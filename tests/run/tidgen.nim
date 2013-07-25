discard """
  output: "3 4"
"""

import macros

# Test compile-time state in same module

var gid {.compileTime.} = 3

macro genId(): expr =
  result = newIntLitNode(gid)
  inc gid

proc id1(): int {.compileTime.} = return genId()
proc id2(): int {.compileTime.} = return genId()

echo Id1(), " ", Id2()

