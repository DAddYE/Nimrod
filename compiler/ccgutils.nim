#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# This module declares some helpers for the C code generator.

import 
  ast, astalgo, ropes, lists, hashes, strutils, types, msgs, wordrecg, 
  platform, trees

proc getPragmaStmt*(n: PNode, w: TSpecialWord): PNode =
  case n.kind
  of nkStmtList: 
    for i in 0 .. < n.len: 
      result = getPragmaStmt(n[i], w)
      if result != nil: break
  of nkPragma:
    for i in 0 .. < n.len: 
      if whichPragma(n[i]) == w: return n[i]
  else: nil

proc stmtsContainPragma*(n: PNode, w: TSpecialWord): Bool =
  result = getPragmaStmt(n, w) != nil

proc hashString*(s: String): BiggestInt = 
  # has to be the same algorithm as system.hashString!
  if Cpu[targetCPU].bit == 64: 
    # we have to use the same bitwidth
    # as the target CPU
    var b = 0'i64
    for i in countup(0, len(s) - 1): 
      b = b +% ord(s[i])
      b = b +% `shl`(b, 10)
      b = b xor `shr`(b, 6)
    b = b +% `shl`(b, 3)
    b = b xor `shr`(b, 11)
    b = b +% `shl`(b, 15)
    result = b
  else: 
    var a = 0'i32
    for i in countup(0, len(s) - 1): 
      a = a +% ord(s[i]).Int32
      a = a +% `shl`(a, 10'i32)
      a = a xor `shr`(a, 6'i32)
    a = a +% `shl`(a, 3'i32)
    a = a xor `shr`(a, 11'i32)
    a = a +% `shl`(a, 15'i32)
    result = a

var 
  gTypeTable: Array[TTypeKind, TIdTable]
  gCanonicalTypes: Array[TTypeKind, PType]

proc initTypeTables() = 
  for i in countup(low(TTypeKind), high(TTypeKind)): initIdTable(gTypeTable[i])

proc resetCaches* =
  ## XXX: fix that more properly
  initTypeTables()
  for i in low(gCanonicalTypes)..high(gCanonicalTypes):
    gCanonicalTypes[i] = nil

when false:
  proc echoStats*() =
    for i in countup(low(TTypeKind), high(TTypeKind)): 
      echo i, " ", gTypeTable[i].counter
  
proc getUniqueType*(key: PType): PType = 
  # this is a hotspot in the compiler!
  if key == nil: return 
  var k = key.kind
  case k
  of  tyBool, tyChar, 
      tyInt..tyUInt64:
    # no canonicalization for integral types, so that e.g. ``pid_t`` is
    # produced instead of ``NI``.
    result = key
  of  tyEmpty, tyNil, tyExpr, tyStmt, tyPointer, tyString, 
      tyCString, tyNone, tyBigNum:
    result = gCanonicalTypes[k]
    if result == nil:
      gCanonicalTypes[k] = key
      result = key
  of tyTypeDesc, tyTypeClass:
    internalError("value expected, but got a type")
  of tyGenericParam:
    internalError("GetUniqueType")
  of tyGenericInst, tyDistinct, tyOrdinal, tyMutable, tyConst, tyIter:
    result = getUniqueType(lastSon(key))
  of tyArrayConstr, tyGenericInvokation, tyGenericBody,
     tyOpenArray, tyArray, tySet, tyRange, tyTuple,
     tyPtr, tyRef, tySequence, tyForward, tyVarargs, tyProxy, tyVar:
    # tuples are quite horrible as C does not support them directly and
    # tuple[string, string] is a (strange) subtype of
    # tuple[nameA, nameB: string]. This bites us here, so we 
    # use 'sameBackendType' instead of 'sameType'.

    # we have to do a slow linear search because types may need
    # to be compared by their structure:
    if idTableHasObjectAsKey(gTypeTable[k], key): return key 
    for h in countup(0, high(gTypeTable[k].data)): 
      var t = PType(gTypeTable[k].data[h].key)
      if t != nil and sameBackendType(t, key): 
        return t
    idTablePut(gTypeTable[k], key, key)
    result = key
  of tyObject:
    if tfFromGeneric notin key.flags:
      # fast case; lookup per id suffices:
      result = PType(idTableGet(gTypeTable[k], key))
      if result == nil: 
        idTablePut(gTypeTable[k], key, key)
        result = key
    else:
      # ugly slow case: need to compare by structure
      if idTableHasObjectAsKey(gTypeTable[k], key): return key
      for h in countup(0, high(gTypeTable[k].data)): 
        var t = PType(gTypeTable[k].data[h].key)
        if t != nil and sameType(t, key): 
          return t
      idTablePut(gTypeTable[k], key, key)
      result = key
  of tyEnum:
    result = PType(idTableGet(gTypeTable[k], key))
    if result == nil: 
      idTablePut(gTypeTable[k], key, key)
      result = key
  of tyProc:
    # tyVar is not 100% correct, but would speeds things up a little:
    if key.callConv != ccClosure:
      result = key
    else:
      # ugh, we need the canon here:
      if idTableHasObjectAsKey(gTypeTable[k], key): return key 
      for h in countup(0, high(gTypeTable[k].data)): 
        var t = PType(gTypeTable[k].data[h].key)
        if t != nil and sameBackendType(t, key): 
          return t
      idTablePut(gTypeTable[k], key, key)
      result = key
      
proc tableGetType*(tab: TIdTable, key: PType): PObject = 
  # returns nil if we need to declare this type
  result = idTableGet(tab, key)
  if (result == nil) and (tab.counter > 0): 
    # we have to do a slow linear search because types may need
    # to be compared by their structure:
    for h in countup(0, high(tab.data)): 
      var t = PType(tab.data[h].key)
      if t != nil: 
        if sameType(t, key): 
          return tab.data[h].val

proc makeSingleLineCString*(s: String): String =
  result = "\""
  for c in items(s):
    result.add(c.toCChar)
  result.add('\"')

proc makeLLVMString*(s: String): PRope = 
  const MaxLineLength = 64
  result = nil
  var res = "c\""
  for i in countup(0, len(s) - 1): 
    if (i + 1) mod MaxLineLength == 0: 
      app(result, toRope(res))
      setLen(res, 0)
    case s[i]
    of '\0'..'\x1F', '\x80'..'\xFF', '\"', '\\': 
      add(res, '\\')
      add(res, toHex(ord(s[i]), 2))
    else: add(res, s[i])
  add(res, "\\00\"")
  app(result, toRope(res))

initTypeTables()
