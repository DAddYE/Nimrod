#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## Nimrod OID support. An OID is a global ID that consists of a timestamp,
## a unique counter and a random value. This combination should suffice to 
## produce a globally distributed unique ID. This implementation was extracted
## from the Mongodb interface and it thus binary compatible with a Mongo OID.
##
## This implementation calls ``math.randomize()`` for the first call of
## ``genOid``.

import times, endians

type
  Toid* {.pure, final.} = object ## an OID
    time: Int32  ## 
    fuzz: Int32  ## 
    count: Int32 ## 

proc hexbyte*(hex: Char): Int = 
  case hex
  of '0'..'9': result = (ord(hex) - ord('0'))
  of 'a'..'f': result = (ord(hex) - ord('a') + 10)
  of 'A'..'F': result = (ord(hex) - ord('A') + 10)
  else: nil

proc parseOid*(str: Cstring): Toid =
  ## parses an OID.
  var bytes = cast[Cstring](addr(result.time))
  var i = 0
  while i < 12:
    bytes[i] = chr((hexbyte(str[2 * i]) shl 4) or hexbyte(str[2 * i + 1]))
    inc(i)

proc oidToString*(oid: Toid, str: Cstring) = 
  const hex = "0123456789abcdef"
  # work around a compiler bug:
  var str = str
  var o = oid
  var bytes = cast[Cstring](addr(o))
  var i = 0
  while i < 12:
    let b = bytes[i].ord
    str[2 * i] = hex[(b and 0xF0) shr 4]
    str[2 * i + 1] = hex[b and 0xF]
    inc(i)
  str[24] = '\0'

var
  incr: Int 
  fuzz: Int32

proc genOid*(): Toid =
  ## generates a new OID.
  proc rand(): Cint {.importc: "rand", nodecl.}
  proc gettime(dummy: ptr Cint): Cint {.importc: "time", header: "<time.h>".}
  proc srand(seed: Cint) {.importc: "srand", nodecl.}

  var t = gettime(nil)
  
  var i = Int32(incr)
  atomicInc(incr)
  
  if fuzz == 0:
    # racy, but fine semantically:
    srand(t)
    fuzz = rand()
  bigEndian32(addr result.time, addr(t))
  result.fuzz = fuzz
  bigEndian32(addr result.count, addr(i))

proc generatedTime*(oid: Toid): TTime =
  ## returns the generated timestamp of the OID.
  var tmp: Int32
  var dummy = oid.time
  bigEndian32(addr(tmp), addr(dummy))
  result = TTime(tmp)

when isMainModule:
  let xo = genOID()
  echo xo.generatedTime
