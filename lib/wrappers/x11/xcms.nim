
import
  x, xlib

#const
#  libX11* = "X11"

#
#  Automatically converted by H2Pas 0.99.15 from xcms.h
#  The following command line parameters were used:
#    -p
#    -T
#    -S
#    -d
#    -c
#    xcms.h
#

const
  XcmsFailure* = 0
  XcmsSuccess* = 1
  XcmsSuccessWithCompression* = 2

type
  PXcmsColorFormat* = ptr TXcmsColorFormat
  TXcmsColorFormat* = int32

proc xcmsUndefinedFormat*(): TXcmsColorFormat
proc xcmsCIEXYZFormat*(): TXcmsColorFormat
proc xcmsCIEuvYFormat*(): TXcmsColorFormat
proc xcmsCIExyYFormat*(): TXcmsColorFormat
proc xcmsCIELabFormat*(): TXcmsColorFormat
proc xcmsCIELuvFormat*(): TXcmsColorFormat
proc xcmsTekHVCFormat*(): TXcmsColorFormat
proc xcmsRGBFormat*(): TXcmsColorFormat
proc xcmsRGBiFormat*(): TXcmsColorFormat
const
  XcmsInitNone* = 0x00000000
  XcmsInitSuccess* = 0x00000001
  XcmsInitFailure* = 0x000000FF

when defined(MACROS):
  proc displayOfCCC*(ccc: int32): int32
  proc screenNumberOfCCC*(ccc: int32): int32
  proc visualOfCCC*(ccc: int32): int32
  proc clientWhitePointOfCCC*(ccc: int32): int32
  proc screenWhitePointOfCCC*(ccc: int32): int32
  proc functionSetOfCCC*(ccc: int32): int32
type
  PXcmsFloat* = ptr TXcmsFloat
  TXcmsFloat* = float64
  PXcmsRGB* = ptr TXcmsRGB
  TXcmsRGB*{.final.} = object
    red*: int16
    green*: int16
    blue*: int16

  PXcmsRGBi* = ptr TXcmsRGBi
  TXcmsRGBi*{.final.} = object
    red*: TXcmsFloat
    green*: TXcmsFloat
    blue*: TXcmsFloat

  PXcmsCIEXYZ* = ptr TXcmsCIEXYZ
  TXcmsCIEXYZ*{.final.} = object
    X*: TXcmsFloat
    Y*: TXcmsFloat
    Z*: TXcmsFloat

  PXcmsCIEuvY* = ptr TXcmsCIEuvY
  TXcmsCIEuvY*{.final.} = object
    u_prime*: TXcmsFloat
    v_prime*: TXcmsFloat
    Y*: TXcmsFloat

  PXcmsCIExyY* = ptr TXcmsCIExyY
  TXcmsCIExyY*{.final.} = object
    x*: TXcmsFloat
    y*: TXcmsFloat
    theY*: TXcmsFloat

  PXcmsCIELab* = ptr TXcmsCIELab
  TXcmsCIELab*{.final.} = object
    L_star*: TXcmsFloat
    a_star*: TXcmsFloat
    b_star*: TXcmsFloat

  PXcmsCIELuv* = ptr TXcmsCIELuv
  TXcmsCIELuv*{.final.} = object
    L_star*: TXcmsFloat
    u_star*: TXcmsFloat
    v_star*: TXcmsFloat

  PXcmsTekHVC* = ptr TXcmsTekHVC
  TXcmsTekHVC*{.final.} = object
    H*: TXcmsFloat
    V*: TXcmsFloat
    C*: TXcmsFloat

  PXcmsPad* = ptr TXcmsPad
  TXcmsPad*{.final.} = object
    pad0*: TXcmsFloat
    pad1*: TXcmsFloat
    pad2*: TXcmsFloat
    pad3*: TXcmsFloat

  PXcmsColor* = ptr TXcmsColor
  TXcmsColor*{.final.} = object  # spec : record
                                 #            case longint of
                                 #               0 : ( RGB : TXcmsRGB );
                                 #               1 : ( RGBi : TXcmsRGBi );
                                 #               2 : ( CIEXYZ : TXcmsCIEXYZ );
                                 #               3 : ( CIEuvY : TXcmsCIEuvY );
                                 #               4 : ( CIExyY : TXcmsCIExyY );
                                 #               5 : ( CIELab : TXcmsCIELab );
                                 #               6 : ( CIELuv : TXcmsCIELuv );
                                 #               7 : ( TekHVC : TXcmsTekHVC );
                                 #               8 : ( Pad : TXcmsPad );
                                 #            end;
    pad*: TXcmsPad
    pixel*: int32
    format*: TXcmsColorFormat

  PXcmsPerScrnInfo* = ptr TXcmsPerScrnInfo
  TXcmsPerScrnInfo*{.final.} = object
    screenWhitePt*: TXcmsColor
    functionSet*: TXpointer
    screenData*: TXpointer
    state*: int8
    pad*: array[0..2, char]

  PXcmsCCC* = ptr TXcmsCCC
  TXcmsCompressionProc* = proc (para1: PXcmsCCC, para2: PXcmsColor,
                                para3: int32, para4: int32, para5: Pbool): TStatus{.
      cdecl.}
  TXcmsWhiteAdjustProc* = proc (para1: PXcmsCCC, para2: PXcmsColor,
                                para3: PXcmsColor, para4: TXcmsColorFormat,
                                para5: PXcmsColor, para6: int32, para7: Pbool): TStatus{.
      cdecl.}
  TXcmsCCC*{.final.} = object
    dpy*: PDisplay
    screenNumber*: int32
    visual*: PVisual
    clientWhitePt*: TXcmsColor
    gamutCompProc*: TXcmsCompressionProc
    gamutCompClientData*: TXpointer
    whitePtAdjProc*: TXcmsWhiteAdjustProc
    whitePtAdjClientData*: TXpointer
    pPerScrnInfo*: PXcmsPerScrnInfo

  TXcmsCCCRec* = TXcmsCCC
  PXcmsCCCRec* = ptr TXcmsCCCRec
  TXcmsScreenInitProc* = proc (para1: PDisplay, para2: int32,
                               para3: PXcmsPerScrnInfo): TStatus{.cdecl.}
  TXcmsScreenFreeProc* = proc (para1: TXpointer){.cdecl.}
  TXcmsConversionProc* = proc (){.cdecl.}
  PXcmsFuncListPtr* = ptr TXcmsFuncListPtr
  TXcmsFuncListPtr* = TXcmsConversionProc
  TXcmsParseStringProc* = proc (para1: cstring, para2: PXcmsColor): int32{.cdecl.}
  PXcmsColorSpace* = ptr TXcmsColorSpace
  TXcmsColorSpace*{.final.} = object
    prefix*: cstring
    id*: TXcmsColorFormat
    parseString*: TXcmsParseStringProc
    to_CIEXYZ*: TXcmsFuncListPtr
    from_CIEXYZ*: TXcmsFuncListPtr
    inverse_flag*: int32

  PXcmsFunctionSet* = ptr TXcmsFunctionSet
  TXcmsFunctionSet*{.final.} = object  # error
                                       #extern Status XcmsAddColorSpace (
                                       #in declaration at line 323
    DDColorSpaces*: ptr PXcmsColorSpace
    screenInitProc*: TXcmsScreenInitProc
    screenFreeProc*: TXcmsScreenFreeProc


