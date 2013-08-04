
import 
  x, xlib

when defined(use_pkg_config) or defined(use_pkg_config_static):
    {.pragma: libxrender, cdecl, importc.}
    when defined(use_pkg_config):
        {.passl: gorge("pkg-config xrender --libs").}
    else:
        {.passl: gorge("pkg-config xrender --static --libs").}
else:
    when defined(macosx):
        const 
          libXrender* = "libXrender.dylib"
    else:
        const 
          libXrender* = "libXrender.so"

    
    {.pragma: libxrender, dynlib: libXrender, cdecl, importc.}
#const 
#  libXrender* = "libXrender.so"

#
#  Automatically converted by H2Pas 0.99.15 from xrender.h
#  The following command line parameters were used:
#    -p
#    -T
#    -S
#    -d
#    -c
#    xrender.h
#

type 
  PGlyph* = ptr TGlyph
  TGlyph* = Int32
  PGlyphSet* = ptr TGlyphSet
  TGlyphSet* = Int32
  PPicture* = ptr TPicture
  TPicture* = Int32
  PPictFormat* = ptr TPictFormat
  TPictFormat* = Int32

const 
  RenderName* = "RENDER"
  RenderMajor* = 0
  RenderMinor* = 0
  constXRenderQueryVersion* = 0
  XRenderQueryPictFormats* = 1
  XRenderQueryPictIndexValues* = 2
  XRenderQueryDithers* = 3
  constXRenderCreatePicture* = 4
  constXRenderChangePicture* = 5
  XRenderSetPictureClipRectangles* = 6
  constXRenderFreePicture* = 7
  constXRenderComposite* = 8
  XRenderScale* = 9
  XRenderTrapezoids* = 10
  XRenderTriangles* = 11
  XRenderTriStrip* = 12
  XRenderTriFan* = 13
  XRenderColorTrapezoids* = 14
  XRenderColorTriangles* = 15
  XRenderTransform* = 16
  constXRenderCreateGlyphSet* = 17
  constXRenderReferenceGlyphSet* = 18
  constXRenderFreeGlyphSet* = 19
  constXRenderAddGlyphs* = 20
  constXRenderAddGlyphsFromPicture* = 21
  constXRenderFreeGlyphs* = 22
  constXRenderCompositeGlyphs8* = 23
  constXRenderCompositeGlyphs16* = 24
  constXRenderCompositeGlyphs32* = 25
  BadPictFormat* = 0
  BadPicture* = 1
  BadPictOp* = 2
  BadGlyphSet* = 3
  BadGlyph* = 4
  RenderNumberErrors* = BadGlyph + 1
  PictTypeIndexed* = 0
  PictTypeDirect* = 1
  PictOpClear* = 0
  PictOpSrc* = 1
  PictOpDst* = 2
  PictOpOver* = 3
  PictOpOverReverse* = 4
  PictOpIn* = 5
  PictOpInReverse* = 6
  PictOpOut* = 7
  PictOpOutReverse* = 8
  PictOpAtop* = 9
  PictOpAtopReverse* = 10
  PictOpXor* = 11
  PictOpAdd* = 12
  PictOpSaturate* = 13
  PictOpMaximum* = 13
  PolyEdgeSharp* = 0
  PolyEdgeSmooth* = 1
  PolyModePrecise* = 0
  PolyModeImprecise* = 1
  CPRepeat* = 1 shl 0
  CPAlphaMap* = 1 shl 1
  CPAlphaXOrigin* = 1 shl 2
  CPAlphaYOrigin* = 1 shl 3
  CPClipXOrigin* = 1 shl 4
  CPClipYOrigin* = 1 shl 5
  CPClipMask* = 1 shl 6
  CPGraphicsExposure* = 1 shl 7
  CPSubwindowMode* = 1 shl 8
  CPPolyEdge* = 1 shl 9
  CPPolyMode* = 1 shl 10
  CPDither* = 1 shl 11
  CPLastBit* = 11

type 
  PXRenderDirectFormat* = ptr TXRenderDirectFormat
  TXRenderDirectFormat*{.final.} = object 
    red*: Int16
    redMask*: Int16
    green*: Int16
    greenMask*: Int16
    blue*: Int16
    blueMask*: Int16
    alpha*: Int16
    alphaMask*: Int16

  PXRenderPictFormat* = ptr TXRenderPictFormat
  TXRenderPictFormat*{.final.} = object 
    id*: TPictFormat
    thetype*: Int32
    depth*: Int32
    direct*: TXRenderDirectFormat
    colormap*: TColormap


const 
  PictFormatID* = 1 shl 0
  PictFormatType* = 1 shl 1
  PictFormatDepth* = 1 shl 2
  PictFormatRed* = 1 shl 3
  PictFormatRedMask* = 1 shl 4
  PictFormatGreen* = 1 shl 5
  PictFormatGreenMask* = 1 shl 6
  PictFormatBlue* = 1 shl 7
  PictFormatBlueMask* = 1 shl 8
  PictFormatAlpha* = 1 shl 9
  PictFormatAlphaMask* = 1 shl 10
  PictFormatColormap* = 1 shl 11

