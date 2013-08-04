#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# set handling

type
  TNimSet = Array [0..4*2048-1, Int8]

proc countBits32(n: Int32): Int {.compilerproc.} =
  var v = n
  v = v -% ((v shr 1'i32) and 0x55555555'i32)
  v = (v and 0x33333333'i32) +% ((v shr 2'i32) and 0x33333333'i32)
  result = ((v +% (v shr 4'i32) and 0xF0F0F0F'i32) *% 0x1010101'i32) shr 24'i32

proc countBits64(n: Int64): Int {.compilerproc.} = 
  result = countBits32(toU32(n and 0xffff'i64)) +
           countBits32(toU32(n shr 16'i64))

proc cardSet(s: TNimSet, len: Int): Int {.compilerproc.} =
  result = 0
  for i in countup(0, len-1):
    inc(result, countBits32(Int32(ze(s[i]))))
