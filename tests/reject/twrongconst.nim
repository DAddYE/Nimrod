discard """
  output: "Error: constant expression expected"
  line: 7
"""

var x: Array[100, Char] 
template foo : Expr = x[42]


const myConst = foo
