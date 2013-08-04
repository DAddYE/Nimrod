# Claro Graphics - an abstraction layer for native UI libraries
#  
#  $Id$
#  
#  The contents of this file are subject to the Mozilla Public License
#  Version 1.1 (the "License"); you may not use this file except in
#  compliance with the License. You may obtain a copy of the License at
#  http://www.mozilla.org/MPL/
#  
#  Software distributed under the License is distributed on an "AS IS"
#  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
#  License for the specific language governing rights and limitations
#  under the License.
#  
#  See the LICENSE file for more details.
# 

## Wrapper for the Claro GUI library. 
## This wrapper calls ``claro_base_init`` and ``claro_graphics_init`` 
## automatically on startup, so you don't have to do it and in fact cannot do
## it because they are not exported.

{.deadCodeElim: on.}

when defined(windows): 
  const 
    clarodll = "claro.dll"
elif defined(macosx): 
  const 
    clarodll = "libclaro.dylib"
else: 
  const 
    clarodll = "libclaro.so"

import cairo

type 
  TNode* {.pure.} = object 
    next*: ptr TNode
    prev*: ptr TNode        # pointer to real structure 
    data*: Pointer

  TList* {.pure.} = object 
    head*: ptr TNode
    tail*: ptr TNode        
    count*: Int32


proc listInit*(){.cdecl, importc: "list_init", dynlib: clarodll.}
proc listCreate*(list: ptr TList){.cdecl, importc: "list_create", 
                                      dynlib: clarodll.}
proc nodeCreate*(): ptr TNode{.cdecl, importc: "node_create", 
                                  dynlib: clarodll.}
proc nodeFree*(n: ptr TNode){.cdecl, importc: "node_free", dynlib: clarodll.}
proc nodeAdd*(data: Pointer, n: ptr TNode, L: ptr TList){.cdecl, 
    importc: "node_add", dynlib: clarodll.}
proc nodePrepend*(data: Pointer, n: ptr TNode, L: ptr TList){.cdecl, 
    importc: "node_prepend", dynlib: clarodll.}
proc nodeDel*(n: ptr TNode, L: ptr TList){.cdecl, importc: "node_del", 
    dynlib: clarodll.}
proc nodeFind*(data: Pointer, L: ptr TList): ptr TNode{.cdecl, 
    importc: "node_find", dynlib: clarodll.}
proc nodeMove*(n: ptr TNode, oldlist: ptr TList, newlist: ptr TList){.
    cdecl, importc: "node_move", dynlib: clarodll.}

type 
  TClaroObj*{.pure.} = object 
    typ*: Array[0..64 - 1, Char]
    destroy_pending*: Cint
    event_handlers*: TList
    children*: TList
    parent*: ptr TClaroObj
    appdata*: Pointer         # !! this is for APPLICATION USE ONLY !! 
  
  TEvent*{.pure.} = object 
    obj*: ptr TClaroObj    # the object which this event was sent to 
    name*: Array[0..64 - 1, Char]
    handled*: Cint
    arg_num*: Cint            # number of arguments 
    format*: Array[0..16 - 1, Char] # format of the arguments sent 
    arglist*: ptr Pointer     # list of args, as per format. 
  
  TEventFunc* = proc (obj: ptr TClaroObj, event: ptr TEvent){.cdecl.}
  TEventIfaceFunc* = proc (obj: ptr TClaroObj, event: ptr TEvent, 
                           data: Pointer){.cdecl.}
  TEventHandler*{.pure.} = object 
    typ*: Array[0..32 - 1, Char]
    data*: Pointer
    func*: TEventFunc   # the function that handles this event 
  

# #define event_handler(n) void n ( TClaroObj *object, event_t *event )
#CLVEXP list_t object_list;

proc objectInit*(){.cdecl, importc: "object_init", dynlib: clarodll.}

proc objectOverrideNextSize*(size: Cint){.cdecl, 
    importc: "object_override_next_size", dynlib: clarodll.}
  ## Overrides the size of next object to be created, providing the 
  ## size is more than is requested by default.
  ## 
  ## `size` specifies the full size, which is greater than both TClaroObj
  ## and the size that will be requested automatically.
    
proc eventGetArgPtr*(e: ptr TEvent, arg: Cint): Pointer{.cdecl, 
    importc: "event_get_arg_ptr", dynlib: clarodll.}
proc eventGetArgDouble*(e: ptr TEvent, arg: Cint): Cdouble{.cdecl, 
    importc: "event_get_arg_double", dynlib: clarodll.}
proc eventGetArgInt*(e: ptr TEvent, arg: Cint): Cint{.cdecl, 
    importc: "event_get_arg_int", dynlib: clarodll.}
proc objectCreate*(parent: ptr TClaroObj, size: Int32, 
                    typ: Cstring): ptr TClaroObj{.
    cdecl, importc: "object_create", dynlib: clarodll.}
proc objectDestroy*(obj: ptr TClaroObj){.cdecl, importc: "object_destroy", 
    dynlib: clarodll.}
proc objectSetParent*(obj: ptr TClaroObj, parent: ptr TClaroObj){.cdecl, 
    importc: "object_set_parent", dynlib: clarodll.}

##define object_cmptype(o,t) (!strcmp(((TClaroObj *)o)->type,t))

# event functions 

proc objectAddhandler*(obj: ptr TClaroObj, event: Cstring, 
                        func: TEventFunc){.cdecl, 
    importc: "object_addhandler", dynlib: clarodll.}
proc objectAddhandlerInterface*(obj: ptr TClaroObj, event: Cstring, 
                                  func: TEventFunc, data: Pointer){.cdecl, 
    importc: "object_addhandler_interface", dynlib: clarodll.}
proc eventSend*(obj: ptr TClaroObj, event: Cstring, fmt: Cstring): Cint{.
    varargs, cdecl, importc: "event_send", dynlib: clarodll.}
proc eventGetName*(event: ptr TEvent): Cstring{.cdecl, 
    importc: "event_get_name", dynlib: clarodll.}
proc claroBaseInit(){.cdecl, importc: "claro_base_init", dynlib: clarodll.}
proc claroLoop*(){.cdecl, importc: "claro_loop", dynlib: clarodll.}
proc claroRun*(){.cdecl, importc: "claro_run", dynlib: clarodll.}
proc claroShutdown*(){.cdecl, importc: "claro_shutdown", dynlib: clarodll.}
proc mssleep*(ms: Cint){.cdecl, importc: "mssleep", dynlib: clarodll.}
proc claroGraphicsInit(){.cdecl, importc: "claro_graphics_init", 
                            dynlib: clarodll.}

const 
  cWidgetNoBorder* = (1 shl 24)
  cWidgetCustomDraw* = (1 shl 25)

type 
  TBounds*{.pure.} = object 
    x*: Cint
    y*: Cint
    w*: Cint
    h*: Cint
    owner*: ptr TClaroObj


const 
  cSizeRequestChanged* = 1

type 
  TFont*{.pure.} = object 
    used*: Cint
    face*: Cstring
    size*: Cint
    weight*: Cint
    slant*: Cint
    decoration*: Cint
    native*: Pointer

  TColor*{.pure.} = object 
    used*: Cint
    r*: Cfloat
    g*: Cfloat
    b*: Cfloat
    a*: Cfloat

  TWidget* {.pure.} = object of TClaroObj
    size_req*: ptr TBounds
    size*: TBounds
    size_ct*: TBounds
    supports_alpha*: Cint
    size_flags*: Cint
    flags*: Cint
    visible*: Cint
    notify_flags*: Cint
    font*: TFont
    native*: Pointer          # native widget 
    ndata*: Pointer           # additional native data 
    container*: Pointer       # native widget container (if not ->native) 
    naddress*: Array[0..3, Pointer] # addressed for something 
                                    # we override or need to remember 
  
proc clipboardSetText*(w: ptr TWidget, text: Cstring): Cint{.cdecl, 
    importc: "clipboard_set_text", dynlib: clarodll.}
  ## Sets the (text) clipboard to the specified text value.
  ##
  ## `w` The widget requesting the action, some platforms may use this value.
  ## `text` The text to place in the clipboard.
  ## returns 1 on success, 0 on failure.

const 
  cNotifyMouse* = 1'i32
  cNotifyKey* = 2'i32

  cFontSlantNormal* = 0
  cFontSlantItalic* = 1
  cFontWeightNormal* = 0
  cFontWeightBold* = 1
  cFontDecorationNormal* = 0
  cFontDecorationUnderline* = 1


proc widgetSetFont*(widget: ptr TClaroObj, face: Cstring, size: Cint, 
                      weight: Cint, slant: Cint, decoration: Cint){.cdecl, 
    importc: "widget_set_font", dynlib: clarodll.}
  ## Sets the font details of the specified widget.
  ## 
  ##  `widget` A widget
  ##  `face` Font face string
  ##  `size` Size of the font in pixels
  ##  `weight` The weight of the font
  ##  `slant` The sland of the font
  ##  `decoration` The decoration of the font
    
proc widgetFontStringWidth*(widget: ptr TClaroObj, text: Cstring, 
                               chars: Cint): Cint {.
    cdecl, importc: "widget_font_string_width", dynlib: clarodll.}
  ## Calculates the pixel width of the text in the widget's font.
  ## `chars` is the number of characters of text to calculate. Return value
  ## is the width of the specified text in pixels.

const 
  ClaroApplication* = "claro.graphics"

type 
  TImage* {.pure.} = object of TClaroObj
    width*: Cint
    height*: Cint
    native*: Pointer
    native2*: Pointer
    native3*: Pointer
    icon*: Pointer


proc imageLoad*(parent: ptr TClaroObj, file: Cstring): ptr TImage{.cdecl, 
    importc: "image_load", dynlib: clarodll.}
  ## Loads an image from a file and returns a new image object.
  ## 
  ## The supported formats depend on the platform.
  ## The main effort is to ensure that PNG images will always work.
  ## Generally, JPEGs and possibly GIFs will also work.
  ##
  ## `Parent` object (usually the application's main window), can be nil.
    
proc imageLoadInlinePng*(parent: ptr TClaroObj, data: Cstring, 
                            len: Cint): ptr TImage{.cdecl, 
    importc: "image_load_inline_png", dynlib: clarodll.}
  ## Loads an image from inline data and returns a new image object.
  ## `Parent` object (usually the application's main window), can be nil.
  ##  data raw PNG image
  ##  len size of data

when true:
  nil
