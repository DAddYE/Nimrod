discard """
  file: "tmultim1.nim"
  output: "7"
"""
# Test multi methods

type
  Expression = ref object {.inheritable.}
  Literal = ref object of Expression
    x: Int
  PlusExpr = ref object of Expression
    a, b: Expression
    
method eval(e: Expression): Int = quit "to override!"
method eval(e: Literal): Int = return e.x
method eval(e: PlusExpr): Int = return eval(e.a) + eval(e.b)

proc newLit(x: Int): Literal =
  new(result)
  result.x = x
  
proc newPlus(a, b: Expression): PlusExpr =
  new(result)
  result.a = a
  result.b = b

echo eval(newPlus(newPlus(newLit(1), newLit(2)), newLit(4))) #OUT 7


