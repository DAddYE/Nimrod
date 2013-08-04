{.deadCodeElim: on.}
import 
  Glib2, gdk2

when defined(WIN32): 
  const 
    GLExtLib = "libgdkglext-win32-1.0-0.dll"
elif defined(macosx): 
  const 
    GLExtLib = "libgdkglext-x11-1.0.dylib"
else: 
  const 
    GLExtLib = "libgdkglext-x11-1.0.so"
type 
  TGLConfigAttrib* = Int32
  TGLConfigCaveat* = Int32
  TGLVisualType* = Int32
  TGLTransparentType* = Int32
  TGLDrawableTypeMask* = Int32
  TGLRenderTypeMask* = Int32
  TGLBufferMask* = Int32
  TGLConfigError* = Int32
  TGLRenderType* = Int32
  TGLDrawableAttrib* = Int32
  TGLPbufferAttrib* = Int32
  TGLEventMask* = Int32
  TGLEventType* = Int32
  TGLDrawableType* = Int32
  TGLProc* = Pointer
  PGLConfig* = ptr TGLConfig
  PGLContext* = ptr TGLContext
  PGLDrawable* = ptr TGLDrawable
  PGLPixmap* = ptr TGLPixmap
  PGLWindow* = ptr TGLWindow
  TGLConfig* = object of TGObject
    layer_plane*: Gint
    n_aux_buffers*: Gint
    n_sample_buffers*: Gint
    flag0*: Int16

  PGLConfigClass* = ptr TGLConfigClass
  TGLConfigClass* = object of TGObjectClass
  TGLContext* = object of TGObject
  PGLContextClass* = ptr TGLContextClass
  TGLContextClass* = object of TGObjectClass
  TGLDrawable* = object of TGObject
  PGLDrawableClass* = ptr TGLDrawableClass
  TGLDrawableClass* = object of TGTypeInterface
    create_new_context*: proc (gldrawable: PGLDrawable, share_list: PGLContext, 
                               direct: Gboolean, render_type: Int32): PGLContext{.
        cdecl.}
    make_context_current*: proc (draw: PGLDrawable, a_read: PGLDrawable, 
                                 glcontext: PGLContext): Gboolean{.cdecl.}
    is_double_buffered*: proc (gldrawable: PGLDrawable): Gboolean{.cdecl.}
    swap_buffers*: proc (gldrawable: PGLDrawable){.cdecl.}
    wait_gl*: proc (gldrawable: PGLDrawable){.cdecl.}
    wait_gdk*: proc (gldrawable: PGLDrawable){.cdecl.}
    gl_begin*: proc (draw: PGLDrawable, a_read: PGLDrawable, 
                     glcontext: PGLContext): Gboolean{.cdecl.}
    gl_end*: proc (gldrawable: PGLDrawable){.cdecl.}
    get_gl_config*: proc (gldrawable: PGLDrawable): PGLConfig{.cdecl.}
    get_size*: proc (gldrawable: PGLDrawable, width, height: Pgint){.cdecl.}

  TGLPixmap* = object of TGObject
    drawable*: PDrawable

  PGLPixmapClass* = ptr TGLPixmapClass
  TGLPixmapClass* = object of TGObjectClass
  TGLWindow* = object of TGObject
    drawable*: PDrawable

  PGLWindowClass* = ptr TGLWindowClass
  TGLWindowClass* = object of TGObjectClass

const 
  HeaderGdkglextMajorVersion* = 1
  HeaderGdkglextMinorVersion* = 0
  HeaderGdkglextMicroVersion* = 6
  HeaderGdkglextInterfaceAge* = 4
  HeaderGdkglextBinaryAge* = 6

proc headerGdkglextCheckVersion*(major, minor, micro: Guint): Bool
var 
  glext_major_version*{.importc, dynlib: GLExtLib.}: Guint
  glext_minor_version*{.importc, dynlib: GLExtLib.}: Guint
  glext_micro_version*{.importc, dynlib: GLExtLib.}: Guint
  glext_interface_age*{.importc, dynlib: GLExtLib.}: Guint
  glext_binary_age*{.importc, dynlib: GLExtLib.}: Guint