else:
  # status icons are not supported on all platforms yet:
  type 
    TStatusIcon* {.pure.} = object of TClaroObj
      icon*: ptr TImage
      native*: pointer
      native2*: pointer

  #*
  #  \brief Creates a status icon
  # 
  #  \param parent Parent object (usually the application's main window),
  #                can be NULL.
  #  \param image The image object for the icon NOT NULL
  #  \param flags Flags
  #  \return New status_icon_t object
  # 

  proc status_icon_create*(parent: ptr TClaroObj, icon: ptr TImage, 
                           flags: cint): ptr TStatusIcon {.
      cdecl, importc: "status_icon_create", dynlib: clarodll.}

  #*
  #  \brief sets the status icon's image 
  # 
  #  \param status Status Icon
  #  \param image The image object for the icon
  # 

  proc status_icon_set_icon*(status: ptr TStatusIcon, icon: ptr TImage){.cdecl, 
      importc: "status_icon_set_icon", dynlib: clarodll.}

  #*
  #  \brief sets the status icons's menu
  # 
  #  \param status Status Icon
  #  \param menu The menu object for the popup menu
  # 

  proc status_icon_set_menu*(status: ptr TStatusIcon, menu: ptr TClaroObj){.cdecl, 
      importc: "status_icon_set_menu", dynlib: clarodll.}
  #*
  #  \brief sets the status icon's visibility
  # 
  #  \param status Status Icon
  #  \param visible whether the status icon is visible or not
  # 

  proc status_icon_set_visible*(status: ptr TStatusIcon, visible: cint){.cdecl, 
      importc: "status_icon_set_visible", dynlib: clarodll.}
  #*
  #  \brief sets the status icon's tooltip
  # 
  #  \param status Status Icon
  #  \param tooltip Tooltip string
  # 

  proc status_icon_set_tooltip*(status: ptr TStatusIcon, tooltip: cstring){.cdecl, 
      importc: "status_icon_set_tooltip", dynlib: clarodll.}
    
#*
#  \brief Makes the specified widget visible.
# 
#  \param widget A widget
# 

proc widgetShow*(widget: ptr TWidget){.cdecl, importc: "widget_show", 
    dynlib: clarodll.}
#*
#  \brief Makes the specified widget invisible.
# 
#  \param widget A widget
# 

proc widgetHide*(widget: ptr TWidget){.cdecl, importc: "widget_hide", 
    dynlib: clarodll.}
#*
#  \brief Enables the widget, allowing focus
# 
#  \param widget A widget
# 

proc widgetEnable*(widget: ptr TWidget){.cdecl, importc: "widget_enable", 
    dynlib: clarodll.}
#*
#  \brief Disables the widget
#  When disabled, a widget appears greyed and cannot
#  receive focus.
# 
#  \param widget A widget
# 

proc widgetDisable*(widget: ptr TWidget){.cdecl, importc: "widget_disable", 
    dynlib: clarodll.}
#*
#  \brief Give focus to the specified widget
# 
#  \param widget A widget
# 

proc widgetFocus*(widget: ptr TWidget){.cdecl, importc: "widget_focus", 
    dynlib: clarodll.}
#*
#  \brief Closes a widget
# 
#  Requests that a widget be closed by the platform code. 
#  This may or may not result in immediate destruction of the widget,
#  however the actual Claro widget object will remain valid until at
#  least the next loop iteration.
# 
#  \param widget A widget
# 

proc widgetClose*(widget: ptr TWidget){.cdecl, importc: "widget_close", 
    dynlib: clarodll.}
#*
#  \brief Retrieve the screen offset of the specified widget.
# 
#  Retrieves the X and Y screen positions of the widget.
# 
#  \param widget A widget
#  \param dx Pointer to the location to place the X position.
#  \param dy Pointer to the location to place the Y position.
# 

proc widgetScreenOffset*(widget: ptr TWidget, dx: ptr Cint, dy: ptr Cint){.
    cdecl, importc: "widget_screen_offset", dynlib: clarodll.}
#*
#  \brief Sets the additional notify events that should be sent.
# 
#  For performance reasons, some events, like mouse and key events,
#  are not sent by default. By specifying such events here, you can
#  elect to receive these events.
# 
#  \param widget A widget
#  \param flags Any number of cWidgetNotify flags ORed together.
# 

proc widgetSetNotify*(widget: ptr TWidget, flags: Cint){.cdecl, 
    importc: "widget_set_notify", dynlib: clarodll.}


type
  TCursorType* {.size: sizeof(cint).} = enum
    cCursorNormal = 0,
    cCursorTextEdit = 1,
    cCursorWait = 2,
    cCursorPoint = 3

#*
#  \brief Sets the mouse cursor for the widget
# 
#  \param widget A widget
#  \param cursor A valid cCursor* value
# 

proc widgetSetCursor*(widget: ptr TWidget, cursor: TCursorType){.cdecl, 
    importc: "widget_set_cursor", dynlib: clarodll.}

#*
#  \brief Retrieves the key pressed in a key notify event.
# 
#  \param widget A widget
#  \param event An event resource
#  \return The keycode of the key pressed.
# 

proc widgetGetNotifyKey*(widget: ptr TWidget, event: ptr TEvent): Cint{.
    cdecl, importc: "widget_get_notify_key", dynlib: clarodll.}

#*
#  \brief Updates the bounds structure with new values
# 
#  This function should \b always be used instead of setting the
#  members manually. In the future, there may be a \b real reason
#  for this.
# 
#  \param bounds A bounds structure
#  \param x The new X position
#  \param y The new Y position
#  \param w The new width
#  \param h The new height
# 

proc boundsSet*(bounds: ptr TBounds, x: Cint, y: Cint, w: Cint, h: Cint){.
    cdecl, importc: "bounds_set", dynlib: clarodll.}
#*
#  \brief Create a new bounds object
# 
#  Creates a new bounds_t for the specified bounds.
# 
#  \param x X position
#  \param y Y position
#  \param w Width
#  \param h Height
#  \return A new bounds_t structure
# 

proc newBounds*(x: Cint, y: Cint, w: Cint, h: Cint): ptr TBounds{.cdecl, 
    importc: "new_bounds", dynlib: clarodll.}
proc getReqBounds*(widget: ptr TWidget): ptr TBounds{.cdecl, 
    importc: "get_req_bounds", dynlib: clarodll.}
    
var
  noBoundsVar: TBounds # set to all zero which is correct
    
template noBounds*: Expr = (addr(bind noBoundsVar))

#* \internal
#  \brief Internal pre-inititalisation hook
# 
#  \param widget A widget
# 

proc widgetPreInit*(widget: ptr TWidget){.cdecl, importc: "widget_pre_init", 
    dynlib: clarodll.}
#* \internal
#  \brief Internal post-inititalisation hook
# 
#  \param widget A widget
# 

proc widgetPostInit*(widget: ptr TWidget){.cdecl, 
    importc: "widget_post_init", dynlib: clarodll.}
#* \internal
#  \brief Internal resize event handler
# 
#  \param obj An object
#  \param event An event resource
# 

proc widgetResizedHandle*(obj: ptr TWidget, event: ptr TEvent){.cdecl, 
    importc: "widget_resized_handle", dynlib: clarodll.}
# CLVEXP bounds_t no_bounds;
#* \internal
#  \brief Internal default widget creation function
# 
#  \param parent The parent of the widget
#  \param widget_size The size in bytes of the widget's structure
#  \param widget_name The object type of the widget (claro.graphics.widgets.*)
#  \param size_req The initial bounds of the widget
#  \param flags Widget flags
#  \param creator The platform function that will be called to actually create
#                 the widget natively.
#  \return A new widget object
# 

type
  TcgraphicsCreateFunction* = proc (widget: ptr TWidget) {.cdecl.}

proc newdefault*(parent: ptr TWidget, widget_size: Int, 
                 widget_name: Cstring, size_req: ptr TBounds, flags: Cint, 
                 creator: TcgraphicsCreateFunction): ptr TWidget{.cdecl, 
    importc: "default_widget_create", dynlib: clarodll.}
#* \internal
#  \brief Retrieves the native container of the widget's children
# 
#  \param widget A widget
#  \return A pointer to the native widget that will hold w's children
# 

proc widgetGetContainer*(widget: ptr TWidget): Pointer{.cdecl, 
    importc: "widget_get_container", dynlib: clarodll.}
#* \internal
#  \brief Sets the content size of the widget.
# 
#  \param widget A widget
#  \param w New width of the content area of the widget
#  \param h New height of the content area of the widget
#  \param event Whether to send a content_size event
# 

proc widgetSetContentSize*(widget: ptr TWidget, w: Cint, h: Cint, 
                              event: Cint){.cdecl, 
    importc: "widget_set_content_size", dynlib: clarodll.}
#* \internal
#  \brief Sets the size of the widget.
# 
#  \param widget A widget
#  \param w New width of the widget
#  \param h New height of the widget
#  \param event Whether to send a resize event
# 

proc widgetSetSize*(widget: ptr TWidget, w: Cint, h: Cint, event: Cint){.
    cdecl, importc: "widget_set_size", dynlib: clarodll.}
#* \internal
#  \brief Sets the position of the widget's content area.
# 
#  \param widget A widget
#  \param x New X position of the widget's content area
#  \param y New Y position of the widget's content area
#  \param event Whether to send a content_move event
# 

proc widgetSetContentPosition*(widget: ptr TWidget, x: Cint, y: Cint, 
                                  event: Cint){.cdecl, 
    importc: "widget_set_content_position", dynlib: clarodll.}
#* \internal
#  \brief Sets the position of the widget.
# 
#  \param widget A widget
#  \param x New X position of the widget's content area
#  \param y New Y position of the widget's content area
#  \param event Whether to send a moved event
# 

proc widgetSetPosition*(widget: ptr TWidget, x: Cint, y: Cint, event: Cint){.
    cdecl, importc: "widget_set_position", dynlib: clarodll.}
#* \internal
#  \brief Sends a destroy event to the specified widget.
# 
#  You should use widget_close() in application code instead.
# 
#  \param widget A widget
# 

proc widgetDestroy*(widget: ptr TWidget){.cdecl, importc: "widget_destroy", 
    dynlib: clarodll.}

type 
  TOpenglWidget* {.pure.} = object of TWidget
    gldata*: Pointer


# functions 
#*
#  \brief Creates a OpenGL widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new OpenGL widget object.
# 

proc newopengl*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                flags: Cint): ptr TOpenglWidget {.
    cdecl, importc: "opengl_widget_create", dynlib: clarodll.}
#*
#  \brief Flips the front and back buffers
#  
#  \param widget A valid OpenGL widget object
# 

proc openglFlip*(widget: ptr TOpenglWidget) {.cdecl, importc: "opengl_flip", 
    dynlib: clarodll.}
#*
#  \brief Activates this OpenGL widget's context
#  
#  \param widget A valid OpenGL widget object
# 

proc openglActivate*(widget: ptr TOpenglWidget) {.
    cdecl, importc: "opengl_activate", dynlib: clarodll.}

type 
  TButton* {.pure.} = object of TWidget
    text*: Array[0..256-1, Char]


# functions 
#*
#  \brief Creates a Button widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Button widget object.
# 

proc newbutton*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                flags: Cint): ptr TButton {.
    cdecl, importc: "button_widget_create", dynlib: clarodll.}
#*
#  \brief Creates a Button widget with a label
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \param label The label for the button
#  \return A new Button widget object.
# 

proc newbutton*(parent: ptr TClaroObj, 
                bounds: ptr TBounds, flags: Cint, 
                label: Cstring): ptr TButton{.cdecl, 
    importc: "button_widget_create_with_label", dynlib: clarodll.}
#*
#  \brief Changes the label of the button
#  
#  \param obj A valid Button widget object
#  \param label The new label for the button
# 

