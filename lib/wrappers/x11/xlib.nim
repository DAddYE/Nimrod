
import
  x

const
  libX11* = "libX11.so"

type
  cunsigned* = cint
  Pcint* = ptr cint
  PPcint* = ptr Pcint
  PPcuchar* = ptr ptr cuchar
  PWideChar* = ptr int16
  PPchar* = ptr cstring
  PPPchar* = ptr ptr cstring
  Pculong* = ptr culong
  Pcuchar* = cstring
  Pcuint* = ptr cuint
  Pcushort* = ptr uint16
#  Automatically converted by H2Pas 0.99.15 from xlib.h
#  The following command line parameters were used:
#    -p
#    -T
#    -S
#    -d
#    -c
#    xlib.h

const
  XlibSpecificationRelease* = 6

type
  PXpointer* = ptr TXpointer
  TXpointer* = ptr char
  Pbool* = ptr Tbool
  Tbool* = int           #cint?
  PStatus* = ptr TStatus
  TStatus* = cint

const
  QueuedAlready* = 0
  QueuedAfterReading* = 1
  QueuedAfterFlush* = 2

type
  PPXExtData* = ptr PXExtData
  PXExtData* = ptr TXExtData
  TXExtData*{.final.} = object
    number*: cint
    next*: PXExtData
    free_private*: proc (extension: PXExtData): cint{.cdecl.}
    private_data*: TXpointer

  PXExtCodes* = ptr TXExtCodes
  TXExtCodes*{.final.} = object
    extension*: cint
    major_opcode*: cint
    first_event*: cint
    first_error*: cint

  PXPixmapFormatValues* = ptr TXPixmapFormatValues
  TXPixmapFormatValues*{.final.} = object
    depth*: cint
    bits_per_pixel*: cint
    scanline_pad*: cint

  PXGCValues* = ptr TXGCValues
  TXGCValues*{.final.} = object
    function*: cint
    plane_mask*: culong
    foreground*: culong
    background*: culong
    line_width*: cint
    line_style*: cint
    cap_style*: cint
    join_style*: cint
    fill_style*: cint
    fill_rule*: cint
    arc_mode*: cint
    tile*: TPixmap
    stipple*: TPixmap
    ts_x_origin*: cint
    ts_y_origin*: cint
    font*: TFont
    subwindow_mode*: cint
    graphics_exposures*: Tbool
    clip_x_origin*: cint
    clip_y_origin*: cint
    clip_mask*: TPixmap
    dash_offset*: cint
    dashes*: cchar

  PXGC* = ptr TXGC
  TXGC*{.final.} = object
  TGC* = PXGC
  PGC* = ptr TGC
  PVisual* = ptr TVisual
  TVisual*{.final.} = object
    ext_data*: PXExtData
    visualid*: TVisualID
    c_class*: cint
    red_mask*, green_mask*, blue_mask*: culong
    bits_per_rgb*: cint
    map_entries*: cint

  PDepth* = ptr TDepth
  TDepth*{.final.} = object
    depth*: cint
    nvisuals*: cint
    visuals*: PVisual

  PXDisplay* = ptr TXDisplay
  TXDisplay*{.final.} = object
  PScreen* = ptr TScreen
  TScreen*{.final.} = object
    ext_data*: PXExtData
    display*: PXDisplay
    root*: TWindow
    width*, height*: cint
    mwidth*, mheight*: cint
    ndepths*: cint
    depths*: PDepth
    root_depth*: cint
    root_visual*: PVisual
    default_gc*: TGC
    cmap*: TColormap
    white_pixel*: culong
    black_pixel*: culong
    max_maps*, min_maps*: cint
    backing_store*: cint
    save_unders*: Tbool
    root_input_mask*: clong

  PScreenFormat* = ptr TScreenFormat
  TScreenFormat*{.final.} = object
    ext_data*: PXExtData
    depth*: cint
    bits_per_pixel*: cint
    scanline_pad*: cint

  PXSetWindowAttributes* = ptr TXSetWindowAttributes
  TXSetWindowAttributes*{.final.} = object
    background_pixmap*: TPixmap
    background_pixel*: culong
    border_pixmap*: TPixmap
    border_pixel*: culong
    bit_gravity*: cint
    win_gravity*: cint
    backing_store*: cint
    backing_planes*: culong
    backing_pixel*: culong
    save_under*: Tbool
    event_mask*: clong
    do_not_propagate_mask*: clong
    override_redirect*: Tbool
    colormap*: TColormap
    cursor*: TCursor

  PXWindowAttributes* = ptr TXWindowAttributes
  TXWindowAttributes*{.final.} = object
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    depth*: cint
    visual*: PVisual
    root*: TWindow
    c_class*: cint
    bit_gravity*: cint
    win_gravity*: cint
    backing_store*: cint
    backing_planes*: culong
    backing_pixel*: culong
    save_under*: Tbool
    colormap*: TColormap
    map_installed*: Tbool
    map_state*: cint
    all_event_masks*: clong
    your_event_mask*: clong
    do_not_propagate_mask*: clong
    override_redirect*: Tbool
    screen*: PScreen

  PXHostAddress* = ptr TXHostAddress
  TXHostAddress*{.final.} = object
    family*: cint
    len*: cint
    address*: cstring

  PXServerInterpretedAddress* = ptr TXServerInterpretedAddress
  TXServerInterpretedAddress*{.final.} = object
    typelength*: cint
    valuelength*: cint
    theType*: cstring
    value*: cstring

  PXImage* = ptr TXImage
  TF*{.final.} = object
    create_image*: proc (para1: PXDisplay, para2: PVisual, para3: cuint,
                         para4: cint, para5: cint, para6: cstring, para7: cuint,
                         para8: cuint, para9: cint, para10: cint): PXImage{.
        cdecl.}
    destroy_image*: proc (para1: PXImage): cint{.cdecl.}
    get_pixel*: proc (para1: PXImage, para2: cint, para3: cint): culong{.cdecl.}
    put_pixel*: proc (para1: PXImage, para2: cint, para3: cint, para4: culong): cint{.
        cdecl.}
    sub_image*: proc (para1: PXImage, para2: cint, para3: cint, para4: cuint,
                      para5: cuint): PXImage{.cdecl.}
    add_pixel*: proc (para1: PXImage, para2: clong): cint{.cdecl.}

  TXImage*{.final.} = object
    width*, height*: cint
    xoffset*: cint
    format*: cint
    data*: cstring
    byte_order*: cint
    bitmap_unit*: cint
    bitmap_bit_order*: cint
    bitmap_pad*: cint
    depth*: cint
    bytes_per_line*: cint
    bits_per_pixel*: cint
    red_mask*: culong
    green_mask*: culong
    blue_mask*: culong
    obdata*: TXpointer
    f*: TF

  PXWindowChanges* = ptr TXWindowChanges
  TXWindowChanges*{.final.} = object
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    sibling*: TWindow
    stack_mode*: cint

  PXColor* = ptr TXColor
  TXColor*{.final.} = object
    pixel*: culong
    red*, green*, blue*: cushort
    flags*: cchar
    pad*: cchar

  PXSegment* = ptr TXSegment
  TXSegment*{.final.} = object
    x1*, y1*, x2*, y2*: cshort

  PXPoint* = ptr TXPoint
  TXPoint*{.final.} = object
    x*, y*: cshort

  PXRectangle* = ptr TXRectangle
  TXRectangle*{.final.} = object
    x*, y*: cshort
    width*, height*: cushort

  PXArc* = ptr TXArc
  TXArc*{.final.} = object
    x*, y*: cshort
    width*, height*: cushort
    angle1*, angle2*: cshort

  PXKeyboardControl* = ptr TXKeyboardControl
  TXKeyboardControl*{.final.} = object
    key_click_percent*: cint
    bell_percent*: cint
    bell_pitch*: cint
    bell_duration*: cint
    led*: cint
    led_mode*: cint
    key*: cint
    auto_repeat_mode*: cint

  PXKeyboardState* = ptr TXKeyboardState
  TXKeyboardState*{.final.} = object
    key_click_percent*: cint
    bell_percent*: cint
    bell_pitch*, bell_duration*: cuint
    led_mask*: culong
    global_auto_repeat*: cint
    auto_repeats*: array[0..31, cchar]

  PXTimeCoord* = ptr TXTimeCoord
  TXTimeCoord*{.final.} = object
    time*: TTime
    x*, y*: cshort

  PXModifierKeymap* = ptr TXModifierKeymap
  TXModifierKeymap*{.final.} = object
    max_keypermod*: cint
    modifiermap*: PKeyCode

  PDisplay* = ptr TDisplay
  TDisplay* = TXDisplay
  PXPrivate* = ptr TXPrivate
  TXPrivate*{.final.} = object
  PXrmHashBucketRec* = ptr TXrmHashBucketRec
  TXrmHashBucketRec*{.final.} = object
  PXPrivDisplay* = ptr TXPrivDisplay
  TXPrivDisplay*{.final.} = object
    ext_data*: PXExtData
    private1*: PXPrivate
    fd*: cint
    private2*: cint
    proto_major_version*: cint
    proto_minor_version*: cint
    vendor*: cstring
    private3*: TXID
    private4*: TXID
    private5*: TXID
    private6*: cint
    resource_alloc*: proc (para1: PXDisplay): TXID{.cdecl.}
    byte_order*: cint
    bitmap_unit*: cint
    bitmap_pad*: cint
    bitmap_bit_order*: cint
    nformats*: cint
    pixmap_format*: PScreenFormat
    private8*: cint
    release*: cint
    private9*, private10*: PXPrivate
    qlen*: cint
    last_request_read*: culong
    request*: culong
    private11*: TXpointer
    private12*: TXpointer
    private13*: TXpointer
    private14*: TXpointer
    max_request_size*: cunsigned
    db*: PXrmHashBucketRec
    private15*: proc (para1: PXDisplay): cint{.cdecl.}
    display_name*: cstring
    default_screen*: cint
    nscreens*: cint
    screens*: PScreen
    motion_buffer*: culong
    private16*: culong
    min_keycode*: cint
    max_keycode*: cint
    private17*: TXpointer
    private18*: TXpointer
    private19*: cint
    xdefaults*: cstring

  PXKeyEvent* = ptr TXKeyEvent
  TXKeyEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    root*: TWindow
    subwindow*: TWindow
    time*: TTime
    x*, y*: cint
    x_root*, y_root*: cint
    state*: cuint
    keycode*: cuint
    same_screen*: Tbool

  PXKeyPressedEvent* = ptr TXKeyPressedEvent
  TXKeyPressedEvent* = TXKeyEvent
  PXKeyReleasedEvent* = ptr TXKeyReleasedEvent
  TXKeyReleasedEvent* = TXKeyEvent
  PXButtonEvent* = ptr TXButtonEvent
  TXButtonEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    root*: TWindow
    subwindow*: TWindow
    time*: TTime
    x*, y*: cint
    x_root*, y_root*: cint
    state*: cuint
    button*: cuint
    same_screen*: Tbool

  PXButtonPressedEvent* = ptr TXButtonPressedEvent
  TXButtonPressedEvent* = TXButtonEvent
  PXButtonReleasedEvent* = ptr TXButtonReleasedEvent
  TXButtonReleasedEvent* = TXButtonEvent
  PXMotionEvent* = ptr TXMotionEvent
  TXMotionEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    root*: TWindow
    subwindow*: TWindow
    time*: TTime
    x*, y*: cint
    x_root*, y_root*: cint
    state*: cuint
    is_hint*: cchar
    same_screen*: Tbool

  PXpointerMovedEvent* = ptr TXpointerMovedEvent
  TXpointerMovedEvent* = TXMotionEvent
  PXCrossingEvent* = ptr TXCrossingEvent
  TXCrossingEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    root*: TWindow
    subwindow*: TWindow
    time*: TTime
    x*, y*: cint
    x_root*, y_root*: cint
    mode*: cint
    detail*: cint
    same_screen*: Tbool
    focus*: Tbool
    state*: cuint

  PXEnterWindowEvent* = ptr TXEnterWindowEvent
  TXEnterWindowEvent* = TXCrossingEvent
  PXLeaveWindowEvent* = ptr TXLeaveWindowEvent
  TXLeaveWindowEvent* = TXCrossingEvent
  PXFocusChangeEvent* = ptr TXFocusChangeEvent
  TXFocusChangeEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    mode*: cint
    detail*: cint

  PXFocusInEvent* = ptr TXFocusInEvent
  TXFocusInEvent* = TXFocusChangeEvent
  PXFocusOutEvent* = ptr TXFocusOutEvent
  TXFocusOutEvent* = TXFocusChangeEvent
  PXKeymapEvent* = ptr TXKeymapEvent
  TXKeymapEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    key_vector*: array[0..31, cchar]

  PXExposeEvent* = ptr TXExposeEvent
  TXExposeEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    x*, y*: cint
    width*, height*: cint
    count*: cint

  PXGraphicsExposeEvent* = ptr TXGraphicsExposeEvent
  TXGraphicsExposeEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    drawable*: TDrawable
    x*, y*: cint
    width*, height*: cint
    count*: cint
    major_code*: cint
    minor_code*: cint

  PXNoExposeEvent* = ptr TXNoExposeEvent
  TXNoExposeEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    drawable*: TDrawable
    major_code*: cint
    minor_code*: cint

  PXVisibilityEvent* = ptr TXVisibilityEvent
  TXVisibilityEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    state*: cint

  PXCreateWindowEvent* = ptr TXCreateWindowEvent
  TXCreateWindowEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    parent*: TWindow
    window*: TWindow
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    override_redirect*: Tbool

  PXDestroyWindowEvent* = ptr TXDestroyWindowEvent
  TXDestroyWindowEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    event*: TWindow
    window*: TWindow

  PXUnmapEvent* = ptr TXUnmapEvent
  TXUnmapEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    from_configure*: Tbool

  PXMapEvent* = ptr TXMapEvent
  TXMapEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    override_redirect*: Tbool

  PXMapRequestEvent* = ptr TXMapRequestEvent
  TXMapRequestEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    parent*: TWindow
    window*: TWindow

  PXReparentEvent* = ptr TXReparentEvent
  TXReparentEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    parent*: TWindow
    x*, y*: cint
    override_redirect*: Tbool

  PXConfigureEvent* = ptr TXConfigureEvent
  TXConfigureEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    above*: TWindow
    override_redirect*: Tbool

  PXGravityEvent* = ptr TXGravityEvent
  TXGravityEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    x*, y*: cint

  PXResizeRequestEvent* = ptr TXResizeRequestEvent
  TXResizeRequestEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    width*, height*: cint

  PXConfigureRequestEvent* = ptr TXConfigureRequestEvent
  TXConfigureRequestEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    parent*: TWindow
    window*: TWindow
    x*, y*: cint
    width*, height*: cint
    border_width*: cint
    above*: TWindow
    detail*: cint
    value_mask*: culong

  PXCirculateEvent* = ptr TXCirculateEvent
  TXCirculateEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    place*: cint

  PXCirculateRequestEvent* = ptr TXCirculateRequestEvent
  TXCirculateRequestEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    parent*: TWindow
    window*: TWindow
    place*: cint

  PXPropertyEvent* = ptr TXPropertyEvent
  TXPropertyEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    atom*: TAtom
    time*: TTime
    state*: cint

  PXSelectionClearEvent* = ptr TXSelectionClearEvent
  TXSelectionClearEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    selection*: TAtom
    time*: TTime

  PXSelectionRequestEvent* = ptr TXSelectionRequestEvent
  TXSelectionRequestEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    owner*: TWindow
    requestor*: TWindow
    selection*: TAtom
    target*: TAtom
    property*: TAtom
    time*: TTime

  PXSelectionEvent* = ptr TXSelectionEvent
  TXSelectionEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    requestor*: TWindow
    selection*: TAtom
    target*: TAtom
    property*: TAtom
    time*: TTime

  PXColormapEvent* = ptr TXColormapEvent
  TXColormapEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    colormap*: TColormap
    c_new*: Tbool
    state*: cint

  PXClientMessageEvent* = ptr TXClientMessageEvent
  TXClientMessageEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    message_type*: TAtom
    format*: cint
    data*: array[0..19, char]

  PXMappingEvent* = ptr TXMappingEvent
  TXMappingEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow
    request*: cint
    first_keycode*: cint
    count*: cint

  PXErrorEvent* = ptr TXErrorEvent
  TXErrorEvent*{.final.} = object
    theType*: cint
    display*: PDisplay
    resourceid*: TXID
    serial*: culong
    error_code*: cuchar
    request_code*: cuchar
    minor_code*: cuchar

  PXAnyEvent* = ptr TXAnyEvent
  TXAnyEvent*{.final.} = object
    theType*: cint
    serial*: culong
    send_event*: Tbool
    display*: PDisplay
    window*: TWindow

  PXEvent* = ptr TXEvent
  TXEvent*{.final.} = object
    theType*: cint
    pad*: array[0..22, clong] #
                              #       case longint of
                              #          0 : ( theType : cint );
                              #          1 : ( xany : TXAnyEvent );
                              #          2 : ( xkey : TXKeyEvent );
                              #          3 : ( xbutton : TXButtonEvent );
                              #          4 : ( xmotion : TXMotionEvent );
                              #          5 : ( xcrossing : TXCrossingEvent );
                              #          6 : ( xfocus : TXFocusChangeEvent );
                              #          7 : ( xexpose : TXExposeEvent );
                              #          8 : ( xgraphicsexpose : TXGraphicsExposeEvent );
                              #          9 : ( xnoexpose : TXNoExposeEvent );
                              #          10 : ( xvisibility : TXVisibilityEvent );
                              #          11 : ( xcreatewindow : TXCreateWindowEvent );
                              #          12 : ( xdestroywindow : TXDestroyWindowEvent );
                              #          13 : ( xunmap : TXUnmapEvent );
                              #          14 : ( xmap : TXMapEvent );
                              #          15 : ( xmaprequest : TXMapRequestEvent );
                              #          16 : ( xreparent : TXReparentEvent );
                              #          17 : ( xconfigure : TXConfigureEvent );
                              #          18 : ( xgravity : TXGravityEvent );
                              #          19 : ( xresizerequest : TXResizeRequestEvent );
                              #          20 : ( xconfigurerequest : TXConfigureRequestEvent );
                              #          21 : ( xcirculate : TXCirculateEvent );
                              #          22 : ( xcirculaterequest : TXCirculateRequestEvent );
                              #          23 : ( xproperty : TXPropertyEvent );
                              #          24 : ( xselectionclear : TXSelectionClearEvent );
                              #          25 : ( xselectionrequest : TXSelectionRequestEvent );
                              #          26 : ( xselection : TXSelectionEvent );
                              #          27 : ( xcolormap : TXColormapEvent );
                              #          28 : ( xclient : TXClientMessageEvent );
                              #          29 : ( xmapping : TXMappingEvent );
                              #          30 : ( xerror : TXErrorEvent );
                              #          31 : ( xkeymap : TXKeymapEvent );
                              #          32 : ( pad : array[0..23] of clong );
                              #


