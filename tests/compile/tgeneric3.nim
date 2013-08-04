import strutils

type
  PNode[T,D] = ref TNode[T,D]
  TItem {.acyclic, pure, final, shallow.} [T,D] = object
        key: T
        value: D
        node: PNode[T,D]
        when not (D is string):
          valSet: Bool

  TItems[T,D] = Seq[ref TItem[T,D]]
  TNode {.acyclic, pure, final, shallow.} [T,D] = object
        slots: TItems[T,D]
        left: PNode[T,D]
        count: Int32


  RPath[T,D] = tuple[
    xi: Int,
    nd: PNode[T,D] ]

const
  cLen1 = 2
  cLen2 = 16
  cLen3 = 32
  cLenCenter = 80
  clen4 = 96
  cLenMax = 128
  cCenter = cLenMax div 2

proc len[T,D] (n:PNode[T,D]): Int {.inline.} =
  return n.Count

proc clean[T: TOrdinal|TNumber](o: var T) {.inline.} = nil

proc clean[T: string|seq](o: var T) {.inline.} =
  o = nil

proc clean[T,D] (o: ref TItem[T,D]) {.inline.} = 
  when (D is String) :
    o.Value = nil
  else :
    o.val_set = false

proc isClean[T,D] (it: ref TItem[T,D]): Bool {.inline.} = 
  when (D is String) :
    return it.Value == nil
  else :
    return not it.val_set

proc isClean[T,D] (n: PNode[T,D], x: Int): Bool {.inline.} = 
  when (D is String) :
    return n.slots[x].Value == nil
  else :
    return not n.slots[x].val_set

proc setItem[T,D] (AKey: T, AValue: D, ANode: PNode[T,D]): ref TItem[T,D] {.inline.} = 
  new(Result)
  Result.Key = aKey
  Result.Value = aValue
  Result.Node = aNode
  when not (D is String) :
    Result.val_set = true

proc cmp[T:Int8|Int16|Int32|Int64|Int] (a,b: T): T {.inline.} =
  return a-b

template binSearchImpl *(docmp: Expr) {.immediate.} =
  var bFound = false
  result = 0
  var h = haystack.len -1
  while result <= h :
    var i {.inject.} = (result + h) shr 1
    var sw = docmp 
    if sw < 0: result = i + 1 
    else:
      h = i - 1
      if sw == 0 : bFound = true
  if bFound: inc(result)
  else: result = - result

proc bSearch[T,D] (haystack: PNode[T,D], needle:T): Int {.inline.} =
  binSearchImpl(haystack.slots[i].key.cmp(needle))

proc deleteItem[T,D] (n: PNode[T,D], x: Int): PNode[T,D] {.inline.} =
  var w = n.slots[x]
  if w.Node != nil : 
    clean(w)
    return n
  dec(n.Count)
  if n.Count > 0 :
    for i in countup(x, n.Count -1) : n.slots[i] = n.slots[i + 1]
    n.slots[n.Count] = nil
    case n.Count 
    of cLen1 : setLen(n.slots, cLen1)
    of cLen2 : setLen(n.slots, cLen2)
    of cLen3 : setLen(n.slots, cLen3)
    of cLenCenter : setLen(n.slots, cLenCenter)
    of clen4 : setLen(n.slots, clen4)
    else: nil
    Result = n

  else :
    Result = n.Left
    n.slots = nil
    n.Left = nil

proc internalDelete[T,D] (ANode: PNode[T,D], key: T, AValue: var D): PNode[T,D] = 
  var Path: Array[0..20, RPath[T,D]]
  var n = ANode
  Result = n
  clean(AValue)
  var h = 0
  while n != nil:
    var x = bSearch(n, key)
    if x <= 0 :
      Path[h].Nd = n
      Path[h].Xi = - x
      inc(h)
      if x == 0 :
        n = n.Left
      else :
        x = (-x) -1
        if x < n.Count :
          n = n.slots[x].Node
        else :
          n = nil
    else : 
      dec(x)
      if isClean(n, x) : return
      AValue = n.slots[x].Value
      var n2 = deleteItem(n, x)
      dec(h)
      while (n2 != n) and (h >=0) :
        n = n2 
        var w = addr Path[h]
        x  = w.Xi -1
        if x >= 0 :
          if (n == nil) and isClean(w.Nd, x) :
            n = w.Nd
            n.slots[x].Node = nil 
            n2 = deleteItem(n, x)
          else :
            w.Nd.slots[x].Node = n
            return
        else :
          w.Nd.Left = n
          return
        dec(h)
      if h < 0:
        Result = n2
      return

proc internalFind[T,D] (n: PNode[T,D], key: T): ref TItem[T,D] {.inline.} =
  var wn = n
  while wn != nil :
    var x = bSearch(wn, key)
    if x <= 0 :
      if x == 0 :
        wn = wn.Left
      else :
        x = (-x) -1
        if x < wn.Count : 
          wn = wn.slots[x].Node
        else :
          return nil

    else :
      return wn.slots[x - 1]
  return nil