proc xcmsAddFunctionSet*(para1: PXcmsFunctionSet): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsallocColor*(para1: PDisplay, para2: TColormap, para3: PXcmsColor,
                     para4: TXcmsColorFormat): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsallocNamedColor*(para1: PDisplay, para2: TColormap, para3: cstring,
                          para4: PXcmsColor, para5: PXcmsColor,
                          para6: TXcmsColorFormat): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCCCOfColormap*(para1: PDisplay, para2: TColormap): TXcmsCCC{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCIELabClipab*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                       para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCIELabClipL*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                      para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCIELabClipLab*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                        para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCIELabQueryMaxC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsCIELabQueryMaxL*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsCIELabQueryMaxLC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsCIELabQueryMinL*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsCIELabToCIEXYZ*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIELabWhiteShiftColors*(para1: TXcmsCCC, para2: PXcmsColor,
                                 para3: PXcmsColor, para4: TXcmsColorFormat,
                                 para5: PXcmsColor, para6: int32, para7: Pbool): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsCIELuvClipL*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                      para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCIELuvClipLuv*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                        para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCIELuvClipuv*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                       para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCIELuvQueryMaxC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsCIELuvQueryMaxL*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsCIELuvQueryMaxLC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsCIELuvQueryMinL*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsCIELuvToCIEuvY*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIELuvWhiteShiftColors*(para1: TXcmsCCC, para2: PXcmsColor,
                                 para3: PXcmsColor, para4: TXcmsColorFormat,
                                 para5: PXcmsColor, para6: int32, para7: Pbool): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsCIEXYZToCIELab*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIEXYZToCIEuvY*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIEXYZToCIExyY*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIEXYZToRGBi*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                       para4: Pbool): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIEuvYToCIELuv*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIEuvYToCIEXYZ*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIEuvYToTekHVC*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsCIExyYToCIEXYZ*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsClientWhitePointOfCCC*(para1: TXcmsCCC): PXcmsColor{.cdecl,
    dynlib: libX11, importc.}
proc xcmsConvertColors*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                        para4: TXcmsColorFormat, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsCreateCCC*(para1: PDisplay, para2: int32, para3: PVisual,
                    para4: PXcmsColor, para5: TXcmsCompressionProc,
                    para6: TXpointer, para7: TXcmsWhiteAdjustProc,
                    para8: TXpointer): TXcmsCCC{.cdecl, dynlib: libX11, importc.}
proc xcmsDefaultCCC*(para1: PDisplay, para2: int32): TXcmsCCC{.cdecl,
    dynlib: libX11, importc.}
proc xcmsDisplayOfCCC*(para1: TXcmsCCC): PDisplay{.cdecl, dynlib: libX11,
    importc.}