type
  PXcharStruct* = ptr TXcharStruct
  TXcharStruct*{.final.} = object
    lbearing*: cshort
    rbearing*: cshort
    width*: cshort
    ascent*: cshort
    descent*: cshort
    attributes*: cushort

  PXFontProp* = ptr TXFontProp
  TXFontProp*{.final.} = object
    name*: TAtom
    card32*: culong

  PPPXFontStruct* = ptr PPXFontStruct
  PPXFontStruct* = ptr PXFontStruct
  PXFontStruct* = ptr TXFontStruct
  TXFontStruct*{.final.} = object
    ext_data*: PXExtData
    fid*: TFont
    direction*: cunsigned
    min_char_or_byte2*: cunsigned
    max_char_or_byte2*: cunsigned
    min_byte1*: cunsigned
    max_byte1*: cunsigned
    all_chars_exist*: Tbool
    default_char*: cunsigned
    n_properties*: cint
    properties*: PXFontProp
    min_bounds*: TXcharStruct
    max_bounds*: TXcharStruct
    per_char*: PXcharStruct
    ascent*: cint
    descent*: cint

  PXTextItem* = ptr TXTextItem
  TXTextItem*{.final.} = object
    chars*: cstring
    nchars*: cint
    delta*: cint
    font*: TFont

  PXchar2b* = ptr TXchar2b
  TXchar2b*{.final.} = object
    byte1*: cuchar
    byte2*: cuchar

  PXTextItem16* = ptr TXTextItem16
  TXTextItem16*{.final.} = object
    chars*: PXchar2b
    nchars*: cint
    delta*: cint
    font*: TFont

  PXEDataObject* = ptr TXEDataObject
  TXEDataObject*{.final.} = object
    display*: PDisplay        #case longint of
                              #          0 : ( display : PDisplay );
                              #          1 : ( gc : TGC );
                              #          2 : ( visual : PVisual );
                              #          3 : ( screen : PScreen );
                              #          4 : ( pixmap_format : PScreenFormat );
                              #          5 : ( font : PXFontStruct );

  PXFontSetExtents* = ptr TXFontSetExtents
  TXFontSetExtents*{.final.} = object
    max_ink_extent*: TXRectangle
    max_logical_extent*: TXRectangle

  PXOM* = ptr TXOM
  TXOM*{.final.} = object
  PXOC* = ptr TXOC
  TXOC*{.final.} = object
  TXFontSet* = PXOC
  PXFontSet* = ptr TXFontSet
  PXmbTextItem* = ptr TXmbTextItem
  TXmbTextItem*{.final.} = object
    chars*: cstring
    nchars*: cint
    delta*: cint
    font_set*: TXFontSet

  PXwcTextItem* = ptr TXwcTextItem
  TXwcTextItem*{.final.} = object
    chars*: PWideChar         #wchar_t*
    nchars*: cint
    delta*: cint
    font_set*: TXFontSet


const
  XNRequiredCharSet* = "requiredCharSet"
  XNQueryOrientation* = "queryOrientation"
  XNBaseFontName* = "baseFontName"
  XNOMAutomatic* = "omAutomatic"
  XNMissingCharSet* = "missingCharSet"
  XNDefaultString* = "defaultString"
  XNOrientation* = "orientation"
  XNDirectionalDependentDrawing* = "directionalDependentDrawing"
  XNContextualDrawing* = "contextualDrawing"
  XNFontInfo* = "fontInfo"

type
  PXOMcharSetList* = ptr TXOMcharSetList
  TXOMcharSetList*{.final.} = object
    charset_count*: cint
    charset_list*: PPchar

  PXOrientation* = ptr TXOrientation
  TXOrientation* = enum
    XOMOrientation_LTR_TTB, XOMOrientation_RTL_TTB, XOMOrientation_TTB_LTR,
    XOMOrientation_TTB_RTL, XOMOrientation_Context
  PXOMOrientation* = ptr TXOMOrientation
  TXOMOrientation*{.final.} = object
    num_orientation*: cint
    orientation*: PXOrientation

  PXOMFontInfo* = ptr TXOMFontInfo
  TXOMFontInfo*{.final.} = object
    num_font*: cint
    font_struct_list*: ptr PXFontStruct
    font_name_list*: PPchar

  PXIM* = ptr TXIM
  TXIM*{.final.} = object
  PXIC* = ptr TXIC
  TXIC*{.final.} = object
  TXIMProc* = proc (para1: TXIM, para2: TXpointer, para3: TXpointer){.cdecl.}
  TXICProc* = proc (para1: TXIC, para2: TXpointer, para3: TXpointer): Tbool{.
      cdecl.}
  TXIDProc* = proc (para1: PDisplay, para2: TXpointer, para3: TXpointer){.cdecl.}
  PXIMStyle* = ptr TXIMStyle
  TXIMStyle* = culong
  PXIMStyles* = ptr TXIMStyles
  TXIMStyles*{.final.} = object
    count_styles*: cushort
    supported_styles*: PXIMStyle


