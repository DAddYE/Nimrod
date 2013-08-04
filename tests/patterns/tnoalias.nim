discard """
  output: "23"
"""

template optslice{a = b + c}(a: Expr{noalias}, b, c: Expr): Stmt =
  a = b
  inc a, c

var
  x = 12
  y = 10
  z = 13

x = y+z

echo x
