
import 
  x

include "x11pragma.nim"

type
  Cunsigned* = Cint
  Pcint* = ptr Cint
  PPcint* = ptr Pcint
  PPcuchar* = ptr ptr Cuchar
  PWideChar* = ptr Int16
  PPChar* = ptr Cstring
  PPPChar* = ptr ptr Cstring
  Pculong* = ptr Culong
  Pcuchar* = Cstring
  Pcuint* = ptr Cuint
  Pcushort* = ptr Uint16
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
  PXPointer* = ptr TXPointer
  TXPointer* = ptr Char
  PBool* = ptr TBool
  TBool* = Int           #cint?
  PStatus* = ptr TStatus
  TStatus* = Cint

const 
  QueuedAlready* = 0
  QueuedAfterReading* = 1
  QueuedAfterFlush* = 2

type 
  PPXExtData* = ptr PXExtData
  PXExtData* = ptr TXExtData
  TXExtData*{.final.} = object 
    number*: Cint
    next*: PXExtData
    free_private*: proc (extension: PXExtData): Cint{.cdecl.}
    private_data*: TXPointer

  PXExtCodes* = ptr TXExtCodes
  TXExtCodes*{.final.} = object 
    extension*: Cint
    major_opcode*: Cint
    first_event*: Cint
    first_error*: Cint

  PXPixmapFormatValues* = ptr TXPixmapFormatValues
  TXPixmapFormatValues*{.final.} = object 
    depth*: Cint
    bits_per_pixel*: Cint
    scanline_pad*: Cint

  PXGCValues* = ptr TXGCValues
  TXGCValues*{.final.} = object 
    function*: Cint
    plane_mask*: Culong
    foreground*: Culong
    background*: Culong
    line_width*: Cint
    line_style*: Cint
    cap_style*: Cint
    join_style*: Cint
    fill_style*: Cint
    fill_rule*: Cint
    arc_mode*: Cint
    tile*: TPixmap
    stipple*: TPixmap
    ts_x_origin*: Cint
    ts_y_origin*: Cint
    font*: TFont
    subwindow_mode*: Cint
    graphics_exposures*: TBool
    clip_x_origin*: Cint
    clip_y_origin*: Cint
    clip_mask*: TPixmap
    dash_offset*: Cint
    dashes*: Cchar

  Pxgc* = ptr TXGC
  TXGC*{.final.} = object 
  TGC* = Pxgc
  Pgc* = ptr TGC
  PVisual* = ptr TVisual
  TVisual*{.final.} = object 
    ext_data*: PXExtData
    visualid*: TVisualID
    c_class*: Cint
    red_mask*, green_mask*, blue_mask*: Culong
    bits_per_rgb*: Cint
    map_entries*: Cint

  PDepth* = ptr TDepth
  TDepth*{.final.} = object 
    depth*: Cint
    nvisuals*: Cint
    visuals*: PVisual

  PXDisplay* = ptr TXDisplay
  TXDisplay*{.final.} = object 
  PScreen* = ptr TScreen
  TScreen*{.final.} = object 
    ext_data*: PXExtData
    display*: PXDisplay
    root*: TWindow
    width*, height*: Cint
    mwidth*, mheight*: Cint
    ndepths*: Cint
    depths*: PDepth
    root_depth*: Cint
    root_visual*: PVisual
    default_gc*: TGC
    cmap*: TColormap
    white_pixel*: Culong
    black_pixel*: Culong
    max_maps*, min_maps*: Cint
    backing_store*: Cint
    save_unders*: TBool
    root_input_mask*: Clong

  PScreenFormat* = ptr TScreenFormat
  TScreenFormat*{.final.} = object 
    ext_data*: PXExtData
    depth*: Cint
    bits_per_pixel*: Cint
    scanline_pad*: Cint

  PXSetWindowAttributes* = ptr TXSetWindowAttributes
  TXSetWindowAttributes*{.final.} = object 
    background_pixmap*: TPixmap
    background_pixel*: Culong
    border_pixmap*: TPixmap
    border_pixel*: Culong
    bit_gravity*: Cint
    win_gravity*: Cint
    backing_store*: Cint
    backing_planes*: Culong
    backing_pixel*: Culong
    save_under*: TBool
    event_mask*: Clong
    do_not_propagate_mask*: Clong
    override_redirect*: TBool
    colormap*: TColormap
    cursor*: TCursor

  PXWindowAttributes* = ptr TXWindowAttributes
  TXWindowAttributes*{.final.} = object 
    x*, y*: Cint
    width*, height*: Cint
    border_width*: Cint
    depth*: Cint
    visual*: PVisual
    root*: TWindow
    c_class*: Cint
    bit_gravity*: Cint
    win_gravity*: Cint
    backing_store*: Cint
    backing_planes*: Culong
    backing_pixel*: Culong
    save_under*: TBool
    colormap*: TColormap
    map_installed*: TBool
    map_state*: Cint
    all_event_masks*: Clong
    your_event_mask*: Clong
    do_not_propagate_mask*: Clong
    override_redirect*: TBool
    screen*: PScreen

  PXHostAddress* = ptr TXHostAddress
  TXHostAddress*{.final.} = object 
    family*: Cint
    len*: Cint
    address*: Cstring

  PXServerInterpretedAddress* = ptr TXServerInterpretedAddress
  TXServerInterpretedAddress*{.final.} = object 
    typelength*: Cint
    valuelength*: Cint
    theType*: Cstring
    value*: Cstring

  PXImage* = ptr TXImage
  TF*{.final.} = object 
    create_image*: proc (para1: PXDisplay, para2: PVisual, para3: Cuint, 
                         para4: Cint, para5: Cint, para6: Cstring, para7: Cuint, 
                         para8: Cuint, para9: Cint, para10: Cint): PXImage{.
        cdecl.}
    destroy_image*: proc (para1: PXImage): Cint{.cdecl.}
    get_pixel*: proc (para1: PXImage, para2: Cint, para3: Cint): Culong{.cdecl.}
    put_pixel*: proc (para1: PXImage, para2: Cint, para3: Cint, para4: Culong): Cint{.
        cdecl.}
    sub_image*: proc (para1: PXImage, para2: Cint, para3: Cint, para4: Cuint, 
                      para5: Cuint): PXImage{.cdecl.}
    add_pixel*: proc (para1: PXImage, para2: Clong): Cint{.cdecl.}

  TXImage*{.final.} = object 
    width*, height*: Cint
    xoffset*: Cint
    format*: Cint
    data*: Cstring
    byte_order*: Cint
    bitmap_unit*: Cint
    bitmap_bit_order*: Cint
    bitmap_pad*: Cint
    depth*: Cint
    bytes_per_line*: Cint
    bits_per_pixel*: Cint
    red_mask*: Culong
    green_mask*: Culong
    blue_mask*: Culong
    obdata*: TXPointer
    f*: TF

  PXWindowChanges* = ptr TXWindowChanges
  TXWindowChanges*{.final.} = object 
    x*, y*: Cint
    width*, height*: Cint
    border_width*: Cint
    sibling*: TWindow
    stack_mode*: Cint

  PXColor* = ptr TXColor
  TXColor*{.final.} = object 
    pixel*: Culong
    red*, green*, blue*: Cushort
    flags*: Cchar
    pad*: Cchar

  PXSegment* = ptr TXSegment
  TXSegment*{.final.} = object 
    x1*, y1*, x2*, y2*: Cshort

  PXPoint* = ptr TXPoint
  TXPoint*{.final.} = object 
    x*, y*: Cshort

  PXRectangle* = ptr TXRectangle
  TXRectangle*{.final.} = object 
    x*, y*: Cshort
    width*, height*: Cushort

  PXArc* = ptr TXArc
  TXArc*{.final.} = object 
    x*, y*: Cshort
    width*, height*: Cushort
    angle1*, angle2*: Cshort

  PXKeyboardControl* = ptr TXKeyboardControl
  TXKeyboardControl*{.final.} = object 
    key_click_percent*: Cint
    bell_percent*: Cint
    bell_pitch*: Cint
    bell_duration*: Cint
    led*: Cint
    led_mode*: Cint
    key*: Cint
    auto_repeat_mode*: Cint

  PXKeyboardState* = ptr TXKeyboardState
  TXKeyboardState*{.final.} = object 
    key_click_percent*: Cint
    bell_percent*: Cint
    bell_pitch*, bell_duration*: Cuint
    led_mask*: Culong
    global_auto_repeat*: Cint
    auto_repeats*: Array[0..31, Cchar]

  PXTimeCoord* = ptr TXTimeCoord
  TXTimeCoord*{.final.} = object 
    time*: TTime
    x*, y*: Cshort

  PXModifierKeymap* = ptr TXModifierKeymap
  TXModifierKeymap*{.final.} = object 
    max_keypermod*: Cint
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
    fd*: Cint
    private2*: Cint
    proto_major_version*: Cint
    proto_minor_version*: Cint
    vendor*: Cstring
    private3*: TXID
    private4*: TXID
    private5*: TXID
    private6*: Cint
    resource_alloc*: proc (para1: PXDisplay): TXID{.cdecl.}
    byte_order*: Cint
    bitmap_unit*: Cint
    bitmap_pad*: Cint
    bitmap_bit_order*: Cint
    nformats*: Cint
    pixmap_format*: PScreenFormat
    private8*: Cint
    release*: Cint
    private9*, private10*: PXPrivate
    qlen*: Cint
    last_request_read*: Culong
    request*: Culong
    private11*: TXPointer
    private12*: TXPointer
    private13*: TXPointer
    private14*: TXPointer
    max_request_size*: Cunsigned
    db*: PXrmHashBucketRec
    private15*: proc (para1: PXDisplay): Cint{.cdecl.}
    display_name*: Cstring
    default_screen*: Cint
    nscreens*: Cint
    screens*: PScreen
    motion_buffer*: Culong
    private16*: Culong
    min_keycode*: Cint
    max_keycode*: Cint
    private17*: TXPointer
    private18*: TXPointer
    private19*: Cint
    xdefaults*: Cstring

  PXKeyEvent* = ptr TXKeyEvent
  TXKeyEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    root*: TWindow
    subwindow*: TWindow
    time*: TTime
    x*, y*: Cint
    x_root*, y_root*: Cint
    state*: Cuint
    keycode*: Cuint
    same_screen*: TBool

  PXKeyPressedEvent* = ptr TXKeyPressedEvent
  TXKeyPressedEvent* = TXKeyEvent
  PXKeyReleasedEvent* = ptr TXKeyReleasedEvent
  TXKeyReleasedEvent* = TXKeyEvent
  PXButtonEvent* = ptr TXButtonEvent
  TXButtonEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    root*: TWindow
    subwindow*: TWindow
    time*: TTime
    x*, y*: Cint
    x_root*, y_root*: Cint
    state*: Cuint
    button*: Cuint
    same_screen*: TBool

  PXButtonPressedEvent* = ptr TXButtonPressedEvent
  TXButtonPressedEvent* = TXButtonEvent
  PXButtonReleasedEvent* = ptr TXButtonReleasedEvent
  TXButtonReleasedEvent* = TXButtonEvent
  PXMotionEvent* = ptr TXMotionEvent
  TXMotionEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    root*: TWindow
    subwindow*: TWindow
    time*: TTime
    x*, y*: Cint
    x_root*, y_root*: Cint
    state*: Cuint
    is_hint*: Cchar
    same_screen*: TBool

  PXPointerMovedEvent* = ptr TXPointerMovedEvent
  TXPointerMovedEvent* = TXMotionEvent
  PXCrossingEvent* = ptr TXCrossingEvent
  TXCrossingEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    root*: TWindow
    subwindow*: TWindow
    time*: TTime
    x*, y*: Cint
    x_root*, y_root*: Cint
    mode*: Cint
    detail*: Cint
    same_screen*: TBool
    focus*: TBool
    state*: Cuint

  PXEnterWindowEvent* = ptr TXEnterWindowEvent
  TXEnterWindowEvent* = TXCrossingEvent
  PXLeaveWindowEvent* = ptr TXLeaveWindowEvent
  TXLeaveWindowEvent* = TXCrossingEvent
  PXFocusChangeEvent* = ptr TXFocusChangeEvent
  TXFocusChangeEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    mode*: Cint
    detail*: Cint

  PXFocusInEvent* = ptr TXFocusInEvent
  TXFocusInEvent* = TXFocusChangeEvent
  PXFocusOutEvent* = ptr TXFocusOutEvent
  TXFocusOutEvent* = TXFocusChangeEvent
  PXKeymapEvent* = ptr TXKeymapEvent
  TXKeymapEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    key_vector*: Array[0..31, Cchar]

  PXExposeEvent* = ptr TXExposeEvent
  TXExposeEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    x*, y*: Cint
    width*, height*: Cint
    count*: Cint

  PXGraphicsExposeEvent* = ptr TXGraphicsExposeEvent
  TXGraphicsExposeEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    drawable*: TDrawable
    x*, y*: Cint
    width*, height*: Cint
    count*: Cint
    major_code*: Cint
    minor_code*: Cint

  PXNoExposeEvent* = ptr TXNoExposeEvent
  TXNoExposeEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    drawable*: TDrawable
    major_code*: Cint
    minor_code*: Cint

  PXVisibilityEvent* = ptr TXVisibilityEvent
  TXVisibilityEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    state*: Cint

  PXCreateWindowEvent* = ptr TXCreateWindowEvent
  TXCreateWindowEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    parent*: TWindow
    window*: TWindow
    x*, y*: Cint
    width*, height*: Cint
    border_width*: Cint
    override_redirect*: TBool

  PXDestroyWindowEvent* = ptr TXDestroyWindowEvent
  TXDestroyWindowEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    event*: TWindow
    window*: TWindow

  PXUnmapEvent* = ptr TXUnmapEvent
  TXUnmapEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    from_configure*: TBool

  PXMapEvent* = ptr TXMapEvent
  TXMapEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    override_redirect*: TBool

  PXMapRequestEvent* = ptr TXMapRequestEvent
  TXMapRequestEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    parent*: TWindow
    window*: TWindow

  PXReparentEvent* = ptr TXReparentEvent
  TXReparentEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    parent*: TWindow
    x*, y*: Cint
    override_redirect*: TBool

  PXConfigureEvent* = ptr TXConfigureEvent
  TXConfigureEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    x*, y*: Cint
    width*, height*: Cint
    border_width*: Cint
    above*: TWindow
    override_redirect*: TBool

  PXGravityEvent* = ptr TXGravityEvent
  TXGravityEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    x*, y*: Cint

  PXResizeRequestEvent* = ptr TXResizeRequestEvent
  TXResizeRequestEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    width*, height*: Cint

  PXConfigureRequestEvent* = ptr TXConfigureRequestEvent
  TXConfigureRequestEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    parent*: TWindow
    window*: TWindow
    x*, y*: Cint
    width*, height*: Cint
    border_width*: Cint
    above*: TWindow
    detail*: Cint
    value_mask*: Culong

  PXCirculateEvent* = ptr TXCirculateEvent
  TXCirculateEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    event*: TWindow
    window*: TWindow
    place*: Cint

  PXCirculateRequestEvent* = ptr TXCirculateRequestEvent
  TXCirculateRequestEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    parent*: TWindow
    window*: TWindow
    place*: Cint

  PXPropertyEvent* = ptr TXPropertyEvent
  TXPropertyEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    atom*: TAtom
    time*: TTime
    state*: Cint

  PXSelectionClearEvent* = ptr TXSelectionClearEvent
  TXSelectionClearEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    selection*: TAtom
    time*: TTime

  PXSelectionRequestEvent* = ptr TXSelectionRequestEvent
  TXSelectionRequestEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    owner*: TWindow
    requestor*: TWindow
    selection*: TAtom
    target*: TAtom
    property*: TAtom
    time*: TTime

  PXSelectionEvent* = ptr TXSelectionEvent
  TXSelectionEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    requestor*: TWindow
    selection*: TAtom
    target*: TAtom
    property*: TAtom
    time*: TTime

  PXColormapEvent* = ptr TXColormapEvent
  TXColormapEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    colormap*: TColormap
    c_new*: TBool
    state*: Cint

  PXClientMessageEvent* = ptr TXClientMessageEvent
  TXClientMessageEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    message_type*: TAtom
    format*: Cint
    data*: Array[0..4, Clong] # using clong here to be 32/64-bit dependent
        # as the original C union

  PXMappingEvent* = ptr TXMappingEvent
  TXMappingEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow
    request*: Cint
    first_keycode*: Cint
    count*: Cint

  PXErrorEvent* = ptr TXErrorEvent
  TXErrorEvent*{.final.} = object 
    theType*: Cint
    display*: PDisplay
    resourceid*: TXID
    serial*: Culong
    error_code*: Cuchar
    request_code*: Cuchar
    minor_code*: Cuchar

  PXAnyEvent* = ptr TXAnyEvent
  TXAnyEvent*{.final.} = object 
    theType*: Cint
    serial*: Culong
    send_event*: TBool
    display*: PDisplay
    window*: TWindow

  PXEvent* = ptr TXEvent
  TXEvent*{.final.} = object 
    theType*: Cint
    pad*: Array[0..22, Clong] #
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
  

