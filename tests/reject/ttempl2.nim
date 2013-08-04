discard """
  file: "ttempl2.nim"
  line: 18
  errormsg: "undeclared identifier: \'b\'"
"""
template declareInScope(x: Expr, t: TypeDesc): Stmt {.immediate.} =
  var x: t
  
template declareInNewScope(x: Expr, t: TypeDesc): Stmt {.immediate.} =
  # open a new scope:
  block: 
    var x: t

declareInScope(a, Int)
a = 42  # works, `a` is known here

declareInNewScope(b, Int)
b = 42  #ERROR_MSG undeclared identifier: 'b'

