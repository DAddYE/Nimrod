discard """
  output: '''came here'''
"""

type
  TAny* = object {.pure.}
    value*: Pointer
    rawType: Pointer
    
proc newAny(value, rawType: Pointer): TAny =
  result.value = value
  result.rawType = rawType

var name: Cstring = "example"

var ret: Seq[tuple[name: String, a: TAny]] = @[]
for i in 0..8000:
  var tup = ($name, newAny(nil, nil))
  assert(tup[0] == "example")
  ret.add(tup)
  assert(ret[ret.len()-1][0] == "example")

echo "came here"

