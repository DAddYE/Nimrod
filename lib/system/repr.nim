#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# The generic ``repr`` procedure. It is an invaluable debugging tool.

when not defined(useNimRtl):
  proc reprAny(p: Pointer, typ: PNimType): String {.compilerRtl.}

proc reprInt(x: Int64): String {.compilerproc.} = return $x
proc reprFloat(x: Float): String {.compilerproc.} = return $x

proc reprPointer(x: Pointer): String {.compilerproc.} =
  var buf: Array [0..59, Char]
  cSprintf(buf, "%p", x)
  return $buf

proc `$`(x: uint64): string =
  var buf: Array [0..59, Char]
  cSprintf(buf, "%llu", x)
  return $buf

proc reprStrAux(result: var String, s: String) =
  if cast[Pointer](s) == nil:
    add result, "nil"
    return
  add result, reprPointer(cast[Pointer](s)) & "\""
  for c in items(s):
    case c
    of '"': add result, "\\\""
    of '\\': add result, "\\\\" # BUGFIX: forgotten
    of '\10': add result, "\\10\"\n\"" # " \n " # better readability
    of '\128' .. '\255', '\0'..'\9', '\11'..'\31':
      add result, "\\" & reprInt(ord(c))
    else: result.add(c)
  add result, "\""

proc reprStr(s: String): String {.compilerRtl.} =
  result = ""
  reprStrAux(result, s)

proc reprBool(x: Bool): String {.compilerRtl.} =
  if x: result = "true"
  else: result = "false"

proc reprChar(x: Char): String {.compilerRtl.} =
  result = "\'"
  case x
  of '"': add result, "\\\""
  of '\\': add result, "\\\\"
  of '\128' .. '\255', '\0'..'\31': add result, "\\" & reprInt(ord(x))
  else: add result, x
  add result, "\'"

proc reprEnum(e: Int, typ: PNimType): String {.compilerRtl.} =
  # we read an 'int' but this may have been too large, so mask the other bits:
  let e = e and (1 shl (typ.size*8)-1)
  if ntfEnumHole notin typ.flags:
    if e <% typ.node.len:
      return $typ.node.sons[e].name
  else:
    # ugh we need a slow linear search:
    var n = typ.node
    var s = n.sons
    for i in 0 .. n.len-1:
      if s[i].offset == e: return $s[i].name
  result = $e & " (invalid data!)"

type
  PbyteArray = ptr Array[0.. 0xffff, Int8]

proc addSetElem(result: var String, elem: Int, typ: PNimType) =
  case typ.kind
  of tyEnum: add result, reprEnum(elem, typ)
  of tyBool: add result, reprBool(Bool(elem))
  of tyChar: add result, reprChar(chr(elem))
  of tyRange: addSetElem(result, elem, typ.base)
  of tyInt..tyInt64, tyUInt8, tyUInt16: add result, reprInt(elem)
  else: # data corrupt --> inform the user
    add result, " (invalid data!)"