proc traceTree[T,D](root: PNode[T,D]) =
  proc traceX(x: Int) = 
    write stdout, "("
    write stdout, x
    write stdout, ") "

  proc traceEl(el: ref TItem[T,D]) =
    write stdout, " key: "
    write stdout, el.Key
    write stdout, " value: "
    write stdout, el.Value


  proc traceln(space: String) =
    writeln stdout, ""
    write stdout, space

  proc doTrace(n: PNode[T,D], level: Int) =
    var space = repeatChar(2 * level)
    traceln(space)
    write stdout, "node: "
    if n == nil:
      writeln stdout, "is empty"
      return
    write stdout, n.Count
    write stdout, " elements: "
    if n.Left != nil:
      traceln(space)
      write stdout, "left: "
      doTrace(n.left, level +1)
    for i, el in n.slots :
      if el != nil and not isClean(el):
        traceln(space)
        traceX(i)
        if i >= n.Count: 
          write stdout, "error "
        else:
          traceEl(el)
          if el.Node != nil: doTrace(el.Node, level +1)
          else : write stdout, " empty "
      elif i < n.Count :
        traceln(space)
        traceX(i)
        write stdout, "clean: "
        when T is String :
          if el.Key != nil: write stdout, el.Key
        else : write stdout, el.Key
        if el.Node != nil: doTrace(el.Node, level +1)
        else : write stdout, " empty "
    writeln stdout,""

  doTrace(root, 0)

proc insertItem[T,D](APath: RPath[T,D], ANode:PNode[T,D], AKey: T, AValue: D) =
  var x = - aPath.Xi
  inc(aPath.Nd.Count)
  case aPath.Nd.Count 
  of cLen1: setLen(aPath.Nd.slots, cLen2)
  of cLen2: setLen(aPath.Nd.slots, cLen3)
  of cLen3: setLen(aPath.Nd.slots, cLenCenter)
  of cLenCenter: setLen(aPath.Nd.slots, clen4)
  of clen4: setLen(aPath.Nd.slots, cLenMax)
  else: nil
  for i in countdown(aPath.Nd.Count.Int - 1, x + 1): shallowCopy(aPath.Nd.slots[i], aPath.Nd.slots[i - 1])
  aPath.Nd.slots[x] = setItem(aKey, aValue, aNode)


proc splitPage[T,D](n, left: PNode[T,D], xi: Int, AKey:var T, AValue:var D): PNode[T,D] =
  var x = -xi
  var it1: TItems[T,D]
  it1.newSeq(cLenCenter)
  new(Result)
  Result.slots.newSeq(cLenCenter)
  Result.Count = cCenter
  if x == cCenter:
    for i in 0..cCenter -1: shallowCopy(it1[i], left.slots[i])
    for i in 0..cCenter -1: shallowCopy(Result.slots[i], left.slots[cCenter + i])
    Result.Left = n
  else :
    if x < cCenter :
      for i in 0..x-1: shallowCopy(it1[i], left.slots[i])
      it1[x] = setItem(aKey, aValue, n)
      for i in x+1 .. cCenter -1: shallowCopy(it1[i], left.slots[i-1])
      var w = left.slots[cCenter -1]
      aKey = w.Key
      aValue = w.Value
      Result.Left = w.Node
      for i in 0..cCenter -1: shallowCopy(Result.slots[i], left.slots[cCenter + i])
    else :
      for i in 0..cCenter -1: shallowCopy(it1[i], left.slots[i])
      x = x - (cCenter + 1)
      for i in 0..x-1: shallowCopy(Result.slots[i], left.slots[cCenter + i + 1])
      Result.slots[x] = setItem(aKey, aValue, n)
      for i in x+1 .. cCenter -1: shallowCopy(Result.slots[i], left.slots[cCenter + i])
      var w = left.slots[cCenter]
      aKey = w.Key
      aValue = w.Value
      Result.Left = w.Node
  left.Count = cCenter
  shallowCopy(left.slots, it1)


proc internalPut[T,D](ANode: ref TNode[T,D], AKey: T, AValue: D, OldValue: var D): ref TNode[T,D] =
  var h: Int
  var path: Array[0..30, RPath[T,D]]
  var left: PNode[T,D]
  var n = aNode


  Result = aNode
  h = 0
  while n != nil:
    var x = bSearch[T,D](n, aKey)
    if x <= 0 :
      path[h].Nd = n
      path[h].Xi = x
      inc(h) 
      if x == 0 :
        n = n.Left
      else :
        x = (-x) -1
        if x < n.Count :
          n = n.slots[x].Node
        else :
          n = nil
    else :
      var w = n.slots[x - 1]
      oldValue = w.Value
      w.Value = aValue
      return

  dec(h)
  left = nil
  var lKey = aKey
  var lValue = aValue
  while h >= 0 :
    if path[h].Nd.Count < cLenMax :
      insertItem(path[h], n, lKey, lValue)
      return
    else :
      left = path[h].Nd
      n = splitPage(n, left, path[h].Xi, lKey, lValue)
    dec(h)

  new(Result)
  Result.slots.newSeq(cLen1)
  Result.Count = 1
  Result.Left = left
  Result.slots[0] = setItem(lKey, lValue, n)


