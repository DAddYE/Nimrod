discard """
  output: "Done"
  cmd: "nimrod cc --debuginfo --hints:on --define:useNimRtl $# $#"
"""

type
  TNodeKind = enum nkLit, nkSub, nkAdd, nkDiv, nkMul
  TNode = object
    case k: TNodeKind
    of nkLit: x: Int
    else: a, b: ref TNode

  PNode = ref TNode


when defined(windows):
  const dllname = "server.dll"
elif defined(macosx):
  const dllname = "libserver.dylib"
else:
  const dllname = "libserver.so"

proc newLit(x: Int): PNode {.importc: "newLit", dynlib: dllname.}
proc newOp(k: TNodeKind, a, b: PNode): PNode {.
  importc: "newOp", dynlib: dllname.}  
proc buildTree(x: Int): PNode {.importc: "buildTree", dynlib: dllname.} 

proc eval(n: PNode): Int =
  case n.k
  of nkLit: result = n.x
  of nkSub: result = eval(n.a) - eval(n.b)
  of nkAdd: result = eval(n.a) + eval(n.b)
  of nkDiv: result = eval(n.a) div eval(n.b)
  of nkMul: result = eval(n.a) * eval(n.b)

# Test the GC:
for i in 0..100_000:
  discard eval(buildTree(2))
  
echo "Done"