proc buttonSetText*(obj: ptr TButton, label: Cstring){.cdecl, 
    importc: "button_set_label", dynlib: clarodll.}

#*
#  \brief Changes the image of the button
# 
#  \warning This function is not implemented yet and is not portable.
#           Do not use it.
#  
#  \param obj A valid Button widget object
#  \param image The new image for the button
# 

proc buttonSetImage*(obj: ptr TButton, image: ptr TImage){.cdecl, 
    importc: "button_set_image", dynlib: clarodll.}

const 
  CtextSlantNormal* = cFontSlantNormal
  CtextSlantItalic* = cFontSlantItalic
  CtextWeightNormal* = cFontWeightNormal
  CtextWeightBold* = cFontWeightBold
  CtextExtraNone* = cFontDecorationNormal
  CtextExtraUnderline* = cFontDecorationUnderline

# END OLD 

type 
  TCanvas*{.pure.} = object of TWidget
    surface*: cairo.PSurface
    cr*: Cairo.PContext
    surfdata*: Pointer
    fontdata*: Pointer
    font_height*: Cint
    fr*: Cfloat
    fg*: Cfloat
    fb*: Cfloat
    fa*: Cfloat
    br*: Cfloat
    bg*: Cfloat
    bb*: Cfloat
    ba*: Cfloat
    charsize*: Array[0..256 - 1, cairo.TTextExtents]
    csz_loaded*: Cint
    fontsize*: Cint

# functions 
#*
#  \brief Creates a Canvas widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Canvas widget object.
# 

proc newcanvas*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                flags: Cint): ptr TCanvas{.
    cdecl, importc: "canvas_widget_create", dynlib: clarodll.}
#*
#  \brief Invalidates and redraws a canvas widget
#  
#  \param widget A valid Canvas widget object.
# 

proc canvasRedraw*(widget: ptr TCanvas){.cdecl, importc: "canvas_redraw", 
    dynlib: clarodll.}
# claro text functions 
#*
#  \brief Set the current text color
#  
#  \param widget A valid Canvas widget object.
#  \param r Red component (0.0 - 1.0)
#  \param g Green component (0.0 - 1.0)
#  \param b Blue component (0.0 - 1.0)
#  \param a Alpha component (0.0 - 1.0)
# 

proc canvasSetTextColor*(widget: ptr TCanvas, r: Cdouble, g: Cdouble, 
                            b: Cdouble, a: Cdouble){.cdecl, 
    importc: "canvas_set_text_color", dynlib: clarodll.}
#*
#  \brief Set the current text background color
#  
#  \param widget A valid Canvas widget object.
#  \param r Red component (0.0 - 1.0)
#  \param g Green component (0.0 - 1.0)
#  \param b Blue component (0.0 - 1.0)
#  \param a Alpha component (0.0 - 1.0)
# 

proc canvasSetTextBgcolor*(widget: ptr TCanvas, r: Cdouble, g: Cdouble, 
                              b: Cdouble, a: Cdouble){.cdecl, 
    importc: "canvas_set_text_bgcolor", dynlib: clarodll.}
#*
#  \brief Set the current canvas font
#  
#  \param widget A valid Canvas widget object.
#  \param face The font face
#  \param size The font height in pixels
#  \param weight The weight of the font
#  \param slant The slant of the font
#  \param decoration Font decorations
# 

proc canvasSetTextFont*(widget: ptr TCanvas, face: Cstring, size: Cint, 
                           weight: Cint, slant: Cint, decoration: Cint){.cdecl, 
    importc: "canvas_set_text_font", dynlib: clarodll.}
#*
#  \brief Calculates the width of the specified text
#  
#  \param widget A valid Canvas widget object.
#  \param text The text to calulate the length of
#  \param len The number of characters of text to calulcate
#  \return Width of the text in pixels
# 

proc canvasTextWidth*(widget: ptr TCanvas, text: Cstring, len: Cint): Cint{.
    cdecl, importc: "canvas_text_width", dynlib: clarodll.}
#*
#  \brief Calculates the width of the specified text's bounding box
#  
#  \param widget A valid Canvas widget object.
#  \param text The text to calulate the length of
#  \param len The number of characters of text to calulcate
#  \return Width of the text's bounding box in pixels
# 

proc canvasTextBoxWidth*(widget: ptr TCanvas, text: Cstring, 
                            len: Cint): Cint{.
    cdecl, importc: "canvas_text_box_width", dynlib: clarodll.}
#*
#  \brief Calculates the number of characters of text that can be displayed
#         before width pixels.
#  
#  \param widget A valid Canvas widget object.
#  \param text The text to calulate the length of
#  \param width The width to fit the text in
#  \return The number of characters of text that will fit in width pixels.
# 

proc canvasTextDisplayCount*(widget: ptr TCanvas, text: Cstring, 
                                width: Cint): Cint{.cdecl, 
    importc: "canvas_text_display_count", dynlib: clarodll.}
#*
#  \brief Displays the specified text on the canvas
#  
#  \param widget A valid Canvas widget object.
#  \param x The X position at which the text will be drawn
#  \param y The Y position at which the text will be drawn
#  \param text The text to calulate the length of
#  \param len The number of characters of text to calulcate
# 

proc canvasShowText*(widget: ptr TCanvas, x: Cint, y: Cint, text: Cstring, 
                       len: Cint){.cdecl, importc: "canvas_show_text", 
                                   dynlib: clarodll.}
#*
#  \brief Draws a filled rectangle
#  
#  \param widget A valid Canvas widget object.
#  \param x The X position at which the rectangle will start
#  \param y The Y position at which the rectangle will start
#  \param w The width of the rectangle
#  \param h The height of the rectangle
#  \param r Red component (0.0 - 1.0)
#  \param g Green component (0.0 - 1.0)
#  \param b Blue component (0.0 - 1.0)
#  \param a Alpha component (0.0 - 1.0)
# 

proc canvasFillRect*(widget: ptr TCanvas, x: Cint, y: Cint, w: Cint, 
                       h: Cint, r, g, b, a: Cdouble){.
    cdecl, importc: "canvas_fill_rect", dynlib: clarodll.}
#*
#  \brief Draws the specified image on the canvas
#  
#  \param widget A valid Canvas widget object.
#  \param image The image to draw
#  \param x The X position at which the image will be drawn
#  \param y The Y position at which the image will be drawn
# 

proc canvasDrawImage*(widget: ptr TCanvas, image: ptr TImage, x: Cint, 
                        y: Cint){.cdecl, importc: "canvas_draw_image", 
                                  dynlib: clarodll.}
# claro "extensions" of cairo 
#* \internal
#  \brief Internal claro extension of cairo text functions
# 

proc canvasCairoBufferedTextWidth*(widget: ptr TCanvas, 
                                       text: Cstring, len: Cint): Cint{.cdecl, 
    importc: "canvas_cairo_buffered_text_width", dynlib: clarodll.}
#* \internal
#  \brief Internal claro extension of cairo text functions
# 

proc canvasCairoBufferedTextDisplayCount*(widget: ptr TCanvas, 
    text: Cstring, width: Cint): Cint{.cdecl, 
    importc: "canvas_cairo_buffered_text_display_count", 
    dynlib: clarodll.}
proc canvasGetCairoContext*(widget: ptr TCanvas): Cairo.PContext {.cdecl, 
    importc: "canvas_get_cairo_context", dynlib: clarodll.}

type 
  TCheckBox*{.pure.} = object of TWidget
    text*: Array[0..256-1, Char]
    checked*: Cint

#*
#  \brief Creates a Checkbox widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Checkbox widget object.
# 

proc newcheckbox*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                  flags: Cint): ptr TCheckBox{.
    cdecl, importc: "checkbox_widget_create", dynlib: clarodll.}
#*
#  \brief Creates a Checkbox widget with a label
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \param label The label for the checkbox
#  \return A new Checkbox widget object.
# 

proc newcheckbox*(parent: ptr TClaroObj, 
                  bounds: ptr TBounds, flags: Cint, 
                  label: Cstring): ptr TCheckBox {.cdecl, 
    importc: "checkbox_widget_create_with_label", dynlib: clarodll.}
#*
#  \brief Sets a new label for the Checkbox widget
#  
#  \param obj A valid Checkbox widget object.
#  \param label The new label for the checkbox
# 

proc checkboxSetText*(obj: ptr TCheckBox, label: Cstring){.cdecl, 
    importc: "checkbox_set_label", dynlib: clarodll.}
#*
#  \brief Retrieves the checkbox's check state
#  
#  \param obj A valid Checkbox widget object.
#  \return 1 if the checkbox is checked, otherwise 0
# 

proc checkboxChecked*(obj: ptr TCheckBox): Cint{.cdecl, 
    importc: "checkbox_get_checked", dynlib: clarodll.}
#*
#  \brief Sets the checkbox's checked state
#  
#  \param obj A valid Checkbox widget object.
#  \param checked 1 if the checkbox should become checked, otherwise 0
# 

proc checkboxSetChecked*(obj: ptr TCheckBox, checked: Cint){.cdecl, 
    importc: "checkbox_set_checked", dynlib: clarodll.}


#*
#  List items define items in a list_widget
# 

type 
  TListItem*{.pure.} = object of TClaroObj
    row*: Cint
    native*: Pointer
    nativeid*: Int
    menu*: ptr TClaroObj
    enabled*: Cint
    data*: ptr Pointer
    ListItemChildren*: TList
    ListItemParent*: ptr TList
    parent_item*: ptr TListItem # drawing related info, not always required
    text_color*: TColor
    sel_text_color*: TColor
    back_color*: TColor
    sel_back_color*: TColor
    font*: TFont

  TListWidget* {.pure.} = object of TWidget ## List widget, base for 
                                            ## widgets containing items
    columns*: Cint
    coltypes*: ptr Cint
    items*: TList

  TCombo*{.pure.} = object of TListWidget
    selected*: ptr TListItem


# functions 
#*
#  \brief Creates a Combo widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Combo widget object.
# 

proc newcombo*(parent: ptr TClaroObj, bounds: ptr TBounds, 
               flags: Cint): ptr TCombo{.
    cdecl, importc: "combo_widget_create", dynlib: clarodll.}
#*
#  \brief Append a row to a Combo widget
#  
#  \param combo A valid Combo widget object.
#  \param text The text for the item.
#  \return A new list item.
# 

proc comboAppendRow*(combo: ptr TCombo, text: Cstring): ptr TListItem {.
    cdecl, importc: "combo_append_row", dynlib: clarodll.}
#*
#  \brief Insert a row at the specified position into a Combo widget
#  
#  \param combo A valid Combo widget object.
#  \param pos The index at which this item will be placed.
#  \param text The text for the item.
#  \return A new list item.
# 

proc comboInsertRow*(combo: ptr TCombo, pos: Cint, 
                       text: Cstring): ptr TListItem {.
    cdecl, importc: "combo_insert_row", dynlib: clarodll.}
#*
#  \brief Move a row in a Combo widget
#  
#  \param combo A valid Combo widget object.
#  \param item A valid list item
#  \param row New position to place this item
# 

