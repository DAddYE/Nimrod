discard """
  output: "4"
"""

template cse{f(a, a, x)}(a: Expr{(nkDotExpr|call|nkBracketExpr)&noSideEffect},
                         f: Expr, x: Varargs[Expr]): Expr =
  let aa = a
  f(aa, aa, x)+4
  
var
  a: Array[0..10, Int]
  i = 3
echo a[i] + a[i]
