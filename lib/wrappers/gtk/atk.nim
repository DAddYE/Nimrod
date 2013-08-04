{.deadCodeElim: on.}
import 
  glib2

when defined(windows): 
  const 
    lib = "libatk-1.0-0.dll"
elif defined(macosx):
  const 
    lib = "libatk-1.0.dylib"
else: 
  const 
    lib = "libatk-1.0.so"
type 
  PImplementor* = Pointer
  PAction* = Pointer
  PComponent* = Pointer
  PDocument* = Pointer
  PEditableText* = Pointer
  PHypertext* = Pointer
  PImage* = Pointer
  PSelection* = Pointer
  PStreamableContent* = Pointer
  PTable* = Pointer
  PText* = Pointer
  PValue* = Pointer
  PRelationSet* = ptr TRelationSet
  PStateSet* = ptr TStateSet
  PAttributeSet* = ptr TAttributeSet
  PCoordType* = ptr TCoordType
  TCoordType* = enum 
    XY_SCREEN, XY_WINDOW
  PRole* = ptr TRole
  TRole* = enum 
    ROLE_INVALID, ROLE_ACCEL_LABEL, ROLE_ALERT, ROLE_ANIMATION, ROLE_ARROW, 
    ROLE_CALENDAR, ROLE_CANVAS, ROLE_CHECK_BOX, ROLE_CHECK_MENU_ITEM, 
    ROLE_COLOR_CHOOSER, ROLE_COLUMN_HEADER, ROLE_COMBO_BOX, ROLE_DATE_EDITOR, 
    ROLE_DESKTOP_ICON, ROLE_DESKTOP_FRAME, ROLE_DIAL, ROLE_DIALOG, 
    ROLE_DIRECTORY_PANE, ROLE_DRAWING_AREA, ROLE_FILE_CHOOSER, ROLE_FILLER, 
    ROLE_FONT_CHOOSER, ROLE_FRAME, ROLE_GLASS_PANE, ROLE_HTML_CONTAINER, 
    ROLE_ICON, ROLE_IMAGE, ROLE_INTERNAL_FRAME, ROLE_LABEL, ROLE_LAYERED_PANE, 
    ROLE_LIST, ROLE_LIST_ITEM, ROLE_MENU, ROLE_MENU_BAR, ROLE_MENU_ITEM, 
    ROLE_OPTION_PANE, ROLE_PAGE_TAB, ROLE_PAGE_TAB_LIST, ROLE_PANEL, 
    ROLE_PASSWORD_TEXT, ROLE_POPUP_MENU, ROLE_PROGRESS_BAR, ROLE_PUSH_BUTTON, 
    ROLE_RADIO_BUTTON, ROLE_RADIO_MENU_ITEM, ROLE_ROOT_PANE, ROLE_ROW_HEADER, 
    ROLE_SCROLL_BAR, ROLE_SCROLL_PANE, ROLE_SEPARATOR, ROLE_SLIDER, 
    ROLE_SPLIT_PANE, ROLE_SPIN_BUTTON, ROLE_STATUSBAR, ROLE_TABLE, 
    ROLE_TABLE_CELL, ROLE_TABLE_COLUMN_HEADER, ROLE_TABLE_ROW_HEADER, 
    ROLE_TEAR_OFF_MENU_ITEM, ROLE_TERMINAL, ROLE_TEXT, ROLE_TOGGLE_BUTTON, 
    ROLE_TOOL_BAR, ROLE_TOOL_TIP, ROLE_TREE, ROLE_TREE_TABLE, ROLE_UNKNOWN, 
    ROLE_VIEWPORT, ROLE_WINDOW, ROLE_LAST_DEFINED
  PLayer* = ptr TLayer
  TLayer* = enum 
    LAYER_INVALID, LAYER_BACKGROUND, LAYER_CANVAS, LAYER_WIDGET, LAYER_MDI, 
    LAYER_POPUP, LAYER_OVERLAY
  PPropertyValues* = ptr TPropertyValues
  TPropertyValues*{.final, pure.} = object 
    property_name*: Cstring
    old_value*: TGValue
    new_value*: TGValue

  TFunction* = proc (data: Gpointer): Gboolean{.cdecl.}
  PObject* = ptr TObject
  PPAtkObject* = ptr PObject
  TObject* = object of TGObject
    description*: Cstring
    name*: Cstring
    accessible_parent*: PObject
    role*: TRole
    relation_set*: PRelationSet
    layer*: TLayer

  TPropertyChangeHandler* = proc (para1: PObject, para2: PPropertyValues){.cdecl.}
  PObjectClass* = ptr TObjectClass
  TObjectClass* = object of TGObjectClass
    get_name*: proc (accessible: PObject): Cstring{.cdecl.}
    get_description*: proc (accessible: PObject): Cstring{.cdecl.}
    get_parent*: proc (accessible: PObject): PObject{.cdecl.}
    get_n_children*: proc (accessible: PObject): Gint{.cdecl.}
    ref_child*: proc (accessible: PObject, i: Gint): PObject{.cdecl.}
    get_index_in_parent*: proc (accessible: PObject): Gint{.cdecl.}
    ref_relation_set*: proc (accessible: PObject): PRelationSet{.cdecl.}
    get_role*: proc (accessible: PObject): TRole{.cdecl.}
    get_layer*: proc (accessible: PObject): TLayer{.cdecl.}
    get_mdi_zorder*: proc (accessible: PObject): Gint{.cdecl.}
    ref_state_set*: proc (accessible: PObject): PStateSet{.cdecl.}
    set_name*: proc (accessible: PObject, name: Cstring){.cdecl.}
    set_description*: proc (accessible: PObject, description: Cstring){.cdecl.}
    set_parent*: proc (accessible: PObject, parent: PObject){.cdecl.}
    set_role*: proc (accessible: PObject, role: TRole){.cdecl.}
    connect_property_change_handler*: proc (accessible: PObject, 
        handler: TPropertyChangeHandler): Guint{.cdecl.}
    remove_property_change_handler*: proc (accessible: PObject, 
        handler_id: Guint){.cdecl.}
    initialize*: proc (accessible: PObject, data: Gpointer){.cdecl.}
    children_changed*: proc (accessible: PObject, change_index: Guint, 
                             changed_child: Gpointer){.cdecl.}
    focus_event*: proc (accessible: PObject, focus_in: Gboolean){.cdecl.}
    property_change*: proc (accessible: PObject, values: PPropertyValues){.cdecl.}
    state_change*: proc (accessible: PObject, name: Cstring, state_set: Gboolean){.
        cdecl.}
    visible_data_changed*: proc (accessible: PObject){.cdecl.}
    pad1*: TFunction
    pad2*: TFunction
    pad3*: TFunction
    pad4*: TFunction

  PImplementorIface* = ptr TImplementorIface
  TImplementorIface* = object of TGTypeInterface
    ref_accessible*: proc (implementor: PImplementor): PObject{.cdecl.}

  PActionIface* = ptr TActionIface
  TActionIface* = object of TGTypeInterface
    do_action*: proc (action: PAction, i: Gint): Gboolean{.cdecl.}
    get_n_actions*: proc (action: PAction): Gint{.cdecl.}
    get_description*: proc (action: PAction, i: Gint): Cstring{.cdecl.}
    get_name*: proc (action: PAction, i: Gint): Cstring{.cdecl.}
    get_keybinding*: proc (action: PAction, i: Gint): Cstring{.cdecl.}
    set_description*: proc (action: PAction, i: Gint, desc: Cstring): Gboolean{.
        cdecl.}
    pad1*: TFunction
    pad2*: TFunction

  TFocusHandler* = proc (para1: PObject, para2: Gboolean){.cdecl.}
  PComponentIface* = ptr TComponentIface
  TComponentIface* = object of TGTypeInterface
    add_focus_handler*: proc (component: PComponent, handler: TFocusHandler): Guint{.
        cdecl.}
    contains*: proc (component: PComponent, x: Gint, y: Gint, 
                     coord_type: TCoordType): Gboolean{.cdecl.}
    ref_accessible_at_point*: proc (component: PComponent, x: Gint, y: Gint, 
                                    coord_type: TCoordType): PObject{.cdecl.}
    get_extents*: proc (component: PComponent, x: Pgint, y: Pgint, width: Pgint, 
                        height: Pgint, coord_type: TCoordType){.cdecl.}
    get_position*: proc (component: PComponent, x: Pgint, y: Pgint, 
                         coord_type: TCoordType){.cdecl.}
    get_size*: proc (component: PComponent, width: Pgint, height: Pgint){.cdecl.}
    grab_focus*: proc (component: PComponent): Gboolean{.cdecl.}
    remove_focus_handler*: proc (component: PComponent, handler_id: Guint){.
        cdecl.}
    set_extents*: proc (component: PComponent, x: Gint, y: Gint, width: Gint, 
                        height: Gint, coord_type: TCoordType): Gboolean{.cdecl.}
    set_position*: proc (component: PComponent, x: Gint, y: Gint, 
                         coord_type: TCoordType): Gboolean{.cdecl.}
    set_size*: proc (component: PComponent, width: Gint, height: Gint): Gboolean{.
        cdecl.}
    get_layer*: proc (component: PComponent): TLayer{.cdecl.}
    get_mdi_zorder*: proc (component: PComponent): Gint{.cdecl.}
    pad1*: TFunction
    pad2*: TFunction

  PDocumentIface* = ptr TDocumentIface
  TDocumentIface* = object of TGTypeInterface
    get_document_type*: proc (document: PDocument): Cstring{.cdecl.}
    get_document*: proc (document: PDocument): Gpointer{.cdecl.}
    pad1*: TFunction
    pad2*: TFunction
    pad3*: TFunction
    pad4*: TFunction
    pad5*: TFunction
    pad6*: TFunction
    pad7*: TFunction
    pad8*: TFunction

  PEditableTextIface* = ptr TEditableTextIface
  TEditableTextIface* = object of TGTypeInterface
    set_run_attributes*: proc (text: PEditableText, attrib_set: PAttributeSet, 
                               start_offset: Gint, end_offset: Gint): Gboolean{.
        cdecl.}
    set_text_contents*: proc (text: PEditableText, `string`: Cstring){.cdecl.}
    insert_text*: proc (text: PEditableText, `string`: Cstring, length: Gint, 
                        position: Pgint){.cdecl.}
    copy_text*: proc (text: PEditableText, start_pos: Gint, end_pos: Gint){.
        cdecl.}
    cut_text*: proc (text: PEditableText, start_pos: Gint, end_pos: Gint){.cdecl.}
    delete_text*: proc (text: PEditableText, start_pos: Gint, end_pos: Gint){.
        cdecl.}
    paste_text*: proc (text: PEditableText, position: Gint){.cdecl.}
    pad1*: TFunction
    pad2*: TFunction

  PGObjectAccessible* = ptr TGObjectAccessible
  TGObjectAccessible* = object of TObject
  PGObjectAccessibleClass* = ptr TGObjectAccessibleClass
  TGObjectAccessibleClass* = object of TObjectClass
    pad5*: TFunction
    pad6*: TFunction

  PHyperlink* = ptr THyperlink
  THyperlink* = object of TGObject
  PHyperlinkClass* = ptr THyperlinkClass
  THyperlinkClass* = object of TGObjectClass
    get_uri*: proc (link: PHyperlink, i: Gint): Cstring{.cdecl.}
    get_object*: proc (link: PHyperlink, i: Gint): PObject{.cdecl.}
    get_end_index*: proc (link: PHyperlink): Gint{.cdecl.}
    get_start_index*: proc (link: PHyperlink): Gint{.cdecl.}
    is_valid*: proc (link: PHyperlink): Gboolean{.cdecl.}
    get_n_anchors*: proc (link: PHyperlink): Gint{.cdecl.}
    pad7*: TFunction
    pad8*: TFunction
    pad9*: TFunction
    pad10*: TFunction

  PHypertextIface* = ptr THypertextIface
  THypertextIface* = object of TGTypeInterface
    get_link*: proc (hypertext: PHypertext, link_index: Gint): PHyperlink{.cdecl.}
    get_n_links*: proc (hypertext: PHypertext): Gint{.cdecl.}
    get_link_index*: proc (hypertext: PHypertext, char_index: Gint): Gint{.cdecl.}
    pad11*: TFunction
    pad12*: TFunction
    pad13*: TFunction
    pad14*: TFunction

  PImageIface* = ptr TImageIface
  TImageIface* = object of TGTypeInterface
    get_image_position*: proc (image: PImage, x: Pgint, y: Pgint, 
                               coord_type: TCoordType){.cdecl.}
    get_image_description*: proc (image: PImage): Cstring{.cdecl.}
    get_image_size*: proc (image: PImage, width: Pgint, height: Pgint){.cdecl.}
    set_image_description*: proc (image: PImage, description: Cstring): Gboolean{.
        cdecl.}
    pad15*: TFunction
    pad16*: TFunction

  PObjectFactory* = ptr TObjectFactory
  TObjectFactory* = object of TGObject
  PObjectFactoryClass* = ptr TObjectFactoryClass
  TObjectFactoryClass* = object of TGObjectClass
    create_accessible*: proc (obj: PGObject): PObject{.cdecl.}
    invalidate*: proc (factory: PObjectFactory){.cdecl.}
    get_accessible_type*: proc (): GType{.cdecl.}
    pad17*: TFunction
    pad18*: TFunction

  PRegistry* = ptr TRegistry
  TRegistry* = object of TGObject
    factory_type_registry*: PGHashTable
    factory_singleton_cache*: PGHashTable

  PRegistryClass* = ptr TRegistryClass
  TRegistryClass* = object of TGObjectClass
  PRelationType* = ptr TRelationType
  TRelationType* = enum 
    RELATION_NULL, RELATION_CONTROLLED_BY, RELATION_CONTROLLER_FOR, 
    RELATION_LABEL_FOR, RELATION_LABELLED_BY, RELATION_MEMBER_OF, 
    RELATION_NODE_CHILD_OF, RELATION_LAST_DEFINED
  PRelation* = ptr TRelation
  PGPtrArray = Pointer
  TRelation* = object of TGObject
    target*: PGPtrArray
    relationship*: TRelationType

  PRelationClass* = ptr TRelationClass
  TRelationClass* = object of TGObjectClass
  TRelationSet* = object of TGObject
    relations*: PGPtrArray

  PRelationSetClass* = ptr TRelationSetClass
  TRelationSetClass* = object of TGObjectClass
    pad19*: TFunction
    pad20*: TFunction

  PSelectionIface* = ptr TSelectionIface
  TSelectionIface* = object of TGTypeInterface
    add_selection*: proc (selection: PSelection, i: Gint): Gboolean{.cdecl.}
    clear_selection*: proc (selection: PSelection): Gboolean{.cdecl.}
    ref_selection*: proc (selection: PSelection, i: Gint): PObject{.cdecl.}
    get_selection_count*: proc (selection: PSelection): Gint{.cdecl.}
    is_child_selected*: proc (selection: PSelection, i: Gint): Gboolean{.cdecl.}
    remove_selection*: proc (selection: PSelection, i: Gint): Gboolean{.cdecl.}
    select_all_selection*: proc (selection: PSelection): Gboolean{.cdecl.}
    selection_changed*: proc (selection: PSelection){.cdecl.}
    pad1*: TFunction
    pad2*: TFunction

  PStateType* = ptr TStateType
  TStateType* = enum 
    STATE_INVALID, STATE_ACTIVE, STATE_ARMED, STATE_BUSY, STATE_CHECKED, 
    STATE_DEFUNCT, STATE_EDITABLE, STATE_ENABLED, STATE_EXPANDABLE, 
    STATE_EXPANDED, STATE_FOCUSABLE, STATE_FOCUSED, STATE_HORIZONTAL, 
    STATE_ICONIFIED, STATE_MODAL, STATE_MULTI_LINE, STATE_MULTISELECTABLE, 
    STATE_OPAQUE, STATE_PRESSED, STATE_RESIZABLE, STATE_SELECTABLE, 
    STATE_SELECTED, STATE_SENSITIVE, STATE_SHOWING, STATE_SINGLE_LINE, 
    STATE_STALE, STATE_TRANSIENT, STATE_VERTICAL, STATE_VISIBLE, 
    STATE_LAST_DEFINED
  PState* = ptr TState
  TState* = Guint64
  TStateSet* = object of TGObject
  PStateSetClass* = ptr TStateSetClass
  TStateSetClass* = object of TGObjectClass
  PStreamableContentIface* = ptr TStreamableContentIface
  TStreamableContentIface* = object of TGTypeInterface
    get_n_mime_types*: proc (streamable: PStreamableContent): Gint{.cdecl.}
    get_mime_type*: proc (streamable: PStreamableContent, i: Gint): Cstring{.
        cdecl.}
    get_stream*: proc (streamable: PStreamableContent, mime_type: Cstring): PGIOChannel{.
        cdecl.}
    pad21*: TFunction
    pad22*: TFunction
    pad23*: TFunction
    pad24*: TFunction

  PTableIface* = ptr TTableIface
  TTableIface* = object of TGTypeInterface
    ref_at*: proc (table: PTable, row: Gint, column: Gint): PObject{.cdecl.}
    get_index_at*: proc (table: PTable, row: Gint, column: Gint): Gint{.cdecl.}
    get_column_at_index*: proc (table: PTable, index: Gint): Gint{.cdecl.}
    get_row_at_index*: proc (table: PTable, index: Gint): Gint{.cdecl.}
    get_n_columns*: proc (table: PTable): Gint{.cdecl.}
    get_n_rows*: proc (table: PTable): Gint{.cdecl.}
    get_column_extent_at*: proc (table: PTable, row: Gint, column: Gint): Gint{.
        cdecl.}
    get_row_extent_at*: proc (table: PTable, row: Gint, column: Gint): Gint{.
        cdecl.}
    get_caption*: proc (table: PTable): PObject{.cdecl.}
    get_column_description*: proc (table: PTable, column: Gint): Cstring{.cdecl.}
    get_column_header*: proc (table: PTable, column: Gint): PObject{.cdecl.}
    get_row_description*: proc (table: PTable, row: Gint): Cstring{.cdecl.}
    get_row_header*: proc (table: PTable, row: Gint): PObject{.cdecl.}
    get_summary*: proc (table: PTable): PObject{.cdecl.}
    set_caption*: proc (table: PTable, caption: PObject){.cdecl.}
    set_column_description*: proc (table: PTable, column: Gint, 
                                   description: Cstring){.cdecl.}
    set_column_header*: proc (table: PTable, column: Gint, header: PObject){.
        cdecl.}
    set_row_description*: proc (table: PTable, row: Gint, description: Cstring){.
        cdecl.}
    set_row_header*: proc (table: PTable, row: Gint, header: PObject){.cdecl.}
    set_summary*: proc (table: PTable, accessible: PObject){.cdecl.}
    get_selected_columns*: proc (table: PTable, selected: PPgint): Gint{.cdecl.}
    get_selected_rows*: proc (table: PTable, selected: PPgint): Gint{.cdecl.}
    is_column_selected*: proc (table: PTable, column: Gint): Gboolean{.cdecl.}
    is_row_selected*: proc (table: PTable, row: Gint): Gboolean{.cdecl.}
    is_selected*: proc (table: PTable, row: Gint, column: Gint): Gboolean{.cdecl.}
    add_row_selection*: proc (table: PTable, row: Gint): Gboolean{.cdecl.}
    remove_row_selection*: proc (table: PTable, row: Gint): Gboolean{.cdecl.}
    add_column_selection*: proc (table: PTable, column: Gint): Gboolean{.cdecl.}
    remove_column_selection*: proc (table: PTable, column: Gint): Gboolean{.
        cdecl.}
    row_inserted*: proc (table: PTable, row: Gint, num_inserted: Gint){.cdecl.}
    column_inserted*: proc (table: PTable, column: Gint, num_inserted: Gint){.
        cdecl.}
    row_deleted*: proc (table: PTable, row: Gint, num_deleted: Gint){.cdecl.}
    column_deleted*: proc (table: PTable, column: Gint, num_deleted: Gint){.
        cdecl.}
    row_reordered*: proc (table: PTable){.cdecl.}
    column_reordered*: proc (table: PTable){.cdecl.}
    model_changed*: proc (table: PTable){.cdecl.}
    pad25*: TFunction
    pad26*: TFunction
    pad27*: TFunction
    pad28*: TFunction

  TAttributeSet* = TGSList
  PAttribute* = ptr TAttribute
  TAttribute*{.final, pure.} = object 
    name*: Cstring
    value*: Cstring

  PTextAttribute* = ptr TTextAttribute
  TTextAttribute* = enum 
    TEXT_ATTR_INVALID, TEXT_ATTR_LEFT_MARGIN, TEXT_ATTR_RIGHT_MARGIN, 
    TEXT_ATTR_INDENT, TEXT_ATTR_INVISIBLE, TEXT_ATTR_EDITABLE, 
    TEXT_ATTR_PIXELS_ABOVE_LINES, TEXT_ATTR_PIXELS_BELOW_LINES, 
    TEXT_ATTR_PIXELS_INSIDE_WRAP, TEXT_ATTR_BG_FULL_HEIGHT, TEXT_ATTR_RISE, 
    TEXT_ATTR_UNDERLINE, TEXT_ATTR_STRIKETHROUGH, TEXT_ATTR_SIZE, 
    TEXT_ATTR_SCALE, TEXT_ATTR_WEIGHT, TEXT_ATTR_LANGUAGE, 
    TEXT_ATTR_FAMILY_NAME, TEXT_ATTR_BG_COLOR, TEXT_ATTR_FG_COLOR, 
    TEXT_ATTR_BG_STIPPLE, TEXT_ATTR_FG_STIPPLE, TEXT_ATTR_WRAP_MODE, 
    TEXT_ATTR_DIRECTION, TEXT_ATTR_JUSTIFICATION, TEXT_ATTR_STRETCH, 
    TEXT_ATTR_VARIANT, TEXT_ATTR_STYLE, TEXT_ATTR_LAST_DEFINED
  PTextBoundary* = ptr TTextBoundary
  TTextBoundary* = enum 
    TEXT_BOUNDARY_CHAR, TEXT_BOUNDARY_WORD_START, TEXT_BOUNDARY_WORD_END, 
    TEXT_BOUNDARY_SENTENCE_START, TEXT_BOUNDARY_SENTENCE_END, 
    TEXT_BOUNDARY_LINE_START, TEXT_BOUNDARY_LINE_END
  PTextIface* = ptr TTextIface
  TTextIface* = object of TGTypeInterface
    get_text*: proc (text: PText, start_offset: Gint, end_offset: Gint): Cstring{.
        cdecl.}
    get_text_after_offset*: proc (text: PText, offset: Gint, 
                                  boundary_type: TTextBoundary, 
                                  start_offset: Pgint, end_offset: Pgint): Cstring{.
        cdecl.}
    get_text_at_offset*: proc (text: PText, offset: Gint, 
                               boundary_type: TTextBoundary, 
                               start_offset: Pgint, end_offset: Pgint): Cstring{.
        cdecl.}
    get_character_at_offset*: proc (text: PText, offset: Gint): Gunichar{.cdecl.}
    get_text_before_offset*: proc (text: PText, offset: Gint, 
                                   boundary_type: TTextBoundary, 
                                   start_offset: Pgint, end_offset: Pgint): Cstring{.
        cdecl.}
    get_caret_offset*: proc (text: PText): Gint{.cdecl.}
    get_run_attributes*: proc (text: PText, offset: Gint, start_offset: Pgint, 
                               end_offset: Pgint): PAttributeSet{.cdecl.}
    get_default_attributes*: proc (text: PText): PAttributeSet{.cdecl.}
    get_character_extents*: proc (text: PText, offset: Gint, x: Pgint, y: Pgint, 
                                  width: Pgint, height: Pgint, 
                                  coords: TCoordType){.cdecl.}
    get_character_count*: proc (text: PText): Gint{.cdecl.}
    get_offset_at_point*: proc (text: PText, x: Gint, y: Gint, 
                                coords: TCoordType): Gint{.cdecl.}
    get_n_selections*: proc (text: PText): Gint{.cdecl.}
    get_selection*: proc (text: PText, selection_num: Gint, start_offset: Pgint, 
                          end_offset: Pgint): Cstring{.cdecl.}
    add_selection*: proc (text: PText, start_offset: Gint, end_offset: Gint): Gboolean{.
        cdecl.}
    remove_selection*: proc (text: PText, selection_num: Gint): Gboolean{.cdecl.}
    set_selection*: proc (text: PText, selection_num: Gint, start_offset: Gint, 
                          end_offset: Gint): Gboolean{.cdecl.}
    set_caret_offset*: proc (text: PText, offset: Gint): Gboolean{.cdecl.}
    text_changed*: proc (text: PText, position: Gint, length: Gint){.cdecl.}
    text_caret_moved*: proc (text: PText, location: Gint){.cdecl.}
    text_selection_changed*: proc (text: PText){.cdecl.}
    pad29*: TFunction
    pad30*: TFunction
    pad31*: TFunction
    pad32*: TFunction

  TEventListener* = proc (para1: PObject){.cdecl.}
  TEventListenerInitProc* = proc (){.cdecl.}
  TEventListenerInit* = proc (para1: TEventListenerInitProc){.cdecl.}
  PKeyEventStruct* = ptr TKeyEventStruct
  TKeyEventStruct*{.final, pure.} = object 
    `type`*: Gint
    state*: Guint
    keyval*: Guint
    length*: Gint
    string*: Cstring
    keycode*: Guint16
    timestamp*: Guint32

  TKeySnoopFunc* = proc (event: PKeyEventStruct, func_data: Gpointer): Gint{.
      cdecl.}
  PKeyEventType* = ptr TKeyEventType
  TKeyEventType* = enum 
    KEY_EVENT_PRESS, KEY_EVENT_RELEASE, KEY_EVENT_LAST_DEFINED
  PUtil* = ptr TUtil
  TUtil* = object of TGObject
  PUtilClass* = ptr TUtilClass
  TUtilClass* = object of TGObjectClass
    add_global_event_listener*: proc (listener: TGSignalEmissionHook, 
                                      event_type: Cstring): Guint{.cdecl.}
    remove_global_event_listener*: proc (listener_id: Guint){.cdecl.}
    add_key_event_listener*: proc (listener: TKeySnoopFunc, data: Gpointer): Guint{.
        cdecl.}
    remove_key_event_listener*: proc (listener_id: Guint){.cdecl.}
    get_root*: proc (): PObject{.cdecl.}
    get_toolkit_name*: proc (): Cstring{.cdecl.}
    get_toolkit_version*: proc (): Cstring{.cdecl.}

  PValueIface* = ptr TValueIface
  TValueIface* = object of TGTypeInterface
    get_current_value*: proc (obj: PValue, value: PGValue){.cdecl.}
    get_maximum_value*: proc (obj: PValue, value: PGValue){.cdecl.}
    get_minimum_value*: proc (obj: PValue, value: PGValue){.cdecl.}
    set_current_value*: proc (obj: PValue, value: PGValue): Gboolean{.cdecl.}
    pad33*: TFunction
    pad34*: TFunction


