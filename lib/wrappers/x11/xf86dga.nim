#
#   Copyright (c) 1999  XFree86 Inc
#
# $XFree86: xc/include/extensions/xf86dga.h,v 3.20 1999/10/13 04:20:48 dawes Exp $ 

import 
  x, xlib

const 
  libXxf86dga* = "libXxf86dga.so"

#type 
#  cfloat* = float32

# $XFree86: xc/include/extensions/xf86dga1.h,v 1.2 1999/04/17 07:05:41 dawes Exp $ 
#
#
#Copyright (c) 1995  Jon Tombs
#Copyright (c) 1995  XFree86 Inc
#
#
#************************************************************************
#
#   THIS IS THE OLD DGA API AND IS OBSOLETE.  PLEASE DO NOT USE IT ANYMORE
#
#************************************************************************

type 
  PPcchar* = ptr ptr Cstring

const 
  XXF86DGAQueryVersion* = 0
  XXF86DGAGetVideoLL* = 1
  XXF86DGADirectVideo* = 2
  XXF86DGAGetViewPortSize* = 3
  XXF86DGASetViewPort* = 4
  XXF86DGAGetVidPage* = 5
  XXF86DGASetVidPage* = 6
  XXF86DGAInstallColormap* = 7
  XXF86DGAQueryDirectVideo* = 8
  XXF86DGAViewPortChanged* = 9
  XF86DGADirectPresent* = 0x00000001
  XF86DGADirectGraphics* = 0x00000002
  XF86DGADirectMouse* = 0x00000004
  XF86DGADirectKeyb* = 0x00000008
  XF86DGAHasColormap* = 0x00000100
  XF86DGADirectColormap* = 0x00000200