proc comboMoveRow*(combo: ptr TCombo, item: ptr TListItem, row: Cint){.
    cdecl, importc: "combo_move_row", dynlib: clarodll.}
#*
#  \brief Remove a row from a Combo widget
#  
#  \param combo A valid Combo widget object.
#  \param item A valid list item
# 

proc comboRemoveRow*(combo: ptr TCombo, item: ptr TListItem){.cdecl, 
    importc: "combo_remove_row", dynlib: clarodll.}
#*
#  \brief Returns the currently selected Combo item
#  
#  \param obj A valid Combo widget object.
#  \return The currently selected Combo item, or NULL if no item is selected.
# 

proc comboGetSelected*(obj: ptr TCombo): ptr TListItem{.cdecl, 
    importc: "combo_get_selected", dynlib: clarodll.}
#*
#  \brief Returns the number of rows in a Combo widget
#  
#  \param obj A valid Combo widget object.
#  \return Number of rows
# 

proc comboGetRows*(obj: ptr TCombo): Cint{.cdecl, 
    importc: "combo_get_rows", dynlib: clarodll.}
#*
#  \brief Selects a row in a Combo widget
#  
#  \param obj A valid Combo widget object.
#  \param item A valid list item
# 

proc comboSelectItem*(obj: ptr TCombo, item: ptr TListItem){.cdecl, 
    importc: "combo_select_item", dynlib: clarodll.}
#*
#  \brief Removes all entries from a Combo widget
#  
#  \param obj A valid Combo widget object.
# 

proc comboClear*(obj: ptr TCombo){.cdecl, importc: "combo_clear", 
                                    dynlib: clarodll.}

type 
  TContainerWidget* {.pure.} = object of TWidget


# functions 
#*
#  \brief Creates a Container widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Container widget object.
# 

proc newcontainer*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                   flags: Cint): ptr TContainerWidget{.
    cdecl, importc: "container_widget_create", dynlib: clarodll.}

proc newdialog*(parent: ptr TClaroObj, bounds: ptr TBounds, format: Cstring, 
                flags: Cint): ptr TClaroObj{.cdecl, 
    importc: "dialog_widget_create", dynlib: clarodll.}
proc dialogSetText*(obj: ptr TClaroObj, text: Cstring){.cdecl, 
    importc: "dialog_set_text", dynlib: clarodll.}
proc dialogSetDefaultIcon*(typ: Cstring, file: Cstring){.cdecl, 
    importc: "dialog_set_default_icon", dynlib: clarodll.}
proc dialogGetDefaultIcon*(dialog_type: Cint): Cstring{.cdecl, 
    importc: "dialog_get_default_icon", dynlib: clarodll.}
proc dialogWarning*(format: Cstring, text: Cstring): Cint{.cdecl, 
    importc: "dialog_warning", dynlib: clarodll.}
proc dialogInfo*(format: Cstring, text: Cstring): Cint{.cdecl, 
    importc: "dialog_info", dynlib: clarodll.}
proc dialogError*(format: Cstring, text: Cstring): Cint{.cdecl, 
    importc: "dialog_error", dynlib: clarodll.}
proc dialogOther*(format: Cstring, text: Cstring, default_icon: Cstring): Cint{.
    cdecl, importc: "dialog_other", dynlib: clarodll.}

type 
  TFontDialog* {.pure.} = object of TWidget
    selected*: TFont

# functions 
#*
#  \brief Creates a Font Selection widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param flags Widget flags.
#  \return A new Font Selection widget object.
# 

proc newFontDialog*(parent: ptr TClaroObj, flags: Cint): ptr TFontDialog {.
    cdecl, importc: "font_dialog_widget_create", dynlib: clarodll.}
#*
#  \brief Changes the selected font
#  
#  \param obj A valid Font Selection widget object
#  \param font The name of the font
# 

proc fontDialogSetFont*(obj: ptr TFontDialog, face: Cstring, size: Cint, 
                           weight: Cint, slant: Cint, decoration: Cint){.cdecl, 
    importc: "font_dialog_set_font", dynlib: clarodll.}
#*
#  \brief Returns a structure representing the currently selected font
#  
#  \param obj A valid Font Selection widget object
#  \return A font_t structure containing information about the selected font.
# 

proc fontDialogGetFont*(obj: ptr TFontDialog): ptr TFont{.cdecl, 
    importc: "font_dialog_get_font", dynlib: clarodll.}

type 
  TFrame* {.pure.} = object of TWidget
    text*: Array[0..256-1, Char]


#*
#  \brief Creates a Frame widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Frame widget object.
# 

proc newframe*(parent: ptr TClaroObj, bounds: ptr TBounds, 
               flags: Cint): ptr TFrame{.
    cdecl, importc: "frame_widget_create", dynlib: clarodll.}
#*
#  \brief Creates a Frame widget with a label
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \param label The initial label for the frame
#  \return A new Frame widget object.
# 

proc newframe*(parent: ptr TClaroObj, bounds: ptr TBounds, flags: Cint, 
                                     label: Cstring): ptr TFrame {.cdecl, 
    importc: "frame_widget_create_with_label", dynlib: clarodll.}
#*
#  \brief Creates a Container widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Container widget object.
# 

proc frameSetText*(frame: ptr TFrame, label: Cstring){.cdecl, 
    importc: "frame_set_label", dynlib: clarodll.}

type 
  TImageWidget* {.pure.} = object of TWidget
    src*: ptr TImage


#*
#  \brief Creates an Image widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Image widget object.
# 

proc newimageWidget*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                     flags: Cint): ptr TImageWidget{.
    cdecl, importc: "image_widget_create", dynlib: clarodll.}
#*
#  \brief Creates an Image widget with an image
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \param image A valid Image object.
#  \return A new Image widget object.
# 

proc newimageWidget*(parent: ptr TClaroObj, 
                     bounds: ptr TBounds, flags: Cint, 
                     image: ptr TImage): ptr TImageWidget{.cdecl, 
    importc: "image_widget_create_with_image", dynlib: clarodll.}
#*
#  \brief Sets the image object of the image widget
#  
#  \param image A valid image widget
#  \param src The source image object
# 

proc imageSetImage*(image: ptr TImageWidget, src: ptr TImage){.cdecl, 
    importc: "image_set_image", dynlib: clarodll.}
    
type 
  TLabel*{.pure.} = object of TWidget
    text*: Array[0..256-1, Char]

  TcLabelJustify* = enum 
    cLabelLeft = 0x00000001, cLabelRight = 0x00000002, 
    cLabelCenter = 0x00000004, cLabelFill = 0x00000008

#*
#  \brief Creates a Label widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Label widget object.
# 

proc newlabel*(parent: ptr TClaroObj, bounds: ptr TBounds, 
               flags: Cint): ptr TLabel{.
    cdecl, importc: "label_widget_create", dynlib: clarodll.}
#*
#  \brief Creates a Label widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Label widget object.
# 

proc newLabel*(parent: ptr TClaroObj, 
               bounds: ptr TBounds, flags: Cint, 
               text: Cstring): ptr TLabel{.cdecl, 
    importc: "label_widget_create_with_text", dynlib: clarodll.}
#*
#  \brief Sets the text of a label widget
#  
#  \param obj A valid label widget
#  \param text The text this label widget will show
# 

proc labelSetText*(obj: ptr TLabel, text: Cstring){.cdecl, 
    importc: "label_set_text", dynlib: clarodll.}
    
#*
#  \brief Sets the alignment/justification of a label
#  
#  \param obj A valid label widget
#  \param text The justification (see cLabelJustify enum)
# 

proc labelSetJustify*(obj: ptr TLabel, flags: Cint){.cdecl, 
    importc: "label_set_justify", dynlib: clarodll.}
    
const 
  ClistTypePtr* = 0
  ClistTypeString* = 1
  ClistTypeInt* = 2
  ClistTypeUint* = 3
  ClistTypeDouble* = 4

# functions 
#*
#  \brief Initialises a list_widget_t derivative's storage space.
# 
#  \param obj list widget
#  \param col_num number of columns to be used
#  \param cols An array of col_num integers, specifying the 
#              types of the columns.
# 

proc listWidgetInitPtr*(obj: ptr TListWidget, col_num: Cint, 
                           cols: ptr Cint) {.cdecl, 
    importc: "list_widget_init_ptr", dynlib: clarodll.}
#*
#  \brief Copies and passes on the arg list to list_widget_init_ptr.
# 
#  \param obj list widget
#  \param col_num number of columns to be used
#  \param argpi A pointer to a va_list to parse
# 

#proc list_widget_init_vaptr*(obj: ptr TClaroObj, col_num: cunsignedint, 
#                             argpi: va_list){.cdecl, 
#    importc: "list_widget_init_vaptr", dynlib: clarodll.}

#*
#  Shortcut function, simply calls list_widget_init_ptr with
#  it's own arguments, and a pointer to the first variable argument.
# 

proc listWidgetInit*(obj: ptr TListWidget, col_num: Cint){.varargs, 
    cdecl, importc: "list_widget_init", dynlib: clarodll.}
#*
#  \brief Inserts a row to a list under parent at the position specified.
# 
#  \param list list to insert item in
#  \param parent item in tree to be used as parent. NULL specifies
#   that it should be a root node.
#  \param row item will be inserted before the item currently at
#   this position. -1 specifies an append.
#  \param argp points to the first element of an array containing
#  the column data as specified by the types in list_widget_init.
# 

#*
#  Shortcut function, calls list_widget_row_insert_ptr with
#  it's own arguments, a position at the end of the list, and
#  a pointer to the first variable argument.
# 

proc listWidgetRowAppend*(list: ptr TListWidget, 
                             parent: ptr TListItem): ptr TListItem{.
    varargs, cdecl, importc: "list_widget_row_append", dynlib: clarodll.}
#*
#  Shortcut function, calls list_widget_row_insert_ptr with
#  it's own arguments, and a pointer to the first variable argument.
# 

proc listWidgetRowInsert*(list: ptr TListWidget, parent: ptr TListItem, 
                             pos: Cint): ptr TListItem {.varargs, cdecl, 
    importc: "list_widget_row_insert", dynlib: clarodll.}
#*
#  \brief Removes a row from a list
# 
#  \param list List widget to operate on
#  \param item The item to remove
# 

proc listWidgetRowRemove*(list: ptr TListWidget, item: ptr TListItem){.
    cdecl, importc: "list_widget_row_remove", dynlib: clarodll.}
#*
#  \brief Moves a row to a new position in the list
# 
#  \param list List widget to operate on
#  \param item The item to move 
#  \param row Row position to place item before. Passing the current
#             position will result in no change.
# 

proc listWidgetRowMove*(list: ptr TListWidget, item: ptr TListItem, 
                           row: Cint){.cdecl, importc: "list_widget_row_move", 
                                       dynlib: clarodll.}
#*
#  \brief Return the nth row under parent in the list
# 
#  \param list List widget search
#  \param parent Parent of the item
#  \param row Row index of item to return
# 

proc listWidgetGetRow*(list: ptr TListWidget, parent: ptr TListItem, 
                          row: Cint): ptr TListItem{.cdecl, 
    importc: "list_widget_get_row", dynlib: clarodll.}
