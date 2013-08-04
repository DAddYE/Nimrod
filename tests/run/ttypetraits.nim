discard """
  msg:    "int\nstring\nTBar[int]"
  output: "int\nstring\nTBar[int]\nint\nrange 0..2\nstring"
"""

import typetraits

# simple case of type trait usage inside/outside of static blocks
proc foo(x) =
  static:
    var t = type(x)
    echo t.name

  echo x.type.name

type
  TBar[U] = object
    x: U

var bar: TBar[Int]

foo 10
foo "test"
foo bar

# generic params on user types work too
proc foo2[T](x: TBar[T]) =
  echo T.name

foo2 bar

# less usual generic params on built-in types
var arr: Array[0..2, Int] = [1, 2, 3]

proc foo3[R, T](x: Array[R, T]) =
  echo name(R)

foo3 arr

const TypeList = [Int, String, seq[int]]

macro selectType(inType: TypeDesc): TypeDesc =
  var typeSeq = @[Float, TBar[int]]
  
  for t in TypeList:
    typeSeq.add(t)

  typeSeq.add(inType)
  typeSeq.add(type(10))
  
  var typeSeq2: Seq[TypeDesc] = @[]
  typeSeq2 = typeSeq

  result = typeSeq2[5]
  
var xvar: selectType(String)
xvar = "proba"
echo xvar.type.name

