#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This file implements the FFI part of the evaluator for Nimrod code.

import ast, astalgo, ropes, types, options, tables, dynlib, libffi, msgs

when defined(windows):
  const libcDll = "msvcrt.dll"
else:
  const libcDll = "libc.so(.6|.5|)"

type
  TDllCache = tables.TTable[String, TLibHandle]
var
  gDllCache = initTable[string, TLibHandle]()
  gExeHandle = loadLib()

proc getDll(cache: var TDllCache; dll: String; info: TLineInfo): Pointer =
  result = cache[dll]
  if result.isNil:
    var libs: Seq[String] = @[]
    libCandidates(dll, libs)
    for c in libs:
      result = loadLib(c)
      if not result.isNil: break
    if result.isNil:
      globalError(info, "cannot load: " & dll)
    cache[dll] = result

const
  nkPtrLit = nkIntLit # hopefully we can get rid of this hack soon

proc importcSymbol*(sym: PSym): PNode =
  let name = ropeToStr(sym.loc.r)
  
  # the AST does not support untyped pointers directly, so we use an nkIntLit
  # that contains the address instead:
  result = newNodeIT(nkPtrLit, sym.info, sym.typ)
  case name
  of "stdin":  result.intVal = cast[TAddress](system.stdin)
  of "stdout": result.intVal = cast[TAddress](system.stdout)
  of "stderr": result.intVal = cast[TAddress](system.stderr)
  else:
    let lib = sym.annex
    if lib != nil and lib.path.kind notin {nkStrLit..nkTripleStrLit}:
      globalError(sym.info, "dynlib needs to be a string lit for the REPL")
    var theAddr: Pointer
    if lib.isNil and not gExeHandle.isNil:
      # first try this exe itself:
      theAddr = gExeHandle.symAddr(name)
      # then try libc:
      if theAddr.isNil:
        let dllhandle = gDllCache.getDll(libcDll, sym.info)
        theAddr = dllhandle.checkedSymAddr(name)
    else:
      let dllhandle = gDllCache.getDll(lib.path.strVal, sym.info)
      theAddr = dllhandle.checkedSymAddr(name)
    result.intVal = cast[TAddress](theAddr)

proc mapType(t: ast.PType): ptr libffi.TType =
  if t == nil: return addr libffi.type_void
  
  case t.kind
  of tyBool, tyEnum, tyChar, tyInt..tyInt64, tyUInt..tyUInt64, tySet:
    case t.getSize
    of 1: result = addr libffi.type_uint8
    of 2: result = addr libffi.type_sint16
    of 4: result = addr libffi.type_sint32
    of 8: result = addr libffi.type_sint64
    else: result = nil
  of tyFloat, tyFloat64: result = addr libffi.type_double
  of tyFloat32: result = addr libffi.type_float
  of tyVar, tyPointer, tyPtr, tyRef, tyCString, tySequence, tyString, tyExpr,
     tyStmt, tyTypeDesc, tyProc, tyArray, tyArrayConstr, tyNil:
    result = addr libffi.type_pointer
  of tyDistinct:
    result = mapType(t.sons[0])
  else:
    result = nil
  # too risky:
  #of tyFloat128: result = addr libffi.type_longdouble

proc mapCallConv(cc: TCallingConvention, info: TLineInfo): TABI =
  case cc
  of ccDefault: result = DefaultAbi
  of ccStdCall: result = when defined(windows): STDCALL else: DefaultAbi
  of ccCDecl: result = DefaultAbi
  else:
    globalError(info, "cannot map calling convention to FFI")

template rd(T, p: Expr): Expr {.immediate.} = (cast[ptr t](p))[]
template wr(T, p, v: Expr) {.immediate.} = (cast[ptr t](p))[] = v
template `+!`(x, y: Expr): Expr {.immediate.} =
  cast[Pointer](cast[TAddress](x) + y)

proc packSize(v: PNode, typ: PType): Int =
  ## computes the size of the blob
  case typ.kind
  of tyPtr, tyRef, tyVar:
    if v.kind in {nkNilLit, nkPtrLit}:
      result = sizeof(Pointer)
    else:
      result = sizeof(Pointer) + packSize(v.sons[0], typ.sons[0])
  of tyDistinct, tyGenericInst:
    result = packSize(v, typ.sons[0])
  of tyArray, tyArrayConstr:
    # consider: ptr array[0..1000_000, int] which is common for interfacing;
    # we use the real length here instead
    if v.kind in {nkNilLit, nkPtrLit}:
      result = sizeof(Pointer)
    elif v.len != 0:
      result = v.len * packSize(v.sons[0], typ.sons[1])
  else:
    result = typ.getSize.Int

