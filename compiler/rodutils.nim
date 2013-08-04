#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## Serialization utilities for the compiler.
import strutils

proc cSprintf(buf, frmt: Cstring) {.importc: "sprintf", nodecl, varargs.}

proc toStrMaxPrecision*(f: BiggestFloat): String = 
  if f != f:
    result = "NAN"
  elif f == 0.0:
    result = "0.0"
  elif f == 0.5 * f:
    if f > 0.0: result = "INF"
    else: result = "-INF"
  else:
    var buf: Array [0..80, Char]    
    cSprintf(buf, "%#.16e", f) 
    result = $buf

proc encodeStr*(s: String, result: var String) =
  for i in countup(0, len(s) - 1): 
    case s[i]
    of 'a'..'z', 'A'..'Z', '0'..'9', '_': add(result, s[i])
    else: add(result, '\\' & toHex(ord(s[i]), 2))

proc hexChar(c: Char, xi: var Int) = 
  case c
  of '0'..'9': xi = (xi shl 4) or (ord(c) - ord('0'))
  of 'a'..'f': xi = (xi shl 4) or (ord(c) - ord('a') + 10)
  of 'A'..'F': xi = (xi shl 4) or (ord(c) - ord('A') + 10)
  else: nil

proc decodeStr*(s: Cstring, pos: var Int): String =
  var i = pos
  result = ""
  while true: 
    case s[i]
    of '\\': 
      inc(i, 3)
      var xi = 0
      hexChar(s[i-2], xi)
      hexChar(s[i-1], xi)
      add(result, chr(xi))
    of 'a'..'z', 'A'..'Z', '0'..'9', '_': 
      add(result, s[i])
      inc(i)
    else: break 
  pos = i

const
  chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

# since negative numbers require a leading '-' they use up 1 byte. Thus we
# subtract/add `vintDelta` here to save space for small negative numbers
# which are common in ROD files:
const
  vintDelta = 5

template encodeIntImpl(self: Expr) =
  var d: Char
  var v = x
  var rem = v mod 190
  if rem < 0: 
    add(result, '-')
    v = - (v div 190)
    rem = - rem
  else: 
    v = v div 190
  var idx = Int(rem)
  if idx < 62: d = chars[idx]
  else: d = chr(idx - 62 + 128)
  if v != 0: self(v, result)
  add(result, d)

proc encodeVBiggestIntAux(x: BiggestInt, result: var String) =
  ## encode a biggest int as a variable length base 190 int.
  encodeIntImpl(encodeVBiggestIntAux)

proc encodeVBiggestInt*(x: BiggestInt, result: var String) =
  ## encode a biggest int as a variable length base 190 int.
  encodeVBiggestIntAux(x +% vintDelta, result)
  #  encodeIntImpl(encodeVBiggestInt)

proc encodeVIntAux(x: Int, result: var String) = 
  ## encode an int as a variable length base 190 int.
  encodeIntImpl(encodeVIntAux)
  
proc encodeVInt*(x: Int, result: var String) = 
  ## encode an int as a variable length base 190 int.
  encodeVIntAux(x +% vintDelta, result)

template decodeIntImpl() =
  var i = pos
  var sign = - 1
  assert(s[i] in {'a'..'z', 'A'..'Z', '0'..'9', '-', '\x80'..'\xFF'})
  if s[i] == '-': 
    inc(i)
    sign = 1
  result = 0
  while true: 
    case s[i]
    of '0'..'9': result = result * 190 - (ord(s[i]) - ord('0'))
    of 'a'..'z': result = result * 190 - (ord(s[i]) - ord('a') + 10)
    of 'A'..'Z': result = result * 190 - (ord(s[i]) - ord('A') + 36)
    of '\x80'..'\xFF': result = result * 190 - (ord(s[i]) - 128 + 62)
    else: break
    inc(i)
  result = result * sign -% vintDelta
  pos = i

proc decodeVInt*(s: Cstring, pos: var Int): Int = 
  decodeIntImpl()

proc decodeVBiggestInt*(s: Cstring, pos: var Int): BiggestInt =
  decodeIntImpl()

iterator decodeVIntArray*(s: Cstring): Int =
  var i = 0
  while s[i] != '\0':
    yield decodeVInt(s, i)
    if s[i] == ' ': inc i

iterator decodeStrArray*(s: Cstring): String =
  var i = 0
  while s[i] != '\0':
    yield decodeStr(s, i)
    if s[i] == ' ': inc i

