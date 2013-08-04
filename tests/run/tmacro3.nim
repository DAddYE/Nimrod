discard """
  output: ""
"""

import  macros

type 
    TA = tuple[a: Int]
    Pa = ref TA

macro test*(a: Stmt): Stmt {.immediate.} =
  var val: Pa
  new(val)
  val.a = 4

test:
  "hi"

macro test2*(a: Stmt): Stmt {.immediate.} =
  proc testproc(recurse: Int) =
    echo "Thats weird"
    var o : PNimrodNode = nil
    echo "  no its not!"
    o = newNimNode(nnkNone)
    if recurse > 0:
      testproc(recurse - 1)
  testproc(5)

test2:
  "hi"

