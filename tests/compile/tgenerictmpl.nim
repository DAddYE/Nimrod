
template tmp[T](x: var Seq[T]) =
  #var yz: T  # XXX doesn't work yet
  x = @[1, 2, 3]

macro tmp2[T](x: var Seq[T]): Stmt =
  nil

var y: Seq[Int]
tmp(y)
tmp(y)
echo y.repr