proc roleRegister*(name: Cstring): TRole{.cdecl, dynlib: lib, 
    importc: "atk_role_register".}
proc objectGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "atk_object_get_type".}
proc typeObject*(): GType
proc `object`*(obj: Pointer): PObject
proc objectClass*(klass: Pointer): PObjectClass
proc isObject*(obj: Pointer): Bool
proc isObjectClass*(klass: Pointer): Bool
proc objectGetClass*(obj: Pointer): PObjectClass
proc typeImplementor*(): GType
proc isImplementor*(obj: Pointer): Bool
proc implementor*(obj: Pointer): PImplementor
proc implementorGetIface*(obj: Pointer): PImplementorIface
proc implementorGetType*(): GType{.cdecl, dynlib: lib, 
                                     importc: "atk_implementor_get_type".}
proc refAccessible*(implementor: PImplementor): PObject{.cdecl, 
    dynlib: lib, importc: "atk_implementor_ref_accessible".}
proc getName*(accessible: PObject): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_object_get_name".}
proc getDescription*(accessible: PObject): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_object_get_description".}
proc getParent*(accessible: PObject): PObject{.cdecl, dynlib: lib, 
    importc: "atk_object_get_parent".}
proc getNAccessibleChildren*(accessible: PObject): Gint{.cdecl, 
    dynlib: lib, importc: "atk_object_get_n_accessible_children".}
