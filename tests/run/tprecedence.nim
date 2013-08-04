discard """
  output: "true"
"""

# Test the new predence rules

proc `\+` (x, y: Int): Int = result = x + y
proc `\*` (x, y: Int): Int = result = x * y

echo 5 \+ 1 \* 9 == 14