const
  XIMPreeditArea* = 0x00000001
  XIMPreeditCallbacks* = 0x00000002
  XIMPreeditPosition* = 0x00000004
  XIMPreeditNothing* = 0x00000008
  XIMPreeditNone* = 0x00000010
  XIMStatusArea* = 0x00000100
  XIMStatusCallbacks* = 0x00000200
  XIMStatusNothing* = 0x00000400
  XIMStatusNone* = 0x00000800
  XNVaNestedList* = "XNVaNestedList"
  XNQueryInputStyle* = "queryInputStyle"
  XNClientWindow* = "clientWindow"
  XNInputStyle* = "inputStyle"
  XNFocusWindow* = "focusWindow"
  XNResourceName* = "resourceName"
  XNResourceClass* = "resourceClass"
  XNGeometryCallback* = "geometryCallback"
  XNDestroyCallback* = "destroyCallback"
  XNFilterEvents* = "filterEvents"
  XNPreeditStartCallback* = "preeditStartCallback"
  XNPreeditDoneCallback* = "preeditDoneCallback"
  XNPreeditDrawCallback* = "preeditDrawCallback"
  XNPreeditCaretCallback* = "preeditCaretCallback"
  XNPreeditStateNotifyCallback* = "preeditStateNotifyCallback"
  XNPreeditAttributes* = "preeditAttributes"
  XNStatusStartCallback* = "statusStartCallback"
  XNStatusDoneCallback* = "statusDoneCallback"
  XNStatusDrawCallback* = "statusDrawCallback"
  XNStatusAttributes* = "statusAttributes"
  XNArea* = "area"
  XNAreaNeeded* = "areaNeeded"
  XNSpotLocation* = "spotLocation"
  XNColormap* = "colorMap"
  XNStdColormap* = "stdColorMap"
  XNForeground* = "foreground"
  XNBackground* = "background"
  XNBackgroundPixmap* = "backgroundPixmap"
  XNFontSet* = "fontSet"
  XNLineSpace* = "lineSpace"
  XNCursor* = "cursor"
  XNQueryIMValuesList* = "queryIMValuesList"
  XNQueryICValuesList* = "queryICValuesList"
  XNVisiblePosition* = "visiblePosition"
  XNR6PreeditCallback* = "r6PreeditCallback"
  XNStringConversionCallback* = "stringConversionCallback"
  XNStringConversion* = "stringConversion"
  XNResetState* = "resetState"
  XNHotKey* = "hotKey"
  XNHotKeyState* = "hotKeyState"
  XNPreeditState* = "preeditState"
  XNSeparatorofNestedList* = "separatorofNestedList"
  XBufferOverflow* = - (1)
  XLookupNone* = 1
  XLookupChars* = 2
  XLookupKeySymVal* = 3
  XLookupBoth* = 4

type
  PXVaNestedList* = ptr TXVaNestedList
  TXVaNestedList* = pointer
  PXIMCallback* = ptr TXIMCallback
  TXIMCallback*{.final.} = object
    client_data*: TXpointer
    callback*: TXIMProc

  PXICCallback* = ptr TXICCallback
  TXICCallback*{.final.} = object
    client_data*: TXpointer
    callback*: TXICProc

  PXIMFeedback* = ptr TXIMFeedback
  TXIMFeedback* = culong

const
  XIMReverse* = 1
  XIMUnderline* = 1 shl 1
  XIMHighlight* = 1 shl 2
  XIMPrimary* = 1 shl 5
  XIMSecondary* = 1 shl 6
  XIMTertiary* = 1 shl 7
  XIMVisibleToForward* = 1 shl 8
  XIMVisibleToBackword* = 1 shl 9
  XIMVisibleToCenter* = 1 shl 10

type
  PXIMText* = ptr TXIMText
  TXIMText*{.final.} = object
    len*: cushort
    feedback*: PXIMFeedback
    encoding_is_wchar*: Tbool
    multi_byte*: cstring

  PXIMPreeditState* = ptr TXIMPreeditState
  TXIMPreeditState* = culong

const
  XIMPreeditUnKnown* = 0
  XIMPreeditEnable* = 1
  XIMPreeditDisable* = 1 shl 1

type
  PXIMPreeditStateNotifyCallbackStruct* = ptr TXIMPreeditStateNotifyCallbackStruct
  TXIMPreeditStateNotifyCallbackStruct*{.final.} = object
    state*: TXIMPreeditState

  PXIMResetState* = ptr TXIMResetState
  TXIMResetState* = culong

const
  XIMInitialState* = 1
  XIMPreserveState* = 1 shl 1

type
  PXIMStringConversionFeedback* = ptr TXIMStringConversionFeedback
  TXIMStringConversionFeedback* = culong

const
  XIMStringConversionLeftEdge* = 0x00000001
  XIMStringConversionRightEdge* = 0x00000002
  XIMStringConversionTopEdge* = 0x00000004
  XIMStringConversionBottomEdge* = 0x00000008
  XIMStringConversionConcealed* = 0x00000010
  XIMStringConversionWrapped* = 0x00000020

type
  PXIMStringConversionText* = ptr TXIMStringConversionText
  TXIMStringConversionText*{.final.} = object
    len*: cushort
    feedback*: PXIMStringConversionFeedback
    encoding_is_wchar*: Tbool
    mbs*: cstring

  PXIMStringConversionPosition* = ptr TXIMStringConversionPosition
  TXIMStringConversionPosition* = cushort
  PXIMStringConversionType* = ptr TXIMStringConversionType
  TXIMStringConversionType* = cushort

const
  XIMStringConversionBuffer* = 0x00000001
  XIMStringConversionLine* = 0x00000002
  XIMStringConversionWord* = 0x00000003
  XIMStringConversionChar* = 0x00000004

type
  PXIMStringConversionOperation* = ptr TXIMStringConversionOperation
  TXIMStringConversionOperation* = cushort

const
  XIMStringConversionSubstitution* = 0x00000001
  XIMStringConversionRetrieval* = 0x00000002

type
  PXIMCaretDirection* = ptr TXIMCaretDirection
  TXIMCaretDirection* = enum
    XIMForwardChar, XIMBackwardChar, XIMForwardWord, XIMBackwardWord,
    XIMCaretUp, XIMCaretDown, XIMNextLine, XIMPreviousLine, XIMLineStart,
    XIMLineEnd, XIMAbsolutePosition, XIMDontChange
  PXIMStringConversionCallbackStruct* = ptr TXIMStringConversionCallbackStruct
  TXIMStringConversionCallbackStruct*{.final.} = object
    position*: TXIMStringConversionPosition
    direction*: TXIMCaretDirection
    operation*: TXIMStringConversionOperation
    factor*: cushort
    text*: PXIMStringConversionText

  PXIMPreeditDrawCallbackStruct* = ptr TXIMPreeditDrawCallbackStruct
  TXIMPreeditDrawCallbackStruct*{.final.} = object
    caret*: cint
    chg_first*: cint
    chg_length*: cint
    text*: PXIMText

  PXIMCaretStyle* = ptr TXIMCaretStyle
  TXIMCaretStyle* = enum
    XIMIsInvisible, XIMIsPrimary, XIMIsSecondary
  PXIMPreeditCaretCallbackStruct* = ptr TXIMPreeditCaretCallbackStruct
  TXIMPreeditCaretCallbackStruct*{.final.} = object
    position*: cint
    direction*: TXIMCaretDirection
    style*: TXIMCaretStyle

  PXIMStatusDataType* = ptr TXIMStatusDataType
  TXIMStatusDataType* = enum
    XIMTextType, XIMBitmapType
  PXIMStatusDrawCallbackStruct* = ptr TXIMStatusDrawCallbackStruct
  TXIMStatusDrawCallbackStruct*{.final.} = object
    theType*: TXIMStatusDataType
    bitmap*: TPixmap

  PXIMHotKeyTrigger* = ptr TXIMHotKeyTrigger
  TXIMHotKeyTrigger*{.final.} = object
    keysym*: TKeySym
    modifier*: cint
    modifier_mask*: cint

  PXIMHotKeyTriggers* = ptr TXIMHotKeyTriggers
  TXIMHotKeyTriggers*{.final.} = object
    num_hot_key*: cint
    key*: PXIMHotKeyTrigger

  PXIMHotKeyState* = ptr TXIMHotKeyState
  TXIMHotKeyState* = culong

const
  XIMHotKeyStateON* = 0x00000001
  XIMHotKeyStateOFF* = 0x00000002

type
  PXIMValuesList* = ptr TXIMValuesList
  TXIMValuesList*{.final.} = object
    count_values*: cushort
    supported_values*: PPchar


type
  funcdisp* = proc (display: PDisplay): cint{.cdecl.}
  funcifevent* = proc (display: PDisplay, event: PXEvent, p: TXpointer): Tbool{.
      cdecl.}
  chararr32* = array[0..31, char]

const
  AllPlanes*: culong = culong(not 0)

proc xLoadQueryFont*(para1: PDisplay, para2: cstring): PXFontStruct{.cdecl,
    dynlib: libX11, importc.}
proc xQueryFont*(para1: PDisplay, para2: TXID): PXFontStruct{.cdecl,
    dynlib: libX11, importc.}
proc xGetMotionEvents*(para1: PDisplay, para2: TWindow, para3: TTime,
                       para4: TTime, para5: Pcint): PXTimeCoord{.cdecl,
    dynlib: libX11, importc.}
proc xDeleteModifiermapEntry*(para1: PXModifierKeymap, para2: TKeyCode,
                              para3: cint): PXModifierKeymap{.cdecl,
    dynlib: libX11, importc.}
proc xGetModifierMapping*(para1: PDisplay): PXModifierKeymap{.cdecl,
    dynlib: libX11, importc.}
proc xInsertModifiermapEntry*(para1: PXModifierKeymap, para2: TKeyCode,
                              para3: cint): PXModifierKeymap{.cdecl,
    dynlib: libX11, importc.}
proc xNewModifiermap*(para1: cint): PXModifierKeymap{.cdecl, dynlib: libX11,
    importc.}
proc xCreateImage*(para1: PDisplay, para2: PVisual, para3: cuint, para4: cint,
                   para5: cint, para6: cstring, para7: cuint, para8: cuint,
                   para9: cint, para10: cint): PXImage{.cdecl, dynlib: libX11,
    importc.}
proc xInitImage*(para1: PXImage): TStatus{.cdecl, dynlib: libX11, importc.}
proc xGetImage*(para1: PDisplay, para2: TDrawable, para3: cint, para4: cint,
                para5: cuint, para6: cuint, para7: culong, para8: cint): PXImage{.
    cdecl, dynlib: libX11, importc.}
proc xGetSubImage*(para1: PDisplay, para2: TDrawable, para3: cint, para4: cint,
                   para5: cuint, para6: cuint, para7: culong, para8: cint,
                   para9: PXImage, para10: cint, para11: cint): PXImage{.cdecl,
    dynlib: libX11, importc.}
proc xOpenDisplay*(para1: cstring): PDisplay{.cdecl, dynlib: libX11, importc.}
proc xrmInitialize*(){.cdecl, dynlib: libX11, importc.}
proc xFetchBytes*(para1: PDisplay, para2: Pcint): cstring{.cdecl,
    dynlib: libX11, importc.}
proc xFetchBuffer*(para1: PDisplay, para2: Pcint, para3: cint): cstring{.cdecl,
    dynlib: libX11, importc.}
proc xGetAtomName*(para1: PDisplay, para2: TAtom): cstring{.cdecl,
    dynlib: libX11, importc.}
