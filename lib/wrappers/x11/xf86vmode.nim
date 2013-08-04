# $XFree86: xc/include/extensions/xf86vmode.h,v 3.30 2001/05/07 20:09:50 mvojkovi Exp $ 
#
#
#Copyright 1995  Kaleb S. KEITHLEY
#
#Permission is hereby granted, free of charge, to any person obtaining
#a copy of this software and associated documentation files (the
#"Software"), to deal in the Software without restriction, including
#without limitation the rights to use, copy, modify, merge, publish,
#distribute, sublicense, and/or sell copies of the Software, and to
#permit persons to whom the Software is furnished to do so, subject to
#the following conditions:
#
#The above copyright notice and this permission notice shall be
#included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#IN NO EVENT SHALL Kaleb S. KEITHLEY BE LIABLE FOR ANY CLAIM, DAMAGES 
#OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#OTHER DEALINGS IN THE SOFTWARE.
#
#Except as contained in this notice, the name of Kaleb S. KEITHLEY 
#shall not be used in advertising or otherwise to promote the sale, use 
#or other dealings in this Software without prior written authorization
#from Kaleb S. KEITHLEY
#
#
# $Xorg: xf86vmode.h,v 1.3 2000/08/18 04:05:46 coskrey Exp $ 
# THIS IS NOT AN X CONSORTIUM STANDARD OR AN X PROJECT TEAM SPECIFICATION 

import 
  x, xlib

const 
  libXxf86vm* = "libXxf86vm.so"

type 
  Pint32* = ptr Int32

const 
  XXF86VidModeQueryVersion* = 0
  XXF86VidModeGetModeLine* = 1
  XXF86VidModeModModeLine* = 2
  XXF86VidModeSwitchMode* = 3
  XXF86VidModeGetMonitor* = 4
  XXF86VidModeLockModeSwitch* = 5
  XXF86VidModeGetAllModeLines* = 6
  XXF86VidModeAddModeLine* = 7
  XXF86VidModeDeleteModeLine* = 8
  XXF86VidModeValidateModeLine* = 9
  XXF86VidModeSwitchToMode* = 10
  XXF86VidModeGetViewPort* = 11
  XXF86VidModeSetViewPort* = 12 # new for version 2.x of this extension 
  XXF86VidModeGetDotClocks* = 13
  XXF86VidModeSetClientVersion* = 14
  XXF86VidModeSetGamma* = 15
  XXF86VidModeGetGamma* = 16
  XXF86VidModeGetGammaRamp* = 17
  XXF86VidModeSetGammaRamp* = 18
  XXF86VidModeGetGammaRampSize* = 19
  XXF86VidModeGetPermissions* = 20
  ClkflagProgramable* = 1

when defined(XF86VIDMODE_EVENTS): 
  const 
    XF86VidModeNotify* = 0
    XF86VidModeNumberEvents* = (XF86VidModeNotify + 1)
    XF86VidModeNotifyMask* = 0x00000001
    XF86VidModeNonEvent* = 0
    XF86VidModeModeChange* = 1
else: 
  const 
    XF86VidModeNumberEvents* = 0
const 
  XF86VidModeBadClock* = 0
  XF86VidModeBadHTimings* = 1
  XF86VidModeBadVTimings* = 2
  XF86VidModeModeUnsuitable* = 3
  XF86VidModeExtensionDisabled* = 4
  XF86VidModeClientNotLocal* = 5
  XF86VidModeZoomLocked* = 6
  XF86VidModeNumberErrors* = (XF86VidModeZoomLocked + 1)
  Xf86vmReadPermission* = 1
  Xf86vmWritePermission* = 2

type 
  PXF86VidModeModeLine* = ptr TXF86VidModeModeLine
  TXF86VidModeModeLine*{.final.} = object 
    hdisplay*: Cushort
    hsyncstart*: Cushort
    hsyncend*: Cushort
    htotal*: Cushort
    hskew*: Cushort
    vdisplay*: Cushort
    vsyncstart*: Cushort
    vsyncend*: Cushort
    vtotal*: Cushort
    flags*: Cuint
    privsize*: Cint
    c_private*: Pint32

  PPPXF86VidModeModeInfo* = ptr PPXF86VidModeModeInfo
  PPXF86VidModeModeInfo* = ptr PXF86VidModeModeInfo
  PXF86VidModeModeInfo* = ptr TXF86VidModeModeInfo
  TXF86VidModeModeInfo*{.final.} = object 
    dotclock*: Cuint
    hdisplay*: Cushort
    hsyncstart*: Cushort
    hsyncend*: Cushort
    htotal*: Cushort
    hskew*: Cushort
    vdisplay*: Cushort
    vsyncstart*: Cushort
    vsyncend*: Cushort
    vtotal*: Cushort
    flags*: Cuint
    privsize*: Cint
    c_private*: Pint32

  PXF86VidModeSyncRange* = ptr TXF86VidModeSyncRange
  TXF86VidModeSyncRange*{.final.} = object 
    hi*: Cfloat
    lo*: Cfloat

  PXF86VidModeMonitor* = ptr TXF86VidModeMonitor
  TXF86VidModeMonitor*{.final.} = object 
    vendor*: Cstring
    model*: Cstring
    EMPTY*: Cfloat
    nhsync*: Cuchar
    hsync*: PXF86VidModeSyncRange
    nvsync*: Cuchar
    vsync*: PXF86VidModeSyncRange

  PXF86VidModeNotifyEvent* = ptr TXF86VidModeNotifyEvent
  TXF86VidModeNotifyEvent*{.final.} = object 
    theType*: Cint            # of event 
    serial*: Culong           # # of last request processed by server 
    send_event*: TBool        # true if this came from a SendEvent req 
    display*: PDisplay        # Display the event was read from 
    root*: TWindow            # root window of event screen 
    state*: Cint              # What happened 
    kind*: Cint               # What happened 
    forced*: TBool            # extents of new region 
    time*: TTime              # event timestamp 
  
  PXF86VidModeGamma* = ptr TXF86VidModeGamma
  TXF86VidModeGamma*{.final.} = object 
    red*: Cfloat              # Red Gamma value 
    green*: Cfloat            # Green Gamma value 
    blue*: Cfloat             # Blue Gamma value 
  

