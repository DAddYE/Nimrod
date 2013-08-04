discard """
  outputsub: "no leak: "
"""

when defined(GC_setMaxPause):
  GC_setMaxPause 2_000

type
  TExpr = object ## abstract base class for an expression
  PLiteral = ref TLiteral
  TLiteral = object of TExpr
    x: Int
    op1: String
  TPlusExpr = object of TExpr
    a, b: ref TExpr
    op2: String
    
method eval(e: ref TExpr): Int =
  # override this base method
  quit "to override!"

method eval(e: ref TLiteral): Int = return e.x

method eval(e: ref TPlusExpr): Int =
  # watch out: relies on dynamic binding
  return eval(e.a) + eval(e.b)

proc newLit(x: Int): ref TLiteral =
  new(result)
  {.watchpoint: result.}
  result.x = x
  result.op1 = $getOccupiedMem()
  
proc newPlus(a, b: ref TExpr): ref TPlusExpr =
  new(result)
  {.watchpoint: result.}
  result.a = a
  result.b = b
  result.op2 = $getOccupiedMem()

for i in 0..100_000:
  var s: Array[0..11, ref TExpr]
  for j in 0..high(s):
    s[j] = newPlus(newPlus(newLit(j), newLit(2)), newLit(4))
    if eval(s[j]) != j+6:
      quit "error: wrong result"
  if getOccupiedMem() > 500_000: quit("still a leak!")

echo "no leak: ", getOccupiedMem()
