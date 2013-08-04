{.deadCodeElim: on.}
import 
  glib2

when defined(win32): 
  const 
    pixbuflib = "libgdk_pixbuf-2.0-0.dll"
elif defined(macosx): 
  const 
    pixbuflib = "libgdk_pixbuf-2.0.0.dylib"
  # linklib gtk-x11-2.0
  # linklib gdk-x11-2.0
  # linklib pango-1.0.0
  # linklib glib-2.0.0
  # linklib gobject-2.0.0
  # linklib gdk_pixbuf-2.0.0
  # linklib atk-1.0.0
else: 
  const 
    pixbuflib = "libgdk_pixbuf-2.0.so"
type 
  PPixbuf* = Pointer
  PPixbufAnimation* = Pointer
  PPixbufAnimationIter* = Pointer
  PPixbufAlphaMode* = ptr TPixbufAlphaMode
  TPixbufAlphaMode* = enum 
    PIXBUF_ALPHA_BILEVEL, PIXBUF_ALPHA_FULL
  PColorspace* = ptr TColorspace
  TColorspace* = enum 
    COLORSPACE_RGB
  TPixbufDestroyNotify* = proc (pixels: Pguchar, data: Gpointer){.cdecl.}
  PPixbufError* = ptr TPixbufError
  TPixbufError* = enum 
    PIXBUF_ERROR_CORRUPT_IMAGE, PIXBUF_ERROR_INSUFFICIENT_MEMORY, 
    PIXBUF_ERROR_BAD_OPTION, PIXBUF_ERROR_UNKNOWN_TYPE, 
    PIXBUF_ERROR_UNSUPPORTED_OPERATION, PIXBUF_ERROR_FAILED
  PInterpType* = ptr TInterpType
  TInterpType* = enum 
    INTERP_NEAREST, INTERP_TILES, INTERP_BILINEAR, INTERP_HYPER

proc typePixbuf*(): GType
proc pixbuf*(anObject: Pointer): PPixbuf
proc isPixbuf*(anObject: Pointer): Bool
proc typePixbufAnimation*(): GType
proc pixbufAnimation*(anObject: Pointer): PPixbufAnimation
proc isPixbufAnimation*(anObject: Pointer): Bool
proc typePixbufAnimationIter*(): GType
proc pixbufAnimationIter*(anObject: Pointer): PPixbufAnimationIter
proc isPixbufAnimationIter*(anObject: Pointer): Bool
proc pixbufError*(): TGQuark
proc pixbufErrorQuark*(): TGQuark{.cdecl, dynlib: pixbuflib, 
                                     importc: "gdk_pixbuf_error_quark".}
proc pixbufGetType*(): GType{.cdecl, dynlib: pixbuflib, 
                                importc: "gdk_pixbuf_get_type".}
when not defined(PIXBUF_DISABLE_DEPRECATED): 
  proc pixbufRef*(pixbuf: PPixbuf): PPixbuf{.cdecl, dynlib: pixbuflib, 
      importc: "gdk_pixbuf_ref".}
  proc pixbufUnref*(pixbuf: PPixbuf){.cdecl, dynlib: pixbuflib, 
                                       importc: "gdk_pixbuf_unref".}