proc pack(v: PNode, typ: PType, res: Pointer)

proc getField(n: PNode; position: Int): PSym =
  case n.kind
  of nkRecList:
    for i in countup(0, sonsLen(n) - 1):
      result = getField(n.sons[i], position)
      if result != nil: return 
  of nkRecCase:
    result = getField(n.sons[0], position)
    if result != nil: return
    for i in countup(1, sonsLen(n) - 1):
      case n.sons[i].kind
      of nkOfBranch, nkElse:
        result = getField(lastSon(n.sons[i]), position)
        if result != nil: return
      else: internalError(n.info, "getField(record case branch)")
  of nkSym:
    if n.sym.position == position: result = n.sym
  else: nil

proc packObject(x: PNode, typ: PType, res: Pointer) =
  InternalAssert x.kind in {nkObjConstr, nkPar}
  # compute the field's offsets:
  discard typ.getSize
  for i in countup(ord(x.kind == nkObjConstr), sonsLen(x) - 1):
    var it = x.sons[i]
    if it.kind == nkExprColonExpr:
      internalAssert it.sons[0].kind == nkSym
      let field = it.sons[0].sym
      pack(it.sons[1], field.typ, res +! field.offset)
    elif typ.n != nil:
      let field = getField(typ.n, i)
      pack(it, field.typ, res +! field.offset)
    else:
      globalError(x.info, "cannot pack unnamed tuple")

const maxPackDepth = 20
var packRecCheck = 0

proc pack(v: PNode, typ: PType, res: pointer) =
  template awr(T, v: Expr) {.immediate, dirty.} =
    wr(t, res, v)

  case typ.kind
  of tyBool: awr(Bool, v.intVal != 0)
  of tyChar: awr(Char, v.intVal.chr)
  of tyInt:  awr(Int, v.intVal.Int)
  of tyInt8: awr(Int8, v.intVal.Int8)
  of tyInt16: awr(Int16, v.intVal.Int16)
  of tyInt32: awr(Int32, v.intVal.Int32)
  of tyInt64: awr(Int64, v.intVal.Int64)
  of tyUInt: awr(Uint, v.intVal.Uint)
  of tyUInt8: awr(Uint8, v.intVal.Uint8)
  of tyUInt16: awr(Uint16, v.intVal.Uint16)
  of tyUInt32: awr(Uint32, v.intVal.Uint32)
  of tyUInt64: awr(Uint64, v.intVal.Uint64)
  of tyEnum, tySet:
    case v.typ.getSize
    of 1: awr(Uint8, v.intVal.Uint8)
    of 2: awr(Uint16, v.intVal.Uint16)
    of 4: awr(Int32, v.intVal.Int32)
    of 8: awr(Int64, v.intVal.Int64)
    else:
      globalError(v.info, "cannot map value to FFI (tyEnum, tySet)")
  of tyFloat: awr(Float, v.floatVal)
  of tyFloat32: awr(Float32, v.floatVal)
  of tyFloat64: awr(Float64, v.floatVal)
  
  of tyPointer, tyProc,  tyCString, tyString:
    if v.kind == nkNilLit:
      # nothing to do since the memory is 0 initialized anyway
      nil
    elif v.kind == nkPtrLit:
      awr(Pointer, cast[Pointer](v.intVal))
    elif v.kind in {nkStrLit..nkTripleStrLit}:
      awr(Cstring, Cstring(v.strVal))
    else:
      globalError(v.info, "cannot map pointer/proc value to FFI")
  of tyPtr, tyRef, tyVar:
    if v.kind == nkNilLit:
      # nothing to do since the memory is 0 initialized anyway
      nil
    elif v.kind == nkPtrLit:
      awr(Pointer, cast[Pointer](v.intVal))
    else:
      if packRecCheck > maxPackDepth:
        packRecCheck = 0
        globalError(v.info, "cannot map value to FFI " & typeToString(v.typ))
      inc packRecCheck
      pack(v.sons[0], typ.sons[0], res +! sizeof(Pointer))
      dec packRecCheck
      awr(Pointer, res +! sizeof(Pointer))
  of tyArray, tyArrayConstr:
    let baseSize = typ.sons[1].getSize
    for i in 0 .. <v.len:
      pack(v.sons[i], typ.sons[1], res +! i * baseSize)
  of tyObject, tyTuple:
    packObject(v, typ, res)
  of tyNil:
    nil
  of tyDistinct, tyGenericInst:
    pack(v, typ.sons[0], res)
  else:
    globalError(v.info, "cannot map value to FFI " & typeToString(v.typ))

