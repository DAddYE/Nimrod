discard """
  file: "tinvalidnewseq.nim"
  line: 15
  errormsg: "type mismatch: got (array[0..6, string], int literal(7))"
"""
import re, strutils

type
  TURL = tuple[protocol, subdomain, domain, port: String, path: Seq[String]]

proc parseURL(url: String): TURL =
  #([a-zA-Z]+://)?(\w+?\.)?(\w+)(\.\w+)(:[0-9]+)?(/.+)?
  var pattern: String = r"([a-zA-Z]+://)?(\w+?\.)?(\w+)(\.\w+)(:[0-9]+)?(/.+)?"
  var m: Array[0..6, String] #Array with the matches
  newSeq(m, 7) #ERROR
  discard regexprs.match(url, re(pattern), m)
 
  result = (protocol: m[1], subdomain: m[2], domain: m[3] & m[4], 
            port: m[5], path: m[6].split('/'))
 
var r: TUrl
 
r = parseURL(r"http://google.com/search?var=bleahdhsad")
echo(r.domain)