proc xclient*(e: PXEvent): PXClientMessageEvent =
    ## Treats XEvent as XClientMessageEvent
    return cast[PXClientMessageEvent](e)

proc xclient*(e: var TXEvent): PXClientMessageEvent =
    return xclient(PXEvent(e.addr))

type 
  PXCharStruct* = ptr TXCharStruct
  TXCharStruct*{.final.} = object 
    lbearing*: Cshort
    rbearing*: Cshort
    width*: Cshort
    ascent*: Cshort
    descent*: Cshort
    attributes*: Cushort

  PXFontProp* = ptr TXFontProp
  TXFontProp*{.final.} = object 
    name*: TAtom
    card32*: Culong

  PPPXFontStruct* = ptr PPXFontStruct
  PPXFontStruct* = ptr PXFontStruct
  PXFontStruct* = ptr TXFontStruct
  TXFontStruct*{.final.} = object 
    ext_data*: PXExtData
    fid*: TFont
    direction*: Cunsigned
    min_char_or_byte2*: Cunsigned
    max_char_or_byte2*: Cunsigned
    min_byte1*: Cunsigned
    max_byte1*: Cunsigned
    all_chars_exist*: TBool
    default_char*: Cunsigned
    n_properties*: Cint
    properties*: PXFontProp
    min_bounds*: TXCharStruct
    max_bounds*: TXCharStruct
    per_char*: PXCharStruct
    ascent*: Cint
    descent*: Cint

  PXTextItem* = ptr TXTextItem
  TXTextItem*{.final.} = object 
    chars*: Cstring
    nchars*: Cint
    delta*: Cint
    font*: TFont

  PXChar2b* = ptr TXChar2b
  TXChar2b*{.final.} = object 
    byte1*: Cuchar
    byte2*: Cuchar

  PXTextItem16* = ptr TXTextItem16
  TXTextItem16*{.final.} = object 
    chars*: PXChar2b
    nchars*: Cint
    delta*: Cint
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

  Pxom* = ptr TXOM
  TXOM*{.final.} = object 
  Pxoc* = ptr TXOC
  TXOC*{.final.} = object 
  TXFontSet* = Pxoc
  PXFontSet* = ptr TXFontSet
  PXmbTextItem* = ptr TXmbTextItem
  TXmbTextItem*{.final.} = object 
    chars*: Cstring
    nchars*: Cint
    delta*: Cint
    font_set*: TXFontSet

  PXwcTextItem* = ptr TXwcTextItem
  TXwcTextItem*{.final.} = object 
    chars*: PWideChar         #wchar_t*
    nchars*: Cint
    delta*: Cint
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
  PXOMCharSetList* = ptr TXOMCharSetList
  TXOMCharSetList*{.final.} = object 
    charset_count*: Cint
    charset_list*: PPChar

  PXOrientation* = ptr TXOrientation
  TXOrientation* = enum 
    XOMOrientation_LTR_TTB, XOMOrientation_RTL_TTB, XOMOrientation_TTB_LTR, 
    XOMOrientation_TTB_RTL, XOMOrientation_Context
  PXOMOrientation* = ptr TXOMOrientation
  TXOMOrientation*{.final.} = object 
    num_orientation*: Cint
    orientation*: PXOrientation

  PXOMFontInfo* = ptr TXOMFontInfo
  TXOMFontInfo*{.final.} = object 
    num_font*: Cint
    font_struct_list*: ptr PXFontStruct
    font_name_list*: PPChar

  Pxim* = ptr TXIM
  TXIM*{.final.} = object 
  Pxic* = ptr TXIC
  TXIC*{.final.} = object 
  TXIMProc* = proc (para1: TXIM, para2: TXPointer, para3: TXPointer){.cdecl.}
  TXICProc* = proc (para1: TXIC, para2: TXPointer, para3: TXPointer): TBool{.
      cdecl.}
  TXIDProc* = proc (para1: PDisplay, para2: TXPointer, para3: TXPointer){.cdecl.}
  PXIMStyle* = ptr TXIMStyle
  TXIMStyle* = Culong
  PXIMStyles* = ptr TXIMStyles
  TXIMStyles*{.final.} = object 
    count_styles*: Cushort
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
  TXVaNestedList* = Pointer
  PXIMCallback* = ptr TXIMCallback
  TXIMCallback*{.final.} = object 
    client_data*: TXPointer
    callback*: TXIMProc

  PXICCallback* = ptr TXICCallback
  TXICCallback*{.final.} = object 
    client_data*: TXPointer
    callback*: TXICProc

  PXIMFeedback* = ptr TXIMFeedback
  TXIMFeedback* = Culong

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
    len*: Cushort
    feedback*: PXIMFeedback
    encoding_is_wchar*: TBool
    multi_byte*: Cstring

  PXIMPreeditState* = ptr TXIMPreeditState
  TXIMPreeditState* = Culong