proc refAccessibleChild*(accessible: PObject, i: Gint): PObject{.cdecl, 
    dynlib: lib, importc: "atk_object_ref_accessible_child".}
proc refRelationSet*(accessible: PObject): PRelationSet{.cdecl, 
    dynlib: lib, importc: "atk_object_ref_relation_set".}
proc getRole*(accessible: PObject): TRole{.cdecl, dynlib: lib, 
    importc: "atk_object_get_role".}
proc getLayer*(accessible: PObject): TLayer{.cdecl, dynlib: lib, 
    importc: "atk_object_get_layer".}
proc getMdiZorder*(accessible: PObject): Gint{.cdecl, dynlib: lib, 
    importc: "atk_object_get_mdi_zorder".}
proc refStateSet*(accessible: PObject): PStateSet{.cdecl, dynlib: lib, 
    importc: "atk_object_ref_state_set".}
proc getIndexInParent*(accessible: PObject): Gint{.cdecl, dynlib: lib, 
    importc: "atk_object_get_index_in_parent".}
proc setName*(accessible: PObject, name: Cstring){.cdecl, dynlib: lib, 
    importc: "atk_object_set_name".}
proc setDescription*(accessible: PObject, description: Cstring){.cdecl, 
    dynlib: lib, importc: "atk_object_set_description".}
