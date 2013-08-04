discard """
  file: "toverl3.nim"
  output: '''m1
tup1'''
"""

# Tests more specific generic match:

proc m[T](x: T) = echo "m2"
proc m[T](x: var ref T) = echo "m1"

proc tup[S, T](x: tuple[a: S, b: ref T]) = echo "tup1"
proc tup[S, T](x: tuple[a: S, b: T]) = echo "tup2"

var
  obj: ref Int
  tu: tuple[a: Int, b: ref Bool]
  
m(obj)
tup(tu)
