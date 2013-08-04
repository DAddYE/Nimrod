discard """
  output: '''
OBJ 1 foo
10
OBJ 1 bar
OBJ 2 foo
5
OBJ 2 bar
'''
"""

type
  # these are the signatures of the virtual procs for each type
  FooProc[T] = proc (o: var T): Int
  BarProc[T] = proc (o: var T)

  # an untyped table to store the proc pointers
  # it's also possible to use a strongly typed tuple here
  VTable = Array[0..1, Pointer]
  
  TBase = object {.inheritable.}
    vtbl: ptr VTable

  TUserObject1 = object of TBase
    x: Int

  TUserObject2 = object of TBase
    y: Int

proc foo(o: var TUserObject1): Int =
  echo "OBJ 1 foo"
  return 10

proc bar(o: var TUserObject1) =
  echo "OBJ 1 bar"

proc foo(o: var TUserObject2): Int =
  echo "OBJ 2 foo"
  return 5

proc bar(o: var TUserObject2) =
  echo "OBJ 2 bar"

proc getVTable(T: TypeDesc): ptr VTable =
  # pay attention to what's going on here
  # this will initialize the vtable for each type at program start-up
  #
  # fooProc[T](foo) is a type coercion - it looks for a proc named foo
  # matching the signature fooProc[T] (e.g. proc (o: var TUserObject1): int)
  var vtbl {.global.} = [
    cast[Pointer](FooProc[T](foo)),
    cast[Pointer](BarProc[T](bar))
  ]

  return vtbl.addr

proc create(T: TypeDesc): T =
  result.vtbl = getVTable(t)

proc baseFoo(o: var TBase): Int =
  return cast[FooProc[TBase]](o.vtbl[0]) (o)

proc baseBar(o: var TBase) =
  cast[BarProc[TBase]](o.vtbl[1]) (o)

var a = TUserObject1.create
var b = TUserObject2.create

echo a.baseFoo
a.baseBar

echo b.baseFoo
b.baseBar

