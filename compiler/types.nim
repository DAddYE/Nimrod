#
#
#           The Nimrod Compiler
#        (c) Copyright 2013 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# this module contains routines for accessing and iterating over types

import 
  intsets, ast, astalgo, trees, msgs, strutils, platform

proc firstOrd*(t: PType): BiggestInt
proc lastOrd*(t: PType): BiggestInt
proc lengthOrd*(t: PType): BiggestInt
type 
  TPreferedDesc* = enum 
    preferName, preferDesc, preferExported

proc typeToString*(typ: PType, prefer: TPreferedDesc = preferName): String
proc getProcHeader*(sym: PSym): String
proc base*(t: PType): PType
  # ------------------- type iterator: ----------------------------------------
type 
  TTypeIter* = proc (t: PType, closure: PObject): Bool {.nimcall.} # true if iteration should stop
  TTypeMutator* = proc (t: PType, closure: PObject): PType {.nimcall.} # copy t and mutate it
  TTypePredicate* = proc (t: PType): Bool {.nimcall.}

proc iterOverType*(t: PType, iter: TTypeIter, closure: PObject): Bool
  # Returns result of `iter`.
proc mutateType*(t: PType, iter: TTypeMutator, closure: PObject): PType
  # Returns result of `iter`.

type 
  TParamsEquality* = enum     # they are equal, but their
                              # identifiers or their return
                              # type differ (i.e. they cannot be
                              # overloaded)
                              # this used to provide better error messages
    paramsNotEqual,           # parameters are not equal
    paramsEqual,              # parameters are equal
    paramsIncompatible

proc equalParams*(a, b: PNode): TParamsEquality
  # returns whether the parameter lists of the procs a, b are exactly the same
proc isOrdinalType*(t: PType): Bool
proc enumHasHoles*(t: PType): Bool
const 
  abstractPtrs* = {tyVar, tyPtr, tyRef, tyGenericInst, tyDistinct, tyOrdinal,
                   tyConst, tyMutable, tyTypeDesc}
  abstractVar* = {tyVar, tyGenericInst, tyDistinct, tyOrdinal,
                  tyConst, tyMutable, tyTypeDesc}
  abstractRange* = {tyGenericInst, tyRange, tyDistinct, tyOrdinal,
                    tyConst, tyMutable, tyTypeDesc}
  abstractVarRange* = {tyGenericInst, tyRange, tyVar, tyDistinct, tyOrdinal,
                       tyConst, tyMutable, tyTypeDesc}
  abstractInst* = {tyGenericInst, tyDistinct, tyConst, tyMutable, tyOrdinal,
                   tyTypeDesc}

  skipPtrs* = {tyVar, tyPtr, tyRef, tyGenericInst, tyConst, tyMutable, 
               tyTypeDesc}
  typedescPtrs* = abstractPtrs + {tyTypeDesc}
  typedescInst* = abstractInst + {tyTypeDesc}

proc skipTypes*(t: PType, kinds: TTypeKinds): PType
proc containsObject*(t: PType): Bool
proc containsGarbageCollectedRef*(typ: PType): Bool
proc containsHiddenPointer*(typ: PType): Bool
proc canFormAcycle*(typ: PType): Bool
proc isCompatibleToCString*(a: PType): Bool
proc getOrdValue*(n: PNode): BiggestInt
proc computeSize*(typ: PType): BiggestInt
proc getSize*(typ: PType): BiggestInt
proc isPureObject*(typ: PType): Bool
proc invalidGenericInst*(f: PType): Bool
  # for debugging
type 
  TTypeFieldResult* = enum 
    frNone,                   # type has no object type field 
    frHeader,                 # type has an object type field only in the header
    frEmbedded                # type has an object type field somewhere embedded

proc analyseObjectWithTypeField*(t: PType): TTypeFieldResult
  # this does a complex analysis whether a call to ``objectInit`` needs to be
  # made or intializing of the type field suffices or if there is no type field
  # at all in this type.
proc typeAllowed*(t: PType, kind: TSymKind): Bool
# implementation

proc invalidGenericInst(f: PType): bool = 
  result = (f.kind == tyGenericInst) and (lastSon(f) == nil)

proc isPureObject(typ: PType): bool = 
  var t = typ
  while t.kind == tyObject and t.sons[0] != nil: t = t.sons[0]
  result = t.sym != nil and sfPure in t.sym.flags

proc getOrdValue(n: PNode): biggestInt = 
  case n.kind
  of nkCharLit..nkInt64Lit: result = n.intVal
  of nkNilLit: result = 0
  of nkHiddenStdConv: result = getOrdValue(n.sons[1])
  else:
    localError(n.info, errOrdinalTypeExpected)
    result = 0

proc isIntLit*(t: PType): Bool {.inline.} =
  result = t.kind == tyInt and t.n != nil and t.n.kind == nkIntLit

proc isCompatibleToCString(a: PType): bool = 
  if a.kind == tyArray: 
    if (firstOrd(a.sons[0]) == 0) and
        (skipTypes(a.sons[0], {tyRange, tyConst, 
                               tyMutable, tyGenericInst}).kind in 
            {tyInt..tyInt64, tyUInt..tyUInt64}) and
        (a.sons[1].kind == tyChar): 
      result = true
  
proc getProcHeader(sym: PSym): string = 
  result = sym.owner.name.s & '.' & sym.name.s & '('
  var n = sym.typ.n
  for i in countup(1, sonsLen(n) - 1): 
    var p = n.sons[i]
    if p.kind == nkSym: 
      add(result, p.sym.name.s)
      add(result, ": ")
      add(result, typeToString(p.sym.typ))
      if i != sonsLen(n)-1: add(result, ", ")
    else:
      internalError("getProcHeader")
  add(result, ')')
  if n.sons[0].typ != nil: result.add(": " & typeToString(n.sons[0].typ))
  
proc elemType*(t: PType): PType = 
  assert(t != nil)
  case t.kind
  of tyGenericInst, tyDistinct: result = elemType(lastSon(t))
  of tyArray, tyArrayConstr: result = t.sons[1]
  else: result = t.sons[0]
  assert(result != nil)

proc skipGeneric(t: PType): PType = 
  result = t
  while result.kind == tyGenericInst: result = lastSon(result)
      
proc skipTypes(t: PType, kinds: TTypeKinds): PType = 
  result = t
  while result.kind in kinds: result = lastSon(result)
  
proc isOrdinalType(t: PType): bool =
  assert(t != nil)
  # caution: uint, uint64 are no ordinal types!
  result = t.Kind in {tyChar,tyInt..tyInt64,tyUInt8..tyUInt32,tyBool,tyEnum} or
      (t.Kind in {tyRange, tyOrdinal, tyConst, tyMutable, tyGenericInst}) and
       isOrdinalType(t.sons[0])

