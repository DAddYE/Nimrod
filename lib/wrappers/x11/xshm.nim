
import 
  x, xlib

#const 
#  libX11* = "libX11.so"

#
#  Automatically converted by H2Pas 0.99.15 from xshm.h
#  The following command line parameters were used:
#    -p
#    -T
#    -S
#    -d
#    -c
#    xshm.h
#

const 
  constXShmQueryVersion* = 0
  constXShmAttach* = 1
  constXShmDetach* = 2
  constXShmPutImage* = 3
  constXShmGetImage* = 4
  constXShmCreatePixmap* = 5
  ShmCompletion* = 0
  ShmNumberEvents* = ShmCompletion + 1
  BadShmSeg* = 0
  ShmNumberErrors* = BadShmSeg + 1

type 
  PShmSeg* = ptr TShmSeg
  TShmSeg* = Culong
  PXShmCompletionEvent* = ptr TXShmCompletionEvent
  TXShmCompletionEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    drawable*: TDrawable
    major_code*: Cint
    minor_code*: Cint
    shmseg*: TShmSeg
    offset*: Culong

  PXShmSegmentInfo* = ptr TXShmSegmentInfo
  TXShmSegmentInfo*{.final.} = object 
    shmseg*: TShmSeg
    shmid*: Cint
    shmaddr*: Cstring
    readOnly*: TBool


proc XShmQueryExtension*(para1: PDisplay): TBool{.cdecl, dynlib: libX11, importc.}
proc XShmGetEventBase*(para1: PDisplay): Cint{.cdecl, dynlib: libX11, importc.}
proc XShmQueryVersion*(para1: PDisplay, para2: Pcint, para3: Pcint, para4: PBool): TBool{.
    cdecl, dynlib: libX11, importc.}
proc XShmPixmapFormat*(para1: PDisplay): Cint{.cdecl, dynlib: libX11, importc.}
proc XShmAttach*(para1: PDisplay, para2: PXShmSegmentInfo): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XShmDetach*(para1: PDisplay, para2: PXShmSegmentInfo): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XShmPutImage*(para1: PDisplay, para2: TDrawable, para3: TGC, 
                   para4: PXImage, para5: Cint, para6: Cint, para7: Cint, 
                   para8: Cint, para9: Cuint, para10: Cuint, para11: TBool): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc XShmGetImage*(para1: PDisplay, para2: TDrawable, para3: PXImage, 
                   para4: Cint, para5: Cint, para6: Culong): TStatus{.cdecl, 
    dynlib: libX11, importc.}
proc XShmCreateImage*(para1: PDisplay, para2: PVisual, para3: Cuint, 
                      para4: Cint, para5: Cstring, para6: PXShmSegmentInfo, 
                      para7: Cuint, para8: Cuint): PXImage{.cdecl, 
    dynlib: libX11, importc.}
proc XShmCreatePixmap*(para1: PDisplay, para2: TDrawable, para3: Cstring, 
                       para4: PXShmSegmentInfo, para5: Cuint, para6: Cuint, 
                       para7: Cuint): TPixmap{.cdecl, dynlib: libX11, importc.}
# implementation
