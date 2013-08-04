discard """
  line: 12
  errormsg: "type mismatch: got (proc (int){.closure.})"
"""

proc ugh[T](x: T) {.closure.} =
  echo "ugha"


proc takeCdecl(p: proc (x: Int) {.cdecl.}) = nil

takeCDecl(ugh[int])
