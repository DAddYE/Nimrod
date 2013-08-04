discard """
  output: "b"
"""

type
  TA = object of TObject
    x, y: Int
  
  TB = object of TA
    z: Int
    
  TC = object of TB
    whatever: String
  
proc p(a: var TA) = echo "a"
proc p(b: var TB) = echo "b"

var c: TC

p(c)

