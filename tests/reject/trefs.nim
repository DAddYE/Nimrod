discard """
  file: "trefs.nim"
  line: 20
  errormsg: "type mismatch"
"""
# test for ref types (including refs to procs)

type
  TProc = proc (a, b: Int): Int {.stdcall.}

proc foo(c, d: Int): Int {.stdcall.} =
  return 0

proc wrongfoo(c, e: Int): Int {.inline.} =
  return 0

var p: TProc
p = foo
write(stdout, "success!")
p = wrongfoo  #ERROR_MSG type mismatch



