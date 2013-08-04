discard """
  line: 16
  errormsg: "type mismatch: got (int literal(232))"
"""

proc myGenericProc[T: object|tuple|ptr|ref|distinct](x: T): String = 
  result = $x

type
  TMyObj = tuple[x, y: Int]

var
  x: TMyObj

assert myGenericProc(x) == "(x: 0, y: 0)"
assert myGenericProc(232) == "232"