const 
  XIMPreeditUnKnown* = 0
  XIMPreeditEnable* = 1
  XIMPreeditDisable* = 1 shl 1

type 
  PXIMPreeditStateNotifyCallbackStruct* = ptr TXIMPreeditStateNotifyCallbackStruct
  TXIMPreeditStateNotifyCallbackStruct*{.final.} = object 
    state*: TXIMPreeditState

  PXIMResetState* = ptr TXIMResetState
  TXIMResetState* = Culong

const 
  XIMInitialState* = 1
  XIMPreserveState* = 1 shl 1

type 
  PXIMStringConversionFeedback* = ptr TXIMStringConversionFeedback
  TXIMStringConversionFeedback* = Culong

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
    len*: Cushort
    feedback*: PXIMStringConversionFeedback
    encoding_is_wchar*: TBool
    mbs*: Cstring

  PXIMStringConversionPosition* = ptr TXIMStringConversionPosition
  TXIMStringConversionPosition* = Cushort
  PXIMStringConversionType* = ptr TXIMStringConversionType
  TXIMStringConversionType* = Cushort

const 
  XIMStringConversionBuffer* = 0x00000001
  XIMStringConversionLine* = 0x00000002
  XIMStringConversionWord* = 0x00000003
  XIMStringConversionChar* = 0x00000004

type 
  PXIMStringConversionOperation* = ptr TXIMStringConversionOperation
  TXIMStringConversionOperation* = Cushort

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
    factor*: Cushort
    text*: PXIMStringConversionText

  PXIMPreeditDrawCallbackStruct* = ptr TXIMPreeditDrawCallbackStruct
  TXIMPreeditDrawCallbackStruct*{.final.} = object 
    caret*: Cint
    chg_first*: Cint
    chg_length*: Cint
    text*: PXIMText

  PXIMCaretStyle* = ptr TXIMCaretStyle
  TXIMCaretStyle* = enum 
    XIMIsInvisible, XIMIsPrimary, XIMIsSecondary
  PXIMPreeditCaretCallbackStruct* = ptr TXIMPreeditCaretCallbackStruct
  TXIMPreeditCaretCallbackStruct*{.final.} = object 
    position*: Cint
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
    modifier*: Cint
    modifier_mask*: Cint

  PXIMHotKeyTriggers* = ptr TXIMHotKeyTriggers
  TXIMHotKeyTriggers*{.final.} = object 
    num_hot_key*: Cint
    key*: PXIMHotKeyTrigger

  PXIMHotKeyState* = ptr TXIMHotKeyState
  TXIMHotKeyState* = Culong

const 
  XIMHotKeyStateON* = 0x00000001
  XIMHotKeyStateOFF* = 0x00000002

type 
  PXIMValuesList* = ptr TXIMValuesList
  TXIMValuesList*{.final.} = object 
    count_values*: Cushort
    supported_values*: PPChar


type 
  Funcdisp* = proc (display: PDisplay): Cint{.cdecl.}
  Funcifevent* = proc (display: PDisplay, event: PXEvent, p: TXPointer): TBool{.
      cdecl.}
  Chararr32* = Array[0..31, Char]

const 
  AllPlanes*: Culong = culong(not 0)

proc XLoadQueryFont*(para1: PDisplay, para2: Cstring): PXFontStruct{.libx11.}
proc XQueryFont*(para1: PDisplay, para2: TXID): PXFontStruct{.libx11.}
proc XGetMotionEvents*(para1: PDisplay, para2: TWindow, para3: TTime, 
                       para4: TTime, para5: Pcint): PXTimeCoord{.libx11.}
proc XDeleteModifiermapEntry*(para1: PXModifierKeymap, para2: TKeyCode, 
                              para3: Cint): PXModifierKeymap{.libx11.}
proc XGetModifierMapping*(para1: PDisplay): PXModifierKeymap{.libx11.}
proc XInsertModifiermapEntry*(para1: PXModifierKeymap, para2: TKeyCode, 
                              para3: Cint): PXModifierKeymap{.libx11.}
proc XNewModifiermap*(para1: Cint): PXModifierKeymap{.libx11.}
proc XCreateImage*(para1: PDisplay, para2: PVisual, para3: Cuint, para4: Cint, 
                   para5: Cint, para6: Cstring, para7: Cuint, para8: Cuint, 
                   para9: Cint, para10: Cint): PXImage{.libx11.}
proc XInitImage*(para1: PXImage): TStatus{.libx11.}
proc XGetImage*(para1: PDisplay, para2: TDrawable, para3: Cint, para4: Cint, 
                para5: Cuint, para6: Cuint, para7: Culong, para8: Cint): PXImage{.
    libx11.}
proc XGetSubImage*(para1: PDisplay, para2: TDrawable, para3: Cint, para4: Cint, 
                   para5: Cuint, para6: Cuint, para7: Culong, para8: Cint, 
                   para9: PXImage, para10: Cint, para11: Cint): PXImage{.libx11.}
proc XOpenDisplay*(para1: Cstring): PDisplay{.libx11.}
proc XrmInitialize*(){.libx11.}
proc XFetchBytes*(para1: PDisplay, para2: Pcint): Cstring{.libx11.}
proc XFetchBuffer*(para1: PDisplay, para2: Pcint, para3: Cint): Cstring{.libx11.}
proc XGetAtomName*(para1: PDisplay, para2: TAtom): Cstring{.libx11.}
proc XGetAtomNames*(para1: PDisplay, para2: PAtom, para3: Cint, para4: PPChar): TStatus{.
    libx11.}
proc XGetDefault*(para1: PDisplay, para2: Cstring, para3: Cstring): Cstring{.
    libx11.}
proc XDisplayName*(para1: Cstring): Cstring{.libx11.}
proc XKeysymToString*(para1: TKeySym): Cstring{.libx11.}
proc XSynchronize*(para1: PDisplay, para2: TBool): Funcdisp{.libx11.}
proc XSetAfterFunction*(para1: PDisplay, para2: Funcdisp): Funcdisp{.libx11.}
proc XInternAtom*(para1: PDisplay, para2: Cstring, para3: TBool): TAtom{.libx11.}
proc XInternAtoms*(para1: PDisplay, para2: PPChar, para3: Cint, para4: TBool, 
                   para5: PAtom): TStatus{.libx11.}
proc XCopyColormapAndFree*(para1: PDisplay, para2: TColormap): TColormap{.libx11.}
proc XCreateColormap*(para1: PDisplay, para2: TWindow, para3: PVisual, 
                      para4: Cint): TColormap{.libx11.}
proc XCreatePixmapCursor*(para1: PDisplay, para2: TPixmap, para3: TPixmap, 
                          para4: PXColor, para5: PXColor, para6: Cuint, 
                          para7: Cuint): TCursor{.libx11.}
proc XCreateGlyphCursor*(para1: PDisplay, para2: TFont, para3: TFont, 
                         para4: Cuint, para5: Cuint, para6: PXColor, 
                         para7: PXColor): TCursor{.libx11.}
proc XCreateFontCursor*(para1: PDisplay, para2: Cuint): TCursor{.libx11.}
proc XLoadFont*(para1: PDisplay, para2: Cstring): TFont{.libx11.}
proc XCreateGC*(para1: PDisplay, para2: TDrawable, para3: Culong, 
                para4: PXGCValues): TGC{.libx11.}
proc XGContextFromGC*(para1: TGC): TGContext{.libx11.}
proc XFlushGC*(para1: PDisplay, para2: TGC){.libx11.}
proc XCreatePixmap*(para1: PDisplay, para2: TDrawable, para3: Cuint, 
                    para4: Cuint, para5: Cuint): TPixmap{.libx11.}
proc XCreateBitmapFromData*(para1: PDisplay, para2: TDrawable, para3: Cstring, 
                            para4: Cuint, para5: Cuint): TPixmap{.libx11.}
proc XCreatePixmapFromBitmapData*(para1: PDisplay, para2: TDrawable, 
                                  para3: Cstring, para4: Cuint, para5: Cuint, 
                                  para6: Culong, para7: Culong, para8: Cuint): TPixmap{.
    libx11.}
proc XCreateSimpleWindow*(para1: PDisplay, para2: TWindow, para3: Cint, 
                          para4: Cint, para5: Cuint, para6: Cuint, para7: Cuint, 
                          para8: Culong, para9: Culong): TWindow{.libx11.}
proc XGetSelectionOwner*(para1: PDisplay, para2: TAtom): TWindow{.libx11.}
proc XCreateWindow*(para1: PDisplay, para2: TWindow, para3: Cint, para4: Cint, 
                    para5: Cuint, para6: Cuint, para7: Cuint, para8: Cint, 
                    para9: Cuint, para10: PVisual, para11: Culong, 
                    para12: PXSetWindowAttributes): TWindow{.libx11.}
proc XListInstalledColormaps*(para1: PDisplay, para2: TWindow, para3: Pcint): PColormap{.
    libx11.}
proc XListFonts*(para1: PDisplay, para2: Cstring, para3: Cint, para4: Pcint): PPChar{.
    libx11.}
proc XListFontsWithInfo*(para1: PDisplay, para2: Cstring, para3: Cint, 
                         para4: Pcint, para5: PPXFontStruct): PPChar{.libx11.}
proc XGetFontPath*(para1: PDisplay, para2: Pcint): PPChar{.libx11.}
proc XListExtensions*(para1: PDisplay, para2: Pcint): PPChar{.libx11.}
proc XListProperties*(para1: PDisplay, para2: TWindow, para3: Pcint): PAtom{.
    libx11.}
proc XListHosts*(para1: PDisplay, para2: Pcint, para3: PBool): PXHostAddress{.
    libx11.}
proc XKeycodeToKeysym*(para1: PDisplay, para2: TKeyCode, para3: Cint): TKeySym{.
    libx11.}
proc XLookupKeysym*(para1: PXKeyEvent, para2: Cint): TKeySym{.libx11.}
proc XGetKeyboardMapping*(para1: PDisplay, para2: TKeyCode, para3: Cint, 
                          para4: Pcint): PKeySym{.libx11.}
