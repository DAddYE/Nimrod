#***********************************************************
#Copyright 1991 by Digital Equipment Corporation, Maynard, Massachusetts,
#and the Massachusetts Institute of Technology, Cambridge, Massachusetts.
#
#                        All Rights Reserved
#
#Permission to use, copy, modify, and distribute this software and its 
#documentation for any purpose and without fee is hereby granted, 
#provided that the above copyright notice appear in all copies and that
#both that copyright notice and this permission notice appear in 
#supporting documentation, and that the names of Digital or MIT not be
#used in advertising or publicity pertaining to distribution of the
#software without specific, written prior permission.  
#
#DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
#ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
#DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
#ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
#WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
#ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
#SOFTWARE.
#
#******************************************************************
# $XFree86: xc/include/extensions/Xvlib.h,v 1.3 1999/12/11 19:28:48 mvojkovi Exp $ 
#*
#** File: 
#**
#**   Xvlib.h --- Xv library public header file
#**
#** Author: 
#**
#**   David Carver (Digital Workstation Engineering/Project Athena)
#**
#** Revisions:
#**
#**   26.06.91 Carver
#**     - changed XvFreeAdaptors to XvFreeAdaptorInfo
#**     - changed XvFreeEncodings to XvFreeEncodingInfo
#**
#**   11.06.91 Carver
#**     - changed SetPortControl to SetPortAttribute
#**     - changed GetPortControl to GetPortAttribute
#**     - changed QueryBestSize
#**
#**   05.15.91 Carver
#**     - version 2.0 upgrade
#**
#**   01.24.91 Carver
#**     - version 1.4 upgrade
#**
#*

import 
  x, xlib, xshm, xv

const 
  libXv* = "libXv.so"

type 
  PXvRational* = ptr TXvRational
  TXvRational*{.final.} = object 
    numerator*: Cint
    denominator*: Cint

  PXvAttribute* = ptr TXvAttribute
  TXvAttribute*{.final.} = object 
    flags*: Cint              # XvGettable, XvSettable 
    min_value*: Cint
    max_value*: Cint
    name*: Cstring

  PPXvEncodingInfo* = ptr PXvEncodingInfo
  PXvEncodingInfo* = ptr TXvEncodingInfo
  TXvEncodingInfo*{.final.} = object 
    encoding_id*: TXvEncodingID
    name*: Cstring
    width*: Culong
    height*: Culong
    rate*: TXvRational
    num_encodings*: Culong

  PXvFormat* = ptr TXvFormat
  TXvFormat*{.final.} = object 
    depth*: Cchar
    visual_id*: Culong

  PPXvAdaptorInfo* = ptr PXvAdaptorInfo
  PXvAdaptorInfo* = ptr TXvAdaptorInfo
  TXvAdaptorInfo*{.final.} = object 
    base_id*: TXvPortID
    num_ports*: Culong
    thetype*: Cchar
    name*: Cstring
    num_formats*: Culong
    formats*: PXvFormat
    num_adaptors*: Culong

  PXvVideoNotifyEvent* = ptr TXvVideoNotifyEvent
  TXvVideoNotifyEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong           # # of last request processed by server 
    send_event*: TBool        # true if this came from a SendEvent request 
    display*: PDisplay        # Display the event was read from 
    drawable*: TDrawable      # drawable 
    reason*: Culong           # what generated this event 
    port_id*: TXvPortID       # what port 
    time*: TTime              # milliseconds 
  
  PXvPortNotifyEvent* = ptr TXvPortNotifyEvent
  TXvPortNotifyEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong           # # of last request processed by server 
    send_event*: TBool        # true if this came from a SendEvent request 
    display*: PDisplay        # Display the event was read from 
    port_id*: TXvPortID       # what port 
    time*: TTime              # milliseconds 
    attribute*: TAtom         # atom that identifies attribute 
    value*: Clong             # value of attribute 
  
  PXvEvent* = ptr TXvEvent
  TXvEvent*{.final.} = object 
    pad*: Array[0..23, Clong] #case longint of
                              #      0 : (
                              #            theType : cint;
                              #	  );
                              #      1 : (
                              #            xvvideo : TXvVideoNotifyEvent;
                              #          );
                              #      2 : (
                              #            xvport : TXvPortNotifyEvent;
                              #          );
                              #      3 : (
                              #            
                              #          );
  
  PXvImageFormatValues* = ptr TXvImageFormatValues
  TXvImageFormatValues*{.final.} = object 
    id*: Cint                 # Unique descriptor for the format 
    theType*: Cint            # XvRGB, XvYUV 
    byte_order*: Cint         # LSBFirst, MSBFirst 
    guid*: Array[0..15, Cchar] # Globally Unique IDentifier 
    bits_per_pixel*: Cint
    format*: Cint             # XvPacked, XvPlanar 
    num_planes*: Cint         # for RGB formats only 
    depth*: Cint
    red_mask*: Cuint
    green_mask*: Cuint
    blue_mask*: Cuint         # for YUV formats only 
    y_sample_bits*: Cuint
    u_sample_bits*: Cuint
    v_sample_bits*: Cuint
    horz_y_period*: Cuint
    horz_u_period*: Cuint
    horz_v_period*: Cuint
    vert_y_period*: Cuint
    vert_u_period*: Cuint
    vert_v_period*: Cuint
    component_order*: Array[0..31, Char] # eg. UYVY 
    scanline_order*: Cint     # XvTopToBottom, XvBottomToTop 
  
  PXvImage* = ptr TXvImage
  TXvImage*{.final.} = object 
    id*: Cint
    width*, height*: Cint
    data_size*: Cint          # bytes 
    num_planes*: Cint
    pitches*: Pcint           # bytes 
    offsets*: Pcint           # bytes 
    data*: Pointer
    obdata*: TXPointer


