# Converted from Pascal

## Interface to the zlib http://www.zlib.net/ compression library.

when defined(windows):
  const libz = "zlib1.dll"
elif defined(macosx):
  const libz = "libz.dylib"
else:
  const libz = "libz.so"

type
  Uint* = Int32
  Ulong* = Int
  Ulongf* = Int
  Pulongf* = ptr Ulongf
  ZOffT* = Int32
  Pbyte* = Cstring
  Pbytef* = Cstring
  TAllocfunc* = proc (p: Pointer, items: Uint, size: Uint): Pointer{.cdecl.}
  TFreeFunc* = proc (p: Pointer, address: Pointer){.cdecl.}
  TInternalState*{.final, pure.} = object 
  PInternalState* = ptr TInternalstate
  TZStream*{.final, pure.} = object 
    next_in*: Pbytef
    avail_in*: Uint
    total_in*: Ulong
    next_out*: Pbytef
    avail_out*: Uint
    total_out*: Ulong
    msg*: Pbytef
    state*: PInternalState
    zalloc*: TAllocFunc
    zfree*: TFreeFunc
    opaque*: Pointer
    data_type*: Int32
    adler*: Ulong
    reserved*: Ulong

  TZStreamRec* = TZStream
  PZstream* = ptr TZStream
  GzFile* = Pointer

const 
  ZNoFlush* = 0
  ZPartialFlush* = 1
  ZSyncFlush* = 2
  ZFullFlush* = 3
  ZFinish* = 4
  ZOk* = 0
  ZStreamEnd* = 1
  ZNeedDict* = 2
  ZErrno* = -1
  ZStreamError* = -2
  ZDataError* = -3
  ZMemError* = -4
  ZBufError* = -5
  ZVersionError* = -6
  ZNoCompression* = 0
  ZBestSpeed* = 1
  ZBestCompression* = 9
  ZDefaultCompression* = -1
  ZFiltered* = 1
  ZHuffmanOnly* = 2
  ZDefaultStrategy* = 0
  ZBinary* = 0
  ZAscii* = 1
  ZUnknown* = 2
  ZDeflated* = 8
  ZNull* = 0

proc zlibVersion*(): Cstring{.cdecl, dynlib: libz, importc: "zlibVersion".}
proc deflate*(strm: var TZStream, flush: Int32): Int32{.cdecl, dynlib: libz, 
    importc: "deflate".}
proc deflateEnd*(strm: var TZStream): Int32{.cdecl, dynlib: libz, 
    importc: "deflateEnd".}
proc inflate*(strm: var TZStream, flush: Int32): Int32{.cdecl, dynlib: libz, 
    importc: "inflate".}
proc inflateEnd*(strm: var TZStream): Int32{.cdecl, dynlib: libz, 
    importc: "inflateEnd".}
proc deflateSetDictionary*(strm: var TZStream, dictionary: Pbytef, 
                           dictLength: Uint): Int32{.cdecl, dynlib: libz, 
    importc: "deflateSetDictionary".}
proc deflateCopy*(dest, source: var TZstream): Int32{.cdecl, dynlib: libz, 
    importc: "deflateCopy".}
proc deflateReset*(strm: var TZStream): Int32{.cdecl, dynlib: libz, 
    importc: "deflateReset".}
proc deflateParams*(strm: var TZStream, level: Int32, strategy: Int32): Int32{.
    cdecl, dynlib: libz, importc: "deflateParams".}
proc inflateSetDictionary*(strm: var TZStream, dictionary: Pbytef, 
                           dictLength: Uint): Int32{.cdecl, dynlib: libz, 
    importc: "inflateSetDictionary".}
proc inflateSync*(strm: var TZStream): Int32{.cdecl, dynlib: libz, 
    importc: "inflateSync".}
proc inflateReset*(strm: var TZStream): Int32{.cdecl, dynlib: libz, 
    importc: "inflateReset".}
proc compress*(dest: Pbytef, destLen: Pulongf, source: Pbytef, sourceLen: Ulong): Cint{.
    cdecl, dynlib: libz, importc: "compress".}
proc compress2*(dest: Pbytef, destLen: Pulongf, source: Pbytef, 
                sourceLen: Ulong, level: Cint): Cint{.cdecl, dynlib: libz, 
    importc: "compress2".}
proc uncompress*(dest: Pbytef, destLen: Pulongf, source: Pbytef, 
                 sourceLen: Ulong): Cint{.cdecl, dynlib: libz, 
    importc: "uncompress".}
proc gzopen*(path: Cstring, mode: Cstring): GzFile{.cdecl, dynlib: libz, 
    importc: "gzopen".}
proc gzdopen*(fd: Int32, mode: Cstring): GzFile{.cdecl, dynlib: libz, 
    importc: "gzdopen".}
proc gzsetparams*(thefile: GzFile, level: Int32, strategy: Int32): Int32{.cdecl, 
    dynlib: libz, importc: "gzsetparams".}