proc XStringToKeysym*(para1: Cstring): TKeySym{.libx11.}
proc XMaxRequestSize*(para1: PDisplay): Clong{.libx11.}
proc XExtendedMaxRequestSize*(para1: PDisplay): Clong{.libx11.}
proc XResourceManagerString*(para1: PDisplay): Cstring{.libx11.}
proc XScreenResourceString*(para1: PScreen): Cstring{.libx11.}
proc XDisplayMotionBufferSize*(para1: PDisplay): Culong{.libx11.}
proc XVisualIDFromVisual*(para1: PVisual): TVisualID{.libx11.}
proc XInitThreads*(): TStatus{.libx11.}
proc XLockDisplay*(para1: PDisplay){.libx11.}
proc XUnlockDisplay*(para1: PDisplay){.libx11.}
proc XInitExtension*(para1: PDisplay, para2: Cstring): PXExtCodes{.libx11.}
proc XAddExtension*(para1: PDisplay): PXExtCodes{.libx11.}
proc XFindOnExtensionList*(para1: PPXExtData, para2: Cint): PXExtData{.libx11.}
proc XEHeadOfExtensionList*(para1: TXEDataObject): PPXExtData{.libx11.}
proc XRootWindow*(para1: PDisplay, para2: Cint): TWindow{.libx11.}
proc XDefaultRootWindow*(para1: PDisplay): TWindow{.libx11.}
proc XRootWindowOfScreen*(para1: PScreen): TWindow{.libx11.}
proc XDefaultVisual*(para1: PDisplay, para2: Cint): PVisual{.libx11.}
proc XDefaultVisualOfScreen*(para1: PScreen): PVisual{.libx11.}
proc XDefaultGC*(para1: PDisplay, para2: Cint): TGC{.libx11.}
proc XDefaultGCOfScreen*(para1: PScreen): TGC{.libx11.}
proc XBlackPixel*(para1: PDisplay, para2: Cint): Culong{.libx11.}
proc XWhitePixel*(para1: PDisplay, para2: Cint): Culong{.libx11.}
proc XAllPlanes*(): Culong{.libx11.}
proc XBlackPixelOfScreen*(para1: PScreen): Culong{.libx11.}
proc XWhitePixelOfScreen*(para1: PScreen): Culong{.libx11.}
proc XNextRequest*(para1: PDisplay): Culong{.libx11.}
proc XLastKnownRequestProcessed*(para1: PDisplay): Culong{.libx11.}
proc XServerVendor*(para1: PDisplay): Cstring{.libx11.}
proc XDisplayString*(para1: PDisplay): Cstring{.libx11.}
proc XDefaultColormap*(para1: PDisplay, para2: Cint): TColormap{.libx11.}
proc XDefaultColormapOfScreen*(para1: PScreen): TColormap{.libx11.}
proc XDisplayOfScreen*(para1: PScreen): PDisplay{.libx11.}
proc XScreenOfDisplay*(para1: PDisplay, para2: Cint): PScreen{.libx11.}
proc XDefaultScreenOfDisplay*(para1: PDisplay): PScreen{.libx11.}
proc XEventMaskOfScreen*(para1: PScreen): Clong{.libx11.}
proc XScreenNumberOfScreen*(para1: PScreen): Cint{.libx11.}
type 
  TXErrorHandler* = proc (para1: PDisplay, para2: PXErrorEvent): Cint{.cdecl.}

proc XSetErrorHandler*(para1: TXErrorHandler): TXErrorHandler{.libx11.}
type 
  TXIOErrorHandler* = proc (para1: PDisplay): Cint{.cdecl.}

proc XSetIOErrorHandler*(para1: TXIOErrorHandler): TXIOErrorHandler{.libx11.}
proc XListPixmapFormats*(para1: PDisplay, para2: Pcint): PXPixmapFormatValues{.
    libx11.}
proc XListDepths*(para1: PDisplay, para2: Cint, para3: Pcint): Pcint{.libx11.}
proc XReconfigureWMWindow*(para1: PDisplay, para2: TWindow, para3: Cint, 
                           para4: Cuint, para5: PXWindowChanges): TStatus{.
    libx11.}
proc XGetWMProtocols*(para1: PDisplay, para2: TWindow, para3: PPAtom, 
                      para4: Pcint): TStatus{.libx11.}
proc XSetWMProtocols*(para1: PDisplay, para2: TWindow, para3: PAtom, para4: Cint): TStatus{.
    libx11.}
proc XIconifyWindow*(para1: PDisplay, para2: TWindow, para3: Cint): TStatus{.
    libx11.}
proc XWithdrawWindow*(para1: PDisplay, para2: TWindow, para3: Cint): TStatus{.
    libx11.}
proc XGetCommand*(para1: PDisplay, para2: TWindow, para3: PPPChar, para4: Pcint): TStatus{.
    libx11.}
proc XGetWMColormapWindows*(para1: PDisplay, para2: TWindow, para3: PPWindow, 
                            para4: Pcint): TStatus{.libx11.}
proc XSetWMColormapWindows*(para1: PDisplay, para2: TWindow, para3: PWindow, 
                            para4: Cint): TStatus{.libx11.}
proc XFreeStringList*(para1: PPChar){.libx11.}
proc XSetTransientForHint*(para1: PDisplay, para2: TWindow, para3: TWindow): Cint{.
    libx11.}
proc XActivateScreenSaver*(para1: PDisplay): Cint{.libx11.}
proc XAddHost*(para1: PDisplay, para2: PXHostAddress): Cint{.libx11.}
proc XAddHosts*(para1: PDisplay, para2: PXHostAddress, para3: Cint): Cint{.
    libx11.}
proc XAddToExtensionList*(para1: PPXExtData, para2: PXExtData): Cint{.libx11.}
proc XAddToSaveSet*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XAllocColor*(para1: PDisplay, para2: TColormap, para3: PXColor): TStatus{.
    libx11.}
proc XAllocColorCells*(para1: PDisplay, para2: TColormap, para3: TBool, 
                       para4: Pculong, para5: Cuint, para6: Pculong, 
                       para7: Cuint): TStatus{.libx11.}
proc XAllocColorPlanes*(para1: PDisplay, para2: TColormap, para3: TBool, 
                        para4: Pculong, para5: Cint, para6: Cint, para7: Cint, 
                        para8: Cint, para9: Pculong, para10: Pculong, 
                        para11: Pculong): TStatus{.libx11.}
proc XAllocNamedColor*(para1: PDisplay, para2: TColormap, para3: Cstring, 
                       para4: PXColor, para5: PXColor): TStatus{.libx11.}
proc XAllowEvents*(para1: PDisplay, para2: Cint, para3: TTime): Cint{.libx11.}
proc XAutoRepeatOff*(para1: PDisplay): Cint{.libx11.}
proc XAutoRepeatOn*(para1: PDisplay): Cint{.libx11.}
proc XBell*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XBitmapBitOrder*(para1: PDisplay): Cint{.libx11.}
proc XBitmapPad*(para1: PDisplay): Cint{.libx11.}
proc XBitmapUnit*(para1: PDisplay): Cint{.libx11.}
proc XCellsOfScreen*(para1: PScreen): Cint{.libx11.}
proc XChangeActivePointerGrab*(para1: PDisplay, para2: Cuint, para3: TCursor, 
                               para4: TTime): Cint{.libx11.}
proc XChangeGC*(para1: PDisplay, para2: TGC, para3: Culong, para4: PXGCValues): Cint{.
    libx11.}
proc XChangeKeyboardControl*(para1: PDisplay, para2: Culong, 
                             para3: PXKeyboardControl): Cint{.libx11.}
proc XChangeKeyboardMapping*(para1: PDisplay, para2: Cint, para3: Cint, 
                             para4: PKeySym, para5: Cint): Cint{.libx11.}
proc XChangePointerControl*(para1: PDisplay, para2: TBool, para3: TBool, 
                            para4: Cint, para5: Cint, para6: Cint): Cint{.libx11.}
proc XChangeProperty*(para1: PDisplay, para2: TWindow, para3: TAtom, 
                      para4: TAtom, para5: Cint, para6: Cint, para7: Pcuchar, 
                      para8: Cint): Cint{.libx11.}
proc XChangeSaveSet*(para1: PDisplay, para2: TWindow, para3: Cint): Cint{.libx11.}
proc XChangeWindowAttributes*(para1: PDisplay, para2: TWindow, para3: Culong, 
                              para4: PXSetWindowAttributes): Cint{.libx11.}
proc XCheckIfEvent*(para1: PDisplay, para2: PXEvent, para3: Funcifevent, 
                    para4: TXPointer): TBool{.libx11.}
proc XCheckMaskEvent*(para1: PDisplay, para2: Clong, para3: PXEvent): TBool{.
    libx11.}
proc XCheckTypedEvent*(para1: PDisplay, para2: Cint, para3: PXEvent): TBool{.
    libx11.}
proc XCheckTypedWindowEvent*(para1: PDisplay, para2: TWindow, para3: Cint, 
                             para4: PXEvent): TBool{.libx11.}
proc XCheckWindowEvent*(para1: PDisplay, para2: TWindow, para3: Clong, 
                        para4: PXEvent): TBool{.libx11.}
proc XCirculateSubwindows*(para1: PDisplay, para2: TWindow, para3: Cint): Cint{.
    libx11.}
proc XCirculateSubwindowsDown*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XCirculateSubwindowsUp*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XClearArea*(para1: PDisplay, para2: TWindow, para3: Cint, para4: Cint, 
                 para5: Cuint, para6: Cuint, para7: TBool): Cint{.libx11.}
proc XClearWindow*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XCloseDisplay*(para1: PDisplay): Cint{.libx11.}
proc XConfigureWindow*(para1: PDisplay, para2: TWindow, para3: Cuint, 
                       para4: PXWindowChanges): Cint{.libx11.}
proc XConnectionNumber*(para1: PDisplay): Cint{.libx11.}
proc XConvertSelection*(para1: PDisplay, para2: TAtom, para3: TAtom, 
                        para4: TAtom, para5: TWindow, para6: TTime): Cint{.
    libx11.}
proc XCopyArea*(para1: PDisplay, para2: TDrawable, para3: TDrawable, para4: TGC, 
                para5: Cint, para6: Cint, para7: Cuint, para8: Cuint, 
                para9: Cint, para10: Cint): Cint{.libx11.}
proc XCopyGC*(para1: PDisplay, para2: TGC, para3: Culong, para4: TGC): Cint{.
    libx11.}
proc XCopyPlane*(para1: PDisplay, para2: TDrawable, para3: TDrawable, 
                 para4: TGC, para5: Cint, para6: Cint, para7: Cuint, 
                 para8: Cuint, para9: Cint, para10: Cint, para11: Culong): Cint{.
    libx11.}
proc XDefaultDepth*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XDefaultDepthOfScreen*(para1: PScreen): Cint{.libx11.}
proc XDefaultScreen*(para1: PDisplay): Cint{.libx11.}
proc XDefineCursor*(para1: PDisplay, para2: TWindow, para3: TCursor): Cint{.
    libx11.}
proc XDeleteProperty*(para1: PDisplay, para2: TWindow, para3: TAtom): Cint{.
    libx11.}
