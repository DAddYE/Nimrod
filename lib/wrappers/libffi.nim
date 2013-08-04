# -----------------------------------------------------------------*-C-*-
#   libffi 3.0.10 - Copyright (c) 2011 Anthony Green
#                    - Copyright (c) 1996-2003, 2007, 2008 Red Hat, Inc.
#
#   Permission is hereby granted, free of charge, to any person
#   obtaining a copy of this software and associated documentation
#   files (the ``Software''), to deal in the Software without
#   restriction, including without limitation the rights to use, copy,
#   modify, merge, publish, distribute, sublicense, and/or sell copies
#   of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be
#   included in all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED ``AS IS'', WITHOUT WARRANTY OF ANY KIND,
#   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#   NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#   DEALINGS IN THE SOFTWARE.
#
#   ----------------------------------------------------------------------- 

{.deadCodeElim: on.}

when defined(windows): 
  const libffidll* = "libffi.dll"
elif defined(macosx): 
  const libffidll* = "libffi.dylib"
else: 
  const libffidll* = "libffi.so"

type
  TArg* = Int
  TSArg* = Int

when defined(windows) and defined(x86):
  type
    TABI* {.size: sizeof(cint).} = enum
      FIRST_ABI, SYSV, STDCALL

  const DEFAULT_ABI* = SYSV
elif defined(amd64) and defined(windows):
  type 
    TABI* {.size: sizeof(cint).} = enum 
      FIRST_ABI, WIN64
  const DEFAULT_ABI* = WIN64
else:
  type 
    TABI* {.size: sizeof(cint).} = enum
      FIRST_ABI, SYSV, UNIX64

  when defined(i386):
    const DEFAULT_ABI* = SYSV
  else: 
    const DefaultAbi* = UNIX64
    
const 
  tkVOID* = 0
  tkINT* = 1
  tkFLOAT* = 2
  tkDOUBLE* = 3
  tkLONGDOUBLE* = 4
  tkUINT8* = 5
  tkSINT8* = 6
  tkUINT16* = 7
  tkSINT16* = 8
  tkUINT32* = 9
  tkSINT32* = 10
  tkUINT64* = 11
  tkSINT64* = 12
  tkSTRUCT* = 13
  tkPOINTER* = 14

  tkLAST = tkPOINTER
  tkSMALLSTRUCT1B* = (tkLAST + 1)
  tkSMALLSTRUCT2B* = (tkLAST + 2)
  tkSMALLSTRUCT4B* = (tkLAST + 3)

type
  TType* = object
    size*: Int
    alignment*: Uint16
    typ*: Uint16
    elements*: ptr ptr TType

var
  typeVoid* {.importc: "ffi_type_void", dynlib: libffidll.}: TType
  typeUint8* {.importc: "ffi_type_uint8", dynlib: libffidll.}: TType
  typeSint8* {.importc: "ffi_type_sint8", dynlib: libffidll.}: TType
  typeUint16* {.importc: "ffi_type_uint16", dynlib: libffidll.}: TType
  typeSint16* {.importc: "ffi_type_sint16", dynlib: libffidll.}: TType
  typeUint32* {.importc: "ffi_type_uint32", dynlib: libffidll.}: TType
  typeSint32* {.importc: "ffi_type_sint32", dynlib: libffidll.}: TType
  typeUint64* {.importc: "ffi_type_uint64", dynlib: libffidll.}: TType
  typeSint64* {.importc: "ffi_type_sint64", dynlib: libffidll.}: TType
  typeFloat* {.importc: "ffi_type_float", dynlib: libffidll.}: TType
  typeDouble* {.importc: "ffi_type_double", dynlib: libffidll.}: TType
  typePointer* {.importc: "ffi_type_pointer", dynlib: libffidll.}: TType
  typeLongdouble* {.importc: "ffi_type_longdouble", dynlib: libffidll.}: TType

type 
  Tstatus* {.size: sizeof(cint).} = enum 
    OK, BAD_TYPEDEF, BAD_ABI
  TTypeKind* = Cuint
  TCif* {.pure, final.} = object 
    abi*: TABI
    nargs*: Cuint
    arg_types*: ptr ptr TType
    rtype*: ptr TType
    bytes*: Cuint
    flags*: Cuint

type
  TRaw* = object 
    sint*: TSArg

proc rawCall*(cif: var Tcif; fn: proc () {.cdecl.}; rvalue: Pointer; 
               avalue: ptr TRaw) {.cdecl, importc: "ffi_raw_call", 
                                   dynlib: libffidll.}
proc ptrarrayToRaw*(cif: var Tcif; args: ptr Pointer; raw: ptr TRaw) {.cdecl, 
    importc: "ffi_ptrarray_to_raw", dynlib: libffidll.}
proc rawToPtrarray*(cif: var Tcif; raw: ptr TRaw; args: ptr Pointer) {.cdecl, 
    importc: "ffi_raw_to_ptrarray", dynlib: libffidll.}
proc rawSize*(cif: var Tcif): Int {.cdecl, importc: "ffi_raw_size", 
                                     dynlib: libffidll.}

proc prepCif*(cif: var Tcif; abi: TABI; nargs: Cuint; rtype: ptr TType; 
               atypes: ptr ptr TType): Tstatus {.cdecl, importc: "ffi_prep_cif", 
    dynlib: libffidll.}
proc call*(cif: var Tcif; fn: proc () {.cdecl.}; rvalue: Pointer; 
           avalue: ptr Pointer) {.cdecl, importc: "ffi_call", dynlib: libffidll.}

# the same with an easier interface:
type
  TParamList* = Array[0..100, ptr TType]
  TArgList* = Array[0..100, Pointer]

proc prepCif*(cif: var Tcif; abi: TABI; nargs: Cuint; rtype: ptr TType; 
               atypes: TParamList): Tstatus {.cdecl, importc: "ffi_prep_cif",
    dynlib: libffidll.}
proc call*(cif: var Tcif; fn, rvalue: Pointer;
           avalue: TArgList) {.cdecl, importc: "ffi_call", dynlib: libffidll.}

# Useful for eliminating compiler warnings 
##define FFI_FN(f) ((void (*)(void))f)