proc setParent*(accessible: PObject, parent: PObject){.cdecl, 
    dynlib: lib, importc: "atk_object_set_parent".}
proc setRole*(accessible: PObject, role: TRole){.cdecl, dynlib: lib, 
    importc: "atk_object_set_role".}
proc connectPropertyChangeHandler*(accessible: PObject, 
    handler: TPropertyChangeHandler): Guint{.cdecl, dynlib: lib, 
    importc: "atk_object_connect_property_change_handler".}
proc removePropertyChangeHandler*(accessible: PObject, 
    handler_id: Guint){.cdecl, dynlib: lib, 
                        importc: "atk_object_remove_property_change_handler".}
proc notifyStateChange*(accessible: PObject, state: TState, 
                                 value: Gboolean){.cdecl, dynlib: lib, 
    importc: "atk_object_notify_state_change".}
proc initialize*(accessible: PObject, data: Gpointer){.cdecl, 
    dynlib: lib, importc: "atk_object_initialize".}
proc roleGetName*(role: TRole): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_role_get_name".}
proc roleForName*(name: Cstring): TRole{.cdecl, dynlib: lib, 
    importc: "atk_role_for_name".}
proc typeAction*(): GType
proc isAction*(obj: Pointer): Bool
proc action*(obj: Pointer): PAction
proc actionGetIface*(obj: Pointer): PActionIface
proc actionGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "atk_action_get_type".}
proc doAction*(action: PAction, i: Gint): Gboolean{.cdecl, dynlib: lib, 
    importc: "atk_action_do_action".}
proc getNActions*(action: PAction): Gint{.cdecl, dynlib: lib, 
    importc: "atk_action_get_n_actions".}
proc getDescription*(action: PAction, i: Gint): Cstring{.cdecl, 
    dynlib: lib, importc: "atk_action_get_description".}
proc getName*(action: PAction, i: Gint): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_action_get_name".}
proc getKeybinding*(action: PAction, i: Gint): Cstring{.cdecl, 
    dynlib: lib, importc: "atk_action_get_keybinding".}
proc setDescription*(action: PAction, i: Gint, desc: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_action_set_description".}
proc typeComponent*(): GType
proc isComponent*(obj: Pointer): Bool
proc component*(obj: Pointer): PComponent
proc componentGetIface*(obj: Pointer): PComponentIface
proc componentGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "atk_component_get_type".}
proc addFocusHandler*(component: PComponent, handler: TFocusHandler): Guint{.
    cdecl, dynlib: lib, importc: "atk_component_add_focus_handler".}
proc contains*(component: PComponent, x, y: Gint, 
                         coord_type: TCoordType): Gboolean{.cdecl, dynlib: lib, 
    importc: "atk_component_contains".}
proc refAccessibleAtPoint*(component: PComponent, x, y: Gint, 
                                        coord_type: TCoordType): PObject{.cdecl, 
    dynlib: lib, importc: "atk_component_ref_accessible_at_point".}
proc getExtents*(component: PComponent, x, y, width, height: Pgint, 
                            coord_type: TCoordType){.cdecl, dynlib: lib, 
    importc: "atk_component_get_extents".}
proc getPosition*(component: PComponent, x: Pgint, y: Pgint, 
                             coord_type: TCoordType){.cdecl, dynlib: lib, 
    importc: "atk_component_get_position".}
proc getSize*(component: PComponent, width: Pgint, height: Pgint){.
    cdecl, dynlib: lib, importc: "atk_component_get_size".}
proc getLayer*(component: PComponent): TLayer{.cdecl, dynlib: lib, 
    importc: "atk_component_get_layer".}
proc getMdiZorder*(component: PComponent): Gint{.cdecl, dynlib: lib, 
    importc: "atk_component_get_mdi_zorder".}
proc grabFocus*(component: PComponent): Gboolean{.cdecl, dynlib: lib, 
    importc: "atk_component_grab_focus".}
proc removeFocusHandler*(component: PComponent, handler_id: Guint){.
    cdecl, dynlib: lib, importc: "atk_component_remove_focus_handler".}
proc setExtents*(component: PComponent, x: Gint, y: Gint, 
                            width: Gint, height: Gint, coord_type: TCoordType): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_component_set_extents".}
proc setPosition*(component: PComponent, x: Gint, y: Gint, 
                             coord_type: TCoordType): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_component_set_position".}
proc setSize*(component: PComponent, width: Gint, height: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_component_set_size".}
proc typeDocument*(): GType
proc isDocument*(obj: Pointer): Bool
proc document*(obj: Pointer): PDocument
proc documentGetIface*(obj: Pointer): PDocumentIface
proc documentGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "atk_document_get_type".}
proc getDocumentType*(document: PDocument): Cstring{.cdecl, 
    dynlib: lib, importc: "atk_document_get_document_type".}
proc getDocument*(document: PDocument): Gpointer{.cdecl, dynlib: lib, 
    importc: "atk_document_get_document".}
proc typeEditableText*(): GType
proc isEditableText*(obj: Pointer): Bool
proc editableText*(obj: Pointer): PEditableText
proc editableTextGetIface*(obj: Pointer): PEditableTextIface
proc editableTextGetType*(): GType{.cdecl, dynlib: lib, 
                                       importc: "atk_editable_text_get_type".}