proc unpack(x: Pointer, typ: PType, n: PNode): PNode

proc unpackObjectAdd(x: Pointer, n, result: PNode) =
  case n.kind
  of nkRecList:
    for i in countup(0, sonsLen(n) - 1):
      unpackObjectAdd(x, n.sons[i], result)
  of nkRecCase:
    globalError(result.info, "case objects cannot be unpacked")
  of nkSym:
    var pair = newNodeI(nkExprColonExpr, result.info, 2)
    pair.sons[0] = n
    pair.sons[1] = unpack(x +! n.sym.offset, n.sym.typ, nil)
    #echo "offset: ", n.sym.name.s, " ", n.sym.offset
    result.add pair
  else: nil

proc unpackObject(x: Pointer, typ: PType, n: PNode): PNode =
  # compute the field's offsets:
  discard typ.getSize
  
  # iterate over any actual field of 'n' ... if n is nil we need to create
  # the nkPar node:
  if n.isNil:
    result = newNode(nkPar)
    result.typ = typ
    if typ.n.isNil:
      internalError("cannot unpack unnamed tuple")
    unpackObjectAdd(x, typ.n, result)
  else:
    result = n
    if result.kind notin {nkObjConstr, nkPar}:
      globalError(n.info, "cannot map value from FFI")
    if typ.n.isNil:
      globalError(n.info, "cannot unpack unnamed tuple")
    for i in countup(ord(n.kind == nkObjConstr), sonsLen(n) - 1):
      var it = n.sons[i]
      if it.kind == nkExprColonExpr:
        internalAssert it.sons[0].kind == nkSym
        let field = it.sons[0].sym
        it.sons[1] = unpack(x +! field.offset, field.typ, it.sons[1])
      else:
        let field = getField(typ.n, i)
        n.sons[i] = unpack(x +! field.offset, field.typ, it)

proc unpackArray(x: Pointer, typ: PType, n: PNode): PNode =
  if n.isNil:
    result = newNode(nkBracket)
    result.typ = typ
    newSeq(result.sons, lengthOrd(typ).Int)
  else:
    result = n
    if result.kind != nkBracket:
      globalError(n.info, "cannot map value from FFI")
  let baseSize = typ.sons[1].getSize
  for i in 0 .. < result.len:
    result.sons[i] = unpack(x +! i * baseSize, typ.sons[1], result.sons[i])

proc canonNodeKind(k: TNodeKind): TNodeKind =
  case k
  of nkCharLit..nkUInt64Lit: result = nkIntLit
  of nkFloatLit..nkFloat128Lit: result = nkFloatLit
  of nkStrLit..nkTripleStrLit: result = nkStrLit
  else: result = k

