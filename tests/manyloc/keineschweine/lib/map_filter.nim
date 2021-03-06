template filterIt2*(seq, pred: Expr, body: Stmt): Stmt {.immediate, dirty.} =
  ## sequtils defines a filterIt() that returns a new seq, but this one is called
  ## with a statement body to iterate directly over it
  for it in items(seq):
    if pred: body

proc map*[A, B](x: Seq[A], func: proc(y: A): B {.closure.}): Seq[B] =
  result = @[]
  for item in x.items:
    result.add func(item)

proc mapInPlace*[A](x: var Seq[A], func: proc(y: A): A {.closure.}) =
  for i in 0..x.len-1:
    x[i] = func(x[i])

template unless*(condition: Expr; body: Stmt): Stmt {.dirty.} =
  if not(condition):
    body

when isMainModule:
  proc dumpSeq[T](x: Seq[T]) =
    for index, item in x.pairs: 
      echo index, " ", item
    echo "-------"

  var t= @[1,2,3,4,5]
  var res = t.map(proc(z: Int): Int = result = z * 10)
  dumpSeq res

  from strutils import toHex, repeatStr
  var foocakes = t.map(proc(z: Int): String = 
    result = toHex((z * 23).BiggestInt, 4))
  dumpSeq foocakes

  t.mapInPlace(proc(z: Int): Int = result = z * 30)
  dumpSeq t
  
  var someSeq = @[9,8,7,6,5,4,3,2,1] ## numbers < 6 or even
  filterIt2 someSeq, it < 6 or (it and 1) == 0:
    echo(it)
  echo "-----------"