proc enumHasHoles(t: PType): bool = 
  var b = t
  while b.kind in {tyConst, tyMutable, tyRange, tyGenericInst}: b = b.sons[0]
  result = b.Kind == tyEnum and tfEnumHasHoles in b.flags

proc iterOverTypeAux(marker: var TIntSet, t: PType, iter: TTypeIter, 
                     closure: PObject): Bool
proc iterOverNode(marker: var TIntSet, n: PNode, iter: TTypeIter, 
                  closure: PObject): Bool = 
  if n != nil: 
    case n.kind
    of nkNone..nkNilLit: 
      # a leaf
      result = iterOverTypeAux(marker, n.typ, iter, closure)
    else: 
      for i in countup(0, sonsLen(n) - 1): 
        result = iterOverNode(marker, n.sons[i], iter, closure)
        if result: return 
  
proc iterOverTypeAux(marker: var TIntSet, t: PType, iter: TTypeIter, 
                     closure: PObject): bool = 
  result = false
  if t == nil: return 
  result = iter(t, closure)
  if result: return 
  if not containsOrIncl(marker, t.id): 
    case t.kind
    of tyGenericInst, tyGenericBody: 
      result = iterOverTypeAux(marker, lastSon(t), iter, closure)
    else: 
      for i in countup(0, sonsLen(t) - 1): 
        result = iterOverTypeAux(marker, t.sons[i], iter, closure)
        if result: return 
      if t.n != nil: result = iterOverNode(marker, t.n, iter, closure)
  
proc iterOverType(t: PType, iter: TTypeIter, closure: PObject): bool = 
  var marker = initIntSet()
  result = iterOverTypeAux(marker, t, iter, closure)

proc searchTypeForAux(t: PType, predicate: TTypePredicate, 
                      marker: var TIntSet): Bool

proc searchTypeNodeForAux(n: PNode, p: TTypePredicate, 
                          marker: var TIntSet): Bool = 
  result = false
  case n.kind
  of nkRecList: 
    for i in countup(0, sonsLen(n) - 1): 
      result = searchTypeNodeForAux(n.sons[i], p, marker)
      if result: return 
  of nkRecCase: 
    assert(n.sons[0].kind == nkSym)
    result = searchTypeNodeForAux(n.sons[0], p, marker)
    if result: return 
    for i in countup(1, sonsLen(n) - 1): 
      case n.sons[i].kind
      of nkOfBranch, nkElse: 
        result = searchTypeNodeForAux(lastSon(n.sons[i]), p, marker)
        if result: return 
      else: internalError("searchTypeNodeForAux(record case branch)")
  of nkSym: 
    result = searchTypeForAux(n.sym.typ, p, marker)
  else: internalError(n.info, "searchTypeNodeForAux()")
  
proc searchTypeForAux(t: PType, predicate: TTypePredicate, 
                      marker: var TIntSet): bool = 
  # iterates over VALUE types!
  result = false
  if t == nil: return 
  if containsOrIncl(marker, t.id): return 
  result = predicate(t)
  if result: return 
  case t.kind
  of tyObject: 
    result = searchTypeForAux(t.sons[0], predicate, marker)
    if not result: result = searchTypeNodeForAux(t.n, predicate, marker)
  of tyGenericInst, tyDistinct: 
    result = searchTypeForAux(lastSon(t), predicate, marker)
  of tyArray, tyArrayConstr, tySet, tyTuple: 
    for i in countup(0, sonsLen(t) - 1): 
      result = searchTypeForAux(t.sons[i], predicate, marker)
      if result: return 
  else: 
    nil

proc searchTypeFor(t: PType, predicate: TTypePredicate): Bool = 
  var marker = initIntSet()
  result = searchTypeForAux(t, predicate, marker)

proc isObjectPredicate(t: PType): Bool = 
  result = t.kind == tyObject

proc containsObject(t: PType): bool = 
  result = searchTypeFor(t, isObjectPredicate)

proc isObjectWithTypeFieldPredicate(t: PType): Bool = 
  result = t.kind == tyObject and t.sons[0] == nil and
      not (t.sym != nil and sfPure in t.sym.flags) and
      tfFinal notin t.flags

proc analyseObjectWithTypeFieldAux(t: PType, 
                                   marker: var TIntSet): TTypeFieldResult = 
  var res: TTypeFieldResult
  result = frNone
  if t == nil: return 
  case t.kind
  of tyObject: 
    if (t.n != nil): 
      if searchTypeNodeForAux(t.n, isObjectWithTypeFieldPredicate, marker): 
        return frEmbedded
    for i in countup(0, sonsLen(t) - 1): 
      res = analyseObjectWithTypeFieldAux(t.sons[i], marker)
      if res == frEmbedded: 
        return frEmbedded
      if res == frHeader: result = frHeader
    if result == frNone: 
      if isObjectWithTypeFieldPredicate(t): result = frHeader
  of tyGenericInst, tyDistinct, tyConst, tyMutable: 
    result = analyseObjectWithTypeFieldAux(lastSon(t), marker)
  of tyArray, tyArrayConstr, tyTuple: 
    for i in countup(0, sonsLen(t) - 1): 
      res = analyseObjectWithTypeFieldAux(t.sons[i], marker)
      if res != frNone: 
        return frEmbedded
  else: 
    nil

proc analyseObjectWithTypeField(t: PType): TTypeFieldResult = 
  var marker = initIntSet()
  result = analyseObjectWithTypeFieldAux(t, marker)

proc isGCRef(t: PType): Bool =
  result = t.kind in GcTypeKinds or
    (t.kind == tyProc and t.callConv == ccClosure)

proc containsGarbageCollectedRef(typ: PType): bool = 
  # returns true if typ contains a reference, sequence or string (all the
  # things that are garbage-collected)
  result = searchTypeFor(typ, isGCRef)

proc isTyRef(t: PType): Bool =
  result = t.kind == tyRef or (t.kind == tyProc and t.callConv == ccClosure)

proc containsTyRef*(typ: PType): Bool = 
  # returns true if typ contains a 'ref'
  result = searchTypeFor(typ, isTyRef)

proc isHiddenPointer(t: PType): Bool = 
  result = t.kind in {tyString, tySequence}

proc containsHiddenPointer(typ: PType): bool = 
  # returns true if typ contains a string, table or sequence (all the things
  # that need to be copied deeply)
  result = searchTypeFor(typ, isHiddenPointer)

