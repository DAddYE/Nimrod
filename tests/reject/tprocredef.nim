discard """
  file: "tprocredef.nim"
  line: 8
  errormsg: "redefinition of \'foo\'"
"""

proc foo(a: Int, b: String) = nil
proc foo(a: int, b: string) = nil

