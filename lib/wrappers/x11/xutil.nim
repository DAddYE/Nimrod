
import
  x, xlib, keysym

#const
#  libX11* = "libX11.so"

#
#  Automatically converted by H2Pas 0.99.15 from xutil.h
#  The following command line parameters were used:
#    -p
#    -T
#    -S
#    -d
#    -c
#    xutil.h
#

const
  NoValue* = 0x00000000
  XValue* = 0x00000001
  YValue* = 0x00000002
  WidthValue* = 0x00000004
  HeightValue* = 0x00000008
  AllValues* = 0x0000000F
  XNegative* = 0x00000010
  YNegative* = 0x00000020

type
  TCPoint*{.final.} = object
    x*: cint
    y*: cint

  PXSizeHints* = ptr TXSizeHints
  TXSizeHints*{.final.} = object
    flags*: clong
    x*, y*: cint
    width*, height*: cint
    min_width*, min_height*: cint
    max_width*, max_height*: cint
    width_inc*, height_inc*: cint
    min_aspect*, max_aspect*: TCPoint
    base_width*, base_height*: cint
    win_gravity*: cint


const
  USPosition* = 1 shl 0
  USSize* = 1 shl 1
  PPosition* = 1 shl 2
  PSize* = 1 shl 3
  PMinSize* = 1 shl 4
  PMaxSize* = 1 shl 5
  PResizeInc* = 1 shl 6
  PAspect* = 1 shl 7
  PBaseSize* = 1 shl 8
  PWinGravity* = 1 shl 9
  PAllHints* = PPosition or PSize or PMinSize or PMaxSize or PResizeInc or
      PAspect

type
  PXWMHints* = ptr TXWMHints
  TXWMHints*{.final.} = object
    flags*: clong
    input*: Tbool
    initial_state*: cint
    icon_pixmap*: TPixmap
    icon_window*: TWindow
    icon_x*, icon_y*: cint
    icon_mask*: TPixmap
    window_group*: TXID


const
  InputHint* = 1 shl 0
  StateHint* = 1 shl 1
  IconPixmapHint* = 1 shl 2
  IconWindowHint* = 1 shl 3
  IconPositionHint* = 1 shl 4
  IconMaskHint* = 1 shl 5
  WindowGroupHint* = 1 shl 6
  AllHints* = InputHint or StateHint or IconPixmapHint or IconWindowHint or
      IconPositionHint or IconMaskHint or WindowGroupHint
  XUrgencyHint* = 1 shl 8
  WithdrawnState* = 0
  NormalState* = 1
  IconicState* = 3
  DontCareState* = 0
  ZoomState* = 2
  InactiveState* = 4

type
  PXTextProperty* = ptr TXTextProperty
  TXTextProperty*{.final.} = object
    value*: pcuchar
    encoding*: TAtom
    format*: cint
    nitems*: culong


const
  XNoMemory* = - 1
  XLocaleNotSupported* = - 2
  XConverterNotFound* = - 3

type
  PXICCEncodingStyle* = ptr TXICCEncodingStyle
  TXICCEncodingStyle* = enum
    XStringStyle, XCompoundTextStyle, XTextStyle, XStdICCTextStyle,
    XUTF8StringStyle
  PPXIconSize* = ptr PXIconSize
  PXIconSize* = ptr TXIconSize
  TXIconSize*{.final.} = object
    min_width*, min_height*: cint
    max_width*, max_height*: cint
    width_inc*, height_inc*: cint

  PXClassHint* = ptr TXClassHint
  TXClassHint*{.final.} = object
    res_name*: cstring
    res_class*: cstring


type
  PXComposeStatus* = ptr TXComposeStatus
  TXComposeStatus*{.final.} = object
    compose_ptr*: TXpointer
    chars_matched*: cint


type
  PXRegion* = ptr TXRegion
  TXRegion*{.final.} = object
  TRegion* = PXRegion
  PRegion* = ptr TRegion

const
  RectangleOut* = 0
  RectangleIn* = 1
  RectanglePart* = 2

type
  PXVisualInfo* = ptr TXVisualInfo
  TXVisualInfo*{.final.} = object
    visual*: PVisual
    visualid*: TVisualID
    screen*: cint
    depth*: cint
    class*: cint
    red_mask*: culong
    green_mask*: culong
    blue_mask*: culong
    colormap_size*: cint
    bits_per_rgb*: cint


const
  VisualNoMask* = 0x00000000
  VisualIDMask* = 0x00000001
  VisualScreenMask* = 0x00000002
  VisualDepthMask* = 0x00000004
  VisualClassMask* = 0x00000008
  VisualRedMaskMask* = 0x00000010
  VisualGreenMaskMask* = 0x00000020
  VisualBlueMaskMask* = 0x00000040
  VisualColormapSizeMask* = 0x00000080
  VisualBitsPerRGBMask* = 0x00000100
  VisualAllMask* = 0x000001FF