#*
#  \brief Edit items of a row in the list.
# 
#  \param list List widget to edit
#  \param item Row to modify
#  \param args num,val,...,-1 where num is the column and val is the new 
#              value of the column's type. Terminate with -1. 
#              Don't forget the -1.
# 

#*
#  \brief Edit items of a row in the list.
# 
#  \param list List-based (list_widget_t) object
#  \param item Row to modify
#  \param ... num,val,...,-1 where num is the column and val is the new 
#              value of the column's type. Terminate with -1. 
#              Don't forget the -1.
# 

proc listWidgetEditRow*(list: ptr TListWidget, item: ptr TListItem){.
    varargs, cdecl, importc: "list_widget_edit_row", dynlib: clarodll.}
#*
#  \brief Set the text color of an item.
#  This is currently only supported by the TreeView widget.
# 
#  \param item Target list item
#  \param r Red component between 0.0 and 1.0
#  \param g Green component between 0.0 and 1.0
#  \param b Blue component between 0.0 and 1.0
#  \param a Alpha component between 0.0 and 1.0 (reserved for future use,
#          should be 1.0)
# 

proc listItemSetTextColor*(item: ptr TListItem, r: Cfloat, g: Cfloat, 
                               b: Cfloat, a: Cfloat){.cdecl, 
    importc: "list_item_set_text_color", dynlib: clarodll.}
#*
#  \brief Set the text background color of an item.
#  This is currently only supported by the TreeView widget.
# 
#  \param item Target list item
#  \param r Red component between 0.0 and 1.0
#  \param g Green component between 0.0 and 1.0
#  \param b Blue component between 0.0 and 1.0
#  \param a Alpha component between 0.0 and 1.0 (reserved for future use,
#           should be 1.0)
# 

proc listItemSetTextBgcolor*(item: ptr TListItem, r: Cfloat, g: Cfloat, 
                                 b: Cfloat, a: Cfloat){.cdecl, 
    importc: "list_item_set_text_bgcolor", dynlib: clarodll.}
#*
#  \brief Set the text color of a selected item.
#  This is currently only supported by the TreeView widget.
# 
#  \param item Target list item
#  \param r Red component between 0.0 and 1.0
#  \param g Green component between 0.0 and 1.0
#  \param b Blue component between 0.0 and 1.0
#  \param a Alpha component between 0.0 and 1.0 (reserved for future use,
#         should be 1.0)
# 

proc listItemSetSelTextColor*(item: ptr TListItem, r: Cfloat, g: Cfloat, 
                                   b: Cfloat, a: Cfloat){.cdecl, 
    importc: "list_item_set_sel_text_color", dynlib: clarodll.}
#*
#  \brief Set the text background color of a selected item.
#  This is currently only supported by the TreeView widget.
# 
#  \param item Target list item
#  \param r Red component between 0.0 and 1.0
#  \param g Green component between 0.0 and 1.0
#  \param b Blue component between 0.0 and 1.0
#  \param a Alpha component between 0.0 and 1.0 (reserved for future use,
#          should be 1.0)
# 

proc listItemSetSelTextBgcolor*(item: ptr TListItem, r: Cfloat, 
                                     g: Cfloat, b: Cfloat, a: Cfloat){.cdecl, 
    importc: "list_item_set_sel_text_bgcolor", dynlib: clarodll.}
#*
#  \brief Set the font details of the specified item.
# 
#  \param item Target list item
#  \param weight The weight of the font
#  \param slant The slant of the font
#  \param decoration Font decorations
# 

proc listItemSetFontExtra*(item: ptr TListItem, weight: Cint, 
                               slant: Cint, decoration: Cint){.cdecl, 
    importc: "list_item_set_font_extra", dynlib: clarodll.}

type 
  TListbox* {.pure.} = object of TListWidget
    selected*: ptr TListItem

# functions 
#*
#  \brief Creates a ListBox widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new ListBox widget object.
# 

proc newlistbox*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                 flags: Cint): ptr TListbox{.
    cdecl, importc: "listbox_widget_create", dynlib: clarodll.}
#*
#  \brief Insert a row at the specified position into a ListBox widget
#  
#  \param listbox A valid ListBox widget object.
#  \param pos The index at which this item will be placed.
#  \param text The text for the item.
#  \return A new list item.
# 

proc listboxInsertRow*(listbox: ptr TListbox, pos: Cint, 
                         text: Cstring): ptr TListItem{.
    cdecl, importc: "listbox_insert_row", dynlib: clarodll.}
#*
#  \brief Append a row to a ListBox widget
#  
#  \param listbox A valid ListBox widget object.
#  \param text The text for the item.
#  \return A new list item.
# 

proc listboxAppendRow*(listbox: ptr TListbox, text: Cstring): ptr TListItem{.
    cdecl, importc: "listbox_append_row", dynlib: clarodll.}
#*
#  \brief Move a row in a ListBox widget
#  
#  \param listbox A valid ListBox widget object.
#  \param item A valid list item
#  \param row New position to place this item
# 

proc listboxMoveRow*(listbox: ptr TListbox, item: ptr TListItem, row: Cint){.
    cdecl, importc: "listbox_move_row", dynlib: clarodll.}
#*
#  \brief Remove a row from a ListBox widget
#  
#  \param listbox A valid ListBox widget object.
#  \param item A valid list item
# 

proc listboxRemoveRow*(listbox: ptr TListbox, item: ptr TListItem){.cdecl, 
    importc: "listbox_remove_row", dynlib: clarodll.}
#*
#  \brief Returns the currently selected ListBox item
#  
#  \param obj A valid ListBox widget object.
#  \return The currently selected ListBox item, or NULL if no item is selected.
# 

proc listboxGetSelected*(obj: ptr TListbox): ptr TListItem{.cdecl, 
    importc: "listbox_get_selected", dynlib: clarodll.}
#*
#  \brief Returns the number of rows in a ListBox widget
#  
#  \param obj A valid ListBox widget object.
#  \return Number of rows
# 

proc listboxGetRows*(obj: ptr TListbox): Cint{.cdecl, 
    importc: "listbox_get_rows", dynlib: clarodll.}
#*
#  \brief Selects a row in a ListBox widget
#  
#  \param obj A valid ListBox widget object.
#  \param item A valid list item
# 

proc listboxSelectItem*(obj: ptr TListbox, item: ptr TListItem){.cdecl, 
    importc: "listbox_select_item", dynlib: clarodll.}

const 
  cListViewTypeNone* = 0
  cListViewTypeText* = 1
  cListViewTypeCheckBox* = 2
  cListViewTypeProgress* = 3

# whole row checkboxes.. will we really need this? hmm.

const 
  cListViewRowCheckBoxes* = 1

type 
  TListview* {.pure.} = object of TListWidget
    titles*: CstringArray
    nativep*: Pointer
    selected*: ptr TListItem


# functions 
#*
#  \brief Creates a ListView widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \param columns The number of columns in the listview
#  \param ... specifies the titles and types of each column. 
#             ("Enable",cListViewTypeCheckBox,"Title",cListViewTypeText,...)
#  \return A new ListView widget object.
# 

proc newlistview*(parent: ptr TClaroObj, bounds: ptr TBounds, columns: Cint, 
                  flags: Cint): ptr TListview {.varargs, cdecl, 
    importc: "listview_widget_create", dynlib: clarodll.}
#*
#  \brief Append a row to a ListView widget
#  
#  \param listview A valid ListView widget object.
#  \param ... A list of values for each column
#  \return A new list item.
# 

proc listviewAppendRow*(listview: ptr TListview): ptr TListItem{.varargs, 
    cdecl, importc: "listview_append_row", dynlib: clarodll.}
#*
#  \brief Insert a row at the specified position into a ListView widget
#  
#  \param listview A valid ListView widget object.
#  \param pos The index at which this item will be placed.
#  \param ... A list of values for each column
#  \return A new list item.
# 

proc listviewInsertRow*(listview: ptr TListview, pos: Cint): ptr TListItem{.
    varargs, cdecl, importc: "listview_insert_row", dynlib: clarodll.}
#*
#  \brief Move a row in a ListView widget
#  
#  \param listview A valid ListView widget object.
#  \param item A valid list item
#  \param row New position to place this item
# 

proc listviewMoveRow*(listview: ptr TListview, item: ptr TListItem, 
                        row: Cint){.cdecl, importc: "listview_move_row", 
                                    dynlib: clarodll.}
#*
#  \brief Remove a row from a ListView widget
#  
#  \param listview A valid ListView widget object.
#  \param item A valid list item
# 

proc listviewRemoveRow*(listview: ptr TListview, item: ptr TListItem){.
    cdecl, importc: "listview_remove_row", dynlib: clarodll.}
#*
#  \brief Returns the currently selected ListView item
#  
#  \param obj A valid ListView widget object.
#  \return The currently selected ListView item, or NULL if no item is selected.
# 

proc listviewGetSelected*(obj: ptr TListview): ptr TListItem{.cdecl, 
    importc: "listview_get_selected", dynlib: clarodll.}
#*
#  \brief Returns the number of rows in a ListView widget
#  
#  \param obj A valid ListView widget object.
#  \return Number of rows
# 

proc listviewGetRows*(obj: ptr TListview): Cint{.cdecl, 
    importc: "listview_get_rows", dynlib: clarodll.}
#*
#  \brief Selects a row in a ListView widget
#  
#  \param obj A valid ListView widget object.
#  \param item A valid list item
# 

proc listviewSelectItem*(obj: ptr TListview, item: ptr TListItem){.cdecl, 
    importc: "listview_select_item", dynlib: clarodll.}

const 
  cMenuPopupAtCursor* = 1

type 
  TMenu* {.pure.} = object of TListWidget


#*
#  \brief Creates a Menu widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param flags Widget flags.
#  \return A new Menu widget object.
# 

proc newmenu*(parent: ptr TClaroObj, flags: Cint): ptr TMenu {.cdecl, 
    importc: "menu_widget_create", dynlib: clarodll.}
#*
#  \brief Append a row to a Menu widget
#  
#  \param menu A valid Menu widget object.
#  \param parent The item to place the new item under, or NULL for a root item.
#  \param image An image object, or NULL.
#  \param title A string title, or NULL.
#  \return A new list item.
# 

proc menuAppendItem*(menu: ptr TMenu, parent: ptr TListItem, 
                       image: ptr TImage, title: Cstring): ptr TListItem{.
    cdecl, importc: "menu_append_item", dynlib: clarodll.}
#*
#  \brief Insert a row into a Menu widget
#  
#  \param menu A valid Menu widget object.
#  \param parent The item to place the new item under, or NULL for a root item.
#  \param pos The position at which to insert this item
#  \param image An image object, or NULL.
#  \param title A string title, or NULL.
#  \return A new list item.
# 

proc menuInsertItem*(menu: ptr TMenu, parent: ptr TListItem, pos: Cint, 
                       image: ptr TImage, title: Cstring): ptr TListItem{.
    cdecl, importc: "menu_insert_item", dynlib: clarodll.}
