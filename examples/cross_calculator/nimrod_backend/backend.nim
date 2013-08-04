# Backend for the different user interfaces.

proc myAdd*(x, y: Int): Int {.cdecl, exportc.} = 
  result = x + y

