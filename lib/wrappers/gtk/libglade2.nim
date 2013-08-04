{.deadCodeElim: on.}
import 
  glib2, gtk2

when defined(win32): 
  const 
    LibGladeLib = "libglade-2.0-0.dll"
elif defined(macosx): 
  const 
    LibGladeLib = "libglade-2.0.dylib"
else: 
  const 
    LibGladeLib = "libglade-2.0.so"
type 
  PLongint* = ptr Int32
  PSmallInt* = ptr Int16
  PByte* = ptr Int8
  PWord* = ptr Int16
  PDWord* = ptr Int32
  PDouble* = ptr Float64

proc init*(){.cdecl, dynlib: LibGladeLib, importc: "glade_init".}
proc require*(TheLibrary: Cstring){.cdecl, dynlib: LibGladeLib, 
                                    importc: "glade_require".}
proc provide*(TheLibrary: Cstring){.cdecl, dynlib: LibGladeLib, 
                                    importc: "glade_provide".}
type 
  PXMLPrivate* = Pointer
  Pxml* = ptr TXML
  TXML* = object of TGObject
    filename*: Cstring
    priv*: PXMLPrivate

  PXMLClass* = ptr TXMLClass
  TXMLClass* = object of TGObjectClass
  TXMLConnectFunc* = proc (handler_name: Cstring, anObject: PGObject, 
                           signal_name: Cstring, signal_data: Cstring, 
                           connect_object: PGObject, after: Gboolean, 
                           user_data: Gpointer){.cdecl.}

proc typeXml*(): GType
proc xml*(obj: Pointer): Pxml
proc xmlClass*(klass: Pointer): PXMLClass
proc isXml*(obj: Pointer): Gboolean
proc isXmlClass*(klass: Pointer): Gboolean
proc xmlGetClass*(obj: Pointer): PXMLClass
proc xmlGetType*(): GType{.cdecl, dynlib: LibGladeLib, 
                             importc: "glade_xml_get_type".}
proc xmlNew*(fname: Cstring, root: Cstring, domain: Cstring): Pxml{.cdecl, 
    dynlib: LibGladeLib, importc: "glade_xml_new".}
proc xmlNewFromBuffer*(buffer: Cstring, size: Int32, root: Cstring, 
                          domain: Cstring): Pxml{.cdecl, dynlib: LibGladeLib, 
    importc: "glade_xml_new_from_buffer".}
proc construct*(self: Pxml, fname: Cstring, root: Cstring, domain: Cstring): Gboolean{.
    cdecl, dynlib: LibGladeLib, importc: "glade_xml_construct".}
proc signalConnect*(self: Pxml, handlername: Cstring, func: TGCallback){.
    cdecl, dynlib: LibGladeLib, importc: "glade_xml_signal_connect".}
proc signalConnectData*(self: Pxml, handlername: Cstring, 
                              func: TGCallback, user_data: Gpointer){.cdecl, 
    dynlib: LibGladeLib, importc: "glade_xml_signal_connect_data".}
proc signalAutoconnect*(self: Pxml){.cdecl, dynlib: LibGladeLib, 
    importc: "glade_xml_signal_autoconnect".}
proc signalConnectFull*(self: Pxml, handler_name: Cstring, 
                              func: TXMLConnectFunc, user_data: Gpointer){.
    cdecl, dynlib: LibGladeLib, importc: "glade_xml_signal_connect_full".}
proc signalAutoconnectFull*(self: Pxml, func: TXMLConnectFunc, 
                                  user_data: Gpointer){.cdecl, 
    dynlib: LibGladeLib, importc: "glade_xml_signal_autoconnect_full".}
proc getWidget*(self: Pxml, name: Cstring): gtk2.PWidget{.cdecl, 
    dynlib: LibGladeLib, importc: "glade_xml_get_widget".}
proc getWidgetPrefix*(self: Pxml, name: Cstring): PGList{.cdecl, 
    dynlib: LibGladeLib, importc: "glade_xml_get_widget_prefix".}
proc relativeFile*(self: Pxml, filename: Cstring): Cstring{.cdecl, 
    dynlib: LibGladeLib, importc: "glade_xml_relative_file".}
proc getWidgetName*(widget: gtk2.PWidget): Cstring{.cdecl, dynlib: LibGladeLib, 
    importc: "glade_get_widget_name".}
proc getWidgetTree*(widget: gtk2.PWidget): Pxml{.cdecl, dynlib: LibGladeLib, 
    importc: "glade_get_widget_tree".}
type 
  PXMLCustomWidgetHandler* = ptr TXMLCustomWidgetHandler
  TXMLCustomWidgetHandler* = gtk2.TWidget

proc setCustomHandler*(handler: TXMLCustomWidgetHandler, user_data: Gpointer){.
    cdecl, dynlib: LibGladeLib, importc: "glade_set_custom_handler".}
proc gnomeInit*() = 
  init()

proc bonoboInit*() = 
  init()

proc xmlNewFromMemory*(buffer: Cstring, size: Int32, root: Cstring, 
                          domain: Cstring): Pxml = 
  result = xmlNewFromBuffer(buffer, size, root, domain)

proc typeXml*(): GType = 
  result = xmlGetType()

proc xml*(obj: pointer): PXML = 
  result = cast[Pxml](gTypeCheckInstanceCast(obj, typeXml()))

proc xmlClass*(klass: pointer): PXMLClass = 
  result = cast[PXMLClass](gTypeCheckClassCast(klass, typeXml()))

proc isXml*(obj: pointer): gboolean = 
  result = gTypeCheckInstanceType(obj, typeXml())

proc isXmlClass*(klass: pointer): gboolean = 
  result = gTypeCheckClassType(klass, typeXml())

proc xmlGetClass*(obj: pointer): PXMLClass = 
  result = cast[PXMLClass](gTypeInstanceGetClass(obj, typeXml()))
