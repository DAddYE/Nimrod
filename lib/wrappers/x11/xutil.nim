
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
    x*: Cint
    y*: Cint

  PXSizeHints* = ptr TXSizeHints
  TXSizeHints*{.final.} = object 
    flags*: Clong
    x*, y*: Cint
    width*, height*: Cint
    min_width*, min_height*: Cint
    max_width*, max_height*: Cint
    width_inc*, height_inc*: Cint
    min_aspect*, max_aspect*: TCPoint
    base_width*, base_height*: Cint
    win_gravity*: Cint


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
    flags*: Clong
    input*: TBool
    initial_state*: Cint
    icon_pixmap*: TPixmap
    icon_window*: TWindow
    icon_x*, icon_y*: Cint
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
    value*: Pcuchar
    encoding*: TAtom
    format*: Cint
    nitems*: Culong


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
    min_width*, min_height*: Cint
    max_width*, max_height*: Cint
    width_inc*, height_inc*: Cint

  PXClassHint* = ptr TXClassHint
  TXClassHint*{.final.} = object 
    res_name*: Cstring
    res_class*: Cstring


type 
  PXComposeStatus* = ptr TXComposeStatus
  TXComposeStatus*{.final.} = object 
    compose_ptr*: TXPointer
    chars_matched*: Cint


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
    screen*: Cint
    depth*: Cint
    class*: Cint
    red_mask*: Culong
    green_mask*: Culong
    blue_mask*: Culong
    colormap_size*: Cint
    bits_per_rgb*: Cint


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
    red_max*: Culong
    red_mult*: Culong
    green_max*: Culong
    green_mult*: Culong
    blue_max*: Culong
    blue_mult*: Culong
    base_pixel*: Culong
    visualid*: TVisualID
    killid*: TXID


const 
  BitmapSuccess* = 0
  BitmapOpenFailed* = 1
  BitmapFileInvalid* = 2
  BitmapNoMemory* = 3
  Xcsuccess* = 0
  Xcnomem* = 1
  Xcnoent* = 2
  ReleaseByFreeingColormap*: TXID = TXID(1)

type 
  PXContext* = ptr TXContext
  TXContext* = Cint

proc XAllocClassHint*(): PXClassHint{.cdecl, dynlib: libX11, importc.}
proc XAllocIconSize*(): PXIconSize{.cdecl, dynlib: libX11, importc.}
proc XAllocSizeHints*(): PXSizeHints{.cdecl, dynlib: libX11, importc.}
proc XAllocStandardColormap*(): PXStandardColormap{.cdecl, dynlib: libX11, 
    importc.}
proc XAllocWMHints*(): PXWMHints{.cdecl, dynlib: libX11, importc.}
proc XClipBox*(para1: TRegion, para2: PXRectangle): Cint{.cdecl, dynlib: libX11, 
    importc.}
proc XCreateRegion*(): TRegion{.cdecl, dynlib: libX11, importc.}
proc XDefaultString*(): Cstring{.cdecl, dynlib: libX11, importc.}
proc XDeleteContext*(para1: PDisplay, para2: TXID, para3: TXContext): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XDestroyRegion*(para1: TRegion): Cint{.cdecl, dynlib: libX11, importc.}
proc XEmptyRegion*(para1: TRegion): Cint{.cdecl, dynlib: libX11, importc.}
proc XEqualRegion*(para1: TRegion, para2: TRegion): Cint{.cdecl, dynlib: libX11, 
    importc.}
proc XFindContext*(para1: PDisplay, para2: TXID, para3: TXContext, 
                   para4: PXPointer): Cint{.cdecl, dynlib: libX11, importc.}
proc XGetClassHint*(para1: PDisplay, para2: TWindow, para3: PXClassHint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XGetIconSizes*(para1: PDisplay, para2: TWindow, para3: PPXIconSize, 
                    para4: Pcint): TStatus{.cdecl, dynlib: libX11, importc.}
proc XGetNormalHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XGetRGBColormaps*(para1: PDisplay, para2: TWindow, 
                       para3: PPXStandardColormap, para4: Pcint, para5: TAtom): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XGetSizeHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints, 
                    para4: TAtom): TStatus{.cdecl, dynlib: libX11, importc.}
proc XGetStandardColormap*(para1: PDisplay, para2: TWindow, 
                           para3: PXStandardColormap, para4: TAtom): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XGetTextProperty*(para1: PDisplay, para2: TWindow, para3: PXTextProperty, 
                       para4: TAtom): TStatus{.cdecl, dynlib: libX11, importc.}
proc XGetVisualInfo*(para1: PDisplay, para2: Clong, para3: PXVisualInfo, 
                     para4: Pcint): PXVisualInfo{.cdecl, dynlib: libX11, importc.}
proc XGetWMClientMachine*(para1: PDisplay, para2: TWindow, para3: PXTextProperty): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XGetWMHints*(para1: PDisplay, para2: TWindow): PXWMHints{.cdecl, 
    dynlib: libX11, importc.}
