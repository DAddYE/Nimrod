import endians

proc swapEndian16*(outp, inp: Pointer) = 
  ## copies `inp` to `outp` swapping bytes. Both buffers are supposed to
  ## contain at least 2 bytes.
  var i = cast[Cstring](inp)
  var o = cast[Cstring](outp)
  o[0] = i[1]
  o[1] = i[0]
when cpuEndian == bigEndian:
  proc bigEndian16(outp, inp: pointer) {.inline.} = copyMem(outp, inp, 2)
else:
  proc bigEndian16*(outp, inp: Pointer) {.inline.} = swapEndian16(outp, inp)

import enet

type
  PBuffer* = ref object
    data*: String
    pos: Int

proc free(b: PBuffer) =
  gCUnref b.data
proc newBuffer*(len: Int): PBuffer =
  new result, free
  result.data = newString(len)
proc newBuffer*(pkt: PPacket): PBuffer =
  new result, free
  result.data = newString(pkt.dataLength)
  copyMem(addr result.data[0], pkt.data, pkt.dataLength)
proc toPacket*(buffer: PBuffer; flags: TPacketFlag): PPacket =
  buffer.data.setLen buffer.pos
  result = createPacket(cstring(buffer.data), buffer.pos, flags)

proc isDirty*(buffer: PBuffer): Bool {.inline.} =
  result = (buffer.pos != 0)
proc atEnd*(buffer: PBuffer): Bool {.inline.} =
  result = (buffer.pos == buffer.data.len)
proc reset*(buffer: PBuffer) {.inline.} =
  buffer.pos = 0

proc flush*(buf: PBuffer) =
  buf.pos = 0
  buf.data.setLen(0)
proc send*(peer: PPeer; channel: Cuchar; buf: PBuffer; flags: TPacketFlag): Cint {.discardable.} =
  result = send(peer, channel, buf.toPacket(flags))

proc read*[T: int16|uint16](buffer: PBuffer; outp: var T) =
  bigEndian16(addr outp, addr buffer.data[buffer.pos])
  inc buffer.pos, 2
proc read*[T: float32|int32|uint32](buffer: PBuffer; outp: var T) =
  bigEndian32(addr outp, addr buffer.data[buffer.pos])
  inc buffer.pos, 4
proc read*[T: float64|int64|uint64](buffer: PBuffer; outp: var T) =
  bigEndian64(addr outp, addr buffer.data[buffer.pos])
  inc buffer.pos, 8
proc read*[T: int8|uint8|byte|bool|char](buffer: PBuffer; outp: var T) =
  copyMem(addr outp, addr buffer.data[buffer.pos], 1)
  inc buffer.pos, 1

proc writeBE*[T: int16|uint16](buffer: PBuffer; val: var T) =
  setLen buffer.data, buffer.pos + 2
  bigEndian16(addr buffer.data[buffer.pos], addr val)
  inc buffer.pos, 2
proc writeBE*[T: int32|uint32|float32](buffer: PBuffer; val: var T) =
  setLen buffer.data, buffer.pos + 4
  bigEndian32(addr buffer.data[buffer.pos], addr val)
  inc buffer.pos, 4
proc writeBE*[T: int64|uint64|float64](buffer: PBuffer; val: var T) =
  setLen buffer.data, buffer.pos + 8
  bigEndian64(addr buffer.data[buffer.pos], addr val)
  inc buffer.pos, 8
proc writeBE*[T: char|int8|uint8|byte|bool](buffer: PBuffer; val: var T) =
  setLen buffer.data, buffer.pos + 1
  copyMem(addr buffer.data[buffer.pos], addr val, 1)
  inc buffer.pos, 1


proc write*(buffer: PBuffer; val: var String) =
  var length = len(val).Uint16
  writeBE buffer, length
  setLen buffer.data, buffer.pos + length.Int
  copyMem(addr buffer.data[buffer.pos], addr val[0], length.Int)
  inc buffer.pos, length.Int
proc write*[T: TNumber|bool|char|byte](buffer: PBuffer; val: T) =
  var v: T
  shallowCopy v, val
  writeBE buffer, v

proc readInt8*(buffer: PBuffer): Int8 =
  read buffer, result
proc readInt16*(buffer: PBuffer): Int16 =
  read buffer, result
proc readInt32*(buffer: PBuffer): Int32 =
  read buffer, result
proc readInt64*(buffer: PBuffer): Int64 =
  read buffer, result
proc readFloat32*(buffer: PBuffer): Float32 =
  read buffer, result
proc readFloat64*(buffer: PBuffer): Float64 =
  read buffer, result
proc readStr*(buffer: PBuffer): String =
  let len = readInt16(buffer).Int
  result = ""
  if len > 0:
    result.setLen len
    copyMem(addr result[0], addr buffer.data[buffer.pos], len)
    inc buffer.pos, len
proc readChar*(buffer: PBuffer): Char {.inline.} = return readInt8(buffer).Char
proc readBool*(buffer: PBuffer): Bool {.inline.} = return readInt8(buffer).Bool


when isMainModule:
  var b = newBuffer(100)
  var str = "hello there"
  b.write str
  echo(repr(b))
  b.pos = 0
  echo(repr(b.readStr()))
  
  b.flush()
  echo "flushed"
  b.writeC([1,2,3])
  echo(repr(b))
  
  
