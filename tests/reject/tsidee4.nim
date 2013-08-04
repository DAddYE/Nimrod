discard """
  file: "tsidee4.nim"
  line: 15
  errormsg: "type mismatch"
"""

var
  global: Int

proc dontcare(x: Int): Int = return x

proc noSideEffect(x, y: Int, p: proc (a: Int): Int {.noSideEffect.}): Int {.noSideEffect.} = 
  return x + y + dontcare(x)
  
echo noSideEffect(1, 3, dontcare) #ERROR_MSG type mismatch