proc xGetAtomNames*(para1: PDisplay, para2: PAtom, para3: cint, para4: PPchar): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetDefault*(para1: PDisplay, para2: cstring, para3: cstring): cstring{.
    cdecl, dynlib: libX11, importc.}
proc xDisplayName*(para1: cstring): cstring{.cdecl, dynlib: libX11, importc.}
proc xKeysymToString*(para1: TKeySym): cstring{.cdecl, dynlib: libX11, importc.}
proc xSynchronize*(para1: PDisplay, para2: Tbool): funcdisp{.cdecl,
    dynlib: libX11, importc.}
proc xSetAfterFunction*(para1: PDisplay, para2: funcdisp): funcdisp{.cdecl,
    dynlib: libX11, importc.}
proc xInternAtom*(para1: PDisplay, para2: cstring, para3: Tbool): TAtom{.cdecl,
    dynlib: libX11, importc.}
proc xInternAtoms*(para1: PDisplay, para2: PPchar, para3: cint, para4: Tbool,
                   para5: PAtom): TStatus{.cdecl, dynlib: libX11, importc.}
proc xCopyColormapAndFree*(para1: PDisplay, para2: TColormap): TColormap{.cdecl,
    dynlib: libX11, importc.}
proc xCreateColormap*(para1: PDisplay, para2: TWindow, para3: PVisual,
                      para4: cint): TColormap{.cdecl, dynlib: libX11, importc.}
proc xCreatePixmapCursor*(para1: PDisplay, para2: TPixmap, para3: TPixmap,
                          para4: PXColor, para5: PXColor, para6: cuint,
                          para7: cuint): TCursor{.cdecl, dynlib: libX11, importc.}
proc xCreateGlyphCursor*(para1: PDisplay, para2: TFont, para3: TFont,
                         para4: cuint, para5: cuint, para6: PXColor,
                         para7: PXColor): TCursor{.cdecl, dynlib: libX11,
    importc.}
proc xCreateFontCursor*(para1: PDisplay, para2: cuint): TCursor{.cdecl,
    dynlib: libX11, importc.}
proc xLoadFont*(para1: PDisplay, para2: cstring): TFont{.cdecl, dynlib: libX11,
    importc.}
proc xCreateGC*(para1: PDisplay, para2: TDrawable, para3: culong,
                para4: PXGCValues): TGC{.cdecl, dynlib: libX11, importc.}
proc xGContextFromGC*(para1: TGC): TGContext{.cdecl, dynlib: libX11, importc.}
proc xFlushGC*(para1: PDisplay, para2: TGC){.cdecl, dynlib: libX11, importc.}
proc xCreatePixmap*(para1: PDisplay, para2: TDrawable, para3: cuint,
                    para4: cuint, para5: cuint): TPixmap{.cdecl, dynlib: libX11,
    importc.}
proc xCreateBitmapFromData*(para1: PDisplay, para2: TDrawable, para3: cstring,
                            para4: cuint, para5: cuint): TPixmap{.cdecl,
    dynlib: libX11, importc.}
proc xCreatePixmapFromBitmapData*(para1: PDisplay, para2: TDrawable,
                                  para3: cstring, para4: cuint, para5: cuint,
                                  para6: culong, para7: culong, para8: cuint): TPixmap{.
    cdecl, dynlib: libX11, importc.}
proc xCreateSimpleWindow*(para1: PDisplay, para2: TWindow, para3: cint,
                          para4: cint, para5: cuint, para6: cuint, para7: cuint,
                          para8: culong, para9: culong): TWindow{.cdecl,
    dynlib: libX11, importc.}
proc xGetSelectionOwner*(para1: PDisplay, para2: TAtom): TWindow{.cdecl,
    dynlib: libX11, importc.}
proc xCreateWindow*(para1: PDisplay, para2: TWindow, para3: cint, para4: cint,
                    para5: cuint, para6: cuint, para7: cuint, para8: cint,
                    para9: cuint, para10: PVisual, para11: culong,
                    para12: PXSetWindowAttributes): TWindow{.cdecl,
    dynlib: libX11, importc.}
proc xListInstalledColormaps*(para1: PDisplay, para2: TWindow, para3: Pcint): PColormap{.
    cdecl, dynlib: libX11, importc.}
proc xListFonts*(para1: PDisplay, para2: cstring, para3: cint, para4: Pcint): PPchar{.
    cdecl, dynlib: libX11, importc.}
proc xListFontsWithInfo*(para1: PDisplay, para2: cstring, para3: cint,
                         para4: Pcint, para5: PPXFontStruct): PPchar{.cdecl,
    dynlib: libX11, importc.}
proc xGetFontPath*(para1: PDisplay, para2: Pcint): PPchar{.cdecl,
    dynlib: libX11, importc.}
proc xListExtensions*(para1: PDisplay, para2: Pcint): PPchar{.cdecl,
    dynlib: libX11, importc.}
proc xListProperties*(para1: PDisplay, para2: TWindow, para3: Pcint): PAtom{.
    cdecl, dynlib: libX11, importc.}
proc xListHosts*(para1: PDisplay, para2: Pcint, para3: Pbool): PXHostAddress{.
    cdecl, dynlib: libX11, importc.}
proc xKeycodeToKeysym*(para1: PDisplay, para2: TKeyCode, para3: cint): TKeySym{.
    cdecl, dynlib: libX11, importc.}
proc xLookupKeysym*(para1: PXKeyEvent, para2: cint): TKeySym{.cdecl,
    dynlib: libX11, importc.}
proc xGetKeyboardMapping*(para1: PDisplay, para2: TKeyCode, para3: cint,
                          para4: Pcint): PKeySym{.cdecl, dynlib: libX11, importc.}
proc xStringToKeysym*(para1: cstring): TKeySym{.cdecl, dynlib: libX11, importc.}
proc xMaxRequestSize*(para1: PDisplay): clong{.cdecl, dynlib: libX11, importc.}
proc xExtendedMaxRequestSize*(para1: PDisplay): clong{.cdecl, dynlib: libX11,
    importc.}
proc xResourceManagerString*(para1: PDisplay): cstring{.cdecl, dynlib: libX11,
    importc.}
proc xScreenResourceString*(para1: PScreen): cstring{.cdecl, dynlib: libX11,
    importc.}
proc xDisplayMotionBufferSize*(para1: PDisplay): culong{.cdecl, dynlib: libX11,
    importc.}
proc xVisualIDFromVisual*(para1: PVisual): TVisualID{.cdecl, dynlib: libX11,
    importc.}
proc xInitThreads*(): TStatus{.cdecl, dynlib: libX11, importc.}
proc xLockDisplay*(para1: PDisplay){.cdecl, dynlib: libX11, importc.}
proc xUnlockDisplay*(para1: PDisplay){.cdecl, dynlib: libX11, importc.}
proc xInitExtension*(para1: PDisplay, para2: cstring): PXExtCodes{.cdecl,
    dynlib: libX11, importc.}
proc xAddExtension*(para1: PDisplay): PXExtCodes{.cdecl, dynlib: libX11, importc.}
proc xFindOnExtensionList*(para1: PPXExtData, para2: cint): PXExtData{.cdecl,
    dynlib: libX11, importc.}
proc xEHeadOfExtensionList*(para1: TXEDataObject): PPXExtData{.cdecl,
    dynlib: libX11, importc.}
proc xRootWindow*(para1: PDisplay, para2: cint): TWindow{.cdecl, dynlib: libX11,
    importc.}
proc xDefaultRootWindow*(para1: PDisplay): TWindow{.cdecl, dynlib: libX11,
    importc.}
proc xRootWindowOfScreen*(para1: PScreen): TWindow{.cdecl, dynlib: libX11,
    importc.}
proc xDefaultVisual*(para1: PDisplay, para2: cint): PVisual{.cdecl,
    dynlib: libX11, importc.}
proc xDefaultVisualOfScreen*(para1: PScreen): PVisual{.cdecl, dynlib: libX11,
    importc.}
proc xDefaultGC*(para1: PDisplay, para2: cint): TGC{.cdecl, dynlib: libX11,
    importc.}
proc xDefaultGCOfScreen*(para1: PScreen): TGC{.cdecl, dynlib: libX11, importc.}
proc xBlackPixel*(para1: PDisplay, para2: cint): culong{.cdecl, dynlib: libX11,
    importc.}
proc xWhitePixel*(para1: PDisplay, para2: cint): culong{.cdecl, dynlib: libX11,
    importc.}
proc xAllPlanes*(): culong{.cdecl, dynlib: libX11, importc.}
proc xBlackPixelOfScreen*(para1: PScreen): culong{.cdecl, dynlib: libX11,
    importc.}
proc xWhitePixelOfScreen*(para1: PScreen): culong{.cdecl, dynlib: libX11,
    importc.}
proc xNextRequest*(para1: PDisplay): culong{.cdecl, dynlib: libX11, importc.}
proc xLastKnownRequestProcessed*(para1: PDisplay): culong{.cdecl,
    dynlib: libX11, importc.}
proc xServerVendor*(para1: PDisplay): cstring{.cdecl, dynlib: libX11, importc.}
proc xDisplayString*(para1: PDisplay): cstring{.cdecl, dynlib: libX11, importc.}
proc xDefaultColormap*(para1: PDisplay, para2: cint): TColormap{.cdecl,
    dynlib: libX11, importc.}
proc xDefaultColormapOfScreen*(para1: PScreen): TColormap{.cdecl,
    dynlib: libX11, importc.}
proc xDisplayOfScreen*(para1: PScreen): PDisplay{.cdecl, dynlib: libX11, importc.}
proc xScreenOfDisplay*(para1: PDisplay, para2: cint): PScreen{.cdecl,
    dynlib: libX11, importc.}
proc xDefaultScreenOfDisplay*(para1: PDisplay): PScreen{.cdecl, dynlib: libX11,
    importc.}
proc xEventMaskOfScreen*(para1: PScreen): clong{.cdecl, dynlib: libX11, importc.}
proc xScreenNumberOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11,
    importc.}
type
  TXErrorHandler* = proc (para1: PDisplay, para2: PXErrorEvent): cint{.cdecl.}

proc xSetErrorHandler*(para1: TXErrorHandler): TXErrorHandler{.cdecl,
    dynlib: libX11, importc.}
type
  TXIOErrorHandler* = proc (para1: PDisplay): cint{.cdecl.}

proc xSetIOErrorHandler*(para1: TXIOErrorHandler): TXIOErrorHandler{.cdecl,
    dynlib: libX11, importc.}
proc xListPixmapFormats*(para1: PDisplay, para2: Pcint): PXPixmapFormatValues{.
    cdecl, dynlib: libX11, importc.}
proc xListDepths*(para1: PDisplay, para2: cint, para3: Pcint): Pcint{.cdecl,
    dynlib: libX11, importc.}
proc xReconfigureWMWindow*(para1: PDisplay, para2: TWindow, para3: cint,
                           para4: cuint, para5: PXWindowChanges): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetWMProtocols*(para1: PDisplay, para2: TWindow, para3: PPAtom,
                      para4: Pcint): TStatus{.cdecl, dynlib: libX11, importc.}