proc XDestroyWindow*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XDestroySubwindows*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XDoesBackingStore*(para1: PScreen): Cint{.libx11.}
proc XDoesSaveUnders*(para1: PScreen): TBool{.libx11.}
proc XDisableAccessControl*(para1: PDisplay): Cint{.libx11.}
proc XDisplayCells*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XDisplayHeight*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XDisplayHeightMM*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XDisplayKeycodes*(para1: PDisplay, para2: Pcint, para3: Pcint): Cint{.
    libx11.}
proc XDisplayPlanes*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XDisplayWidth*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XDisplayWidthMM*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XDrawArc*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
               para5: Cint, para6: Cuint, para7: Cuint, para8: Cint, para9: Cint): Cint{.
    libx11.}
proc XDrawArcs*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXArc, 
                para5: Cint): Cint{.libx11.}
proc XDrawImageString*(para1: PDisplay, para2: TDrawable, para3: TGC, 
                       para4: Cint, para5: Cint, para6: Cstring, para7: Cint): Cint{.
    libx11.}
proc XDrawImageString16*(para1: PDisplay, para2: TDrawable, para3: TGC, 
                         para4: Cint, para5: Cint, para6: PXChar2b, para7: Cint): Cint{.
    libx11.}
proc XDrawLine*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                para5: Cint, para6: Cint, para7: Cint): Cint{.libx11.}
proc XDrawLines*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXPoint, 
                 para5: Cint, para6: Cint): Cint{.libx11.}
proc XDrawPoint*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                 para5: Cint): Cint{.libx11.}
proc XDrawPoints*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXPoint, 
                  para5: Cint, para6: Cint): Cint{.libx11.}
proc XDrawRectangle*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                     para5: Cint, para6: Cuint, para7: Cuint): Cint{.libx11.}
proc XDrawRectangles*(para1: PDisplay, para2: TDrawable, para3: TGC, 
                      para4: PXRectangle, para5: Cint): Cint{.libx11.}
proc XDrawSegments*(para1: PDisplay, para2: TDrawable, para3: TGC, 
                    para4: PXSegment, para5: Cint): Cint{.libx11.}
proc XDrawString*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                  para5: Cint, para6: Cstring, para7: Cint): Cint{.libx11.}
proc XDrawString16*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                    para5: Cint, para6: PXChar2b, para7: Cint): Cint{.libx11.}
proc XDrawText*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                para5: Cint, para6: PXTextItem, para7: Cint): Cint{.libx11.}
proc XDrawText16*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                  para5: Cint, para6: PXTextItem16, para7: Cint): Cint{.libx11.}
proc XEnableAccessControl*(para1: PDisplay): Cint{.libx11.}
proc XEventsQueued*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XFetchName*(para1: PDisplay, para2: TWindow, para3: PPChar): TStatus{.
    libx11.}
proc XFillArc*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
               para5: Cint, para6: Cuint, para7: Cuint, para8: Cint, para9: Cint): Cint{.
    libx11.}
proc XFillArcs*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXArc, 
                para5: Cint): Cint{.libx11.}
proc XFillPolygon*(para1: PDisplay, para2: TDrawable, para3: TGC, 
                   para4: PXPoint, para5: Cint, para6: Cint, para7: Cint): Cint{.
    libx11.}
proc XFillRectangle*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                     para5: Cint, para6: Cuint, para7: Cuint): Cint{.libx11.}
proc XFillRectangles*(para1: PDisplay, para2: TDrawable, para3: TGC, 
                      para4: PXRectangle, para5: Cint): Cint{.libx11.}
proc XFlush*(para1: PDisplay): Cint{.libx11.}
proc XForceScreenSaver*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XFree*(para1: Pointer): Cint{.libx11.}
proc XFreeColormap*(para1: PDisplay, para2: TColormap): Cint{.libx11.}
proc XFreeColors*(para1: PDisplay, para2: TColormap, para3: Pculong, 
                  para4: Cint, para5: Culong): Cint{.libx11.}
proc XFreeCursor*(para1: PDisplay, para2: TCursor): Cint{.libx11.}
proc XFreeExtensionList*(para1: PPChar): Cint{.libx11.}
proc XFreeFont*(para1: PDisplay, para2: PXFontStruct): Cint{.libx11.}
proc XFreeFontInfo*(para1: PPChar, para2: PXFontStruct, para3: Cint): Cint{.
    libx11.}
proc XFreeFontNames*(para1: PPChar): Cint{.libx11.}
proc XFreeFontPath*(para1: PPChar): Cint{.libx11.}
proc XFreeGC*(para1: PDisplay, para2: TGC): Cint{.libx11.}
proc XFreeModifiermap*(para1: PXModifierKeymap): Cint{.libx11.}
proc XFreePixmap*(para1: PDisplay, para2: TPixmap): Cint{.libx11.}
proc XGeometry*(para1: PDisplay, para2: Cint, para3: Cstring, para4: Cstring, 
                para5: Cuint, para6: Cuint, para7: Cuint, para8: Cint, 
                para9: Cint, para10: Pcint, para11: Pcint, para12: Pcint, 
                para13: Pcint): Cint{.libx11.}
proc XGetErrorDatabaseText*(para1: PDisplay, para2: Cstring, para3: Cstring, 
                            para4: Cstring, para5: Cstring, para6: Cint): Cint{.
    libx11.}
proc XGetErrorText*(para1: PDisplay, para2: Cint, para3: Cstring, para4: Cint): Cint{.
    libx11.}
proc XGetFontProperty*(para1: PXFontStruct, para2: TAtom, para3: Pculong): TBool{.
    libx11.}
proc XGetGCValues*(para1: PDisplay, para2: TGC, para3: Culong, para4: PXGCValues): TStatus{.
    libx11.}
proc XGetGeometry*(para1: PDisplay, para2: TDrawable, para3: PWindow, 
                   para4: Pcint, para5: Pcint, para6: Pcuint, para7: Pcuint, 
                   para8: Pcuint, para9: Pcuint): TStatus{.libx11.}
proc XGetIconName*(para1: PDisplay, para2: TWindow, para3: PPChar): TStatus{.
    libx11.}
proc XGetInputFocus*(para1: PDisplay, para2: PWindow, para3: Pcint): Cint{.
    libx11.}
proc XGetKeyboardControl*(para1: PDisplay, para2: PXKeyboardState): Cint{.libx11.}
proc XGetPointerControl*(para1: PDisplay, para2: Pcint, para3: Pcint, 
                         para4: Pcint): Cint{.libx11.}
proc XGetPointerMapping*(para1: PDisplay, para2: Pcuchar, para3: Cint): Cint{.
    libx11.}
proc XGetScreenSaver*(para1: PDisplay, para2: Pcint, para3: Pcint, para4: Pcint, 
                      para5: Pcint): Cint{.libx11.}
proc XGetTransientForHint*(para1: PDisplay, para2: TWindow, para3: PWindow): TStatus{.
    libx11.}
proc XGetWindowProperty*(para1: PDisplay, para2: TWindow, para3: TAtom, 
                         para4: Clong, para5: Clong, para6: TBool, para7: TAtom, 
                         para8: PAtom, para9: Pcint, para10: Pculong, 
                         para11: Pculong, para12: PPcuchar): Cint{.libx11.}
proc XGetWindowAttributes*(para1: PDisplay, para2: TWindow, 
                           para3: PXWindowAttributes): TStatus{.libx11.}
proc XGrabButton*(para1: PDisplay, para2: Cuint, para3: Cuint, para4: TWindow, 
                  para5: TBool, para6: Cuint, para7: Cint, para8: Cint, 
                  para9: TWindow, para10: TCursor): Cint{.libx11.}
proc XGrabKey*(para1: PDisplay, para2: Cint, para3: Cuint, para4: TWindow, 
               para5: TBool, para6: Cint, para7: Cint): Cint{.libx11.}
proc XGrabKeyboard*(para1: PDisplay, para2: TWindow, para3: TBool, para4: Cint, 
                    para5: Cint, para6: TTime): Cint{.libx11.}
proc XGrabPointer*(para1: PDisplay, para2: TWindow, para3: TBool, para4: Cuint, 
                   para5: Cint, para6: Cint, para7: TWindow, para8: TCursor, 
                   para9: TTime): Cint{.libx11.}
proc XGrabServer*(para1: PDisplay): Cint{.libx11.}
proc XHeightMMOfScreen*(para1: PScreen): Cint{.libx11.}
proc XHeightOfScreen*(para1: PScreen): Cint{.libx11.}
proc XIfEvent*(para1: PDisplay, para2: PXEvent, para3: Funcifevent, 
               para4: TXPointer): Cint{.libx11.}
proc XImageByteOrder*(para1: PDisplay): Cint{.libx11.}
proc XInstallColormap*(para1: PDisplay, para2: TColormap): Cint{.libx11.}
proc XKeysymToKeycode*(para1: PDisplay, para2: TKeySym): TKeyCode{.libx11.}
proc XKillClient*(para1: PDisplay, para2: TXID): Cint{.libx11.}
proc XLookupColor*(para1: PDisplay, para2: TColormap, para3: Cstring, 
                   para4: PXColor, para5: PXColor): TStatus{.libx11.}
proc XLowerWindow*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XMapRaised*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XMapSubwindows*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XMapWindow*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XMaskEvent*(para1: PDisplay, para2: Clong, para3: PXEvent): Cint{.libx11.}
proc XMaxCmapsOfScreen*(para1: PScreen): Cint{.libx11.}
proc XMinCmapsOfScreen*(para1: PScreen): Cint{.libx11.}
proc XMoveResizeWindow*(para1: PDisplay, para2: TWindow, para3: Cint, 
                        para4: Cint, para5: Cuint, para6: Cuint): Cint{.libx11.}
proc XMoveWindow*(para1: PDisplay, para2: TWindow, para3: Cint, para4: Cint): Cint{.
    libx11.}
proc XNextEvent*(para1: PDisplay, para2: PXEvent): Cint{.libx11.}
proc XNoOp*(para1: PDisplay): Cint{.libx11.}
proc XParseColor*(para1: PDisplay, para2: TColormap, para3: Cstring, 
                  para4: PXColor): TStatus{.libx11.}
proc XParseGeometry*(para1: Cstring, para2: Pcint, para3: Pcint, para4: Pcuint, 
                     para5: Pcuint): Cint{.libx11.}
proc XPeekEvent*(para1: PDisplay, para2: PXEvent): Cint{.libx11.}
proc XPeekIfEvent*(para1: PDisplay, para2: PXEvent, para3: Funcifevent, 
                   para4: TXPointer): Cint{.libx11.}
proc XPending*(para1: PDisplay): Cint{.libx11.}
proc XPlanesOfScreen*(para1: PScreen): Cint{.libx11.}
proc XProtocolRevision*(para1: PDisplay): Cint{.libx11.}
proc XProtocolVersion*(para1: PDisplay): Cint{.libx11.}
proc XPutBackEvent*(para1: PDisplay, para2: PXEvent): Cint{.libx11.}
proc XPutImage*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: PXImage, 
                para5: Cint, para6: Cint, para7: Cint, para8: Cint, 
                para9: Cuint, para10: Cuint): Cint{.libx11.}
