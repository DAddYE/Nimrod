discard """
  errormsg: "cannot prove that field 'x.s' is accessible"
  line:51
"""

import strutils

{.warning[ProveField]: on.}

type
  TNodeKind = enum
    nkBinary, nkTernary, nkStr
  PNode = ref TNode not nil
  TNode = object
    case k: TNodeKind
    of nkBinary, nkTernary: a, b: PNode
    of nkStr: s: String
    
  PList = ref object
    data: String
    next: PList

proc getData(x: PList not nil) =
  echo x.data

var head: PList

proc processList() =
  var it = head
  while it != nil:
    getData(it)
    it = it.next

proc toString2(x: PNode): String =
  if x.k < nkStr:
    toString2(x.a) & " " & toString2(x.b)
  else:
    x.s

proc toString(x: PNode): String =
  case x.k
  of nkTernary, nkBinary:
    toString(x.a) & " " & toString(x.b)
  of nkStr:
    x.s

proc toString3(x: PNode): String =
  if x.k <= nkBinary:
    toString3(x.a) & " " & toString3(x.b)
  else:
    x.s # x.k in {nkStr}  --> fact:  not (x.k <= nkBinary)

proc p() =
  var x: PNode = PNode(k: nkStr, s: "abc")
  
  let y = x
  if not y.isNil:
    echo toString(y), " ", toString2(y)

p()
