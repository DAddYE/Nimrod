#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2013 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This file implements basic features for any debugger.

type
  TVarSlot* {.compilerproc, final.} = object ## a slot in a frame
    address*: Pointer ## the variable's address
    typ*: PNimType    ## the variable's type
    name*: Cstring    ## the variable's name; for globals this is "module.name"

  PExtendedFrame = ptr TExtendedFrame
  TExtendedFrame = object  # If the debugger is enabled the compiler
                           # provides an extended frame. Of course
                           # only slots that are
                           # needed are allocated and not 10_000,
                           # except for the global data description.
    f: TFrame
    slots: Array[0..10_000, TVarSlot]

var
  dbgGlobalData: TExtendedFrame # this reserves much space, but
                                # for now it is the most practical way

proc dbgRegisterGlobal(name: Cstring, address: Pointer,
                       typ: PNimType) {.compilerproc.} =
  let i = dbgGlobalData.f.len
  if i >= high(dbgGlobalData.slots):
    #debugOut("[Warning] cannot register global ")
    return
  dbgGlobalData.slots[i].name = name
  dbgGlobalData.slots[i].typ = typ
  dbgGlobalData.slots[i].address = address
  inc(dbgGlobalData.f.len)

proc getLocal*(frame: PFrame; slot: Int): TVarSlot {.inline.} =
  ## retrieves the meta data for the local variable at `slot`. CAUTION: An
  ## invalid `slot` value causes a corruption!
  result = cast[PExtendedFrame](frame).slots[slot]

proc getGlobalLen*(): Int {.inline.} =
  ## gets the number of registered globals.
  result = dbgGlobalData.f.len

proc getGlobal*(slot: Int): TVarSlot {.inline.} =
  ## retrieves the meta data for the global variable at `slot`. CAUTION: An
  ## invalid `slot` value causes a corruption!
  result = dbgGlobalData.slots[slot]

# ------------------- breakpoint support ------------------------------------

type
  TBreakpoint* = object  ## represents a break point
    low*, high*: Int     ## range from low to high; if disabled
                         ## both low and high are set to their negative values
    filename*: Cstring   ## the filename of the breakpoint

var
  dbgBP: Array[0..127, TBreakpoint] # breakpoints
  dbgBPlen: Int
  dbgBPbloom: Int64  # we use a bloom filter to speed up breakpoint checking
  
  dbgFilenames*: Array[0..300, Cstring] ## registered filenames;
                                        ## 'nil' terminated
  dbgFilenameLen: Int

proc dbgRegisterFilename(filename: Cstring) {.compilerproc.} =
  # XXX we could check for duplicates here for DLL support
  dbgFilenames[dbgFilenameLen] = filename
  inc dbgFilenameLen

proc dbgRegisterBreakpoint(line: Int,
                           filename, name: Cstring) {.compilerproc.} =
  let x = dbgBPlen
  if x >= high(dbgBP):
    #debugOut("[Warning] cannot register breakpoint")
    return
  inc(dbgBPlen)
  dbgBP[x].filename = filename
  dbgBP[x].low = line
  dbgBP[x].high = line
  dbgBPbloom = dbgBPbloom or line

proc addBreakpoint*(filename: Cstring, lo, hi: Int): Bool =
  let x = dbgBPlen
  if x >= high(dbgBP): return false
  inc(dbgBPlen)
  result = true
  dbgBP[x].filename = filename
  dbgBP[x].low = lo
  dbgBP[x].high = hi
  for line in lo..hi: dbgBPbloom = dbgBPbloom or line

const
  FileSystemCaseInsensitive = defined(windows) or defined(dos) or defined(os2)

proc fileMatches(c, bp: Cstring): Bool =
  # bp = breakpoint filename
  # c = current filename
  # we consider it a match if bp is a suffix of c
  # and the character for the suffix does not exist or
  # is one of: \  /  :
  # depending on the OS case does not matter!
  var blen: Int = c_strlen(bp)
  var clen: Int = c_strlen(c)
  if blen > clen: return false
  # check for \ /  :
  if clen-blen-1 >= 0 and c[clen-blen-1] notin {'\\', '/', ':'}:
    return false
  var i = 0
  while i < blen:
    var x = bp[i]
    var y = c[i+clen-blen]
    when FileSystemCaseInsensitive:
      if x >= 'A' and x <= 'Z': x = chr(ord(x) - ord('A') + ord('a'))
      if y >= 'A' and y <= 'Z': y = chr(ord(y) - ord('A') + ord('a'))
    if x != y: return false
    inc(i)
  return true

proc canonFilename*(filename: Cstring): Cstring =
  ## returns 'nil' if the filename cannot be found.
  for i in 0 .. <dbgFilenameLen:
    result = dbgFilenames[i]
    if fileMatches(result, filename): return result
  result = nil

iterator listBreakpoints*(): ptr TBreakpoint =
  ## lists all breakpoints.
  for i in 0..dbgBPlen-1: yield addr(dbgBP[i])

proc isActive*(b: ptr TBreakpoint): Bool = b.low > 0
proc flip*(b: ptr TBreakpoint) =
  ## enables or disables 'b' depending on its current state.
  b.low = -b.low; b.high = -b.high

proc checkBreakpoints*(filename: Cstring, line: Int): ptr TBreakpoint =
  ## in which breakpoint (if any) we are.
  if (dbgBPbloom and line) != line: return nil
  for b in listBreakpoints():
    if line >= b.low and line <= b.high and filename == b.filename: return b

# ------------------- watchpoint support ------------------------------------

