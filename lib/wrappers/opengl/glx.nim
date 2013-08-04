#
#
#  Translation of the Mesa GLX headers for FreePascal
#  Copyright (C) 1999 Sebastian Guenther
#
#
#  Mesa 3-D graphics library
#  Version:  3.0
#  Copyright (C) 1995-1998  Brian Paul
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Library General Public
#  License as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Library General Public License for more details.
#
#  You should have received a copy of the GNU Library General Public
#  License along with this library; if not, write to the Free
#  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#

import 
  X, XLib, XUtil, gl

when defined(windows): 
  const 
    dllname = "GL.dll"
elif defined(macosx): 
  const 
    dllname = "/usr/X11R6/lib/libGL.dylib"
else: 
  const 
    dllname = "libGL.so"
const 
  GlxUseGl* = 1
  GlxBufferSize* = 2
  GlxLevel* = 3
  GlxRgba* = 4
  GlxDoublebuffer* = 5
  GlxStereo* = 6
  GlxAuxBuffers* = 7
  GlxRedSize* = 8
  GlxGreenSize* = 9
  GlxBlueSize* = 10
  GlxAlphaSize* = 11
  GlxDepthSize* = 12
  GlxStencilSize* = 13
  GlxAccumRedSize* = 14
  GlxAccumGreenSize* = 15
  GlxAccumBlueSize* = 16
  GlxAccumAlphaSize* = 17  # GLX_EXT_visual_info extension
  GlxXVisualTypeExt* = 0x00000022
  GlxTransparentTypeExt* = 0x00000023
  GlxTransparentIndexValueExt* = 0x00000024
  GlxTransparentRedValueExt* = 0x00000025
  GlxTransparentGreenValueExt* = 0x00000026
  GlxTransparentBlueValueExt* = 0x00000027
  GlxTransparentAlphaValueExt* = 0x00000028 # Error codes returned by glXGetConfig:
  GlxBadScreen* = 1
  GlxBadAttribute* = 2
  GlxNoExtension* = 3
  GlxBadVisual* = 4
  GlxBadContext* = 5
  GlxBadValue* = 6
  GlxBadEnum* = 7           # GLX 1.1 and later:
  GlxVendor* = 1
  GlxVersion* = 2
  GlxExtensions* = 3         # GLX_visual_info extension
  GlxTrueColorExt* = 0x00008002
  GlxDirectColorExt* = 0x00008003
  GlxPseudoColorExt* = 0x00008004
  GlxStaticColorExt* = 0x00008005
  GlxGrayScaleExt* = 0x00008006
  GlxStaticGrayExt* = 0x00008007
  GlxNoneExt* = 0x00008000
  GlxTransparentRgbExt* = 0x00008008
  GlxTransparentIndexExt* = 0x00008009

type                          # From XLib:
  XPixmap* = TXID
  XFont* = TXID
  XColormap* = TXID
  GLXContext* = Pointer
  GLXPixmap* = TXID
  GLXDrawable* = TXID
  GLXContextID* = TXID
  TXPixmap* = XPixmap
  TXFont* = XFont
  TXColormap* = XColormap
  TGLXContext* = GLXContext
  TGLXPixmap* = GLXPixmap
  TGLXDrawable* = GLXDrawable
  TGLXContextID* = GLXContextID

proc glXChooseVisual*(dpy: PDisplay, screen: Int, attribList: ptr Int32): PXVisualInfo{.
    cdecl, dynlib: dllname, importc: "glXChooseVisual".}
proc glXCreateContext*(dpy: PDisplay, vis: PXVisualInfo, shareList: GLXContext, 
                       direct: Bool): GLXContext{.cdecl, dynlib: dllname, 
    importc: "glXCreateContext".}
proc glXDestroyContext*(dpy: PDisplay, ctx: GLXContext){.cdecl, dynlib: dllname, 
    importc: "glXDestroyContext".}
