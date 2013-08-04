discard """
  output: "0false12"
"""

# Test multiple generic instantiation of generic proc vars:

proc threadProcWrapper[TMsg]() =
  var x: TMsg
  stdout.write($x)

#var x = threadProcWrapper[int]
#x()

#var y = threadProcWrapper[bool]
#y()

threadProcWrapper[int]()
threadProcWrapper[bool]()

type
  TFilterProc[T,D] = proc (item: T, env:D): Bool {.nimcall.}

proc filter[T,D](data: Seq[T], env:D, pred: TFilterProc[T,D]): Seq[T] =
  result = @[]
  for e in data:
    if pred(e, env): result.add(e)

proc predTest(item: Int, value: Int): Bool =
  return item <= value

proc test(data: Seq[Int], value: Int): Seq[Int] =
  return filter(data, value, predTest)

for x in items(test(@[1,2,3], 2)):
  stdout.write(x)

