{.deadCodeElim: on.}
import 
  glib2, gdk2pixbuf, pango

when defined(win32): 
  const 
    lib = "libgdk-win32-2.0-0.dll"
elif defined(macosx): 
  #    linklib gtk-x11-2.0
  #    linklib gdk-x11-2.0
  #    linklib pango-1.0.0
  #    linklib glib-2.0.0
  #    linklib gobject-2.0.0
  #    linklib gdk_pixbuf-2.0.0
  #    linklib atk-1.0.0
  const 
    lib = "libgdk-x11-2.0.dylib"
else: 
  const 
    lib = "libgdk-x11-2.0.so(|.0)"
const 
  Numptstobuffer* = 200
  MaxTimecoordAxes* = 128

type 
  PDeviceClass* = ptr TDeviceClass
  TDeviceClass* = object of TGObjectClass
  PVisualClass* = ptr TVisualClass
  TVisualClass* = object of TGObjectClass
  PColor* = ptr TColor
  TColor*{.final, pure.} = object 
    pixel*: Guint32
    red*: Guint16
    green*: Guint16
    blue*: Guint16

  PColormap* = ptr TColormap
  PDrawable* = ptr TDrawable
  TDrawable* = object of TGObject
  PWindow* = ptr TWindow
  TWindow* = TDrawable
  PPixmap* = ptr TPixmap
  TPixmap* = TDrawable
  PBitmap* = ptr TBitmap
  TBitmap* = TDrawable
  PFontType* = ptr TFontType
  TFontType* = enum 
    FONT_FONT, FONT_FONTSET
  PFont* = ptr TFont
  TFont*{.final, pure.} = object 
    `type`*: TFontType
    ascent*: Gint
    descent*: Gint

  PFunction* = ptr TFunction
  TFunction* = enum 
    funcCOPY, funcINVERT, funcXOR, funcCLEAR, funcAND, 
    funcAND_REVERSE, funcAND_INVERT, funcNOOP, funcOR, funcEQUIV, 
    funcOR_REVERSE, funcCOPY_INVERT, funcOR_INVERT, funcNAND, funcNOR, funcSET
  PCapStyle* = ptr TCapStyle
  TCapStyle* = enum 
    CAP_NOT_LAST, CAP_BUTT, CAP_ROUND, CAP_PROJECTING
  PFill* = ptr TFill
  TFill* = enum 
    SOLID, TILED, STIPPLED, OPAQUE_STIPPLED
  PJoinStyle* = ptr TJoinStyle
  TJoinStyle* = enum 
    JOIN_MITER, JOIN_ROUND, JOIN_BEVEL
  PLineStyle* = ptr TLineStyle
  TLineStyle* = enum 
    LINE_SOLID, LINE_ON_OFF_DASH, LINE_DOUBLE_DASH
  PSubwindowMode* = ptr TSubwindowMode
  TSubwindowMode* = Int
  PGCValuesMask* = ptr TGCValuesMask
  TGCValuesMask* = Int32
  PGCValues* = ptr TGCValues
  TGCValues*{.final, pure.} = object 
    foreground*: TColor
    background*: TColor
    font*: PFont
    `function`*: TFunction
    fill*: TFill
    tile*: PPixmap
    stipple*: PPixmap
    clip_mask*: PPixmap
    subwindow_mode*: TSubwindowMode
    ts_x_origin*: Gint
    ts_y_origin*: Gint
    clip_x_origin*: Gint
    clip_y_origin*: Gint
    graphics_exposures*: Gint
    line_width*: Gint
    line_style*: TLineStyle
    cap_style*: TCapStyle
    join_style*: TJoinStyle

  Pgc* = ptr TGC
  TGC* = object of TGObject
    clip_x_origin*: Gint
    clip_y_origin*: Gint
    ts_x_origin*: Gint
    ts_y_origin*: Gint
    colormap*: PColormap

  PImageType* = ptr TImageType
  TImageType* = enum 
    IMAGE_NORMAL, IMAGE_SHARED, IMAGE_FASTEST
  PImage* = ptr TImage
  PDevice* = ptr TDevice
  PTimeCoord* = ptr TTimeCoord
  PPTimeCoord* = ptr PTimeCoord
  PRgbDither* = ptr TRgbDither
  TRgbDither* = enum 
    RGB_DITHER_NONE, RGB_DITHER_NORMAL, RGB_DITHER_MAX
  PDisplay* = ptr TDisplay
  PScreen* = ptr TScreen
  TScreen* = object of TGObject
  PInputCondition* = ptr TInputCondition
  TInputCondition* = Int32
  PStatus* = ptr TStatus
  TStatus* = Int32
  TPoint*{.final, pure.} = object 
    x*: Gint
    y*: Gint

  PPoint* = ptr TPoint
  PPPoint* = ptr PPoint
  PSpan* = ptr TSpan
  PWChar* = ptr TWChar
  TWChar* = Guint32
  PSegment* = ptr TSegment
  TSegment*{.final, pure.} = object 
    x1*: Gint
    y1*: Gint
    x2*: Gint
    y2*: Gint

  PRectangle* = ptr TRectangle
  TRectangle*{.final, pure.} = object 
    x*: Gint
    y*: Gint
    width*: Gint
    height*: Gint

  PAtom* = ptr TAtom
  TAtom* = Gulong
  PByteOrder* = ptr TByteOrder
  TByteOrder* = enum 
    LSB_FIRST, MSB_FIRST
  PModifierType* = ptr TModifierType
  TModifierType* = Gint
  PVisualType* = ptr TVisualType
  TVisualType* = enum 
    VISUAL_STATIC_GRAY, VISUAL_GRAYSCALE, VISUAL_STATIC_COLOR, 
    VISUAL_PSEUDO_COLOR, VISUAL_TRUE_COLOR, VISUAL_DIRECT_COLOR
  PVisual* = ptr TVisual
  TVisual* = object of TGObject
    TheType*: TVisualType
    depth*: Gint
    byte_order*: TByteOrder
    colormap_size*: Gint
    bits_per_rgb*: Gint
    red_mask*: Guint32
    red_shift*: Gint
    red_prec*: Gint
    green_mask*: Guint32
    green_shift*: Gint
    green_prec*: Gint
    blue_mask*: Guint32
    blue_shift*: Gint
    blue_prec*: Gint
    screen*: PScreen

  PColormapClass* = ptr TColormapClass
  TColormapClass* = object of TGObjectClass
  TColormap* = object of TGObject
    size*: Gint
    colors*: PColor
    visual*: PVisual
    windowing_data*: Gpointer
    screen*: PScreen

  PCursorType* = ptr TCursorType
  TCursorType* = Gint
  PCursor* = ptr TCursor
  TCursor*{.final, pure.} = object 
    `type`*: TCursorType
    ref_count*: Guint

  PDragAction* = ptr TDragAction
  TDragAction* = Int32
  PDragProtocol* = ptr TDragProtocol
  TDragProtocol* = enum 
    DRAG_PROTO_MOTIF, DRAG_PROTO_XDND, DRAG_PROTO_ROOTWIN, DRAG_PROTO_NONE, 
    DRAG_PROTO_WIN32_DROPFILES, DRAG_PROTO_OLE2, DRAG_PROTO_LOCAL
  PDragContext* = ptr TDragContext
  TDragContext* = object of TGObject
    protocol*: TDragProtocol
    is_source*: Gboolean
    source_window*: PWindow
    dest_window*: PWindow
    targets*: PGList
    actions*: TDragAction
    suggested_action*: TDragAction
    action*: TDragAction
    start_time*: Guint32
    windowing_data*: Gpointer

  PDragContextClass* = ptr TDragContextClass
  TDragContextClass* = object of TGObjectClass
  PRegionBox* = ptr TRegionBox
  TRegionBox* = TSegment
  PRegion* = ptr TRegion
  TRegion*{.final, pure.} = object 
    size*: Int32
    numRects*: Int32
    rects*: PRegionBox
    extents*: TRegionBox

  Ppointblock* = ptr TPOINTBLOCK
  TPOINTBLOCK*{.final, pure.} = object 
    pts*: Array[0..(NUMPTSTOBUFFER) - 1, TPoint]
    next*: Ppointblock

  PDrawableClass* = ptr TDrawableClass
  TDrawableClass* = object of TGObjectClass
    create_gc*: proc (drawable: PDrawable, values: PGCValues, 
                      mask: TGCValuesMask): Pgc{.cdecl.}
    draw_rectangle*: proc (drawable: PDrawable, gc: Pgc, filled: Gint, x: Gint, 
                           y: Gint, width: Gint, height: Gint){.cdecl.}
    draw_arc*: proc (drawable: PDrawable, gc: Pgc, filled: Gint, x: Gint, 
                     y: Gint, width: Gint, height: Gint, angle1: Gint, 
                     angle2: Gint){.cdecl.}
    draw_polygon*: proc (drawable: PDrawable, gc: Pgc, filled: Gint, 
                         points: PPoint, npoints: Gint){.cdecl.}
    draw_text*: proc (drawable: PDrawable, font: PFont, gc: Pgc, x: Gint, 
                      y: Gint, text: Cstring, text_length: Gint){.cdecl.}
    draw_text_wc*: proc (drawable: PDrawable, font: PFont, gc: Pgc, x: Gint, 
                         y: Gint, text: PWChar, text_length: Gint){.cdecl.}
    draw_drawable*: proc (drawable: PDrawable, gc: Pgc, src: PDrawable, 
                          xsrc: Gint, ysrc: Gint, xdest: Gint, ydest: Gint, 
                          width: Gint, height: Gint){.cdecl.}
    draw_points*: proc (drawable: PDrawable, gc: Pgc, points: PPoint, 
                        npoints: Gint){.cdecl.}
    draw_segments*: proc (drawable: PDrawable, gc: Pgc, segs: PSegment, 
                          nsegs: Gint){.cdecl.}
    draw_lines*: proc (drawable: PDrawable, gc: Pgc, points: PPoint, 
                       npoints: Gint){.cdecl.}
    draw_glyphs*: proc (drawable: PDrawable, gc: Pgc, font: PFont, x: Gint, 
                        y: Gint, glyphs: PGlyphString){.cdecl.}
    draw_image*: proc (drawable: PDrawable, gc: Pgc, image: PImage, xsrc: Gint, 
                       ysrc: Gint, xdest: Gint, ydest: Gint, width: Gint, 
                       height: Gint){.cdecl.}
    get_depth*: proc (drawable: PDrawable): Gint{.cdecl.}
    get_size*: proc (drawable: PDrawable, width: Pgint, height: Pgint){.cdecl.}
    set_colormap*: proc (drawable: PDrawable, cmap: PColormap){.cdecl.}
    get_colormap*: proc (drawable: PDrawable): PColormap{.cdecl.}
    get_visual*: proc (drawable: PDrawable): PVisual{.cdecl.}
    get_screen*: proc (drawable: PDrawable): PScreen{.cdecl.}
    get_image*: proc (drawable: PDrawable, x: Gint, y: Gint, width: Gint, 
                      height: Gint): PImage{.cdecl.}
    get_clip_region*: proc (drawable: PDrawable): PRegion{.cdecl.}
    get_visible_region*: proc (drawable: PDrawable): PRegion{.cdecl.}
    get_composite_drawable*: proc (drawable: PDrawable, x: Gint, y: Gint, 
                                   width: Gint, height: Gint, 
                                   composite_x_offset: Pgint, 
                                   composite_y_offset: Pgint): PDrawable{.cdecl.}
    `draw_pixbuf`*: proc (drawable: PDrawable, gc: Pgc, pixbuf: PPixbuf, 
                          src_x: Gint, src_y: Gint, dest_x: Gint, dest_y: Gint, 
                          width: Gint, height: Gint, dither: TRgbDither, 
                          x_dither: Gint, y_dither: Gint){.cdecl.}
    `copy_to_image`*: proc (drawable: PDrawable, image: PImage, src_x: Gint, 
                            src_y: Gint, dest_x: Gint, dest_y: Gint, 
                            width: Gint, height: Gint): PImage{.cdecl.}
    `reserved1`: proc (){.cdecl.}
    `reserved2`: proc (){.cdecl.}
    `reserved3`: proc (){.cdecl.}
    `reserved4`: proc (){.cdecl.}
    `reserved5`: proc (){.cdecl.}
    `reserved6`: proc (){.cdecl.}
    `reserved7`: proc (){.cdecl.}
    `reserved9`: proc (){.cdecl.}
    `reserved10`: proc (){.cdecl.}
    `reserved11`: proc (){.cdecl.}
    `reserved12`: proc (){.cdecl.}
    `reserved13`: proc (){.cdecl.}
    `reserved14`: proc (){.cdecl.}
    `reserved15`: proc (){.cdecl.}
    `reserved16`: proc (){.cdecl.}

  PEvent* = ptr TEvent
  TEventFunc* = proc (event: PEvent, data: Gpointer){.cdecl.}
  PXEvent* = ptr TXEvent
  TXEvent* = proc () {.cdecl.}
  PFilterReturn* = ptr TFilterReturn
  TFilterReturn* = enum 
    FILTER_CONTINUE, FILTER_TRANSLATE, FILTER_REMOVE
  TFilterFunc* = proc (xevent: PXEvent, event: PEvent, data: Gpointer): TFilterReturn{.
      cdecl.}
  PEventType* = ptr TEventType
  TEventType* = Gint
  PEventMask* = ptr TEventMask
  TEventMask* = Gint32
  PVisibilityState* = ptr TVisibilityState
  TVisibilityState* = enum 
    VISIBILITY_UNOBSCURED, VISIBILITY_PARTIAL, VISIBILITY_FULLY_OBSCURED
  PScrollDirection* = ptr TScrollDirection
  TScrollDirection* = enum 
    SCROLL_UP, SCROLL_DOWN, SCROLL_LEFT, SCROLL_RIGHT
  PNotifyType* = ptr TNotifyType
  TNotifyType* = Int
  PCrossingMode* = ptr TCrossingMode
  TCrossingMode* = enum 
    CROSSING_NORMAL, CROSSING_GRAB, CROSSING_UNGRAB
  PPropertyState* = ptr TPropertyState
  TPropertyState* = enum 
    PROPERTY_NEW_VALUE, PROPERTY_STATE_DELETE
  PWindowState* = ptr TWindowState
  TWindowState* = Gint
  PSettingAction* = ptr TSettingAction
  TSettingAction* = enum 
    SETTING_ACTION_NEW, SETTING_ACTION_CHANGED, SETTING_ACTION_DELETED
  PEventAny* = ptr TEventAny
  TEventAny*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8

  PEventExpose* = ptr TEventExpose
  TEventExpose*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    area*: TRectangle
    region*: PRegion
    count*: Gint

  PEventNoExpose* = ptr TEventNoExpose
  TEventNoExpose*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8

  PEventVisibility* = ptr TEventVisibility
  TEventVisibility*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    state*: TVisibilityState

  PEventMotion* = ptr TEventMotion
  TEventMotion*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    time*: Guint32
    x*: Gdouble
    y*: Gdouble
    axes*: Pgdouble
    state*: Guint
    is_hint*: Gint16
    device*: PDevice
    x_root*: Gdouble
    y_root*: Gdouble

  PEventButton* = ptr TEventButton
  TEventButton*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    time*: Guint32
    x*: Gdouble
    y*: Gdouble
    axes*: Pgdouble
    state*: Guint
    button*: Guint
    device*: PDevice
    x_root*: Gdouble
    y_root*: Gdouble

  PEventScroll* = ptr TEventScroll
  TEventScroll*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    time*: Guint32
    x*: Gdouble
    y*: Gdouble
    state*: Guint
    direction*: TScrollDirection
    device*: PDevice
    x_root*: Gdouble
    y_root*: Gdouble

  PEventKey* = ptr TEventKey
  TEventKey*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    time*: Guint32
    state*: Guint
    keyval*: Guint
    length*: Gint
    `string`*: Cstring
    hardware_keycode*: Guint16
    group*: Guint8

  PEventCrossing* = ptr TEventCrossing
  TEventCrossing*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    subwindow*: PWindow
    time*: Guint32
    x*: Gdouble
    y*: Gdouble
    x_root*: Gdouble
    y_root*: Gdouble
    mode*: TCrossingMode
    detail*: TNotifyType
    focus*: Gboolean
    state*: Guint

  PEventFocus* = ptr TEventFocus
  TEventFocus*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    `in`*: Gint16

  PEventConfigure* = ptr TEventConfigure
  TEventConfigure*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    x*: Gint
    y*: Gint
    width*: Gint
    height*: Gint

  PEventProperty* = ptr TEventProperty
  TEventProperty*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    atom*: TAtom
    time*: Guint32
    state*: Guint

  TNativeWindow* = Pointer
  PEventSelection* = ptr TEventSelection
  TEventSelection*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    selection*: TAtom
    target*: TAtom
    `property`*: TAtom
    time*: Guint32
    requestor*: TNativeWindow

  PEventProximity* = ptr TEventProximity
  TEventProximity*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    time*: Guint32
    device*: PDevice

  PmatDUMMY* = ptr TmatDUMMY
  TmatDUMMY*{.final, pure.} = object 
    b*: Array[0..19, Char]

  PEventClient* = ptr TEventClient
  TEventClient*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    message_type*: TAtom
    data_format*: Gushort
    b*: Array[0..19, Char]

  PEventSetting* = ptr TEventSetting
  TEventSetting*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    action*: TSettingAction
    name*: Cstring

  PEventWindowState* = ptr TEventWindowState
  TEventWindowState*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    changed_mask*: TWindowState
    new_window_state*: TWindowState

  PEventDND* = ptr TEventDND
  TEventDND*{.final, pure.} = object 
    `type`*: TEventType
    window*: PWindow
    send_event*: Gint8
    context*: PDragContext
    time*: Guint32
    x_root*: Gshort
    y_root*: Gshort

  TEvent*{.final, pure.} = object 
    data*: Array[0..255, Char] # union of
                               # `type`: TEventType
                               #  any: TEventAny
                               #  expose: TEventExpose
                               #  no_expose: TEventNoExpose
                               #  visibility: TEventVisibility
                               #  motion: TEventMotion
                               #  button: TEventButton
                               #  scroll: TEventScroll
                               #  key: TEventKey
                               #  crossing: TEventCrossing
                               #  focus_change: TEventFocus
                               #  configure: TEventConfigure
                               #  `property`: TEventProperty
                               #  selection: TEventSelection
                               #  proximity: TEventProximity
                               #  client: TEventClient
                               #  dnd: TEventDND
                               #  window_state: TEventWindowState
                               #  setting: TEventSetting
  
  PGCClass* = ptr TGCClass
  TGCClass* = object of TGObjectClass
    get_values*: proc (gc: Pgc, values: PGCValues){.cdecl.}
    set_values*: proc (gc: Pgc, values: PGCValues, mask: TGCValuesMask){.cdecl.}
    set_dashes*: proc (gc: Pgc, dash_offset: Gint, dash_list: Openarray[Gint8]){.
        cdecl.}
    `reserved1`*: proc (){.cdecl.}
    `reserved2`*: proc (){.cdecl.}
    `reserved3`*: proc (){.cdecl.}
    `reserved4`*: proc (){.cdecl.}

  PImageClass* = ptr TImageClass
  TImageClass* = object of TGObjectClass
  TImage* = object of TGObject
    `type`*: TImageType
    visual*: PVisual
    byte_order*: TByteOrder
    width*: Gint
    height*: Gint
    depth*: Guint16
    bpp*: Guint16
    bpl*: Guint16
    bits_per_pixel*: Guint16
    mem*: Gpointer
    colormap*: PColormap
    windowing_data*: Gpointer

  PExtensionMode* = ptr TExtensionMode
  TExtensionMode* = enum 
    EXTENSION_EVENTS_NONE, EXTENSION_EVENTS_ALL, EXTENSION_EVENTS_CURSOR
  PInputSource* = ptr TInputSource
  TInputSource* = enum 
    SOURCE_MOUSE, SOURCE_PEN, SOURCE_ERASER, SOURCE_CURSOR
  PInputMode* = ptr TInputMode
  TInputMode* = enum 
    MODE_DISABLED, MODE_SCREEN, MODE_WINDOW
  PAxisUse* = ptr TAxisUse
  TAxisUse* = Int32
  PDeviceKey* = ptr TDeviceKey
  TDeviceKey*{.final, pure.} = object 
    keyval*: Guint
    modifiers*: TModifierType

  PDeviceAxis* = ptr TDeviceAxis
  TDeviceAxis*{.final, pure.} = object 
    use*: TAxisUse
    min*: Gdouble
    max*: Gdouble

  TDevice* = object of TGObject
    name*: Cstring
    source*: TInputSource
    mode*: TInputMode
    has_cursor*: Gboolean
    num_axes*: Gint
    axes*: PDeviceAxis
    num_keys*: Gint
    keys*: PDeviceKey

  TTimeCoord*{.final, pure.} = object 
    time*: Guint32
    axes*: Array[0..(MAX_TIMECOORD_AXES) - 1, Gdouble]

  PKeymapKey* = ptr TKeymapKey
  TKeymapKey*{.final, pure.} = object 
    keycode*: Guint
    group*: Gint
    level*: Gint

  PKeymap* = ptr TKeymap
  TKeymap* = object of TGObject
    display*: PDisplay

  PKeymapClass* = ptr TKeymapClass
  TKeymapClass* = object of TGObjectClass
    direction_changed*: proc (keymap: PKeymap){.cdecl.}

  PAttrStipple* = ptr TAttrStipple
  TAttrStipple*{.final, pure.} = object 
    attr*: TAttribute
    stipple*: PBitmap

  PAttrEmbossed* = ptr TAttrEmbossed
  TAttrEmbossed*{.final, pure.} = object 
    attr*: TAttribute
    embossed*: Gboolean

  PPixmapObject* = ptr TPixmapObject
  TPixmapObject* = object of TDrawable
    impl*: PDrawable
    depth*: Gint

  PPixmapObjectClass* = ptr TPixmapObjectClass
  TPixmapObjectClass* = object of TDrawableClass
  PPropMode* = ptr TPropMode
  TPropMode* = enum 
    PROP_MODE_REPLACE, PROP_MODE_PREPEND, PROP_MODE_APPEND
  PFillRule* = ptr TFillRule
  TFillRule* = enum 
    EVEN_ODD_RULE, WINDING_RULE
  POverlapType* = ptr TOverlapType
  TOverlapType* = enum 
    OVERLAP_RECTANGLE_IN, OVERLAP_RECTANGLE_OUT, OVERLAP_RECTANGLE_PART
  TSpanFunc* = proc (span: PSpan, data: Gpointer){.cdecl.}
  PRgbCmap* = ptr TRgbCmap
  TRgbCmap*{.final, pure.} = object 
    colors*: Array[0..255, Guint32]
    n_colors*: Gint
    info_list*: PGSList

  TDisplay* = object of TGObject
    queued_events*: PGList
    queued_tail*: PGList
    button_click_time*: Array[0..1, Guint32]
    button_window*: Array[0..1, PWindow]
    button_number*: Array[0..1, Guint]
    double_click_time*: Guint

  PDisplayClass* = ptr TDisplayClass
  TDisplayClass* = object of TGObjectClass
    get_display_name*: proc (display: PDisplay): Cstring{.cdecl.}
    get_n_screens*: proc (display: PDisplay): Gint{.cdecl.}
    get_screen*: proc (display: PDisplay, screen_num: Gint): PScreen{.cdecl.}
    get_default_screen*: proc (display: PDisplay): PScreen{.cdecl.}

  PScreenClass* = ptr TScreenClass
  TScreenClass* = object of TGObjectClass
    get_display*: proc (screen: PScreen): PDisplay{.cdecl.}
    get_width*: proc (screen: PScreen): Gint{.cdecl.}
    get_height*: proc (screen: PScreen): Gint{.cdecl.}
    get_width_mm*: proc (screen: PScreen): Gint{.cdecl.}
    get_height_mm*: proc (screen: PScreen): Gint{.cdecl.}
    get_root_depth*: proc (screen: PScreen): Gint{.cdecl.}
    get_screen_num*: proc (screen: PScreen): Gint{.cdecl.}
    get_root_window*: proc (screen: PScreen): PWindow{.cdecl.}
    get_default_colormap*: proc (screen: PScreen): PColormap{.cdecl.}
    set_default_colormap*: proc (screen: PScreen, colormap: PColormap){.cdecl.}
    get_window_at_pointer*: proc (screen: PScreen, win_x: Pgint, win_y: Pgint): PWindow{.
        cdecl.}
    get_n_monitors*: proc (screen: PScreen): Gint{.cdecl.}
    get_monitor_geometry*: proc (screen: PScreen, monitor_num: Gint, 
                                 dest: PRectangle){.cdecl.}

  PGrabStatus* = ptr TGrabStatus
  TGrabStatus* = Int
  TInputFunction* = proc (data: Gpointer, source: Gint, 
                          condition: TInputCondition){.cdecl.}
  TDestroyNotify* = proc (data: Gpointer){.cdecl.}
  TSpan*{.final, pure.} = object 
    x*: Gint
    y*: Gint
    width*: Gint

  PWindowClass* = ptr TWindowClass
  TWindowClass* = enum 
    INPUT_OUTPUT, INPUT_ONLY
  PWindowType* = ptr TWindowType
  TWindowType* = enum 
    WINDOW_ROOT, WINDOW_TOPLEVEL, WINDOW_CHILD, WINDOW_DIALOG, WINDOW_TEMP, 
    WINDOW_FOREIGN
  PWindowAttributesType* = ptr TWindowAttributesType
  TWindowAttributesType* = Int32
  PWindowHints* = ptr TWindowHints
  TWindowHints* = Int32
  PWindowTypeHint* = ptr TWindowTypeHint
  TWindowTypeHint* = enum 
    WINDOW_TYPE_HINT_NORMAL, WINDOW_TYPE_HINT_DIALOG, WINDOW_TYPE_HINT_MENU, 
    WINDOW_TYPE_HINT_TOOLBAR, WINDOW_TYPE_HINT_SPLASHSCREEN,
    WINDOW_TYPE_HINT_UTILITY, WINDOW_TYPE_HINT_DOCK,
    WINDOW_TYPE_HINT_DESKTOP, WINDOW_TYPE_HINT_DROPDOWN_MENU,
    WINDOW_TYPE_HINT_POPUP_MENU, WINDOW_TYPE_HINT_TOOLTIP,
    WINDOW_TYPE_HINT_NOTIFICATION, WINDOW_TYPE_HINT_COMBO,
    WINDOW_TYPE_HINT_DND
  PWMDecoration* = ptr TWMDecoration
  TWMDecoration* = Int32
  PWMFunction* = ptr TWMFunction
  TWMFunction* = Int32
  PGravity* = ptr TGravity
  TGravity* = Int
  PWindowEdge* = ptr TWindowEdge
  TWindowEdge* = enum 
    WINDOW_EDGE_NORTH_WEST, WINDOW_EDGE_NORTH, WINDOW_EDGE_NORTH_EAST, 
    WINDOW_EDGE_WEST, WINDOW_EDGE_EAST, WINDOW_EDGE_SOUTH_WEST, 
    WINDOW_EDGE_SOUTH, WINDOW_EDGE_SOUTH_EAST
  PWindowAttr* = ptr TWindowAttr
  TWindowAttr*{.final, pure.} = object 
    title*: Cstring
    event_mask*: Gint
    x*: Gint
    y*: Gint
    width*: Gint
    height*: Gint
    wclass*: TWindowClass
    visual*: PVisual
    colormap*: PColormap
    window_type*: TWindowType
    cursor*: PCursor
    wmclass_name*: Cstring
    wmclass_class*: Cstring
    override_redirect*: Gboolean

  PGeometry* = ptr TGeometry
  TGeometry*{.final, pure.} = object 
    min_width*: Gint
    min_height*: Gint
    max_width*: Gint
    max_height*: Gint
    base_width*: Gint
    base_height*: Gint
    width_inc*: Gint
    height_inc*: Gint
    min_aspect*: Gdouble
    max_aspect*: Gdouble
    win_gravity*: TGravity

  PPointerHooks* = ptr TPointerHooks
  TPointerHooks*{.final, pure.} = object 
    get_pointer*: proc (window: PWindow, x: Pgint, y: Pgint, mask: PModifierType): PWindow{.
        cdecl.}
    window_at_pointer*: proc (screen: PScreen, win_x: Pgint, win_y: Pgint): PWindow{.
        cdecl.}

  PWindowObject* = ptr TWindowObject
  TWindowObject* = object of TDrawable
    impl*: PDrawable
    parent*: PWindowObject
    user_data*: Gpointer
    x*: Gint
    y*: Gint
    extension_events*: Gint
    filters*: PGList
    children*: PGList
    bg_color*: TColor
    bg_pixmap*: PPixmap
    paint_stack*: PGSList
    update_area*: PRegion
    update_freeze_count*: Guint
    window_type*: Guint8
    depth*: Guint8
    resize_count*: Guint8
    state*: TWindowState
    flag0*: Guint16
    event_mask*: TEventMask

  PWindowObjectClass* = ptr TWindowObjectClass
  TWindowObjectClass* = object of TDrawableClass
  WindowInvalidateMaybeRecurseChildFunc* = proc (para1: PWindow, 
      para2: Gpointer): Gboolean {.cdecl.}

