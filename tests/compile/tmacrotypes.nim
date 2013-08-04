import macros, typetraits

macro checkType(ex, expected: Expr): Stmt {.immediate.} =
  var t = ex.typ
  assert t.name == expected.strVal

proc voidProc = echo "hello"
proc intProc(a, b): Int = 10

checkType(voidProc(), "void")
checkType(intProc(10, 20.0), "int")
checkType(noproc(10, 20.0), "Error Type")
