discard """
  output: "4887 true"
"""

# test the new borrow feature that works with generics:

proc `++`*[T: int | float](a, b: T): T =
  result = a + b
  
type
  Di = distinct Int
  Df = distinct Float
  Ds = distinct String
  
proc `++`(x, y: Di): Di {.borrow.}
proc `++`(x, y: Df): Df {.borrow.}

proc `$`(x: Di): String {.borrow.}
proc `$`(x: Df): String {.borrow.}

echo  4544.Di ++ 343.Di, " ", (4.5.Df ++ 0.5.Df).Float == 5.0
