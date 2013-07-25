
import
  x, xlib

#const
#  libX11* = "libX11.so"

#
#  Automatically converted by H2Pas 0.99.15 from xresource.h
#  The following command line parameters were used:
#    -p
#    -T
#    -S
#    -d
#    -c
#    xresource.h
#

proc xpermalloc*(para1: int32): cstring{.cdecl, dynlib: libX11, importc.}
type
  PXrmQuark* = ptr TXrmQuark
  TXrmQuark* = int32
  TXrmQuarkList* = PXrmQuark
  PXrmQuarkList* = ptr TXrmQuarkList

proc nULLQUARK*(): TXrmQuark
type
  PXrmString* = ptr TXrmString
  TXrmString* = ptr char

proc nULLSTRING*(): TXrmString
proc xrmStringToQuark*(para1: cstring): TXrmQuark{.cdecl, dynlib: libX11,
    importc.}
proc xrmPermStringToQuark*(para1: cstring): TXrmQuark{.cdecl, dynlib: libX11,
    importc.}
proc xrmQuarkToString*(para1: TXrmQuark): TXrmString{.cdecl, dynlib: libX11,
    importc.}
proc xrmUniqueQuark*(): TXrmQuark{.cdecl, dynlib: libX11, importc.}
when defined(MACROS):
  proc xrmStringsEqual*(a1, a2: cstring): bool
type
  PXrmBinding* = ptr TXrmBinding
  TXrmBinding* = enum
    XrmBindTightly, XrmBindLoosely
  TXrmBindingList* = PXrmBinding
  PXrmBindingList* = ptr TXrmBindingList

proc xrmStringToQuarkList*(para1: cstring, para2: TXrmQuarkList){.cdecl,
    dynlib: libX11, importc.}
proc xrmStringToBindingQuarkList*(para1: cstring, para2: TXrmBindingList,
                                  para3: TXrmQuarkList){.cdecl, dynlib: libX11,
    importc.}
type
  PXrmName* = ptr TXrmName
  TXrmName* = TXrmQuark
  PXrmNameList* = ptr TXrmNameList
  TXrmNameList* = TXrmQuarkList

when defined(MACROS):
  proc xrmNameToString*(name: int32): TXrmString
  proc xrmStringToName*(str: cstring): int32
  proc xrmStringToNameList*(str: cstring, name: PXrmQuark)
type
  PXrmClass* = ptr TXrmClass
  TXrmClass* = TXrmQuark
  PXrmClassList* = ptr TXrmClassList
  TXrmClassList* = TXrmQuarkList

when defined(MACROS):
  proc xrmClassToString*(c_class: int32): TXrmString
  proc xrmStringToClass*(c_class: cstring): int32
  proc xrmStringToClassList*(str: cstring, c_class: PXrmQuark)
type
  PXrmRepresentation* = ptr TXrmRepresentation
  TXrmRepresentation* = TXrmQuark

when defined(MACROS):
  proc xrmStringToRepresentation*(str: cstring): int32
  proc xrmRepresentationToString*(thetype: int32): TXrmString
type
  PXrmValue* = ptr TXrmValue
  TXrmValue*{.final.} = object
    size*: int32
    address*: TXpointer

  TXrmValuePtr* = PXrmValue
  PXrmValuePtr* = ptr TXrmValuePtr
  PXrmHashBucketRec* = ptr TXrmHashBucketRec
  TXrmHashBucketRec*{.final.} = object
  TXrmHashBucket* = PXrmHashBucketRec
  PXrmHashBucket* = ptr TXrmHashBucket
  PXrmHashTable* = ptr TXrmHashTable
  TXrmHashTable* = ptr TXrmHashBucket
  TXrmDatabase* = PXrmHashBucketRec
  PXrmDatabase* = ptr TXrmDatabase

proc xrmDestroyDatabase*(para1: TXrmDatabase){.cdecl, dynlib: libX11, importc.}
proc xrmQPutResource*(para1: PXrmDatabase, para2: TXrmBindingList,
                      para3: TXrmQuarkList, para4: TXrmRepresentation,
                      para5: PXrmValue){.cdecl, dynlib: libX11, importc.}
proc xrmPutResource*(para1: PXrmDatabase, para2: cstring, para3: cstring,
                     para4: PXrmValue){.cdecl, dynlib: libX11, importc.}
proc xrmQPutStringResource*(para1: PXrmDatabase, para2: TXrmBindingList,
                            para3: TXrmQuarkList, para4: cstring){.cdecl,
    dynlib: libX11, importc.}
proc xrmPutStringResource*(para1: PXrmDatabase, para2: cstring, para3: cstring){.
    cdecl, dynlib: libX11, importc.}
proc xrmPutLineResource*(para1: PXrmDatabase, para2: cstring){.cdecl,
    dynlib: libX11, importc.}
