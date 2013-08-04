import tables

type
  TX = TTable[String, Int]

proc foo(models: Seq[TX]): Seq[Int] =
  result = @[]
  for model in models.items:
    result.add model["foobar"]

type
  Obj = object
    field: TTable[String, String]
var t: Obj
discard initTable[type(t.field), string]()
