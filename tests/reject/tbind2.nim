discard """
  file: "tbind2.nim"
  line: 12
  errormsg: "ambiguous call"
"""
# Test the new ``bind`` keyword for templates

proc p1(x: Int8, y: Int): Int = return x + y
proc p1(x: Int, y: Int8): Int = return x - y

template tempBind(x, y: Expr): Expr = 
  (bind p1(x, y))  #ERROR_MSG ambiguous call

echo tempBind(1'i8, 2'i8)



