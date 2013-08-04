discard """
  output: "after"
"""

import
  macros, strutils

macro testMacro*(n: Stmt): Stmt {.immediate.} =
  result = newNimNode(nnkStmtList)
  var ass : PNimrodNode = newNimNode(nnkAsgn)
  add(ass, newIdentNode("str"))
  add(ass, newStrLitNode("after"))
  add(result, ass)
when isMainModule:
  var str: String = "before"
  test_macro(str):
    var i : integer = 123
  echo str