proc getColorspace*(pixbuf: PPixbuf): TColorspace{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_get_colorspace".}
proc getNChannels*(pixbuf: PPixbuf): Int32{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_get_n_channels".}
proc getHasAlpha*(pixbuf: PPixbuf): Gboolean{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_get_has_alpha".}
proc getBitsPerSample*(pixbuf: PPixbuf): Int32{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_get_bits_per_sample".}
proc getPixels*(pixbuf: PPixbuf): Pguchar{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_get_pixels".}
proc getWidth*(pixbuf: PPixbuf): Int32{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_get_width".}
proc getHeight*(pixbuf: PPixbuf): Int32{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_get_height".}
proc getRowstride*(pixbuf: PPixbuf): Int32{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_get_rowstride".}
proc pixbufNew*(colorspace: TColorspace, has_alpha: Gboolean, 
                 bits_per_sample: Int32, width: Int32, height: Int32): PPixbuf{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_new".}
proc copy*(pixbuf: PPixbuf): PPixbuf{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_copy".}
proc newSubpixbuf*(src_pixbuf: PPixbuf, src_x: Int32, src_y: Int32, 
                           width: Int32, height: Int32): PPixbuf{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_new_subpixbuf".}
proc pixbufNewFromFile*(filename: Cstring, error: Pointer): PPixbuf{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_new_from_file".}
proc pixbufNewFromData*(data: Pguchar, colorspace: TColorspace, 
                           has_alpha: Gboolean, bits_per_sample: Int32, 
                           width: Int32, height: Int32, rowstride: Int32, 
                           destroy_fn: TPixbufDestroyNotify, 
                           destroy_fn_data: Gpointer): PPixbuf{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_new_from_data".}
proc pixbufNewFromXpmData*(data: PPchar): PPixbuf{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_new_from_xpm_data".}
proc pixbufNewFromInline*(data_length: Gint, a: var Guint8, 
                             copy_pixels: Gboolean, error: Pointer): PPixbuf{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_new_from_inline".}
proc pixbufNewFromFileAtSize*(filename: Cstring, width, height: gint, 
                                   error: Pointer): PPixbuf{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_new_from_file_at_size".}
proc pixbufNewFromFileAtScale*(filename: Cstring, width, height: gint, 
                                    preserve_aspect_ratio: Gboolean, 
                                    error: Pointer): PPixbuf{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_new_from_file_at_scale".}
proc fill*(pixbuf: PPixbuf, pixel: Guint32){.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_fill".}
proc save*(pixbuf: PPixbuf, filename: Cstring, `type`: Cstring, 
                  error: Pointer): Gboolean{.cdecl, varargs, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_save".}
proc savev*(pixbuf: PPixbuf, filename: Cstring, `type`: Cstring, 
                   option_keys: PPchar, option_values: PPchar, error: Pointer): Gboolean{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_savev".}
proc addAlpha*(pixbuf: PPixbuf, substitute_color: Gboolean, r: Guchar, 
                       g: Guchar, b: Guchar): PPixbuf{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_add_alpha".}
proc copyArea*(src_pixbuf: PPixbuf, src_x: Int32, src_y: Int32, 
                       width: Int32, height: Int32, dest_pixbuf: PPixbuf, 
                       dest_x: Int32, dest_y: Int32){.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_copy_area".}
proc saturateAndPixelate*(src: PPixbuf, dest: PPixbuf, 
                                   saturation: Gfloat, pixelate: Gboolean){.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_saturate_and_pixelate".}
proc scale*(src: PPixbuf, dest: PPixbuf, dest_x: Int32, dest_y: Int32, 
                   dest_width: Int32, dest_height: Int32, offset_x: Float64, 
                   offset_y: Float64, scale_x: Float64, scale_y: Float64, 
                   interp_type: TInterpType){.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_scale".}
proc composite*(src: PPixbuf, dest: PPixbuf, dest_x: Int32, 
                       dest_y: Int32, dest_width: Int32, dest_height: Int32, 
                       offset_x: Float64, offset_y: Float64, scale_x: Float64, 
                       scale_y: Float64, interp_type: TInterpType, 
                       overall_alpha: Int32){.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_composite".}
proc compositeColor*(src: PPixbuf, dest: PPixbuf, dest_x: Int32, 
                             dest_y: Int32, dest_width: Int32, 
                             dest_height: Int32, offset_x: Float64, 
                             offset_y: Float64, scale_x: Float64, 
                             scale_y: Float64, interp_type: TInterpType, 
                             overall_alpha: Int32, check_x: Int32, 
                             check_y: Int32, check_size: Int32, color1: Guint32, 
                             color2: Guint32){.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_composite_color".}
proc scaleSimple*(src: PPixbuf, dest_width: Int32, dest_height: Int32, 
                          interp_type: TInterpType): PPixbuf{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_scale_simple".}
proc compositeColorSimple*(src: PPixbuf, dest_width: Int32, 
                                    dest_height: Int32, 
                                    interp_type: TInterpType, 
                                    overall_alpha: Int32, check_size: Int32, 
                                    color1: Guint32, color2: Guint32): PPixbuf{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_composite_color_simple".}
proc pixbufAnimationGetType*(): GType{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_animation_get_type".}
proc pixbufAnimationNewFromFile*(filename: Cstring, error: Pointer): PPixbufAnimation{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_animation_new_from_file".}
when not defined(PIXBUF_DISABLE_DEPRECATED): 
  proc pixbufAnimationRef*(animation: PPixbufAnimation): PPixbufAnimation{.
      cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_animation_ref".}
  proc pixbufAnimationUnref*(animation: PPixbufAnimation){.cdecl, 
      dynlib: pixbuflib, importc: "gdk_pixbuf_animation_unref".}
proc getWidth*(animation: PPixbufAnimation): Int32{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_animation_get_width".}
proc getHeight*(animation: PPixbufAnimation): Int32{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_animation_get_height".}
proc isStaticImage*(animation: PPixbufAnimation): Gboolean{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_animation_is_static_image".}
proc getStaticImage*(animation: PPixbufAnimation): PPixbuf{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_animation_get_static_image".}
proc getIter*(animation: PPixbufAnimation, e: var TGTimeVal): PPixbufAnimationIter{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_animation_get_iter".}
proc pixbufAnimationIterGetType*(): GType{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_animation_iter_get_type".}
proc iterGetDelayTime*(iter: PPixbufAnimationIter): Int32{.
    cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_animation_iter_get_delay_time".}
proc iterGetPixbuf*(iter: PPixbufAnimationIter): PPixbuf{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_animation_iter_get_pixbuf".}
proc pixbufAnimationIterOnCurrentlyLoadingFrame*(
    iter: PPixbufAnimationIter): Gboolean{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_animation_iter_on_currently_loading_frame".}
proc iterAdvance*(iter: PPixbufAnimationIter, e: var TGTimeVal): Gboolean{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_animation_iter_advance".}
proc getOption*(pixbuf: PPixbuf, key: Cstring): Cstring{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_get_option".}
type 
  PPixbufLoader* = ptr TPixbufLoader
  TPixbufLoader*{.final, pure.} = object 
    parent_instance*: TGObject
    priv*: Gpointer

  PPixbufLoaderClass* = ptr TPixbufLoaderClass
  TPixbufLoaderClass*{.final, pure.} = object 
    parent_class*: TGObjectClass
    area_prepared*: proc (loader: PPixbufLoader){.cdecl.}
    area_updated*: proc (loader: PPixbufLoader, x: Int32, y: Int32, 
                         width: Int32, height: Int32){.cdecl.}
    closed*: proc (loader: PPixbufLoader){.cdecl.}


proc typePixbufLoader*(): GType
proc pixbufLoader*(obj: Pointer): PPixbufLoader
proc pixbufLoaderClass*(klass: Pointer): PPixbufLoaderClass
proc isPixbufLoader*(obj: Pointer): Bool
proc isPixbufLoaderClass*(klass: Pointer): Bool
proc pixbufLoaderGetClass*(obj: Pointer): PPixbufLoaderClass
proc pixbufLoaderGetType*(): GType{.cdecl, dynlib: pixbuflib, 
                                       importc: "gdk_pixbuf_loader_get_type".}
proc pixbufLoaderNew*(): PPixbufLoader{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_loader_new".}
proc pixbufLoaderNew*(image_type: Cstring, error: Pointer): PPixbufLoader{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_loader_new_with_type".}
proc write*(loader: PPixbufLoader, buf: Pguchar, count: Gsize, 
                          error: Pointer): Gboolean{.cdecl, dynlib: pixbuflib, 
    importc: "gdk_pixbuf_loader_write".}
proc getPixbuf*(loader: PPixbufLoader): PPixbuf{.cdecl, 
    dynlib: pixbuflib, importc: "gdk_pixbuf_loader_get_pixbuf".}
proc getAnimation*(loader: PPixbufLoader): PPixbufAnimation{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_loader_get_animation".}
proc close*(loader: PPixbufLoader, error: Pointer): Gboolean{.
    cdecl, dynlib: pixbuflib, importc: "gdk_pixbuf_loader_close".}
proc typePixbufLoader*(): GType = 
  result = pixbufLoaderGetType()

proc pixbufLoader*(obj: pointer): PPixbufLoader = 
  result = cast[PPixbufLoader](gTypeCheckInstanceCast(obj, 
      typePixbufLoader()))

proc pixbufLoaderClass*(klass: pointer): PPixbufLoaderClass = 
  result = cast[PPixbufLoaderClass](gTypeCheckClassCast(klass, 
      typePixbufLoader()))

proc isPixbufLoader*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typePixbufLoader())

proc isPixbufLoaderClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typePixbufLoader())

proc pixbufLoaderGetClass*(obj: pointer): PPixbufLoaderClass = 
  result = cast[PPixbufLoaderClass](gTypeInstanceGetClass(obj, 
      typePixbufLoader()))

proc typePixbuf*(): GType = 
  result = pixbufGetType()

proc pixbuf*(anObject: pointer): PPixbuf = 
  result = cast[PPixbuf](gTypeCheckInstanceCast(anObject, typePixbuf()))

proc isPixbuf*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typePixbuf())

proc typePixbufAnimation*(): GType = 
  result = pixbufAnimationGetType()

proc pixbufAnimation*(anObject: pointer): PPixbufAnimation = 
  result = cast[PPixbufAnimation](gTypeCheckInstanceCast(anObject, 
      typePixbufAnimation()))

proc isPixbufAnimation*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typePixbufAnimation())

proc typePixbufAnimationIter*(): GType = 
  result = pixbufAnimationIterGetType()

proc pixbufAnimationIter*(anObject: pointer): PPixbufAnimationIter = 
  result = cast[PPixbufAnimationIter](gTypeCheckInstanceCast(anObject, 
      typePixbufAnimationIter()))

proc isPixbufAnimationIter*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typePixbufAnimationIter())

proc pixbufError*(): TGQuark = 
  result = pixbufErrorQuark()