proc canFormAcycleAux(marker: var TIntSet, typ: PType, startId: Int): Bool
proc canFormAcycleNode(marker: var TIntSet, n: PNode, startId: Int): Bool = 
  result = false
  if n != nil: 
    result = canFormAcycleAux(marker, n.typ, startId)
    if not result: 
      case n.kind
      of nkNone..nkNilLit: 
        nil
      else: 
        for i in countup(0, sonsLen(n) - 1): 
          result = canFormAcycleNode(marker, n.sons[i], startId)
          if result: return 
  
proc canFormAcycleAux(marker: var TIntSet, typ: PType, startId: int): bool = 
  result = false
  if typ == nil: return 
  if tfAcyclic in typ.flags: return 
  var t = skipTypes(typ, abstractInst-{tyTypeDesc})
  if tfAcyclic in t.flags: return 
  case t.kind
  of tyTuple, tyObject, tyRef, tySequence, tyArray, tyArrayConstr, tyOpenArray,
     tyVarargs:
    if not containsOrIncl(marker, t.id): 
      for i in countup(0, sonsLen(t) - 1): 
        result = canFormAcycleAux(marker, t.sons[i], startId)
        if result: return 
      if t.n != nil: result = canFormAcycleNode(marker, t.n, startId)
    else: 
      result = t.id == startId
    # Inheritance can introduce cyclic types, however this is not relevant
    # as the type that is passed to 'new' is statically known!
    #if t.kind == tyObject and tfFinal notin t.flags:
    #  # damn inheritance may introduce cycles:
    #  result = true
  of tyProc: result = typ.callConv == ccClosure
  else: nil

proc canFormAcycle(typ: PType): bool =
  var marker = initIntSet()
  result = canFormAcycleAux(marker, typ, typ.id)

proc mutateTypeAux(marker: var TIntSet, t: PType, iter: TTypeMutator, 
                   closure: PObject): PType
proc mutateNode(marker: var TIntSet, n: PNode, iter: TTypeMutator, 
                closure: PObject): PNode = 
  result = nil
  if n != nil: 
    result = copyNode(n)
    result.typ = mutateTypeAux(marker, n.typ, iter, closure)
    case n.kind
    of nkNone..nkNilLit: 
      # a leaf
    else: 
      for i in countup(0, sonsLen(n) - 1): 
        addSon(result, mutateNode(marker, n.sons[i], iter, closure))
  
proc mutateTypeAux(marker: var TIntSet, t: PType, iter: TTypeMutator, 
                   closure: PObject): PType = 
  result = nil
  if t == nil: return 
  result = iter(t, closure)
  if not containsOrIncl(marker, t.id): 
    for i in countup(0, sonsLen(t) - 1): 
      result.sons[i] = mutateTypeAux(marker, result.sons[i], iter, closure)
    if t.n != nil: result.n = mutateNode(marker, t.n, iter, closure)
  assert(result != nil)

proc mutateType(t: PType, iter: TTypeMutator, closure: PObject): PType = 
  var marker = initIntSet()
  result = mutateTypeAux(marker, t, iter, closure)

proc valueToString(a: PNode): String = 
  case a.kind
  of nkCharLit..nkUInt64Lit: result = $(a.intVal)
  of nkFloatLit..nkFloat128Lit: result = $(a.floatVal)
  of nkStrLit..nkTripleStrLit: result = a.strVal
  else: result = "<invalid value>"

proc rangeToStr(n: PNode): String = 
  assert(n.kind == nkRange)
  result = valueToString(n.sons[0]) & ".." & valueToString(n.sons[1])

const 
  typeToStr: Array[TTypeKind, String] = ["None", "bool", "Char", "empty", 
    "Array Constructor [$1]", "nil", "expr", "stmt", "typeDesc", 
    "GenericInvokation", "GenericBody", "GenericInst", "GenericParam", 
    "distinct $1", "enum", "ordinal[$1]", "array[$1, $2]", "object", "tuple", 
    "set[$1]", "range[$1]", "ptr ", "ref ", "var ", "seq[$1]", "proc", 
    "pointer", "OpenArray[$1]", "string", "CString", "Forward",
    "int", "int8", "int16", "int32", "int64",
    "float", "float32", "float64", "float128",
    "uint", "uint8", "uint16", "uint32", "uint64",
    "bignum", "const ",
    "!", "varargs[$1]", "iter[$1]", "Error Type", "TypeClass"]

proc consToStr(t: PType): String =
  if t.len > 0: result = t.typeToString
  else: result = typeToStr[t.kind].strip

proc constraintsToStr(t: PType): String =
  let sep = if tfAny in t.flags: " or " else: " and "
  result = ""
  for i in countup(0, t.len - 1):
    if i > 0: result.add(sep)
    result.add(t.sons[i].consToStr)