#*
#  \brief Append a separator to a Menu widget
#  
#  \param menu A valid Menu widget object.
#  \param parent The item to place the new item under, or NULL for a root item.
#  \return A new list item.
# 

proc menuAppendSeparator*(menu: ptr TMenu, 
                            parent: ptr TListItem): ptr TListItem{.
    cdecl, importc: "menu_append_separator", dynlib: clarodll.}
#*
#  \brief Insert a separator into a Menu widget
#  
#  \param menu A valid Menu widget object.
#  \param parent The item to place the new item under, or NULL for a root item.
#  \param pos The position at which to insert this item
#  \return A new list item.
# 

proc menuInsertSeparator*(menu: ptr TMenu, parent: ptr TListItem, 
                            pos: Cint): ptr TListItem{.cdecl, 
    importc: "menu_insert_separator", dynlib: clarodll.}
#*
#  \brief Move a row in a Menu widget
#  
#  \param menu A valid Menu widget object.
#  \param item A valid list item
#  \param row New position to place this item
# 

proc menuMoveItem*(menu: ptr TMenu, item: ptr TListItem, row: Cint){.
    cdecl, importc: "menu_move_item", dynlib: clarodll.}
#*
#  \brief Remove a row from a Menu widget
#  
#  \param menu A valid Menu widget object.
#  \param item A valid list item
# 

proc menuRemoveItem*(menu: ptr TMenu, item: ptr TListItem){.cdecl, 
    importc: "menu_remove_item", dynlib: clarodll.}
#*
#  \brief Returns the number of rows in a Menu widget
#  
#  \param obj A valid Menu widget object.
#  \param parent Item whose children count to return, 
#  or NULL for root item count.
#  \return Number of rows
# 

proc menuItemCount*(obj: ptr TMenu, parent: ptr TListItem): Cint{.
    cdecl, importc: "menu_item_count", dynlib: clarodll.}
#*
#  \brief Disables a menu item (no focus and greyed out)
#  
#  \param menu A valid Menu widget object.
#  \param item A valid list item
# 

proc menuDisableItem*(menu: ptr TMenu, item: ptr TListItem){.cdecl, 
    importc: "menu_disable_item", dynlib: clarodll.}
#*
#  \brief Enables a menu item (allows focus and not greyed out)
#  
#  \param menu A valid Menu widget object.
#  \param item A valid list item
# 

proc menuEnableItem*(menu: ptr TMenu, item: ptr TListItem){.cdecl, 
    importc: "menu_enable_item", dynlib: clarodll.}
#*
#  \brief Pops up the menu at the position specified
#  
#  \param menu A valid Menu widget object.
#  \param x The X position
#  \param y The Y position
#  \param flags Flags
# 

proc menuPopup*(menu: ptr TMenu, x: Cint, y: Cint, flags: Cint){.cdecl, 
    importc: "menu_popup", dynlib: clarodll.}
#
#   Menu modifiers
# 

const 
  cModifierShift* = 1 shl 0
  cModifierCommand* = 1 shl 1

type 
  TMenubar* {.pure.} = object of TListWidget

#*
#  \brief Creates a MenuBar widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param flags Widget flags.
#  \return A new MenuBar widget object.
# 

proc newmenubar*(parent: ptr TClaroObj, flags: Cint): ptr TMenubar {.cdecl, 
    importc: "menubar_widget_create", dynlib: clarodll.}
#*
#  \brief Add a key binding to a menu items
#  
#  \param menubar A valid MenuBar widget object.
#  \param item The item
#  \param utf8_key The key to use, NOT NULL.
#  \param modifier The modifier key, or 0.
# 

proc menubarAddKeyBinding*(menubar: ptr TMenubar, item: ptr TListItem, 
                              utf8_key: Cstring, modifier: Cint){.cdecl, 
    importc: "menubar_add_key_binding", dynlib: clarodll.}
#*
#  \brief Append a row to a MenuBar widget
#  
#  \param menubar A valid MenuBar widget object.
#  \param parent The item to place the new item under, or NULL for a root item.
#  \param image An image object, or NULL.
#  \param title A string title, or NULL.
#  \return A new list item.
# 

proc menubarAppendItem*(menubar: ptr TMenubar, parent: ptr TListItem, 
                          image: ptr TImage, title: Cstring): ptr TListItem{.
    cdecl, importc: "menubar_append_item", dynlib: clarodll.}
#*
#  \brief Insert a row into a MenuBar widget
#  
#  \param menubar A valid MenuBar widget object.
#  \param parent The item to place the new item under, or NULL for a root item.
#  \param pos The position at which to insert this item
#  \param image An image object, or NULL.
#  \param title A string title, or NULL.
#  \return A new list item.
# 

proc menubarInsertItem*(menubar: ptr TMenubar, parent: ptr TListItem, 
                          pos: Cint, image: ptr TImage, 
                          title: Cstring): ptr TListItem{.
    cdecl, importc: "menubar_insert_item", dynlib: clarodll.}
#*
#  \brief Append a separator to a MenuBar widget
#  
#  \param menubar A valid MenuBar widget object.
#  \param parent The item to place the new item under, or NULL for a root item.
#  \return A new list item.
# 

proc menubarAppendSeparator*(menubar: ptr TMenubar, 
                               parent: ptr TListItem): ptr TListItem{.
    cdecl, importc: "menubar_append_separator", dynlib: clarodll.}
#*
#  \brief Insert a separator into a MenuBar widget
#  
#  \param menubar A valid MenuBar widget object.
#  \param parent The item to place the new item under, or NULL for a root item.
#  \param pos The position at which to insert this item
#  \return A new list item.
# 

proc menubarInsertSeparator*(menubar: ptr TMenubar, parent: ptr TListItem, 
                               pos: Cint): ptr TListItem{.cdecl, 
    importc: "menubar_insert_separator", dynlib: clarodll.}
#*
#  \brief Move a row in a MenuBar widget
#  
#  \param menubar A valid MenuBar widget object.
#  \param item A valid list item
#  \param row New position to place this item
# 

proc menubarMoveItem*(menubar: ptr TMenubar, item: ptr TListItem, 
                        row: Cint){.cdecl, importc: "menubar_move_item", 
                                    dynlib: clarodll.}
#*
#  \brief Remove a row from a MenuBar widget
#  
#  \param menubar A valid MenuBar widget object.
#  \param item A valid list item
# 

proc menubarRemoveItem*(menubar: ptr TMenubar, item: ptr TListItem) {.
    cdecl, importc: "menubar_remove_item", dynlib: clarodll.}
#*
#  \brief Returns the number of rows in a MenuBar widget
#  
#  \param obj A valid MenuBar widget object.
#  \param parent Item whose children count to return, or NULL for root
#         item count.
#  \return Number of rows
# 

proc menubarItemCount*(obj: ptr TMenubar, parent: ptr TListItem): Cint{.
    cdecl, importc: "menubar_item_count", dynlib: clarodll.}
#*
#  \brief Disables a menu item (no focus and greyed out)
#  
#  \param menubar A valid MenuBar widget object.
#  \param item A valid list item
# 

proc menubarDisableItem*(menubar: ptr TMenubar, item: ptr TListItem){.
    cdecl, importc: "menubar_disable_item", dynlib: clarodll.}
#*
#  \brief Enables a menu item (allows focus and not greyed out)
#  
#  \param menubar A valid MenuBar widget object.
#  \param item A valid list item
# 

proc menubarEnableItem*(menubar: ptr TMenubar, item: ptr TListItem){.
    cdecl, importc: "menubar_enable_item", dynlib: clarodll.}

type 
  TProgress* {.pure.} = object of TWidget

  TcProgressStyle* = enum 
    cProgressLeftRight = 0x00000000, cProgressRightLeft = 0x00000001, 
    cProgressTopBottom = 0x00000002, cProgressBottomTop = 0x00000004

#*
#  \brief Creates a Progress widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Progress widget object.
# 

proc newprogress*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                  flags: Cint): ptr TProgress {.
    cdecl, importc: "progress_widget_create", dynlib: clarodll.}
#*
#  \brief Sets the value of a progress widget
#  
#  \param progress A valid progress widget object
#  \param percentage Progress value
# 

proc progressSetLevel*(progress: ptr TProgress, percentage: Cdouble){.cdecl, 
    importc: "progress_set_level", dynlib: clarodll.}
#*
#  \brief Sets the orientation of a progress widget
#  
#  \param progress A valid progress widget object
#  \param flags One of the cProgressStyle values
# 

proc progressSetOrientation*(progress: ptr TProgress, flags: Cint){.cdecl, 
    importc: "progress_set_orientation", dynlib: clarodll.}

type 
  TRadioGroup* {.pure.} = object of TClaroObj
    buttons*: TList
    selected*: ptr TClaroObj
    ndata*: Pointer

  TRadioButton* {.pure.} = object of TWidget
    text*: Array[0..256-1, Char]
    group*: ptr TRadioGroup


#*
#  \brief Creates a Radio Group widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param flags Widget flags.
#  \return A new Radio Group widget object.
# 

proc newRadiogroup*(parent: ptr TClaroObj, flags: Cint): ptr TRadioGroup {.
    cdecl, importc: "radiogroup_create", dynlib: clarodll.}
#*
#  \brief Creates a Radio Button widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param group A valid Radio Group widget object
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param label The label of the radio widget
#  \param flags Widget flags.
#  \return A new Radio Button widget object.
# 

proc newradiobutton*(parent: ptr TClaroObj, group: ptr TRadioGroup, 
                     bounds: ptr TBounds, label: Cstring, 
                     flags: Cint): ptr TRadioButton{.
    cdecl, importc: "radiobutton_widget_create", dynlib: clarodll.}
#*
#  \brief Set the label of a Radio Button
#  
#  \param obj A valid Radio Button widget
#  \param label The new label for the Radio Button
# 

proc radiobuttonSetText*(obj: ptr TRadioButton, label: Cstring){.cdecl, 
    importc: "radiobutton_set_label", dynlib: clarodll.}
#*
#  \brief Set the group of a Radio Button
#  
#  \param rbutton A valid Radio Button widget
#  \param group A valid Radio Group widget object
# 

proc radiobuttonSetGroup*(rbutton: ptr TRadioButton, group: ptr TRadioGroup){.
    cdecl, importc: "radiobutton_set_group", dynlib: clarodll.}

const 
  ClaroScrollbarMaximum* = 256

type 
  TScrollbar* {.pure.} = object of TWidget
    min*: Cint
    max*: Cint
    pagesize*: Cint


const 
  cScrollbarHorizontal* = 0
  cScrollbarVertical* = 1

# functions 
#*
#  \brief Creates a ScrollBar widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new ScrollBar widget object.
# 

proc newscrollbar*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                   flags: Cint): ptr TScrollbar{.
    cdecl, importc: "scrollbar_widget_create", dynlib: clarodll.}
#*
#  \brief Returns the width that scrollbars should be on this platform
#  
#  \return Width of vertical scrollbars
# 

proc scrollbarGetSysWidth*(): Cint{.cdecl, 
                                       importc: "scrollbar_get_sys_width", 
                                       dynlib: clarodll.}
