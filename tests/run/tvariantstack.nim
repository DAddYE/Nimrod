discard """
  file: "tvariantstack.nim"
  output: "came here"
"""
#BUG
type
  TAnyKind = enum
    nkInt,
    nkFloat,
    nkString
  PAny = ref TAny
  TAny = object
    case kind: TAnyKind
    of nkInt: intVal: Int
    of nkFloat: floatVal: Float
    of nkString: strVal: String

  TStack* = object
    list*: Seq[TAny]

proc newStack(): TStack =
  result.list = @[]

proc push(Stack: var TStack, item: TAny) =
  var nSeq: Seq[TAny] = @[item]
  for i in items(stack.list):
    nSeq.add(i)
  stack.list = nSeq

proc pop(Stack: var TStack): TAny =
  result = stack.list[0]
  stack.list.delete(0)

var stack = newStack()

var s: TAny
s.kind = nkString
s.strVal = "test"

stack.push(s)

var nr: TAny
nr.kind = nkInt
nr.intVal = 78

stack.push(nr)

var t = stack.pop()
echo "came here"