proc typeToString(typ: PType, prefer: TPreferedDesc = preferName): string = 
  var t = typ
  result = ""
  if t == nil: return 
  if prefer == preferName and t.sym != nil and sfAnon notin t.sym.flags:
    if t.kind == tyInt and isIntLit(t):
      return t.sym.Name.s & " literal(" & $t.n.intVal & ")"
    return t.sym.Name.s
  case t.Kind
  of tyInt:
    if not isIntLit(t) or prefer == preferExported:
      result = typeToStr[t.kind]
    else:
      result = "int literal(" & $t.n.intVal & ")"
  of tyGenericBody, tyGenericInst, tyGenericInvokation:
    result = typeToString(t.sons[0]) & '['
    for i in countup(1, sonsLen(t) -1 -ord(t.kind != tyGenericInvokation)):
      if i > 1: add(result, ", ")
      add(result, typeToString(t.sons[i]))
    add(result, ']')
  of tyTypeDesc:
    if t.len == 0: result = "typedesc"
    else: result = "typedesc[" & constraintsToStr(t) & "]"
  of tyTypeClass:
    case t.len
    of 0: result = "typeclass[]"
    of 1: result = "typeclass[" & consToStr(t.sons[0]) & "]"
    else: result = constraintsToStr(t)
  of tyExpr:
    if t.len == 0: result = "expr"
    else: result = "expr[" & constraintsToStr(t) & "]"
  of tyArray: 
    if t.sons[0].kind == tyRange: 
      result = "array[" & rangeToStr(t.sons[0].n) & ", " &
          typeToString(t.sons[1]) & ']'
    else: 
      result = "array[" & typeToString(t.sons[0]) & ", " &
          typeToString(t.sons[1]) & ']'
  of tyArrayConstr: 
    result = "Array constructor[" & rangeToStr(t.sons[0].n) & ", " &
        typeToString(t.sons[1]) & ']'
  of tySequence: 
    result = "seq[" & typeToString(t.sons[0]) & ']'
  of tyOrdinal: 
    result = "ordinal[" & typeToString(t.sons[0]) & ']'
  of tySet: 
    result = "set[" & typeToString(t.sons[0]) & ']'
  of tyOpenArray: 
    result = "openarray[" & typeToString(t.sons[0]) & ']'
  of tyDistinct: 
    result = "distinct " & typeToString(t.sons[0], preferName)
  of tyTuple: 
    # we iterate over t.sons here, because t.n may be nil
    result = "tuple["
    if t.n != nil: 
      assert(sonsLen(t.n) == sonsLen(t))
      for i in countup(0, sonsLen(t.n) - 1): 
        assert(t.n.sons[i].kind == nkSym)
        add(result, t.n.sons[i].sym.name.s & ": " & typeToString(t.sons[i]))
        if i < sonsLen(t.n) - 1: add(result, ", ")
    else: 
      for i in countup(0, sonsLen(t) - 1): 
        add(result, typeToString(t.sons[i]))
        if i < sonsLen(t) - 1: add(result, ", ")
    add(result, ']')
  of tyPtr, tyRef, tyVar, tyMutable, tyConst: 
    result = typeToStr[t.kind] & typeToString(t.sons[0])
  of tyRange:
    result = "range " & rangeToStr(t.n)
    if prefer != preferExported:
      result.add("(" & typeToString(t.sons[0]) & ")")
  of tyProc:
    result = if tfIterator in t.flags: "iterator (" else: "proc ("
    for i in countup(1, sonsLen(t) - 1): 
      add(result, typeToString(t.sons[i]))
      if i < sonsLen(t) - 1: add(result, ", ")
    add(result, ')')
    if t.sons[0] != nil: add(result, ": " & typeToString(t.sons[0]))
    var prag: String
    if t.callConv != ccDefault: prag = CallingConvToStr[t.callConv]
    else: prag = ""
    if tfNoSideEffect in t.flags: 
      addSep(prag)
      add(prag, "noSideEffect")
    if tfThread in t.flags:
      addSep(prag)
      add(prag, "thread")
    if len(prag) != 0: add(result, "{." & prag & ".}")
  of tyVarargs, tyIter:
    result = typeToStr[t.kind] % typeToString(t.sons[0])
  else: 
    result = typeToStr[t.kind]
  if tfShared in t.flags: result = "shared " & result
  if tfNotNil in t.flags: result.add(" not nil")

proc resultType(t: PType): PType = 
  assert(t.kind == tyProc)
  result = t.sons[0]          # nil is allowed
  
proc base(t: PType): PType = 
  result = t.sons[0]

proc firstOrd(t: PType): biggestInt = 
  case t.kind
  of tyBool, tyChar, tySequence, tyOpenArray, tyString, tyVarargs, tyProxy:
    result = 0
  of tySet, tyVar: result = firstOrd(t.sons[0])
  of tyArray, tyArrayConstr: result = firstOrd(t.sons[0])
  of tyRange: 
    assert(t.n != nil)        # range directly given:
    assert(t.n.kind == nkRange)
    result = getOrdValue(t.n.sons[0])
  of tyInt: 
    if platform.intSize == 4: result = - (2147483646) - 2
    else: result = 0x8000000000000000'i64
  of tyInt8: result = - 128
  of tyInt16: result = - 32768
  of tyInt32: result = - 2147483646 - 2
  of tyInt64: result = 0x8000000000000000'i64
  of tyUInt..tyUInt64: result = 0
  of tyEnum: 
    # if basetype <> nil then return firstOrd of basetype
    if (sonsLen(t) > 0) and (t.sons[0] != nil): 
      result = firstOrd(t.sons[0])
    else: 
      assert(t.n.sons[0].kind == nkSym)
      result = t.n.sons[0].sym.position
  of tyGenericInst, tyDistinct, tyConst, tyMutable, tyTypeDesc:
    result = firstOrd(lastSon(t))
  else: 
    internalError("invalid kind for first(" & $t.kind & ')')
    result = 0

proc lastOrd(t: PType): biggestInt = 
  case t.kind
  of tyBool: result = 1
  of tyChar: result = 255
  of tySet, tyVar: result = lastOrd(t.sons[0])
  of tyArray, tyArrayConstr: result = lastOrd(t.sons[0])
  of tyRange: 
    assert(t.n != nil)        # range directly given:
    assert(t.n.kind == nkRange)
    result = getOrdValue(t.n.sons[1])
  of tyInt: 
    if platform.intSize == 4: result = 0x7FFFFFFF
    else: result = 0x7FFFFFFFFFFFFFFF'i64
  of tyInt8: result = 0x0000007F
  of tyInt16: result = 0x00007FFF
  of tyInt32: result = 0x7FFFFFFF
  of tyInt64: result = 0x7FFFFFFFFFFFFFFF'i64
  of tyUInt: 
    if platform.intSize == 4: result = 0xFFFFFFFF
    else: result = 0x7FFFFFFFFFFFFFFF'i64
  of tyUInt8: result = 0xFF
  of tyUInt16: result = 0xFFFF
  of tyUInt32: result = 0xFFFFFFFF
  of tyUInt64: result = 0x7FFFFFFFFFFFFFFF'i64
  of tyEnum: 
    assert(t.n.sons[sonsLen(t.n) - 1].kind == nkSym)
    result = t.n.sons[sonsLen(t.n) - 1].sym.position
  of tyGenericInst, tyDistinct, tyConst, tyMutable, tyTypeDesc: 
    result = lastOrd(lastSon(t))
  of tyProxy: result = 0
  else: 
    internalError("invalid kind for last(" & $t.kind & ')')
    result = 0

proc lengthOrd(t: PType): biggestInt = 
  case t.kind
  of tyInt64, tyInt32, tyInt: result = lastOrd(t)
  of tyDistinct, tyConst, tyMutable: result = lengthOrd(t.sons[0])
  else: result = lastOrd(t) - firstOrd(t) + 1

# -------------- type equality -----------------------------------------------

type
  TDistinctCompare* = enum ## how distinct types are to be compared
    dcEq,                  ## a and b should be the same type
    dcEqIgnoreDistinct,    ## compare symetrically: (distinct a) == b, a == b
                           ## or a == (distinct b)
    dcEqOrDistinctOf       ## a equals b or a is distinct of b

  TTypeCmpFlag* = enum
    IgnoreTupleFields,
    TypeDescExactMatch,
    AllowCommonBase

  TTypeCmpFlags* = Set[TTypeCmpFlag]

  TSameTypeClosure = object {.pure.}
    cmp: TDistinctCompare
    recCheck: Int
    flags: TTypeCmpFlags
    s: Seq[tuple[a,b: Int]] # seq for a set as it's hopefully faster
                            # (few elements expected)

proc initSameTypeClosure: TSameTypeClosure =
  # we do the initialization lazily for performance (avoids memory allocations)
  nil

