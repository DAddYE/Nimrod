discard """
  output: "1\n2"
"""

type
  TFoo1 = object of TObject
    v: Int
  TFoo2 = object of TFoo1
    v2: Int

proc test(f: TFoo1) =
  echo "1"

proc foo[T](f: T) =
  mixin test
  test(f)

var
  a: TFoo1
  b: TFoo2


proc test(f: TFoo2) =
  echo "2"

foo(a)
foo(b)