proc setRunAttributes*(text: PEditableText, 
                                       attrib_set: PAttributeSet, 
                                       start_offset: Gint, end_offset: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_editable_text_set_run_attributes".}
proc setTextContents*(text: PEditableText, string: Cstring){.
    cdecl, dynlib: lib, importc: "atk_editable_text_set_text_contents".}
proc insertText*(text: PEditableText, `string`: Cstring, 
                                length: Gint, position: Pgint){.cdecl, 
    dynlib: lib, importc: "atk_editable_text_insert_text".}
proc copyText*(text: PEditableText, start_pos: Gint, 
                              end_pos: Gint){.cdecl, dynlib: lib, 
    importc: "atk_editable_text_copy_text".}
proc cutText*(text: PEditableText, start_pos: Gint, end_pos: Gint){.
    cdecl, dynlib: lib, importc: "atk_editable_text_cut_text".}
proc deleteText*(text: PEditableText, start_pos: Gint, 
                                end_pos: Gint){.cdecl, dynlib: lib, 
    importc: "atk_editable_text_delete_text".}
proc pasteText*(text: PEditableText, position: Gint){.cdecl, 
    dynlib: lib, importc: "atk_editable_text_paste_text".}
proc typeGobjectAccessible*(): GType
proc gobjectAccessible*(obj: Pointer): PGObjectAccessible
proc gobjectAccessibleClass*(klass: Pointer): PGObjectAccessibleClass
proc isGobjectAccessible*(obj: Pointer): Bool
proc isGobjectAccessibleClass*(klass: Pointer): Bool
proc gobjectAccessibleGetClass*(obj: Pointer): PGObjectAccessibleClass
proc gobjectAccessibleGetType*(): GType{.cdecl, dynlib: lib, 
    importc: "atk_gobject_accessible_get_type".}
proc accessibleForObject*(obj: PGObject): PObject{.cdecl, dynlib: lib, 
    importc: "atk_gobject_accessible_for_object".}
proc getObject*(obj: PGObjectAccessible): PGObject{.cdecl, 
    dynlib: lib, importc: "atk_gobject_accessible_get_object".}
proc typeHyperlink*(): GType
proc hyperlink*(obj: Pointer): PHyperlink
proc hyperlinkClass*(klass: Pointer): PHyperlinkClass
proc isHyperlink*(obj: Pointer): Bool
proc isHyperlinkClass*(klass: Pointer): Bool
proc hyperlinkGetClass*(obj: Pointer): PHyperlinkClass
proc hyperlinkGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "atk_hyperlink_get_type".}
proc getUri*(link: PHyperlink, i: Gint): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_hyperlink_get_uri".}
proc getObject*(link: PHyperlink, i: Gint): PObject{.cdecl, 
    dynlib: lib, importc: "atk_hyperlink_get_object".}
proc getEndIndex*(link: PHyperlink): Gint{.cdecl, dynlib: lib, 
    importc: "atk_hyperlink_get_end_index".}
proc getStartIndex*(link: PHyperlink): Gint{.cdecl, dynlib: lib, 
    importc: "atk_hyperlink_get_start_index".}
proc isValid*(link: PHyperlink): Gboolean{.cdecl, dynlib: lib, 
    importc: "atk_hyperlink_is_valid".}
proc getNAnchors*(link: PHyperlink): Gint{.cdecl, dynlib: lib, 
    importc: "atk_hyperlink_get_n_anchors".}
proc typeHypertext*(): GType
proc isHypertext*(obj: Pointer): Bool
proc hypertext*(obj: Pointer): PHypertext
proc hypertextGetIface*(obj: Pointer): PHypertextIface
proc hypertextGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "atk_hypertext_get_type".}
proc getLink*(hypertext: PHypertext, link_index: Gint): PHyperlink{.
    cdecl, dynlib: lib, importc: "atk_hypertext_get_link".}
proc getNLinks*(hypertext: PHypertext): Gint{.cdecl, dynlib: lib, 
    importc: "atk_hypertext_get_n_links".}
proc getLinkIndex*(hypertext: PHypertext, char_index: Gint): Gint{.
    cdecl, dynlib: lib, importc: "atk_hypertext_get_link_index".}
proc typeImage*(): GType
proc isImage*(obj: Pointer): Bool
proc image*(obj: Pointer): PImage
proc imageGetIface*(obj: Pointer): PImageIface
proc imageGetType*(): GType{.cdecl, dynlib: lib, importc: "atk_image_get_type".}
proc getImageDescription*(image: PImage): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_image_get_image_description".}
proc getImageSize*(image: PImage, width: Pgint, height: Pgint){.cdecl, 
    dynlib: lib, importc: "atk_image_get_image_size".}
proc setImageDescription*(image: PImage, description: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_image_set_image_description".}
proc getImagePosition*(image: PImage, x: Pgint, y: Pgint, 
                               coord_type: TCoordType){.cdecl, dynlib: lib, 
    importc: "atk_image_get_image_position".}
proc typeObjectFactory*(): GType
proc objectFactory*(obj: Pointer): PObjectFactory
proc objectFactoryClass*(klass: Pointer): PObjectFactoryClass
proc isObjectFactory*(obj: Pointer): Bool
proc isObjectFactoryClass*(klass: Pointer): Bool
proc objectFactoryGetClass*(obj: Pointer): PObjectFactoryClass
proc objectFactoryGetType*(): GType{.cdecl, dynlib: lib, 
                                        importc: "atk_object_factory_get_type".}
proc createAccessible*(factory: PObjectFactory, obj: PGObject): PObject{.
    cdecl, dynlib: lib, importc: "atk_object_factory_create_accessible".}
proc invalidate*(factory: PObjectFactory){.cdecl, dynlib: lib, 
    importc: "atk_object_factory_invalidate".}
proc getAccessibleType*(factory: PObjectFactory): GType{.cdecl, 
    dynlib: lib, importc: "atk_object_factory_get_accessible_type".}
proc typeRegistry*(): GType
proc registry*(obj: Pointer): PRegistry
proc registryClass*(klass: Pointer): PRegistryClass
proc isRegistry*(obj: Pointer): Bool
proc isRegistryClass*(klass: Pointer): Bool
proc registryGetClass*(obj: Pointer): PRegistryClass
proc registryGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "atk_registry_get_type".}
proc setFactoryType*(registry: PRegistry, `type`: GType, 
                                factory_type: GType){.cdecl, dynlib: lib, 
    importc: "atk_registry_set_factory_type".}
proc getFactoryType*(registry: PRegistry, `type`: GType): GType{.
    cdecl, dynlib: lib, importc: "atk_registry_get_factory_type".}
proc getFactory*(registry: PRegistry, `type`: GType): PObjectFactory{.
    cdecl, dynlib: lib, importc: "atk_registry_get_factory".}
proc getDefaultRegistry*(): PRegistry{.cdecl, dynlib: lib, 
    importc: "atk_get_default_registry".}
proc typeRelation*(): GType
proc relation*(obj: Pointer): PRelation
proc relationClass*(klass: Pointer): PRelationClass
proc isRelation*(obj: Pointer): Bool
proc isRelationClass*(klass: Pointer): Bool
proc relationGetClass*(obj: Pointer): PRelationClass
proc relationGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "atk_relation_get_type".}
proc relationTypeRegister*(name: Cstring): TRelationType{.cdecl, dynlib: lib, 
    importc: "atk_relation_type_register".}
proc relationTypeGetName*(`type`: TRelationType): Cstring{.cdecl, 
    dynlib: lib, importc: "atk_relation_type_get_name".}
proc relationTypeForName*(name: Cstring): TRelationType{.cdecl, dynlib: lib, 
    importc: "atk_relation_type_for_name".}
proc relationNew*(targets: PPAtkObject, n_targets: Gint, 
                   relationship: TRelationType): PRelation{.cdecl, dynlib: lib, 
    importc: "atk_relation_new".}
proc getRelationType*(relation: PRelation): TRelationType{.cdecl, 
    dynlib: lib, importc: "atk_relation_get_relation_type".}
proc getTarget*(relation: PRelation): PGPtrArray{.cdecl, dynlib: lib, 
    importc: "atk_relation_get_target".}
proc typeRelationSet*(): GType
proc relationSet*(obj: Pointer): PRelationSet
proc relationSetClass*(klass: Pointer): PRelationSetClass
proc isRelationSet*(obj: Pointer): Bool
proc isRelationSetClass*(klass: Pointer): Bool
proc relationSetGetClass*(obj: Pointer): PRelationSetClass
proc relationSetGetType*(): GType{.cdecl, dynlib: lib, 
                                      importc: "atk_relation_set_get_type".}
proc relationSetNew*(): PRelationSet{.cdecl, dynlib: lib, 
                                        importc: "atk_relation_set_new".}
proc contains*(RelationSet: PRelationSet, 
                            relationship: TRelationType): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_relation_set_contains".}
