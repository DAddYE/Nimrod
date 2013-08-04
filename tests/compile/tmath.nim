# tests for the interpreter

proc loops(a: var Int) =
  nil
  #var
  #  b: int
  #b = glob
  #while b != 0:
  #  b = b + 1
  #a = b

proc mymax(a, b: Int): Int =
  #loops(result)
  result = a
  if b > a: result = b

proc test(a, b: Int) =
  var
    x, y: Int
  x = 0
  y = 7
  if x == a + b * 3 - 7 or
      x == 8 or
      x == y and y > -56 and y < 699:
    y = 0
  elif y == 78 and x == 0:
    y = 1
  elif y == 0 and x == 0:
    y = 2
  else:
    y = 3

type
  TTokType = enum
    tkNil, tkType, tkConst, tkVar, tkSymbol, tkIf,
    tkWhile, tkFor, tkLoop, tkCase, tkLabel, tkGoto

proc testCase(t: TTokType): Int =
  case t
  of tkNil, tkType, tkConst: result = 0
  of tkVar: result = 1
  of tkSymbol: result = 2
  of tkIf..tkFor: result = 3
  of tkLoop: result = 56
  else: result = -1
  test(0, 9) # test the call

proc testLoops() =
  var
    i, j: Int

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


var
  glob: Int
  a: Array [0..5, Int]

proc main() =
  #glob = 0
  #loops( glob )
  var
    res: Int
    s: String
  #write(stdout, mymax(23, 45))
  write(stdout, "Hallo! Wie heiﬂt du? ")
  s = readLine(stdin)
  # test the case statement
  case s
  of "Andreas": write(stdout, "Du bist mein Meister!\n")
  of "Rumpf": write(stdout, "Du bist in der Familie meines Meisters!\n")
  else: write(stdout, "ich kenne dich nicht!\n")
  write(stdout, "Du heisst " & s & "\n")

main()
