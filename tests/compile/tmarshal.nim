discard """
  output: ""
"""

import marshal

template testit(x: Expr) = echo($$to[type(x)]($$x))

var x: Array[0..4, Array[0..4, String]] = [
  ["test", "1", "2", "3", "4"], ["test", "1", "2", "3", "4"], 
  ["test", "1", "2", "3", "4"], ["test", "1", "2", "3", "4"], 
  ["test", "1", "2", "3", "4"]]
testit(x)
var test2: tuple[name: String, s: Int] = ("tuple test", 56)
testit(test2)

type
  TE = enum
    blah, blah2

  TestObj = object
    test, asd: Int
    case test2: TE
    of blah:
      help: String
    else:
      nil
      
  PNode = ref TNode
  TNode = object
    next, prev: PNode
    data: String

proc buildList(): PNode =
  new(result)
  new(result.next)
  new(result.prev)
  result.data = "middle"
  result.next.data = "next"
  result.prev.data = "prev"
  result.next.next = result.prev
  result.next.prev = result
  result.prev.next = result
  result.prev.prev = result.next

var test3: TestObj
test3.test = 42
test3.test2 = blah
testit(test3)

var test4: ref tuple[a, b: String]
new(test4)
test4.a = "ref string test: A"
test4.b = "ref string test: B"
testit(test4)

var test5 = @[(0,1),(2,3),(4,5)]
testit(test5)

var test7 = buildList()
testit(test7)

var test6: Set[Char] = {'A'..'Z', '_'}
testit(test6)

