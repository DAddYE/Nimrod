
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
  TXcmsColorFormat* = Int32

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
  proc DisplayOfCCC*(ccc: int32): int32
  proc ScreenNumberOfCCC*(ccc: int32): int32
  proc VisualOfCCC*(ccc: int32): int32
  proc ClientWhitePointOfCCC*(ccc: int32): int32
  proc ScreenWhitePointOfCCC*(ccc: int32): int32
  proc FunctionSetOfCCC*(ccc: int32): int32
type 
  PXcmsFloat* = ptr TXcmsFloat
  TXcmsFloat* = Float64
  PXcmsRGB* = ptr TXcmsRGB
  TXcmsRGB*{.final.} = object 
    red*: Int16
    green*: Int16
    blue*: Int16

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
    pixel*: Int32
    format*: TXcmsColorFormat

  PXcmsPerScrnInfo* = ptr TXcmsPerScrnInfo
  TXcmsPerScrnInfo*{.final.} = object 
    screenWhitePt*: TXcmsColor
    functionSet*: TXPointer
    screenData*: TXPointer
    state*: Int8
    pad*: Array[0..2, Char]

  PXcmsCCC* = ptr TXcmsCCC
  TXcmsCompressionProc* = proc (para1: PXcmsCCC, para2: PXcmsColor, 
                                para3: Int32, para4: Int32, para5: PBool): TStatus{.
      cdecl.}
  TXcmsWhiteAdjustProc* = proc (para1: PXcmsCCC, para2: PXcmsColor, 
                                para3: PXcmsColor, para4: TXcmsColorFormat, 
                                para5: PXcmsColor, para6: Int32, para7: PBool): TStatus{.
      cdecl.}
  TXcmsCCC*{.final.} = object 
    dpy*: PDisplay
    screenNumber*: Int32
    visual*: PVisual
    clientWhitePt*: TXcmsColor
    gamutCompProc*: TXcmsCompressionProc
    gamutCompClientData*: TXPointer
    whitePtAdjProc*: TXcmsWhiteAdjustProc
    whitePtAdjClientData*: TXPointer
    pPerScrnInfo*: PXcmsPerScrnInfo

  TXcmsCCCRec* = TXcmsCCC
  PXcmsCCCRec* = ptr TXcmsCCCRec
  TXcmsScreenInitProc* = proc (para1: PDisplay, para2: Int32, 
                               para3: PXcmsPerScrnInfo): TStatus{.cdecl.}
  TXcmsScreenFreeProc* = proc (para1: TXPointer){.cdecl.}
  TXcmsConversionProc* = proc (){.cdecl.}
  PXcmsFuncListPtr* = ptr TXcmsFuncListPtr
  TXcmsFuncListPtr* = TXcmsConversionProc
  TXcmsParseStringProc* = proc (para1: Cstring, para2: PXcmsColor): Int32{.cdecl.}
  PXcmsColorSpace* = ptr TXcmsColorSpace
  TXcmsColorSpace*{.final.} = object 
    prefix*: Cstring
    id*: TXcmsColorFormat
    parseString*: TXcmsParseStringProc
    to_CIEXYZ*: TXcmsFuncListPtr
    from_CIEXYZ*: TXcmsFuncListPtr
    inverse_flag*: Int32

  PXcmsFunctionSet* = ptr TXcmsFunctionSet
  TXcmsFunctionSet*{.final.} = object  # error
                                       #extern Status XcmsAddColorSpace (
                                       #in declaration at line 323 
    DDColorSpaces*: ptr PXcmsColorSpace
    screenInitProc*: TXcmsScreenInitProc
    screenFreeProc*: TXcmsScreenFreeProc