proc xcmsFormatOfPrefix*(para1: cstring): TXcmsColorFormat{.cdecl,
    dynlib: libX11, importc.}
proc xcmsFreeCCC*(para1: TXcmsCCC){.cdecl, dynlib: libX11, importc.}
proc xcmsLookupColor*(para1: PDisplay, para2: TColormap, para3: cstring,
                      para4: PXcmsColor, para5: PXcmsColor,
                      para6: TXcmsColorFormat): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsPrefixOfFormat*(para1: TXcmsColorFormat): cstring{.cdecl,
    dynlib: libX11, importc.}
proc xcmsQueryBlack*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsQueryBlue*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsQueryColor*(para1: PDisplay, para2: TColormap, para3: PXcmsColor,
                     para4: TXcmsColorFormat): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsQueryColors*(para1: PDisplay, para2: TColormap, para3: PXcmsColor,
                      para4: int32, para5: TXcmsColorFormat): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsQueryGreen*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsQueryRed*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsQueryWhite*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsRGBiToCIEXYZ*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                       para4: Pbool): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsRGBiToRGB*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                    para4: Pbool): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsRGBToRGBi*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                    para4: Pbool): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsScreenNumberOfCCC*(para1: TXcmsCCC): int32{.cdecl, dynlib: libX11,
    importc.}
proc xcmsScreenWhitePointOfCCC*(para1: TXcmsCCC): PXcmsColor{.cdecl,
    dynlib: libX11, importc.}
proc xcmsSetCCCOfColormap*(para1: PDisplay, para2: TColormap, para3: TXcmsCCC): TXcmsCCC{.
    cdecl, dynlib: libX11, importc.}
proc xcmsSetCompressionProc*(para1: TXcmsCCC, para2: TXcmsCompressionProc,
                             para3: TXpointer): TXcmsCompressionProc{.cdecl,
    dynlib: libX11, importc.}
proc xcmsSetWhiteAdjustProc*(para1: TXcmsCCC, para2: TXcmsWhiteAdjustProc,
                             para3: TXpointer): TXcmsWhiteAdjustProc{.cdecl,
    dynlib: libX11, importc.}
proc xcmsSetWhitePoint*(para1: TXcmsCCC, para2: PXcmsColor): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsStoreColor*(para1: PDisplay, para2: TColormap, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsStoreColors*(para1: PDisplay, para2: TColormap, para3: PXcmsColor,
                      para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsTekHVCClipC*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                      para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsTekHVCClipV*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                      para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsTekHVCClipVC*(para1: TXcmsCCC, para2: PXcmsColor, para3: int32,
                       para4: int32, para5: Pbool): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xcmsTekHVCQueryMaxC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsTekHVCQueryMaxV*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsTekHVCQueryMaxVC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsTekHVCQueryMaxVSamples*(para1: TXcmsCCC, para2: TXcmsFloat,
                                 para3: PXcmsColor, para4: int32): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsTekHVCQueryMinV*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat,
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xcmsTekHVCToCIEuvY*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor,
                         para4: int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc xcmsTekHVCWhiteShiftColors*(para1: TXcmsCCC, para2: PXcmsColor,
                                 para3: PXcmsColor, para4: TXcmsColorFormat,
                                 para5: PXcmsColor, para6: int32, para7: Pbool): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xcmsVisualOfCCC*(para1: TXcmsCCC): PVisual{.cdecl, dynlib: libX11, importc.}
# implementation

proc xcmsUndefinedFormat(): TXcmsColorFormat =
  result = 0x00000000'i32

proc xcmsCIEXYZFormat(): TXcmsColorFormat =
  result = 0x00000001'i32

proc xcmsCIEuvYFormat(): TXcmsColorFormat =
  result = 0x00000002'i32

proc xcmsCIExyYFormat(): TXcmsColorFormat =
  result = 0x00000003'i32

proc xcmsCIELabFormat(): TXcmsColorFormat =
  result = 0x00000004'i32

proc xcmsCIELuvFormat(): TXcmsColorFormat =
  result = 0x00000005'i32

proc xcmsTekHVCFormat(): TXcmsColorFormat =
  result = 0x00000006'i32

proc xcmsRGBFormat(): TXcmsColorFormat =
  result = 0x80000000'i32

proc xcmsRGBiFormat(): TXcmsColorFormat =
  result = 0x80000001'i32

when defined(MACROS):
  proc displayOfCCC(ccc: int32): int32 =
    result = ccc.dpy

  proc screenNumberOfCCC(ccc: int32): int32 =
    result = ccc.screenNumber

  proc visualOfCCC(ccc: int32): int32 =
    result = ccc.visual

  proc clientWhitePointOfCCC(ccc: int32): int32 =
    result = addr(ccc.clientWhitePt)

  proc screenWhitePointOfCCC(ccc: int32): int32 =
    result = addr(ccc.pPerScrnInfo.screenWhitePt)

  proc functionSetOfCCC(ccc: int32): int32 =
    result = ccc.pPerScrnInfo.functionSet
