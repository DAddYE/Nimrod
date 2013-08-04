discard """
  file: "tsidee1.nim"
  line: 12
  errormsg: "\'SideEffectLyer\' can have side effects"
"""

var
  global: Int

proc dontcare(x: Int): Int = return x + global

proc sideEffectLyer(x, y: Int): Int {.noSideEffect.} = #ERROR_MSG 'SideEffectLyer' can have side effects
  return x + y + dontcare(x)
  
echo sideEffectLyer(1, 3) 