proc reprSetAux(result: var String, p: Pointer, typ: PNimType) =
  # "typ.slots.len" field is for sets the "first" field
  var elemCounter = 0  # we need this flag for adding the comma at
                       # the right places
  add result, "{"
  var u: Int64
  case typ.size
  of 1: u = ze64(cast[ptr Int8](p)[])
  of 2: u = ze64(cast[ptr Int16](p)[])
  of 4: u = ze64(cast[ptr Int32](p)[])
  of 8: u = cast[ptr Int64](p)[]
  else:
    var a = cast[PbyteArray](p)
    for i in 0 .. typ.size*8-1:
      if (ze(a[i div 8]) and (1 shl (i mod 8))) != 0:
        if elemCounter > 0: add result, ", "
        addSetElem(result, i+typ.node.len, typ.base)
        inc(elemCounter)
  if typ.size <= 8:
    for i in 0..sizeof(int64)*8-1:
      if (u and (1'i64 shl Int64(i))) != 0'i64:
        if elemCounter > 0: add result, ", "
        addSetElem(result, i+typ.node.len, typ.base)
        inc(elemCounter)
  add result, "}"

proc reprSet(p: Pointer, typ: PNimType): String {.compilerRtl.} =
  result = ""
  reprSetAux(result, p, typ)

type
  TReprClosure {.final.} = object # we cannot use a global variable here
                                  # as this wouldn't be thread-safe
    marked: TCellSet
    recdepth: Int       # do not recurse endlessly
    indent: Int         # indentation

when not defined(useNimRtl):
  proc initReprClosure(cl: var TReprClosure) =
    # Important: cellsets does not lock the heap when doing allocations! We
    # have to do it here ...
    when hasThreadSupport and hasSharedHeap and defined(heapLock):
      AcquireSys(HeapLock)
    init(cl.marked)
    cl.recdepth = -1      # default is to display everything!
    cl.indent = 0

  proc deinitReprClosure(cl: var TReprClosure) =
    deinit(cl.marked)
    when hasThreadSupport and hasSharedHeap and defined(heapLock): 
      ReleaseSys(HeapLock)

  proc reprBreak(result: var String, cl: TReprClosure) =
    add result, "\n"
    for i in 0..cl.indent-1: add result, ' '

  proc reprAux(result: var String, p: Pointer, typ: PNimType,
               cl: var TReprClosure)

  proc reprArray(result: var String, p: Pointer, typ: PNimType,
                 cl: var TReprClosure) =
    add result, "["
    var bs = typ.base.size
    for i in 0..typ.size div bs - 1:
      if i > 0: add result, ", "
      reprAux(result, cast[Pointer](cast[TAddress](p) + i*bs), typ.base, cl)
    add result, "]"

  proc reprSequence(result: var String, p: Pointer, typ: PNimType,
                    cl: var TReprClosure) =
    if p == nil:
      add result, "nil"
      return
    result.add(reprPointer(p) & "[")
    var bs = typ.base.size
    for i in 0..cast[PGenericSeq](p).len-1:
      if i > 0: add result, ", "
      reprAux(result, cast[Pointer](cast[TAddress](p) + GenericSeqSize + i*bs),
              typ.Base, cl)
    add result, "]"

  proc reprRecordAux(result: var String, p: Pointer, n: ptr TNimNode,
                     cl: var TReprClosure) =
    case n.kind
    of nkNone: sysAssert(false, "reprRecordAux")
    of nkSlot:
      add result, $n.name
      add result, " = "
      reprAux(result, cast[Pointer](cast[TAddress](p) + n.offset), n.typ, cl)
    of nkList:
      for i in 0..n.len-1:
        if i > 0: add result, ",\n"
        reprRecordAux(result, p, n.sons[i], cl)
    of nkCase:
      var m = selectBranch(p, n)
      reprAux(result, cast[Pointer](cast[TAddress](p) + n.offset), n.typ, cl)
      if m != nil: reprRecordAux(result, p, m, cl)

  proc reprRecord(result: var String, p: Pointer, typ: PNimType,
                  cl: var TReprClosure) =
    add result, "["
    let oldLen = result.len
    reprRecordAux(result, p, typ.node, cl)
    if typ.base != nil: 
      if oldLen != result.len: add result, ",\n"
      reprRecordAux(result, p, typ.base.node, cl)
    add result, "]"

  proc reprRef(result: var String, p: Pointer, typ: PNimType,
               cl: var TReprClosure) =
    # we know that p is not nil here:
    when defined(boehmGC) or defined(nogc):
      var cell = cast[PCell](p)
    else:
      var cell = usrToCell(p)
    add result, "ref " & reprPointer(p)
    if cell notin cl.marked:
      # only the address is shown:
      incl(cl.marked, cell)
      add result, " --> "
      reprAux(result, p, typ.base, cl)

  proc reprAux(result: var string, p: pointer, typ: PNimType,
               cl: var TReprClosure) =
    if cl.recdepth == 0:
      add result, "..."
      return
    dec(cl.recdepth)
    case typ.kind
    of tySet: reprSetAux(result, p, typ)
    of tyArray: reprArray(result, p, typ, cl)
    of tyTuple: reprRecord(result, p, typ, cl)
    of tyObject: 
      var t = cast[ptr PNimType](p)[]
      reprRecord(result, p, t, cl)
    of tyRef, tyPtr:
      sysAssert(p != nil, "reprAux")
      if cast[PPointer](p)[] == nil: add result, "nil"
      else: reprRef(result, cast[PPointer](p)[], typ, cl)
    of tySequence:
      reprSequence(result, cast[PPointer](p)[], typ, cl)
    of tyInt: add result, $(cast[ptr Int](p)[])
    of tyInt8: add result, $Int(cast[ptr Int8](p)[])
    of tyInt16: add result, $Int(cast[ptr Int16](p)[])
    of tyInt32: add result, $Int(cast[ptr Int32](p)[])
    of tyInt64: add result, $(cast[ptr Int64](p)[])
    of tyUInt8: add result, $ze(cast[ptr Int8](p)[])
    of tyUInt16: add result, $ze(cast[ptr Int16](p)[])
    
    of tyFloat: add result, $(cast[ptr Float](p)[])
    of tyFloat32: add result, $(cast[ptr Float32](p)[])
    of tyFloat64: add result, $(cast[ptr Float64](p)[])
    of tyEnum: add result, reprEnum(cast[ptr Int](p)[], typ)
    of tyBool: add result, reprBool(cast[ptr Bool](p)[])
    of tyChar: add result, reprChar(cast[ptr Char](p)[])
    of tyString: reprStrAux(result, cast[ptr String](p)[])
    of tyCString: reprStrAux(result, $(cast[ptr Cstring](p)[]))
    of tyRange: reprAux(result, p, typ.base, cl)
    of tyProc, tyPointer:
      if cast[PPointer](p)[] == nil: add result, "nil"
      else: add result, reprPointer(cast[PPointer](p)[])
    else:
      add result, "(invalid data!)"
    inc(cl.recdepth)

proc reprOpenArray(p: Pointer, length: Int, elemtyp: PNimType): String {.
                   compilerRtl.} =
  var
    cl: TReprClosure
  initReprClosure(cl)
  result = "["
  var bs = elemtyp.size
  for i in 0..length - 1:
    if i > 0: add result, ", "
    reprAux(result, cast[Pointer](cast[TAddress](p) + i*bs), elemtyp, cl)
  add result, "]"
  deinitReprClosure(cl)

when not defined(useNimRtl):
  proc reprAny(p: pointer, typ: PNimType): string =
    var
      cl: TReprClosure
    initReprClosure(cl)
    result = ""
    if typ.kind in {tyObject, tyTuple, tyArray, tySet}:
      reprAux(result, p, typ, cl)
    else:
      var p = p
      reprAux(result, addr(p), typ, cl)
    add result, "\n"
    deinitReprClosure(cl)

