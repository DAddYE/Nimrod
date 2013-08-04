import imported, strutils

type
  TFoo = object
    x: Int
    y: String

proc main =
  var t1 = "text"
  var t2 = t1.toUpper
  var foo = TFoo(x: 10, y: "test")
  foo.
  echo(t1 +++ t2)

