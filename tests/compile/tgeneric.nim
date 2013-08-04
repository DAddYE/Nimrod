import tables

type
  TX = TTable[String, Int]

proc foo(models: Seq[TTable[String, Float]]): Seq[Float] =
  result = @[]
  for model in models.items:
    result.add model["foobar"]