proc XQLength*(para1: PDisplay): Cint{.libx11.}
proc XQueryBestCursor*(para1: PDisplay, para2: TDrawable, para3: Cuint, 
                       para4: Cuint, para5: Pcuint, para6: Pcuint): TStatus{.
    libx11.}
proc XQueryBestSize*(para1: PDisplay, para2: Cint, para3: TDrawable, 
                     para4: Cuint, para5: Cuint, para6: Pcuint, para7: Pcuint): TStatus{.
    libx11.}
proc XQueryBestStipple*(para1: PDisplay, para2: TDrawable, para3: Cuint, 
                        para4: Cuint, para5: Pcuint, para6: Pcuint): TStatus{.
    libx11.}
proc XQueryBestTile*(para1: PDisplay, para2: TDrawable, para3: Cuint, 
                     para4: Cuint, para5: Pcuint, para6: Pcuint): TStatus{.
    libx11.}
proc XQueryColor*(para1: PDisplay, para2: TColormap, para3: PXColor): Cint{.
    libx11.}
proc XQueryColors*(para1: PDisplay, para2: TColormap, para3: PXColor, 
                   para4: Cint): Cint{.libx11.}
proc XQueryExtension*(para1: PDisplay, para2: Cstring, para3: Pcint, 
                      para4: Pcint, para5: Pcint): TBool{.libx11.}
  #?
proc XQueryKeymap*(para1: PDisplay, para2: Chararr32): Cint{.libx11.}
proc XQueryPointer*(para1: PDisplay, para2: TWindow, para3: PWindow, 
                    para4: PWindow, para5: Pcint, para6: Pcint, para7: Pcint, 
                    para8: Pcint, para9: Pcuint): TBool{.libx11.}
proc XQueryTextExtents*(para1: PDisplay, para2: TXID, para3: Cstring, 
                        para4: Cint, para5: Pcint, para6: Pcint, para7: Pcint, 
                        para8: PXCharStruct): Cint{.libx11.}
proc XQueryTextExtents16*(para1: PDisplay, para2: TXID, para3: PXChar2b, 
                          para4: Cint, para5: Pcint, para6: Pcint, para7: Pcint, 
                          para8: PXCharStruct): Cint{.libx11.}
proc XQueryTree*(para1: PDisplay, para2: TWindow, para3: PWindow, 
                 para4: PWindow, para5: PPWindow, para6: Pcuint): TStatus{.
    libx11.}
proc XRaiseWindow*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XReadBitmapFile*(para1: PDisplay, para2: TDrawable, para3: Cstring, 
                      para4: Pcuint, para5: Pcuint, para6: PPixmap, 
                      para7: Pcint, para8: Pcint): Cint{.libx11.}
proc XReadBitmapFileData*(para1: Cstring, para2: Pcuint, para3: Pcuint, 
                          para4: PPcuchar, para5: Pcint, para6: Pcint): Cint{.
    libx11.}
proc XRebindKeysym*(para1: PDisplay, para2: TKeySym, para3: PKeySym, 
                    para4: Cint, para5: Pcuchar, para6: Cint): Cint{.libx11.}
proc XRecolorCursor*(para1: PDisplay, para2: TCursor, para3: PXColor, 
                     para4: PXColor): Cint{.libx11.}
proc XRefreshKeyboardMapping*(para1: PXMappingEvent): Cint{.libx11.}
proc XRemoveFromSaveSet*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XRemoveHost*(para1: PDisplay, para2: PXHostAddress): Cint{.libx11.}
proc XRemoveHosts*(para1: PDisplay, para2: PXHostAddress, para3: Cint): Cint{.
    libx11.}
proc XReparentWindow*(para1: PDisplay, para2: TWindow, para3: TWindow, 
                      para4: Cint, para5: Cint): Cint{.libx11.}
proc XResetScreenSaver*(para1: PDisplay): Cint{.libx11.}
proc XResizeWindow*(para1: PDisplay, para2: TWindow, para3: Cuint, para4: Cuint): Cint{.
    libx11.}
proc XRestackWindows*(para1: PDisplay, para2: PWindow, para3: Cint): Cint{.
    libx11.}
proc XRotateBuffers*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XRotateWindowProperties*(para1: PDisplay, para2: TWindow, para3: PAtom, 
                              para4: Cint, para5: Cint): Cint{.libx11.}
proc XScreenCount*(para1: PDisplay): Cint{.libx11.}
proc XSelectInput*(para1: PDisplay, para2: TWindow, para3: Clong): Cint{.libx11.}
proc XSendEvent*(para1: PDisplay, para2: TWindow, para3: TBool, para4: Clong, 
                 para5: PXEvent): TStatus{.libx11.}
proc XSetAccessControl*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XSetArcMode*(para1: PDisplay, para2: TGC, para3: Cint): Cint{.libx11.}
proc XSetBackground*(para1: PDisplay, para2: TGC, para3: Culong): Cint{.libx11.}
proc XSetClipMask*(para1: PDisplay, para2: TGC, para3: TPixmap): Cint{.libx11.}
proc XSetClipOrigin*(para1: PDisplay, para2: TGC, para3: Cint, para4: Cint): Cint{.
    libx11.}
proc XSetClipRectangles*(para1: PDisplay, para2: TGC, para3: Cint, para4: Cint, 
                         para5: PXRectangle, para6: Cint, para7: Cint): Cint{.
    libx11.}
proc XSetCloseDownMode*(para1: PDisplay, para2: Cint): Cint{.libx11.}
proc XSetCommand*(para1: PDisplay, para2: TWindow, para3: PPChar, para4: Cint): Cint{.
    libx11.}
proc XSetDashes*(para1: PDisplay, para2: TGC, para3: Cint, para4: Cstring, 
                 para5: Cint): Cint{.libx11.}
proc XSetFillRule*(para1: PDisplay, para2: TGC, para3: Cint): Cint{.libx11.}
proc XSetFillStyle*(para1: PDisplay, para2: TGC, para3: Cint): Cint{.libx11.}
proc XSetFont*(para1: PDisplay, para2: TGC, para3: TFont): Cint{.libx11.}
proc XSetFontPath*(para1: PDisplay, para2: PPChar, para3: Cint): Cint{.libx11.}
proc XSetForeground*(para1: PDisplay, para2: TGC, para3: Culong): Cint{.libx11.}
proc XSetFunction*(para1: PDisplay, para2: TGC, para3: Cint): Cint{.libx11.}
proc XSetGraphicsExposures*(para1: PDisplay, para2: TGC, para3: TBool): Cint{.
    libx11.}
proc XSetIconName*(para1: PDisplay, para2: TWindow, para3: Cstring): Cint{.
    libx11.}
proc XSetInputFocus*(para1: PDisplay, para2: TWindow, para3: Cint, para4: TTime): Cint{.
    libx11.}
proc XSetLineAttributes*(para1: PDisplay, para2: TGC, para3: Cuint, para4: Cint, 
                         para5: Cint, para6: Cint): Cint{.libx11.}
proc XSetModifierMapping*(para1: PDisplay, para2: PXModifierKeymap): Cint{.
    libx11.}
proc XSetPlaneMask*(para1: PDisplay, para2: TGC, para3: Culong): Cint{.libx11.}
proc XSetPointerMapping*(para1: PDisplay, para2: Pcuchar, para3: Cint): Cint{.
    libx11.}
proc XSetScreenSaver*(para1: PDisplay, para2: Cint, para3: Cint, para4: Cint, 
                      para5: Cint): Cint{.libx11.}
proc XSetSelectionOwner*(para1: PDisplay, para2: TAtom, para3: TWindow, 
                         para4: TTime): Cint{.libx11.}
proc XSetState*(para1: PDisplay, para2: TGC, para3: Culong, para4: Culong, 
                para5: Cint, para6: Culong): Cint{.libx11.}
proc XSetStipple*(para1: PDisplay, para2: TGC, para3: TPixmap): Cint{.libx11.}
proc XSetSubwindowMode*(para1: PDisplay, para2: TGC, para3: Cint): Cint{.libx11.}
proc XSetTSOrigin*(para1: PDisplay, para2: TGC, para3: Cint, para4: Cint): Cint{.
    libx11.}
proc XSetTile*(para1: PDisplay, para2: TGC, para3: TPixmap): Cint{.libx11.}
proc XSetWindowBackground*(para1: PDisplay, para2: TWindow, para3: Culong): Cint{.
    libx11.}
proc XSetWindowBackgroundPixmap*(para1: PDisplay, para2: TWindow, para3: TPixmap): Cint{.
    libx11.}
proc XSetWindowBorder*(para1: PDisplay, para2: TWindow, para3: Culong): Cint{.
    libx11.}
proc XSetWindowBorderPixmap*(para1: PDisplay, para2: TWindow, para3: TPixmap): Cint{.
    libx11.}
proc XSetWindowBorderWidth*(para1: PDisplay, para2: TWindow, para3: Cuint): Cint{.
    libx11.}
proc XSetWindowColormap*(para1: PDisplay, para2: TWindow, para3: TColormap): Cint{.
    libx11.}
proc XStoreBuffer*(para1: PDisplay, para2: Cstring, para3: Cint, para4: Cint): Cint{.
    libx11.}
proc XStoreBytes*(para1: PDisplay, para2: Cstring, para3: Cint): Cint{.libx11.}
proc XStoreColor*(para1: PDisplay, para2: TColormap, para3: PXColor): Cint{.
    libx11.}
proc XStoreColors*(para1: PDisplay, para2: TColormap, para3: PXColor, 
                   para4: Cint): Cint{.libx11.}
proc XStoreName*(para1: PDisplay, para2: TWindow, para3: Cstring): Cint{.libx11.}
proc XStoreNamedColor*(para1: PDisplay, para2: TColormap, para3: Cstring, 
                       para4: Culong, para5: Cint): Cint{.libx11.}
proc XSync*(para1: PDisplay, para2: TBool): Cint{.libx11.}
proc XTextExtents*(para1: PXFontStruct, para2: Cstring, para3: Cint, 
                   para4: Pcint, para5: Pcint, para6: Pcint, para7: PXCharStruct): Cint{.
    libx11.}
proc XTextExtents16*(para1: PXFontStruct, para2: PXChar2b, para3: Cint, 
                     para4: Pcint, para5: Pcint, para6: Pcint, 
                     para7: PXCharStruct): Cint{.libx11.}
proc XTextWidth*(para1: PXFontStruct, para2: Cstring, para3: Cint): Cint{.libx11.}
proc XTextWidth16*(para1: PXFontStruct, para2: PXChar2b, para3: Cint): Cint{.
    libx11.}