const 
  GlSuccess* = 0
  GlAttribListNone* = 0
  GlUseGl* = 1
  GlBufferSize* = 2
  GlLevel* = 3
  GlRgba* = 4
  GlDoublebuffer* = 5
  GlStereo* = 6
  GlAuxBuffers* = 7
  GlRedSize* = 8
  GlGreenSize* = 9
  GlBlueSize* = 10
  GlAlphaSize* = 11
  GlDepthSize* = 12
  GlStencilSize* = 13
  GlAccumRedSize* = 14
  GlAccumGreenSize* = 15
  GlAccumBlueSize* = 16
  GlAccumAlphaSize* = 17
  GlConfigCaveat* = 0x00000020
  GlXVisualType* = 0x00000022
  GlTransparentType* = 0x00000023
  GlTransparentIndexValue* = 0x00000024
  GlTransparentRedValue* = 0x00000025
  GlTransparentGreenValue* = 0x00000026
  GlTransparentBlueValue* = 0x00000027
  GlTransparentAlphaValue* = 0x00000028
  GlDrawableType* = 0x00008010
  GlRenderType* = 0x00008011
  GlXRenderable* = 0x00008012
  GlFbconfigId* = 0x00008013
  GlMaxPbufferWidth* = 0x00008016
  GlMaxPbufferHeight* = 0x00008017
  GlMaxPbufferPixels* = 0x00008018
  GlVisualId* = 0x0000800B
  GlScreen* = 0x0000800C
  GlSampleBuffers* = 100000
  GlSamples* = 100001
  GlDontCare* = 0xFFFFFFFF
  GlNone* = 0x00008000
  GlConfigCaveatDontCare* = 0xFFFFFFFF
  GlConfigCaveatNone* = 0x00008000
  GlSlowConfig* = 0x00008001
  GlNonConformantConfig* = 0x0000800D
  GlVisualTypeDontCare* = 0xFFFFFFFF
  GlTrueColor* = 0x00008002
  GlDirectColor* = 0x00008003
  GlPseudoColor* = 0x00008004
  GlStaticColor* = 0x00008005
  GlGrayScale* = 0x00008006
  GlStaticGray* = 0x00008007
  GlTransparentNone* = 0x00008000
  GlTransparentRgb* = 0x00008008
  GlTransparentIndex* = 0x00008009
  GlWindowBit* = 1 shl 0
  GlPixmapBit* = 1 shl 1
  GlPbufferBit* = 1 shl 2
  GlRgbaBit* = 1 shl 0
  GlColorIndexBit* = 1 shl 1
  GlFrontLeftBufferBit* = 1 shl 0
  GlFrontRightBufferBit* = 1 shl 1
  GlBackLeftBufferBit* = 1 shl 2
  GlBackRightBufferBit* = 1 shl 3
  GlAuxBuffersBit* = 1 shl 4
  GlDepthBufferBit* = 1 shl 5
  GlStencilBufferBit* = 1 shl 6
  GlAccumBufferBit* = 1 shl 7
  GlBadScreen* = 1
  GlBadAttribute* = 2
  GlNoExtension* = 3
  GlBadVisual* = 4
  GlBadContext* = 5
  GlBadValue* = 6
  GlBadEnum* = 7
  GlRgbaType* = 0x00008014
  GlColorIndexType* = 0x00008015
  GlPreservedContents* = 0x0000801B
  GlLargestPbuffer* = 0x0000801C
  GlWidth* = 0x0000801D
  GlHeight* = 0x0000801E
  GlEventMask* = 0x0000801F
  GlPbufferPreservedContents* = 0x0000801B
  GlPbufferLargestPbuffer* = 0x0000801C
  GlPbufferHeight* = 0x00008040
  GlPbufferWidth* = 0x00008041
  GlPbufferClobberMask* = 1 shl 27
  GlDamaged* = 0x00008020
  GlSaved* = 0x00008021
  GlWindowValue* = 0x00008022
  GlPbuffer* = 0x00008023

