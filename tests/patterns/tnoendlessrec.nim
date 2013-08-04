discard """
  output: "4"
"""

# test that an endless recursion is avoided:

template optLen{len(x)}(x: Expr): Expr = len(x)

var s = "lala"
echo len(s)
