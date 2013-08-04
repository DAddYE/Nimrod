# test a simple yet highly efficient set of strings

type
  TRadixNodeKind = enum rnLinear, rnFull, rnLeaf
  PRadixNode = ref TRadixNode
  TRadixNode = object {.inheritable.}
    kind: TRadixNodeKind
  TRadixNodeLinear = object of TRadixNode
    len: Int8
    keys: Array [0..31, Char]
    vals: Array [0..31, PRadixNode]  
  TRadixNodeFull = object of TRadixNode
    b: Array [char, PRadixNode]
  TRadixNodeLeaf = object of TRadixNode
    s: String
  PRadixNodeLinear = ref TRadixNodeLinear
  PRadixNodeFull = ref TRadixNodeFull
  PRadixNodeLeaf = ref TRadixNodeLeaf
    
proc search(r: PRadixNode, s: String): PRadixNode =
  var r = r
  var i = 0
  while r != nil:
    case r.kind
    of rnLinear:
      var x = PRadixNodeLinear(r)
      for j in 0..ze(x.len)-1:
        if x.keys[j] == s[i]:
          if s[i] == '\0': return r
          r = x.vals[j]
          inc(i)
          break
      break # character not found
    of rnFull:
      var x = PRadixNodeFull(r)
      var y = x.b[s[i]]
      if s[i] == '\0':
        return if y != nil: r else: nil
      r = y
      inc(i)
    of rnLeaf:
      var x = PRadixNodeLeaf(r)
      var j = 0
      while true:
        if x.s[j] != s[i]: return nil
        if s[i] == '\0': return r
        inc(j)
        inc(i)

proc contains*(r: PRadixNode, s: String): Bool =
  return search(r, s) != nil

proc testOrincl*(r: var PRadixNode, s: String): Bool =
  nil
    
proc incl*(r: var PRadixNode, s: String) = discard testOrincl(r, s)

proc excl*(r: var PRadixNode, s: String) =
  var x = search(r, s)
  if x == nil: return
  case x.kind
  of rnLeaf: PRadixNodeLeaf(x).s = ""
  of rnFull: PRadixNodeFull(x).b['\0'] = nil
  of rnLinear:
    var x = PRadixNodeLinear(x)
    for i in 0..ze(x.len)-1:
      if x.keys[i] == '\0':
        swap(x.keys[i], x.keys[ze(x.len)-1])
        dec(x.len)
        break

var
  root: PRadixNode

