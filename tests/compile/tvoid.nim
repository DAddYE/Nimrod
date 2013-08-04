discard """
  output: "he, no return type;abc a string"
"""

proc returnT[T](x: T): T =
  when T is Void:
    echo "he, no return type;"
  else:
    result = x & " a string"

proc nothing(x, y: Void): Void =
  echo "ha"

proc callProc[T](p: proc (x: T) {.nimcall.}, x: T) =
  when T is Void: 
    p()
  else:
    p(x)

proc intProc(x: Int) =
  echo x
  
proc emptyProc() =
  echo "empty"

callProc[int](intProc, 12)
callProc[void](emptyProc)


returnT[void]()
echo returnT[string]("abc")
nothing()

