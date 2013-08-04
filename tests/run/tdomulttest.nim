discard """
  file: "tdomulttest.nim"
  output: "555\ntest\nmulti lines\n99999999\nend"
  disabled: true
"""
proc foo(bar, baz: proc (x: Int): Int) =
  echo bar(555)
  echo baz(99999999)

foo do (x: Int) -> Int:
  return x
do (x: Int) -> Int:
  echo("test")
  echo("multi lines")
  return x

echo("end")
