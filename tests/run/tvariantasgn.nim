discard """
  file: "tvariantasgn.nim"
  output: "came here"
"""
#BUG
type
  TAnyKind = enum
    nkInt,
    nkFloat,
    nkString
  TAny = object
    case kind: TAnyKind
    of nkInt: intVal: Int
    of nkFloat: floatVal: Float
    of nkString: strVal: String

var s: TAny
s.kind = nkString
s.strVal = "test"

var nr: TAny
nr.kind = nkInt
nr.intVal = 78


# s = nr # works
nr = s # fails!
echo "came here"


