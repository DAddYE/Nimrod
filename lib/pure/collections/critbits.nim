#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements a `crit bit tree`:idx: which is an efficient
## container for a set or a mapping of strings. Based on the excellent paper
## by Adam Langley.

type
  TNode[T] = object {.pure, final, acyclic.}
    byte: Int ## byte index of the difference
    otherbits: Char
    case isLeaf: Bool
    of false: child: Array[0..1, ref TNode[T]]
    of true: 
      key: String
      when T isnot void:
        val: T
    
  PNode[T] = ref TNode[T]
  TCritBitTree*[T] = object {.
      pure, final.} ## The crit bit tree can either be used
                    ## as a mapping from strings to
                    ## some type ``T`` or as a set of
                    ## strings if ``T`` is void.
    root: PNode[T]
    count: Int
    
proc len*[T](c: TCritBitTree[T]): Int =
  ## returns the number of elements in `c` in O(1).
  result = c.count

proc rawGet[T](c: TCritBitTree[T], key: String): PNode[T] =
  var it = c.root
  while it != nil:
    if not it.isLeaf:
      let ch = if it.byte < key.len: key[it.byte] else: '\0'
      let dir = (1 + (ch.ord or it.otherBits.ord)) shr 8
      it = it.child[dir]
    else:
      return if it.key == key: it else: nil

proc contains*[T](c: TCritBitTree[T], key: String): Bool {.inline.} =
  ## returns true iff `c` contains the given `key`.
  result = rawGet(c, key) != nil

proc hasKey*[T](c: TCritBitTree[T], key: String): Bool {.inline.} =
  ## alias for `contains`.
  result = rawGet(c, key) != nil

proc rawInsert[T](c: var TCritBitTree[T], key: String): PNode[T] =
  if c.root == nil:
    new c.root
    c.root.isleaf = true
    c.root.key = key
    result = c.root
  else:
    var it = c.root
    while not it.isLeaf:
      let ch = if it.byte < key.len: key[it.byte] else: '\0'
      let dir = (1 + (ch.ord or it.otherBits.ord)) shr 8
      it = it.child[dir]
    
    var newOtherBits = 0
    var newByte = 0
    block blockX:
      while newByte < key.len:
        if it.key[newByte] != key[newByte]:
          newOtherBits = it.key[newByte].ord xor key[newByte].ord
          break blockX
        inc newByte
      if it.key[newByte] != '\0':
        newOtherBits = it.key[newByte].ord
      else:
        return it
    while (newOtherBits and (newOtherBits-1)) != 0:
      newOtherBits = newOtherBits and (newOtherBits-1)
    newOtherBits = newOtherBits xor 255
    let ch = it.key[newByte]
    let dir = (1 + (ord(ch) or newOtherBits)) shr 8
    
    var inner: PNode[T]
    new inner
    new result
    result.isLeaf = true
    result.key = key
    inner.otherBits = chr(newOtherBits)
    inner.byte = newByte
    inner.child[1 - dir] = result
    
    var wherep = addr(c.root)
    while true:
      var p = wherep[]
      if p.isLeaf: break
      if p.byte > newByte: break
      if p.byte == newByte and p.otherBits.ord > newOtherBits: break
      let ch = if p.byte < key.len: key[p.byte] else: '\0'
      let dir = (1 + (ch.ord or p.otherBits.ord)) shr 8
      wherep = addr(p.child[dir])
    inner.child[dir] = wherep[]
    wherep[] = inner
  inc c.count

proc containsOrIncl*[T](c: var TCritBitTree[T], key: String, val: T): Bool =
  ## returns true iff `c` contains the given `key`. If the key does not exist
  ## ``c[key] = val`` is performed.
  let oldCount = c.count
  var n = rawInsert(c, key)
  result = c.count == oldCount
  when T isnot Void:
    if not result: n.val = val

proc containsOrIncl*(c: var TCritBitTree[Void], key: String): Bool =
  ## returns true iff `c` contains the given `key`. If the key does not exist
  ## it is inserted into `c`.
  let oldCount = c.count
  var n = rawInsert(c, key)
  result = c.count == oldCount

proc incl*(c: var TCritBitTree[Void], key: String) =
  ## includes `key` in `c`.
  discard rawInsert(c, key)

proc `[]=`*[T](c: var TCritBitTree[T], key: String, val: T) =
  ## puts a (key, value)-pair into `t`.
  var n = rawInsert(c, key)
  n.val = val

proc `[]`*[T](c: var TCritBitTree[T], key: String): T {.inline.} =
  ## retrieves the value at ``c[key]``. If `key` is not in `t`,
  ## default empty value for the type `B` is returned
  ## and no exception is raised. One can check with ``hasKey`` whether the key
  ## exists.
  let n = rawGet(c, key)
  if n != nil: result = n.val

proc mget*[T](c: var TCritBitTree[T], key: String): var T {.inline.} =
  ## retrieves the value at ``c[key]``. The value can be modified.
  ## If `key` is not in `t`, the ``EInvalidKey`` exception is raised.
  let n = rawGet(c, key)
  if n != nil: result = n.val
  else: raise newException(EInvalidKey, "key not found: " & $key)