when defined(MACROS): 
  proc XF86VidModeSelectNextMode*(disp: PDisplay, scr: cint): TBool
  proc XF86VidModeSelectPrevMode*(disp: PDisplay, scr: cint): TBool
proc XF86VidModeQueryVersion*(dpy: PDisplay, majorVersion: Pcint, 
                              minorVersion: Pcint): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeQueryExtension*(dpy: PDisplay, event_base: Pcint, 
                                error_base: Pcint): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeSetClientVersion*(dpy: PDisplay): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeGetModeLine*(dpy: PDisplay, screen: Cint, dotclock: Pcint, 
                             modeline: PXF86VidModeModeLine): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeGetAllModeLines*(dpy: PDisplay, screen: Cint, modecount: Pcint, 
                                 modelinesPtr: PPPXF86VidModeModeInfo): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeAddModeLine*(dpy: PDisplay, screen: Cint, 
                             new_modeline: PXF86VidModeModeInfo, 
                             after_modeline: PXF86VidModeModeInfo): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeDeleteModeLine*(dpy: PDisplay, screen: Cint, 
                                modeline: PXF86VidModeModeInfo): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeModModeLine*(dpy: PDisplay, screen: Cint, 
                             modeline: PXF86VidModeModeLine): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeValidateModeLine*(dpy: PDisplay, screen: Cint, 
                                  modeline: PXF86VidModeModeInfo): TStatus{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeSwitchMode*(dpy: PDisplay, screen: Cint, zoom: Cint): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeSwitchToMode*(dpy: PDisplay, screen: Cint, 
                              modeline: PXF86VidModeModeInfo): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeLockModeSwitch*(dpy: PDisplay, screen: Cint, lock: Cint): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeGetMonitor*(dpy: PDisplay, screen: Cint, 
                            monitor: PXF86VidModeMonitor): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeGetViewPort*(dpy: PDisplay, screen: Cint, x_return: Pcint, 
                             y_return: Pcint): TBool{.CDecl, dynlib: libXxf86vm, 
    importc.}
proc XF86VidModeSetViewPort*(dpy: PDisplay, screen: Cint, x: Cint, y: Cint): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeGetDotClocks*(dpy: PDisplay, screen: Cint, flags_return: Pcint, 
                              number_of_clocks_return: Pcint, 
                              max_dot_clock_return: Pcint, clocks_return: PPcint): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeGetGamma*(dpy: PDisplay, screen: Cint, Gamma: PXF86VidModeGamma): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeSetGamma*(dpy: PDisplay, screen: Cint, Gamma: PXF86VidModeGamma): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeSetGammaRamp*(dpy: PDisplay, screen: Cint, size: Cint, 
                              red_array: Pcushort, green_array: Pcushort, 
                              blue_array: Pcushort): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeGetGammaRamp*(dpy: PDisplay, screen: Cint, size: Cint, 
                              red_array: Pcushort, green_array: Pcushort, 
                              blue_array: Pcushort): TBool{.CDecl, 
    dynlib: libXxf86vm, importc.}
proc XF86VidModeGetGammaRampSize*(dpy: PDisplay, screen: Cint, size: Pcint): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
proc XF86VidModeGetPermissions*(dpy: PDisplay, screen: Cint, permissions: Pcint): TBool{.
    CDecl, dynlib: libXxf86vm, importc.}
# implementation

when defined(MACROS): 
  proc XF86VidModeSelectNextMode(disp: PDisplay, scr: cint): TBool = 
    XF86VidModeSelectNextMode = XF86VidModeSwitchMode(disp, scr, 1)

  proc XF86VidModeSelectPrevMode(disp: PDisplay, scr: cint): TBool = 
    XF86VidModeSelectPrevMode = XF86VidModeSwitchMode(disp, scr, - 1)