proc glXMakeCurrent*(dpy: PDisplay, drawable: GLXDrawable, ctx: GLXContext): Bool{.
    cdecl, dynlib: dllname, importc: "glXMakeCurrent".}
proc glXCopyContext*(dpy: PDisplay, src, dst: GLXContext, mask: Int32){.cdecl, 
    dynlib: dllname, importc: "glXCopyContext".}
proc glXSwapBuffers*(dpy: PDisplay, drawable: GLXDrawable){.cdecl, 
    dynlib: dllname, importc: "glXSwapBuffers".}
proc glXCreateGLXPixmap*(dpy: PDisplay, visual: PXVisualInfo, pixmap: XPixmap): GLXPixmap{.
    cdecl, dynlib: dllname, importc: "glXCreateGLXPixmap".}
proc glXDestroyGLXPixmap*(dpy: PDisplay, pixmap: GLXPixmap){.cdecl, 
    dynlib: dllname, importc: "glXDestroyGLXPixmap".}
proc glXQueryExtension*(dpy: PDisplay, errorb, event: var Int): Bool{.cdecl, 
    dynlib: dllname, importc: "glXQueryExtension".}
proc glXQueryVersion*(dpy: PDisplay, maj, min: var Int): Bool{.cdecl, 
    dynlib: dllname, importc: "glXQueryVersion".}
proc glXIsDirect*(dpy: PDisplay, ctx: GLXContext): Bool{.cdecl, dynlib: dllname, 
    importc: "glXIsDirect".}
proc glXGetConfig*(dpy: PDisplay, visual: PXVisualInfo, attrib: Int, 
                   value: var Int): Int{.cdecl, dynlib: dllname, 
    importc: "glXGetConfig".}
proc glXGetCurrentContext*(): GLXContext{.cdecl, dynlib: dllname, 
    importc: "glXGetCurrentContext".}
proc glXGetCurrentDrawable*(): GLXDrawable{.cdecl, dynlib: dllname, 
    importc: "glXGetCurrentDrawable".}
proc glXWaitGL*(){.cdecl, dynlib: dllname, importc: "glXWaitGL".}
proc glXWaitX*(){.cdecl, dynlib: dllname, importc: "glXWaitX".}
proc glXUseXFont*(font: XFont, first, count, list: Int){.cdecl, dynlib: dllname, 
    importc: "glXUseXFont".}
  # GLX 1.1 and later
proc glXQueryExtensionsString*(dpy: PDisplay, screen: Int): Cstring{.cdecl, 
    dynlib: dllname, importc: "glXQueryExtensionsString".}
proc glXQueryServerString*(dpy: PDisplay, screen, name: Int): Cstring{.cdecl, 
    dynlib: dllname, importc: "glXQueryServerString".}
proc glXGetClientString*(dpy: PDisplay, name: Int): Cstring{.cdecl, 
    dynlib: dllname, importc: "glXGetClientString".}
  # Mesa GLX Extensions
proc glXCreateGLXPixmapMESA*(dpy: PDisplay, visual: PXVisualInfo, 
                             pixmap: XPixmap, cmap: XColormap): GLXPixmap{.
    cdecl, dynlib: dllname, importc: "glXCreateGLXPixmapMESA".}
proc glXReleaseBufferMESA*(dpy: PDisplay, d: GLXDrawable): Bool{.cdecl, 
    dynlib: dllname, importc: "glXReleaseBufferMESA".}
proc glXCopySubBufferMESA*(dpy: PDisplay, drawbale: GLXDrawable, 
                           x, y, width, height: Int){.cdecl, dynlib: dllname, 
    importc: "glXCopySubBufferMESA".}
proc glXGetVideoSyncSGI*(counter: var Int32): Int{.cdecl, dynlib: dllname, 
    importc: "glXGetVideoSyncSGI".}
proc glXWaitVideoSyncSGI*(divisor, remainder: Int, count: var Int32): Int{.
    cdecl, dynlib: dllname, importc: "glXWaitVideoSyncSGI".}
# implementation