type
  PPXStandardColormap* = ptr PXStandardColormap
  PXStandardColormap* = ptr TXStandardColormap
  TXStandardColormap*{.final.} = object
    colormap*: TColormap
    red_max*: culong
    red_mult*: culong
    green_max*: culong
    green_mult*: culong
    blue_max*: culong
    blue_mult*: culong
    base_pixel*: culong
    visualid*: TVisualID
    killid*: TXID


const
  BitmapSuccess* = 0
  BitmapOpenFailed* = 1
  BitmapFileInvalid* = 2
  BitmapNoMemory* = 3
  XCSUCCESS* = 0
  XCNOMEM* = 1
  XCNOENT* = 2
  ReleaseByFreeingColormap*: TXID = TXID(1)

type
  PXContext* = ptr TXContext
  TXContext* = cint

proc xallocClassHint*(): PXClassHint{.cdecl, dynlib: libX11, importc.}
proc xallocIconSize*(): PXIconSize{.cdecl, dynlib: libX11, importc.}
proc xallocSizeHints*(): PXSizeHints{.cdecl, dynlib: libX11, importc.}
proc xallocStandardColormap*(): PXStandardColormap{.cdecl, dynlib: libX11,
    importc.}
proc xallocWMHints*(): PXWMHints{.cdecl, dynlib: libX11, importc.}
proc xClipBox*(para1: TRegion, para2: PXRectangle): cint{.cdecl, dynlib: libX11,
    importc.}
proc xCreateRegion*(): TRegion{.cdecl, dynlib: libX11, importc.}
proc xDefaultString*(): cstring{.cdecl, dynlib: libX11, importc.}
proc xDeleteContext*(para1: PDisplay, para2: TXID, para3: TXContext): cint{.
    cdecl, dynlib: libX11, importc.}
proc xDestroyRegion*(para1: TRegion): cint{.cdecl, dynlib: libX11, importc.}
proc xEmptyRegion*(para1: TRegion): cint{.cdecl, dynlib: libX11, importc.}
proc xEqualRegion*(para1: TRegion, para2: TRegion): cint{.cdecl, dynlib: libX11,
    importc.}
proc xFindContext*(para1: PDisplay, para2: TXID, para3: TXContext,
                   para4: PXpointer): cint{.cdecl, dynlib: libX11, importc.}
proc xGetClassHint*(para1: PDisplay, para2: TWindow, para3: PXClassHint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetIconSizes*(para1: PDisplay, para2: TWindow, para3: PPXIconSize,
                    para4: Pcint): TStatus{.cdecl, dynlib: libX11, importc.}
proc xGetNormalHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetRGBColormaps*(para1: PDisplay, para2: TWindow,
                       para3: PPXStandardColormap, para4: Pcint, para5: TAtom): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetSizeHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints,
                    para4: TAtom): TStatus{.cdecl, dynlib: libX11, importc.}
proc xGetStandardColormap*(para1: PDisplay, para2: TWindow,
                           para3: PXStandardColormap, para4: TAtom): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetTextProperty*(para1: PDisplay, para2: TWindow, para3: PXTextProperty,
                       para4: TAtom): TStatus{.cdecl, dynlib: libX11, importc.}
proc xGetVisualInfo*(para1: PDisplay, para2: clong, para3: PXVisualInfo,
                     para4: Pcint): PXVisualInfo{.cdecl, dynlib: libX11, importc.}
proc xGetWMClientMachine*(para1: PDisplay, para2: TWindow, para3: PXTextProperty): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetWMHints*(para1: PDisplay, para2: TWindow): PXWMHints{.cdecl,
    dynlib: libX11, importc.}
proc xGetWMIconName*(para1: PDisplay, para2: TWindow, para3: PXTextProperty): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetWMName*(para1: PDisplay, para2: TWindow, para3: PXTextProperty): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetWMNormalHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints,
                        para4: ptr int): TStatus{.cdecl, dynlib: libX11, importc.}
proc xGetWMSizeHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints,
                      para4: ptr int, para5: TAtom): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xGetZoomHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xIntersectRegion*(para1: TRegion, para2: TRegion, para3: TRegion): cint{.
    cdecl, dynlib: libX11, importc.}
proc xConvertCase*(para1: TKeySym, para2: PKeySym, para3: PKeySym){.cdecl,
    dynlib: libX11, importc.}
proc xLookupString*(para1: PXKeyEvent, para2: cstring, para3: cint,
                    para4: PKeySym, para5: PXComposeStatus): cint{.cdecl,
    dynlib: libX11, importc.}
