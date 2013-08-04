# Test nested loops and some other things

proc andTest() =
  var a = 0 == 5 and 6 == 6

proc incx(x: var Int) = # is built-in proc
  x = x + 1

proc decx(x: var Int) =
  x = x - 1

proc first(y: var Int) =
  var x: Int
  incx(x)
  if x == 10:
    y = 0
  else:
    if x == 0:
      incx(x)
    else:
      x=11

proc testLoops() =
  var i, j: Int
  while i >= 0:
    if i mod 3 == 0:
      break
    i = i + 1
    while j == 13:
      j = 13
      break
    break

  while true:
    break


proc foo(n: Int): Int =
    var
        a, old: Int
        b, c: Bool
    first(a)
    if a == 10:
        a = 30
    elif a == 11:
        a = 22
    elif a == 12:
        a = 23
    elif b:
        old = 12
    else:
        a = 40

    #
    b = false or 2 == 0 and 3 == 9
    a = 0 + 3 * 5 + 6 + 7 + +8 # 36
    while b:
        a = a + 3
    a = a + 5
    write(stdout, "Hello!")


# We should come till here :-)
discard foo(345)

# test the new type symbol lookup feature:

type
  MyType[T] = tuple[
    x, y, z: T]
  MyType2 = tuple[x, y: Float]

proc main[T]() =
  var myType: MyType[T]
  var b: MyType[T]
  b = (1, 2, 3)
  myType = b
  echo myType
  
  var myType2: MyType2
  var c: MyType2
  c = (1.0, 2.0)
  myType2 = c
  echo myType2

main[int]()

