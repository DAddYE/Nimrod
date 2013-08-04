#
#
#           Nimrod Website Generator
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

import
  os, strutils, times, parseopt, parsecfg, streams, strtabs, tables,
  re, htmlgen, macros, md5

type
  TKeyValPair = tuple[key, id, val: String]
  TConfigData = object of TObject
    tabs, links: Seq[TKeyValPair]
    doc, srcdoc, srcdoc2, webdoc, pdf: Seq[String]
    authors, projectName, projectTitle, logo, infile, outdir, ticker: String
    vars: PStringTable
    nimrodArgs: String
    quotations: TTable[String, tuple[quote, author: String]]
  TRssItem = object
    year, month, day, title: String

proc initConfigData(c: var TConfigData) =
  c.tabs = @[]
  c.links = @[]
  c.doc = @[]
  c.srcdoc = @[]
  c.srcdoc2 = @[]
  c.webdoc = @[]
  c.pdf = @[]
  c.infile = ""
  c.outdir = ""
  c.nimrodArgs = "--hint[Conf]:off "
  c.authors = ""
  c.projectTitle = ""
  c.projectName = ""
  c.logo = ""
  c.ticker = ""
  c.vars = newStringTable(modeStyleInsensitive)
  c.quotations = initTable[string, tuple[quote, author: string]]()

include "website.tmpl"

# ------------------------- configuration file -------------------------------

const
  Version = "0.7"
  Usage = "nimweb - Nimrod Website Generator Version " & version & """

  (c) 2012 Andreas Rumpf
Usage:
  nimweb [options] ini-file[.ini] [compile_options]
Options:
  -o, --output:dir    set the output directory (default: same as ini-file)
  --var:name=value    set the value of a variable
  -h, --help          shows this help
  -v, --version       shows the version
Compile_options:
  will be passed to the Nimrod compiler
"""

  rYearMonthDayTitle = r"(\d{4})-(\d{2})-(\d{2})\s+(.*)"
  rssUrl = "http://nimrod-code.org/news.xml"
  rssNewsUrl = "http://nimrod-code.org/news.html"
  validAnchorCharacters = Letters + Digits


macro id(e: Expr): Expr {.immediate.} =
  ## generates the rss xml ``id`` element.
  let e = callsite()
  result = xmlCheckedTag(e, "id")

macro updated(e: Expr): Expr {.immediate.} =
  ## generates the rss xml ``updated`` element.
  let e = callsite()
  result = xmlCheckedTag(e, "updated")

proc updatedDate(year, month, day: String): String =
  ## wrapper around the update macro with easy input.
  result = updated("$1-$2-$3T00:00:00Z" % [year,
    repeatStr(2 - len(month), "0") & month,
    repeatStr(2 - len(day), "0") & day])

macro entry(e: Expr): Expr {.immediate.} =
  ## generates the rss xml ``entry`` element.
  let e = callsite()
  result = xmlCheckedTag(e, "entry")

macro content(e: Expr): Expr {.immediate.} =
  ## generates the rss xml ``content`` element.
  let e = callsite()
  result = xmlCheckedTag(e, "content", reqAttr = "type")

proc parseCmdLine(c: var TConfigData) =
  var p = initOptParser()
  while true:
    next(p)
    var kind = p.kind
    var key = p.key
    var val = p.val
    case kind
    of cmdArgument:
      c.infile = addFileExt(key, "ini")
      c.nimrodArgs.add(cmdLineRest(p))
      break
    of cmdLongOption, cmdShortOption:
      case normalize(key)
      of "help", "h": 
        stdout.write(Usage)
        quit(0)
      of "version", "v": 
        stdout.write(Version & "\n")
        quit(0)
      of "o", "output": c.outdir = val
      of "var":
        var idx = val.find('=')
        if idx < 0: quit("invalid command line")
        c.vars[substr(val, 0, idx-1)] = substr(val, idx+1)
      else: quit(Usage)
    of cmdEnd: break
  if c.infile.len == 0: quit(Usage)

proc walkDirRecursively(s: var Seq[String], root, ext: String) =
  for k, f in walkDir(root):
    case k
    of pcFile, pcLinkToFile:
      if cmpIgnoreCase(ext, splitFile(f).ext) == 0:
        add(s, f)
    of pcDir: walkDirRecursively(s, f, ext)
    of pcLinkToDir: nil