proc containsOrIncl(c: var TSameTypeClosure, a, b: PType): Bool =
  result = not isNil(c.s) and c.s.contains((a.id, b.id))
  if not result:
    if isNil(c.s): c.s = @[]
    c.s.add((a.id, b.id))

proc sameTypeAux(x, y: PType, c: var TSameTypeClosure): Bool
proc sameTypeOrNilAux(a, b: PType, c: var TSameTypeClosure): Bool =
  if a == b:
    result = true
  else:
    if a == nil or b == nil: result = false
    else: result = sameTypeAux(a, b, c)

proc sameTypeOrNil*(a, b: PType, flags: TTypeCmpFlags = {}): Bool =
  if a == b:
    result = true
  else: 
    if a == nil or b == nil: result = false
    else:
      var c = initSameTypeClosure()
      c.flags = flags
      result = sameTypeAux(a, b, c)

proc equalParam(a, b: PSym): TParamsEquality = 
  if sameTypeOrNil(a.typ, b.typ, {TypeDescExactMatch}) and
      exprStructuralEquivalent(a.constraint, b.constraint):
    if a.ast == b.ast: 
      result = paramsEqual
    elif a.ast != nil and b.ast != nil: 
      if exprStructuralEquivalent(a.ast, b.ast): result = paramsEqual
      else: result = paramsIncompatible
    elif a.ast != nil: 
      result = paramsEqual
    elif b.ast != nil: 
      result = paramsIncompatible
  else:
    result = paramsNotEqual
  
proc equalParams(a, b: PNode): TParamsEquality = 
  result = paramsEqual
  var length = sonsLen(a)
  if length != sonsLen(b): 
    result = paramsNotEqual
  else: 
    for i in countup(1, length - 1): 
      var m = a.sons[i].sym
      var n = b.sons[i].sym
      assert((m.kind == skParam) and (n.kind == skParam))
      case equalParam(m, n)
      of paramsNotEqual: 
        return paramsNotEqual
      of paramsEqual: 
        nil
      of paramsIncompatible: 
        result = paramsIncompatible
      if (m.name.id != n.name.id): 
        # BUGFIX
        return paramsNotEqual # paramsIncompatible;
      # continue traversal! If not equal, we can return immediately; else
      # it stays incompatible
    if not sameTypeOrNil(a.sons[0].typ, b.sons[0].typ, {TypeDescExactMatch}):
      if (a.sons[0].typ == nil) or (b.sons[0].typ == nil): 
        result = paramsNotEqual # one proc has a result, the other not is OK
      else: 
        result = paramsIncompatible # overloading by different
                                    # result types does not work
  
proc sameLiteral(x, y: PNode): Bool = 
  if x.kind == y.kind: 
    case x.kind
    of nkCharLit..nkInt64Lit: result = x.intVal == y.intVal
    of nkFloatLit..nkFloat64Lit: result = x.floatVal == y.floatVal
    of nkNilLit: result = true
    else: assert(false)
  
proc sameRanges(a, b: PNode): Bool = 
  result = sameLiteral(a.sons[0], b.sons[0]) and
           sameLiteral(a.sons[1], b.sons[1])

proc sameTuple(a, b: PType, c: var TSameTypeClosure): Bool = 
  # two tuples are equivalent iff the names, types and positions are the same;
  # however, both types may not have any field names (t.n may be nil) which
  # complicates the matter a bit.
  if sonsLen(a) == sonsLen(b): 
    result = true
    for i in countup(0, sonsLen(a) - 1): 
      var x = a.sons[i]
      var y = b.sons[i]
      if IgnoreTupleFields in c.flags:
        x = skipTypes(x, {tyRange})
        y = skipTypes(y, {tyRange})
      
      result = sameTypeAux(x, y, c)
      if not result: return 
    if a.n != nil and b.n != nil and IgnoreTupleFields notin c.flags:
      for i in countup(0, sonsLen(a.n) - 1): 
        # check field names: 
        if a.n.sons[i].kind == nkSym and b.n.sons[i].kind == nkSym:
          var x = a.n.sons[i].sym
          var y = b.n.sons[i].sym
          result = x.name.id == y.name.id
          if not result: break 
        else: internalError(a.n.info, "sameTuple")
  else:
    result = false

template ifFastObjectTypeCheckFailed(a, b: PType, body: Stmt) {.immediate.} =
  if tfFromGeneric notin a.flags + b.flags:
    # fast case: id comparison suffices:
    result = a.id == b.id
  else:
    # expensive structural equality test; however due to the way generic and
    # objects work, if one of the types does **not** contain tfFromGeneric,
    # they cannot be equal. The check ``a.sym.Id == b.sym.Id`` checks
    # for the same origin and is essential because we don't want "pure" 
    # structural type equivalence:
    #
    # type
    #   TA[T] = object
    #   TB[T] = object
    # --> TA[int] != TB[int]
    if tfFromGeneric in a.flags * b.flags and a.sym.Id == b.sym.Id:
      # ok, we need the expensive structural check
      body

proc sameObjectTypes*(a, b: PType): Bool =
  # specialized for efficiency (sigmatch uses it)
  IfFastObjectTypeCheckFailed(a, b):
    var c = initSameTypeClosure()
    result = sameTypeAux(a, b, c)

proc sameDistinctTypes*(a, b: PType): Bool {.inline.} =
  result = sameObjectTypes(a, b)

proc sameEnumTypes*(a, b: PType): Bool {.inline.} =
  result = a.id == b.id

proc sameObjectTree(a, b: PNode, c: var TSameTypeClosure): Bool =
  if a == b:
    result = true
  elif (a != nil) and (b != nil) and (a.kind == b.kind):
    if sameTypeOrNilAux(a.typ, b.typ, c):
      case a.kind
      of nkSym:
        # same symbol as string is enough:
        result = a.sym.name.id == b.sym.name.id
      of nkIdent: result = a.ident.id == b.ident.id
      of nkCharLit..nkInt64Lit: result = a.intVal == b.intVal
      of nkFloatLit..nkFloat64Lit: result = a.floatVal == b.floatVal
      of nkStrLit..nkTripleStrLit: result = a.strVal == b.strVal
      of nkEmpty, nkNilLit, nkType: result = true
      else:
        if sonsLen(a) == sonsLen(b): 
          for i in countup(0, sonsLen(a) - 1): 
            if not sameObjectTree(a.sons[i], b.sons[i], c): return 
          result = true

proc sameObjectStructures(a, b: PType, c: var TSameTypeClosure): Bool =
  # check base types:
  if sonsLen(a) != sonsLen(b): return
  for i in countup(0, sonsLen(a) - 1):
    if not sameTypeOrNilAux(a.sons[i], b.sons[i], c): return
  if not sameObjectTree(a.n, b.n, c): return
  result = true

