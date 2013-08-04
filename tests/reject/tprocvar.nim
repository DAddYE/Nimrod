discard """
  errormsg: "type mismatch"
  line: 17
  file: "tprocvar.nim"
"""

type
  TCallback = proc (a, b: Int)

proc huh(x, y: var Int) =
  x = 0
  y = x+1

proc so(c: TCallback) =
  c(2, 4)
  
so(huh)

