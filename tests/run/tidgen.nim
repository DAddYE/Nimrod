discard """
  output: "3 4"
"""

import macros

# Test compile-time state in same module

var gid {.compileTime.} = 3

macro genId(): Expr =
  result = newIntLitNode(gid)
  inc gid

proc id1(): Int {.compileTime.} = return genId()
proc id2(): Int {.compileTime.} = return genId()

echo Id1(), " ", Id2()