proc sameChildrenAux(a, b: PType, c: var TSameTypeClosure): Bool =
  if sonsLen(a) != sonsLen(b): return false
  result = true
  for i in countup(0, sonsLen(a) - 1):
    result = sameTypeOrNilAux(a.sons[i], b.sons[i], c)
    if not result: return 

proc sameTypeAux(x, y: PType, c: var TSameTypeClosure): bool =
  template cycleCheck() =
    # believe it or not, the direct check for ``containsOrIncl(c, a, b)``
    # increases bootstrapping time from 2.4s to 3.3s on my laptop! So we cheat
    # again: Since the recursion check is only to not get caught in an endless
    # recursion, we use a counter and only if it's value is over some 
    # threshold we perform the expensive exact cycle check:
    if c.recCheck < 3:
      inc c.recCheck
    else:
      if containsOrIncl(c, a, b): return true

  proc sameFlags(a, b: PType): Bool {.inline.} =
    result = eqTypeFlags*a.flags == eqTypeFlags*b.flags
    
  if x == y: return true
  var a = skipTypes(x, {tyGenericInst})
  var b = skipTypes(y, {tyGenericInst})
  assert(a != nil)
  assert(b != nil)
  if a.kind != b.kind:
    case c.cmp
    of dcEq: return false
    of dcEqIgnoreDistinct:
      while a.kind == tyDistinct: a = a.sons[0]
      while b.kind == tyDistinct: b = b.sons[0]
      if a.kind != b.kind: return false
    of dcEqOrDistinctOf:
      while a.kind == tyDistinct: a = a.sons[0]
      if a.kind != b.kind: return false
  case a.Kind
  of tyEmpty, tyChar, tyBool, tyNil, tyPointer, tyString, tyCString,
     tyInt..tyBigNum, tyStmt:
    result = sameFlags(a, b)
  of tyExpr:
    result = exprStructuralEquivalent(a.n, b.n) and sameFlags(a, b)
  of tyObject:
    IfFastObjectTypeCheckFailed(a, b):
      CycleCheck()
      result = sameObjectStructures(a, b, c) and sameFlags(a, b)
  of tyDistinct:
    CycleCheck()
    if c.cmp == dcEq: result = sameDistinctTypes(a, b) and sameFlags(a, b)
    else: result = sameTypeAux(a.sons[0], b.sons[0], c) and sameFlags(a, b)
  of tyEnum, tyForward, tyProxy:
    # XXX generic enums do not make much sense, but require structural checking
    result = a.id == b.id and sameFlags(a, b)
  of tyTuple:
    CycleCheck()
    result = sameTuple(a, b, c) and sameFlags(a, b)
  of tyGenericInst:
    result = sameTypeAux(lastSon(a), lastSon(b), c)
  of tyTypeDesc:
    if c.cmp == dcEqIgnoreDistinct: result = false
    elif TypeDescExactMatch in c.flags:
      CycleCheck()
      result = sameChildrenAux(x, y, c) and sameFlags(a, b)
    else:
      result = sameFlags(a, b)
  of tyGenericParam, tyGenericInvokation, tyGenericBody, tySequence,
     tyOpenArray, tySet, tyRef, tyPtr, tyVar, tyArrayConstr,
     tyArray, tyProc, tyConst, tyMutable, tyVarargs, tyIter,
     tyOrdinal, tyTypeClass:
    CycleCheck()
    result = sameChildrenAux(a, b, c) and sameFlags(a, b)
    if result and (a.kind == tyProc):
      result = a.callConv == b.callConv
  of tyRange:
    CycleCheck()
    result = sameTypeOrNilAux(a.sons[0], b.sons[0], c) and
        sameValue(a.n.sons[0], b.n.sons[0]) and
        sameValue(a.n.sons[1], b.n.sons[1])
  of tyNone: result = false

proc sameType*(x, y: PType): Bool =
  var c = initSameTypeClosure()
  result = sameTypeAux(x, y, c)

proc sameBackendType*(x, y: PType): Bool =
  var c = initSameTypeClosure()
  c.flags.incl IgnoreTupleFields
  result = sameTypeAux(x, y, c)
  
proc compareTypes*(x, y: PType,
                   cmp: TDistinctCompare = dcEq,
                   flags: TTypeCmpFlags = {}): Bool =
  ## compares two type for equality (modulo type distinction)
  var c = initSameTypeClosure()
  c.cmp = cmp
  c.flags = flags
  result = sameTypeAux(x, y, c)
  
proc inheritanceDiff*(a, b: PType): Int = 
  # | returns: 0 iff `a` == `b`
  # | returns: -x iff `a` is the x'th direct superclass of `b`
  # | returns: +x iff `a` is the x'th direct subclass of `b`
  # | returns: `maxint` iff `a` and `b` are not compatible at all
  assert a.kind == tyObject
  assert b.kind == tyObject
  var x = a
  result = 0
  while x != nil:
    x = skipTypes(x, skipPtrs)
    if sameObjectTypes(x, b): return 
    x = x.sons[0]
    dec(result)
  var y = b
  result = 0
  while y != nil:
    y = skipTypes(y, skipPtrs)
    if sameObjectTypes(y, a): return 
    y = y.sons[0]
    inc(result)
  result = high(Int)

proc commonSuperclass*(a, b: PType): PType =
  # quick check: are they the same?
  if sameObjectTypes(a, b): return a

  # simple algorithm: we store all ancestors of 'a' in a ID-set and walk 'b'
  # up until the ID is found:
  assert a.kind == tyObject
  assert b.kind == tyObject
  var x = a
  var ancestors = initIntSet()
  while x != nil:
    x = skipTypes(x, skipPtrs)
    ancestors.incl(x.id)
    x = x.sons[0]
  var y = b
  while y != nil:
    y = skipTypes(y, skipPtrs)
    if ancestors.contains(y.id): return y
    y = y.sons[0]

proc typeAllowedAux(marker: var TIntSet, typ: PType, kind: TSymKind): Bool
proc typeAllowedNode(marker: var TIntSet, n: PNode, kind: TSymKind): Bool = 
  result = true
  if n != nil: 
    result = typeAllowedAux(marker, n.typ, kind)
    #if not result: debug(n.typ)
    if result: 
      case n.kind
      of nkNone..nkNilLit: 
        nil
      else: 
        for i in countup(0, sonsLen(n) - 1): 
          result = typeAllowedNode(marker, n.sons[i], kind)
          if not result: break

