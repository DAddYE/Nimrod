discard """
  file: "tcurrncy.nim"
  output: "25"
"""
template additive(typ: TypeDesc): Stmt =
  proc `+` *(x, y: typ): typ {.borrow.}
  proc `-` *(x, y: typ): typ {.borrow.}
  
  # unary operators:
  proc `+` *(x: typ): typ {.borrow.}
  proc `-` *(x: typ): typ {.borrow.}

template multiplicative(typ, base: TypeDesc): Stmt {.immediate.} =
  proc `*` *(x: typ, y: base): typ {.borrow.}
  proc `*` *(x: base, y: typ): typ {.borrow.}
  proc `div` *(x: typ, y: base): typ {.borrow.}
  proc `mod` *(x: typ, y: base): typ {.borrow.}

template comparable(typ: TypeDesc): Stmt =
  proc `<` * (x, y: typ): Bool {.borrow.}
  proc `<=` * (x, y: typ): Bool {.borrow.}
  proc `==` * (x, y: typ): Bool {.borrow.}

template defineCurrency(typ, base: Expr): Stmt {.immediate.} =
  type
    typ* = distinct base
  Additive(typ)
  Multiplicative(typ, base)
  Comparable(typ)
  
  proc `$` * (t: typ): String {.borrow.}

DefineCurrency(TDollar, Int)
DefineCurrency(TEuro, Int)
echo($( 12.TDollar + 13.TDollar )) #OUT 25