proc gzread*(thefile: GzFile, buf: Pointer, length: Int): Int32{.cdecl, 
    dynlib: libz, importc: "gzread".}
proc gzwrite*(thefile: GzFile, buf: Pointer, length: Int): Int32{.cdecl, 
    dynlib: libz, importc: "gzwrite".}
proc gzprintf*(thefile: GzFile, format: Pbytef): Int32{.varargs, cdecl, 
    dynlib: libz, importc: "gzprintf".}
proc gzputs*(thefile: GzFile, s: Pbytef): Int32{.cdecl, dynlib: libz, 
    importc: "gzputs".}
proc gzgets*(thefile: GzFile, buf: Pbytef, length: Int32): Pbytef{.cdecl, 
    dynlib: libz, importc: "gzgets".}
proc gzputc*(thefile: GzFile, c: Char): Char{.cdecl, dynlib: libz, 
    importc: "gzputc".}
proc gzgetc*(thefile: GzFile): Char{.cdecl, dynlib: libz, importc: "gzgetc".}
proc gzflush*(thefile: GzFile, flush: Int32): Int32{.cdecl, dynlib: libz, 
    importc: "gzflush".}
proc gzseek*(thefile: GzFile, offset: ZOffT, whence: Int32): ZOffT{.cdecl, 
    dynlib: libz, importc: "gzseek".}
proc gzrewind*(thefile: GzFile): Int32{.cdecl, dynlib: libz, importc: "gzrewind".}
proc gztell*(thefile: GzFile): ZOffT{.cdecl, dynlib: libz, importc: "gztell".}
proc gzeof*(thefile: GzFile): Int {.cdecl, dynlib: libz, importc: "gzeof".}
proc gzclose*(thefile: GzFile): Int32{.cdecl, dynlib: libz, importc: "gzclose".}
proc gzerror*(thefile: GzFile, errnum: var Int32): Pbytef{.cdecl, dynlib: libz, 
    importc: "gzerror".}
proc adler32*(adler: Ulong, buf: Pbytef, length: Uint): Ulong{.cdecl, 
    dynlib: libz, importc: "adler32".}
proc crc32*(crc: Ulong, buf: Pbytef, length: Uint): Ulong{.cdecl, dynlib: libz, 
    importc: "crc32".}
proc deflateInitu*(strm: var TZStream, level: Int32, version: Cstring, 
                   stream_size: Int32): Int32{.cdecl, dynlib: libz, 
    importc: "deflateInit_".}
proc inflateInitu*(strm: var TZStream, version: Cstring,
                   stream_size: Int32): Int32 {.
    cdecl, dynlib: libz, importc: "inflateInit_".}
proc deflateInit*(strm: var TZStream, level: Int32): Int32
proc inflateInit*(strm: var TZStream): Int32
proc deflateInit2u*(strm: var TZStream, level: Int32, `method`: Int32, 
                    windowBits: Int32, memLevel: Int32, strategy: Int32, 
                    version: Cstring, stream_size: Int32): Int32 {.cdecl, 
                    dynlib: libz, importc: "deflateInit2_".}
proc inflateInit2u*(strm: var TZStream, windowBits: Int32, version: Cstring, 
                    stream_size: Int32): Int32{.cdecl, dynlib: libz, 
    importc: "inflateInit2_".}
proc deflateInit2*(strm: var TZStream, 
                   level, `method`, windowBits, memLevel,
                   strategy: Int32): Int32
proc inflateInit2*(strm: var TZStream, windowBits: Int32): Int32
proc zError*(err: Int32): Cstring{.cdecl, dynlib: libz, importc: "zError".}
proc inflateSyncPoint*(z: PZstream): Int32{.cdecl, dynlib: libz, 
    importc: "inflateSyncPoint".}
proc getCrcTable*(): Pointer{.cdecl, dynlib: libz, importc: "get_crc_table".}

proc deflateInit(strm: var TZStream, level: int32): int32 = 
  result = deflateInitu(strm, level, zlibVersion(), sizeof(TZStream).Cint)

proc inflateInit(strm: var TZStream): int32 = 
  result = inflateInitu(strm, zlibVersion(), sizeof(TZStream).Cint)

proc deflateInit2(strm: var TZStream, 
                  level, `method`, windowBits, memLevel,
                  strategy: int32): int32 = 
  result = deflateInit2u(strm, level, `method`, windowBits, memLevel, 
                         strategy, zlibVersion(), sizeof(TZStream).Cint)

proc inflateInit2(strm: var TZStream, windowBits: int32): int32 = 
  result = inflateInit2u(strm, windowBits, zlibVersion(), 
                         sizeof(TZStream).Cint)

proc zlibAllocMem*(AppData: Pointer, Items, Size: Int): Pointer {.cdecl.} = 
  result = alloc(items * size)

proc zlibFreeMem*(AppData, `Block`: Pointer) {.cdecl.} = 
  dealloc(`block`)
