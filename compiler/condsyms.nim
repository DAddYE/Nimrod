#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# This module handles the conditional symbols.

import
  ast, astalgo, hashes, platform, strutils, idents

var gSymbols*: TStrTable

proc defineSymbol*(symbol: string) =
  var i = getIdent(symbol)
  var sym = strTableGet(gSymbols, i)
  if sym == nil:
    new(sym)                  # circumvent the ID mechanism
    sym.kind = skConditional
    sym.name = i
    strTableAdd(gSymbols, sym)
  sym.position = 1

proc undefSymbol*(symbol: string) =
  var sym = strTableGet(gSymbols, getIdent(symbol))
  if sym != nil: sym.position = 0

proc isDefined*(symbol: PIdent): bool =
  var sym = strTableGet(gSymbols, symbol)
  result = sym != nil and sym.position == 1

proc isDefined*(symbol: string): bool =
  result = isDefined(getIdent(symbol))

iterator definedSymbolNames*: string =
  var it: TTabIter
  var s = initTabIter(it, gSymbols)
  while s != nil:
    if s.position == 1: yield s.name.s
    s = nextIter(it, gSymbols)

proc countDefinedSymbols*(): int =
  var it: TTabIter
  var s = initTabIter(it, gSymbols)
  result = 0
  while s != nil:
    if s.position == 1: inc(result)
    s = nextIter(it, gSymbols)

proc initDefines*() =
  initStrTable(gSymbols)
  defineSymbol("nimrod") # 'nimrod' is always defined
  # for bootstrapping purposes and old code:
  defineSymbol("nimhygiene")
  defineSymbol("niminheritable")
  defineSymbol("nimmixin")
  defineSymbol("nimeffects")
  defineSymbol("nimbabel")
  defineSymbol("nimsuperops")

  # add platform specific symbols:
  case targetCPU
  of cpuI386: defineSymbol("x86")
  of cpuIa64: defineSymbol("itanium")
  of cpuAmd64: defineSymbol("x8664")
  else: nil
  case targetOS
  of osDOS:
    defineSymbol("msdos")
  of osWindows:
    defineSymbol("mswindows")
    defineSymbol("win32")
  of osLinux, osMorphOS, osSkyOS, osIrix, osPalmOS, osQNX, osAtari, osAix,
     osHaiku:
    # these are all 'unix-like'
    defineSymbol("unix")
    defineSymbol("posix")
  of osSolaris:
    defineSymbol("sunos")
    defineSymbol("unix")
    defineSymbol("posix")
  of osNetBSD, osFreeBSD, osOpenBSD:
    defineSymbol("unix")
    defineSymbol("bsd")
    defineSymbol("posix")
  of osMacOS:
    defineSymbol("macintosh")
  of osMacOSX:
    defineSymbol("macintosh")
    defineSymbol("unix")
    defineSymbol("posix")
  else: nil
  defineSymbol("cpu" & $CPU[targetCPU].bit)
  defineSymbol(normalize(EndianToStr[CPU[targetCPU].endian]))
  defineSymbol(CPU[targetCPU].name)
  defineSymbol(platform.OS[targetOS].name)
  if platform.OS[targetOS].props.contains(ospLacksThreadVars):
    defineSymbol("emulatedthreadvars")