proc glConfigAttribGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_config_attrib_get_type".}
proc typeGlConfigAttrib*(): GType{.cdecl, dynlib: GLExtLib, 
                                      importc: "gdk_gl_config_attrib_get_type".}
proc glConfigCaveatGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_config_caveat_get_type".}
proc typeGlConfigCaveat*(): GType{.cdecl, dynlib: GLExtLib, 
                                      importc: "gdk_gl_config_caveat_get_type".}
proc glVisualTypeGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                        importc: "gdk_gl_visual_type_get_type".}
proc typeGlVisualType*(): GType{.cdecl, dynlib: GLExtLib, 
                                    importc: "gdk_gl_visual_type_get_type".}
proc glTransparentTypeGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_transparent_type_get_type".}
proc typeGlTransparentType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_transparent_type_get_type".}
proc glDrawableTypeMaskGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_drawable_type_mask_get_type".}
proc typeGlDrawableTypeMask*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_drawable_type_mask_get_type".}
proc glRenderTypeMaskGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_render_type_mask_get_type".}
proc typeGlRenderTypeMask*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_render_type_mask_get_type".}
proc glBufferMaskGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                        importc: "gdk_gl_buffer_mask_get_type".}
proc typeGlBufferMask*(): GType{.cdecl, dynlib: GLExtLib, 
                                    importc: "gdk_gl_buffer_mask_get_type".}
proc glConfigErrorGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_config_error_get_type".}
proc typeGlConfigError*(): GType{.cdecl, dynlib: GLExtLib, 
                                     importc: "gdk_gl_config_error_get_type".}
proc glRenderTypeGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                        importc: "gdk_gl_render_type_get_type".}
proc typeGlRenderType*(): GType{.cdecl, dynlib: GLExtLib, 
                                    importc: "gdk_gl_render_type_get_type".}
proc glDrawableAttribGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_drawable_attrib_get_type".}
proc typeGlDrawableAttrib*(): GType{.cdecl, dynlib: GLExtLib, importc: "gdk_gl_drawable_attrib_get_type".}
proc glPbufferAttribGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_pbuffer_attrib_get_type".}
proc typeGlPbufferAttrib*(): GType{.cdecl, dynlib: GLExtLib, importc: "gdk_gl_pbuffer_attrib_get_type".}
proc glEventMaskGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                       importc: "gdk_gl_event_mask_get_type".}
proc typeGlEventMask*(): GType{.cdecl, dynlib: GLExtLib, 
                                   importc: "gdk_gl_event_mask_get_type".}
proc glEventTypeGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                       importc: "gdk_gl_event_type_get_type".}
proc typeGlEventType*(): GType{.cdecl, dynlib: GLExtLib, 
                                   importc: "gdk_gl_event_type_get_type".}
proc glDrawableTypeGetType*(): GType{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_drawable_type_get_type".}
proc typeGlDrawableType*(): GType{.cdecl, dynlib: GLExtLib, 
                                      importc: "gdk_gl_drawable_type_get_type".}
proc glConfigModeGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                        importc: "gdk_gl_config_mode_get_type".}
proc typeGlConfigMode*(): GType{.cdecl, dynlib: GLExtLib, 
                                    importc: "gdk_gl_config_mode_get_type".}