proc addFiles(s: var Seq[String], dir, ext: String, patterns: Seq[String]) =
  for p in items(patterns):
    if existsDir(dir / p):
      walkDirRecursively(s, dir / p, ext)
    else:
      add(s, dir / addFileExt(p, ext))

proc parseIniFile(c: var TConfigData) =
  var
    p: TCfgParser
    section: String # current section
  var input = newFileStream(c.infile, fmRead)
  if input != nil:
    open(p, input, c.infile)
    while true:
      var k = next(p)
      case k.kind
      of cfgEof: break
      of cfgSectionStart:
        section = normalize(k.section)
        case section
        of "project", "links", "tabs", "ticker", "documentation", "var": nil
        else: echo("[Warning] Skipping unknown section: " & section)

      of cfgKeyValuePair:
        var v = k.value % c.vars
        c.vars[k.key] = v

        case section
        of "project":
          case normalize(k.key)
          of "name": c.projectName = v
          of "title": c.projectTitle = v
          of "logo": c.logo = v
          of "authors": c.authors = v
          else: quit(errorStr(p, "unknown variable: " & k.key))
        of "var": nil
        of "links":
          let valID = v.split(';')
          add(c.links, (k.key.replace('_', ' '), valID[1], valID[0]))
        of "tabs": add(c.tabs, (k.key, "", v))
        of "ticker": c.ticker = v
        of "documentation":
          case normalize(k.key)
          of "doc": addFiles(c.doc, "doc", ".txt", split(v, {';'}))
          of "pdf": addFiles(c.pdf, "doc", ".txt", split(v, {';'}))
          of "srcdoc": addFiles(c.srcdoc, "lib", ".nim", split(v, {';'}))
          of "srcdoc2": addFiles(c.srcdoc2, "lib", ".nim", split(v, {';'}))
          of "webdoc": addFiles(c.webdoc, "lib", ".nim", split(v, {';'}))
          else: quit(errorStr(p, "unknown variable: " & k.key))
        of "quotations":
          let vSplit = v.split('-')
          doAssert vSplit.len == 2
          c.quotations[k.key.normalize] = (vSplit[0], vSplit[1])
        else: nil

      of cfgOption: quit(errorStr(p, "syntax error"))
      of cfgError: quit(errorStr(p, k.msg))
    close(p)
    if c.projectName.len == 0:
      c.projectName = changeFileExt(extractFilename(c.infile), "")
    if c.outdir.len == 0:
      c.outdir = splitFile(c.infile).dir
  else:
    quit("cannot open: " & c.infile)

# ------------------- main ----------------------------------------------------

proc exec(cmd: String) =
  echo(cmd)
  if os.execShellCmd(cmd) != 0: quit("external program failed")

proc buildDoc(c: var TConfigData, destPath: String) =
  # call nim for the documentation:
  for d in items(c.doc):
    exec("nimrod rst2html $# -o:$# --index:on $#" %
      [c.nimrodArgs, destPath / changeFileExt(splitFile(d).name, "html"), d])
  for d in items(c.srcdoc):
    exec("nimrod doc $# -o:$# --index:on $#" %
      [c.nimrodArgs, destPath / changeFileExt(splitFile(d).name, "html"), d])
  for d in items(c.srcdoc2):
    exec("nimrod doc2 $# -o:$# --index:on $#" %
      [c.nimrodArgs, destPath / changeFileExt(splitFile(d).name, "html"), d])
  exec("nimrod buildIndex -o:$1/theindex.html $1" % [destPath])

proc buildPdfDoc(c: var TConfigData, destPath: String) =
  if os.execShellCmd("pdflatex -version") != 0:
    echo "pdflatex not found; no PDF documentation generated"
  else:
    for d in items(c.pdf):
      exec("nimrod rst2tex $# $#" % [c.nimrodArgs, d])
      # call LaTeX twice to get cross references right:
      exec("pdflatex " & changeFileExt(d, "tex"))
      exec("pdflatex " & changeFileExt(d, "tex"))
      # delete all the crappy temporary files:
      var pdf = splitFile(d).name & ".pdf"
      moveFile(dest=destPath / pdf, source=pdf)
      removeFile(changeFileExt(pdf, "aux"))
      if existsFile(changeFileExt(pdf, "toc")):
        removeFile(changeFileExt(pdf, "toc"))
      removeFile(changeFileExt(pdf, "log"))
      removeFile(changeFileExt(pdf, "out"))
      removeFile(changeFileExt(d, "tex"))