proc matchType*(a: PType, pattern: Openarray[tuple[k:TTypeKind, i:Int]],
                last: TTypeKind): Bool =
  var a = a
  for k, i in pattern.items:
    if a.kind != k: return false
    if i >= a.sonsLen or a.sons[i] == nil: return false
    a = a.sons[i]
  result = a.kind == last

proc isGenericAlias*(t: PType): Bool =
  return t.kind == tyGenericInst and t.lastSon.kind == tyGenericInst

proc skipGenericAlias*(t: PType): PType =
  return if t.isGenericAlias: t.lastSon else: t

proc matchTypeClass*(bindings: var TIdTable, typeClass, t: PType): Bool =
  for i in countup(0, typeClass.sonsLen - 1):
    let req = typeClass.sons[i]
    var match = req.kind == skipTypes(t, {tyGenericInst, tyRange}).kind or
                req.kind == skipTypes(t, {tyGenericInst}).kind
    if not match:
      case req.kind
      of tyGenericBody:
        if t.kind == tyGenericInst and t.sons[0] == req:
          match = true
          idTablePut(bindings, typeClass, t)
      of tyTypeClass:
        match = matchTypeClass(bindings, req, t)
      else: nil
    elif t.kind in {tyObject} and req.len != 0:
      # empty 'object' is fine as constraint in a type class
      match = sameType(t, req)

    if tfAny in typeClass.flags:
      if match: return true
    else:
      if not match: return false

  # if the loop finished without returning, either all constraints matched
  # or none of them matched.
  result = if tfAny in typeClass.flags: false else: true

proc matchTypeClass*(typeClass, typ: PType): Bool =
  var bindings: TIdTable
  initIdTable(bindings)
  result = matchTypeClass(bindings, typeClass, typ)

proc typeAllowedAux(marker: var TIntSet, typ: PType, kind: TSymKind): bool =
  assert(kind in {skVar, skLet, skConst, skParam, skResult})
  # if we have already checked the type, return true, because we stop the
  # evaluation if something is wrong:
  result = true
  if typ == nil: return
  if containsOrIncl(marker, typ.id): return 
  var t = skipTypes(typ, abstractInst-{tyTypeDesc})
  case t.kind
  of tyVar:
    if kind == skConst: return false
    var t2 = skipTypes(t.sons[0], abstractInst-{tyTypeDesc})
    case t2.kind
    of tyVar: 
      result = false          # ``var var`` is always an invalid type:
    of tyOpenArray: 
      result = kind == skParam and typeAllowedAux(marker, t2, kind)
    else:
      result = kind in {skParam, skResult} and typeAllowedAux(marker, t2, kind)
  of tyProc: 
    for i in countup(1, sonsLen(t) - 1): 
      result = typeAllowedAux(marker, t.sons[i], skParam)
      if not result: break 
    if result and t.sons[0] != nil:
      result = typeAllowedAux(marker, t.sons[0], skResult)
  of tyExpr, tyStmt, tyTypeDesc:
    result = true
    # XXX er ... no? these should not be allowed!
  of tyTypeClass:
    result = true
  of tyGenericBody, tyGenericParam, tyForward, tyNone, tyGenericInvokation:
    result = false
  of tyEmpty, tyNil:
    result = kind == skConst
  of tyString, tyBool, tyChar, tyEnum, tyInt..tyBigNum, tyCString, tyPointer: 
    result = true
  of tyOrdinal: 
    result = kind == skParam
  of tyGenericInst, tyDistinct: 
    result = typeAllowedAux(marker, lastSon(t), kind)
  of tyRange:
    result = skipTypes(t.sons[0], abstractInst-{tyTypeDesc}).kind in
        {tyChar, tyEnum, tyInt..tyUInt64}
  of tyOpenArray, tyVarargs: 
    result = (kind == skParam) and typeAllowedAux(marker, t.sons[0], skVar)
  of tySequence: 
    result = t.sons[0].kind == tyEmpty or 
        typeAllowedAux(marker, t.sons[0], skVar)
  of tyArray:
    result = t.sons[1].kind == tyEmpty or
        typeAllowedAux(marker, t.sons[1], skVar)
  of tyRef:
    if kind == skConst: return false
    result = typeAllowedAux(marker, t.sons[0], skVar)
  of tyPtr:
    result = typeAllowedAux(marker, t.sons[0], skVar)
  of tyArrayConstr, tyTuple, tySet, tyConst, tyMutable, tyIter:
    for i in countup(0, sonsLen(t) - 1):
      result = typeAllowedAux(marker, t.sons[i], kind)
      if not result: break
  of tyObject:
    if kind == skConst: return false
    for i in countup(0, sonsLen(t) - 1): 
      result = typeAllowedAux(marker, t.sons[i], kind)
      if not result: break
    if result and t.n != nil: result = typeAllowedNode(marker, t.n, kind)
  of tyProxy:
    # for now same as error node; we say it's a valid type as it should
    # prevent cascading errors:
    result = true
    
proc typeAllowed(t: PType, kind: TSymKind): bool = 
  var marker = initIntSet()
  result = typeAllowedAux(marker, t, kind)

proc align(address, alignment: BiggestInt): BiggestInt = 
  result = (address + (alignment - 1)) and not (alignment - 1)

proc computeSizeAux(typ: PType, a: var BiggestInt): BiggestInt
proc computeRecSizeAux(n: PNode, a, currOffset: var BiggestInt): BiggestInt = 
  var maxAlign, maxSize, b, res: BiggestInt
  case n.kind
  of nkRecCase: 
    assert(n.sons[0].kind == nkSym)
    result = computeRecSizeAux(n.sons[0], a, currOffset)
    maxSize = 0
    maxAlign = 1
    for i in countup(1, sonsLen(n) - 1): 
      case n.sons[i].kind
      of nkOfBranch, nkElse: 
        res = computeRecSizeAux(lastSon(n.sons[i]), b, currOffset)
        if res < 0: return res
        maxSize = max(maxSize, res)
        maxAlign = max(maxAlign, b)
      else: internalError("computeRecSizeAux(record case branch)")
    currOffset = align(currOffset, maxAlign) + maxSize
    result = align(result, maxAlign) + maxSize
    a = maxAlign
  of nkRecList: 
    result = 0
    maxAlign = 1
    for i in countup(0, sonsLen(n) - 1): 
      res = computeRecSizeAux(n.sons[i], b, currOffset)
      if res < 0: return res
      currOffset = align(currOffset, b) + res
      result = align(result, b) + res
      if b > maxAlign: maxAlign = b
    a = maxAlign
  of nkSym: 
    result = computeSizeAux(n.sym.typ, a)
    n.sym.offset = Int(currOffset)
  else: 
    internalError("computeRecSizeAux()")
    a = 1
    result = - 1

