discard """
  output: "11"
"""

proc p(x, y: Int): Int = 
  result = x + y

echo p((proc (): Int = 
          var x = 7
          return x)(),
       (proc (): Int = return 4)())