#*
#  \brief Sets the range of a ScrollBar widget
#  
#  \param w A valid ScrollBar widget object
#  \param min The minimum value
#  \param max The maximum value
# 

proc scrollbarSetRange*(w: ptr TScrollbar, min: Cint, max: Cint){.cdecl, 
    importc: "scrollbar_set_range", dynlib: clarodll.}
#*
#  \brief Sets the position of a ScrollBar widget
#  
#  \param w A valid ScrollBar widget object
#  \param pos The new position
# 

proc scrollbarSetPos*(w: ptr TScrollbar, pos: Cint){.cdecl, 
    importc: "scrollbar_set_pos", dynlib: clarodll.}
#*
#  \brief Gets the position of a ScrollBar widget
#  
#  \param w A valid ScrollBar widget object
#  \return The current position
# 

proc scrollbarGetPos*(w: ptr TScrollbar): Cint{.cdecl, 
    importc: "scrollbar_get_pos", dynlib: clarodll.}
#*
#  \brief Sets the page size of a ScrollBar widget
# 
#  \param w A valid ScrollBar widget object
#  \param pagesize The size of a page (the number of units visible at one time)
# 

proc scrollbarSetPagesize*(w: ptr TScrollbar, pagesize: Cint){.cdecl, 
    importc: "scrollbar_set_pagesize", dynlib: clarodll.}
    
type 
  TcSplitterChildren* = enum 
    cSplitterFirst = 0, cSplitterSecond = 1
  TSplitterChild* {.pure.} = object 
    flex*: Cint
    size*: Cint
    w*: ptr TWidget

  TSplitter* {.pure.} = object of TWidget
    pair*: Array[0..1, TSplitterChild]


const 
  cSplitterHorizontal* = 0
  cSplitterVertical* = 1

# functions 
#*
#  \brief Creates a Splitter widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Splitter widget object.
# 

proc newsplitter*(parent: ptr TClaroObj, bounds: ptr TBounds,
                  flags: Cint): ptr TSplitter{.
    cdecl, importc: "splitter_widget_create", dynlib: clarodll.}
#*
#  \brief Sets the sizing information of a child
#  
#  \param splitter A valid splitter widget object
#  \param child The child number, either cSplitterFirst or cSplitterSecond.
#  \param flex 1 if this child should receive extra space as the splitter 
#         expands, 0 if not
#  \param size The size of this child
# 

proc splitterSetInfo*(splitter: ptr TSplitter, child: Cint, flex: Cint, 
                        size: Cint){.cdecl, importc: "splitter_set_info", 
                                     dynlib: clarodll.}
                                     
type 
  TStatusbar* {.pure.} = object of TWidget
    text*: Array[0..256 - 1, Char]


#*
#  \brief Creates a StatusBar widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param flags Widget flags.
#  \return A new StatusBar widget object.
# 

proc newstatusbar*(parent: ptr TClaroObj, flags: Cint): ptr TStatusbar {.cdecl, 
    importc: "statusbar_widget_create", dynlib: clarodll.}
#*
#  \brief Sets the text of a statusbar
#  
#  \param obj A valid StatusBar widget
#  \param text The new text
# 

proc statusbarSetText*(obj: ptr TStatusbar, text: Cstring){.cdecl, 
    importc: "statusbar_set_text", dynlib: clarodll.}
#*
#  \brief obtains a stock image
#  
#  \param stock_id The string ID of the stock image, NOT NULL.
#  \return The Image object.
# 

proc stockGetImage*(stock_id: Cstring): ptr TImage{.cdecl, 
    importc: "stock_get_image", dynlib: clarodll.}
#*
#  \brief adds a stock id image
#  
#  \param stock_id The string ID of the stock image, NOT NULL.
#  \param img The Image object to add.
#  \return The Image object.
# 

proc stockAddImage*(stock_id: Cstring, img: ptr TImage){.cdecl, 
    importc: "stock_add_image", dynlib: clarodll.}

const 
  ClaroTextareaMaximum = (1024 * 1024)

type 
  TTextArea* {.pure.} = object of TWidget
    text*: Array[0..CLARO_TEXTAREA_MAXIMUM - 1, Char]


#*
#  \brief Creates a TextArea widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new TextArea widget object.
# 

proc newtextarea*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                  flags: Cint): ptr TTextArea{.
    cdecl, importc: "textarea_widget_create", dynlib: clarodll.}
#*
#  \brief Sets the text of a textarea
#  
#  \param obj A valid TextArea widget
#  \param text The new text
# 

proc textareaSetText*(obj: ptr TTextArea, text: Cstring){.cdecl, 
    importc: "textarea_set_text", dynlib: clarodll.}
#*
#  \brief Retrieve the text of a textarea
#  
#  \param obj A valid TextArea widget
#  \return Pointer to an internal reference of the text. Should not be changed.
# 

proc textareaGetText*(obj: ptr TTextArea): Cstring{.cdecl, 
    importc: "textarea_get_text", dynlib: clarodll.}

const 
  ClaroTextboxMaximum = 8192

type 
  TTextBox* {.pure.} = object of TWidget
    text*: Array[0..CLARO_TEXTBOX_MAXIMUM-1, Char]


const 
  cTextBoxTypePassword* = 1

# functions 
#*
#  \brief Creates a TextBox widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new TextBox widget object.
# 

proc newtextbox*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                 flags: Cint): ptr TTextBox{.
    cdecl, importc: "textbox_widget_create", dynlib: clarodll.}
#*
#  \brief Sets the text of a textbox
#  
#  \param obj A valid TextBox widget
#  \param text The new text
# 

proc textboxSetText*(obj: ptr TTextBox, text: Cstring){.cdecl, 
    importc: "textbox_set_text", dynlib: clarodll.}
#*
#  \brief Retrieve the text of a textbox
#  
#  \param obj A valid TextBox widget
#  \return Pointer to an internal reference of the text. Should not be changed.
# 

proc textboxGetText*(obj: ptr TTextBox): Cstring{.cdecl, 
    importc: "textbox_get_text", dynlib: clarodll.}
#*
#  \brief Retrieve the cursor position inside a textbox
#  
#  \param obj A valid TextBox widget
#  \return Cursor position inside TextBox
# 

proc textboxGetPos*(obj: ptr TTextBox): Cint{.cdecl, 
    importc: "textbox_get_pos", dynlib: clarodll.}
#*
#  \brief Sets the cursor position inside a textbox
#  
#  \param obj A valid TextBox widget
#  \param pos New cursor position inside TextBox
# 

proc textboxSetPos*(obj: ptr TTextBox, pos: Cint){.cdecl, 
    importc: "textbox_set_pos", dynlib: clarodll.}

const 
  cToolbarShowText* = 1
  cToolbarShowImages* = 2
  cToolbarShowBoth* = 3
  cToolbarAutoSizeButtons* = 4

type 
  TToolbar* {.pure.} = object of TListWidget

#*
#  \brief Creates a ToolBar widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param flags Widget flags.
#  \return A new ToolBar widget object.
# 

proc newtoolbar*(parent: ptr TClaroObj, flags: Cint): ptr TToolbar{.cdecl, 
    importc: "toolbar_widget_create", dynlib: clarodll.}
#*
#  \brief Append a row to a ToolBar widget
#  
#  \param toolbar A valid ToolBar widget object.
#  \param image An image object, or NULL.
#  \param title A string title, or NULL.
#  \param tooltip A string tooltip, or NULL.
#  \return A new list item.
# 

proc toolbarAppendIcon*(toolbar: ptr TToolbar, image: ptr TImage, 
                          title: Cstring, tooltip: Cstring): ptr TListItem{.
    cdecl, importc: "toolbar_append_icon", dynlib: clarodll.}
#*
#  \brief Insert a row into a ToolBar widget
#  
#  \param toolbar A valid ToolBar widget object.
#  \param pos The position at which to insert this item
#  \param image An image object, or NULL.
#  \param title A string title, or NULL.
#  \param tooltip A string tooltip, or NULL.
#  \return A new list item.
# 

proc toolbarInsertIcon*(toolbar: ptr TToolbar, pos: Cint, 
                          image: ptr TImage, title: Cstring, 
                          tooltip: Cstring): ptr TListItem{.
    cdecl, importc: "toolbar_insert_icon", dynlib: clarodll.}
#*
#  \brief Append a separator to a ToolBar widget
#  
#  \param toolbar A valid ToolBar widget object.
#  \return A new list item.
# 

proc toolbarAppendSeparator*(toolbar: ptr TToolbar): ptr TListItem{.cdecl, 
    importc: "toolbar_append_separator", dynlib: clarodll.}
#*
#  \brief Insert a separator into a ToolBar widget
#  
#  \param toolbar A valid ToolBar widget object.
#  \param pos The position at which to insert this item
#  \return A new list item.
# 

proc toolbarInsertSeparator*(toolbar: ptr TToolbar, 
                               pos: Cint): ptr TListItem {.
    cdecl, importc: "toolbar_insert_separator", dynlib: clarodll.}
#*
#  \brief Assign a menu widget to an item.
# 
#  This will show a small down arrow next to the item
#  that will open this menu.
#  
#  \param toolbar A valid ToolBar widget object.
#  \param item Toolbar item the menu is for.
#  \param menu Menu widget object, or NULL to remove a menu.
# 

proc toolbarSetItemMenu*(toolbar: ptr TToolbar, item: ptr TListItem, 
                            menu: ptr TMenu){.cdecl, 
    importc: "toolbar_set_item_menu", dynlib: clarodll.}
#*
#  \brief Move a row in a ToolBar widget
#  
#  \param toolbar A valid ToolBar widget object.
#  \param item A valid list item
#  \param row New position to place this item
# 

proc toolbarMoveIcon*(toolbar: ptr TToolbar, item: ptr TListItem, 
                        row: Cint){.cdecl, importc: "toolbar_move_icon", 
                                    dynlib: clarodll.}
#*
#  \brief Remove a row from a ToolBar widget
#  
#  \param toolbar A valid ToolBar widget object.
#  \param item A valid list item
# 

proc toolbarRemoveIcon*(toolbar: ptr TToolbar, item: ptr TListItem){.
    cdecl, importc: "toolbar_remove_icon", dynlib: clarodll.}
#*
#  \brief Returns the number of rows in a ToolBar widget
#  
#  \param obj A valid ToolBar widget object.
#  \return Number of rows
# 

proc toolbarItemCount*(obj: ptr TToolbar): Cint{.cdecl, 
    importc: "toolbar_item_count", dynlib: clarodll.}
#*
#  \brief TreeView widget
# 

type 
  TTreeview* {.pure.} = object of TListWidget
    selected*: ptr TListItem


# functions 
#*
#  \brief Creates a TreeView widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new TreeView widget object.
# 

proc newtreeview*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                  flags: Cint): ptr TTreeview{.
    cdecl, importc: "treeview_widget_create", dynlib: clarodll.}
#*
#  \brief Append a row to a TreeView
#  
#  \param treeview A valid TreeView widget object.
#  \param parent The item under which to place the new item, or NULL for a root node.
#  \param image An image to go to the left of the item, or NULL for no image.
#  \param title The text for the item.
#  \return A new list item.
# 