proc xrmQGetResource*(para1: TXrmDatabase, para2: TXrmNameList,
                      para3: TXrmClassList, para4: PXrmRepresentation,
                      para5: PXrmValue): Tbool{.cdecl, dynlib: libX11, importc.}
proc xrmGetResource*(para1: TXrmDatabase, para2: cstring, para3: cstring,
                     para4: PPchar, para5: PXrmValue): Tbool{.cdecl,
    dynlib: libX11, importc.}
  # There is no definition of TXrmSearchList
  #function XrmQGetSearchList(para1:TXrmDatabase; para2:TXrmNameList; para3:TXrmClassList; para4:TXrmSearchList; para5:longint):Tbool;cdecl;external libX11;
  #function XrmQGetSearchResource(para1:TXrmSearchList; para2:TXrmName; para3:TXrmClass; para4:PXrmRepresentation; para5:PXrmValue):Tbool;cdecl;external libX11;
proc xrmSetDatabase*(para1: PDisplay, para2: TXrmDatabase){.cdecl,
    dynlib: libX11, importc.}
proc xrmGetDatabase*(para1: PDisplay): TXrmDatabase{.cdecl, dynlib: libX11,
    importc.}
proc xrmGetFileDatabase*(para1: cstring): TXrmDatabase{.cdecl, dynlib: libX11,
    importc.}
proc xrmCombineFileDatabase*(para1: cstring, para2: PXrmDatabase, para3: Tbool): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xrmGetStringDatabase*(para1: cstring): TXrmDatabase{.cdecl, dynlib: libX11,
    importc.}
proc xrmPutFileDatabase*(para1: TXrmDatabase, para2: cstring){.cdecl,
    dynlib: libX11, importc.}
proc xrmMergeDatabases*(para1: TXrmDatabase, para2: PXrmDatabase){.cdecl,
    dynlib: libX11, importc.}
proc xrmCombineDatabase*(para1: TXrmDatabase, para2: PXrmDatabase, para3: Tbool){.
    cdecl, dynlib: libX11, importc.}
const
  XrmEnumAllLevels* = 0
  XrmEnumOneLevel* = 1

type
  funcbool* = proc (): Tbool {.cdecl.}

proc xrmEnumerateDatabase*(para1: TXrmDatabase, para2: TXrmNameList,
                           para3: TXrmClassList, para4: int32, para5: funcbool,
                           para6: TXpointer): Tbool{.cdecl, dynlib: libX11,
    importc.}
proc xrmLocaleOfDatabase*(para1: TXrmDatabase): cstring{.cdecl, dynlib: libX11,
    importc.}
type
  PXrmOptionKind* = ptr TXrmOptionKind
  TXrmOptionKind* = enum
    XrmoptionNoArg, XrmoptionIsArg, XrmoptionStickyArg, XrmoptionSepArg,
    XrmoptionResArg, XrmoptionSkipArg, XrmoptionSkipLine, XrmoptionSkipNArgs
  PXrmOptionDescRec* = ptr TXrmOptionDescRec
  TXrmOptionDescRec*{.final.} = object
    option*: cstring
    specifier*: cstring
    argKind*: TXrmOptionKind
    value*: TXpointer

  TXrmOptionDescList* = PXrmOptionDescRec
  PXrmOptionDescList* = ptr TXrmOptionDescList

proc xrmParseCommand*(para1: PXrmDatabase, para2: TXrmOptionDescList,
                      para3: int32, para4: cstring, para5: ptr int32,
                      para6: PPchar){.cdecl, dynlib: libX11, importc.}
# implementation

proc nULLQUARK(): TXrmQuark =
  result = TXrmQuark(0)

proc nULLSTRING(): TXrmString =
  result = nil

when defined(MACROS):
  proc xrmStringsEqual(a1, a2: cstring): bool =
    result = (strcomp(a1, a2)) == 0

  proc xrmNameToString(name: int32): TXrmString =
    result = XrmQuarkToString(name)

  proc xrmStringToName(str: cstring): int32 =
    result = XrmStringToQuark(str)

  proc xrmStringToNameList(str: cstring, name: PXrmQuark) =
    XrmStringToQuarkList(str, name)

  proc xrmClassToString(c_class: int32): TXrmString =
    result = XrmQuarkToString(c_class)

  proc xrmStringToClass(c_class: cstring): int32 =
    result = XrmStringToQuark(c_class)

  proc xrmStringToClassList(str: cstring, c_class: PXrmQuark) =
    XrmStringToQuarkList(str, c_class)

  proc xrmStringToRepresentation(str: cstring): int32 =
    result = XrmStringToQuark(str)

  proc xrmRepresentationToString(thetype: int32): TXrmString =
    result = XrmQuarkToString(thetype)