proc glParseArgs*(argc: var Int32, argv: ptr CstringArray): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_parse_args".}
proc glInitCheck*(argc: var Int32, argv: ptr CstringArray): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_init_check".}
proc glInit*(argc: var Int32, argv: ptr CstringArray){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_init".}
proc glQueryGlExtension*(extension: Cstring): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_query_gl_extension".}
proc glGetProcAddress*(proc_name: Cstring): TGLProc{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_get_proc_address".}
const 
  bmTGdkGLConfigIsRgba* = 1 shl 0
  bpTGdkGLConfigIsRgba* = 0
  bmTGdkGLConfigIsDoubleBuffered* = 1 shl 1
  bpTGdkGLConfigIsDoubleBuffered* = 1
  bmTGdkGLConfigAsSingleMode* = 1 shl 2
  bpTGdkGLConfigAsSingleMode* = 2
  bmTGdkGLConfigIsStereo* = 1 shl 3
  bpTGdkGLConfigIsStereo* = 3
  bmTGdkGLConfigHasAlpha* = 1 shl 4
  bpTGdkGLConfigHasAlpha* = 4
  bmTGdkGLConfigHasDepthBuffer* = 1 shl 5
  bpTGdkGLConfigHasDepthBuffer* = 5
  bmTGdkGLConfigHasStencilBuffer* = 1 shl 6
  bpTGdkGLConfigHasStencilBuffer* = 6
  bmTGdkGLConfigHasAccumBuffer* = 1 shl 7
  bpTGdkGLConfigHasAccumBuffer* = 7

const 
  GlModeRgb* = 0
  GlModeRgba* = 0
  GlModeIndex* = 1 shl 0
  GlModeSingle* = 0
  GlModeDouble* = 1 shl 1
  GlModeStereo* = 1 shl 2
  GlModeAlpha* = 1 shl 3
  GlModeDepth* = 1 shl 4
  GlModeStencil* = 1 shl 5
  GlModeAccum* = 1 shl 6
  GlModeMultisample* = 1 shl 7

type 
  TGLConfigMode* = Int32
  PGLConfigMode* = ptr TGLConfigMode

proc typeGlConfig*(): GType
proc glConfig*(anObject: Pointer): PGLConfig
proc glConfigClass*(klass: Pointer): PGLConfigClass
proc isGlConfig*(anObject: Pointer): Bool
proc isGlConfigClass*(klass: Pointer): Bool
proc glConfigGetClass*(obj: Pointer): PGLConfigClass
proc glConfigGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                   importc: "gdk_gl_config_get_type".}
proc getScreen*(glconfig: PGLConfig): PScreen{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_get_screen".}
proc getAttrib*(glconfig: PGLConfig, attribute: Int, value: var Cint): Gboolean{.
    cdecl, dynlib: GLExtLib, importc: "gdk_gl_config_get_attrib".}
proc getColormap*(glconfig: PGLConfig): PColormap{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_get_colormap".}
proc getVisual*(glconfig: PGLConfig): PVisual{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_get_visual".}
proc getDepth*(glconfig: PGLConfig): Gint{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_config_get_depth".}
proc getLayerPlane*(glconfig: PGLConfig): Gint{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_get_layer_plane".}
proc getNAuxBuffers*(glconfig: PGLConfig): Gint{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_get_n_aux_buffers".}
proc getNSampleBuffers*(glconfig: PGLConfig): Gint{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_get_n_sample_buffers".}
proc isRgba*(glconfig: PGLConfig): Gboolean{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_config_is_rgba".}
proc isDoubleBuffered*(glconfig: PGLConfig): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_is_double_buffered".}
proc isStereo*(glconfig: PGLConfig): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_is_stereo".}
proc hasAlpha*(glconfig: PGLConfig): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_has_alpha".}
proc hasDepthBuffer*(glconfig: PGLConfig): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_has_depth_buffer".}
proc hasStencilBuffer*(glconfig: PGLConfig): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_has_stencil_buffer".}
proc hasAccumBuffer*(glconfig: PGLConfig): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_config_has_accum_buffer".}
proc typeGlContext*(): GType
proc glContext*(anObject: Pointer): PGLContext
proc glContextClass*(klass: Pointer): PGLContextClass
proc isGlContext*(anObject: Pointer): Bool
proc isGlContextClass*(klass: Pointer): Bool
proc glContextGetClass*(obj: Pointer): PGLContextClass
proc glContextGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                    importc: "gdk_gl_context_get_type".}
proc contextNew*(gldrawable: PGLDrawable, share_list: PGLContext, 
                     direct: Gboolean, render_type: Int32): PGLContext{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_context_new".}
proc destroy*(glcontext: PGLContext){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_context_destroy".}
proc copy*(glcontext: PGLContext, src: PGLContext, mask: Int32): Gboolean{.
    cdecl, dynlib: GLExtLib, importc: "gdk_gl_context_copy".}
proc getGlDrawable*(glcontext: PGLContext): PGLDrawable{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_context_get_gl_drawable".}
proc getGlConfig*(glcontext: PGLContext): PGLConfig{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_context_get_gl_config".}
proc getShareList*(glcontext: PGLContext): PGLContext{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_context_get_share_list".}
proc isDirect*(glcontext: PGLContext): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_context_is_direct".}
proc getRenderType*(glcontext: PGLContext): Int32{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_context_get_render_type".}
proc glContextGetCurrent*(): PGLContext{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_context_get_current".}
proc typeGlDrawable*(): GType
proc glDrawable*(inst: Pointer): PGLDrawable
proc glDrawableClass*(vtable: Pointer): PGLDrawableClass
proc isGlDrawable*(inst: Pointer): Bool
proc isGlDrawableClass*(vtable: Pointer): Bool
proc glDrawableGetClass*(inst: Pointer): PGLDrawableClass
proc glDrawableGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                     importc: "gdk_gl_drawable_get_type".}
proc makeCurrent*(gldrawable: PGLDrawable, glcontext: PGLContext): Gboolean{.
    cdecl, dynlib: GLExtLib, importc: "gdk_gl_drawable_make_current".}
proc isDoubleBuffered*(gldrawable: PGLDrawable): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_drawable_is_double_buffered".}
proc swapBuffers*(gldrawable: PGLDrawable){.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_drawable_swap_buffers".}
proc waitGl*(gldrawable: PGLDrawable){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_drawable_wait_gl".}
proc waitGdk*(gldrawable: PGLDrawable){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_drawable_wait_gdk".}
proc glBegin*(gldrawable: PGLDrawable, glcontext: PGLContext): Gboolean{.
    cdecl, dynlib: GLExtLib, importc: "gdk_gl_drawable_gl_begin".}
proc glEnd*(gldrawable: PGLDrawable){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_drawable_gl_end".}
proc getGlConfig*(gldrawable: PGLDrawable): PGLConfig{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_drawable_get_gl_config".}
proc getSize*(gldrawable: PGLDrawable, width, height: Pgint){.
    cdecl, dynlib: GLExtLib, importc: "gdk_gl_drawable_get_size".}
proc glDrawableGetCurrent*(): PGLDrawable{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_drawable_get_current".}
proc typeGlPixmap*(): GType
proc glPixmap*(anObject: Pointer): PGLPixmap
proc glPixmapClass*(klass: Pointer): PGLPixmapClass
proc isGlPixmap*(anObject: Pointer): Bool
proc isGlPixmapClass*(klass: Pointer): Bool
proc glPixmapGetClass*(obj: Pointer): PGLPixmapClass
proc glPixmapGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                   importc: "gdk_gl_pixmap_get_type".}
proc pixmapNew*(glconfig: PGLConfig, pixmap: PPixmap, attrib_list: ptr Int32): PGLPixmap{.
    cdecl, dynlib: GLExtLib, importc: "gdk_gl_pixmap_new".}
proc destroy*(glpixmap: PGLPixmap){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_pixmap_destroy".}
proc getPixmap*(glpixmap: PGLPixmap): PPixmap{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_pixmap_get_pixmap".}
proc setGlCapability*(pixmap: PPixmap, glconfig: PGLConfig, 
                               attrib_list: ptr Int32): PGLPixmap{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_pixmap_set_gl_capability".}
proc unsetGlCapability*(pixmap: PPixmap){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_pixmap_unset_gl_capability".}
proc isGlCapable*(pixmap: PPixmap): Gboolean{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_pixmap_is_gl_capable".}
proc getGlPixmap*(pixmap: PPixmap): PGLPixmap{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_pixmap_get_gl_pixmap".}
proc getGlDrawable*(pixmap: PPixmap): PGLDrawable
proc typeGlWindow*(): GType
proc glWindow*(anObject: Pointer): PGLWindow
proc glWindowClass*(klass: Pointer): PGLWindowClass
proc isGlWindow*(anObject: Pointer): Bool
proc isGlWindowClass*(klass: Pointer): Bool
proc glWindowGetClass*(obj: Pointer): PGLWindowClass
proc glWindowGetType*(): GType{.cdecl, dynlib: GLExtLib, 
                                   importc: "gdk_gl_window_get_type".}
proc windowNew*(glconfig: PGLConfig, window: PWindow, attrib_list: ptr Int32): PGLWindow{.
    cdecl, dynlib: GLExtLib, importc: "gdk_gl_window_new".}
proc destroy*(glwindow: PGLWindow){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_window_destroy".}
proc getWindow*(glwindow: PGLWindow): PWindow{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_window_get_window".}
proc setGlCapability*(window: PWindow, glconfig: PGLConfig, 
                               attrib_list: ptr Int32): PGLWindow{.cdecl, 
    dynlib: GLExtLib, importc: "gdk_window_set_gl_capability".}
proc unsetGlCapability*(window: PWindow){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_window_unset_gl_capability".}
proc isGlCapable*(window: PWindow): Gboolean{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_window_is_gl_capable".}
proc getGlWindow*(window: PWindow): PGLWindow{.cdecl, dynlib: GLExtLib, 
    importc: "gdk_window_get_gl_window".}
proc getGlDrawable*(window: PWindow): PGLDrawable
proc glDrawCube*(solid: Gboolean, size: Float64){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_draw_cube".}
proc glDrawSphere*(solid: Gboolean, radius: Float64, slices: Int32, 
                     stacks: Int32){.cdecl, dynlib: GLExtLib, 
                                     importc: "gdk_gl_draw_sphere".}
proc glDrawCone*(solid: Gboolean, base: Float64, height: Float64, 
                   slices: Int32, stacks: Int32){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_draw_cone".}
proc glDrawTorus*(solid: Gboolean, inner_radius: Float64, 
                    outer_radius: Float64, nsides: Int32, rings: Int32){.cdecl, 
    dynlib: GLExtLib, importc: "gdk_gl_draw_torus".}
proc glDrawTetrahedron*(solid: Gboolean){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_draw_tetrahedron".}
proc glDrawOctahedron*(solid: Gboolean){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_draw_octahedron".}
proc glDrawDodecahedron*(solid: Gboolean){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_draw_dodecahedron".}
proc glDrawIcosahedron*(solid: Gboolean){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_draw_icosahedron".}
proc glDrawTeapot*(solid: Gboolean, scale: Float64){.cdecl, dynlib: GLExtLib, 
    importc: "gdk_gl_draw_teapot".}
proc headerGdkglextCheckVersion*(major, minor, micro: guint): bool = 
  result = (HEADER_GDKGLEXT_MAJOR_VERSION > major) or
      ((HEADER_GDKGLEXT_MAJOR_VERSION == major) and
      (HEADER_GDKGLEXT_MINOR_VERSION > minor)) or
      ((HEADER_GDKGLEXT_MAJOR_VERSION == major) and
      (HEADER_GDKGLEXT_MINOR_VERSION == minor) and
      (HEADER_GDKGLEXT_MICRO_VERSION >= micro))

proc typeGlConfig*(): GType = 
  result = glConfigGetType()

proc glConfig*(anObject: Pointer): PGLConfig = 
  result = cast[PGLConfig](gTypeCheckInstanceCast(anObject, typeGlConfig()))

proc glConfigClass*(klass: Pointer): PGLConfigClass = 
  result = cast[PGLConfigClass](gTypeCheckClassCast(klass, typeGlConfig()))

proc isGlConfig*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeGlConfig())

proc isGlConfigClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeGlConfig())

proc glConfigGetClass*(obj: Pointer): PGLConfigClass = 
  result = cast[PGLConfigClass](gTypeInstanceGetClass(obj, typeGlConfig()))

proc typeGlContext*(): GType = 
  result = glContextGetType()

proc glContext*(anObject: Pointer): PGLContext = 
  result = cast[PGLContext](gTypeCheckInstanceCast(anObject, 
      typeGlContext()))

proc glContextClass*(klass: Pointer): PGLContextClass = 
  result = cast[PGLContextClass](gTypeCheckClassCast(klass, 
      typeGlContext()))

proc isGlContext*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeGlContext())

proc isGlContextClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeGlContext())

proc glContextGetClass*(obj: Pointer): PGLContextClass = 
  result = cast[PGLContextClass](gTypeInstanceGetClass(obj, 
      typeGlContext()))

proc typeGlDrawable*(): GType = 
  result = glDrawableGetType()

proc glDrawable*(inst: Pointer): PGLDrawable = 
  result = cast[PGLDrawable](gTypeCheckInstanceCast(inst, typeGlDrawable()))

proc glDrawableClass*(vtable: Pointer): PGLDrawableClass = 
  result = cast[PGLDrawableClass](gTypeCheckClassCast(vtable, 
      typeGlDrawable()))

proc isGlDrawable*(inst: Pointer): bool = 
  result = gTypeCheckInstanceType(inst, typeGlDrawable())

proc isGlDrawableClass*(vtable: Pointer): bool = 
  result = gTypeCheckClassType(vtable, typeGlDrawable())

proc glDrawableGetClass*(inst: Pointer): PGLDrawableClass = 
  result = cast[PGLDrawableClass](gTypeInstanceGetInterface(inst, 
      typeGlDrawable()))

proc typeGlPixmap*(): GType = 
  result = glPixmapGetType()

proc glPixmap*(anObject: Pointer): PGLPixmap = 
  result = cast[PGLPixmap](gTypeCheckInstanceCast(anObject, typeGlPixmap()))

proc glPixmapClass*(klass: Pointer): PGLPixmapClass = 
  result = cast[PGLPixmapClass](gTypeCheckClassCast(klass, typeGlPixmap()))

proc isGlPixmap*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeGlPixmap())

proc isGlPixmapClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeGlPixmap())

proc glPixmapGetClass*(obj: Pointer): PGLPixmapClass = 
  result = cast[PGLPixmapClass](gTypeInstanceGetClass(obj, typeGlPixmap()))

proc getGlDrawable*(pixmap: PPixmap): PGLDrawable = 
  result = glDrawable(getGlPixmap(pixmap))

proc typeGlWindow*(): GType = 
  result = glWindowGetType()

proc glWindow*(anObject: Pointer): PGLWindow = 
  result = cast[PGLWindow](gTypeCheckInstanceCast(anObject, typeGlWindow()))

proc glWindowClass*(klass: Pointer): PGLWindowClass = 
  result = cast[PGLWindowClass](gTypeCheckClassCast(klass, typeGlWindow()))

proc isGlWindow*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeGlWindow())

proc isGlWindowClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeGlWindow())

proc glWindowGetClass*(obj: Pointer): PGLWindowClass = 
  result = cast[PGLWindowClass](gTypeInstanceGetClass(obj, typeGlWindow()))

proc getGlDrawable*(window: PWindow): PGLDrawable = 
  result = glDrawable(getGlWindow(window))