proc computeSizeAux(typ: PType, a: var biggestInt): biggestInt = 
  var res, maxAlign, length, currOffset: BiggestInt
  if typ.size == - 2: 
    # we are already computing the size of the type
    # --> illegal recursion in type
    return - 2
  if typ.size >= 0: 
    # size already computed
    result = typ.size
    a = typ.align
    return 
  typ.size = - 2              # mark as being computed
  case typ.kind
  of tyInt, tyUInt: 
    result = intSize
    a = result
  of tyInt8, tyUInt8, tyBool, tyChar: 
    result = 1
    a = result
  of tyInt16, tyUInt16: 
    result = 2
    a = result
  of tyInt32, tyUInt32, tyFloat32: 
    result = 4
    a = result
  of tyInt64, tyUInt64, tyFloat64: 
    result = 8
    a = result
  of tyFloat128:
    result = 16
    a = result
  of tyFloat: 
    result = floatSize
    a = result
  of tyProc: 
    if typ.callConv == ccClosure: result = 2 * ptrSize
    else: result = ptrSize
    a = ptrSize
  of tyNil, tyCString, tyString, tySequence, tyPtr, tyRef, tyVar, tyOpenArray,
     tyBigNum: 
    result = ptrSize
    a = result
  of tyArray, tyArrayConstr: 
    result = lengthOrd(typ.sons[0]) * computeSizeAux(typ.sons[1], a)
  of tyEnum: 
    if firstOrd(typ) < 0: 
      result = 4              # use signed int32
    else: 
      length = lastOrd(typ)   # BUGFIX: use lastOrd!
      if length + 1 < `shl`(1, 8): result = 1
      elif length + 1 < `shl`(1, 16): result = 2
      elif length + 1 < `shl`(biggestInt(1), 32): result = 4
      else: result = 8
    a = result
  of tySet: 
    length = lengthOrd(typ.sons[0])
    if length <= 8: result = 1
    elif length <= 16: result = 2
    elif length <= 32: result = 4
    elif length <= 64: result = 8
    elif align(length, 8) mod 8 == 0: result = align(length, 8) div 8
    else: result = align(length, 8) div 8 + 1
    a = result
  of tyRange: 
    result = computeSizeAux(typ.sons[0], a)
  of tyTuple: 
    result = 0
    maxAlign = 1
    for i in countup(0, sonsLen(typ) - 1): 
      res = computeSizeAux(typ.sons[i], a)
      if res < 0: return res
      maxAlign = max(maxAlign, a)
      result = align(result, a) + res
    result = align(result, maxAlign)
    a = maxAlign
  of tyObject: 
    if typ.sons[0] != nil: 
      result = computeSizeAux(typ.sons[0], a)
      if result < 0: return 
      maxAlign = a
    elif isObjectWithTypeFieldPredicate(typ): 
      result = intSize
      maxAlign = result
    else: 
      result = 0
      maxAlign = 1
    currOffset = result
    result = computeRecSizeAux(typ.n, a, currOffset)
    if result < 0: return 
    if a < maxAlign: a = maxAlign
    result = align(result, a)
  of tyGenericInst, tyDistinct, tyGenericBody, tyMutable, tyConst, tyIter:
    result = computeSizeAux(lastSon(typ), a)
  of tyTypeDesc:
    result = (if typ.len == 1: computeSizeAux(typ.sons[0], a) else: -1)
  of tyProxy: result = 1
  else:
    #internalError("computeSizeAux()")
    result = - 1
  typ.size = result
  typ.align = Int(a)

proc computeSize(typ: PType): biggestInt = 
  var a: BiggestInt = 1
  result = computeSizeAux(typ, a)

proc getReturnType*(s: PSym): PType =
  # Obtains the return type of a iterator/proc/macro/template
  assert s.kind in {skProc, skTemplate, skMacro, skIterator}
  result = s.typ.sons[0]

proc getSize(typ: PType): biggestInt = 
  result = computeSize(typ)
  if result < 0: internalError("getSize: " & $typ.kind)

  
proc containsGenericTypeIter(t: PType, closure: PObject): Bool = 
  result = t.kind in GenericTypes

proc containsGenericType*(t: PType): Bool = 
  result = iterOverType(t, containsGenericTypeIter, nil)

proc baseOfDistinct*(t: PType): PType =
  if t.kind == tyDistinct:
    result = t.sons[0]
  else:
    result = copyType(t, t.owner, false)
    var parent: PType = nil
    var it = result
    while it.kind in {tyPtr, tyRef}:
      parent = it
      it = it.sons[0]
    if it.kind == tyDistinct:
      internalAssert parent != nil
      parent.sons[0] = it.sons[0]

proc safeInheritanceDiff*(a, b: PType): Int =
  # same as inheritanceDiff but checks for tyError:
  if a.kind == tyError or b.kind == tyError: 
    result = -1
  else:
    result = inheritanceDiff(a, b)

proc compatibleEffectsAux(se, re: PNode): Bool =
  if re.isNil: return false
  for r in items(re):
    block search:
      for s in items(se):
        if safeInheritanceDiff(r.typ, s.typ) <= 0:
          break search
      return false
  result = true

proc compatibleEffects*(formal, actual: PType): Bool =
  # for proc type compatibility checking:
  assert formal.kind == tyProc and actual.kind == tyProc
  InternalAssert formal.n.sons[0].kind == nkEffectList
  InternalAssert actual.n.sons[0].kind == nkEffectList
  
  var spec = formal.n.sons[0]
  if spec.len != 0:
    var real = actual.n.sons[0]

    let se = spec.sons[exceptionEffects]
    # if 'se.kind == nkArgList' it is no formal type really, but a
    # computed effect and as such no spec:
    # 'r.msgHandler = if isNil(msgHandler): defaultMsgHandler else: msgHandler'
    if not isNil(se) and se.kind != nkArgList:
      # spec requires some exception or tag, but we don't know anything:
      if real.len == 0: return false
      result = compatibleEffectsAux(se, real.sons[exceptionEffects])
      if not result: return

    let st = spec.sons[tagEffects]
    if not isNil(st) and st.kind != nkArgList:
      # spec requires some exception or tag, but we don't know anything:
      if real.len == 0: return false
      result = compatibleEffectsAux(st, real.sons[tagEffects])
      if not result: return
  result = true

proc isCompileTimeOnly*(t: PType): Bool {.inline.} =
  result = t.kind in {tyTypeDesc, tyExpr}

proc containsCompileTimeOnly*(t: PType): Bool =
  if isCompileTimeOnly(t): return true
  if t.sons != nil:
    for i in 0 .. <t.sonsLen:
      if t.sons[i] != nil and isCompileTimeOnly(t.sons[i]):
        return true
  return false