proc remove*(RelationSet: PRelationSet, relation: PRelation){.
    cdecl, dynlib: lib, importc: "atk_relation_set_remove".}
proc add*(RelationSet: PRelationSet, relation: PRelation){.cdecl, 
    dynlib: lib, importc: "atk_relation_set_add".}
proc getNRelations*(RelationSet: PRelationSet): Gint{.cdecl, 
    dynlib: lib, importc: "atk_relation_set_get_n_relations".}
proc getRelation*(RelationSet: PRelationSet, i: Gint): PRelation{.
    cdecl, dynlib: lib, importc: "atk_relation_set_get_relation".}
proc getRelationByType*(RelationSet: PRelationSet, 
                                        relationship: TRelationType): PRelation{.
    cdecl, dynlib: lib, importc: "atk_relation_set_get_relation_by_type".}
proc typeSelection*(): GType
proc isSelection*(obj: Pointer): Bool
proc selection*(obj: Pointer): PSelection
proc selectionGetIface*(obj: Pointer): PSelectionIface
proc selectionGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "atk_selection_get_type".}
proc addSelection*(selection: PSelection, i: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_selection_add_selection".}
proc clearSelection*(selection: PSelection): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_selection_clear_selection".}
proc refSelection*(selection: PSelection, i: Gint): PObject{.cdecl, 
    dynlib: lib, importc: "atk_selection_ref_selection".}
proc getSelectionCount*(selection: PSelection): Gint{.cdecl, 
    dynlib: lib, importc: "atk_selection_get_selection_count".}
proc isChildSelected*(selection: PSelection, i: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_selection_is_child_selected".}
proc removeSelection*(selection: PSelection, i: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_selection_remove_selection".}
proc selectAllSelection*(selection: PSelection): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_selection_select_all_selection".}
proc stateTypeRegister*(name: Cstring): TStateType{.cdecl, dynlib: lib, 
    importc: "atk_state_type_register".}
proc stateTypeGetName*(`type`: TStateType): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_state_type_get_name".}
proc stateTypeForName*(name: Cstring): TStateType{.cdecl, dynlib: lib, 
    importc: "atk_state_type_for_name".}
proc typeStateSet*(): GType
proc stateSet*(obj: Pointer): PStateSet
proc stateSetClass*(klass: Pointer): PStateSetClass
proc isStateSet*(obj: Pointer): Bool
proc isStateSetClass*(klass: Pointer): Bool
proc stateSetGetClass*(obj: Pointer): PStateSetClass
proc stateSetGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "atk_state_set_get_type".}
proc stateSetNew*(): PStateSet{.cdecl, dynlib: lib, 
                                  importc: "atk_state_set_new".}
proc isEmpty*(StateSet: PStateSet): Gboolean{.cdecl, dynlib: lib, 
    importc: "atk_state_set_is_empty".}
proc addState*(StateSet: PStateSet, `type`: TStateType): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_state_set_add_state".}
proc addStates*(StateSet: PStateSet, types: PStateType, n_types: Gint){.
    cdecl, dynlib: lib, importc: "atk_state_set_add_states".}
proc clearStates*(StateSet: PStateSet){.cdecl, dynlib: lib, 
    importc: "atk_state_set_clear_states".}
proc containsState*(StateSet: PStateSet, `type`: TStateType): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_state_set_contains_state".}
proc containsStates*(StateSet: PStateSet, types: PStateType, 
                                n_types: Gint): Gboolean{.cdecl, dynlib: lib, 
    importc: "atk_state_set_contains_states".}
proc removeState*(StateSet: PStateSet, `type`: TStateType): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_state_set_remove_state".}
proc andSets*(StateSet: PStateSet, compare_set: PStateSet): PStateSet{.
    cdecl, dynlib: lib, importc: "atk_state_set_and_sets".}
proc orSets*(StateSet: PStateSet, compare_set: PStateSet): PStateSet{.
    cdecl, dynlib: lib, importc: "atk_state_set_or_sets".}
proc xorSets*(StateSet: PStateSet, compare_set: PStateSet): PStateSet{.
    cdecl, dynlib: lib, importc: "atk_state_set_xor_sets".}
proc typeStreamableContent*(): GType
proc isStreamableContent*(obj: Pointer): Bool
proc streamableContent*(obj: Pointer): PStreamableContent
proc streamableContentGetIface*(obj: Pointer): PStreamableContentIface
proc streamableContentGetType*(): GType{.cdecl, dynlib: lib, 
    importc: "atk_streamable_content_get_type".}
proc getNMimeTypes*(streamable: PStreamableContent): Gint{.
    cdecl, dynlib: lib, importc: "atk_streamable_content_get_n_mime_types".}
proc getMimeType*(streamable: PStreamableContent, i: Gint): Cstring{.
    cdecl, dynlib: lib, importc: "atk_streamable_content_get_mime_type".}
proc getStream*(streamable: PStreamableContent, 
                                    mime_type: Cstring): PGIOChannel{.cdecl, 
    dynlib: lib, importc: "atk_streamable_content_get_stream".}
proc typeTable*(): GType
proc isTable*(obj: Pointer): Bool
proc table*(obj: Pointer): PTable
proc tableGetIface*(obj: Pointer): PTableIface
proc tableGetType*(): GType{.cdecl, dynlib: lib, importc: "atk_table_get_type".}
proc refAt*(table: PTable, row, column: Gint): PObject{.cdecl, 
    dynlib: lib, importc: "atk_table_ref_at".}
proc getIndexAt*(table: PTable, row, column: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "atk_table_get_index_at".}
proc getColumnAtIndex*(table: PTable, index: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "atk_table_get_column_at_index".}
proc getRowAtIndex*(table: PTable, index: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "atk_table_get_row_at_index".}
proc getNColumns*(table: PTable): Gint{.cdecl, dynlib: lib, 
    importc: "atk_table_get_n_columns".}
proc getNRows*(table: PTable): Gint{.cdecl, dynlib: lib, 
    importc: "atk_table_get_n_rows".}
proc getColumnExtentAt*(table: PTable, row: Gint, column: Gint): Gint{.
    cdecl, dynlib: lib, importc: "atk_table_get_column_extent_at".}
proc getRowExtentAt*(table: PTable, row: Gint, column: Gint): Gint{.
    cdecl, dynlib: lib, importc: "atk_table_get_row_extent_at".}
proc getCaption*(table: PTable): PObject{.cdecl, dynlib: lib, 
    importc: "atk_table_get_caption".}
proc getColumnDescription*(table: PTable, column: Gint): Cstring{.cdecl, 
    dynlib: lib, importc: "atk_table_get_column_description".}
proc getColumnHeader*(table: PTable, column: Gint): PObject{.cdecl, 
    dynlib: lib, importc: "atk_table_get_column_header".}
proc getRowDescription*(table: PTable, row: Gint): Cstring{.cdecl, 
    dynlib: lib, importc: "atk_table_get_row_description".}
proc getRowHeader*(table: PTable, row: Gint): PObject{.cdecl, 
    dynlib: lib, importc: "atk_table_get_row_header".}
proc getSummary*(table: PTable): PObject{.cdecl, dynlib: lib, 
    importc: "atk_table_get_summary".}
proc setCaption*(table: PTable, caption: PObject){.cdecl, dynlib: lib, 
    importc: "atk_table_set_caption".}
proc setColumnDescription*(table: PTable, column: Gint, 
                                   description: Cstring){.cdecl, dynlib: lib, 
    importc: "atk_table_set_column_description".}
proc setColumnHeader*(table: PTable, column: Gint, header: PObject){.
    cdecl, dynlib: lib, importc: "atk_table_set_column_header".}
proc setRowDescription*(table: PTable, row: Gint, description: Cstring){.
    cdecl, dynlib: lib, importc: "atk_table_set_row_description".}
proc setRowHeader*(table: PTable, row: Gint, header: PObject){.cdecl, 
    dynlib: lib, importc: "atk_table_set_row_header".}
proc setSummary*(table: PTable, accessible: PObject){.cdecl, dynlib: lib, 
    importc: "atk_table_set_summary".}
proc getSelectedColumns*(table: PTable, selected: PPgint): Gint{.cdecl, 
    dynlib: lib, importc: "atk_table_get_selected_columns".}
proc getSelectedRows*(table: PTable, selected: PPgint): Gint{.cdecl, 
    dynlib: lib, importc: "atk_table_get_selected_rows".}
proc isColumnSelected*(table: PTable, column: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_table_is_column_selected".}
proc isRowSelected*(table: PTable, row: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_table_is_row_selected".}
proc isSelected*(table: PTable, row: Gint, column: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_table_is_selected".}
proc addRowSelection*(table: PTable, row: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_table_add_row_selection".}
proc removeRowSelection*(table: PTable, row: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_table_remove_row_selection".}
proc addColumnSelection*(table: PTable, column: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_table_add_column_selection".}
proc removeColumnSelection*(table: PTable, column: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_table_remove_column_selection".}
proc textAttributeRegister*(name: Cstring): TTextAttribute{.cdecl, 
    dynlib: lib, importc: "atk_text_attribute_register".}
proc typeText*(): GType
proc isText*(obj: Pointer): Bool
proc text*(obj: Pointer): PText
proc textGetIface*(obj: Pointer): PTextIface
proc textGetType*(): GType{.cdecl, dynlib: lib, importc: "atk_text_get_type".}
proc getText*(text: PText, start_offset: Gint, end_offset: Gint): Cstring{.
    cdecl, dynlib: lib, importc: "atk_text_get_text".}
proc getCharacterAtOffset*(text: PText, offset: Gint): Gunichar{.cdecl, 
    dynlib: lib, importc: "atk_text_get_character_at_offset".}
proc getTextAfterOffset*(text: PText, offset: Gint, 
                                 boundary_type: TTextBoundary, 
                                 start_offset: Pgint, end_offset: Pgint): Cstring{.
    cdecl, dynlib: lib, importc: "atk_text_get_text_after_offset".}
proc getTextAtOffset*(text: PText, offset: Gint, 
                              boundary_type: TTextBoundary, start_offset: Pgint, 
                              end_offset: Pgint): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_text_get_text_at_offset".}
proc getTextBeforeOffset*(text: PText, offset: Gint, 
                                  boundary_type: TTextBoundary, 
                                  start_offset: Pgint, end_offset: Pgint): Cstring{.
    cdecl, dynlib: lib, importc: "atk_text_get_text_before_offset".}
proc getCaretOffset*(text: PText): Gint{.cdecl, dynlib: lib, 
    importc: "atk_text_get_caret_offset".}
proc getCharacterExtents*(text: PText, offset: Gint, x: Pgint, y: Pgint, 
                                 width: Pgint, height: Pgint, coords: TCoordType){.
    cdecl, dynlib: lib, importc: "atk_text_get_character_extents".}
proc getRunAttributes*(text: PText, offset: Gint, start_offset: Pgint, 
                              end_offset: Pgint): PAttributeSet{.cdecl, 
    dynlib: lib, importc: "atk_text_get_run_attributes".}
proc getDefaultAttributes*(text: PText): PAttributeSet{.cdecl, 
    dynlib: lib, importc: "atk_text_get_default_attributes".}
proc getCharacterCount*(text: PText): Gint{.cdecl, dynlib: lib, 
    importc: "atk_text_get_character_count".}
proc getOffsetAtPoint*(text: PText, x: Gint, y: Gint, coords: TCoordType): Gint{.
    cdecl, dynlib: lib, importc: "atk_text_get_offset_at_point".}
proc getNSelections*(text: PText): Gint{.cdecl, dynlib: lib, 
    importc: "atk_text_get_n_selections".}
proc getSelection*(text: PText, selection_num: Gint, start_offset: Pgint, 
                         end_offset: Pgint): Cstring{.cdecl, dynlib: lib, 
    importc: "atk_text_get_selection".}
proc addSelection*(text: PText, start_offset: Gint, end_offset: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "atk_text_add_selection".}
proc removeSelection*(text: PText, selection_num: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_text_remove_selection".}
proc setSelection*(text: PText, selection_num: Gint, start_offset: Gint, 
                         end_offset: Gint): Gboolean{.cdecl, dynlib: lib, 
    importc: "atk_text_set_selection".}
proc setCaretOffset*(text: PText, offset: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_text_set_caret_offset".}
proc free*(attrib_set: PAttributeSet){.cdecl, dynlib: lib, 
    importc: "atk_attribute_set_free".}
proc textAttributeGetName*(attr: TTextAttribute): Cstring{.cdecl, 
    dynlib: lib, importc: "atk_text_attribute_get_name".}
proc textAttributeForName*(name: Cstring): TTextAttribute{.cdecl, 
    dynlib: lib, importc: "atk_text_attribute_for_name".}
proc textAttributeGetValue*(attr: TTextAttribute, index: Gint): Cstring{.
    cdecl, dynlib: lib, importc: "atk_text_attribute_get_value".}
proc typeUtil*(): GType
proc isUtil*(obj: Pointer): Bool
proc util*(obj: Pointer): PUtil
proc utilClass*(klass: Pointer): PUtilClass
proc isUtilClass*(klass: Pointer): Bool
proc utilGetClass*(obj: Pointer): PUtilClass
proc utilGetType*(): GType{.cdecl, dynlib: lib, importc: "atk_util_get_type".}
proc addFocusTracker*(focus_tracker: TEventListener): Guint{.cdecl, 
    dynlib: lib, importc: "atk_add_focus_tracker".}
proc removeFocusTracker*(tracker_id: Guint){.cdecl, dynlib: lib, 
    importc: "atk_remove_focus_tracker".}
proc focusTrackerInit*(add_function: TEventListenerInit){.cdecl, dynlib: lib, 
    importc: "atk_focus_tracker_init".}
proc focusTrackerNotify*(anObject: PObject){.cdecl, dynlib: lib, 
    importc: "atk_focus_tracker_notify".}
proc addGlobalEventListener*(listener: TGSignalEmissionHook, 
                                event_type: Cstring): Guint{.cdecl, dynlib: lib, 
    importc: "atk_add_global_event_listener".}
proc removeGlobalEventListener*(listener_id: Guint){.cdecl, dynlib: lib, 
    importc: "atk_remove_global_event_listener".}
proc addKeyEventListener*(listener: TKeySnoopFunc, data: Gpointer): Guint{.
    cdecl, dynlib: lib, importc: "atk_add_key_event_listener".}
proc removeKeyEventListener*(listener_id: Guint){.cdecl, dynlib: lib, 
    importc: "atk_remove_key_event_listener".}
proc getRoot*(): PObject{.cdecl, dynlib: lib, importc: "atk_get_root".}
proc getToolkitName*(): Cstring{.cdecl, dynlib: lib, 
                                   importc: "atk_get_toolkit_name".}
proc getToolkitVersion*(): Cstring{.cdecl, dynlib: lib, 
                                      importc: "atk_get_toolkit_version".}
proc typeValue*(): GType
proc isValue*(obj: Pointer): Bool
proc value*(obj: Pointer): PValue
proc valueGetIface*(obj: Pointer): PValueIface
proc valueGetType*(): GType{.cdecl, dynlib: lib, importc: "atk_value_get_type".}
proc getCurrentValue*(obj: PValue, value: PGValue){.cdecl, dynlib: lib, 
    importc: "atk_value_get_current_value".}
proc getMaximumValue*(obj: PValue, value: PGValue){.cdecl, dynlib: lib, 
    importc: "atk_value_get_maximum_value".}
proc getMinimumValue*(obj: PValue, value: PGValue){.cdecl, dynlib: lib, 
    importc: "atk_value_get_minimum_value".}
proc setCurrentValue*(obj: PValue, value: PGValue): Gboolean{.cdecl, 
    dynlib: lib, importc: "atk_value_set_current_value".}
proc typeObject*(): GType = 
  result = objectGetType()

proc `object`*(obj: pointer): PObject = 
  result = cast[PObject](gTypeCheckInstanceCast(obj, typeObject()))

proc objectClass*(klass: pointer): PObjectClass = 
  result = cast[PObjectClass](gTypeCheckClassCast(klass, typeObject()))

proc isObject*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeObject())

proc isObjectClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeObject())

proc objectGetClass*(obj: pointer): PObjectClass = 
  result = cast[PObjectClass](gTypeInstanceGetClass(obj, typeObject()))

proc typeImplementor*(): GType = 
  result = implementorGetType()

proc isImplementor*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeImplementor())

proc implementor*(obj: pointer): PImplementor = 
  result = PImplementor(gTypeCheckInstanceCast(obj, typeImplementor()))

proc implementorGetIface*(obj: pointer): PImplementorIface = 
  result = cast[PImplementorIface](gTypeInstanceGetInterface(obj, 
      typeImplementor()))

proc typeAction*(): GType = 
  result = actionGetType()

proc isAction*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeAction())

proc action*(obj: pointer): PAction = 
  result = PAction(gTypeCheckInstanceCast(obj, typeAction()))

proc actionGetIface*(obj: pointer): PActionIface = 
  result = cast[PActionIface](gTypeInstanceGetInterface(obj, typeAction()))

proc typeComponent*(): GType = 
  result = componentGetType()

proc isComponent*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeComponent())

proc component*(obj: pointer): PComponent = 
  result = PComponent(gTypeCheckInstanceCast(obj, typeComponent()))

proc componentGetIface*(obj: pointer): PComponentIface = 
  result = cast[PComponentIface](gTypeInstanceGetInterface(obj, 
      typeComponent()))

proc typeDocument*(): GType = 
  result = documentGetType()

proc isDocument*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeDocument())

proc document*(obj: pointer): PDocument = 
  result = cast[PDocument](gTypeCheckInstanceCast(obj, typeDocument()))

proc documentGetIface*(obj: pointer): PDocumentIface = 
  result = cast[PDocumentIface](gTypeInstanceGetInterface(obj, 
      typeDocument()))

proc typeEditableText*(): GType = 
  result = editableTextGetType()

proc isEditableText*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeEditableText())

proc editableText*(obj: pointer): PEditableText = 
  result = cast[PEditableText](gTypeCheckInstanceCast(obj, 
      typeEditableText()))

proc editableTextGetIface*(obj: pointer): PEditableTextIface = 
  result = cast[PEditableTextIface](gTypeInstanceGetInterface(obj, 
      typeEditableText()))

proc typeGobjectAccessible*(): GType = 
  result = gobjectAccessibleGetType()

proc gobjectAccessible*(obj: pointer): PGObjectAccessible = 
  result = cast[PGObjectAccessible](gTypeCheckInstanceCast(obj, 
      typeGobjectAccessible()))

proc gobjectAccessibleClass*(klass: pointer): PGObjectAccessibleClass = 
  result = cast[PGObjectAccessibleClass](gTypeCheckClassCast(klass, 
      typeGobjectAccessible()))

proc isGobjectAccessible*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeGobjectAccessible())

proc isGobjectAccessibleClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeGobjectAccessible())

proc gobjectAccessibleGetClass*(obj: pointer): PGObjectAccessibleClass = 
  result = cast[PGObjectAccessibleClass](gTypeInstanceGetClass(obj, 
      typeGobjectAccessible()))

proc typeHyperlink*(): GType = 
  result = hyperlinkGetType()

proc hyperlink*(obj: pointer): PHyperlink = 
  result = cast[PHyperlink](gTypeCheckInstanceCast(obj, typeHyperlink()))

proc hyperlinkClass*(klass: pointer): PHyperlinkClass = 
  result = cast[PHyperlinkClass](gTypeCheckClassCast(klass, typeHyperlink()))

proc isHyperlink*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeHyperlink())

proc isHyperlinkClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeHyperlink())

