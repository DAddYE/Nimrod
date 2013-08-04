discard """
  file: "tclosure.nim"
  output: "2 4 6 8 10"
  disabled: true
"""
# Test the closure implementation

proc map(n: var Openarray[Int], fn: proc (x: Int): Int {.closure}) =
  for i in 0..n.len-1: n[i] = fn(n[i])

proc foldr(n: Openarray[Int], fn: proc (x, y: Int): Int {.closure}): Int =
  for i in 0..n.len-1:
    result = fn(result, n[i])

proc each(n: Openarray[Int], fn: proc(x: Int) {.closure.}) =
  for i in 0..n.len-1:
    fn(n[i])

var
  myData: Array[0..4, Int] = [0, 1, 2, 3, 4]

proc testA() =
  var p = 0
  map(myData, proc (x: int): int =
                result = x + 1 shl (proc (y: int): int =
                  return y + p
                )(0)
                inc(p))

testA()

myData.each do (x: Int):
  write(stout, x)

#OUT 2 4 6 8 10

type
  ITest = tuple[
    setter: proc(v: Int),
    getter: proc(): Int]

proc getInterf(): ITest =
  var shared: int
  
  return (setter: proc (x) = shared = x,
          getter: proc (): int = return shared)