proc XvQueryExtension*(display: PDisplay, p_version, p_revision, p_requestBase, 
    p_eventBase, p_errorBase: Pcuint): Cint{.cdecl, dynlib: libXv, importc.}
proc XvQueryAdaptors*(display: PDisplay, window: TWindow, p_nAdaptors: Pcuint, 
                      p_pAdaptors: PPXvAdaptorInfo): Cint{.cdecl, dynlib: libXv, 
    importc.}
proc XvQueryEncodings*(display: PDisplay, port: TXvPortID, p_nEncoding: Pcuint, 
                       p_pEncoding: PPXvEncodingInfo): Cint{.cdecl, 
    dynlib: libXv, importc.}
proc XvPutVideo*(display: PDisplay, port: TXvPortID, d: TDrawable, gc: TGC, 
                 vx, vy: Cint, vw, vh: Cuint, dx, dy: Cint, dw, dh: Cuint): Cint{.
    cdecl, dynlib: libXv, importc.}
proc XvPutStill*(display: PDisplay, port: TXvPortID, d: TDrawable, gc: TGC, 
                 vx, vy: Cint, vw, vh: Cuint, dx, dy: Cint, dw, dh: Cuint): Cint{.
    cdecl, dynlib: libXv, importc.}
proc XvGetVideo*(display: PDisplay, port: TXvPortID, d: TDrawable, gc: TGC, 
                 vx, vy: Cint, vw, vh: Cuint, dx, dy: Cint, dw, dh: Cuint): Cint{.
    cdecl, dynlib: libXv, importc.}
proc XvGetStill*(display: PDisplay, port: TXvPortID, d: TDrawable, gc: TGC, 
                 vx, vy: Cint, vw, vh: Cuint, dx, dy: Cint, dw, dh: Cuint): Cint{.
    cdecl, dynlib: libXv, importc.}
proc XvStopVideo*(display: PDisplay, port: TXvPortID, drawable: TDrawable): Cint{.
    cdecl, dynlib: libXv, importc.}
proc XvGrabPort*(display: PDisplay, port: TXvPortID, time: TTime): Cint{.cdecl, 
    dynlib: libXv, importc.}
proc XvUngrabPort*(display: PDisplay, port: TXvPortID, time: TTime): Cint{.
    cdecl, dynlib: libXv, importc.}
proc XvSelectVideoNotify*(display: PDisplay, drawable: TDrawable, onoff: TBool): Cint{.
    cdecl, dynlib: libXv, importc.}
proc XvSelectPortNotify*(display: PDisplay, port: TXvPortID, onoff: TBool): Cint{.
    cdecl, dynlib: libXv, importc.}
proc XvSetPortAttribute*(display: PDisplay, port: TXvPortID, attribute: TAtom, 
                         value: Cint): Cint{.cdecl, dynlib: libXv, importc.}
proc XvGetPortAttribute*(display: PDisplay, port: TXvPortID, attribute: TAtom, 
                         p_value: Pcint): Cint{.cdecl, dynlib: libXv, importc.}
proc XvQueryBestSize*(display: PDisplay, port: TXvPortID, motion: TBool, 
                      vid_w, vid_h, drw_w, drw_h: Cuint, 
                      p_actual_width, p_actual_height: Pcuint): Cint{.cdecl, 
    dynlib: libXv, importc.}
proc XvQueryPortAttributes*(display: PDisplay, port: TXvPortID, number: Pcint): PXvAttribute{.
    cdecl, dynlib: libXv, importc.}
proc XvFreeAdaptorInfo*(adaptors: PXvAdaptorInfo){.cdecl, dynlib: libXv, importc.}
proc XvFreeEncodingInfo*(encodings: PXvEncodingInfo){.cdecl, dynlib: libXv, 
    importc.}
proc XvListImageFormats*(display: PDisplay, port_id: TXvPortID, 
                         count_return: Pcint): PXvImageFormatValues{.cdecl, 
    dynlib: libXv, importc.}
proc XvCreateImage*(display: PDisplay, port: TXvPortID, id: Cint, data: Pointer, 
                    width, height: Cint): PXvImage{.cdecl, dynlib: libXv, 
    importc.}
proc XvPutImage*(display: PDisplay, id: TXvPortID, d: TDrawable, gc: TGC, 
                 image: PXvImage, src_x, src_y: Cint, src_w, src_h: Cuint, 
                 dest_x, dest_y: Cint, dest_w, dest_h: Cuint): Cint{.cdecl, 
    dynlib: libXv, importc.}
proc XvShmPutImage*(display: PDisplay, id: TXvPortID, d: TDrawable, gc: TGC, 
                    image: PXvImage, src_x, src_y: Cint, src_w, src_h: Cuint, 
                    dest_x, dest_y: Cint, dest_w, dest_h: Cuint, 
                    send_event: TBool): Cint{.cdecl, dynlib: libXv, importc.}
proc XvShmCreateImage*(display: PDisplay, port: TXvPortID, id: Cint, 
                       data: Pointer, width, height: Cint, 
                       shminfo: PXShmSegmentInfo): PXvImage{.cdecl, 
    dynlib: libXv, importc.}
# implementation