proc XF86DGAQueryVersion*(dpy: PDisplay, majorVersion: Pcint, 
                          minorVersion: Pcint): TBool{.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XF86DGAQueryExtension*(dpy: PDisplay, event_base: Pcint, error_base: Pcint): TBool{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGAGetVideoLL*(dpy: PDisplay, screen: Cint, base_addr: Pcint, 
                        width: Pcint, bank_size: Pcint, ram_size: Pcint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGAGetVideo*(dpy: PDisplay, screen: Cint, base_addr: PPcchar, 
                      width: Pcint, bank_size: Pcint, ram_size: Pcint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGADirectVideo*(dpy: PDisplay, screen: Cint, enable: Cint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGADirectVideoLL*(dpy: PDisplay, screen: Cint, enable: Cint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGAGetViewPortSize*(dpy: PDisplay, screen: Cint, width: Pcint, 
                             height: Pcint): TStatus{.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XF86DGASetViewPort*(dpy: PDisplay, screen: Cint, x: Cint, y: Cint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGAGetVidPage*(dpy: PDisplay, screen: Cint, vid_page: Pcint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGASetVidPage*(dpy: PDisplay, screen: Cint, vid_page: Cint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGAInstallColormap*(dpy: PDisplay, screen: Cint, Colormap: TColormap): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGAForkApp*(screen: Cint): Cint{.CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGAQueryDirectVideo*(dpy: PDisplay, screen: Cint, flags: Pcint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XF86DGAViewPortChanged*(dpy: PDisplay, screen: Cint, n: Cint): TBool{.
    CDecl, dynlib: libXxf86dga, importc.}
const 
  XXDGAQueryVersion* = 0     # 1 through 9 are in xf86dga1.pp 
                              # 10 and 11 are reserved to avoid conflicts with rogue DGA extensions 
  XXDGAQueryModes* = 12
  XXDGASetMode* = 13
  XXDGASetViewport* = 14
  XXDGAInstallColormap* = 15
  XXDGASelectInput* = 16
  XXDGAFillRectangle* = 17
  XXDGACopyArea* = 18
  XXDGACopyTransparentArea* = 19
  XXDGAGetViewportStatus* = 20
  XXDGASync* = 21
  XXDGAOpenFramebuffer* = 22
  XXDGACloseFramebuffer* = 23
  XXDGASetClientVersion* = 24
  XXDGAChangePixmapMode* = 25
  XXDGACreateColormap* = 26
  XDGAConcurrentAccess* = 0x00000001
  XDGASolidFillRect* = 0x00000002
  XDGABlitRect* = 0x00000004
  XDGABlitTransRect* = 0x00000008
  XDGAPixmap* = 0x00000010
  XDGAInterlaced* = 0x00010000
  XDGADoublescan* = 0x00020000
  XDGAFlipImmediate* = 0x00000001
  XDGAFlipRetrace* = 0x00000002
  XDGANeedRoot* = 0x00000001
  XF86DGANumberEvents* = 7
  XDGAPixmapModeLarge* = 0
  XDGAPixmapModeSmall* = 1
  XF86DGAClientNotLocal* = 0
  XF86DGANoDirectVideoMode* = 1
  XF86DGAScreenNotActive* = 2
  XF86DGADirectNotActivated* = 3
  XF86DGAOperationNotSupported* = 4
  XF86DGANumberErrors* = (XF86DGAOperationNotSupported + 1)

type 
  PXDGAMode* = ptr TXDGAMode
  TXDGAMode*{.final.} = object 
    num*: Cint                # A unique identifier for the mode (num > 0) 
    name*: Cstring            # name of mode given in the XF86Config 
    verticalRefresh*: Cfloat
    flags*: Cint              # DGA_CONCURRENT_ACCESS, etc... 
    imageWidth*: Cint         # linear accessible portion (pixels) 
    imageHeight*: Cint
    pixmapWidth*: Cint        # Xlib accessible portion (pixels) 
    pixmapHeight*: Cint       # both fields ignored if no concurrent access 
    bytesPerScanline*: Cint
    byteOrder*: Cint          # MSBFirst, LSBFirst 
    depth*: Cint
    bitsPerPixel*: Cint
    redMask*: Culong
    greenMask*: Culong
    blueMask*: Culong
    visualClass*: Cshort
    viewportWidth*: Cint
    viewportHeight*: Cint
    xViewportStep*: Cint      # viewport position granularity 
    yViewportStep*: Cint
    maxViewportX*: Cint       # max viewport origin 
    maxViewportY*: Cint
    viewportFlags*: Cint      # types of page flipping possible 
    reserved1*: Cint
    reserved2*: Cint

  PXDGADevice* = ptr TXDGADevice
  TXDGADevice*{.final.} = object 
    mode*: TXDGAMode
    data*: Pcuchar
    pixmap*: TPixmap

  PXDGAButtonEvent* = ptr TXDGAButtonEvent
  TXDGAButtonEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    display*: PDisplay
    screen*: Cint
    time*: TTime
    state*: Cuint
    button*: Cuint

  PXDGAKeyEvent* = ptr TXDGAKeyEvent
  TXDGAKeyEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    display*: PDisplay
    screen*: Cint
    time*: TTime
    state*: Cuint
    keycode*: Cuint

  PXDGAMotionEvent* = ptr TXDGAMotionEvent
  TXDGAMotionEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    display*: PDisplay
    screen*: Cint
    time*: TTime
    state*: Cuint
    dx*: Cint
    dy*: Cint

  PXDGAEvent* = ptr TXDGAEvent
  TXDGAEvent*{.final.} = object 
    pad*: Array[0..23, Clong] # sorry you have to cast if you want access
                              #Case LongInt Of
                              #      0 : (_type : cint);
                              #      1 : (xbutton : TXDGAButtonEvent);
                              #      2 : (xkey : TXDGAKeyEvent);
                              #      3 : (xmotion : TXDGAMotionEvent);
                              #      4 : (pad : Array[0..23] Of clong);
  

proc XDGAQueryExtension*(dpy: PDisplay, eventBase: Pcint, erroBase: Pcint): TBool{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XDGAQueryVersion*(dpy: PDisplay, majorVersion: Pcint, minorVersion: Pcint): TBool{.
    CDecl, dynlib: libXxf86dga, importc.}
proc XDGAQueryModes*(dpy: PDisplay, screen: Cint, num: Pcint): PXDGAMode{.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGASetMode*(dpy: PDisplay, screen: Cint, mode: Cint): PXDGADevice{.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGAOpenFramebuffer*(dpy: PDisplay, screen: Cint): TBool{.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGACloseFramebuffer*(dpy: PDisplay, screen: Cint){.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGASetViewport*(dpy: PDisplay, screen: Cint, x: Cint, y: Cint, flags: Cint){.
    CDecl, dynlib: libXxf86dga, importc.}
proc XDGAInstallColormap*(dpy: PDisplay, screen: Cint, cmap: TColormap){.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGACreateColormap*(dpy: PDisplay, screen: Cint, device: PXDGADevice, 
                         alloc: Cint): TColormap{.CDecl, dynlib: libXxf86dga, 
    importc.}
proc XDGASelectInput*(dpy: PDisplay, screen: Cint, event_mask: Clong){.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGAFillRectangle*(dpy: PDisplay, screen: Cint, x: Cint, y: Cint, 
                        width: Cuint, height: Cuint, color: Culong){.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGACopyArea*(dpy: PDisplay, screen: Cint, srcx: Cint, srcy: Cint, 
                   width: Cuint, height: Cuint, dstx: Cint, dsty: Cint){.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGACopyTransparentArea*(dpy: PDisplay, screen: Cint, srcx: Cint, 
                              srcy: Cint, width: Cuint, height: Cuint, 
                              dstx: Cint, dsty: Cint, key: Culong){.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGAGetViewportStatus*(dpy: PDisplay, screen: Cint): Cint{.CDecl, 
    dynlib: libXxf86dga, importc.}
proc XDGASync*(dpy: PDisplay, screen: Cint){.CDecl, dynlib: libXxf86dga, importc.}
proc XDGASetClientVersion*(dpy: PDisplay): TBool{.CDecl, dynlib: libXxf86dga, 
    importc.}
proc XDGAChangePixmapMode*(dpy: PDisplay, screen: Cint, x: Pcint, y: Pcint, 
                           mode: Cint){.CDecl, dynlib: libXxf86dga, importc.}
proc XDGAKeyEventToXKeyEvent*(dk: PXDGAKeyEvent, xk: PXKeyEvent){.CDecl, 
    dynlib: libXxf86dga, importc.}
# implementation
