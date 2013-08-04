discard """
  output: '''-2'''
"""

proc p(x, y: Int; cond: Bool): Int =
  result = if cond: x + y else: x - y

template optP{p(x, y, true)}(x, y: Expr): Expr = x - y
template optP{p(x, y, false)}(x, y: Expr): Expr = x + y

echo p(2, 4, true)
