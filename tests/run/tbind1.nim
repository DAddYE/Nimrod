discard """
  file: "tbind1.nim"
  output: "3"
"""
# Test the new ``bind`` keyword for templates

proc p1(x: Int8, y: Int): Int = return x + y

template tempBind(x, y: Expr): Expr = 
  bind p1
  p1(x, y) 

proc p1(x: Int, y: Int8): Int = return x - y

# This is tricky: the call to ``p1(1'i8, 2'i8)`` should not fail in line 6, 
# because it is not ambiguous there. But it is ambiguous after line 8. 

echo tempBind(1'i8, 2'i8) #OUT 3



