{.deadCodeElim: on.}
import 
  Glib2, Gdk2, gtk2, GdkGLExt

when defined(windows):
  const 
    GLExtLib* = "libgtkglext-win32-1.0-0.dll" 
elif defined(macosx):
  const
    GLExtLib* = "libgtkglext-x11-1.0.dylib"
else:
  const
    GLExtLib* = "libgtkglext-x11-1.0.so"

const 
  HeaderGtkglextMajorVersion* = 1
  HeaderGtkglextMinorVersion* = 0
  HeaderGtkglextMicroVersion* = 6
  HeaderGtkglextInterfaceAge* = 4
  HeaderGtkglextBinaryAge* = 6

proc glParseArgs*(argc: ptr Int32, argv: PPPchar): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gtk_gl_parse_args".}
proc glInitCheck*(argc: ptr Int32, argv: PPPchar): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gtk_gl_init_check".}
proc glInit*(argc: ptr Int32, argv: PPPchar){.cdecl, dynlib: GLExtLib, 
    importc: "gtk_gl_init".}
proc setGlCapability*(widget: PWidget, glconfig: PGLConfig, 
                               share_list: PGLContext, direct: Gboolean, 
                               render_type: Int): Gboolean{.cdecl, 
    dynlib: GLExtLib, importc: "gtk_widget_set_gl_capability".}
proc isGlCapable*(widget: PWidget): Gboolean{.cdecl, dynlib: GLExtLib, 
    importc: "gtk_widget_is_gl_capable".}
proc getGlConfig*(widget: PWidget): PGLConfig{.cdecl, 
    dynlib: GLExtLib, importc: "gtk_widget_get_gl_config".}
proc createGlContext*(widget: PWidget, share_list: PGLContext, 
                               direct: Gboolean, render_type: Int): PGLContext{.
    cdecl, dynlib: GLExtLib, importc: "gtk_widget_create_gl_context".}
proc getGlContext*(widget: PWidget): PGLContext{.cdecl, 
    dynlib: GLExtLib, importc: "gtk_widget_get_gl_context".}
proc getGlWindow*(widget: PWidget): PGLWindow{.cdecl, 
    dynlib: GLExtLib, importc: "gtk_widget_get_gl_window".}

proc headerGtkglextCheckVersion*(major, minor, micro: Guint): Bool = 
  result = (HEADER_GTKGLEXT_MAJOR_VERSION > major) or
      ((HEADER_GTKGLEXT_MAJOR_VERSION == major) and
      (HEADER_GTKGLEXT_MINOR_VERSION > minor)) or
      ((HEADER_GTKGLEXT_MAJOR_VERSION == major) and
      (HEADER_GTKGLEXT_MINOR_VERSION == minor) and
      (HEADER_GTKGLEXT_MICRO_VERSION >= micro))

proc getGlDrawable*(widget: PWidget): PGLDrawable = 
  result = glDrawable(getGlWindow(widget))