proc xMatchVisualInfo*(para1: PDisplay, para2: cint, para3: cint, para4: cint,
                       para5: PXVisualInfo): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xOffsetRegion*(para1: TRegion, para2: cint, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xPointInRegion*(para1: TRegion, para2: cint, para3: cint): Tbool{.cdecl,
    dynlib: libX11, importc.}
proc xPolygonRegion*(para1: PXPoint, para2: cint, para3: cint): TRegion{.cdecl,
    dynlib: libX11, importc.}
proc xRectInRegion*(para1: TRegion, para2: cint, para3: cint, para4: cuint,
                    para5: cuint): cint{.cdecl, dynlib: libX11, importc.}
proc xSaveContext*(para1: PDisplay, para2: TXID, para3: TXContext,
                   para4: cstring): cint{.cdecl, dynlib: libX11, importc.}
proc xSetClassHint*(para1: PDisplay, para2: TWindow, para3: PXClassHint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetIconSizes*(para1: PDisplay, para2: TWindow, para3: PXIconSize,
                    para4: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xSetNormalHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetRGBColormaps*(para1: PDisplay, para2: TWindow,
                       para3: PXStandardColormap, para4: cint, para5: TAtom){.
    cdecl, dynlib: libX11, importc.}
proc xSetSizeHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints,
                    para4: TAtom): cint{.cdecl, dynlib: libX11, importc.}
proc xSetStandardProperties*(para1: PDisplay, para2: TWindow, para3: cstring,
                             para4: cstring, para5: TPixmap, para6: PPchar,
                             para7: cint, para8: PXSizeHints): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetTextProperty*(para1: PDisplay, para2: TWindow, para3: PXTextProperty,
                       para4: TAtom){.cdecl, dynlib: libX11, importc.}
proc xSetWMClientMachine*(para1: PDisplay, para2: TWindow, para3: PXTextProperty){.
    cdecl, dynlib: libX11, importc.}
proc xSetWMHints*(para1: PDisplay, para2: TWindow, para3: PXWMHints): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetWMIconName*(para1: PDisplay, para2: TWindow, para3: PXTextProperty){.
    cdecl, dynlib: libX11, importc.}
proc xSetWMName*(para1: PDisplay, para2: TWindow, para3: PXTextProperty){.cdecl,
    dynlib: libX11, importc.}
proc xSetWMNormalHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints){.
    cdecl, dynlib: libX11, importc.}
proc xSetWMProperties*(para1: PDisplay, para2: TWindow, para3: PXTextProperty,
                       para4: PXTextProperty, para5: PPchar, para6: cint,
                       para7: PXSizeHints, para8: PXWMHints, para9: PXClassHint){.
    cdecl, dynlib: libX11, importc.}
proc xmbSetWMProperties*(para1: PDisplay, para2: TWindow, para3: cstring,
                         para4: cstring, para5: PPchar, para6: cint,
                         para7: PXSizeHints, para8: PXWMHints,
                         para9: PXClassHint){.cdecl, dynlib: libX11, importc.}
proc xutf8SetWMProperties*(para1: PDisplay, para2: TWindow, para3: cstring,
                           para4: cstring, para5: PPchar, para6: cint,
                           para7: PXSizeHints, para8: PXWMHints,
                           para9: PXClassHint){.cdecl, dynlib: libX11, importc.}
proc xSetWMSizeHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints,
                      para4: TAtom){.cdecl, dynlib: libX11, importc.}
proc xSetRegion*(para1: PDisplay, para2: TGC, para3: TRegion): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetStandardColormap*(para1: PDisplay, para2: TWindow,
                           para3: PXStandardColormap, para4: TAtom){.cdecl,
    dynlib: libX11, importc.}
proc xSetZoomHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints): cint{.
    cdecl, dynlib: libX11, importc.}