proc XcmsAddFunctionSet*(para1: PXcmsFunctionSet): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsAllocColor*(para1: PDisplay, para2: TColormap, para3: PXcmsColor, 
                     para4: TXcmsColorFormat): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsAllocNamedColor*(para1: PDisplay, para2: TColormap, para3: Cstring, 
                          para4: PXcmsColor, para5: PXcmsColor, 
                          para6: TXcmsColorFormat): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCCCOfColormap*(para1: PDisplay, para2: TColormap): TXcmsCCC{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCIELabClipab*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                       para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCIELabClipL*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                      para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCIELabClipLab*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                        para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCIELabQueryMaxC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsCIELabQueryMaxL*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsCIELabQueryMaxLC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsCIELabQueryMinL*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsCIELabToCIEXYZ*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIELabWhiteShiftColors*(para1: TXcmsCCC, para2: PXcmsColor, 
                                 para3: PXcmsColor, para4: TXcmsColorFormat, 
                                 para5: PXcmsColor, para6: Int32, para7: PBool): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsCIELuvClipL*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                      para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCIELuvClipLuv*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                        para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCIELuvClipuv*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                       para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCIELuvQueryMaxC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsCIELuvQueryMaxL*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsCIELuvQueryMaxLC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsCIELuvQueryMinL*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsCIELuvToCIEuvY*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIELuvWhiteShiftColors*(para1: TXcmsCCC, para2: PXcmsColor, 
                                 para3: PXcmsColor, para4: TXcmsColorFormat, 
                                 para5: PXcmsColor, para6: Int32, para7: PBool): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsCIEXYZToCIELab*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIEXYZToCIEuvY*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIEXYZToCIExyY*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIEXYZToRGBi*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                       para4: PBool): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIEuvYToCIELuv*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIEuvYToCIEXYZ*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIEuvYToTekHVC*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsCIExyYToCIEXYZ*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsClientWhitePointOfCCC*(para1: TXcmsCCC): PXcmsColor{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsConvertColors*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                        para4: TXcmsColorFormat, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsCreateCCC*(para1: PDisplay, para2: Int32, para3: PVisual, 
                    para4: PXcmsColor, para5: TXcmsCompressionProc, 
                    para6: TXPointer, para7: TXcmsWhiteAdjustProc, 
                    para8: TXPointer): TXcmsCCC{.cdecl, dynlib: libX11, importc.}
proc XcmsDefaultCCC*(para1: PDisplay, para2: Int32): TXcmsCCC{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsDisplayOfCCC*(para1: TXcmsCCC): PDisplay{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsFormatOfPrefix*(para1: Cstring): TXcmsColorFormat{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsFreeCCC*(para1: TXcmsCCC){.cdecl, dynlib: libX11, importc.}
proc XcmsLookupColor*(para1: PDisplay, para2: TColormap, para3: Cstring, 
                      para4: PXcmsColor, para5: PXcmsColor, 
                      para6: TXcmsColorFormat): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsPrefixOfFormat*(para1: TXcmsColorFormat): Cstring{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsQueryBlack*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsQueryBlue*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsQueryColor*(para1: PDisplay, para2: TColormap, para3: PXcmsColor, 
                     para4: TXcmsColorFormat): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsQueryColors*(para1: PDisplay, para2: TColormap, para3: PXcmsColor, 
                      para4: Int32, para5: TXcmsColorFormat): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsQueryGreen*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsQueryRed*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsQueryWhite*(para1: TXcmsCCC, para2: TXcmsColorFormat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsRGBiToCIEXYZ*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                       para4: PBool): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsRGBiToRGB*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                    para4: PBool): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsRGBToRGBi*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                    para4: PBool): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsScreenNumberOfCCC*(para1: TXcmsCCC): Int32{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsScreenWhitePointOfCCC*(para1: TXcmsCCC): PXcmsColor{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsSetCCCOfColormap*(para1: PDisplay, para2: TColormap, para3: TXcmsCCC): TXcmsCCC{.
    cdecl, dynlib: libX11, importc.}
proc XcmsSetCompressionProc*(para1: TXcmsCCC, para2: TXcmsCompressionProc, 
                             para3: TXPointer): TXcmsCompressionProc{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsSetWhiteAdjustProc*(para1: TXcmsCCC, para2: TXcmsWhiteAdjustProc, 
                             para3: TXPointer): TXcmsWhiteAdjustProc{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsSetWhitePoint*(para1: TXcmsCCC, para2: PXcmsColor): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsStoreColor*(para1: PDisplay, para2: TColormap, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsStoreColors*(para1: PDisplay, para2: TColormap, para3: PXcmsColor, 
                      para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsTekHVCClipC*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                      para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsTekHVCClipV*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                      para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsTekHVCClipVC*(para1: TXcmsCCC, para2: PXcmsColor, para3: Int32, 
                       para4: Int32, para5: PBool): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XcmsTekHVCQueryMaxC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsTekHVCQueryMaxV*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsTekHVCQueryMaxVC*(para1: TXcmsCCC, para2: TXcmsFloat, para3: PXcmsColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsTekHVCQueryMaxVSamples*(para1: TXcmsCCC, para2: TXcmsFloat, 
                                 para3: PXcmsColor, para4: Int32): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsTekHVCQueryMinV*(para1: TXcmsCCC, para2: TXcmsFloat, para3: TXcmsFloat, 
                          para4: PXcmsColor): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XcmsTekHVCToCIEuvY*(para1: TXcmsCCC, para2: PXcmsColor, para3: PXcmsColor, 
                         para4: Int32): TStatus{.cdecl, dynlib: libX11, importc.}
proc XcmsTekHVCWhiteShiftColors*(para1: TXcmsCCC, para2: PXcmsColor, 
                                 para3: PXcmsColor, para4: TXcmsColorFormat, 
                                 para5: PXcmsColor, para6: Int32, para7: PBool): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XcmsVisualOfCCC*(para1: TXcmsCCC): PVisual{.cdecl, dynlib: libX11, importc.}
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
  proc DisplayOfCCC(ccc: int32): int32 = 
    result = ccc.dpy

  proc ScreenNumberOfCCC(ccc: int32): int32 = 
    result = ccc.screenNumber

  proc VisualOfCCC(ccc: int32): int32 = 
    result = ccc.visual

  proc ClientWhitePointOfCCC(ccc: int32): int32 = 
    result = addr(ccc.clientWhitePt)

  proc ScreenWhitePointOfCCC(ccc: int32): int32 = 
    result = addr(ccc.pPerScrnInfo.screenWhitePt)

  proc FunctionSetOfCCC(ccc: int32): int32 = 
    result = ccc.pPerScrnInfo.functionSet
