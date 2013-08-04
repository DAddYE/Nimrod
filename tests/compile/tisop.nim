import typetraits

type
  TRecord = (tuple) or (object)
  
  TFoo[T, U] = object
    x: Int

    when T is string:
      y: float
    else:
      y: string

    when U is TRecord:
      z: float

  E = enum A, B, C

macro m(t: TypeDesc): TypeDesc =
  if t is enum:
    result = String
  else:
    result = Int

var f: TFoo[Int, Int]
static: assert(f.y.type.name == "string")

when compiles(f.z):
  {.error: "Foo should not have a `z` field".}

proc p(a, b) =
  when a.type is Int:
    static: assert false

  var f: TFoo[m(a.type), b.type]
  static:
    assert f.x.type.name == "int"
    assert f.y.type.name == "float"
    assert f.z.type.name == "float"

p(A, f)

