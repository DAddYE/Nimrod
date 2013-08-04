# Dump the contents of a PNimrodNode

import macros

template plus(a, b: Expr): Expr =
  a + b

macro call(e: Expr): Expr =
  result = newCall("foo", newStrLitNode("bar"))
  
macro dumpAST(n: Stmt): Stmt {.immediate.} =
  # dump AST as a side-effect and return the inner node
  let n = callsite()
  echo n.lispRepr
  echo n.treeRepr

  var plusAst = getAst(plus(1, 2))
  echo plusAst.lispRepr

  var callAst = getAst(call())
  echo callAst.lispRepr

  var e = parseExpr("foo(bar + baz)")
  echo e.lispRepr

  result = n[1]
  
dumpAST:
  proc add(x, y: int): int =
    return x + y
  
  proc sub(x, y: int): int = return x - y

