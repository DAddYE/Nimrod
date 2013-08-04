discard """
  file: "toprprec.nim"
  output: "done"
"""
# Test operator precedence: 

template `@` (x: Expr): Expr {.immediate.} = self.x
template `@!` (x: Expr): Expr {.immediate.} = x
template `===` (x: Expr): Expr {.immediate.} = x

type
  TO = object
    x: Int
  TA = tuple[a, b: Int, obj: TO]
  
proc init(self: var TA): String =
  @a = 3
  === @b = 4
  @obj.x = 4
  @! === result = "abc"
  result = @b.`$`

assert 3+5*5-2 == 28- -26-28

proc `^-` (x, y: Int): Int =  
  # now right-associative!
  result = x - y
  
assert 34 ^- 6 ^- 2 == 30
assert 34 - 6 - 2 == 26


var s: TA
assert init(s) == "4"

echo "done"