proc xShrinkRegion*(para1: TRegion, para2: cint, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xStringListToTextProperty*(para1: PPchar, para2: cint,
                                para3: PXTextProperty): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xSubtractRegion*(para1: TRegion, para2: TRegion, para3: TRegion): cint{.
    cdecl, dynlib: libX11, importc.}
proc xmbTextListToTextProperty*(para1: PDisplay, para2: PPchar, para3: cint,
                                para4: TXICCEncodingStyle, para5: PXTextProperty): cint{.
    cdecl, dynlib: libX11, importc.}
proc xwcTextListToTextProperty*(para1: PDisplay, para2: ptr ptr int16, para3: cint,
                                para4: TXICCEncodingStyle, para5: PXTextProperty): cint{.
    cdecl, dynlib: libX11, importc.}
proc xutf8TextListToTextProperty*(para1: PDisplay, para2: PPchar, para3: cint,
                                  para4: TXICCEncodingStyle,
                                  para5: PXTextProperty): cint{.cdecl,
    dynlib: libX11, importc.}
proc xwcFreeStringList*(para1: ptr ptr int16){.cdecl, dynlib: libX11, importc.}
proc xTextPropertyToStringList*(para1: PXTextProperty, para2: PPPchar,
                                para3: Pcint): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xmbTextPropertyToTextList*(para1: PDisplay, para2: PXTextProperty,
                                para3: PPPchar, para4: Pcint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xwcTextPropertyToTextList*(para1: PDisplay, para2: PXTextProperty,
                                para3: ptr ptr ptr int16, para4: Pcint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xutf8TextPropertyToTextList*(para1: PDisplay, para2: PXTextProperty,
                                  para3: PPPchar, para4: Pcint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xUnionRectWithRegion*(para1: PXRectangle, para2: TRegion, para3: TRegion): cint{.
    cdecl, dynlib: libX11, importc.}
proc xUnionRegion*(para1: TRegion, para2: TRegion, para3: TRegion): cint{.cdecl,
    dynlib: libX11, importc.}
proc xWMGeometry*(para1: PDisplay, para2: cint, para3: cstring, para4: cstring,
                  para5: cuint, para6: PXSizeHints, para7: Pcint, para8: Pcint,
                  para9: Pcint, para10: Pcint, para11: Pcint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xXorRegion*(para1: TRegion, para2: TRegion, para3: TRegion): cint{.cdecl,
    dynlib: libX11, importc.}
when defined(MACROS):
  proc xDestroyImage*(ximage: PXImage): cint
  proc xGetPixel*(ximage: PXImage, x, y: cint): culong
  proc xPutPixel*(ximage: PXImage, x, y: cint, pixel: culong): cint
  proc xSubImage*(ximage: PXImage, x, y: cint, width, height: cuint): PXImage
  proc xAddPixel*(ximage: PXImage, value: clong): cint
  proc isKeypadKey*(keysym: TKeySym): bool
  proc isPrivateKeypadKey*(keysym: TKeySym): bool
  proc isCursorKey*(keysym: TKeySym): bool
  proc isPFKey*(keysym: TKeySym): bool
  proc isFunctionKey*(keysym: TKeySym): bool
  proc isMiscFunctionKey*(keysym: TKeySym): bool
  proc isModifierKey*(keysym: TKeySym): bool
    #function XUniqueContext : TXContext;
    #function XStringToContext(_string : Pchar) : TXContext;
# implementation

when defined(MACROS):
  proc xDestroyImage(ximage: PXImage): cint =
    XDestroyImage = ximage[] .f.destroy_image(ximage)

  proc xGetPixel(ximage: PXImage, x, y: cint): culong =
    XGetPixel = ximage[] .f.get_pixel(ximage, x, y)

  proc xPutPixel(ximage: PXImage, x, y: cint, pixel: culong): cint =
    XPutPixel = ximage[] .f.put_pixel(ximage, x, y, pixel)

  proc xSubImage(ximage: PXImage, x, y: cint, width, height: cuint): PXImage =
    XSubImage = ximage[] .f.sub_image(ximage, x, y, width, height)

  proc xAddPixel(ximage: PXImage, value: clong): cint =
    XAddPixel = ximage[] .f.add_pixel(ximage, value)

  proc isKeypadKey(keysym: TKeySym): bool =
    IsKeypadKey = (keysym >= XK_KP_Space) and (keysym <= XK_KP_Equal)

  proc isPrivateKeypadKey(keysym: TKeySym): bool =
    IsPrivateKeypadKey = (keysym >= 0x11000000) and (keysym <= 0x1100FFFF)

  proc isCursorKey(keysym: TKeySym): bool =
    IsCursorKey = (keysym >= XK_Home) and (keysym < XK_Select)

  proc isPFKey(keysym: TKeySym): bool =
    IsPFKey = (keysym >= XK_KP_F1) and (keysym <= XK_KP_F4)

  proc isFunctionKey(keysym: TKeySym): bool =
    IsFunctionKey = (keysym >= XK_F1) and (keysym <= XK_F35)

  proc isMiscFunctionKey(keysym: TKeySym): bool =
    IsMiscFunctionKey = (keysym >= XK_Select) and (keysym <= XK_Break)

  proc isModifierKey(keysym: TKeySym): bool =
    IsModifierKey = ((keysym >= XK_Shift_L) And (keysym <= XK_Hyper_R)) Or
        (keysym == XK_Mode_switch) Or (keysym == XK_Num_Lock)
