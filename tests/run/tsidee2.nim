discard """
  file: "tsidee2.nim"
  output: "5"
"""

var
  global: Int

proc dontcare(x: Int): Int = return x

proc sideEffectLyer(x, y: Int): Int {.noSideEffect.} = 
  return x + y + dontcare(x)
  
echo sideEffectLyer(1, 3) #OUT 5