type
  THash = Int
  TWatchpoint {.pure, final.} = object
    name: Cstring
    address: Pointer
    typ: PNimType
    oldValue: THash

var
  watchpoints: Array [0..99, TWatchpoint]
  watchpointsLen: Int

proc `!&`(h: THash, val: Int): THash {.inline.} =
  result = h +% val
  result = result +% result shl 10
  result = result xor (result shr 6)

proc `!$`(h: THash): THash {.inline.} =
  result = h +% h shl 3
  result = result xor (result shr 11)
  result = result +% result shl 15

proc hash(Data: Pointer, Size: Int): THash =
  var h: THash = 0
  var p = cast[Cstring](data)
  var i = 0
  var s = size
  while s > 0:
    h = h !& ord(p[i])
    inc(i)
    dec(s)
  result = !$h

proc hashGcHeader(data: Pointer): THash =
  const headerSize = sizeof(int)*2
  result = hash(cast[Pointer](cast[Int](data) -% headerSize), headerSize)

proc genericHashAux(dest: Pointer, mt: PNimType, shallow: Bool,
                    h: THash): THash
proc genericHashAux(dest: Pointer, n: ptr TNimNode, shallow: Bool,
                    h: THash): THash =
  var d = cast[TAddress](dest)
  case n.kind
  of nkSlot:
    result = genericHashAux(cast[Pointer](d +% n.offset), n.typ, shallow, h)
  of nkList:
    result = h
    for i in 0..n.len-1: 
      result = result !& genericHashAux(dest, n.sons[i], shallow, result)
  of nkCase:
    result = h !& hash(cast[Pointer](d +% n.offset), n.typ.size)
    var m = selectBranch(dest, n)
    if m != nil: result = genericHashAux(dest, m, shallow, result)
  of nkNone: sysAssert(false, "genericHashAux")

proc genericHashAux(dest: Pointer, mt: PNimType, shallow: Bool, 
                    h: THash): THash =
  sysAssert(mt != nil, "genericHashAux 2")
  case mt.Kind
  of tyString:
    var x = cast[ppointer](dest)[]
    result = h
    if x != nil:
      let s = cast[NimString](x)
      when defined(trackGcHeaders):
        result = result !& hashGcHeader(x)
      else:
        result = result !& hash(x, s.len)
  of tySequence:
    var x = cast[ppointer](dest)
    var dst = cast[taddress](cast[ppointer](dest)[])
    result = h
    if dst != 0:
      when defined(trackGcHeaders):
        result = result !& hashGcHeader(cast[ppointer](dest)[])
      else:
        for i in 0..cast[pgenericseq](dst).len-1:
          result = result !& genericHashAux(
            cast[Pointer](dst +% i*% mt.base.size +% genericSeqSize),
            mt.Base, shallow, result)
  of tyObject, tyTuple:
    # we don't need to copy m_type field for tyObject, as they are equal anyway
    result = genericHashAux(dest, mt.node, shallow, h)
  of tyArray, tyArrayConstr:
    let d = cast[TAddress](dest)
    result = h
    for i in 0..(mt.size div mt.base.size)-1:
      result = result !& genericHashAux(cast[Pointer](d +% i*% mt.base.size),
                                        mt.base, shallow, result)
  of tyRef:
    when defined(trackGcHeaders):
      var s = cast[ppointer](dest)[]
      if s != nil:
        result = result !& hashGcHeader(s)
    else:
      if shallow:
        result = h !& hash(dest, mt.size)
      else:
        result = h
        var s = cast[ppointer](dest)[]
        if s != nil:
          result = result !& genericHashAux(s, mt.base, shallow, result)
  else:
    result = h !& hash(dest, mt.size) # hash raw bits

proc genericHash(dest: Pointer, mt: PNimType): Int =
  result = genericHashAux(dest, mt, false, 0)
  
proc dbgRegisterWatchpoint(address: Pointer, name: Cstring,
                           typ: PNimType) {.compilerproc.} =
  let L = watchpointsLen
  for i in 0.. <L:
    if watchpoints[i].name == name:
      # address may have changed:
      watchpoints[i].address = address
      return
  if L >= watchpoints.high:
    #debugOut("[Warning] cannot register watchpoint")
    return
  watchpoints[L].name = name
  watchpoints[L].address = address
  watchpoints[L].typ = typ
  watchpoints[L].oldValue = genericHash(address, typ)
  inc watchpointsLen

proc dbgUnregisterWatchpoints*() =
  watchpointsLen = 0

var
  dbgLineHook*: proc () {.nimcall.}
    ## set this variable to provide a procedure that should be called before
    ## each executed instruction. This should only be used by debuggers!
    ## Only code compiled with the ``debugger:on`` switch calls this hook.

  dbgWatchpointHook*: proc (watchpointName: Cstring) {.nimcall.}
  
proc checkWatchpoints =
  let L = watchpointsLen
  for i in 0.. <L:
    let newHash = genericHash(watchpoints[i].address, watchpoints[i].typ)
    if newHash != watchpoints[i].oldValue:
      dbgWatchpointHook(watchpoints[i].name)
      watchpoints[i].oldValue = newHash

proc endb(line: Int, file: Cstring) {.compilerproc, noinline.} =
  # This proc is called before every Nimrod code line!
  if framePtr == nil: return
  if dbgWatchpointHook != nil: checkWatchpoints()
  framePtr.line = line # this is done here for smaller code size!
  framePtr.filename = file
  if dbgLineHook != nil: dbgLineHook()

include "system/endb"
