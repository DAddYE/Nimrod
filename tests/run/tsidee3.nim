discard """
  file: "tsidee3.nim"
  output: "5"
"""

var
  global: Int

proc dontcare(x: Int): Int {.noSideEffect.} = return x

proc noSideEffect(x, y: Int, p: proc (a: Int): Int {.noSideEffect.}): Int {.noSideEffect.} = 
  return x + y + dontcare(x)
  
echo noSideEffect(1, 3, dontcare) #OUT 5



