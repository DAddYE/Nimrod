import unittest, typetraits

type 
  TFoo[T, U] = object
    x: T
    y: U

proc getTypeName(t: TypeDesc): String = t.name

proc foo(T: TypeDesc[Float], a: Expr): String =
  result = "float " & $(a.len > 5)

proc foo(T: TypeDesc[TFoo], a: Int): String =
  result = "TFoo "  & $(a)

proc foo(T: TypeDesc[Int or Bool]): String =
  var a: T
  a = 10
  result = "int or bool " & ($a)

template foo(T: TypeDesc[Seq]): Expr = "seq"

test "types can be used as proc params":
  # XXX: `check` needs to know that TFoo[int, float] is a type and 
  # cannot be assigned for a local variable for later inspection
  check ((String.getTypeName == "string"))
  check ((getTypeName(Int) == "int"))
  
  check ((foo(TFoo[int, float], 1000) == "TFoo 1000"))
  
  var f = 10.0
  check ((foo(Float, "long string") == "float true"))
  check ((foo(type(f), [1, 2, 3]) == "float false"))
  
  check ((foo(Int) == "int or bool 10"))

  check ((foo(seq[int]) == "seq"))
  check ((foo(seq[TFoo[bool, string]]) == "seq"))

when false:
  proc foo(T: typedesc[seq], s: T) = nil