proc typeColormap*(): GType
proc colormap*(anObject: Pointer): PColormap
proc colormapClass*(klass: Pointer): PColormapClass
proc isColormap*(anObject: Pointer): Bool
proc isColormapClass*(klass: Pointer): Bool
proc colormapGetClass*(obj: Pointer): PColormapClass
proc typeColor*(): GType
proc colormapGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "gdk_colormap_get_type".}
proc colormapNew*(visual: PVisual, allocate: Gboolean): PColormap{.cdecl, 
    dynlib: lib, importc: "gdk_colormap_new".}
proc allocColors*(colormap: PColormap, colors: PColor, ncolors: Gint, 
                            writeable: Gboolean, best_match: Gboolean, 
                            success: Pgboolean): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_colormap_alloc_colors".}
proc allocColor*(colormap: PColormap, color: PColor, 
                           writeable: Gboolean, best_match: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_colormap_alloc_color".}
proc freeColors*(colormap: PColormap, colors: PColor, ncolors: Gint){.
    cdecl, dynlib: lib, importc: "gdk_colormap_free_colors".}
proc queryColor*(colormap: PColormap, pixel: Gulong, result: PColor){.
    cdecl, dynlib: lib, importc: "gdk_colormap_query_color".}
proc getVisual*(colormap: PColormap): PVisual{.cdecl, dynlib: lib, 
    importc: "gdk_colormap_get_visual".}
proc copy*(color: PColor): PColor{.cdecl, dynlib: lib, 
    importc: "gdk_color_copy".}
proc free*(color: PColor){.cdecl, dynlib: lib, importc: "gdk_color_free".}
proc colorParse*(spec: Cstring, color: PColor): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_color_parse".}
proc hash*(colora: PColor): Guint{.cdecl, dynlib: lib, 
    importc: "gdk_color_hash".}
proc equal*(colora: PColor, colorb: PColor): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_color_equal".}
proc colorGetType*(): GType{.cdecl, dynlib: lib, importc: "gdk_color_get_type".}
const 
  CursorIsPixmap* = - (1)
  XCursor* = 0
  Arrow* = 2
  BasedArrowDown* = 4
  BasedArrowUp* = 6
  Boat* = 8
  Bogosity* = 10
  BottomLeftCorner* = 12
  BottomRightCorner* = 14
  BottomSide* = 16
  BottomTee* = 18
  BoxSpiral* = 20
  CenterPtr* = 22
  Circle* = 24
  Clock* = 26
  CoffeeMug* = 28
  Cross* = 30
  CrossReverse* = 32
  Crosshair* = 34
  DiamondCross* = 36
  Dot* = 38
  Dotbox* = 40
  DoubleArrow* = 42
  DraftLarge* = 44
  DraftSmall* = 46
  DrapedBox* = 48
  Exchange* = 50
  Fleur* = 52
  Gobbler* = 54
  Gumby* = 56
  Hand1* = 58
  Hand2* = 60
  Heart* = 62
  Icon* = 64
  IronCross* = 66
  LeftPtr* = 68
  LeftSide* = 70
  LeftTee* = 72
  Leftbutton* = 74
  LlAngle* = 76
  LrAngle* = 78
  Man* = 80
  Middlebutton* = 82
  Mouse* = 84
  Pencil* = 86
  Pirate* = 88
  Plus* = 90
  QuestionArrow* = 92
  RightPtr* = 94
  RightSide* = 96
  RightTee* = 98
  Rightbutton* = 100
  RtlLogo* = 102
  Sailboat* = 104
  SbDownArrow* = 106
  SbHDoubleArrow* = 108
  SbLeftArrow* = 110
  SbRightArrow* = 112
  SbUpArrow* = 114
  SbVDoubleArrow* = 116
  Shuttle* = 118
  Sizing* = 120
  Spider* = 122
  Spraycan* = 124
  Star* = 126
  Target* = 128
  Tcross* = 130
  TopLeftArrow* = 132
  TopLeftCorner* = 134
  TopRightCorner* = 136
  TopSide* = 138
  TopTee* = 140
  Trek* = 142
  UlAngle* = 144
  Umbrella* = 146
  UrAngle* = 148
  Watch* = 150
  Xterm* = 152
  LastCursor* = XTERM + 1

proc typeCursor*(): GType
proc cursorGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "gdk_cursor_get_type".}
proc cursorNewForScreen*(screen: PScreen, cursor_type: TCursorType): PCursor{.
    cdecl, dynlib: lib, importc: "gdk_cursor_new_for_screen".}
proc cursorNewFromPixmap*(source: PPixmap, mask: PPixmap, fg: PColor, 
                             bg: PColor, x: Gint, y: Gint): PCursor{.cdecl, 
    dynlib: lib, importc: "gdk_cursor_new_from_pixmap".}
proc getScreen*(cursor: PCursor): PScreen{.cdecl, dynlib: lib, 
    importc: "gdk_cursor_get_screen".}
proc reference*(cursor: PCursor): PCursor{.cdecl, dynlib: lib, 
    importc: "gdk_cursor_ref".}
proc unref*(cursor: PCursor){.cdecl, dynlib: lib, 
                                     importc: "gdk_cursor_unref".}
const 
  ActionDefault* = 1 shl 0
  ActionCopy* = 1 shl 1
  ActionMove* = 1 shl 2
  ActionLink* = 1 shl 3
  ActionPrivate* = 1 shl 4
  ActionAsk* = 1 shl 5

proc typeDragContext*(): GType
proc dragContext*(anObject: Pointer): PDragContext
proc dragContextClass*(klass: Pointer): PDragContextClass
proc isDragContext*(anObject: Pointer): Bool
proc isDragContextClass*(klass: Pointer): Bool
proc dragContextGetClass*(obj: Pointer): PDragContextClass
proc dragContextGetType*(): GType{.cdecl, dynlib: lib, 
                                      importc: "gdk_drag_context_get_type".}
proc dragContextNew*(): PDragContext{.cdecl, dynlib: lib, 
                                        importc: "gdk_drag_context_new".}
proc status*(context: PDragContext, action: TDragAction, time: Guint32){.
    cdecl, dynlib: lib, importc: "gdk_drag_status".}
proc dropReply*(context: PDragContext, ok: Gboolean, time: Guint32){.cdecl, 
    dynlib: lib, importc: "gdk_drop_reply".}
proc dropFinish*(context: PDragContext, success: Gboolean, time: Guint32){.
    cdecl, dynlib: lib, importc: "gdk_drop_finish".}
proc getSelection*(context: PDragContext): TAtom{.cdecl, dynlib: lib, 
    importc: "gdk_drag_get_selection".}
proc dragBegin*(window: PWindow, targets: PGList): PDragContext{.cdecl, 
    dynlib: lib, importc: "gdk_drag_begin".}
proc dragGetProtocolForDisplay*(display: PDisplay, xid: Guint32, 
                                    protocol: PDragProtocol): Guint32{.cdecl, 
    dynlib: lib, importc: "gdk_drag_get_protocol_for_display".}
proc findWindow*(context: PDragContext, drag_window: PWindow, 
                       x_root: Gint, y_root: Gint, w: var PWindow, 
                       protocol: PDragProtocol){.cdecl, dynlib: lib, 
    importc: "gdk_drag_find_window".}
proc motion*(context: PDragContext, dest_window: PWindow, 
                  protocol: TDragProtocol, x_root: Gint, y_root: Gint, 
                  suggested_action: TDragAction, possible_actions: TDragAction, 
                  time: Guint32): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_drag_motion".}
proc drop*(context: PDragContext, time: Guint32){.cdecl, dynlib: lib, 
    importc: "gdk_drag_drop".}
proc abort*(context: PDragContext, time: Guint32){.cdecl, dynlib: lib, 
    importc: "gdk_drag_abort".}
proc regionEXTENTCHECK*(r1, r2: PRegionBox): Bool
proc extents*(r: PRegionBox, idRect: PRegion)
proc memcheck*(reg: PRegion, ARect, firstrect: var PRegionBox): Bool
proc checkPrevious*(Reg: PRegion, R: PRegionBox, 
                            Rx1, Ry1, Rx2, Ry2: Gint): Bool
proc addrect*(reg: PRegion, r: PRegionBox, rx1, ry1, rx2, ry2: Gint)
proc addrectnox*(reg: PRegion, r: PRegionBox, rx1, ry1, rx2, ry2: Gint)
proc emptyRegion*(pReg: PRegion): Bool
proc regionNotEmpty*(pReg: PRegion): Bool
proc regionINBOX*(r: TRegionBox, x, y: Gint): Bool
proc typeDrawable*(): GType
proc drawable*(anObject: Pointer): PDrawable
proc drawableClass*(klass: Pointer): PDrawableClass
proc isDrawable*(anObject: Pointer): Bool
proc isDrawableClass*(klass: Pointer): Bool
proc drawableGetClass*(obj: Pointer): PDrawableClass
proc drawableGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "gdk_drawable_get_type".}
proc getSize*(drawable: PDrawable, width: Pgint, height: Pgint){.
    cdecl, dynlib: lib, importc: "gdk_drawable_get_size".}
proc setColormap*(drawable: PDrawable, colormap: PColormap){.cdecl, 
    dynlib: lib, importc: "gdk_drawable_set_colormap".}
proc getColormap*(drawable: PDrawable): PColormap{.cdecl, dynlib: lib, 
    importc: "gdk_drawable_get_colormap".}
proc getVisual*(drawable: PDrawable): PVisual{.cdecl, dynlib: lib, 
    importc: "gdk_drawable_get_visual".}
proc getDepth*(drawable: PDrawable): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_drawable_get_depth".}
proc getScreen*(drawable: PDrawable): PScreen{.cdecl, dynlib: lib, 
    importc: "gdk_drawable_get_screen".}
proc getDisplay*(drawable: PDrawable): PDisplay{.cdecl, dynlib: lib, 
    importc: "gdk_drawable_get_display".}
proc point*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint){.cdecl, 
    dynlib: lib, importc: "gdk_draw_point".}
proc line*(drawable: PDrawable, gc: Pgc, x1: Gint, y1: Gint, x2: Gint, 
                y2: Gint){.cdecl, dynlib: lib, importc: "gdk_draw_line".}
proc rectangle*(drawable: PDrawable, gc: Pgc, filled: Gint, x: Gint, 
                     y: Gint, width: Gint, height: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_draw_rectangle".}
proc arc*(drawable: PDrawable, gc: Pgc, filled: Gint, x: Gint, y: Gint, 
               width: Gint, height: Gint, angle1: Gint, angle2: Gint){.cdecl, 
    dynlib: lib, importc: "gdk_draw_arc".}
proc polygon*(drawable: PDrawable, gc: Pgc, filled: Gint, points: PPoint, 
                   npoints: Gint){.cdecl, dynlib: lib, 
                                   importc: "gdk_draw_polygon".}
proc drawable*(drawable: PDrawable, gc: Pgc, src: PDrawable, xsrc: Gint, 
                    ysrc: Gint, xdest: Gint, ydest: Gint, width: Gint, 
                    height: Gint){.cdecl, dynlib: lib, 
                                   importc: "gdk_draw_drawable".}
proc image*(drawable: PDrawable, gc: Pgc, image: PImage, xsrc: Gint, 
                 ysrc: Gint, xdest: Gint, ydest: Gint, width: Gint, height: Gint){.
    cdecl, dynlib: lib, importc: "gdk_draw_image".}
proc points*(drawable: PDrawable, gc: Pgc, points: PPoint, npoints: Gint){.
    cdecl, dynlib: lib, importc: "gdk_draw_points".}
proc segments*(drawable: PDrawable, gc: Pgc, segs: PSegment, nsegs: Gint){.
    cdecl, dynlib: lib, importc: "gdk_draw_segments".}
proc lines*(drawable: PDrawable, gc: Pgc, points: PPoint, npoints: Gint){.
    cdecl, dynlib: lib, importc: "gdk_draw_lines".}
proc glyphs*(drawable: PDrawable, gc: Pgc, font: PFont, x: Gint, 
                  y: Gint, glyphs: PGlyphString){.cdecl, dynlib: lib, 
    importc: "gdk_draw_glyphs".}
proc layoutLine*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint, 
                       line: PLayoutLine){.cdecl, dynlib: lib, 
    importc: "gdk_draw_layout_line".}
proc layout*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint, 
                  layout: PLayout){.cdecl, dynlib: lib, 
    importc: "gdk_draw_layout".}
proc layoutLine*(drawable: PDrawable, gc: Pgc, x: Gint, 
                                   y: Gint, line: PLayoutLine, 
                                   foreground: PColor, background: PColor){.
    cdecl, dynlib: lib, importc: "gdk_draw_layout_line_with_colors".}
proc layout*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint, 
                              layout: PLayout, foreground: PColor, 
                              background: PColor){.cdecl, dynlib: lib, 
    importc: "gdk_draw_layout_with_colors".}
proc getImage*(drawable: PDrawable, x: Gint, y: Gint, width: Gint, 
                         height: Gint): PImage{.cdecl, dynlib: lib, 
    importc: "gdk_drawable_get_image".}
proc getClipRegion*(drawable: PDrawable): PRegion{.cdecl, 
    dynlib: lib, importc: "gdk_drawable_get_clip_region".}
proc getVisibleRegion*(drawable: PDrawable): PRegion{.cdecl, 
    dynlib: lib, importc: "gdk_drawable_get_visible_region".}
const 
  Nothing* = - (1)
  Delete* = 0
  constDESTROY* = 1
  Expose* = 2
  MotionNotify* = 3
  ButtonPress* = 4
  Button2Press* = 5
  Button3Press* = 6
  ButtonRelease* = 7
  KeyPress* = 8
  KeyRelease* = 9
  EnterNotify* = 10
  LeaveNotify* = 11
  FocusChange* = 12
  Configure* = 13
  Map* = 14
  Unmap* = 15
  PropertyNotify* = 16
  SelectionClear* = 17
  SelectionRequest* = 18
  SelectionNotify* = 19
  ProximityIn* = 20
  ProximityOut* = 21
  DragEnter* = 22
  DragLeave* = 23
  DragMotionEvent* = 24
  DragStatusEvent* = 25
  DropStart* = 26
  DropFinished* = 27
  ClientEvent* = 28
  VisibilityNotify* = 29
  NoExpose* = 30
  constSCROLL* = 31
  WindowState* = 32
  Setting* = 33
  NotifyAncestor* = 0
  NotifyVirtual* = 1
  NotifyInferior* = 2
  NotifyNonlinear* = 3
  NotifyNonlinearVirtual* = 4
  NotifyUnknown* = 5

proc typeEvent*(): GType
const 
  GPriorityDefault* = 0
  PriorityEvents* = G_PRIORITY_DEFAULT #GDK_PRIORITY_REDRAW* = G_PRIORITY_HIGH_IDLE + 20
  ExposureMask* = 1 shl 1
  PointerMotionMask* = 1 shl 2
  PointerMotionHintMask* = 1 shl 3
  ButtonMotionMask* = 1 shl 4
  Button1MotionMask* = 1 shl 5
  Button2MotionMask* = 1 shl 6
  Button3MotionMask* = 1 shl 7
  ButtonPressMask* = 1 shl 8
  ButtonReleaseMask* = 1 shl 9
  KeyPressMask* = 1 shl 10
  KeyReleaseMask* = 1 shl 11
  EnterNotifyMask* = 1 shl 12
  LeaveNotifyMask* = 1 shl 13
  FocusChangeMask* = 1 shl 14
  StructureMask* = 1 shl 15
  PropertyChangeMask* = 1 shl 16
  VisibilityNotifyMask* = 1 shl 17
  ProximityInMask* = 1 shl 18
  ProximityOutMask* = 1 shl 19
  SubstructureMask* = 1 shl 20
  ScrollMask* = 1 shl 21
  AllEventsMask* = 0x003FFFFE
  WindowStateWithdrawn* = 1 shl 0
  WindowStateIconified* = 1 shl 1
  WindowStateMaximized* = 1 shl 2
  WindowStateSticky* = 1 shl 3

proc eventGetType*(): GType{.cdecl, dynlib: lib, importc: "gdk_event_get_type".}
proc eventsPending*(): Gboolean{.cdecl, dynlib: lib, 
                                  importc: "gdk_events_pending".}
proc eventGet*(): PEvent{.cdecl, dynlib: lib, importc: "gdk_event_get".}
proc eventPeek*(): PEvent{.cdecl, dynlib: lib, importc: "gdk_event_peek".}
proc eventGetGraphicsExpose*(window: PWindow): PEvent{.cdecl, dynlib: lib, 
    importc: "gdk_event_get_graphics_expose".}
proc put*(event: PEvent){.cdecl, dynlib: lib, importc: "gdk_event_put".}
proc copy*(event: PEvent): PEvent{.cdecl, dynlib: lib, 
    importc: "gdk_event_copy".}
proc free*(event: PEvent){.cdecl, dynlib: lib, importc: "gdk_event_free".}
proc getTime*(event: PEvent): Guint32{.cdecl, dynlib: lib, 
    importc: "gdk_event_get_time".}
proc getState*(event: PEvent, state: PModifierType): Gboolean{.cdecl, 
    dynlib: lib, importc: "gdk_event_get_state".}
proc getCoords*(event: PEvent, x_win: Pgdouble, y_win: Pgdouble): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_event_get_coords".}
proc getRootCoords*(event: PEvent, x_root: Pgdouble, y_root: Pgdouble): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_event_get_root_coords".}
proc getAxis*(event: PEvent, axis_use: TAxisUse, value: Pgdouble): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_event_get_axis".}
proc eventHandlerSet*(func: TEventFunc, data: Gpointer, 
                        notify: TGDestroyNotify){.cdecl, dynlib: lib, 
    importc: "gdk_event_handler_set".}
proc setShowEvents*(show_events: Gboolean){.cdecl, dynlib: lib, 
    importc: "gdk_set_show_events".}
