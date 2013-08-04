discard """
  output: "12false3ha"
"""

proc f(x: Varargs[String, `$`]) = nil
template optF{f(x)}(x: Varargs[Expr]) = 
  writeln(stdout, x)

f 1, 2, false, 3, "ha"
