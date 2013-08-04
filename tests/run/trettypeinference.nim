discard """
  msg:    "instantiated for string\ninstantiated for int\ninstantiated for bool"
  output: "int\nseq[string]\nA\nB\n100\ntrue"
"""

import typetraits

proc plus(a, b): Auto = a + b
proc makePair(a, b): Auto = (first: a, second: b)

proc `+`(a, b: String): Seq[String] = @[a, b]

var i = plus(10, 20)
var s = plus("A", "B")

var p = makePair("key", 100)
static: assert p[0].type is string

echo i.type.name
echo s.type.name

proc inst(a): Auto =
  static: echo "instantiated for ", a.type.name
  result = a

echo inst("A")
echo inst("B")
echo inst(100)
echo inst(true)

# XXX: [string, tyGenericParam] is cached instead of [string, string]
# echo inst[string, string]("C")