proc XTranslateCoordinates*(para1: PDisplay, para2: TWindow, para3: TWindow, 
                            para4: Cint, para5: Cint, para6: Pcint, 
                            para7: Pcint, para8: PWindow): TBool{.libx11.}
proc XUndefineCursor*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XUngrabButton*(para1: PDisplay, para2: Cuint, para3: Cuint, para4: TWindow): Cint{.
    libx11.}
proc XUngrabKey*(para1: PDisplay, para2: Cint, para3: Cuint, para4: TWindow): Cint{.
    libx11.}
proc XUngrabKeyboard*(para1: PDisplay, para2: TTime): Cint{.libx11.}
proc XUngrabPointer*(para1: PDisplay, para2: TTime): Cint{.libx11.}
proc XUngrabServer*(para1: PDisplay): Cint{.libx11.}
proc XUninstallColormap*(para1: PDisplay, para2: TColormap): Cint{.libx11.}
proc XUnloadFont*(para1: PDisplay, para2: TFont): Cint{.libx11.}
proc XUnmapSubwindows*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XUnmapWindow*(para1: PDisplay, para2: TWindow): Cint{.libx11.}
proc XVendorRelease*(para1: PDisplay): Cint{.libx11.}
proc XWarpPointer*(para1: PDisplay, para2: TWindow, para3: TWindow, para4: Cint, 
                   para5: Cint, para6: Cuint, para7: Cuint, para8: Cint, 
                   para9: Cint): Cint{.libx11.}
proc XWidthMMOfScreen*(para1: PScreen): Cint{.libx11.}
proc XWidthOfScreen*(para1: PScreen): Cint{.libx11.}
proc XWindowEvent*(para1: PDisplay, para2: TWindow, para3: Clong, para4: PXEvent): Cint{.
    libx11.}
proc XWriteBitmapFile*(para1: PDisplay, para2: Cstring, para3: TPixmap, 
                       para4: Cuint, para5: Cuint, para6: Cint, para7: Cint): Cint{.
    libx11.}
proc XSupportsLocale*(): TBool{.libx11.}
proc XSetLocaleModifiers*(para1: Cstring): Cstring{.libx11.}
proc XOpenOM*(para1: PDisplay, para2: PXrmHashBucketRec, para3: Cstring, 
              para4: Cstring): TXOM{.libx11.}
proc XCloseOM*(para1: TXOM): TStatus{.libx11.}
proc XSetOMValues*(para1: TXOM): Cstring{.varargs, libx11.}
proc XGetOMValues*(para1: TXOM): Cstring{.varargs, libx11.}
proc XDisplayOfOM*(para1: TXOM): PDisplay{.libx11.}
proc XLocaleOfOM*(para1: TXOM): Cstring{.libx11.}
proc XCreateOC*(para1: TXOM): TXOC{.varargs, libx11.}
proc XDestroyOC*(para1: TXOC){.libx11.}
proc XOMOfOC*(para1: TXOC): TXOM{.libx11.}
proc XSetOCValues*(para1: TXOC): Cstring{.varargs, libx11.}
proc XGetOCValues*(para1: TXOC): Cstring{.varargs, libx11.}
proc XCreateFontSet*(para1: PDisplay, para2: Cstring, para3: PPPChar, 
                     para4: Pcint, para5: PPChar): TXFontSet{.libx11.}
proc XFreeFontSet*(para1: PDisplay, para2: TXFontSet){.libx11.}
proc XFontsOfFontSet*(para1: TXFontSet, para2: PPPXFontStruct, para3: PPPChar): Cint{.
    libx11.}
proc XBaseFontNameListOfFontSet*(para1: TXFontSet): Cstring{.libx11.}
proc XLocaleOfFontSet*(para1: TXFontSet): Cstring{.libx11.}
proc XContextDependentDrawing*(para1: TXFontSet): TBool{.libx11.}
proc XDirectionalDependentDrawing*(para1: TXFontSet): TBool{.libx11.}
proc XContextualDrawing*(para1: TXFontSet): TBool{.libx11.}
proc XExtentsOfFontSet*(para1: TXFontSet): PXFontSetExtents{.libx11.}
proc XmbTextEscapement*(para1: TXFontSet, para2: Cstring, para3: Cint): Cint{.
    libx11.}
proc XwcTextEscapement*(para1: TXFontSet, para2: PWideChar, para3: Cint): Cint{.
    libx11.}
proc Xutf8TextEscapement*(para1: TXFontSet, para2: Cstring, para3: Cint): Cint{.
    libx11.}
proc XmbTextExtents*(para1: TXFontSet, para2: Cstring, para3: Cint, 
                     para4: PXRectangle, para5: PXRectangle): Cint{.libx11.}
proc XwcTextExtents*(para1: TXFontSet, para2: PWideChar, para3: Cint, 
                     para4: PXRectangle, para5: PXRectangle): Cint{.libx11.}
proc Xutf8TextExtents*(para1: TXFontSet, para2: Cstring, para3: Cint, 
                       para4: PXRectangle, para5: PXRectangle): Cint{.libx11.}
proc XmbTextPerCharExtents*(para1: TXFontSet, para2: Cstring, para3: Cint, 
                            para4: PXRectangle, para5: PXRectangle, para6: Cint, 
                            para7: Pcint, para8: PXRectangle, para9: PXRectangle): TStatus{.
    libx11.}
proc XwcTextPerCharExtents*(para1: TXFontSet, para2: PWideChar, para3: Cint, 
                            para4: PXRectangle, para5: PXRectangle, para6: Cint, 
                            para7: Pcint, para8: PXRectangle, para9: PXRectangle): TStatus{.
    libx11.}
proc Xutf8TextPerCharExtents*(para1: TXFontSet, para2: Cstring, para3: Cint, 
                              para4: PXRectangle, para5: PXRectangle, 
                              para6: Cint, para7: Pcint, para8: PXRectangle, 
                              para9: PXRectangle): TStatus{.libx11.}
proc XmbDrawText*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                  para5: Cint, para6: PXmbTextItem, para7: Cint){.libx11.}
proc XwcDrawText*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                  para5: Cint, para6: PXwcTextItem, para7: Cint){.libx11.}
proc Xutf8DrawText*(para1: PDisplay, para2: TDrawable, para3: TGC, para4: Cint, 
                    para5: Cint, para6: PXmbTextItem, para7: Cint){.libx11.}
proc XmbDrawString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet, 
                    para4: TGC, para5: Cint, para6: Cint, para7: Cstring, 
                    para8: Cint){.libx11.}
proc XwcDrawString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet, 
                    para4: TGC, para5: Cint, para6: Cint, para7: PWideChar, 
                    para8: Cint){.libx11.}
proc Xutf8DrawString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet, 
                      para4: TGC, para5: Cint, para6: Cint, para7: Cstring, 
                      para8: Cint){.libx11.}
proc XmbDrawImageString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet, 
                         para4: TGC, para5: Cint, para6: Cint, para7: Cstring, 
                         para8: Cint){.libx11.}
proc XwcDrawImageString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet, 
                         para4: TGC, para5: Cint, para6: Cint, para7: PWideChar, 
                         para8: Cint){.libx11.}
proc Xutf8DrawImageString*(para1: PDisplay, para2: TDrawable, para3: TXFontSet, 
                           para4: TGC, para5: Cint, para6: Cint, para7: Cstring, 
                           para8: Cint){.libx11.}
proc XOpenIM*(para1: PDisplay, para2: PXrmHashBucketRec, para3: Cstring, 
              para4: Cstring): TXIM{.libx11.}
proc XCloseIM*(para1: TXIM): TStatus{.libx11.}
proc XGetIMValues*(para1: TXIM): Cstring{.varargs, libx11.}
proc XSetIMValues*(para1: TXIM): Cstring{.varargs, libx11.}
proc XDisplayOfIM*(para1: TXIM): PDisplay{.libx11.}
proc XLocaleOfIM*(para1: TXIM): Cstring{.libx11.}
proc XCreateIC*(para1: TXIM): TXIC{.varargs, libx11.}
proc XDestroyIC*(para1: TXIC){.libx11.}
proc XSetICFocus*(para1: TXIC){.libx11.}
proc XUnsetICFocus*(para1: TXIC){.libx11.}
proc XwcResetIC*(para1: TXIC): PWideChar{.libx11.}
proc XmbResetIC*(para1: TXIC): Cstring{.libx11.}
proc Xutf8ResetIC*(para1: TXIC): Cstring{.libx11.}
proc XSetICValues*(para1: TXIC): Cstring{.varargs, libx11.}
proc XGetICValues*(para1: TXIC): Cstring{.varargs, libx11.}
proc XIMOfIC*(para1: TXIC): TXIM{.libx11.}
proc XFilterEvent*(para1: PXEvent, para2: TWindow): TBool{.libx11.}
proc XmbLookupString*(para1: TXIC, para2: PXKeyPressedEvent, para3: Cstring, 
                      para4: Cint, para5: PKeySym, para6: PStatus): Cint{.libx11.}
proc XwcLookupString*(para1: TXIC, para2: PXKeyPressedEvent, para3: PWideChar, 
                      para4: Cint, para5: PKeySym, para6: PStatus): Cint{.libx11.}
proc Xutf8LookupString*(para1: TXIC, para2: PXKeyPressedEvent, para3: Cstring, 
                        para4: Cint, para5: PKeySym, para6: PStatus): Cint{.
    libx11.}
proc XVaCreateNestedList*(unused: Cint): TXVaNestedList{.varargs, libx11.}
proc XRegisterIMInstantiateCallback*(para1: PDisplay, para2: PXrmHashBucketRec, 
                                     para3: Cstring, para4: Cstring, 
                                     para5: TXIDProc, para6: TXPointer): TBool{.
    libx11.}
proc XUnregisterIMInstantiateCallback*(para1: PDisplay, 
                                       para2: PXrmHashBucketRec, para3: Cstring, 
                                       para4: Cstring, para5: TXIDProc, 
                                       para6: TXPointer): TBool{.libx11.}
type 
  TXConnectionWatchProc* = proc (para1: PDisplay, para2: TXPointer, para3: Cint, 
                                 para4: TBool, para5: PXPointer){.cdecl.}

proc XInternalConnectionNumbers*(para1: PDisplay, para2: PPcint, para3: Pcint): TStatus{.
    libx11.}
proc XProcessInternalConnection*(para1: PDisplay, para2: Cint){.libx11.}
proc XAddConnectionWatch*(para1: PDisplay, para2: TXConnectionWatchProc, 
                          para3: TXPointer): TStatus{.libx11.}
proc XRemoveConnectionWatch*(para1: PDisplay, para2: TXConnectionWatchProc, 
                             para3: TXPointer){.libx11.}
proc XSetAuthorization*(para1: Cstring, para2: Cint, para3: Cstring, para4: Cint){.
    libx11.}
  #
  #  _Xmbtowc?
  #  _Xwctomb?
  #