type 
  PXRenderVisual* = ptr TXRenderVisual
  TXRenderVisual*{.final.} = object 
    visual*: PVisual
    format*: PXRenderPictFormat

  PXRenderDepth* = ptr TXRenderDepth
  TXRenderDepth*{.final.} = object 
    depth*: Int32
    nvisuals*: Int32
    visuals*: PXRenderVisual

  PXRenderScreen* = ptr TXRenderScreen
  TXRenderScreen*{.final.} = object 
    depths*: PXRenderDepth
    ndepths*: Int32
    fallback*: PXRenderPictFormat

  PXRenderInfo* = ptr TXRenderInfo
  TXRenderInfo*{.final.} = object 
    format*: PXRenderPictFormat
    nformat*: Int32
    screen*: PXRenderScreen
    nscreen*: Int32
    depth*: PXRenderDepth
    ndepth*: Int32
    visual*: PXRenderVisual
    nvisual*: Int32

  PXRenderPictureAttributes* = ptr TXRenderPictureAttributes
  TXRenderPictureAttributes*{.final.} = object 
    repeat*: TBool
    alpha_map*: TPicture
    alpha_x_origin*: Int32
    alpha_y_origin*: Int32
    clip_x_origin*: Int32
    clip_y_origin*: Int32
    clip_mask*: TPixmap
    graphics_exposures*: TBool
    subwindow_mode*: Int32
    poly_edge*: Int32
    poly_mode*: Int32
    dither*: TAtom

  PXGlyphInfo* = ptr TXGlyphInfo
  TXGlyphInfo*{.final.} = object 
    width*: Int16
    height*: Int16
    x*: Int16
    y*: Int16
    xOff*: Int16
    yOff*: Int16


proc XRenderQueryExtension*(dpy: PDisplay, event_basep: ptr Int32, 
                            error_basep: ptr Int32): TBool{.libxrender.}
proc XRenderQueryVersion*(dpy: PDisplay, major_versionp: ptr Int32, 
                          minor_versionp: ptr Int32): TStatus{.libxrender.}
proc XRenderQueryFormats*(dpy: PDisplay): TStatus{.libxrender.}
proc XRenderFindVisualFormat*(dpy: PDisplay, visual: PVisual): PXRenderPictFormat{.
    libxrender.}
proc XRenderFindFormat*(dpy: PDisplay, mask: Int32, 
                        `template`: PXRenderPictFormat, count: Int32): PXRenderPictFormat{.
    libxrender.}
proc XRenderCreatePicture*(dpy: PDisplay, drawable: TDrawable, 
                           format: PXRenderPictFormat, valuemask: Int32, 
                           attributes: PXRenderPictureAttributes): TPicture{.
    libxrender.}
proc XRenderChangePicture*(dpy: PDisplay, picture: TPicture, valuemask: Int32, 
                           attributes: PXRenderPictureAttributes){.libxrender.}
proc XRenderFreePicture*(dpy: PDisplay, picture: TPicture){.libxrender.}
proc XRenderComposite*(dpy: PDisplay, op: Int32, src: TPicture, mask: TPicture, 
                       dst: TPicture, src_x: Int32, src_y: Int32, mask_x: Int32, 
                       mask_y: Int32, dst_x: Int32, dst_y: Int32, width: Int32, 
                       height: Int32){.libxrender.}
proc XRenderCreateGlyphSet*(dpy: PDisplay, format: PXRenderPictFormat): TGlyphSet{.
    libxrender.}
proc XRenderReferenceGlyphSet*(dpy: PDisplay, existing: TGlyphSet): TGlyphSet{.
    libxrender.}
proc XRenderFreeGlyphSet*(dpy: PDisplay, glyphset: TGlyphSet){.libxrender.}
proc XRenderAddGlyphs*(dpy: PDisplay, glyphset: TGlyphSet, gids: PGlyph, 
                       glyphs: PXGlyphInfo, nglyphs: Int32, images: Cstring, 
                       nbyte_images: Int32){.libxrender.}
proc XRenderFreeGlyphs*(dpy: PDisplay, glyphset: TGlyphSet, gids: PGlyph, 
                        nglyphs: Int32){.libxrender.}
proc XRenderCompositeString8*(dpy: PDisplay, op: Int32, src: TPicture, 
                              dst: TPicture, maskFormat: PXRenderPictFormat, 
                              glyphset: TGlyphSet, xSrc: Int32, ySrc: Int32, 
                              xDst: Int32, yDst: Int32, str: Cstring, 
                              nchar: Int32){.libxrender.}
# implementation