proc unpack(x: pointer, typ: PType, n: PNode): PNode =
  template aw(k, v, field: Expr) {.immediate, dirty.} =
    if n.isNil:
      result = newNode(k)
      result.typ = typ
    else:
      # check we have the right field:
      result = n
      if result.kind.canonNodeKind != k.canonNodeKind:
        #echo "expected ", k, " but got ", result.kind
        #debug result
        return newNodeI(nkExceptBranch, n.info)
        #GlobalError(n.info, "cannot map value from FFI")
    result.field = v

  template setNil() =
    if n.isNil:
      result = newNode(nkNilLit)
      result.typ = typ
    else:
      reset n[]
      result = n
      result.kind = nkNilLit
      result.typ = typ

  template awi(kind, v: Expr) {.immediate, dirty.} = aw(kind, v, intVal)
  template awf(kind, v: Expr) {.immediate, dirty.} = aw(kind, v, floatVal)
  template aws(kind, v: Expr) {.immediate, dirty.} = aw(kind, v, strVal)
  
  case typ.kind
  of tyBool: awi(nkIntLit, rd(Bool, x).ord)
  of tyChar: awi(nkCharLit, rd(Char, x).ord)
  of tyInt:  awi(nkIntLit, rd(Int, x))
  of tyInt8: awi(nkInt8Lit, rd(Int8, x))
  of tyInt16: awi(nkInt16Lit, rd(Int16, x))
  of tyInt32: awi(nkInt32Lit, rd(Int32, x))
  of tyInt64: awi(nkInt64Lit, rd(Int64, x))
  of tyUInt: awi(nkUIntLit, rd(Uint, x).BiggestInt)
  of tyUInt8: awi(nkUInt8Lit, rd(Uint8, x).BiggestInt)
  of tyUInt16: awi(nkUInt16Lit, rd(Uint16, x).BiggestInt)
  of tyUInt32: awi(nkUInt32Lit, rd(Uint32, x).BiggestInt)
  of tyUInt64: awi(nkUInt64Lit, rd(Uint64, x).BiggestInt)
  of tyEnum:
    case typ.getSize
    of 1: awi(nkIntLit, rd(Uint8, x).BiggestInt)
    of 2: awi(nkIntLit, rd(Uint16, x).BiggestInt)
    of 4: awi(nkIntLit, rd(Int32, x).BiggestInt)
    of 8: awi(nkIntLit, rd(Int64, x).BiggestInt)
    else:
      globalError(n.info, "cannot map value from FFI (tyEnum, tySet)")
  of tyFloat: awf(nkFloatLit, rd(Float, x))
  of tyFloat32: awf(nkFloat32Lit, rd(Float32, x))
  of tyFloat64: awf(nkFloat64Lit, rd(Float64, x))
  of tyPointer, tyProc:
    let p = rd(Pointer, x)
    if p.isNil:
      setNil()
    elif n != nil and n.kind == nkStrLit:
      # we passed a string literal as a pointer; however strings are already
      # in their unboxed representation so nothing it to be unpacked:
      result = n
    else:
      awi(nkPtrLit, cast[TAddress](p))
  of tyPtr, tyRef, tyVar:
    let p = rd(Pointer, x)
    if p.isNil:
      setNil()
    elif n == nil or n.kind == nkPtrLit:
      awi(nkPtrLit, cast[TAddress](p))
    elif n != nil and n.len == 1:
      internalAssert n.kind == nkRefTy
      n.sons[0] = unpack(p, typ.sons[0], n.sons[0])
      result = n
    else:
      globalError(n.info, "cannot map value from FFI " & typeToString(typ))
  of tyObject, tyTuple:
    result = unpackObject(x, typ, n)
  of tyArray, tyArrayConstr:
    result = unpackArray(x, typ, n)
  of tyCString, tyString:
    let p = rd(Cstring, x)
    if p.isNil:
      setNil()
    else:
      aws(nkStrLit, $p)
  of tyNil:
    setNil()
  of tyDistinct, tyGenericInst:
    result = unpack(x, typ.sons[0], n)
  else:
    # XXX what to do with 'array' here?
    globalError(n.info, "cannot map value from FFI " & typeToString(typ))

proc fficast*(x: PNode, destTyp: PType): PNode =
  if x.kind == nkPtrLit and x.typ.kind in {tyPtr, tyRef, tyVar, tyPointer, 
                                           tyProc, tyCString, tyString, 
                                           tySequence}:
    result = newNodeIT(x.kind, x.info, destTyp)
    result.intVal = x.intVal
  elif x.kind == nkNilLit:
    result = newNodeIT(x.kind, x.info, destTyp)
  else:
    # we play safe here and allocate the max possible size:
    let size = max(packSize(x, x.typ), packSize(x, destTyp))
    var a = alloc0(size)
    pack(x, x.typ, a)
    # cast through a pointer needs a new inner object:
    let y = if x.kind == nkRefTy: newNodeI(nkRefTy, x.info, 1)
            else: x.copyTree
    y.typ = x.typ
    result = unpack(a, destTyp, y)
    dealloc a

proc callForeignFunction*(call: PNode): PNode =
  InternalAssert call.sons[0].kind == nkPtrLit
  
  var cif: TCif
  var sig: TParamList
  # use the arguments' types for varargs support:
  for i in 1..call.len-1:
    sig[i-1] = mapType(call.sons[i].typ)
    if sig[i-1].isNil:
      globalError(call.info, "cannot map FFI type")
  
  let typ = call.sons[0].typ
  if prepCif(cif, mapCallConv(typ.callConv, call.info), Cuint(call.len-1),
              mapType(typ.sons[0]), sig) != Ok:
    globalError(call.info, "error in FFI call")
  
  var args: TArgList
  let fn = cast[Pointer](call.sons[0].intVal)
  for i in 1 .. call.len-1:
    var t = call.sons[i].typ
    args[i-1] = alloc0(packSize(call.sons[i], t))
    pack(call.sons[i], t, args[i-1])
  let retVal = if isEmptyType(typ.sons[0]): Pointer(nil)
               else: alloc(typ.sons[0].getSize.Int)

  libffi.call(cif, fn, retVal, args)
  
  if retVal.isNil: 
    result = emptyNode
  else:
    result = unpack(retVal, typ.sons[0], nil)
    result.info = call.info

  if retVal != nil: dealloc retVal
  for i in 1 .. call.len-1:
    call.sons[i] = unpack(args[i-1], typ.sons[i], call[i])
    dealloc args[i-1]