when defined(MACROS): 
  proc ConnectionNumber*(dpy: PDisplay): cint
  proc RootWindow*(dpy: PDisplay, scr: cint): TWindow
  proc DefaultScreen*(dpy: PDisplay): cint
  proc DefaultRootWindow*(dpy: PDisplay): TWindow
  proc DefaultVisual*(dpy: PDisplay, scr: cint): PVisual
  proc DefaultGC*(dpy: PDisplay, scr: cint): TGC
  proc BlackPixel*(dpy: PDisplay, scr: cint): culong
  proc WhitePixel*(dpy: PDisplay, scr: cint): culong
  proc QLength*(dpy: PDisplay): cint
  proc DisplayWidth*(dpy: PDisplay, scr: cint): cint
  proc DisplayHeight*(dpy: PDisplay, scr: cint): cint
  proc DisplayWidthMM*(dpy: PDisplay, scr: cint): cint
  proc DisplayHeightMM*(dpy: PDisplay, scr: cint): cint
  proc DisplayPlanes*(dpy: PDisplay, scr: cint): cint
  proc DisplayCells*(dpy: PDisplay, scr: cint): cint
  proc ScreenCount*(dpy: PDisplay): cint
  proc ServerVendor*(dpy: PDisplay): cstring
  proc ProtocolVersion*(dpy: PDisplay): cint
  proc ProtocolRevision*(dpy: PDisplay): cint
  proc VendorRelease*(dpy: PDisplay): cint
  proc DisplayString*(dpy: PDisplay): cstring
  proc DefaultDepth*(dpy: PDisplay, scr: cint): cint
  proc DefaultColormap*(dpy: PDisplay, scr: cint): TColormap
  proc BitmapUnit*(dpy: PDisplay): cint
  proc BitmapBitOrder*(dpy: PDisplay): cint
  proc BitmapPad*(dpy: PDisplay): cint
  proc ImageByteOrder*(dpy: PDisplay): cint
  proc NextRequest*(dpy: PDisplay): culong
  proc LastKnownRequestProcessed*(dpy: PDisplay): culong
  proc ScreenOfDisplay*(dpy: PDisplay, scr: cint): PScreen
  proc DefaultScreenOfDisplay*(dpy: PDisplay): PScreen
  proc DisplayOfScreen*(s: PScreen): PDisplay
  proc RootWindowOfScreen*(s: PScreen): TWindow
  proc BlackPixelOfScreen*(s: PScreen): culong
  proc WhitePixelOfScreen*(s: PScreen): culong
  proc DefaultColormapOfScreen*(s: PScreen): TColormap
  proc DefaultDepthOfScreen*(s: PScreen): cint
  proc DefaultGCOfScreen*(s: PScreen): TGC
  proc DefaultVisualOfScreen*(s: PScreen): PVisual
  proc WidthOfScreen*(s: PScreen): cint
  proc HeightOfScreen*(s: PScreen): cint
  proc WidthMMOfScreen*(s: PScreen): cint
  proc HeightMMOfScreen*(s: PScreen): cint
  proc PlanesOfScreen*(s: PScreen): cint
  proc CellsOfScreen*(s: PScreen): cint
  proc MinCmapsOfScreen*(s: PScreen): cint
  proc MaxCmapsOfScreen*(s: PScreen): cint
  proc DoesSaveUnders*(s: PScreen): TBool
  proc DoesBackingStore*(s: PScreen): cint
  proc EventMaskOfScreen*(s: PScreen): clong
  proc XAllocID*(dpy: PDisplay): TXID
# implementation

when defined(MACROS): 
  proc ConnectionNumber(dpy: PDisplay): cint = 
    ConnectionNumber = (PXPrivDisplay(dpy))[] .fd

  proc RootWindow(dpy: PDisplay, scr: cint): TWindow = 
    RootWindow = (ScreenOfDisplay(dpy, scr))[] .root

  proc DefaultScreen(dpy: PDisplay): cint = 
    DefaultScreen = (PXPrivDisplay(dpy))[] .default_screen

  proc DefaultRootWindow(dpy: PDisplay): TWindow = 
    DefaultRootWindow = (ScreenOfDisplay(dpy, DefaultScreen(dpy)))[] .root

  proc DefaultVisual(dpy: PDisplay, scr: cint): PVisual = 
    DefaultVisual = (ScreenOfDisplay(dpy, scr))[] .root_visual

  proc DefaultGC(dpy: PDisplay, scr: cint): TGC = 
    DefaultGC = (ScreenOfDisplay(dpy, scr))[] .default_gc

  proc BlackPixel(dpy: PDisplay, scr: cint): culong = 
    BlackPixel = (ScreenOfDisplay(dpy, scr))[] .black_pixel

  proc WhitePixel(dpy: PDisplay, scr: cint): culong = 
    WhitePixel = (ScreenOfDisplay(dpy, scr))[] .white_pixel

  proc QLength(dpy: PDisplay): cint = 
    QLength = (PXPrivDisplay(dpy))[] .qlen

  proc DisplayWidth(dpy: PDisplay, scr: cint): cint = 
    DisplayWidth = (ScreenOfDisplay(dpy, scr))[] .width

  proc DisplayHeight(dpy: PDisplay, scr: cint): cint = 
    DisplayHeight = (ScreenOfDisplay(dpy, scr))[] .height

  proc DisplayWidthMM(dpy: PDisplay, scr: cint): cint = 
    DisplayWidthMM = (ScreenOfDisplay(dpy, scr))[] .mwidth

  proc DisplayHeightMM(dpy: PDisplay, scr: cint): cint = 
    DisplayHeightMM = (ScreenOfDisplay(dpy, scr))[] .mheight

  proc DisplayPlanes(dpy: PDisplay, scr: cint): cint = 
    DisplayPlanes = (ScreenOfDisplay(dpy, scr))[] .root_depth

  proc DisplayCells(dpy: PDisplay, scr: cint): cint = 
    DisplayCells = (DefaultVisual(dpy, scr))[] .map_entries

  proc ScreenCount(dpy: PDisplay): cint = 
    ScreenCount = (PXPrivDisplay(dpy))[] .nscreens

  proc ServerVendor(dpy: PDisplay): cstring = 
    ServerVendor = (PXPrivDisplay(dpy))[] .vendor

  proc ProtocolVersion(dpy: PDisplay): cint = 
    ProtocolVersion = (PXPrivDisplay(dpy))[] .proto_major_version

  proc ProtocolRevision(dpy: PDisplay): cint = 
    ProtocolRevision = (PXPrivDisplay(dpy))[] .proto_minor_version

  proc VendorRelease(dpy: PDisplay): cint = 
    VendorRelease = (PXPrivDisplay(dpy))[] .release

  proc DisplayString(dpy: PDisplay): cstring = 
    DisplayString = (PXPrivDisplay(dpy))[] .display_name

  proc DefaultDepth(dpy: PDisplay, scr: cint): cint = 
    DefaultDepth = (ScreenOfDisplay(dpy, scr))[] .root_depth

  proc DefaultColormap(dpy: PDisplay, scr: cint): TColormap = 
    DefaultColormap = (ScreenOfDisplay(dpy, scr))[] .cmap

  proc BitmapUnit(dpy: PDisplay): cint = 
    BitmapUnit = (PXPrivDisplay(dpy))[] .bitmap_unit

  proc BitmapBitOrder(dpy: PDisplay): cint = 
    BitmapBitOrder = (PXPrivDisplay(dpy))[] .bitmap_bit_order

  proc BitmapPad(dpy: PDisplay): cint = 
    BitmapPad = (PXPrivDisplay(dpy))[] .bitmap_pad

  proc ImageByteOrder(dpy: PDisplay): cint = 
    ImageByteOrder = (PXPrivDisplay(dpy))[] .byte_order

  proc NextRequest(dpy: PDisplay): culong = 
    NextRequest = ((PXPrivDisplay(dpy))[] .request) + 1

  proc LastKnownRequestProcessed(dpy: PDisplay): culong = 
    LastKnownRequestProcessed = (PXPrivDisplay(dpy))[] .last_request_read

  proc ScreenOfDisplay(dpy: PDisplay, scr: cint): PScreen = 
    ScreenOfDisplay = addr((((PXPrivDisplay(dpy))[] .screens)[scr]))

  proc DefaultScreenOfDisplay(dpy: PDisplay): PScreen = 
    DefaultScreenOfDisplay = ScreenOfDisplay(dpy, DefaultScreen(dpy))

  proc DisplayOfScreen(s: PScreen): PDisplay = 
    DisplayOfScreen = s[] .display

  proc RootWindowOfScreen(s: PScreen): TWindow = 
    RootWindowOfScreen = s[] .root

  proc BlackPixelOfScreen(s: PScreen): culong = 
    BlackPixelOfScreen = s[] .black_pixel

  proc WhitePixelOfScreen(s: PScreen): culong = 
    WhitePixelOfScreen = s[] .white_pixel

  proc DefaultColormapOfScreen(s: PScreen): TColormap = 
    DefaultColormapOfScreen = s[] .cmap

  proc DefaultDepthOfScreen(s: PScreen): cint = 
    DefaultDepthOfScreen = s[] .root_depth

  proc DefaultGCOfScreen(s: PScreen): TGC = 
    DefaultGCOfScreen = s[] .default_gc

  proc DefaultVisualOfScreen(s: PScreen): PVisual = 
    DefaultVisualOfScreen = s[] .root_visual

  proc WidthOfScreen(s: PScreen): cint = 
    WidthOfScreen = s[] .width

  proc HeightOfScreen(s: PScreen): cint = 
    HeightOfScreen = s[] .height

  proc WidthMMOfScreen(s: PScreen): cint = 
    WidthMMOfScreen = s[] .mwidth

  proc HeightMMOfScreen(s: PScreen): cint = 
    HeightMMOfScreen = s[] .mheight

  proc PlanesOfScreen(s: PScreen): cint = 
    PlanesOfScreen = s[] .root_depth

  proc CellsOfScreen(s: PScreen): cint = 
    CellsOfScreen = (DefaultVisualOfScreen(s))[] .map_entries

  proc MinCmapsOfScreen(s: PScreen): cint = 
    MinCmapsOfScreen = s[] .min_maps

  proc MaxCmapsOfScreen(s: PScreen): cint = 
    MaxCmapsOfScreen = s[] .max_maps

  proc DoesSaveUnders(s: PScreen): TBool = 
    DoesSaveUnders = s[] .save_unders

  proc DoesBackingStore(s: PScreen): cint = 
    DoesBackingStore = s[] .backing_store

  proc EventMaskOfScreen(s: PScreen): clong = 
    EventMaskOfScreen = s[] .root_input_mask

  proc XAllocID(dpy: PDisplay): TXID = 
    XAllocID = (PXPrivDisplay(dpy))[] .resource_alloc(dpy)
