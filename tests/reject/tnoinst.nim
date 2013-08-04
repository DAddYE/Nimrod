discard """
  line: 12
  errormsg: "instantiate 'notConcrete' explicitely"
"""

proc wrap[T]() =
  proc notConcrete[T](x, y: Int): Int =
    var dummy: T
    result = x - y

  var x: proc (x, y: T): Int
  x = notConcrete
  

wrap[int]()

