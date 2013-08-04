# Converted from X11/Xinerama.h 
import                        
  xlib

const
  xineramaLib = "libXinerama.so"

type 
  PXineramaScreenInfo* = ptr TXineramaScreenInfo
  TXineramaScreenInfo*{.final.} = object 
    screen_number*: Cint
    x_org*: Int16
    y_org*: Int16
    width*: Int16
    height*: Int16


proc XineramaQueryExtension*(dpy: PDisplay, event_base: Pcint, error_base: Pcint): TBool{.
    cdecl, dynlib: xineramaLib, importc.}
proc XineramaQueryVersion*(dpy: PDisplay, major: Pcint, minor: Pcint): TStatus{.
    cdecl, dynlib: xineramaLib, importc.}
proc XineramaIsActive*(dpy: PDisplay): TBool{.cdecl, dynlib: xineramaLib, importc.}
proc XineramaQueryScreens*(dpy: PDisplay, number: Pcint): PXineramaScreenInfo{.
    cdecl, dynlib: xineramaLib, importc.}

