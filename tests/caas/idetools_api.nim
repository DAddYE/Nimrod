import unicode, sequtils, macros, re

proc testEnums() =
  var o: Tfile
  if o.open("files " & "test.txt", fmWrite):
    o.write("test")
    o.close()

proc testIterators(filename = "tests.nim") =
  let
    input = readFile(filename)
    letters = toSeq(runes(String(input)))
  for letter in letters: echo Int(letter)

const SomeSequence = @[1, 2]
type
  BadString = distinct String
  TPerson = object of TObject
    name*: BadString
    age: Int

proc adder(a, b: Int): Int =
  result = a + b

type
  PExpr = ref object of TObject ## abstract base class for an expression
  PLiteral = ref object of PExpr
    x: Int
  PPlusExpr = ref object of PExpr
    a, b: PExpr

# watch out: 'eval' relies on dynamic binding
method eval(e: PExpr): Int =
  # override this base method
  quit "to override!"

method eval(e: PLiteral): Int = e.x
method eval(e: PPlusExpr): Int = eval(e.a) + eval(e.b)

proc newLit(x: Int): PLiteral = PLiteral(x: x)
proc newPlus(a, b: PExpr): PPlusExpr = PPlusExpr(a: a, b: b)

echo eval(newPlus(newPlus(newLit(1), newLit(2)), newLit(4)))

proc findVowelPosition(text: String) =
  var found = -1
  block loops:
    for i, letter in pairs(text):
      for j in ['a', 'e', 'i', 'o', 'u']:
        if letter == j:
          found = i
          break loops # leave both for-loops
  echo found

findVowelPosition("Zerg") # should output 1, position of vowel.

macro expect*(exceptions: Varargs[Expr], body: Stmt): Stmt {.immediate.} =
  ## Expect docstrings
  let exp = callsite()
  template expectBody(errorTypes, lineInfoLit: Expr,
                      body: Stmt): PNimrodNode {.dirty.} =
    try:
      body
      assert false
    except errorTypes:
      nil

  var body = exp[exp.len - 1]

  var errorTypes = newNimNode(nnkBracket)
  for i in countup(1, exp.len - 2):
    errorTypes.add(exp[i])

  result = getAst(expectBody(errorTypes, exp.lineinfo, body))

proc err =
  raise newException(EArithmetic, "some exception")

proc testMacro() =
  expect(EArithmetic):
    err()

testMacro()
let notAModule = re"(\w+)=(.*)"
