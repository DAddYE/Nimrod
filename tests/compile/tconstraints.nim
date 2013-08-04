

proc myGenericProc[T: object|tuple|int|ptr|ref|distinct](x: T): String = 
  result = $x

type
  TMyObj = tuple[x, y: Int]

var
  x: TMyObj

assert myGenericProc(232) == "232"
assert myGenericProc(x) == "(x: 0, y: 0)"


