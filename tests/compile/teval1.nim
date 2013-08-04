import macros

proc testProc: String {.compileTime.} =
  result = ""
  result = result & ""

when true:
  macro test(n: Stmt): Stmt {.immediate.} =
    result = newNimNode(nnkStmtList)
    echo "#", testProc(), "#"
  test:
    "hi"

const
  x = testProc()
  
echo "##", x, "##"