proc xSetWMProtocols*(para1: PDisplay, para2: TWindow, para3: PAtom, para4: cint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xIconifyWindow*(para1: PDisplay, para2: TWindow, para3: cint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xWithdrawWindow*(para1: PDisplay, para2: TWindow, para3: cint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetCommand*(para1: PDisplay, para2: TWindow, para3: PPPchar, para4: Pcint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetWMColormapWindows*(para1: PDisplay, para2: TWindow, para3: PPWindow,
                            para4: Pcint): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xSetWMColormapWindows*(para1: PDisplay, para2: TWindow, para3: PWindow,
                            para4: cint): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xFreeStringList*(para1: PPchar){.cdecl, dynlib: libX11, importc.}
proc xSetTransientForHint*(para1: PDisplay, para2: TWindow, para3: TWindow): cint{.
    cdecl, dynlib: libX11, importc.}
proc xActivateScreenSaver*(para1: PDisplay): cint{.cdecl, dynlib: libX11,
    importc.}
proc xAddHost*(para1: PDisplay, para2: PXHostAddress): cint{.cdecl,
    dynlib: libX11, importc.}
proc xAddHosts*(para1: PDisplay, para2: PXHostAddress, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xAddToExtensionList*(para1: PPXExtData, para2: PXExtData): cint{.cdecl,
    dynlib: libX11, importc.}
proc xAddToSaveSet*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xallocColor*(para1: PDisplay, para2: TColormap, para3: PXColor): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xallocColorCells*(para1: PDisplay, para2: TColormap, para3: Tbool,
                       para4: Pculong, para5: cuint, para6: Pculong,
                       para7: cuint): TStatus{.cdecl, dynlib: libX11, importc.}
proc xallocColorPlanes*(para1: PDisplay, para2: TColormap, para3: Tbool,
                        para4: Pculong, para5: cint, para6: cint, para7: cint,
                        para8: cint, para9: Pculong, para10: Pculong,
                        para11: Pculong): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xallocNamedColor*(para1: PDisplay, para2: TColormap, para3: cstring,
                       para4: PXColor, para5: PXColor): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xAllowEvents*(para1: PDisplay, para2: cint, para3: TTime): cint{.cdecl,
    dynlib: libX11, importc.}
proc xAutoRepeatOff*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xAutoRepeatOn*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xBell*(para1: PDisplay, para2: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xBitmapBitOrder*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xBitmapPad*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xBitmapUnit*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xCellsOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xChangeActivePointerGrab*(para1: PDisplay, para2: cuint, para3: TCursor,
                               para4: TTime): cint{.cdecl, dynlib: libX11,
    importc.}
proc xChangeGC*(para1: PDisplay, para2: TGC, para3: culong, para4: PXGCValues): cint{.
    cdecl, dynlib: libX11, importc.}
proc xChangeKeyboardControl*(para1: PDisplay, para2: culong,
                             para3: PXKeyboardControl): cint{.cdecl,
    dynlib: libX11, importc.}
proc xChangeKeyboardMapping*(para1: PDisplay, para2: cint, para3: cint,
                             para4: PKeySym, para5: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xChangePointerControl*(para1: PDisplay, para2: Tbool, para3: Tbool,
                            para4: cint, para5: cint, para6: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xChangeProperty*(para1: PDisplay, para2: TWindow, para3: TAtom,
                      para4: TAtom, para5: cint, para6: cint, para7: Pcuchar,
                      para8: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xChangeSaveSet*(para1: PDisplay, para2: TWindow, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xChangeWindowAttributes*(para1: PDisplay, para2: TWindow, para3: culong,
                              para4: PXSetWindowAttributes): cint{.cdecl,
    dynlib: libX11, importc.}
proc xCheckIfEvent*(para1: PDisplay, para2: PXEvent, para3: funcifevent,
                    para4: TXpointer): Tbool{.cdecl, dynlib: libX11, importc.}
proc xCheckMaskEvent*(para1: PDisplay, para2: clong, para3: PXEvent): Tbool{.
    cdecl, dynlib: libX11, importc.}
proc xCheckTypedEvent*(para1: PDisplay, para2: cint, para3: PXEvent): Tbool{.
    cdecl, dynlib: libX11, importc.}
proc xCheckTypedWindowEvent*(para1: PDisplay, para2: TWindow, para3: cint,
                             para4: PXEvent): Tbool{.cdecl, dynlib: libX11,
    importc.}
proc xCheckWindowEvent*(para1: PDisplay, para2: TWindow, para3: clong,
                        para4: PXEvent): Tbool{.cdecl, dynlib: libX11, importc.}
proc xCirculateSubwindows*(para1: PDisplay, para2: TWindow, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xCirculateSubwindowsDown*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xCirculateSubwindowsUp*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xClearArea*(para1: PDisplay, para2: TWindow, para3: cint, para4: cint,
                 para5: cuint, para6: cuint, para7: Tbool): cint{.cdecl,
    dynlib: libX11, importc.}
proc xClearWindow*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xCloseDisplay*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xConfigureWindow*(para1: PDisplay, para2: TWindow, para3: cuint,
                       para4: PXWindowChanges): cint{.cdecl, dynlib: libX11,
    importc.}
proc xConnectionNumber*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xConvertSelection*(para1: PDisplay, para2: TAtom, para3: TAtom,
                        para4: TAtom, para5: TWindow, para6: TTime): cint{.
    cdecl, dynlib: libX11, importc.}
proc xCopyArea*(para1: PDisplay, para2: TDrawable, para3: TDrawable, para4: TGC,
                para5: cint, para6: cint, para7: cuint, para8: cuint,
                para9: cint, para10: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xCopyGC*(para1: PDisplay, para2: TGC, para3: culong, para4: TGC): cint{.
    cdecl, dynlib: libX11, importc.}
proc xCopyPlane*(para1: PDisplay, para2: TDrawable, para3: TDrawable,
                 para4: TGC, para5: cint, para6: cint, para7: cuint,
                 para8: cuint, para9: cint, para10: cint, para11: culong): cint{.
    cdecl, dynlib: libX11, importc.}
proc xDefaultDepth*(para1: PDisplay, para2: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDefaultDepthOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDefaultScreen*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xDefineCursor*(para1: PDisplay, para2: TWindow, para3: TCursor): cint{.
    cdecl, dynlib: libX11, importc.}
proc xDeleteProperty*(para1: PDisplay, para2: TWindow, para3: TAtom): cint{.
    cdecl, dynlib: libX11, importc.}
proc xDestroyWindow*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDestroySubwindows*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDoesBackingStore*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xDoesSaveUnders*(para1: PScreen): Tbool{.cdecl, dynlib: libX11, importc.}
proc xDisableAccessControl*(para1: PDisplay): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDisplayCells*(para1: PDisplay, para2: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDisplayHeight*(para1: PDisplay, para2: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDisplayHeightMM*(para1: PDisplay, para2: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDisplayKeycodes*(para1: PDisplay, para2: Pcint, para3: Pcint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xDisplayPlanes*(para1: PDisplay, para2: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDisplayWidth*(para1: PDisplay, para2: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDisplayWidthMM*(para1: PDisplay, para2: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDrawArc*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
               para5: cint, para6: cuint, para7: cuint, para8: cint, para9: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xDrawArcs*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXArc,
                para5: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xDrawImageString*(para1: PDisplay, para2: TDrawable, para3: TGC,
                       para4: cint, para5: cint, para6: cstring, para7: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xDrawImageString16*(para1: PDisplay, para2: TDrawable, para3: TGC,
                         para4: cint, para5: cint, para6: PXchar2b, para7: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xDrawLine*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                para5: cint, para6: cint, para7: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDrawLines*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXPoint,
                 para5: cint, para6: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xDrawPoint*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                 para5: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xDrawPoints*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXPoint,
                  para5: cint, para6: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDrawRectangle*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                     para5: cint, para6: cuint, para7: cuint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDrawRectangles*(para1: PDisplay, para2: TDrawable, para3: TGC,
                      para4: PXRectangle, para5: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDrawSegments*(para1: PDisplay, para2: TDrawable, para3: TGC,
                    para4: PXSegment, para5: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xDrawString*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                  para5: cint, para6: cstring, para7: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDrawString16*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                    para5: cint, para6: PXchar2b, para7: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDrawText*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                para5: cint, para6: PXTextItem, para7: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xDrawText16*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                  para5: cint, para6: PXTextItem16, para7: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xEnableAccessControl*(para1: PDisplay): cint{.cdecl, dynlib: libX11,
    importc.}
proc xEventsQueued*(para1: PDisplay, para2: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xFetchName*(para1: PDisplay, para2: TWindow, para3: PPchar): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xFillArc*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
               para5: cint, para6: cuint, para7: cuint, para8: cint, para9: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xFillArcs*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXArc,
                para5: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xFillPolygon*(para1: PDisplay, para2: TDrawable, para3: TGC,
                   para4: PXPoint, para5: cint, para6: cint, para7: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xFillRectangle*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                     para5: cint, para6: cuint, para7: cuint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xFillRectangles*(para1: PDisplay, para2: TDrawable, para3: TGC,
                      para4: PXRectangle, para5: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xFlush*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xForceScreenSaver*(para1: PDisplay, para2: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xFree*(para1: pointer): cint{.cdecl, dynlib: libX11, importc.}
proc xFreeColormap*(para1: PDisplay, para2: TColormap): cint{.cdecl,
    dynlib: libX11, importc.}
proc xFreeColors*(para1: PDisplay, para2: TColormap, para3: Pculong,
                  para4: cint, para5: culong): cint{.cdecl, dynlib: libX11,
    importc.}
proc xFreeCursor*(para1: PDisplay, para2: TCursor): cint{.cdecl, dynlib: libX11,
    importc.}
proc xFreeExtensionList*(para1: PPchar): cint{.cdecl, dynlib: libX11, importc.}
proc xFreeFont*(para1: PDisplay, para2: PXFontStruct): cint{.cdecl,
    dynlib: libX11, importc.}
proc xFreeFontInfo*(para1: PPchar, para2: PXFontStruct, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xFreeFontNames*(para1: PPchar): cint{.cdecl, dynlib: libX11, importc.}
proc xFreeFontPath*(para1: PPchar): cint{.cdecl, dynlib: libX11, importc.}
proc xFreeGC*(para1: PDisplay, para2: TGC): cint{.cdecl, dynlib: libX11, importc.}
proc xFreeModifiermap*(para1: PXModifierKeymap): cint{.cdecl, dynlib: libX11,
    importc.}
proc xFreePixmap*(para1: PDisplay, para2: TPixmap): cint{.cdecl, dynlib: libX11,
    importc.}
proc xGeometry*(para1: PDisplay, para2: cint, para3: cstring, para4: cstring,
                para5: cuint, para6: cuint, para7: cuint, para8: cint,
                para9: cint, para10: Pcint, para11: Pcint, para12: Pcint,
                para13: Pcint): cint{.cdecl, dynlib: libX11, importc.}
proc xGetErrorDatabaseText*(para1: PDisplay, para2: cstring, para3: cstring,
                            para4: cstring, para5: cstring, para6: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xGetErrorText*(para1: PDisplay, para2: cint, para3: cstring, para4: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xGetFontProperty*(para1: PXFontStruct, para2: TAtom, para3: Pculong): Tbool{.
    cdecl, dynlib: libX11, importc.}
proc xGetGCValues*(para1: PDisplay, para2: TGC, para3: culong, para4: PXGCValues): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetGeometry*(para1: PDisplay, para2: TDrawable, para3: PWindow,
                   para4: Pcint, para5: Pcint, para6: Pcuint, para7: Pcuint,
                   para8: Pcuint, para9: Pcuint): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xGetIconName*(para1: PDisplay, para2: TWindow, para3: PPchar): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetInputFocus*(para1: PDisplay, para2: PWindow, para3: Pcint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xGetKeyboardControl*(para1: PDisplay, para2: PXKeyboardState): cint{.cdecl,
    dynlib: libX11, importc.}
proc xGetPointerControl*(para1: PDisplay, para2: Pcint, para3: Pcint,
                         para4: Pcint): cint{.cdecl, dynlib: libX11, importc.}
proc xGetPointerMapping*(para1: PDisplay, para2: Pcuchar, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xGetScreenSaver*(para1: PDisplay, para2: Pcint, para3: Pcint, para4: Pcint,
                      para5: Pcint): cint{.cdecl, dynlib: libX11, importc.}
proc xGetTransientForHint*(para1: PDisplay, para2: TWindow, para3: PWindow): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xGetWindowProperty*(para1: PDisplay, para2: TWindow, para3: TAtom,
                         para4: clong, para5: clong, para6: Tbool, para7: TAtom,
                         para8: PAtom, para9: Pcint, para10: Pculong,
                         para11: Pculong, para12: PPcuchar): cint{.cdecl,
    dynlib: libX11, importc.}
proc xGetWindowAttributes*(para1: PDisplay, para2: TWindow,
                           para3: PXWindowAttributes): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xGrabButton*(para1: PDisplay, para2: cuint, para3: cuint, para4: TWindow,
                  para5: Tbool, para6: cuint, para7: cint, para8: cint,
                  para9: TWindow, para10: TCursor): cint{.cdecl, dynlib: libX11,
    importc.}
proc xGrabKey*(para1: PDisplay, para2: cint, para3: cuint, para4: TWindow,
               para5: Tbool, para6: cint, para7: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xGrabKeyboard*(para1: PDisplay, para2: TWindow, para3: Tbool, para4: cint,
                    para5: cint, para6: TTime): cint{.cdecl, dynlib: libX11,
    importc.}
proc xGrabPointer*(para1: PDisplay, para2: TWindow, para3: Tbool, para4: cuint,
                   para5: cint, para6: cint, para7: TWindow, para8: TCursor,
                   para9: TTime): cint{.cdecl, dynlib: libX11, importc.}
proc xGrabServer*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xHeightMMOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xHeightOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xIfEvent*(para1: PDisplay, para2: PXEvent, para3: funcifevent,
               para4: TXpointer): cint{.cdecl, dynlib: libX11, importc.}
proc xImageByteOrder*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xInstallColormap*(para1: PDisplay, para2: TColormap): cint{.cdecl,
    dynlib: libX11, importc.}
proc xKeysymToKeycode*(para1: PDisplay, para2: TKeySym): TKeyCode{.cdecl,
    dynlib: libX11, importc.}
proc xKillClient*(para1: PDisplay, para2: TXID): cint{.cdecl, dynlib: libX11,
    importc.}
proc xLookupColor*(para1: PDisplay, para2: TColormap, para3: cstring,
                   para4: PXColor, para5: PXColor): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xLowerWindow*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xMapRaised*(para1: PDisplay, para2: TWindow): cint{.cdecl, dynlib: libX11,
    importc.}
proc xMapSubwindows*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xMapWindow*(para1: PDisplay, para2: TWindow): cint{.cdecl, dynlib: libX11,
    importc.}
proc xMaskEvent*(para1: PDisplay, para2: clong, para3: PXEvent): cint{.cdecl,
    dynlib: libX11, importc.}
proc xMaxCmapsOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xMinCmapsOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xMoveResizeWindow*(para1: PDisplay, para2: TWindow, para3: cint,
                        para4: cint, para5: cuint, para6: cuint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xMoveWindow*(para1: PDisplay, para2: TWindow, para3: cint, para4: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xNextEvent*(para1: PDisplay, para2: PXEvent): cint{.cdecl, dynlib: libX11,
    importc.}
proc xNoOp*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xParseColor*(para1: PDisplay, para2: TColormap, para3: cstring,
                  para4: PXColor): TStatus{.cdecl, dynlib: libX11, importc.}
proc xParseGeometry*(para1: cstring, para2: Pcint, para3: Pcint, para4: Pcuint,
                     para5: Pcuint): cint{.cdecl, dynlib: libX11, importc.}
proc xPeekEvent*(para1: PDisplay, para2: PXEvent): cint{.cdecl, dynlib: libX11,
    importc.}
proc xPeekIfEvent*(para1: PDisplay, para2: PXEvent, para3: funcifevent,
                   para4: TXpointer): cint{.cdecl, dynlib: libX11, importc.}
proc xPending*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xPlanesOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xProtocolRevision*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xProtocolVersion*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xPutBackEvent*(para1: PDisplay, para2: PXEvent): cint{.cdecl,
    dynlib: libX11, importc.}
proc xPutImage*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXImage,
                para5: cint, para6: cint, para7: cint, para8: cint,
                para9: cuint, para10: cuint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xQlength*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xQueryBestCursor*(para1: PDisplay, para2: TDrawable, para3: cuint,
                       para4: cuint, para5: Pcuint, para6: Pcuint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xQueryBestSize*(para1: PDisplay, para2: cint, para3: TDrawable,
                     para4: cuint, para5: cuint, para6: Pcuint, para7: Pcuint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xQueryBestStipple*(para1: PDisplay, para2: TDrawable, para3: cuint,
                        para4: cuint, para5: Pcuint, para6: Pcuint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xQueryBestTile*(para1: PDisplay, para2: TDrawable, para3: cuint,
                     para4: cuint, para5: Pcuint, para6: Pcuint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xQueryColor*(para1: PDisplay, para2: TColormap, para3: PXColor): cint{.
    cdecl, dynlib: libX11, importc.}
proc xQueryColors*(para1: PDisplay, para2: TColormap, para3: PXColor,
                   para4: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xQueryExtension*(para1: PDisplay, para2: cstring, para3: Pcint,
                      para4: Pcint, para5: Pcint): Tbool{.cdecl, dynlib: libX11,
    importc.}
  #?
proc xQueryKeymap*(para1: PDisplay, para2: chararr32): cint{.cdecl,
    dynlib: libX11, importc.}
proc xQueryPointer*(para1: PDisplay, para2: TWindow, para3: PWindow,
                    para4: PWindow, para5: Pcint, para6: Pcint, para7: Pcint,
                    para8: Pcint, para9: Pcuint): Tbool{.cdecl, dynlib: libX11,
    importc.}
proc xQueryTextExtents*(para1: PDisplay, para2: TXID, para3: cstring,
                        para4: cint, para5: Pcint, para6: Pcint, para7: Pcint,
                        para8: PXcharStruct): cint{.cdecl, dynlib: libX11,
    importc.}
proc xQueryTextExtents16*(para1: PDisplay, para2: TXID, para3: PXchar2b,
                          para4: cint, para5: Pcint, para6: Pcint, para7: Pcint,
                          para8: PXcharStruct): cint{.cdecl, dynlib: libX11,
    importc.}
proc xQueryTree*(para1: PDisplay, para2: TWindow, para3: PWindow,
                 para4: PWindow, para5: PPWindow, para6: Pcuint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xRaiseWindow*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xReadBitmapFile*(para1: PDisplay, para2: TDrawable, para3: cstring,
                      para4: Pcuint, para5: Pcuint, para6: PPixmap,
                      para7: Pcint, para8: Pcint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xReadBitmapFileData*(para1: cstring, para2: Pcuint, para3: Pcuint,
                          para4: PPcuchar, para5: Pcint, para6: Pcint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xRebindKeysym*(para1: PDisplay, para2: TKeySym, para3: PKeySym,
                    para4: cint, para5: Pcuchar, para6: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xRecolorCursor*(para1: PDisplay, para2: TCursor, para3: PXColor,
                     para4: PXColor): cint{.cdecl, dynlib: libX11, importc.}
proc xRefreshKeyboardMapping*(para1: PXMappingEvent): cint{.cdecl,
    dynlib: libX11, importc.}
proc xRemoveFromSaveSet*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xRemoveHost*(para1: PDisplay, para2: PXHostAddress): cint{.cdecl,
    dynlib: libX11, importc.}
proc xRemoveHosts*(para1: PDisplay, para2: PXHostAddress, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xReparentWindow*(para1: PDisplay, para2: TWindow, para3: TWindow,
                      para4: cint, para5: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xResetScreenSaver*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xResizeWindow*(para1: PDisplay, para2: TWindow, para3: cuint, para4: cuint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xRestackWindows*(para1: PDisplay, para2: PWindow, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xRotateBuffers*(para1: PDisplay, para2: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xRotateWindowProperties*(para1: PDisplay, para2: TWindow, para3: PAtom,
                              para4: cint, para5: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xScreenCount*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xSelectInput*(para1: PDisplay, para2: TWindow, para3: clong): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSendEvent*(para1: PDisplay, para2: TWindow, para3: Tbool, para4: clong,
                 para5: PXEvent): TStatus{.cdecl, dynlib: libX11, importc.}
proc xSetAccessControl*(para1: PDisplay, para2: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetArcMode*(para1: PDisplay, para2: TGC, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetBackground*(para1: PDisplay, para2: TGC, para3: culong): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetClipMask*(para1: PDisplay, para2: TGC, para3: TPixmap): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetClipOrigin*(para1: PDisplay, para2: TGC, para3: cint, para4: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetClipRectangles*(para1: PDisplay, para2: TGC, para3: cint, para4: cint,
                         para5: PXRectangle, para6: cint, para7: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetCloseDownMode*(para1: PDisplay, para2: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetCommand*(para1: PDisplay, para2: TWindow, para3: PPchar, para4: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetDashes*(para1: PDisplay, para2: TGC, para3: cint, para4: cstring,
                 para5: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xSetFillRule*(para1: PDisplay, para2: TGC, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetFillStyle*(para1: PDisplay, para2: TGC, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetFont*(para1: PDisplay, para2: TGC, para3: TFont): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetFontPath*(para1: PDisplay, para2: PPchar, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetForeground*(para1: PDisplay, para2: TGC, para3: culong): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetFunction*(para1: PDisplay, para2: TGC, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetGraphicsExposures*(para1: PDisplay, para2: TGC, para3: Tbool): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetIconName*(para1: PDisplay, para2: TWindow, para3: cstring): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetInputFocus*(para1: PDisplay, para2: TWindow, para3: cint, para4: TTime): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetLineAttributes*(para1: PDisplay, para2: TGC, para3: cuint, para4: cint,
                         para5: cint, para6: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xSetModifierMapping*(para1: PDisplay, para2: PXModifierKeymap): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetPlaneMask*(para1: PDisplay, para2: TGC, para3: culong): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetPointerMapping*(para1: PDisplay, para2: Pcuchar, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetScreenSaver*(para1: PDisplay, para2: cint, para3: cint, para4: cint,
                      para5: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xSetSelectionOwner*(para1: PDisplay, para2: TAtom, para3: TWindow,
                         para4: TTime): cint{.cdecl, dynlib: libX11, importc.}
proc xSetState*(para1: PDisplay, para2: TGC, para3: culong, para4: culong,
                para5: cint, para6: culong): cint{.cdecl, dynlib: libX11,
    importc.}
proc xSetStipple*(para1: PDisplay, para2: TGC, para3: TPixmap): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetSubwindowMode*(para1: PDisplay, para2: TGC, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetTSOrigin*(para1: PDisplay, para2: TGC, para3: cint, para4: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetTile*(para1: PDisplay, para2: TGC, para3: TPixmap): cint{.cdecl,
    dynlib: libX11, importc.}
proc xSetWindowBackground*(para1: PDisplay, para2: TWindow, para3: culong): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetWindowBackgroundPixmap*(para1: PDisplay, para2: TWindow, para3: TPixmap): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetWindowBorder*(para1: PDisplay, para2: TWindow, para3: culong): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetWindowBorderPixmap*(para1: PDisplay, para2: TWindow, para3: TPixmap): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetWindowBorderWidth*(para1: PDisplay, para2: TWindow, para3: cuint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSetWindowColormap*(para1: PDisplay, para2: TWindow, para3: TColormap): cint{.
    cdecl, dynlib: libX11, importc.}
proc xStoreBuffer*(para1: PDisplay, para2: cstring, para3: cint, para4: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xStoreBytes*(para1: PDisplay, para2: cstring, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xStoreColor*(para1: PDisplay, para2: TColormap, para3: PXColor): cint{.
    cdecl, dynlib: libX11, importc.}
proc xStoreColors*(para1: PDisplay, para2: TColormap, para3: PXColor,
                   para4: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xStoreName*(para1: PDisplay, para2: TWindow, para3: cstring): cint{.cdecl,
    dynlib: libX11, importc.}
proc xStoreNamedColor*(para1: PDisplay, para2: TColormap, para3: cstring,
                       para4: culong, para5: cint): cint{.cdecl, dynlib: libX11,
    importc.}
proc xSync*(para1: PDisplay, para2: Tbool): cint{.cdecl, dynlib: libX11, importc.}
proc xTextExtents*(para1: PXFontStruct, para2: cstring, para3: cint,
                   para4: Pcint, para5: Pcint, para6: Pcint, para7: PXcharStruct): cint{.
    cdecl, dynlib: libX11, importc.}
proc xTextExtents16*(para1: PXFontStruct, para2: PXchar2b, para3: cint,
                     para4: Pcint, para5: Pcint, para6: Pcint,
                     para7: PXcharStruct): cint{.cdecl, dynlib: libX11, importc.}
proc xTextWidth*(para1: PXFontStruct, para2: cstring, para3: cint): cint{.cdecl,
    dynlib: libX11, importc.}
proc xTextWidth16*(para1: PXFontStruct, para2: PXchar2b, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xTranslateCoordinates*(para1: PDisplay, para2: TWindow, para3: TWindow,
                            para4: cint, para5: cint, para6: Pcint,
                            para7: Pcint, para8: PWindow): Tbool{.cdecl,
    dynlib: libX11, importc.}
proc xUndefineCursor*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xUngrabButton*(para1: PDisplay, para2: cuint, para3: cuint, para4: TWindow): cint{.
    cdecl, dynlib: libX11, importc.}
proc xUngrabKey*(para1: PDisplay, para2: cint, para3: cuint, para4: TWindow): cint{.
    cdecl, dynlib: libX11, importc.}
proc xUngrabKeyboard*(para1: PDisplay, para2: TTime): cint{.cdecl,
    dynlib: libX11, importc.}
proc xUngrabPointer*(para1: PDisplay, para2: TTime): cint{.cdecl,
    dynlib: libX11, importc.}
proc xUngrabServer*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xUninstallColormap*(para1: PDisplay, para2: TColormap): cint{.cdecl,
    dynlib: libX11, importc.}
proc xUnloadFont*(para1: PDisplay, para2: TFont): cint{.cdecl, dynlib: libX11,
    importc.}
proc xUnmapSubwindows*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xUnmapWindow*(para1: PDisplay, para2: TWindow): cint{.cdecl,
    dynlib: libX11, importc.}
proc xVendorRelease*(para1: PDisplay): cint{.cdecl, dynlib: libX11, importc.}
proc xWarpPointer*(para1: PDisplay, para2: TWindow, para3: TWindow, para4: cint,
                   para5: cint, para6: cuint, para7: cuint, para8: cint,
                   para9: cint): cint{.cdecl, dynlib: libX11, importc.}
proc xWidthMMOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xWidthOfScreen*(para1: PScreen): cint{.cdecl, dynlib: libX11, importc.}
proc xWindowEvent*(para1: PDisplay, para2: TWindow, para3: clong, para4: PXEvent): cint{.
    cdecl, dynlib: libX11, importc.}
proc xWriteBitmapFile*(para1: PDisplay, para2: cstring, para3: TPixmap,
                       para4: cuint, para5: cuint, para6: cint, para7: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xSupportsLocale*(): Tbool{.cdecl, dynlib: libX11, importc.}
proc xSetLocaleModifiers*(para1: cstring): cstring{.cdecl, dynlib: libX11,
    importc.}
proc xOpenOM*(para1: PDisplay, para2: PXrmHashBucketRec, para3: cstring,
              para4: cstring): TXOM{.cdecl, dynlib: libX11, importc.}
proc xCloseOM*(para1: TXOM): TStatus{.cdecl, dynlib: libX11, importc.}
proc xSetOMValues*(para1: TXOM): cstring{.varargs, cdecl, dynlib: libX11,
    importc.}
proc xGetOMValues*(para1: TXOM): cstring{.varargs, cdecl, dynlib: libX11,
    importc.}
proc xDisplayOfOM*(para1: TXOM): PDisplay{.cdecl, dynlib: libX11, importc.}
proc xLocaleOfOM*(para1: TXOM): cstring{.cdecl, dynlib: libX11, importc.}
proc xCreateOC*(para1: TXOM): TXOC{.varargs, cdecl, dynlib: libX11, importc.}
proc xDestroyOC*(para1: TXOC){.cdecl, dynlib: libX11, importc.}
proc xOMOfOC*(para1: TXOC): TXOM{.cdecl, dynlib: libX11, importc.}
proc xSetOCValues*(para1: TXOC): cstring{.varargs, cdecl, dynlib: libX11,
    importc.}
proc xGetOCValues*(para1: TXOC): cstring{.varargs, cdecl, dynlib: libX11,
    importc.}
proc xCreateFontSet*(para1: PDisplay, para2: cstring, para3: PPPchar,
                     para4: Pcint, para5: PPchar): TXFontSet{.cdecl,
    dynlib: libX11, importc.}
proc xFreeFontSet*(para1: PDisplay, para2: TXFontSet){.cdecl, dynlib: libX11,
    importc.}
proc xFontsOfFontSet*(para1: TXFontSet, para2: PPPXFontStruct, para3: PPPchar): cint{.
    cdecl, dynlib: libX11, importc.}
proc xBaseFontNameListOfFontSet*(para1: TXFontSet): cstring{.cdecl,
    dynlib: libX11, importc.}
proc xLocaleOfFontSet*(para1: TXFontSet): cstring{.cdecl, dynlib: libX11,
    importc.}
proc xContextDependentDrawing*(para1: TXFontSet): Tbool{.cdecl, dynlib: libX11,
    importc.}
proc xDirectionalDependentDrawing*(para1: TXFontSet): Tbool{.cdecl,
    dynlib: libX11, importc.}
proc xContextualDrawing*(para1: TXFontSet): Tbool{.cdecl, dynlib: libX11,
    importc.}
proc xExtentsOfFontSet*(para1: TXFontSet): PXFontSetExtents{.cdecl,
    dynlib: libX11, importc.}
proc xmbTextEscapement*(para1: TXFontSet, para2: cstring, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xwcTextEscapement*(para1: TXFontSet, para2: PWideChar, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xutf8TextEscapement*(para1: TXFontSet, para2: cstring, para3: cint): cint{.
    cdecl, dynlib: libX11, importc.}
proc xmbTextExtents*(para1: TXFontSet, para2: cstring, para3: cint,
                     para4: PXRectangle, para5: PXRectangle): cint{.cdecl,
    dynlib: libX11, importc.}
proc xwcTextExtents*(para1: TXFontSet, para2: PWideChar, para3: cint,
                     para4: PXRectangle, para5: PXRectangle): cint{.cdecl,
    dynlib: libX11, importc.}
proc xutf8TextExtents*(para1: TXFontSet, para2: cstring, para3: cint,
                       para4: PXRectangle, para5: PXRectangle): cint{.cdecl,
    dynlib: libX11, importc.}
proc xmbTextPerCharExtents*(para1: TXFontSet, para2: cstring, para3: cint,
                            para4: PXRectangle, para5: PXRectangle, para6: cint,
                            para7: Pcint, para8: PXRectangle, para9: PXRectangle): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xwcTextPerCharExtents*(para1: TXFontSet, para2: PWideChar, para3: cint,
                            para4: PXRectangle, para5: PXRectangle, para6: cint,
                            para7: Pcint, para8: PXRectangle, para9: PXRectangle): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xutf8TextPerCharExtents*(para1: TXFontSet, para2: cstring, para3: cint,
                              para4: PXRectangle, para5: PXRectangle,
                              para6: cint, para7: Pcint, para8: PXRectangle,
                              para9: PXRectangle): TStatus{.cdecl,
    dynlib: libX11, importc.}
proc xmbDrawText*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                  para5: cint, para6: PXmbTextItem, para7: cint){.cdecl,
    dynlib: libX11, importc.}
proc xwcDrawText*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                  para5: cint, para6: PXwcTextItem, para7: cint){.cdecl,
    dynlib: libX11, importc.}
proc xutf8DrawText*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: cint,
                    para5: cint, para6: PXmbTextItem, para7: cint){.cdecl,
    dynlib: libX11, importc.}
proc xmbDrawString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet,
                    para4: TGC, para5: cint, para6: cint, para7: cstring,
                    para8: cint){.cdecl, dynlib: libX11, importc.}
proc xwcDrawString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet,
                    para4: TGC, para5: cint, para6: cint, para7: PWideChar,
                    para8: cint){.cdecl, dynlib: libX11, importc.}
proc xutf8DrawString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet,
                      para4: TGC, para5: cint, para6: cint, para7: cstring,
                      para8: cint){.cdecl, dynlib: libX11, importc.}
proc xmbDrawImageString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet,
                         para4: TGC, para5: cint, para6: cint, para7: cstring,
                         para8: cint){.cdecl, dynlib: libX11, importc.}
proc xwcDrawImageString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet,
                         para4: TGC, para5: cint, para6: cint, para7: PWideChar,
                         para8: cint){.cdecl, dynlib: libX11, importc.}
proc xutf8DrawImageString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet,
                           para4: TGC, para5: cint, para6: cint, para7: cstring,
                           para8: cint){.cdecl, dynlib: libX11, importc.}
proc xOpenIM*(para1: PDisplay, para2: PXrmHashBucketRec, para3: cstring,
              para4: cstring): TXIM{.cdecl, dynlib: libX11, importc.}
proc xCloseIM*(para1: TXIM): TStatus{.cdecl, dynlib: libX11, importc.}
proc xGetIMValues*(para1: TXIM): cstring{.varargs, cdecl, dynlib: libX11,
    importc.}
proc xSetIMValues*(para1: TXIM): cstring{.varargs, cdecl, dynlib: libX11,
    importc.}
proc xDisplayOfIM*(para1: TXIM): PDisplay{.cdecl, dynlib: libX11, importc.}
proc xLocaleOfIM*(para1: TXIM): cstring{.cdecl, dynlib: libX11, importc.}
proc xCreateIC*(para1: TXIM): TXIC{.varargs, cdecl, dynlib: libX11, importc.}
proc xDestroyIC*(para1: TXIC){.cdecl, dynlib: libX11, importc.}
proc xSetICFocus*(para1: TXIC){.cdecl, dynlib: libX11, importc.}
proc xUnsetICFocus*(para1: TXIC){.cdecl, dynlib: libX11, importc.}
proc xwcResetIC*(para1: TXIC): PWideChar{.cdecl, dynlib: libX11, importc.}
proc xmbResetIC*(para1: TXIC): cstring{.cdecl, dynlib: libX11, importc.}
proc xutf8ResetIC*(para1: TXIC): cstring{.cdecl, dynlib: libX11, importc.}
proc xSetICValues*(para1: TXIC): cstring{.varargs, cdecl, dynlib: libX11,
    importc.}
proc xGetICValues*(para1: TXIC): cstring{.varargs, cdecl, dynlib: libX11,
    importc.}
proc xIMOfIC*(para1: TXIC): TXIM{.cdecl, dynlib: libX11, importc.}
proc xFilterEvent*(para1: PXEvent, para2: TWindow): Tbool{.cdecl,
    dynlib: libX11, importc.}
proc xmbLookupString*(para1: TXIC, para2: PXKeyPressedEvent, para3: cstring,
                      para4: cint, para5: PKeySym, para6: PStatus): cint{.cdecl,
    dynlib: libX11, importc.}
proc xwcLookupString*(para1: TXIC, para2: PXKeyPressedEvent, para3: PWideChar,
                      para4: cint, para5: PKeySym, para6: PStatus): cint{.cdecl,
    dynlib: libX11, importc.}
proc xutf8LookupString*(para1: TXIC, para2: PXKeyPressedEvent, para3: cstring,
                        para4: cint, para5: PKeySym, para6: PStatus): cint{.
    cdecl, dynlib: libX11, importc.}
proc xVaCreateNestedList*(unused: cint): TXVaNestedList{.varargs, cdecl,
    dynlib: libX11, importc.}
proc xRegisterIMInstantiateCallback*(para1: PDisplay, para2: PXrmHashBucketRec,
                                     para3: cstring, para4: cstring,
                                     para5: TXIDProc, para6: TXpointer): Tbool{.
    cdecl, dynlib: libX11, importc.}
proc xUnregisterIMInstantiateCallback*(para1: PDisplay,
                                       para2: PXrmHashBucketRec, para3: cstring,
                                       para4: cstring, para5: TXIDProc,
                                       para6: TXpointer): Tbool{.cdecl,
    dynlib: libX11, importc.}
type
  TXConnectionWatchProc* = proc (para1: PDisplay, para2: TXpointer, para3: cint,
                                 para4: Tbool, para5: PXpointer){.cdecl.}

proc xInternalConnectionNumbers*(para1: PDisplay, para2: PPcint, para3: Pcint): TStatus{.
    cdecl, dynlib: libX11, importc.}
proc xProcessInternalConnection*(para1: PDisplay, para2: cint){.cdecl,
    dynlib: libX11, importc.}
proc xAddConnectionWatch*(para1: PDisplay, para2: TXConnectionWatchProc,
                          para3: TXpointer): TStatus{.cdecl, dynlib: libX11,
    importc.}
proc xRemoveConnectionWatch*(para1: PDisplay, para2: TXConnectionWatchProc,
                             para3: TXpointer){.cdecl, dynlib: libX11, importc.}
proc xSetAuthorization*(para1: cstring, para2: cint, para3: cstring, para4: cint){.
    cdecl, dynlib: libX11, importc.}
  #
  #  _Xmbtowc?
  #  _Xwctomb?
  #
when defined(MACROS):
  proc connectionNumber*(dpy: PDisplay): cint
  proc rootWindow*(dpy: PDisplay, scr: cint): TWindow
  proc defaultScreen*(dpy: PDisplay): cint
  proc defaultRootWindow*(dpy: PDisplay): TWindow
  proc defaultVisual*(dpy: PDisplay, scr: cint): PVisual
  proc defaultGC*(dpy: PDisplay, scr: cint): TGC
  proc blackPixel*(dpy: PDisplay, scr: cint): culong
  proc whitePixel*(dpy: PDisplay, scr: cint): culong
  proc qLength*(dpy: PDisplay): cint
  proc displayWidth*(dpy: PDisplay, scr: cint): cint
  proc displayHeight*(dpy: PDisplay, scr: cint): cint
  proc displayWidthMM*(dpy: PDisplay, scr: cint): cint
  proc displayHeightMM*(dpy: PDisplay, scr: cint): cint
  proc displayPlanes*(dpy: PDisplay, scr: cint): cint
  proc displayCells*(dpy: PDisplay, scr: cint): cint
  proc screenCount*(dpy: PDisplay): cint
  proc serverVendor*(dpy: PDisplay): cstring
  proc protocolVersion*(dpy: PDisplay): cint
  proc protocolRevision*(dpy: PDisplay): cint
  proc vendorRelease*(dpy: PDisplay): cint
  proc displayString*(dpy: PDisplay): cstring
  proc defaultDepth*(dpy: PDisplay, scr: cint): cint
  proc defaultColormap*(dpy: PDisplay, scr: cint): TColormap
  proc bitmapUnit*(dpy: PDisplay): cint
  proc bitmapBitOrder*(dpy: PDisplay): cint
  proc bitmapPad*(dpy: PDisplay): cint
  proc imageByteOrder*(dpy: PDisplay): cint
  proc nextRequest*(dpy: PDisplay): culong
  proc lastKnownRequestProcessed*(dpy: PDisplay): culong
  proc screenOfDisplay*(dpy: PDisplay, scr: cint): PScreen
  proc defaultScreenOfDisplay*(dpy: PDisplay): PScreen
  proc displayOfScreen*(s: PScreen): PDisplay
  proc rootWindowOfScreen*(s: PScreen): TWindow
  proc blackPixelOfScreen*(s: PScreen): culong
  proc whitePixelOfScreen*(s: PScreen): culong
  proc defaultColormapOfScreen*(s: PScreen): TColormap
  proc defaultDepthOfScreen*(s: PScreen): cint
  proc defaultGCOfScreen*(s: PScreen): TGC
  proc defaultVisualOfScreen*(s: PScreen): PVisual
  proc widthOfScreen*(s: PScreen): cint
  proc heightOfScreen*(s: PScreen): cint
  proc widthMMOfScreen*(s: PScreen): cint
  proc heightMMOfScreen*(s: PScreen): cint
  proc planesOfScreen*(s: PScreen): cint
  proc cellsOfScreen*(s: PScreen): cint
  proc minCmapsOfScreen*(s: PScreen): cint
  proc maxCmapsOfScreen*(s: PScreen): cint
  proc doesSaveUnders*(s: PScreen): Tbool
  proc doesBackingStore*(s: PScreen): cint
  proc eventMaskOfScreen*(s: PScreen): clong
  proc xallocID*(dpy: PDisplay): TXID
# implementation

when defined(MACROS):
  proc connectionNumber(dpy: PDisplay): cint =
    ConnectionNumber = (PXPrivDisplay(dpy))[] .fd

  proc rootWindow(dpy: PDisplay, scr: cint): TWindow =
    RootWindow = (ScreenOfDisplay(dpy, scr))[] .root

  proc defaultScreen(dpy: PDisplay): cint =
    DefaultScreen = (PXPrivDisplay(dpy))[] .default_screen

  proc defaultRootWindow(dpy: PDisplay): TWindow =
    DefaultRootWindow = (ScreenOfDisplay(dpy, DefaultScreen(dpy)))[] .root

  proc defaultVisual(dpy: PDisplay, scr: cint): PVisual =
    DefaultVisual = (ScreenOfDisplay(dpy, scr))[] .root_visual

  proc defaultGC(dpy: PDisplay, scr: cint): TGC =
    DefaultGC = (ScreenOfDisplay(dpy, scr))[] .default_gc

  proc blackPixel(dpy: PDisplay, scr: cint): culong =
    BlackPixel = (ScreenOfDisplay(dpy, scr))[] .black_pixel

  proc whitePixel(dpy: PDisplay, scr: cint): culong =
    WhitePixel = (ScreenOfDisplay(dpy, scr))[] .white_pixel

  proc qLength(dpy: PDisplay): cint =
    Qlength = (PXPrivDisplay(dpy))[] .qlen

  proc displayWidth(dpy: PDisplay, scr: cint): cint =
    DisplayWidth = (ScreenOfDisplay(dpy, scr))[] .width

  proc displayHeight(dpy: PDisplay, scr: cint): cint =
    DisplayHeight = (ScreenOfDisplay(dpy, scr))[] .height

  proc displayWidthMM(dpy: PDisplay, scr: cint): cint =
    DisplayWidthMM = (ScreenOfDisplay(dpy, scr))[] .mwidth

  proc displayHeightMM(dpy: PDisplay, scr: cint): cint =
    DisplayHeightMM = (ScreenOfDisplay(dpy, scr))[] .mheight

  proc displayPlanes(dpy: PDisplay, scr: cint): cint =
    DisplayPlanes = (ScreenOfDisplay(dpy, scr))[] .root_depth

  proc displayCells(dpy: PDisplay, scr: cint): cint =
    DisplayCells = (DefaultVisual(dpy, scr))[] .map_entries

  proc screenCount(dpy: PDisplay): cint =
    ScreenCount = (PXPrivDisplay(dpy))[] .nscreens

  proc serverVendor(dpy: PDisplay): cstring =
    ServerVendor = (PXPrivDisplay(dpy))[] .vendor

  proc protocolVersion(dpy: PDisplay): cint =
    ProtocolVersion = (PXPrivDisplay(dpy))[] .proto_major_version

  proc protocolRevision(dpy: PDisplay): cint =
    ProtocolRevision = (PXPrivDisplay(dpy))[] .proto_minor_version

  proc vendorRelease(dpy: PDisplay): cint =
    VendorRelease = (PXPrivDisplay(dpy))[] .release

  proc displayString(dpy: PDisplay): cstring =
    DisplayString = (PXPrivDisplay(dpy))[] .display_name

  proc defaultDepth(dpy: PDisplay, scr: cint): cint =
    DefaultDepth = (ScreenOfDisplay(dpy, scr))[] .root_depth

  proc defaultColormap(dpy: PDisplay, scr: cint): TColormap =
    DefaultColormap = (ScreenOfDisplay(dpy, scr))[] .cmap

  proc bitmapUnit(dpy: PDisplay): cint =
    BitmapUnit = (PXPrivDisplay(dpy))[] .bitmap_unit

  proc bitmapBitOrder(dpy: PDisplay): cint =
    BitmapBitOrder = (PXPrivDisplay(dpy))[] .bitmap_bit_order

  proc bitmapPad(dpy: PDisplay): cint =
    BitmapPad = (PXPrivDisplay(dpy))[] .bitmap_pad

  proc imageByteOrder(dpy: PDisplay): cint =
    ImageByteOrder = (PXPrivDisplay(dpy))[] .byte_order

  proc nextRequest(dpy: PDisplay): culong =
    NextRequest = ((PXPrivDisplay(dpy))[] .request) + 1

  proc lastKnownRequestProcessed(dpy: PDisplay): culong =
    LastKnownRequestProcessed = (PXPrivDisplay(dpy))[] .last_request_read

  proc screenOfDisplay(dpy: PDisplay, scr: cint): PScreen =
    ScreenOfDisplay = addr((((PXPrivDisplay(dpy))[] .screens)[scr]))

  proc defaultScreenOfDisplay(dpy: PDisplay): PScreen =
    DefaultScreenOfDisplay = ScreenOfDisplay(dpy, DefaultScreen(dpy))

  proc displayOfScreen(s: PScreen): PDisplay =
    DisplayOfScreen = s[] .display

  proc rootWindowOfScreen(s: PScreen): TWindow =
    RootWindowOfScreen = s[] .root

  proc blackPixelOfScreen(s: PScreen): culong =
    BlackPixelOfScreen = s[] .black_pixel

  proc whitePixelOfScreen(s: PScreen): culong =
    WhitePixelOfScreen = s[] .white_pixel

  proc defaultColormapOfScreen(s: PScreen): TColormap =
    DefaultColormapOfScreen = s[] .cmap

  proc defaultDepthOfScreen(s: PScreen): cint =
    DefaultDepthOfScreen = s[] .root_depth

  proc defaultGCOfScreen(s: PScreen): TGC =
    DefaultGCOfScreen = s[] .default_gc

  proc defaultVisualOfScreen(s: PScreen): PVisual =
    DefaultVisualOfScreen = s[] .root_visual

  proc widthOfScreen(s: PScreen): cint =
    WidthOfScreen = s[] .width

  proc heightOfScreen(s: PScreen): cint =
    HeightOfScreen = s[] .height

  proc widthMMOfScreen(s: PScreen): cint =
    WidthMMOfScreen = s[] .mwidth

  proc heightMMOfScreen(s: PScreen): cint =
    HeightMMOfScreen = s[] .mheight

  proc planesOfScreen(s: PScreen): cint =
    PlanesOfScreen = s[] .root_depth

  proc cellsOfScreen(s: PScreen): cint =
    CellsOfScreen = (DefaultVisualOfScreen(s))[] .map_entries

  proc minCmapsOfScreen(s: PScreen): cint =
    MinCmapsOfScreen = s[] .min_maps

  proc maxCmapsOfScreen(s: PScreen): cint =
    MaxCmapsOfScreen = s[] .max_maps

  proc doesSaveUnders(s: PScreen): Tbool =
    DoesSaveUnders = s[] .save_unders

  proc doesBackingStore(s: PScreen): cint =
    DoesBackingStore = s[] .backing_store

  proc eventMaskOfScreen(s: PScreen): clong =
    EventMaskOfScreen = s[] .root_input_mask

  proc xallocID(dpy: PDisplay): TXID =
    XallocID = (PXPrivDisplay(dpy))[] .resource_alloc(dpy)