proc XGetWMIconName*(para1: PDisplay, para2: TWindow, para3: PXTextProperty): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XGetWMName*(para1: PDisplay, para2: TWindow, para3: PXTextProperty): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XGetWMNormalHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints, 
                        para4: ptr Int): TStatus{.cdecl, dynlib: libX11, importc.}
proc XGetWMSizeHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints, 
                      para4: ptr Int, para5: TAtom): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XGetZoomHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XIntersectRegion*(para1: TRegion, para2: TRegion, para3: TRegion): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XConvertCase*(para1: TKeySym, para2: PKeySym, para3: PKeySym){.cdecl, 
    dynlib: libX11, importc.}
proc XLookupString*(para1: PXKeyEvent, para2: Cstring, para3: Cint, 
                    para4: PKeySym, para5: PXComposeStatus): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XMatchVisualInfo*(para1: PDisplay, para2: Cint, para3: Cint, para4: Cint, 
                       para5: PXVisualInfo): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XOffsetRegion*(para1: TRegion, para2: Cint, para3: Cint): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XPointInRegion*(para1: TRegion, para2: Cint, para3: Cint): TBool{.cdecl, 
    dynlib: libX11, importc.}
proc XPolygonRegion*(para1: PXPoint, para2: Cint, para3: Cint): TRegion{.cdecl, 
    dynlib: libX11, importc.}
proc XRectInRegion*(para1: TRegion, para2: Cint, para3: Cint, para4: Cuint, 
                    para5: Cuint): Cint{.cdecl, dynlib: libX11, importc.}
proc XSaveContext*(para1: PDisplay, para2: TXID, para3: TXContext, 
                   para4: Cstring): Cint{.cdecl, dynlib: libX11, importc.}
proc XSetClassHint*(para1: PDisplay, para2: TWindow, para3: PXClassHint): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XSetIconSizes*(para1: PDisplay, para2: TWindow, para3: PXIconSize, 
                    para4: Cint): Cint{.cdecl, dynlib: libX11, importc.}
proc XSetNormalHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XSetRGBColormaps*(para1: PDisplay, para2: TWindow, 
                       para3: PXStandardColormap, para4: Cint, para5: TAtom){.
    cdecl, dynlib: libX11, importc.}
proc XSetSizeHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints, 
                    para4: TAtom): Cint{.cdecl, dynlib: libX11, importc.}
proc XSetStandardProperties*(para1: PDisplay, para2: TWindow, para3: Cstring, 
                             para4: Cstring, para5: TPixmap, para6: PPChar, 
                             para7: Cint, para8: PXSizeHints): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XSetTextProperty*(para1: PDisplay, para2: TWindow, para3: PXTextProperty, 
                       para4: TAtom){.cdecl, dynlib: libX11, importc.}
proc XSetWMClientMachine*(para1: PDisplay, para2: TWindow, para3: PXTextProperty){.
    cdecl, dynlib: libX11, importc.}
proc XSetWMHints*(para1: PDisplay, para2: TWindow, para3: PXWMHints): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XSetWMIconName*(para1: PDisplay, para2: TWindow, para3: PXTextProperty){.
    cdecl, dynlib: libX11, importc.}
proc XSetWMName*(para1: PDisplay, para2: TWindow, para3: PXTextProperty){.cdecl, 
    dynlib: libX11, importc.}
proc XSetWMNormalHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints){.
    cdecl, dynlib: libX11, importc.}
proc XSetWMProperties*(para1: PDisplay, para2: TWindow, para3: PXTextProperty, 
                       para4: PXTextProperty, para5: PPChar, para6: Cint, 
                       para7: PXSizeHints, para8: PXWMHints, para9: PXClassHint){.
    cdecl, dynlib: libX11, importc.}
proc XmbSetWMProperties*(para1: PDisplay, para2: TWindow, para3: Cstring, 
                         para4: Cstring, para5: PPChar, para6: Cint, 
                         para7: PXSizeHints, para8: PXWMHints, 
                         para9: PXClassHint){.cdecl, dynlib: libX11, importc.}
proc Xutf8SetWMProperties*(para1: PDisplay, para2: TWindow, para3: Cstring, 
                           para4: Cstring, para5: PPChar, para6: Cint, 
                           para7: PXSizeHints, para8: PXWMHints, 
                           para9: PXClassHint){.cdecl, dynlib: libX11, importc.}
proc XSetWMSizeHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints, 
                      para4: TAtom){.cdecl, dynlib: libX11, importc.}
proc XSetRegion*(para1: PDisplay, para2: TGC, para3: TRegion): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XSetStandardColormap*(para1: PDisplay, para2: TWindow, 
                           para3: PXStandardColormap, para4: TAtom){.cdecl, 
    dynlib: libX11, importc.}
proc XSetZoomHints*(para1: PDisplay, para2: TWindow, para3: PXSizeHints): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XShrinkRegion*(para1: TRegion, para2: Cint, para3: Cint): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XStringListToTextProperty*(para1: PPChar, para2: Cint, 
                                para3: PXTextProperty): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XSubtractRegion*(para1: TRegion, para2: TRegion, para3: TRegion): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XmbTextListToTextProperty*(para1: PDisplay, para2: PPChar, para3: Cint, 
                                para4: TXICCEncodingStyle, para5: PXTextProperty): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XwcTextListToTextProperty*(para1: PDisplay, para2: ptr ptr Int16, para3: Cint, 
                                para4: TXICCEncodingStyle, para5: PXTextProperty): Cint{.
    cdecl, dynlib: libX11, importc.}
