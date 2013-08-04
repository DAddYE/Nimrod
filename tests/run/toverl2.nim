discard """
  file: "toverl2.nim"
  output: "true012innertrue"
"""
# Test new overloading resolution rules

import strutils

proc toverl2(x: Int): String = return $x
proc toverl2(x: Bool): String = return $x

iterator toverl2(x: Int): Int = 
  var res = 0
  while res < x: 
    yield res
    inc(res)

var
  pp: proc (x: Bool): String {.nimcall.} = toverl2

stdout.write(pp(true))

for x in toverl2(3): 
  stdout.write(toverl2(x))

block:
  proc toverl2(x: Int): String = return "inner"
  stdout.write(toverl2(5))
  stdout.write(true)

stdout.write("\n")
#OUT true012innertrue