proc cleanTree[T,D](n: PNode[T,D]): PNode[T,D] =
  if n.Left != nil :
    n.Left = cleanTree(n.Left)
  for i in 0 .. n.Count - 1 :
    var w = n.slots[i]
    if w.Node != nil :
        w.Node = cleanTree(w.Node)
    clean(w.Value)
    clean(w.Key)
  n.slots = nil
  return nil


proc visitAllNodes[T,D](n: PNode[T,D], visit: proc(n: PNode[T,D]): PNode[T,D] {.closure.} ): PNode[T,D] =
  if n != nil :
    if n.Left != nil :
      n.Left = visitAllNodes(n.Left, visit)    
    for i in 0 .. n.Count - 1 :
      var w = n.slots[i]
      if w.Node != nil :
        w.Node = visitAllNodes(w.Node, visit)    
    return visit(n)
  return nil

proc visitAllNodes[T,D](n: PNode[T,D], visit: proc(n: PNode[T,D]) {.closure.} ) =
  if n != nil:
    if n.Left != nil :
      visitAllNodes(n.Left, visit)    
    for i in 0 .. n.Count - 1 :
      var w = n.slots[i]
      if w.Node != nil :
        visitAllNodes(w.Node, visit)    
    visit(n)

proc visitAll[T,D](n: PNode[T,D], visit: proc(AKey: T, AValue: D) {.closure.} ) =
  if n != nil:
    if n.Left != nil :
      visitAll(n.Left, visit) 
    for i in 0 .. n.Count - 1 :
      var w = n.slots[i]
      if not w.isClean :
        visit(w.Key, w.Value)   
      if w.Node != nil :
        visitAll(w.Node, visit)    

proc visitAll[T,D](n: PNode[T,D], visit: proc(AKey: T, AValue: var D):Bool {.closure.} ): PNode[T,D] =
  if n != nil:
    var n1 = n.Left
    if n1 != nil :
      var n2 = visitAll(n1, visit) 
      if n1 != n2 :
        n.Left = n2
    var i = 0
    while i < n.Count :
      var w = n.slots[i]
      if not w.isClean :
        if visit(w.Key, w.Value) :
          Result = deleteItem(n, i)
          if Result == nil : return
          dec(i)
      n1 = w.Node
      if n1 != nil :
        var n2 = visitAll(n1, visit)
        if n1 != n2 :
          w.Node = n2
      inc(i)
  return n

iterator keys* [T,D] (n: PNode[T,D]): T =
  if n != nil :
    var Path: Array[0..20, RPath[T,D]]
    var level = 0
    var nd = n
    var i = -1
    while true : 
      if i < nd.Count :
        Path[level].Nd = nd
        Path[level].Xi = i
        if i < 0 :
          if nd.Left != nil :
            nd = nd.Left
            inc(level)
          else : inc(i)
        else :
          var w = nd.slots[i]
          if not w.isClean() :
            yield w.Key
          if w.Node != nil :
            nd = w.Node
            i = -1
            inc(level)
          else : inc(i)
      else :
        dec(level)
        if level < 0 : break
        nd = Path[level].Nd
        i = Path[level].Xi
        inc(i)


when isMainModule:

  proc test() =
    var oldValue: Int
    var root = internalPut[int, int](nil, 312, 312, oldValue)
    var someOtherRoot = internalPut[string, int](nil, "312", 312, oldValue)
    var it1 = internalFind(root, 312)
    echo it1.Value

    for i in 1..1_000_000:
      root = internalPut(root, i, i, oldValue)

    var cnt = 0
    oldValue = -1
    when true : # code compiles, when this or the other when is switched to false
      for k in root.keys :
        if k <= oldValue :
          echo k
        oldValue = k
        inc(cnt)
      echo cnt
    when true :
      cnt = 0
      visitAll(root, proc(key, val: int) = inc(cnt))
      echo cnt
      when true :
        root = visitAll(root, proc(key: Int, value: var Int): Bool =
          return key mod 2 == 0 )
      cnt = 0
      oldValue = -1
      visitAll(root, proc(key: int, value: int) {.closure.} =
        if key <= oldValue :
          echo key
        oldValue = key
        inc(cnt) )
      echo cnt
      root = visitAll(root, proc(key: Int, value: var Int): Bool =
        return key mod 2 != 0 )
      cnt = 0
      oldValue = -1
      visitAll(root, proc(key: int, value: int) {.closure.} =
        if key <= oldValue :
          echo "error ", key
        oldValue = key
        inc(cnt) )
      echo cnt
      #traceTree(root)



  test()  
