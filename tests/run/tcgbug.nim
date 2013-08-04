discard """
  file: "tcgbug.nim"
  output: "success"
"""

type
  TObj = object
    x, y: Int
  PObj = ref TObj

proc p(a: PObj) =
  a.x = 0

proc q(a: var PObj) =
  a.p()

var 
  a: PObj
new(a)
q(a)

echo "success"