proc Xutf8TextListToTextProperty*(para1: PDisplay, para2: PPChar, para3: Cint, 
                                  para4: TXICCEncodingStyle, 
                                  para5: PXTextProperty): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XwcFreeStringList*(para1: ptr ptr Int16){.cdecl, dynlib: libX11, importc.}
proc XTextPropertyToStringList*(para1: PXTextProperty, para2: PPPChar, 
                                para3: Pcint): TStatus{.cdecl, dynlib: libX11, 
    importc.}
proc XmbTextPropertyToTextList*(para1: PDisplay, para2: PXTextProperty, 
                                para3: PPPChar, para4: Pcint): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XwcTextPropertyToTextList*(para1: PDisplay, para2: PXTextProperty, 
                                para3: ptr ptr ptr Int16, para4: Pcint): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc Xutf8TextPropertyToTextList*(para1: PDisplay, para2: PXTextProperty, 
                                  para3: PPPChar, para4: Pcint): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XUnionRectWithRegion*(para1: PXRectangle, para2: TRegion, para3: TRegion): Cint{.
    cdecl, dynlib: libX11, importc.}
proc XUnionRegion*(para1: TRegion, para2: TRegion, para3: TRegion): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XWMGeometry*(para1: PDisplay, para2: Cint, para3: Cstring, para4: Cstring, 
                  para5: Cuint, para6: PXSizeHints, para7: Pcint, para8: Pcint, 
                  para9: Pcint, para10: Pcint, para11: Pcint): Cint{.cdecl, 
    dynlib: libX11, importc.}
proc XXorRegion*(para1: TRegion, para2: TRegion, para3: TRegion): Cint{.cdecl, 
    dynlib: libX11, importc.}
when defined(MACROS): 
  proc XDestroyImage*(ximage: PXImage): cint
  proc XGetPixel*(ximage: PXImage, x, y: cint): culong
  proc XPutPixel*(ximage: PXImage, x, y: cint, pixel: culong): cint
  proc XSubImage*(ximage: PXImage, x, y: cint, width, height: cuint): PXImage
  proc XAddPixel*(ximage: PXImage, value: clong): cint
  proc IsKeypadKey*(keysym: TKeySym): bool
  proc IsPrivateKeypadKey*(keysym: TKeySym): bool
  proc IsCursorKey*(keysym: TKeySym): bool
  proc IsPFKey*(keysym: TKeySym): bool
  proc IsFunctionKey*(keysym: TKeySym): bool
  proc IsMiscFunctionKey*(keysym: TKeySym): bool
  proc IsModifierKey*(keysym: TKeySym): bool
    #function XUniqueContext : TXContext;
    #function XStringToContext(_string : Pchar) : TXContext;
# implementation

when defined(MACROS): 
  proc XDestroyImage(ximage: PXImage): cint = 
    XDestroyImage = ximage[] .f.destroy_image(ximage)

  proc XGetPixel(ximage: PXImage, x, y: cint): culong = 
    XGetPixel = ximage[] .f.get_pixel(ximage, x, y)

  proc XPutPixel(ximage: PXImage, x, y: cint, pixel: culong): cint = 
    XPutPixel = ximage[] .f.put_pixel(ximage, x, y, pixel)

  proc XSubImage(ximage: PXImage, x, y: cint, width, height: cuint): PXImage = 
    XSubImage = ximage[] .f.sub_image(ximage, x, y, width, height)

  proc XAddPixel(ximage: PXImage, value: clong): cint = 
    XAddPixel = ximage[] .f.add_pixel(ximage, value)

  proc IsKeypadKey(keysym: TKeySym): bool = 
    IsKeypadKey = (keysym >= XK_KP_Space) and (keysym <= XK_KP_Equal)

  proc IsPrivateKeypadKey(keysym: TKeySym): bool = 
    IsPrivateKeypadKey = (keysym >= 0x11000000) and (keysym <= 0x1100FFFF)

  proc IsCursorKey(keysym: TKeySym): bool = 
    IsCursorKey = (keysym >= XK_Home) and (keysym < XK_Select)

  proc IsPFKey(keysym: TKeySym): bool = 
    IsPFKey = (keysym >= XK_KP_F1) and (keysym <= XK_KP_F4)

  proc IsFunctionKey(keysym: TKeySym): bool = 
    IsFunctionKey = (keysym >= XK_F1) and (keysym <= XK_F35)

  proc IsMiscFunctionKey(keysym: TKeySym): bool = 
    IsMiscFunctionKey = (keysym >= XK_Select) and (keysym <= XK_Break)

  proc IsModifierKey(keysym: TKeySym): bool = 
    IsModifierKey = ((keysym >= XK_Shift_L) And (keysym <= XK_Hyper_R)) Or
        (keysym == XK_Mode_switch) Or (keysym == XK_Num_Lock)
