discard """
  line: 10
  errormsg: "illegal capture 'A'"
"""

proc outer() = 
  var a: Int

  proc ugh[T](x: T) {.cdecl.} =
    echo "ugha", a, x
    
  ugh[int](12)

outer()
