import zlib

proc compress*(source: String): String =
  var
    sourcelen = source.len
    destlen = sourcelen + (sourcelen.Float * 0.1).Int + 16
  result = ""
  result.setLen destlen
  var res = zlib.compress(Cstring(result), addr destlen, Cstring(source), sourcelen)
  if res != Z_OK:
    echo "Error occured: ", res
  elif destlen < result.len:
    result.setLen(destlen)

proc uncompress*(source: String, destLen: var Int): String =
  result = ""
  result.setLen destLen
  var res = zlib.uncompress(Cstring(result), addr destLen, Cstring(source), source.len)
  if res != Z_OK:
    echo "Error occured: ", res
    

when isMainModule:
  import strutils
  var r = compress("Hello")
  echo repr(r)
  var l = "Hello".len
  var rr = uncompress(r, l)
  echo repr(rr)
  assert rr == "Hello"

  proc `*`(a: String; b: Int): String {.inline.} = result = repeatStr(b, a)
  var s = "yo dude sup bruh homie" * 50
  r = compress(s)
  echo s.len, " -> ", r.len

  l = s.len
  rr = uncompress(r, l)
  echo r.len, " -> ", rr.len
  assert rr == s
