import macros

macro foo(x: Stmt): Stmt =
  echo treeRepr(callsite())
  result = newNimNode(nnkStmtList)

proc zoo() {.foo.} = echo "hi"