proc getShowEvents*(): Gboolean{.cdecl, dynlib: lib, 
                                   importc: "gdk_get_show_events".}
proc typeFont*(): GType
proc fontGetType*(): GType{.cdecl, dynlib: lib, importc: "gdk_font_get_type".}
proc fontLoadForDisplay*(display: PDisplay, font_name: Cstring): PFont{.
    cdecl, dynlib: lib, importc: "gdk_font_load_for_display".}
proc fontsetLoadForDisplay*(display: PDisplay, fontset_name: Cstring): PFont{.
    cdecl, dynlib: lib, importc: "gdk_fontset_load_for_display".}
proc fontFromDescriptionForDisplay*(display: PDisplay, 
                                        font_desc: PFontDescription): PFont{.
    cdecl, dynlib: lib, importc: "gdk_font_from_description_for_display".}
proc reference*(font: PFont): PFont{.cdecl, dynlib: lib, importc: "gdk_font_ref".}
proc unref*(font: PFont){.cdecl, dynlib: lib, importc: "gdk_font_unref".}
proc id*(font: PFont): Gint{.cdecl, dynlib: lib, importc: "gdk_font_id".}
proc equal*(fonta: PFont, fontb: PFont): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_font_equal".}
proc stringWidth*(font: PFont, `string`: Cstring): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_string_width".}
proc textWidth*(font: PFont, text: Cstring, text_length: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "gdk_text_width".}
proc textWidthWc*(font: PFont, text: PWChar, text_length: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "gdk_text_width_wc".}
proc charWidth*(font: PFont, character: Gchar): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_char_width".}
proc charWidthWc*(font: PFont, character: TWChar): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_char_width_wc".}
proc stringMeasure*(font: PFont, `string`: Cstring): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_string_measure".}
proc textMeasure*(font: PFont, text: Cstring, text_length: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "gdk_text_measure".}
proc charMeasure*(font: PFont, character: Gchar): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_char_measure".}
proc stringHeight*(font: PFont, `string`: Cstring): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_string_height".}
proc textHeight*(font: PFont, text: Cstring, text_length: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "gdk_text_height".}
proc charHeight*(font: PFont, character: Gchar): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_char_height".}
proc textExtents*(font: PFont, text: Cstring, text_length: Gint, 
                   lbearing: Pgint, rbearing: Pgint, width: Pgint, 
                   ascent: Pgint, descent: Pgint){.cdecl, dynlib: lib, 
    importc: "gdk_text_extents".}
proc textExtentsWc*(font: PFont, text: PWChar, text_length: Gint, 
                      lbearing: Pgint, rbearing: Pgint, width: Pgint, 
                      ascent: Pgint, descent: Pgint){.cdecl, dynlib: lib, 
    importc: "gdk_text_extents_wc".}
proc stringExtents*(font: PFont, `string`: Cstring, lbearing: Pgint, 
                     rbearing: Pgint, width: Pgint, ascent: Pgint, 
                     descent: Pgint){.cdecl, dynlib: lib, 
                                      importc: "gdk_string_extents".}
proc getDisplay*(font: PFont): PDisplay{.cdecl, dynlib: lib, 
    importc: "gdk_font_get_display".}
const 
  GcForeground* = 1 shl 0
  GcBackground* = 1 shl 1
  GcFont* = 1 shl 2
  GcFunction* = 1 shl 3
  GcFill* = 1 shl 4
  GcTile* = 1 shl 5
  GcStipple* = 1 shl 6
  GcClipMask* = 1 shl 7
  GcSubwindow* = 1 shl 8
  GcTsXOrigin* = 1 shl 9
  GcTsYOrigin* = 1 shl 10
  GcClipXOrigin* = 1 shl 11
  GcClipYOrigin* = 1 shl 12
  GcExposures* = 1 shl 13
  GcLineWidth* = 1 shl 14
  GcLineStyle* = 1 shl 15
  GcCapStyle* = 1 shl 16
  GcJoinStyle* = 1 shl 17
  ClipByChildren* = 0
  IncludeInferiors* = 1

proc typeGc*(): GType
proc gc*(anObject: Pointer): Pgc
proc gcClass*(klass: Pointer): PGCClass
proc isGc*(anObject: Pointer): Bool
proc isGcClass*(klass: Pointer): Bool
proc gcGetClass*(obj: Pointer): PGCClass
proc gcGetType*(): GType{.cdecl, dynlib: lib, importc: "gdk_gc_get_type".}
proc gcNew*(drawable: PDrawable): Pgc{.cdecl, dynlib: lib, 
                                        importc: "gdk_gc_new".}
proc gcNew*(drawable: PDrawable, values: PGCValues, 
                         values_mask: TGCValuesMask): Pgc{.cdecl, dynlib: lib, 
    importc: "gdk_gc_new_with_values".}
proc getValues*(gc: Pgc, values: PGCValues){.cdecl, dynlib: lib, 
    importc: "gdk_gc_get_values".}
proc setValues*(gc: Pgc, values: PGCValues, values_mask: TGCValuesMask){.
    cdecl, dynlib: lib, importc: "gdk_gc_set_values".}
