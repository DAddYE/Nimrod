import macros
{.deadCodeElim: on.}
#Inline macro.add() to allow for easier nesting
proc und*(a: PNimrodNode; b: PNimrodNode): PNimrodNode {.compileTime.} =
  a.add(b)
  result = a
proc und*(a: PNimrodNode; b: Varargs[PNimrodNode]): PNimrodNode {.compileTime.} =
  a.add(b)
  result = a

proc `^`*(a: String): PNimrodNode {.compileTime.} = 
  ## new ident node
  result = newIdentNode(!a)
proc `[]`*(a, b: PNimrodNode): PNimrodNode {.compileTime.} =
  ## new bracket expression: node[node] not to be confused with node[indx]
  result = newNimNode(nnkBracketExpr).und(a, b)
proc `:=`*(left, right: PNimrodNode): PNimrodNode {.compileTime.} =
  ## new Asgn node:  left = right
  result = newNimNode(nnkAsgn).und(left, right)

proc lit*(a: String): PNimrodNode {.compileTime.} =
  result = newStrLitNode(a)
proc lit*(a: Int): PNimrodNode {.compileTime.} =
  result = newIntLitNode(a)
proc lit*(a: Float): PNimrodNode {.compileTime.} =
  result = newFloatLitNode(a)
proc lit*(a: Char): PNimrodNode {.compileTime.} =
  result = newNimNode(nnkCharLit)
  result.intval = a.ord

proc emptyNode*(): PNimrodNode {.compileTime.} =
  result = newNimNode(nnkEmpty)

proc dot*(left, right: PNimrodNode): PNimrodNode {.compileTime.} =
  result = newNimNode(nnkDotExpr).und(left, right)
proc prefix*(a: String, b: PNimrodNode): PNimrodNode {.compileTime.} =
  result = newNimNode(nnkPrefix).und(newIdentNode(!a), b)

proc quoted2ident*(a: PNimrodNode): PNimrodNode {.compileTime.} = 
  if a.kind != nnkAccQuoted:
    return a
  var pname = ""
  for piece in 0..a.len - 1:
    pname.add($a[piece].ident)
  result = ^pname


macro `?`(a: Expr): Expr =
  ## Character literal ?A #=> 'A'
  result = ($a[1].ident)[0].lit
## echo(?F,?a,?t,?t,?y)

when isMainModule:
  macro foo(x: stmt): stmt =
    result = newNimNode(nnkStmtList)
    result.add(newNimNode(nnkCall).und(!!"echo", "Hello thar".lit))
    result.add(newCall("echo", lit("3 * 45 = "), (3.lit.infix("*", 45.lit))))
    let stmtlist = x[1]
    for i in countdown(len(stmtlist)-1, 0):
      result.add(stmtlist[i])
  foo:
    echo y, " * 2 = ", y * 2
    let y = 320

