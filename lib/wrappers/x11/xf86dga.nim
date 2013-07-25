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
  PPcchar* = ptr ptr cstring

const
  X_XF86DGAQueryVersion* = 0
  X_XF86DGAGetVideoLL* = 1
  X_XF86DGADirectVideo* = 2
  X_XF86DGAGetViewPortSize* = 3
  X_XF86DGASetViewPort* = 4
  X_XF86DGAGetVidPage* = 5
  X_XF86DGASetVidPage* = 6
  X_XF86DGAInstallColormap* = 7
  X_XF86DGAQueryDirectVideo* = 8
  X_XF86DGAViewPortChanged* = 9
  XF86DGADirectPresent* = 0x00000001
  XF86DGADirectGraphics* = 0x00000002
  XF86DGADirectMouse* = 0x00000004
  XF86DGADirectKeyb* = 0x00000008
  XF86DGAHasColormap* = 0x00000100
  XF86DGADirectColormap* = 0x00000200

proc xF86DGAQueryVersion*(dpy: PDisplay, majorVersion: Pcint,
                          minorVersion: Pcint): Tbool{.CDecl,
    dynlib: libXxf86dga, importc.}
proc xF86DGAQueryExtension*(dpy: PDisplay, event_base: Pcint, error_base: Pcint): Tbool{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGAGetVideoLL*(dpy: PDisplay, screen: cint, base_addr: Pcint,
                        width: Pcint, bank_size: Pcint, ram_size: Pcint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGAGetVideo*(dpy: PDisplay, screen: cint, base_addr: PPcchar,
                      width: Pcint, bank_size: Pcint, ram_size: Pcint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGADirectVideo*(dpy: PDisplay, screen: cint, enable: cint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGADirectVideoLL*(dpy: PDisplay, screen: cint, enable: cint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGAGetViewPortSize*(dpy: PDisplay, screen: cint, width: Pcint,
                             height: Pcint): TStatus{.CDecl,
    dynlib: libXxf86dga, importc.}
proc xF86DGASetViewPort*(dpy: PDisplay, screen: cint, x: cint, y: cint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGAGetVidPage*(dpy: PDisplay, screen: cint, vid_page: Pcint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGASetVidPage*(dpy: PDisplay, screen: cint, vid_page: cint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGAInstallColormap*(dpy: PDisplay, screen: cint, Colormap: TColormap): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGAForkApp*(screen: cint): cint{.CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGAQueryDirectVideo*(dpy: PDisplay, screen: cint, flags: Pcint): TStatus{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xF86DGAViewPortChanged*(dpy: PDisplay, screen: cint, n: cint): Tbool{.
    CDecl, dynlib: libXxf86dga, importc.}
const
  X_XDGAQueryVersion* = 0     # 1 through 9 are in xf86dga1.pp
                              # 10 and 11 are reserved to avoid conflicts with rogue DGA extensions
  X_XDGAQueryModes* = 12
  X_XDGASetMode* = 13
  X_XDGASetViewport* = 14
  X_XDGAInstallColormap* = 15
  X_XDGASelectInput* = 16
  X_XDGAFillRectangle* = 17
  X_XDGACopyArea* = 18
  X_XDGACopyTransparentArea* = 19
  X_XDGAGetViewportStatus* = 20
  X_XDGASync* = 21
  X_XDGAOpenFramebuffer* = 22
  X_XDGACloseFramebuffer* = 23
  X_XDGASetClientVersion* = 24
  X_XDGAChangePixmapMode* = 25
  X_XDGACreateColormap* = 26
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
    num*: cint                # A unique identifier for the mode (num > 0)
    name*: cstring            # name of mode given in the XF86Config
    verticalRefresh*: cfloat
    flags*: cint              # DGA_CONCURRENT_ACCESS, etc...
    imageWidth*: cint         # linear accessible portion (pixels)
    imageHeight*: cint
    pixmapWidth*: cint        # Xlib accessible portion (pixels)
    pixmapHeight*: cint       # both fields ignored if no concurrent access
    bytesPerScanline*: cint
    byteOrder*: cint          # MSBFirst, LSBFirst
    depth*: cint
    bitsPerPixel*: cint
    redMask*: culong
    greenMask*: culong
    blueMask*: culong
    visualClass*: cshort
    viewportWidth*: cint
    viewportHeight*: cint
    xViewportStep*: cint      # viewport position granularity
    yViewportStep*: cint
    maxViewportX*: cint       # max viewport origin
    maxViewportY*: cint
    viewportFlags*: cint      # types of page flipping possible
    reserved1*: cint
    reserved2*: cint

  PXDGADevice* = ptr TXDGADevice
  TXDGADevice*{.final.} = object
    mode*: TXDGAMode
    data*: Pcuchar
    pixmap*: TPixmap

  PXDGAButtonEvent* = ptr TXDGAButtonEvent
  TXDGAButtonEvent*{.final.} = object
    theType*: cint
    serial*: culong
    display*: PDisplay
    screen*: cint
    time*: TTime
    state*: cuint
    button*: cuint

  PXDGAKeyEvent* = ptr TXDGAKeyEvent
  TXDGAKeyEvent*{.final.} = object
    theType*: cint
    serial*: culong
    display*: PDisplay
    screen*: cint
    time*: TTime
    state*: cuint
    keycode*: cuint

  PXDGAMotionEvent* = ptr TXDGAMotionEvent
  TXDGAMotionEvent*{.final.} = object
    theType*: cint
    serial*: culong
    display*: PDisplay
    screen*: cint
    time*: TTime
    state*: cuint
    dx*: cint
    dy*: cint

  PXDGAEvent* = ptr TXDGAEvent
  TXDGAEvent*{.final.} = object
    pad*: array[0..23, clong] # sorry you have to cast if you want access
                              #Case LongInt Of
                              #      0 : (_type : cint);
                              #      1 : (xbutton : TXDGAButtonEvent);
                              #      2 : (xkey : TXDGAKeyEvent);
                              #      3 : (xmotion : TXDGAMotionEvent);
                              #      4 : (pad : Array[0..23] Of clong);


proc xDGAQueryExtension*(dpy: PDisplay, eventBase: Pcint, erroBase: Pcint): Tbool{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xDGAQueryVersion*(dpy: PDisplay, majorVersion: Pcint, minorVersion: Pcint): Tbool{.
    CDecl, dynlib: libXxf86dga, importc.}
proc xDGAQueryModes*(dpy: PDisplay, screen: cint, num: Pcint): PXDGAMode{.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGASetMode*(dpy: PDisplay, screen: cint, mode: cint): PXDGADevice{.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGAOpenFramebuffer*(dpy: PDisplay, screen: cint): Tbool{.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGACloseFramebuffer*(dpy: PDisplay, screen: cint){.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGASetViewport*(dpy: PDisplay, screen: cint, x: cint, y: cint, flags: cint){.
    CDecl, dynlib: libXxf86dga, importc.}
proc xDGAInstallColormap*(dpy: PDisplay, screen: cint, cmap: TColormap){.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGACreateColormap*(dpy: PDisplay, screen: cint, device: PXDGADevice,
                         alloc: cint): TColormap{.CDecl, dynlib: libXxf86dga,
    importc.}
proc xDGASelectInput*(dpy: PDisplay, screen: cint, event_mask: clong){.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGAFillRectangle*(dpy: PDisplay, screen: cint, x: cint, y: cint,
                        width: cuint, height: cuint, color: culong){.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGACopyArea*(dpy: PDisplay, screen: cint, srcx: cint, srcy: cint,
                   width: cuint, height: cuint, dstx: cint, dsty: cint){.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGACopyTransparentArea*(dpy: PDisplay, screen: cint, srcx: cint,
                              srcy: cint, width: cuint, height: cuint,
                              dstx: cint, dsty: cint, key: culong){.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGAGetViewportStatus*(dpy: PDisplay, screen: cint): cint{.CDecl,
    dynlib: libXxf86dga, importc.}
proc xDGASync*(dpy: PDisplay, screen: cint){.CDecl, dynlib: libXxf86dga, importc.}
proc xDGASetClientVersion*(dpy: PDisplay): Tbool{.CDecl, dynlib: libXxf86dga,
    importc.}
proc xDGAChangePixmapMode*(dpy: PDisplay, screen: cint, x: Pcint, y: Pcint,
                           mode: cint){.CDecl, dynlib: libXxf86dga, importc.}
proc xDGAKeyEventToXKeyEvent*(dk: PXDGAKeyEvent, xk: PXKeyEvent){.CDecl,
    dynlib: libXxf86dga, importc.}
# implementation