proc hyperlinkGetClass*(obj: pointer): PHyperlinkClass = 
  result = cast[PHyperlinkClass](gTypeInstanceGetClass(obj, typeHyperlink()))

proc typeHypertext*(): GType = 
  result = hypertextGetType()

proc isHypertext*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeHypertext())

proc hypertext*(obj: pointer): PHypertext = 
  result = cast[PHypertext](gTypeCheckInstanceCast(obj, typeHypertext()))

proc hypertextGetIface*(obj: pointer): PHypertextIface = 
  result = cast[PHypertextIface](gTypeInstanceGetInterface(obj, 
      typeHypertext()))

proc typeImage*(): GType = 
  result = imageGetType()

proc isImage*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeImage())

proc image*(obj: pointer): PImage = 
  result = cast[PImage](gTypeCheckInstanceCast(obj, typeImage()))

proc imageGetIface*(obj: pointer): PImageIface = 
  result = cast[PImageIface](gTypeInstanceGetInterface(obj, typeImage()))

proc typeObjectFactory*(): GType = 
  result = objectFactoryGetType()

proc objectFactory*(obj: pointer): PObjectFactory = 
  result = cast[PObjectFactory](gTypeCheckInstanceCast(obj, 
      typeObjectFactory()))

proc objectFactoryClass*(klass: pointer): PObjectFactoryClass = 
  result = cast[PObjectFactoryClass](gTypeCheckClassCast(klass, 
      typeObjectFactory()))