proc excl*[T](c: var TCritBitTree[T], key: String) =
  ## removes `key` (and its associated value) from the set `c`.
  ## If the `key` does not exist, nothing happens.
  var p = c.root
  var wherep = addr(c.root)
  var whereq: ptr PNode = nil
  if p == nil: return
  var dir = 0
  var q: PNode
  while not p.isLeaf:
    whereq = wherep
    q = p
    let ch = if p.byte < key.len: key[p.byte] else: '\0'
    dir = (1 + (ch.ord or p.otherBits.ord)) shr 8
    wherep = addr(p.child[dir])
    p = wherep[]
  if p.key == key:
    # else: not in tree at all
    if whereq == nil:
      c.root = nil
    else:
      whereq[] = q.child[1 - dir]
    dec c.count

iterator leaves[T](n: PNode[T]): PNode[T] =
  if n != nil:
    # XXX actually we could compute the necessary stack size in advance:
    # it's rougly log2(c.count).
    var stack = @[n]
    while stack.len > 0: 
      var it = stack.pop
      while not it.isLeaf:
        stack.add(it.child[1])
        it = it.child[0]
        assert(it != nil)
      yield it

iterator keys*[T](c: TCritBitTree[T]): String =
  ## yields all keys in lexicographical order.
  for x in leaves(c.root): yield x.key

iterator values*[T](c: TCritBitTree[T]): T =
  ## yields all values of `c` in the lexicographical order of the
  ## corresponding keys.
  for x in leaves(c.root): yield x.val

iterator mvalues*[T](c: var TCritBitTree[T]): var T =
  ## yields all values of `c` in the lexicographical order of the
  ## corresponding keys. The values can be modified.
  for x in leaves(c.root): yield x.val

iterator items*[T](c: TCritBitTree[T]): String =
  ## yields all keys in lexicographical order.
  for x in leaves(c.root): yield x.key

iterator pairs*[T](c: TCritBitTree[T]): tuple[key: String, val: T] =
  ## yields all (key, value)-pairs of `c`.
  for x in leaves(c.root): yield (x.key, x.val)
  
iterator mpairs*[T](c: var TCritBitTree[T]): tuple[key: String, val: var T] =
  ## yields all (key, value)-pairs of `c`. The yielded values can be modified.
  for x in leaves(c.root): yield (x.key, x.val)

proc allprefixedAux[T](c: TCritBitTree[T], key: String): PNode[T] =
  var p = c.root
  var top = p
  if p != nil:
    while not p.isLeaf:
      var q = p
      let ch = if p.byte < key.len: key[p.byte] else: '\0'
      let dir = (1 + (ch.ord or p.otherBits.ord)) shr 8
      p = p.child[dir]
      if q.byte < key.len: top = p
    for i in 0 .. <key.len:
      if p.key[i] != key[i]: return
    result = top

iterator itemsWithPrefix*[T](c: TCritBitTree[T], prefix: String): String =
  ## yields all keys starting with `prefix`.
  let top = allprefixedAux(c, prefix)
  for x in leaves(top): yield x.key

iterator keysWithPrefix*[T](c: TCritBitTree[T], prefix: String): String =
  ## yields all keys starting with `prefix`.
  let top = allprefixedAux(c, prefix)
  for x in leaves(top): yield x.key

iterator valuesWithPrefix*[T](c: TCritBitTree[T], prefix: String): T =
  ## yields all values of `c` starting with `prefix` of the
  ## corresponding keys.
  let top = allprefixedAux(c, prefix)
  for x in leaves(top): yield x.val

iterator mvaluesWithPrefix*[T](c: var TCritBitTree[T], prefix: String): var T =
  ## yields all values of `c` starting with `prefix` of the
  ## corresponding keys. The values can be modified.
  let top = allprefixedAux(c, prefix)
  for x in leaves(top): yield x.val

iterator pairsWithPrefix*[T](c: TCritBitTree[T],
                             prefix: String): tuple[key: String, val: T] =
  ## yields all (key, value)-pairs of `c` starting with `prefix`.
  let top = allprefixedAux(c, prefix)
  for x in leaves(top): yield (x.key, x.val)
  
iterator mpairsWithPrefix*[T](c: var TCritBitTree[T],
                              prefix: String): tuple[key: String, val: var T] =
  ## yields all (key, value)-pairs of `c` starting with `prefix`.
  ## The yielded values can be modified.
  let top = allprefixedAux(c, prefix)
  for x in leaves(top): yield (x.key, x.val)

proc `$`*[T](c: TCritBitTree[T]): String =
  ## turns `c` into a string representation. Example outputs:
  ## ``{keyA: value, keyB: value}``, ``{:}``
  ## If `T` is void the outputs look like:
  ## ``{keyA, keyB}``, ``{}``.
  if c.len == 0:
    when T is Void:
      result = "{}"
    else:
      result = "{:}"
  else:
    # an educated guess is better than nothing:
    when T is Void:
      const avgItemLen = 8
    else:
      const avgItemLen = 16
    result = newStringOfCap(c.count * avgItemLen)
    result.add("{")
    for key, val in pairs(c):
      if result.len > 1: result.add(", ")
      result.add($key)
      when T isnot Void:
        result.add(": ")
        result.add($val)
    result.add("}")

when isMainModule:
  var r: TCritBitTree[void]
  r.incl "abc"
  r.incl "xyz"
  r.incl "def"
  r.incl "definition"
  r.incl "prefix"
  doAssert r.contains"def"
  #r.del "def"

  for w in r.items:
    echo w
    
  for w in r.itemsWithPrefix("de"):
    echo w