proc setForeground*(gc: Pgc, color: PColor){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_foreground".}
proc setBackground*(gc: Pgc, color: PColor){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_background".}
proc setFunction*(gc: Pgc, `function`: TFunction){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_function".}
proc setFill*(gc: Pgc, fill: TFill){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_fill".}
proc setTile*(gc: Pgc, tile: PPixmap){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_tile".}
proc setStipple*(gc: Pgc, stipple: PPixmap){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_stipple".}
proc setTsOrigin*(gc: Pgc, x: Gint, y: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_ts_origin".}
proc setClipOrigin*(gc: Pgc, x: Gint, y: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_clip_origin".}
proc setClipMask*(gc: Pgc, mask: PBitmap){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_clip_mask".}
proc setClipRectangle*(gc: Pgc, rectangle: PRectangle){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_clip_rectangle".}
proc setClipRegion*(gc: Pgc, region: PRegion){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_clip_region".}
proc setSubwindow*(gc: Pgc, mode: TSubwindowMode){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_subwindow".}
proc setExposures*(gc: Pgc, exposures: Gboolean){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_exposures".}
proc setLineAttributes*(gc: Pgc, line_width: Gint, line_style: TLineStyle, 
                             cap_style: TCapStyle, join_style: TJoinStyle){.
    cdecl, dynlib: lib, importc: "gdk_gc_set_line_attributes".}
proc setDashes*(gc: Pgc, dash_offset: Gint, dash_list: Openarray[Gint8]){.
    cdecl, dynlib: lib, importc: "gdk_gc_set_dashes".}
proc offset*(gc: Pgc, x_offset: Gint, y_offset: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_gc_offset".}
proc copy*(dst_gc: Pgc, src_gc: Pgc){.cdecl, dynlib: lib, 
    importc: "gdk_gc_copy".}
proc setColormap*(gc: Pgc, colormap: PColormap){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_colormap".}
proc getColormap*(gc: Pgc): PColormap{.cdecl, dynlib: lib, 
    importc: "gdk_gc_get_colormap".}
proc setRgbFgColor*(gc: Pgc, color: PColor){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_rgb_fg_color".}
proc setRgbBgColor*(gc: Pgc, color: PColor){.cdecl, dynlib: lib, 
    importc: "gdk_gc_set_rgb_bg_color".}
proc getScreen*(gc: Pgc): PScreen{.cdecl, dynlib: lib, 
                                       importc: "gdk_gc_get_screen".}
proc typeImage*(): GType
proc image*(anObject: Pointer): PImage
proc imageClass*(klass: Pointer): PImageClass
proc isImage*(anObject: Pointer): Bool
proc isImageClass*(klass: Pointer): Bool
proc imageGetClass*(obj: Pointer): PImageClass
proc imageGetType*(): GType{.cdecl, dynlib: lib, importc: "gdk_image_get_type".}
proc imageNew*(`type`: TImageType, visual: PVisual, width: Gint, height: Gint): PImage{.
    cdecl, dynlib: lib, importc: "gdk_image_new".}
proc putPixel*(image: PImage, x: Gint, y: Gint, pixel: Guint32){.cdecl, 
    dynlib: lib, importc: "gdk_image_put_pixel".}
proc getPixel*(image: PImage, x: Gint, y: Gint): Guint32{.cdecl, 
    dynlib: lib, importc: "gdk_image_get_pixel".}
proc setColormap*(image: PImage, colormap: PColormap){.cdecl, 
    dynlib: lib, importc: "gdk_image_set_colormap".}
proc getColormap*(image: PImage): PColormap{.cdecl, dynlib: lib, 
    importc: "gdk_image_get_colormap".}
const 
  AxisIgnore* = 0
  AxisX* = 1
  AxisY* = 2
  AxisPressure* = 3
  AxisXtilt* = 4
  AxisYtilt* = 5
  AxisWheel* = 6
  AxisLast* = 7

proc typeDevice*(): GType
proc device*(anObject: Pointer): PDevice
proc deviceClass*(klass: Pointer): PDeviceClass
proc isDevice*(anObject: Pointer): Bool
proc isDeviceClass*(klass: Pointer): Bool
proc deviceGetClass*(obj: Pointer): PDeviceClass
proc deviceGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "gdk_device_get_type".}
proc setSource*(device: PDevice, source: TInputSource){.cdecl, 
    dynlib: lib, importc: "gdk_device_set_source".}
proc setMode*(device: PDevice, mode: TInputMode): Gboolean{.cdecl, 
    dynlib: lib, importc: "gdk_device_set_mode".}
proc setKey*(device: PDevice, index: Guint, keyval: Guint, 
                     modifiers: TModifierType){.cdecl, dynlib: lib, 
    importc: "gdk_device_set_key".}
proc setAxisUse*(device: PDevice, index: Guint, use: TAxisUse){.cdecl, 
    dynlib: lib, importc: "gdk_device_set_axis_use".}
proc getState*(device: PDevice, window: PWindow, axes: Pgdouble, 
                       mask: PModifierType){.cdecl, dynlib: lib, 
    importc: "gdk_device_get_state".}
proc getHistory*(device: PDevice, window: PWindow, start: Guint32, 
                         stop: Guint32, s: var PPTimeCoord, n_events: Pgint): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_device_get_history".}
proc deviceFreeHistory*(events: PPTimeCoord, n_events: Gint){.cdecl, 
    dynlib: lib, importc: "gdk_device_free_history".}
proc getAxis*(device: PDevice, axes: Pgdouble, use: TAxisUse, 
                      value: Pgdouble): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_device_get_axis".}
proc inputSetExtensionEvents*(window: PWindow, mask: Gint, 
                                 mode: TExtensionMode){.cdecl, dynlib: lib, 
    importc: "gdk_input_set_extension_events".}
proc deviceGetCorePointer*(): PDevice{.cdecl, dynlib: lib, 
    importc: "gdk_device_get_core_pointer".}
proc typeKeymap*(): GType
proc keymap*(anObject: Pointer): PKeymap
proc keymapClass*(klass: Pointer): PKeymapClass
proc isKeymap*(anObject: Pointer): Bool
proc isKeymapClass*(klass: Pointer): Bool
proc keymapGetClass*(obj: Pointer): PKeymapClass
proc keymapGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "gdk_keymap_get_type".}
proc keymapGetForDisplay*(display: PDisplay): PKeymap{.cdecl, dynlib: lib, 
    importc: "gdk_keymap_get_for_display".}
proc lookupKey*(keymap: PKeymap, key: PKeymapKey): Guint{.cdecl, 
    dynlib: lib, importc: "gdk_keymap_lookup_key".}
proc translateKeyboardState*(keymap: PKeymap, hardware_keycode: Guint, 
                                      state: TModifierType, group: Gint, 
                                      keyval: Pguint, effective_group: Pgint, 
                                      level: Pgint, 
                                      consumed_modifiers: PModifierType): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_keymap_translate_keyboard_state".}
proc getEntriesForKeyval*(keymap: PKeymap, keyval: Guint, 
                                    s: var PKeymapKey, n_keys: Pgint): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_keymap_get_entries_for_keyval".}
proc getEntriesForKeycode*(keymap: PKeymap, hardware_keycode: Guint, 
                                     s: var PKeymapKey, sasdf: var Pguint, 
                                     n_entries: Pgint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gdk_keymap_get_entries_for_keycode".}
proc getDirection*(keymap: PKeymap): TDirection{.cdecl, 
    dynlib: lib, importc: "gdk_keymap_get_direction".}
proc keyvalName*(keyval: Guint): Cstring{.cdecl, dynlib: lib, 
    importc: "gdk_keyval_name".}
proc keyvalFromName*(keyval_name: Cstring): Guint{.cdecl, dynlib: lib, 
    importc: "gdk_keyval_from_name".}
proc keyvalConvertCase*(symbol: Guint, lower: Pguint, upper: Pguint){.cdecl, 
    dynlib: lib, importc: "gdk_keyval_convert_case".}
proc keyvalToUpper*(keyval: Guint): Guint{.cdecl, dynlib: lib, 
    importc: "gdk_keyval_to_upper".}
proc keyvalToLower*(keyval: Guint): Guint{.cdecl, dynlib: lib, 
    importc: "gdk_keyval_to_lower".}
proc keyvalIsUpper*(keyval: Guint): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_keyval_is_upper".}
proc keyvalIsLower*(keyval: Guint): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_keyval_is_lower".}
proc keyvalToUnicode*(keyval: Guint): Guint32{.cdecl, dynlib: lib, 
    importc: "gdk_keyval_to_unicode".}
proc unicodeToKeyval*(wc: Guint32): Guint{.cdecl, dynlib: lib, 
    importc: "gdk_unicode_to_keyval".}
const 
  KEYVoidSymbol* = 0x00FFFFFF
  KEYBackSpace* = 0x0000FF08
  KEYTab* = 0x0000FF09
  KEYLinefeed* = 0x0000FF0A
  KEYClear* = 0x0000FF0B
  KEYReturn* = 0x0000FF0D
  KEYPause* = 0x0000FF13
  KEYScrollLock* = 0x0000FF14
  KEYSysReq* = 0x0000FF15
  KEYEscape* = 0x0000FF1B
  KEYDelete* = 0x0000FFFF
  KEYMultiKey* = 0x0000FF20
  KEYCodeinput* = 0x0000FF37
  KEYSingleCandidate* = 0x0000FF3C
  KEYMultipleCandidate* = 0x0000FF3D
  KEYPreviousCandidate* = 0x0000FF3E
  KEYKanji* = 0x0000FF21
  KEYMuhenkan* = 0x0000FF22
  KEYHenkanMode* = 0x0000FF23
  KEYHenkan* = 0x0000FF23
  KEYRomaji* = 0x0000FF24
  KEYHiragana* = 0x0000FF25
  KEYKatakana* = 0x0000FF26
  KEYHiraganaKatakana* = 0x0000FF27
  KEYZenkaku* = 0x0000FF28
  KEYHankaku* = 0x0000FF29
  KEYZenkakuHankaku* = 0x0000FF2A
  KEYTouroku* = 0x0000FF2B
  KEYMassyo* = 0x0000FF2C
  KEYKanaLock* = 0x0000FF2D
  KEYKanaShift* = 0x0000FF2E
  KEYEisuShift* = 0x0000FF2F
  KEYEisuToggle* = 0x0000FF30
  KEYKanjiBangou* = 0x0000FF37
  KEYZenKoho* = 0x0000FF3D
  KEYMaeKoho* = 0x0000FF3E
  KEYHome* = 0x0000FF50
  KEYLeft* = 0x0000FF51
  KEYUp* = 0x0000FF52
  KEYRight* = 0x0000FF53
  KEYDown* = 0x0000FF54
  KEYPrior* = 0x0000FF55
  KEYPageUp* = 0x0000FF55
  KEYNext* = 0x0000FF56
  KEYPageDown* = 0x0000FF56
  KEYEnd* = 0x0000FF57
  KEYBegin* = 0x0000FF58
  KEYSelect* = 0x0000FF60
  KEYPrint* = 0x0000FF61
  KEYExecute* = 0x0000FF62
  KEYInsert* = 0x0000FF63
  KEYUndo* = 0x0000FF65
  KEYRedo* = 0x0000FF66
  KEYMenu* = 0x0000FF67
  KEYFind* = 0x0000FF68
  KEYCancel* = 0x0000FF69
  KEYHelp* = 0x0000FF6A
  KEYBreak* = 0x0000FF6B
  KEYModeSwitch* = 0x0000FF7E
  KEYScriptSwitch* = 0x0000FF7E
  KEYNumLock* = 0x0000FF7F
  KEYKPSpace* = 0x0000FF80
  KEYKPTab* = 0x0000FF89
  KEYKPEnter* = 0x0000FF8D
  KeyKpF1* = 0x0000FF91
  KeyKpF2* = 0x0000FF92
  KeyKpF3* = 0x0000FF93
  KeyKpF4* = 0x0000FF94
  KEYKPHome* = 0x0000FF95
  KEYKPLeft* = 0x0000FF96
  KEYKPUp* = 0x0000FF97
  KEYKPRight* = 0x0000FF98
  KEYKPDown* = 0x0000FF99
  KEYKPPrior* = 0x0000FF9A
  KEYKPPageUp* = 0x0000FF9A
  KEYKPNext* = 0x0000FF9B
  KEYKPPageDown* = 0x0000FF9B
  KEYKPEnd* = 0x0000FF9C
  KEYKPBegin* = 0x0000FF9D
  KEYKPInsert* = 0x0000FF9E
  KEYKPDelete* = 0x0000FF9F
  KEYKPEqual* = 0x0000FFBD
  KEYKPMultiply* = 0x0000FFAA
  KEYKPAdd* = 0x0000FFAB
  KEYKPSeparator* = 0x0000FFAC
  KEYKPSubtract* = 0x0000FFAD
  KEYKPDecimal* = 0x0000FFAE
  KEYKPDivide* = 0x0000FFAF
  KeyKp0* = 0x0000FFB0
  KeyKp1* = 0x0000FFB1
  KeyKp2* = 0x0000FFB2
  KeyKp3* = 0x0000FFB3
  KeyKp4* = 0x0000FFB4
  KeyKp5* = 0x0000FFB5
  KeyKp6* = 0x0000FFB6
  KeyKp7* = 0x0000FFB7
  KeyKp8* = 0x0000FFB8
  KeyKp9* = 0x0000FFB9
  KeyF1* = 0x0000FFBE
  KeyF2* = 0x0000FFBF
  KeyF3* = 0x0000FFC0
  KeyF4* = 0x0000FFC1
  KeyF5* = 0x0000FFC2
  KeyF6* = 0x0000FFC3
  KeyF7* = 0x0000FFC4
  KeyF8* = 0x0000FFC5
  KeyF9* = 0x0000FFC6
  KeyF10* = 0x0000FFC7
  KeyF11* = 0x0000FFC8
  KeyL1* = 0x0000FFC8
  KeyF12* = 0x0000FFC9
  KeyL2* = 0x0000FFC9
  KeyF13* = 0x0000FFCA
  KeyL3* = 0x0000FFCA
  KeyF14* = 0x0000FFCB
  KeyL4* = 0x0000FFCB
  KeyF15* = 0x0000FFCC
  KeyL5* = 0x0000FFCC
  KeyF16* = 0x0000FFCD
  KeyL6* = 0x0000FFCD
  KeyF17* = 0x0000FFCE
  KeyL7* = 0x0000FFCE
  KeyF18* = 0x0000FFCF
  KeyL8* = 0x0000FFCF
  KeyF19* = 0x0000FFD0
  KeyL9* = 0x0000FFD0
  KeyF20* = 0x0000FFD1
  KeyL10* = 0x0000FFD1
  KeyF21* = 0x0000FFD2
  KeyR1* = 0x0000FFD2
  KeyF22* = 0x0000FFD3
  KeyR2* = 0x0000FFD3
  KeyF23* = 0x0000FFD4
  KeyR3* = 0x0000FFD4
  KeyF24* = 0x0000FFD5
  KeyR4* = 0x0000FFD5
  KeyF25* = 0x0000FFD6
  KeyR5* = 0x0000FFD6
  KeyF26* = 0x0000FFD7
  KeyR6* = 0x0000FFD7
  KeyF27* = 0x0000FFD8
  KeyR7* = 0x0000FFD8
  KeyF28* = 0x0000FFD9
  KeyR8* = 0x0000FFD9
  KeyF29* = 0x0000FFDA
  KeyR9* = 0x0000FFDA
  KeyF30* = 0x0000FFDB
  KeyR10* = 0x0000FFDB
  KeyF31* = 0x0000FFDC
  KeyR11* = 0x0000FFDC
  KeyF32* = 0x0000FFDD
  KeyR12* = 0x0000FFDD
  KeyF33* = 0x0000FFDE
  KeyR13* = 0x0000FFDE
  KeyF34* = 0x0000FFDF
  KeyR14* = 0x0000FFDF
  KeyF35* = 0x0000FFE0
  KeyR15* = 0x0000FFE0
  KEYShiftL* = 0x0000FFE1
  KEYShiftR* = 0x0000FFE2
  KEYControlL* = 0x0000FFE3
  KEYControlR* = 0x0000FFE4
  KEYCapsLock* = 0x0000FFE5
  KEYShiftLock* = 0x0000FFE6
  KEYMetaL* = 0x0000FFE7
  KEYMetaR* = 0x0000FFE8
  KEYAltL* = 0x0000FFE9
  KEYAltR* = 0x0000FFEA
  KEYSuperL* = 0x0000FFEB
  KEYSuperR* = 0x0000FFEC
  KEYHyperL* = 0x0000FFED
  KEYHyperR* = 0x0000FFEE
  KEYISOLock* = 0x0000FE01
  KEYISOLevel2Latch* = 0x0000FE02
  KEYISOLevel3Shift* = 0x0000FE03
  KEYISOLevel3Latch* = 0x0000FE04
  KEYISOLevel3Lock* = 0x0000FE05
  KEYISOGroupShift* = 0x0000FF7E
  KEYISOGroupLatch* = 0x0000FE06
  KEYISOGroupLock* = 0x0000FE07
  KEYISONextGroup* = 0x0000FE08
  KEYISONextGroupLock* = 0x0000FE09
  KEYISOPrevGroup* = 0x0000FE0A
  KEYISOPrevGroupLock* = 0x0000FE0B
  KEYISOFirstGroup* = 0x0000FE0C
  KEYISOFirstGroupLock* = 0x0000FE0D
  KEYISOLastGroup* = 0x0000FE0E
  KEYISOLastGroupLock* = 0x0000FE0F
  KEYISOLeftTab* = 0x0000FE20
  KEYISOMoveLineUp* = 0x0000FE21
  KEYISOMoveLineDown* = 0x0000FE22
  KEYISOPartialLineUp* = 0x0000FE23
  KEYISOPartialLineDown* = 0x0000FE24
  KEYISOPartialSpaceLeft* = 0x0000FE25
  KEYISOPartialSpaceRight* = 0x0000FE26
  KEYISOSetMarginLeft* = 0x0000FE27
  KEYISOSetMarginRight* = 0x0000FE28
  KEYISOReleaseMarginLeft* = 0x0000FE29
  KEYISOReleaseMarginRight* = 0x0000FE2A
  KEYISOReleaseBothMargins* = 0x0000FE2B
  KEYISOFastCursorLeft* = 0x0000FE2C
  KEYISOFastCursorRight* = 0x0000FE2D
  KEYISOFastCursorUp* = 0x0000FE2E
  KEYISOFastCursorDown* = 0x0000FE2F
  KEYISOContinuousUnderline* = 0x0000FE30
  KEYISODiscontinuousUnderline* = 0x0000FE31
  KEYISOEmphasize* = 0x0000FE32
  KEYISOCenterObject* = 0x0000FE33
  KEYISOEnter* = 0x0000FE34
  KEYDeadGrave* = 0x0000FE50
  KEYDeadAcute* = 0x0000FE51
  KEYDeadCircumflex* = 0x0000FE52
  KEYDeadTilde* = 0x0000FE53
  KEYDeadMacron* = 0x0000FE54
  KEYDeadBreve* = 0x0000FE55
  KEYDeadAbovedot* = 0x0000FE56
  KEYDeadDiaeresis* = 0x0000FE57
  KEYDeadAbovering* = 0x0000FE58
  KEYDeadDoubleacute* = 0x0000FE59
  KEYDeadCaron* = 0x0000FE5A
  KEYDeadCedilla* = 0x0000FE5B
  KEYDeadOgonek* = 0x0000FE5C
  KEYDeadIota* = 0x0000FE5D
  KEYDeadVoicedSound* = 0x0000FE5E
  KEYDeadSemivoicedSound* = 0x0000FE5F
  KEYDeadBelowdot* = 0x0000FE60
  KEYFirstVirtualScreen* = 0x0000FED0
  KEYPrevVirtualScreen* = 0x0000FED1
  KEYNextVirtualScreen* = 0x0000FED2
  KEYLastVirtualScreen* = 0x0000FED4
  KEYTerminateServer* = 0x0000FED5
  KEYAccessXEnable* = 0x0000FE70
  KEYAccessXFeedbackEnable* = 0x0000FE71
  KEYRepeatKeysEnable* = 0x0000FE72
  KEYSlowKeysEnable* = 0x0000FE73
  KEYBounceKeysEnable* = 0x0000FE74
  KEYStickyKeysEnable* = 0x0000FE75
  KEYMouseKeysEnable* = 0x0000FE76
  KEYMouseKeysAccelEnable* = 0x0000FE77
  KEYOverlay1Enable* = 0x0000FE78
  KEYOverlay2Enable* = 0x0000FE79
  KEYAudibleBellEnable* = 0x0000FE7A
  KEYPointerLeft* = 0x0000FEE0
  KEYPointerRight* = 0x0000FEE1
  KEYPointerUp* = 0x0000FEE2
  KEYPointerDown* = 0x0000FEE3
  KEYPointerUpLeft* = 0x0000FEE4
  KEYPointerUpRight* = 0x0000FEE5
  KEYPointerDownLeft* = 0x0000FEE6
  KEYPointerDownRight* = 0x0000FEE7
  KEYPointerButtonDflt* = 0x0000FEE8
  KEYPointerButton1* = 0x0000FEE9
  KEYPointerButton2* = 0x0000FEEA
  KEYPointerButton3* = 0x0000FEEB
  KEYPointerButton4* = 0x0000FEEC
  KEYPointerButton5* = 0x0000FEED
  KEYPointerDblClickDflt* = 0x0000FEEE
  KEYPointerDblClick1* = 0x0000FEEF
  KEYPointerDblClick2* = 0x0000FEF0
  KEYPointerDblClick3* = 0x0000FEF1
  KEYPointerDblClick4* = 0x0000FEF2
  KEYPointerDblClick5* = 0x0000FEF3
  KEYPointerDragDflt* = 0x0000FEF4
  KEYPointerDrag1* = 0x0000FEF5
  KEYPointerDrag2* = 0x0000FEF6
  KEYPointerDrag3* = 0x0000FEF7
  KEYPointerDrag4* = 0x0000FEF8
  KEYPointerDrag5* = 0x0000FEFD
  KEYPointerEnableKeys* = 0x0000FEF9
  KEYPointerAccelerate* = 0x0000FEFA
  KEYPointerDfltBtnNext* = 0x0000FEFB
  KEYPointerDfltBtnPrev* = 0x0000FEFC
  KEY3270Duplicate* = 0x0000FD01
  KEY3270FieldMark* = 0x0000FD02
  KEY3270Right2* = 0x0000FD03
  KEY3270Left2* = 0x0000FD04
  KEY3270BackTab* = 0x0000FD05
  KEY3270EraseEOF* = 0x0000FD06
  KEY3270EraseInput* = 0x0000FD07
  KEY3270Reset* = 0x0000FD08
  KEY3270Quit* = 0x0000FD09
  Key3270Pa1* = 0x0000FD0A
  Key3270Pa2* = 0x0000FD0B
  Key3270Pa3* = 0x0000FD0C
  KEY3270Test* = 0x0000FD0D
  KEY3270Attn* = 0x0000FD0E
  KEY3270CursorBlink* = 0x0000FD0F
  KEY3270AltCursor* = 0x0000FD10
  KEY3270KeyClick* = 0x0000FD11
  KEY3270Jump* = 0x0000FD12
  KEY3270Ident* = 0x0000FD13
  KEY3270Rule* = 0x0000FD14
  KEY3270Copy* = 0x0000FD15
  KEY3270Play* = 0x0000FD16
  KEY3270Setup* = 0x0000FD17
  KEY3270Record* = 0x0000FD18
  KEY3270ChangeScreen* = 0x0000FD19
  KEY3270DeleteWord* = 0x0000FD1A
  KEY3270ExSelect* = 0x0000FD1B
  KEY3270CursorSelect* = 0x0000FD1C
  KEY3270PrintScreen* = 0x0000FD1D
  KEY3270Enter* = 0x0000FD1E
  KEYSpace* = 0x00000020
  KEYExclam* = 0x00000021
  KEYQuotedbl* = 0x00000022
  KEYNumbersign* = 0x00000023
  KEYDollar* = 0x00000024
  KEYPercent* = 0x00000025
  KEYAmpersand* = 0x00000026
  KEYApostrophe* = 0x00000027
  KEYQuoteright* = 0x00000027
  KEYParenleft* = 0x00000028
  KEYParenright* = 0x00000029
  KEYAsterisk* = 0x0000002A
  KEYPlus* = 0x0000002B
  KEYComma* = 0x0000002C
  KEYMinus* = 0x0000002D
  KEYPeriod* = 0x0000002E
  KEYSlash* = 0x0000002F
  Key0* = 0x00000030
  Key1* = 0x00000031
  Key2* = 0x00000032
  Key3* = 0x00000033
  Key4* = 0x00000034
  Key5* = 0x00000035
  Key6* = 0x00000036
  Key7* = 0x00000037
  Key8* = 0x00000038
  Key9* = 0x00000039
  KEYColon* = 0x0000003A
  KEYSemicolon* = 0x0000003B
  KEYLess* = 0x0000003C
  KEYEqual* = 0x0000003D
  KEYGreater* = 0x0000003E
  KEYQuestion* = 0x0000003F
  KEYAt* = 0x00000040
  KeyCapitalA* = 0x00000041
  KeyCapitalB* = 0x00000042
  KeyCapitalC* = 0x00000043
  KeyCapitalD* = 0x00000044
  KeyCapitalE* = 0x00000045
  KeyCapitalF* = 0x00000046
  KeyCapitalG* = 0x00000047
  KeyCapitalH* = 0x00000048
  KeyCapitalI* = 0x00000049
  KeyCapitalJ* = 0x0000004A
  KeyCapitalK* = 0x0000004B
  KeyCapitalL* = 0x0000004C
  KeyCapitalM* = 0x0000004D
  KeyCapitalN* = 0x0000004E
  KeyCapitalO* = 0x0000004F
  KeyCapitalP* = 0x00000050
  KeyCapitalQ* = 0x00000051
  KeyCapitalR* = 0x00000052
  KeyCapitalS* = 0x00000053
  KeyCapitalT* = 0x00000054
  KeyCapitalU* = 0x00000055
  KeyCapitalV* = 0x00000056
  KeyCapitalW* = 0x00000057
  KeyCapitalX* = 0x00000058
  KeyCapitalY* = 0x00000059
  KeyCapitalZ* = 0x0000005A
  KEYBracketleft* = 0x0000005B
  KEYBackslash* = 0x0000005C
  KEYBracketright* = 0x0000005D
  KEYAsciicircum* = 0x0000005E
  KEYUnderscore* = 0x0000005F
  KEYGrave* = 0x00000060
  KEYQuoteleft* = 0x00000060
  KEYA* = 0x00000061
  KEYB* = 0x00000062
  KEYC* = 0x00000063
  KEYD* = 0x00000064
  KEYE* = 0x00000065
  KEYF* = 0x00000066
  KEYG* = 0x00000067
  KEYH* = 0x00000068
  KEYI* = 0x00000069
  KEYJ* = 0x0000006A
  KEYK* = 0x0000006B
  KEYL* = 0x0000006C
  KEYM* = 0x0000006D
  KEYN* = 0x0000006E
  KEYO* = 0x0000006F
  KEYP* = 0x00000070
  KEYQ* = 0x00000071
  KEYR* = 0x00000072
  KEYS* = 0x00000073
  KEYT* = 0x00000074
  KEYU* = 0x00000075
  KEYV* = 0x00000076
  KEYW* = 0x00000077
  KEYX* = 0x00000078
  KEYY* = 0x00000079
  KEYZ* = 0x0000007A
  KEYBraceleft* = 0x0000007B
  KEYBar* = 0x0000007C
  KEYBraceright* = 0x0000007D
  KEYAsciitilde* = 0x0000007E
  KEYNobreakspace* = 0x000000A0
  KEYExclamdown* = 0x000000A1
  KEYCent* = 0x000000A2
  KEYSterling* = 0x000000A3
  KEYCurrency* = 0x000000A4
  KEYYen* = 0x000000A5
  KEYBrokenbar* = 0x000000A6
  KEYSection* = 0x000000A7
  KEYDiaeresis* = 0x000000A8
  KEYCopyright* = 0x000000A9
  KEYOrdfeminine* = 0x000000AA
  KEYGuillemotleft* = 0x000000AB
  KEYNotsign* = 0x000000AC
  KEYHyphen* = 0x000000AD
  KEYRegistered* = 0x000000AE
  KEYMacron* = 0x000000AF
  KEYDegree* = 0x000000B0
  KEYPlusminus* = 0x000000B1
  KEYTwosuperior* = 0x000000B2
  KEYThreesuperior* = 0x000000B3
  KEYAcute* = 0x000000B4
  KEYMu* = 0x000000B5
  KEYParagraph* = 0x000000B6
  KEYPeriodcentered* = 0x000000B7
  KEYCedilla* = 0x000000B8
  KEYOnesuperior* = 0x000000B9
  KEYMasculine* = 0x000000BA
  KEYGuillemotright* = 0x000000BB
  KEYOnequarter* = 0x000000BC
  KEYOnehalf* = 0x000000BD
  KEYThreequarters* = 0x000000BE
  KEYQuestiondown* = 0x000000BF
  KEYCAPITALAgrave* = 0x000000C0
  KEYCAPITALAacute* = 0x000000C1
  KEYCAPITALAcircumflex* = 0x000000C2
  KEYCAPITALAtilde* = 0x000000C3
  KEYCAPITALAdiaeresis* = 0x000000C4
  KEYCAPITALAring* = 0x000000C5
  KeyCapitalAe* = 0x000000C6
  KEYCAPITALCcedilla* = 0x000000C7
  KEYCAPITALEgrave* = 0x000000C8
  KEYCAPITALEacute* = 0x000000C9
  KEYCAPITALEcircumflex* = 0x000000CA
  KEYCAPITALEdiaeresis* = 0x000000CB
  KEYCAPITALIgrave* = 0x000000CC
  KEYCAPITALIacute* = 0x000000CD
  KEYCAPITALIcircumflex* = 0x000000CE
  KEYCAPITALIdiaeresis* = 0x000000CF
  KeyCapitalEth* = 0x000000D0
  KEYCAPITALNtilde* = 0x000000D1
  KEYCAPITALOgrave* = 0x000000D2
  KEYCAPITALOacute* = 0x000000D3
  KEYCAPITALOcircumflex* = 0x000000D4
  KEYCAPITALOtilde* = 0x000000D5
  KEYCAPITALOdiaeresis* = 0x000000D6
  KEYMultiply* = 0x000000D7
  KEYOoblique* = 0x000000D8
  KEYCAPITALUgrave* = 0x000000D9
  KEYCAPITALUacute* = 0x000000DA
  KEYCAPITALUcircumflex* = 0x000000DB
  KEYCAPITALUdiaeresis* = 0x000000DC
  KEYCAPITALYacute* = 0x000000DD
  KeyCapitalThorn* = 0x000000DE
  KEYSsharp* = 0x000000DF
  KEYAgrave* = 0x000000E0
  KEYAacute* = 0x000000E1
  KEYAcircumflex* = 0x000000E2
  KEYAtilde* = 0x000000E3
  KEYAdiaeresis* = 0x000000E4
  KEYAring* = 0x000000E5
  KEYAe* = 0x000000E6
  KEYCcedilla* = 0x000000E7
  KEYEgrave* = 0x000000E8
  KEYEacute* = 0x000000E9
  KEYEcircumflex* = 0x000000EA
  KEYEdiaeresis* = 0x000000EB
  KEYIgrave* = 0x000000EC
  KEYIacute* = 0x000000ED
  KEYIcircumflex* = 0x000000EE
  KEYIdiaeresis* = 0x000000EF
  KEYEth* = 0x000000F0
  KEYNtilde* = 0x000000F1
  KEYOgrave* = 0x000000F2
  KEYOacute* = 0x000000F3
  KEYOcircumflex* = 0x000000F4
  KEYOtilde* = 0x000000F5
  KEYOdiaeresis* = 0x000000F6
  KEYDivision* = 0x000000F7
  KEYOslash* = 0x000000F8
  KEYUgrave* = 0x000000F9
  KEYUacute* = 0x000000FA
  KEYUcircumflex* = 0x000000FB
  KEYUdiaeresis* = 0x000000FC
  KEYYacute* = 0x000000FD
  KEYThorn* = 0x000000FE
  KEYYdiaeresis* = 0x000000FF
  KEYCAPITALAogonek* = 0x000001A1
  KEYBreve* = 0x000001A2
  KEYCAPITALLstroke* = 0x000001A3
  KEYCAPITALLcaron* = 0x000001A5
  KEYCAPITALSacute* = 0x000001A6
  KEYCAPITALScaron* = 0x000001A9
  KEYCAPITALScedilla* = 0x000001AA
  KEYCAPITALTcaron* = 0x000001AB
  KEYCAPITALZacute* = 0x000001AC
  KEYCAPITALZcaron* = 0x000001AE
  KEYCAPITALZabovedot* = 0x000001AF
  KEYAogonek* = 0x000001B1
  KEYOgonek* = 0x000001B2
  KEYLstroke* = 0x000001B3
  KEYLcaron* = 0x000001B5
  KEYSacute* = 0x000001B6
  KEYCaron* = 0x000001B7
  KEYScaron* = 0x000001B9
  KEYScedilla* = 0x000001BA
  KEYTcaron* = 0x000001BB
  KEYZacute* = 0x000001BC
  KEYDoubleacute* = 0x000001BD
  KEYZcaron* = 0x000001BE
  KEYZabovedot* = 0x000001BF
  KEYCAPITALRacute* = 0x000001C0
  KEYCAPITALAbreve* = 0x000001C3
  KEYCAPITALLacute* = 0x000001C5
  KEYCAPITALCacute* = 0x000001C6
  KEYCAPITALCcaron* = 0x000001C8
  KEYCAPITALEogonek* = 0x000001CA
  KEYCAPITALEcaron* = 0x000001CC
  KEYCAPITALDcaron* = 0x000001CF
  KEYCAPITALDstroke* = 0x000001D0
  KEYCAPITALNacute* = 0x000001D1
  KEYCAPITALNcaron* = 0x000001D2
  KEYCAPITALOdoubleacute* = 0x000001D5
  KEYCAPITALRcaron* = 0x000001D8
  KEYCAPITALUring* = 0x000001D9
  KEYCAPITALUdoubleacute* = 0x000001DB
  KEYCAPITALTcedilla* = 0x000001DE
  KEYRacute* = 0x000001E0
  KEYAbreve* = 0x000001E3
  KEYLacute* = 0x000001E5
  KEYCacute* = 0x000001E6
  KEYCcaron* = 0x000001E8
  KEYEogonek* = 0x000001EA
  KEYEcaron* = 0x000001EC
  KEYDcaron* = 0x000001EF
  KEYDstroke* = 0x000001F0
  KEYNacute* = 0x000001F1
  KEYNcaron* = 0x000001F2
  KEYOdoubleacute* = 0x000001F5
  KEYUdoubleacute* = 0x000001FB
  KEYRcaron* = 0x000001F8
  KEYUring* = 0x000001F9
  KEYTcedilla* = 0x000001FE
  KEYAbovedot* = 0x000001FF
  KEYCAPITALHstroke* = 0x000002A1
  KEYCAPITALHcircumflex* = 0x000002A6
  KEYCAPITALIabovedot* = 0x000002A9
  KEYCAPITALGbreve* = 0x000002AB
  KEYCAPITALJcircumflex* = 0x000002AC
  KEYHstroke* = 0x000002B1
  KEYHcircumflex* = 0x000002B6
  KEYIdotless* = 0x000002B9
  KEYGbreve* = 0x000002BB
  KEYJcircumflex* = 0x000002BC
  KEYCAPITALCabovedot* = 0x000002C5
  KEYCAPITALCcircumflex* = 0x000002C6
  KEYCAPITALGabovedot* = 0x000002D5
  KEYCAPITALGcircumflex* = 0x000002D8
  KEYCAPITALUbreve* = 0x000002DD
  KEYCAPITALScircumflex* = 0x000002DE
  KEYCabovedot* = 0x000002E5
  KEYCcircumflex* = 0x000002E6
  KEYGabovedot* = 0x000002F5
  KEYGcircumflex* = 0x000002F8
  KEYUbreve* = 0x000002FD
  KEYScircumflex* = 0x000002FE
  KEYKra* = 0x000003A2
  KEYKappa* = 0x000003A2
  KEYCAPITALRcedilla* = 0x000003A3
  KEYCAPITALItilde* = 0x000003A5
  KEYCAPITALLcedilla* = 0x000003A6
  KEYCAPITALEmacron* = 0x000003AA
  KEYCAPITALGcedilla* = 0x000003AB
  KEYCAPITALTslash* = 0x000003AC
  KEYRcedilla* = 0x000003B3
  KEYItilde* = 0x000003B5
  KEYLcedilla* = 0x000003B6
  KEYEmacron* = 0x000003BA
  KEYGcedilla* = 0x000003BB
  KEYTslash* = 0x000003BC
  KeyCapitalEng* = 0x000003BD
  KEYEng* = 0x000003BF
  KEYCAPITALAmacron* = 0x000003C0
  KEYCAPITALIogonek* = 0x000003C7
  KEYCAPITALEabovedot* = 0x000003CC
  KEYCAPITALImacron* = 0x000003CF
  KEYCAPITALNcedilla* = 0x000003D1
  KEYCAPITALOmacron* = 0x000003D2
  KEYCAPITALKcedilla* = 0x000003D3
  KEYCAPITALUogonek* = 0x000003D9
  KEYCAPITALUtilde* = 0x000003DD
  KEYCAPITALUmacron* = 0x000003DE
  KEYAmacron* = 0x000003E0
  KEYIogonek* = 0x000003E7
  KEYEabovedot* = 0x000003EC
  KEYImacron* = 0x000003EF
  KEYNcedilla* = 0x000003F1
  KEYOmacron* = 0x000003F2
  KEYKcedilla* = 0x000003F3
  KEYUogonek* = 0x000003F9
  KEYUtilde* = 0x000003FD
  KEYUmacron* = 0x000003FE
  KeyCapitalOe* = 0x000013BC
  KEYOe* = 0x000013BD
  KEYCAPITALYdiaeresis* = 0x000013BE
  KEYOverline* = 0x0000047E
  KEYKanaFullstop* = 0x000004A1
  KEYKanaOpeningbracket* = 0x000004A2
  KEYKanaClosingbracket* = 0x000004A3
  KEYKanaComma* = 0x000004A4
  KEYKanaConjunctive* = 0x000004A5
  KEYKanaMiddledot* = 0x000004A5
  KEYKanaWO* = 0x000004A6
  KEYKanaA* = 0x000004A7
  KEYKanaI* = 0x000004A8
  KEYKanaU* = 0x000004A9
  KEYKanaE* = 0x000004AA
  KEYKanaO* = 0x000004AB
  KEYKanaYa* = 0x000004AC
  KEYKanaYu* = 0x000004AD
  KEYKanaYo* = 0x000004AE
  KEYKanaTsu* = 0x000004AF
  KEYKanaTu* = 0x000004AF
  KEYProlongedsound* = 0x000004B0
  KEYKanaCAPITALA* = 0x000004B1
  KEYKanaCAPITALI* = 0x000004B2
  KEYKanaCAPITALU* = 0x000004B3
  KEYKanaCAPITALE* = 0x000004B4
  KEYKanaCAPITALO* = 0x000004B5
  KEYKanaKA* = 0x000004B6
  KEYKanaKI* = 0x000004B7
  KEYKanaKU* = 0x000004B8
  KEYKanaKE* = 0x000004B9
  KEYKanaKO* = 0x000004BA
  KEYKanaSA* = 0x000004BB
  KEYKanaSHI* = 0x000004BC
  KEYKanaSU* = 0x000004BD
  KEYKanaSE* = 0x000004BE
  KEYKanaSO* = 0x000004BF
  KEYKanaTA* = 0x000004C0
  KEYKanaCHI* = 0x000004C1
  KEYKanaTI* = 0x000004C1
  KEYKanaCAPITALTSU* = 0x000004C2
  KEYKanaCAPITALTU* = 0x000004C2
  KEYKanaTE* = 0x000004C3
  KEYKanaTO* = 0x000004C4
  KEYKanaNA* = 0x000004C5
  KEYKanaNI* = 0x000004C6
  KEYKanaNU* = 0x000004C7
  KEYKanaNE* = 0x000004C8
  KEYKanaNO* = 0x000004C9
  KEYKanaHA* = 0x000004CA
  KEYKanaHI* = 0x000004CB
  KEYKanaFU* = 0x000004CC
  KEYKanaHU* = 0x000004CC
  KEYKanaHE* = 0x000004CD
  KEYKanaHO* = 0x000004CE
  KEYKanaMA* = 0x000004CF
  KEYKanaMI* = 0x000004D0
  KEYKanaMU* = 0x000004D1
  KEYKanaME* = 0x000004D2
  KEYKanaMO* = 0x000004D3
  KEYKanaCAPITALYA* = 0x000004D4
  KEYKanaCAPITALYU* = 0x000004D5
  KEYKanaCAPITALYO* = 0x000004D6
  KEYKanaRA* = 0x000004D7
  KEYKanaRI* = 0x000004D8
  KEYKanaRU* = 0x000004D9
  KEYKanaRE* = 0x000004DA
  KEYKanaRO* = 0x000004DB
  KEYKanaWA* = 0x000004DC
  KEYKanaN* = 0x000004DD
  KEYVoicedsound* = 0x000004DE
  KEYSemivoicedsound* = 0x000004DF
  KEYKanaSwitch* = 0x0000FF7E
  KEYArabicComma* = 0x000005AC
  KEYArabicSemicolon* = 0x000005BB
  KEYArabicQuestionMark* = 0x000005BF
  KEYArabicHamza* = 0x000005C1
  KEYArabicMaddaonalef* = 0x000005C2
  KEYArabicHamzaonalef* = 0x000005C3
  KEYArabicHamzaonwaw* = 0x000005C4
  KEYArabicHamzaunderalef* = 0x000005C5
  KEYArabicHamzaonyeh* = 0x000005C6
  KEYArabicAlef* = 0x000005C7
  KEYArabicBeh* = 0x000005C8
  KEYArabicTehmarbuta* = 0x000005C9
  KEYArabicTeh* = 0x000005CA
  KEYArabicTheh* = 0x000005CB
  KEYArabicJeem* = 0x000005CC
  KEYArabicHah* = 0x000005CD
  KEYArabicKhah* = 0x000005CE
  KEYArabicDal* = 0x000005CF
  KEYArabicThal* = 0x000005D0
  KEYArabicRa* = 0x000005D1
  KEYArabicZain* = 0x000005D2
  KEYArabicSeen* = 0x000005D3
  KEYArabicSheen* = 0x000005D4
  KEYArabicSad* = 0x000005D5
  KEYArabicDad* = 0x000005D6
  KEYArabicTah* = 0x000005D7
  KEYArabicZah* = 0x000005D8
  KEYArabicAin* = 0x000005D9
  KEYArabicGhain* = 0x000005DA
  KEYArabicTatweel* = 0x000005E0
  KEYArabicFeh* = 0x000005E1
  KEYArabicQaf* = 0x000005E2
  KEYArabicKaf* = 0x000005E3
  KEYArabicLam* = 0x000005E4
  KEYArabicMeem* = 0x000005E5
  KEYArabicNoon* = 0x000005E6
  KEYArabicHa* = 0x000005E7
  KEYArabicHeh* = 0x000005E7
  KEYArabicWaw* = 0x000005E8
  KEYArabicAlefmaksura* = 0x000005E9
  KEYArabicYeh* = 0x000005EA
  KEYArabicFathatan* = 0x000005EB
  KEYArabicDammatan* = 0x000005EC
  KEYArabicKasratan* = 0x000005ED
  KEYArabicFatha* = 0x000005EE
  KEYArabicDamma* = 0x000005EF
  KEYArabicKasra* = 0x000005F0
  KEYArabicShadda* = 0x000005F1
  KEYArabicSukun* = 0x000005F2
  KEYArabicSwitch* = 0x0000FF7E
  KEYSerbianDje* = 0x000006A1
  KEYMacedoniaGje* = 0x000006A2
  KEYCyrillicIo* = 0x000006A3
  KEYUkrainianIe* = 0x000006A4
  KEYUkranianJe* = 0x000006A4
  KEYMacedoniaDse* = 0x000006A5
  KEYUkrainianI* = 0x000006A6
  KEYUkranianI* = 0x000006A6
  KEYUkrainianYi* = 0x000006A7
  KEYUkranianYi* = 0x000006A7
  KEYCyrillicJe* = 0x000006A8
  KEYSerbianJe* = 0x000006A8
  KEYCyrillicLje* = 0x000006A9
  KEYSerbianLje* = 0x000006A9
  KEYCyrillicNje* = 0x000006AA
  KEYSerbianNje* = 0x000006AA
  KEYSerbianTshe* = 0x000006AB
  KEYMacedoniaKje* = 0x000006AC
  KEYByelorussianShortu* = 0x000006AE
  KEYCyrillicDzhe* = 0x000006AF
  KEYSerbianDze* = 0x000006AF
  KEYNumerosign* = 0x000006B0
  KEYSerbianCAPITALDJE* = 0x000006B1
  KEYMacedoniaCAPITALGJE* = 0x000006B2
  KEYCyrillicCAPITALIO* = 0x000006B3
  KEYUkrainianCAPITALIE* = 0x000006B4
  KEYUkranianCAPITALJE* = 0x000006B4
  KEYMacedoniaCAPITALDSE* = 0x000006B5
  KEYUkrainianCAPITALI* = 0x000006B6
  KEYUkranianCAPITALI* = 0x000006B6
  KEYUkrainianCAPITALYI* = 0x000006B7
  KEYUkranianCAPITALYI* = 0x000006B7
  KEYCyrillicCAPITALJE* = 0x000006B8
  KEYSerbianCAPITALJE* = 0x000006B8
  KEYCyrillicCAPITALLJE* = 0x000006B9
  KEYSerbianCAPITALLJE* = 0x000006B9
  KEYCyrillicCAPITALNJE* = 0x000006BA
  KEYSerbianCAPITALNJE* = 0x000006BA
  KEYSerbianCAPITALTSHE* = 0x000006BB
  KEYMacedoniaCAPITALKJE* = 0x000006BC
  KEYByelorussianCAPITALSHORTU* = 0x000006BE
  KEYCyrillicCAPITALDZHE* = 0x000006BF
  KEYSerbianCAPITALDZE* = 0x000006BF
  KEYCyrillicYu* = 0x000006C0
  KEYCyrillicA* = 0x000006C1
  KEYCyrillicBe* = 0x000006C2
  KEYCyrillicTse* = 0x000006C3
  KEYCyrillicDe* = 0x000006C4
  KEYCyrillicIe* = 0x000006C5
  KEYCyrillicEf* = 0x000006C6
  KEYCyrillicGhe* = 0x000006C7
  KEYCyrillicHa* = 0x000006C8
  KEYCyrillicI* = 0x000006C9
  KEYCyrillicShorti* = 0x000006CA
  KEYCyrillicKa* = 0x000006CB
  KEYCyrillicEl* = 0x000006CC
  KEYCyrillicEm* = 0x000006CD
  KEYCyrillicEn* = 0x000006CE
  KEYCyrillicO* = 0x000006CF
  KEYCyrillicPe* = 0x000006D0
  KEYCyrillicYa* = 0x000006D1
  KEYCyrillicEr* = 0x000006D2
  KEYCyrillicEs* = 0x000006D3
  KEYCyrillicTe* = 0x000006D4
  KEYCyrillicU* = 0x000006D5
  KEYCyrillicZhe* = 0x000006D6
  KEYCyrillicVe* = 0x000006D7
  KEYCyrillicSoftsign* = 0x000006D8
  KEYCyrillicYeru* = 0x000006D9
  KEYCyrillicZe* = 0x000006DA
  KEYCyrillicSha* = 0x000006DB
  KEYCyrillicE* = 0x000006DC
  KEYCyrillicShcha* = 0x000006DD
  KEYCyrillicChe* = 0x000006DE
  KEYCyrillicHardsign* = 0x000006DF
  KEYCyrillicCAPITALYU* = 0x000006E0
  KEYCyrillicCAPITALA* = 0x000006E1
  KEYCyrillicCAPITALBE* = 0x000006E2
  KEYCyrillicCAPITALTSE* = 0x000006E3
  KEYCyrillicCAPITALDE* = 0x000006E4
  KEYCyrillicCAPITALIE* = 0x000006E5
  KEYCyrillicCAPITALEF* = 0x000006E6
  KEYCyrillicCAPITALGHE* = 0x000006E7
  KEYCyrillicCAPITALHA* = 0x000006E8
  KEYCyrillicCAPITALI* = 0x000006E9
  KEYCyrillicCAPITALSHORTI* = 0x000006EA
  KEYCyrillicCAPITALKA* = 0x000006EB
  KEYCyrillicCAPITALEL* = 0x000006EC
  KEYCyrillicCAPITALEM* = 0x000006ED
  KEYCyrillicCAPITALEN* = 0x000006EE
  KEYCyrillicCAPITALO* = 0x000006EF
  KEYCyrillicCAPITALPE* = 0x000006F0
  KEYCyrillicCAPITALYA* = 0x000006F1
  KEYCyrillicCAPITALER* = 0x000006F2
  KEYCyrillicCAPITALES* = 0x000006F3
  KEYCyrillicCAPITALTE* = 0x000006F4
  KEYCyrillicCAPITALU* = 0x000006F5
  KEYCyrillicCAPITALZHE* = 0x000006F6
  KEYCyrillicCAPITALVE* = 0x000006F7
  KEYCyrillicCAPITALSOFTSIGN* = 0x000006F8
  KEYCyrillicCAPITALYERU* = 0x000006F9
  KEYCyrillicCAPITALZE* = 0x000006FA
  KEYCyrillicCAPITALSHA* = 0x000006FB
  KEYCyrillicCAPITALE* = 0x000006FC
  KEYCyrillicCAPITALSHCHA* = 0x000006FD
  KEYCyrillicCAPITALCHE* = 0x000006FE
  KEYCyrillicCAPITALHARDSIGN* = 0x000006FF
  KEYGreekCAPITALALPHAaccent* = 0x000007A1
  KEYGreekCAPITALEPSILONaccent* = 0x000007A2
  KEYGreekCAPITALETAaccent* = 0x000007A3
  KEYGreekCAPITALIOTAaccent* = 0x000007A4
  KEYGreekCAPITALIOTAdiaeresis* = 0x000007A5
  KEYGreekCAPITALOMICRONaccent* = 0x000007A7
  KEYGreekCAPITALUPSILONaccent* = 0x000007A8
  KEYGreekCAPITALUPSILONdieresis* = 0x000007A9
  KEYGreekCAPITALOMEGAaccent* = 0x000007AB
  KEYGreekAccentdieresis* = 0x000007AE
  KEYGreekHorizbar* = 0x000007AF
  KEYGreekAlphaaccent* = 0x000007B1
  KEYGreekEpsilonaccent* = 0x000007B2
  KEYGreekEtaaccent* = 0x000007B3
  KEYGreekIotaaccent* = 0x000007B4
  KEYGreekIotadieresis* = 0x000007B5
  KEYGreekIotaaccentdieresis* = 0x000007B6
  KEYGreekOmicronaccent* = 0x000007B7
  KEYGreekUpsilonaccent* = 0x000007B8
  KEYGreekUpsilondieresis* = 0x000007B9
  KEYGreekUpsilonaccentdieresis* = 0x000007BA
  KEYGreekOmegaaccent* = 0x000007BB
  KEYGreekCAPITALALPHA* = 0x000007C1
  KEYGreekCAPITALBETA* = 0x000007C2
  KEYGreekCAPITALGAMMA* = 0x000007C3
  KEYGreekCAPITALDELTA* = 0x000007C4
  KEYGreekCAPITALEPSILON* = 0x000007C5
  KEYGreekCAPITALZETA* = 0x000007C6
  KEYGreekCAPITALETA* = 0x000007C7
  KEYGreekCAPITALTHETA* = 0x000007C8
  KEYGreekCAPITALIOTA* = 0x000007C9
  KEYGreekCAPITALKAPPA* = 0x000007CA
  KEYGreekCAPITALLAMDA* = 0x000007CB
  KEYGreekCAPITALLAMBDA* = 0x000007CB
  KEYGreekCAPITALMU* = 0x000007CC
  KEYGreekCAPITALNU* = 0x000007CD
  KEYGreekCAPITALXI* = 0x000007CE
  KEYGreekCAPITALOMICRON* = 0x000007CF
  KEYGreekCAPITALPI* = 0x000007D0
  KEYGreekCAPITALRHO* = 0x000007D1
  KEYGreekCAPITALSIGMA* = 0x000007D2
  KEYGreekCAPITALTAU* = 0x000007D4
  KEYGreekCAPITALUPSILON* = 0x000007D5
  KEYGreekCAPITALPHI* = 0x000007D6
  KEYGreekCAPITALCHI* = 0x000007D7
  KEYGreekCAPITALPSI* = 0x000007D8
  KEYGreekCAPITALOMEGA* = 0x000007D9
  KEYGreekAlpha* = 0x000007E1
  KEYGreekBeta* = 0x000007E2
  KEYGreekGamma* = 0x000007E3
  KEYGreekDelta* = 0x000007E4
  KEYGreekEpsilon* = 0x000007E5
  KEYGreekZeta* = 0x000007E6
  KEYGreekEta* = 0x000007E7
  KEYGreekTheta* = 0x000007E8
  KEYGreekIota* = 0x000007E9
  KEYGreekKappa* = 0x000007EA
  KEYGreekLamda* = 0x000007EB
  KEYGreekLambda* = 0x000007EB
  KEYGreekMu* = 0x000007EC
  KEYGreekNu* = 0x000007ED
  KEYGreekXi* = 0x000007EE
  KEYGreekOmicron* = 0x000007EF
  KEYGreekPi* = 0x000007F0
  KEYGreekRho* = 0x000007F1
  KEYGreekSigma* = 0x000007F2
  KEYGreekFinalsmallsigma* = 0x000007F3
  KEYGreekTau* = 0x000007F4
  KEYGreekUpsilon* = 0x000007F5
  KEYGreekPhi* = 0x000007F6
  KEYGreekChi* = 0x000007F7
  KEYGreekPsi* = 0x000007F8
  KEYGreekOmega* = 0x000007F9
  KEYGreekSwitch* = 0x0000FF7E
  KEYLeftradical* = 0x000008A1
  KEYTopleftradical* = 0x000008A2
  KEYHorizconnector* = 0x000008A3
  KEYTopintegral* = 0x000008A4
  KEYBotintegral* = 0x000008A5
  KEYVertconnector* = 0x000008A6
  KEYTopleftsqbracket* = 0x000008A7
  KEYBotleftsqbracket* = 0x000008A8
  KEYToprightsqbracket* = 0x000008A9
  KEYBotrightsqbracket* = 0x000008AA
  KEYTopleftparens* = 0x000008AB
  KEYBotleftparens* = 0x000008AC
  KEYToprightparens* = 0x000008AD
  KEYBotrightparens* = 0x000008AE
  KEYLeftmiddlecurlybrace* = 0x000008AF
  KEYRightmiddlecurlybrace* = 0x000008B0
  KEYTopleftsummation* = 0x000008B1
  KEYBotleftsummation* = 0x000008B2
  KEYTopvertsummationconnector* = 0x000008B3
  KEYBotvertsummationconnector* = 0x000008B4
  KEYToprightsummation* = 0x000008B5
  KEYBotrightsummation* = 0x000008B6
  KEYRightmiddlesummation* = 0x000008B7
  KEYLessthanequal* = 0x000008BC
  KEYNotequal* = 0x000008BD
  KEYGreaterthanequal* = 0x000008BE
  KEYIntegral* = 0x000008BF
  KEYTherefore* = 0x000008C0
  KEYVariation* = 0x000008C1
  KEYInfinity* = 0x000008C2
  KEYNabla* = 0x000008C5
  KEYApproximate* = 0x000008C8
  KEYSimilarequal* = 0x000008C9
  KEYIfonlyif* = 0x000008CD
  KEYImplies* = 0x000008CE
  KEYIdentical* = 0x000008CF
  KEYRadical* = 0x000008D6
  KEYIncludedin* = 0x000008DA
  KEYIncludes* = 0x000008DB
  KEYIntersection* = 0x000008DC
  KEYUnion* = 0x000008DD
  KEYLogicaland* = 0x000008DE
  KEYLogicalor* = 0x000008DF
  KEYPartialderivative* = 0x000008EF
  KEYFunction* = 0x000008F6
  KEYLeftarrow* = 0x000008FB
  KEYUparrow* = 0x000008FC
  KEYRightarrow* = 0x000008FD
  KEYDownarrow* = 0x000008FE
  KEYBlank* = 0x000009DF
  KEYSoliddiamond* = 0x000009E0
  KEYCheckerboard* = 0x000009E1
  KEYHt* = 0x000009E2
  KEYFf* = 0x000009E3
  KEYCr* = 0x000009E4
  KEYLf* = 0x000009E5
  KEYNl* = 0x000009E8
  KEYVt* = 0x000009E9
  KEYLowrightcorner* = 0x000009EA
  KEYUprightcorner* = 0x000009EB
  KEYUpleftcorner* = 0x000009EC
  KEYLowleftcorner* = 0x000009ED
  KEYCrossinglines* = 0x000009EE
  KEYHorizlinescan1* = 0x000009EF
  KEYHorizlinescan3* = 0x000009F0
  KEYHorizlinescan5* = 0x000009F1
  KEYHorizlinescan7* = 0x000009F2
  KEYHorizlinescan9* = 0x000009F3
  KEYLeftt* = 0x000009F4
  KEYRightt* = 0x000009F5
  KEYBott* = 0x000009F6
  KEYTopt* = 0x000009F7
  KEYVertbar* = 0x000009F8
  KEYEmspace* = 0x00000AA1
  KEYEnspace* = 0x00000AA2
  KEYEm3space* = 0x00000AA3
  KEYEm4space* = 0x00000AA4
  KEYDigitspace* = 0x00000AA5
  KEYPunctspace* = 0x00000AA6
  KEYThinspace* = 0x00000AA7
  KEYHairspace* = 0x00000AA8
  KEYEmdash* = 0x00000AA9
  KEYEndash* = 0x00000AAA
  KEYSignifblank* = 0x00000AAC
  KEYEllipsis* = 0x00000AAE
  KEYDoubbaselinedot* = 0x00000AAF
  KEYOnethird* = 0x00000AB0
  KEYTwothirds* = 0x00000AB1
  KEYOnefifth* = 0x00000AB2
  KEYTwofifths* = 0x00000AB3
  KEYThreefifths* = 0x00000AB4
  KEYFourfifths* = 0x00000AB5
  KEYOnesixth* = 0x00000AB6
  KEYFivesixths* = 0x00000AB7
  KEYCareof* = 0x00000AB8
  KEYFigdash* = 0x00000ABB
  KEYLeftanglebracket* = 0x00000ABC
  KEYDecimalpoint* = 0x00000ABD
  KEYRightanglebracket* = 0x00000ABE
  KEYMarker* = 0x00000ABF
  KEYOneeighth* = 0x00000AC3
  KEYThreeeighths* = 0x00000AC4
  KEYFiveeighths* = 0x00000AC5
  KEYSeveneighths* = 0x00000AC6
  KEYTrademark* = 0x00000AC9
  KEYSignaturemark* = 0x00000ACA
  KEYTrademarkincircle* = 0x00000ACB
  KEYLeftopentriangle* = 0x00000ACC
  KEYRightopentriangle* = 0x00000ACD
  KEYEmopencircle* = 0x00000ACE
  KEYEmopenrectangle* = 0x00000ACF
  KEYLeftsinglequotemark* = 0x00000AD0
  KEYRightsinglequotemark* = 0x00000AD1
  KEYLeftdoublequotemark* = 0x00000AD2
  KEYRightdoublequotemark* = 0x00000AD3
  KEYPrescription* = 0x00000AD4
  KEYMinutes* = 0x00000AD6
  KEYSeconds* = 0x00000AD7
  KEYLatincross* = 0x00000AD9
  KEYHexagram* = 0x00000ADA
  KEYFilledrectbullet* = 0x00000ADB
  KEYFilledlefttribullet* = 0x00000ADC
  KEYFilledrighttribullet* = 0x00000ADD
  KEYEmfilledcircle* = 0x00000ADE
  KEYEmfilledrect* = 0x00000ADF
  KEYEnopencircbullet* = 0x00000AE0
  KEYEnopensquarebullet* = 0x00000AE1
  KEYOpenrectbullet* = 0x00000AE2
  KEYOpentribulletup* = 0x00000AE3
  KEYOpentribulletdown* = 0x00000AE4
  KEYOpenstar* = 0x00000AE5
  KEYEnfilledcircbullet* = 0x00000AE6
  KEYEnfilledsqbullet* = 0x00000AE7
  KEYFilledtribulletup* = 0x00000AE8
  KEYFilledtribulletdown* = 0x00000AE9
  KEYLeftpointer* = 0x00000AEA
  KEYRightpointer* = 0x00000AEB
  KEYClub* = 0x00000AEC
  KEYDiamond* = 0x00000AED
  KEYHeart* = 0x00000AEE
  KEYMaltesecross* = 0x00000AF0
  KEYDagger* = 0x00000AF1
  KEYDoubledagger* = 0x00000AF2
  KEYCheckmark* = 0x00000AF3
  KEYBallotcross* = 0x00000AF4
  KEYMusicalsharp* = 0x00000AF5
  KEYMusicalflat* = 0x00000AF6
  KEYMalesymbol* = 0x00000AF7
  KEYFemalesymbol* = 0x00000AF8
  KEYTelephone* = 0x00000AF9
  KEYTelephonerecorder* = 0x00000AFA
  KEYPhonographcopyright* = 0x00000AFB
  KEYCaret* = 0x00000AFC
  KEYSinglelowquotemark* = 0x00000AFD
  KEYDoublelowquotemark* = 0x00000AFE
  KEYCursor* = 0x00000AFF
  KEYLeftcaret* = 0x00000BA3
  KEYRightcaret* = 0x00000BA6
  KEYDowncaret* = 0x00000BA8
  KEYUpcaret* = 0x00000BA9
  KEYOverbar* = 0x00000BC0
  KEYDowntack* = 0x00000BC2
  KEYUpshoe* = 0x00000BC3
  KEYDownstile* = 0x00000BC4
  KEYUnderbar* = 0x00000BC6
  KEYJot* = 0x00000BCA
  KEYQuad* = 0x00000BCC
  KEYUptack* = 0x00000BCE
  KEYCircle* = 0x00000BCF
  KEYUpstile* = 0x00000BD3
  KEYDownshoe* = 0x00000BD6
  KEYRightshoe* = 0x00000BD8
  KEYLeftshoe* = 0x00000BDA
  KEYLefttack* = 0x00000BDC
  KEYRighttack* = 0x00000BFC
  KEYHebrewDoublelowline* = 0x00000CDF
  KEYHebrewAleph* = 0x00000CE0
  KEYHebrewBet* = 0x00000CE1
  KEYHebrewBeth* = 0x00000CE1
  KEYHebrewGimel* = 0x00000CE2
  KEYHebrewGimmel* = 0x00000CE2
  KEYHebrewDalet* = 0x00000CE3
  KEYHebrewDaleth* = 0x00000CE3
  KEYHebrewHe* = 0x00000CE4
  KEYHebrewWaw* = 0x00000CE5
  KEYHebrewZain* = 0x00000CE6
  KEYHebrewZayin* = 0x00000CE6
  KEYHebrewChet* = 0x00000CE7
  KEYHebrewHet* = 0x00000CE7
  KEYHebrewTet* = 0x00000CE8
  KEYHebrewTeth* = 0x00000CE8
  KEYHebrewYod* = 0x00000CE9
  KEYHebrewFinalkaph* = 0x00000CEA
  KEYHebrewKaph* = 0x00000CEB
  KEYHebrewLamed* = 0x00000CEC
  KEYHebrewFinalmem* = 0x00000CED
  KEYHebrewMem* = 0x00000CEE
  KEYHebrewFinalnun* = 0x00000CEF
  KEYHebrewNun* = 0x00000CF0
  KEYHebrewSamech* = 0x00000CF1
  KEYHebrewSamekh* = 0x00000CF1
  KEYHebrewAyin* = 0x00000CF2
  KEYHebrewFinalpe* = 0x00000CF3
  KEYHebrewPe* = 0x00000CF4
  KEYHebrewFinalzade* = 0x00000CF5
  KEYHebrewFinalzadi* = 0x00000CF5
  KEYHebrewZade* = 0x00000CF6
  KEYHebrewZadi* = 0x00000CF6
  KEYHebrewQoph* = 0x00000CF7
  KEYHebrewKuf* = 0x00000CF7
  KEYHebrewResh* = 0x00000CF8
  KEYHebrewShin* = 0x00000CF9
  KEYHebrewTaw* = 0x00000CFA
  KEYHebrewTaf* = 0x00000CFA
  KEYHebrewSwitch* = 0x0000FF7E
  KEYThaiKokai* = 0x00000DA1
  KEYThaiKhokhai* = 0x00000DA2
  KEYThaiKhokhuat* = 0x00000DA3
  KEYThaiKhokhwai* = 0x00000DA4
  KEYThaiKhokhon* = 0x00000DA5
  KEYThaiKhorakhang* = 0x00000DA6
  KEYThaiNgongu* = 0x00000DA7
  KEYThaiChochan* = 0x00000DA8
  KEYThaiChoching* = 0x00000DA9
  KEYThaiChochang* = 0x00000DAA
  KEYThaiSoso* = 0x00000DAB
  KEYThaiChochoe* = 0x00000DAC
  KEYThaiYoying* = 0x00000DAD
  KEYThaiDochada* = 0x00000DAE
  KEYThaiTopatak* = 0x00000DAF
  KEYThaiThothan* = 0x00000DB0
  KEYThaiThonangmontho* = 0x00000DB1
  KEYThaiThophuthao* = 0x00000DB2
  KEYThaiNonen* = 0x00000DB3
  KEYThaiDodek* = 0x00000DB4
  KEYThaiTotao* = 0x00000DB5
  KEYThaiThothung* = 0x00000DB6
  KEYThaiThothahan* = 0x00000DB7
  KEYThaiThothong* = 0x00000DB8
  KEYThaiNonu* = 0x00000DB9
  KEYThaiBobaimai* = 0x00000DBA
  KEYThaiPopla* = 0x00000DBB
  KEYThaiPhophung* = 0x00000DBC
  KEYThaiFofa* = 0x00000DBD
  KEYThaiPhophan* = 0x00000DBE
  KEYThaiFofan* = 0x00000DBF
  KEYThaiPhosamphao* = 0x00000DC0
  KEYThaiMoma* = 0x00000DC1
  KEYThaiYoyak* = 0x00000DC2
  KEYThaiRorua* = 0x00000DC3
  KEYThaiRu* = 0x00000DC4
  KEYThaiLoling* = 0x00000DC5
  KEYThaiLu* = 0x00000DC6
  KEYThaiWowaen* = 0x00000DC7
  KEYThaiSosala* = 0x00000DC8
  KEYThaiSorusi* = 0x00000DC9
  KEYThaiSosua* = 0x00000DCA
  KEYThaiHohip* = 0x00000DCB
  KEYThaiLochula* = 0x00000DCC
  KEYThaiOang* = 0x00000DCD
  KEYThaiHonokhuk* = 0x00000DCE
  KEYThaiPaiyannoi* = 0x00000DCF
  KEYThaiSaraa* = 0x00000DD0
  KEYThaiMaihanakat* = 0x00000DD1
  KEYThaiSaraaa* = 0x00000DD2
  KEYThaiSaraam* = 0x00000DD3
  KEYThaiSarai* = 0x00000DD4
  KEYThaiSaraii* = 0x00000DD5
  KEYThaiSaraue* = 0x00000DD6
  KEYThaiSarauee* = 0x00000DD7
  KEYThaiSarau* = 0x00000DD8
  KEYThaiSarauu* = 0x00000DD9
  KEYThaiPhinthu* = 0x00000DDA
  KEYThaiMaihanakatMaitho* = 0x00000DDE
  KEYThaiBaht* = 0x00000DDF
  KEYThaiSarae* = 0x00000DE0
  KEYThaiSaraae* = 0x00000DE1
  KEYThaiSarao* = 0x00000DE2
  KEYThaiSaraaimaimuan* = 0x00000DE3
  KEYThaiSaraaimaimalai* = 0x00000DE4
  KEYThaiLakkhangyao* = 0x00000DE5
  KEYThaiMaiyamok* = 0x00000DE6
  KEYThaiMaitaikhu* = 0x00000DE7
  KEYThaiMaiek* = 0x00000DE8
  KEYThaiMaitho* = 0x00000DE9
  KEYThaiMaitri* = 0x00000DEA
  KEYThaiMaichattawa* = 0x00000DEB
  KEYThaiThanthakhat* = 0x00000DEC
  KEYThaiNikhahit* = 0x00000DED
  KEYThaiLeksun* = 0x00000DF0
  KEYThaiLeknung* = 0x00000DF1
  KEYThaiLeksong* = 0x00000DF2
  KEYThaiLeksam* = 0x00000DF3
  KEYThaiLeksi* = 0x00000DF4
  KEYThaiLekha* = 0x00000DF5
  KEYThaiLekhok* = 0x00000DF6
  KEYThaiLekchet* = 0x00000DF7
  KEYThaiLekpaet* = 0x00000DF8
  KEYThaiLekkao* = 0x00000DF9
  KEYHangul* = 0x0000FF31
  KEYHangulStart* = 0x0000FF32
  KEYHangulEnd* = 0x0000FF33
  KEYHangulHanja* = 0x0000FF34
  KEYHangulJamo* = 0x0000FF35
  KEYHangulRomaja* = 0x0000FF36
  KEYHangulCodeinput* = 0x0000FF37
  KEYHangulJeonja* = 0x0000FF38
  KEYHangulBanja* = 0x0000FF39
  KEYHangulPreHanja* = 0x0000FF3A
  KEYHangulPostHanja* = 0x0000FF3B
  KEYHangulSingleCandidate* = 0x0000FF3C
  KEYHangulMultipleCandidate* = 0x0000FF3D
  KEYHangulPreviousCandidate* = 0x0000FF3E
  KEYHangulSpecial* = 0x0000FF3F
  KEYHangulSwitch* = 0x0000FF7E
  KEYHangulKiyeog* = 0x00000EA1
  KEYHangulSsangKiyeog* = 0x00000EA2
  KEYHangulKiyeogSios* = 0x00000EA3
  KEYHangulNieun* = 0x00000EA4
  KEYHangulNieunJieuj* = 0x00000EA5
  KEYHangulNieunHieuh* = 0x00000EA6
  KEYHangulDikeud* = 0x00000EA7
  KEYHangulSsangDikeud* = 0x00000EA8
  KEYHangulRieul* = 0x00000EA9
  KEYHangulRieulKiyeog* = 0x00000EAA
  KEYHangulRieulMieum* = 0x00000EAB
  KEYHangulRieulPieub* = 0x00000EAC
  KEYHangulRieulSios* = 0x00000EAD
  KEYHangulRieulTieut* = 0x00000EAE
  KEYHangulRieulPhieuf* = 0x00000EAF
  KEYHangulRieulHieuh* = 0x00000EB0
  KEYHangulMieum* = 0x00000EB1
  KEYHangulPieub* = 0x00000EB2
  KEYHangulSsangPieub* = 0x00000EB3
  KEYHangulPieubSios* = 0x00000EB4
  KEYHangulSios* = 0x00000EB5
  KEYHangulSsangSios* = 0x00000EB6
  KEYHangulIeung* = 0x00000EB7
  KEYHangulJieuj* = 0x00000EB8
  KEYHangulSsangJieuj* = 0x00000EB9
  KEYHangulCieuc* = 0x00000EBA
  KEYHangulKhieuq* = 0x00000EBB
  KEYHangulTieut* = 0x00000EBC
  KEYHangulPhieuf* = 0x00000EBD
  KEYHangulHieuh* = 0x00000EBE
  KEYHangulA* = 0x00000EBF
  KEYHangulAE* = 0x00000EC0
  KEYHangulYA* = 0x00000EC1
  KEYHangulYAE* = 0x00000EC2
  KEYHangulEO* = 0x00000EC3
  KEYHangulE* = 0x00000EC4
  KEYHangulYEO* = 0x00000EC5
  KEYHangulYE* = 0x00000EC6
  KEYHangulO* = 0x00000EC7
  KEYHangulWA* = 0x00000EC8
  KEYHangulWAE* = 0x00000EC9
  KEYHangulOE* = 0x00000ECA
  KEYHangulYO* = 0x00000ECB
  KEYHangulU* = 0x00000ECC
  KEYHangulWEO* = 0x00000ECD
  KEYHangulWE* = 0x00000ECE
  KEYHangulWI* = 0x00000ECF
  KEYHangulYU* = 0x00000ED0
  KEYHangulEU* = 0x00000ED1
  KEYHangulYI* = 0x00000ED2
  KEYHangulI* = 0x00000ED3
  KEYHangulJKiyeog* = 0x00000ED4
  KEYHangulJSsangKiyeog* = 0x00000ED5
  KEYHangulJKiyeogSios* = 0x00000ED6
  KEYHangulJNieun* = 0x00000ED7
  KEYHangulJNieunJieuj* = 0x00000ED8
  KEYHangulJNieunHieuh* = 0x00000ED9
  KEYHangulJDikeud* = 0x00000EDA
  KEYHangulJRieul* = 0x00000EDB
  KEYHangulJRieulKiyeog* = 0x00000EDC
  KEYHangulJRieulMieum* = 0x00000EDD
  KEYHangulJRieulPieub* = 0x00000EDE
  KEYHangulJRieulSios* = 0x00000EDF
  KEYHangulJRieulTieut* = 0x00000EE0
  KEYHangulJRieulPhieuf* = 0x00000EE1
  KEYHangulJRieulHieuh* = 0x00000EE2
  KEYHangulJMieum* = 0x00000EE3
  KEYHangulJPieub* = 0x00000EE4
  KEYHangulJPieubSios* = 0x00000EE5
  KEYHangulJSios* = 0x00000EE6
  KEYHangulJSsangSios* = 0x00000EE7
  KEYHangulJIeung* = 0x00000EE8
  KEYHangulJJieuj* = 0x00000EE9
  KEYHangulJCieuc* = 0x00000EEA
  KEYHangulJKhieuq* = 0x00000EEB
  KEYHangulJTieut* = 0x00000EEC
  KEYHangulJPhieuf* = 0x00000EED
  KEYHangulJHieuh* = 0x00000EEE
  KEYHangulRieulYeorinHieuh* = 0x00000EEF
  KEYHangulSunkyeongeumMieum* = 0x00000EF0
  KEYHangulSunkyeongeumPieub* = 0x00000EF1
  KEYHangulPanSios* = 0x00000EF2
  KEYHangulKkogjiDalrinIeung* = 0x00000EF3
  KEYHangulSunkyeongeumPhieuf* = 0x00000EF4
  KEYHangulYeorinHieuh* = 0x00000EF5
  KEYHangulAraeA* = 0x00000EF6
  KEYHangulAraeAE* = 0x00000EF7
  KEYHangulJPanSios* = 0x00000EF8
  KEYHangulJKkogjiDalrinIeung* = 0x00000EF9
  KEYHangulJYeorinHieuh* = 0x00000EFA
  KEYKoreanWon* = 0x00000EFF
  KEYEcuSign* = 0x000020A0
  KEYColonSign* = 0x000020A1
  KEYCruzeiroSign* = 0x000020A2
  KEYFFrancSign* = 0x000020A3
  KEYLiraSign* = 0x000020A4
  KEYMillSign* = 0x000020A5
  KEYNairaSign* = 0x000020A6
  KEYPesetaSign* = 0x000020A7
  KEYRupeeSign* = 0x000020A8
  KEYWonSign* = 0x000020A9
  KEYNewSheqelSign* = 0x000020AA
  KEYDongSign* = 0x000020AB
  KEYEuroSign* = 0x000020AC

proc pangoContextGetForScreen*(screen: PScreen): PContext{.cdecl, 
    dynlib: lib, importc: "gdk_pango_context_get_for_screen".}
proc pangoContextSetColormap*(context: PContext, colormap: PColormap){.
    cdecl, dynlib: lib, importc: "gdk_pango_context_set_colormap".}
proc pangoLayoutLineGetClipRegion*(line: PLayoutLine, x_origin: gint, 
                                        y_origin: Gint, index_ranges: Pgint, 
                                        n_ranges: Gint): PRegion{.cdecl, 
    dynlib: lib, importc: "gdk_pango_layout_line_get_clip_region".}
proc pangoLayoutGetClipRegion*(layout: PLayout, x_origin: Gint, 
                                   y_origin: Gint, index_ranges: Pgint, 
                                   n_ranges: Gint): PRegion{.cdecl, dynlib: lib, 
    importc: "gdk_pango_layout_get_clip_region".}
proc pangoAttrStippleNew*(stipple: PBitmap): PAttribute{.cdecl, 
    dynlib: lib, importc: "gdk_pango_attr_stipple_new".}
proc pangoAttrEmbossedNew*(embossed: Gboolean): PAttribute{.cdecl, 
    dynlib: lib, importc: "gdk_pango_attr_embossed_new".}
proc renderThresholdAlpha*(pixbuf: PPixbuf, bitmap: PBitmap, 
                                    src_x: Int32, src_y: Int32, dest_x: Int32, 
                                    dest_y: Int32, width: Int32, height: Int32, 
                                    alpha_threshold: Int32){.cdecl, dynlib: lib, 
    importc: "gdk_pixbuf_render_threshold_alpha".}
proc renderToDrawable*(pixbuf: PPixbuf, drawable: PDrawable, gc: Pgc, 
                                src_x: Int32, src_y: Int32, dest_x: Int32, 
                                dest_y: Int32, width: Int32, height: Int32, 
                                dither: TRgbDither, x_dither: Int32, 
                                y_dither: Int32){.cdecl, dynlib: lib, 
    importc: "gdk_pixbuf_render_to_drawable".}
proc renderToDrawableAlpha*(pixbuf: PPixbuf, drawable: PDrawable, 
                                      src_x: Int32, src_y: Int32, dest_x: Int32, 
                                      dest_y: Int32, width: Int32, 
                                      height: Int32, 
                                      alpha_mode: TPixbufAlphaMode, 
                                      alpha_threshold: Int32, 
                                      dither: TRgbDither, x_dither: Int32, 
                                      y_dither: Int32){.cdecl, dynlib: lib, 
    importc: "gdk_pixbuf_render_to_drawable_alpha".}
proc renderPixmapAndMaskForColormap*(pixbuf: PPixbuf, 
    colormap: PColormap, n: var PPixmap, nasdfdsafw4e: var PBitmap, 
    alpha_threshold: Int32){.cdecl, dynlib: lib, importc: "gdk_pixbuf_render_pixmap_and_mask_for_colormap".}
proc getFromDrawable*(dest: PPixbuf, src: PDrawable, cmap: PColormap, 
                               src_x: Int32, src_y: Int32, dest_x: Int32, 
                               dest_y: Int32, width: Int32, height: Int32): PPixbuf{.
    cdecl, dynlib: lib, importc: "gdk_pixbuf_get_from_drawable".}
proc getFromImage*(dest: PPixbuf, src: PImage, cmap: PColormap, 
                            src_x: Int32, src_y: Int32, dest_x: Int32, 
                            dest_y: Int32, width: Int32, height: Int32): PPixbuf{.
    cdecl, dynlib: lib, importc: "gdk_pixbuf_get_from_image".}
proc typePixmap*(): GType
proc pixmap*(anObject: Pointer): PPixmap
proc pixmapClass*(klass: Pointer): PPixmapObjectClass
proc isPixmap*(anObject: Pointer): Bool
proc isPixmapClass*(klass: Pointer): Bool
proc pixmapGetClass*(obj: Pointer): PPixmapObjectClass
proc pixmapObject*(anObject: Pointer): PPixmapObject
proc pixmapGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "gdk_pixmap_get_type".}
proc pixmapNew*(window: PWindow, width: Gint, height: Gint, depth: Gint): PPixmap{.
    cdecl, dynlib: lib, importc: "gdk_pixmap_new".}
proc bitmapCreateFromData*(window: PWindow, data: Cstring, width: Gint, 
                              height: Gint): PBitmap{.cdecl, dynlib: lib, 
    importc: "gdk_bitmap_create_from_data".}
proc pixmapCreateFromData*(window: PWindow, data: Cstring, width: Gint, 
                              height: Gint, depth: Gint, fg: PColor, bg: PColor): PPixmap{.
    cdecl, dynlib: lib, importc: "gdk_pixmap_create_from_data".}
proc pixmapCreateFromXpm*(window: PWindow, k: var PBitmap, 
                             transparent_color: PColor, filename: Cstring): PPixmap{.
    cdecl, dynlib: lib, importc: "gdk_pixmap_create_from_xpm".}
proc pixmapColormapCreateFromXpm*(window: PWindow, colormap: PColormap, 
                                      k: var PBitmap, transparent_color: PColor, 
                                      filename: Cstring): PPixmap{.cdecl, 
    dynlib: lib, importc: "gdk_pixmap_colormap_create_from_xpm".}
proc pixmapCreateFromXpmD*(window: PWindow, k: var PBitmap, 
                               transparent_color: PColor, data: PPgchar): PPixmap{.
    cdecl, dynlib: lib, importc: "gdk_pixmap_create_from_xpm_d".}
proc pixmapColormapCreateFromXpmD*(window: PWindow, colormap: PColormap, 
                                        k: var PBitmap, 
                                        transparent_color: PColor, data: PPgchar): PPixmap{.
    cdecl, dynlib: lib, importc: "gdk_pixmap_colormap_create_from_xpm_d".}
proc pixmapForeignNewForDisplay*(display: PDisplay, anid: TNativeWindow): PPixmap{.
    cdecl, dynlib: lib, importc: "gdk_pixmap_foreign_new_for_display".}
proc pixmapLookupForDisplay*(display: PDisplay, anid: TNativeWindow): PPixmap{.
    cdecl, dynlib: lib, importc: "gdk_pixmap_lookup_for_display".}
proc atomIntern*(atom_name: Cstring, only_if_exists: Gboolean): TAtom{.cdecl, 
    dynlib: lib, importc: "gdk_atom_intern".}
proc atomName*(atom: TAtom): Cstring{.cdecl, dynlib: lib, 
                                       importc: "gdk_atom_name".}
proc propertyGet*(window: PWindow, `property`: TAtom, `type`: TAtom, 
                   offset: Gulong, length: Gulong, pdelete: Gint, 
                   actual_property_type: PAtom, actual_format: Pgint, 
                   actual_length: Pgint, data: PPguchar): Gboolean{.cdecl, 
    dynlib: lib, importc: "gdk_property_get".}
proc propertyChange*(window: PWindow, `property`: TAtom, `type`: TAtom, 
                      format: Gint, mode: TPropMode, data: Pguchar, 
                      nelements: Gint){.cdecl, dynlib: lib, 
                                        importc: "gdk_property_change".}
proc propertyDelete*(window: PWindow, `property`: TAtom){.cdecl, dynlib: lib, 
    importc: "gdk_property_delete".}
proc textPropertyToTextListForDisplay*(display: PDisplay, encoding: TAtom, 
    format: Gint, text: Pguchar, length: Gint, t: var PPgchar): Gint{.cdecl, 
    dynlib: lib, importc: "gdk_text_property_to_text_list_for_display".}
proc textPropertyToUtf8ListForDisplay*(display: PDisplay, encoding: TAtom, 
    format: Gint, text: Pguchar, length: Gint, t: var PPgchar): Gint{.cdecl, 
    dynlib: lib, importc: "gdk_text_property_to_utf8_list_for_display".}
proc utf8ToStringTarget*(str: Cstring): Cstring{.cdecl, dynlib: lib, 
    importc: "gdk_utf8_to_string_target".}
proc stringToCompoundTextForDisplay*(display: PDisplay, str: Cstring, 
    encoding: PAtom, format: Pgint, ctext: PPguchar, length: Pgint): Gint{.
    cdecl, dynlib: lib, importc: "gdk_string_to_compound_text_for_display".}
proc utf8ToCompoundTextForDisplay*(display: PDisplay, str: Cstring, 
                                        encoding: PAtom, format: Pgint, 
                                        ctext: PPguchar, length: Pgint): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_utf8_to_compound_text_for_display".}
proc freeTextList*(list: PPgchar){.cdecl, dynlib: lib, 
                                     importc: "gdk_free_text_list".}
proc freeCompoundText*(ctext: Pguchar){.cdecl, dynlib: lib, 
    importc: "gdk_free_compound_text".}
proc regionNew*(): PRegion{.cdecl, dynlib: lib, importc: "gdk_region_new".}
proc regionPolygon*(points: PPoint, npoints: Gint, fill_rule: TFillRule): PRegion{.
    cdecl, dynlib: lib, importc: "gdk_region_polygon".}
proc copy*(region: PRegion): PRegion{.cdecl, dynlib: lib, 
    importc: "gdk_region_copy".}
proc regionRectangle*(rectangle: PRectangle): PRegion{.cdecl, dynlib: lib, 
    importc: "gdk_region_rectangle".}
proc destroy*(region: PRegion){.cdecl, dynlib: lib, 
                                       importc: "gdk_region_destroy".}
proc getClipbox*(region: PRegion, rectangle: PRectangle){.cdecl, 
    dynlib: lib, importc: "gdk_region_get_clipbox".}
proc getRectangles*(region: PRegion, s: var PRectangle, 
                            n_rectangles: Pgint){.cdecl, dynlib: lib, 
    importc: "gdk_region_get_rectangles".}
proc empty*(region: PRegion): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_region_empty".}
proc equal*(region1: PRegion, region2: PRegion): Gboolean{.cdecl, 
    dynlib: lib, importc: "gdk_region_equal".}
proc pointIn*(region: PRegion, x: Int32, y: Int32): Gboolean{.cdecl, 
    dynlib: lib, importc: "gdk_region_point_in".}
proc rectIn*(region: PRegion, rect: PRectangle): TOverlapType{.cdecl, 
    dynlib: lib, importc: "gdk_region_rect_in".}
proc offset*(region: PRegion, dx: Gint, dy: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_region_offset".}
proc shrink*(region: PRegion, dx: Gint, dy: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_region_shrink".}
proc union*(region: PRegion, rect: PRectangle){.cdecl, 
    dynlib: lib, importc: "gdk_region_union_with_rect".}
proc intersect*(source1: PRegion, source2: PRegion){.cdecl, dynlib: lib, 
    importc: "gdk_region_intersect".}
proc union*(source1: PRegion, source2: PRegion){.cdecl, dynlib: lib, 
    importc: "gdk_region_union".}
proc subtract*(source1: PRegion, source2: PRegion){.cdecl, dynlib: lib, 
    importc: "gdk_region_subtract".}
proc `xor`*(source1: PRegion, source2: PRegion){.cdecl, dynlib: lib, 
    importc: "gdk_region_xor".}
proc spansIntersectForeach*(region: PRegion, spans: PSpan, 
                                     n_spans: Int32, sorted: Gboolean, 
                                     `function`: TSpanFunc, data: Gpointer){.
    cdecl, dynlib: lib, importc: "gdk_region_spans_intersect_foreach".}
proc rgbFindColor*(colormap: PColormap, color: PColor){.cdecl, dynlib: lib, 
    importc: "gdk_rgb_find_color".}
proc rgbImage*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint, 
                     width: Gint, height: Gint, dith: TRgbDither, 
                     rgb_buf: Pguchar, rowstride: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_draw_rgb_image".}
proc rgbImageDithalign*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint, 
                               width: Gint, height: Gint, dith: TRgbDither, 
                               rgb_buf: Pguchar, rowstride: Gint, xdith: Gint, 
                               ydith: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_draw_rgb_image_dithalign".}
proc rgb32Image*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint, 
                        width: Gint, height: Gint, dith: TRgbDither, 
                        buf: Pguchar, rowstride: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_draw_rgb_32_image".}
proc rgb32ImageDithalign*(drawable: PDrawable, gc: Pgc, x: Gint, 
                                  y: Gint, width: Gint, height: Gint, 
                                  dith: TRgbDither, buf: Pguchar, 
                                  rowstride: Gint, xdith: Gint, ydith: Gint){.
    cdecl, dynlib: lib, importc: "gdk_draw_rgb_32_image_dithalign".}
proc grayImage*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint, 
                      width: Gint, height: Gint, dith: TRgbDither, buf: Pguchar, 
                      rowstride: Gint){.cdecl, dynlib: lib, 
                                        importc: "gdk_draw_gray_image".}
proc indexedImage*(drawable: PDrawable, gc: Pgc, x: Gint, y: Gint, 
                         width: Gint, height: Gint, dith: TRgbDither, 
                         buf: Pguchar, rowstride: Gint, cmap: PRgbCmap){.cdecl, 
    dynlib: lib, importc: "gdk_draw_indexed_image".}
proc rgbCmapNew*(colors: Pguint32, n_colors: Gint): PRgbCmap{.cdecl, 
    dynlib: lib, importc: "gdk_rgb_cmap_new".}
proc free*(cmap: PRgbCmap){.cdecl, dynlib: lib, 
                                     importc: "gdk_rgb_cmap_free".}
proc rgbSetVerbose*(verbose: Gboolean){.cdecl, dynlib: lib, 
    importc: "gdk_rgb_set_verbose".}
proc rgbSetInstall*(install: Gboolean){.cdecl, dynlib: lib, 
    importc: "gdk_rgb_set_install".}
proc rgbSetMinColors*(min_colors: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_rgb_set_min_colors".}
proc typeDisplay*(): GType
proc displayObject*(anObject: Pointer): PDisplay
proc displayClass*(klass: Pointer): PDisplayClass
proc isDisplay*(anObject: Pointer): Bool
proc isDisplayClass*(klass: Pointer): Bool
proc displayGetClass*(obj: Pointer): PDisplayClass
proc displayOpen*(display_name: Cstring): PDisplay{.cdecl, dynlib: lib, 
    importc: "gdk_display_open".}
proc getName*(display: PDisplay): Cstring{.cdecl, dynlib: lib, 
    importc: "gdk_display_get_name".}
proc getNScreens*(display: PDisplay): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_display_get_n_screens".}
proc getScreen*(display: PDisplay, screen_num: Gint): PScreen{.cdecl, 
    dynlib: lib, importc: "gdk_display_get_screen".}
proc getDefaultScreen*(display: PDisplay): PScreen{.cdecl, 
    dynlib: lib, importc: "gdk_display_get_default_screen".}
proc pointerUngrab*(display: PDisplay, time: Guint32){.cdecl, 
    dynlib: lib, importc: "gdk_display_pointer_ungrab".}
proc keyboardUngrab*(display: PDisplay, time: Guint32){.cdecl, 
    dynlib: lib, importc: "gdk_display_keyboard_ungrab".}
proc pointerIsGrabbed*(display: PDisplay): Gboolean{.cdecl, 
    dynlib: lib, importc: "gdk_display_pointer_is_grabbed".}
proc beep*(display: PDisplay){.cdecl, dynlib: lib, 
                                       importc: "gdk_display_beep".}
proc sync*(display: PDisplay){.cdecl, dynlib: lib, 
                                       importc: "gdk_display_sync".}
proc close*(display: PDisplay){.cdecl, dynlib: lib, 
                                        importc: "gdk_display_close".}
proc listDevices*(display: PDisplay): PGList{.cdecl, dynlib: lib, 
    importc: "gdk_display_list_devices".}
proc getEvent*(display: PDisplay): PEvent{.cdecl, dynlib: lib, 
    importc: "gdk_display_get_event".}
proc peekEvent*(display: PDisplay): PEvent{.cdecl, dynlib: lib, 
    importc: "gdk_display_peek_event".}
proc putEvent*(display: PDisplay, event: PEvent){.cdecl, dynlib: lib, 
    importc: "gdk_display_put_event".}
proc addClientMessageFilter*(display: PDisplay, message_type: TAtom, 
                                        func: TFilterFunc, data: Gpointer){.
    cdecl, dynlib: lib, importc: "gdk_display_add_client_message_filter".}
proc setDoubleClickTime*(display: PDisplay, msec: Guint){.cdecl, 
    dynlib: lib, importc: "gdk_display_set_double_click_time".}
proc setSmClientId*(display: PDisplay, sm_client_id: Cstring){.cdecl, 
    dynlib: lib, importc: "gdk_display_set_sm_client_id".}
proc setDefaultDisplay*(display: PDisplay){.cdecl, dynlib: lib, 
    importc: "gdk_set_default_display".}
proc getDefaultDisplay*(): PDisplay{.cdecl, dynlib: lib, 
                                       importc: "gdk_get_default_display".}
proc typeScreen*(): GType
proc screen*(anObject: Pointer): PScreen
proc screenClass*(klass: Pointer): PScreenClass
proc isScreen*(anObject: Pointer): Bool
proc isScreenClass*(klass: Pointer): Bool
proc screenGetClass*(obj: Pointer): PScreenClass
proc getDefaultColormap*(screen: PScreen): PColormap{.cdecl, 
    dynlib: lib, importc: "gdk_screen_get_default_colormap".}
proc setDefaultColormap*(screen: PScreen, colormap: PColormap){.cdecl, 
    dynlib: lib, importc: "gdk_screen_set_default_colormap".}
proc getSystemColormap*(screen: PScreen): PColormap{.cdecl, 
    dynlib: lib, importc: "gdk_screen_get_system_colormap".}
proc getSystemVisual*(screen: PScreen): PVisual{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_system_visual".}
proc getRgbColormap*(screen: PScreen): PColormap{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_rgb_colormap".}
proc getRgbVisual*(screen: PScreen): PVisual{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_rgb_visual".}
proc getRootWindow*(screen: PScreen): PWindow{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_root_window".}
proc getDisplay*(screen: PScreen): PDisplay{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_display".}
proc getNumber*(screen: PScreen): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_number".}
proc getWindowAtPointer*(screen: PScreen, win_x: Pgint, win_y: Pgint): PWindow{.
    cdecl, dynlib: lib, importc: "gdk_screen_get_window_at_pointer".}
proc getWidth*(screen: PScreen): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_width".}
proc getHeight*(screen: PScreen): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_height".}
proc getWidthMm*(screen: PScreen): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_width_mm".}
proc getHeightMm*(screen: PScreen): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_height_mm".}
proc close*(screen: PScreen){.cdecl, dynlib: lib, 
                                     importc: "gdk_screen_close".}
proc listVisuals*(screen: PScreen): PGList{.cdecl, dynlib: lib, 
    importc: "gdk_screen_list_visuals".}
proc getToplevelWindows*(screen: PScreen): PGList{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_toplevel_windows".}
proc getNMonitors*(screen: PScreen): Gint{.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_n_monitors".}
proc getMonitorGeometry*(screen: PScreen, monitor_num: Gint, 
                                  dest: PRectangle){.cdecl, dynlib: lib, 
    importc: "gdk_screen_get_monitor_geometry".}
proc getMonitorAtPoint*(screen: PScreen, x: Gint, y: Gint): Gint{.
    cdecl, dynlib: lib, importc: "gdk_screen_get_monitor_at_point".}
proc getMonitorAtWindow*(screen: PScreen, window: PWindow): Gint{.
    cdecl, dynlib: lib, importc: "gdk_screen_get_monitor_at_window".}
proc broadcastClientMessage*(screen: PScreen, event: PEvent){.cdecl, 
    dynlib: lib, importc: "gdk_screen_broadcast_client_message".}
proc getDefaultScreen*(): PScreen{.cdecl, dynlib: lib, 
                                     importc: "gdk_get_default_screen".}
proc getSetting*(screen: PScreen, name: Cstring, value: PGValue): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_screen_get_setting".}
proc selectionPrimary*(): TAtom
proc selectionSecondary*(): TAtom
proc selectionClipboard*(): TAtom
proc targetBitmap*(): TAtom
proc targetColormap*(): TAtom
proc targetDrawable*(): TAtom
proc targetPixmap*(): TAtom
proc targetString*(): TAtom
proc selectionTypeAtom*(): TAtom
proc selectionTypeBitmap*(): TAtom
proc selectionTypeColormap*(): TAtom
proc selectionTypeDrawable*(): TAtom
proc selectionTypeInteger*(): TAtom
proc selectionTypePixmap*(): TAtom
proc selectionTypeWindow*(): TAtom
proc selectionTypeString*(): TAtom
proc selectionOwnerSetForDisplay*(display: PDisplay, owner: PWindow, 
                                      selection: TAtom, time: Guint32, 
                                      send_event: Gboolean): Gboolean{.cdecl, 
    dynlib: lib, importc: "gdk_selection_owner_set_for_display".}
proc selectionOwnerGetForDisplay*(display: PDisplay, selection: TAtom): PWindow{.
    cdecl, dynlib: lib, importc: "gdk_selection_owner_get_for_display".}
proc selectionConvert*(requestor: PWindow, selection: TAtom, target: TAtom, 
                        time: Guint32){.cdecl, dynlib: lib, 
                                        importc: "gdk_selection_convert".}
proc selectionPropertyGet*(requestor: PWindow, data: PPguchar, 
                             prop_type: PAtom, prop_format: Pgint): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_selection_property_get".}
proc selectionSendNotifyForDisplay*(display: PDisplay, requestor: Guint32, 
                                        selection: TAtom, target: TAtom, 
                                        `property`: TAtom, time: Guint32){.
    cdecl, dynlib: lib, importc: "gdk_selection_send_notify_for_display".}
const 
  CurrentTime* = 0
  ParentRelative* = 1
  Ok* = 0
  Error* = - (1)
  ErrorParam* = - (2)
  ErrorFile* = - (3)
  ErrorMem* = - (4)
  ShiftMask* = 1 shl 0
  LockMask* = 1 shl 1
  ControlMask* = 1 shl 2
  Mod1Mask* = 1 shl 3
  Mod2Mask* = 1 shl 4
  Mod3Mask* = 1 shl 5
  Mod4Mask* = 1 shl 6
  Mod5Mask* = 1 shl 7
  Button1Mask* = 1 shl 8
  Button2Mask* = 1 shl 9
  Button3Mask* = 1 shl 10
  Button4Mask* = 1 shl 11
  Button5Mask* = 1 shl 12
  ReleaseMask* = 1 shl 30
  ModifierMask* = ord(RELEASE_MASK) or 0x00001FFF
  InputRead* = 1 shl 0
  InputWrite* = 1 shl 1
  InputException* = 1 shl 2
  GrabSuccess* = 0
  GrabAlreadyGrabbed* = 1
  GrabInvalidTime* = 2
  GrabNotViewable* = 3
  GrabFrozen* = 4

proc atomToPointer*(atom: TAtom): Pointer
proc pointerToAtom*(p: Pointer): TAtom
proc `makeAtom`*(val: Guint): TAtom
proc none*(): TAtom
proc typeVisual*(): GType
proc visual*(anObject: Pointer): PVisual
proc visualClass*(klass: Pointer): PVisualClass
proc isVisual*(anObject: Pointer): Bool
proc isVisualClass*(klass: Pointer): Bool
proc visualGetClass*(obj: Pointer): PVisualClass
proc visualGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "gdk_visual_get_type".}
const 
  WaTitle* = 1 shl 1
  WaX* = 1 shl 2
  WaY* = 1 shl 3
  WaCursor* = 1 shl 4
  WaColormap* = 1 shl 5
  WaVisual* = 1 shl 6
  WaWmclass* = 1 shl 7
  WaNoredir* = 1 shl 8
  HintPos* = 1 shl 0
  HintMinSize* = 1 shl 1
  HintMaxSize* = 1 shl 2
  HintBaseSize* = 1 shl 3
  HintAspect* = 1 shl 4
  HintResizeInc* = 1 shl 5
  HintWinGravity* = 1 shl 6
  HintUserPos* = 1 shl 7
  HintUserSize* = 1 shl 8
  DecorAll* = 1 shl 0
  DecorBorder* = 1 shl 1
  DecorResizeh* = 1 shl 2
  DecorTitle* = 1 shl 3
  DecorMenu* = 1 shl 4
  DecorMinimize* = 1 shl 5
  DecorMaximize* = 1 shl 6
  FuncAll* = 1 shl 0
  FuncResize* = 1 shl 1
  FuncMove* = 1 shl 2
  FuncMinimize* = 1 shl 3
  FuncMaximize* = 1 shl 4
  FuncClose* = 1 shl 5
  GravityNorthWest* = 1
  GravityNorth* = 2
  GravityNorthEast* = 3
  GravityWest* = 4
  GravityCenter* = 5
  GravityEast* = 6
  GravitySouthWest* = 7
  GravitySouth* = 8
  GravitySouthEast* = 9
  GravityStatic* = 10

proc typeWindow*(): GType
proc window*(anObject: Pointer): PWindow
proc windowClass*(klass: Pointer): PWindowObjectClass
proc isWindow*(anObject: Pointer): Bool
proc isWindowClass*(klass: Pointer): Bool
proc windowGetClass*(obj: Pointer): PWindowObjectClass
proc windowObject*(anObject: Pointer): PWindowObject
const 
  bmTWindowObjectGuffawGravity* = 0x0001'i16
  bpTWindowObjectGuffawGravity* = 0'i16
  bmTWindowObjectInputOnly* = 0x0002'i16
  bpTWindowObjectInputOnly* = 1'i16
  bmTWindowObjectModalHint* = 0x0004'i16
  bpTWindowObjectModalHint* = 2'i16
  bmTWindowObjectDestroyed* = 0x0018'i16
  bpTWindowObjectDestroyed* = 3'i16

proc windowObjectGuffawGravity*(a: PWindowObject): Guint
proc windowObjectSetGuffawGravity*(a: PWindowObject, 
                                      `guffaw_gravity`: Guint)
proc windowObjectInputOnly*(a: PWindowObject): Guint
proc windowObjectSetInputOnly*(a: PWindowObject, `input_only`: Guint)
proc windowObjectModalHint*(a: PWindowObject): Guint
proc windowObjectSetModalHint*(a: PWindowObject, `modal_hint`: Guint)
proc windowObjectDestroyed*(a: PWindowObject): Guint
proc windowObjectSetDestroyed*(a: PWindowObject, `destroyed`: Guint)
proc windowObjectGetType*(): GType{.cdecl, dynlib: lib, 
                                       importc: "gdk_window_object_get_type".}
proc new*(parent: PWindow, attributes: PWindowAttr, attributes_mask: Gint): PWindow{.
    cdecl, dynlib: lib, importc: "gdk_window_new".}
proc destroy*(window: PWindow){.cdecl, dynlib: lib, 
                                       importc: "gdk_window_destroy".}
proc getWindowType*(window: PWindow): TWindowType{.cdecl, dynlib: lib, 
    importc: "gdk_window_get_window_type".}
proc windowAtPointer*(win_x: Pgint, win_y: Pgint): PWindow{.cdecl, 
    dynlib: lib, importc: "gdk_window_at_pointer".}
proc show*(window: PWindow){.cdecl, dynlib: lib, 
                                    importc: "gdk_window_show".}
proc hide*(window: PWindow){.cdecl, dynlib: lib, 
                                    importc: "gdk_window_hide".}
proc withdraw*(window: PWindow){.cdecl, dynlib: lib, 
                                        importc: "gdk_window_withdraw".}
proc showUnraised*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_show_unraised".}
proc move*(window: PWindow, x: Gint, y: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_window_move".}
proc resize*(window: PWindow, width: Gint, height: Gint){.cdecl, 
    dynlib: lib, importc: "gdk_window_resize".}
proc moveResize*(window: PWindow, x: Gint, y: Gint, width: Gint, 
                         height: Gint){.cdecl, dynlib: lib, 
                                        importc: "gdk_window_move_resize".}
proc reparent*(window: PWindow, new_parent: PWindow, x: Gint, y: Gint){.
    cdecl, dynlib: lib, importc: "gdk_window_reparent".}
proc clear*(window: PWindow){.cdecl, dynlib: lib, 
                                     importc: "gdk_window_clear".}
proc clearArea*(window: PWindow, x: Gint, y: Gint, width: Gint, 
                        height: Gint){.cdecl, dynlib: lib, 
                                       importc: "gdk_window_clear_area".}
proc clearAreaE*(window: PWindow, x: Gint, y: Gint, width: Gint, 
                          height: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_window_clear_area_e".}
proc `raise`*(window: PWindow){.cdecl, dynlib: lib, 
                                importc: "gdk_window_raise".}
proc lower*(window: PWindow){.cdecl, dynlib: lib, 
                                     importc: "gdk_window_lower".}
proc focus*(window: PWindow, timestamp: Guint32){.cdecl, dynlib: lib, 
    importc: "gdk_window_focus".}
proc setUserData*(window: PWindow, user_data: Gpointer){.cdecl, 
    dynlib: lib, importc: "gdk_window_set_user_data".}
proc setOverrideRedirect*(window: PWindow, override_redirect: Gboolean){.
    cdecl, dynlib: lib, importc: "gdk_window_set_override_redirect".}
proc addFilter*(window: PWindow, `function`: TFilterFunc, data: Gpointer){.
    cdecl, dynlib: lib, importc: "gdk_window_add_filter".}
proc removeFilter*(window: PWindow, `function`: TFilterFunc, 
                           data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gdk_window_remove_filter".}
proc scroll*(window: PWindow, dx: Gint, dy: Gint){.cdecl, dynlib: lib, 
    importc: "gdk_window_scroll".}
proc shapeCombineMask*(window: PWindow, mask: PBitmap, x: Gint, y: Gint){.
    cdecl, dynlib: lib, importc: "gdk_window_shape_combine_mask".}
proc shapeCombineRegion*(window: PWindow, shape_region: PRegion, 
                                  offset_x: Gint, offset_y: Gint){.cdecl, 
    dynlib: lib, importc: "gdk_window_shape_combine_region".}
proc setChildShapes*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_child_shapes".}
proc mergeChildShapes*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_merge_child_shapes".}
proc isVisible*(window: PWindow): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_window_is_visible".}
proc isViewable*(window: PWindow): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_window_is_viewable".}
proc getState*(window: PWindow): TWindowState{.cdecl, dynlib: lib, 
    importc: "gdk_window_get_state".}
proc setStaticGravities*(window: PWindow, use_static: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_window_set_static_gravities".}
proc windowForeignNewForDisplay*(display: PDisplay, anid: TNativeWindow): PWindow{.
    cdecl, dynlib: lib, importc: "gdk_window_foreign_new_for_display".}
proc windowLookupForDisplay*(display: PDisplay, anid: TNativeWindow): PWindow{.
    cdecl, dynlib: lib, importc: "gdk_window_lookup_for_display".}
proc setTypeHint*(window: PWindow, hint: TWindowTypeHint){.cdecl, 
    dynlib: lib, importc: "gdk_window_set_type_hint".}
proc setModalHint*(window: PWindow, modal: Gboolean){.cdecl, 
    dynlib: lib, importc: "gdk_window_set_modal_hint".}
proc setGeometryHints*(window: PWindow, geometry: PGeometry, 
                                geom_mask: TWindowHints){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_geometry_hints".}
proc setSmClientId*(sm_client_id: Cstring){.cdecl, dynlib: lib, 
    importc: "gdk_set_sm_client_id".}
proc beginPaintRect*(window: PWindow, rectangle: PRectangle){.cdecl, 
    dynlib: lib, importc: "gdk_window_begin_paint_rect".}
proc beginPaintRegion*(window: PWindow, region: PRegion){.cdecl, 
    dynlib: lib, importc: "gdk_window_begin_paint_region".}
proc endPaint*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_end_paint".}
proc setTitle*(window: PWindow, title: Cstring){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_title".}
proc setRole*(window: PWindow, role: Cstring){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_role".}
proc setTransientFor*(window: PWindow, parent: PWindow){.cdecl, 
    dynlib: lib, importc: "gdk_window_set_transient_for".}
proc setBackground*(window: PWindow, color: PColor){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_background".}
proc setBackPixmap*(window: PWindow, pixmap: PPixmap, 
                             parent_relative: Gboolean){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_back_pixmap".}
proc setCursor*(window: PWindow, cursor: PCursor){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_cursor".}
proc getUserData*(window: PWindow, data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gdk_window_get_user_data".}
proc getGeometry*(window: PWindow, x: Pgint, y: Pgint, width: Pgint, 
                          height: Pgint, depth: Pgint){.cdecl, dynlib: lib, 
    importc: "gdk_window_get_geometry".}
proc getPosition*(window: PWindow, x: Pgint, y: Pgint){.cdecl, 
    dynlib: lib, importc: "gdk_window_get_position".}
proc getOrigin*(window: PWindow, x: Pgint, y: Pgint): Gint{.cdecl, 
    dynlib: lib, importc: "gdk_window_get_origin".}
proc getRootOrigin*(window: PWindow, x: Pgint, y: Pgint){.cdecl, 
    dynlib: lib, importc: "gdk_window_get_root_origin".}
proc getFrameExtents*(window: PWindow, rect: PRectangle){.cdecl, 
    dynlib: lib, importc: "gdk_window_get_frame_extents".}
proc getPointer*(window: PWindow, x: Pgint, y: Pgint, 
                         mask: PModifierType): PWindow{.cdecl, dynlib: lib, 
    importc: "gdk_window_get_pointer".}
proc getParent*(window: PWindow): PWindow{.cdecl, dynlib: lib, 
    importc: "gdk_window_get_parent".}
proc getToplevel*(window: PWindow): PWindow{.cdecl, dynlib: lib, 
    importc: "gdk_window_get_toplevel".}
proc getChildren*(window: PWindow): PGList{.cdecl, dynlib: lib, 
    importc: "gdk_window_get_children".}
proc peekChildren*(window: PWindow): PGList{.cdecl, dynlib: lib, 
    importc: "gdk_window_peek_children".}
proc getEvents*(window: PWindow): TEventMask{.cdecl, dynlib: lib, 
    importc: "gdk_window_get_events".}
proc setEvents*(window: PWindow, event_mask: TEventMask){.cdecl, 
    dynlib: lib, importc: "gdk_window_set_events".}
proc setIconList*(window: PWindow, pixbufs: PGList){.cdecl, 
    dynlib: lib, importc: "gdk_window_set_icon_list".}
proc setIcon*(window: PWindow, icon_window: PWindow, pixmap: PPixmap, 
                      mask: PBitmap){.cdecl, dynlib: lib, 
                                      importc: "gdk_window_set_icon".}
proc setIconName*(window: PWindow, name: Cstring){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_icon_name".}
proc setGroup*(window: PWindow, leader: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_group".}
proc setDecorations*(window: PWindow, decorations: TWMDecoration){.
    cdecl, dynlib: lib, importc: "gdk_window_set_decorations".}
proc getDecorations*(window: PWindow, decorations: PWMDecoration): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_window_get_decorations".}
proc setFunctions*(window: PWindow, functions: TWMFunction){.cdecl, 
    dynlib: lib, importc: "gdk_window_set_functions".}
proc iconify*(window: PWindow){.cdecl, dynlib: lib, 
                                       importc: "gdk_window_iconify".}
proc deiconify*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_deiconify".}
proc stick*(window: PWindow){.cdecl, dynlib: lib, 
                                     importc: "gdk_window_stick".}
proc unstick*(window: PWindow){.cdecl, dynlib: lib, 
                                       importc: "gdk_window_unstick".}
proc maximize*(window: PWindow){.cdecl, dynlib: lib, 
                                        importc: "gdk_window_maximize".}
proc unmaximize*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_unmaximize".}
proc registerDnd*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_register_dnd".}
proc beginResizeDrag*(window: PWindow, edge: TWindowEdge, button: Gint, 
                               root_x: Gint, root_y: Gint, timestamp: Guint32){.
    cdecl, dynlib: lib, importc: "gdk_window_begin_resize_drag".}
proc beginMoveDrag*(window: PWindow, button: Gint, root_x: Gint, 
                             root_y: Gint, timestamp: Guint32){.cdecl, 
    dynlib: lib, importc: "gdk_window_begin_move_drag".}
proc invalidateRect*(window: PWindow, rect: PRectangle, 
                             invalidate_children: Gboolean){.cdecl, dynlib: lib, 
    importc: "gdk_window_invalidate_rect".}
proc invalidateRegion*(window: PWindow, region: PRegion, 
                               invalidate_children: Gboolean){.cdecl, 
    dynlib: lib, importc: "gdk_window_invalidate_region".}
proc invalidateMaybeRecurse*(window: PWindow, region: PRegion, 
    child_func: WindowInvalidateMaybeRecurseChildFunc, user_data: Gpointer){.
    cdecl, dynlib: lib, importc: "gdk_window_invalidate_maybe_recurse".}
proc getUpdateArea*(window: PWindow): PRegion{.cdecl, dynlib: lib, 
    importc: "gdk_window_get_update_area".}
proc freezeUpdates*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_freeze_updates".}
proc thawUpdates*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gdk_window_thaw_updates".}
proc windowProcessAllUpdates*(){.cdecl, dynlib: lib, 
                                    importc: "gdk_window_process_all_updates".}
proc processUpdates*(window: PWindow, update_children: Gboolean){.cdecl, 
    dynlib: lib, importc: "gdk_window_process_updates".}
proc windowSetDebugUpdates*(setting: Gboolean){.cdecl, dynlib: lib, 
    importc: "gdk_window_set_debug_updates".}
proc windowConstrainSize*(geometry: PGeometry, flags: Guint, width: Gint, 
                            height: Gint, new_width: Pgint, new_height: Pgint){.
    cdecl, dynlib: lib, importc: "gdk_window_constrain_size".}
proc getInternalPaintInfo*(window: PWindow, e: var PDrawable, 
                                     x_offset: Pgint, y_offset: Pgint){.cdecl, 
    dynlib: lib, importc: "gdk_window_get_internal_paint_info".}
proc setPointerHooks*(new_hooks: PPointerHooks): PPointerHooks{.cdecl, 
    dynlib: lib, importc: "gdk_set_pointer_hooks".}
proc getDefaultRootWindow*(): PWindow{.cdecl, dynlib: lib, 
    importc: "gdk_get_default_root_window".}
proc parseArgs*(argc: Pgint, v: var PPgchar){.cdecl, dynlib: lib, 
    importc: "gdk_parse_args".}
proc init*(argc: Pgint, v: var PPgchar){.cdecl, dynlib: lib, importc: "gdk_init".}
proc initCheck*(argc: Pgint, v: var PPgchar): Gboolean{.cdecl, dynlib: lib, 
    importc: "gdk_init_check".}
when not defined(DISABLE_DEPRECATED): 
  proc exit*(error_code: Gint){.cdecl, dynlib: lib, importc: "gdk_exit".}
proc setLocale*(): Cstring{.cdecl, dynlib: lib, importc: "gdk_set_locale".}
proc getProgramClass*(): Cstring{.cdecl, dynlib: lib, 
                                    importc: "gdk_get_program_class".}
proc setProgramClass*(program_class: Cstring){.cdecl, dynlib: lib, 
    importc: "gdk_set_program_class".}
proc errorTrapPush*(){.cdecl, dynlib: lib, importc: "gdk_error_trap_push".}
proc errorTrapPop*(): Gint{.cdecl, dynlib: lib, importc: "gdk_error_trap_pop".}
when not defined(DISABLE_DEPRECATED): 
  proc setUseXshm*(use_xshm: Gboolean){.cdecl, dynlib: lib, 
      importc: "gdk_set_use_xshm".}
  proc getUseXshm*(): Gboolean{.cdecl, dynlib: lib, 
                                  importc: "gdk_get_use_xshm".}
proc getDisplay*(): Cstring{.cdecl, dynlib: lib, importc: "gdk_get_display".}
proc getDisplayArgName*(): Cstring{.cdecl, dynlib: lib, 
                                       importc: "gdk_get_display_arg_name".}
when not defined(DISABLE_DEPRECATED): 
  proc inputAddFull*(source: Gint, condition: TInputCondition, 
                       `function`: TInputFunction, data: Gpointer, 
                       destroy: TDestroyNotify): Gint{.cdecl, dynlib: lib, 
      importc: "gdk_input_add_full".}
  proc inputAdd*(source: Gint, condition: TInputCondition, 
                  `function`: TInputFunction, data: Gpointer): Gint{.cdecl, 
      dynlib: lib, importc: "gdk_input_add".}
  proc inputRemove*(tag: Gint){.cdecl, dynlib: lib, importc: "gdk_input_remove".}
proc pointerGrab*(window: PWindow, owner_events: Gboolean, 
                   event_mask: TEventMask, confine_to: PWindow, cursor: PCursor, 
                   time: Guint32): TGrabStatus{.cdecl, dynlib: lib, 
    importc: "gdk_pointer_grab".}
proc keyboardGrab*(window: PWindow, owner_events: Gboolean, time: Guint32): TGrabStatus{.
    cdecl, dynlib: lib, importc: "gdk_keyboard_grab".}
when not defined(MULTIHEAD_SAFE): 
  proc pointerUngrab*(time: Guint32){.cdecl, dynlib: lib, 
                                       importc: "gdk_pointer_ungrab".}
  proc keyboardUngrab*(time: Guint32){.cdecl, dynlib: lib, 
                                        importc: "gdk_keyboard_ungrab".}
  proc pointerIsGrabbed*(): Gboolean{.cdecl, dynlib: lib, 
                                        importc: "gdk_pointer_is_grabbed".}
  proc screenWidth*(): Gint{.cdecl, dynlib: lib, importc: "gdk_screen_width".}
  proc screenHeight*(): Gint{.cdecl, dynlib: lib, importc: "gdk_screen_height".}
  proc screenWidthMm*(): Gint{.cdecl, dynlib: lib, 
                                 importc: "gdk_screen_width_mm".}
  proc screenHeightMm*(): Gint{.cdecl, dynlib: lib, 
                                  importc: "gdk_screen_height_mm".}
  proc beep*(){.cdecl, dynlib: lib, importc: "gdk_beep".}
proc flush*(){.cdecl, dynlib: lib, importc: "gdk_flush".}
when not defined(MULTIHEAD_SAFE): 
  proc setDoubleClickTime*(msec: Guint){.cdecl, dynlib: lib, 
      importc: "gdk_set_double_click_time".}
proc intersect*(src1: PRectangle, src2: PRectangle, dest: PRectangle): Gboolean{.
    cdecl, dynlib: lib, importc: "gdk_rectangle_intersect".}
proc union*(src1: PRectangle, src2: PRectangle, dest: PRectangle){.
    cdecl, dynlib: lib, importc: "gdk_rectangle_union".}
proc rectangleGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "gdk_rectangle_get_type".}
proc typeRectangle*(): GType
proc wcstombs*(src: PWChar): Cstring{.cdecl, dynlib: lib, 
                                      importc: "gdk_wcstombs".}
proc mbstowcs*(dest: PWChar, src: Cstring, dest_max: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "gdk_mbstowcs".}
when not defined(MULTIHEAD_SAFE): 
  proc eventSendClientMessage*(event: PEvent, xid: Guint32): Gboolean{.cdecl, 
      dynlib: lib, importc: "gdk_event_send_client_message".}
  proc eventSendClientmessageToall*(event: PEvent){.cdecl, dynlib: lib, 
      importc: "gdk_event_send_clientmessage_toall".}
proc eventSendClientMessageForDisplay*(display: PDisplay, event: PEvent, 
    xid: Guint32): Gboolean{.cdecl, dynlib: lib, importc: "gdk_event_send_client_message_for_display".}
proc threadsEnter*(){.cdecl, dynlib: lib, importc: "gdk_threads_enter".}
proc threadsLeave*(){.cdecl, dynlib: lib, importc: "gdk_threads_leave".}
proc threadsInit*(){.cdecl, dynlib: lib, importc: "gdk_threads_init".}
proc typeRectangle*(): GType = 
  result = rectangleGetType()

proc typeColormap*(): GType = 
  result = colormapGetType()

proc colormap*(anObject: pointer): PColormap = 
  result = cast[PColormap](gTypeCheckInstanceCast(anObject, typeColormap()))

proc colormapClass*(klass: pointer): PColormapClass = 
  result = cast[PColormapClass](gTypeCheckClassCast(klass, typeColormap()))

proc isColormap*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeColormap())

proc isColormapClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeColormap())

proc colormapGetClass*(obj: pointer): PColormapClass = 
  result = cast[PColormapClass](gTypeInstanceGetClass(obj, typeColormap()))

proc typeColor*(): GType = 
  result = gdk2.color_get_type()

proc destroy*(cursor: PCursor) = 
  unref(cursor)

proc typeCursor*(): GType = 
  result = cursorGetType()

proc typeDragContext*(): GType = 
  result = dragContextGetType()

proc dragContext*(anObject: Pointer): PDragContext = 
  result = cast[PDragContext](gTypeCheckInstanceCast(anObject, 
      typeDragContext()))

proc dragContextClass*(klass: Pointer): PDragContextClass = 
  result = cast[PDragContextClass](gTypeCheckClassCast(klass, 
      typeDragContext()))

proc isDragContext*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeDragContext())

proc isDragContextClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeDragContext())

proc dragContextGetClass*(obj: Pointer): PDragContextClass = 
  result = cast[PDragContextClass](gTypeInstanceGetClass(obj, 
      typeDragContext()))

proc regionEXTENTCHECK*(r1, r2: PRegionBox): bool = 
  result = ((r1.x2) > r2.x1) and ((r1.x1) < r2.x2) and ((r1.y2) > r2.y1) and
      ((r1.y1) < r2.y2)

proc extents*(r: PRegionBox, idRect: PRegion) = 
  if ((r.x1) < idRect.extents.x1): 
    idRect.extents.x1 = r.x1
  if (r.y1) < idRect.extents.y1: 
    idRect.extents.y1 = r.y1
  if (r.x2) > idRect.extents.x2: 
    idRect.extents.x2 = r.x2

proc memcheck*(reg: PRegion, ARect, firstrect: var PRegionBox): bool = 
  assert(false)               # to implement
  
proc checkPrevious*(Reg: PRegion, R: PRegionBox, 
                            Rx1, Ry1, Rx2, Ry2: gint): bool = 
  assert(false)               # to implement
  
proc addrect*(reg: PRegion, r: PRegionBox, rx1, ry1, rx2, ry2: gint) = 
  if (((rx1) < rx2) and ((ry1) < ry2) and
      checkPrevious(reg, r, rx1, ry1, rx2, ry2)): 
    r.x1 = rx1
    r.y1 = ry1
    r.x2 = rx2
    r.y2 = ry2

proc addrectnox*(reg: PRegion, r: PRegionBox, rx1, ry1, rx2, ry2: gint) = 
  if (((rx1) < rx2) and ((ry1) < ry2) and
      checkPrevious(reg, r, rx1, ry1, rx2, ry2)): 
    r.x1 = rx1
    r.y1 = ry1
    r.x2 = rx2
    r.y2 = ry2
    inc(reg.numRects)

proc emptyRegion*(pReg: PRegion): bool = 
  result = pReg.numRects == 0'i32

proc regionNotEmpty*(pReg: PRegion): bool = 
  result = pReg.numRects != 0'i32

proc regionINBOX*(r: TRegionBox, x, y: gint): bool = 
  result = ((((r.x2) > x) and ((r.x1) <= x)) and ((r.y2) > y)) and
      ((r.y1) <= y)

proc typeDrawable*(): GType = 
  result = drawableGetType()

proc drawable*(anObject: Pointer): PDrawable = 
  result = cast[PDrawable](gTypeCheckInstanceCast(anObject, typeDrawable()))

proc drawableClass*(klass: Pointer): PDrawableClass = 
  result = cast[PDrawableClass](gTypeCheckClassCast(klass, typeDrawable()))

proc isDrawable*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeDrawable())

proc isDrawableClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeDrawable())

proc drawableGetClass*(obj: Pointer): PDrawableClass = 
  result = cast[PDrawableClass](gTypeInstanceGetClass(obj, typeDrawable()))

proc pixmap*(drawable: PDrawable, gc: Pgc, src: PDrawable, xsrc: Gint, 
                  ysrc: Gint, xdest: Gint, ydest: Gint, width: Gint, 
                  height: Gint) = 
  drawable(drawable, gc, src, xsrc, ysrc, xdest, ydest, width, height)

proc bitmap*(drawable: PDrawable, gc: Pgc, src: PDrawable, xsrc: Gint, 
                  ysrc: Gint, xdest: Gint, ydest: Gint, width: Gint, 
                  height: Gint) = 
  drawable(drawable, gc, src, xsrc, ysrc, xdest, ydest, width, height)

proc typeEvent*(): GType = 
  result = eventGetType()

proc typeFont*(): GType = 
  result = gdk2.font_get_type()

proc typeGc*(): GType = 
  result = gcGetType()

proc gc*(anObject: Pointer): PGC = 
  result = cast[Pgc](gTypeCheckInstanceCast(anObject, typeGc()))

proc gcClass*(klass: Pointer): PGCClass = 
  result = cast[PGCClass](gTypeCheckClassCast(klass, typeGc()))

proc isGc*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeGc())

proc isGcClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeGc())

proc gcGetClass*(obj: Pointer): PGCClass = 
  result = cast[PGCClass](gTypeInstanceGetClass(obj, typeGc()))

proc destroy*(gc: Pgc) = 
  gObjectUnref(gObject(gc))

proc typeImage*(): GType = 
  result = imageGetType()

proc image*(anObject: Pointer): PImage = 
  result = cast[PImage](gTypeCheckInstanceCast(anObject, typeImage()))

proc imageClass*(klass: Pointer): PImageClass = 
  result = cast[PImageClass](gTypeCheckClassCast(klass, typeImage()))

proc isImage*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeImage())

proc isImageClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeImage())

proc imageGetClass*(obj: Pointer): PImageClass = 
  result = cast[PImageClass](gTypeInstanceGetClass(obj, typeImage()))

proc destroy*(image: PImage) = 
  gObjectUnref(gObject(image))

proc typeDevice*(): GType = 
  result = deviceGetType()

proc device*(anObject: Pointer): PDevice = 
  result = cast[PDevice](gTypeCheckInstanceCast(anObject, typeDevice()))

proc deviceClass*(klass: Pointer): PDeviceClass = 
  result = cast[PDeviceClass](gTypeCheckClassCast(klass, typeDevice()))

proc isDevice*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeDevice())

proc isDeviceClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeDevice())

proc deviceGetClass*(obj: Pointer): PDeviceClass = 
  result = cast[PDeviceClass](gTypeInstanceGetClass(obj, typeDevice()))

proc typeKeymap*(): GType = 
  result = keymapGetType()

proc keymap*(anObject: Pointer): PKeymap = 
  result = cast[PKeymap](gTypeCheckInstanceCast(anObject, typeKeymap()))

proc keymapClass*(klass: Pointer): PKeymapClass = 
  result = cast[PKeymapClass](gTypeCheckClassCast(klass, typeKeymap()))

proc isKeymap*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeKeymap())

proc isKeymapClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeKeymap())

proc keymapGetClass*(obj: Pointer): PKeymapClass = 
  result = cast[PKeymapClass](gTypeInstanceGetClass(obj, typeKeymap()))

proc typePixmap*(): GType = 
  result = pixmapGetType()

proc pixmap*(anObject: Pointer): PPixmap = 
  result = cast[PPixmap](gTypeCheckInstanceCast(anObject, typePixmap()))

proc pixmapClass*(klass: Pointer): PPixmapObjectClass = 
  result = cast[PPixmapObjectClass](gTypeCheckClassCast(klass, typePixmap()))

proc isPixmap*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typePixmap())

proc isPixmapClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typePixmap())

proc pixmapGetClass*(obj: Pointer): PPixmapObjectClass = 
  result = cast[PPixmapObjectClass](gTypeInstanceGetClass(obj, typePixmap()))

proc pixmapObject*(anObject: Pointer): PPixmapObject = 
  result = cast[PPixmapObject](pixmap(anObject))

proc bitmapRef*(drawable: PDrawable): PDrawable = 
  result = drawable(gObjectRef(gObject(drawable)))

proc bitmapUnref*(drawable: PDrawable) = 
  gObjectUnref(gObject(drawable))

proc pixmapRef*(drawable: PDrawable): PDrawable = 
  result = drawable(gObjectRef(gObject(drawable)))

proc pixmapUnref*(drawable: PDrawable) = 
  gObjectUnref(gObject(drawable))

proc rgbGetCmap*(): PColormap = 
  result = nil                #gdk_rgb_get_colormap()
  
proc typeDisplay*(): GType = 
  nil
  #result = nil
  
proc displayObject*(anObject: pointer): PDisplay = 
  result = cast[PDisplay](gTypeCheckInstanceCast(anObject, typeDisplay()))

proc displayClass*(klass: pointer): PDisplayClass = 
  result = cast[PDisplayClass](gTypeCheckClassCast(klass, typeDisplay()))

proc isDisplay*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeDisplay())

proc isDisplayClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeDisplay())

proc displayGetClass*(obj: pointer): PDisplayClass = 
  result = cast[PDisplayClass](gTypeInstanceGetClass(obj, typeDisplay()))

proc typeScreen*(): GType = 
  nil

proc screen*(anObject: Pointer): PScreen = 
  result = cast[PScreen](gTypeCheckInstanceCast(anObject, typeScreen()))

proc screenClass*(klass: Pointer): PScreenClass = 
  result = cast[PScreenClass](gTypeCheckClassCast(klass, typeScreen()))

proc isScreen*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeScreen())

proc isScreenClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeScreen())

proc screenGetClass*(obj: Pointer): PScreenClass = 
  result = cast[PScreenClass](gTypeInstanceGetClass(obj, typeScreen()))

proc selectionPrimary*(): TAtom = 
  result = `makeAtom`(1)

proc selectionSecondary*(): TAtom = 
  result = `makeAtom`(2)

proc selectionClipboard*(): TAtom = 
  result = `makeAtom`(69)

proc targetBitmap*(): TAtom = 
  result = `makeAtom`(5)

proc targetColormap*(): TAtom = 
  result = `makeAtom`(7)

proc targetDrawable*(): TAtom = 
  result = `makeAtom`(17)

proc targetPixmap*(): TAtom = 
  result = `makeAtom`(20)

proc targetString*(): TAtom = 
  result = `makeAtom`(31)

proc selectionTypeAtom*(): TAtom = 
  result = `makeAtom`(4)

proc selectionTypeBitmap*(): TAtom = 
  result = `makeAtom`(5)

proc selectionTypeColormap*(): TAtom = 
  result = `makeAtom`(7)

proc selectionTypeDrawable*(): TAtom = 
  result = `makeAtom`(17)

proc selectionTypeInteger*(): TAtom = 
  result = `makeAtom`(19)

proc selectionTypePixmap*(): TAtom = 
  result = `makeAtom`(20)

proc selectionTypeWindow*(): TAtom = 
  result = `makeAtom`(33)

proc selectionTypeString*(): TAtom = 
  result = `makeAtom`(31)

proc atomToPointer*(atom: TAtom): pointer = 
  result = cast[Pointer](atom)

proc pointerToAtom*(p: Pointer): TAtom = 
  result = cast[TAtom](p)

proc `makeAtom`*(val: guint): TAtom = 
  result = cast[TAtom](val)

proc none*(): TAtom = 
  result = `makeAtom`(0)

proc typeVisual*(): GType = 
  result = visualGetType()

proc visual*(anObject: Pointer): PVisual = 
  result = cast[PVisual](gTypeCheckInstanceCast(anObject, typeVisual()))

proc visualClass*(klass: Pointer): PVisualClass = 
  result = cast[PVisualClass](gTypeCheckClassCast(klass, typeVisual()))

proc isVisual*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeVisual())

proc isVisualClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeVisual())

proc visualGetClass*(obj: Pointer): PVisualClass = 
  result = cast[PVisualClass](gTypeInstanceGetClass(obj, typeVisual()))

proc reference*(v: PVisual) = 
  discard gObjectRef(v)

proc unref*(v: PVisual) = 
  gObjectUnref(v)

proc typeWindow*(): GType = 
  result = windowObjectGetType()

proc window*(anObject: Pointer): PWindow = 
  result = cast[PWindow](gTypeCheckInstanceCast(anObject, typeWindow()))

proc windowClass*(klass: Pointer): PWindowObjectClass = 
  result = cast[PWindowObjectClass](gTypeCheckClassCast(klass, typeWindow()))

proc isWindow*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeWindow())

proc isWindowClass*(klass: Pointer): bool = 
  result = gTypeCheckClassType(klass, typeWindow())

proc windowGetClass*(obj: Pointer): PWindowObjectClass = 
  result = cast[PWindowObjectClass](gTypeInstanceGetClass(obj, typeWindow()))

proc windowObject*(anObject: Pointer): PWindowObject = 
  result = cast[PWindowObject](window(anObject))

proc windowObjectGuffawGravity*(a: PWindowObject): guint = 
  result = (a.flag0 and bm_TWindowObject_guffaw_gravity) shr
      bp_TWindowObject_guffaw_gravity

proc windowObjectSetGuffawGravity*(a: PWindowObject, 
                                      `guffaw_gravity`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`guffawGravity` shl bp_TWindowObject_guffaw_gravity) and
      bm_TWindowObject_guffaw_gravity)

proc windowObjectInputOnly*(a: PWindowObject): guint = 
  result = (a.flag0 and bm_TWindowObject_input_only) shr
      bp_TWindowObject_input_only

proc windowObjectSetInputOnly*(a: PWindowObject, `input_only`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`inputOnly` shl bp_TWindowObject_input_only) and
      bm_TWindowObject_input_only)

proc windowObjectModalHint*(a: PWindowObject): guint = 
  result = (a.flag0 and bm_TWindowObject_modal_hint) shr
      bp_TWindowObject_modal_hint

proc windowObjectSetModalHint*(a: PWindowObject, `modal_hint`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`modalHint` shl bp_TWindowObject_modal_hint) and
      bm_TWindowObject_modal_hint)

proc windowObjectDestroyed*(a: PWindowObject): guint = 
  result = (a.flag0 and bm_TWindowObject_destroyed) shr
      bp_TWindowObject_destroyed

proc windowObjectSetDestroyed*(a: PWindowObject, `destroyed`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`destroyed` shl bp_TWindowObject_destroyed) and
      bm_TWindowObject_destroyed)

proc rootParent*(): PWindow = 
  result = getDefaultRootWindow()

proc windowGetSize*(drawable: PDrawable, width: Pgint, height: Pgint) = 
  getSize(drawable, width, height)

proc getType*(window: PWindow): TWindowType = 
  result = getWindowType(window)

proc windowGetColormap*(drawable: PDrawable): PColormap = 
  result = getColormap(drawable)

proc windowSetColormap*(drawable: PDrawable, colormap: PColormap) = 
  setColormap(drawable, colormap)

proc windowGetVisual*(drawable: PDrawable): PVisual = 
  result = getVisual(drawable)

proc windowRef*(drawable: PDrawable): PDrawable = 
  result = drawable(gObjectRef(gObject(drawable)))

proc windowUnref*(drawable: PDrawable) = 
  gObjectUnref(gObject(drawable))

proc windowCopyArea*(drawable: PDrawable, gc: Pgc, x, y: Gint, 
                       source_drawable: PDrawable, source_x, source_y: Gint, 
                       width, height: Gint) = 
  pixmap(drawable, gc, sourceDrawable, sourceX, sourceY, x, y, width, 
         height)