proc isObjectFactory*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeObjectFactory())

proc isObjectFactoryClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeObjectFactory())

proc objectFactoryGetClass*(obj: pointer): PObjectFactoryClass = 
  result = cast[PObjectFactoryClass](gTypeInstanceGetClass(obj, 
      typeObjectFactory()))

proc typeRegistry*(): GType = 
  result = registryGetType()

proc registry*(obj: pointer): PRegistry = 
  result = cast[PRegistry](gTypeCheckInstanceCast(obj, typeRegistry()))

proc registryClass*(klass: pointer): PRegistryClass = 
  result = cast[PRegistryClass](gTypeCheckClassCast(klass, typeRegistry()))

proc isRegistry*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeRegistry())

proc isRegistryClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeRegistry())

proc registryGetClass*(obj: pointer): PRegistryClass = 
  result = cast[PRegistryClass](gTypeInstanceGetClass(obj, typeRegistry()))

proc typeRelation*(): GType = 
  result = relationGetType()

proc relation*(obj: pointer): PRelation = 
  result = cast[PRelation](gTypeCheckInstanceCast(obj, typeRelation()))

proc relationClass*(klass: pointer): PRelationClass = 
  result = cast[PRelationClass](gTypeCheckClassCast(klass, typeRelation()))

proc isRelation*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeRelation())

proc isRelationClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeRelation())

proc relationGetClass*(obj: pointer): PRelationClass = 
  result = cast[PRelationClass](gTypeInstanceGetClass(obj, typeRelation()))

proc typeRelationSet*(): GType = 
  result = relationSetGetType()

proc relationSet*(obj: pointer): PRelationSet = 
  result = cast[PRelationSet](gTypeCheckInstanceCast(obj, 
      typeRelationSet()))

proc relationSetClass*(klass: pointer): PRelationSetClass = 
  result = cast[PRelationSetClass](gTypeCheckClassCast(klass, 
      typeRelationSet()))

proc isRelationSet*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeRelationSet())

proc isRelationSetClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeRelationSet())

proc relationSetGetClass*(obj: pointer): PRelationSetClass = 
  result = cast[PRelationSetClass](gTypeInstanceGetClass(obj, 
      typeRelationSet()))

proc typeSelection*(): GType = 
  result = selectionGetType()

proc isSelection*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeSelection())

proc selection*(obj: pointer): PSelection = 
  result = cast[PSelection](gTypeCheckInstanceCast(obj, typeSelection()))

proc selectionGetIface*(obj: pointer): PSelectionIface = 
  result = cast[PSelectionIface](gTypeInstanceGetInterface(obj, 
      typeSelection()))

proc typeStateSet*(): GType = 
  result = stateSetGetType()

proc stateSet*(obj: pointer): PStateSet = 
  result = cast[PStateSet](gTypeCheckInstanceCast(obj, typeStateSet()))

proc stateSetClass*(klass: pointer): PStateSetClass = 
  result = cast[PStateSetClass](gTypeCheckClassCast(klass, typeStateSet()))

proc isStateSet*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeStateSet())

proc isStateSetClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeStateSet())

proc stateSetGetClass*(obj: pointer): PStateSetClass = 
  result = cast[PStateSetClass](gTypeInstanceGetClass(obj, typeStateSet()))

proc typeStreamableContent*(): GType = 
  result = streamableContentGetType()

proc isStreamableContent*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeStreamableContent())

proc streamableContent*(obj: pointer): PStreamableContent = 
  result = cast[PStreamableContent](gTypeCheckInstanceCast(obj, 
      typeStreamableContent()))

proc streamableContentGetIface*(obj: pointer): PStreamableContentIface = 
  result = cast[PStreamableContentIface](gTypeInstanceGetInterface(obj, 
      typeStreamableContent()))

proc typeTable*(): GType = 
  result = tableGetType()

proc isTable*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTable())

proc table*(obj: pointer): PTable = 
  result = cast[PTable](gTypeCheckInstanceCast(obj, typeTable()))

proc tableGetIface*(obj: pointer): PTableIface = 
  result = cast[PTableIface](gTypeInstanceGetInterface(obj, typeTable()))

proc typeText*(): GType = 
  result = textGetType()

proc isText*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeText())

proc text*(obj: pointer): PText = 
  result = cast[PText](gTypeCheckInstanceCast(obj, typeText()))

proc textGetIface*(obj: pointer): PTextIface = 
  result = cast[PTextIface](gTypeInstanceGetInterface(obj, typeText()))

proc typeUtil*(): GType = 
  result = utilGetType()

proc isUtil*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeUtil())

proc util*(obj: pointer): PUtil = 
  result = cast[PUtil](gTypeCheckInstanceCast(obj, typeUtil()))

proc utilClass*(klass: pointer): PUtilClass = 
  result = cast[PUtilClass](gTypeCheckClassCast(klass, typeUtil()))

proc isUtilClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeUtil())

proc utilGetClass*(obj: pointer): PUtilClass = 
  result = cast[PUtilClass](gTypeInstanceGetClass(obj, typeUtil()))

proc typeValue*(): GType = 
  result = valueGetType()

proc isValue*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeValue())

proc value*(obj: pointer): PValue = 
  result = cast[PValue](gTypeCheckInstanceCast(obj, typeValue()))

proc valueGetIface*(obj: pointer): PValueIface = 
  result = cast[PValueIface](gTypeInstanceGetInterface(obj, typeValue()))