proc buildAddDoc(c: var TConfigData, destPath: String) =
  # build additional documentation (without the index):
  for d in items(c.webdoc):
    exec("nimrod doc $# -o:$# $#" %
      [c.nimrodArgs, destPath / changeFileExt(splitFile(d).name, "html"), d])

proc parseNewsTitles(inputFilename: String): Seq[TRssItem] =
  # parses the file for titles and returns them as TRssItem blocks.
  let reYearMonthDayTitle = re(rYearMonthDayTitle)
  var
    input: TFile
    line = ""

  result = @[]
  if not open(input, inputFilename):
    quit("Could not read $1 for rss generation" % [inputFilename])
  finally: input.close()
  while input.readLine(line):
    if line =~ reYearMonthDayTitle:
      result.add(TRssItem(year: matches[0], month: matches[1], day: matches[2],
        title: matches[3]))

proc genUUID(text: String): String =
  # Returns a valid RSS uuid, which is basically md5 with dashes and a prefix.
  result = getMD5(text)
  result.insert("-", 20)
  result.insert("-", 16)
  result.insert("-", 12)
  result.insert("-", 8)
  result.insert("urn:uuid:")

proc genNewsLink(title: String): String =
  # Mangles a title string into an expected news.html anchor.
  result = title
  result.insert("Z")
  for i in 1..len(result)-1:
    let letter = result[i].toLower()
    if letter in validAnchorCharacters:
      result[i] = letter
    else:
      result[i] = '-'
  result.insert(rssNewsUrl & "#")

proc generateRss(outputFilename: String, news: Seq[TRssItem]) =
  # Given a list of rss items generates an rss overwriting destination.
  var
    output: TFile

  if not open(output, outputFilename, mode = fmWrite):
    quit("Could not write to $1 for rss generation" % [outputFilename])
  finally: output.close()

  output.write("""<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
""")
  output.write(title("Nimrod website news"))
  output.write(link(href = rssUrl, rel = "self"))
  output.write(link(href = rssNewsUrl))
  output.write(id(rssNewsUrl))

  let now = getGMTime(getTime())
  output.write(updatedDate($now.year, $(Int(now.month) + 1), $now.monthday))

  for rss in news:
    let joinedTitle = "$1-$2-$3 $4" % [rss.year, rss.month, rss.day, rss.title]
    output.write(entry(
        title(joinedTitle),
        id(genUUID(joinedTitle)),
        link(`type` = "text/html", rel = "alternate",
          href = genNewsLink(joinedTitle)),
        updatedDate(rss.year, rss.month, rss.day),
        "<author><name>Nimrod</name></author>",
        content(joinedTitle, `type` = "text"),
      ))

  output.write("""</feed>""")

proc buildNewsRss(c: var TConfigData, destPath: String) =
  # generates an xml feed from the web/news.txt file
  let
    srcFilename = "web" / "news.txt"
    destFilename = destPath / changeFileExt(splitFile(srcFilename).name, "xml")

  generateRss(destFilename, parseNewsTitles(srcFilename))

proc main(c: var TConfigData) =
  const
    cmd = "nimrod rst2html --compileonly $1 -o:web/$2.temp web/$2.txt"
  if c.ticker.len > 0:
    try:
      c.ticker = readFile("web" / c.ticker)
    except EIO:
      quit("[Error] cannot open: " & c.ticker)
  for i in 0..c.tabs.len-1:
    var file = c.tabs[i].val
    let rss = if file in ["news", "index"]: extractFilename(rssUrl) else: ""
    exec(cmd % [c.nimrodArgs, file])
    var temp = "web" / changeFileExt(file, "temp")
    var content: String
    try:
      content = readFile(temp)
    except EIO:
      quit("[Error] cannot open: " & temp)
    var f: TFile
    var outfile = "web/upload/$#.html" % file
    if not existsDir("web/upload"):
      createDir("web/upload")
    if open(f, outfile, fmWrite):
      writeln(f, generateHTMLPage(c, file, content, rss))
      close(f)
    else:
      quit("[Error] cannot write file: " & outfile)
    removeFile(temp)
  copyDir("web/assets", "web/upload/assets")
  buildNewsRss(c, "web/upload")
  buildAddDoc(c, "web/upload")
  buildDoc(c, "web/upload")
  buildDoc(c, "doc")
  buildPdfDoc(c, "doc")

var c: TConfigData
initConfigData(c)
parseCmdLine(c)
parseIniFile(c)
main(c)