proc treeviewAppendRow*(treeview: ptr TTreeview, parent: ptr TListItem, 
                          image: ptr TImage, title: Cstring): ptr TListItem{.
    cdecl, importc: "treeview_append_row", dynlib: clarodll.}
#*
#  \brief Insert a row at the specified position into a TreeView
#  
#  \param treeview A valid TreeView widget object.
#  \param parent The item under which to place the new item, or NULL for a root node.
#  \param pos The index at which this item will be placed.
#  \param image An image to go to the left of the item, or NULL for no image.
#  \param title The text for the item.
#  \return A new list item.
# 

proc treeviewInsertRow*(treeview: ptr TTreeview, parent: ptr TListItem, 
                          pos: Cint, image: ptr TImage, 
                          title: Cstring): ptr TListItem{.
    cdecl, importc: "treeview_insert_row", dynlib: clarodll.}
#*
#  \brief Move a row in a TreeView
#  
#  \param treeview A valid TreeView widget object.
#  \param item A valid list item
#  \param row New position to place this item
# 

proc treeviewMoveRow*(treeview: ptr TTreeview, item: ptr TListItem, 
                        row: Cint){.cdecl, importc: "treeview_move_row", 
                                    dynlib: clarodll.}
#*
#  \brief Remove a row from a TreeView
#  
#  \param treeview A valid TreeView widget object.
#  \param item A valid list item
# 

proc treeviewRemoveRow*(treeview: ptr TTreeview, item: ptr TListItem){.
    cdecl, importc: "treeview_remove_row", dynlib: clarodll.}
#*
#  \brief Expand a row in a TreeView
#  
#  \param treeview A valid TreeView widget object.
#  \param item A valid list item
# 

proc treeviewExpand*(treeview: ptr TTreeview, item: ptr TListItem){.cdecl, 
    importc: "treeview_expand", dynlib: clarodll.}
#*
#  \brief Collapse a row in a TreeView
#  
#  \param treeview A valid TreeView widget object.
#  \param item A valid list item
# 

proc treeviewCollapse*(treeview: ptr TTreeview, item: ptr TListItem){.cdecl, 
    importc: "treeview_collapse", dynlib: clarodll.}
#*
#  \brief Returns the currently selected TreeView item
#  
#  \param obj A valid TreeView widget object.
#  \return The currently selected TreeView item, or NULL if no item is selected.
# 

proc treeviewGetSelected*(obj: ptr TTreeview): ptr TListItem{.cdecl, 
    importc: "treeview_get_selected", dynlib: clarodll.}
#*
#  \brief Returns the number of rows in a TreeView
#  
#  \param obj A valid TreeView widget object.
#  \param parent Return the number of children of this item, or the number of
#                root items if NULL
#  \return Number of rows
# 

proc treeviewGetRows*(obj: ptr TTreeview, parent: ptr TListItem): Cint{.
    cdecl, importc: "treeview_get_rows", dynlib: clarodll.}
#*
#  \brief Selects a row in a TreeView
#  
#  \param obj A valid TreeView widget object.
#  \param item A valid list item
# 

proc treeviewSelectItem*(obj: ptr TTreeview, item: ptr TListItem){.cdecl, 
    importc: "treeview_select_item", dynlib: clarodll.}

const 
  cWindowModalDialog* = 1
  cWindowCenterParent* = 2
  cWindowNoResizing* = 4

type 
  TWindow* {.pure.} = object of TWidget
    title*: Array[0..512 - 1, Char]
    icon*: ptr TImage
    menubar*: ptr TWidget
    workspace*: ptr TWidget
    exsp_tools*: Cint
    exsp_status*: Cint
    exsp_init*: Cint


const 
  cWindowFixedSize* = 1

# functions 
#*
#  \brief Creates a Window widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Window widget object.
# 

proc newwindow*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                flags: Cint): ptr TWindow {.
    cdecl, importc: "window_widget_create", dynlib: clarodll.}
#*
#  \brief Sets a Window's title
#  
#  \param w A valid Window widget object
#  \param title The new title for the window
# 

proc windowSetTitle*(w: ptr TWindow, title: Cstring){.cdecl, 
    importc: "window_set_title", dynlib: clarodll.}
#*
#  \brief Makes a window visible
#  
#  \param w A valid Window widget object
# 

proc windowShow*(w: ptr TWindow){.cdecl, importc: "window_show", 
                                     dynlib: clarodll.}
#*
#  \brief Makes a window invisible
#  
#  \param w A valid Window widget object
# 

proc windowHide*(w: ptr TWindow){.cdecl, importc: "window_hide", 
                                     dynlib: clarodll.}
#*
#  \brief Gives focus to a window
#  
#  \param w A valid Window widget object
# 

proc windowFocus*(w: ptr TWindow){.cdecl, importc: "window_focus", 
                                      dynlib: clarodll.}
#*
#  \brief Maximises a window
#  
#  \param w A valid Window widget object
# 

proc windowMaximize*(w: ptr TWindow){.cdecl, importc: "window_maximise", 
    dynlib: clarodll.}
#*
#  \brief Minimises a window
#  
#  \param w A valid Window widget object
# 

proc windowMinimize*(w: ptr TWindow){.cdecl, importc: "window_minimise", 
    dynlib: clarodll.}
#*
#  \brief Restores a window
#  
#  \param w A valid Window widget object
# 

proc windowRestore*(w: ptr TWindow){.cdecl, importc: "window_restore", 
                                        dynlib: clarodll.}
#*
#  \brief Sets a window's icon
#  
#  \param w A valid Window widget object
#  \param icon A valid Image object
# 

proc windowSetIcon*(w: ptr TWindow, icon: ptr TImage){.cdecl, 
    importc: "window_set_icon", dynlib: clarodll.}

const 
  cWorkspaceTileHorizontally* = 0
  cWorkspaceTileVertically* = 1

type 
  TWorkspace*{.pure.} = object of TWidget

  TWorkspaceWindow*{.pure.} = object of TWidget
    icon*: ptr TImage
    title*: Array[0..512 - 1, Char]
    workspace*: ptr TWorkspace


# functions (workspace) 
#*
#  \brief Creates a Workspace widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Workspace widget object.
# 

proc newworkspace*(parent: ptr TClaroObj, bounds: ptr TBounds, 
                   flags: Cint): ptr TWorkspace{.
    cdecl, importc: "workspace_widget_create", dynlib: clarodll.}
#*
#  \brief Sets the active (visible) workspace child
#  
#  \param workspace A valid workspace widget
#  \param child A valid workspace window widget
# 

proc workspaceSetActive*(workspace: ptr TWorkspace, child: ptr TClaroObj){.
    cdecl, importc: "workspace_set_active", dynlib: clarodll.}
#*
#  \brief Returns the active (visible) workspace child
#  
#  \param workspace A valid workspace widget
#  \return The active workspace window widget
# 

proc workspaceGetActive*(workspace: ptr TWorkspace): ptr TWorkspace{.cdecl, 
    importc: "workspace_get_active", dynlib: clarodll.}
#*
#  \brief Cascades all workspace windows
#  
#  \param workspace A valid workspace widget
# 

proc workspaceCascade*(workspace: ptr TWorkspace){.cdecl, 
    importc: "workspace_cascade", dynlib: clarodll.}
#*
#  \brief Tiles all workspace windows
#  
#  \param workspace A valid workspace widget
#  \param dir The direction to tile child widgets
# 

proc workspaceTile*(workspace: ptr TWorkspace, dir: Cint){.cdecl, 
    importc: "workspace_tile", dynlib: clarodll.}
# functions (workspace_window) 
#*
#  \brief Creates a Workspace widget
#  
#  \param parent The parent widget of this widget, NOT NULL.
#  \param bounds The initial bounds of this widget, or NO_BOUNDS.
#  \param flags Widget flags.
#  \return A new Workspace widget object.
# 

proc newWorkspaceWindow*(parent: ptr TClaroObj, 
                         bounds: ptr TBounds, 
                         flags: Cint): ptr TWorkspaceWindow{.
    cdecl, importc: "workspace_window_widget_create", dynlib: clarodll.}
#*
#  \brief Sets the title of a Workspace Window widget
#  
#  \param window A valid Workspace Window widget
#  \param title The new title for the widget
# 

proc workspaceWindowSetTitle*(window: ptr TWorkspaceWindow, 
                                 title: Cstring){.cdecl, 
    importc: "workspace_window_set_title", dynlib: clarodll.}
#*
#  \brief Makes a Workspace Window widget visible
#  
#  \param window A valid Workspace Window widget
# 

proc workspaceWindowShow*(window: ptr TWorkspaceWindow){.cdecl, 
    importc: "workspace_window_show", dynlib: clarodll.}
#*
#  \brief Makes a Workspace Window widget invisible
#  
#  \param window A valid Workspace Window widget
# 

proc workspaceWindowHide*(window: ptr TWorkspaceWindow){.cdecl, 
    importc: "workspace_window_hide", dynlib: clarodll.}
#*
#  \brief Restores a Workspace Window widget
#  
#  \param window A valid Workspace Window widget
# 

proc workspaceWindowRestore*(window: ptr TWorkspaceWindow){.cdecl, 
    importc: "workspace_window_restore", dynlib: clarodll.}
# American spelling 

#*
#  \brief Minimises a Workspace Window widget
#  
#  \param window A valid Workspace Window widget
# 

proc workspaceWindowMinimize*(window: ptr TWorkspaceWindow){.cdecl, 
    importc: "workspace_window_minimise", dynlib: clarodll.}
#*
#  \brief Maxmimises a Workspace Window widget
#  
#  \param window A valid Workspace Window widget
# 

proc workspaceWindowMaximize*(window: ptr TWorkspaceWindow){.cdecl, 
    importc: "workspace_window_maximise", dynlib: clarodll.}
#*
#  \brief Sets the icon of a Workspace Window widget
#  
#  \param window A valid Workspace Window widget
#  \param icon A valid Image object.
# 

proc workspaceWindowSetIcon*(w: ptr TWorkspaceWindow, icon: ptr TImage){.
    cdecl, importc: "workspace_window_set_icon", dynlib: clarodll.}
    
claroBaseInit()
claroGraphicsInit()

when isMainModule:
  var w = newwindow(nil, newBounds(100, 100, 230, 230), 0)
  windowSetTitle(w, "Hello, World!")

  var t = newTextbox(w, new_bounds(10, 10, 210, -1), 0)
  widgetSetNotify(t, cNotifyKey)
  textboxSetText(t, "Yeehaw!")

  var b = newButton(w, new_bounds(40, 45, 150, -1), 0, "Push my button!")

  proc pushMyButton(obj: ptr TClaroObj, event: ptr TEvent) {.cdecl.} =
    textboxSetText(t, "You pushed my button!")
    var button = cast[ptr TButton](obj)
    buttonSetText(button, "Ouch!")

  objectAddhandler(b, "pushed", pushMyButton)

  windowShow(w)
  windowFocus(w)

  claroLoop()

