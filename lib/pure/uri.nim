#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Dominik Picheta
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#
import strutils
type
  TUrl* = distinct String

proc `$`*(url: TUrl): String = return String(url)

proc `/`*(a, b: TUrl): TUrl =
  ## Joins two URLs together, separating them with / if needed.
  var urlS = $a
  var bS = $b
  if urlS == "": return b
  if urlS[urlS.len-1] != '/':
    urlS.add('/')
  if bS[0] == '/':
    urlS.add(bS.substr(1))
  else:
    urlS.add(bS)
  result = TUrl(urlS)

proc add*(url: var TUrl, a: TUrl) =
  ## Appends url to url.
  url = url / a

when isMainModule:
  assert($("http://".TUrl / "localhost:5000".TUrl) == "http://localhost:5000")
