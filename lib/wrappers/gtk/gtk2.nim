{.deadCodeElim: on.}
import 
  glib2, atk, pango, gdk2pixbuf, gdk2

export gbool, toBool

when defined(win32): 
  const 
    lib = "libgtk-win32-2.0-0.dll"
elif defined(macosx): 
  const 
    lib = "libgtk-x11-2.0.dylib"
  # linklib gtk-x11-2.0
  # linklib gdk-x11-2.0
  # linklib pango-1.0.0
  # linklib glib-2.0.0
  # linklib gobject-2.0.0
  # linklib gdk_pixbuf-2.0.0
  # linklib atk-1.0.0
else: 
  const 
    lib = "libgtk-x11-2.0.so(|.0)"

const 
  MaxComposeLen* = 7

type 
  PObject* = ptr TObject
  PPGtkObject* = ptr PObject
  PArg* = ptr TArg
  PType* = ptr TType
  TType* = GType
  PWidget* = ptr TWidget
  PMisc* = ptr TMisc
  PLabel* = ptr TLabel
  PMenu* = ptr TMenu
  PAnchorType* = ptr TAnchorType
  TAnchorType* = Int32
  PArrowType* = ptr TArrowType
  TArrowType* = Int32
  PAttachOptions* = ptr TAttachOptions
  TAttachOptions* = Int32
  PButtonBoxStyle* = ptr TButtonBoxStyle
  TButtonBoxStyle* = Int32
  PCurveType* = ptr TCurveType
  TCurveType* = Int32
  PDeleteType* = ptr TDeleteType
  TDeleteType* = Int32
  PDirectionType* = ptr TDirectionType
  TDirectionType* = Int32
  PExpanderStyle* = ptr TExpanderStyle
  TExpanderStyle* = Int32
  PPGtkIconSize* = ptr PIconSize
  PIconSize* = ptr TIconSize
  TIconSize* = Int32
  PTextDirection* = ptr TTextDirection
  TTextDirection* = Int32
  PJustification* = ptr TJustification
  TJustification* = Int32
  PMenuDirectionType* = ptr TMenuDirectionType
  TMenuDirectionType* = Int32
  PMetricType* = ptr TMetricType
  TMetricType* = Int32
  PMovementStep* = ptr TMovementStep
  TMovementStep* = Int32
  POrientation* = ptr TOrientation
  TOrientation* = Int32
  PCornerType* = ptr TCornerType
  TCornerType* = Int32
  PPackType* = ptr TPackType
  TPackType* = Int32
  PPathPriorityType* = ptr TPathPriorityType
  TPathPriorityType* = Int32
  PPathType* = ptr TPathType
  TPathType* = Int32
  PPolicyType* = ptr TPolicyType
  TPolicyType* = Int32
  PPositionType* = ptr TPositionType
  TPositionType* = Int32
  PReliefStyle* = ptr TReliefStyle
  TReliefStyle* = Int32
  PResizeMode* = ptr TResizeMode
  TResizeMode* = Int32
  PScrollType* = ptr TScrollType
  TScrollType* = Int32
  PSelectionMode* = ptr TSelectionMode
  TSelectionMode* = Int32
  PShadowType* = ptr TShadowType
  TShadowType* = Int32
  PStateType* = ptr TStateType
  TStateType* = Int32
  PSubmenuDirection* = ptr TSubmenuDirection
  TSubmenuDirection* = Int32
  PSubmenuPlacement* = ptr TSubmenuPlacement
  TSubmenuPlacement* = Int32
  PToolbarStyle* = ptr TToolbarStyle
  TToolbarStyle* = Int32
  PUpdateType* = ptr TUpdateType
  TUpdateType* = Int32
  PVisibility* = ptr TVisibility
  TVisibility* = Int32
  PWindowPosition* = ptr TWindowPosition
  TWindowPosition* = Int32
  PWindowType* = ptr TWindowType
  TWindowType* = Int32
  PWrapMode* = ptr TWrapMode
  TWrapMode* = Int32
  PSortType* = ptr TSortType
  TSortType* = Int32
  PStyle* = ptr TStyle
  PPGtkTreeModel* = ptr PTreeModel
  PTreeModel* = Pointer
  PTreePath* = Pointer
  PTreeIter* = ptr TTreeIter
  PSelectionData* = ptr TSelectionData
  PTextTagTable* = ptr TTextTagTable
  PTextBTreeNode* = Pointer
  PTextBTree* = Pointer
  PTextLine* = ptr TTextLine
  PTreeViewColumn* = ptr TTreeViewColumn
  PTreeView* = ptr TTreeView
  TTreeViewColumnDropFunc* = proc (tree_view: PTreeView, 
                                   column: PTreeViewColumn, 
                                   prev_column: PTreeViewColumn, 
                                   next_column: PTreeViewColumn, data: Gpointer): Gboolean{.
      cdecl.}
  TTreeViewMappingFunc* = proc (tree_view: PTreeView, path: PTreePath, 
                                user_data: Gpointer){.cdecl.}
  TTreeViewSearchEqualFunc* = proc (model: PTreeModel, column: Gint, 
                                    key: Cstring, iter: PTreeIter, 
                                    search_data: Gpointer): Gboolean{.cdecl.}
  TTreeDestroyCountFunc* = proc (tree_view: PTreeView, path: PTreePath, 
                                 children: Gint, user_data: Gpointer){.cdecl.}
  PTreeViewDropPosition* = ptr TTreeViewDropPosition
  TTreeViewDropPosition* = enum 
    TREE_VIEW_DROP_BEFORE, TREE_VIEW_DROP_AFTER, TREE_VIEW_DROP_INTO_OR_BEFORE, 
    TREE_VIEW_DROP_INTO_OR_AFTER
  PObjectFlags* = ptr TObjectFlags
  TObjectFlags* = Int32
  TObject* = object of TGObject
    flags*: Guint32

  PObjectClass* = ptr TObjectClass
  TObjectClass* = object of TGObjectClass
    set_arg*: proc (anObject: PObject, arg: PArg, arg_id: Guint){.cdecl.}
    get_arg*: proc (anObject: PObject, arg: PArg, arg_id: Guint){.cdecl.}
    destroy*: proc (anObject: PObject){.cdecl.}

  PFundamentalType* = ptr TFundamentalType
  TFundamentalType* = GType
  TFunction* = proc (data: Gpointer): Gboolean{.cdecl.}
  TDestroyNotify* = proc (data: Gpointer){.cdecl.}
  TCallbackMarshal* = proc (anObject: PObject, data: Gpointer, n_args: Guint, 
                            args: PArg){.cdecl.}
  TSignalFunc* = proc (para1: Pointer){.cdecl.}
  PSignalMarshaller* = ptr TSignalMarshaller
  TSignalMarshaller* = TGSignalCMarshaller
  TArgSignalData*{.final, pure.} = object 
    f*: TSignalFunc
    d*: Gpointer

  TArg*{.final, pure.} = object 
    `type`*: TType
    name*: Cstring
    d*: Gdouble               # was a union type
  
  PTypeInfo* = ptr TTypeInfo
  TTypeInfo*{.final, pure.} = object 
    type_name*: Cstring
    object_size*: Guint
    class_size*: Guint
    class_init_func*: Pointer #TGtkClassInitFunc
    object_init_func*: Pointer #TGtkObjectInitFunc
    reserved_1*: Gpointer
    reserved_2*: Gpointer
    base_class_init_func*: Pointer #TGtkClassInitFunc
  
  PEnumValue* = ptr TEnumValue
  TEnumValue* = TGEnumValue
  PFlagValue* = ptr TFlagValue
  TFlagValue* = TGFlagsValue
  PWidgetFlags* = ptr TWidgetFlags
  TWidgetFlags* = Int32
  PWidgetHelpType* = ptr TWidgetHelpType
  TWidgetHelpType* = enum 
    WIDGET_HELP_TOOLTIP, WIDGET_HELP_WHATS_THIS
  PAllocation* = ptr TAllocation
  TAllocation* = Gdk2.TRectangle
  TCallback* = proc (widget: PWidget, data: Gpointer){.cdecl.}
  PRequisition* = ptr TRequisition
  TRequisition*{.final, pure.} = object 
    width*: Gint
    height*: Gint

  TWidget* = object of TObject
    private_flags*: Guint16
    state*: Guint8
    savedState*: Guint8
    name*: Cstring
    style*: PStyle
    requisition*: TRequisition
    allocation*: TAllocation
    window*: Gdk2.PWindow
    parent*: PWidget

  PWidgetClass* = ptr TWidgetClass
  TWidgetClass* = object of TObjectClass
    activate_signal*: Guint
    set_scroll_adjustments_signal*: Guint
    dispatch_child_properties_changed*: proc (widget: PWidget, n_pspecs: Guint, 
        pspecs: PPGParamSpec){.cdecl.}
    show*: proc (widget: PWidget){.cdecl.}
    show_all*: proc (widget: PWidget){.cdecl.}
    hide*: proc (widget: PWidget){.cdecl.}
    hide_all*: proc (widget: PWidget){.cdecl.}
    map*: proc (widget: PWidget){.cdecl.}
    unmap*: proc (widget: PWidget){.cdecl.}
    realize*: proc (widget: PWidget){.cdecl.}
    unrealize*: proc (widget: PWidget){.cdecl.}
    size_request*: proc (widget: PWidget, requisition: PRequisition){.cdecl.}
    size_allocate*: proc (widget: PWidget, allocation: PAllocation){.cdecl.}
    state_changed*: proc (widget: PWidget, previous_state: TStateType){.cdecl.}
    parent_set*: proc (widget: PWidget, previous_parent: PWidget){.cdecl.}
    hierarchy_changed*: proc (widget: PWidget, previous_toplevel: PWidget){.
        cdecl.}
    style_set*: proc (widget: PWidget, previous_style: PStyle){.cdecl.}
    direction_changed*: proc (widget: PWidget, 
                              previous_direction: TTextDirection){.cdecl.}
    grab_notify*: proc (widget: PWidget, was_grabbed: Gboolean){.cdecl.}
    child_notify*: proc (widget: PWidget, pspec: PGParamSpec){.cdecl.}
    mnemonic_activate*: proc (widget: PWidget, group_cycling: Gboolean): Gboolean{.
        cdecl.}
    grab_focus*: proc (widget: PWidget){.cdecl.}
    focus*: proc (widget: PWidget, direction: TDirectionType): Gboolean{.cdecl.}
    event*: proc (widget: PWidget, event: Gdk2.PEvent): Gboolean{.cdecl.}
    button_press_event*: proc (widget: PWidget, event: PEventButton): Gboolean{.
        cdecl.}
    button_release_event*: proc (widget: PWidget, event: PEventButton): Gboolean{.
        cdecl.}
    scroll_event*: proc (widget: PWidget, event: PEventScroll): Gboolean{.
        cdecl.}
    motion_notify_event*: proc (widget: PWidget, event: PEventMotion): Gboolean{.
        cdecl.}
    delete_event*: proc (widget: PWidget, event: PEventAny): Gboolean{.cdecl.}
    destroy_event*: proc (widget: PWidget, event: PEventAny): Gboolean{.cdecl.}
    expose_event*: proc (widget: PWidget, event: PEventExpose): Gboolean{.
        cdecl.}
    key_press_event*: proc (widget: PWidget, event: PEventKey): Gboolean{.
        cdecl.}
    key_release_event*: proc (widget: PWidget, event: PEventKey): Gboolean{.
        cdecl.}
    enter_notify_event*: proc (widget: PWidget, event: PEventCrossing): Gboolean{.
        cdecl.}
    leave_notify_event*: proc (widget: PWidget, event: PEventCrossing): Gboolean{.
        cdecl.}
    configure_event*: proc (widget: PWidget, event: PEventConfigure): Gboolean{.
        cdecl.}
    focus_in_event*: proc (widget: PWidget, event: PEventFocus): Gboolean{.
        cdecl.}
    focus_out_event*: proc (widget: PWidget, event: PEventFocus): Gboolean{.
        cdecl.}
    map_event*: proc (widget: PWidget, event: PEventAny): Gboolean{.cdecl.}
    unmap_event*: proc (widget: PWidget, event: PEventAny): Gboolean{.cdecl.}
    property_notify_event*: proc (widget: PWidget, event: PEventProperty): Gboolean{.
        cdecl.}
    selection_clear_event*: proc (widget: PWidget, event: PEventSelection): Gboolean{.
        cdecl.}
    selection_request_event*: proc (widget: PWidget, event: PEventSelection): Gboolean{.
        cdecl.}
    selection_notify_event*: proc (widget: PWidget, event: PEventSelection): Gboolean{.
        cdecl.}
    proximity_in_event*: proc (widget: PWidget, event: PEventProximity): Gboolean{.
        cdecl.}
    proximity_out_event*: proc (widget: PWidget, event: PEventProximity): Gboolean{.
        cdecl.}
    visibility_notify_event*: proc (widget: PWidget, event: PEventVisibility): Gboolean{.
        cdecl.}
    client_event*: proc (widget: PWidget, event: PEventClient): Gboolean{.
        cdecl.}
    no_expose_event*: proc (widget: PWidget, event: PEventAny): Gboolean{.
        cdecl.}
    window_state_event*: proc (widget: PWidget, event: PEventWindowState): Gboolean{.
        cdecl.}
    selection_get*: proc (widget: PWidget, selection_data: PSelectionData, 
                          info: Guint, time: Guint){.cdecl.}
    selection_received*: proc (widget: PWidget, selection_data: PSelectionData, 
                               time: Guint){.cdecl.}
    drag_begin*: proc (widget: PWidget, context: PDragContext){.cdecl.}
    drag_end*: proc (widget: PWidget, context: PDragContext){.cdecl.}
    drag_data_get*: proc (widget: PWidget, context: PDragContext, 
                          selection_data: PSelectionData, info: Guint, 
                          time: Guint){.cdecl.}
    drag_data_delete*: proc (widget: PWidget, context: PDragContext){.cdecl.}
    drag_leave*: proc (widget: PWidget, context: PDragContext, time: Guint){.
        cdecl.}
    drag_motion*: proc (widget: PWidget, context: PDragContext, x: Gint, 
                        y: Gint, time: Guint): Gboolean{.cdecl.}
    drag_drop*: proc (widget: PWidget, context: PDragContext, x: Gint, 
                      y: Gint, time: Guint): Gboolean{.cdecl.}
    drag_data_received*: proc (widget: PWidget, context: PDragContext, 
                               x: Gint, y: Gint, selection_data: PSelectionData, 
                               info: Guint, time: Guint){.cdecl.}
    popup_menu*: proc (widget: PWidget): Gboolean{.cdecl.}
    show_help*: proc (widget: PWidget, help_type: TWidgetHelpType): Gboolean{.
        cdecl.}
    get_accessible*: proc (widget: PWidget): atk.PObject{.cdecl.}
    reserved1: proc (){.cdecl.}
    reserved2: proc (){.cdecl.}
    reserved3: proc (){.cdecl.}
    reserved4: proc (){.cdecl.}
    reserved5*: proc (){.cdecl.}
    reserved6*: proc (){.cdecl.}
    reserved7*: proc (){.cdecl.}
    reserved8*: proc (){.cdecl.}

  PWidgetAuxInfo* = ptr TWidgetAuxInfo
  TWidgetAuxInfo*{.final, pure.} = object 
    x*: Gint
    y*: Gint
    width*: Gint
    height*: Gint
    flag0*: Guint16

  PWidgetShapeInfo* = ptr TWidgetShapeInfo
  TWidgetShapeInfo*{.final, pure.} = object 
    offset_x*: Gint16
    offset_y*: Gint16
    shape_mask*: gdk2.PBitmap

  TMisc* = object of TWidget
    xalign*: Gfloat
    yalign*: Gfloat
    xpad*: Guint16
    ypad*: Guint16

  PMiscClass* = ptr TMiscClass
  TMiscClass* = object of TWidgetClass
  PAccelFlags* = ptr TAccelFlags
  TAccelFlags* = Int32
  PAccelGroup* = ptr TAccelGroup
  PAccelGroupEntry* = ptr TAccelGroupEntry
  TAccelGroupActivate* = proc (accel_group: PAccelGroup, 
                               acceleratable: PGObject, keyval: Guint, 
                               modifier: gdk2.TModifierType): Gboolean{.cdecl.}
  TAccelGroup* = object of TGObject
    lock_count*: Guint
    modifier_mask*: gdk2.TModifierType
    acceleratables*: PGSList
    n_accels*: Guint
    priv_accels*: PAccelGroupEntry

  PAccelGroupClass* = ptr TAccelGroupClass
  TAccelGroupClass* = object of TGObjectClass
    accel_changed*: proc (accel_group: PAccelGroup, keyval: Guint, 
                          modifier: gdk2.TModifierType, accel_closure: PGClosure){.
        cdecl.}
    reserved1: proc (){.cdecl.}
    reserved2: proc (){.cdecl.}
    reserved3: proc (){.cdecl.}
    reserved4: proc (){.cdecl.}

  PAccelKey* = ptr TAccelKey
  TAccelKey*{.final, pure.} = object 
    accel_key*: Guint
    accel_mods*: gdk2.TModifierType
    flag0*: Guint16

  TAccelGroupEntry*{.final, pure.} = object 
    key*: TAccelKey
    closure*: PGClosure
    accel_path_quark*: TGQuark

  TaccelGroupFindFunc* = proc (key: PAccelKey, closure: PGClosure, 
                                  data: Gpointer): Gboolean{.cdecl.}
  PContainer* = ptr TContainer
  TContainer* = object of TWidget
    focus_child*: PWidget
    containerFlag0*: Int32

  PContainerClass* = ptr TContainerClass
  TContainerClass* = object of TWidgetClass
    add*: proc (container: PContainer, widget: PWidget){.cdecl.}
    remove*: proc (container: PContainer, widget: PWidget){.cdecl.}
    check_resize*: proc (container: PContainer){.cdecl.}
    forall*: proc (container: PContainer, include_internals: Gboolean, 
                   callback: TCallback, callback_data: Gpointer){.cdecl.}
    set_focus_child*: proc (container: PContainer, widget: PWidget){.cdecl.}
    child_type*: proc (container: PContainer): TType{.cdecl.}
    composite_name*: proc (container: PContainer, child: PWidget): Cstring{.
        cdecl.}
    set_child_property*: proc (container: PContainer, child: PWidget, 
                               property_id: Guint, value: PGValue, 
                               pspec: PGParamSpec){.cdecl.}
    get_child_property*: proc (container: PContainer, child: PWidget, 
                               property_id: Guint, value: PGValue, 
                               pspec: PGParamSpec){.cdecl.}
    reserved20: proc (){.cdecl.}
    reserved21: proc (){.cdecl.}
    reserved23: proc (){.cdecl.}
    reserved24: proc (){.cdecl.}

  PBin* = ptr TBin
  TBin* = object of TContainer
    child*: PWidget

  PBinClass* = ptr TBinClass
  TBinClass* = object of TContainerClass
  PWindowGeometryInfo* = Pointer
  PWindowGroup* = ptr TWindowGroup
  PWindow* = ptr TWindow
  TWindow* = object of TBin
    title*: Cstring
    wmclass_name*: Cstring
    wmclass_class*: Cstring
    wm_role*: Cstring
    focus_widget*: PWidget
    default_widget*: PWidget
    transient_parent*: PWindow
    geometry_info*: PWindowGeometryInfo
    frame*: gdk2.PWindow
    group*: PWindowGroup
    configure_request_count*: Guint16
    windowFlag0*: Int32
    frame_left*: Guint
    frame_top*: Guint
    frame_right*: Guint
    frame_bottom*: Guint
    keys_changed_handler*: Guint
    mnemonic_modifier*: gdk2.TModifierType
    screen*: gdk2.PScreen

  PWindowClass* = ptr TWindowClass
  TWindowClass* = object of TBinClass
    set_focus*: proc (window: PWindow, focus: PWidget){.cdecl.}
    frame_event*: proc (window: PWindow, event: gdk2.PEvent): Gboolean{.cdecl.}
    activate_focus*: proc (window: PWindow){.cdecl.}
    activate_default*: proc (window: PWindow){.cdecl.}
    move_focus*: proc (window: PWindow, direction: TDirectionType){.cdecl.}
    keys_changed*: proc (window: PWindow){.cdecl.}
    reserved30: proc (){.cdecl.}
    reserved31: proc (){.cdecl.}
    reserved32: proc (){.cdecl.}
    reserved33: proc (){.cdecl.}

  TWindowGroup* = object of TGObject
    grabs*: PGSList

  PWindowGroupClass* = ptr TWindowGroupClass
  TWindowGroupClass* = object of TGObjectClass
    reserved40: proc (){.cdecl.}
    reserved41: proc (){.cdecl.}
    reserved42: proc (){.cdecl.}
    reserved43: proc (){.cdecl.}

  TWindowKeysForeachFunc* = proc (window: PWindow, keyval: Guint, 
                                  modifiers: gdk2.TModifierType, 
                                  is_mnemonic: Gboolean, data: Gpointer){.cdecl.}
  PLabelSelectionInfo* = Pointer
  TLabel* = object of TMisc
    `label`*: Cstring
    labelFlag0*: Guint16
    mnemonic_keyval*: Guint
    text*: Cstring
    attrs*: pango.PAttrList
    effective_attrs*: pango.PAttrList
    layout*: pango.PLayout
    mnemonic_widget*: PWidget
    mnemonic_window*: PWindow
    select_info*: PLabelSelectionInfo

  PLabelClass* = ptr TLabelClass
  TLabelClass* = object of TMiscClass
    move_cursor*: proc (`label`: PLabel, step: TMovementStep, count: Gint, 
                        extend_selection: Gboolean){.cdecl.}
    copy_clipboard*: proc (`label`: PLabel){.cdecl.}
    populate_popup*: proc (`label`: PLabel, menu: PMenu){.cdecl.}
    reserved50: proc (){.cdecl.}
    reserved51: proc (){.cdecl.}
    reserved52: proc (){.cdecl.}
    reserved53: proc (){.cdecl.}

  PAccelLabel* = ptr TAccelLabel
  TAccelLabel* = object of TLabel
    queue_id*: Guint
    accel_padding*: Guint
    accel_widget*: PWidget
    accel_closure*: PGClosure
    accel_group*: PAccelGroup
    accel_string*: Cstring
    accel_string_width*: Guint16

  PAccelLabelClass* = ptr TAccelLabelClass
  TAccelLabelClass* = object of TLabelClass
    signal_quote1*: Cstring
    signal_quote2*: Cstring
    mod_name_shift*: Cstring
    mod_name_control*: Cstring
    mod_name_alt*: Cstring
    mod_separator*: Cstring
    accel_seperator*: Cstring
    accelLabelClassFlag0*: Guint16
    reserved61: proc (){.cdecl.}
    reserved62: proc (){.cdecl.}
    reserved63: proc (){.cdecl.}
    reserved64: proc (){.cdecl.}

  TAccelMapForeach* = proc (data: Gpointer, accel_path: Cstring, 
                            accel_key: Guint, accel_mods: gdk2.TModifierType, 
                            changed: Gboolean){.cdecl.}
  PAccessible* = ptr TAccessible
  TAccessible* = object of atk.TObject
    widget*: PWidget

  PAccessibleClass* = ptr TAccessibleClass
  TAccessibleClass* = object of atk.TObjectClass
    connect_widget_destroyed*: proc (accessible: PAccessible){.cdecl.}
    reserved71: proc (){.cdecl.}
    reserved72: proc (){.cdecl.}
    reserved73: proc (){.cdecl.}
    reserved74: proc (){.cdecl.}

  PAdjustment* = ptr TAdjustment
  TAdjustment* = object of TObject
    lower*: Gdouble
    upper*: Gdouble
    value*: Gdouble
    step_increment*: Gdouble
    page_increment*: Gdouble
    page_size*: Gdouble

  PAdjustmentClass* = ptr TAdjustmentClass
  TAdjustmentClass* = object of TObjectClass
    changed*: proc (adjustment: PAdjustment){.cdecl.}
    value_changed*: proc (adjustment: PAdjustment){.cdecl.}
    reserved81: proc (){.cdecl.}
    reserved82: proc (){.cdecl.}
    reserved83: proc (){.cdecl.}
    reserved84: proc (){.cdecl.}

  PAlignment* = ptr TAlignment
  TAlignment* = object of TBin
    xalign*: Gfloat
    yalign*: Gfloat
    xscale*: Gfloat
    yscale*: Gfloat

  PAlignmentClass* = ptr TAlignmentClass
  TAlignmentClass* = object of TBinClass
  PFrame* = ptr TFrame
  TFrame* = object of TBin
    label_widget*: PWidget
    shadow_type*: Gint16
    label_xalign*: Gfloat
    label_yalign*: Gfloat
    child_allocation*: TAllocation

  PFrameClass* = ptr TFrameClass
  TFrameClass* = object of TBinClass
    compute_child_allocation*: proc (frame: PFrame, allocation: PAllocation){.
        cdecl.}

  PAspectFrame* = ptr TAspectFrame
  TAspectFrame* = object of TFrame
    xalign*: Gfloat
    yalign*: Gfloat
    ratio*: Gfloat
    obey_child*: Gboolean
    center_allocation*: TAllocation

  PAspectFrameClass* = ptr TAspectFrameClass
  TAspectFrameClass* = object of TFrameClass
  PArrow* = ptr TArrow
  TArrow* = object of TMisc
    arrow_type*: Gint16
    shadow_type*: Gint16

  PArrowClass* = ptr TArrowClass
  TArrowClass* = object of TMiscClass
  PBindingEntry* = ptr TBindingEntry
  PBindingSignal* = ptr TBindingSignal
  PBindingArg* = ptr TBindingArg
  PBindingSet* = ptr TBindingSet
  TBindingSet*{.final, pure.} = object 
    set_name*: Cstring
    priority*: Gint
    widget_path_pspecs*: PGSList
    widget_class_pspecs*: PGSList
    class_branch_pspecs*: PGSList
    entries*: PBindingEntry
    current*: PBindingEntry
    flag0*: Guint16

  TBindingEntry*{.final, pure.} = object 
    keyval*: Guint
    modifiers*: gdk2.TModifierType
    binding_set*: PBindingSet
    flag0*: Guint16
    set_next*: PBindingEntry
    hash_next*: PBindingEntry
    signals*: PBindingSignal

  TBindingSignal*{.final, pure.} = object 
    next*: PBindingSignal
    signal_name*: Cstring
    n_args*: Guint
    args*: PBindingArg

  TBindingArg*{.final, pure.} = object 
    arg_type*: TType
    d*: Gdouble

  PBox* = ptr TBox
  TBox* = object of TContainer
    children*: PGList
    spacing*: Gint16
    boxFlag0*: Guint16

  PBoxClass* = ptr TBoxClass
  TBoxClass* = object of TContainerClass
  PBoxChild* = ptr TBoxChild
  TBoxChild*{.final, pure.} = object 
    widget*: PWidget
    padding*: Guint16
    flag0*: Guint16

  PButtonBox* = ptr TButtonBox
  TButtonBox* = object of TBox
    child_min_width*: Gint
    child_min_height*: Gint
    child_ipad_x*: Gint
    child_ipad_y*: Gint
    layout_style*: TButtonBoxStyle

  PButtonBoxClass* = ptr TButtonBoxClass
  TButtonBoxClass* = object of TBoxClass
  PButton* = ptr TButton
  TButton* = object of TBin
    event_window*: gdk2.PWindow
    label_text*: Cstring
    activate_timeout*: Guint
    buttonFlag0*: Guint16

  PButtonClass* = ptr TButtonClass
  TButtonClass* = object of TBinClass
    pressed*: proc (button: PButton){.cdecl.}
    released*: proc (button: PButton){.cdecl.}
    clicked*: proc (button: PButton){.cdecl.}
    enter*: proc (button: PButton){.cdecl.}
    leave*: proc (button: PButton){.cdecl.}
    activate*: proc (button: PButton){.cdecl.}
    reserved101: proc (){.cdecl.}
    reserved102: proc (){.cdecl.}
    reserved103: proc (){.cdecl.}
    reserved104: proc (){.cdecl.}

  PCalendarDisplayOptions* = ptr TCalendarDisplayOptions
  TCalendarDisplayOptions* = Int32
  PCalendar* = ptr TCalendar
  TCalendar* = object of TWidget
    header_style*: PStyle
    label_style*: PStyle
    month*: Gint
    year*: Gint
    selected_day*: Gint
    day_month*: Array[0..5, Array[0..6, Gint]]
    day*: Array[0..5, Array[0..6, Gint]]
    num_marked_dates*: Gint
    marked_date*: Array[0..30, Gint]
    display_flags*: TCalendarDisplayOptions
    marked_date_color*: Array[0..30, gdk2.TColor]
    gc*: gdk2.PGC
    xor_gc*: gdk2.PGC
    focus_row*: Gint
    focus_col*: Gint
    highlight_row*: Gint
    highlight_col*: Gint
    private_data*: Gpointer
    grow_space*: Array[0..31, Gchar]
    reserved111: proc (){.cdecl.}
    reserved112: proc (){.cdecl.}
    reserved113: proc (){.cdecl.}
    reserved114: proc (){.cdecl.}

  PCalendarClass* = ptr TCalendarClass
  TCalendarClass* = object of TWidgetClass
    month_changed*: proc (calendar: PCalendar){.cdecl.}
    day_selected*: proc (calendar: PCalendar){.cdecl.}
    day_selected_double_click*: proc (calendar: PCalendar){.cdecl.}
    prev_month*: proc (calendar: PCalendar){.cdecl.}
    next_month*: proc (calendar: PCalendar){.cdecl.}
    prev_year*: proc (calendar: PCalendar){.cdecl.}
    next_year*: proc (calendar: PCalendar){.cdecl.}

  PCellEditable* = Pointer
  PCellEditableIface* = ptr TCellEditableIface
  TCellEditableIface* = object of TGTypeInterface
    editing_done*: proc (cell_editable: PCellEditable){.cdecl.}
    remove_widget*: proc (cell_editable: PCellEditable){.cdecl.}
    start_editing*: proc (cell_editable: PCellEditable, event: gdk2.PEvent){.cdecl.}

  PCellRendererState* = ptr TCellRendererState
  TCellRendererState* = Int32
  PCellRendererMode* = ptr TCellRendererMode
  TCellRendererMode* = enum 
    CELL_RENDERER_MODE_INERT, CELL_RENDERER_MODE_ACTIVATABLE, 
    CELL_RENDERER_MODE_EDITABLE
  PCellRenderer* = ptr TCellRenderer
  TCellRenderer* = object of TObject
    xalign*: Gfloat
    yalign*: Gfloat
    width*: Gint
    height*: Gint
    xpad*: Guint16
    ypad*: Guint16
    cellRendererFlag0*: Guint16

  PCellRendererClass* = ptr TCellRendererClass
  TCellRendererClass* = object of TObjectClass
    get_size*: proc (cell: PCellRenderer, widget: PWidget, 
                     cell_area: gdk2.PRectangle, x_offset: Pgint, y_offset: Pgint, 
                     width: Pgint, height: Pgint){.cdecl.}
    render*: proc (cell: PCellRenderer, window: gdk2.PWindow, widget: PWidget, 
                   background_area: gdk2.PRectangle, cell_area: gdk2.PRectangle, 
                   expose_area: gdk2.PRectangle, flags: TCellRendererState){.cdecl.}
    activate*: proc (cell: PCellRenderer, event: gdk2.PEvent, widget: PWidget, 
                     path: Cstring, background_area: gdk2.PRectangle, 
                     cell_area: gdk2.PRectangle, flags: TCellRendererState): Gboolean{.
        cdecl.}
    start_editing*: proc (cell: PCellRenderer, event: gdk2.PEvent, 
                          widget: PWidget, path: Cstring, 
                          background_area: gdk2.PRectangle, 
                          cell_area: gdk2.PRectangle, flags: TCellRendererState): PCellEditable{.
        cdecl.}
    reserved121: proc (){.cdecl.}
    reserved122: proc (){.cdecl.}
    reserved123: proc (){.cdecl.}
    reserved124: proc (){.cdecl.}

  PCellRendererText* = ptr TCellRendererText
  TCellRendererText* = object of TCellRenderer
    text*: Cstring
    font*: pango.PFontDescription
    font_scale*: Gdouble
    foreground*: pango.TColor
    background*: pango.TColor
    extra_attrs*: pango.PAttrList
    underline_style*: pango.TUnderline
    rise*: Gint
    fixed_height_rows*: Gint
    cellRendererTextFlag0*: Guint16

  PCellRendererTextClass* = ptr TCellRendererTextClass
  TCellRendererTextClass* = object of TCellRendererClass
    edited*: proc (cell_renderer_text: PCellRendererText, path: Cstring, 
                   new_text: Cstring){.cdecl.}
    reserved131: proc (){.cdecl.}
    reserved132: proc (){.cdecl.}
    reserved133: proc (){.cdecl.}
    reserved134: proc (){.cdecl.}

  PCellRendererToggle* = ptr TCellRendererToggle
  TCellRendererToggle* = object of TCellRenderer
    cellRendererToggleFlag0*: Guint16

  PCellRendererToggleClass* = ptr TCellRendererToggleClass
  TCellRendererToggleClass* = object of TCellRendererClass
    toggled*: proc (cell_renderer_toggle: PCellRendererToggle, path: Cstring){.
        cdecl.}
    reserved141: proc (){.cdecl.}
    reserved142: proc (){.cdecl.}
    reserved143: proc (){.cdecl.}
    reserved144: proc (){.cdecl.}

  PCellRendererPixbuf* = ptr TCellRendererPixbuf
  TCellRendererPixbuf* = object of TCellRenderer
    pixbuf*: gdk2pixbuf.PPixbuf
    pixbuf_expander_open*: gdk2pixbuf.PPixbuf
    pixbuf_expander_closed*: gdk2pixbuf.PPixbuf

  PCellRendererPixbufClass* = ptr TCellRendererPixbufClass
  TCellRendererPixbufClass* = object of TCellRendererClass
    reserved151: proc (){.cdecl.}
    reserved152: proc (){.cdecl.}
    reserved153: proc (){.cdecl.}
    reserved154: proc (){.cdecl.}

  PItem* = ptr TItem
  TItem* = object of TBin
  PItemClass* = ptr TItemClass
  TItemClass* = object of TBinClass
    select*: proc (item: PItem){.cdecl.}
    deselect*: proc (item: PItem){.cdecl.}
    toggle*: proc (item: PItem){.cdecl.}
    reserved161: proc (){.cdecl.}
    reserved162: proc (){.cdecl.}
    reserved163: proc (){.cdecl.}
    reserved164: proc (){.cdecl.}

  PMenuItem* = ptr TMenuItem
  TMenuItem* = object of TItem
    submenu*: PWidget
    event_window*: gdk2.PWindow
    toggle_size*: Guint16
    accelerator_width*: Guint16
    accel_path*: Cstring
    menuItemFlag0*: Guint16
    timer*: Guint

  PMenuItemClass* = ptr TMenuItemClass
  TMenuItemClass* = object of TItemClass
    menuItemClassFlag0*: Guint16
    activate*: proc (menu_item: PMenuItem){.cdecl.}
    activate_item*: proc (menu_item: PMenuItem){.cdecl.}
    toggle_size_request*: proc (menu_item: PMenuItem, requisition: Pgint){.cdecl.}
    toggle_size_allocate*: proc (menu_item: PMenuItem, allocation: Gint){.cdecl.}
    reserved171: proc (){.cdecl.}
    reserved172: proc (){.cdecl.}
    reserved173: proc (){.cdecl.}
    reserved174: proc (){.cdecl.}

  PToggleButton* = ptr TToggleButton
  TToggleButton* = object of TButton
    toggleButtonFlag0*: Guint16

  PToggleButtonClass* = ptr TToggleButtonClass
  TToggleButtonClass* = object of TButtonClass
    toggled*: proc (toggle_button: PToggleButton){.cdecl.}
    reserved171: proc (){.cdecl.}
    reserved172: proc (){.cdecl.}
    reserved173: proc (){.cdecl.}
    reserved174: proc (){.cdecl.}

  PCheckButton* = ptr TCheckButton
  TCheckButton* = object of TToggleButton
  PCheckButtonClass* = ptr TCheckButtonClass
  TCheckButtonClass* = object of TToggleButtonClass
    draw_indicator*: proc (check_button: PCheckButton, area: gdk2.PRectangle){.
        cdecl.}
    reserved181: proc (){.cdecl.}
    reserved182: proc (){.cdecl.}
    reserved183: proc (){.cdecl.}
    reserved184: proc (){.cdecl.}

  PCheckMenuItem* = ptr TCheckMenuItem
  TCheckMenuItem* = object of TMenuItem
    checkMenuItemFlag0*: Guint16

  PCheckMenuItemClass* = ptr TCheckMenuItemClass
  TCheckMenuItemClass* = object of TMenuItemClass
    toggled*: proc (check_menu_item: PCheckMenuItem){.cdecl.}
    draw_indicator*: proc (check_menu_item: PCheckMenuItem, area: gdk2.PRectangle){.
        cdecl.}
    reserved191: proc (){.cdecl.}
    reserved192: proc (){.cdecl.}
    reserved193: proc (){.cdecl.}
    reserved194: proc (){.cdecl.}

  PClipboard* = Pointer
  TClipboardReceivedFunc* = proc (clipboard: PClipboard, 
                                  selection_data: PSelectionData, data: Gpointer){.
      cdecl.}
  TClipboardTextReceivedFunc* = proc (clipboard: PClipboard, text: Cstring, 
                                      data: Gpointer){.cdecl.}
  TClipboardGetFunc* = proc (clipboard: PClipboard, 
                             selection_data: PSelectionData, info: Guint, 
                             user_data_or_owner: Gpointer){.cdecl.}
  TClipboardClearFunc* = proc (clipboard: PClipboard, 
                               user_data_or_owner: Gpointer){.cdecl.}
  PCList* = ptr TCList
  PCListColumn* = ptr TCListColumn
  PCListRow* = ptr TCListRow
  PCell* = ptr TCell
  PCellType* = ptr TCellType
  TCellType* = enum 
    CELL_EMPTY, CELL_TEXT, CELL_PIXMAP, CELL_PIXTEXT, CELL_WIDGET
  PCListDragPos* = ptr TCListDragPos
  TCListDragPos* = enum 
    CLIST_DRAG_NONE, CLIST_DRAG_BEFORE, CLIST_DRAG_INTO, CLIST_DRAG_AFTER
  PButtonAction* = ptr TButtonAction
  TButtonAction* = Int32
  TCListCompareFunc* = proc (clist: PCList, ptr1: Gconstpointer, 
                             ptr2: Gconstpointer): Gint{.cdecl.}
  PCListCellInfo* = ptr TCListCellInfo
  TCListCellInfo*{.final, pure.} = object 
    row*: Gint
    column*: Gint

  PCListDestInfo* = ptr TCListDestInfo
  TCListDestInfo*{.final, pure.} = object 
    cell*: TCListCellInfo
    insert_pos*: TCListDragPos

  TCList* = object of TContainer
    CList_flags*: Guint16
    row_mem_chunk*: PGMemChunk
    cell_mem_chunk*: PGMemChunk
    freeze_count*: Guint
    internal_allocation*: gdk2.TRectangle
    rows*: Gint
    row_height*: Gint
    row_list*: PGList
    row_list_end*: PGList
    columns*: Gint
    column_title_area*: gdk2.TRectangle
    title_window*: gdk2.PWindow
    column*: PCListColumn
    clist_window*: gdk2.PWindow
    clist_window_width*: Gint
    clist_window_height*: Gint
    hoffset*: Gint
    voffset*: Gint
    shadow_type*: TShadowType
    selection_mode*: TSelectionMode
    selection*: PGList
    selection_end*: PGList
    undo_selection*: PGList
    undo_unselection*: PGList
    undo_anchor*: Gint
    button_actions*: Array[0..4, Guint8]
    drag_button*: Guint8
    click_cell*: TCListCellInfo
    hadjustment*: PAdjustment
    vadjustment*: PAdjustment
    xor_gc*: gdk2.PGC
    fg_gc*: gdk2.PGC
    bg_gc*: gdk2.PGC
    cursor_drag*: gdk2.PCursor
    x_drag*: Gint
    focus_row*: Gint
    focus_header_column*: Gint
    anchor*: Gint
    anchor_state*: TStateType
    drag_pos*: Gint
    htimer*: Gint
    vtimer*: Gint
    sort_type*: TSortType
    compare*: TCListCompareFunc
    sort_column*: Gint
    drag_highlight_row*: Gint
    drag_highlight_pos*: TCListDragPos

  PCListClass* = ptr TCListClass
  TCListClass* = object of TContainerClass
    set_scroll_adjustments*: proc (clist: PCList, hadjustment: PAdjustment, 
                                   vadjustment: PAdjustment){.cdecl.}
    refresh*: proc (clist: PCList){.cdecl.}
    select_row*: proc (clist: PCList, row: Gint, column: Gint, event: gdk2.PEvent){.
        cdecl.}
    unselect_row*: proc (clist: PCList, row: Gint, column: Gint, 
                         event: gdk2.PEvent){.cdecl.}
    row_move*: proc (clist: PCList, source_row: Gint, dest_row: Gint){.cdecl.}
    click_column*: proc (clist: PCList, column: Gint){.cdecl.}
    resize_column*: proc (clist: PCList, column: Gint, width: Gint){.cdecl.}
    toggle_focus_row*: proc (clist: PCList){.cdecl.}
    select_all*: proc (clist: PCList){.cdecl.}
    unselect_all*: proc (clist: PCList){.cdecl.}
    undo_selection*: proc (clist: PCList){.cdecl.}
    start_selection*: proc (clist: PCList){.cdecl.}
    end_selection*: proc (clist: PCList){.cdecl.}
    extend_selection*: proc (clist: PCList, scroll_type: TScrollType, 
                             position: Gfloat, auto_start_selection: Gboolean){.
        cdecl.}
    scroll_horizontal*: proc (clist: PCList, scroll_type: TScrollType, 
                              position: Gfloat){.cdecl.}
    scroll_vertical*: proc (clist: PCList, scroll_type: TScrollType, 
                            position: Gfloat){.cdecl.}
    toggle_add_mode*: proc (clist: PCList){.cdecl.}
    abort_column_resize*: proc (clist: PCList){.cdecl.}
    resync_selection*: proc (clist: PCList, event: gdk2.PEvent){.cdecl.}
    selection_find*: proc (clist: PCList, row_number: Gint, 
                           row_list_element: PGList): PGList{.cdecl.}
    draw_row*: proc (clist: PCList, area: gdk2.PRectangle, row: Gint, 
                     clist_row: PCListRow){.cdecl.}
    draw_drag_highlight*: proc (clist: PCList, target_row: PCListRow, 
                                target_row_number: Gint, drag_pos: TCListDragPos){.
        cdecl.}
    clear*: proc (clist: PCList){.cdecl.}
    fake_unselect_all*: proc (clist: PCList, row: Gint){.cdecl.}
    sort_list*: proc (clist: PCList){.cdecl.}
    insert_row*: proc (clist: PCList, row: Gint): Gint{.cdecl, varargs.}
    remove_row*: proc (clist: PCList, row: Gint){.cdecl.}
    set_cell_contents*: proc (clist: PCList, clist_row: PCListRow, column: Gint, 
                              thetype: TCellType, text: Cstring, 
                              spacing: Guint8, pixmap: gdk2.PPixmap, 
                              mask: gdk2.PBitmap){.cdecl.}
    cell_size_request*: proc (clist: PCList, clist_row: PCListRow, column: Gint, 
                              requisition: PRequisition){.cdecl.}

  PGPtrArray = Pointer
  PGArray = Pointer
  TCListColumn*{.final, pure.} = object 
    title*: Cstring
    area*: gdk2.TRectangle
    button*: PWidget
    window*: gdk2.PWindow
    width*: Gint
    min_width*: Gint
    max_width*: Gint
    justification*: TJustification
    flag0*: Guint16

  TCListRow*{.final, pure.} = object 
    cell*: PCell
    state*: TStateType
    foreground*: gdk2.TColor
    background*: gdk2.TColor
    style*: PStyle
    data*: Gpointer
    destroy*: TDestroyNotify
    flag0*: Guint16

  PCellText* = ptr TCellText
  TCellText*{.final, pure.} = object 
    `type`*: TCellType
    vertical*: Gint16
    horizontal*: Gint16
    style*: PStyle
    text*: Cstring

  PCellPixmap* = ptr TCellPixmap
  TCellPixmap*{.final, pure.} = object 
    `type`*: TCellType
    vertical*: Gint16
    horizontal*: Gint16
    style*: PStyle
    pixmap*: gdk2.PPixmap
    mask*: gdk2.PBitmap

  PCellPixText* = ptr TCellPixText
  TCellPixText*{.final, pure.} = object 
    `type`*: TCellType
    vertical*: Gint16
    horizontal*: Gint16
    style*: PStyle
    text*: Cstring
    spacing*: Guint8
    pixmap*: gdk2.PPixmap
    mask*: gdk2.PBitmap

  PCellWidget* = ptr TCellWidget
  TCellWidget*{.final, pure.} = object 
    `type`*: TCellType
    vertical*: Gint16
    horizontal*: Gint16
    style*: PStyle
    widget*: PWidget

  TCell*{.final, pure.} = object 
    `type`*: TCellType
    vertical*: Gint16
    horizontal*: Gint16
    style*: PStyle
    text*: Cstring
    spacing*: Guint8
    pixmap*: gdk2.PPixmap
    mask*: gdk2.PBitmap

  PDialogFlags* = ptr TDialogFlags
  TDialogFlags* = Int32
  PResponseType* = ptr TResponseType
  TResponseType* = Int32
  PDialog* = ptr TDialog
  TDialog* = object of TWindow
    vbox*: PBox
    action_area*: PWidget
    separator*: PWidget

  PDialogClass* = ptr TDialogClass
  TDialogClass* = object of TWindowClass
    response*: proc (dialog: PDialog, response_id: Gint){.cdecl.}
    closeFile*: proc (dialog: PDialog){.cdecl.}
    reserved201: proc (){.cdecl.}
    reserved202: proc (){.cdecl.}
    reserved203: proc (){.cdecl.}
    reserved204: proc (){.cdecl.}

  PVBox* = ptr TVBox
  TVBox* = object of TBox
  PVBoxClass* = ptr TVBoxClass
  TVBoxClass* = object of TBoxClass
  TColorSelectionChangePaletteFunc* = proc (colors: gdk2.PColor, n_colors: Gint){.
      cdecl.}
  TColorSelectionChangePaletteWithScreenFunc* = proc (screen: gdk2.PScreen, 
      colors: gdk2.PColor, n_colors: Gint){.cdecl.}
  PColorSelection* = ptr TColorSelection
  TColorSelection* = object of TVBox
    private_data*: Gpointer

  PColorSelectionClass* = ptr TColorSelectionClass
  TColorSelectionClass* = object of TVBoxClass
    color_changed*: proc (color_selection: PColorSelection){.cdecl.}
    reserved211: proc (){.cdecl.}
    reserved212: proc (){.cdecl.}
    reserved213: proc (){.cdecl.}
    reserved214: proc (){.cdecl.}

  PColorSelectionDialog* = ptr TColorSelectionDialog
  TColorSelectionDialog* = object of TDialog
    colorsel*: PWidget
    ok_button*: PWidget
    cancel_button*: PWidget
    help_button*: PWidget

  PColorSelectionDialogClass* = ptr TColorSelectionDialogClass
  TColorSelectionDialogClass* = object of TDialogClass
    reserved221: proc (){.cdecl.}
    reserved222: proc (){.cdecl.}
    reserved223: proc (){.cdecl.}
    reserved224: proc (){.cdecl.}

  PHBox* = ptr THBox
  THBox* = object of TBox
  PHBoxClass* = ptr THBoxClass
  THBoxClass* = object of TBoxClass
  PCombo* = ptr TCombo
  TCombo* = object of THBox
    entry*: PWidget
    button*: PWidget
    popup*: PWidget
    popwin*: PWidget
    list*: PWidget
    entry_change_id*: Guint
    list_change_id*: Guint
    comboFlag0*: Guint16
    current_button*: Guint16
    activate_id*: Guint

  PComboClass* = ptr TComboClass
  TComboClass* = object of THBoxClass
    reserved231: proc (){.cdecl.}
    reserved232: proc (){.cdecl.}
    reserved233: proc (){.cdecl.}
    reserved234: proc (){.cdecl.}

  PCTreePos* = ptr TCTreePos
  TCTreePos* = enum 
    CTREE_POS_BEFORE, CTREE_POS_AS_CHILD, CTREE_POS_AFTER
  PCTreeLineStyle* = ptr TCTreeLineStyle
  TCTreeLineStyle* = enum 
    CTREE_LINES_NONE, CTREE_LINES_SOLID, CTREE_LINES_DOTTED, CTREE_LINES_TABBED
  PCTreeExpanderStyle* = ptr TCTreeExpanderStyle
  TCTreeExpanderStyle* = enum 
    CTREE_EXPANDER_NONE, CTREE_EXPANDER_SQUARE, CTREE_EXPANDER_TRIANGLE, 
    CTREE_EXPANDER_CIRCULAR
  PCTreeExpansionType* = ptr TCTreeExpansionType
  TCTreeExpansionType* = enum 
    CTREE_EXPANSION_EXPAND, CTREE_EXPANSION_EXPAND_RECURSIVE, 
    CTREE_EXPANSION_COLLAPSE, CTREE_EXPANSION_COLLAPSE_RECURSIVE, 
    CTREE_EXPANSION_TOGGLE, CTREE_EXPANSION_TOGGLE_RECURSIVE
  PCTree* = ptr TCTree
  PCTreeNode* = ptr TCTreeNode
  TCTreeFunc* = proc (ctree: PCTree, node: PCTreeNode, data: Gpointer){.cdecl.}
  TCTreeGNodeFunc* = proc (ctree: PCTree, depth: Guint, gnode: PGNode, 
                           cnode: PCTreeNode, data: Gpointer): Gboolean{.cdecl.}
  TCTreeCompareDragFunc* = proc (ctree: PCTree, source_node: PCTreeNode, 
                                 new_parent: PCTreeNode, new_sibling: PCTreeNode): Gboolean{.
      cdecl.}
  TCTree* = object of TCList
    lines_gc*: gdk2.PGC
    tree_indent*: Gint
    tree_spacing*: Gint
    tree_column*: Gint
    cTreeFlag0*: Guint16
    drag_compare*: TCTreeCompareDragFunc

  PCTreeClass* = ptr TCTreeClass
  TCTreeClass* = object of TCListClass
    tree_select_row*: proc (ctree: PCTree, row: PCTreeNode, column: Gint){.cdecl.}
    tree_unselect_row*: proc (ctree: PCTree, row: PCTreeNode, column: Gint){.
        cdecl.}
    tree_expand*: proc (ctree: PCTree, node: PCTreeNode){.cdecl.}
    tree_collapse*: proc (ctree: PCTree, node: PCTreeNode){.cdecl.}
    tree_move*: proc (ctree: PCTree, node: PCTreeNode, new_parent: PCTreeNode, 
                      new_sibling: PCTreeNode){.cdecl.}
    change_focus_row_expansion*: proc (ctree: PCTree, 
                                       action: TCTreeExpansionType){.cdecl.}

  PCTreeRow* = ptr TCTreeRow
  TCTreeRow*{.final, pure.} = object 
    row*: TCListRow
    parent*: PCTreeNode
    sibling*: PCTreeNode
    children*: PCTreeNode
    pixmap_closed*: gdk2.PPixmap
    mask_closed*: gdk2.PBitmap
    pixmap_opened*: gdk2.PPixmap
    mask_opened*: gdk2.PBitmap
    level*: Guint16
    cTreeRowFlag0*: Guint16

  TCTreeNode*{.final, pure.} = object 
    list*: TGList

  PDrawingArea* = ptr TDrawingArea
  TDrawingArea* = object of TWidget
    draw_data*: Gpointer

  PDrawingAreaClass* = ptr TDrawingAreaClass
  TDrawingAreaClass* = object of TWidgetClass
    reserved241: proc (){.cdecl.}
    reserved242: proc (){.cdecl.}
    reserved243: proc (){.cdecl.}
    reserved244: proc (){.cdecl.}

  Tctlpoint* = Array[0..1, Gfloat]
  Pctlpoint* = ptr Tctlpoint
  PCurve* = ptr TCurve
  TCurve* = object of TDrawingArea
    cursor_type*: Gint
    min_x*: Gfloat
    max_x*: Gfloat
    min_y*: Gfloat
    max_y*: Gfloat
    pixmap*: gdk2.PPixmap
    curve_type*: TCurveType
    height*: Gint
    grab_point*: Gint
    last*: Gint
    num_points*: Gint
    point*: gdk2.PPoint
    num_ctlpoints*: Gint
    ctlpoint*: Pctlpoint

  PCurveClass* = ptr TCurveClass
  TCurveClass* = object of TDrawingAreaClass
    curve_type_changed*: proc (curve: PCurve){.cdecl.}
    reserved251: proc (){.cdecl.}
    reserved252: proc (){.cdecl.}
    reserved253: proc (){.cdecl.}
    reserved254: proc (){.cdecl.}

  PDestDefaults* = ptr TDestDefaults
  TDestDefaults* = Int32
  PTargetFlags* = ptr TTargetFlags
  TTargetFlags* = Int32
  PEditable* = Pointer
  PEditableClass* = ptr TEditableClass
  TEditableClass* = object of TGTypeInterface
    insert_text*: proc (editable: PEditable, text: Cstring, length: Gint, 
                        position: Pgint){.cdecl.}
    delete_text*: proc (editable: PEditable, start_pos: Gint, end_pos: Gint){.
        cdecl.}
    changed*: proc (editable: PEditable){.cdecl.}
    do_insert_text*: proc (editable: PEditable, text: Cstring, length: Gint, 
                           position: Pgint){.cdecl.}
    do_delete_text*: proc (editable: PEditable, start_pos: Gint, end_pos: Gint){.
        cdecl.}
    get_chars*: proc (editable: PEditable, start_pos: Gint, end_pos: Gint): Cstring{.
        cdecl.}
    set_selection_bounds*: proc (editable: PEditable, start_pos: Gint, 
                                 end_pos: Gint){.cdecl.}
    get_selection_bounds*: proc (editable: PEditable, start_pos: Pgint, 
                                 end_pos: Pgint): Gboolean{.cdecl.}
    set_position*: proc (editable: PEditable, position: Gint){.cdecl.}
    get_position*: proc (editable: PEditable): Gint{.cdecl.}

  PIMContext* = ptr TIMContext
  TIMContext* = object of TGObject
  PIMContextClass* = ptr TIMContextClass
  TIMContextClass* = object of TObjectClass
    preedit_start*: proc (context: PIMContext){.cdecl.}
    preedit_end*: proc (context: PIMContext){.cdecl.}
    preedit_changed*: proc (context: PIMContext){.cdecl.}
    commit*: proc (context: PIMContext, str: Cstring){.cdecl.}
    retrieve_surrounding*: proc (context: PIMContext): Gboolean{.cdecl.}
    delete_surrounding*: proc (context: PIMContext, offset: Gint, n_chars: Gint): Gboolean{.
        cdecl.}
    set_client_window*: proc (context: PIMContext, window: gdk2.PWindow){.cdecl.}
    get_preedit_string*: proc (context: PIMContext, str: PPgchar, 
                               attrs: var pango.PAttrList, cursor_pos: Pgint){.
        cdecl.}
    filter_keypress*: proc (context: PIMContext, event: gdk2.PEventKey): Gboolean{.
        cdecl.}
    focus_in*: proc (context: PIMContext){.cdecl.}
    focus_out*: proc (context: PIMContext){.cdecl.}
    reset*: proc (context: PIMContext){.cdecl.}
    set_cursor_location*: proc (context: PIMContext, area: gdk2.PRectangle){.cdecl.}
    set_use_preedit*: proc (context: PIMContext, use_preedit: Gboolean){.cdecl.}
    set_surrounding*: proc (context: PIMContext, text: Cstring, len: Gint, 
                            cursor_index: Gint){.cdecl.}
    get_surrounding*: proc (context: PIMContext, text: PPgchar, 
                            cursor_index: Pgint): Gboolean{.cdecl.}
    reserved261: proc (){.cdecl.}
    reserved262: proc (){.cdecl.}
    reserved263: proc (){.cdecl.}
    reserved264: proc (){.cdecl.}
    reserved265: proc (){.cdecl.}
    reserved266: proc (){.cdecl.}

  PMenuShell* = ptr TMenuShell
  TMenuShell* = object of TContainer
    children*: PGList
    active_menu_item*: PWidget
    parent_menu_shell*: PWidget
    button*: Guint
    activate_time*: Guint32
    menuShellFlag0*: Guint16

  PMenuShellClass* = ptr TMenuShellClass
  TMenuShellClass* = object of TContainerClass
    menuShellClassFlag0*: Guint16
    deactivate*: proc (menu_shell: PMenuShell){.cdecl.}
    selection_done*: proc (menu_shell: PMenuShell){.cdecl.}
    move_current*: proc (menu_shell: PMenuShell, direction: TMenuDirectionType){.
        cdecl.}
    activate_current*: proc (menu_shell: PMenuShell, force_hide: Gboolean){.
        cdecl.}
    cancel*: proc (menu_shell: PMenuShell){.cdecl.}
    select_item*: proc (menu_shell: PMenuShell, menu_item: PWidget){.cdecl.}
    insert*: proc (menu_shell: PMenuShell, child: PWidget, position: Gint){.
        cdecl.}
    reserved271: proc (){.cdecl.}
    reserved272: proc (){.cdecl.}
    reserved273: proc (){.cdecl.}
    reserved274: proc (){.cdecl.}

  TMenuPositionFunc* = proc (menu: PMenu, x: Pgint, y: Pgint, 
                             push_in: Pgboolean, user_data: Gpointer){.cdecl.}
  TMenuDetachFunc* = proc (attach_widget: PWidget, menu: PMenu){.cdecl.}
  TMenu* = object of TMenuShell
    parent_menu_item*: PWidget
    old_active_menu_item*: PWidget
    accel_group*: PAccelGroup
    accel_path*: Cstring
    position_func*: TMenuPositionFunc
    position_func_data*: Gpointer
    toggle_size*: Guint
    toplevel*: PWidget
    tearoff_window*: PWidget
    tearoff_hbox*: PWidget
    tearoff_scrollbar*: PWidget
    tearoff_adjustment*: PAdjustment
    view_window*: gdk2.PWindow
    bin_window*: gdk2.PWindow
    scroll_offset*: Gint
    saved_scroll_offset*: Gint
    scroll_step*: Gint
    timeout_id*: Guint
    navigation_region*: gdk2.PRegion
    navigation_timeout*: Guint
    menuFlag0*: Guint16

  PMenuClass* = ptr TMenuClass
  TMenuClass* = object of TMenuShellClass
    reserved281: proc (){.cdecl.}
    reserved282: proc (){.cdecl.}
    reserved283: proc (){.cdecl.}
    reserved284: proc (){.cdecl.}

  PEntry* = ptr TEntry
  TEntry* = object of TWidget
    text*: Cstring
    entryFlag0*: Guint16
    text_length*: Guint16
    text_max_length*: Guint16
    text_area*: gdk2.PWindow
    im_context*: PIMContext
    popup_menu*: PWidget
    current_pos*: Gint
    selection_bound*: Gint
    cached_layout*: pango.PLayout
    flag1*: Guint16
    button*: Guint
    blink_timeout*: Guint
    recompute_idle*: Guint
    scroll_offset*: Gint
    ascent*: Gint
    descent*: Gint
    text_size*: Guint16
    n_bytes*: Guint16
    preedit_length*: Guint16
    preedit_cursor*: Guint16
    dnd_position*: Gint
    drag_start_x*: Gint
    drag_start_y*: Gint
    invisible_char*: Gunichar
    width_chars*: Gint

  PEntryClass* = ptr TEntryClass
  TEntryClass* = object of TWidgetClass
    populate_popup*: proc (entry: PEntry, menu: PMenu){.cdecl.}
    activate*: proc (entry: PEntry){.cdecl.}
    move_cursor*: proc (entry: PEntry, step: TMovementStep, count: Gint, 
                        extend_selection: Gboolean){.cdecl.}
    insert_at_cursor*: proc (entry: PEntry, str: Cstring){.cdecl.}
    delete_from_cursor*: proc (entry: PEntry, thetype: TDeleteType, count: Gint){.
        cdecl.}
    cut_clipboard*: proc (entry: PEntry){.cdecl.}
    copy_clipboard*: proc (entry: PEntry){.cdecl.}
    paste_clipboard*: proc (entry: PEntry){.cdecl.}
    toggle_overwrite*: proc (entry: PEntry){.cdecl.}
    reserved291: proc (){.cdecl.}
    reserved292: proc (){.cdecl.}
    reserved293: proc (){.cdecl.}
    reserved294: proc (){.cdecl.}

  PEventBox* = ptr TEventBox
  TEventBox* = object of TBin
  PEventBoxClass* = ptr TEventBoxClass
  TEventBoxClass* = object of TBinClass
  PFileSelection* = ptr TFileSelection
  TFileSelection* = object of TDialog
    dir_list*: PWidget
    file_list*: PWidget
    selection_entry*: PWidget
    selection_text*: PWidget
    main_vbox*: PWidget
    ok_button*: PWidget
    cancel_button*: PWidget
    help_button*: PWidget
    history_pulldown*: PWidget
    history_menu*: PWidget
    history_list*: PGList
    fileop_dialog*: PWidget
    fileop_entry*: PWidget
    fileop_file*: Cstring
    cmpl_state*: Gpointer
    fileop_c_dir*: PWidget
    fileop_del_file*: PWidget
    fileop_ren_file*: PWidget
    button_area*: PWidget
    FileSelection_action_area*: PWidget
    selected_names*: PGPtrArray
    last_selected*: Cstring

  PFileSelectionClass* = ptr TFileSelectionClass
  TFileSelectionClass* = object of TDialogClass
    reserved301: proc (){.cdecl.}
    reserved302: proc (){.cdecl.}
    reserved303: proc (){.cdecl.}
    reserved304: proc (){.cdecl.}

  PFixed* = ptr TFixed
  TFixed* = object of TContainer
    children*: PGList

  PFixedClass* = ptr TFixedClass
  TFixedClass* = object of TContainerClass
  PFixedChild* = ptr TFixedChild
  TFixedChild*{.final, pure.} = object 
    widget*: PWidget
    x*: Gint
    y*: Gint

  PFontSelection* = ptr TFontSelection
  TFontSelection* = object of TVBox
    font_entry*: PWidget
    family_list*: PWidget
    font_style_entry*: PWidget
    face_list*: PWidget
    size_entry*: PWidget
    size_list*: PWidget
    pixels_button*: PWidget
    points_button*: PWidget
    filter_button*: PWidget
    preview_entry*: PWidget
    family*: pango.PFontFamily
    face*: pango.PFontFace
    size*: Gint
    font*: gdk2.PFont

  PFontSelectionClass* = ptr TFontSelectionClass
  TFontSelectionClass* = object of TVBoxClass
    reserved311: proc (){.cdecl.}
    reserved312: proc (){.cdecl.}
    reserved313: proc (){.cdecl.}
    reserved314: proc (){.cdecl.}

  PFontSelectionDialog* = ptr TFontSelectionDialog
  TFontSelectionDialog* = object of TDialog
    fontsel*: PWidget
    main_vbox*: PWidget
    FontSelectionDialog_action_area*: PWidget
    ok_button*: PWidget
    apply_button*: PWidget
    cancel_button*: PWidget
    dialog_width*: Gint
    auto_resize*: Gboolean

  PFontSelectionDialogClass* = ptr TFontSelectionDialogClass
  TFontSelectionDialogClass* = object of TDialogClass
    reserved321: proc (){.cdecl.}
    reserved322: proc (){.cdecl.}
    reserved323: proc (){.cdecl.}
    reserved324: proc (){.cdecl.}

  PGammaCurve* = ptr TGammaCurve
  TGammaCurve* = object of TVBox
    table*: PWidget
    curve*: PWidget
    button*: Array[0..4, PWidget]
    gamma*: Gfloat
    gamma_dialog*: PWidget
    gamma_text*: PWidget

  PGammaCurveClass* = ptr TGammaCurveClass
  TGammaCurveClass* = object of TVBoxClass
    reserved331: proc (){.cdecl.}
    reserved332: proc (){.cdecl.}
    reserved333: proc (){.cdecl.}
    reserved334: proc (){.cdecl.}

  PHandleBox* = ptr THandleBox
  THandleBox* = object of TBin
    bin_window*: gdk2.PWindow
    float_window*: gdk2.PWindow
    shadow_type*: TShadowType
    handleBoxFlag0*: Guint16
    deskoff_x*: Gint
    deskoff_y*: Gint
    attach_allocation*: TAllocation
    float_allocation*: TAllocation

  PHandleBoxClass* = ptr THandleBoxClass
  THandleBoxClass* = object of TBinClass
    child_attached*: proc (handle_box: PHandleBox, child: PWidget){.cdecl.}
    child_detached*: proc (handle_box: PHandleBox, child: PWidget){.cdecl.}
    reserved341: proc (){.cdecl.}
    reserved342: proc (){.cdecl.}
    reserved343: proc (){.cdecl.}
    reserved344: proc (){.cdecl.}

  PPaned* = ptr TPaned
  TPaned* = object of TContainer
    child1*: PWidget
    child2*: PWidget
    handle*: gdk2.PWindow
    xor_gc*: gdk2.PGC
    cursor_type*: gdk2.TCursorType
    handle_pos*: gdk2.TRectangle
    child1_size*: Gint
    last_allocation*: Gint
    min_position*: Gint
    max_position*: Gint
    panedFlag0*: Guint16
    last_child1_focus*: PWidget
    last_child2_focus*: PWidget
    saved_focus*: PWidget
    drag_pos*: Gint
    original_position*: Gint

  PPanedClass* = ptr TPanedClass
  TPanedClass* = object of TContainerClass
    cycle_child_focus*: proc (paned: PPaned, reverse: Gboolean): Gboolean{.cdecl.}
    toggle_handle_focus*: proc (paned: PPaned): Gboolean{.cdecl.}
    move_handle*: proc (paned: PPaned, scroll: TScrollType): Gboolean{.cdecl.}
    cycle_handle_focus*: proc (paned: PPaned, reverse: Gboolean): Gboolean{.
        cdecl.}
    accept_position*: proc (paned: PPaned): Gboolean{.cdecl.}
    cancel_position*: proc (paned: PPaned): Gboolean{.cdecl.}
    reserved351: proc (){.cdecl.}
    reserved352: proc (){.cdecl.}
    reserved353: proc (){.cdecl.}
    reserved354: proc (){.cdecl.}

  PHButtonBox* = ptr THButtonBox
  THButtonBox* = object of TButtonBox
  PHButtonBoxClass* = ptr THButtonBoxClass
  THButtonBoxClass* = object of TButtonBoxClass
  PHPaned* = ptr THPaned
  THPaned* = object of TPaned
  PHPanedClass* = ptr THPanedClass
  THPanedClass* = object of TPanedClass
  PRulerMetric* = ptr TRulerMetric
  PRuler* = ptr TRuler
  TRuler* = object of TWidget
    backing_store*: gdk2.PPixmap
    non_gr_exp_gc*: gdk2.PGC
    metric*: PRulerMetric
    xsrc*: Gint
    ysrc*: Gint
    slider_size*: Gint
    lower*: Gdouble
    upper*: Gdouble
    position*: Gdouble
    max_size*: Gdouble

  PRulerClass* = ptr TRulerClass
  TRulerClass* = object of TWidgetClass
    draw_ticks*: proc (ruler: PRuler){.cdecl.}
    draw_pos*: proc (ruler: PRuler){.cdecl.}
    reserved361: proc (){.cdecl.}
    reserved362: proc (){.cdecl.}
    reserved363: proc (){.cdecl.}
    reserved364: proc (){.cdecl.}

  TRulerMetric*{.final, pure.} = object 
    metric_name*: Cstring
    abbrev*: Cstring
    pixels_per_unit*: Gdouble
    ruler_scale*: Array[0..9, Gdouble]
    subdivide*: Array[0..4, Gint]

  PHRuler* = ptr THRuler
  THRuler* = object of TRuler
  PHRulerClass* = ptr THRulerClass
  THRulerClass* = object of TRulerClass
  PRcContext* = Pointer
  PSettings* = ptr TSettings
  TSettings* = object of TGObject
    queued_settings*: PGData
    property_values*: PGValue
    rc_context*: PRcContext
    screen*: gdk2.PScreen

  PSettingsClass* = ptr TSettingsClass
  TSettingsClass* = object of TGObjectClass
  PSettingsValue* = ptr TSettingsValue
  TSettingsValue*{.final, pure.} = object 
    origin*: Cstring
    value*: TGValue

  PRcFlags* = ptr TRcFlags
  TRcFlags* = Int32
  PRcStyle* = ptr TRcStyle
  TRcStyle* = object of TGObject
    name*: Cstring
    bg_pixmap_name*: Array[0..4, Cstring]
    font_desc*: pango.PFontDescription
    color_flags*: Array[0..4, TRcFlags]
    fg*: Array[0..4, gdk2.TColor]
    bg*: Array[0..4, gdk2.TColor]
    text*: Array[0..4, gdk2.TColor]
    base*: Array[0..4, gdk2.TColor]
    xthickness*: Gint
    ythickness*: Gint
    rc_properties*: PGArray
    rc_style_lists*: PGSList
    icon_factories*: PGSList
    rcStyleFlag0*: Guint16

  PRcStyleClass* = ptr TRcStyleClass
  TRcStyleClass* = object of TGObjectClass
    create_rc_style*: proc (rc_style: PRcStyle): PRcStyle{.cdecl.}
    parse*: proc (rc_style: PRcStyle, settings: PSettings, scanner: PGScanner): Guint{.
        cdecl.}
    merge*: proc (dest: PRcStyle, src: PRcStyle){.cdecl.}
    create_style*: proc (rc_style: PRcStyle): PStyle{.cdecl.}
    reserved371: proc (){.cdecl.}
    reserved372: proc (){.cdecl.}
    reserved373: proc (){.cdecl.}
    reserved374: proc (){.cdecl.}

  PRcTokenType* = ptr TRcTokenType
  TRcTokenType* = enum 
    RC_TOKEN_INVALID, RC_TOKEN_INCLUDE, RC_TOKEN_NORMAL, RC_TOKEN_ACTIVE, 
    RC_TOKEN_PRELIGHT, RC_TOKEN_SELECTED, RC_TOKEN_INSENSITIVE, RC_TOKEN_FG, 
    RC_TOKEN_BG, RC_TOKEN_TEXT, RC_TOKEN_BASE, RC_TOKEN_XTHICKNESS, 
    RC_TOKEN_YTHICKNESS, RC_TOKEN_FONT, RC_TOKEN_FONTSET, RC_TOKEN_FONT_NAME, 
    RC_TOKEN_BG_PIXMAP, RC_TOKEN_PIXMAP_PATH, RC_TOKEN_STYLE, RC_TOKEN_BINDING, 
    RC_TOKEN_BIND, RC_TOKEN_WIDGET, RC_TOKEN_WIDGET_CLASS, RC_TOKEN_CLASS, 
    RC_TOKEN_LOWEST, RC_TOKEN_GTK, RC_TOKEN_APPLICATION, RC_TOKEN_THEME, 
    RC_TOKEN_RC, RC_TOKEN_HIGHEST, RC_TOKEN_ENGINE, RC_TOKEN_MODULE_PATH, 
    RC_TOKEN_IM_MODULE_PATH, RC_TOKEN_IM_MODULE_FILE, RC_TOKEN_STOCK, 
    RC_TOKEN_LTR, RC_TOKEN_RTL, RC_TOKEN_LAST
  PRcProperty* = ptr TRcProperty
  TRcProperty*{.final, pure.} = object 
    type_name*: TGQuark
    property_name*: TGQuark
    origin*: Cstring
    value*: TGValue

  PIconSource* = Pointer
  TRcPropertyParser* = proc (pspec: PGParamSpec, rc_string: PGString, 
                             property_value: PGValue): Gboolean{.cdecl.}
  TStyle* = object of TGObject
    fg*: Array[0..4, gdk2.TColor]
    bg*: Array[0..4, gdk2.TColor]
    light*: Array[0..4, gdk2.TColor]
    dark*: Array[0..4, gdk2.TColor]
    mid*: Array[0..4, gdk2.TColor]
    text*: Array[0..4, gdk2.TColor]
    base*: Array[0..4, gdk2.TColor]
    text_aa*: Array[0..4, gdk2.TColor]
    black*: gdk2.TColor
    white*: gdk2.TColor
    font_desc*: pango.PFontDescription
    xthickness*: Gint
    ythickness*: Gint
    fg_gc*: Array[0..4, gdk2.PGC]
    bg_gc*: Array[0..4, gdk2.PGC]
    light_gc*: Array[0..4, gdk2.PGC]
    dark_gc*: Array[0..4, gdk2.PGC]
    mid_gc*: Array[0..4, gdk2.PGC]
    text_gc*: Array[0..4, gdk2.PGC]
    base_gc*: Array[0..4, gdk2.PGC]
    text_aa_gc*: Array[0..4, gdk2.PGC]
    black_gc*: gdk2.PGC
    white_gc*: gdk2.PGC
    bg_pixmap*: Array[0..4, gdk2.PPixmap]
    attachCount*: Gint
    depth*: Gint
    colormap*: gdk2.PColormap
    private_font*: gdk2.PFont
    private_font_desc*: pango.PFontDescription
    rc_style*: PRcStyle
    styles*: PGSList
    property_cache*: PGArray
    icon_factories*: PGSList

  PStyleClass* = ptr TStyleClass
  TStyleClass* = object of TGObjectClass
    realize*: proc (style: PStyle){.cdecl.}
    unrealize*: proc (style: PStyle){.cdecl.}
    copy*: proc (style: PStyle, src: PStyle){.cdecl.}
    clone*: proc (style: PStyle): PStyle{.cdecl.}
    init_from_rc*: proc (style: PStyle, rc_style: PRcStyle){.cdecl.}
    set_background*: proc (style: PStyle, window: gdk2.PWindow, 
                           state_type: TStateType){.cdecl.}
    render_icon*: proc (style: PStyle, source: PIconSource, 
                        direction: TTextDirection, state: TStateType, 
                        size: TIconSize, widget: PWidget, detail: Cstring): gdk2pixbuf.PPixbuf{.
        cdecl.}
    draw_hline*: proc (style: PStyle, window: gdk2.PWindow, 
                       state_type: TStateType, area: gdk2.PRectangle, 
                       widget: PWidget, detail: Cstring, x1: Gint, x2: Gint, 
                       y: Gint){.cdecl.}
    draw_vline*: proc (style: PStyle, window: gdk2.PWindow, 
                       state_type: TStateType, area: gdk2.PRectangle, 
                       widget: PWidget, detail: Cstring, y1: Gint, y2: Gint, 
                       x: Gint){.cdecl.}
    draw_shadow*: proc (style: PStyle, window: gdk2.PWindow, 
                        state_type: TStateType, shadow_type: TShadowType, 
                        area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                        x: Gint, y: Gint, width: Gint, height: Gint){.cdecl.}
    draw_polygon*: proc (style: PStyle, window: gdk2.PWindow, 
                         state_type: TStateType, shadow_type: TShadowType, 
                         area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                         point: gdk2.PPoint, npoints: Gint, fill: Gboolean){.cdecl.}
    draw_arrow*: proc (style: PStyle, window: gdk2.PWindow, 
                       state_type: TStateType, shadow_type: TShadowType, 
                       area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                       arrow_type: TArrowType, fill: Gboolean, x: Gint, y: Gint, 
                       width: Gint, height: Gint){.cdecl.}
    draw_diamond*: proc (style: PStyle, window: gdk2.PWindow, 
                         state_type: TStateType, shadow_type: TShadowType, 
                         area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                         x: Gint, y: Gint, width: Gint, height: Gint){.cdecl.}
    draw_string*: proc (style: PStyle, window: gdk2.PWindow, 
                        state_type: TStateType, area: gdk2.PRectangle, 
                        widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                        `string`: Cstring){.cdecl.}
    draw_box*: proc (style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                     shadow_type: TShadowType, area: gdk2.PRectangle, 
                     widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                     width: Gint, height: Gint){.cdecl.}
    draw_flat_box*: proc (style: PStyle, window: gdk2.PWindow, 
                          state_type: TStateType, shadow_type: TShadowType, 
                          area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                          x: Gint, y: Gint, width: Gint, height: Gint){.cdecl.}
    draw_check*: proc (style: PStyle, window: gdk2.PWindow, 
                       state_type: TStateType, shadow_type: TShadowType, 
                       area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                       x: Gint, y: Gint, width: Gint, height: Gint){.cdecl.}
    draw_option*: proc (style: PStyle, window: gdk2.PWindow, 
                        state_type: TStateType, shadow_type: TShadowType, 
                        area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                        x: Gint, y: Gint, width: Gint, height: Gint){.cdecl.}
    draw_tab*: proc (style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                     shadow_type: TShadowType, area: gdk2.PRectangle, 
                     widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                     width: Gint, height: Gint){.cdecl.}
    draw_shadow_gap*: proc (style: PStyle, window: gdk2.PWindow, 
                            state_type: TStateType, shadow_type: TShadowType, 
                            area: gdk2.PRectangle, widget: PWidget, 
                            detail: Cstring, x: Gint, y: Gint, width: Gint, 
                            height: Gint, gap_side: TPositionType, gap_x: Gint, 
                            gap_width: Gint){.cdecl.}
    draw_box_gap*: proc (style: PStyle, window: gdk2.PWindow, 
                         state_type: TStateType, shadow_type: TShadowType, 
                         area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                         x: Gint, y: Gint, width: Gint, height: Gint, 
                         gap_side: TPositionType, gap_x: Gint, gap_width: Gint){.
        cdecl.}
    draw_extension*: proc (style: PStyle, window: gdk2.PWindow, 
                           state_type: TStateType, shadow_type: TShadowType, 
                           area: gdk2.PRectangle, widget: PWidget, 
                           detail: Cstring, x: Gint, y: Gint, width: Gint, 
                           height: Gint, gap_side: TPositionType){.cdecl.}
    draw_focus*: proc (style: PStyle, window: gdk2.PWindow, 
                       state_type: TStateType, area: gdk2.PRectangle, 
                       widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                       width: Gint, height: Gint){.cdecl.}
    draw_slider*: proc (style: PStyle, window: gdk2.PWindow, 
                        state_type: TStateType, shadow_type: TShadowType, 
                        area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                        x: Gint, y: Gint, width: Gint, height: Gint, 
                        orientation: TOrientation){.cdecl.}
    draw_handle*: proc (style: PStyle, window: gdk2.PWindow, 
                        state_type: TStateType, shadow_type: TShadowType, 
                        area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                        x: Gint, y: Gint, width: Gint, height: Gint, 
                        orientation: TOrientation){.cdecl.}
    draw_expander*: proc (style: PStyle, window: gdk2.PWindow, 
                          state_type: TStateType, area: gdk2.PRectangle, 
                          widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                          expander_style: TExpanderStyle){.cdecl.}
    draw_layout*: proc (style: PStyle, window: gdk2.PWindow, 
                        state_type: TStateType, use_text: Gboolean, 
                        area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                        x: Gint, y: Gint, layout: pango.PLayout){.cdecl.}
    draw_resize_grip*: proc (style: PStyle, window: gdk2.PWindow, 
                             state_type: TStateType, area: gdk2.PRectangle, 
                             widget: PWidget, detail: Cstring, 
                             edge: gdk2.TWindowEdge, x: Gint, y: Gint, 
                             width: Gint, height: Gint){.cdecl.}
    reserved381: proc (){.cdecl.}
    reserved382: proc (){.cdecl.}
    reserved383: proc (){.cdecl.}
    reserved384: proc (){.cdecl.}
    reserved385: proc (){.cdecl.}
    reserved386: proc (){.cdecl.}
    reserved387: proc (){.cdecl.}
    reserved388: proc (){.cdecl.}
    reserved389: proc (){.cdecl.}
    reserved3810: proc (){.cdecl.}
    reserved3811: proc (){.cdecl.}
    reserved3812: proc (){.cdecl.}

  PBorder* = ptr TBorder
  TBorder*{.final, pure.} = object 
    left*: Gint
    right*: Gint
    top*: Gint
    bottom*: Gint

  PRangeLayout* = Pointer
  PRangeStepTimer* = Pointer
  PRange* = ptr TRange
  TRange* = object of TWidget
    adjustment*: PAdjustment
    update_policy*: TUpdateType
    rangeFlag0*: Guint16
    min_slider_size*: Gint
    orientation*: TOrientation
    range_rect*: gdk2.TRectangle
    slider_start*: Gint
    slider_end*: Gint
    round_digits*: Gint
    flag1*: Guint16
    layout*: PRangeLayout
    timer*: PRangeStepTimer
    slide_initial_slider_position*: Gint
    slide_initial_coordinate*: Gint
    update_timeout_id*: Guint
    event_window*: gdk2.PWindow

  PRangeClass* = ptr TRangeClass
  TRangeClass* = object of TWidgetClass
    slider_detail*: Cstring
    stepper_detail*: Cstring
    value_changed*: proc (range: PRange){.cdecl.}
    adjust_bounds*: proc (range: PRange, new_value: Gdouble){.cdecl.}
    move_slider*: proc (range: PRange, scroll: TScrollType){.cdecl.}
    get_range_border*: proc (range: PRange, border: PBorder){.cdecl.}
    reserved401: proc (){.cdecl.}
    reserved402: proc (){.cdecl.}
    reserved403: proc (){.cdecl.}
    reserved404: proc (){.cdecl.}

  PScale* = ptr TScale
  TScale* = object of TRange
    digits*: Gint
    scaleFlag0*: Guint16

  PScaleClass* = ptr TScaleClass
  TScaleClass* = object of TRangeClass
    format_value*: proc (scale: PScale, value: Gdouble): Cstring{.cdecl.}
    draw_value*: proc (scale: PScale){.cdecl.}
    reserved411: proc (){.cdecl.}
    reserved412: proc (){.cdecl.}
    reserved413: proc (){.cdecl.}
    reserved414: proc (){.cdecl.}

  PHScale* = ptr THScale
  THScale* = object of TScale
  PHScaleClass* = ptr THScaleClass
  THScaleClass* = object of TScaleClass
  PScrollbar* = ptr TScrollbar
  TScrollbar* = object of TRange
  PScrollbarClass* = ptr TScrollbarClass
  TScrollbarClass* = object of TRangeClass
    reserved421: proc (){.cdecl.}
    reserved422: proc (){.cdecl.}
    reserved423: proc (){.cdecl.}
    reserved424: proc (){.cdecl.}

  PHScrollbar* = ptr THScrollbar
  THScrollbar* = object of TScrollbar
  PHScrollbarClass* = ptr THScrollbarClass
  THScrollbarClass* = object of TScrollbarClass
  PSeparator* = ptr TSeparator
  TSeparator* = object of TWidget
  PSeparatorClass* = ptr TSeparatorClass
  TSeparatorClass* = object of TWidgetClass
  PHSeparator* = ptr THSeparator
  THSeparator* = object of TSeparator
  PHSeparatorClass* = ptr THSeparatorClass
  THSeparatorClass* = object of TSeparatorClass
  PIconFactory* = ptr TIconFactory
  TIconFactory* = object of TGObject
    icons*: PGHashTable

  PIconFactoryClass* = ptr TIconFactoryClass
  TIconFactoryClass* = object of TGObjectClass
    reserved431: proc (){.cdecl.}
    reserved432: proc (){.cdecl.}
    reserved433: proc (){.cdecl.}
    reserved434: proc (){.cdecl.}

  PIconSet* = Pointer
  PImagePixmapData* = ptr TImagePixmapData
  TImagePixmapData*{.final, pure.} = object 
    pixmap*: gdk2.PPixmap

  PImageImageData* = ptr TImageImageData
  TImageImageData*{.final, pure.} = object 
    image*: gdk2.PImage

  PImagePixbufData* = ptr TImagePixbufData
  TImagePixbufData*{.final, pure.} = object 
    pixbuf*: gdk2pixbuf.PPixbuf

  PImageStockData* = ptr TImageStockData
  TImageStockData*{.final, pure.} = object 
    stock_id*: Cstring

  PImageIconSetData* = ptr TImageIconSetData
  TImageIconSetData*{.final, pure.} = object 
    icon_set*: PIconSet

  PImageAnimationData* = ptr TImageAnimationData
  TImageAnimationData*{.final, pure.} = object 
    anim*: gdk2pixbuf.PPixbufAnimation
    iter*: gdk2pixbuf.PPixbufAnimationIter
    frame_timeout*: Guint

  PImageType* = ptr TImageType
  TImageType* = enum 
    IMAGE_EMPTY, IMAGE_PIXMAP, IMAGE_IMAGE, IMAGE_PIXBUF, IMAGE_STOCK, 
    IMAGE_ICON_SET, IMAGE_ANIMATION
  PImage* = ptr TImage
  TImage* = object of TMisc
    storage_type*: TImageType
    pixmap*: TImagePixmapData
    mask*: gdk2.PBitmap
    icon_size*: TIconSize

  PImageClass* = ptr TImageClass
  TImageClass* = object of TMiscClass
    reserved441: proc (){.cdecl.}
    reserved442: proc (){.cdecl.}
    reserved443: proc (){.cdecl.}
    reserved444: proc (){.cdecl.}

  PImageMenuItem* = ptr TImageMenuItem
  TImageMenuItem* = object of TMenuItem
    image*: PWidget

  PImageMenuItemClass* = ptr TImageMenuItemClass
  TImageMenuItemClass* = object of TMenuItemClass
  PIMContextSimple* = ptr TIMContextSimple
  TIMContextSimple* = object of TIMContext
    tables*: PGSList
    compose_buffer*: Array[0..(MAX_COMPOSE_LEN + 1) - 1, Guint]
    tentative_match*: Gunichar
    tentative_match_len*: Gint
    iMContextSimpleFlag0*: Guint16

  PIMContextSimpleClass* = ptr TIMContextSimpleClass
  TIMContextSimpleClass* = object of TIMContextClass
  PIMMulticontext* = ptr TIMMulticontext
  TIMMulticontext* = object of TIMContext
    slave*: PIMContext
    client_window*: gdk2.PWindow
    context_id*: Cstring

  PIMMulticontextClass* = ptr TIMMulticontextClass
  TIMMulticontextClass* = object of TIMContextClass
    reserved451: proc (){.cdecl.}
    reserved452: proc (){.cdecl.}
    reserved453: proc (){.cdecl.}
    reserved454: proc (){.cdecl.}

  PInputDialog* = ptr TInputDialog
  TInputDialog* = object of TDialog
    axis_list*: PWidget
    axis_listbox*: PWidget
    mode_optionmenu*: PWidget
    close_button*: PWidget
    save_button*: PWidget
    axis_items*: Array[0..(gdk2.AXIS_LAST) - 1, PWidget]
    current_device*: gdk2.PDevice
    keys_list*: PWidget
    keys_listbox*: PWidget

  PInputDialogClass* = ptr TInputDialogClass
  TInputDialogClass* = object of TDialogClass
    enable_device*: proc (inputd: PInputDialog, device: gdk2.PDevice){.cdecl.}
    disable_device*: proc (inputd: PInputDialog, device: gdk2.PDevice){.cdecl.}
    reserved461: proc (){.cdecl.}
    reserved462: proc (){.cdecl.}
    reserved463: proc (){.cdecl.}
    reserved464: proc (){.cdecl.}

  PInvisible* = ptr TInvisible
  TInvisible* = object of TWidget
    has_user_ref_count*: Gboolean
    screen*: gdk2.PScreen

  PInvisibleClass* = ptr TInvisibleClass
  TInvisibleClass* = object of TWidgetClass
    reserved701: proc (){.cdecl.}
    reserved702: proc (){.cdecl.}
    reserved703: proc (){.cdecl.}
    reserved704: proc (){.cdecl.}

  TPrintFunc* = proc (func_data: Gpointer, str: Cstring){.cdecl.}
  PTranslateFunc* = ptr TTranslateFunc
  TTranslateFunc* = Gchar
  TItemFactoryCallback* = proc (){.cdecl.}
  TItemFactoryCallback1* = proc (callback_data: Gpointer, 
                                 callback_action: Guint, widget: PWidget){.cdecl.}
  PItemFactory* = ptr TItemFactory
  TItemFactory* = object of TObject
    path*: Cstring
    accel_group*: PAccelGroup
    widget*: PWidget
    items*: PGSList
    translate_func*: TTranslateFunc
    translate_data*: Gpointer
    translate_notify*: TDestroyNotify

  PItemFactoryClass* = ptr TItemFactoryClass
  TItemFactoryClass* = object of TObjectClass
    item_ht*: PGHashTable
    reserved471: proc (){.cdecl.}
    reserved472: proc (){.cdecl.}
    reserved473: proc (){.cdecl.}
    reserved474: proc (){.cdecl.}

  PItemFactoryEntry* = ptr TItemFactoryEntry
  TItemFactoryEntry*{.final, pure.} = object 
    path*: Cstring
    accelerator*: Cstring
    callback*: TItemFactoryCallback
    callback_action*: Guint
    item_type*: Cstring
    extra_data*: Gconstpointer

  PItemFactoryItem* = ptr TItemFactoryItem
  TItemFactoryItem*{.final, pure.} = object 
    path*: Cstring
    widgets*: PGSList

  PLayout* = ptr TLayout
  TLayout* = object of TContainer
    children*: PGList
    width*: Guint
    height*: Guint
    hadjustment*: PAdjustment
    vadjustment*: PAdjustment
    bin_window*: gdk2.PWindow
    visibility*: gdk2.TVisibilityState
    scroll_x*: Gint
    scroll_y*: Gint
    freeze_count*: Guint

  PLayoutClass* = ptr TLayoutClass
  TLayoutClass* = object of TContainerClass
    set_scroll_adjustments*: proc (layout: PLayout, hadjustment: PAdjustment, 
                                   vadjustment: PAdjustment){.cdecl.}
    reserved481: proc (){.cdecl.}
    reserved482: proc (){.cdecl.}
    reserved483: proc (){.cdecl.}
    reserved484: proc (){.cdecl.}

  PList* = ptr TList
  TList* = object of TContainer
    children*: PGList
    selection*: PGList
    undo_selection*: PGList
    undo_unselection*: PGList
    last_focus_child*: PWidget
    undo_focus_child*: PWidget
    htimer*: Guint
    vtimer*: Guint
    anchor*: Gint
    drag_pos*: Gint
    anchor_state*: TStateType
    listFlag0*: Guint16

  PListClass* = ptr TListClass
  TListClass* = object of TContainerClass
    selection_changed*: proc (list: PList){.cdecl.}
    select_child*: proc (list: PList, child: PWidget){.cdecl.}
    unselect_child*: proc (list: PList, child: PWidget){.cdecl.}

  TTreeModelForeachFunc* = proc (model: PTreeModel, path: PTreePath, 
                                 iter: PTreeIter, data: Gpointer): Gboolean{.
      cdecl.}
  PTreeModelFlags* = ptr TTreeModelFlags
  TTreeModelFlags* = Int32
  TTreeIter*{.final, pure.} = object 
    stamp*: Gint
    user_data*: Gpointer
    user_data2*: Gpointer
    user_data3*: Gpointer

  PTreeModelIface* = ptr TTreeModelIface
  TTreeModelIface* = object of TGTypeInterface
    row_changed*: proc (tree_model: PTreeModel, path: PTreePath, iter: PTreeIter){.
        cdecl.}
    row_inserted*: proc (tree_model: PTreeModel, path: PTreePath, 
                         iter: PTreeIter){.cdecl.}
    row_has_child_toggled*: proc (tree_model: PTreeModel, path: PTreePath, 
                                  iter: PTreeIter){.cdecl.}
    row_deleted*: proc (tree_model: PTreeModel, path: PTreePath){.cdecl.}
    rows_reordered*: proc (tree_model: PTreeModel, path: PTreePath, 
                           iter: PTreeIter, new_order: Pgint){.cdecl.}
    get_flags*: proc (tree_model: PTreeModel): TTreeModelFlags{.cdecl.}
    get_n_columns*: proc (tree_model: PTreeModel): Gint{.cdecl.}
    get_column_type*: proc (tree_model: PTreeModel, index: Gint): GType{.cdecl.}
    get_iter*: proc (tree_model: PTreeModel, iter: PTreeIter, path: PTreePath): Gboolean{.
        cdecl.}
    get_path*: proc (tree_model: PTreeModel, iter: PTreeIter): PTreePath{.cdecl.}
    get_value*: proc (tree_model: PTreeModel, iter: PTreeIter, column: Gint, 
                      value: PGValue){.cdecl.}
    iter_next*: proc (tree_model: PTreeModel, iter: PTreeIter): Gboolean{.cdecl.}
    iter_children*: proc (tree_model: PTreeModel, iter: PTreeIter, 
                          parent: PTreeIter): Gboolean{.cdecl.}
    iter_has_child*: proc (tree_model: PTreeModel, iter: PTreeIter): Gboolean{.
        cdecl.}
    iter_n_children*: proc (tree_model: PTreeModel, iter: PTreeIter): Gint{.
        cdecl.}
    iter_nth_child*: proc (tree_model: PTreeModel, iter: PTreeIter, 
                           parent: PTreeIter, n: Gint): Gboolean{.cdecl.}
    iter_parent*: proc (tree_model: PTreeModel, iter: PTreeIter, 
                        child: PTreeIter): Gboolean{.cdecl.}
    ref_node*: proc (tree_model: PTreeModel, iter: PTreeIter){.cdecl.}
    unref_node*: proc (tree_model: PTreeModel, iter: PTreeIter){.cdecl.}

  PTreeSortable* = Pointer
  TTreeIterCompareFunc* = proc (model: PTreeModel, a: PTreeIter, b: PTreeIter, 
                                user_data: Gpointer): Gint{.cdecl.}
  PTreeSortableIface* = ptr TTreeSortableIface
  TTreeSortableIface* = object of TGTypeInterface
    sort_column_changed*: proc (sortable: PTreeSortable){.cdecl.}
    get_sort_column_id*: proc (sortable: PTreeSortable, sort_column_id: Pgint, 
                               order: PSortType): Gboolean{.cdecl.}
    set_sort_column_id*: proc (sortable: PTreeSortable, sort_column_id: Gint, 
                               order: TSortType){.cdecl.}
    set_sort_func*: proc (sortable: PTreeSortable, sort_column_id: Gint, 
                          func: TTreeIterCompareFunc, data: Gpointer, 
                          destroy: TDestroyNotify){.cdecl.}
    set_default_sort_func*: proc (sortable: PTreeSortable, 
                                  func: TTreeIterCompareFunc, data: Gpointer, 
                                  destroy: TDestroyNotify){.cdecl.}
    has_default_sort_func*: proc (sortable: PTreeSortable): Gboolean{.cdecl.}

  PTreeModelSort* = ptr TTreeModelSort
  TTreeModelSort* = object of TGObject
    root*: Gpointer
    stamp*: Gint
    child_flags*: Guint
    child_model*: PTreeModel
    zero_ref_count*: Gint
    sort_list*: PGList
    sort_column_id*: Gint
    order*: TSortType
    default_sort_func*: TTreeIterCompareFunc
    default_sort_data*: Gpointer
    default_sort_destroy*: TDestroyNotify
    changed_id*: Guint
    inserted_id*: Guint
    has_child_toggled_id*: Guint
    deleted_id*: Guint
    reordered_id*: Guint

  PTreeModelSortClass* = ptr TTreeModelSortClass
  TTreeModelSortClass* = object of TGObjectClass
    reserved491: proc (){.cdecl.}
    reserved492: proc (){.cdecl.}
    reserved493: proc (){.cdecl.}
    reserved494: proc (){.cdecl.}

  PListStore* = ptr TListStore
  TListStore* = object of TGObject
    stamp*: Gint
    root*: Gpointer
    tail*: Gpointer
    sort_list*: PGList
    n_columns*: Gint
    sort_column_id*: Gint
    order*: TSortType
    column_headers*: PGType
    length*: Gint
    default_sort_func*: TTreeIterCompareFunc
    default_sort_data*: Gpointer
    default_sort_destroy*: TDestroyNotify
    listStoreFlag0*: Guint16

  PListStoreClass* = ptr TListStoreClass
  TListStoreClass* = object of TGObjectClass
    reserved501: proc (){.cdecl.}
    reserved502: proc (){.cdecl.}
    reserved503: proc (){.cdecl.}
    reserved504: proc (){.cdecl.}

  TModuleInitFunc* = proc (argc: Pgint, argv: PPPgchar){.cdecl.}
  TKeySnoopFunc* = proc (grab_widget: PWidget, event: gdk2.PEventKey, 
                         func_data: Gpointer): Gint{.cdecl.}
  PMenuBar* = ptr TMenuBar
  TMenuBar* = object of TMenuShell
  PMenuBarClass* = ptr TMenuBarClass
  TMenuBarClass* = object of TMenuShellClass
    reserved511: proc (){.cdecl.}
    reserved512: proc (){.cdecl.}
    reserved513: proc (){.cdecl.}
    reserved514: proc (){.cdecl.}

  PMessageType* = ptr TMessageType
  TMessageType* = enum 
    MESSAGE_INFO, MESSAGE_WARNING, MESSAGE_QUESTION, MESSAGE_ERROR
  PButtonsType* = ptr TButtonsType
  TButtonsType* = enum 
    BUTTONS_NONE, BUTTONS_OK, BUTTONS_CLOSE, BUTTONS_CANCEL, BUTTONS_YES_NO, 
    BUTTONS_OK_CANCEL
  PMessageDialog* = ptr TMessageDialog
  TMessageDialog* = object of TDialog
    image*: PWidget
    label*: PWidget

  PMessageDialogClass* = ptr TMessageDialogClass
  TMessageDialogClass* = object of TDialogClass
    reserved521: proc (){.cdecl.}
    reserved522: proc (){.cdecl.}
    reserved523: proc (){.cdecl.}
    reserved524: proc (){.cdecl.}

  PNotebookPage* = Pointer
  PNotebookTab* = ptr TNotebookTab
  TNotebookTab* = enum 
    NOTEBOOK_TAB_FIRST, NOTEBOOK_TAB_LAST
  PNotebook* = ptr TNotebook
  TNotebook* = object of TContainer
    cur_page*: PNotebookPage
    children*: PGList
    first_tab*: PGList
    focus_tab*: PGList
    menu*: PWidget
    event_window*: gdk2.PWindow
    timer*: Guint32
    tab_hborder*: Guint16
    tab_vborder*: Guint16
    notebookFlag0*: Guint16

  PNotebookClass* = ptr TNotebookClass
  TNotebookClass* = object of TContainerClass
    switch_page*: proc (notebook: PNotebook, page: PNotebookPage, 
                        page_num: Guint){.cdecl.}
    select_page*: proc (notebook: PNotebook, move_focus: Gboolean): Gboolean{.
        cdecl.}
    focus_tab*: proc (notebook: PNotebook, thetype: TNotebookTab): Gboolean{.
        cdecl.}
    change_current_page*: proc (notebook: PNotebook, offset: Gint){.cdecl.}
    move_focus_out*: proc (notebook: PNotebook, direction: TDirectionType){.
        cdecl.}
    reserved531: proc (){.cdecl.}
    reserved532: proc (){.cdecl.}
    reserved533: proc (){.cdecl.}
    reserved534: proc (){.cdecl.}

  POldEditable* = ptr TOldEditable
  TOldEditable* = object of TWidget
    current_pos*: Guint
    selection_start_pos*: Guint
    selection_end_pos*: Guint
    oldEditableFlag0*: Guint16
    clipboard_text*: Cstring

  TTextFunction* = proc (editable: POldEditable, time: Guint32){.cdecl.}
  POldEditableClass* = ptr TOldEditableClass
  TOldEditableClass* = object of TWidgetClass
    activate*: proc (editable: POldEditable){.cdecl.}
    set_editable*: proc (editable: POldEditable, is_editable: Gboolean){.cdecl.}
    move_cursor*: proc (editable: POldEditable, x: Gint, y: Gint){.cdecl.}
    move_word*: proc (editable: POldEditable, n: Gint){.cdecl.}
    move_page*: proc (editable: POldEditable, x: Gint, y: Gint){.cdecl.}
    move_to_row*: proc (editable: POldEditable, row: Gint){.cdecl.}
    move_to_column*: proc (editable: POldEditable, row: Gint){.cdecl.}
    kill_char*: proc (editable: POldEditable, direction: Gint){.cdecl.}
    kill_word*: proc (editable: POldEditable, direction: Gint){.cdecl.}
    kill_line*: proc (editable: POldEditable, direction: Gint){.cdecl.}
    cut_clipboard*: proc (editable: POldEditable){.cdecl.}
    copy_clipboard*: proc (editable: POldEditable){.cdecl.}
    paste_clipboard*: proc (editable: POldEditable){.cdecl.}
    update_text*: proc (editable: POldEditable, start_pos: Gint, end_pos: Gint){.
        cdecl.}
    get_chars*: proc (editable: POldEditable, start_pos: Gint, end_pos: Gint): Cstring{.
        cdecl.}
    set_selection*: proc (editable: POldEditable, start_pos: Gint, end_pos: Gint){.
        cdecl.}
    set_position*: proc (editable: POldEditable, position: Gint){.cdecl.}

  POptionMenu* = ptr TOptionMenu
  TOptionMenu* = object of TButton
    menu*: PWidget
    menu_item*: PWidget
    width*: Guint16
    height*: Guint16

  POptionMenuClass* = ptr TOptionMenuClass
  TOptionMenuClass* = object of TButtonClass
    changed*: proc (option_menu: POptionMenu){.cdecl.}
    reserved541: proc (){.cdecl.}
    reserved542: proc (){.cdecl.}
    reserved543: proc (){.cdecl.}
    reserved544: proc (){.cdecl.}

  PPixmap* = ptr TPixmap
  TPixmap* = object of TMisc
    pixmap*: gdk2.PPixmap
    mask*: gdk2.PBitmap
    pixmap_insensitive*: gdk2.PPixmap
    pixmapFlag0*: Guint16

  PPixmapClass* = ptr TPixmapClass
  TPixmapClass* = object of TMiscClass
  PPlug* = ptr TPlug
  TPlug* = object of TWindow
    socket_window*: gdk2.PWindow
    modality_window*: PWidget
    modality_group*: PWindowGroup
    grabbed_keys*: PGHashTable
    plugFlag0*: Guint16

  PPlugClass* = ptr TPlugClass
  TPlugClass* = object of TWindowClass
    embedded*: proc (plug: PPlug){.cdecl.}
    reserved551: proc (){.cdecl.}
    reserved552: proc (){.cdecl.}
    reserved553: proc (){.cdecl.}
    reserved554: proc (){.cdecl.}

  PPreview* = ptr TPreview
  TPreview* = object of TWidget
    buffer*: Pguchar
    buffer_width*: Guint16
    buffer_height*: Guint16
    bpp*: Guint16
    rowstride*: Guint16
    dither*: gdk2.TRgbDither
    previewFlag0*: Guint16

  PPreviewInfo* = ptr TPreviewInfo
  TPreviewInfo*{.final, pure.} = object 
    lookup*: Pguchar
    gamma*: Gdouble

  PDitherInfo* = ptr TDitherInfo
  TDitherInfo*{.final, pure.} = object 
    c*: Array[0..3, Guchar]

  PPreviewClass* = ptr TPreviewClass
  TPreviewClass* = object of TWidgetClass
    info*: TPreviewInfo

  PProgress* = ptr TProgress
  TProgress* = object of TWidget
    adjustment*: PAdjustment
    offscreen_pixmap*: gdk2.PPixmap
    format*: Cstring
    x_align*: Gfloat
    y_align*: Gfloat
    progressFlag0*: Guint16

  PProgressClass* = ptr TProgressClass
  TProgressClass* = object of TWidgetClass
    paint*: proc (progress: PProgress){.cdecl.}
    update*: proc (progress: PProgress){.cdecl.}
    act_mode_enter*: proc (progress: PProgress){.cdecl.}
    reserved561: proc (){.cdecl.}
    reserved562: proc (){.cdecl.}
    reserved563: proc (){.cdecl.}
    reserved564: proc (){.cdecl.}

  PProgressBarStyle* = ptr TProgressBarStyle
  TProgressBarStyle* = enum 
    PROGRESS_CONTINUOUS, PROGRESS_DISCRETE
  PProgressBarOrientation* = ptr TProgressBarOrientation
  TProgressBarOrientation* = enum 
    PROGRESS_LEFT_TO_RIGHT, PROGRESS_RIGHT_TO_LEFT, PROGRESS_BOTTOM_TO_TOP, 
    PROGRESS_TOP_TO_BOTTOM
  PProgressBar* = ptr TProgressBar
  TProgressBar* = object of TProgress
    bar_style*: TProgressBarStyle
    orientation*: TProgressBarOrientation
    blocks*: Guint
    in_block*: Gint
    activity_pos*: Gint
    activity_step*: Guint
    activity_blocks*: Guint
    pulse_fraction*: Gdouble
    progressBarFlag0*: Guint16

  PProgressBarClass* = ptr TProgressBarClass
  TProgressBarClass* = object of TProgressClass
    reserved571: proc (){.cdecl.}
    reserved572: proc (){.cdecl.}
    reserved573: proc (){.cdecl.}
    reserved574: proc (){.cdecl.}

  PRadioButton* = ptr TRadioButton
  TRadioButton* = object of TCheckButton
    group*: PGSList

  PRadioButtonClass* = ptr TRadioButtonClass
  TRadioButtonClass* = object of TCheckButtonClass
    reserved581: proc (){.cdecl.}
    reserved582: proc (){.cdecl.}
    reserved583: proc (){.cdecl.}
    reserved584: proc (){.cdecl.}

  PRadioMenuItem* = ptr TRadioMenuItem
  TRadioMenuItem* = object of TCheckMenuItem
    group*: PGSList

  PRadioMenuItemClass* = ptr TRadioMenuItemClass
  TRadioMenuItemClass* = object of TCheckMenuItemClass
    reserved591: proc (){.cdecl.}
    reserved592: proc (){.cdecl.}
    reserved593: proc (){.cdecl.}
    reserved594: proc (){.cdecl.}

  PScrolledWindow* = ptr TScrolledWindow
  TScrolledWindow* = object of TBin
    hscrollbar*: PWidget
    vscrollbar*: PWidget
    scrolledWindowFlag0*: Guint16
    shadow_type*: Guint16

  PScrolledWindowClass* = ptr TScrolledWindowClass
  TScrolledWindowClass* = object of TBinClass
    scrollbar_spacing*: Gint
    scroll_child*: proc (scrolled_window: PScrolledWindow, scroll: TScrollType, 
                         horizontal: Gboolean){.cdecl.}
    move_focus_out*: proc (scrolled_window: PScrolledWindow, 
                           direction: TDirectionType){.cdecl.}
    reserved601: proc (){.cdecl.}
    reserved602: proc (){.cdecl.}
    reserved603: proc (){.cdecl.}
    reserved604: proc (){.cdecl.}

  TSelectionData*{.final, pure.} = object 
    selection*: gdk2.TAtom
    target*: gdk2.TAtom
    thetype*: gdk2.TAtom
    format*: Gint
    data*: Pguchar
    length*: Gint
    display*: gdk2.PDisplay

  PTargetEntry* = ptr TTargetEntry
  TTargetEntry*{.final, pure.} = object 
    target*: Cstring
    flags*: Guint
    info*: Guint

  PTargetList* = ptr TTargetList
  TTargetList*{.final, pure.} = object 
    list*: PGList
    ref_count*: Guint

  PTargetPair* = ptr TTargetPair
  TTargetPair*{.final, pure.} = object 
    target*: gdk2.TAtom
    flags*: Guint
    info*: Guint

  PSeparatorMenuItem* = ptr TSeparatorMenuItem
  TSeparatorMenuItem* = object of TMenuItem
  PSeparatorMenuItemClass* = ptr TSeparatorMenuItemClass
  TSeparatorMenuItemClass* = object of TMenuItemClass
  PSizeGroup* = ptr TSizeGroup
  TSizeGroup* = object of TGObject
    widgets*: PGSList
    mode*: Guint8
    sizeGroupFlag0*: Guint16
    requisition*: TRequisition

  PSizeGroupClass* = ptr TSizeGroupClass
  TSizeGroupClass* = object of TGObjectClass
    reserved611: proc (){.cdecl.}
    reserved612: proc (){.cdecl.}
    reserved613: proc (){.cdecl.}
    reserved614: proc (){.cdecl.}

  PSizeGroupMode* = ptr TSizeGroupMode
  TSizeGroupMode* = enum 
    SIZE_GROUP_NONE, SIZE_GROUP_HORIZONTAL, SIZE_GROUP_VERTICAL, SIZE_GROUP_BOTH
  PSocket* = ptr TSocket
  TSocket* = object of TContainer
    request_width*: Guint16
    request_height*: Guint16
    current_width*: Guint16
    current_height*: Guint16
    plug_window*: gdk2.PWindow
    plug_widget*: PWidget
    xembed_version*: Gshort
    socketFlag0*: Guint16
    accel_group*: PAccelGroup
    toplevel*: PWidget

  PSocketClass* = ptr TSocketClass
  TSocketClass* = object of TContainerClass
    plug_added*: proc (socket: PSocket){.cdecl.}
    plug_removed*: proc (socket: PSocket): Gboolean{.cdecl.}
    reserved621: proc (){.cdecl.}
    reserved622: proc (){.cdecl.}
    reserved623: proc (){.cdecl.}
    reserved624: proc (){.cdecl.}

  PSpinButtonUpdatePolicy* = ptr TSpinButtonUpdatePolicy
  TSpinButtonUpdatePolicy* = enum 
    UPDATE_ALWAYS, UPDATE_IF_VALID
  PSpinType* = ptr TSpinType
  TSpinType* = enum 
    SPIN_STEP_FORWARD, SPIN_STEP_BACKWARD, SPIN_PAGE_FORWARD, 
    SPIN_PAGE_BACKWARD, SPIN_HOME, SPIN_END, SPIN_USER_DEFINED
  PSpinButton* = ptr TSpinButton
  TSpinButton* = object of TEntry
    adjustment*: PAdjustment
    panel*: gdk2.PWindow
    timer*: Guint32
    climb_rate*: Gdouble
    timer_step*: Gdouble
    update_policy*: TSpinButtonUpdatePolicy
    spinButtonFlag0*: Int32

  PSpinButtonClass* = ptr TSpinButtonClass
  TSpinButtonClass* = object of TEntryClass
    input*: proc (spin_button: PSpinButton, new_value: Pgdouble): Gint{.cdecl.}
    output*: proc (spin_button: PSpinButton): Gint{.cdecl.}
    value_changed*: proc (spin_button: PSpinButton){.cdecl.}
    change_value*: proc (spin_button: PSpinButton, scroll: TScrollType){.cdecl.}
    reserved631: proc (){.cdecl.}
    reserved632: proc (){.cdecl.}
    reserved633: proc (){.cdecl.}
    reserved634: proc (){.cdecl.}

  PStockItem* = ptr TStockItem
  TStockItem*{.final, pure.} = object 
    stock_id*: Cstring
    label*: Cstring
    modifier*: gdk2.TModifierType
    keyval*: Guint
    translation_domain*: Cstring

  PStatusbar* = ptr TStatusbar
  TStatusbar* = object of THBox
    frame*: PWidget
    `label`*: PWidget
    messages*: PGSList
    keys*: PGSList
    seq_context_id*: Guint
    seq_message_id*: Guint
    grip_window*: gdk2.PWindow
    statusbarFlag0*: Guint16

  PStatusbarClass* = ptr TStatusbarClass
  TStatusbarClass* = object of THBoxClass
    messages_mem_chunk*: PGMemChunk
    text_pushed*: proc (statusbar: PStatusbar, context_id: Guint, text: Cstring){.
        cdecl.}
    text_popped*: proc (statusbar: PStatusbar, context_id: Guint, text: Cstring){.
        cdecl.}
    reserved641: proc (){.cdecl.}
    reserved642: proc (){.cdecl.}
    reserved643: proc (){.cdecl.}
    reserved644: proc (){.cdecl.}

  PTableRowCol* = ptr TTableRowCol
  PTable* = ptr TTable
  TTable* = object of TContainer
    children*: PGList
    rows*: PTableRowCol
    cols*: PTableRowCol
    nrows*: Guint16
    ncols*: Guint16
    column_spacing*: Guint16
    row_spacing*: Guint16
    tableFlag0*: Guint16

  PTableClass* = ptr TTableClass
  TTableClass* = object of TContainerClass
  PTableChild* = ptr TTableChild
  TTableChild*{.final, pure.} = object 
    widget*: PWidget
    left_attach*: Guint16
    right_attach*: Guint16
    top_attach*: Guint16
    bottom_attach*: Guint16
    xpadding*: Guint16
    ypadding*: Guint16
    tableChildFlag0*: Guint16

  TTableRowCol*{.final, pure.} = object 
    requisition*: Guint16
    allocation*: Guint16
    spacing*: Guint16
    flag0*: Guint16

  PTearoffMenuItem* = ptr TTearoffMenuItem
  TTearoffMenuItem* = object of TMenuItem
    tearoffMenuItemFlag0*: Guint16

  PTearoffMenuItemClass* = ptr TTearoffMenuItemClass
  TTearoffMenuItemClass* = object of TMenuItemClass
    reserved651: proc (){.cdecl.}
    reserved652: proc (){.cdecl.}
    reserved653: proc (){.cdecl.}
    reserved654: proc (){.cdecl.}

  PTextFont* = Pointer
  PPropertyMark* = ptr TPropertyMark
  TPropertyMark*{.final, pure.} = object 
    `property`*: PGList
    offset*: Guint
    index*: Guint

  PText* = ptr TText
  TText* = object of TOldEditable
    text_area*: gdk2.PWindow
    hadj*: PAdjustment
    vadj*: PAdjustment
    gc*: gdk2.PGC
    line_wrap_bitmap*: gdk2.PPixmap
    line_arrow_bitmap*: gdk2.PPixmap
    text*: Pguchar
    text_len*: Guint
    gap_position*: Guint
    gap_size*: Guint
    text_end*: Guint
    line_start_cache*: PGList
    first_line_start_index*: Guint
    first_cut_pixels*: Guint
    first_onscreen_hor_pixel*: Guint
    first_onscreen_ver_pixel*: Guint
    textFlag0*: Guint16
    freeze_count*: Guint
    text_properties*: PGList
    text_properties_end*: PGList
    point*: TPropertyMark
    scratch_buffer*: Pguchar
    scratch_buffer_len*: Guint
    last_ver_value*: Gint
    cursor_pos_x*: Gint
    cursor_pos_y*: Gint
    cursor_mark*: TPropertyMark
    cursor_char*: gdk2.TWChar
    cursor_char_offset*: Gchar
    cursor_virtual_x*: Gint
    cursor_drawn_level*: Gint
    current_line*: PGList
    tab_stops*: PGList
    default_tab_width*: Gint
    current_font*: PTextFont
    timer*: Gint
    button*: Guint
    bg_gc*: gdk2.PGC

  PTextClass* = ptr TTextClass
  TTextClass* = object of TOldEditableClass
    set_scroll_adjustments*: proc (text: PText, hadjustment: PAdjustment, 
                                   vadjustment: PAdjustment){.cdecl.}

  PTextSearchFlags* = ptr TTextSearchFlags
  TTextSearchFlags* = Int32
  PTextIter* = ptr TTextIter
  TTextIter*{.final, pure.} = object 
    dummy1*: Gpointer
    dummy2*: Gpointer
    dummy3*: Gint
    dummy4*: Gint
    dummy5*: Gint
    dummy6*: Gint
    dummy7*: Gint
    dummy8*: Gint
    dummy9*: Gpointer
    dummy10*: Gpointer
    dummy11*: Gint
    dummy12*: Gint
    dummy13*: Gint
    dummy14*: Gpointer

  TTextCharPredicate* = proc (ch: Gunichar, user_data: Gpointer): Gboolean{.
      cdecl.}
  PTextTagClass* = ptr TTextTagClass
  PTextAttributes* = ptr TTextAttributes
  PTextTag* = ptr TTextTag
  PPGtkTextTag* = ptr PTextTag
  TTextTag* = object of TGObject
    table*: PTextTagTable
    name*: Cstring
    priority*: Int32
    values*: PTextAttributes
    textTagFlag0*: Int32

  TTextTagClass* = object of TGObjectClass
    event*: proc (tag: PTextTag, event_object: PGObject, event: gdk2.PEvent, 
                  iter: PTextIter): Gboolean{.cdecl.}
    reserved661: proc (){.cdecl.}
    reserved662: proc (){.cdecl.}
    reserved663: proc (){.cdecl.}
    reserved664: proc (){.cdecl.}

  PTextAppearance* = ptr TTextAppearance
  TTextAppearance*{.final, pure.} = object 
    bg_color*: gdk2.TColor
    fg_color*: gdk2.TColor
    bg_stipple*: gdk2.PBitmap
    fg_stipple*: gdk2.PBitmap
    rise*: Gint
    padding1*: Gpointer
    flag0*: Guint16

  TTextAttributes*{.final, pure.} = object 
    refcount*: Guint
    appearance*: TTextAppearance
    justification*: TJustification
    direction*: TTextDirection
    font*: pango.PFontDescription
    font_scale*: Gdouble
    left_margin*: Gint
    indent*: Gint
    right_margin*: Gint
    pixels_above_lines*: Gint
    pixels_below_lines*: Gint
    pixels_inside_wrap*: Gint
    tabs*: pango.PTabArray
    wrap_mode*: TWrapMode
    language*: pango.PLanguage
    padding1*: Gpointer
    flag0*: Guint16

  TTextTagTableForeach* = proc (tag: PTextTag, data: Gpointer){.cdecl.}
  TTextTagTable* = object of TGObject
    hash*: PGHashTable
    anonymous*: PGSList
    anon_count*: Gint
    buffers*: PGSList

  PTextTagTableClass* = ptr TTextTagTableClass
  TTextTagTableClass* = object of TGObjectClass
    tag_changed*: proc (table: PTextTagTable, tag: PTextTag, 
                        size_changed: Gboolean){.cdecl.}
    tag_added*: proc (table: PTextTagTable, tag: PTextTag){.cdecl.}
    tag_removed*: proc (table: PTextTagTable, tag: PTextTag){.cdecl.}
    reserved1: proc (){.cdecl.}
    reserved2: proc (){.cdecl.}
    reserved3: proc (){.cdecl.}
    reserved4: proc (){.cdecl.}

  PTextMark* = ptr TTextMark
  TTextMark* = object of TGObject
    segment*: Gpointer

  PTextMarkClass* = ptr TTextMarkClass
  TTextMarkClass* = object of TGObjectClass
    reserved1: proc (){.cdecl.}
    reserved2: proc (){.cdecl.}
    reserved3: proc (){.cdecl.}
    reserved4: proc (){.cdecl.}

  PTextMarkBody* = ptr TTextMarkBody
  TTextMarkBody*{.final, pure.} = object 
    obj*: PTextMark
    name*: Cstring
    tree*: PTextBTree
    line*: PTextLine
    flag0*: Guint16

  PTextChildAnchor* = ptr TTextChildAnchor
  TTextChildAnchor* = object of TGObject
    segment*: Gpointer

  PTextChildAnchorClass* = ptr TTextChildAnchorClass
  TTextChildAnchorClass* = object of TGObjectClass
    reserved1: proc (){.cdecl.}
    reserved2: proc (){.cdecl.}
    reserved3: proc (){.cdecl.}
    reserved4: proc (){.cdecl.}

  PTextPixbuf* = ptr TTextPixbuf
  TTextPixbuf*{.final, pure.} = object 
    pixbuf*: gdk2pixbuf.PPixbuf

  PTextChildBody* = ptr TTextChildBody
  TTextChildBody*{.final, pure.} = object 
    obj*: PTextChildAnchor
    widgets*: PGSList
    tree*: PTextBTree
    line*: PTextLine

  PTextLineSegment* = ptr TTextLineSegment
  PTextLineSegmentClass* = ptr TTextLineSegmentClass
  PTextTagInfo* = ptr TTextTagInfo
  TTextTagInfo*{.final, pure.} = object 
    tag*: PTextTag
    tag_root*: PTextBTreeNode
    toggle_count*: Gint

  PTextToggleBody* = ptr TTextToggleBody
  TTextToggleBody*{.final, pure.} = object 
    info*: PTextTagInfo
    inNodeCounts*: Gboolean

  TTextLineSegment*{.final, pure.} = object 
    `type`*: PTextLineSegmentClass
    next*: PTextLineSegment
    char_count*: Int32
    byte_count*: Int32
    body*: TTextChildBody

  PTextSegSplitFunc* = ptr TTextSegSplitFunc
  TTextSegSplitFunc* = TTextLineSegment
  TTextSegDeleteFunc* = proc (seg: PTextLineSegment, line: PTextLine, 
                              tree_gone: Gboolean): Gboolean{.cdecl.}
  PTextSegCleanupFunc* = ptr TTextSegCleanupFunc
  TTextSegCleanupFunc* = TTextLineSegment
  TTextSegLineChangeFunc* = proc (seg: PTextLineSegment, line: PTextLine){.cdecl.}
  TTextSegCheckFunc* = proc (seg: PTextLineSegment, line: PTextLine){.cdecl.}
  TTextLineSegmentClass*{.final, pure.} = object 
    name*: Cstring
    leftGravity*: Gboolean
    splitFunc*: TTextSegSplitFunc
    deleteFunc*: TTextSegDeleteFunc
    cleanupFunc*: TTextSegCleanupFunc
    lineChangeFunc*: TTextSegLineChangeFunc
    checkFunc*: TTextSegCheckFunc

  PTextLineData* = ptr TTextLineData
  TTextLineData*{.final, pure.} = object 
    view_id*: Gpointer
    next*: PTextLineData
    height*: Gint
    flag0*: Int32

  TTextLine*{.final, pure.} = object 
    parent*: PTextBTreeNode
    next*: PTextLine
    segments*: PTextLineSegment
    views*: PTextLineData

  PTextLogAttrCache* = Pointer
  PTextBuffer* = ptr TTextBuffer
  TTextBuffer* = object of TGObject
    tag_table*: PTextTagTable
    btree*: PTextBTree
    clipboard_contents_buffers*: PGSList
    selection_clipboards*: PGSList
    log_attr_cache*: PTextLogAttrCache
    user_action_count*: Guint
    textBufferFlag0*: Guint16

  PTextBufferClass* = ptr TTextBufferClass
  TTextBufferClass* = object of TGObjectClass
    insert_text*: proc (buffer: PTextBuffer, pos: PTextIter, text: Cstring, 
                        length: Gint){.cdecl.}
    insert_pixbuf*: proc (buffer: PTextBuffer, pos: PTextIter, 
                          pixbuf: gdk2pixbuf.PPixbuf){.cdecl.}
    insert_child_anchor*: proc (buffer: PTextBuffer, pos: PTextIter, 
                                anchor: PTextChildAnchor){.cdecl.}
    delete_range*: proc (buffer: PTextBuffer, start: PTextIter, 
                         theEnd: PTextIter){.cdecl.}
    changed*: proc (buffer: PTextBuffer){.cdecl.}
    modified_changed*: proc (buffer: PTextBuffer){.cdecl.}
    mark_set*: proc (buffer: PTextBuffer, location: PTextIter, mark: PTextMark){.
        cdecl.}
    mark_deleted*: proc (buffer: PTextBuffer, mark: PTextMark){.cdecl.}
    apply_tag*: proc (buffer: PTextBuffer, tag: PTextTag, start_char: PTextIter, 
                      end_char: PTextIter){.cdecl.}
    remove_tag*: proc (buffer: PTextBuffer, tag: PTextTag, 
                       start_char: PTextIter, end_char: PTextIter){.cdecl.}
    begin_user_action*: proc (buffer: PTextBuffer){.cdecl.}
    end_user_action*: proc (buffer: PTextBuffer){.cdecl.}
    reserved1: proc (){.cdecl.}
    reserved2: proc (){.cdecl.}
    reserved3: proc (){.cdecl.}
    reserved4: proc (){.cdecl.}
    reserved5: proc (){.cdecl.}
    reserved6: proc (){.cdecl.}

  PTextLineDisplay* = ptr TTextLineDisplay
  PTextLayout* = ptr TTextLayout
  TTextLayout* = object of TGObject
    screen_width*: Gint
    width*: Gint
    height*: Gint
    buffer*: PTextBuffer
    default_style*: PTextAttributes
    ltr_context*: pango.PContext
    rtl_context*: pango.PContext
    one_style_cache*: PTextAttributes
    one_display_cache*: PTextLineDisplay
    wrap_loop_count*: Gint
    textLayoutFlag0*: Guint16
    preedit_string*: Cstring
    preedit_attrs*: pango.PAttrList
    preedit_len*: Gint
    preedit_cursor*: Gint

  PTextLayoutClass* = ptr TTextLayoutClass
  TTextLayoutClass* = object of TGObjectClass
    invalidated*: proc (layout: PTextLayout){.cdecl.}
    changed*: proc (layout: PTextLayout, y: Gint, old_height: Gint, 
                    new_height: Gint){.cdecl.}
    wrap*: proc (layout: PTextLayout, line: PTextLine, line_data: PTextLineData): PTextLineData{.
        cdecl.}
    get_log_attrs*: proc (layout: PTextLayout, line: PTextLine, 
                          attrs: var pango.PLogAttr, n_attrs: Pgint){.cdecl.}
    invalidate*: proc (layout: PTextLayout, start: PTextIter, theEnd: PTextIter){.
        cdecl.}
    free_line_data*: proc (layout: PTextLayout, line: PTextLine, 
                           line_data: PTextLineData){.cdecl.}
    allocate_child*: proc (layout: PTextLayout, child: PWidget, x: Gint, y: Gint){.
        cdecl.}
    reserved1: proc (){.cdecl.}
    reserved2: proc (){.cdecl.}
    reserved3: proc (){.cdecl.}
    reserved4: proc (){.cdecl.}

  PTextAttrAppearance* = ptr TTextAttrAppearance
  TTextAttrAppearance*{.final, pure.} = object 
    attr*: pango.TAttribute
    appearance*: TTextAppearance

  PTextCursorDisplay* = ptr TTextCursorDisplay
  TTextCursorDisplay*{.final, pure.} = object 
    x*: Gint
    y*: Gint
    height*: Gint
    flag0*: Guint16

  TTextLineDisplay*{.final, pure.} = object 
    layout*: pango.PLayout
    cursors*: PGSList
    shaped_objects*: PGSList
    direction*: TTextDirection
    width*: Gint
    total_width*: Gint
    height*: Gint
    x_offset*: Gint
    left_margin*: Gint
    right_margin*: Gint
    top_margin*: Gint
    bottom_margin*: Gint
    insert_index*: Gint
    size_only*: Gboolean
    line*: PTextLine

  PTextWindow* = Pointer
  PTextPendingScroll* = Pointer
  PTextWindowType* = ptr TTextWindowType
  TTextWindowType* = enum 
    TEXT_WINDOW_PRIVATE, TEXT_WINDOW_WIDGET, TEXT_WINDOW_TEXT, TEXT_WINDOW_LEFT, 
    TEXT_WINDOW_RIGHT, TEXT_WINDOW_TOP, TEXT_WINDOW_BOTTOM
  PTextView* = ptr TTextView
  TTextView* = object of TContainer
    layout*: PTextLayout
    buffer*: PTextBuffer
    selection_drag_handler*: Guint
    scroll_timeout*: Guint
    pixels_above_lines*: Gint
    pixels_below_lines*: Gint
    pixels_inside_wrap*: Gint
    wrap_mode*: TWrapMode
    justify*: TJustification
    left_margin*: Gint
    right_margin*: Gint
    indent*: Gint
    tabs*: pango.PTabArray
    textViewFlag0*: Guint16
    text_window*: PTextWindow
    left_window*: PTextWindow
    right_window*: PTextWindow
    top_window*: PTextWindow
    bottom_window*: PTextWindow
    hadjustment*: PAdjustment
    vadjustment*: PAdjustment
    xoffset*: Gint
    yoffset*: Gint
    width*: Gint
    height*: Gint
    virtual_cursor_x*: Gint
    virtual_cursor_y*: Gint
    first_para_mark*: PTextMark
    first_para_pixels*: Gint
    dnd_mark*: PTextMark
    blink_timeout*: Guint
    first_validate_idle*: Guint
    incremental_validate_idle*: Guint
    im_context*: PIMContext
    popup_menu*: PWidget
    drag_start_x*: Gint
    drag_start_y*: Gint
    children*: PGSList
    pending_scroll*: PTextPendingScroll
    pending_place_cursor_button*: Gint

  PTextViewClass* = ptr TTextViewClass
  TTextViewClass* = object of TContainerClass
    set_scroll_adjustments*: proc (text_view: PTextView, 
                                   hadjustment: PAdjustment, 
                                   vadjustment: PAdjustment){.cdecl.}
    populate_popup*: proc (text_view: PTextView, menu: PMenu){.cdecl.}
    move_cursor*: proc (text_view: PTextView, step: TMovementStep, count: Gint, 
                        extend_selection: Gboolean){.cdecl.}
    page_horizontally*: proc (text_view: PTextView, count: Gint, 
                              extend_selection: Gboolean){.cdecl.}
    set_anchor*: proc (text_view: PTextView){.cdecl.}
    insert_at_cursor*: proc (text_view: PTextView, str: Cstring){.cdecl.}
    delete_from_cursor*: proc (text_view: PTextView, thetype: TDeleteType, 
                               count: Gint){.cdecl.}
    cut_clipboard*: proc (text_view: PTextView){.cdecl.}
    copy_clipboard*: proc (text_view: PTextView){.cdecl.}
    paste_clipboard*: proc (text_view: PTextView){.cdecl.}
    toggle_overwrite*: proc (text_view: PTextView){.cdecl.}
    move_focus*: proc (text_view: PTextView, direction: TDirectionType){.cdecl.}
    reserved711: proc (){.cdecl.}
    reserved712: proc (){.cdecl.}
    reserved713: proc (){.cdecl.}
    reserved714: proc (){.cdecl.}
    reserved715: proc (){.cdecl.}
    reserved716: proc (){.cdecl.}
    reserved717: proc (){.cdecl.}
    reserved718: proc (){.cdecl.}

  PTipsQuery* = ptr TTipsQuery
  TTipsQuery* = object of TLabel
    tipsQueryFlag0*: Guint16
    label_inactive*: Cstring
    label_no_tip*: Cstring
    caller*: PWidget
    last_crossed*: PWidget
    query_cursor*: gdk2.PCursor

  PTipsQueryClass* = ptr TTipsQueryClass
  TTipsQueryClass* = object of TLabelClass
    start_query*: proc (tips_query: PTipsQuery){.cdecl.}
    stop_query*: proc (tips_query: PTipsQuery){.cdecl.}
    widget_entered*: proc (tips_query: PTipsQuery, widget: PWidget, 
                           tip_text: Cstring, tip_private: Cstring){.cdecl.}
    widget_selected*: proc (tips_query: PTipsQuery, widget: PWidget, 
                            tip_text: Cstring, tip_private: Cstring, 
                            event: gdk2.PEventButton): Gint{.cdecl.}
    reserved721: proc (){.cdecl.}
    reserved722: proc (){.cdecl.}
    reserved723: proc (){.cdecl.}
    reserved724: proc (){.cdecl.}

  PTooltips* = ptr TTooltips
  PTooltipsData* = ptr TTooltipsData
  TTooltipsData*{.final, pure.} = object 
    tooltips*: PTooltips
    widget*: PWidget
    tip_text*: Cstring
    tip_private*: Cstring

  TTooltips* = object of TObject
    tip_window*: PWidget
    tip_label*: PWidget
    active_tips_data*: PTooltipsData
    tips_data_list*: PGList
    tooltipsFlag0*: Int32
    flag1*: Guint16
    timer_tag*: Gint
    last_popdown*: TGTimeVal

  PTooltipsClass* = ptr TTooltipsClass
  TTooltipsClass* = object of TObjectClass
    reserved1: proc (){.cdecl.}
    reserved2: proc (){.cdecl.}
    reserved3: proc (){.cdecl.}
    reserved4: proc (){.cdecl.}

  PToolbarChildType* = ptr TToolbarChildType
  TToolbarChildType* = enum 
    TOOLBAR_CHILD_SPACE, TOOLBAR_CHILD_BUTTON, TOOLBAR_CHILD_TOGGLEBUTTON, 
    TOOLBAR_CHILD_RADIOBUTTON, TOOLBAR_CHILD_WIDGET
  PToolbarSpaceStyle* = ptr TToolbarSpaceStyle
  TToolbarSpaceStyle* = enum 
    TOOLBAR_SPACE_EMPTY, TOOLBAR_SPACE_LINE
  PToolbarChild* = ptr TToolbarChild
  TToolbarChild*{.final, pure.} = object 
    `type`*: TToolbarChildType
    widget*: PWidget
    icon*: PWidget
    label*: PWidget

  PToolbar* = ptr TToolbar
  TToolbar* = object of TContainer
    num_children*: Gint
    children*: PGList
    orientation*: TOrientation
    Toolbar_style*: TToolbarStyle
    icon_size*: TIconSize
    tooltips*: PTooltips
    button_maxw*: Gint
    button_maxh*: Gint
    style_set_connection*: Guint
    icon_size_connection*: Guint
    toolbarFlag0*: Guint16

  PToolbarClass* = ptr TToolbarClass
  TToolbarClass* = object of TContainerClass
    orientation_changed*: proc (toolbar: PToolbar, orientation: TOrientation){.
        cdecl.}
    style_changed*: proc (toolbar: PToolbar, style: TToolbarStyle){.cdecl.}
    reserved731: proc (){.cdecl.}
    reserved732: proc (){.cdecl.}
    reserved733: proc (){.cdecl.}
    reserved734: proc (){.cdecl.}

  PTreeViewMode* = ptr TTreeViewMode
  TTreeViewMode* = enum 
    TREE_VIEW_LINE, TREE_VIEW_ITEM
  PTree* = ptr TTree
  TTree* = object of TContainer
    children*: PGList
    rootTree*: PTree
    tree_owner*: PWidget
    selection*: PGList
    level*: Guint
    indent_value*: Guint
    current_indent*: Guint
    treeFlag0*: Guint16

  PTreeClass* = ptr TTreeClass
  TTreeClass* = object of TContainerClass
    selection_changed*: proc (tree: PTree){.cdecl.}
    select_child*: proc (tree: PTree, child: PWidget){.cdecl.}
    unselect_child*: proc (tree: PTree, child: PWidget){.cdecl.}

  PTreeDragSource* = Pointer
  PTreeDragDest* = Pointer
  PTreeDragSourceIface* = ptr TTreeDragSourceIface
  TTreeDragSourceIface* = object of TGTypeInterface
    row_draggable*: proc (drag_source: PTreeDragSource, path: PTreePath): Gboolean{.
        cdecl.}
    drag_data_get*: proc (drag_source: PTreeDragSource, path: PTreePath, 
                          selection_data: PSelectionData): Gboolean{.cdecl.}
    drag_data_delete*: proc (drag_source: PTreeDragSource, path: PTreePath): Gboolean{.
        cdecl.}

  PTreeDragDestIface* = ptr TTreeDragDestIface
  TTreeDragDestIface* = object of TGTypeInterface
    drag_data_received*: proc (drag_dest: PTreeDragDest, dest: PTreePath, 
                               selection_data: PSelectionData): Gboolean{.cdecl.}
    row_drop_possible*: proc (drag_dest: PTreeDragDest, dest_path: PTreePath, 
                              selection_data: PSelectionData): Gboolean{.cdecl.}

  PTreeItem* = ptr TTreeItem
  TTreeItem* = object of TItem
    subtree*: PWidget
    pixmaps_box*: PWidget
    plus_pix_widget*: PWidget
    minus_pix_widget*: PWidget
    pixmaps*: PGList
    treeItemFlag0*: Guint16

  PTreeItemClass* = ptr TTreeItemClass
  TTreeItemClass* = object of TItemClass
    expand*: proc (tree_item: PTreeItem){.cdecl.}
    collapse*: proc (tree_item: PTreeItem){.cdecl.}

  PTreeSelection* = ptr TTreeSelection
  TTreeSelectionFunc* = proc (selection: PTreeSelection, model: PTreeModel, 
                              path: PTreePath, 
                              path_currently_selected: Gboolean, data: Gpointer): Gboolean{.
      cdecl.}
  TTreeSelectionForeachFunc* = proc (model: PTreeModel, path: PTreePath, 
                                     iter: PTreeIter, data: Gpointer){.cdecl.}
  TTreeSelection* = object of TGObject
    tree_view*: PTreeView
    thetype*: TSelectionMode
    user_func*: TTreeSelectionFunc
    user_data*: Gpointer
    destroy*: TDestroyNotify

  PTreeSelectionClass* = ptr TTreeSelectionClass
  TTreeSelectionClass* = object of TGObjectClass
    changed*: proc (selection: PTreeSelection){.cdecl.}
    reserved741: proc (){.cdecl.}
    reserved742: proc (){.cdecl.}
    reserved743: proc (){.cdecl.}
    reserved744: proc (){.cdecl.}

  PTreeStore* = ptr TTreeStore
  TTreeStore* = object of TGObject
    stamp*: Gint
    root*: Gpointer
    last*: Gpointer
    n_columns*: Gint
    sort_column_id*: Gint
    sort_list*: PGList
    order*: TSortType
    column_headers*: PGType
    default_sort_func*: TTreeIterCompareFunc
    default_sort_data*: Gpointer
    default_sort_destroy*: TDestroyNotify
    treeStoreFlag0*: Guint16

  PTreeStoreClass* = ptr TTreeStoreClass
  TTreeStoreClass* = object of TGObjectClass
    reserved751: proc (){.cdecl.}
    reserved752: proc (){.cdecl.}
    reserved753: proc (){.cdecl.}
    reserved754: proc (){.cdecl.}

  PTreeViewColumnSizing* = ptr TTreeViewColumnSizing
  TTreeViewColumnSizing* = enum 
    TREE_VIEW_COLUMN_GROW_ONLY, TREE_VIEW_COLUMN_AUTOSIZE, 
    TREE_VIEW_COLUMN_FIXED
  TTreeCellDataFunc* = proc (tree_column: PTreeViewColumn, cell: PCellRenderer, 
                             tree_model: PTreeModel, iter: PTreeIter, 
                             data: Gpointer){.cdecl.}
  TTreeViewColumn* = object of TObject
    tree_view*: PWidget
    button*: PWidget
    child*: PWidget
    arrow*: PWidget
    alignment*: PWidget
    window*: gdk2.PWindow
    editable_widget*: PCellEditable
    xalign*: Gfloat
    property_changed_signal*: Guint
    spacing*: Gint
    column_type*: TTreeViewColumnSizing
    requestedWidth*: Gint
    button_request*: Gint
    resized_width*: Gint
    width*: Gint
    fixed_width*: Gint
    minWidth*: Gint
    maxWidth*: Gint
    drag_x*: Gint
    drag_y*: Gint
    title*: Cstring
    cell_list*: PGList
    sort_clicked_signal*: Guint
    sort_column_changed_signal*: Guint
    sort_column_id*: Gint
    sort_order*: TSortType
    treeViewColumnFlag0*: Guint16

  PTreeViewColumnClass* = ptr TTreeViewColumnClass
  TTreeViewColumnClass* = object of TObjectClass
    clicked*: proc (tree_column: PTreeViewColumn){.cdecl.}
    reserved751: proc (){.cdecl.}
    reserved752: proc (){.cdecl.}
    reserved753: proc (){.cdecl.}
    reserved754: proc (){.cdecl.}

  PRBNodeColor* = ptr TRBNodeColor
  TRBNodeColor* = Int32
  PRBTree* = ptr TRBTree
  PRBNode* = ptr TRBNode
  TRBTreeTraverseFunc* = proc (tree: PRBTree, node: PRBNode, data: Gpointer){.
      cdecl.}
  TRBTree*{.final, pure.} = object 
    root*: PRBNode
    `nil`*: PRBNode
    parent_tree*: PRBTree
    parent_node*: PRBNode

  TRBNode*{.final, pure.} = object 
    flag0*: Guint16
    left*: PRBNode
    right*: PRBNode
    parent*: PRBNode
    count*: Gint
    offset*: Gint
    children*: PRBTree

  PTreeRowReference* = Pointer
  PTreeViewFlags* = ptr TTreeViewFlags
  TTreeViewFlags* = Int32
  TTreeViewSearchDialogPositionFunc* = proc (tree_view: PTreeView, 
      search_dialog: PWidget){.cdecl.}
  PTreeViewColumnReorder* = ptr TTreeViewColumnReorder
  TTreeViewColumnReorder*{.final, pure.} = object 
    left_align*: Gint
    right_align*: Gint
    left_column*: PTreeViewColumn
    right_column*: PTreeViewColumn

  PTreeViewPrivate* = ptr TTreeViewPrivate
  TTreeViewPrivate*{.final, pure.} = object 
    model*: PTreeModel
    flags*: Guint
    tree*: PRBTree
    button_pressed_node*: PRBNode
    button_pressed_tree*: PRBTree
    children*: PGList
    width*: Gint
    height*: Gint
    expander_size*: Gint
    hadjustment*: PAdjustment
    vadjustment*: PAdjustment
    bin_window*: gdk2.PWindow
    header_window*: gdk2.PWindow
    drag_window*: gdk2.PWindow
    drag_highlight_window*: gdk2.PWindow
    drag_column*: PTreeViewColumn
    last_button_press*: PTreeRowReference
    last_button_press_2*: PTreeRowReference
    top_row*: PTreeRowReference
    top_row_dy*: Gint
    dy*: Gint
    drag_column_x*: Gint
    expander_column*: PTreeViewColumn
    edited_column*: PTreeViewColumn
    presize_handler_timer*: Guint
    validate_rows_timer*: Guint
    scroll_sync_timer*: Guint
    focus_column*: PTreeViewColumn
    anchor*: PTreeRowReference
    cursor*: PTreeRowReference
    drag_pos*: Gint
    x_drag*: Gint
    prelight_node*: PRBNode
    prelight_tree*: PRBTree
    expanded_collapsed_node*: PRBNode
    expanded_collapsed_tree*: PRBTree
    expand_collapse_timeout*: Guint
    selection*: PTreeSelection
    n_columns*: Gint
    columns*: PGList
    headerHeight*: Gint
    column_drop_func*: TTreeViewColumnDropFunc
    column_drop_func_data*: Gpointer
    column_drop_func_data_destroy*: TDestroyNotify
    column_drag_info*: PGList
    cur_reorder*: PTreeViewColumnReorder
    destroy_count_func*: TTreeDestroyCountFunc
    destroy_count_data*: Gpointer
    destroy_count_destroy*: TDestroyNotify
    scroll_timeout*: Guint
    drag_dest_row*: PTreeRowReference
    drag_dest_pos*: TTreeViewDropPosition
    open_dest_timeout*: Guint
    pressed_button*: Gint
    press_start_x*: Gint
    press_start_y*: Gint
    scroll_to_path*: PTreeRowReference
    scroll_to_column*: PTreeViewColumn
    scroll_to_row_align*: Gfloat
    scroll_to_col_align*: Gfloat
    flag0*: Guint16
    search_column*: Gint
    search_dialog_position_func*: TTreeViewSearchDialogPositionFunc
    search_equal_func*: TTreeViewSearchEqualFunc
    search_user_data*: Gpointer
    search_destroy*: TDestroyNotify

  TTreeView* = object of TContainer
    priv*: PTreeViewPrivate

  PTreeViewClass* = ptr TTreeViewClass
  TTreeViewClass* = object of TContainerClass
    set_scroll_adjustments*: proc (tree_view: PTreeView, 
                                   hadjustment: PAdjustment, 
                                   vadjustment: PAdjustment){.cdecl.}
    row_activated*: proc (tree_view: PTreeView, path: PTreePath, 
                          column: PTreeViewColumn){.cdecl.}
    test_expand_row*: proc (tree_view: PTreeView, iter: PTreeIter, 
                            path: PTreePath): Gboolean{.cdecl.}
    test_collapse_row*: proc (tree_view: PTreeView, iter: PTreeIter, 
                              path: PTreePath): Gboolean{.cdecl.}
    row_expanded*: proc (tree_view: PTreeView, iter: PTreeIter, path: PTreePath){.
        cdecl.}
    row_collapsed*: proc (tree_view: PTreeView, iter: PTreeIter, path: PTreePath){.
        cdecl.}
    columns_changed*: proc (tree_view: PTreeView){.cdecl.}
    cursor_changed*: proc (tree_view: PTreeView){.cdecl.}
    move_cursor*: proc (tree_view: PTreeView, step: TMovementStep, count: Gint): Gboolean{.
        cdecl.}
    select_all*: proc (tree_view: PTreeView){.cdecl.}
    unselect_all*: proc (tree_view: PTreeView){.cdecl.}
    select_cursor_row*: proc (tree_view: PTreeView, start_editing: Gboolean){.
        cdecl.}
    toggle_cursor_row*: proc (tree_view: PTreeView){.cdecl.}
    expand_collapse_cursor_row*: proc (tree_view: PTreeView, logical: Gboolean, 
                                       expand: Gboolean, open_all: Gboolean){.
        cdecl.}
    select_cursor_parent*: proc (tree_view: PTreeView){.cdecl.}
    start_interactive_search*: proc (tree_view: PTreeView){.cdecl.}
    reserved760: proc (){.cdecl.}
    reserved761: proc (){.cdecl.}
    reserved762: proc (){.cdecl.}
    reserved763: proc (){.cdecl.}
    reserved764: proc (){.cdecl.}

  PVButtonBox* = ptr TVButtonBox
  TVButtonBox* = object of TButtonBox
  PVButtonBoxClass* = ptr TVButtonBoxClass
  TVButtonBoxClass* = object of TButtonBoxClass
  PViewport* = ptr TViewport
  TViewport* = object of TBin
    shadow_type*: TShadowType
    view_window*: gdk2.PWindow
    bin_window*: gdk2.PWindow
    hadjustment*: PAdjustment
    vadjustment*: PAdjustment

  PViewportClass* = ptr TViewportClass
  TViewportClass* = object of TBinClass
    set_scroll_adjustments*: proc (viewport: PViewport, 
                                   hadjustment: PAdjustment, 
                                   vadjustment: PAdjustment){.cdecl.}

  PVPaned* = ptr TVPaned
  TVPaned* = object of TPaned
  PVPanedClass* = ptr TVPanedClass
  TVPanedClass* = object of TPanedClass
  PVRuler* = ptr TVRuler
  TVRuler* = object of TRuler
  PVRulerClass* = ptr TVRulerClass
  TVRulerClass* = object of TRulerClass
  PVScale* = ptr TVScale
  TVScale* = object of TScale
  PVScaleClass* = ptr TVScaleClass
  TVScaleClass* = object of TScaleClass
  PVScrollbar* = ptr TVScrollbar
  TVScrollbar* = object of TScrollbar
  PVScrollbarClass* = ptr TVScrollbarClass
  TVScrollbarClass* = object of TScrollbarClass
  PVSeparator* = ptr TVSeparator
  TVSeparator* = object of TSeparator
  PVSeparatorClass* = ptr TVSeparatorClass
  TVSeparatorClass* = object of TSeparatorClass

const 
  InDestruction* = 1 shl 0
  Floating* = 1 shl 1
  Reserved1* = 1 shl 2
  Reserved2* = 1 shl 3
  ArgReadable* = G_PARAM_READABLE
  ArgWritable* = G_PARAM_WRITABLE
  ArgConstruct* = G_PARAM_CONSTRUCT
  ArgConstructOnly* = G_PARAM_CONSTRUCT_ONLY
  ArgChildArg* = 1 shl 4

proc typeObject*(): GType
proc `object`*(anObject: Pointer): PObject
proc objectClass*(klass: Pointer): PObjectClass
proc isObject*(anObject: Pointer): Bool
proc isObjectClass*(klass: Pointer): Bool
proc objectGetClass*(anObject: Pointer): PObjectClass
proc objectType*(anObject: Pointer): GType
proc objectTypeName*(anObject: Pointer): Cstring
proc objectFlags*(obj: Pointer): Guint32
proc objectFloating*(obj: Pointer): Gboolean
proc objectSetFlags*(obj: Pointer, flag: Guint32)
proc objectUnsetFlags*(obj: Pointer, flag: Guint32)
proc objectGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_object_get_type".}
proc objectNew*(thetype: TType, first_property_name: Cstring): PObject{.cdecl, 
    varargs, dynlib: lib, importc: "gtk_object_new".}
proc sink*(anObject: PObject){.cdecl, dynlib: lib, 
                                      importc: "gtk_object_sink".}
proc destroy*(anObject: PObject){.cdecl, dynlib: lib, 
    importc: "gtk_object_destroy".}
const 
  TypeInvalid* = G_TYPE_INVALID
  TypeNone* = G_TYPE_NONE
  TypeEnum* = G_TYPE_ENUM
  TypeFlags* = G_TYPE_FLAGS
  TypeChar* = G_TYPE_CHAR
  TypeUchar* = G_TYPE_UCHAR
  TypeBool* = G_TYPE_BOOLEAN
  TypeInt* = G_TYPE_INT
  TypeUint* = G_TYPE_UINT
  TypeLong* = G_TYPE_LONG
  TypeUlong* = G_TYPE_ULONG
  TypeFloat* = G_TYPE_FLOAT
  TypeDouble* = G_TYPE_DOUBLE
  TypeString* = G_TYPE_STRING
  TypeBoxed* = G_TYPE_BOXED
  TypePointer* = G_TYPE_POINTER

proc typeIdentifier*(): GType
proc identifierGetType*(): GType{.cdecl, dynlib: lib, 
                                    importc: "gtk_identifier_get_type".}
proc signalFunc*(f: Pointer): TSignalFunc
proc typeClass*(thetype: TType): Gpointer{.cdecl, dynlib: lib, 
    importc: "gtk_type_class".}
const 
  Toplevel* = 1 shl 4
  NoWindow* = 1 shl 5
  constREALIZED* = 1 shl 6
  Mapped* = 1 shl 7
  constVISIBLE* = 1 shl 8
  Sensitive* = 1 shl 9
  ParentSensitive* = 1 shl 10
  CanFocus* = 1 shl 11
  constHASFOCUS* = 1 shl 12
  CanDefault* = 1 shl 13
  HasDefault* = 1 shl 14
  HasGrab* = 1 shl 15
  RcStyle* = 1 shl 16
  CompositeChild* = 1 shl 17
  NoReparent* = 1 shl 18
  AppPaintable* = 1 shl 19
  ReceivesDefault* = 1 shl 20
  DoubleBuffered* = 1 shl 21

const 
  bmTGtkWidgetAuxInfoXSet* = 0x0001'i16
  bpTGtkWidgetAuxInfoXSet* = 0'i16
  bmTGtkWidgetAuxInfoYSet* = 0x0002'i16
  bpTGtkWidgetAuxInfoYSet* = 1'i16

proc typeWidget*(): GType
proc widget*(widget: Pointer): PWidget
proc widgetClass*(klass: Pointer): PWidgetClass
proc isWidget*(widget: Pointer): Bool
proc isWidgetClass*(klass: Pointer): Bool
proc widgetGetClass*(obj: Pointer): PWidgetClass
proc widgetType*(wid: Pointer): GType
proc widgetState*(wid: Pointer): Int32
proc widgetSavedState*(wid: Pointer): Int32
proc widgetFlags*(wid: Pointer): Guint32
proc widgetToplevel*(wid: Pointer): Gboolean
proc widgetNoWindow*(wid: Pointer): Gboolean
proc widgetRealized*(wid: Pointer): Gboolean
proc widgetMapped*(wid: Pointer): Gboolean
proc widgetVisible*(wid: Pointer): Gboolean
proc widgetDrawable*(wid: Pointer): Gboolean
proc widgetSensitive*(wid: Pointer): Gboolean
proc widgetParentSensitive*(wid: Pointer): Gboolean
proc widgetIsSensitive*(wid: Pointer): Gboolean
proc widgetCanFocus*(wid: Pointer): Gboolean
proc widgetHasFocus*(wid: Pointer): Gboolean
proc widgetCanDefault*(wid: Pointer): Gboolean
proc widgetHasDefault*(wid: Pointer): Gboolean
proc widgetHasGrab*(wid: Pointer): Gboolean
proc widgetRcStyle*(wid: Pointer): Gboolean
proc widgetCompositeChild*(wid: Pointer): Gboolean
proc widgetAppPaintable*(wid: Pointer): Gboolean
proc widgetReceivesDefault*(wid: Pointer): Gboolean
proc widgetDoubleBuffered*(wid: Pointer): Gboolean
proc setFlags*(wid: PWidget, flags: TWidgetFlags): TWidgetFlags
proc unsetFlags*(wid: PWidget, flags: TWidgetFlags): TWidgetFlags
proc typeRequisition*(): GType
proc xSet*(a: PWidgetAuxInfo): Guint
proc setXSet*(a: PWidgetAuxInfo, x_set: Guint)
proc ySet*(a: PWidgetAuxInfo): Guint
proc setYSet*(a: PWidgetAuxInfo, y_set: Guint)
proc widgetGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_widget_get_type".}
proc reference*(widget: PWidget): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_widget_ref".}
proc unref*(widget: PWidget){.cdecl, dynlib: lib, 
                                     importc: "gtk_widget_unref".}
proc destroy*(widget: PWidget){.cdecl, dynlib: lib, 
                                       importc: "gtk_widget_destroy".}
proc destroyed*(widget: PWidget, r: var PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_destroyed".}
proc unparent*(widget: PWidget){.cdecl, dynlib: lib, 
                                        importc: "gtk_widget_unparent".}
proc show*(widget: PWidget){.cdecl, dynlib: lib, 
                                    importc: "gtk_widget_show".}
proc showNow*(widget: PWidget){.cdecl, dynlib: lib, 
                                        importc: "gtk_widget_show_now".}
proc hide*(widget: PWidget){.cdecl, dynlib: lib, 
                                    importc: "gtk_widget_hide".}
proc showAll*(widget: PWidget){.cdecl, dynlib: lib, 
                                        importc: "gtk_widget_show_all".}
proc hideAll*(widget: PWidget){.cdecl, dynlib: lib, 
                                        importc: "gtk_widget_hide_all".}
proc map*(widget: PWidget){.cdecl, dynlib: lib, importc: "gtk_widget_map".}
proc unmap*(widget: PWidget){.cdecl, dynlib: lib, 
                                     importc: "gtk_widget_unmap".}
proc realize*(widget: PWidget){.cdecl, dynlib: lib, 
                                       importc: "gtk_widget_realize".}
proc unrealize*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_unrealize".}
proc queueDraw*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_queue_draw".}
proc queueDrawArea*(widget: PWidget, x: Gint, y: Gint, width: Gint, 
                             height: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_widget_queue_draw_area".}
proc queueResize*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_queue_resize".}
proc sizeRequest*(widget: PWidget, requisition: PRequisition){.cdecl, 
    dynlib: lib, importc: "gtk_widget_size_request".}
proc sizeAllocate*(widget: PWidget, allocation: PAllocation){.cdecl, 
    dynlib: lib, importc: "gtk_widget_size_allocate".}
proc getChildRequisition*(widget: PWidget, requisition: PRequisition){.
    cdecl, dynlib: lib, importc: "gtk_widget_get_child_requisition".}
proc addAccelerator*(widget: PWidget, accel_signal: Cstring, 
                             accel_group: PAccelGroup, accel_key: Guint, 
                             accel_mods: gdk2.TModifierType, 
                             accel_flags: TAccelFlags){.cdecl, dynlib: lib, 
    importc: "gtk_widget_add_accelerator".}
proc removeAccelerator*(widget: PWidget, accel_group: PAccelGroup, 
                                accel_key: Guint, accel_mods: gdk2.TModifierType): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_widget_remove_accelerator".}
proc setAccelPath*(widget: PWidget, accel_path: Cstring, 
                            accel_group: PAccelGroup){.cdecl, dynlib: lib, 
    importc: "gtk_widget_set_accel_path".}
proc getAccelPath*(widget: PWidget, locked: Pgboolean): Cstring{.cdecl, 
    dynlib: lib, importc: "_gtk_widget_get_accel_path".}
proc listAccelClosures*(widget: PWidget): PGList{.cdecl, dynlib: lib, 
    importc: "gtk_widget_list_accel_closures".}
proc mnemonicActivate*(widget: PWidget, group_cycling: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_widget_mnemonic_activate".}
proc event*(widget: PWidget, event: gdk2.PEvent): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_widget_event".}
proc sendExpose*(widget: PWidget, event: gdk2.PEvent): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_widget_send_expose".}
proc activate*(widget: PWidget): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_widget_activate".}
proc setScrollAdjustments*(widget: PWidget, hadjustment: PAdjustment, 
                                    vadjustment: PAdjustment): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_widget_set_scroll_adjustments".}
proc reparent*(widget: PWidget, new_parent: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_reparent".}
proc intersect*(widget: PWidget, area: gdk2.PRectangle, 
                       intersection: gdk2.PRectangle): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_widget_intersect".}
proc regionIntersect*(widget: PWidget, region: gdk2.PRegion): gdk2.PRegion{.
    cdecl, dynlib: lib, importc: "gtk_widget_region_intersect".}
proc freezeChildNotify*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_freeze_child_notify".}
proc childNotify*(widget: PWidget, child_property: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_widget_child_notify".}
proc thawChildNotify*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_thaw_child_notify".}
proc isFocus*(widget: PWidget): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_widget_is_focus".}
proc grabFocus*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_grab_focus".}
proc grabDefault*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_grab_default".}
proc setName*(widget: PWidget, name: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_widget_set_name".}
proc getName*(widget: PWidget): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_name".}
proc setState*(widget: PWidget, state: TStateType){.cdecl, dynlib: lib, 
    importc: "gtk_widget_set_state".}
proc setSensitive*(widget: PWidget, sensitive: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_widget_set_sensitive".}
proc setAppPaintable*(widget: PWidget, app_paintable: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_widget_set_app_paintable".}
proc setDoubleBuffered*(widget: PWidget, double_buffered: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_widget_set_double_buffered".}
proc setRedrawOnAllocate*(widget: PWidget, 
                                    redraw_on_allocate: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_widget_set_redraw_on_allocate".}
proc setParent*(widget: PWidget, parent: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_set_parent".}
proc setParentWindow*(widget: PWidget, parent_window: gdk2.PWindow){.
    cdecl, dynlib: lib, importc: "gtk_widget_set_parent_window".}
proc setChildVisible*(widget: PWidget, is_visible: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_widget_set_child_visible".}
proc getChildVisible*(widget: PWidget): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_child_visible".}
proc getParent*(widget: PWidget): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_parent".}
proc getParentWindow*(widget: PWidget): gdk2.PWindow{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_parent_window".}
proc childFocus*(widget: PWidget, direction: TDirectionType): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_widget_child_focus".}
proc setSizeRequest*(widget: PWidget, width: Gint, height: Gint){.
    cdecl, dynlib: lib, importc: "gtk_widget_set_size_request".}
proc getSizeRequest*(widget: PWidget, width: Pgint, height: Pgint){.
    cdecl, dynlib: lib, importc: "gtk_widget_get_size_request".}
proc setEvents*(widget: PWidget, events: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_widget_set_events".}
proc addEvents*(widget: PWidget, events: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_widget_add_events".}
proc setExtensionEvents*(widget: PWidget, mode: gdk2.TExtensionMode){.
    cdecl, dynlib: lib, importc: "gtk_widget_set_extension_events".}
proc getExtensionEvents*(widget: PWidget): gdk2.TExtensionMode{.cdecl, 
    dynlib: lib, importc: "gtk_widget_get_extension_events".}
proc getToplevel*(widget: PWidget): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_toplevel".}
proc getAncestor*(widget: PWidget, widget_type: TType): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_widget_get_ancestor".}
proc getColormap*(widget: PWidget): gdk2.PColormap{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_colormap".}
proc getVisual*(widget: PWidget): gdk2.PVisual{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_visual".}
proc getScreen*(widget: PWidget): gdk2.PScreen{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_screen".}
proc hasScreen*(widget: PWidget): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_widget_has_screen".}
proc getDisplay*(widget: PWidget): gdk2.PDisplay{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_display".}
proc getRootWindow*(widget: PWidget): gdk2.PWindow{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_root_window".}
proc getSettings*(widget: PWidget): PSettings{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_settings".}
proc getClipboard*(widget: PWidget, selection: gdk2.TAtom): PClipboard{.
    cdecl, dynlib: lib, importc: "gtk_widget_get_clipboard".}
proc getAccessible*(widget: PWidget): atk.PObject{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_accessible".}
proc setColormap*(widget: PWidget, colormap: gdk2.PColormap){.cdecl, 
    dynlib: lib, importc: "gtk_widget_set_colormap".}
proc getEvents*(widget: PWidget): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_events".}
proc getPointer*(widget: PWidget, x: Pgint, y: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_widget_get_pointer".}
proc isAncestor*(widget: PWidget, ancestor: PWidget): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_widget_is_ancestor".}
proc translateCoordinates*(src_widget: PWidget, dest_widget: PWidget, 
                                   src_x: Gint, src_y: Gint, dest_x: Pgint, 
                                   dest_y: Pgint): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_widget_translate_coordinates".}
proc hideOnDelete*(widget: PWidget): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_widget_hide_on_delete".}
proc setStyle*(widget: PWidget, style: PStyle){.cdecl, dynlib: lib, 
    importc: "gtk_widget_set_style".}
proc ensureStyle*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_ensure_style".}
proc getStyle*(widget: PWidget): PStyle{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_style".}
proc modifyStyle*(widget: PWidget, style: PRcStyle){.cdecl, dynlib: lib, 
    importc: "gtk_widget_modify_style".}
proc getModifierStyle*(widget: PWidget): PRcStyle{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_modifier_style".}
proc modifyFg*(widget: PWidget, state: TStateType, color: gdk2.PColor){.
    cdecl, dynlib: lib, importc: "gtk_widget_modify_fg".}
proc modifyBg*(widget: PWidget, state: TStateType, color: gdk2.PColor){.
    cdecl, dynlib: lib, importc: "gtk_widget_modify_bg".}
proc modifyText*(widget: PWidget, state: TStateType, color: gdk2.PColor){.
    cdecl, dynlib: lib, importc: "gtk_widget_modify_text".}
proc modifyBase*(widget: PWidget, state: TStateType, color: gdk2.PColor){.
    cdecl, dynlib: lib, importc: "gtk_widget_modify_base".}
proc modifyFont*(widget: PWidget, font_desc: pango.PFontDescription){.
    cdecl, dynlib: lib, importc: "gtk_widget_modify_font".}
proc createPangoContext*(widget: PWidget): pango.PContext{.cdecl, 
    dynlib: lib, importc: "gtk_widget_create_pango_context".}
proc getPangoContext*(widget: PWidget): pango.PContext{.cdecl, 
    dynlib: lib, importc: "gtk_widget_get_pango_context".}
proc createPangoLayout*(widget: PWidget, text: Cstring): pango.PLayout{.
    cdecl, dynlib: lib, importc: "gtk_widget_create_pango_layout".}
proc renderIcon*(widget: PWidget, stock_id: Cstring, size: TIconSize, 
                         detail: Cstring): gdk2pixbuf.PPixbuf{.cdecl, dynlib: lib, 
    importc: "gtk_widget_render_icon".}
proc setCompositeName*(widget: PWidget, name: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_widget_set_composite_name".}
proc getCompositeName*(widget: PWidget): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_composite_name".}
proc resetRcStyles*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_reset_rc_styles".}
proc widgetPushColormap*(cmap: gdk2.PColormap){.cdecl, dynlib: lib, 
    importc: "gtk_widget_push_colormap".}
proc widgetPushCompositeChild*(){.cdecl, dynlib: lib, 
                                     importc: "gtk_widget_push_composite_child".}
proc widgetPopCompositeChild*(){.cdecl, dynlib: lib, 
                                    importc: "gtk_widget_pop_composite_child".}
proc widgetPopColormap*(){.cdecl, dynlib: lib, 
                             importc: "gtk_widget_pop_colormap".}
proc installStyleProperty*(klass: PWidgetClass, 
    pspec: PGParamSpec){.cdecl, dynlib: lib, 
                         importc: "gtk_widget_class_install_style_property".}
proc installStylePropertyParser*(klass: PWidgetClass, 
    pspec: PGParamSpec, parser: TRcPropertyParser){.cdecl, dynlib: lib, 
    importc: "gtk_widget_class_install_style_property_parser".}
proc findStyleProperty*(klass: PWidgetClass, 
                                       property_name: Cstring): PGParamSpec{.
    cdecl, dynlib: lib, importc: "gtk_widget_class_find_style_property".}
proc listStyleProperties*(klass: PWidgetClass, 
    n_properties: Pguint): PPGParamSpec{.cdecl, dynlib: lib, 
    importc: "gtk_widget_class_list_style_properties".}
proc styleGetProperty*(widget: PWidget, property_name: Cstring, 
                                value: PGValue){.cdecl, dynlib: lib, 
    importc: "gtk_widget_style_get_property".}
proc widgetSetDefaultColormap*(colormap: gdk2.PColormap){.cdecl, dynlib: lib, 
    importc: "gtk_widget_set_default_colormap".}
proc widgetGetDefaultStyle*(): PStyle{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_default_style".}
proc setDirection*(widget: PWidget, dir: TTextDirection){.cdecl, 
    dynlib: lib, importc: "gtk_widget_set_direction".}
proc getDirection*(widget: PWidget): TTextDirection{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_direction".}
proc widgetSetDefaultDirection*(dir: TTextDirection){.cdecl, dynlib: lib, 
    importc: "gtk_widget_set_default_direction".}
proc widgetGetDefaultDirection*(): TTextDirection{.cdecl, dynlib: lib, 
    importc: "gtk_widget_get_default_direction".}
proc shapeCombineMask*(widget: PWidget, shape_mask: gdk2.PBitmap, 
                                offset_x: Gint, offset_y: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_widget_shape_combine_mask".}
proc resetShapes*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_widget_reset_shapes".}
proc path*(widget: PWidget, path_length: Pguint, path: PPgchar, 
                  path_reversed: PPgchar){.cdecl, dynlib: lib, 
    importc: "gtk_widget_path".}
proc classPath*(widget: PWidget, path_length: Pguint, path: PPgchar, 
                        path_reversed: PPgchar){.cdecl, dynlib: lib, 
    importc: "gtk_widget_class_path".}
proc requisitionGetType*(): GType{.cdecl, dynlib: lib, 
                                     importc: "gtk_requisition_get_type".}
proc copy*(requisition: PRequisition): PRequisition{.cdecl, 
    dynlib: lib, importc: "gtk_requisition_copy".}
proc free*(requisition: PRequisition){.cdecl, dynlib: lib, 
    importc: "gtk_requisition_free".}
proc getAuxInfo*(widget: PWidget, create: Gboolean): PWidgetAuxInfo{.
    cdecl, dynlib: lib, importc: "gtk_widget_get_aux_info".}
proc propagateHierarchyChanged*(widget: PWidget, 
    previous_toplevel: PWidget){.cdecl, dynlib: lib, importc: "_gtk_widget_propagate_hierarchy_changed".}
proc widgetPeekColormap*(): gdk2.PColormap{.cdecl, dynlib: lib, 
    importc: "_gtk_widget_peek_colormap".}
proc typeMisc*(): GType
proc misc*(obj: Pointer): PMisc
proc miscClass*(klass: Pointer): PMiscClass
proc isMisc*(obj: Pointer): Bool
proc isMiscClass*(klass: Pointer): Bool
proc miscGetClass*(obj: Pointer): PMiscClass
proc miscGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_misc_get_type".}
proc setAlignment*(misc: PMisc, xalign: Gfloat, yalign: Gfloat){.cdecl, 
    dynlib: lib, importc: "gtk_misc_set_alignment".}
proc getAlignment*(misc: PMisc, xalign, yalign: var Pgfloat){.cdecl, 
    dynlib: lib, importc: "gtk_misc_get_alignment".}
proc setPadding*(misc: PMisc, xpad: Gint, ypad: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_misc_set_padding".}
proc getPadding*(misc: PMisc, xpad, ypad: var Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_misc_get_padding".}
const 
  AccelVisible* = 1 shl 0
  AccelLocked* = 1 shl 1
  AccelMask* = 0x00000007
  bmTGtkAccelKeyAccelFlags* = 0xFFFF'i16
  bpTGtkAccelKeyAccelFlags* = 0'i16

proc typeAccelGroup*(): GType
proc accelGroup*(anObject: Pointer): PAccelGroup
proc accelGroupClass*(klass: Pointer): PAccelGroupClass
proc isAccelGroup*(anObject: Pointer): Bool
proc isAccelGroupClass*(klass: Pointer): Bool
proc accelGroupGetClass*(obj: Pointer): PAccelGroupClass
proc accelFlags*(a: PAccelKey): Guint
proc setAccelFlags*(a: PAccelKey, `accel_flags`: Guint)
proc accelGroupGetType*(): GType{.cdecl, dynlib: lib, 
                                     importc: "gtk_accel_group_get_type".}
proc accelGroupNew*(): PAccelGroup{.cdecl, dynlib: lib, 
                                      importc: "gtk_accel_group_new".}
proc lock*(accel_group: PAccelGroup){.cdecl, dynlib: lib, 
    importc: "gtk_accel_group_lock".}
proc unlock*(accel_group: PAccelGroup){.cdecl, dynlib: lib, 
    importc: "gtk_accel_group_unlock".}
proc connect*(accel_group: PAccelGroup, accel_key: Guint, 
                          accel_mods: gdk2.TModifierType, 
                          accel_flags: TAccelFlags, closure: PGClosure){.cdecl, 
    dynlib: lib, importc: "gtk_accel_group_connect".}
proc connectByPath*(accel_group: PAccelGroup, accel_path: Cstring, 
                                  closure: PGClosure){.cdecl, dynlib: lib, 
    importc: "gtk_accel_group_connect_by_path".}
proc disconnect*(accel_group: PAccelGroup, closure: PGClosure): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_accel_group_disconnect".}
proc disconnectKey*(accel_group: PAccelGroup, accel_key: Guint, 
                                 accel_mods: gdk2.TModifierType): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_accel_group_disconnect_key".}
proc attach*(accel_group: PAccelGroup, anObject: PGObject){.cdecl, 
    dynlib: lib, importc: "_gtk_accel_group_attach".}
proc detach*(accel_group: PAccelGroup, anObject: PGObject){.cdecl, 
    dynlib: lib, importc: "_gtk_accel_group_detach".}
proc accelGroupsActivate*(anObject: PGObject, accel_key: Guint, 
                            accel_mods: gdk2.TModifierType): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_accel_groups_activate".}
proc accelGroupsFromObject*(anObject: PGObject): PGSList{.cdecl, dynlib: lib, 
    importc: "gtk_accel_groups_from_object".}
proc find*(accel_group: PAccelGroup, 
                       find_func: TaccelGroupFindFunc, data: Gpointer): PAccelKey{.
    cdecl, dynlib: lib, importc: "gtk_accel_group_find".}
proc accelGroupFromAccelClosure*(closure: PGClosure): PAccelGroup{.cdecl, 
    dynlib: lib, importc: "gtk_accel_group_from_accel_closure".}
proc acceleratorValid*(keyval: Guint, modifiers: gdk2.TModifierType): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_accelerator_valid".}
proc acceleratorParse*(accelerator: Cstring, accelerator_key: Pguint, 
                        accelerator_mods: gdk2.PModifierType){.cdecl, dynlib: lib, 
    importc: "gtk_accelerator_parse".}
proc acceleratorName*(accelerator_key: Guint, 
                       accelerator_mods: gdk2.TModifierType): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_accelerator_name".}
proc acceleratorSetDefaultModMask*(default_mod_mask: gdk2.TModifierType){.
    cdecl, dynlib: lib, importc: "gtk_accelerator_set_default_mod_mask".}
proc acceleratorGetDefaultModMask*(): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_accelerator_get_default_mod_mask".}
proc query*(accel_group: PAccelGroup, accel_key: Guint, 
                        accel_mods: gdk2.TModifierType, n_entries: Pguint): PAccelGroupEntry{.
    cdecl, dynlib: lib, importc: "gtk_accel_group_query".}
proc reconnect*(accel_group: PAccelGroup, accel_path_quark: TGQuark){.
    cdecl, dynlib: lib, importc: "_gtk_accel_group_reconnect".}
const 
  bmTGtkContainerBorderWidth* = 0x0000FFFF'i32
  bpTGtkContainerBorderWidth* = 0'i32
  bmTGtkContainerNeedResize* = 0x00010000'i32
  bpTGtkContainerNeedResize* = 16'i32
  bmTGtkContainerResizeMode* = 0x00060000'i32
  bpTGtkContainerResizeMode* = 17'i32
  bmTGtkContainerReallocateRedraws* = 0x00080000'i32
  bpTGtkContainerReallocateRedraws* = 19'i32
  bmTGtkContainerHasFocusChain* = 0x00100000'i32
  bpTGtkContainerHasFocusChain* = 20'i32

proc typeContainer*(): GType
proc container*(obj: Pointer): PContainer
proc containerClass*(klass: Pointer): PContainerClass
proc isContainer*(obj: Pointer): Bool
proc isContainerClass*(klass: Pointer): Bool
proc containerGetClass*(obj: Pointer): PContainerClass
proc isResizeContainer*(widget: Pointer): Bool
proc borderWidth*(a: PContainer): Guint
proc needResize*(a: PContainer): Guint
proc setNeedResize*(a: PContainer, `need_resize`: Guint)
proc resizeMode*(a: PContainer): Guint
proc setResizeMode*(a: PContainer, `resize_mode`: Guint)
proc reallocateRedraws*(a: PContainer): Guint
proc setReallocateRedraws*(a: PContainer, `reallocate_redraws`: Guint)
proc hasFocusChain*(a: PContainer): Guint
proc setHasFocusChain*(a: PContainer, `has_focus_chain`: Guint)
proc containerGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_container_get_type".}
proc setBorderWidth*(container: PContainer, border_width: Guint){.
    cdecl, dynlib: lib, importc: "gtk_container_set_border_width".}
proc getBorderWidth*(container: PContainer): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_container_get_border_width".}
proc add*(container: PContainer, widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_container_add".}
proc remove*(container: PContainer, widget: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_container_remove".}
proc setResizeMode*(container: PContainer, resize_mode: TResizeMode){.
    cdecl, dynlib: lib, importc: "gtk_container_set_resize_mode".}
proc getResizeMode*(container: PContainer): TResizeMode{.cdecl, 
    dynlib: lib, importc: "gtk_container_get_resize_mode".}
proc checkResize*(container: PContainer){.cdecl, dynlib: lib, 
    importc: "gtk_container_check_resize".}
proc foreach*(container: PContainer, callback: TCallback, 
                        callback_data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_container_foreach".}
proc getChildren*(container: PContainer): PGList{.cdecl, dynlib: lib, 
    importc: "gtk_container_get_children".}
proc propagateExpose*(container: PContainer, child: PWidget, 
                                 event: gdk2.PEventExpose){.cdecl, dynlib: lib, 
    importc: "gtk_container_propagate_expose".}
proc setFocusChain*(container: PContainer, focusable_widgets: PGList){.
    cdecl, dynlib: lib, importc: "gtk_container_set_focus_chain".}
proc getFocusChain*(container: PContainer, s: var PGList): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_container_get_focus_chain".}
proc unsetFocusChain*(container: PContainer){.cdecl, dynlib: lib, 
    importc: "gtk_container_unset_focus_chain".}
proc setReallocateRedraws*(container: PContainer, 
                                       needs_redraws: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_container_set_reallocate_redraws".}
proc setFocusChild*(container: PContainer, child: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_container_set_focus_child".}
proc setFocusVadjustment*(container: PContainer, 
                                      adjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_container_set_focus_vadjustment".}
proc getFocusVadjustment*(container: PContainer): PAdjustment{.
    cdecl, dynlib: lib, importc: "gtk_container_get_focus_vadjustment".}
proc setFocusHadjustment*(container: PContainer, 
                                      adjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_container_set_focus_hadjustment".}
proc getFocusHadjustment*(container: PContainer): PAdjustment{.
    cdecl, dynlib: lib, importc: "gtk_container_get_focus_hadjustment".}
proc resizeChildren*(container: PContainer){.cdecl, dynlib: lib, 
    importc: "gtk_container_resize_children".}
proc childType*(container: PContainer): TType{.cdecl, dynlib: lib, 
    importc: "gtk_container_child_type".}
proc installChildProperty*(cclass: PContainerClass, 
    property_id: Guint, pspec: PGParamSpec){.cdecl, dynlib: lib, 
    importc: "gtk_container_class_install_child_property".}
proc containerClassFindChildProperty*(cclass: PGObjectClass, 
    property_name: Cstring): PGParamSpec{.cdecl, dynlib: lib, 
    importc: "gtk_container_class_find_child_property".}
proc containerClassListChildProperties*(cclass: PGObjectClass, 
    n_properties: Pguint): PPGParamSpec{.cdecl, dynlib: lib, 
    importc: "gtk_container_class_list_child_properties".}
proc childSetProperty*(container: PContainer, child: PWidget, 
                                   property_name: Cstring, value: PGValue){.
    cdecl, dynlib: lib, importc: "gtk_container_child_set_property".}
proc childGetProperty*(container: PContainer, child: PWidget, 
                                   property_name: Cstring, value: PGValue){.
    cdecl, dynlib: lib, importc: "gtk_container_child_get_property".}
proc containerWarnInvalidChildPropertyId*(anObject: Pointer, 
    property_id: Guint, pspec: Pointer)
proc forall*(container: PContainer, callback: TCallback, 
                       callback_data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_container_forall".}
proc queueResize*(container: PContainer){.cdecl, dynlib: lib, 
    importc: "_gtk_container_queue_resize".}
proc clearResizeWidgets*(container: PContainer){.cdecl, dynlib: lib, 
    importc: "_gtk_container_clear_resize_widgets".}
proc childCompositeName*(container: PContainer, child: PWidget): Cstring{.
    cdecl, dynlib: lib, importc: "_gtk_container_child_composite_name".}
proc dequeueResizeHandler*(container: PContainer){.cdecl, 
    dynlib: lib, importc: "_gtk_container_dequeue_resize_handler".}
proc focusSort*(container: PContainer, children: PGList, 
                           direction: TDirectionType, old_focus: PWidget): PGList{.
    cdecl, dynlib: lib, importc: "_gtk_container_focus_sort".}
proc typeBin*(): GType
proc bin*(obj: Pointer): PBin
proc binClass*(klass: Pointer): PBinClass
proc isBin*(obj: Pointer): Bool
proc isBinClass*(klass: Pointer): Bool
proc binGetClass*(obj: Pointer): PBinClass
proc binGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_bin_get_type".}
proc getChild*(bin: PBin): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_bin_get_child".}
const 
  bmTGtkWindowAllowShrink* = 0x00000001'i32
  bpTGtkWindowAllowShrink* = 0'i32
  bmTGtkWindowAllowGrow* = 0x00000002'i32
  bpTGtkWindowAllowGrow* = 1'i32
  bmTGtkWindowConfigureNotifyReceived* = 0x00000004'i32
  bpTGtkWindowConfigureNotifyReceived* = 2'i32
  bmTGtkWindowNeedDefaultPosition* = 0x00000008'i32
  bpTGtkWindowNeedDefaultPosition* = 3'i32
  bmTGtkWindowNeedDefaultSize* = 0x00000010'i32
  bpTGtkWindowNeedDefaultSize* = 4'i32
  bmTGtkWindowPosition* = 0x000000E0'i32
  bpTGtkWindowPosition* = 5'i32
  bmTGtkWindowType* = 0x00000F00'i32
  bpTGtkWindowType* = 8'i32
  bmTGtkWindowHasUserRefCount* = 0x00001000'i32
  bpTGtkWindowHasUserRefCount* = 12'i32
  bmTGtkWindowHasFocus* = 0x00002000'i32
  bpTGtkWindowHasFocus* = 13'i32
  bmTGtkWindowModal* = 0x00004000'i32
  bpTGtkWindowModal* = 14'i32
  bmTGtkWindowDestroyWithParent* = 0x00008000'i32
  bpTGtkWindowDestroyWithParent* = 15'i32
  bmTGtkWindowHasFrame* = 0x00010000'i32
  bpTGtkWindowHasFrame* = 16'i32
  bmTGtkWindowIconifyInitially* = 0x00020000'i32
  bpTGtkWindowIconifyInitially* = 17'i32
  bmTGtkWindowStickInitially* = 0x00040000'i32
  bpTGtkWindowStickInitially* = 18'i32
  bmTGtkWindowMaximizeInitially* = 0x00080000'i32
  bpTGtkWindowMaximizeInitially* = 19'i32
  bmTGtkWindowDecorated* = 0x00100000'i32
  bpTGtkWindowDecorated* = 20'i32
  bmTGtkWindowTypeHint* = 0x00E00000'i32
  bpTGtkWindowTypeHint* = 21'i32
  bmTGtkWindowGravity* = 0x1F000000'i32
  bpTGtkWindowGravity* = 24'i32

proc typeWindow*(): GType
proc window*(obj: Pointer): PWindow
proc windowClass*(klass: Pointer): PWindowClass
proc isWindow*(obj: Pointer): Bool
proc isWindowClass*(klass: Pointer): Bool
proc windowGetClass*(obj: Pointer): PWindowClass
proc allowShrink*(a: gtk2.PWindow): Guint
proc setAllowShrink*(a: gtk2.PWindow, `allow_shrink`: Guint)
proc allowGrow*(a: gtk2.PWindow): Guint
proc setAllowGrow*(a: gtk2.PWindow, `allow_grow`: Guint)
proc configureNotifyReceived*(a: gtk2.PWindow): Guint
proc setConfigureNotifyReceived*(a: gtk2.PWindow, 
                                    `configure_notify_received`: Guint)
proc needDefaultPosition*(a: gtk2.PWindow): Guint
proc setNeedDefaultPosition*(a: gtk2.PWindow, `need_default_position`: Guint)
proc needDefaultSize*(a: gtk2.PWindow): Guint
proc setNeedDefaultSize*(a: gtk2.PWindow, `need_default_size`: Guint)
proc position*(a: gtk2.PWindow): Guint
proc getType*(a: gtk2.PWindow): Guint
proc setType*(a: gtk2.PWindow, `type`: Guint)
proc hasUserRefCount*(a: gtk2.PWindow): Guint
proc setHasUserRefCount*(a: gtk2.PWindow, `has_user_ref_count`: Guint)
proc hasFocus*(a: gtk2.PWindow): Guint
proc setHasFocus*(a: gtk2.PWindow, `has_focus`: Guint)
proc modal*(a: gtk2.PWindow): Guint
proc setModal*(a: gtk2.PWindow, `modal`: Guint)
proc destroyWithParent*(a: gtk2.PWindow): Guint
proc setDestroyWithParent*(a: gtk2.PWindow, `destroy_with_parent`: Guint)
proc hasFrame*(a: gtk2.PWindow): Guint
proc setHasFrame*(a: gtk2.PWindow, `has_frame`: Guint)
proc iconifyInitially*(a: gtk2.PWindow): Guint
proc setIconifyInitially*(a: gtk2.PWindow, `iconify_initially`: Guint)
proc stickInitially*(a: gtk2.PWindow): Guint
proc setStickInitially*(a: gtk2.PWindow, `stick_initially`: Guint)
proc maximizeInitially*(a: gtk2.PWindow): Guint
proc setMaximizeInitially*(a: gtk2.PWindow, `maximize_initially`: Guint)
proc decorated*(a: gtk2.PWindow): Guint
proc setDecorated*(a: gtk2.PWindow, `decorated`: Guint)
proc typeHint*(a: gtk2.PWindow): Guint
proc setTypeHint*(a: gtk2.PWindow, `type_hint`: Guint)
proc gravity*(a: gtk2.PWindow): Guint
proc setGravity*(a: gtk2.PWindow, `gravity`: Guint)
proc typeWindowGroup*(): GType
proc windowGroup*(anObject: Pointer): PWindowGroup
proc windowGroupClass*(klass: Pointer): PWindowGroupClass
proc isWindowGroup*(anObject: Pointer): Bool
proc isWindowGroupClass*(klass: Pointer): Bool
proc windowGroupGetClass*(obj: Pointer): PWindowGroupClass
proc windowGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_window_get_type".}
proc windowNew*(thetype: TWindowType): PWindow{.cdecl, dynlib: lib, 
    importc: "gtk_window_new".}
proc setTitle*(window: PWindow, title: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_title".}
proc getTitle*(window: PWindow): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_title".}
proc setWmclass*(window: PWindow, wmclass_name: Cstring, 
                         wmclass_class: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_wmclass".}
proc setRole*(window: PWindow, role: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_role".}
proc getRole*(window: PWindow): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_role".}
proc addAccelGroup*(window: PWindow, accel_group: PAccelGroup){.cdecl, 
    dynlib: lib, importc: "gtk_window_add_accel_group".}
proc removeAccelGroup*(window: PWindow, accel_group: PAccelGroup){.
    cdecl, dynlib: lib, importc: "gtk_window_remove_accel_group".}
proc setPosition*(window: PWindow, position: TWindowPosition){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_position".}
proc activateFocus*(window: PWindow): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_window_activate_focus".}
proc setFocus*(window: PWindow, focus: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_focus".}
proc getFocus*(window: PWindow): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_focus".}
proc setDefault*(window: PWindow, default_widget: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_default".}
proc activateDefault*(window: PWindow): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_window_activate_default".}
proc setTransientFor*(window: PWindow, parent: PWindow){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_transient_for".}
proc getTransientFor*(window: PWindow): PWindow{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_transient_for".}
proc setTypeHint*(window: PWindow, hint: gdk2.TWindowTypeHint){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_type_hint".}
proc getTypeHint*(window: PWindow): gdk2.TWindowTypeHint{.cdecl, 
    dynlib: lib, importc: "gtk_window_get_type_hint".}
proc setDestroyWithParent*(window: PWindow, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_destroy_with_parent".}
proc getDestroyWithParent*(window: PWindow): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_window_get_destroy_with_parent".}
proc setResizable*(window: PWindow, resizable: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_resizable".}
proc getResizable*(window: PWindow): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_resizable".}
proc setGravity*(window: PWindow, gravity: gdk2.TGravity){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_gravity".}
proc getGravity*(window: PWindow): gdk2.TGravity{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_gravity".}
proc setGeometryHints*(window: PWindow, geometry_widget: PWidget, 
                                geometry: gdk2.PGeometry, 
                                geom_mask: gdk2.TWindowHints){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_geometry_hints".}
proc setScreen*(window: PWindow, screen: gdk2.PScreen){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_screen".}
proc getScreen*(window: PWindow): gdk2.PScreen{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_screen".}
proc setHasFrame*(window: PWindow, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_has_frame".}
proc getHasFrame*(window: PWindow): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_has_frame".}
proc setFrameDimensions*(window: PWindow, left: Gint, top: Gint, 
                                  right: Gint, bottom: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_frame_dimensions".}
proc getFrameDimensions*(window: PWindow, left: Pgint, top: Pgint, 
                                  right: Pgint, bottom: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_window_get_frame_dimensions".}
proc setDecorated*(window: PWindow, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_window_set_decorated".}
proc getDecorated*(window: PWindow): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_decorated".}
proc setIconList*(window: PWindow, list: PGList){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_icon_list".}
proc getIconList*(window: PWindow): PGList{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_icon_list".}
proc setIcon*(window: PWindow, icon: gdk2pixbuf.PPixbuf){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_icon".}
proc getIcon*(window: PWindow): gdk2pixbuf.PPixbuf{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_icon".}
proc windowSetDefaultIconList*(list: PGList){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_default_icon_list".}
proc windowGetDefaultIconList*(): PGList{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_default_icon_list".}
proc setModal*(window: PWindow, modal: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_modal".}
proc getModal*(window: PWindow): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_window_get_modal".}
proc windowListToplevels*(): PGList{.cdecl, dynlib: lib, 
                                       importc: "gtk_window_list_toplevels".}
proc addMnemonic*(window: PWindow, keyval: Guint, target: PWidget){.
    cdecl, dynlib: lib, importc: "gtk_window_add_mnemonic".}
proc removeMnemonic*(window: PWindow, keyval: Guint, target: PWidget){.
    cdecl, dynlib: lib, importc: "gtk_window_remove_mnemonic".}
proc mnemonicActivate*(window: PWindow, keyval: Guint, 
                               modifier: gdk2.TModifierType): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_window_mnemonic_activate".}
proc setMnemonicModifier*(window: PWindow, modifier: gdk2.TModifierType){.
    cdecl, dynlib: lib, importc: "gtk_window_set_mnemonic_modifier".}
proc getMnemonicModifier*(window: PWindow): gdk2.TModifierType{.cdecl, 
    dynlib: lib, importc: "gtk_window_get_mnemonic_modifier".}
proc present*(window: PWindow){.cdecl, dynlib: lib, 
                                       importc: "gtk_window_present".}
proc iconify*(window: PWindow){.cdecl, dynlib: lib, 
                                       importc: "gtk_window_iconify".}
proc deiconify*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gtk_window_deiconify".}
proc stick*(window: PWindow){.cdecl, dynlib: lib, 
                                     importc: "gtk_window_stick".}
proc unstick*(window: PWindow){.cdecl, dynlib: lib, 
                                       importc: "gtk_window_unstick".}
proc maximize*(window: PWindow){.cdecl, dynlib: lib, 
                                        importc: "gtk_window_maximize".}
proc unmaximize*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gtk_window_unmaximize".}
proc beginResizeDrag*(window: PWindow, edge: gdk2.TWindowEdge, 
                               button: Gint, root_x: Gint, root_y: Gint, 
                               timestamp: Guint32){.cdecl, dynlib: lib, 
    importc: "gtk_window_begin_resize_drag".}
proc beginMoveDrag*(window: PWindow, button: Gint, root_x: Gint, 
                             root_y: Gint, timestamp: Guint32){.cdecl, 
    dynlib: lib, importc: "gtk_window_begin_move_drag".}
proc setDefaultSize*(window: PWindow, width: Gint, height: Gint){.
    cdecl, dynlib: lib, importc: "gtk_window_set_default_size".}
proc getDefaultSize*(window: PWindow, width: Pgint, height: Pgint){.
    cdecl, dynlib: lib, importc: "gtk_window_get_default_size".}
proc resize*(window: PWindow, width: Gint, height: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_window_resize".}
proc getSize*(window: PWindow, width: Pgint, height: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_window_get_size".}
proc move*(window: PWindow, x: Gint, y: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_window_move".}
proc getPosition*(window: PWindow, root_x: Pgint, root_y: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_window_get_position".}
proc parseGeometry*(window: PWindow, geometry: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_window_parse_geometry".}
proc reshowWithInitialSize*(window: PWindow){.cdecl, dynlib: lib, 
    importc: "gtk_window_reshow_with_initial_size".}
proc windowGroupGetType*(): GType{.cdecl, dynlib: lib, 
                                      importc: "gtk_window_group_get_type".}
proc windowGroupNew*(): PWindowGroup{.cdecl, dynlib: lib, 
                                        importc: "gtk_window_group_new".}
proc addWindow*(window_group: PWindowGroup, window: PWindow){.
    cdecl, dynlib: lib, importc: "gtk_window_group_add_window".}
proc removeWindow*(window_group: PWindowGroup, window: PWindow){.
    cdecl, dynlib: lib, importc: "gtk_window_group_remove_window".}
proc windowSetDefaultIconName*(name: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_window_set_default_icon_name".}
proc internalSetFocus*(window: PWindow, focus: PWidget){.cdecl, 
    dynlib: lib, importc: "_gtk_window_internal_set_focus".}
proc removeEmbeddedXid*(window: PWindow, xid: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_window_remove_embedded_xid".}
proc addEmbeddedXid*(window: PWindow, xid: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_window_add_embedded_xid".}
proc reposition*(window: PWindow, x: Gint, y: Gint){.cdecl, dynlib: lib, 
    importc: "_gtk_window_reposition".}
proc constrainSize*(window: PWindow, width: Gint, height: Gint, 
                            new_width: Pgint, new_height: Pgint){.cdecl, 
    dynlib: lib, importc: "_gtk_window_constrain_size".}
proc getGroup*(window: PWindow): PWindowGroup{.cdecl, dynlib: lib, 
    importc: "_gtk_window_get_group".}
proc activateKey*(window: PWindow, event: gdk2.PEventKey): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_window_activate_key".}
proc keysForeach*(window: PWindow, func: TWindowKeysForeachFunc, 
                          func_data: Gpointer){.cdecl, dynlib: lib, 
    importc: "_gtk_window_keys_foreach".}
proc queryNonaccels*(window: PWindow, accel_key: Guint, 
                             accel_mods: gdk2.TModifierType): Gboolean{.cdecl, 
    dynlib: lib, importc: "_gtk_window_query_nonaccels".}
const 
  bmTGtkLabelJtype* = 0x0003'i16
  bpTGtkLabelJtype* = 0'i16
  bmTGtkLabelWrap* = 0x0004'i16
  bpTGtkLabelWrap* = 2'i16
  bmTGtkLabelUseUnderline* = 0x0008'i16
  bpTGtkLabelUseUnderline* = 3'i16
  bmTGtkLabelUseMarkup* = 0x0010'i16
  bpTGtkLabelUseMarkup* = 4'i16

proc typeLabel*(): GType
proc label*(obj: Pointer): PLabel
proc labelClass*(klass: Pointer): PLabelClass
proc isLabel*(obj: Pointer): Bool
proc isLabelClass*(klass: Pointer): Bool
proc labelGetClass*(obj: Pointer): PLabelClass
proc jtype*(a: PLabel): Guint
proc setJtype*(a: PLabel, `jtype`: Guint)
proc wrap*(a: PLabel): Guint
proc setWrap*(a: PLabel, `wrap`: Guint)
proc useUnderline*(a: PLabel): Guint
proc setUseUnderline*(a: PLabel, `use_underline`: Guint)
proc useMarkup*(a: PLabel): Guint
proc setUseMarkup*(a: PLabel, `use_markup`: Guint)
proc labelGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_label_get_type".}
proc labelNew*(str: Cstring): PLabel{.cdecl, dynlib: lib, 
                                       importc: "gtk_label_new".}
proc labelNewWithMnemonic*(str: Cstring): PLabel{.cdecl, dynlib: lib, 
    importc: "gtk_label_new_with_mnemonic".}
proc setText*(`label`: PLabel, str: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_label_set_text".}
proc getText*(`label`: PLabel): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_text".}
proc setAttributes*(`label`: PLabel, attrs: pango.PAttrList){.cdecl, 
    dynlib: lib, importc: "gtk_label_set_attributes".}
proc getAttributes*(`label`: PLabel): pango.PAttrList{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_attributes".}
proc setLabel*(`label`: PLabel, str: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_label_set_label".}
proc getLabel*(`label`: PLabel): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_label".}
proc setMarkup*(`label`: PLabel, str: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_label_set_markup".}
proc setUseMarkup*(`label`: PLabel, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_label_set_use_markup".}
proc getUseMarkup*(`label`: PLabel): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_use_markup".}
proc setUseUnderline*(`label`: PLabel, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_label_set_use_underline".}
proc getUseUnderline*(`label`: PLabel): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_use_underline".}
proc setMarkupWithMnemonic*(`label`: PLabel, str: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_label_set_markup_with_mnemonic".}
proc getMnemonicKeyval*(`label`: PLabel): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_mnemonic_keyval".}
proc setMnemonicWidget*(`label`: PLabel, widget: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_label_set_mnemonic_widget".}
proc getMnemonicWidget*(`label`: PLabel): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_mnemonic_widget".}
proc setTextWithMnemonic*(`label`: PLabel, str: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_label_set_text_with_mnemonic".}
proc setJustify*(`label`: PLabel, jtype: TJustification){.cdecl, 
    dynlib: lib, importc: "gtk_label_set_justify".}
proc getJustify*(`label`: PLabel): TJustification{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_justify".}
proc setPattern*(`label`: PLabel, pattern: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_label_set_pattern".}
proc setLineWrap*(`label`: PLabel, wrap: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_label_set_line_wrap".}
proc getLineWrap*(`label`: PLabel): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_line_wrap".}
proc setSelectable*(`label`: PLabel, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_label_set_selectable".}
proc getSelectable*(`label`: PLabel): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_selectable".}
proc selectRegion*(`label`: PLabel, start_offset: Gint, end_offset: Gint){.
    cdecl, dynlib: lib, importc: "gtk_label_select_region".}
proc getSelectionBounds*(`label`: PLabel, start: Pgint, theEnd: Pgint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_label_get_selection_bounds".}
proc getLayout*(`label`: PLabel): pango.PLayout{.cdecl, dynlib: lib, 
    importc: "gtk_label_get_layout".}
proc getLayoutOffsets*(`label`: PLabel, x: Pgint, y: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_label_get_layout_offsets".}
const 
  bmTGtkAccelLabelClassLatin1ToChar* = 0x0001'i16
  bpTGtkAccelLabelClassLatin1ToChar* = 0'i16

proc typeAccelLabel*(): GType
proc accelLabel*(obj: Pointer): PAccelLabel
proc accelLabelClass*(klass: Pointer): PAccelLabelClass
proc isAccelLabel*(obj: Pointer): Bool
proc isAccelLabelClass*(klass: Pointer): Bool
proc accelLabelGetClass*(obj: Pointer): PAccelLabelClass
proc latin1ToChar*(a: PAccelLabelClass): Guint
proc setLatin1ToChar*(a: PAccelLabelClass, `latin1_to_char`: Guint)
proc accelLabelGetType*(): TType{.cdecl, dynlib: lib, 
                                     importc: "gtk_accel_label_get_type".}
proc accelLabelNew*(`string`: Cstring): PAccelLabel{.cdecl, dynlib: lib, 
    importc: "gtk_accel_label_new".}
proc getAccelWidget*(accel_label: PAccelLabel): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_accel_label_get_accel_widget".}
proc getAccelWidth*(accel_label: PAccelLabel): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_accel_label_get_accel_width".}
proc setAccelWidget*(accel_label: PAccelLabel, 
                                   accel_widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_accel_label_set_accel_widget".}
proc setAccelClosure*(accel_label: PAccelLabel, 
                                    accel_closure: PGClosure){.cdecl, 
    dynlib: lib, importc: "gtk_accel_label_set_accel_closure".}
proc refetch*(accel_label: PAccelLabel): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_accel_label_refetch".}
proc accelMapAddEntry*(accel_path: Cstring, accel_key: Guint, 
                          accel_mods: gdk2.TModifierType){.cdecl, dynlib: lib, 
    importc: "gtk_accel_map_add_entry".}
proc accelMapLookupEntry*(accel_path: Cstring, key: PAccelKey): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_accel_map_lookup_entry".}
proc accelMapChangeEntry*(accel_path: Cstring, accel_key: Guint, 
                             accel_mods: gdk2.TModifierType, replace: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_accel_map_change_entry".}
proc accelMapLoad*(file_name: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_accel_map_load".}
proc accelMapSave*(file_name: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_accel_map_save".}
proc accelMapForeach*(data: Gpointer, foreach_func: TAccelMapForeach){.cdecl, 
    dynlib: lib, importc: "gtk_accel_map_foreach".}
proc accelMapLoadFd*(fd: Gint){.cdecl, dynlib: lib, 
                                   importc: "gtk_accel_map_load_fd".}
proc accelMapLoadScanner*(scanner: PGScanner){.cdecl, dynlib: lib, 
    importc: "gtk_accel_map_load_scanner".}
proc accelMapSaveFd*(fd: Gint){.cdecl, dynlib: lib, 
                                   importc: "gtk_accel_map_save_fd".}
proc accelMapAddFilter*(filter_pattern: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_accel_map_add_filter".}
proc accelMapForeachUnfiltered*(data: Gpointer, 
                                   foreach_func: TAccelMapForeach){.cdecl, 
    dynlib: lib, importc: "gtk_accel_map_foreach_unfiltered".}
proc accelMapInit*(){.cdecl, dynlib: lib, importc: "_gtk_accel_map_init".}
proc accelMapAddGroup*(accel_path: Cstring, accel_group: PAccelGroup){.cdecl, 
    dynlib: lib, importc: "_gtk_accel_map_add_group".}
proc accelMapRemoveGroup*(accel_path: Cstring, accel_group: PAccelGroup){.
    cdecl, dynlib: lib, importc: "_gtk_accel_map_remove_group".}
proc accelPathIsValid*(accel_path: Cstring): Gboolean{.cdecl, dynlib: lib, 
    importc: "_gtk_accel_path_is_valid".}
proc typeAccessible*(): GType
proc accessible*(obj: Pointer): PAccessible
proc accessibleClass*(klass: Pointer): PAccessibleClass
proc isAccessible*(obj: Pointer): Bool
proc isAccessibleClass*(klass: Pointer): Bool
proc accessibleGetClass*(obj: Pointer): PAccessibleClass
proc accessibleGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_accessible_get_type".}
proc connectWidgetDestroyed*(accessible: PAccessible){.cdecl, 
    dynlib: lib, importc: "gtk_accessible_connect_widget_destroyed".}
proc typeAdjustment*(): GType
proc adjustment*(obj: Pointer): PAdjustment
proc adjustmentClass*(klass: Pointer): PAdjustmentClass
proc isAdjustment*(obj: Pointer): Bool
proc isAdjustmentClass*(klass: Pointer): Bool
proc adjustmentGetClass*(obj: Pointer): PAdjustmentClass
proc adjustmentGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_adjustment_get_type".}
proc adjustmentNew*(value: Gdouble, lower: Gdouble, upper: Gdouble, 
                     step_increment: Gdouble, page_increment: Gdouble, 
                     page_size: Gdouble): PAdjustment{.cdecl, dynlib: lib, 
    importc: "gtk_adjustment_new".}
proc changed*(adjustment: PAdjustment){.cdecl, dynlib: lib, 
    importc: "gtk_adjustment_changed".}
proc valueChanged*(adjustment: PAdjustment){.cdecl, dynlib: lib, 
    importc: "gtk_adjustment_value_changed".}
proc clampPage*(adjustment: PAdjustment, lower: Gdouble, 
                            upper: Gdouble){.cdecl, dynlib: lib, 
    importc: "gtk_adjustment_clamp_page".}
proc getValue*(adjustment: PAdjustment): Gdouble{.cdecl, 
    dynlib: lib, importc: "gtk_adjustment_get_value".}
proc setValue*(adjustment: PAdjustment, value: Gdouble){.cdecl, 
    dynlib: lib, importc: "gtk_adjustment_set_value".}
proc getUpper*(adjustment: PAdjustment): Gdouble{.cdecl, 
    dynlib: lib, importc: "gtk_adjustment_get_upper".}
proc getPageSize*(adjustment: PAdjustment): Gdouble{.cdecl, 
    dynlib: lib, importc: "gtk_adjustment_get_page_size".}
proc typeAlignment*(): GType
proc alignment*(obj: Pointer): PAlignment
proc alignmentClass*(klass: Pointer): PAlignmentClass
proc isAlignment*(obj: Pointer): Bool
proc isAlignmentClass*(klass: Pointer): Bool
proc alignmentGetClass*(obj: Pointer): PAlignmentClass
proc alignmentGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_alignment_get_type".}
proc alignmentNew*(xalign: Gfloat, yalign: Gfloat, xscale: Gfloat, 
                    yscale: Gfloat): PAlignment{.cdecl, dynlib: lib, 
    importc: "gtk_alignment_new".}
proc set*(alignment: PAlignment, xalign: Gfloat, yalign: Gfloat, 
                    xscale: Gfloat, yscale: Gfloat){.cdecl, dynlib: lib, 
    importc: "gtk_alignment_set".}
proc typeFrame*(): GType
proc frame*(obj: Pointer): PFrame
proc frameClass*(klass: Pointer): PFrameClass
proc isFrame*(obj: Pointer): Bool
proc isFrameClass*(klass: Pointer): Bool
proc frameGetClass*(obj: Pointer): PFrameClass
proc frameGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_frame_get_type".}
proc frameNew*(`label`: Cstring): PFrame{.cdecl, dynlib: lib, 
    importc: "gtk_frame_new".}
proc setLabel*(frame: PFrame, `label`: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_frame_set_label".}
proc getLabel*(frame: PFrame): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_frame_get_label".}
proc setLabelWidget*(frame: PFrame, label_widget: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_frame_set_label_widget".}
proc getLabelWidget*(frame: PFrame): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_frame_get_label_widget".}
proc setLabelAlign*(frame: PFrame, xalign: Gfloat, yalign: Gfloat){.
    cdecl, dynlib: lib, importc: "gtk_frame_set_label_align".}
proc getLabelAlign*(frame: PFrame, xalign: Pgfloat, yalign: Pgfloat){.
    cdecl, dynlib: lib, importc: "gtk_frame_get_label_align".}
proc setShadowType*(frame: PFrame, thetype: TShadowType){.cdecl, 
    dynlib: lib, importc: "gtk_frame_set_shadow_type".}
proc getShadowType*(frame: PFrame): TShadowType{.cdecl, dynlib: lib, 
    importc: "gtk_frame_get_shadow_type".}
proc typeAspectFrame*(): GType
proc aspectFrame*(obj: Pointer): PAspectFrame
proc aspectFrameClass*(klass: Pointer): PAspectFrameClass
proc isAspectFrame*(obj: Pointer): Bool
proc isAspectFrameClass*(klass: Pointer): Bool
proc aspectFrameGetClass*(obj: Pointer): PAspectFrameClass
proc aspectFrameGetType*(): TType{.cdecl, dynlib: lib, 
                                      importc: "gtk_aspect_frame_get_type".}
proc aspectFrameNew*(`label`: Cstring, xalign: Gfloat, yalign: Gfloat, 
                       ratio: Gfloat, obey_child: Gboolean): PAspectFrame{.
    cdecl, dynlib: lib, importc: "gtk_aspect_frame_new".}
proc set*(aspect_frame: PAspectFrame, xalign: Gfloat, 
                       yalign: Gfloat, ratio: Gfloat, obey_child: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_aspect_frame_set".}
proc typeArrow*(): GType
proc arrow*(obj: Pointer): PArrow
proc arrowClass*(klass: Pointer): PArrowClass
proc isArrow*(obj: Pointer): Bool
proc isArrowClass*(klass: Pointer): Bool
proc arrowGetClass*(obj: Pointer): PArrowClass
proc arrowGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_arrow_get_type".}
proc arrowNew*(arrow_type: TArrowType, shadow_type: TShadowType): PArrow{.
    cdecl, dynlib: lib, importc: "gtk_arrow_new".}
proc set*(arrow: PArrow, arrow_type: TArrowType, shadow_type: TShadowType){.
    cdecl, dynlib: lib, importc: "gtk_arrow_set".}
const 
  bmTGtkBindingSetParsed* = 0x0001'i16
  bpTGtkBindingSetParsed* = 0'i16
  bmTGtkBindingEntryDestroyed* = 0x0001'i16
  bpTGtkBindingEntryDestroyed* = 0'i16
  bmTGtkBindingEntryInEmission* = 0x0002'i16
  bpTGtkBindingEntryInEmission* = 1'i16

proc entryAdd*(binding_set: PBindingSet, keyval: Guint, 
                        modifiers: gdk2.TModifierType)
proc parsed*(a: PBindingSet): Guint
proc setParsed*(a: PBindingSet, `parsed`: Guint)
proc destroyed*(a: PBindingEntry): Guint
proc setDestroyed*(a: PBindingEntry, `destroyed`: Guint)
proc inEmission*(a: PBindingEntry): Guint
proc setInEmission*(a: PBindingEntry, `in_emission`: Guint)
proc bindingSetNew*(set_name: Cstring): PBindingSet{.cdecl, dynlib: lib, 
    importc: "gtk_binding_set_new".}
proc bindingSetByClass*(object_class: Gpointer): PBindingSet{.cdecl, 
    dynlib: lib, importc: "gtk_binding_set_by_class".}
proc bindingSetFind*(set_name: Cstring): PBindingSet{.cdecl, dynlib: lib, 
    importc: "gtk_binding_set_find".}
proc bindingsActivate*(anObject: PObject, keyval: Guint, 
                        modifiers: gdk2.TModifierType): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_bindings_activate".}
proc activate*(binding_set: PBindingSet, keyval: Guint, 
                           modifiers: gdk2.TModifierType, anObject: PObject): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_binding_set_activate".}
proc entryClear*(binding_set: PBindingSet, keyval: Guint, 
                          modifiers: gdk2.TModifierType){.cdecl, dynlib: lib, 
    importc: "gtk_binding_entry_clear".}
proc addPath*(binding_set: PBindingSet, path_type: TPathType, 
                           path_pattern: Cstring, priority: TPathPriorityType){.
    cdecl, dynlib: lib, importc: "gtk_binding_set_add_path".}
proc entryRemove*(binding_set: PBindingSet, keyval: Guint, 
                           modifiers: gdk2.TModifierType){.cdecl, dynlib: lib, 
    importc: "gtk_binding_entry_remove".}
proc entryAddSignall*(binding_set: PBindingSet, keyval: Guint, 
                                modifiers: gdk2.TModifierType, 
                                signal_name: Cstring, binding_args: PGSList){.
    cdecl, dynlib: lib, importc: "gtk_binding_entry_add_signall".}
proc bindingParseBinding*(scanner: PGScanner): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_binding_parse_binding".}
proc bindingsActivateEvent*(anObject: PObject, event: gdk2.PEventKey): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_bindings_activate_event".}
proc bindingResetParsed*(){.cdecl, dynlib: lib, 
                              importc: "_gtk_binding_reset_parsed".}
const 
  bmTGtkBoxHomogeneous* = 0x0001'i16
  bpTGtkBoxHomogeneous* = 0'i16
  bmTGtkBoxChildExpand* = 0x0001'i16
  bpTGtkBoxChildExpand* = 0'i16
  bmTGtkBoxChildFill* = 0x0002'i16
  bpTGtkBoxChildFill* = 1'i16
  bmTGtkBoxChildPack* = 0x0004'i16
  bpTGtkBoxChildPack* = 2'i16
  bmTGtkBoxChildIsSecondary* = 0x0008'i16
  bpTGtkBoxChildIsSecondary* = 3'i16

proc typeBox*(): GType
proc box*(obj: Pointer): PBox
proc boxClass*(klass: Pointer): PBoxClass
proc isBox*(obj: Pointer): Bool
proc isBoxClass*(klass: Pointer): Bool
proc boxGetClass*(obj: Pointer): PBoxClass
proc homogeneous*(a: PBox): Guint
proc setHomogeneous*(a: PBox, `homogeneous`: Guint)
proc expand*(a: PBoxChild): Guint
proc setExpand*(a: PBoxChild, `expand`: Guint)
proc fill*(a: PBoxChild): Guint
proc setFill*(a: PBoxChild, `fill`: Guint)
proc pack*(a: PBoxChild): Guint
proc setPack*(a: PBoxChild, `pack`: Guint)
proc isSecondary*(a: PBoxChild): Guint
proc setIsSecondary*(a: PBoxChild, `is_secondary`: Guint)
proc boxGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_box_get_type".}
proc packStart*(box: PBox, child: PWidget, expand: Gboolean, 
                     fill: Gboolean, padding: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_box_pack_start".}
proc packEnd*(box: PBox, child: PWidget, expand: Gboolean, fill: Gboolean, 
                   padding: Guint){.cdecl, dynlib: lib, 
                                    importc: "gtk_box_pack_end".}
proc packStartDefaults*(box: PBox, widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_box_pack_start_defaults".}
proc packEndDefaults*(box: PBox, widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_box_pack_end_defaults".}
proc setHomogeneous*(box: PBox, homogeneous: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_box_set_homogeneous".}
proc getHomogeneous*(box: PBox): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_box_get_homogeneous".}
proc setSpacing*(box: PBox, spacing: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_box_set_spacing".}
proc getSpacing*(box: PBox): Gint{.cdecl, dynlib: lib, 
                                        importc: "gtk_box_get_spacing".}
proc reorderChild*(box: PBox, child: PWidget, position: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_box_reorder_child".}
proc queryChildPacking*(box: PBox, child: PWidget, expand: Pgboolean, 
                              fill: Pgboolean, padding: Pguint, 
                              pack_type: PPackType){.cdecl, dynlib: lib, 
    importc: "gtk_box_query_child_packing".}
proc setChildPacking*(box: PBox, child: PWidget, expand: Gboolean, 
                            fill: Gboolean, padding: Guint, pack_type: TPackType){.
    cdecl, dynlib: lib, importc: "gtk_box_set_child_packing".}
const 
  ButtonboxDefault* = - (1)

proc typeButtonBox*(): GType
proc buttonBox*(obj: Pointer): PButtonBox
proc buttonBoxClass*(klass: Pointer): PButtonBoxClass
proc isButtonBox*(obj: Pointer): Bool
proc isButtonBoxClass*(klass: Pointer): Bool
proc buttonBoxGetClass*(obj: Pointer): PButtonBoxClass
proc buttonBoxGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_button_box_get_type".}
proc getLayout*(widget: PButtonBox): TButtonBoxStyle{.cdecl, 
    dynlib: lib, importc: "gtk_button_box_get_layout".}
proc setLayout*(widget: PButtonBox, layout_style: TButtonBoxStyle){.
    cdecl, dynlib: lib, importc: "gtk_button_box_set_layout".}
proc setChildSecondary*(widget: PButtonBox, child: PWidget, 
                                     is_secondary: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_button_box_set_child_secondary".}
proc buttonBoxChildRequisition*(widget: PWidget, nvis_children: var Int32, 
                                   nvis_secondaries: var Int32, 
                                   width: var Int32, height: var Int32){.cdecl, 
    dynlib: lib, importc: "_gtk_button_box_child_requisition".}
const 
  bmTGtkButtonConstructed* = 0x0001'i16
  bpTGtkButtonConstructed* = 0'i16
  bmTGtkButtonInButton* = 0x0002'i16
  bpTGtkButtonInButton* = 1'i16
  bmTGtkButtonButtonDown* = 0x0004'i16
  bpTGtkButtonButtonDown* = 2'i16
  bmTGtkButtonRelief* = 0x0018'i16
  bpTGtkButtonRelief* = 3'i16
  bmTGtkButtonUseUnderline* = 0x0020'i16
  bpTGtkButtonUseUnderline* = 5'i16
  bmTGtkButtonUseStock* = 0x0040'i16
  bpTGtkButtonUseStock* = 6'i16
  bmTGtkButtonDepressed* = 0x0080'i16
  bpTGtkButtonDepressed* = 7'i16
  bmTGtkButtonDepressOnActivate* = 0x0100'i16
  bpTGtkButtonDepressOnActivate* = 8'i16

proc typeButton*(): GType
proc button*(obj: Pointer): PButton
proc buttonClass*(klass: Pointer): PButtonClass
proc isButton*(obj: Pointer): Bool
proc isButtonClass*(klass: Pointer): Bool
proc buttonGetClass*(obj: Pointer): PButtonClass
proc constructed*(a: PButton): Guint
proc setConstructed*(a: PButton, `constructed`: Guint)
proc inButton*(a: PButton): Guint
proc setInButton*(a: PButton, `in_button`: Guint)
proc buttonDown*(a: PButton): Guint
proc setButtonDown*(a: PButton, `button_down`: Guint)
proc relief*(a: PButton): Guint
proc useUnderline*(a: PButton): Guint
proc setUseUnderline*(a: PButton, `use_underline`: Guint)
proc useStock*(a: PButton): Guint
proc setUseStock*(a: PButton, `use_stock`: Guint)
proc depressed*(a: PButton): Guint
proc setDepressed*(a: PButton, `depressed`: Guint)
proc depressOnActivate*(a: PButton): Guint
proc setDepressOnActivate*(a: PButton, `depress_on_activate`: Guint)
proc buttonGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_button_get_type".}
proc buttonNew*(): PButton{.cdecl, dynlib: lib, importc: "gtk_button_new".}
proc buttonNew*(`label`: Cstring): PButton{.cdecl, dynlib: lib, 
    importc: "gtk_button_new_with_label".}
proc buttonNewFromStock*(stock_id: Cstring): PButton{.cdecl, dynlib: lib, 
    importc: "gtk_button_new_from_stock".}
proc buttonNewWithMnemonic*(`label`: Cstring): PButton{.cdecl, dynlib: lib, 
    importc: "gtk_button_new_with_mnemonic".}
proc pressed*(button: PButton){.cdecl, dynlib: lib, 
                                       importc: "gtk_button_pressed".}
proc released*(button: PButton){.cdecl, dynlib: lib, 
                                        importc: "gtk_button_released".}
proc clicked*(button: PButton){.cdecl, dynlib: lib, 
                                       importc: "gtk_button_clicked".}
proc enter*(button: PButton){.cdecl, dynlib: lib, 
                                     importc: "gtk_button_enter".}
proc leave*(button: PButton){.cdecl, dynlib: lib, 
                                     importc: "gtk_button_leave".}
proc setRelief*(button: PButton, newstyle: TReliefStyle){.cdecl, 
    dynlib: lib, importc: "gtk_button_set_relief".}
proc getRelief*(button: PButton): TReliefStyle{.cdecl, dynlib: lib, 
    importc: "gtk_button_get_relief".}
proc setLabel*(button: PButton, `label`: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_button_set_label".}
proc getLabel*(button: PButton): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_button_get_label".}
proc setUseUnderline*(button: PButton, use_underline: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_button_set_use_underline".}
proc getUseUnderline*(button: PButton): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_button_get_use_underline".}
proc setUseStock*(button: PButton, use_stock: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_button_set_use_stock".}
proc getUseStock*(button: PButton): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_button_get_use_stock".}
proc setDepressed*(button: PButton, depressed: Gboolean){.cdecl, 
    dynlib: lib, importc: "_gtk_button_set_depressed".}
proc paint*(button: PButton, area: gdk2.PRectangle, state_type: TStateType, 
                   shadow_type: TShadowType, main_detail: Cstring, 
                   default_detail: Cstring){.cdecl, dynlib: lib, 
    importc: "_gtk_button_paint".}
proc setImage*(button: PButton, image: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_button_set_image".}
proc getImage*(button: PButton): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_button_get_image".}
const 
  CalendarShowHeading* = 1 shl 0
  CalendarShowDayNames* = 1 shl 1
  CalendarNoMonthChange* = 1 shl 2
  CalendarShowWeekNumbers* = 1 shl 3
  CalendarWeekStartMonday* = 1 shl 4

proc typeCalendar*(): GType
proc calendar*(obj: Pointer): PCalendar
proc calendarClass*(klass: Pointer): PCalendarClass
proc isCalendar*(obj: Pointer): Bool
proc isCalendarClass*(klass: Pointer): Bool
proc calendarGetClass*(obj: Pointer): PCalendarClass
proc calendarGetType*(): TType{.cdecl, dynlib: lib, 
                                  importc: "gtk_calendar_get_type".}
proc calendarNew*(): PCalendar{.cdecl, dynlib: lib, importc: "gtk_calendar_new".}
proc selectMonth*(calendar: PCalendar, month: Guint, year: Guint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_calendar_select_month".}
proc selectDay*(calendar: PCalendar, day: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_calendar_select_day".}
proc markDay*(calendar: PCalendar, day: Guint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_calendar_mark_day".}
proc unmarkDay*(calendar: PCalendar, day: Guint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_calendar_unmark_day".}
proc clearMarks*(calendar: PCalendar){.cdecl, dynlib: lib, 
    importc: "gtk_calendar_clear_marks".}
proc displayOptions*(calendar: PCalendar, 
                               flags: TCalendarDisplayOptions){.cdecl, 
    dynlib: lib, importc: "gtk_calendar_display_options".}
proc getDate*(calendar: PCalendar, year: Pguint, month: Pguint, 
                        day: Pguint){.cdecl, dynlib: lib, 
                                      importc: "gtk_calendar_get_date".}
proc freeze*(calendar: PCalendar){.cdecl, dynlib: lib, 
    importc: "gtk_calendar_freeze".}
proc thaw*(calendar: PCalendar){.cdecl, dynlib: lib, 
    importc: "gtk_calendar_thaw".}
proc typeCellEditable*(): GType
proc cellEditable*(obj: Pointer): PCellEditable
proc cellEditableClass*(obj: Pointer): PCellEditableIface
proc isCellEditable*(obj: Pointer): Bool
proc cellEditableGetIface*(obj: Pointer): PCellEditableIface
proc cellEditableGetType*(): GType{.cdecl, dynlib: lib, 
                                       importc: "gtk_cell_editable_get_type".}
proc startEditing*(cell_editable: PCellEditable, event: gdk2.PEvent){.
    cdecl, dynlib: lib, importc: "gtk_cell_editable_start_editing".}
proc editingDone*(cell_editable: PCellEditable){.cdecl, 
    dynlib: lib, importc: "gtk_cell_editable_editing_done".}
proc removeWidget*(cell_editable: PCellEditable){.cdecl, 
    dynlib: lib, importc: "gtk_cell_editable_remove_widget".}
const 
  CellRendererSelected* = 1 shl 0
  CellRendererPrelit* = 1 shl 1
  CellRendererInsensitive* = 1 shl 2
  CellRendererSorted* = 1 shl 3

const 
  bmTGtkCellRendererMode* = 0x0003'i16
  bpTGtkCellRendererMode* = 0'i16
  bmTGtkCellRendererVisible* = 0x0004'i16
  bpTGtkCellRendererVisible* = 2'i16
  bmTGtkCellRendererIsExpander* = 0x0008'i16
  bpTGtkCellRendererIsExpander* = 3'i16
  bmTGtkCellRendererIsExpanded* = 0x0010'i16
  bpTGtkCellRendererIsExpanded* = 4'i16
  bmTGtkCellRendererCellBackgroundSet* = 0x0020'i16
  bpTGtkCellRendererCellBackgroundSet* = 5'i16

proc typeCellRenderer*(): GType
proc cellRenderer*(obj: Pointer): PCellRenderer
proc cellRendererClass*(klass: Pointer): PCellRendererClass
proc isCellRenderer*(obj: Pointer): Bool
proc isCellRendererClass*(klass: Pointer): Bool
proc cellRendererGetClass*(obj: Pointer): PCellRendererClass
proc mode*(a: PCellRenderer): Guint
proc setMode*(a: PCellRenderer, `mode`: Guint)
proc visible*(a: PCellRenderer): Guint
proc setVisible*(a: PCellRenderer, `visible`: Guint)
proc isExpander*(a: PCellRenderer): Guint
proc setIsExpander*(a: PCellRenderer, `is_expander`: Guint)
proc isExpanded*(a: PCellRenderer): Guint
proc setIsExpanded*(a: PCellRenderer, `is_expanded`: Guint)
proc cellBackgroundSet*(a: PCellRenderer): Guint
proc setCellBackgroundSet*(a: PCellRenderer, `cell_background_set`: Guint)
proc cellRendererGetType*(): GType{.cdecl, dynlib: lib, 
                                       importc: "gtk_cell_renderer_get_type".}
proc getSize*(cell: PCellRenderer, widget: PWidget, 
                             cell_area: gdk2.PRectangle, x_offset: Pgint, 
                             y_offset: Pgint, width: Pgint, height: Pgint){.
    cdecl, dynlib: lib, importc: "gtk_cell_renderer_get_size".}
proc render*(cell: PCellRenderer, window: gdk2.PWindow, 
                           widget: PWidget, background_area: gdk2.PRectangle, 
                           cell_area: gdk2.PRectangle, expose_area: gdk2.PRectangle, 
                           flags: TCellRendererState){.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_render".}
proc activate*(cell: PCellRenderer, event: gdk2.PEvent, 
                             widget: PWidget, path: Cstring, 
                             background_area: gdk2.PRectangle, 
                             cell_area: gdk2.PRectangle, flags: TCellRendererState): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_cell_renderer_activate".}
proc startEditing*(cell: PCellRenderer, event: gdk2.PEvent, 
                                  widget: PWidget, path: Cstring, 
                                  background_area: gdk2.PRectangle, 
                                  cell_area: gdk2.PRectangle, 
                                  flags: TCellRendererState): PCellEditable{.
    cdecl, dynlib: lib, importc: "gtk_cell_renderer_start_editing".}
proc setFixedSize*(cell: PCellRenderer, width: Gint, 
                                   height: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_set_fixed_size".}
proc getFixedSize*(cell: PCellRenderer, width: Pgint, 
                                   height: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_get_fixed_size".}
const 
  bmTGtkCellRendererTextStrikethrough* = 0x0001'i16
  bpTGtkCellRendererTextStrikethrough* = 0'i16
  bmTGtkCellRendererTextEditable* = 0x0002'i16
  bpTGtkCellRendererTextEditable* = 1'i16
  bmTGtkCellRendererTextScaleSet* = 0x0004'i16
  bpTGtkCellRendererTextScaleSet* = 2'i16
  bmTGtkCellRendererTextForegroundSet* = 0x0008'i16
  bpTGtkCellRendererTextForegroundSet* = 3'i16
  bmTGtkCellRendererTextBackgroundSet* = 0x0010'i16
  bpTGtkCellRendererTextBackgroundSet* = 4'i16
  bmTGtkCellRendererTextUnderlineSet* = 0x0020'i16
  bpTGtkCellRendererTextUnderlineSet* = 5'i16
  bmTGtkCellRendererTextRiseSet* = 0x0040'i16
  bpTGtkCellRendererTextRiseSet* = 6'i16
  bmTGtkCellRendererTextStrikethroughSet* = 0x0080'i16
  bpTGtkCellRendererTextStrikethroughSet* = 7'i16
  bmTGtkCellRendererTextEditableSet* = 0x0100'i16
  bpTGtkCellRendererTextEditableSet* = 8'i16
  bmTGtkCellRendererTextCalcFixedHeight* = 0x0200'i16
  bpTGtkCellRendererTextCalcFixedHeight* = 9'i16

proc typeCellRendererText*(): GType
proc cellRendererText*(obj: Pointer): PCellRendererText
proc cellRendererTextClass*(klass: Pointer): PCellRendererTextClass
proc isCellRendererText*(obj: Pointer): Bool
proc isCellRendererTextClass*(klass: Pointer): Bool
proc cellRendererTextGetClass*(obj: Pointer): PCellRendererTextClass
proc strikethrough*(a: PCellRendererText): Guint
proc setStrikethrough*(a: PCellRendererText, `strikethrough`: Guint)
proc editable*(a: PCellRendererText): Guint
proc setEditable*(a: PCellRendererText, `editable`: Guint)
proc scaleSet*(a: PCellRendererText): Guint
proc setScaleSet*(a: PCellRendererText, `scale_set`: Guint)
proc foregroundSet*(a: PCellRendererText): Guint
proc setForegroundSet*(a: PCellRendererText, `foreground_set`: Guint)
proc backgroundSet*(a: PCellRendererText): Guint
proc setBackgroundSet*(a: PCellRendererText, `background_set`: Guint)
proc underlineSet*(a: PCellRendererText): Guint
proc setUnderlineSet*(a: PCellRendererText, `underline_set`: Guint)
proc riseSet*(a: PCellRendererText): Guint
proc setRiseSet*(a: PCellRendererText, `rise_set`: Guint)
proc strikethroughSet*(a: PCellRendererText): Guint
proc setStrikethroughSet*(a: PCellRendererText, `strikethrough_set`: Guint)
proc editableSet*(a: PCellRendererText): Guint
proc setEditableSet*(a: PCellRendererText, `editable_set`: Guint)
proc calcFixedHeight*(a: PCellRendererText): Guint
proc setCalcFixedHeight*(a: PCellRendererText, `calc_fixed_height`: Guint)
proc cellRendererTextGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_text_get_type".}
proc cellRendererTextNew*(): PCellRenderer{.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_text_new".}
proc textSetFixedHeightFromFont*(renderer: PCellRendererText, 
    number_of_rows: Gint){.cdecl, dynlib: lib, importc: "gtk_cell_renderer_text_set_fixed_height_from_font".}
const 
  bmTGtkCellRendererToggleActive* = 0x0001'i16
  bpTGtkCellRendererToggleActive* = 0'i16
  bmTGtkCellRendererToggleActivatable* = 0x0002'i16
  bpTGtkCellRendererToggleActivatable* = 1'i16
  bmTGtkCellRendererToggleRadio* = 0x0004'i16
  bpTGtkCellRendererToggleRadio* = 2'i16

proc typeCellRendererToggle*(): GType
proc cellRendererToggle*(obj: Pointer): PCellRendererToggle
proc cellRendererToggleClass*(klass: Pointer): PCellRendererToggleClass
proc isCellRendererToggle*(obj: Pointer): Bool
proc isCellRendererToggleClass*(klass: Pointer): Bool
proc cellRendererToggleGetClass*(obj: Pointer): PCellRendererToggleClass
proc active*(a: PCellRendererToggle): Guint
proc setActive*(a: PCellRendererToggle, `active`: Guint)
proc activatable*(a: PCellRendererToggle): Guint
proc setActivatable*(a: PCellRendererToggle, `activatable`: Guint)
proc radio*(a: PCellRendererToggle): Guint
proc setRadio*(a: PCellRendererToggle, `radio`: Guint)
proc cellRendererToggleGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_toggle_get_type".}
proc cellRendererToggleNew*(): PCellRenderer{.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_toggle_new".}
proc toggleGetRadio*(toggle: PCellRendererToggle): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_cell_renderer_toggle_get_radio".}
proc toggleSetRadio*(toggle: PCellRendererToggle, 
                                     radio: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_toggle_set_radio".}
proc toggleGetActive*(toggle: PCellRendererToggle): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_cell_renderer_toggle_get_active".}
proc toggleSetActive*(toggle: PCellRendererToggle, 
                                      setting: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_toggle_set_active".}
proc typeCellRendererPixbuf*(): GType
proc cellRendererPixbuf*(obj: Pointer): PCellRendererPixbuf
proc cellRendererPixbufClass*(klass: Pointer): PCellRendererPixbufClass
proc isCellRendererPixbuf*(obj: Pointer): Bool
proc isCellRendererPixbufClass*(klass: Pointer): Bool
proc cellRendererPixbufGetClass*(obj: Pointer): PCellRendererPixbufClass
proc cellRendererPixbufGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_pixbuf_get_type".}
proc cellRendererPixbufNew*(): PCellRenderer{.cdecl, dynlib: lib, 
    importc: "gtk_cell_renderer_pixbuf_new".}
proc typeItem*(): GType
proc item*(obj: Pointer): PItem
proc itemClass*(klass: Pointer): PItemClass
proc isItem*(obj: Pointer): Bool
proc isItemClass*(klass: Pointer): Bool
proc itemGetClass*(obj: Pointer): PItemClass
proc itemGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_item_get_type".}
proc select*(item: PItem){.cdecl, dynlib: lib, importc: "gtk_item_select".}
proc deselect*(item: PItem){.cdecl, dynlib: lib, 
                                  importc: "gtk_item_deselect".}
proc toggle*(item: PItem){.cdecl, dynlib: lib, importc: "gtk_item_toggle".}
const 
  bmTGtkMenuItemShowSubmenuIndicator* = 0x0001'i16
  bpTGtkMenuItemShowSubmenuIndicator* = 0'i16
  bmTGtkMenuItemSubmenuPlacement* = 0x0002'i16
  bpTGtkMenuItemSubmenuPlacement* = 1'i16
  bmTGtkMenuItemSubmenuDirection* = 0x0004'i16
  bpTGtkMenuItemSubmenuDirection* = 2'i16
  bmTGtkMenuItemRightJustify* = 0x0008'i16
  bpTGtkMenuItemRightJustify* = 3'i16
  bmTGtkMenuItemTimerFromKeypress* = 0x0010'i16
  bpTGtkMenuItemTimerFromKeypress* = 4'i16
  bmTGtkMenuItemClassHideOnActivate* = 0x0001'i16
  bpTGtkMenuItemClassHideOnActivate* = 0'i16

proc typeMenuItem*(): GType
proc menuItem*(obj: Pointer): PMenuItem
proc menuItemClass*(klass: Pointer): PMenuItemClass
proc isMenuItem*(obj: Pointer): Bool
proc isMenuItemClass*(klass: Pointer): Bool
proc menuItemGetClass*(obj: Pointer): PMenuItemClass
proc showSubmenuIndicator*(a: PMenuItem): Guint
proc setShowSubmenuIndicator*(a: PMenuItem, 
                                 `show_submenu_indicator`: Guint)
proc submenuPlacement*(a: PMenuItem): Guint
proc setSubmenuPlacement*(a: PMenuItem, `submenu_placement`: Guint)
proc submenuDirection*(a: PMenuItem): Guint
proc setSubmenuDirection*(a: PMenuItem, `submenu_direction`: Guint)
proc rightJustify*(a: PMenuItem): Guint
proc setRightJustify*(a: PMenuItem, `right_justify`: Guint)
proc timerFromKeypress*(a: PMenuItem): Guint
proc setTimerFromKeypress*(a: PMenuItem, `timer_from_keypress`: Guint)
proc hideOnActivate*(a: PMenuItemClass): Guint
proc setHideOnActivate*(a: PMenuItemClass, `hide_on_activate`: Guint)
proc menuItemGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_menu_item_get_type".}
proc menuItemNew*(): PMenuItem{.cdecl, dynlib: lib, 
                                  importc: "gtk_menu_item_new".}
proc menuItemNew*(`label`: Cstring): PMenuItem{.cdecl, dynlib: lib, 
    importc: "gtk_menu_item_new_with_label".}
proc menuItemNewWithMnemonic*(`label`: Cstring): PMenuItem{.cdecl, 
    dynlib: lib, importc: "gtk_menu_item_new_with_mnemonic".}
proc setSubmenu*(menu_item: PMenuItem, submenu: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_menu_item_set_submenu".}
proc getSubmenu*(menu_item: PMenuItem): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_menu_item_get_submenu".}
proc removeSubmenu*(menu_item: PMenuItem){.cdecl, dynlib: lib, 
    importc: "gtk_menu_item_remove_submenu".}
proc select*(menu_item: PMenuItem){.cdecl, dynlib: lib, 
    importc: "gtk_menu_item_select".}
proc deselect*(menu_item: PMenuItem){.cdecl, dynlib: lib, 
    importc: "gtk_menu_item_deselect".}
proc activate*(menu_item: PMenuItem){.cdecl, dynlib: lib, 
    importc: "gtk_menu_item_activate".}
proc toggleSizeRequest*(menu_item: PMenuItem, requisition: Pgint){.
    cdecl, dynlib: lib, importc: "gtk_menu_item_toggle_size_request".}
proc toggleSizeAllocate*(menu_item: PMenuItem, allocation: Gint){.
    cdecl, dynlib: lib, importc: "gtk_menu_item_toggle_size_allocate".}
proc setRightJustified*(menu_item: PMenuItem, 
                                    right_justified: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_menu_item_set_right_justified".}
proc getRightJustified*(menu_item: PMenuItem): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_menu_item_get_right_justified".}
proc setAccelPath*(menu_item: PMenuItem, accel_path: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_menu_item_set_accel_path".}
proc refreshAccelPath*(menu_item: PMenuItem, prefix: Cstring, 
                                   accel_group: PAccelGroup, 
                                   group_changed: Gboolean){.cdecl, dynlib: lib, 
    importc: "_gtk_menu_item_refresh_accel_path".}
proc menuItemIsSelectable*(menu_item: PWidget): Gboolean{.cdecl, dynlib: lib, 
    importc: "_gtk_menu_item_is_selectable".}
const 
  bmTGtkToggleButtonActive* = 0x0001'i16
  bpTGtkToggleButtonActive* = 0'i16
  bmTGtkToggleButtonDrawIndicator* = 0x0002'i16
  bpTGtkToggleButtonDrawIndicator* = 1'i16
  bmTGtkToggleButtonInconsistent* = 0x0004'i16
  bpTGtkToggleButtonInconsistent* = 2'i16

proc typeToggleButton*(): GType
proc toggleButton*(obj: Pointer): PToggleButton
proc toggleButtonClass*(klass: Pointer): PToggleButtonClass
proc isToggleButton*(obj: Pointer): Bool
proc isToggleButtonClass*(klass: Pointer): Bool
proc toggleButtonGetClass*(obj: Pointer): PToggleButtonClass
proc active*(a: PToggleButton): Guint
proc setActive*(a: PToggleButton, `active`: Guint)
proc drawIndicator*(a: PToggleButton): Guint
proc setDrawIndicator*(a: PToggleButton, `draw_indicator`: Guint)
proc inconsistent*(a: PToggleButton): Guint
proc setInconsistent*(a: PToggleButton, `inconsistent`: Guint)
proc toggleButtonGetType*(): TType{.cdecl, dynlib: lib, 
                                       importc: "gtk_toggle_button_get_type".}
proc toggleButtonNew*(): PToggleButton{.cdecl, dynlib: lib, 
    importc: "gtk_toggle_button_new".}
proc toggleButtonNew*(`label`: Cstring): PToggleButton{.cdecl, 
    dynlib: lib, importc: "gtk_toggle_button_new_with_label".}
proc toggleButtonNewWithMnemonic*(`label`: Cstring): PToggleButton{.cdecl, 
    dynlib: lib, importc: "gtk_toggle_button_new_with_mnemonic".}
proc setMode*(toggle_button: PToggleButton, 
                             draw_indicator: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_toggle_button_set_mode".}
proc getMode*(toggle_button: PToggleButton): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_toggle_button_get_mode".}
proc setActive*(toggle_button: PToggleButton, is_active: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_toggle_button_set_active".}
proc getActive*(toggle_button: PToggleButton): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_toggle_button_get_active".}
proc toggled*(toggle_button: PToggleButton){.cdecl, dynlib: lib, 
    importc: "gtk_toggle_button_toggled".}
proc setInconsistent*(toggle_button: PToggleButton, 
                                     setting: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_toggle_button_set_inconsistent".}
proc getInconsistent*(toggle_button: PToggleButton): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_toggle_button_get_inconsistent".}
proc typeCheckButton*(): GType
proc checkButton*(obj: Pointer): PCheckButton
proc checkButtonClass*(klass: Pointer): PCheckButtonClass
proc isCheckButton*(obj: Pointer): Bool
proc isCheckButtonClass*(klass: Pointer): Bool
proc checkButtonGetClass*(obj: Pointer): PCheckButtonClass
proc checkButtonGetType*(): TType{.cdecl, dynlib: lib, 
                                      importc: "gtk_check_button_get_type".}
proc checkButtonNew*(): PCheckButton{.cdecl, dynlib: lib, 
                                        importc: "gtk_check_button_new".}
proc checkButtonNew*(`label`: Cstring): PCheckButton{.cdecl, 
    dynlib: lib, importc: "gtk_check_button_new_with_label".}
proc checkButtonNewWithMnemonic*(`label`: Cstring): PCheckButton{.cdecl, 
    dynlib: lib, importc: "gtk_check_button_new_with_mnemonic".}
proc getProps*(check_button: PCheckButton, indicator_size: Pgint, 
                             indicator_spacing: Pgint){.cdecl, dynlib: lib, 
    importc: "_gtk_check_button_get_props".}
const 
  bmTGtkCheckMenuItemActive* = 0x0001'i16
  bpTGtkCheckMenuItemActive* = 0'i16
  bmTGtkCheckMenuItemAlwaysShowToggle* = 0x0002'i16
  bpTGtkCheckMenuItemAlwaysShowToggle* = 1'i16
  bmTGtkCheckMenuItemInconsistent* = 0x0004'i16
  bpTGtkCheckMenuItemInconsistent* = 2'i16

proc typeCheckMenuItem*(): GType
proc checkMenuItem*(obj: Pointer): PCheckMenuItem
proc checkMenuItemClass*(klass: Pointer): PCheckMenuItemClass
proc isCheckMenuItem*(obj: Pointer): Bool
proc isCheckMenuItemClass*(klass: Pointer): Bool
proc checkMenuItemGetClass*(obj: Pointer): PCheckMenuItemClass
proc active*(a: PCheckMenuItem): Guint
proc setActive*(a: PCheckMenuItem, `active`: Guint)
proc alwaysShowToggle*(a: PCheckMenuItem): Guint
proc setAlwaysShowToggle*(a: PCheckMenuItem, `always_show_toggle`: Guint)
proc inconsistent*(a: PCheckMenuItem): Guint
proc setInconsistent*(a: PCheckMenuItem, `inconsistent`: Guint)
proc checkMenuItemGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_check_menu_item_get_type".}
proc checkMenuItemNew*(): PCheckMenuItem{.cdecl, dynlib: lib, 
                                      importc: "gtk_check_menu_item_new".}
proc checkMenuItemNew*(`label`: Cstring): PCheckMenuItem{.cdecl, 
    dynlib: lib, importc: "gtk_check_menu_item_new_with_label".}
proc checkMenuItemNewWithMnemonic*(`label`: Cstring): PCheckMenuItem{.cdecl, 
    dynlib: lib, importc: "gtk_check_menu_item_new_with_mnemonic".}
proc itemSetActive*(check_menu_item: PCheckMenuItem, 
                                 is_active: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_check_menu_item_set_active".}
proc itemGetActive*(check_menu_item: PCheckMenuItem): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_check_menu_item_get_active".}
proc itemToggled*(check_menu_item: PCheckMenuItem){.cdecl, 
    dynlib: lib, importc: "gtk_check_menu_item_toggled".}
proc itemSetInconsistent*(check_menu_item: PCheckMenuItem, 
                                       setting: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_check_menu_item_set_inconsistent".}
proc itemGetInconsistent*(check_menu_item: PCheckMenuItem): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_check_menu_item_get_inconsistent".}
proc clipboardGetForDisplay*(display: gdk2.PDisplay, selection: gdk2.TAtom): PClipboard{.
    cdecl, dynlib: lib, importc: "gtk_clipboard_get_for_display".}
proc getDisplay*(clipboard: PClipboard): gdk2.PDisplay{.cdecl, 
    dynlib: lib, importc: "gtk_clipboard_get_display".}
proc setWithData*(clipboard: PClipboard, targets: PTargetEntry, 
                              n_targets: Guint, get_func: TClipboardGetFunc, 
                              clear_func: TClipboardClearFunc, 
                              user_data: Gpointer): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_clipboard_set_with_data".}
proc setWithOwner*(clipboard: PClipboard, targets: PTargetEntry, 
                               n_targets: Guint, get_func: TClipboardGetFunc, 
                               clear_func: TClipboardClearFunc, owner: PGObject): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_clipboard_set_with_owner".}
proc getOwner*(clipboard: PClipboard): PGObject{.cdecl, dynlib: lib, 
    importc: "gtk_clipboard_get_owner".}
proc clear*(clipboard: PClipboard){.cdecl, dynlib: lib, 
    importc: "gtk_clipboard_clear".}
proc setText*(clipboard: PClipboard, text: Cstring, len: Gint){.
    cdecl, dynlib: lib, importc: "gtk_clipboard_set_text".}
proc requestContents*(clipboard: PClipboard, target: gdk2.TAtom, 
                                 callback: TClipboardReceivedFunc, 
                                 user_data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_clipboard_request_contents".}
proc requestText*(clipboard: PClipboard, 
                             callback: TClipboardTextReceivedFunc, 
                             user_data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_clipboard_request_text".}
proc waitForContents*(clipboard: PClipboard, target: gdk2.TAtom): PSelectionData{.
    cdecl, dynlib: lib, importc: "gtk_clipboard_wait_for_contents".}
proc waitForText*(clipboard: PClipboard): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_clipboard_wait_for_text".}
proc waitIsTextAvailable*(clipboard: PClipboard): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_clipboard_wait_is_text_available".}
const 
  ClistInDrag* = 1 shl 0
  ClistRowHeightSet* = 1 shl 1
  ClistShowTitles* = 1 shl 2
  ClistAddMode* = 1 shl 4
  ClistAutoSort* = 1 shl 5
  ClistAutoResizeBlocked* = 1 shl 6
  ClistReorderable* = 1 shl 7
  ClistUseDragIcons* = 1 shl 8
  ClistDrawDragLine* = 1 shl 9
  ClistDrawDragRect* = 1 shl 10
  ButtonIgnored* = 0
  ButtonSelects* = 1 shl 0
  ButtonDrags* = 1 shl 1
  ButtonExpands* = 1 shl 2

const 
  bmTGtkCListColumnVisible* = 0x0001'i16
  bpTGtkCListColumnVisible* = 0'i16
  bmTGtkCListColumnWidthSet* = 0x0002'i16
  bpTGtkCListColumnWidthSet* = 1'i16
  bmTGtkCListColumnResizeable* = 0x0004'i16
  bpTGtkCListColumnResizeable* = 2'i16
  bmTGtkCListColumnAutoResize* = 0x0008'i16
  bpTGtkCListColumnAutoResize* = 3'i16
  bmTGtkCListColumnButtonPassive* = 0x0010'i16
  bpTGtkCListColumnButtonPassive* = 4'i16
  bmTGtkCListRowFgSet* = 0x0001'i16
  bpTGtkCListRowFgSet* = 0'i16
  bmTGtkCListRowBgSet* = 0x0002'i16
  bpTGtkCListRowBgSet* = 1'i16
  bmTGtkCListRowSelectable* = 0x0004'i16
  bpTGtkCListRowSelectable* = 2'i16

proc typeClist*(): GType
proc clist*(obj: Pointer): PCList
proc clistClass*(klass: Pointer): PCListClass
proc isClist*(obj: Pointer): Bool
proc isClistClass*(klass: Pointer): Bool
proc clistGetClass*(obj: Pointer): PCListClass
proc clistFlags*(clist: Pointer): Guint16
proc setFlag*(clist: PCList, flag: Guint16)
proc unsetFlag*(clist: PCList, flag: Guint16)
#proc GTK_CLIST_IN_DRAG_get*(clist: pointer): bool
#proc GTK_CLIST_ROW_HEIGHT_SET_get*(clist: pointer): bool
#proc GTK_CLIST_SHOW_TITLES_get*(clist: pointer): bool
#proc GTK_CLIST_ADD_MODE_get*(clist: pointer): bool
#proc GTK_CLIST_AUTO_SORT_get*(clist: pointer): bool
#proc GTK_CLIST_AUTO_RESIZE_BLOCKED_get*(clist: pointer): bool
#proc GTK_CLIST_REORDERABLE_get*(clist: pointer): bool
#proc GTK_CLIST_USE_DRAG_ICONS_get*(clist: pointer): bool
#proc GTK_CLIST_DRAW_DRAG_LINE_get*(clist: pointer): bool
#proc GTK_CLIST_DRAW_DRAG_RECT_get*(clist: pointer): bool
#proc GTK_CLIST_ROW_get*(glist: PGList): PGtkCListRow
#proc GTK_CELL_TEXT_get*(cell: pointer): PGtkCellText
#proc GTK_CELL_PIXMAP_get*(cell: pointer): PGtkCellPixmap
#proc GTK_CELL_PIXTEXT_get*(cell: pointer): PGtkCellPixText
#proc GTK_CELL_WIDGET_get*(cell: pointer): PGtkCellWidget

proc visible*(a: PCListColumn): Guint
proc setVisible*(a: PCListColumn, `visible`: Guint)
proc widthSet*(a: PCListColumn): Guint
proc setWidthSet*(a: PCListColumn, `width_set`: Guint)
proc resizeable*(a: PCListColumn): Guint
proc setResizeable*(a: PCListColumn, `resizeable`: Guint)
proc autoResize*(a: PCListColumn): Guint
proc setAutoResize*(a: PCListColumn, `auto_resize`: Guint)
proc buttonPassive*(a: PCListColumn): Guint
proc setButtonPassive*(a: PCListColumn, `button_passive`: Guint)
proc fgSet*(a: PCListRow): Guint
proc setFgSet*(a: PCListRow, `fg_set`: Guint)
proc bgSet*(a: PCListRow): Guint
proc setBgSet*(a: PCListRow, `bg_set`: Guint)
proc selectable*(a: PCListRow): Guint
proc setSelectable*(a: PCListRow, `selectable`: Guint)
proc clistGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_clist_get_type".}
proc clistNew*(columns: Gint): PCList{.cdecl, dynlib: lib, 
                                        importc: "gtk_clist_new".}
proc setHadjustment*(clist: PCList, adjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_hadjustment".}
proc setVadjustment*(clist: PCList, adjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_vadjustment".}
proc getHadjustment*(clist: PCList): PAdjustment{.cdecl, dynlib: lib, 
    importc: "gtk_clist_get_hadjustment".}
proc getVadjustment*(clist: PCList): PAdjustment{.cdecl, dynlib: lib, 
    importc: "gtk_clist_get_vadjustment".}
proc setShadowType*(clist: PCList, thetype: TShadowType){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_shadow_type".}
proc setSelectionMode*(clist: PCList, mode: TSelectionMode){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_selection_mode".}
proc setReorderable*(clist: PCList, reorderable: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_reorderable".}
proc setUseDragIcons*(clist: PCList, use_icons: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_use_drag_icons".}
proc setButtonActions*(clist: PCList, button: Guint, 
                               button_actions: Guint8){.cdecl, dynlib: lib, 
    importc: "gtk_clist_set_button_actions".}
proc freeze*(clist: PCList){.cdecl, dynlib: lib, 
                                   importc: "gtk_clist_freeze".}
proc thaw*(clist: PCList){.cdecl, dynlib: lib, importc: "gtk_clist_thaw".}
proc columnTitlesShow*(clist: PCList){.cdecl, dynlib: lib, 
    importc: "gtk_clist_column_titles_show".}
proc columnTitlesHide*(clist: PCList){.cdecl, dynlib: lib, 
    importc: "gtk_clist_column_titles_hide".}
proc columnTitleActive*(clist: PCList, column: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_clist_column_title_active".}
proc columnTitlePassive*(clist: PCList, column: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_clist_column_title_passive".}
proc columnTitlesActive*(clist: PCList){.cdecl, dynlib: lib, 
    importc: "gtk_clist_column_titles_active".}
proc columnTitlesPassive*(clist: PCList){.cdecl, dynlib: lib, 
    importc: "gtk_clist_column_titles_passive".}
proc setColumnTitle*(clist: PCList, column: Gint, title: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_column_title".}
proc getColumnTitle*(clist: PCList, column: Gint): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_clist_get_column_title".}
proc setColumnWidget*(clist: PCList, column: Gint, widget: PWidget){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_column_widget".}
proc getColumnWidget*(clist: PCList, column: Gint): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_clist_get_column_widget".}
proc setColumnJustification*(clist: PCList, column: Gint, 
                                     justification: TJustification){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_column_justification".}
proc setColumnVisibility*(clist: PCList, column: Gint, visible: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_column_visibility".}
proc setColumnResizeable*(clist: PCList, column: Gint, 
                                  resizeable: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_clist_set_column_resizeable".}
proc setColumnAutoResize*(clist: PCList, column: Gint, 
                                   auto_resize: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_clist_set_column_auto_resize".}
proc columnsAutosize*(clist: PCList): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_clist_columns_autosize".}
proc optimalColumnWidth*(clist: PCList, column: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_clist_optimal_column_width".}
proc setColumnWidth*(clist: PCList, column: Gint, width: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_column_width".}
proc setColumnMinWidth*(clist: PCList, column: Gint, min_width: Gint){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_column_min_width".}
proc setColumnMaxWidth*(clist: PCList, column: Gint, max_width: Gint){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_column_max_width".}
proc setRowHeight*(clist: PCList, height: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_clist_set_row_height".}
proc moveto*(clist: PCList, row: Gint, column: Gint, row_align: Gfloat, 
                   col_align: Gfloat){.cdecl, dynlib: lib, 
                                       importc: "gtk_clist_moveto".}
proc rowIsVisible*(clist: PCList, row: Gint): TVisibility{.cdecl, 
    dynlib: lib, importc: "gtk_clist_row_is_visible".}
proc getCellType*(clist: PCList, row: Gint, column: Gint): TCellType{.
    cdecl, dynlib: lib, importc: "gtk_clist_get_cell_type".}
proc setText*(clist: PCList, row: Gint, column: Gint, text: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_text".}
proc getText*(clist: PCList, row: Gint, column: Gint, text: PPgchar): Gint{.
    cdecl, dynlib: lib, importc: "gtk_clist_get_text".}
proc setPixmap*(clist: PCList, row: Gint, column: Gint, 
                       pixmap: gdk2.PPixmap, mask: gdk2.PBitmap){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_pixmap".}
proc getPixmap*(clist: PCList, row: Gint, column: Gint, 
                       pixmap: var gdk2.PPixmap, mask: var gdk2.PBitmap): Gint{.
    cdecl, dynlib: lib, importc: "gtk_clist_get_pixmap".}
proc setPixtext*(clist: PCList, row: Gint, column: Gint, text: Cstring, 
                        spacing: Guint8, pixmap: gdk2.PPixmap, mask: gdk2.PBitmap){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_pixtext".}
proc setForeground*(clist: PCList, row: Gint, color: gdk2.PColor){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_foreground".}
proc setBackground*(clist: PCList, row: Gint, color: gdk2.PColor){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_background".}
proc setCellStyle*(clist: PCList, row: Gint, column: Gint, style: PStyle){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_cell_style".}
proc getCellStyle*(clist: PCList, row: Gint, column: Gint): PStyle{.
    cdecl, dynlib: lib, importc: "gtk_clist_get_cell_style".}
proc setRowStyle*(clist: PCList, row: Gint, style: PStyle){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_row_style".}
proc getRowStyle*(clist: PCList, row: Gint): PStyle{.cdecl, dynlib: lib, 
    importc: "gtk_clist_get_row_style".}
proc setShift*(clist: PCList, row: Gint, column: Gint, vertical: Gint, 
                      horizontal: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_clist_set_shift".}
proc setSelectable*(clist: PCList, row: Gint, selectable: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_clist_set_selectable".}
proc getSelectable*(clist: PCList, row: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_clist_get_selectable".}
proc remove*(clist: PCList, row: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_clist_remove".}
proc setRowData*(clist: PCList, row: Gint, data: Gpointer){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_row_data".}
proc setRowDataFull*(clist: PCList, row: Gint, data: Gpointer, 
                              destroy: TDestroyNotify){.cdecl, dynlib: lib, 
    importc: "gtk_clist_set_row_data_full".}
proc getRowData*(clist: PCList, row: Gint): Gpointer{.cdecl, 
    dynlib: lib, importc: "gtk_clist_get_row_data".}
proc findRowFromData*(clist: PCList, data: Gpointer): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_clist_find_row_from_data".}
proc selectRow*(clist: PCList, row: Gint, column: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_clist_select_row".}
proc unselectRow*(clist: PCList, row: Gint, column: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_clist_unselect_row".}
proc undoSelection*(clist: PCList){.cdecl, dynlib: lib, 
    importc: "gtk_clist_undo_selection".}
proc clear*(clist: PCList){.cdecl, dynlib: lib, importc: "gtk_clist_clear".}
proc getSelectionInfo*(clist: PCList, x: Gint, y: Gint, row: Pgint, 
                               column: Pgint): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_clist_get_selection_info".}
proc selectAll*(clist: PCList){.cdecl, dynlib: lib, 
                                       importc: "gtk_clist_select_all".}
proc unselectAll*(clist: PCList){.cdecl, dynlib: lib, 
    importc: "gtk_clist_unselect_all".}
proc swapRows*(clist: PCList, row1: Gint, row2: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_clist_swap_rows".}
proc rowMove*(clist: PCList, source_row: Gint, dest_row: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_clist_row_move".}
proc setCompareFunc*(clist: PCList, cmp_func: TCListCompareFunc){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_compare_func".}
proc setSortColumn*(clist: PCList, column: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_clist_set_sort_column".}
proc setSortType*(clist: PCList, sort_type: TSortType){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_sort_type".}
proc sort*(clist: PCList){.cdecl, dynlib: lib, importc: "gtk_clist_sort".}
proc setAutoSort*(clist: PCList, auto_sort: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_clist_set_auto_sort".}
proc createCellLayout*(clist: PCList, clist_row: PCListRow, column: Gint): pango.PLayout{.
    cdecl, dynlib: lib, importc: "_gtk_clist_create_cell_layout".}
const 
  DialogModal* = cint(1 shl 0)
  DialogDestroyWithParent* = cint(1 shl 1)
  DialogNoSeparator* = cint(1 shl 2)
  ResponseNone* = - cint(1)
  ResponseReject* = - cint(2)
  ResponseAccept* = - cint(3)
  ResponseDeleteEvent* = - cint(4)
  ResponseOk* = - cint(5)
  ResponseCancel* = cint(-6)
  ResponseClose* = - cint(7)
  ResponseYes* = - cint(8)
  ResponseNo* = - cint(9)
  ResponseApply* = - cint(10)
  ResponseHelp* = - cint(11)

proc typeDialog*(): GType
proc dialog*(obj: Pointer): PDialog
proc dialogClass*(klass: Pointer): PDialogClass
proc isDialog*(obj: Pointer): Bool
proc isDialogClass*(klass: Pointer): Bool
proc dialogGetClass*(obj: Pointer): PDialogClass
proc dialogGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_dialog_get_type".}
proc dialogNew*(): PDialog{.cdecl, dynlib: lib, importc: "gtk_dialog_new".}
proc addActionWidget*(dialog: PDialog, child: PWidget, 
                               response_id: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_dialog_add_action_widget".}
proc addButton*(dialog: PDialog, button_text: Cstring, response_id: Gint): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_dialog_add_button".}
proc setResponseSensitive*(dialog: PDialog, response_id: Gint, 
                                    setting: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_dialog_set_response_sensitive".}
proc setDefaultResponse*(dialog: PDialog, response_id: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_dialog_set_default_response".}
proc setHasSeparator*(dialog: PDialog, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_dialog_set_has_separator".}
proc getHasSeparator*(dialog: PDialog): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_dialog_get_has_separator".}
proc response*(dialog: PDialog, response_id: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_dialog_response".}
proc run*(dialog: PDialog): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_dialog_run".}
proc showAboutDialog*(parent: PWindow, firstPropertyName: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_show_about_dialog", varargs.}
proc typeVbox*(): GType
proc vbox*(obj: Pointer): PVBox
proc vboxClass*(klass: Pointer): PVBoxClass
proc isVbox*(obj: Pointer): Bool
proc isVboxClass*(klass: Pointer): Bool
proc vboxGetClass*(obj: Pointer): PVBoxClass
proc vboxGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_vbox_get_type".}
proc vboxNew*(homogeneous: Gboolean, spacing: Gint): PVBox{.cdecl, dynlib: lib, 
    importc: "gtk_vbox_new".}
proc typeColorSelection*(): GType
proc colorSelection*(obj: Pointer): PColorSelection
proc colorSelectionClass*(klass: Pointer): PColorSelectionClass
proc isColorSelection*(obj: Pointer): Bool
proc isColorSelectionClass*(klass: Pointer): Bool
proc colorSelectionGetClass*(obj: Pointer): PColorSelectionClass
proc colorSelectionGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_color_selection_get_type".}
proc colorSelectionNew*(): PColorSelection{.cdecl, dynlib: lib, 
    importc: "gtk_color_selection_new".}
proc getHasOpacityControl*(colorsel: PColorSelection): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_color_selection_get_has_opacity_control".}
proc setHasOpacityControl*(colorsel: PColorSelection, 
    has_opacity: Gboolean){.cdecl, dynlib: lib, importc: "gtk_color_selection_set_has_opacity_control".}
proc getHasPalette*(colorsel: PColorSelection): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_color_selection_get_has_palette".}
proc setHasPalette*(colorsel: PColorSelection, 
                                      has_palette: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_color_selection_set_has_palette".}
proc setCurrentColor*(colorsel: PColorSelection, 
                                        color: gdk2.PColor){.cdecl, dynlib: lib, 
    importc: "gtk_color_selection_set_current_color".}
proc setCurrentAlpha*(colorsel: PColorSelection, 
                                        alpha: Guint16){.cdecl, dynlib: lib, 
    importc: "gtk_color_selection_set_current_alpha".}
proc getCurrentColor*(colorsel: PColorSelection, 
                                        color: gdk2.PColor){.cdecl, dynlib: lib, 
    importc: "gtk_color_selection_get_current_color".}
proc getCurrentAlpha*(colorsel: PColorSelection): Guint16{.
    cdecl, dynlib: lib, importc: "gtk_color_selection_get_current_alpha".}
proc setPreviousColor*(colorsel: PColorSelection, 
    color: gdk2.PColor){.cdecl, dynlib: lib, 
                       importc: "gtk_color_selection_set_previous_color".}
proc setPreviousAlpha*(colorsel: PColorSelection, 
    alpha: Guint16){.cdecl, dynlib: lib, 
                     importc: "gtk_color_selection_set_previous_alpha".}
proc getPreviousColor*(colorsel: PColorSelection, 
    color: gdk2.PColor){.cdecl, dynlib: lib, 
                       importc: "gtk_color_selection_get_previous_color".}
proc getPreviousAlpha*(colorsel: PColorSelection): Guint16{.
    cdecl, dynlib: lib, importc: "gtk_color_selection_get_previous_alpha".}
proc isAdjusting*(colorsel: PColorSelection): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_color_selection_is_adjusting".}
proc colorSelectionPaletteFromString*(str: Cstring, colors: var gdk2.PColor, 
    n_colors: Pgint): Gboolean{.cdecl, dynlib: lib, importc: "gtk_color_selection_palette_from_string".}
proc colorSelectionPaletteToString*(colors: gdk2.PColor, n_colors: Gint): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_color_selection_palette_to_string".}
proc colorSelectionSetChangePaletteWithScreenHook*(
    func: TColorSelectionChangePaletteWithScreenFunc): TColorSelectionChangePaletteWithScreenFunc{.
    cdecl, dynlib: lib, 
    importc: "gtk_color_selection_set_change_palette_with_screen_hook".}
proc typeColorSelectionDialog*(): GType
proc colorSelectionDialog*(obj: Pointer): PColorSelectionDialog
proc colorSelectionDialogClass*(klass: Pointer): PColorSelectionDialogClass
proc isColorSelectionDialog*(obj: Pointer): Bool
proc isColorSelectionDialogClass*(klass: Pointer): Bool
proc colorSelectionDialogGetClass*(obj: Pointer): PColorSelectionDialogClass
proc colorSelectionDialogGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_color_selection_dialog_get_type".}
proc colorSelectionDialogNew*(title: Cstring): PColorSelectionDialog{.cdecl, 
    dynlib: lib, importc: "gtk_color_selection_dialog_new".}
proc typeHbox*(): GType
proc hbox*(obj: Pointer): PHBox
proc hboxClass*(klass: Pointer): PHBoxClass
proc isHbox*(obj: Pointer): Bool
proc isHboxClass*(klass: Pointer): Bool
proc hboxGetClass*(obj: Pointer): PHBoxClass
proc hboxGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_hbox_get_type".}
proc hboxNew*(homogeneous: Gboolean, spacing: Gint): PHBox{.cdecl, dynlib: lib, 
    importc: "gtk_hbox_new".}
const 
  bmTGtkComboValueInList* = 0x0001'i16
  bpTGtkComboValueInList* = 0'i16
  bmTGtkComboOkIfEmpty* = 0x0002'i16
  bpTGtkComboOkIfEmpty* = 1'i16
  bmTGtkComboCaseSensitive* = 0x0004'i16
  bpTGtkComboCaseSensitive* = 2'i16
  bmTGtkComboUseArrows* = 0x0008'i16
  bpTGtkComboUseArrows* = 3'i16
  bmTGtkComboUseArrowsAlways* = 0x0010'i16
  bpTGtkComboUseArrowsAlways* = 4'i16

proc typeCombo*(): GType
proc combo*(obj: Pointer): PCombo
proc comboClass*(klass: Pointer): PComboClass
proc isCombo*(obj: Pointer): Bool
proc isComboClass*(klass: Pointer): Bool
proc comboGetClass*(obj: Pointer): PComboClass
proc valueInList*(a: PCombo): Guint
proc setValueInList*(a: PCombo, `value_in_list`: Guint)
proc okIfEmpty*(a: PCombo): Guint
proc setOkIfEmpty*(a: PCombo, `ok_if_empty`: Guint)
proc caseSensitive*(a: PCombo): Guint
proc setCaseSensitive*(a: PCombo, `case_sensitive`: Guint)
proc useArrows*(a: PCombo): Guint
proc setUseArrows*(a: PCombo, `use_arrows`: Guint)
proc useArrowsAlways*(a: PCombo): Guint
proc setUseArrowsAlways*(a: PCombo, `use_arrows_always`: Guint)
proc comboGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_combo_get_type".}
proc comboNew*(): PCombo{.cdecl, dynlib: lib, importc: "gtk_combo_new".}
proc setValueInList*(combo: PCombo, val: Gboolean, 
                              ok_if_empty: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_combo_set_value_in_list".}
proc setUseArrows*(combo: PCombo, val: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_combo_set_use_arrows".}
proc setUseArrowsAlways*(combo: PCombo, val: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_combo_set_use_arrows_always".}
proc setCaseSensitive*(combo: PCombo, val: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_combo_set_case_sensitive".}
proc setItemString*(combo: PCombo, item: PItem, item_value: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_combo_set_item_string".}
proc setPopdownStrings*(combo: PCombo, strings: PGList){.cdecl, 
    dynlib: lib, importc: "gtk_combo_set_popdown_strings".}
proc disableActivate*(combo: PCombo){.cdecl, dynlib: lib, 
    importc: "gtk_combo_disable_activate".}
const 
  bmTGtkCTreeLineStyle* = 0x0003'i16
  bpTGtkCTreeLineStyle* = 0'i16
  bmTGtkCTreeExpanderStyle* = 0x000C'i16
  bpTGtkCTreeExpanderStyle* = 2'i16
  bmTGtkCTreeShowStub* = 0x0010'i16
  bpTGtkCTreeShowStub* = 4'i16
  bmTGtkCTreeRowIsLeaf* = 0x0001'i16
  bpTGtkCTreeRowIsLeaf* = 0'i16
  bmTGtkCTreeRowExpanded* = 0x0002'i16
  bpTGtkCTreeRowExpanded* = 1'i16

proc typeCtree*(): GType
proc ctree*(obj: Pointer): PCTree
proc ctreeClass*(klass: Pointer): PCTreeClass
proc isCtree*(obj: Pointer): Bool
proc isCtreeClass*(klass: Pointer): Bool
proc ctreeGetClass*(obj: Pointer): PCTreeClass
proc ctreeRow*(node: TAddress): PCTreeRow
proc ctreeNode*(node: TAddress): PCTreeNode
proc ctreeNodeNext*(nnode: TAddress): PCTreeNode
proc ctreeNodePrev*(pnode: TAddress): PCTreeNode
proc ctreeFunc*(fun: TAddress): TCTreeFunc
proc typeCtreeNode*(): GType
proc lineStyle*(a: PCTree): Guint
proc setLineStyle*(a: PCTree, `line_style`: Guint)
proc expanderStyle*(a: PCTree): Guint
proc setExpanderStyle*(a: PCTree, `expander_style`: Guint)
proc showStub*(a: PCTree): Guint
proc setShowStub*(a: PCTree, `show_stub`: Guint)
proc isLeaf*(a: PCTreeRow): Guint
proc setIsLeaf*(a: PCTreeRow, `is_leaf`: Guint)
proc expanded*(a: PCTreeRow): Guint
proc setExpanded*(a: PCTreeRow, `expanded`: Guint)
proc ctreeGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_ctree_get_type".}
proc ctreeNew*(columns: Gint, tree_column: Gint): PCTree{.cdecl, dynlib: lib, 
    importc: "gtk_ctree_new".}
proc insertNode*(ctree: PCTree, parent: PCTreeNode, sibling: PCTreeNode, 
                        text: Openarray[Cstring], spacing: Guint8, 
                        pixmap_closed: gdk2.PPixmap, mask_closed: gdk2.PBitmap, 
                        pixmap_opened: gdk2.PPixmap, mask_opened: gdk2.PBitmap, 
                        is_leaf: Gboolean, expanded: Gboolean): PCTreeNode{.
    cdecl, dynlib: lib, importc: "gtk_ctree_insert_node".}
proc removeNode*(ctree: PCTree, node: PCTreeNode){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_remove_node".}
proc insertGnode*(ctree: PCTree, parent: PCTreeNode, sibling: PCTreeNode, 
                         gnode: PGNode, fun: TCTreeGNodeFunc, data: Gpointer): PCTreeNode{.
    cdecl, dynlib: lib, importc: "gtk_ctree_insert_gnode".}
proc exportToGnode*(ctree: PCTree, parent: PGNode, sibling: PGNode, 
                            node: PCTreeNode, fun: TCTreeGNodeFunc, 
                            data: Gpointer): PGNode{.cdecl, dynlib: lib, 
    importc: "gtk_ctree_export_to_gnode".}
proc postRecursive*(ctree: PCTree, node: PCTreeNode, fun: TCTreeFunc, 
                           data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_post_recursive".}
proc postRecursiveToDepth*(ctree: PCTree, node: PCTreeNode, 
                                    depth: Gint, fun: TCTreeFunc, 
                                    data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_post_recursive_to_depth".}
proc preRecursive*(ctree: PCTree, node: PCTreeNode, fun: TCTreeFunc, 
                          data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_pre_recursive".}
proc preRecursiveToDepth*(ctree: PCTree, node: PCTreeNode, 
                                   depth: Gint, fun: TCTreeFunc, 
                                   data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_pre_recursive_to_depth".}
proc isViewable*(ctree: PCTree, node: PCTreeNode): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_ctree_is_viewable".}
proc last*(ctree: PCTree, node: PCTreeNode): PCTreeNode{.cdecl, 
    dynlib: lib, importc: "gtk_ctree_last".}
proc findNodePtr*(ctree: PCTree, ctree_row: PCTreeRow): PCTreeNode{.
    cdecl, dynlib: lib, importc: "gtk_ctree_find_node_ptr".}
proc nodeNth*(ctree: PCTree, row: Guint): PCTreeNode{.cdecl, dynlib: lib, 
    importc: "gtk_ctree_node_nth".}
proc find*(ctree: PCTree, node: PCTreeNode, child: PCTreeNode): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_ctree_find".}
proc isAncestor*(ctree: PCTree, node: PCTreeNode, child: PCTreeNode): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_ctree_is_ancestor".}
proc findByRowData*(ctree: PCTree, node: PCTreeNode, data: Gpointer): PCTreeNode{.
    cdecl, dynlib: lib, importc: "gtk_ctree_find_by_row_data".}
proc findAllByRowData*(ctree: PCTree, node: PCTreeNode, 
                                 data: Gpointer): PGList{.cdecl, dynlib: lib, 
    importc: "gtk_ctree_find_all_by_row_data".}
proc findByRowDataCustom*(ctree: PCTree, node: PCTreeNode, 
                                    data: Gpointer, fun: TGCompareFunc): PCTreeNode{.
    cdecl, dynlib: lib, importc: "gtk_ctree_find_by_row_data_custom".}
proc findAllByRowDataCustom*(ctree: PCTree, node: PCTreeNode, 
                                        data: Gpointer, fun: TGCompareFunc): PGList{.
    cdecl, dynlib: lib, importc: "gtk_ctree_find_all_by_row_data_custom".}
proc isHotSpot*(ctree: PCTree, x: Gint, y: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_ctree_is_hot_spot".}
proc move*(ctree: PCTree, node: PCTreeNode, new_parent: PCTreeNode, 
                 new_sibling: PCTreeNode){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_move".}
proc expand*(ctree: PCTree, node: PCTreeNode){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_expand".}
proc expandRecursive*(ctree: PCTree, node: PCTreeNode){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_expand_recursive".}
proc expandToDepth*(ctree: PCTree, node: PCTreeNode, depth: Gint){.
    cdecl, dynlib: lib, importc: "gtk_ctree_expand_to_depth".}
proc collapse*(ctree: PCTree, node: PCTreeNode){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_collapse".}
proc collapseRecursive*(ctree: PCTree, node: PCTreeNode){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_collapse_recursive".}
proc collapseToDepth*(ctree: PCTree, node: PCTreeNode, depth: Gint){.
    cdecl, dynlib: lib, importc: "gtk_ctree_collapse_to_depth".}
proc toggleExpansion*(ctree: PCTree, node: PCTreeNode){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_toggle_expansion".}
proc toggleExpansionRecursive*(ctree: PCTree, node: PCTreeNode){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_toggle_expansion_recursive".}
proc select*(ctree: PCTree, node: PCTreeNode){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_select".}
proc selectRecursive*(ctree: PCTree, node: PCTreeNode){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_select_recursive".}
proc unselect*(ctree: PCTree, node: PCTreeNode){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_unselect".}
proc unselectRecursive*(ctree: PCTree, node: PCTreeNode){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_unselect_recursive".}
proc realSelectRecursive*(ctree: PCTree, node: PCTreeNode, state: Gint){.
    cdecl, dynlib: lib, importc: "gtk_ctree_real_select_recursive".}
proc nodeSetText*(ctree: PCTree, node: PCTreeNode, column: Gint, 
                          text: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_node_set_text".}
proc nodeSetPixmap*(ctree: PCTree, node: PCTreeNode, column: Gint, 
                            pixmap: gdk2.PPixmap, mask: gdk2.PBitmap){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_node_set_pixmap".}
proc nodeSetPixtext*(ctree: PCTree, node: PCTreeNode, column: Gint, 
                             text: Cstring, spacing: Guint8, pixmap: gdk2.PPixmap, 
                             mask: gdk2.PBitmap){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_node_set_pixtext".}
proc setNodeInfo*(ctree: PCTree, node: PCTreeNode, text: Cstring, 
                          spacing: Guint8, pixmap_closed: gdk2.PPixmap, 
                          mask_closed: gdk2.PBitmap, pixmap_opened: gdk2.PPixmap, 
                          mask_opened: gdk2.PBitmap, is_leaf: Gboolean, 
                          expanded: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_set_node_info".}
proc nodeSetShift*(ctree: PCTree, node: PCTreeNode, column: Gint, 
                           vertical: Gint, horizontal: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_node_set_shift".}
proc nodeSetSelectable*(ctree: PCTree, node: PCTreeNode, 
                                selectable: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_node_set_selectable".}
proc nodeGetSelectable*(ctree: PCTree, node: PCTreeNode): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_ctree_node_get_selectable".}
proc nodeGetCellType*(ctree: PCTree, node: PCTreeNode, column: Gint): TCellType{.
    cdecl, dynlib: lib, importc: "gtk_ctree_node_get_cell_type".}
proc nodeGetText*(ctree: PCTree, node: PCTreeNode, column: Gint, 
                          text: PPgchar): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_ctree_node_get_text".}
proc nodeSetRowStyle*(ctree: PCTree, node: PCTreeNode, style: PStyle){.
    cdecl, dynlib: lib, importc: "gtk_ctree_node_set_row_style".}
proc nodeGetRowStyle*(ctree: PCTree, node: PCTreeNode): PStyle{.cdecl, 
    dynlib: lib, importc: "gtk_ctree_node_get_row_style".}
proc nodeSetCellStyle*(ctree: PCTree, node: PCTreeNode, column: Gint, 
                                style: PStyle){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_node_set_cell_style".}
proc nodeGetCellStyle*(ctree: PCTree, node: PCTreeNode, column: Gint): PStyle{.
    cdecl, dynlib: lib, importc: "gtk_ctree_node_get_cell_style".}
proc nodeSetForeground*(ctree: PCTree, node: PCTreeNode, 
                                color: gdk2.PColor){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_node_set_foreground".}
proc nodeSetBackground*(ctree: PCTree, node: PCTreeNode, 
                                color: gdk2.PColor){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_node_set_background".}
proc nodeSetRowData*(ctree: PCTree, node: PCTreeNode, data: Gpointer){.
    cdecl, dynlib: lib, importc: "gtk_ctree_node_set_row_data".}
proc nodeSetRowDataFull*(ctree: PCTree, node: PCTreeNode, 
                                   data: Gpointer, destroy: TDestroyNotify){.
    cdecl, dynlib: lib, importc: "gtk_ctree_node_set_row_data_full".}
proc nodeGetRowData*(ctree: PCTree, node: PCTreeNode): Gpointer{.
    cdecl, dynlib: lib, importc: "gtk_ctree_node_get_row_data".}
proc nodeMoveto*(ctree: PCTree, node: PCTreeNode, column: Gint, 
                        row_align: Gfloat, col_align: Gfloat){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_node_moveto".}
proc nodeIsVisible*(ctree: PCTree, node: PCTreeNode): TVisibility{.
    cdecl, dynlib: lib, importc: "gtk_ctree_node_is_visible".}
proc setIndent*(ctree: PCTree, indent: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_set_indent".}
proc setSpacing*(ctree: PCTree, spacing: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_set_spacing".}
proc setShowStub*(ctree: PCTree, show_stub: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_set_show_stub".}
proc setLineStyle*(ctree: PCTree, line_style: TCTreeLineStyle){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_set_line_style".}
proc setExpanderStyle*(ctree: PCTree, 
                               expander_style: TCTreeExpanderStyle){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_set_expander_style".}
proc setDragCompareFunc*(ctree: PCTree, cmp_func: TCTreeCompareDragFunc){.
    cdecl, dynlib: lib, importc: "gtk_ctree_set_drag_compare_func".}
proc sortNode*(ctree: PCTree, node: PCTreeNode){.cdecl, dynlib: lib, 
    importc: "gtk_ctree_sort_node".}
proc sortRecursive*(ctree: PCTree, node: PCTreeNode){.cdecl, 
    dynlib: lib, importc: "gtk_ctree_sort_recursive".}
proc ctreeSetReorderable*(t: Pointer, r: Bool)
proc ctreeNodeGetType*(): GType{.cdecl, dynlib: lib, 
                                    importc: "gtk_ctree_node_get_type".}
proc typeDrawingArea*(): GType
proc drawingArea*(obj: Pointer): PDrawingArea
proc drawingAreaClass*(klass: Pointer): PDrawingAreaClass
proc isDrawingArea*(obj: Pointer): Bool
proc isDrawingAreaClass*(klass: Pointer): Bool
proc drawingAreaGetClass*(obj: Pointer): PDrawingAreaClass
proc drawingAreaGetType*(): TType{.cdecl, dynlib: lib, 
                                      importc: "gtk_drawing_area_get_type".}
proc drawingAreaNew*(): PDrawingArea{.cdecl, dynlib: lib, 
                                        importc: "gtk_drawing_area_new".}
proc typeCurve*(): GType
proc curve*(obj: Pointer): PCurve
proc curveClass*(klass: Pointer): PCurveClass
proc isCurve*(obj: Pointer): Bool
proc isCurveClass*(klass: Pointer): Bool
proc curveGetClass*(obj: Pointer): PCurveClass
proc curveGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_curve_get_type".}
proc curveNew*(): PCurve{.cdecl, dynlib: lib, importc: "gtk_curve_new".}
proc reset*(curve: PCurve){.cdecl, dynlib: lib, importc: "gtk_curve_reset".}
proc setGamma*(curve: PCurve, gamma: Gfloat){.cdecl, dynlib: lib, 
    importc: "gtk_curve_set_gamma".}
proc setRange*(curve: PCurve, min_x: Gfloat, max_x: Gfloat, 
                      min_y: Gfloat, max_y: Gfloat){.cdecl, dynlib: lib, 
    importc: "gtk_curve_set_range".}
proc setCurveType*(curve: PCurve, thetype: TCurveType){.cdecl, 
    dynlib: lib, importc: "gtk_curve_set_curve_type".}
const 
  DestDefaultMotion* = 1 shl 0
  DestDefaultHighlight* = 1 shl 1
  DestDefaultDrop* = 1 shl 2
  DestDefaultAll* = 0x00000007
  TargetSameApp* = 1 shl 0
  TargetSameWidget* = 1 shl 1

proc dragGetData*(widget: PWidget, context: gdk2.PDragContext, target: gdk2.TAtom, 
                    time: Guint32){.cdecl, dynlib: lib, 
                                    importc: "gtk_drag_get_data".}
proc dragFinish*(context: gdk2.PDragContext, success: Gboolean, del: Gboolean, 
                  time: Guint32){.cdecl, dynlib: lib, importc: "gtk_drag_finish".}
proc dragGetSourceWidget*(context: gdk2.PDragContext): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_drag_get_source_widget".}
proc dragHighlight*(widget: PWidget){.cdecl, dynlib: lib, 
                                       importc: "gtk_drag_highlight".}
proc dragUnhighlight*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_drag_unhighlight".}
proc dragDestSet*(widget: PWidget, flags: TDestDefaults, 
                    targets: PTargetEntry, n_targets: Gint, 
                    actions: gdk2.TDragAction){.cdecl, dynlib: lib, 
    importc: "gtk_drag_dest_set".}
proc dragDestSetProxy*(widget: PWidget, proxy_window: gdk2.PWindow, 
                          protocol: gdk2.TDragProtocol, use_coordinates: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_drag_dest_set_proxy".}
proc dragDestUnset*(widget: PWidget){.cdecl, dynlib: lib, 
                                        importc: "gtk_drag_dest_unset".}
proc dragDestFindTarget*(widget: PWidget, context: gdk2.PDragContext, 
                            target_list: PTargetList): gdk2.TAtom{.cdecl, 
    dynlib: lib, importc: "gtk_drag_dest_find_target".}
proc dragDestGetTargetList*(widget: PWidget): PTargetList{.cdecl, 
    dynlib: lib, importc: "gtk_drag_dest_get_target_list".}
proc dragDestSetTargetList*(widget: PWidget, target_list: PTargetList){.
    cdecl, dynlib: lib, importc: "gtk_drag_dest_set_target_list".}
proc dragSourceSet*(widget: PWidget, start_button_mask: gdk2.TModifierType, 
                      targets: PTargetEntry, n_targets: Gint, 
                      actions: gdk2.TDragAction){.cdecl, dynlib: lib, 
    importc: "gtk_drag_source_set".}
proc dragSourceUnset*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_drag_source_unset".}
proc dragSourceSetIcon*(widget: PWidget, colormap: gdk2.PColormap, 
                           pixmap: gdk2.PPixmap, mask: gdk2.PBitmap){.cdecl, 
    dynlib: lib, importc: "gtk_drag_source_set_icon".}
proc dragSourceSetIconPixbuf*(widget: PWidget, pixbuf: gdk2pixbuf.PPixbuf){.cdecl, 
    dynlib: lib, importc: "gtk_drag_source_set_icon_pixbuf".}
proc dragSourceSetIconStock*(widget: PWidget, stock_id: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_drag_source_set_icon_stock".}
proc dragBegin*(widget: PWidget, targets: PTargetList, actions: gdk2.TDragAction, 
                 button: Gint, event: gdk2.PEvent): gdk2.PDragContext{.cdecl, 
    dynlib: lib, importc: "gtk_drag_begin".}
proc dragSetIconWidget*(context: gdk2.PDragContext, widget: PWidget, 
                           hot_x: Gint, hot_y: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_drag_set_icon_widget".}
proc dragSetIconPixmap*(context: gdk2.PDragContext, colormap: gdk2.PColormap, 
                           pixmap: gdk2.PPixmap, mask: gdk2.PBitmap, hot_x: Gint, 
                           hot_y: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_drag_set_icon_pixmap".}
proc dragSetIconPixbuf*(context: gdk2.PDragContext, pixbuf: gdk2pixbuf.PPixbuf, 
                           hot_x: Gint, hot_y: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_drag_set_icon_pixbuf".}
proc dragSetIconStock*(context: gdk2.PDragContext, stock_id: Cstring, 
                          hot_x: Gint, hot_y: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_drag_set_icon_stock".}
proc dragSetIconDefault*(context: gdk2.PDragContext){.cdecl, dynlib: lib, 
    importc: "gtk_drag_set_icon_default".}
proc dragCheckThreshold*(widget: PWidget, start_x: Gint, start_y: Gint, 
                           current_x: Gint, current_y: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_drag_check_threshold".}
proc dragSourceHandleEvent*(widget: PWidget, event: gdk2.PEvent){.cdecl, 
    dynlib: lib, importc: "_gtk_drag_source_handle_event".}
proc dragDestHandleEvent*(toplevel: PWidget, event: gdk2.PEvent){.cdecl, 
    dynlib: lib, importc: "_gtk_drag_dest_handle_event".}
proc typeEditable*(): GType
proc editable*(obj: Pointer): PEditable
proc editableClass*(vtable: Pointer): PEditableClass
proc isEditable*(obj: Pointer): Bool
proc isEditableClass*(vtable: Pointer): Bool
proc editableGetClass*(inst: Pointer): PEditableClass
proc editableGetType*(): TType{.cdecl, dynlib: lib, 
                                  importc: "gtk_editable_get_type".}
proc selectRegion*(editable: PEditable, start: Gint, theEnd: Gint){.
    cdecl, dynlib: lib, importc: "gtk_editable_select_region".}
proc getSelectionBounds*(editable: PEditable, start: Pgint, 
                                    theEnd: Pgint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_editable_get_selection_bounds".}
proc insertText*(editable: PEditable, new_text: Cstring, 
                           new_text_length: Gint, position: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_editable_insert_text".}
proc deleteText*(editable: PEditable, start_pos: Gint, end_pos: Gint){.
    cdecl, dynlib: lib, importc: "gtk_editable_delete_text".}
proc getChars*(editable: PEditable, start_pos: Gint, end_pos: Gint): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_editable_get_chars".}
proc cutClipboard*(editable: PEditable){.cdecl, dynlib: lib, 
    importc: "gtk_editable_cut_clipboard".}
proc copyClipboard*(editable: PEditable){.cdecl, dynlib: lib, 
    importc: "gtk_editable_copy_clipboard".}
proc pasteClipboard*(editable: PEditable){.cdecl, dynlib: lib, 
    importc: "gtk_editable_paste_clipboard".}
proc deleteSelection*(editable: PEditable){.cdecl, dynlib: lib, 
    importc: "gtk_editable_delete_selection".}
proc setPosition*(editable: PEditable, position: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_editable_set_position".}
proc getPosition*(editable: PEditable): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_editable_get_position".}
proc setEditable*(editable: PEditable, is_editable: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_editable_set_editable".}
proc getEditable*(editable: PEditable): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_editable_get_editable".}
proc typeImContext*(): GType
proc imContext*(obj: Pointer): PIMContext
proc imContextClass*(klass: Pointer): PIMContextClass
proc isImContext*(obj: Pointer): Bool
proc isImContextClass*(klass: Pointer): Bool
proc imContextGetClass*(obj: Pointer): PIMContextClass
proc imContextGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_im_context_get_type".}
proc setClientWindow*(context: PIMContext, window: gdk2.PWindow){.
    cdecl, dynlib: lib, importc: "gtk_im_context_set_client_window".}
proc filterKeypress*(context: PIMContext, event: gdk2.PEventKey): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_im_context_filter_keypress".}
proc focusIn*(context: PIMContext){.cdecl, dynlib: lib, 
    importc: "gtk_im_context_focus_in".}
proc focusOut*(context: PIMContext){.cdecl, dynlib: lib, 
    importc: "gtk_im_context_focus_out".}
proc reset*(context: PIMContext){.cdecl, dynlib: lib, 
    importc: "gtk_im_context_reset".}
proc setCursorLocation*(context: PIMContext, area: gdk2.PRectangle){.
    cdecl, dynlib: lib, importc: "gtk_im_context_set_cursor_location".}
proc setUsePreedit*(context: PIMContext, use_preedit: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_im_context_set_use_preedit".}
proc setSurrounding*(context: PIMContext, text: Cstring, len: Gint, 
                                 cursor_index: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_im_context_set_surrounding".}
proc getSurrounding*(context: PIMContext, text: PPgchar, 
                                 cursor_index: Pgint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_im_context_get_surrounding".}
proc deleteSurrounding*(context: PIMContext, offset: Gint, 
                                    n_chars: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_im_context_delete_surrounding".}
const 
  bmTGtkMenuShellActive* = 0x0001'i16
  bpTGtkMenuShellActive* = 0'i16
  bmTGtkMenuShellHaveGrab* = 0x0002'i16
  bpTGtkMenuShellHaveGrab* = 1'i16
  bmTGtkMenuShellHaveXgrab* = 0x0004'i16
  bpTGtkMenuShellHaveXgrab* = 2'i16
  bmTGtkMenuShellIgnoreLeave* = 0x0008'i16
  bpTGtkMenuShellIgnoreLeave* = 3'i16
  bmTGtkMenuShellMenuFlag* = 0x0010'i16
  bpTGtkMenuShellMenuFlag* = 4'i16
  bmTGtkMenuShellIgnoreEnter* = 0x0020'i16
  bpTGtkMenuShellIgnoreEnter* = 5'i16
  bmTGtkMenuShellClassSubmenuPlacement* = 0x0001'i16
  bpTGtkMenuShellClassSubmenuPlacement* = 0'i16

proc typeMenuShell*(): GType
proc menuShell*(obj: Pointer): PMenuShell
proc menuShellClass*(klass: Pointer): PMenuShellClass
proc isMenuShell*(obj: Pointer): Bool
proc isMenuShellClass*(klass: Pointer): Bool
proc menuShellGetClass*(obj: Pointer): PMenuShellClass
proc active*(a: PMenuShell): Guint
proc setActive*(a: PMenuShell, `active`: Guint)
proc haveGrab*(a: PMenuShell): Guint
proc setHaveGrab*(a: PMenuShell, `have_grab`: Guint)
proc haveXgrab*(a: PMenuShell): Guint
proc setHaveXgrab*(a: PMenuShell, `have_xgrab`: Guint)
proc ignoreLeave*(a: PMenuShell): Guint
proc setIgnoreLeave*(a: PMenuShell, `ignore_leave`: Guint)
proc menuFlag*(a: PMenuShell): Guint
proc setMenuFlag*(a: PMenuShell, `menu_flag`: Guint)
proc ignoreEnter*(a: PMenuShell): Guint
proc setIgnoreEnter*(a: PMenuShell, `ignore_enter`: Guint)
proc submenuPlacement*(a: PMenuShellClass): Guint
proc setSubmenuPlacement*(a: PMenuShellClass, `submenu_placement`: Guint)
proc menuShellGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_menu_shell_get_type".}
proc append*(menu_shell: PMenuShell, child: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_menu_shell_append".}
proc prepend*(menu_shell: PMenuShell, child: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_menu_shell_prepend".}
proc insert*(menu_shell: PMenuShell, child: PWidget, position: Gint){.
    cdecl, dynlib: lib, importc: "gtk_menu_shell_insert".}
proc deactivate*(menu_shell: PMenuShell){.cdecl, dynlib: lib, 
    importc: "gtk_menu_shell_deactivate".}
proc selectItem*(menu_shell: PMenuShell, menu_item: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_menu_shell_select_item".}
proc deselect*(menu_shell: PMenuShell){.cdecl, dynlib: lib, 
    importc: "gtk_menu_shell_deselect".}
proc activateItem*(menu_shell: PMenuShell, menu_item: PWidget, 
                               force_deactivate: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_menu_shell_activate_item".}
proc selectFirst*(menu_shell: PMenuShell){.cdecl, dynlib: lib, 
    importc: "_gtk_menu_shell_select_first".}
proc activate*(menu_shell: PMenuShell){.cdecl, dynlib: lib, 
    importc: "_gtk_menu_shell_activate".}
const 
  bmTGtkMenuNeedsDestructionRefCount* = 0x0001'i16
  bpTGtkMenuNeedsDestructionRefCount* = 0'i16
  bmTGtkMenuTornOff* = 0x0002'i16
  bpTGtkMenuTornOff* = 1'i16
  bmTGtkMenuTearoffActive* = 0x0004'i16
  bpTGtkMenuTearoffActive* = 2'i16
  bmTGtkMenuScrollFast* = 0x0008'i16
  bpTGtkMenuScrollFast* = 3'i16
  bmTGtkMenuUpperArrowVisible* = 0x0010'i16
  bpTGtkMenuUpperArrowVisible* = 4'i16
  bmTGtkMenuLowerArrowVisible* = 0x0020'i16
  bpTGtkMenuLowerArrowVisible* = 5'i16
  bmTGtkMenuUpperArrowPrelight* = 0x0040'i16
  bpTGtkMenuUpperArrowPrelight* = 6'i16
  bmTGtkMenuLowerArrowPrelight* = 0x0080'i16
  bpTGtkMenuLowerArrowPrelight* = 7'i16

proc typeMenu*(): GType
proc menu*(obj: Pointer): PMenu
proc menuClass*(klass: Pointer): PMenuClass
proc isMenu*(obj: Pointer): Bool
proc isMenuClass*(klass: Pointer): Bool
proc menuGetClass*(obj: Pointer): PMenuClass
proc needsDestructionRefCount*(a: PMenu): Guint
proc setNeedsDestructionRefCount*(a: PMenu, 
                                      `needs_destruction_ref_count`: Guint)
proc tornOff*(a: PMenu): Guint
proc setTornOff*(a: PMenu, `torn_off`: Guint)
proc tearoffActive*(a: PMenu): Guint
proc setTearoffActive*(a: PMenu, `tearoff_active`: Guint)
proc scrollFast*(a: PMenu): Guint
proc setScrollFast*(a: PMenu, `scroll_fast`: Guint)
proc upperArrowVisible*(a: PMenu): Guint
proc setUpperArrowVisible*(a: PMenu, `upper_arrow_visible`: Guint)
proc lowerArrowVisible*(a: PMenu): Guint
proc setLowerArrowVisible*(a: PMenu, `lower_arrow_visible`: Guint)
proc upperArrowPrelight*(a: PMenu): Guint
proc setUpperArrowPrelight*(a: PMenu, `upper_arrow_prelight`: Guint)
proc lowerArrowPrelight*(a: PMenu): Guint
proc setLowerArrowPrelight*(a: PMenu, `lower_arrow_prelight`: Guint)
proc menuGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_menu_get_type".}
proc menuNew*(): PMenu{.cdecl, dynlib: lib, importc: "gtk_menu_new".}
proc popup*(menu: PMenu, parent_menu_shell: PWidget, 
                 parent_menu_item: PWidget, fun: TMenuPositionFunc, 
                 data: Gpointer, button: Guint, activate_time: Guint32){.cdecl, 
    dynlib: lib, importc: "gtk_menu_popup".}
proc reposition*(menu: PMenu){.cdecl, dynlib: lib, 
                                    importc: "gtk_menu_reposition".}
proc popdown*(menu: PMenu){.cdecl, dynlib: lib, importc: "gtk_menu_popdown".}
proc getActive*(menu: PMenu): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_menu_get_active".}
proc setActive*(menu: PMenu, index: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_menu_set_active".}
proc setAccelGroup*(menu: PMenu, accel_group: PAccelGroup){.cdecl, 
    dynlib: lib, importc: "gtk_menu_set_accel_group".}
proc getAccelGroup*(menu: PMenu): PAccelGroup{.cdecl, dynlib: lib, 
    importc: "gtk_menu_get_accel_group".}
proc setAccelPath*(menu: PMenu, accel_path: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_menu_set_accel_path".}
proc attachToWidget*(menu: PMenu, attach_widget: PWidget, 
                            detacher: TMenuDetachFunc){.cdecl, dynlib: lib, 
    importc: "gtk_menu_attach_to_widget".}
proc detach*(menu: PMenu){.cdecl, dynlib: lib, importc: "gtk_menu_detach".}
proc getAttachWidget*(menu: PMenu): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_menu_get_attach_widget".}
proc setTearoffState*(menu: PMenu, torn_off: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_menu_set_tearoff_state".}
proc getTearoffState*(menu: PMenu): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_menu_get_tearoff_state".}
proc setTitle*(menu: PMenu, title: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_menu_set_title".}
proc getTitle*(menu: PMenu): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_menu_get_title".}
proc reorderChild*(menu: PMenu, child: PWidget, position: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_menu_reorder_child".}
proc setScreen*(menu: PMenu, screen: gdk2.PScreen){.cdecl, dynlib: lib, 
    importc: "gtk_menu_set_screen".}
const 
  bmTGtkEntryEditable* = 0x0001'i16
  bpTGtkEntryEditable* = 0'i16
  bmTGtkEntryVisible* = 0x0002'i16
  bpTGtkEntryVisible* = 1'i16
  bmTGtkEntryOverwriteMode* = 0x0004'i16
  bpTGtkEntryOverwriteMode* = 2'i16
  bmTGtkEntryInDrag* = 0x0008'i16
  bpTGtkEntryInDrag* = 3'i16
  bmTGtkEntryCacheIncludesPreedit* = 0x0001'i16
  bpTGtkEntryCacheIncludesPreedit* = 0'i16
  bmTGtkEntryNeedImReset* = 0x0002'i16
  bpTGtkEntryNeedImReset* = 1'i16
  bmTGtkEntryHasFrame* = 0x0004'i16
  bpTGtkEntryHasFrame* = 2'i16
  bmTGtkEntryActivatesDefault* = 0x0008'i16
  bpTGtkEntryActivatesDefault* = 3'i16
  bmTGtkEntryCursorVisible* = 0x0010'i16
  bpTGtkEntryCursorVisible* = 4'i16
  bmTGtkEntryInClick* = 0x0020'i16
  bpTGtkEntryInClick* = 5'i16
  bmTGtkEntryIsCellRenderer* = 0x0040'i16
  bpTGtkEntryIsCellRenderer* = 6'i16
  bmTGtkEntryEditingCanceled* = 0x0080'i16
  bpTGtkEntryEditingCanceled* = 7'i16
  bmTGtkEntryMouseCursorObscured* = 0x0100'i16
  bpTGtkEntryMouseCursorObscured* = 8'i16

proc typeEntry*(): GType
proc entry*(obj: Pointer): PEntry
proc entryClass*(klass: Pointer): PEntryClass
proc isEntry*(obj: Pointer): Bool
proc isEntryClass*(klass: Pointer): Bool
proc entryGetClass*(obj: Pointer): PEntryClass
proc editable*(a: PEntry): Guint
proc setEditable*(a: PEntry, `editable`: Guint)
proc visible*(a: PEntry): Guint
proc setVisible*(a: PEntry, `visible`: Guint)
proc overwriteMode*(a: PEntry): Guint
proc setOverwriteMode*(a: PEntry, `overwrite_mode`: Guint)
proc inDrag*(a: PEntry): Guint
proc setInDrag*(a: PEntry, `in_drag`: Guint)
proc cacheIncludesPreedit*(a: PEntry): Guint
proc setCacheIncludesPreedit*(a: PEntry, `cache_includes_preedit`: Guint)
proc needImReset*(a: PEntry): Guint
proc setNeedImReset*(a: PEntry, `need_im_reset`: Guint)
proc hasFrame*(a: PEntry): Guint
proc setHasFrame*(a: PEntry, `has_frame`: Guint)
proc activatesDefault*(a: PEntry): Guint
proc setActivatesDefault*(a: PEntry, `activates_default`: Guint)
proc cursorVisible*(a: PEntry): Guint
proc setCursorVisible*(a: PEntry, `cursor_visible`: Guint)
proc inClick*(a: PEntry): Guint
proc setInClick*(a: PEntry, `in_click`: Guint)
proc isCellRenderer*(a: PEntry): Guint
proc setIsCellRenderer*(a: PEntry, `is_cell_renderer`: Guint)
proc editingCanceled*(a: PEntry): Guint
proc setEditingCanceled*(a: PEntry, `editing_canceled`: Guint)
proc mouseCursorObscured*(a: PEntry): Guint
proc setMouseCursorObscured*(a: PEntry, `mouse_cursor_obscured`: Guint)
proc entryGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_entry_get_type".}
proc entryNew*(): PEntry{.cdecl, dynlib: lib, importc: "gtk_entry_new".}
proc setVisibility*(entry: PEntry, visible: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_entry_set_visibility".}
proc getVisibility*(entry: PEntry): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_entry_get_visibility".}
proc setInvisibleChar*(entry: PEntry, ch: Gunichar){.cdecl, dynlib: lib, 
    importc: "gtk_entry_set_invisible_char".}
proc getInvisibleChar*(entry: PEntry): Gunichar{.cdecl, dynlib: lib, 
    importc: "gtk_entry_get_invisible_char".}
proc setHasFrame*(entry: PEntry, setting: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_entry_set_has_frame".}
proc getHasFrame*(entry: PEntry): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_entry_get_has_frame".}
proc setMaxLength*(entry: PEntry, max: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_entry_set_max_length".}
proc getMaxLength*(entry: PEntry): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_entry_get_max_length".}
proc setActivatesDefault*(entry: PEntry, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_entry_set_activates_default".}
proc getActivatesDefault*(entry: PEntry): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_entry_get_activates_default".}
proc setWidthChars*(entry: PEntry, n_chars: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_entry_set_width_chars".}
proc getWidthChars*(entry: PEntry): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_entry_get_width_chars".}
proc setText*(entry: PEntry, text: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_entry_set_text".}
proc getText*(entry: PEntry): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_entry_get_text".}
proc getLayout*(entry: PEntry): pango.PLayout{.cdecl, dynlib: lib, 
    importc: "gtk_entry_get_layout".}
proc getLayoutOffsets*(entry: PEntry, x: Pgint, y: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_entry_get_layout_offsets".}
const 
  AnchorCenter* = 0
  AnchorNorth* = 1
  AnchorNorthWest* = 2
  AnchorNorthEast* = 3
  AnchorSouth* = 4
  AnchorSouthWest* = 5
  AnchorSouthEast* = 6
  AnchorWest* = 7
  AnchorEast* = 8
  AnchorN* = ANCHOR_NORTH
  AnchorNw* = ANCHOR_NORTH_WEST
  AnchorNe* = ANCHOR_NORTH_EAST
  AnchorS* = ANCHOR_SOUTH
  AnchorSw* = ANCHOR_SOUTH_WEST
  AnchorSe* = ANCHOR_SOUTH_EAST
  AnchorW* = ANCHOR_WEST
  AnchorE* = ANCHOR_EAST
  ArrowUp* = 0
  ArrowDown* = 1
  ArrowLeft* = 2
  ArrowRight* = 3
  constEXPAND* = 1 shl 0
  constSHRINK* = 1 shl 1
  constFILL* = 1 shl 2
  ButtonboxDefaultStyle* = 0
  ButtonboxSpread* = 1
  ButtonboxEdge* = 2
  ButtonboxStart* = 3
  ButtonboxEnd* = 4
  CurveTypeLinear* = 0
  CurveTypeSpline* = 1
  CurveTypeFree* = 2
  DeleteChars* = 0
  DeleteWordEnds* = 1
  DeleteWords* = 2
  DeleteDisplayLines* = 3
  DeleteDisplayLineEnds* = 4
  DeleteParagraphEnds* = 5
  DeleteParagraphs* = 6
  DeleteWhitespace* = 7
  DirTabForward* = 0
  DirTabBackward* = 1
  DirUp* = 2
  DirDown* = 3
  DirLeft* = 4
  DirRight* = 5
  ExpanderCollapsed* = 0
  ExpanderSemiCollapsed* = 1
  ExpanderSemiExpanded* = 2
  ExpanderExpanded* = 3
  IconSizeInvalid* = 0
  IconSizeMenu* = 1
  IconSizeSmallToolbar* = 2
  IconSizeLargeToolbar* = 3
  IconSizeButton* = 4
  IconSizeDnd* = 5
  IconSizeDialog* = 6
  TextDirNone* = 0
  TextDirLtr* = 1
  TextDirRtl* = 2
  JustifyLeft* = 0
  JustifyRight* = 1
  JustifyCenter* = 2
  JustifyFill* = 3
  MenuDirParent* = 0
  MenuDirChild* = 1
  MenuDirNext* = 2
  MenuDirPrev* = 3
  Pixels* = 0
  Inches* = 1
  Centimeters* = 2
  MovementLogicalPositions* = 0
  MovementVisualPositions* = 1
  MovementWords* = 2
  MovementDisplayLines* = 3
  MovementDisplayLineEnds* = 4
  MovementParagraphs* = 5
  MovementParagraphEnds* = 6
  MovementPages* = 7
  MovementBufferEnds* = 8
  OrientationHorizontal* = 0
  OrientationVertical* = 1
  CornerTopLeft* = 0
  CornerBottomLeft* = 1
  CornerTopRight* = 2
  CornerBottomRight* = 3
  constPACKSTART* = 0
  constPACKEND* = 1
  PathPrioLowest* = 0
  PathPrioGtk* = 4
  PathPrioApplication* = 8
  PathPrioTheme* = 10
  PathPrioRc* = 12
  PathPrioHighest* = 15
  PathWidget* = 0
  PathWidgetClass* = 1
  PathClass* = 2
  PolicyAlways* = 0
  PolicyAutomatic* = 1
  PolicyNever* = 2
  PosLeft* = 0
  PosRight* = 1
  PosTop* = 2
  PosBottom* = 3
  PreviewColor* = 0
  PreviewGrayscale* = 1
  ReliefNormal* = 0
  ReliefHalf* = 1
  ReliefNone* = 2
  ResizeParent* = 0
  ResizeQueue* = 1
  ResizeImmediate* = 2
  ScrollNone* = 0
  ScrollJump* = 1
  ScrollStepBackward* = 2
  ScrollStepForward* = 3
  ScrollPageBackward* = 4
  ScrollPageForward* = 5
  ScrollStepUp* = 6
  ScrollStepDown* = 7
  ScrollPageUp* = 8
  ScrollPageDown* = 9
  ScrollStepLeft* = 10
  ScrollStepRight* = 11
  ScrollPageLeft* = 12
  ScrollPageRight* = 13
  ScrollStart* = 14
  ScrollEnd* = 15
  SelectionNone* = 0
  SelectionSingle* = 1
  SelectionBrowse* = 2
  SelectionMultiple* = 3
  SelectionExtended* = SELECTION_MULTIPLE
  ShadowNone* = 0
  ShadowIn* = 1
  ShadowOut* = 2
  ShadowEtchedIn* = 3
  ShadowEtchedOut* = 4
  StateNormal* = 0
  StateActive* = 1
  StatePrelight* = 2
  StateSelected* = 3
  StateInsensitive* = 4
  DirectionLeft* = 0
  DirectionRight* = 1
  TopBottom* = 0
  LeftRight* = 1
  ToolbarIcons* = 0
  ToolbarText* = 1
  ToolbarBoth* = 2
  ToolbarBothHoriz* = 3
  UpdateContinuous* = 0
  UpdateDiscontinuous* = 1
  UpdateDelayed* = 2
  VisibilityNone* = 0
  VisibilityPartial* = 1
  VisibilityFull* = 2
  WinPosNone* = 0
  WinPosCenter* = 1
  WinPosMouse* = 2
  WinPosCenterAlways* = 3
  WinPosCenterOnParent* = 4
  WindowToplevel* = 0
  WindowPopup* = 1
  WrapNone* = 0
  WrapChar* = 1
  WrapWord* = 2
  SortAscending* = 0
  SortDescending* = 1

proc typeEventBox*(): GType
proc eventBox*(obj: Pointer): PEventBox
proc eventBoxClass*(klass: Pointer): PEventBoxClass
proc isEventBox*(obj: Pointer): Bool
proc isEventBoxClass*(klass: Pointer): Bool
proc eventBoxGetClass*(obj: Pointer): PEventBoxClass
proc eventBoxGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_event_box_get_type".}
proc eventBoxNew*(): PEventBox{.cdecl, dynlib: lib, 
                                  importc: "gtk_event_box_new".}
const 
  FnmPathname* = 1 shl 0
  FnmNoescape* = 1 shl 1
  FnmPeriod* = 1 shl 2

const 
  FnmFileName* = FNM_PATHNAME
  FnmLeadingDir* = 1 shl 3
  FnmCasefold* = 1 shl 4

const 
  FnmNomatch* = 1

proc fnmatch*(`pattern`: Char, `string`: Char, `flags`: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "fnmatch".}
proc typeFileSelection*(): GType
proc fileSelection*(obj: Pointer): PFileSelection
proc fileSelectionClass*(klass: Pointer): PFileSelectionClass
proc isFileSelection*(obj: Pointer): Bool
proc isFileSelectionClass*(klass: Pointer): Bool
proc fileSelectionGetClass*(obj: Pointer): PFileSelectionClass
proc fileSelectionGetType*(): TType{.cdecl, dynlib: lib, 
                                        importc: "gtk_file_selection_get_type".}
proc fileSelectionNew*(title: Cstring): PFileSelection{.cdecl, dynlib: lib, 
    importc: "gtk_file_selection_new".}
proc setFilename*(filesel: PFileSelection, filename: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_file_selection_set_filename".}
proc getFilename*(filesel: PFileSelection): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_file_selection_get_filename".}
proc complete*(filesel: PFileSelection, pattern: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_file_selection_complete".}
proc showFileopButtons*(filesel: PFileSelection){.cdecl, 
    dynlib: lib, importc: "gtk_file_selection_show_fileop_buttons".}
proc hideFileopButtons*(filesel: PFileSelection){.cdecl, 
    dynlib: lib, importc: "gtk_file_selection_hide_fileop_buttons".}
proc getSelections*(filesel: PFileSelection): PPgchar{.cdecl, 
    dynlib: lib, importc: "gtk_file_selection_get_selections".}
proc setSelectMultiple*(filesel: PFileSelection, 
    select_multiple: Gboolean){.cdecl, dynlib: lib, importc: "gtk_file_selection_set_select_multiple".}
proc getSelectMultiple*(filesel: PFileSelection): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_selection_get_select_multiple".}
proc typeFixed*(): GType
proc fixed*(obj: Pointer): PFixed
proc fixedClass*(klass: Pointer): PFixedClass
proc isFixed*(obj: Pointer): Bool
proc isFixedClass*(klass: Pointer): Bool
proc fixedGetClass*(obj: Pointer): PFixedClass
proc fixedGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_fixed_get_type".}
proc fixedNew*(): PFixed{.cdecl, dynlib: lib, importc: "gtk_fixed_new".}
proc put*(fixed: PFixed, widget: PWidget, x: Gint, y: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_fixed_put".}
proc move*(fixed: PFixed, widget: PWidget, x: Gint, y: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_fixed_move".}
proc setHasWindow*(fixed: PFixed, has_window: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_fixed_set_has_window".}
proc getHasWindow*(fixed: PFixed): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_fixed_get_has_window".}
proc typeFontSelection*(): GType
proc fontSelection*(obj: Pointer): PFontSelection
proc fontSelectionClass*(klass: Pointer): PFontSelectionClass
proc isFontSelection*(obj: Pointer): Bool
proc isFontSelectionClass*(klass: Pointer): Bool
proc fontSelectionGetClass*(obj: Pointer): PFontSelectionClass
proc typeFontSelectionDialog*(): GType
proc fontSelectionDialog*(obj: Pointer): PFontSelectionDialog
proc fontSelectionDialogClass*(klass: Pointer): PFontSelectionDialogClass
proc isFontSelectionDialog*(obj: Pointer): Bool
proc isFontSelectionDialogClass*(klass: Pointer): Bool
proc fontSelectionDialogGetClass*(obj: Pointer): PFontSelectionDialogClass
proc fontSelectionGetType*(): TType{.cdecl, dynlib: lib, 
                                        importc: "gtk_font_selection_get_type".}
proc fontSelectionNew*(): PFontSelection{.cdecl, dynlib: lib, 
    importc: "gtk_font_selection_new".}
proc getFontName*(fontsel: PFontSelection): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_font_selection_get_font_name".}
proc setFontName*(fontsel: PFontSelection, fontname: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_font_selection_set_font_name".}
proc getPreviewText*(fontsel: PFontSelection): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_font_selection_get_preview_text".}
proc setPreviewText*(fontsel: PFontSelection, text: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_font_selection_set_preview_text".}
proc fontSelectionDialogGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_font_selection_dialog_get_type".}
proc fontSelectionDialogNew*(title: Cstring): PFontSelectionDialog{.cdecl, 
    dynlib: lib, importc: "gtk_font_selection_dialog_new".}
proc dialogGetFontName*(fsd: PFontSelectionDialog): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_font_selection_dialog_get_font_name".}
proc dialogSetFontName*(fsd: PFontSelectionDialog, 
    fontname: Cstring): Gboolean{.cdecl, dynlib: lib, importc: "gtk_font_selection_dialog_set_font_name".}
proc dialogGetPreviewText*(fsd: PFontSelectionDialog): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_font_selection_dialog_get_preview_text".}
proc dialogSetPreviewText*(fsd: PFontSelectionDialog, 
    text: Cstring){.cdecl, dynlib: lib, 
                    importc: "gtk_font_selection_dialog_set_preview_text".}
proc typeGammaCurve*(): GType
proc gammaCurve*(obj: Pointer): PGammaCurve
proc gammaCurveClass*(klass: Pointer): PGammaCurveClass
proc isGammaCurve*(obj: Pointer): Bool
proc isGammaCurveClass*(klass: Pointer): Bool
proc gammaCurveGetClass*(obj: Pointer): PGammaCurveClass
proc gammaCurveGetType*(): TType{.cdecl, dynlib: lib, 
                                     importc: "gtk_gamma_curve_get_type".}
proc gammaCurveNew*(): PGammaCurve{.cdecl, dynlib: lib, 
                                      importc: "gtk_gamma_curve_new".}
proc gcGet*(depth: Gint, colormap: gdk2.PColormap, values: gdk2.PGCValues, 
             values_mask: gdk2.TGCValuesMask): gdk2.PGC{.cdecl, dynlib: lib, 
    importc: "gtk_gc_get".}
proc gcRelease*(gc: gdk2.Pgc){.cdecl, dynlib: lib, importc: "gtk_gc_release".}
const 
  bmTGtkHandleBoxHandlePosition* = 0x0003'i16
  bpTGtkHandleBoxHandlePosition* = 0'i16
  bmTGtkHandleBoxFloatWindowMapped* = 0x0004'i16
  bpTGtkHandleBoxFloatWindowMapped* = 2'i16
  bmTGtkHandleBoxChildDetached* = 0x0008'i16
  bpTGtkHandleBoxChildDetached* = 3'i16
  bmTGtkHandleBoxInDrag* = 0x0010'i16
  bpTGtkHandleBoxInDrag* = 4'i16
  bmTGtkHandleBoxShrinkOnDetach* = 0x0020'i16
  bpTGtkHandleBoxShrinkOnDetach* = 5'i16
  bmTGtkHandleBoxSnapEdge* = 0x01C0'i16
  bpTGtkHandleBoxSnapEdge* = 6'i16

proc typeHandleBox*(): GType
proc handleBox*(obj: Pointer): PHandleBox
proc handleBoxClass*(klass: Pointer): PHandleBoxClass
proc isHandleBox*(obj: Pointer): Bool
proc isHandleBoxClass*(klass: Pointer): Bool
proc handleBoxGetClass*(obj: Pointer): PHandleBoxClass
proc handlePosition*(a: PHandleBox): Guint
proc setHandlePosition*(a: PHandleBox, `handle_position`: Guint)
proc floatWindowMapped*(a: PHandleBox): Guint
proc setFloatWindowMapped*(a: PHandleBox, `float_window_mapped`: Guint)
proc childDetached*(a: PHandleBox): Guint
proc setChildDetached*(a: PHandleBox, `child_detached`: Guint)
proc inDrag*(a: PHandleBox): Guint
proc setInDrag*(a: PHandleBox, `in_drag`: Guint)
proc shrinkOnDetach*(a: PHandleBox): Guint
proc setShrinkOnDetach*(a: PHandleBox, `shrink_on_detach`: Guint)
proc snapEdge*(a: PHandleBox): Gint
proc setSnapEdge*(a: PHandleBox, `snap_edge`: Gint)
proc handleBoxGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_handle_box_get_type".}
proc handleBoxNew*(): PHandleBox{.cdecl, dynlib: lib, 
                                    importc: "gtk_handle_box_new".}
proc setShadowType*(handle_box: PHandleBox, thetype: TShadowType){.
    cdecl, dynlib: lib, importc: "gtk_handle_box_set_shadow_type".}
proc getShadowType*(handle_box: PHandleBox): TShadowType{.cdecl, 
    dynlib: lib, importc: "gtk_handle_box_get_shadow_type".}
proc setHandlePosition*(handle_box: PHandleBox, 
                                     position: TPositionType){.cdecl, 
    dynlib: lib, importc: "gtk_handle_box_set_handle_position".}
proc getHandlePosition*(handle_box: PHandleBox): TPositionType{.
    cdecl, dynlib: lib, importc: "gtk_handle_box_get_handle_position".}
proc setSnapEdge*(handle_box: PHandleBox, edge: TPositionType){.
    cdecl, dynlib: lib, importc: "gtk_handle_box_set_snap_edge".}
proc getSnapEdge*(handle_box: PHandleBox): TPositionType{.cdecl, 
    dynlib: lib, importc: "gtk_handle_box_get_snap_edge".}
const 
  bmTGtkPanedPositionSet* = 0x0001'i16
  bpTGtkPanedPositionSet* = 0'i16
  bmTGtkPanedInDrag* = 0x0002'i16
  bpTGtkPanedInDrag* = 1'i16
  bmTGtkPanedChild1Shrink* = 0x0004'i16
  bpTGtkPanedChild1Shrink* = 2'i16
  bmTGtkPanedChild1Resize* = 0x0008'i16
  bpTGtkPanedChild1Resize* = 3'i16
  bmTGtkPanedChild2Shrink* = 0x0010'i16
  bpTGtkPanedChild2Shrink* = 4'i16
  bmTGtkPanedChild2Resize* = 0x0020'i16
  bpTGtkPanedChild2Resize* = 5'i16
  bmTGtkPanedOrientation* = 0x0040'i16
  bpTGtkPanedOrientation* = 6'i16
  bmTGtkPanedInRecursion* = 0x0080'i16
  bpTGtkPanedInRecursion* = 7'i16
  bmTGtkPanedHandlePrelit* = 0x0100'i16
  bpTGtkPanedHandlePrelit* = 8'i16

proc typePaned*(): GType
proc paned*(obj: Pointer): PPaned
proc panedClass*(klass: Pointer): PPanedClass
proc isPaned*(obj: Pointer): Bool
proc isPanedClass*(klass: Pointer): Bool
proc panedGetClass*(obj: Pointer): PPanedClass
proc positionSet*(a: PPaned): Guint
proc setPositionSet*(a: PPaned, `position_set`: Guint)
proc inDrag*(a: PPaned): Guint
proc setInDrag*(a: PPaned, `in_drag`: Guint)
proc child1Shrink*(a: PPaned): Guint
proc setChild1Shrink*(a: PPaned, `child1_shrink`: Guint)
proc child1Resize*(a: PPaned): Guint
proc setChild1Resize*(a: PPaned, `child1_resize`: Guint)
proc child2Shrink*(a: PPaned): Guint
proc setChild2Shrink*(a: PPaned, `child2_shrink`: Guint)
proc child2Resize*(a: PPaned): Guint
proc setChild2Resize*(a: PPaned, `child2_resize`: Guint)
proc orientation*(a: PPaned): Guint
proc setOrientation*(a: PPaned, `orientation`: Guint)
proc inRecursion*(a: PPaned): Guint
proc setInRecursion*(a: PPaned, `in_recursion`: Guint)
proc handlePrelit*(a: PPaned): Guint
proc setHandlePrelit*(a: PPaned, `handle_prelit`: Guint)
proc panedGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_paned_get_type".}
proc add1*(paned: PPaned, child: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_paned_add1".}
proc add2*(paned: PPaned, child: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_paned_add2".}
proc pack1*(paned: PPaned, child: PWidget, resize: Gboolean, 
                  shrink: Gboolean){.cdecl, dynlib: lib, 
                                     importc: "gtk_paned_pack1".}
proc pack2*(paned: PPaned, child: PWidget, resize: Gboolean, 
                  shrink: Gboolean){.cdecl, dynlib: lib, 
                                     importc: "gtk_paned_pack2".}
proc getPosition*(paned: PPaned): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_paned_get_position".}
proc setPosition*(paned: PPaned, position: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paned_set_position".}
proc computePosition*(paned: PPaned, allocation: Gint, child1_req: Gint, 
                             child2_req: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paned_compute_position".}
proc typeHbuttonBox*(): GType
proc hbuttonBox*(obj: Pointer): PHButtonBox
proc hbuttonBoxClass*(klass: Pointer): PHButtonBoxClass
proc isHbuttonBox*(obj: Pointer): Bool
proc isHbuttonBoxClass*(klass: Pointer): Bool
proc hbuttonBoxGetClass*(obj: Pointer): PHButtonBoxClass
proc hbuttonBoxGetType*(): TType{.cdecl, dynlib: lib, 
                                     importc: "gtk_hbutton_box_get_type".}
proc hbuttonBoxNew*(): PHButtonBox{.cdecl, dynlib: lib, 
                                      importc: "gtk_hbutton_box_new".}
proc typeHpaned*(): GType
proc hpaned*(obj: Pointer): PHPaned
proc hpanedClass*(klass: Pointer): PHPanedClass
proc isHpaned*(obj: Pointer): Bool
proc isHpanedClass*(klass: Pointer): Bool
proc hpanedGetClass*(obj: Pointer): PHPanedClass
proc hpanedGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_hpaned_get_type".}
proc hpanedNew*(): PHPaned{.cdecl, dynlib: lib, importc: "gtk_hpaned_new".}
proc typeRuler*(): GType
proc ruler*(obj: Pointer): PRuler
proc rulerClass*(klass: Pointer): PRulerClass
proc isRuler*(obj: Pointer): Bool
proc isRulerClass*(klass: Pointer): Bool
proc rulerGetClass*(obj: Pointer): PRulerClass
proc rulerGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_ruler_get_type".}
proc setMetric*(ruler: PRuler, metric: TMetricType){.cdecl, dynlib: lib, 
    importc: "gtk_ruler_set_metric".}
proc setRange*(ruler: PRuler, lower: Gdouble, upper: Gdouble, 
                      position: Gdouble, max_size: Gdouble){.cdecl, dynlib: lib, 
    importc: "gtk_ruler_set_range".}
proc drawTicks*(ruler: PRuler){.cdecl, dynlib: lib, 
                                       importc: "gtk_ruler_draw_ticks".}
proc drawPos*(ruler: PRuler){.cdecl, dynlib: lib, 
                                     importc: "gtk_ruler_draw_pos".}
proc getMetric*(ruler: PRuler): TMetricType{.cdecl, dynlib: lib, 
    importc: "gtk_ruler_get_metric".}
proc getRange*(ruler: PRuler, lower: Pgdouble, upper: Pgdouble, 
                      position: Pgdouble, max_size: Pgdouble){.cdecl, 
    dynlib: lib, importc: "gtk_ruler_get_range".}
proc typeHruler*(): GType
proc hruler*(obj: Pointer): PHRuler
proc hrulerClass*(klass: Pointer): PHRulerClass
proc isHruler*(obj: Pointer): Bool
proc isHrulerClass*(klass: Pointer): Bool
proc hrulerGetClass*(obj: Pointer): PHRulerClass
proc hrulerGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_hruler_get_type".}
proc hrulerNew*(): PHRuler{.cdecl, dynlib: lib, importc: "gtk_hruler_new".}
proc typeSettings*(): GType
proc settings*(obj: Pointer): PSettings
proc settingsClass*(klass: Pointer): PSettingsClass
proc isSettings*(obj: Pointer): Bool
proc isSettingsClass*(klass: Pointer): Bool
proc settingsGetClass*(obj: Pointer): PSettingsClass
proc settingsGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "gtk_settings_get_type".}
proc settingsGetForScreen*(screen: gdk2.PScreen): PSettings{.cdecl, 
    dynlib: lib, importc: "gtk_settings_get_for_screen".}
proc settingsInstallProperty*(pspec: PGParamSpec){.cdecl, dynlib: lib, 
    importc: "gtk_settings_install_property".}
proc settingsInstallPropertyParser*(pspec: PGParamSpec, 
                                       parser: TRcPropertyParser){.cdecl, 
    dynlib: lib, importc: "gtk_settings_install_property_parser".}
proc rcPropertyParseColor*(pspec: PGParamSpec, gstring: PGString, 
                              property_value: PGValue): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_rc_property_parse_color".}
proc rcPropertyParseEnum*(pspec: PGParamSpec, gstring: PGString, 
                             property_value: PGValue): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_rc_property_parse_enum".}
proc rcPropertyParseFlags*(pspec: PGParamSpec, gstring: PGString, 
                              property_value: PGValue): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_rc_property_parse_flags".}
proc rcPropertyParseRequisition*(pspec: PGParamSpec, gstring: PGString, 
                                    property_value: PGValue): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_rc_property_parse_requisition".}
proc rcPropertyParseBorder*(pspec: PGParamSpec, gstring: PGString, 
                               property_value: PGValue): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_rc_property_parse_border".}
proc setPropertyValue*(settings: PSettings, name: Cstring, 
                                  svalue: PSettingsValue){.cdecl, dynlib: lib, 
    importc: "gtk_settings_set_property_value".}
proc setStringProperty*(settings: PSettings, name: Cstring, 
                                   v_string: Cstring, origin: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_settings_set_string_property".}
proc setLongProperty*(settings: PSettings, name: Cstring, 
                                 v_long: Glong, origin: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_settings_set_long_property".}
proc setDoubleProperty*(settings: PSettings, name: Cstring, 
                                   v_double: Gdouble, origin: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_settings_set_double_property".}
proc settingsHandleEvent*(event: gdk2.PEventSetting){.cdecl, dynlib: lib, 
    importc: "_gtk_settings_handle_event".}
proc rcPropertyParserFromType*(thetype: GType): TRcPropertyParser{.cdecl, 
    dynlib: lib, importc: "_gtk_rc_property_parser_from_type".}
proc settingsParseConvert*(parser: TRcPropertyParser, src_value: PGValue, 
                             pspec: PGParamSpec, dest_value: PGValue): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_settings_parse_convert".}
const 
  RcFg* = 1 shl 0
  RcBg* = 1 shl 1
  RcText* = 1 shl 2
  RcBase* = 1 shl 3
  bmTGtkRcStyleEngineSpecified* = 0x0001'i16
  bpTGtkRcStyleEngineSpecified* = 0'i16

proc typeRcStyle*(): GType
proc rCSTYLEGet*(anObject: Pointer): PRcStyle
proc rcStyleClass*(klass: Pointer): PRcStyleClass
proc isRcStyle*(anObject: Pointer): Bool
proc isRcStyleClass*(klass: Pointer): Bool
proc rcStyleGetClass*(obj: Pointer): PRcStyleClass
proc engineSpecified*(a: PRcStyle): Guint
proc setEngineSpecified*(a: PRcStyle, `engine_specified`: Guint)
proc rcInit*(){.cdecl, dynlib: lib, importc: "_gtk_rc_init".}
proc rcAddDefaultFile*(filename: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_rc_add_default_file".}
proc rcSetDefaultFiles*(filenames: PPgchar){.cdecl, dynlib: lib, 
    importc: "gtk_rc_set_default_files".}
proc rcGetDefaultFiles*(): PPgchar{.cdecl, dynlib: lib, 
                                       importc: "gtk_rc_get_default_files".}
proc rcGetStyle*(widget: PWidget): PStyle{.cdecl, dynlib: lib, 
    importc: "gtk_rc_get_style".}
proc rcGetStyleByPaths*(settings: PSettings, widget_path: Cstring, 
                            class_path: Cstring, thetype: GType): PStyle{.cdecl, 
    dynlib: lib, importc: "gtk_rc_get_style_by_paths".}
proc rcReparseAllForSettings*(settings: PSettings, force_load: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_rc_reparse_all_for_settings".}
proc rcFindPixmapInPath*(settings: PSettings, scanner: PGScanner, 
                             pixmap_file: Cstring): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_rc_find_pixmap_in_path".}
proc rcParse*(filename: Cstring){.cdecl, dynlib: lib, importc: "gtk_rc_parse".}
proc rcParseString*(rc_string: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_rc_parse_string".}
proc rcReparseAll*(): Gboolean{.cdecl, dynlib: lib, 
                                  importc: "gtk_rc_reparse_all".}
proc rcStyleGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "gtk_rc_style_get_type".}
proc rcStyleNew*(): PRcStyle{.cdecl, dynlib: lib, importc: "gtk_rc_style_new".}
proc copy*(orig: PRcStyle): PRcStyle{.cdecl, dynlib: lib, 
    importc: "gtk_rc_style_copy".}
proc reference*(rc_style: PRcStyle){.cdecl, dynlib: lib, 
                                        importc: "gtk_rc_style_ref".}
proc unref*(rc_style: PRcStyle){.cdecl, dynlib: lib, 
    importc: "gtk_rc_style_unref".}
proc rcFindModuleInPath*(module_file: Cstring): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_rc_find_module_in_path".}
proc rcGetThemeDir*(): Cstring{.cdecl, dynlib: lib, 
                                   importc: "gtk_rc_get_theme_dir".}
proc rcGetModuleDir*(): Cstring{.cdecl, dynlib: lib, 
                                    importc: "gtk_rc_get_module_dir".}
proc rcGetImModulePath*(): Cstring{.cdecl, dynlib: lib, 
                                        importc: "gtk_rc_get_im_module_path".}
proc rcGetImModuleFile*(): Cstring{.cdecl, dynlib: lib, 
                                        importc: "gtk_rc_get_im_module_file".}
proc rcScannerNew*(): PGScanner{.cdecl, dynlib: lib, 
                                   importc: "gtk_rc_scanner_new".}
proc rcParseColor*(scanner: PGScanner, color: gdk2.PColor): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_rc_parse_color".}
proc rcParseState*(scanner: PGScanner, state: PStateType): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_rc_parse_state".}
proc rcParsePriority*(scanner: PGScanner, priority: PPathPriorityType): Guint{.
    cdecl, dynlib: lib, importc: "gtk_rc_parse_priority".}
proc lookupRcProperty*(rc_style: PRcStyle, type_name: TGQuark, 
                                  property_name: TGQuark): PRcProperty{.cdecl, 
    dynlib: lib, importc: "_gtk_rc_style_lookup_rc_property".}
proc rcContextGetDefaultFontName*(settings: PSettings): Cstring{.cdecl, 
    dynlib: lib, importc: "_gtk_rc_context_get_default_font_name".}
proc typeStyle*(): GType
proc style*(anObject: Pointer): PStyle
proc styleClass*(klass: Pointer): PStyleClass
proc isStyle*(anObject: Pointer): Bool
proc isStyleClass*(klass: Pointer): Bool
proc styleGetClass*(obj: Pointer): PStyleClass
proc typeBorder*(): GType
proc styleAttached*(style: Pointer): Bool
proc styleGetType*(): GType{.cdecl, dynlib: lib, importc: "gtk_style_get_type".}
proc styleNew*(): PStyle{.cdecl, dynlib: lib, importc: "gtk_style_new".}
proc copy*(style: PStyle): PStyle{.cdecl, dynlib: lib, 
    importc: "gtk_style_copy".}
proc attach*(style: PStyle, window: gdk2.PWindow): PStyle{.cdecl, 
    dynlib: lib, importc: "gtk_style_attach".}
proc detach*(style: PStyle){.cdecl, dynlib: lib, 
                                   importc: "gtk_style_detach".}
proc setBackground*(style: PStyle, window: gdk2.PWindow, 
                           state_type: TStateType){.cdecl, dynlib: lib, 
    importc: "gtk_style_set_background".}
proc applyDefaultBackground*(style: PStyle, window: gdk2.PWindow, 
                                     set_bg: Gboolean, state_type: TStateType, 
                                     area: gdk2.PRectangle, x: Gint, y: Gint, 
                                     width: Gint, height: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_style_apply_default_background".}
proc lookupIconSet*(style: PStyle, stock_id: Cstring): PIconSet{.cdecl, 
    dynlib: lib, importc: "gtk_style_lookup_icon_set".}
proc renderIcon*(style: PStyle, source: PIconSource, 
                        direction: TTextDirection, state: TStateType, 
                        size: TIconSize, widget: PWidget, detail: Cstring): gdk2pixbuf.PPixbuf{.
    cdecl, dynlib: lib, importc: "gtk_style_render_icon".}
proc paintHline*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                  area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                  x1: Gint, x2: Gint, y: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paint_hline".}
proc paintVline*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                  area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                  y1: Gint, y2: Gint, x: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paint_vline".}
proc paintShadow*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                   shadow_type: TShadowType, area: gdk2.PRectangle, 
                   widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                   width: Gint, height: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paint_shadow".}
proc paintPolygon*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                    shadow_type: TShadowType, area: gdk2.PRectangle, 
                    widget: PWidget, detail: Cstring, points: gdk2.PPoint, 
                    npoints: Gint, fill: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_paint_polygon".}
proc paintArrow*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                  shadow_type: TShadowType, area: gdk2.PRectangle, 
                  widget: PWidget, detail: Cstring, arrow_type: TArrowType, 
                  fill: Gboolean, x: Gint, y: Gint, width: Gint, height: Gint){.
    cdecl, dynlib: lib, importc: "gtk_paint_arrow".}
proc paintDiamond*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                    shadow_type: TShadowType, area: gdk2.PRectangle, 
                    widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                    width: Gint, height: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paint_diamond".}
proc paintBox*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                shadow_type: TShadowType, area: gdk2.PRectangle, widget: PWidget, 
                detail: Cstring, x: Gint, y: Gint, width: Gint, height: Gint){.
    cdecl, dynlib: lib, importc: "gtk_paint_box".}
proc paintFlatBox*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                     shadow_type: TShadowType, area: gdk2.PRectangle, 
                     widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                     width: Gint, height: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paint_flat_box".}
proc paintCheck*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                  shadow_type: TShadowType, area: gdk2.PRectangle, 
                  widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                  width: Gint, height: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paint_check".}
proc paintOption*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                   shadow_type: TShadowType, area: gdk2.PRectangle, 
                   widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                   width: Gint, height: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paint_option".}
proc paintTab*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                shadow_type: TShadowType, area: gdk2.PRectangle, widget: PWidget, 
                detail: Cstring, x: Gint, y: Gint, width: Gint, height: Gint){.
    cdecl, dynlib: lib, importc: "gtk_paint_tab".}
proc paintShadowGap*(style: PStyle, window: gdk2.PWindow, 
                       state_type: TStateType, shadow_type: TShadowType, 
                       area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                       x: Gint, y: Gint, width: Gint, height: Gint, 
                       gap_side: TPositionType, gap_x: Gint, gap_width: Gint){.
    cdecl, dynlib: lib, importc: "gtk_paint_shadow_gap".}
proc paintBoxGap*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                    shadow_type: TShadowType, area: gdk2.PRectangle, 
                    widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                    width: Gint, height: Gint, gap_side: TPositionType, 
                    gap_x: Gint, gap_width: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_paint_box_gap".}
proc paintExtension*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                      shadow_type: TShadowType, area: gdk2.PRectangle, 
                      widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                      width: Gint, height: Gint, gap_side: TPositionType){.
    cdecl, dynlib: lib, importc: "gtk_paint_extension".}
proc paintFocus*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                  area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                  x: Gint, y: Gint, width: Gint, height: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_paint_focus".}
proc paintSlider*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                   shadow_type: TShadowType, area: gdk2.PRectangle, 
                   widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                   width: Gint, height: Gint, orientation: TOrientation){.cdecl, 
    dynlib: lib, importc: "gtk_paint_slider".}
proc paintHandle*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                   shadow_type: TShadowType, area: gdk2.PRectangle, 
                   widget: PWidget, detail: Cstring, x: Gint, y: Gint, 
                   width: Gint, height: Gint, orientation: TOrientation){.cdecl, 
    dynlib: lib, importc: "gtk_paint_handle".}
proc paintExpander*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                     area: gdk2.PRectangle, widget: PWidget, detail: Cstring, 
                     x: Gint, y: Gint, expander_style: TExpanderStyle){.cdecl, 
    dynlib: lib, importc: "gtk_paint_expander".}
proc paintLayout*(style: PStyle, window: gdk2.PWindow, state_type: TStateType, 
                   use_text: Gboolean, area: gdk2.PRectangle, widget: PWidget, 
                   detail: Cstring, x: Gint, y: Gint, layout: pango.PLayout){.
    cdecl, dynlib: lib, importc: "gtk_paint_layout".}
proc paintResizeGrip*(style: PStyle, window: gdk2.PWindow, 
                        state_type: TStateType, area: gdk2.PRectangle, 
                        widget: PWidget, detail: Cstring, edge: gdk2.TWindowEdge, 
                        x: Gint, y: Gint, width: Gint, height: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_paint_resize_grip".}
proc borderGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "gtk_border_get_type".}
proc copy*(border: PBorder): PBorder{.cdecl, dynlib: lib, 
    importc: "gtk_border_copy".}
proc free*(border: PBorder){.cdecl, dynlib: lib, 
                                    importc: "gtk_border_free".}
proc peekPropertyValue*(style: PStyle, widget_type: GType, 
                                pspec: PGParamSpec, parser: TRcPropertyParser): PGValue{.
    cdecl, dynlib: lib, importc: "_gtk_style_peek_property_value".}
proc getInsertionCursorGc*(widget: PWidget, is_primary: Gboolean): gdk2.Pgc{.
    cdecl, dynlib: lib, importc: "_gtk_get_insertion_cursor_gc".}
proc drawInsertionCursor*(widget: PWidget, drawable: gdk2.PDrawable, gc: gdk2.Pgc, 
                            location: gdk2.PRectangle, direction: TTextDirection, 
                            draw_arrow: Gboolean){.cdecl, dynlib: lib, 
    importc: "_gtk_draw_insertion_cursor".}
const 
  bmTGtkRangeInverted* = 0x0001'i16
  bpTGtkRangeInverted* = 0'i16
  bmTGtkRangeFlippable* = 0x0002'i16
  bpTGtkRangeFlippable* = 1'i16
  bmTGtkRangeHasStepperA* = 0x0004'i16
  bpTGtkRangeHasStepperA* = 2'i16
  bmTGtkRangeHasStepperB* = 0x0008'i16
  bpTGtkRangeHasStepperB* = 3'i16
  bmTGtkRangeHasStepperC* = 0x0010'i16
  bpTGtkRangeHasStepperC* = 4'i16
  bmTGtkRangeHasStepperD* = 0x0020'i16
  bpTGtkRangeHasStepperD* = 5'i16
  bmTGtkRangeNeedRecalc* = 0x0040'i16
  bpTGtkRangeNeedRecalc* = 6'i16
  bmTGtkRangeSliderSizeFixed* = 0x0080'i16
  bpTGtkRangeSliderSizeFixed* = 7'i16
  bmTGtkRangeTroughClickForward* = 0x0001'i16
  bpTGtkRangeTroughClickForward* = 0'i16
  bmTGtkRangeUpdatePending* = 0x0002'i16
  bpTGtkRangeUpdatePending* = 1'i16

proc typeRange*(): GType
proc range*(obj: Pointer): PRange
proc rangeClass*(klass: Pointer): PRangeClass
proc isRange*(obj: Pointer): Bool
proc isRangeClass*(klass: Pointer): Bool
proc rangeGetClass*(obj: Pointer): PRangeClass
proc inverted*(a: PRange): Guint
proc setInverted*(a: PRange, `inverted`: Guint)
proc flippable*(a: PRange): Guint
proc setFlippable*(a: PRange, `flippable`: Guint)
proc hasStepperA*(a: PRange): Guint
proc setHasStepperA*(a: PRange, `has_stepper_a`: Guint)
proc hasStepperB*(a: PRange): Guint
proc setHasStepperB*(a: PRange, `has_stepper_b`: Guint)
proc hasStepperC*(a: PRange): Guint
proc setHasStepperC*(a: PRange, `has_stepper_c`: Guint)
proc hasStepperD*(a: PRange): Guint
proc setHasStepperD*(a: PRange, `has_stepper_d`: Guint)
proc needRecalc*(a: PRange): Guint
proc setNeedRecalc*(a: PRange, `need_recalc`: Guint)
proc sliderSizeFixed*(a: PRange): Guint
proc setSliderSizeFixed*(a: PRange, `slider_size_fixed`: Guint)
proc troughClickForward*(a: PRange): Guint
proc setTroughClickForward*(a: PRange, `trough_click_forward`: Guint)
proc updatePending*(a: PRange): Guint
proc setUpdatePending*(a: PRange, `update_pending`: Guint)
proc rangeGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_range_get_type".}
proc setUpdatePolicy*(range: PRange, policy: TUpdateType){.cdecl, 
    dynlib: lib, importc: "gtk_range_set_update_policy".}
proc getUpdatePolicy*(range: PRange): TUpdateType{.cdecl, dynlib: lib, 
    importc: "gtk_range_get_update_policy".}
proc setAdjustment*(range: PRange, adjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_range_set_adjustment".}
proc getAdjustment*(range: PRange): PAdjustment{.cdecl, dynlib: lib, 
    importc: "gtk_range_get_adjustment".}
proc setInverted*(range: PRange, setting: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_range_set_inverted".}
proc getInverted*(range: PRange): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_range_get_inverted".}
proc setIncrements*(range: PRange, step: Gdouble, page: Gdouble){.cdecl, 
    dynlib: lib, importc: "gtk_range_set_increments".}
proc setRange*(range: PRange, min: Gdouble, max: Gdouble){.cdecl, 
    dynlib: lib, importc: "gtk_range_set_range".}
proc setValue*(range: PRange, value: Gdouble){.cdecl, dynlib: lib, 
    importc: "gtk_range_set_value".}
proc getValue*(range: PRange): Gdouble{.cdecl, dynlib: lib, 
    importc: "gtk_range_get_value".}
const 
  bmTGtkScaleDrawValue* = 0x0001'i16
  bpTGtkScaleDrawValue* = 0'i16
  bmTGtkScaleValuePos* = 0x0006'i16
  bpTGtkScaleValuePos* = 1'i16

proc typeScale*(): GType
proc scale*(obj: Pointer): PScale
proc scaleClass*(klass: Pointer): PScaleClass
proc isScale*(obj: Pointer): Bool
proc isScaleClass*(klass: Pointer): Bool
proc scaleGetClass*(obj: Pointer): PScaleClass
proc drawValue*(a: PScale): Guint
proc setDrawValue*(a: PScale, `draw_value`: Guint)
proc valuePos*(a: PScale): Guint
proc setValuePos*(a: PScale, `value_pos`: Guint)
proc scaleGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_scale_get_type".}
proc setDigits*(scale: PScale, digits: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_scale_set_digits".}
proc getDigits*(scale: PScale): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_scale_get_digits".}
proc setDrawValue*(scale: PScale, draw_value: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_scale_set_draw_value".}
proc getDrawValue*(scale: PScale): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_scale_get_draw_value".}
proc setValuePos*(scale: PScale, pos: TPositionType){.cdecl, 
    dynlib: lib, importc: "gtk_scale_set_value_pos".}
proc getValuePos*(scale: PScale): TPositionType{.cdecl, dynlib: lib, 
    importc: "gtk_scale_get_value_pos".}
proc getValueSize*(scale: PScale, width: Pgint, height: Pgint){.cdecl, 
    dynlib: lib, importc: "_gtk_scale_get_value_size".}
proc formatValue*(scale: PScale, value: Gdouble): Cstring{.cdecl, 
    dynlib: lib, importc: "_gtk_scale_format_value".}
proc typeHscale*(): GType
proc hscale*(obj: Pointer): PHScale
proc hscaleClass*(klass: Pointer): PHScaleClass
proc isHscale*(obj: Pointer): Bool
proc isHscaleClass*(klass: Pointer): Bool
proc hscaleGetClass*(obj: Pointer): PHScaleClass
proc hscaleGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_hscale_get_type".}
proc hscaleNew*(adjustment: PAdjustment): PHScale{.cdecl, dynlib: lib, 
    importc: "gtk_hscale_new".}
proc hscaleNew*(min: Gdouble, max: Gdouble, step: Gdouble): PHScale{.
    cdecl, dynlib: lib, importc: "gtk_hscale_new_with_range".}
proc typeScrollbar*(): GType
proc scrollbar*(obj: Pointer): PScrollbar
proc scrollbarClass*(klass: Pointer): PScrollbarClass
proc isScrollbar*(obj: Pointer): Bool
proc isScrollbarClass*(klass: Pointer): Bool
proc scrollbarGetClass*(obj: Pointer): PScrollbarClass
proc scrollbarGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_scrollbar_get_type".}
proc typeHscrollbar*(): GType
proc hscrollbar*(obj: Pointer): PHScrollbar
proc hscrollbarClass*(klass: Pointer): PHScrollbarClass
proc isHscrollbar*(obj: Pointer): Bool
proc isHscrollbarClass*(klass: Pointer): Bool
proc hscrollbarGetClass*(obj: Pointer): PHScrollbarClass
proc hscrollbarGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_hscrollbar_get_type".}
proc hscrollbarNew*(adjustment: PAdjustment): PHScrollbar{.cdecl, dynlib: lib, 
    importc: "gtk_hscrollbar_new".}
proc typeSeparator*(): GType
proc separator*(obj: Pointer): PSeparator
proc separatorClass*(klass: Pointer): PSeparatorClass
proc isSeparator*(obj: Pointer): Bool
proc isSeparatorClass*(klass: Pointer): Bool
proc separatorGetClass*(obj: Pointer): PSeparatorClass
proc separatorGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_separator_get_type".}
proc typeHseparator*(): GType
proc hseparator*(obj: Pointer): PHSeparator
proc hseparatorClass*(klass: Pointer): PHSeparatorClass
proc isHseparator*(obj: Pointer): Bool
proc isHseparatorClass*(klass: Pointer): Bool
proc hseparatorGetClass*(obj: Pointer): PHSeparatorClass
proc hseparatorGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_hseparator_get_type".}
proc hseparatorNew*(): PHSeparator{.cdecl, dynlib: lib, 
                                     importc: "gtk_hseparator_new".}
proc typeIconFactory*(): GType
proc iconFactory*(anObject: Pointer): PIconFactory
proc iconFactoryClass*(klass: Pointer): PIconFactoryClass
proc isIconFactory*(anObject: Pointer): Bool
proc isIconFactoryClass*(klass: Pointer): Bool
proc iconFactoryGetClass*(obj: Pointer): PIconFactoryClass
proc typeIconSet*(): GType
proc typeIconSource*(): GType
proc iconFactoryGetType*(): GType{.cdecl, dynlib: lib, 
                                      importc: "gtk_icon_factory_get_type".}
proc iconFactoryNew*(): PIconFactory{.cdecl, dynlib: lib, 
                                        importc: "gtk_icon_factory_new".}
proc add*(factory: PIconFactory, stock_id: Cstring, 
                       icon_set: PIconSet){.cdecl, dynlib: lib, 
    importc: "gtk_icon_factory_add".}
proc lookup*(factory: PIconFactory, stock_id: Cstring): PIconSet{.
    cdecl, dynlib: lib, importc: "gtk_icon_factory_lookup".}
proc addDefault*(factory: PIconFactory){.cdecl, dynlib: lib, 
    importc: "gtk_icon_factory_add_default".}
proc removeDefault*(factory: PIconFactory){.cdecl, dynlib: lib, 
    importc: "gtk_icon_factory_remove_default".}
proc iconFactoryLookupDefault*(stock_id: Cstring): PIconSet{.cdecl, 
    dynlib: lib, importc: "gtk_icon_factory_lookup_default".}
proc iconSizeLookup*(size: TIconSize, width: Pgint, height: Pgint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_icon_size_lookup".}
proc iconSizeRegister*(name: Cstring, width: Gint, height: Gint): TIconSize{.
    cdecl, dynlib: lib, importc: "gtk_icon_size_register".}
proc iconSizeRegisterAlias*(alias: Cstring, target: TIconSize){.cdecl, 
    dynlib: lib, importc: "gtk_icon_size_register_alias".}
proc iconSizeFromName*(name: Cstring): TIconSize{.cdecl, dynlib: lib, 
    importc: "gtk_icon_size_from_name".}
proc iconSizeGetName*(size: TIconSize): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_icon_size_get_name".}
proc iconSetGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "gtk_icon_set_get_type".}
proc iconSetNew*(): PIconSet{.cdecl, dynlib: lib, importc: "gtk_icon_set_new".}
proc iconSetNewFromPixbuf*(pixbuf: gdk2pixbuf.PPixbuf): PIconSet{.cdecl, 
    dynlib: lib, importc: "gtk_icon_set_new_from_pixbuf".}
proc reference*(icon_set: PIconSet): PIconSet{.cdecl, dynlib: lib, 
    importc: "gtk_icon_set_ref".}
proc unref*(icon_set: PIconSet){.cdecl, dynlib: lib, 
    importc: "gtk_icon_set_unref".}
proc copy*(icon_set: PIconSet): PIconSet{.cdecl, dynlib: lib, 
    importc: "gtk_icon_set_copy".}
proc renderIcon*(icon_set: PIconSet, style: PStyle, 
                           direction: TTextDirection, state: TStateType, 
                           size: TIconSize, widget: PWidget, detail: Cstring): gdk2pixbuf.PPixbuf{.
    cdecl, dynlib: lib, importc: "gtk_icon_set_render_icon".}
proc addSource*(icon_set: PIconSet, source: PIconSource){.cdecl, 
    dynlib: lib, importc: "gtk_icon_set_add_source".}
proc getSizes*(icon_set: PIconSet, sizes: PPGtkIconSize, 
                         n_sizes: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_icon_set_get_sizes".}
proc iconSourceGetType*(): GType{.cdecl, dynlib: lib, 
                                     importc: "gtk_icon_source_get_type".}
proc iconSourceNew*(): PIconSource{.cdecl, dynlib: lib, 
                                      importc: "gtk_icon_source_new".}
proc copy*(source: PIconSource): PIconSource{.cdecl, dynlib: lib, 
    importc: "gtk_icon_source_copy".}
proc free*(source: PIconSource){.cdecl, dynlib: lib, 
    importc: "gtk_icon_source_free".}
proc setFilename*(source: PIconSource, filename: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_set_filename".}
proc setPixbuf*(source: PIconSource, pixbuf: gdk2pixbuf.PPixbuf){.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_set_pixbuf".}
proc getFilename*(source: PIconSource): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_get_filename".}
proc getPixbuf*(source: PIconSource): gdk2pixbuf.PPixbuf{.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_get_pixbuf".}
proc setDirectionWildcarded*(source: PIconSource, 
    setting: Gboolean){.cdecl, dynlib: lib, 
                        importc: "gtk_icon_source_set_direction_wildcarded".}
proc setStateWildcarded*(source: PIconSource, setting: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_icon_source_set_state_wildcarded".}
proc setSizeWildcarded*(source: PIconSource, setting: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_icon_source_set_size_wildcarded".}
proc getSizeWildcarded*(source: PIconSource): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_get_size_wildcarded".}
proc getStateWildcarded*(source: PIconSource): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_get_state_wildcarded".}
proc getDirectionWildcarded*(source: PIconSource): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_icon_source_get_direction_wildcarded".}
proc setDirection*(source: PIconSource, direction: TTextDirection){.
    cdecl, dynlib: lib, importc: "gtk_icon_source_set_direction".}
proc setState*(source: PIconSource, state: TStateType){.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_set_state".}
proc setSize*(source: PIconSource, size: TIconSize){.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_set_size".}
proc getDirection*(source: PIconSource): TTextDirection{.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_get_direction".}
proc getState*(source: PIconSource): TStateType{.cdecl, 
    dynlib: lib, importc: "gtk_icon_source_get_state".}
proc getSize*(source: PIconSource): TIconSize{.cdecl, dynlib: lib, 
    importc: "gtk_icon_source_get_size".}
proc iconSetInvalidateCaches*(){.cdecl, dynlib: lib, 
                                    importc: "_gtk_icon_set_invalidate_caches".}
proc iconFactoryListIds*(): PGSList{.cdecl, dynlib: lib, 
                                        importc: "_gtk_icon_factory_list_ids".}
proc typeImage*(): GType
proc image*(obj: Pointer): PImage
proc imageClass*(klass: Pointer): PImageClass
proc isImage*(obj: Pointer): Bool
proc isImageClass*(klass: Pointer): Bool
proc imageGetClass*(obj: Pointer): PImageClass
proc imageGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_image_get_type".}
proc imageNew*(): PImage{.cdecl, dynlib: lib, importc: "gtk_image_new".}
proc imageNewFromPixmap*(pixmap: gdk2.PPixmap, mask: gdk2.PBitmap): PImage{.
    cdecl, dynlib: lib, importc: "gtk_image_new_from_pixmap".}
proc imageNewFromImage*(image: gdk2.PImage, mask: gdk2.PBitmap): PImage{.cdecl, 
    dynlib: lib, importc: "gtk_image_new_from_image".}
proc imageNewFromFile*(filename: Cstring): PImage{.cdecl, dynlib: lib, 
    importc: "gtk_image_new_from_file".}
proc imageNewFromPixbuf*(pixbuf: gdk2pixbuf.PPixbuf): PImage{.cdecl, dynlib: lib, 
    importc: "gtk_image_new_from_pixbuf".}
proc imageNewFromStock*(stock_id: Cstring, size: TIconSize): PImage{.cdecl, 
    dynlib: lib, importc: "gtk_image_new_from_stock".}
proc imageNewFromIconSet*(icon_set: PIconSet, size: TIconSize): PImage{.
    cdecl, dynlib: lib, importc: "gtk_image_new_from_icon_set".}
proc imageNewFromAnimation*(animation: gdk2pixbuf.PPixbufAnimation): PImage{.cdecl, 
    dynlib: lib, importc: "gtk_image_new_from_animation".}
proc setFromPixmap*(image: PImage, pixmap: gdk2.PPixmap, mask: gdk2.PBitmap){.
    cdecl, dynlib: lib, importc: "gtk_image_set_from_pixmap".}
proc setFromImage*(image: PImage, gdk_image: gdk2.PImage, mask: gdk2.PBitmap){.
    cdecl, dynlib: lib, importc: "gtk_image_set_from_image".}
proc setFromFile*(image: PImage, filename: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_image_set_from_file".}
proc setFromPixbuf*(image: PImage, pixbuf: gdk2pixbuf.PPixbuf){.cdecl, 
    dynlib: lib, importc: "gtk_image_set_from_pixbuf".}
proc setFromStock*(image: PImage, stock_id: Cstring, size: TIconSize){.
    cdecl, dynlib: lib, importc: "gtk_image_set_from_stock".}
proc setFromIconSet*(image: PImage, icon_set: PIconSet, size: TIconSize){.
    cdecl, dynlib: lib, importc: "gtk_image_set_from_icon_set".}
proc setFromAnimation*(image: PImage, animation: gdk2pixbuf.PPixbufAnimation){.
    cdecl, dynlib: lib, importc: "gtk_image_set_from_animation".}
proc getStorageType*(image: PImage): TImageType{.cdecl, dynlib: lib, 
    importc: "gtk_image_get_storage_type".}
proc getPixbuf*(image: PImage): gdk2pixbuf.PPixbuf{.cdecl, dynlib: lib, 
    importc: "gtk_image_get_pixbuf".}
proc getStock*(image: PImage, stock_id: PPgchar, size: PIconSize){.cdecl, 
    dynlib: lib, importc: "gtk_image_get_stock".}
proc getAnimation*(image: PImage): gdk2pixbuf.PPixbufAnimation{.cdecl, 
    dynlib: lib, importc: "gtk_image_get_animation".}
proc typeImageMenuItem*(): GType
proc imageMenuItem*(obj: Pointer): PImageMenuItem
proc imageMenuItemClass*(klass: Pointer): PImageMenuItemClass
proc isImageMenuItem*(obj: Pointer): Bool
proc isImageMenuItemClass*(klass: Pointer): Bool
proc imageMenuItemGetClass*(obj: Pointer): PImageMenuItemClass
proc imageMenuItemGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_image_menu_item_get_type".}
proc imageMenuItemNew*(): PImageMenuItem{.cdecl, dynlib: lib, 
    importc: "gtk_image_menu_item_new".}
proc imageMenuItemNew*(`label`: Cstring): PImageMenuItem{.cdecl, 
    dynlib: lib, importc: "gtk_image_menu_item_new_with_label".}
proc imageMenuItemNewWithMnemonic*(`label`: Cstring): PImageMenuItem{.
    cdecl, dynlib: lib, importc: "gtk_image_menu_item_new_with_mnemonic".}
proc imageMenuItemNewFromStock*(stock_id: Cstring, accel_group: PAccelGroup): PImageMenuItem{.
    cdecl, dynlib: lib, importc: "gtk_image_menu_item_new_from_stock".}
proc itemSetImage*(image_menu_item: PImageMenuItem, image: PWidget){.
    cdecl, dynlib: lib, importc: "gtk_image_menu_item_set_image".}
proc itemGetImage*(image_menu_item: PImageMenuItem): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_image_menu_item_get_image".}
const 
  bmTGtkIMContextSimpleInHexSequence* = 0x0001'i16
  bpTGtkIMContextSimpleInHexSequence* = 0'i16

proc typeImContextSimple*(): GType
proc imContextSimple*(obj: Pointer): PIMContextSimple
proc imContextSimpleClass*(klass: Pointer): PIMContextSimpleClass
proc isImContextSimple*(obj: Pointer): Bool
proc isImContextSimpleClass*(klass: Pointer): Bool
proc imContextSimpleGetClass*(obj: Pointer): PIMContextSimpleClass
proc inHexSequence*(a: PIMContextSimple): Guint
proc setInHexSequence*(a: PIMContextSimple, `in_hex_sequence`: Guint)
proc imContextSimpleGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_im_context_simple_get_type".}
proc imContextSimpleNew*(): PIMContext{.cdecl, dynlib: lib, 
    importc: "gtk_im_context_simple_new".}
proc simpleAddTable*(context_simple: PIMContextSimple, 
                                  data: Pguint16, max_seq_len: Gint, 
                                  n_seqs: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_im_context_simple_add_table".}
proc typeImMulticontext*(): GType
proc imMulticontext*(obj: Pointer): PIMMulticontext
proc imMulticontextClass*(klass: Pointer): PIMMulticontextClass
proc isImMulticontext*(obj: Pointer): Bool
proc isImMulticontextClass*(klass: Pointer): Bool
proc imMulticontextGetClass*(obj: Pointer): PIMMulticontextClass
proc imMulticontextGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_im_multicontext_get_type".}
proc imMulticontextNew*(): PIMContext{.cdecl, dynlib: lib, 
    importc: "gtk_im_multicontext_new".}
proc appendMenuitems*(context: PIMMulticontext, 
                                       menushell: PMenuShell){.cdecl, 
    dynlib: lib, importc: "gtk_im_multicontext_append_menuitems".}
proc typeInputDialog*(): GType
proc inputDialog*(obj: Pointer): PInputDialog
proc inputDialogClass*(klass: Pointer): PInputDialogClass
proc isInputDialog*(obj: Pointer): Bool
proc isInputDialogClass*(klass: Pointer): Bool
proc inputDialogGetClass*(obj: Pointer): PInputDialogClass
proc inputDialogGetType*(): TType{.cdecl, dynlib: lib, 
                                      importc: "gtk_input_dialog_get_type".}
proc inputDialogNew*(): PInputDialog{.cdecl, dynlib: lib, 
                                        importc: "gtk_input_dialog_new".}
proc typeInvisible*(): GType
proc invisible*(obj: Pointer): PInvisible
proc invisibleClass*(klass: Pointer): PInvisibleClass
proc isInvisible*(obj: Pointer): Bool
proc isInvisibleClass*(klass: Pointer): Bool
proc invisibleGetClass*(obj: Pointer): PInvisibleClass
proc invisibleGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_invisible_get_type".}
proc invisibleNew*(): PInvisible{.cdecl, dynlib: lib, 
                                   importc: "gtk_invisible_new".}
proc invisibleNewForScreen*(screen: gdk2.PScreen): PInvisible{.cdecl, 
    dynlib: lib, importc: "gtk_invisible_new_for_screen".}
proc setScreen*(invisible: PInvisible, screen: gdk2.PScreen){.cdecl, 
    dynlib: lib, importc: "gtk_invisible_set_screen".}
proc getScreen*(invisible: PInvisible): gdk2.PScreen{.cdecl, 
    dynlib: lib, importc: "gtk_invisible_get_screen".}
proc typeItemFactory*(): GType
proc itemFactory*(anObject: Pointer): PItemFactory
proc itemFactoryClass*(klass: Pointer): PItemFactoryClass
proc isItemFactory*(anObject: Pointer): Bool
proc isItemFactoryClass*(klass: Pointer): Bool
proc itemFactoryGetClass*(obj: Pointer): PItemFactoryClass
proc itemFactoryGetType*(): TType{.cdecl, dynlib: lib, 
                                      importc: "gtk_item_factory_get_type".}
proc itemFactoryNew*(container_type: TType, path: Cstring, 
                       accel_group: PAccelGroup): PItemFactory{.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_new".}
proc construct*(ifactory: PItemFactory, container_type: TType, 
                             path: Cstring, accel_group: PAccelGroup){.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_construct".}
proc itemFactoryAddForeign*(accel_widget: PWidget, full_path: Cstring, 
                               accel_group: PAccelGroup, keyval: Guint, 
                               modifiers: gdk2.TModifierType){.cdecl, dynlib: lib, 
    importc: "gtk_item_factory_add_foreign".}
proc itemFactoryFromWidget*(widget: PWidget): PItemFactory{.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_from_widget".}
proc itemFactoryPathFromWidget*(widget: PWidget): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_path_from_widget".}
proc getItem*(ifactory: PItemFactory, path: Cstring): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_item_factory_get_item".}
proc getWidget*(ifactory: PItemFactory, path: Cstring): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_item_factory_get_widget".}
proc getWidgetByAction*(ifactory: PItemFactory, action: Guint): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_item_factory_get_widget_by_action".}
proc getItemByAction*(ifactory: PItemFactory, action: Guint): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_item_factory_get_item_by_action".}
proc createItem*(ifactory: PItemFactory, entry: PItemFactoryEntry, 
                               callback_data: Gpointer, callback_type: Guint){.
    cdecl, dynlib: lib, importc: "gtk_item_factory_create_item".}
proc createItems*(ifactory: PItemFactory, n_entries: Guint, 
                                entries: PItemFactoryEntry, 
                                callback_data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_item_factory_create_items".}
proc deleteItem*(ifactory: PItemFactory, path: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_delete_item".}
proc deleteEntry*(ifactory: PItemFactory, entry: PItemFactoryEntry){.
    cdecl, dynlib: lib, importc: "gtk_item_factory_delete_entry".}
proc deleteEntries*(ifactory: PItemFactory, n_entries: Guint, 
                                  entries: PItemFactoryEntry){.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_delete_entries".}
proc popup*(ifactory: PItemFactory, x: Guint, y: Guint, 
                         mouse_button: Guint, time: Guint32){.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_popup".}
proc popup*(ifactory: PItemFactory, popup_data: Gpointer, 
                                   destroy: TDestroyNotify, x: Guint, y: Guint, 
                                   mouse_button: Guint, time: Guint32){.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_popup_with_data".}
proc popupData*(ifactory: PItemFactory): Gpointer{.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_popup_data".}
proc itemFactoryPopupDataFromWidget*(widget: PWidget): Gpointer{.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_popup_data_from_widget".}
proc setTranslateFunc*(ifactory: PItemFactory, 
                                      fun: TTranslateFunc, data: Gpointer, 
                                      notify: TDestroyNotify){.cdecl, 
    dynlib: lib, importc: "gtk_item_factory_set_translate_func".}
proc typeLayout*(): GType
proc layout*(obj: Pointer): PLayout
proc layoutClass*(klass: Pointer): PLayoutClass
proc isLayout*(obj: Pointer): Bool
proc isLayoutClass*(klass: Pointer): Bool
proc layoutGetClass*(obj: Pointer): PLayoutClass
proc layoutGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_layout_get_type".}
proc layoutNew*(hadjustment: PAdjustment, vadjustment: PAdjustment): PLayout{.
    cdecl, dynlib: lib, importc: "gtk_layout_new".}
proc put*(layout: PLayout, child_widget: PWidget, x: Gint, y: Gint){.
    cdecl, dynlib: lib, importc: "gtk_layout_put".}
proc move*(layout: PLayout, child_widget: PWidget, x: Gint, y: Gint){.
    cdecl, dynlib: lib, importc: "gtk_layout_move".}
proc setSize*(layout: PLayout, width: Guint, height: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_layout_set_size".}
proc getSize*(layout: PLayout, width: Pguint, height: Pguint){.cdecl, 
    dynlib: lib, importc: "gtk_layout_get_size".}
proc getHadjustment*(layout: PLayout): PAdjustment{.cdecl, dynlib: lib, 
    importc: "gtk_layout_get_hadjustment".}
proc getVadjustment*(layout: PLayout): PAdjustment{.cdecl, dynlib: lib, 
    importc: "gtk_layout_get_vadjustment".}
proc setHadjustment*(layout: PLayout, adjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_layout_set_hadjustment".}
proc setVadjustment*(layout: PLayout, adjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_layout_set_vadjustment".}
const 
  bmTGtkListSelectionMode* = 0x0003'i16
  bpTGtkListSelectionMode* = 0'i16
  bmTGtkListDragSelection* = 0x0004'i16
  bpTGtkListDragSelection* = 2'i16
  bmTGtkListAddMode* = 0x0008'i16
  bpTGtkListAddMode* = 3'i16

proc typeList*(): GType
proc list*(obj: Pointer): PList
proc listClass*(klass: Pointer): PListClass
proc isList*(obj: Pointer): Bool
proc isListClass*(klass: Pointer): Bool
proc listGetClass*(obj: Pointer): PListClass
proc selectionMode*(a: PList): Guint
proc setSelectionMode*(a: PList, `selection_mode`: Guint)
proc dragSelection*(a: PList): Guint
proc setDragSelection*(a: PList, `drag_selection`: Guint)
proc addMode*(a: PList): Guint
proc setAddMode*(a: PList, `add_mode`: Guint)
proc listGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_list_get_type".}
proc listNew*(): PList{.cdecl, dynlib: lib, importc: "gtk_list_new".}
proc insertItems*(list: PList, items: PGList, position: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_list_insert_items".}
proc appendItems*(list: PList, items: PGList){.cdecl, dynlib: lib, 
    importc: "gtk_list_append_items".}
proc prependItems*(list: PList, items: PGList){.cdecl, dynlib: lib, 
    importc: "gtk_list_prepend_items".}
proc removeItems*(list: PList, items: PGList){.cdecl, dynlib: lib, 
    importc: "gtk_list_remove_items".}
proc removeItemsNoUnref*(list: PList, items: PGList){.cdecl, 
    dynlib: lib, importc: "gtk_list_remove_items_no_unref".}
proc clearItems*(list: PList, start: Gint, theEnd: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_list_clear_items".}
proc selectItem*(list: PList, item: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_list_select_item".}
proc unselectItem*(list: PList, item: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_list_unselect_item".}
proc selectChild*(list: PList, child: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_list_select_child".}
proc unselectChild*(list: PList, child: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_list_unselect_child".}
proc childPosition*(list: PList, child: PWidget): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_list_child_position".}
proc setSelectionMode*(list: PList, mode: TSelectionMode){.cdecl, 
    dynlib: lib, importc: "gtk_list_set_selection_mode".}
proc extendSelection*(list: PList, scroll_type: TScrollType, 
                            position: Gfloat, auto_start_selection: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_list_extend_selection".}
proc startSelection*(list: PList){.cdecl, dynlib: lib, 
    importc: "gtk_list_start_selection".}
proc endSelection*(list: PList){.cdecl, dynlib: lib, 
                                       importc: "gtk_list_end_selection".}
proc selectAll*(list: PList){.cdecl, dynlib: lib, 
                                    importc: "gtk_list_select_all".}
proc unselectAll*(list: PList){.cdecl, dynlib: lib, 
                                      importc: "gtk_list_unselect_all".}
proc scrollHorizontal*(list: PList, scroll_type: TScrollType, 
                             position: Gfloat){.cdecl, dynlib: lib, 
    importc: "gtk_list_scroll_horizontal".}
proc scrollVertical*(list: PList, scroll_type: TScrollType, 
                           position: Gfloat){.cdecl, dynlib: lib, 
    importc: "gtk_list_scroll_vertical".}
proc toggleAddMode*(list: PList){.cdecl, dynlib: lib, 
    importc: "gtk_list_toggle_add_mode".}
proc toggleFocusRow*(list: PList){.cdecl, dynlib: lib, 
    importc: "gtk_list_toggle_focus_row".}
proc toggleRow*(list: PList, item: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_list_toggle_row".}
proc undoSelection*(list: PList){.cdecl, dynlib: lib, 
                                        importc: "gtk_list_undo_selection".}
proc endDragSelection*(list: PList){.cdecl, dynlib: lib, 
    importc: "gtk_list_end_drag_selection".}
const 
  TreeModelItersPersist* = 1 shl 0
  TreeModelListOnly* = 1 shl 1

proc typeTreeModel*(): GType
proc treeModel*(obj: Pointer): PTreeModel
proc isTreeModel*(obj: Pointer): Bool
proc treeModelGetIface*(obj: Pointer): PTreeModelIface
proc typeTreeIter*(): GType
proc typeTreePath*(): GType
proc treePathNew*(): PTreePath{.cdecl, dynlib: lib, 
                                  importc: "gtk_tree_path_new".}
proc treePathNewFromString*(path: Cstring): PTreePath{.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_new_from_string".}
proc toString*(path: PTreePath): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_to_string".}
proc treePathNewRoot*(): PTreePath
proc treePathNewFirst*(): PTreePath{.cdecl, dynlib: lib, 
                                        importc: "gtk_tree_path_new_first".}
proc appendIndex*(path: PTreePath, index: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_append_index".}
proc prependIndex*(path: PTreePath, index: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_prepend_index".}
proc getDepth*(path: PTreePath): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_get_depth".}
proc getIndices*(path: PTreePath): Pgint{.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_get_indices".}
proc free*(path: PTreePath){.cdecl, dynlib: lib, 
                                       importc: "gtk_tree_path_free".}
proc copy*(path: PTreePath): PTreePath{.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_copy".}
proc treePathGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "gtk_tree_path_get_type".}
proc compare*(a: PTreePath, b: PTreePath): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_compare".}
proc next*(path: PTreePath){.cdecl, dynlib: lib, 
                                       importc: "gtk_tree_path_next".}
proc prev*(path: PTreePath): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_prev".}
proc up*(path: PTreePath): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_tree_path_up".}
proc down*(path: PTreePath){.cdecl, dynlib: lib, 
                                       importc: "gtk_tree_path_down".}
proc isAncestor*(path: PTreePath, descendant: PTreePath): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_path_is_ancestor".}
proc isDescendant*(path: PTreePath, ancestor: PTreePath): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_path_is_descendant".}
proc rowReferenceNew*(model: PTreeModel, path: PTreePath): PTreeRowReference{.
    cdecl, dynlib: lib, importc: "gtk_tree_row_reference_new".}
proc treeRowReferenceNewProxy*(proxy: PGObject, model: PTreeModel, 
                                   path: PTreePath): PTreeRowReference{.cdecl, 
    dynlib: lib, importc: "gtk_tree_row_reference_new_proxy".}
proc referenceGetPath*(reference: PTreeRowReference): PTreePath{.
    cdecl, dynlib: lib, importc: "gtk_tree_row_reference_get_path".}
proc referenceValid*(reference: PTreeRowReference): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_row_reference_valid".}
proc referenceFree*(reference: PTreeRowReference){.cdecl, dynlib: lib, 
    importc: "gtk_tree_row_reference_free".}
proc treeRowReferenceInserted*(proxy: PGObject, path: PTreePath){.cdecl, 
    dynlib: lib, importc: "gtk_tree_row_reference_inserted".}
proc treeRowReferenceDeleted*(proxy: PGObject, path: PTreePath){.cdecl, 
    dynlib: lib, importc: "gtk_tree_row_reference_deleted".}
proc treeRowReferenceReordered*(proxy: PGObject, path: PTreePath, 
                                   iter: PTreeIter, new_order: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_tree_row_reference_reordered".}
proc copy*(iter: PTreeIter): PTreeIter{.cdecl, dynlib: lib, 
    importc: "gtk_tree_iter_copy".}
proc free*(iter: PTreeIter){.cdecl, dynlib: lib, 
                                       importc: "gtk_tree_iter_free".}
proc treeIterGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "gtk_tree_iter_get_type".}
proc treeModelGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_tree_model_get_type".}
proc getFlags*(tree_model: PTreeModel): TTreeModelFlags{.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_get_flags".}
proc getNColumns*(tree_model: PTreeModel): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_get_n_columns".}
proc getColumnType*(tree_model: PTreeModel, index: Gint): GType{.
    cdecl, dynlib: lib, importc: "gtk_tree_model_get_column_type".}
proc getIter*(tree_model: PTreeModel, iter: PTreeIter, 
                          path: PTreePath): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_get_iter".}
proc getIterFromString*(tree_model: PTreeModel, iter: PTreeIter, 
                                      path_string: Cstring): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_get_iter_from_string".}
proc getIterRoot*(tree_model: PTreeModel, iter: PTreeIter): Gboolean
proc getIterFirst*(tree_model: PTreeModel, iter: PTreeIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_model_get_iter_first".}
proc getPath*(tree_model: PTreeModel, iter: PTreeIter): PTreePath{.
    cdecl, dynlib: lib, importc: "gtk_tree_model_get_path".}
proc getValue*(tree_model: PTreeModel, iter: PTreeIter, 
                           column: Gint, value: PGValue){.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_get_value".}
proc iterNext*(tree_model: PTreeModel, iter: PTreeIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_model_iter_next".}
proc iterChildren*(tree_model: PTreeModel, iter: PTreeIter, 
                               parent: PTreeIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_iter_children".}
proc iterHasChild*(tree_model: PTreeModel, iter: PTreeIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_model_iter_has_child".}
proc iterNChildren*(tree_model: PTreeModel, iter: PTreeIter): Gint{.
    cdecl, dynlib: lib, importc: "gtk_tree_model_iter_n_children".}
proc iterNthChild*(tree_model: PTreeModel, iter: PTreeIter, 
                                parent: PTreeIter, n: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_iter_nth_child".}
proc iterParent*(tree_model: PTreeModel, iter: PTreeIter, 
                             child: PTreeIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_iter_parent".}
proc getStringFromIter*(tree_model: PTreeModel, iter: PTreeIter): 
    Cstring{.cdecl, dynlib: lib,
             importc: "gtk_tree_model_get_string_from_iter".}
proc refNode*(tree_model: PTreeModel, iter: PTreeIter){.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_ref_node".}
proc unrefNode*(tree_model: PTreeModel, iter: PTreeIter){.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_unref_node".}
proc foreach*(model: PTreeModel, fun: TTreeModelForeachFunc, 
                         user_data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_foreach".}
proc rowChanged*(tree_model: PTreeModel, path: PTreePath, 
                             iter: PTreeIter){.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_row_changed".}
proc rowInserted*(tree_model: PTreeModel, path: PTreePath, 
                              iter: PTreeIter){.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_row_inserted".}
proc rowHasChildToggled*(tree_model: PTreeModel, path: PTreePath, 
                                       iter: PTreeIter){.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_row_has_child_toggled".}
proc rowDeleted*(tree_model: PTreeModel, path: PTreePath){.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_row_deleted".}
proc rowsReordered*(tree_model: PTreeModel, path: PTreePath, 
                                iter: PTreeIter, new_order: Pgint){.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_rows_reordered".}
const 
  TreeSortableDefaultSortColumnId* = - (1)

proc typeTreeSortable*(): GType
proc treeSortable*(obj: Pointer): PTreeSortable
proc treeSortableClass*(obj: Pointer): PTreeSortableIface
proc isTreeSortable*(obj: Pointer): Bool
proc treeSortableGetIface*(obj: Pointer): PTreeSortableIface
proc treeSortableGetType*(): GType{.cdecl, dynlib: lib, 
                                       importc: "gtk_tree_sortable_get_type".}
proc sortColumnChanged*(sortable: PTreeSortable){.cdecl, 
    dynlib: lib, importc: "gtk_tree_sortable_sort_column_changed".}
proc getSortColumnId*(sortable: PTreeSortable, 
                                       sort_column_id: Pgint, order: PSortType): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_sortable_get_sort_column_id".}
proc setSortColumnId*(sortable: PTreeSortable, 
                                       sort_column_id: Gint, order: TSortType){.
    cdecl, dynlib: lib, importc: "gtk_tree_sortable_set_sort_column_id".}
proc setSortFunc*(sortable: PTreeSortable, sort_column_id: Gint, 
                                  sort_func: TTreeIterCompareFunc, 
                                  user_data: Gpointer, destroy: TDestroyNotify){.
    cdecl, dynlib: lib, importc: "gtk_tree_sortable_set_sort_func".}
proc setDefaultSortFunc*(sortable: PTreeSortable, 
    sort_func: TTreeIterCompareFunc, user_data: Gpointer, 
    destroy: TDestroyNotify){.cdecl, dynlib: lib, importc: "gtk_tree_sortable_set_default_sort_func".}
proc hasDefaultSortFunc*(sortable: PTreeSortable): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_sortable_has_default_sort_func".}
proc typeTreeModelSort*(): GType
proc treeModelSort*(obj: Pointer): PTreeModelSort
proc treeModelSortClass*(klass: Pointer): PTreeModelSortClass
proc isTreeModelSort*(obj: Pointer): Bool
proc isTreeModelSortClass*(klass: Pointer): Bool
proc treeModelSortGetClass*(obj: Pointer): PTreeModelSortClass
proc treeModelSortGetType*(): GType{.cdecl, dynlib: lib, 
    importc: "gtk_tree_model_sort_get_type".}
proc sortNew*(child_model: PTreeModel): PTreeModel{.
    cdecl, dynlib: lib, importc: "gtk_tree_model_sort_new_with_model".}
proc sortGetModel*(tree_model: PTreeModelSort): PTreeModel{.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_sort_get_model".}
proc treeModelSortConvertChildPathToPath*(
    tree_model_sort: PTreeModelSort, child_path: PTreePath): PTreePath{.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_sort_convert_child_path_to_path".}
proc treeModelSortConvertChildIterToIter*(
    tree_model_sort: PTreeModelSort, sort_iter: PTreeIter, child_iter: PTreeIter){.
    cdecl, dynlib: lib, 
    importc: "gtk_tree_model_sort_convert_child_iter_to_iter".}
proc treeModelSortConvertPathToChildPath*(
    tree_model_sort: PTreeModelSort, sorted_path: PTreePath): PTreePath{.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_sort_convert_path_to_child_path".}
proc treeModelSortConvertIterToChildIter*(
    tree_model_sort: PTreeModelSort, child_iter: PTreeIter, 
    sorted_iter: PTreeIter){.cdecl, dynlib: lib, importc: "gtk_tree_model_sort_convert_iter_to_child_iter".}
proc sortResetDefaultSortFunc*(tree_model_sort: PTreeModelSort){.
    cdecl, dynlib: lib, importc: "gtk_tree_model_sort_reset_default_sort_func".}
proc sortClearCache*(tree_model_sort: PTreeModelSort){.cdecl, 
    dynlib: lib, importc: "gtk_tree_model_sort_clear_cache".}
const 
  bmTGtkListStoreColumnsDirty* = 0x0001'i16
  bpTGtkListStoreColumnsDirty* = 0'i16

proc typeListStore*(): GType
proc listStore*(obj: Pointer): PListStore
proc listStoreClass*(klass: Pointer): PListStoreClass
proc isListStore*(obj: Pointer): Bool
proc isListStoreClass*(klass: Pointer): Bool
proc listStoreGetClass*(obj: Pointer): PListStoreClass
proc columnsDirty*(a: PListStore): Guint
proc setColumnsDirty*(a: PListStore, `columns_dirty`: Guint)
proc listStoreGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_list_store_get_type".}
proc listStoreNewv*(n_columns: Gint, types: PGType): PListStore{.cdecl, 
    dynlib: lib, importc: "gtk_list_store_newv".}
proc setColumnTypes*(list_store: PListStore, n_columns: Gint, 
                                  types: PGType){.cdecl, dynlib: lib, 
    importc: "gtk_list_store_set_column_types".}
proc setValue*(list_store: PListStore, iter: PTreeIter, 
                           column: Gint, value: PGValue){.cdecl, dynlib: lib, 
    importc: "gtk_list_store_set_value".}
proc remove*(list_store: PListStore, iter: PTreeIter){.cdecl, 
    dynlib: lib, importc: "gtk_list_store_remove".}
proc insert*(list_store: PListStore, iter: PTreeIter, position: Gint){.
    cdecl, dynlib: lib, importc: "gtk_list_store_insert".}
proc insertBefore*(list_store: PListStore, iter: PTreeIter, 
                               sibling: PTreeIter){.cdecl, dynlib: lib, 
    importc: "gtk_list_store_insert_before".}
proc insertAfter*(list_store: PListStore, iter: PTreeIter, 
                              sibling: PTreeIter){.cdecl, dynlib: lib, 
    importc: "gtk_list_store_insert_after".}
proc prepend*(list_store: PListStore, iter: PTreeIter){.cdecl, 
    dynlib: lib, importc: "gtk_list_store_prepend".}
proc append*(list_store: PListStore, iter: PTreeIter){.cdecl, 
    dynlib: lib, importc: "gtk_list_store_append".}
proc clear*(list_store: PListStore){.cdecl, dynlib: lib, 
    importc: "gtk_list_store_clear".}
when false: 
  const 
    PRIORITY_RESIZE* = G_PRIORITY_HIGH_IDLE + 10
proc checkVersion*(required_major: Guint, required_minor: Guint, 
                    required_micro: Guint): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_check_version".}
proc disableSetlocale*(){.cdecl, dynlib: lib, importc: "gtk_disable_setlocale".}
proc setLocale*(): Cstring{.cdecl, dynlib: lib, importc: "gtk_set_locale".}
proc getDefaultLanguage*(): pango.PLanguage{.cdecl, dynlib: lib, 
    importc: "gtk_get_default_language".}
proc eventsPending*(): Gint{.cdecl, dynlib: lib, importc: "gtk_events_pending".}
proc mainDoEvent*(event: gdk2.PEvent){.cdecl, dynlib: lib, 
                                       importc: "gtk_main_do_event".}
proc main*(){.cdecl, dynlib: lib, importc: "gtk_main".}
proc init*(argc, argv: Pointer){.cdecl, dynlib: lib, importc: "gtk_init".}
proc mainLevel*(): Guint{.cdecl, dynlib: lib, importc: "gtk_main_level".}
proc mainQuit*(){.cdecl, dynlib: lib, importc: "gtk_main_quit".}
proc mainIteration*(): Gboolean{.cdecl, dynlib: lib, 
                                  importc: "gtk_main_iteration".}
proc mainIterationDo*(blocking: Gboolean): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_main_iteration_do".}
proc gtkTrue*(): Gboolean{.cdecl, dynlib: lib, importc: "gtk_true".}
proc gtkFalse*(): Gboolean{.cdecl, dynlib: lib, importc: "gtk_false".}
proc grabAdd*(widget: PWidget){.cdecl, dynlib: lib, importc: "gtk_grab_add".}
proc grabGetCurrent*(): PWidget{.cdecl, dynlib: lib, 
                                   importc: "gtk_grab_get_current".}
proc grabRemove*(widget: PWidget){.cdecl, dynlib: lib, 
                                    importc: "gtk_grab_remove".}
proc initAdd*(`function`: TFunction, data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_init_add".}
proc quitAddDestroy*(main_level: Guint, anObject: PObject){.cdecl, 
    dynlib: lib, importc: "gtk_quit_add_destroy".}
proc quitAdd*(main_level: Guint, `function`: TFunction, data: Gpointer): Guint{.
    cdecl, dynlib: lib, importc: "gtk_quit_add".}
proc quitAddFull*(main_level: Guint, `function`: TFunction, 
                    marshal: TCallbackMarshal, data: Gpointer, 
                    destroy: TDestroyNotify): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_quit_add_full".}
proc quitRemove*(quit_handler_id: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_quit_remove".}
proc quitRemoveByData*(data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_quit_remove_by_data".}
proc timeoutAdd*(interval: Guint32, `function`: TFunction, data: Gpointer): Guint{.
    cdecl, dynlib: lib, importc: "gtk_timeout_add".}
proc timeoutAddFull*(interval: Guint32, `function`: TFunction, 
                       marshal: TCallbackMarshal, data: Gpointer, 
                       destroy: TDestroyNotify): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_timeout_add_full".}
proc timeoutRemove*(timeout_handler_id: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_timeout_remove".}
proc idleAdd*(`function`: TFunction, data: Gpointer): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_idle_add".}
proc idleAddPriority*(priority: Gint, `function`: TFunction, data: Gpointer): Guint{.
    cdecl, dynlib: lib, importc: "gtk_idle_add_priority".}
proc idleAddFull*(priority: Gint, `function`: TFunction, 
                    marshal: TCallbackMarshal, data: Gpointer, 
                    destroy: TDestroyNotify): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_idle_add_full".}
proc idleRemove*(idle_handler_id: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_idle_remove".}
proc idleRemoveByData*(data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_idle_remove_by_data".}
proc inputAddFull*(source: Gint, condition: gdk2.TInputCondition, 
                     `function`: gdk2.TInputFunction, marshal: TCallbackMarshal, 
                     data: Gpointer, destroy: TDestroyNotify): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_input_add_full".}
proc inputRemove*(input_handler_id: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_input_remove".}
proc keySnooperInstall*(snooper: TKeySnoopFunc, func_data: Gpointer): Guint{.
    cdecl, dynlib: lib, importc: "gtk_key_snooper_install".}
proc keySnooperRemove*(snooper_handler_id: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_key_snooper_remove".}
proc getCurrentEvent*(): gdk2.PEvent{.cdecl, dynlib: lib, 
                                      importc: "gtk_get_current_event".}
proc getCurrentEventTime*(): Guint32{.cdecl, dynlib: lib, 
    importc: "gtk_get_current_event_time".}
proc getCurrentEventState*(state: gdk2.PModifierType): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_get_current_event_state".}
proc getEventWidget*(event: gdk2.PEvent): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_get_event_widget".}
proc propagateEvent*(widget: PWidget, event: gdk2.PEvent){.cdecl, dynlib: lib, 
    importc: "gtk_propagate_event".}
proc booleanHandledAccumulator*(ihint: PGSignalInvocationHint, 
                                  return_accu: PGValue, handler_return: PGValue, 
                                  dummy: Gpointer): Gboolean{.cdecl, 
    dynlib: lib, importc: "_gtk_boolean_handled_accumulator".}
proc findModule*(name: Cstring, thetype: Cstring): Cstring{.cdecl, dynlib: lib, 
    importc: "_gtk_find_module".}
proc getModulePath*(thetype: Cstring): PPgchar{.cdecl, dynlib: lib, 
    importc: "_gtk_get_module_path".}
proc typeMenuBar*(): GType
proc menuBar*(obj: Pointer): PMenuBar
proc menuBarClass*(klass: Pointer): PMenuBarClass
proc isMenuBar*(obj: Pointer): Bool
proc isMenuBarClass*(klass: Pointer): Bool
proc menuBarGetClass*(obj: Pointer): PMenuBarClass
proc menuBarGetType*(): TType{.cdecl, dynlib: lib, 
                                  importc: "gtk_menu_bar_get_type".}
proc menuBarNew*(): PMenuBar{.cdecl, dynlib: lib, importc: "gtk_menu_bar_new".}
proc cycleFocus*(menubar: PMenuBar, dir: TDirectionType){.cdecl, 
    dynlib: lib, importc: "_gtk_menu_bar_cycle_focus".}
proc typeMessageDialog*(): GType
proc messageDialog*(obj: Pointer): PMessageDialog
proc messageDialogClass*(klass: Pointer): PMessageDialogClass
proc isMessageDialog*(obj: Pointer): Bool
proc isMessageDialogClass*(klass: Pointer): Bool
proc messageDialogGetClass*(obj: Pointer): PMessageDialogClass
proc messageDialogGetType*(): TType{.cdecl, dynlib: lib, 
                                        importc: "gtk_message_dialog_get_type".}
const 
  bmTGtkNotebookShowTabs* = 0x0001'i16
  bpTGtkNotebookShowTabs* = 0'i16
  bmTGtkNotebookHomogeneous* = 0x0002'i16
  bpTGtkNotebookHomogeneous* = 1'i16
  bmTGtkNotebookShowBorder* = 0x0004'i16
  bpTGtkNotebookShowBorder* = 2'i16
  bmTGtkNotebookTabPos* = 0x0018'i16
  bpTGtkNotebookTabPos* = 3'i16
  bmTGtkNotebookScrollable* = 0x0020'i16
  bpTGtkNotebookScrollable* = 5'i16
  bmTGtkNotebookInChild* = 0x00C0'i16
  bpTGtkNotebookInChild* = 6'i16
  bmTGtkNotebookClickChild* = 0x0300'i16
  bpTGtkNotebookClickChild* = 8'i16
  bmTGtkNotebookButton* = 0x0C00'i16
  bpTGtkNotebookButton* = 10'i16
  bmTGtkNotebookNeedTimer* = 0x1000'i16
  bpTGtkNotebookNeedTimer* = 12'i16
  bmTGtkNotebookChildHasFocus* = 0x2000'i16
  bpTGtkNotebookChildHasFocus* = 13'i16
  bmTGtkNotebookHaveVisibleChild* = 0x4000'i16
  bpTGtkNotebookHaveVisibleChild* = 14'i16
  bmTGtkNotebookFocusOut* = 0x8000'i16
  bpTGtkNotebookFocusOut* = 15'i16

proc typeNotebook*(): GType
proc notebook*(obj: Pointer): PNotebook
proc notebookClass*(klass: Pointer): PNotebookClass
proc isNotebook*(obj: Pointer): Bool
proc isNotebookClass*(klass: Pointer): Bool
proc notebookGetClass*(obj: Pointer): PNotebookClass
proc showTabs*(a: PNotebook): Guint
proc setShowTabs*(a: PNotebook, `show_tabs`: Guint)
proc homogeneous*(a: PNotebook): Guint
proc setHomogeneous*(a: PNotebook, `homogeneous`: Guint)
proc showBorder*(a: PNotebook): Guint
proc setShowBorder*(a: PNotebook, `show_border`: Guint)
proc tabPos*(a: PNotebook): Guint
proc scrollable*(a: PNotebook): Guint
proc setScrollable*(a: PNotebook, `scrollable`: Guint)
proc inChild*(a: PNotebook): Guint
proc setInChild*(a: PNotebook, `in_child`: Guint)
proc clickChild*(a: PNotebook): Guint
proc setClickChild*(a: PNotebook, `click_child`: Guint)
proc button*(a: PNotebook): Guint
proc setButton*(a: PNotebook, `button`: Guint)
proc needTimer*(a: PNotebook): Guint
proc setNeedTimer*(a: PNotebook, `need_timer`: Guint)
proc childHasFocus*(a: PNotebook): Guint
proc setChildHasFocus*(a: PNotebook, `child_has_focus`: Guint)
proc haveVisibleChild*(a: PNotebook): Guint
proc setHaveVisibleChild*(a: PNotebook, `have_visible_child`: Guint)
proc focusOut*(a: PNotebook): Guint
proc setFocusOut*(a: PNotebook, `focus_out`: Guint)
proc notebookGetType*(): TType{.cdecl, dynlib: lib, 
                                  importc: "gtk_notebook_get_type".}
proc notebookNew*(): PNotebook{.cdecl, dynlib: lib, importc: "gtk_notebook_new".}
proc appendPage*(notebook: PNotebook, child: PWidget, 
                           tab_label: PWidget): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_notebook_append_page".}
proc appendPageMenu*(notebook: PNotebook, child: PWidget, 
                                tab_label: PWidget, menu_label: PWidget): Gint{.
    cdecl, dynlib: lib, importc: "gtk_notebook_append_page_menu".}
proc prependPage*(notebook: PNotebook, child: PWidget, 
                            tab_label: PWidget): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_notebook_prepend_page".}
proc prependPageMenu*(notebook: PNotebook, child: PWidget, 
                                 tab_label: PWidget, menu_label: PWidget): Gint{.
    cdecl, dynlib: lib, importc: "gtk_notebook_prepend_page_menu".}
proc insertPage*(notebook: PNotebook, child: PWidget, 
                           tab_label: PWidget, position: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_notebook_insert_page".}
proc insertPageMenu*(notebook: PNotebook, child: PWidget, 
                                tab_label: PWidget, menu_label: PWidget, 
                                position: Gint): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_notebook_insert_page_menu".}
proc removePage*(notebook: PNotebook, page_num: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_notebook_remove_page".}
proc getCurrentPage*(notebook: PNotebook): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_notebook_get_current_page".}
proc getNPages*(notebook: PNotebook): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_notebook_get_n_pages".}
proc getNthPage*(notebook: PNotebook, page_num: Gint): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_notebook_get_nth_page".}
proc pageNum*(notebook: PNotebook, child: PWidget): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_notebook_page_num".}
proc setCurrentPage*(notebook: PNotebook, page_num: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_notebook_set_current_page".}
proc nextPage*(notebook: PNotebook){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_next_page".}
proc prevPage*(notebook: PNotebook){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_prev_page".}
proc setShowBorder*(notebook: PNotebook, show_border: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_notebook_set_show_border".}
proc getShowBorder*(notebook: PNotebook): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_notebook_get_show_border".}
proc setShowTabs*(notebook: PNotebook, show_tabs: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_notebook_set_show_tabs".}
proc getShowTabs*(notebook: PNotebook): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_notebook_get_show_tabs".}
#proc set_tab_pos*(notebook: PNotebook, pos: TPositionType){.cdecl, 
#    dynlib: lib, importc: "gtk_notebook_set_tab_pos".}
proc getTabPos*(notebook: PNotebook): TPositionType{.cdecl, 
    dynlib: lib, importc: "gtk_notebook_get_tab_pos".}
proc setScrollable*(notebook: PNotebook, scrollable: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_notebook_set_scrollable".}
proc getScrollable*(notebook: PNotebook): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_notebook_get_scrollable".}
proc setTabReorderable*(notebook: PNotebook, child: PWidget, b: Bool){.cdecl,
    dynlib: lib, importc: "gtk_notebook_set_tab_reorderable".}
proc getTabReorderable*(notebook: PNotebook, child: PWidget): Bool {.cdecl,
    dynlib: lib, importc: "gtk_notebook_get_tab_reorderable".}
proc popupEnable*(notebook: PNotebook){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_popup_enable".}
proc popupDisable*(notebook: PNotebook){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_popup_disable".}
proc getTabLabel*(notebook: PNotebook, child: PWidget): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_notebook_get_tab_label".}
proc setTabLabel*(notebook: PNotebook, child: PWidget, 
                             tab_label: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_set_tab_label".}
proc setTabLabelText*(notebook: PNotebook, child: PWidget, 
                                  tab_text: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_set_tab_label_text".}
proc getTabLabelText*(notebook: PNotebook, child: PWidget): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_notebook_get_tab_label_text".}
proc getMenuLabel*(notebook: PNotebook, child: PWidget): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_notebook_get_menu_label".}
proc setMenuLabel*(notebook: PNotebook, child: PWidget, 
                              menu_label: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_set_menu_label".}
proc setMenuLabelText*(notebook: PNotebook, child: PWidget, 
                                   menu_text: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_set_menu_label_text".}
proc getMenuLabelText*(notebook: PNotebook, child: PWidget): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_notebook_get_menu_label_text".}
proc queryTabLabelPacking*(notebook: PNotebook, child: PWidget, 
                                       expand: Pgboolean, fill: Pgboolean, 
                                       pack_type: PPackType){.cdecl, 
    dynlib: lib, importc: "gtk_notebook_query_tab_label_packing".}
proc setTabLabelPacking*(notebook: PNotebook, child: PWidget, 
                                     expand: Gboolean, fill: Gboolean, 
                                     pack_type: TPackType){.cdecl, dynlib: lib, 
    importc: "gtk_notebook_set_tab_label_packing".}
proc reorderChild*(notebook: PNotebook, child: PWidget, position: Gint){.
    cdecl, dynlib: lib, importc: "gtk_notebook_reorder_child".}
const 
  bmTGtkOldEditableHasSelection* = 0x0001'i16
  bpTGtkOldEditableHasSelection* = 0'i16
  bmTGtkOldEditableEditable* = 0x0002'i16
  bpTGtkOldEditableEditable* = 1'i16
  bmTGtkOldEditableVisible* = 0x0004'i16
  bpTGtkOldEditableVisible* = 2'i16

proc typeOldEditable*(): GType
proc oldEditable*(obj: Pointer): POldEditable
proc oldEditableClass*(klass: Pointer): POldEditableClass
proc isOldEditable*(obj: Pointer): Bool
proc isOldEditableClass*(klass: Pointer): Bool
proc oldEditableGetClass*(obj: Pointer): POldEditableClass
proc hasSelection*(a: POldEditable): Guint
proc setHasSelection*(a: POldEditable, `has_selection`: Guint)
proc editable*(a: POldEditable): Guint
proc setEditable*(a: POldEditable, `editable`: Guint)
proc visible*(a: POldEditable): Guint
proc setVisible*(a: POldEditable, `visible`: Guint)
proc oldEditableGetType*(): TType{.cdecl, dynlib: lib, 
                                      importc: "gtk_old_editable_get_type".}
proc claimSelection*(old_editable: POldEditable, claim: Gboolean, 
                                   time: Guint32){.cdecl, dynlib: lib, 
    importc: "gtk_old_editable_claim_selection".}
proc changed*(old_editable: POldEditable){.cdecl, dynlib: lib, 
    importc: "gtk_old_editable_changed".}
proc typeOptionMenu*(): GType
proc optionMenu*(obj: Pointer): POptionMenu
proc optionMenuClass*(klass: Pointer): POptionMenuClass
proc isOptionMenu*(obj: Pointer): Bool
proc isOptionMenuClass*(klass: Pointer): Bool
proc optionMenuGetClass*(obj: Pointer): POptionMenuClass
proc optionMenuGetType*(): TType{.cdecl, dynlib: lib, 
                                     importc: "gtk_option_menu_get_type".}
proc optionMenuNew*(): POptionMenu{.cdecl, dynlib: lib, 
                                      importc: "gtk_option_menu_new".}
proc getMenu*(option_menu: POptionMenu): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_option_menu_get_menu".}
proc setMenu*(option_menu: POptionMenu, menu: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_option_menu_set_menu".}
proc removeMenu*(option_menu: POptionMenu){.cdecl, dynlib: lib, 
    importc: "gtk_option_menu_remove_menu".}
proc getHistory*(option_menu: POptionMenu): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_option_menu_get_history".}
proc setHistory*(option_menu: POptionMenu, index: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_option_menu_set_history".}
const 
  bmTGtkPixmapBuildInsensitive* = 0x0001'i16
  bpTGtkPixmapBuildInsensitive* = 0'i16

proc typePixmap*(): GType
proc pixmap*(obj: Pointer): PPixmap
proc pixmapClass*(klass: Pointer): PPixmapClass
proc isPixmap*(obj: Pointer): Bool
proc isPixmapClass*(klass: Pointer): Bool
proc pixmapGetClass*(obj: Pointer): PPixmapClass
proc buildInsensitive*(a: PPixmap): Guint
proc setBuildInsensitive*(a: PPixmap, `build_insensitive`: Guint)
proc pixmapGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_pixmap_get_type".}
proc pixmapNew*(pixmap: gdk2.PPixmap, mask: gdk2.PBitmap): PPixmap{.cdecl, 
    dynlib: lib, importc: "gtk_pixmap_new".}
proc set*(pixmap: PPixmap, val: gdk2.PPixmap, mask: gdk2.PBitmap){.cdecl, 
    dynlib: lib, importc: "gtk_pixmap_set".}
proc get*(pixmap: PPixmap, val: var gdk2.PPixmap, mask: var gdk2.PBitmap){.
    cdecl, dynlib: lib, importc: "gtk_pixmap_get".}
proc setBuildInsensitive*(pixmap: PPixmap, build: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_pixmap_set_build_insensitive".}
const 
  bmTGtkPlugSameApp* = 0x0001'i16
  bpTGtkPlugSameApp* = 0'i16

proc typePlug*(): GType
proc plug*(obj: Pointer): PPlug
proc plugClass*(klass: Pointer): PPlugClass
proc isPlug*(obj: Pointer): Bool
proc isPlugClass*(klass: Pointer): Bool
proc plugGetClass*(obj: Pointer): PPlugClass
proc sameApp*(a: PPlug): Guint
proc setSameApp*(a: PPlug, `same_app`: Guint)
proc plugGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_plug_get_type".}
proc constructForDisplay*(plug: PPlug, display: gdk2.PDisplay, 
                                 socket_id: gdk2.TNativeWindow){.cdecl, 
    dynlib: lib, importc: "gtk_plug_construct_for_display".}
proc plugNewForDisplay*(display: gdk2.PDisplay, socket_id: gdk2.TNativeWindow): PPlug{.
    cdecl, dynlib: lib, importc: "gtk_plug_new_for_display".}
proc getId*(plug: PPlug): gdk2.TNativeWindow{.cdecl, dynlib: lib, 
    importc: "gtk_plug_get_id".}
proc addToSocket*(plug: PPlug, socket: PSocket){.cdecl, dynlib: lib, 
    importc: "_gtk_plug_add_to_socket".}
proc removeFromSocket*(plug: PPlug, socket: PSocket){.cdecl, dynlib: lib, 
    importc: "_gtk_plug_remove_from_socket".}
const 
  bmTGtkPreviewType* = 0x0001'i16
  bpTGtkPreviewType* = 0'i16
  bmTGtkPreviewExpand* = 0x0002'i16
  bpTGtkPreviewExpand* = 1'i16

proc typePreview*(): GType
proc preview*(obj: Pointer): PPreview
proc previewClass*(klass: Pointer): PPreviewClass
proc isPreview*(obj: Pointer): Bool
proc isPreviewClass*(klass: Pointer): Bool
proc previewGetClass*(obj: Pointer): PPreviewClass
proc getType*(a: PPreview): Guint
proc setType*(a: PPreview, `type`: Guint)
proc getExpand*(a: PPreview): Guint
proc setExpand*(a: PPreview, `expand`: Guint)
proc previewGetType*(): TType{.cdecl, dynlib: lib, 
                                 importc: "gtk_preview_get_type".}
proc previewUninit*(){.cdecl, dynlib: lib, importc: "gtk_preview_uninit".}
proc previewNew*(thetype: TPreviewClass): PPreview{.cdecl, dynlib: lib, 
    importc: "gtk_preview_new".}
proc size*(preview: PPreview, width: Gint, height: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_preview_size".}
proc put*(preview: PPreview, window: gdk2.PWindow, gc: gdk2.PGC, srcx: Gint, 
                  srcy: Gint, destx: Gint, desty: Gint, width: Gint, 
                  height: Gint){.cdecl, dynlib: lib, importc: "gtk_preview_put".}
proc drawRow*(preview: PPreview, data: Pguchar, x: Gint, y: Gint, 
                       w: Gint){.cdecl, dynlib: lib, 
                                 importc: "gtk_preview_draw_row".}
proc setExpand*(preview: PPreview, expand: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_preview_set_expand".}
proc previewSetGamma*(gamma: Float64){.cdecl, dynlib: lib, 
    importc: "gtk_preview_set_gamma".}
proc previewSetColorCube*(nred_shades: Guint, ngreen_shades: Guint, 
                             nblue_shades: Guint, ngray_shades: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_preview_set_color_cube".}
proc previewSetInstallCmap*(install_cmap: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_preview_set_install_cmap".}
proc previewSetReserved*(nreserved: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_preview_set_reserved".}
proc setDither*(preview: PPreview, dither: gdk2.TRgbDither){.cdecl, 
    dynlib: lib, importc: "gtk_preview_set_dither".}
proc previewGetInfo*(): PPreviewInfo{.cdecl, dynlib: lib, 
                                        importc: "gtk_preview_get_info".}
proc previewReset*(){.cdecl, dynlib: lib, importc: "gtk_preview_reset".}
const 
  bmTGtkProgressShowText* = 0x0001'i16
  bpTGtkProgressShowText* = 0'i16
  bmTGtkProgressActivityMode* = 0x0002'i16
  bpTGtkProgressActivityMode* = 1'i16
  bmTGtkProgressUseTextFormat* = 0x0004'i16
  bpTGtkProgressUseTextFormat* = 2'i16

proc showText*(a: PProgress): Guint
proc setShowText*(a: PProgress, `show_text`: Guint)
proc activityMode*(a: PProgress): Guint
proc setActivityMode*(a: PProgress, `activity_mode`: Guint)
proc useTextFormat*(a: PProgress): Guint
proc setUseTextFormat*(a: PProgress, `use_text_format`: Guint)
const 
  bmTGtkProgressBarActivityDir* = 0x0001'i16
  bpTGtkProgressBarActivityDir* = 0'i16

proc typeProgressBar*(): GType
proc progressBar*(obj: Pointer): PProgressBar
proc progressBarClass*(klass: Pointer): PProgressBarClass
proc isProgressBar*(obj: Pointer): Bool
proc isProgressBarClass*(klass: Pointer): Bool
proc progressBarGetClass*(obj: Pointer): PProgressBarClass
proc activityDir*(a: PProgressBar): Guint
proc setActivityDir*(a: PProgressBar, `activity_dir`: Guint)
proc progressBarGetType*(): TType{.cdecl, dynlib: lib, 
                                      importc: "gtk_progress_bar_get_type".}
proc progressBarNew*(): PProgressBar{.cdecl, dynlib: lib, 
                                        importc: "gtk_progress_bar_new".}
proc pulse*(pbar: PProgressBar){.cdecl, dynlib: lib, 
    importc: "gtk_progress_bar_pulse".}
proc setText*(pbar: PProgressBar, text: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_progress_bar_set_text".}
proc setFraction*(pbar: PProgressBar, fraction: Gdouble){.cdecl, 
    dynlib: lib, importc: "gtk_progress_bar_set_fraction".}
proc setPulseStep*(pbar: PProgressBar, fraction: Gdouble){.cdecl, 
    dynlib: lib, importc: "gtk_progress_bar_set_pulse_step".}
proc setOrientation*(pbar: PProgressBar, 
                                   orientation: TProgressBarOrientation){.cdecl, 
    dynlib: lib, importc: "gtk_progress_bar_set_orientation".}
proc getText*(pbar: PProgressBar): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_progress_bar_get_text".}
proc getFraction*(pbar: PProgressBar): Gdouble{.cdecl, 
    dynlib: lib, importc: "gtk_progress_bar_get_fraction".}
proc getPulseStep*(pbar: PProgressBar): Gdouble{.cdecl, 
    dynlib: lib, importc: "gtk_progress_bar_get_pulse_step".}
proc getOrientation*(pbar: PProgressBar): TProgressBarOrientation{.
    cdecl, dynlib: lib, importc: "gtk_progress_bar_get_orientation".}
proc typeRadioButton*(): GType
proc radioButton*(obj: Pointer): PRadioButton
proc radioButtonClass*(klass: Pointer): PRadioButtonClass
proc isRadioButton*(obj: Pointer): Bool
proc isRadioButtonClass*(klass: Pointer): Bool
proc radioButtonGetClass*(obj: Pointer): PRadioButtonClass
proc radioButtonGetType*(): TType{.cdecl, dynlib: lib, 
                                      importc: "gtk_radio_button_get_type".}
proc radioButtonNew*(group: PGSList): PRadioButton{.cdecl, dynlib: lib, 
    importc: "gtk_radio_button_new".}
proc newFromWidget*(group: PRadioButton): PRadioButton{.cdecl, 
    dynlib: lib, importc: "gtk_radio_button_new_from_widget".}
proc radioButtonNew*(group: PGSList, `label`: Cstring): PRadioButton{.
    cdecl, dynlib: lib, importc: "gtk_radio_button_new_with_label".}
proc radioButtonNewWithLabelFromWidget*(group: PRadioButton, 
    `label`: Cstring): PRadioButton{.cdecl, dynlib: lib, importc: "gtk_radio_button_new_with_label_from_widget".}
proc radioButtonNewWithMnemonic*(group: PGSList, `label`: Cstring): PRadioButton{.
    cdecl, dynlib: lib, importc: "gtk_radio_button_new_with_mnemonic".}
proc radioButtonNewWithMnemonicFromWidget*(group: PRadioButton, 
    `label`: Cstring): PRadioButton{.cdecl, dynlib: lib, importc: "gtk_radio_button_new_with_mnemonic_from_widget".}
proc getGroup*(radio_button: PRadioButton): PGSList{.cdecl, 
    dynlib: lib, importc: "gtk_radio_button_get_group".}
proc setGroup*(radio_button: PRadioButton, group: PGSList){.cdecl, 
    dynlib: lib, importc: "gtk_radio_button_set_group".}
proc typeRadioMenuItem*(): GType
proc radioMenuItem*(obj: Pointer): PRadioMenuItem
proc radioMenuItemClass*(klass: Pointer): PRadioMenuItemClass
proc isRadioMenuItem*(obj: Pointer): Bool
proc isRadioMenuItemClass*(klass: Pointer): Bool
proc radioMenuItemGetClass*(obj: Pointer): PRadioMenuItemClass
proc radioMenuItemGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_radio_menu_item_get_type".}
proc radioMenuItemNew*(group: PGSList): PRadioMenuItem{.cdecl, dynlib: lib, 
    importc: "gtk_radio_menu_item_new".}
proc radioMenuItemNew*(group: PGSList, `label`: Cstring): PRadioMenuItem{.
    cdecl, dynlib: lib, importc: "gtk_radio_menu_item_new_with_label".}
proc radioMenuItemNewWithMnemonic*(group: PGSList, `label`: Cstring): PRadioMenuItem{.
    cdecl, dynlib: lib, importc: "gtk_radio_menu_item_new_with_mnemonic".}
proc itemGetGroup*(radio_menu_item: PRadioMenuItem): PGSList{.
    cdecl, dynlib: lib, importc: "gtk_radio_menu_item_get_group".}
proc itemSetGroup*(radio_menu_item: PRadioMenuItem, group: PGSList){.
    cdecl, dynlib: lib, importc: "gtk_radio_menu_item_set_group".}
const 
  bmTGtkScrolledWindowHscrollbarPolicy* = 0x0003'i16
  bpTGtkScrolledWindowHscrollbarPolicy* = 0'i16
  bmTGtkScrolledWindowVscrollbarPolicy* = 0x000C'i16
  bpTGtkScrolledWindowVscrollbarPolicy* = 2'i16
  bmTGtkScrolledWindowHscrollbarVisible* = 0x0010'i16
  bpTGtkScrolledWindowHscrollbarVisible* = 4'i16
  bmTGtkScrolledWindowVscrollbarVisible* = 0x0020'i16
  bpTGtkScrolledWindowVscrollbarVisible* = 5'i16
  bmTGtkScrolledWindowWindowPlacement* = 0x00C0'i16
  bpTGtkScrolledWindowWindowPlacement* = 6'i16
  bmTGtkScrolledWindowFocusOut* = 0x0100'i16
  bpTGtkScrolledWindowFocusOut* = 8'i16

proc typeScrolledWindow*(): GType
proc scrolledWindow*(obj: Pointer): PScrolledWindow
proc scrolledWindowClass*(klass: Pointer): PScrolledWindowClass
proc isScrolledWindow*(obj: Pointer): Bool
proc isScrolledWindowClass*(klass: Pointer): Bool
proc scrolledWindowGetClass*(obj: Pointer): PScrolledWindowClass
proc hscrollbarPolicy*(a: PScrolledWindow): Guint
proc setHscrollbarPolicy*(a: PScrolledWindow, `hscrollbar_policy`: Guint)
proc vscrollbarPolicy*(a: PScrolledWindow): Guint
proc setVscrollbarPolicy*(a: PScrolledWindow, `vscrollbar_policy`: Guint)
proc hscrollbarVisible*(a: PScrolledWindow): Guint
proc setHscrollbarVisible*(a: PScrolledWindow, `hscrollbar_visible`: Guint)
proc vscrollbarVisible*(a: PScrolledWindow): Guint
proc setVscrollbarVisible*(a: PScrolledWindow, `vscrollbar_visible`: Guint)
proc windowPlacement*(a: PScrolledWindow): Guint
proc setWindowPlacement*(a: PScrolledWindow, `window_placement`: Guint)
proc focusOut*(a: PScrolledWindow): Guint
proc setFocusOut*(a: PScrolledWindow, `focus_out`: Guint)
proc scrolledWindowGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_scrolled_window_get_type".}
proc scrolledWindowNew*(hadjustment: PAdjustment, vadjustment: PAdjustment): PScrolledWindow{.
    cdecl, dynlib: lib, importc: "gtk_scrolled_window_new".}
proc setHadjustment*(scrolled_window: PScrolledWindow, 
                                      hadjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_scrolled_window_set_hadjustment".}
proc setVadjustment*(scrolled_window: PScrolledWindow, 
                                      hadjustment: PAdjustment){.cdecl, 
    dynlib: lib, importc: "gtk_scrolled_window_set_vadjustment".}
proc getHadjustment*(scrolled_window: PScrolledWindow): PAdjustment{.
    cdecl, dynlib: lib, importc: "gtk_scrolled_window_get_hadjustment".}
proc getVadjustment*(scrolled_window: PScrolledWindow): PAdjustment{.
    cdecl, dynlib: lib, importc: "gtk_scrolled_window_get_vadjustment".}
proc setPolicy*(scrolled_window: PScrolledWindow, 
                                 hscrollbar_policy: TPolicyType, 
                                 vscrollbar_policy: TPolicyType){.cdecl, 
    dynlib: lib, importc: "gtk_scrolled_window_set_policy".}
proc getPolicy*(scrolled_window: PScrolledWindow, 
                                 hscrollbar_policy: PPolicyType, 
                                 vscrollbar_policy: PPolicyType){.cdecl, 
    dynlib: lib, importc: "gtk_scrolled_window_get_policy".}
proc setPlacement*(scrolled_window: PScrolledWindow, 
                                    window_placement: TCornerType){.cdecl, 
    dynlib: lib, importc: "gtk_scrolled_window_set_placement".}
proc getPlacement*(scrolled_window: PScrolledWindow): TCornerType{.
    cdecl, dynlib: lib, importc: "gtk_scrolled_window_get_placement".}
proc setShadowType*(scrolled_window: PScrolledWindow, 
                                      thetype: TShadowType){.cdecl, dynlib: lib, 
    importc: "gtk_scrolled_window_set_shadow_type".}
proc getShadowType*(scrolled_window: PScrolledWindow): TShadowType{.
    cdecl, dynlib: lib, importc: "gtk_scrolled_window_get_shadow_type".}
proc addWithViewport*(scrolled_window: PScrolledWindow, 
                                        child: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_scrolled_window_add_with_viewport".}
proc typeSelectionData*(): GType
proc listNew*(targets: PTargetEntry, ntargets: Guint): PTargetList{.
    cdecl, dynlib: lib, importc: "gtk_target_list_new".}
proc reference*(list: PTargetList){.cdecl, dynlib: lib, 
    importc: "gtk_target_list_ref".}
proc unref*(list: PTargetList){.cdecl, dynlib: lib, 
    importc: "gtk_target_list_unref".}
proc add*(list: PTargetList, target: gdk2.TAtom, flags: Guint, 
                      info: Guint){.cdecl, dynlib: lib, 
                                    importc: "gtk_target_list_add".}
proc addTable*(list: PTargetList, targets: PTargetEntry, 
                            ntargets: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_target_list_add_table".}
proc remove*(list: PTargetList, target: gdk2.TAtom){.cdecl, 
    dynlib: lib, importc: "gtk_target_list_remove".}
proc find*(list: PTargetList, target: gdk2.TAtom, info: Pguint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_target_list_find".}
proc selectionOwnerSet*(widget: PWidget, selection: gdk2.TAtom, time: Guint32): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_selection_owner_set".}
proc selectionOwnerSetForDisplay*(display: gdk2.PDisplay, widget: PWidget, 
                                      selection: gdk2.TAtom, time: Guint32): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_selection_owner_set_for_display".}
proc selectionAddTarget*(widget: PWidget, selection: gdk2.TAtom, 
                           target: gdk2.TAtom, info: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_selection_add_target".}
proc selectionAddTargets*(widget: PWidget, selection: gdk2.TAtom, 
                            targets: PTargetEntry, ntargets: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_selection_add_targets".}
proc selectionClearTargets*(widget: PWidget, selection: gdk2.TAtom){.cdecl, 
    dynlib: lib, importc: "gtk_selection_clear_targets".}
proc selectionConvert*(widget: PWidget, selection: gdk2.TAtom, target: gdk2.TAtom, 
                        time: Guint32): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_selection_convert".}
proc set*(selection_data: PSelectionData, thetype: gdk2.TAtom, 
                         format: Gint, data: Pguchar, length: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_selection_data_set".}
proc setText*(selection_data: PSelectionData, str: Cstring, 
                              len: Gint): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_selection_data_set_text".}
proc getText*(selection_data: PSelectionData): Pguchar{.cdecl, 
    dynlib: lib, importc: "gtk_selection_data_get_text".}
proc targetsIncludeText*(selection_data: PSelectionData): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_selection_data_targets_include_text".}
proc selectionRemoveAll*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_selection_remove_all".}
proc selectionClear*(widget: PWidget, event: gdk2.PEventSelection): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_selection_clear".}
proc selectionRequest*(widget: PWidget, event: gdk2.PEventSelection): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_selection_request".}
proc selectionIncrEvent*(window: gdk2.PWindow, event: gdk2.PEventProperty): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_selection_incr_event".}
proc selectionNotify*(widget: PWidget, event: gdk2.PEventSelection): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_selection_notify".}
proc selectionPropertyNotify*(widget: PWidget, event: gdk2.PEventProperty): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_selection_property_notify".}
proc selectionDataGetType*(): GType{.cdecl, dynlib: lib, 
                                        importc: "gtk_selection_data_get_type".}
proc copy*(data: PSelectionData): PSelectionData{.cdecl, 
    dynlib: lib, importc: "gtk_selection_data_copy".}
proc free*(data: PSelectionData){.cdecl, dynlib: lib, 
    importc: "gtk_selection_data_free".}
proc typeSeparatorMenuItem*(): GType
proc separatorMenuItem*(obj: Pointer): PSeparatorMenuItem
proc separatorMenuItemClass*(klass: Pointer): PSeparatorMenuItemClass
proc isSeparatorMenuItem*(obj: Pointer): Bool
proc isSeparatorMenuItemClass*(klass: Pointer): Bool
proc separatorMenuItemGetClass*(obj: Pointer): PSeparatorMenuItemClass
proc separatorMenuItemGetType*(): GType{.cdecl, dynlib: lib, 
    importc: "gtk_separator_menu_item_get_type".}
proc separatorMenuItemNew*(): PSeparatorMenuItem{.cdecl, dynlib: lib, 
    importc: "gtk_separator_menu_item_new".}
const 
  bmTGtkSizeGroupHaveWidth* = 0x0001'i16
  bpTGtkSizeGroupHaveWidth* = 0'i16
  bmTGtkSizeGroupHaveHeight* = 0x0002'i16
  bpTGtkSizeGroupHaveHeight* = 1'i16

proc typeSizeGroup*(): GType
proc sizeGroup*(obj: Pointer): PSizeGroup
proc sizeGroupClass*(klass: Pointer): PSizeGroupClass
proc isSizeGroup*(obj: Pointer): Bool
proc isSizeGroupClass*(klass: Pointer): Bool
proc sizeGroupGetClass*(obj: Pointer): PSizeGroupClass
proc haveWidth*(a: PSizeGroup): Guint
proc setHaveWidth*(a: PSizeGroup, `have_width`: Guint)
proc haveHeight*(a: PSizeGroup): Guint
proc setHaveHeight*(a: PSizeGroup, `have_height`: Guint)
proc sizeGroupGetType*(): GType{.cdecl, dynlib: lib, 
                                    importc: "gtk_size_group_get_type".}
proc sizeGroupNew*(mode: TSizeGroupMode): PSizeGroup{.cdecl, dynlib: lib, 
    importc: "gtk_size_group_new".}
proc setMode*(size_group: PSizeGroup, mode: TSizeGroupMode){.cdecl, 
    dynlib: lib, importc: "gtk_size_group_set_mode".}
proc getMode*(size_group: PSizeGroup): TSizeGroupMode{.cdecl, 
    dynlib: lib, importc: "gtk_size_group_get_mode".}
proc addWidget*(size_group: PSizeGroup, widget: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_size_group_add_widget".}
proc removeWidget*(size_group: PSizeGroup, widget: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_size_group_remove_widget".}
proc sizeGroupGetChildRequisition*(widget: PWidget, 
                                       requisition: PRequisition){.cdecl, 
    dynlib: lib, importc: "_gtk_size_group_get_child_requisition".}
proc sizeGroupComputeRequisition*(widget: PWidget, requisition: PRequisition){.
    cdecl, dynlib: lib, importc: "_gtk_size_group_compute_requisition".}
proc sizeGroupQueueResize*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "_gtk_size_group_queue_resize".}
const 
  bmTGtkSocketSameApp* = 0x0001'i16
  bpTGtkSocketSameApp* = 0'i16
  bmTGtkSocketFocusIn* = 0x0002'i16
  bpTGtkSocketFocusIn* = 1'i16
  bmTGtkSocketHaveSize* = 0x0004'i16
  bpTGtkSocketHaveSize* = 2'i16
  bmTGtkSocketNeedMap* = 0x0008'i16
  bpTGtkSocketNeedMap* = 3'i16
  bmTGtkSocketIsMapped* = 0x0010'i16
  bpTGtkSocketIsMapped* = 4'i16

proc typeSocket*(): GType
proc socket*(obj: Pointer): PSocket
proc socketClass*(klass: Pointer): PSocketClass
proc isSocket*(obj: Pointer): Bool
proc isSocketClass*(klass: Pointer): Bool
proc socketGetClass*(obj: Pointer): PSocketClass
proc sameApp*(a: PSocket): Guint
proc setSameApp*(a: PSocket, `same_app`: Guint)
proc focusIn*(a: PSocket): Guint
proc setFocusIn*(a: PSocket, `focus_in`: Guint)
proc haveSize*(a: PSocket): Guint
proc setHaveSize*(a: PSocket, `have_size`: Guint)
proc needMap*(a: PSocket): Guint
proc setNeedMap*(a: PSocket, `need_map`: Guint)
proc isMapped*(a: PSocket): Guint
proc setIsMapped*(a: PSocket, `is_mapped`: Guint)
proc socketNew*(): PSocket{.cdecl, dynlib: lib, importc: "gtk_socket_new".}
proc socketGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_socket_get_type".}
proc addId*(socket: PSocket, window_id: gdk2.TNativeWindow){.cdecl, 
    dynlib: lib, importc: "gtk_socket_add_id".}
proc getId*(socket: PSocket): gdk2.TNativeWindow{.cdecl, dynlib: lib, 
    importc: "gtk_socket_get_id".}
const 
  InputError* = - (1)
  bmTGtkSpinButtonInChild* = 0x00000003'i32
  bpTGtkSpinButtonInChild* = 0'i32
  bmTGtkSpinButtonClickChild* = 0x0000000C'i32
  bpTGtkSpinButtonClickChild* = 2'i32
  bmTGtkSpinButtonButton* = 0x00000030'i32
  bpTGtkSpinButtonButton* = 4'i32
  bmTGtkSpinButtonNeedTimer* = 0x00000040'i32
  bpTGtkSpinButtonNeedTimer* = 6'i32
  bmTGtkSpinButtonTimerCalls* = 0x00000380'i32
  bpTGtkSpinButtonTimerCalls* = 7'i32
  bmTGtkSpinButtonDigits* = 0x000FFC00'i32
  bpTGtkSpinButtonDigits* = 10'i32
  bmTGtkSpinButtonNumeric* = 0x00100000'i32
  bpTGtkSpinButtonNumeric* = 20'i32
  bmTGtkSpinButtonWrap* = 0x00200000'i32
  bpTGtkSpinButtonWrap* = 21'i32
  bmTGtkSpinButtonSnapToTicks* = 0x00400000'i32
  bpTGtkSpinButtonSnapToTicks* = 22'i32

proc typeSpinButton*(): GType
proc spinButton*(obj: Pointer): PSpinButton
proc spinButtonClass*(klass: Pointer): PSpinButtonClass
proc isSpinButton*(obj: Pointer): Bool
proc isSpinButtonClass*(klass: Pointer): Bool
proc spinButtonGetClass*(obj: Pointer): PSpinButtonClass
proc inChild*(a: PSpinButton): Guint
proc setInChild*(a: PSpinButton, `in_child`: Guint)
proc clickChild*(a: PSpinButton): Guint
proc setClickChild*(a: PSpinButton, `click_child`: Guint)
proc button*(a: PSpinButton): Guint
proc setButton*(a: PSpinButton, `button`: Guint)
proc needTimer*(a: PSpinButton): Guint
proc setNeedTimer*(a: PSpinButton, `need_timer`: Guint)
proc timerCalls*(a: PSpinButton): Guint
proc setTimerCalls*(a: PSpinButton, `timer_calls`: Guint)
proc digits*(a: PSpinButton): Guint
proc setDigits*(a: PSpinButton, `digits`: Guint)
proc numeric*(a: PSpinButton): Guint
proc setNumeric*(a: PSpinButton, `numeric`: Guint)
proc wrap*(a: PSpinButton): Guint
proc setWrap*(a: PSpinButton, `wrap`: Guint)
proc snapToTicks*(a: PSpinButton): Guint
proc setSnapToTicks*(a: PSpinButton, `snap_to_ticks`: Guint)
proc spinButtonGetType*(): TType{.cdecl, dynlib: lib, 
                                     importc: "gtk_spin_button_get_type".}
proc configure*(spin_button: PSpinButton, adjustment: PAdjustment, 
                            climb_rate: Gdouble, digits: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_configure".}
proc spinButtonNew*(adjustment: PAdjustment, climb_rate: Gdouble, 
                      digits: Guint): PSpinButton{.cdecl, dynlib: lib, 
    importc: "gtk_spin_button_new".}
proc spinButtonNew*(min: Gdouble, max: Gdouble, step: Gdouble): PSpinButton{.
    cdecl, dynlib: lib, importc: "gtk_spin_button_new_with_range".}
proc setAdjustment*(spin_button: PSpinButton, 
                                 adjustment: PAdjustment){.cdecl, dynlib: lib, 
    importc: "gtk_spin_button_set_adjustment".}
proc getAdjustment*(spin_button: PSpinButton): PAdjustment{.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_get_adjustment".}
proc setDigits*(spin_button: PSpinButton, digits: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_set_digits".}
proc getDigits*(spin_button: PSpinButton): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_get_digits".}
proc setIncrements*(spin_button: PSpinButton, step: Gdouble, 
                                 page: Gdouble){.cdecl, dynlib: lib, 
    importc: "gtk_spin_button_set_increments".}
proc getIncrements*(spin_button: PSpinButton, step: Pgdouble, 
                                 page: Pgdouble){.cdecl, dynlib: lib, 
    importc: "gtk_spin_button_get_increments".}
proc setRange*(spin_button: PSpinButton, min: Gdouble, max: Gdouble){.
    cdecl, dynlib: lib, importc: "gtk_spin_button_set_range".}
proc getRange*(spin_button: PSpinButton, min: Pgdouble, 
                            max: Pgdouble){.cdecl, dynlib: lib, 
    importc: "gtk_spin_button_get_range".}
proc getValue*(spin_button: PSpinButton): Gdouble{.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_get_value".}
proc getValueAsInt*(spin_button: PSpinButton): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_get_value_as_int".}
proc setValue*(spin_button: PSpinButton, value: Gdouble){.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_set_value".}
proc setUpdatePolicy*(spin_button: PSpinButton, 
                                    policy: TSpinButtonUpdatePolicy){.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_set_update_policy".}
proc getUpdatePolicy*(spin_button: PSpinButton): TSpinButtonUpdatePolicy{.
    cdecl, dynlib: lib, importc: "gtk_spin_button_get_update_policy".}
proc setNumeric*(spin_button: PSpinButton, numeric: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_spin_button_set_numeric".}
proc getNumeric*(spin_button: PSpinButton): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_get_numeric".}
proc spin*(spin_button: PSpinButton, direction: TSpinType, 
                       increment: Gdouble){.cdecl, dynlib: lib, 
    importc: "gtk_spin_button_spin".}
proc setWrap*(spin_button: PSpinButton, wrap: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_set_wrap".}
proc getWrap*(spin_button: PSpinButton): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_get_wrap".}
proc setSnapToTicks*(spin_button: PSpinButton, 
                                    snap_to_ticks: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_set_snap_to_ticks".}
proc getSnapToTicks*(spin_button: PSpinButton): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_spin_button_get_snap_to_ticks".}
proc update*(spin_button: PSpinButton){.cdecl, dynlib: lib, 
    importc: "gtk_spin_button_update".}
const 
  StockDialogInfo* = "gtk-dialog-info"
  StockDialogWarning* = "gtk-dialog-warning"
  StockDialogError* = "gtk-dialog-error"
  StockDialogQuestion* = "gtk-dialog-question"
  StockDnd* = "gtk-dnd"
  StockDndMultiple* = "gtk-dnd-multiple"
  StockAbout* = "gtk-about"
  STOCKADDName* = "gtk-add"
  StockApply* = "gtk-apply"
  StockBold* = "gtk-bold"
  StockCancel* = "gtk-cancel"
  StockCdrom* = "gtk-cdrom"
  StockClear* = "gtk-clear"
  StockClose* = "gtk-close"
  StockColorPicker* = "gtk-color-picker"
  StockConvert* = "gtk-convert"
  StockConnect* = "gtk-connect"
  StockCopy* = "gtk-copy"
  StockCut* = "gtk-cut"
  StockDelete* = "gtk-delete"
  StockEdit* = "gtk-edit"
  StockExecute* = "gtk-execute"
  StockFind* = "gtk-find"
  StockFindAndReplace* = "gtk-find-and-replace"
  StockFloppy* = "gtk-floppy"
  StockGotoBottom* = "gtk-goto-bottom"
  StockGotoFirst* = "gtk-goto-first"
  StockGotoLast* = "gtk-goto-last"
  StockGotoTop* = "gtk-goto-top"
  StockGoBack* = "gtk-go-back"
  StockGoDown* = "gtk-go-down"
  StockGoForward* = "gtk-go-forward"
  StockGoUp* = "gtk-go-up"
  StockHelp* = "gtk-help"
  StockHome* = "gtk-home"
  StockIndex* = "gtk-index"
  StockItalic* = "gtk-italic"
  StockJumpTo* = "gtk-jump-to"
  StockJustifyCenter* = "gtk-justify-center"
  StockJustifyFill* = "gtk-justify-fill"
  StockJustifyLeft* = "gtk-justify-left"
  StockJustifyRight* = "gtk-justify-right"
  StockMediaForward* = "gtk-media-forward"
  StockMediaNext* = "gtk-media-next"
  StockMediaPause* = "gtk-media-pause"
  StockMediaPlay* = "gtk-media-play"
  StockMediaPrevious* = "gtk-media-previous"
  StockMediaRecord* = "gtk-media-record"
  StockMediaRewind* = "gtk-media-rewind"
  StockMediaStop* = "gtk-media-stop"
  StockMissingImage* = "gtk-missing-image"
  StockNew* = "gtk-new"
  StockNo* = "gtk-no"
  StockOk* = "gtk-ok"
  StockOpen* = "gtk-open"
  StockPaste* = "gtk-paste"
  StockPreferences* = "gtk-preferences"
  StockPrint* = "gtk-print"
  StockPrintPreview* = "gtk-print-preview"
  StockProperties* = "gtk-properties"
  StockQuit* = "gtk-quit"
  StockRedo* = "gtk-redo"
  StockRefresh* = "gtk-refresh"
  StockRemove* = "gtk-remove"
  StockRevertToSaved* = "gtk-revert-to-saved"
  StockSave* = "gtk-save"
  StockSaveAs* = "gtk-save-as"
  StockSelectColor* = "gtk-select-color"
  StockSelectFont* = "gtk-select-font"
  StockSortAscending* = "gtk-sort-ascending"
  StockSortDescending* = "gtk-sort-descending"
  StockSpellCheck* = "gtk-spell-check"
  StockStop* = "gtk-stop"
  StockStrikethrough* = "gtk-strikethrough"
  StockUndelete* = "gtk-undelete"
  StockUnderline* = "gtk-underline"
  StockUndo* = "gtk-undo"
  StockYes* = "gtk-yes"
  StockZoom100* = "gtk-zoom-100"
  StockZoomFit* = "gtk-zoom-fit"
  StockZoomIn* = "gtk-zoom-in"
  StockZoomOut* = "gtk-zoom-out"

proc add*(items: PStockItem, n_items: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_stock_add".}
proc addStatic*(items: PStockItem, n_items: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_stock_add_static".}
proc stockLookup*(stock_id: Cstring, item: PStockItem): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_stock_lookup".}
proc stockListIds*(): PGSList{.cdecl, dynlib: lib, 
                                 importc: "gtk_stock_list_ids".}
proc copy*(item: PStockItem): PStockItem{.cdecl, dynlib: lib, 
    importc: "gtk_stock_item_copy".}
proc free*(item: PStockItem){.cdecl, dynlib: lib, 
    importc: "gtk_stock_item_free".}
proc typeStatusbar*(): GType
proc statusbar*(obj: Pointer): PStatusbar
proc statusbarClass*(klass: Pointer): PStatusbarClass
proc isStatusbar*(obj: Pointer): Bool
proc isStatusbarClass*(klass: Pointer): Bool
proc statusbarGetClass*(obj: Pointer): PStatusbarClass
const 
  bmTGtkStatusbarHasResizeGrip* = 0x0001'i16
  bpTGtkStatusbarHasResizeGrip* = 0'i16

proc hasResizeGrip*(a: PStatusbar): Guint
proc setHasResizeGrip*(a: PStatusbar, `has_resize_grip`: Guint)
proc statusbarGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_statusbar_get_type".}
proc statusbarNew*(): PStatusbar{.cdecl, dynlib: lib, 
                                   importc: "gtk_statusbar_new".}
proc getContextId*(statusbar: PStatusbar, 
                               context_description: Cstring): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_statusbar_get_context_id".}
proc push*(statusbar: PStatusbar, context_id: Guint, text: Cstring): Guint{.
    cdecl, dynlib: lib, importc: "gtk_statusbar_push".}
proc pop*(statusbar: PStatusbar, context_id: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_statusbar_pop".}
proc remove*(statusbar: PStatusbar, context_id: Guint, 
                       message_id: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_statusbar_remove".}
proc setHasResizeGrip*(statusbar: PStatusbar, setting: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_statusbar_set_has_resize_grip".}
proc getHasResizeGrip*(statusbar: PStatusbar): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_statusbar_get_has_resize_grip".}
const 
  bmTGtkTableHomogeneous* = 0x0001'i16
  bpTGtkTableHomogeneous* = 0'i16
  bmTGtkTableChildXexpand* = 0x0001'i16
  bpTGtkTableChildXexpand* = 0'i16
  bmTGtkTableChildYexpand* = 0x0002'i16
  bpTGtkTableChildYexpand* = 1'i16
  bmTGtkTableChildXshrink* = 0x0004'i16
  bpTGtkTableChildXshrink* = 2'i16
  bmTGtkTableChildYshrink* = 0x0008'i16
  bpTGtkTableChildYshrink* = 3'i16
  bmTGtkTableChildXfill* = 0x0010'i16
  bpTGtkTableChildXfill* = 4'i16
  bmTGtkTableChildYfill* = 0x0020'i16
  bpTGtkTableChildYfill* = 5'i16
  bmTGtkTableRowColNeedExpand* = 0x0001'i16
  bpTGtkTableRowColNeedExpand* = 0'i16
  bmTGtkTableRowColNeedShrink* = 0x0002'i16
  bpTGtkTableRowColNeedShrink* = 1'i16
  bmTGtkTableRowColExpand* = 0x0004'i16
  bpTGtkTableRowColExpand* = 2'i16
  bmTGtkTableRowColShrink* = 0x0008'i16
  bpTGtkTableRowColShrink* = 3'i16
  bmTGtkTableRowColEmpty* = 0x0010'i16
  bpTGtkTableRowColEmpty* = 4'i16

proc typeTable*(): GType
proc table*(obj: Pointer): PTable
proc tableClass*(klass: Pointer): PTableClass
proc isTable*(obj: Pointer): Bool
proc isTableClass*(klass: Pointer): Bool
proc tableGetClass*(obj: Pointer): PTableClass
proc homogeneous*(a: PTable): Guint
proc setHomogeneous*(a: PTable, `homogeneous`: Guint)
proc xexpand*(a: PTableChild): Guint
proc setXexpand*(a: PTableChild, `xexpand`: Guint)
proc yexpand*(a: PTableChild): Guint
proc setYexpand*(a: PTableChild, `yexpand`: Guint)
proc xshrink*(a: PTableChild): Guint
proc setXshrink*(a: PTableChild, `xshrink`: Guint)
proc yshrink*(a: PTableChild): Guint
proc setYshrink*(a: PTableChild, `yshrink`: Guint)
proc xfill*(a: PTableChild): Guint
proc setXfill*(a: PTableChild, `xfill`: Guint)
proc yfill*(a: PTableChild): Guint
proc setYfill*(a: PTableChild, `yfill`: Guint)
proc needExpand*(a: PTableRowCol): Guint
proc setNeedExpand*(a: PTableRowCol, `need_expand`: Guint)
proc needShrink*(a: PTableRowCol): Guint
proc setNeedShrink*(a: PTableRowCol, `need_shrink`: Guint)
proc expand*(a: PTableRowCol): Guint
proc setExpand*(a: PTableRowCol, `expand`: Guint)
proc shrink*(a: PTableRowCol): Guint
proc setShrink*(a: PTableRowCol, `shrink`: Guint)
proc empty*(a: PTableRowCol): Guint
proc setEmpty*(a: PTableRowCol, `empty`: Guint)
proc tableGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_table_get_type".}
proc tableNew*(rows: Guint, columns: Guint, homogeneous: Gboolean): PTable{.
    cdecl, dynlib: lib, importc: "gtk_table_new".}
proc resize*(table: PTable, rows: Guint, columns: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_table_resize".}
proc attach*(table: PTable, child: PWidget, left_attach: Guint, 
                   right_attach: Guint, top_attach: Guint, bottom_attach: Guint, 
                   xoptions: TAttachOptions, yoptions: TAttachOptions, 
                   xpadding: Guint, ypadding: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_table_attach".}
proc attachDefaults*(table: PTable, widget: PWidget, left_attach: Guint, 
                            right_attach: Guint, top_attach: Guint, 
                            bottom_attach: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_table_attach_defaults".}
proc setRowSpacing*(table: PTable, row: Guint, spacing: Guint){.cdecl, 
    dynlib: lib, importc: "gtk_table_set_row_spacing".}
proc getRowSpacing*(table: PTable, row: Guint): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_table_get_row_spacing".}
proc setColSpacing*(table: PTable, column: Guint, spacing: Guint){.
    cdecl, dynlib: lib, importc: "gtk_table_set_col_spacing".}
proc getColSpacing*(table: PTable, column: Guint): Guint{.cdecl, 
    dynlib: lib, importc: "gtk_table_get_col_spacing".}
proc setRowSpacings*(table: PTable, spacing: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_table_set_row_spacings".}
proc getDefaultRowSpacing*(table: PTable): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_table_get_default_row_spacing".}
proc setColSpacings*(table: PTable, spacing: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_table_set_col_spacings".}
proc getDefaultColSpacing*(table: PTable): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_table_get_default_col_spacing".}
proc setHomogeneous*(table: PTable, homogeneous: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_table_set_homogeneous".}
proc getHomogeneous*(table: PTable): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_table_get_homogeneous".}
const 
  bmTGtkTearoffMenuItemTornOff* = 0x0001'i16
  bpTGtkTearoffMenuItemTornOff* = 0'i16

proc typeTearoffMenuItem*(): GType
proc tearoffMenuItem*(obj: Pointer): PTearoffMenuItem
proc tearoffMenuItemClass*(klass: Pointer): PTearoffMenuItemClass
proc isTearoffMenuItem*(obj: Pointer): Bool
proc isTearoffMenuItemClass*(klass: Pointer): Bool
proc tearoffMenuItemGetClass*(obj: Pointer): PTearoffMenuItemClass
proc tornOff*(a: PTearoffMenuItem): Guint
proc setTornOff*(a: PTearoffMenuItem, `torn_off`: Guint)
proc tearoffMenuItemGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_tearoff_menu_item_get_type".}
proc tearoffMenuItemNew*(): PTearoffMenuItem{.cdecl, dynlib: lib, 
    importc: "gtk_tearoff_menu_item_new".}
const 
  bmTGtkTextLineWrap* = 0x0001'i16
  bpTGtkTextLineWrap* = 0'i16
  bmTGtkTextWordWrap* = 0x0002'i16
  bpTGtkTextWordWrap* = 1'i16
  bmTGtkTextUseWchar* = 0x0004'i16
  bpTGtkTextUseWchar* = 2'i16

proc typeText*(): GType
proc text*(obj: Pointer): PText
proc textClass*(klass: Pointer): PTextClass
proc isText*(obj: Pointer): Bool
proc isTextClass*(klass: Pointer): Bool
proc textGetClass*(obj: Pointer): PTextClass
proc lineWrap*(a: PText): Guint
proc setLineWrap*(a: PText, `line_wrap`: Guint)
proc wordWrap*(a: PText): Guint
proc setWordWrap*(a: PText, `word_wrap`: Guint)
proc useWchar*(a: PText): Gboolean
proc setUseWchar*(a: PText, `use_wchar`: Gboolean)
proc textGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_text_get_type".}
proc textNew*(hadj: PAdjustment, vadj: PAdjustment): PText{.cdecl, dynlib: lib, 
    importc: "gtk_text_new".}
proc setEditable*(text: PText, editable: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_text_set_editable".}
proc setWordWrap*(text: PText, word_wrap: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_text_set_word_wrap".}
proc setLineWrap*(text: PText, line_wrap: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_text_set_line_wrap".}
proc setAdjustments*(text: PText, hadj: PAdjustment, vadj: PAdjustment){.
    cdecl, dynlib: lib, importc: "gtk_text_set_adjustments".}
proc setPoint*(text: PText, index: Guint){.cdecl, dynlib: lib, 
    importc: "gtk_text_set_point".}
proc getPoint*(text: PText): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_text_get_point".}
proc getLength*(text: PText): Guint{.cdecl, dynlib: lib, 
    importc: "gtk_text_get_length".}
proc freeze*(text: PText){.cdecl, dynlib: lib, importc: "gtk_text_freeze".}
proc thaw*(text: PText){.cdecl, dynlib: lib, importc: "gtk_text_thaw".}
proc insert*(text: PText, font: gdk2.PFont, fore: gdk2.PColor, back: gdk2.PColor, 
                  chars: Cstring, length: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_insert".}
proc backwardDelete*(text: PText, nchars: Guint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_backward_delete".}
proc forwardDelete*(text: PText, nchars: Guint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_forward_delete".}
proc indexWchar*(t: PText, index: Guint): Guint32
proc indexUchar*(t: PText, index: Guint): Guchar
const 
  TextSearchVisibleOnly* = 0
  TextSearchTextOnly* = 1

proc typeTextIter*(): GType
proc getBuffer*(iter: PTextIter): PTextBuffer{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_buffer".}
proc copy*(iter: PTextIter): PTextIter{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_copy".}
proc free*(iter: PTextIter){.cdecl, dynlib: lib, 
                                       importc: "gtk_text_iter_free".}
proc textIterGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "gtk_text_iter_get_type".}
proc getOffset*(iter: PTextIter): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_offset".}
proc getLine*(iter: PTextIter): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_line".}
proc getLineOffset*(iter: PTextIter): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_line_offset".}
proc getLineIndex*(iter: PTextIter): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_line_index".}
proc getVisibleLineOffset*(iter: PTextIter): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_get_visible_line_offset".}
proc getVisibleLineIndex*(iter: PTextIter): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_get_visible_line_index".}
proc getChar*(iter: PTextIter): Gunichar{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_char".}
proc getSlice*(start: PTextIter, theEnd: PTextIter): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_get_slice".}
proc getText*(start: PTextIter, theEnd: PTextIter): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_get_text".}
proc getVisibleSlice*(start: PTextIter, theEnd: PTextIter): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_get_visible_slice".}
proc getVisibleText*(start: PTextIter, theEnd: PTextIter): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_get_visible_text".}
proc getPixbuf*(iter: PTextIter): gdk2pixbuf.PPixbuf{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_pixbuf".}
proc getMarks*(iter: PTextIter): PGSList{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_marks".}
proc getChildAnchor*(iter: PTextIter): PTextChildAnchor{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_get_child_anchor".}
proc getToggledTags*(iter: PTextIter, toggled_on: Gboolean): PGSList{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_get_toggled_tags".}
proc beginsTag*(iter: PTextIter, tag: PTextTag): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_begins_tag".}
proc endsTag*(iter: PTextIter, tag: PTextTag): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_ends_tag".}
proc togglesTag*(iter: PTextIter, tag: PTextTag): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_toggles_tag".}
proc hasTag*(iter: PTextIter, tag: PTextTag): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_has_tag".}
proc getTags*(iter: PTextIter): PGSList{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_tags".}
proc editable*(iter: PTextIter, default_setting: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_editable".}
proc canInsert*(iter: PTextIter, default_editability: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_can_insert".}
proc startsWord*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_starts_word".}
proc endsWord*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_ends_word".}
proc insideWord*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_inside_word".}
proc startsSentence*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_starts_sentence".}
proc endsSentence*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_ends_sentence".}
proc insideSentence*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_inside_sentence".}
proc startsLine*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_starts_line".}
proc endsLine*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_ends_line".}
proc isCursorPosition*(iter: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_is_cursor_position".}
proc getCharsInLine*(iter: PTextIter): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_chars_in_line".}
proc getBytesInLine*(iter: PTextIter): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_get_bytes_in_line".}
proc getAttributes*(iter: PTextIter, values: PTextAttributes): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_get_attributes".}
proc getLanguage*(iter: PTextIter): pango.PLanguage{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_get_language".}
proc isEnd*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_is_end".}
proc isStart*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_is_start".}
proc forwardChar*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_forward_char".}
proc backwardChar*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_backward_char".}
proc forwardChars*(iter: PTextIter, count: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_forward_chars".}
proc backwardChars*(iter: PTextIter, count: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_backward_chars".}
proc forwardLine*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_forward_line".}
proc backwardLine*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_backward_line".}
proc forwardLines*(iter: PTextIter, count: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_forward_lines".}
proc backwardLines*(iter: PTextIter, count: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_backward_lines".}
proc forwardWordEnd*(iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_forward_word_end".}
proc backwardWordStart*(iter: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_backward_word_start".}
proc forwardWordEnds*(iter: PTextIter, count: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_forward_word_ends".}
proc backwardWordStarts*(iter: PTextIter, count: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_backward_word_starts".}
proc forwardSentenceEnd*(iter: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_forward_sentence_end".}
proc backwardSentenceStart*(iter: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_backward_sentence_start".}
proc forwardSentenceEnds*(iter: PTextIter, count: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_forward_sentence_ends".}
proc backwardSentenceStarts*(iter: PTextIter, count: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_backward_sentence_starts".}
proc forwardCursorPosition*(iter: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_forward_cursor_position".}
proc backwardCursorPosition*(iter: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_backward_cursor_position".}
proc forwardCursorPositions*(iter: PTextIter, count: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_forward_cursor_positions".}
proc backwardCursorPositions*(iter: PTextIter, count: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_backward_cursor_positions".}
proc setOffset*(iter: PTextIter, char_offset: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_set_offset".}
proc setLine*(iter: PTextIter, line_number: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_set_line".}
proc setLineOffset*(iter: PTextIter, char_on_line: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_set_line_offset".}
proc setLineIndex*(iter: PTextIter, byte_on_line: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_set_line_index".}
proc forwardToEnd*(iter: PTextIter){.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_forward_to_end".}
proc forwardToLineEnd*(iter: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_forward_to_line_end".}
proc setVisibleLineOffset*(iter: PTextIter, char_on_line: Gint){.
    cdecl, dynlib: lib, importc: "gtk_text_iter_set_visible_line_offset".}
proc setVisibleLineIndex*(iter: PTextIter, byte_on_line: Gint){.
    cdecl, dynlib: lib, importc: "gtk_text_iter_set_visible_line_index".}
proc forwardToTagToggle*(iter: PTextIter, tag: PTextTag): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_forward_to_tag_toggle".}
proc backwardToTagToggle*(iter: PTextIter, tag: PTextTag): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_backward_to_tag_toggle".}
proc forwardFindChar*(iter: PTextIter, pred: TTextCharPredicate, 
                                  user_data: Gpointer, limit: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_forward_find_char".}
proc backwardFindChar*(iter: PTextIter, pred: TTextCharPredicate, 
                                   user_data: Gpointer, limit: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_backward_find_char".}
proc forwardSearch*(iter: PTextIter, str: Cstring, 
                               flags: TTextSearchFlags, match_start: PTextIter, 
                               match_end: PTextIter, limit: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_forward_search".}
proc backwardSearch*(iter: PTextIter, str: Cstring, 
                                flags: TTextSearchFlags, match_start: PTextIter, 
                                match_end: PTextIter, limit: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_backward_search".}
proc equal*(lhs: PTextIter, rhs: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_equal".}
proc compare*(lhs: PTextIter, rhs: PTextIter): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_text_iter_compare".}
proc inRange*(iter: PTextIter, start: PTextIter, theEnd: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_iter_in_range".}
proc order*(first: PTextIter, second: PTextIter){.cdecl, dynlib: lib, 
    importc: "gtk_text_iter_order".}
proc typeTextTag*(): GType
proc textTag*(obj: Pointer): PTextTag
proc textTagClass*(klass: Pointer): PTextTagClass
proc isTextTag*(obj: Pointer): Bool
proc isTextTagClass*(klass: Pointer): Bool
proc textTagGetClass*(obj: Pointer): PTextTagClass
proc typeTextAttributes*(): GType
proc textTagGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "gtk_text_tag_get_type".}
proc textTagNew*(name: Cstring): PTextTag{.cdecl, dynlib: lib, 
    importc: "gtk_text_tag_new".}
proc getPriority*(tag: PTextTag): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_tag_get_priority".}
proc setPriority*(tag: PTextTag, priority: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_tag_set_priority".}
proc event*(tag: PTextTag, event_object: PGObject, event: gdk2.PEvent, 
                     iter: PTextIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_tag_event".}
proc textAttributesNew*(): PTextAttributes{.cdecl, dynlib: lib, 
    importc: "gtk_text_attributes_new".}
proc copy*(src: PTextAttributes): PTextAttributes{.cdecl, 
    dynlib: lib, importc: "gtk_text_attributes_copy".}
proc copyValues*(src: PTextAttributes, dest: PTextAttributes){.
    cdecl, dynlib: lib, importc: "gtk_text_attributes_copy_values".}
proc unref*(values: PTextAttributes){.cdecl, dynlib: lib, 
    importc: "gtk_text_attributes_unref".}
proc reference*(values: PTextAttributes){.cdecl, dynlib: lib, 
    importc: "gtk_text_attributes_ref".}
proc textAttributesGetType*(): GType{.cdecl, dynlib: lib, 
    importc: "gtk_text_attributes_get_type".}
const 
  bmTGtkTextTagBgColorSet* = 0x00000001'i32
  bpTGtkTextTagBgColorSet* = 0'i32
  bmTGtkTextTagBgStippleSet* = 0x00000002'i32
  bpTGtkTextTagBgStippleSet* = 1'i32
  bmTGtkTextTagFgColorSet* = 0x00000004'i32
  bpTGtkTextTagFgColorSet* = 2'i32
  bmTGtkTextTagScaleSet* = 0x00000008'i32
  bpTGtkTextTagScaleSet* = 3'i32
  bmTGtkTextTagFgStippleSet* = 0x00000010'i32
  bpTGtkTextTagFgStippleSet* = 4'i32
  bmTGtkTextTagJustificationSet* = 0x00000020'i32
  bpTGtkTextTagJustificationSet* = 5'i32
  bmTGtkTextTagLeftMarginSet* = 0x00000040'i32
  bpTGtkTextTagLeftMarginSet* = 6'i32
  bmTGtkTextTagIndentSet* = 0x00000080'i32
  bpTGtkTextTagIndentSet* = 7'i32
  bmTGtkTextTagRiseSet* = 0x00000100'i32
  bpTGtkTextTagRiseSet* = 8'i32
  bmTGtkTextTagStrikethroughSet* = 0x00000200'i32
  bpTGtkTextTagStrikethroughSet* = 9'i32
  bmTGtkTextTagRightMarginSet* = 0x00000400'i32
  bpTGtkTextTagRightMarginSet* = 10'i32
  bmTGtkTextTagPixelsAboveLinesSet* = 0x00000800'i32
  bpTGtkTextTagPixelsAboveLinesSet* = 11'i32
  bmTGtkTextTagPixelsBelowLinesSet* = 0x00001000'i32
  bpTGtkTextTagPixelsBelowLinesSet* = 12'i32
  bmTGtkTextTagPixelsInsideWrapSet* = 0x00002000'i32
  bpTGtkTextTagPixelsInsideWrapSet* = 13'i32
  bmTGtkTextTagTabsSet* = 0x00004000'i32
  bpTGtkTextTagTabsSet* = 14'i32
  bmTGtkTextTagUnderlineSet* = 0x00008000'i32
  bpTGtkTextTagUnderlineSet* = 15'i32
  bmTGtkTextTagWrapModeSet* = 0x00010000'i32
  bpTGtkTextTagWrapModeSet* = 16'i32
  bmTGtkTextTagBgFullHeightSet* = 0x00020000'i32
  bpTGtkTextTagBgFullHeightSet* = 17'i32
  bmTGtkTextTagInvisibleSet* = 0x00040000'i32
  bpTGtkTextTagInvisibleSet* = 18'i32
  bmTGtkTextTagEditableSet* = 0x00080000'i32
  bpTGtkTextTagEditableSet* = 19'i32
  bmTGtkTextTagLanguageSet* = 0x00100000'i32
  bpTGtkTextTagLanguageSet* = 20'i32
  bmTGtkTextTagPad1* = 0x00200000'i32
  bpTGtkTextTagPad1* = 21'i32
  bmTGtkTextTagPad2* = 0x00400000'i32
  bpTGtkTextTagPad2* = 22'i32
  bmTGtkTextTagPad3* = 0x00800000'i32
  bpTGtkTextTagPad3* = 23'i32

proc bgColorSet*(a: PTextTag): Guint
proc setBgColorSet*(a: PTextTag, `bg_color_set`: Guint)
proc bgStippleSet*(a: PTextTag): Guint
proc setBgStippleSet*(a: PTextTag, `bg_stipple_set`: Guint)
proc fgColorSet*(a: PTextTag): Guint
proc setFgColorSet*(a: PTextTag, `fg_color_set`: Guint)
proc scaleSet*(a: PTextTag): Guint
proc setScaleSet*(a: PTextTag, `scale_set`: Guint)
proc fgStippleSet*(a: PTextTag): Guint
proc setFgStippleSet*(a: PTextTag, `fg_stipple_set`: Guint)
proc justificationSet*(a: PTextTag): Guint
proc setJustificationSet*(a: PTextTag, `justification_set`: Guint)
proc leftMarginSet*(a: PTextTag): Guint
proc setLeftMarginSet*(a: PTextTag, `left_margin_set`: Guint)
proc indentSet*(a: PTextTag): Guint
proc setIndentSet*(a: PTextTag, `indent_set`: Guint)
proc riseSet*(a: PTextTag): Guint
proc setRiseSet*(a: PTextTag, `rise_set`: Guint)
proc strikethroughSet*(a: PTextTag): Guint
proc setStrikethroughSet*(a: PTextTag, `strikethrough_set`: Guint)
proc rightMarginSet*(a: PTextTag): Guint
proc setRightMarginSet*(a: PTextTag, `right_margin_set`: Guint)
proc pixelsAboveLinesSet*(a: PTextTag): Guint
proc setPixelsAboveLinesSet*(a: PTextTag, 
                                 `pixels_above_lines_set`: Guint)
proc pixelsBelowLinesSet*(a: PTextTag): Guint
proc setPixelsBelowLinesSet*(a: PTextTag, 
                                 `pixels_below_lines_set`: Guint)
proc pixelsInsideWrapSet*(a: PTextTag): Guint
proc setPixelsInsideWrapSet*(a: PTextTag, 
                                 `pixels_inside_wrap_set`: Guint)
proc tabsSet*(a: PTextTag): Guint
proc setTabsSet*(a: PTextTag, `tabs_set`: Guint)
proc underlineSet*(a: PTextTag): Guint
proc setUnderlineSet*(a: PTextTag, `underline_set`: Guint)
proc wrapModeSet*(a: PTextTag): Guint
proc setWrapModeSet*(a: PTextTag, `wrap_mode_set`: Guint)
proc bgFullHeightSet*(a: PTextTag): Guint
proc setBgFullHeightSet*(a: PTextTag, `bg_full_height_set`: Guint)
proc invisibleSet*(a: PTextTag): Guint
proc setInvisibleSet*(a: PTextTag, `invisible_set`: Guint)
proc editableSet*(a: PTextTag): Guint
proc setEditableSet*(a: PTextTag, `editable_set`: Guint)
proc languageSet*(a: PTextTag): Guint
proc setLanguageSet*(a: PTextTag, `language_set`: Guint)
proc pad1*(a: PTextTag): Guint
proc setPad1*(a: PTextTag, `pad1`: Guint)
proc pad2*(a: PTextTag): Guint
proc setPad2*(a: PTextTag, `pad2`: Guint)
proc pad3*(a: PTextTag): Guint
proc setPad3*(a: PTextTag, `pad3`: Guint)
const 
  bmTGtkTextAppearanceUnderline* = 0x000F'i16
  bpTGtkTextAppearanceUnderline* = 0'i16
  bmTGtkTextAppearanceStrikethrough* = 0x0010'i16
  bpTGtkTextAppearanceStrikethrough* = 4'i16
  bmTGtkTextAppearanceDrawBg* = 0x0020'i16
  bpTGtkTextAppearanceDrawBg* = 5'i16
  bmTGtkTextAppearanceInsideSelection* = 0x0040'i16
  bpTGtkTextAppearanceInsideSelection* = 6'i16
  bmTGtkTextAppearanceIsText* = 0x0080'i16
  bpTGtkTextAppearanceIsText* = 7'i16
  bmTGtkTextAppearancePad1* = 0x0100'i16
  bpTGtkTextAppearancePad1* = 8'i16
  bmTGtkTextAppearancePad2* = 0x0200'i16
  bpTGtkTextAppearancePad2* = 9'i16
  bmTGtkTextAppearancePad3* = 0x0400'i16
  bpTGtkTextAppearancePad3* = 10'i16
  bmTGtkTextAppearancePad4* = 0x0800'i16
  bpTGtkTextAppearancePad4* = 11'i16

proc underline*(a: PTextAppearance): Guint
proc setUnderline*(a: PTextAppearance, `underline`: Guint)
proc strikethrough*(a: PTextAppearance): Guint
proc setStrikethrough*(a: PTextAppearance, `strikethrough`: Guint)
proc drawBg*(a: PTextAppearance): Guint
proc setDrawBg*(a: PTextAppearance, `draw_bg`: Guint)
proc insideSelection*(a: PTextAppearance): Guint
proc setInsideSelection*(a: PTextAppearance, `inside_selection`: Guint)
proc isText*(a: PTextAppearance): Guint
proc setIsText*(a: PTextAppearance, `is_text`: Guint)
proc pad1*(a: PTextAppearance): Guint
proc setPad1*(a: PTextAppearance, `pad1`: Guint)
proc pad2*(a: PTextAppearance): Guint
proc setPad2*(a: PTextAppearance, `pad2`: Guint)
proc pad3*(a: PTextAppearance): Guint
proc setPad3*(a: PTextAppearance, `pad3`: Guint)
proc pad4*(a: PTextAppearance): Guint
proc setPad4*(a: PTextAppearance, `pad4`: Guint)
const 
  bmTGtkTextAttributesInvisible* = 0x0001'i16
  bpTGtkTextAttributesInvisible* = 0'i16
  bmTGtkTextAttributesBgFullHeight* = 0x0002'i16
  bpTGtkTextAttributesBgFullHeight* = 1'i16
  bmTGtkTextAttributesEditable* = 0x0004'i16
  bpTGtkTextAttributesEditable* = 2'i16
  bmTGtkTextAttributesRealized* = 0x0008'i16
  bpTGtkTextAttributesRealized* = 3'i16
  bmTGtkTextAttributesPad1* = 0x0010'i16
  bpTGtkTextAttributesPad1* = 4'i16
  bmTGtkTextAttributesPad2* = 0x0020'i16
  bpTGtkTextAttributesPad2* = 5'i16
  bmTGtkTextAttributesPad3* = 0x0040'i16
  bpTGtkTextAttributesPad3* = 6'i16
  bmTGtkTextAttributesPad4* = 0x0080'i16
  bpTGtkTextAttributesPad4* = 7'i16

proc invisible*(a: PTextAttributes): Guint
proc setInvisible*(a: PTextAttributes, `invisible`: Guint)
proc bgFullHeight*(a: PTextAttributes): Guint
proc setBgFullHeight*(a: PTextAttributes, `bg_full_height`: Guint)
proc editable*(a: PTextAttributes): Guint
proc setEditable*(a: PTextAttributes, `editable`: Guint)
proc realized*(a: PTextAttributes): Guint
proc setRealized*(a: PTextAttributes, `realized`: Guint)
proc pad1*(a: PTextAttributes): Guint
proc setPad1*(a: PTextAttributes, `pad1`: Guint)
proc pad2*(a: PTextAttributes): Guint
proc setPad2*(a: PTextAttributes, `pad2`: Guint)
proc pad3*(a: PTextAttributes): Guint
proc setPad3*(a: PTextAttributes, `pad3`: Guint)
proc pad4*(a: PTextAttributes): Guint
proc setPad4*(a: PTextAttributes, `pad4`: Guint)
proc typeTextTagTable*(): GType
proc textTagTable*(obj: Pointer): PTextTagTable
proc textTagTableClass*(klass: Pointer): PTextTagTableClass
proc isTextTagTable*(obj: Pointer): Bool
proc isTextTagTableClass*(klass: Pointer): Bool
proc textTagTableGetClass*(obj: Pointer): PTextTagTableClass
proc textTagTableGetType*(): GType{.cdecl, dynlib: lib, 
                                        importc: "gtk_text_tag_table_get_type".}
proc textTagTableNew*(): PTextTagTable{.cdecl, dynlib: lib, 
    importc: "gtk_text_tag_table_new".}
proc tableAdd*(table: PTextTagTable, tag: PTextTag){.cdecl, 
    dynlib: lib, importc: "gtk_text_tag_table_add".}
proc tableRemove*(table: PTextTagTable, tag: PTextTag){.cdecl, 
    dynlib: lib, importc: "gtk_text_tag_table_remove".}
proc tableLookup*(table: PTextTagTable, name: Cstring): PTextTag{.
    cdecl, dynlib: lib, importc: "gtk_text_tag_table_lookup".}
proc tableForeach*(table: PTextTagTable, fun: TTextTagTableForeach, 
                             data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_text_tag_table_foreach".}
proc tableGetSize*(table: PTextTagTable): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_tag_table_get_size".}
proc tableAddBuffer*(table: PTextTagTable, buffer: Gpointer){.cdecl, 
    dynlib: lib, importc: "_gtk_text_tag_table_add_buffer".}
proc tableRemoveBuffer*(table: PTextTagTable, buffer: Gpointer){.
    cdecl, dynlib: lib, importc: "_gtk_text_tag_table_remove_buffer".}
proc typeTextMark*(): GType
proc textMark*(anObject: Pointer): PTextMark
proc textMarkClass*(klass: Pointer): PTextMarkClass
proc isTextMark*(anObject: Pointer): Bool
proc isTextMarkClass*(klass: Pointer): Bool
proc textMarkGetClass*(obj: Pointer): PTextMarkClass
proc textMarkGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "gtk_text_mark_get_type".}
proc setVisible*(mark: PTextMark, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_text_mark_set_visible".}
proc getVisible*(mark: PTextMark): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_mark_get_visible".}
proc getName*(mark: PTextMark): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_text_mark_get_name".}
proc getDeleted*(mark: PTextMark): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_mark_get_deleted".}
proc getBuffer*(mark: PTextMark): PTextBuffer{.cdecl, dynlib: lib, 
    importc: "gtk_text_mark_get_buffer".}
proc getLeftGravity*(mark: PTextMark): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_mark_get_left_gravity".}
const 
  bmTGtkTextMarkBodyVisible* = 0x0001'i16
  bpTGtkTextMarkBodyVisible* = 0'i16
  bmTGtkTextMarkBodyNotDeleteable* = 0x0002'i16
  bpTGtkTextMarkBodyNotDeleteable* = 1'i16

proc visible*(a: PTextMarkBody): Guint
proc setVisible*(a: PTextMarkBody, `visible`: Guint)
proc notDeleteable*(a: PTextMarkBody): Guint
proc setNotDeleteable*(a: PTextMarkBody, `not_deleteable`: Guint)
proc markSegmentNew*(tree: PTextBTree, left_gravity: Gboolean, name: Cstring): PTextLineSegment{.
    cdecl, dynlib: lib, importc: "_gtk_mark_segment_new".}
proc typeTextChildAnchor*(): GType
proc textChildAnchor*(anObject: Pointer): PTextChildAnchor
proc textChildAnchorClass*(klass: Pointer): PTextChildAnchorClass
proc isTextChildAnchor*(anObject: Pointer): Bool
proc isTextChildAnchorClass*(klass: Pointer): Bool
proc textChildAnchorGetClass*(obj: Pointer): PTextChildAnchorClass
proc textChildAnchorGetType*(): GType{.cdecl, dynlib: lib, 
    importc: "gtk_text_child_anchor_get_type".}
proc textChildAnchorNew*(): PTextChildAnchor{.cdecl, dynlib: lib, 
    importc: "gtk_text_child_anchor_new".}
proc anchorGetWidgets*(anchor: PTextChildAnchor): PGList{.cdecl, 
    dynlib: lib, importc: "gtk_text_child_anchor_get_widgets".}
proc anchorGetDeleted*(anchor: PTextChildAnchor): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_child_anchor_get_deleted".}
proc pixbufSegmentNew*(pixbuf: gdk2pixbuf.PPixbuf): PTextLineSegment{.cdecl, 
    dynlib: lib, importc: "_gtk_pixbuf_segment_new".}
proc widgetSegmentNew*(anchor: PTextChildAnchor): PTextLineSegment{.cdecl, 
    dynlib: lib, importc: "_gtk_widget_segment_new".}
proc widgetSegmentAdd*(widget_segment: PTextLineSegment, child: PWidget){.
    cdecl, dynlib: lib, importc: "_gtk_widget_segment_add".}
proc widgetSegmentRemove*(widget_segment: PTextLineSegment, child: PWidget){.
    cdecl, dynlib: lib, importc: "_gtk_widget_segment_remove".}
proc widgetSegmentRef*(widget_segment: PTextLineSegment){.cdecl, dynlib: lib, 
    importc: "_gtk_widget_segment_ref".}
proc widgetSegmentUnref*(widget_segment: PTextLineSegment){.cdecl, 
    dynlib: lib, importc: "_gtk_widget_segment_unref".}
proc anchoredChildGetLayout*(child: PWidget): PTextLayout{.cdecl, 
    dynlib: lib, importc: "_gtk_anchored_child_get_layout".}
proc lineSegmentSplit*(iter: PTextIter): PTextLineSegment{.cdecl, 
    dynlib: lib, importc: "gtk_text_line_segment_split".}
proc charSegmentNew*(text: Cstring, len: Guint): PTextLineSegment{.cdecl, 
    dynlib: lib, importc: "_gtk_char_segment_new".}
proc charSegmentNewFromTwoStrings*(text1: Cstring, len1: Guint, 
                                        text2: Cstring, len2: Guint): PTextLineSegment{.
    cdecl, dynlib: lib, importc: "_gtk_char_segment_new_from_two_strings".}
proc toggleSegmentNew*(info: PTextTagInfo, StateOn: Gboolean): PTextLineSegment{.
    cdecl, dynlib: lib, importc: "_gtk_toggle_segment_new".}
proc btreeNew*(table: PTextTagTable, buffer: PTextBuffer): PTextBTree{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_new".}
proc reference*(tree: PTextBTree){.cdecl, dynlib: lib, 
                                   importc: "_gtk_text_btree_ref".}
proc unref*(tree: PTextBTree){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_unref".}
proc getBuffer*(tree: PTextBTree): PTextBuffer{.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_get_buffer".}
proc getCharsChangedStamp*(tree: PTextBTree): Guint{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_chars_changed_stamp".}
proc getSegmentsChangedStamp*(tree: PTextBTree): Guint{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_segments_changed_stamp".}
proc segmentsChanged*(tree: PTextBTree){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_segments_changed".}
proc isEnd*(tree: PTextBTree, line: PTextLine, 
                        seg: PTextLineSegment, byte_index: Int32, 
                        char_offset: Int32): Gboolean{.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_is_end".}
proc btreeDelete*(start: PTextIter, theEnd: PTextIter){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_delete".}
proc btreeInsert*(iter: PTextIter, text: Cstring, len: Gint){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_insert".}
proc btreeInsertPixbuf*(iter: PTextIter, pixbuf: gdk2pixbuf.PPixbuf){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_insert_pixbuf".}
proc btreeInsertChildAnchor*(iter: PTextIter, anchor: PTextChildAnchor){.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_insert_child_anchor".}
proc btreeUnregisterChildAnchor*(anchor: PTextChildAnchor){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_unregister_child_anchor".}
proc findLineByY*(tree: PTextBTree, view_id: Gpointer, 
                                ypixel: Gint, line_top_y: Pgint): PTextLine{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_find_line_by_y".}
proc findLineTop*(tree: PTextBTree, line: PTextLine, 
                               view_id: Gpointer): Gint{.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_find_line_top".}
proc addView*(tree: PTextBTree, layout: PTextLayout){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_add_view".}
proc removeView*(tree: PTextBTree, view_id: Gpointer){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_remove_view".}
proc invalidateRegion*(tree: PTextBTree, start: PTextIter, 
                                   theEnd: PTextIter){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_invalidate_region".}
proc getViewSize*(tree: PTextBTree, view_id: Gpointer, 
                               width: Pgint, height: Pgint){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_get_view_size".}
proc isValid*(tree: PTextBTree, view_id: Gpointer): Gboolean{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_is_valid".}
proc validate*(tree: PTextBTree, view_id: Gpointer, max_pixels: Gint, 
                          y: Pgint, old_height: Pgint, new_height: Pgint): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_validate".}
proc validateLine*(tree: PTextBTree, line: PTextLine, 
                               view_id: Gpointer){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_validate_line".}
proc btreeTag*(start: PTextIter, theEnd: PTextIter, tag: PTextTag, 
                     apply: Gboolean){.cdecl, dynlib: lib, 
                                       importc: "_gtk_text_btree_tag".}
proc getLine*(tree: PTextBTree, line_number: Gint, 
                          real_line_number: Pgint): PTextLine{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_line".}
proc getLineNoLast*(tree: PTextBTree, line_number: Gint, 
                                  real_line_number: Pgint): PTextLine{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_line_no_last".}
proc getEndIterLine*(tree: PTextBTree): PTextLine{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_end_iter_line".}
proc getLineAtChar*(tree: PTextBTree, char_index: Gint, 
                                  line_start_index: Pgint, 
                                  real_char_index: Pgint): PTextLine{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_line_at_char".}
proc btreeGetTags*(iter: PTextIter, num_tags: Pgint): PPGtkTextTag{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_get_tags".}
proc btreeGetText*(start: PTextIter, theEnd: PTextIter, 
                          include_hidden: Gboolean, include_nonchars: Gboolean): Cstring{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_get_text".}
proc lineCount*(tree: PTextBTree): Gint{.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_line_count".}
proc charCount*(tree: PTextBTree): Gint{.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_char_count".}
proc btreeCharIsInvisible*(iter: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_char_is_invisible".}
proc getIterAtChar*(tree: PTextBTree, iter: PTextIter, 
                                  char_index: Gint){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_get_iter_at_char".}
proc getIterAtLineChar*(tree: PTextBTree, iter: PTextIter, 
                                       line_number: Gint, char_index: Gint){.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_get_iter_at_line_char".}
proc getIterAtLineByte*(tree: PTextBTree, iter: PTextIter, 
                                       line_number: Gint, byte_index: Gint){.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_get_iter_at_line_byte".}
proc getIterFromString*(tree: PTextBTree, iter: PTextIter, 
                                      `string`: Cstring): Gboolean{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_iter_from_string".}
proc getIterAtMarkName*(tree: PTextBTree, iter: PTextIter, 
                                       mark_name: Cstring): Gboolean{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_iter_at_mark_name".}
proc getIterAtMark*(tree: PTextBTree, iter: PTextIter, 
                                  mark: PTextMark){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_get_iter_at_mark".}
proc getEndIter*(tree: PTextBTree, iter: PTextIter){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_end_iter".}
proc getIterAtLine*(tree: PTextBTree, iter: PTextIter, 
                                  line: PTextLine, byte_offset: Gint){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_iter_at_line".}
proc getIterAtFirstToggle*(tree: PTextBTree, iter: PTextIter, 
    tag: PTextTag): Gboolean{.cdecl, dynlib: lib, importc: "_gtk_text_btree_get_iter_at_first_toggle".}
proc getIterAtLastToggle*(tree: PTextBTree, iter: PTextIter, 
    tag: PTextTag): Gboolean{.cdecl, dynlib: lib, importc: "_gtk_text_btree_get_iter_at_last_toggle".}
proc getIterAtChildAnchor*(tree: PTextBTree, iter: PTextIter, 
    anchor: PTextChildAnchor){.cdecl, dynlib: lib, importc: "_gtk_text_btree_get_iter_at_child_anchor".}
proc setMark*(tree: PTextBTree, existing_mark: PTextMark, 
                          name: Cstring, left_gravity: Gboolean, 
                          index: PTextIter, should_exist: Gboolean): PTextMark{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_set_mark".}
proc removeMarkByName*(tree: PTextBTree, name: Cstring){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_remove_mark_by_name".}
proc removeMark*(tree: PTextBTree, segment: PTextMark){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_remove_mark".}
proc getSelectionBounds*(tree: PTextBTree, start: PTextIter, 
                                      theEnd: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_get_selection_bounds".}
proc placeCursor*(tree: PTextBTree, `where`: PTextIter){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_place_cursor".}
proc markIsInsert*(tree: PTextBTree, segment: PTextMark): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_mark_is_insert".}
proc markIsSelectionBound*(tree: PTextBTree, segment: PTextMark): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_mark_is_selection_bound".}
proc getMarkByName*(tree: PTextBTree, name: Cstring): PTextMark{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_get_mark_by_name".}
proc firstCouldContainTag*(tree: PTextBTree, tag: PTextTag): PTextLine{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_first_could_contain_tag".}
proc lastCouldContainTag*(tree: PTextBTree, tag: PTextTag): PTextLine{.
    cdecl, dynlib: lib, importc: "_gtk_text_btree_last_could_contain_tag".}
const 
  bmTGtkTextLineDataWidth* = 0x00FFFFFF'i32
  bpTGtkTextLineDataWidth* = 0'i32
  bmTGtkTextLineDataValid* = 0xFF000000'i32
  bpTGtkTextLineDataValid* = 24'i32

proc width*(a: PTextLineData): Gint
proc setWidth*(a: PTextLineData, NewWidth: Gint)
proc valid*(a: PTextLineData): Gint
proc setValid*(a: PTextLineData, `valid`: Gint)
proc getNumber*(line: PTextLine): Gint{.cdecl, dynlib: lib, 
    importc: "_gtk_text_line_get_number".}
proc charHasTag*(line: PTextLine, tree: PTextBTree, 
                             char_in_line: Gint, tag: PTextTag): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_text_line_char_has_tag".}
proc byteHasTag*(line: PTextLine, tree: PTextBTree, 
                             byte_in_line: Gint, tag: PTextTag): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_text_line_byte_has_tag".}
proc isLast*(line: PTextLine, tree: PTextBTree): Gboolean{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_is_last".}
proc containsEndIter*(line: PTextLine, tree: PTextBTree): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_text_line_contains_end_iter".}
proc next*(line: PTextLine): PTextLine{.cdecl, dynlib: lib, 
    importc: "_gtk_text_line_next".}
proc nextExcludingLast*(line: PTextLine): PTextLine{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_next_excluding_last".}
proc previous*(line: PTextLine): PTextLine{.cdecl, dynlib: lib, 
    importc: "_gtk_text_line_previous".}
proc addData*(line: PTextLine, data: PTextLineData){.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_add_data".}
proc removeData*(line: PTextLine, view_id: Gpointer): Gpointer{.
    cdecl, dynlib: lib, importc: "_gtk_text_line_remove_data".}
proc getData*(line: PTextLine, view_id: Gpointer): Gpointer{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_get_data".}
proc invalidateWrap*(line: PTextLine, ld: PTextLineData){.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_invalidate_wrap".}
proc charCount*(line: PTextLine): Gint{.cdecl, dynlib: lib, 
    importc: "_gtk_text_line_char_count".}
proc byteCount*(line: PTextLine): Gint{.cdecl, dynlib: lib, 
    importc: "_gtk_text_line_byte_count".}
proc charIndex*(line: PTextLine): Gint{.cdecl, dynlib: lib, 
    importc: "_gtk_text_line_char_index".}
proc byteToSegment*(line: PTextLine, byte_offset: Gint, 
                                seg_offset: Pgint): PTextLineSegment{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_byte_to_segment".}
proc charToSegment*(line: PTextLine, char_offset: Gint, 
                                seg_offset: Pgint): PTextLineSegment{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_char_to_segment".}
proc byteToCharOffsets*(line: PTextLine, byte_offset: Gint, 
                                     line_char_offset: Pgint, 
                                     seg_char_offset: Pgint){.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_byte_to_char_offsets".}
proc charToByteOffsets*(line: PTextLine, char_offset: Gint, 
                                     line_byte_offset: Pgint, 
                                     seg_byte_offset: Pgint){.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_char_to_byte_offsets".}
proc byteToAnySegment*(line: PTextLine, byte_offset: Gint, 
                                    seg_offset: Pgint): PTextLineSegment{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_byte_to_any_segment".}
proc charToAnySegment*(line: PTextLine, char_offset: Gint, 
                                    seg_offset: Pgint): PTextLineSegment{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_char_to_any_segment".}
proc byteToChar*(line: PTextLine, byte_offset: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_byte_to_char".}
proc charToByte*(line: PTextLine, char_offset: Gint): Gint{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_char_to_byte".}
proc nextCouldContainTag*(line: PTextLine, tree: PTextBTree, 
                                       tag: PTextTag): PTextLine{.cdecl, 
    dynlib: lib, importc: "_gtk_text_line_next_could_contain_tag".}
proc previousCouldContainTag*(line: PTextLine, tree: PTextBTree, 
    tag: PTextTag): PTextLine{.cdecl, dynlib: lib, importc: "_gtk_text_line_previous_could_contain_tag".}
proc lineDataNew*(layout: PTextLayout, line: PTextLine): PTextLineData{.
    cdecl, dynlib: lib, importc: "_gtk_text_line_data_new".}
proc check*(tree: PTextBTree){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_check".}
proc spew*(tree: PTextBTree){.cdecl, dynlib: lib, 
    importc: "_gtk_text_btree_spew".}
proc toggleSegmentCheckFunc*(segPtr: PTextLineSegment, line: PTextLine){.
    cdecl, dynlib: lib, importc: "_gtk_toggle_segment_check_func".}
proc changeNodeToggleCount*(node: PTextBTreeNode, info: PTextTagInfo, 
                               delta: Gint){.cdecl, dynlib: lib, 
    importc: "_gtk_change_node_toggle_count".}
proc releaseMarkSegment*(tree: PTextBTree, 
                                      segment: PTextLineSegment){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_release_mark_segment".}
proc notifyWillRemoveTag*(tree: PTextBTree, tag: PTextTag){.cdecl, 
    dynlib: lib, importc: "_gtk_text_btree_notify_will_remove_tag".}
const 
  bmTGtkTextBufferModified* = 0x0001'i16
  bpTGtkTextBufferModified* = 0'i16

proc typeTextBuffer*(): GType
proc textBuffer*(obj: Pointer): PTextBuffer
proc textBufferClass*(klass: Pointer): PTextBufferClass
proc isTextBuffer*(obj: Pointer): Bool
proc isTextBufferClass*(klass: Pointer): Bool
proc textBufferGetClass*(obj: Pointer): PTextBufferClass
proc modified*(a: PTextBuffer): Guint
proc setModified*(a: PTextBuffer, `modified`: Guint)
proc textBufferGetType*(): GType{.cdecl, dynlib: lib, 
                                     importc: "gtk_text_buffer_get_type".}
proc textBufferNew*(table: PTextTagTable): PTextBuffer{.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_new".}
proc getLineCount*(buffer: PTextBuffer): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_get_line_count".}
proc getCharCount*(buffer: PTextBuffer): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_get_char_count".}
proc getTagTable*(buffer: PTextBuffer): PTextTagTable{.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_get_tag_table".}
proc setText*(buffer: PTextBuffer, text: Cstring, len: Gint){.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_set_text".}
proc insert*(buffer: PTextBuffer, iter: PTextIter, text: Cstring, 
                         len: Gint){.cdecl, dynlib: lib, 
                                     importc: "gtk_text_buffer_insert".}
proc insertAtCursor*(buffer: PTextBuffer, text: Cstring, len: Gint){.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_insert_at_cursor".}
proc insertInteractive*(buffer: PTextBuffer, iter: PTextIter, 
                                     text: Cstring, len: Gint, 
                                     default_editable: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_insert_interactive".}
proc insertInteractiveAtCursor*(buffer: PTextBuffer, 
    text: Cstring, len: Gint, default_editable: Gboolean): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_insert_interactive_at_cursor".}
proc insertRange*(buffer: PTextBuffer, iter: PTextIter, 
                               start: PTextIter, theEnd: PTextIter){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_insert_range".}
proc insertRangeInteractive*(buffer: PTextBuffer, iter: PTextIter, 
    start: PTextIter, theEnd: PTextIter, default_editable: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_insert_range_interactive".}
proc delete*(buffer: PTextBuffer, start: PTextIter, 
                         theEnd: PTextIter){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_delete".}
proc deleteInteractive*(buffer: PTextBuffer, start_iter: PTextIter, 
                                     end_iter: PTextIter, 
                                     default_editable: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_delete_interactive".}
proc getText*(buffer: PTextBuffer, start: PTextIter, 
                           theEnd: PTextIter, include_hidden_chars: Gboolean): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_get_text".}
proc getSlice*(buffer: PTextBuffer, start: PTextIter, 
                            theEnd: PTextIter, include_hidden_chars: Gboolean): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_get_slice".}
proc insertPixbuf*(buffer: PTextBuffer, iter: PTextIter, 
                                pixbuf: gdk2pixbuf.PPixbuf){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_insert_pixbuf".}
proc insertChildAnchor*(buffer: PTextBuffer, iter: PTextIter, 
                                      anchor: PTextChildAnchor){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_insert_child_anchor".}
proc createChildAnchor*(buffer: PTextBuffer, iter: PTextIter): PTextChildAnchor{.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_create_child_anchor".}
proc createMark*(buffer: PTextBuffer, mark_name: Cstring, 
                              `where`: PTextIter, left_gravity: Gboolean): PTextMark{.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_create_mark".}
proc moveMark*(buffer: PTextBuffer, mark: PTextMark, 
                            `where`: PTextIter){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_move_mark".}
proc deleteMark*(buffer: PTextBuffer, mark: PTextMark){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_delete_mark".}
proc getMark*(buffer: PTextBuffer, name: Cstring): PTextMark{.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_get_mark".}
proc moveMarkByName*(buffer: PTextBuffer, name: Cstring, 
                                    `where`: PTextIter){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_move_mark_by_name".}
proc deleteMarkByName*(buffer: PTextBuffer, name: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_delete_mark_by_name".}
proc getInsert*(buffer: PTextBuffer): PTextMark{.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_get_insert".}
proc getSelectionBound*(buffer: PTextBuffer): PTextMark{.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_get_selection_bound".}
proc placeCursor*(buffer: PTextBuffer, `where`: PTextIter){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_place_cursor".}
proc applyTag*(buffer: PTextBuffer, tag: PTextTag, 
                            start: PTextIter, theEnd: PTextIter){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_apply_tag".}
proc removeTag*(buffer: PTextBuffer, tag: PTextTag, 
                             start: PTextIter, theEnd: PTextIter){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_remove_tag".}
proc applyTagByName*(buffer: PTextBuffer, name: Cstring, 
                                    start: PTextIter, theEnd: PTextIter){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_apply_tag_by_name".}
proc removeTagByName*(buffer: PTextBuffer, name: Cstring, 
                                     start: PTextIter, theEnd: PTextIter){.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_remove_tag_by_name".}
proc removeAllTags*(buffer: PTextBuffer, start: PTextIter, 
                                  theEnd: PTextIter){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_remove_all_tags".}
proc getIterAtLineOffset*(buffer: PTextBuffer, iter: PTextIter, 
    line_number: Gint, char_offset: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_get_iter_at_line_offset".}
proc getIterAtLineIndex*(buffer: PTextBuffer, iter: PTextIter, 
    line_number: Gint, byte_index: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_get_iter_at_line_index".}
proc getIterAtOffset*(buffer: PTextBuffer, iter: PTextIter, 
                                     char_offset: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_get_iter_at_offset".}
proc getIterAtLine*(buffer: PTextBuffer, iter: PTextIter, 
                                   line_number: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_get_iter_at_line".}
proc getStartIter*(buffer: PTextBuffer, iter: PTextIter){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_get_start_iter".}
proc getEndIter*(buffer: PTextBuffer, iter: PTextIter){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_get_end_iter".}
proc getBounds*(buffer: PTextBuffer, start: PTextIter, 
                             theEnd: PTextIter){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_get_bounds".}
proc getIterAtMark*(buffer: PTextBuffer, iter: PTextIter, 
                                   mark: PTextMark){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_get_iter_at_mark".}
proc getIterAtChildAnchor*(buffer: PTextBuffer, iter: PTextIter, 
    anchor: PTextChildAnchor){.cdecl, dynlib: lib, importc: "gtk_text_buffer_get_iter_at_child_anchor".}
proc getModified*(buffer: PTextBuffer): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_get_modified".}
proc setModified*(buffer: PTextBuffer, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_set_modified".}
proc addSelectionClipboard*(buffer: PTextBuffer, 
    clipboard: PClipboard){.cdecl, dynlib: lib, 
                            importc: "gtk_text_buffer_add_selection_clipboard".}
proc removeSelectionClipboard*(buffer: PTextBuffer, 
    clipboard: PClipboard){.cdecl, dynlib: lib, importc: "gtk_text_buffer_remove_selection_clipboard".}
proc cutClipboard*(buffer: PTextBuffer, clipboard: PClipboard, 
                                default_editable: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_cut_clipboard".}
proc copyClipboard*(buffer: PTextBuffer, clipboard: PClipboard){.
    cdecl, dynlib: lib, importc: "gtk_text_buffer_copy_clipboard".}
proc pasteClipboard*(buffer: PTextBuffer, clipboard: PClipboard, 
                                  override_location: PTextIter, 
                                  default_editable: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_paste_clipboard".}
proc getSelectionBounds*(buffer: PTextBuffer, start: PTextIter, 
                                       theEnd: PTextIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_get_selection_bounds".}
proc deleteSelection*(buffer: PTextBuffer, interactive: Gboolean, 
                                   default_editable: Gboolean): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_buffer_delete_selection".}
proc beginUserAction*(buffer: PTextBuffer){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_begin_user_action".}
proc endUserAction*(buffer: PTextBuffer){.cdecl, dynlib: lib, 
    importc: "gtk_text_buffer_end_user_action".}
proc spew*(buffer: PTextBuffer){.cdecl, dynlib: lib, 
    importc: "_gtk_text_buffer_spew".}
proc getBtree*(buffer: PTextBuffer): PTextBTree{.cdecl, 
    dynlib: lib, importc: "_gtk_text_buffer_get_btree".}
proc getLineLogAttrs*(buffer: PTextBuffer, 
                                     anywhere_in_line: PTextIter, 
                                     char_len: Pgint): pango.PLogAttr{.cdecl, 
    dynlib: lib, importc: "_gtk_text_buffer_get_line_log_attrs".}
proc notifyWillRemoveTag*(buffer: PTextBuffer, tag: PTextTag){.
    cdecl, dynlib: lib, importc: "_gtk_text_buffer_notify_will_remove_tag".}
proc getHasSelection*(buffer: PTextBuffer): Bool {.cdecl,
    dynlib: lib, importc: "gtk_text_buffer_get_has_selection".}
proc selectRange*(buffer: PTextBuffer, ins,
    bound: PTextIter) {.cdecl, dynlib: lib, importc: "gtk_text_buffer_select_range".}
proc backspace*(buffer: PTextBuffer, iter: PTextIter,
    interactive, defaultEditable: Bool): Bool {.cdecl,
    dynlib: lib, importc: "gtk_text_buffer_backspace".}

proc typeTextLayout*(): GType
proc textLayout*(obj: Pointer): PTextLayout
proc textLayoutClass*(klass: Pointer): PTextLayoutClass
proc isTextLayout*(obj: Pointer): Bool
proc isTextLayoutClass*(klass: Pointer): Bool
proc textLayoutGetClass*(obj: Pointer): PTextLayoutClass
const 
  bmTGtkTextLayoutCursorVisible* = 0x0001'i16
  bpTGtkTextLayoutCursorVisible* = 0'i16
  bmTGtkTextLayoutCursorDirection* = 0x0006'i16
  bpTGtkTextLayoutCursorDirection* = 1'i16

proc cursorVisible*(a: PTextLayout): Guint
proc setCursorVisible*(a: PTextLayout, `cursor_visible`: Guint)
proc cursorDirection*(a: PTextLayout): Gint
proc setCursorDirection*(a: PTextLayout, `cursor_direction`: Gint)
const 
  bmTGtkTextCursorDisplayIsStrong* = 0x0001'i16
  bpTGtkTextCursorDisplayIsStrong* = 0'i16
  bmTGtkTextCursorDisplayIsWeak* = 0x0002'i16
  bpTGtkTextCursorDisplayIsWeak* = 1'i16

proc isStrong*(a: PTextCursorDisplay): Guint
proc setIsStrong*(a: PTextCursorDisplay, `is_strong`: Guint)
proc isWeak*(a: PTextCursorDisplay): Guint
proc setIsWeak*(a: PTextCursorDisplay, `is_weak`: Guint)
proc textLayoutGetType*(): GType{.cdecl, dynlib: lib, 
                                     importc: "gtk_text_layout_get_type".}
proc textLayoutNew*(): PTextLayout{.cdecl, dynlib: lib, 
                                      importc: "gtk_text_layout_new".}
proc setBuffer*(layout: PTextLayout, buffer: PTextBuffer){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_set_buffer".}
proc getBuffer*(layout: PTextLayout): PTextBuffer{.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_get_buffer".}
proc setDefaultStyle*(layout: PTextLayout, values: PTextAttributes){.
    cdecl, dynlib: lib, importc: "gtk_text_layout_set_default_style".}
proc setContexts*(layout: PTextLayout, ltr_context: pango.PContext, 
                               rtl_context: pango.PContext){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_set_contexts".}
proc setCursorDirection*(layout: PTextLayout, 
                                       direction: TTextDirection){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_set_cursor_direction".}
proc defaultStyleChanged*(layout: PTextLayout){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_default_style_changed".}
proc setScreenWidth*(layout: PTextLayout, width: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_set_screen_width".}
proc setPreeditString*(layout: PTextLayout, 
                                     preedit_string: Cstring, 
                                     preedit_attrs: pango.PAttrList, 
                                     cursor_pos: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_set_preedit_string".}
proc setCursorVisible*(layout: PTextLayout, 
                                     cursor_visible: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_set_cursor_visible".}
proc getCursorVisible*(layout: PTextLayout): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_get_cursor_visible".}
proc getSize*(layout: PTextLayout, width: Pgint, height: Pgint){.
    cdecl, dynlib: lib, importc: "gtk_text_layout_get_size".}
proc getLines*(layout: PTextLayout, top_y: Gint, bottom_y: Gint, 
                            first_line_y: Pgint): PGSList{.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_get_lines".}
proc wrapLoopStart*(layout: PTextLayout){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_wrap_loop_start".}
proc wrapLoopEnd*(layout: PTextLayout){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_wrap_loop_end".}
proc getLineDisplay*(layout: PTextLayout, line: PTextLine, 
                                   size_only: Gboolean): PTextLineDisplay{.
    cdecl, dynlib: lib, importc: "gtk_text_layout_get_line_display".}
proc freeLineDisplay*(layout: PTextLayout, 
                                    display: PTextLineDisplay){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_free_line_display".}
proc getLineAtY*(layout: PTextLayout, target_iter: PTextIter, 
                                y: Gint, line_top: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_get_line_at_y".}
proc getIterAtPixel*(layout: PTextLayout, iter: PTextIter, 
                                    x: Gint, y: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_get_iter_at_pixel".}
proc invalidate*(layout: PTextLayout, start: PTextIter, 
                             theEnd: PTextIter){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_invalidate".}
proc freeLineData*(layout: PTextLayout, line: PTextLine, 
                                 line_data: PTextLineData){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_free_line_data".}
proc isValid*(layout: PTextLayout): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_is_valid".}
proc validateYrange*(layout: PTextLayout, anchor_line: PTextIter, 
                                  y0: Gint, y1: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_validate_yrange".}
proc validate*(layout: PTextLayout, max_pixels: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_validate".}
proc wrap*(layout: PTextLayout, line: PTextLine, 
                       line_data: PTextLineData): PTextLineData{.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_wrap".}
proc changed*(layout: PTextLayout, y: Gint, old_height: Gint, 
                          new_height: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_changed".}
proc getIterLocation*(layout: PTextLayout, iter: PTextIter, 
                                    rect: gdk2.PRectangle){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_get_iter_location".}
proc getLineYrange*(layout: PTextLayout, iter: PTextIter, 
                                  y: Pgint, height: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_get_line_yrange".}
proc getLineXrange*(layout: PTextLayout, iter: PTextIter, 
                                  x: Pgint, width: Pgint){.cdecl, dynlib: lib, 
    importc: "_gtk_text_layout_get_line_xrange".}
proc getCursorLocations*(layout: PTextLayout, iter: PTextIter, 
                                       strong_pos: gdk2.PRectangle, 
                                       weak_pos: gdk2.PRectangle){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_get_cursor_locations".}
proc clampIterToVrange*(layout: PTextLayout, iter: PTextIter, 
                                       top: Gint, bottom: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_layout_clamp_iter_to_vrange".}
proc moveIterToLineEnd*(layout: PTextLayout, iter: PTextIter, 
                                        direction: Gint): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_move_iter_to_line_end".}
proc moveIterToPreviousLine*(layout: PTextLayout, 
    iter: PTextIter): Gboolean{.cdecl, dynlib: lib, importc: "gtk_text_layout_move_iter_to_previous_line".}
proc moveIterToNextLine*(layout: PTextLayout, iter: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_layout_move_iter_to_next_line".}
proc moveIterToX*(layout: PTextLayout, iter: PTextIter, x: Gint){.
    cdecl, dynlib: lib, importc: "gtk_text_layout_move_iter_to_x".}
proc moveIterVisually*(layout: PTextLayout, iter: PTextIter, 
                                     count: Gint): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_move_iter_visually".}
proc iterStartsLine*(layout: PTextLayout, iter: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_layout_iter_starts_line".}
proc getIterAtLine*(layout: PTextLayout, iter: PTextIter, 
                                   line: PTextLine, byte_offset: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_layout_get_iter_at_line".}
proc anchorRegisterChild*(anchor: PTextChildAnchor, child: PWidget, 
                                       layout: PTextLayout){.cdecl, dynlib: lib, 
    importc: "gtk_text_child_anchor_register_child".}
proc anchorUnregisterChild*(anchor: PTextChildAnchor, 
    child: PWidget){.cdecl, dynlib: lib, 
                     importc: "gtk_text_child_anchor_unregister_child".}
proc anchorQueueResize*(anchor: PTextChildAnchor, 
                                     layout: PTextLayout){.cdecl, dynlib: lib, 
    importc: "gtk_text_child_anchor_queue_resize".}
proc textAnchoredChildSetLayout*(child: PWidget, layout: PTextLayout){.
    cdecl, dynlib: lib, importc: "gtk_text_anchored_child_set_layout".}
proc spew*(layout: PTextLayout){.cdecl, dynlib: lib, 
    importc: "gtk_text_layout_spew".}
const                         # GTK_TEXT_VIEW_PRIORITY_VALIDATE* = GDK_PRIORITY_REDRAW + 5
  bmTGtkTextViewEditable* = 0x0001'i16
  bpTGtkTextViewEditable* = 0'i16
  bmTGtkTextViewOverwriteMode* = 0x0002'i16
  bpTGtkTextViewOverwriteMode* = 1'i16
  bmTGtkTextViewCursorVisible* = 0x0004'i16
  bpTGtkTextViewCursorVisible* = 2'i16
  bmTGtkTextViewNeedImReset* = 0x0008'i16
  bpTGtkTextViewNeedImReset* = 3'i16
  bmTGtkTextViewJustSelectedElement* = 0x0010'i16
  bpTGtkTextViewJustSelectedElement* = 4'i16
  bmTGtkTextViewDisableScrollOnFocus* = 0x0020'i16
  bpTGtkTextViewDisableScrollOnFocus* = 5'i16
  bmTGtkTextViewOnscreenValidated* = 0x0040'i16
  bpTGtkTextViewOnscreenValidated* = 6'i16
  bmTGtkTextViewMouseCursorObscured* = 0x0080'i16
  bpTGtkTextViewMouseCursorObscured* = 7'i16

proc typeTextView*(): GType
proc textView*(obj: Pointer): PTextView
proc textViewClass*(klass: Pointer): PTextViewClass
proc isTextView*(obj: Pointer): Bool
proc isTextViewClass*(klass: Pointer): Bool
proc textViewGetClass*(obj: Pointer): PTextViewClass
proc editable*(a: PTextView): Guint
proc setEditable*(a: PTextView, `editable`: Guint)
proc overwriteMode*(a: PTextView): Guint
proc setOverwriteMode*(a: PTextView, `overwrite_mode`: Guint)
proc cursorVisible*(a: PTextView): Guint
proc setCursorVisible*(a: PTextView, `cursor_visible`: Guint)
proc needImReset*(a: PTextView): Guint
proc setNeedImReset*(a: PTextView, `need_im_reset`: Guint)
proc justSelectedElement*(a: PTextView): Guint
proc setJustSelectedElement*(a: PTextView, `just_selected_element`: Guint)
proc disableScrollOnFocus*(a: PTextView): Guint
proc setDisableScrollOnFocus*(a: PTextView, 
                                  `disable_scroll_on_focus`: Guint)
proc onscreenValidated*(a: PTextView): Guint
proc setOnscreenValidated*(a: PTextView, `onscreen_validated`: Guint)
proc mouseCursorObscured*(a: PTextView): Guint
proc setMouseCursorObscured*(a: PTextView, `mouse_cursor_obscured`: Guint)
proc textViewGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_text_view_get_type".}
proc textViewNew*(): PTextView{.cdecl, dynlib: lib, 
                                  importc: "gtk_text_view_new".}
proc textViewNew*(buffer: PTextBuffer): PTextView{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_new_with_buffer".}
proc setBuffer*(text_view: PTextView, buffer: PTextBuffer){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_buffer".}
proc getBuffer*(text_view: PTextView): PTextBuffer{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_buffer".}
proc scrollToIter*(text_view: PTextView, iter: PTextIter, 
                               within_margin: Gdouble, use_align: Gboolean, 
                               xalign: Gdouble, yalign: Gdouble): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_view_scroll_to_iter".}
proc scrollToMark*(text_view: PTextView, mark: PTextMark, 
                               within_margin: Gdouble, use_align: Gboolean, 
                               xalign: Gdouble, yalign: Gdouble){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_scroll_to_mark".}
proc scrollMarkOnscreen*(text_view: PTextView, mark: PTextMark){.
    cdecl, dynlib: lib, importc: "gtk_text_view_scroll_mark_onscreen".}
proc moveMarkOnscreen*(text_view: PTextView, mark: PTextMark): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_view_move_mark_onscreen".}
proc placeCursorOnscreen*(text_view: PTextView): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_place_cursor_onscreen".}
proc getVisibleRect*(text_view: PTextView, 
                                 visible_rect: gdk2.PRectangle){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_visible_rect".}
proc setCursorVisible*(text_view: PTextView, setting: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_text_view_set_cursor_visible".}
proc getCursorVisible*(text_view: PTextView): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_cursor_visible".}
proc getIterLocation*(text_view: PTextView, iter: PTextIter, 
                                  location: gdk2.PRectangle){.cdecl, dynlib: lib, 
    importc: "gtk_text_view_get_iter_location".}
proc getIterAtLocation*(text_view: PTextView, iter: PTextIter, 
                                     x: Gint, y: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_view_get_iter_at_location".}
proc getLineYrange*(text_view: PTextView, iter: PTextIter, y: Pgint, 
                                height: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_text_view_get_line_yrange".}
proc getLineAtY*(text_view: PTextView, target_iter: PTextIter, 
                              y: Gint, line_top: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_text_view_get_line_at_y".}
proc bufferToWindowCoords*(text_view: PTextView, 
                                        win: TTextWindowType, buffer_x: Gint, 
                                        buffer_y: Gint, window_x: Pgint, 
                                        window_y: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_text_view_buffer_to_window_coords".}
proc windowToBufferCoords*(text_view: PTextView, 
                                        win: TTextWindowType, window_x: Gint, 
                                        window_y: Gint, buffer_x: Pgint, 
                                        buffer_y: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_text_view_window_to_buffer_coords".}
proc getWindow*(text_view: PTextView, win: TTextWindowType): gdk2.PWindow{.
    cdecl, dynlib: lib, importc: "gtk_text_view_get_window".}
proc getWindowType*(text_view: PTextView, window: gdk2.PWindow): TTextWindowType{.
    cdecl, dynlib: lib, importc: "gtk_text_view_get_window_type".}
proc setBorderWindowSize*(text_view: PTextView, 
                                       thetype: TTextWindowType, size: Gint){.
    cdecl, dynlib: lib, importc: "gtk_text_view_set_border_window_size".}
proc getBorderWindowSize*(text_view: PTextView, 
                                       thetype: TTextWindowType): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_border_window_size".}
proc forwardDisplayLine*(text_view: PTextView, iter: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_view_forward_display_line".}
proc backwardDisplayLine*(text_view: PTextView, iter: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_view_backward_display_line".}
proc forwardDisplayLineEnd*(text_view: PTextView, iter: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_view_forward_display_line_end".}
proc backwardDisplayLineStart*(text_view: PTextView, 
    iter: PTextIter): Gboolean{.cdecl, dynlib: lib, importc: "gtk_text_view_backward_display_line_start".}
proc startsDisplayLine*(text_view: PTextView, iter: PTextIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_view_starts_display_line".}
proc moveVisually*(text_view: PTextView, iter: PTextIter, count: Gint): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_text_view_move_visually".}
proc addChildAtAnchor*(text_view: PTextView, child: PWidget, 
                                    anchor: PTextChildAnchor){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_add_child_at_anchor".}
proc addChildInWindow*(text_view: PTextView, child: PWidget, 
                                    which_window: TTextWindowType, xpos: Gint, 
                                    ypos: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_text_view_add_child_in_window".}
proc moveChild*(text_view: PTextView, child: PWidget, xpos: Gint, 
                           ypos: Gint){.cdecl, dynlib: lib, 
                                        importc: "gtk_text_view_move_child".}
proc setWrapMode*(text_view: PTextView, wrap_mode: TWrapMode){.
    cdecl, dynlib: lib, importc: "gtk_text_view_set_wrap_mode".}
proc getWrapMode*(text_view: PTextView): TWrapMode{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_wrap_mode".}
proc setEditable*(text_view: PTextView, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_editable".}
proc getEditable*(text_view: PTextView): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_editable".}
proc setPixelsAboveLines*(text_view: PTextView, 
                                       pixels_above_lines: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_pixels_above_lines".}
proc getPixelsAboveLines*(text_view: PTextView): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_pixels_above_lines".}
proc setPixelsBelowLines*(text_view: PTextView, 
                                       pixels_below_lines: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_pixels_below_lines".}
proc getPixelsBelowLines*(text_view: PTextView): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_pixels_below_lines".}
proc setPixelsInsideWrap*(text_view: PTextView, 
                                       pixels_inside_wrap: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_pixels_inside_wrap".}
proc getPixelsInsideWrap*(text_view: PTextView): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_pixels_inside_wrap".}
proc setJustification*(text_view: PTextView, 
                                  justification: TJustification){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_justification".}
proc getJustification*(text_view: PTextView): TJustification{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_justification".}
proc setLeftMargin*(text_view: PTextView, left_margin: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_left_margin".}
proc getLeftMargin*(text_view: PTextView): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_view_get_left_margin".}
proc setRightMargin*(text_view: PTextView, right_margin: Gint){.
    cdecl, dynlib: lib, importc: "gtk_text_view_set_right_margin".}
proc getRightMargin*(text_view: PTextView): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_right_margin".}
proc setIndent*(text_view: PTextView, indent: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_indent".}
proc getIndent*(text_view: PTextView): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_text_view_get_indent".}
proc setTabs*(text_view: PTextView, tabs: pango.PTabArray){.cdecl, 
    dynlib: lib, importc: "gtk_text_view_set_tabs".}
proc getTabs*(text_view: PTextView): pango.PTabArray{.cdecl, 
    dynlib: lib, importc: "gtk_text_view_get_tabs".}
proc getDefaultAttributes*(text_view: PTextView): PTextAttributes{.
    cdecl, dynlib: lib, importc: "gtk_text_view_get_default_attributes".}
const 
  bmTGtkTipsQueryEmitAlways* = 0x0001'i16
  bpTGtkTipsQueryEmitAlways* = 0'i16
  bmTGtkTipsQueryInQuery* = 0x0002'i16
  bpTGtkTipsQueryInQuery* = 1'i16

proc typeTipsQuery*(): GType
proc tipsQuery*(obj: Pointer): PTipsQuery
proc tipsQueryClass*(klass: Pointer): PTipsQueryClass
proc isTipsQuery*(obj: Pointer): Bool
proc isTipsQueryClass*(klass: Pointer): Bool
proc tipsQueryGetClass*(obj: Pointer): PTipsQueryClass
proc emitAlways*(a: PTipsQuery): Guint
proc setEmitAlways*(a: PTipsQuery, `emit_always`: Guint)
proc inQuery*(a: PTipsQuery): Guint
proc setInQuery*(a: PTipsQuery, `in_query`: Guint)
proc tipsQueryGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_tips_query_get_type".}
proc tipsQueryNew*(): PTipsQuery{.cdecl, dynlib: lib, 
                                    importc: "gtk_tips_query_new".}
proc startQuery*(tips_query: PTipsQuery){.cdecl, dynlib: lib, 
    importc: "gtk_tips_query_start_query".}
proc stopQuery*(tips_query: PTipsQuery){.cdecl, dynlib: lib, 
    importc: "gtk_tips_query_stop_query".}
proc setCaller*(tips_query: PTipsQuery, caller: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_tips_query_set_caller".}
proc setLabels*(tips_query: PTipsQuery, label_inactive: Cstring, 
                            label_no_tip: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_tips_query_set_labels".}
const 
  bmTGtkTooltipsDelay* = 0x3FFFFFFF'i32
  bpTGtkTooltipsDelay* = 0'i32
  bmTGtkTooltipsEnabled* = 0x40000000'i32
  bpTGtkTooltipsEnabled* = 30'i32
  bmTGtkTooltipsHaveGrab* = 0x80000000'i32
  bpTGtkTooltipsHaveGrab* = 31'i32
  bmTGtkTooltipsUseStickyDelay* = 0x00000001'i32
  bpTGtkTooltipsUseStickyDelay* = 0'i32

proc typeTooltips*(): GType
proc tooltips*(obj: Pointer): PTooltips
proc tooltipsClass*(klass: Pointer): PTooltipsClass
proc isTooltips*(obj: Pointer): Bool
proc isTooltipsClass*(klass: Pointer): Bool
proc tooltipsGetClass*(obj: Pointer): PTooltipsClass
proc delay*(a: PTooltips): Guint
proc setDelay*(a: PTooltips, `delay`: Guint)
proc enabled*(a: PTooltips): Guint
proc setEnabled*(a: PTooltips, `enabled`: Guint)
proc haveGrab*(a: PTooltips): Guint
proc setHaveGrab*(a: PTooltips, `have_grab`: Guint)
proc useStickyDelay*(a: PTooltips): Guint
proc setUseStickyDelay*(a: PTooltips, `use_sticky_delay`: Guint)
proc tooltipsGetType*(): TType{.cdecl, dynlib: lib, 
                                  importc: "gtk_tooltips_get_type".}
proc tooltipsNew*(): PTooltips{.cdecl, dynlib: lib, importc: "gtk_tooltips_new".}
proc enable*(tooltips: PTooltips){.cdecl, dynlib: lib, 
    importc: "gtk_tooltips_enable".}
proc disable*(tooltips: PTooltips){.cdecl, dynlib: lib, 
    importc: "gtk_tooltips_disable".}
proc setTip*(tooltips: PTooltips, widget: PWidget, tip_text: Cstring, 
                       tip_private: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_tooltips_set_tip".}
proc tooltipsDataGet*(widget: PWidget): PTooltipsData{.cdecl, dynlib: lib, 
    importc: "gtk_tooltips_data_get".}
proc forceWindow*(tooltips: PTooltips){.cdecl, dynlib: lib, 
    importc: "gtk_tooltips_force_window".}
proc tooltipsToggleKeyboardMode*(widget: PWidget){.cdecl, dynlib: lib, 
    importc: "_gtk_tooltips_toggle_keyboard_mode".}
const 
  bmTGtkToolbarStyleSet* = 0x0001'i16
  bpTGtkToolbarStyleSet* = 0'i16
  bmTGtkToolbarIconSizeSet* = 0x0002'i16
  bpTGtkToolbarIconSizeSet* = 1'i16

proc typeToolbar*(): GType
proc toolbar*(obj: Pointer): PToolbar
proc toolbarClass*(klass: Pointer): PToolbarClass
proc isToolbar*(obj: Pointer): Bool
proc isToolbarClass*(klass: Pointer): Bool
proc toolbarGetClass*(obj: Pointer): PToolbarClass
proc styleSet*(a: PToolbar): Guint
proc setStyleSet*(a: PToolbar, `style_set`: Guint)
proc iconSizeSet*(a: PToolbar): Guint
proc setIconSizeSet*(a: PToolbar, `icon_size_set`: Guint)
proc toolbarGetType*(): TType{.cdecl, dynlib: lib, 
                                 importc: "gtk_toolbar_get_type".}
proc toolbarNew*(): PToolbar{.cdecl, dynlib: lib, importc: "gtk_toolbar_new".}
proc appendItem*(toolbar: PToolbar, text: Cstring, 
                          tooltip_text: Cstring, tooltip_private_text: Cstring, 
                          icon: PWidget, callback: TSignalFunc, 
                          user_data: Gpointer): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_append_item".}
proc prependItem*(toolbar: PToolbar, text: Cstring, 
                           tooltip_text: Cstring, tooltip_private_text: Cstring, 
                           icon: PWidget, callback: TSignalFunc, 
                           user_data: Gpointer): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_prepend_item".}
proc insertItem*(toolbar: PToolbar, text: Cstring, 
                          tooltip_text: Cstring, tooltip_private_text: Cstring, 
                          icon: PWidget, callback: TSignalFunc, 
                          user_data: Gpointer, position: Gint): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_toolbar_insert_item".}
proc insertStock*(toolbar: PToolbar, stock_id: Cstring, 
                           tooltip_text: Cstring, tooltip_private_text: Cstring, 
                           callback: TSignalFunc, user_data: Gpointer, 
                           position: Gint): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_insert_stock".}
proc appendSpace*(toolbar: PToolbar){.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_append_space".}
proc prependSpace*(toolbar: PToolbar){.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_prepend_space".}
proc insertSpace*(toolbar: PToolbar, position: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_toolbar_insert_space".}
proc removeSpace*(toolbar: PToolbar, position: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_toolbar_remove_space".}
proc appendElement*(toolbar: PToolbar, thetype: TToolbarChildType, 
                             widget: PWidget, text: Cstring, 
                             tooltip_text: Cstring, 
                             tooltip_private_text: Cstring, icon: PWidget, 
                             callback: TSignalFunc, user_data: Gpointer): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_toolbar_append_element".}
proc prependElement*(toolbar: PToolbar, thetype: TToolbarChildType, 
                              widget: PWidget, text: Cstring, 
                              tooltip_text: Cstring, 
                              tooltip_private_text: Cstring, icon: PWidget, 
                              callback: TSignalFunc, user_data: Gpointer): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_toolbar_prepend_element".}
proc insertElement*(toolbar: PToolbar, thetype: TToolbarChildType, 
                             widget: PWidget, text: Cstring, 
                             tooltip_text: Cstring, 
                             tooltip_private_text: Cstring, icon: PWidget, 
                             callback: TSignalFunc, user_data: Gpointer, 
                             position: Gint): PWidget{.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_insert_element".}
proc appendWidget*(toolbar: PToolbar, widget: PWidget, 
                            tooltip_text: Cstring, tooltip_private_text: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_toolbar_append_widget".}
proc prependWidget*(toolbar: PToolbar, widget: PWidget, 
                             tooltip_text: Cstring, 
                             tooltip_private_text: Cstring){.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_prepend_widget".}
proc insertWidget*(toolbar: PToolbar, widget: PWidget, 
                            tooltip_text: Cstring, 
                            tooltip_private_text: Cstring, position: Gint){.
    cdecl, dynlib: lib, importc: "gtk_toolbar_insert_widget".}
proc setOrientation*(toolbar: PToolbar, orientation: TOrientation){.
    cdecl, dynlib: lib, importc: "gtk_toolbar_set_orientation".}
proc setStyle*(toolbar: PToolbar, style: TToolbarStyle){.cdecl, 
    dynlib: lib, importc: "gtk_toolbar_set_style".}
proc setIconSize*(toolbar: PToolbar, icon_size: TIconSize){.cdecl, 
    dynlib: lib, importc: "gtk_toolbar_set_icon_size".}
proc setTooltips*(toolbar: PToolbar, enable: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_toolbar_set_tooltips".}
proc unsetStyle*(toolbar: PToolbar){.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_unset_style".}
proc unsetIconSize*(toolbar: PToolbar){.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_unset_icon_size".}
proc getOrientation*(toolbar: PToolbar): TOrientation{.cdecl, 
    dynlib: lib, importc: "gtk_toolbar_get_orientation".}
proc getStyle*(toolbar: PToolbar): TToolbarStyle{.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_get_style".}
proc getIconSize*(toolbar: PToolbar): TIconSize{.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_get_icon_size".}
proc getTooltips*(toolbar: PToolbar): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_toolbar_get_tooltips".}
const 
  bmTGtkTreeSelectionMode* = 0x0003'i16
  bpTGtkTreeSelectionMode* = 0'i16
  bmTGtkTreeViewMode* = 0x0004'i16
  bpTGtkTreeViewMode* = 2'i16
  bmTGtkTreeViewLine* = 0x0008'i16
  bpTGtkTreeViewLine* = 3'i16

proc typeTree*(): GType
proc tree*(obj: Pointer): PTree
proc treeClass*(klass: Pointer): PTreeClass
proc isTree*(obj: Pointer): Bool
proc isTreeClass*(klass: Pointer): Bool
proc treeGetClass*(obj: Pointer): PTreeClass
proc isRootTree*(obj: Pointer): Bool
proc treeRootTree*(obj: Pointer): PTree
proc treeSelectionOld*(obj: Pointer): PGList
proc selectionMode*(a: PTree): Guint
proc setSelectionMode*(a: PTree, `selection_mode`: Guint)
proc viewMode*(a: PTree): Guint
proc setViewMode*(a: PTree, `view_mode`: Guint)
proc viewLine*(a: PTree): Guint
proc setViewLine*(a: PTree, `view_line`: Guint)
proc treeGetType*(): TType{.cdecl, dynlib: lib, importc: "gtk_tree_get_type".}
proc treeNew*(): PTree{.cdecl, dynlib: lib, importc: "gtk_tree_new".}
proc append*(tree: PTree, tree_item: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_tree_append".}
proc prepend*(tree: PTree, tree_item: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_tree_prepend".}
proc insert*(tree: PTree, tree_item: PWidget, position: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_tree_insert".}
proc removeItems*(tree: PTree, items: PGList){.cdecl, dynlib: lib, 
    importc: "gtk_tree_remove_items".}
proc clearItems*(tree: PTree, start: Gint, theEnd: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_tree_clear_items".}
proc selectItem*(tree: PTree, item: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_select_item".}
proc unselectItem*(tree: PTree, item: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_unselect_item".}
proc selectChild*(tree: PTree, tree_item: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_tree_select_child".}
proc unselectChild*(tree: PTree, tree_item: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_tree_unselect_child".}
proc childPosition*(tree: PTree, child: PWidget): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_tree_child_position".}
proc setSelectionMode*(tree: PTree, mode: TSelectionMode){.cdecl, 
    dynlib: lib, importc: "gtk_tree_set_selection_mode".}
proc setViewMode*(tree: PTree, mode: TTreeViewMode){.cdecl, dynlib: lib, 
    importc: "gtk_tree_set_view_mode".}
proc setViewLines*(tree: PTree, flag: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_tree_set_view_lines".}
proc removeItem*(tree: PTree, child: PWidget){.cdecl, dynlib: lib, 
    importc: "gtk_tree_remove_item".}
proc typeTreeDragSource*(): GType
proc treeDragSource*(obj: Pointer): PTreeDragSource
proc isTreeDragSource*(obj: Pointer): Bool
proc treeDragSourceGetIface*(obj: Pointer): PTreeDragSourceIface
proc treeDragSourceGetType*(): GType{.cdecl, dynlib: lib, 
    importc: "gtk_tree_drag_source_get_type".}
proc sourceRowDraggable*(drag_source: PTreeDragSource, 
                                     path: PTreePath): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_drag_source_row_draggable".}
proc sourceDragDataDelete*(drag_source: PTreeDragSource, 
                                        path: PTreePath): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_drag_source_drag_data_delete".}
proc sourceDragDataGet*(drag_source: PTreeDragSource, 
                                     path: PTreePath, 
                                     selection_data: PSelectionData): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_drag_source_drag_data_get".}
proc typeTreeDragDest*(): GType
proc treeDragDest*(obj: Pointer): PTreeDragDest
proc isTreeDragDest*(obj: Pointer): Bool
proc treeDragDestGetIface*(obj: Pointer): PTreeDragDestIface
proc treeDragDestGetType*(): GType{.cdecl, dynlib: lib, 
                                        importc: "gtk_tree_drag_dest_get_type".}
proc destDragDataReceived*(drag_dest: PTreeDragDest, 
                                        dest: PTreePath, 
                                        selection_data: PSelectionData): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_drag_dest_drag_data_received".}
proc destRowDropPossible*(drag_dest: PTreeDragDest, 
                                       dest_path: PTreePath, 
                                       selection_data: PSelectionData): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_drag_dest_row_drop_possible".}
proc treeSetRowDragData*(selection_data: PSelectionData, 
                             tree_model: PTreeModel, path: PTreePath): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_set_row_drag_data".}
const 
  bmTGtkTreeItemExpanded* = 0x0001'i16
  bpTGtkTreeItemExpanded* = 0'i16

proc typeTreeItem*(): GType
proc treeItem*(obj: Pointer): PTreeItem
proc treeItemClass*(klass: Pointer): PTreeItemClass
proc isTreeItem*(obj: Pointer): Bool
proc isTreeItemClass*(klass: Pointer): Bool
proc treeItemGetClass*(obj: Pointer): PTreeItemClass
proc treeItemSubtree*(obj: Pointer): PWidget
proc expanded*(a: PTreeItem): Guint
proc setExpanded*(a: PTreeItem, `expanded`: Guint)
proc treeItemGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_tree_item_get_type".}
proc treeItemNew*(): PTreeItem{.cdecl, dynlib: lib, 
                                  importc: "gtk_tree_item_new".}
proc treeItemNew*(`label`: Cstring): PTreeItem{.cdecl, dynlib: lib, 
    importc: "gtk_tree_item_new_with_label".}
proc setSubtree*(tree_item: PTreeItem, subtree: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_tree_item_set_subtree".}
proc removeSubtree*(tree_item: PTreeItem){.cdecl, dynlib: lib, 
    importc: "gtk_tree_item_remove_subtree".}
proc select*(tree_item: PTreeItem){.cdecl, dynlib: lib, 
    importc: "gtk_tree_item_select".}
proc deselect*(tree_item: PTreeItem){.cdecl, dynlib: lib, 
    importc: "gtk_tree_item_deselect".}
proc expand*(tree_item: PTreeItem){.cdecl, dynlib: lib, 
    importc: "gtk_tree_item_expand".}
proc collapse*(tree_item: PTreeItem){.cdecl, dynlib: lib, 
    importc: "gtk_tree_item_collapse".}
proc typeTreeSelection*(): GType
proc treeSelection*(obj: Pointer): PTreeSelection
proc treeSelectionClass*(klass: Pointer): PTreeSelectionClass
proc isTreeSelection*(obj: Pointer): Bool
proc isTreeSelectionClass*(klass: Pointer): Bool
proc treeSelectionGetClass*(obj: Pointer): PTreeSelectionClass
proc treeSelectionGetType*(): TType{.cdecl, dynlib: lib, 
                                        importc: "gtk_tree_selection_get_type".}
proc setMode*(selection: PTreeSelection, thetype: TSelectionMode){.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_set_mode".}
proc getMode*(selection: PTreeSelection): TSelectionMode{.cdecl, 
    dynlib: lib, importc: "gtk_tree_selection_get_mode".}
proc setSelectFunction*(selection: PTreeSelection, 
    fun: TTreeSelectionFunc, data: Gpointer, destroy: TDestroyNotify){.cdecl, 
    dynlib: lib, importc: "gtk_tree_selection_set_select_function".}
proc getUserData*(selection: PTreeSelection): Gpointer{.cdecl, 
    dynlib: lib, importc: "gtk_tree_selection_get_user_data".}
proc getTreeView*(selection: PTreeSelection): PTreeView{.cdecl, 
    dynlib: lib, importc: "gtk_tree_selection_get_tree_view".}
proc getSelected*(selection: PTreeSelection, 
                                  model: PPGtkTreeModel, iter: PTreeIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_get_selected".}
proc getSelectedRows*(selection: PTreeSelection, 
                                       model: PPGtkTreeModel): PGList{.cdecl, 
    dynlib: lib, importc: "gtk_tree_selection_get_selected_rows".}
proc selectedForeach*(selection: PTreeSelection, 
                                      fun: TTreeSelectionForeachFunc, 
                                      data: Gpointer){.cdecl, dynlib: lib, 
    importc: "gtk_tree_selection_selected_foreach".}
proc selectPath*(selection: PTreeSelection, path: PTreePath){.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_select_path".}
proc unselectPath*(selection: PTreeSelection, path: PTreePath){.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_unselect_path".}
proc selectIter*(selection: PTreeSelection, iter: PTreeIter){.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_select_iter".}
proc unselectIter*(selection: PTreeSelection, iter: PTreeIter){.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_unselect_iter".}
proc pathIsSelected*(selection: PTreeSelection, path: PTreePath): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_path_is_selected".}
proc iterIsSelected*(selection: PTreeSelection, iter: PTreeIter): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_iter_is_selected".}
proc selectAll*(selection: PTreeSelection){.cdecl, dynlib: lib, 
    importc: "gtk_tree_selection_select_all".}
proc unselectAll*(selection: PTreeSelection){.cdecl, 
    dynlib: lib, importc: "gtk_tree_selection_unselect_all".}
proc selectRange*(selection: PTreeSelection, 
                                  start_path: PTreePath, end_path: PTreePath){.
    cdecl, dynlib: lib, importc: "gtk_tree_selection_select_range".}
const 
  bmTGtkTreeStoreColumnsDirty* = 0x0001'i16
  bpTGtkTreeStoreColumnsDirty* = 0'i16

proc typeTreeStore*(): GType
proc treeStore*(obj: Pointer): PTreeStore
proc treeStoreClass*(klass: Pointer): PTreeStoreClass
proc isTreeStore*(obj: Pointer): Bool
proc isTreeStoreClass*(klass: Pointer): Bool
proc treeStoreGetClass*(obj: Pointer): PTreeStoreClass
proc columnsDirty*(a: PTreeStore): Guint
proc setColumnsDirty*(a: PTreeStore, `columns_dirty`: Guint)
proc treeStoreGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_tree_store_get_type".}
proc treeStoreNewv*(n_columns: Gint, types: PGType): PTreeStore{.cdecl, 
    dynlib: lib, importc: "gtk_tree_store_newv".}
proc setColumnTypes*(tree_store: PTreeStore, n_columns: Gint, 
                                  types: PGType){.cdecl, dynlib: lib, 
    importc: "gtk_tree_store_set_column_types".}
proc setValue*(tree_store: PTreeStore, iter: PTreeIter, 
                           column: Gint, value: PGValue){.cdecl, dynlib: lib, 
    importc: "gtk_tree_store_set_value".}
proc remove*(tree_store: PTreeStore, iter: PTreeIter){.cdecl, 
    dynlib: lib, importc: "gtk_tree_store_remove".}
proc insert*(tree_store: PTreeStore, iter: PTreeIter, 
                        parent: PTreeIter, position: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_store_insert".}
proc insertBefore*(tree_store: PTreeStore, iter: PTreeIter, 
                               parent: PTreeIter, sibling: PTreeIter){.cdecl, 
    dynlib: lib, importc: "gtk_tree_store_insert_before".}
proc insertAfter*(tree_store: PTreeStore, iter: PTreeIter, 
                              parent: PTreeIter, sibling: PTreeIter){.cdecl, 
    dynlib: lib, importc: "gtk_tree_store_insert_after".}
proc prepend*(tree_store: PTreeStore, iter: PTreeIter, 
                         parent: PTreeIter){.cdecl, dynlib: lib, 
    importc: "gtk_tree_store_prepend".}
proc append*(tree_store: PTreeStore, iter: PTreeIter, 
                        parent: PTreeIter){.cdecl, dynlib: lib, 
    importc: "gtk_tree_store_append".}
proc isAncestor*(tree_store: PTreeStore, iter: PTreeIter, 
                             descendant: PTreeIter): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_store_is_ancestor".}
proc iterDepth*(tree_store: PTreeStore, iter: PTreeIter): Gint{.
    cdecl, dynlib: lib, importc: "gtk_tree_store_iter_depth".}
proc clear*(tree_store: PTreeStore){.cdecl, dynlib: lib, 
    importc: "gtk_tree_store_clear".}
const 
  bmTGtkTreeViewColumnVisible* = 0x0001'i16
  bpTGtkTreeViewColumnVisible* = 0'i16
  bmTGtkTreeViewColumnResizable* = 0x0002'i16
  bpTGtkTreeViewColumnResizable* = 1'i16
  bmTGtkTreeViewColumnClickable* = 0x0004'i16
  bpTGtkTreeViewColumnClickable* = 2'i16
  bmTGtkTreeViewColumnDirty* = 0x0008'i16
  bpTGtkTreeViewColumnDirty* = 3'i16
  bmTGtkTreeViewColumnShowSortIndicator* = 0x0010'i16
  bpTGtkTreeViewColumnShowSortIndicator* = 4'i16
  bmTGtkTreeViewColumnMaybeReordered* = 0x0020'i16
  bpTGtkTreeViewColumnMaybeReordered* = 5'i16
  bmTGtkTreeViewColumnReorderable* = 0x0040'i16
  bpTGtkTreeViewColumnReorderable* = 6'i16
  bmTGtkTreeViewColumnUseResizedWidth* = 0x0080'i16
  bpTGtkTreeViewColumnUseResizedWidth* = 7'i16

proc typeTreeViewColumn*(): GType
proc treeViewColumn*(obj: Pointer): PTreeViewColumn
proc treeViewColumnClass*(klass: Pointer): PTreeViewColumnClass
proc isTreeViewColumn*(obj: Pointer): Bool
proc isTreeViewColumnClass*(klass: Pointer): Bool
proc treeViewColumnGetClass*(obj: Pointer): PTreeViewColumnClass
proc visible*(a: PTreeViewColumn): Guint
proc setVisible*(a: PTreeViewColumn, `visible`: Guint)
proc resizable*(a: PTreeViewColumn): Guint
proc setResizable*(a: PTreeViewColumn, `resizable`: Guint)
proc clickable*(a: PTreeViewColumn): Guint
proc setClickable*(a: PTreeViewColumn, `clickable`: Guint)
proc dirty*(a: PTreeViewColumn): Guint
proc setDirty*(a: PTreeViewColumn, `dirty`: Guint)
proc showSortIndicator*(a: PTreeViewColumn): Guint
proc setShowSortIndicator*(a: PTreeViewColumn, 
                              `show_sort_indicator`: Guint)
proc maybeReordered*(a: PTreeViewColumn): Guint
proc setMaybeReordered*(a: PTreeViewColumn, `maybe_reordered`: Guint)
proc reorderable*(a: PTreeViewColumn): Guint
proc setReorderable*(a: PTreeViewColumn, `reorderable`: Guint)
proc useResizedWidth*(a: PTreeViewColumn): Guint
proc setUseResizedWidth*(a: PTreeViewColumn, `use_resized_width`: Guint)
proc treeViewColumnGetType*(): TType{.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_get_type".}
proc treeViewColumnNew*(): PTreeViewColumn{.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_new".}
proc columnPackStart*(tree_column: PTreeViewColumn, 
                                  cell: PCellRenderer, expand: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_pack_start".}
proc columnPackEnd*(tree_column: PTreeViewColumn, 
                                cell: PCellRenderer, expand: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_pack_end".}
proc columnClear*(tree_column: PTreeViewColumn){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_clear".}
proc columnGetCellRenderers*(tree_column: PTreeViewColumn): PGList{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_cell_renderers".}
proc columnAddAttribute*(tree_column: PTreeViewColumn, 
                                     cell_renderer: PCellRenderer, 
                                     attribute: Cstring, column: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_add_attribute".}
proc columnSetCellDataFunc*(tree_column: PTreeViewColumn, 
    cell_renderer: PCellRenderer, fun: TTreeCellDataFunc, func_data: Gpointer, 
    destroy: TDestroyNotify){.cdecl, dynlib: lib, importc: "gtk_tree_view_column_set_cell_data_func".}
proc columnClearAttributes*(tree_column: PTreeViewColumn, 
                                        cell_renderer: PCellRenderer){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_clear_attributes".}
proc columnSetSpacing*(tree_column: PTreeViewColumn, spacing: Gint){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_set_spacing".}
proc columnGetSpacing*(tree_column: PTreeViewColumn): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_get_spacing".}
proc columnSetVisible*(tree_column: PTreeViewColumn, 
                                   visible: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_set_visible".}
proc columnGetVisible*(tree_column: PTreeViewColumn): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_visible".}
proc columnSetResizable*(tree_column: PTreeViewColumn, 
                                     resizable: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_set_resizable".}
proc columnGetResizable*(tree_column: PTreeViewColumn): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_resizable".}
proc columnSetSizing*(tree_column: PTreeViewColumn, 
                                  thetype: TTreeViewColumnSizing){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_set_sizing".}
proc columnGetSizing*(tree_column: PTreeViewColumn): TTreeViewColumnSizing{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_sizing".}
proc columnGetWidth*(tree_column: PTreeViewColumn): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_get_width".}
proc columnGetFixedWidth*(tree_column: PTreeViewColumn): Gint{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_fixed_width".}
proc columnSetFixedWidth*(tree_column: PTreeViewColumn, 
                                       fixed_width: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_set_fixed_width".}
proc columnSetMinWidth*(tree_column: PTreeViewColumn, 
                                     min_width: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_set_min_width".}
proc columnGetMinWidth*(tree_column: PTreeViewColumn): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_get_min_width".}
proc columnSetMaxWidth*(tree_column: PTreeViewColumn, 
                                     max_width: Gint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_set_max_width".}
proc columnGetMaxWidth*(tree_column: PTreeViewColumn): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_get_max_width".}
proc columnClicked*(tree_column: PTreeViewColumn){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_clicked".}
proc columnSetTitle*(tree_column: PTreeViewColumn, title: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_set_title".}
proc columnGetTitle*(tree_column: PTreeViewColumn): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_get_title".}
proc columnSetClickable*(tree_column: PTreeViewColumn, 
                                     clickable: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_set_clickable".}
proc columnGetClickable*(tree_column: PTreeViewColumn): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_clickable".}
proc columnSetWidget*(tree_column: PTreeViewColumn, widget: PWidget){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_set_widget".}
proc columnGetWidget*(tree_column: PTreeViewColumn): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_get_widget".}
proc columnSetAlignment*(tree_column: PTreeViewColumn, 
                                     xalign: Gfloat){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_set_alignment".}
proc columnGetAlignment*(tree_column: PTreeViewColumn): Gfloat{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_alignment".}
proc columnSetReorderable*(tree_column: PTreeViewColumn, 
                                       reorderable: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_column_set_reorderable".}
proc columnGetReorderable*(tree_column: PTreeViewColumn): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_reorderable".}
proc columnSetSortColumnId*(tree_column: PTreeViewColumn, 
    sort_column_id: Gint){.cdecl, dynlib: lib, 
                           importc: "gtk_tree_view_column_set_sort_column_id".}
proc columnGetSortColumnId*(tree_column: PTreeViewColumn): Gint{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_sort_column_id".}
proc columnSetSortIndicator*(tree_column: PTreeViewColumn, 
    setting: Gboolean){.cdecl, dynlib: lib, 
                        importc: "gtk_tree_view_column_set_sort_indicator".}
proc columnGetSortIndicator*(tree_column: PTreeViewColumn): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_sort_indicator".}
proc columnSetSortOrder*(tree_column: PTreeViewColumn, 
                                      order: TSortType){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_set_sort_order".}
proc columnGetSortOrder*(tree_column: PTreeViewColumn): TSortType{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_sort_order".}
proc columnCellSetCellData*(tree_column: PTreeViewColumn, 
    tree_model: PTreeModel, iter: PTreeIter, is_expander: Gboolean, 
    is_expanded: Gboolean){.cdecl, dynlib: lib, 
                            importc: "gtk_tree_view_column_cell_set_cell_data".}
proc columnCellGetSize*(tree_column: PTreeViewColumn, 
                                     cell_area: gdk2.PRectangle, x_offset: Pgint, 
                                     y_offset: Pgint, width: Pgint, 
                                     height: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_cell_get_size".}
proc columnCellIsVisible*(tree_column: PTreeViewColumn): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_cell_is_visible".}
proc columnFocusCell*(tree_column: PTreeViewColumn, 
                                  cell: PCellRenderer){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_column_focus_cell".}
proc columnSetExpand*(tree_column: PTreeViewColumn, Expand: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_set_expand".}
proc columnGetExpand*(tree_column: PTreeViewColumn): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_column_get_expand".}
const 
  RbnodeBlack* = 1 shl 0
  RbnodeRed* = 1 shl 1
  RbnodeIsParent* = 1 shl 2
  RbnodeIsSelected* = 1 shl 3
  RbnodeIsPrelit* = 1 shl 4
  RbnodeIsSemiCollapsed* = 1 shl 5
  RbnodeIsSemiExpanded* = 1 shl 6
  RbnodeInvalid* = 1 shl 7
  RbnodeColumnInvalid* = 1 shl 8
  RbnodeDescendantsInvalid* = 1 shl 9
  RbnodeNonColors* = RBNODE_IS_PARENT or RBNODE_IS_SELECTED or
      RBNODE_IS_PRELIT or RBNODE_IS_SEMI_COLLAPSED or RBNODE_IS_SEMI_EXPANDED or
      RBNODE_INVALID or RBNODE_COLUMN_INVALID or RBNODE_DESCENDANTS_INVALID

const 
  bmTGtkRBNodeFlags* = 0x3FFF'i16
  bpTGtkRBNodeFlags* = 0'i16
  bmTGtkRBNodeParity* = 0x4000'i16
  bpTGtkRBNodeParity* = 14'i16

proc flags*(a: PRBNode): Guint
proc setFlags*(a: PRBNode, `flags`: Guint)
proc parity*(a: PRBNode): Guint
proc setParity*(a: PRBNode, `parity`: Guint)
proc getColor*(node: PRBNode): Guint
proc setColor*(node: PRBNode, color: Guint)
proc getHeight*(node: PRBNode): Gint
proc setFlag*(node: PRBNode, flag: Guint16)
proc unsetFlag*(node: PRBNode, flag: Guint16)
proc flagSet*(node: PRBNode, flag: Guint): Bool
proc rbtreePushAllocator*(allocator: PGAllocator){.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_push_allocator".}
proc rbtreePopAllocator*(){.cdecl, dynlib: lib, 
                              importc: "_gtk_rbtree_pop_allocator".}
proc rbtreeNew*(): PRBTree{.cdecl, dynlib: lib, importc: "_gtk_rbtree_new".}
proc free*(tree: PRBTree){.cdecl, dynlib: lib, 
                                  importc: "_gtk_rbtree_free".}
proc remove*(tree: PRBTree){.cdecl, dynlib: lib, 
                                    importc: "_gtk_rbtree_remove".}
proc destroy*(tree: PRBTree){.cdecl, dynlib: lib, 
                                     importc: "_gtk_rbtree_destroy".}
proc insertBefore*(tree: PRBTree, node: PRBNode, height: Gint, 
                           valid: Gboolean): PRBNode{.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_insert_before".}
proc insertAfter*(tree: PRBTree, node: PRBNode, height: Gint, 
                          valid: Gboolean): PRBNode{.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_insert_after".}
proc removeNode*(tree: PRBTree, node: PRBNode){.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_remove_node".}
proc reorder*(tree: PRBTree, new_order: Pgint, length: Gint){.cdecl, 
    dynlib: lib, importc: "_gtk_rbtree_reorder".}
proc findCount*(tree: PRBTree, count: Gint): PRBNode{.cdecl, 
    dynlib: lib, importc: "_gtk_rbtree_find_count".}
proc nodeSetHeight*(tree: PRBTree, node: PRBNode, height: Gint){.
    cdecl, dynlib: lib, importc: "_gtk_rbtree_node_set_height".}
proc nodeMarkInvalid*(tree: PRBTree, node: PRBNode){.cdecl, 
    dynlib: lib, importc: "_gtk_rbtree_node_mark_invalid".}
proc nodeMarkValid*(tree: PRBTree, node: PRBNode){.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_node_mark_valid".}
proc columnInvalid*(tree: PRBTree){.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_column_invalid".}
proc markInvalid*(tree: PRBTree){.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_mark_invalid".}
proc setFixedHeight*(tree: PRBTree, height: Gint){.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_set_fixed_height".}
proc nodeFindOffset*(tree: PRBTree, node: PRBNode): Gint{.cdecl, 
    dynlib: lib, importc: "_gtk_rbtree_node_find_offset".}
proc nodeFindParity*(tree: PRBTree, node: PRBNode): Gint{.cdecl, 
    dynlib: lib, importc: "_gtk_rbtree_node_find_parity".}
proc traverse*(tree: PRBTree, node: PRBNode, order: TGTraverseType, 
                      fun: TRBTreeTraverseFunc, data: Gpointer){.cdecl, 
    dynlib: lib, importc: "_gtk_rbtree_traverse".}
proc next*(tree: PRBTree, node: PRBNode): PRBNode{.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_next".}
proc prev*(tree: PRBTree, node: PRBNode): PRBNode{.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_prev".}
proc getDepth*(tree: PRBTree): Gint{.cdecl, dynlib: lib, 
    importc: "_gtk_rbtree_get_depth".}
const 
  TreeViewDragWidth* = 6
  TreeViewIsList* = 1 shl 0
  TreeViewShowExpanders* = 1 shl 1
  TreeViewInColumnResize* = 1 shl 2
  TreeViewArrowPrelit* = 1 shl 3
  TreeViewHeadersVisible* = 1 shl 4
  TreeViewDrawKeyfocus* = 1 shl 5
  TreeViewModelSetup* = 1 shl 6
  TreeViewInColumnDrag* = 1 shl 7
  DragColumnWindowStateUnset* = 0
  DragColumnWindowStateOriginal* = 1
  DragColumnWindowStateArrow* = 2
  DragColumnWindowStateArrowLeft* = 3
  DragColumnWindowStateArrowRight* = 4

proc setFlag*(tree_view: PTreeView, flag: Guint)
proc unsetFlag*(tree_view: PTreeView, flag: Guint)
proc flagSet*(tree_view: PTreeView, flag: Guint): Bool
proc headerHeight*(tree_view: PTreeView): Int32
proc columnRequestedWidth*(column: PTreeViewColumn): Int32
proc drawExpanders*(tree_view: PTreeView): Bool
proc columnDragDeadMultiplier*(tree_view: PTreeView): Int32
const 
  bmTGtkTreeViewPrivateScrollToUseAlign* = 0x0001'i16
  bpTGtkTreeViewPrivateScrollToUseAlign* = 0'i16
  bmTGtkTreeViewPrivateFixedHeightCheck* = 0x0002'i16
  bpTGtkTreeViewPrivateFixedHeightCheck* = 1'i16
  bmTGtkTreeViewPrivateReorderable* = 0x0004'i16
  bpTGtkTreeViewPrivateReorderable* = 2'i16
  bmTGtkTreeViewPrivateHeaderHasFocus* = 0x0008'i16
  bpTGtkTreeViewPrivateHeaderHasFocus* = 3'i16
  bmTGtkTreeViewPrivateDragColumnWindowState* = 0x0070'i16
  bpTGtkTreeViewPrivateDragColumnWindowState* = 4'i16
  bmTGtkTreeViewPrivateHasRules* = 0x0080'i16
  bpTGtkTreeViewPrivateHasRules* = 7'i16
  bmTGtkTreeViewPrivateMarkRowsColDirty* = 0x0100'i16
  bpTGtkTreeViewPrivateMarkRowsColDirty* = 8'i16
  bmTGtkTreeViewPrivateEnableSearch* = 0x0200'i16
  bpTGtkTreeViewPrivateEnableSearch* = 9'i16
  bmTGtkTreeViewPrivateDisablePopdown* = 0x0400'i16
  bpTGtkTreeViewPrivateDisablePopdown* = 10'i16

proc scrollToUseAlign*(a: PTreeViewPrivate): Guint
proc setScrollToUseAlign*(a: PTreeViewPrivate, 
                              `scroll_to_use_align`: Guint)
proc fixedHeightCheck*(a: PTreeViewPrivate): Guint
proc setFixedHeightCheck*(a: PTreeViewPrivate, 
                             `fixed_height_check`: Guint)
proc reorderable*(a: PTreeViewPrivate): Guint
proc setReorderable*(a: PTreeViewPrivate, `reorderable`: Guint)
proc headerHasFocus*(a: PTreeViewPrivate): Guint
proc setHeaderHasFocus*(a: PTreeViewPrivate, `header_has_focus`: Guint)
proc dragColumnWindowState*(a: PTreeViewPrivate): Guint
proc setDragColumnWindowState*(a: PTreeViewPrivate, 
                                   `drag_column_window_state`: Guint)
proc hasRules*(a: PTreeViewPrivate): Guint
proc setHasRules*(a: PTreeViewPrivate, `has_rules`: Guint)
proc markRowsColDirty*(a: PTreeViewPrivate): Guint
proc setMarkRowsColDirty*(a: PTreeViewPrivate, 
                              `mark_rows_col_dirty`: Guint)
proc enableSearch*(a: PTreeViewPrivate): Guint
proc setEnableSearch*(a: PTreeViewPrivate, `enable_search`: Guint)
proc disablePopdown*(a: PTreeViewPrivate): Guint
proc setDisablePopdown*(a: PTreeViewPrivate, `disable_popdown`: Guint)
proc internalSelectNode*(selection: PTreeSelection, 
    node: PRBNode, tree: PRBTree, path: PTreePath, state: gdk2.TModifierType, 
    override_browse_mode: Gboolean){.cdecl, dynlib: lib, importc: "_gtk_tree_selection_internal_select_node".}
proc findNode*(tree_view: PTreeView, path: PTreePath, 
                          tree: var PRBTree, node: var PRBNode): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_find_node".}
proc findPath*(tree_view: PTreeView, tree: PRBTree, node: PRBNode): PTreePath{.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_find_path".}
proc childMoveResize*(tree_view: PTreeView, widget: PWidget, 
                                  x: Gint, y: Gint, width: Gint, height: Gint){.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_child_move_resize".}
proc queueDrawNode*(tree_view: PTreeView, tree: PRBTree, 
                                node: PRBNode, clip_rect: gdk2.PRectangle){.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_queue_draw_node".}
proc columnRealizeButton*(column: PTreeViewColumn){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_column_realize_button".}
proc columnUnrealizeButton*(column: PTreeViewColumn){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_column_unrealize_button".}
proc columnSetTreeView*(column: PTreeViewColumn, 
                                     tree_view: PTreeView){.cdecl, dynlib: lib, 
    importc: "_gtk_tree_view_column_set_tree_view".}
proc columnUnsetTreeView*(column: PTreeViewColumn){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_column_unset_tree_view".}
proc columnSetWidth*(column: PTreeViewColumn, width: Gint){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_column_set_width".}
proc columnStartDrag*(tree_view: PTreeView, column: PTreeViewColumn){.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_column_start_drag".}
proc columnStartEditing*(tree_column: PTreeViewColumn, 
                                     editable_widget: PCellEditable){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_column_start_editing".}
proc columnStopEditing*(tree_column: PTreeViewColumn){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_column_stop_editing".}
proc installMarkRowsColDirty*(tree_view: PTreeView){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_install_mark_rows_col_dirty".}
proc dOgtkTreeViewColumnAutosize*(tree_view: PTreeView, 
                                      column: PTreeViewColumn){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_column_autosize".}
proc columnHasEditableCell*(column: PTreeViewColumn): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_column_has_editable_cell".}
proc columnGetEditedCell*(column: PTreeViewColumn): PCellRenderer{.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_column_get_edited_cell".}
proc columnCountSpecialCells*(column: PTreeViewColumn): Gint{.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_column_count_special_cells".}
proc columnGetCellAtPos*(column: PTreeViewColumn, x: Gint): PCellRenderer{.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_column_get_cell_at_pos".}
proc treeSelectionNew*(): PTreeSelection{.cdecl, dynlib: lib, 
    importc: "_gtk_tree_selection_new".}
proc selectionNew*(tree_view: PTreeView): PTreeSelection{.
    cdecl, dynlib: lib, importc: "_gtk_tree_selection_new_with_tree_view".}
proc setTreeView*(selection: PTreeSelection, 
                                   tree_view: PTreeView){.cdecl, dynlib: lib, 
    importc: "_gtk_tree_selection_set_tree_view".}
proc columnCellRender*(tree_column: PTreeViewColumn, 
                                   window: gdk2.PWindow, 
                                   background_area: gdk2.PRectangle, 
                                   cell_area: gdk2.PRectangle, 
                                   expose_area: gdk2.PRectangle, flags: Guint){.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_column_cell_render".}
proc columnCellFocus*(tree_column: PTreeViewColumn, direction: Gint, 
                                  left: Gboolean, right: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_column_cell_focus".}
proc columnCellDrawFocus*(tree_column: PTreeViewColumn, 
                                       window: gdk2.PWindow, 
                                       background_area: gdk2.PRectangle, 
                                       cell_area: gdk2.PRectangle, 
                                       expose_area: gdk2.PRectangle, flags: Guint){.
    cdecl, dynlib: lib, importc: "_gtk_tree_view_column_cell_draw_focus".}
proc columnCellSetDirty*(tree_column: PTreeViewColumn, 
                                      install_handler: Gboolean){.cdecl, 
    dynlib: lib, importc: "_gtk_tree_view_column_cell_set_dirty".}
proc columnGetNeighborSizes*(column: PTreeViewColumn, 
    cell: PCellRenderer, left: Pgint, right: Pgint){.cdecl, dynlib: lib, 
    importc: "_gtk_tree_view_column_get_neighbor_sizes".}
proc typeTreeView*(): GType
proc treeView*(obj: Pointer): PTreeView
proc treeViewClass*(klass: Pointer): PTreeViewClass
proc isTreeView*(obj: Pointer): Bool
proc isTreeViewClass*(klass: Pointer): Bool
proc treeViewGetClass*(obj: Pointer): PTreeViewClass
proc treeViewGetType*(): TType{.cdecl, dynlib: lib, 
                                   importc: "gtk_tree_view_get_type".}
proc treeViewNew*(): PTreeView{.cdecl, dynlib: lib, 
                                  importc: "gtk_tree_view_new".}
proc treeViewNew*(model: PTreeModel): PTreeView{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_new_with_model".}
proc getModel*(tree_view: PTreeView): PTreeModel{.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_get_model".}
proc setModel*(tree_view: PTreeView, model: PTreeModel){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_set_model".}
proc getSelection*(tree_view: PTreeView): PTreeSelection{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_selection".}
proc getHadjustment*(tree_view: PTreeView): PAdjustment{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_hadjustment".}
proc setHadjustment*(tree_view: PTreeView, adjustment: PAdjustment){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_set_hadjustment".}
proc getVadjustment*(tree_view: PTreeView): PAdjustment{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_vadjustment".}
proc setVadjustment*(tree_view: PTreeView, adjustment: PAdjustment){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_set_vadjustment".}
proc getHeadersVisible*(tree_view: PTreeView): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_headers_visible".}
proc setHeadersVisible*(tree_view: PTreeView, 
                                    headers_visible: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_set_headers_visible".}
proc columnsAutosize*(tree_view: PTreeView){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_columns_autosize".}
proc setHeadersClickable*(tree_view: PTreeView, setting: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_set_headers_clickable".}
proc setRulesHint*(tree_view: PTreeView, setting: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_set_rules_hint".}
proc getRulesHint*(tree_view: PTreeView): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_rules_hint".}
proc appendColumn*(tree_view: PTreeView, column: PTreeViewColumn): Gint{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_append_column".}
proc removeColumn*(tree_view: PTreeView, column: PTreeViewColumn): Gint{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_remove_column".}
proc insertColumn*(tree_view: PTreeView, column: PTreeViewColumn, 
                              position: Gint): Gint{.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_insert_column".}
proc insertColumnWithDataFunc*(tree_view: PTreeView, 
    position: Gint, title: Cstring, cell: PCellRenderer, 
    fun: TTreeCellDataFunc, data: Gpointer, dnotify: TGDestroyNotify): Gint{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_insert_column_with_data_func".}
proc getColumn*(tree_view: PTreeView, n: Gint): PTreeViewColumn{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_get_column".}
proc getColumns*(tree_view: PTreeView): PGList{.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_get_columns".}
proc moveColumnAfter*(tree_view: PTreeView, column: PTreeViewColumn, 
                                  base_column: PTreeViewColumn){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_move_column_after".}
proc setExpanderColumn*(tree_view: PTreeView, 
                                    column: PTreeViewColumn){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_set_expander_column".}
proc getExpanderColumn*(tree_view: PTreeView): PTreeViewColumn{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_get_expander_column".}
proc setColumnDragFunction*(tree_view: PTreeView, 
    fun: TTreeViewColumnDropFunc, user_data: Gpointer, destroy: TDestroyNotify){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_set_column_drag_function".}
proc scrollToPoint*(tree_view: PTreeView, tree_x: Gint, tree_y: Gint){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_scroll_to_point".}
proc scrollToCell*(tree_view: PTreeView, path: PTreePath, 
                               column: PTreeViewColumn, use_align: Gboolean, 
                               row_align: Gfloat, col_align: Gfloat){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_scroll_to_cell".}
proc rowActivated*(tree_view: PTreeView, path: PTreePath, 
                              column: PTreeViewColumn){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_row_activated".}
proc expandAll*(tree_view: PTreeView){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_expand_all".}
proc collapseAll*(tree_view: PTreeView){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_collapse_all".}
proc expandRow*(tree_view: PTreeView, path: PTreePath, 
                           open_all: Gboolean): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_expand_row".}
proc collapseRow*(tree_view: PTreeView, path: PTreePath): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_collapse_row".}
proc mapExpandedRows*(tree_view: PTreeView, 
                                  fun: TTreeViewMappingFunc, data: Gpointer){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_map_expanded_rows".}
proc rowExpanded*(tree_view: PTreeView, path: PTreePath): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_row_expanded".}
proc setReorderable*(tree_view: PTreeView, reorderable: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_set_reorderable".}
proc getReorderable*(tree_view: PTreeView): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_reorderable".}
proc setCursor*(tree_view: PTreeView, path: PTreePath, 
                           focus_column: PTreeViewColumn, 
                           start_editing: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_set_cursor".}
proc setCursorOnCell*(tree_view: PTreeView, path: PTreePath, 
                                   focus_column: PTreeViewColumn, 
                                   focus_cell: PCellRenderer, 
                                   start_editing: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_set_cursor_on_cell".}
proc getBinWindow*(tree_view: PTreeView): gdk2.PWindow{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_bin_window".}
proc getCellArea*(tree_view: PTreeView, path: PTreePath, 
                              column: PTreeViewColumn, rect: gdk2.PRectangle){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_get_cell_area".}
proc getBackgroundArea*(tree_view: PTreeView, path: PTreePath, 
                                    column: PTreeViewColumn, rect: gdk2.PRectangle){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_get_background_area".}
proc getVisibleRect*(tree_view: PTreeView, 
                                 visible_rect: gdk2.PRectangle){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_visible_rect".}
proc widgetToTreeCoords*(tree_view: PTreeView, wx: Gint, wy: Gint, 
                                      tx: Pgint, ty: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_widget_to_tree_coords".}
proc treeToWidgetCoords*(tree_view: PTreeView, tx: Gint, ty: Gint, 
                                      wx: Pgint, wy: Pgint){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_tree_to_widget_coords".}
proc enableModelDragSource*(tree_view: PTreeView, 
    start_button_mask: gdk2.TModifierType, targets: PTargetEntry, n_targets: Gint, 
    actions: gdk2.TDragAction){.cdecl, dynlib: lib, 
                              importc: "gtk_tree_view_enable_model_drag_source".}
proc enableModelDragDest*(tree_view: PTreeView, 
                                       targets: PTargetEntry, n_targets: Gint, 
                                       actions: gdk2.TDragAction){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_enable_model_drag_dest".}
proc unsetRowsDragSource*(tree_view: PTreeView){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_unset_rows_drag_source".}
proc unsetRowsDragDest*(tree_view: PTreeView){.cdecl, dynlib: lib, 
    importc: "gtk_tree_view_unset_rows_drag_dest".}
proc setDragDestRow*(tree_view: PTreeView, path: PTreePath, 
                                  pos: TTreeViewDropPosition){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_set_drag_dest_row".}
proc createRowDragIcon*(tree_view: PTreeView, path: PTreePath): gdk2.PPixmap{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_create_row_drag_icon".}
proc setEnableSearch*(tree_view: PTreeView, enable_search: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_set_enable_search".}
proc getEnableSearch*(tree_view: PTreeView): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_enable_search".}
proc getSearchColumn*(tree_view: PTreeView): Gint{.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_get_search_column".}
proc setSearchColumn*(tree_view: PTreeView, column: Gint){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_set_search_column".}
proc getSearchEqualFunc*(tree_view: PTreeView): TTreeViewSearchEqualFunc{.
    cdecl, dynlib: lib, importc: "gtk_tree_view_get_search_equal_func".}
proc setSearchEqualFunc*(tree_view: PTreeView, search_equal_func: TTreeViewSearchEqualFunc, 
                                      search_user_data: Gpointer, 
                                      search_destroy: TDestroyNotify){.cdecl, 
    dynlib: lib, importc: "gtk_tree_view_set_search_equal_func".}
proc setDestroyCountFunc*(tree_view: PTreeView, 
                                       fun: TTreeDestroyCountFunc, 
                                       data: Gpointer, destroy: TDestroyNotify){.
    cdecl, dynlib: lib, importc: "gtk_tree_view_set_destroy_count_func".}
proc typeVbuttonBox*(): GType
proc vbuttonBox*(obj: Pointer): PVButtonBox
proc vbuttonBoxClass*(klass: Pointer): PVButtonBoxClass
proc isVbuttonBox*(obj: Pointer): Bool
proc isVbuttonBoxClass*(klass: Pointer): Bool
proc vbuttonBoxGetClass*(obj: Pointer): PVButtonBoxClass
proc vbuttonBoxGetType*(): TType{.cdecl, dynlib: lib, 
                                     importc: "gtk_vbutton_box_get_type".}
proc vbuttonBoxNew*(): PVButtonBox{.cdecl, dynlib: lib, 
                                      importc: "gtk_vbutton_box_new".}
proc typeViewport*(): GType
proc viewport*(obj: Pointer): PViewport
proc viewportClass*(klass: Pointer): PViewportClass
proc isViewport*(obj: Pointer): Bool
proc isViewportClass*(klass: Pointer): Bool
proc viewportGetClass*(obj: Pointer): PViewportClass
proc viewportGetType*(): TType{.cdecl, dynlib: lib, 
                                  importc: "gtk_viewport_get_type".}
proc viewportNew*(hadjustment: PAdjustment, vadjustment: PAdjustment): PViewport{.
    cdecl, dynlib: lib, importc: "gtk_viewport_new".}
proc getHadjustment*(viewport: PViewport): PAdjustment{.cdecl, 
    dynlib: lib, importc: "gtk_viewport_get_hadjustment".}
proc getVadjustment*(viewport: PViewport): PAdjustment{.cdecl, 
    dynlib: lib, importc: "gtk_viewport_get_vadjustment".}
proc setHadjustment*(viewport: PViewport, adjustment: PAdjustment){.
    cdecl, dynlib: lib, importc: "gtk_viewport_set_hadjustment".}
proc setVadjustment*(viewport: PViewport, adjustment: PAdjustment){.
    cdecl, dynlib: lib, importc: "gtk_viewport_set_vadjustment".}
proc setShadowType*(viewport: PViewport, thetype: TShadowType){.
    cdecl, dynlib: lib, importc: "gtk_viewport_set_shadow_type".}
proc getShadowType*(viewport: PViewport): TShadowType{.cdecl, 
    dynlib: lib, importc: "gtk_viewport_get_shadow_type".}
proc typeVpaned*(): GType
proc vpaned*(obj: Pointer): PVPaned
proc vpanedClass*(klass: Pointer): PVPanedClass
proc isVpaned*(obj: Pointer): Bool
proc isVpanedClass*(klass: Pointer): Bool
proc vpanedGetClass*(obj: Pointer): PVPanedClass
proc vpanedGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_vpaned_get_type".}
proc vpanedNew*(): PVPaned{.cdecl, dynlib: lib, importc: "gtk_vpaned_new".}
proc typeVruler*(): GType
proc vruler*(obj: Pointer): PVRuler
proc vrulerClass*(klass: Pointer): PVRulerClass
proc isVruler*(obj: Pointer): Bool
proc isVrulerClass*(klass: Pointer): Bool
proc vrulerGetClass*(obj: Pointer): PVRulerClass
proc vrulerGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_vruler_get_type".}
proc vrulerNew*(): PVRuler{.cdecl, dynlib: lib, importc: "gtk_vruler_new".}
proc typeVscale*(): GType
proc vscale*(obj: Pointer): PVScale
proc vscaleClass*(klass: Pointer): PVScaleClass
proc isVscale*(obj: Pointer): Bool
proc isVscaleClass*(klass: Pointer): Bool
proc vscaleGetClass*(obj: Pointer): PVScaleClass
proc vscaleGetType*(): TType{.cdecl, dynlib: lib, 
                                importc: "gtk_vscale_get_type".}
proc vscaleNew*(adjustment: PAdjustment): PVScale{.cdecl, dynlib: lib, 
    importc: "gtk_vscale_new".}
proc vscaleNew*(min: Gdouble, max: Gdouble, step: Gdouble): PVScale{.
    cdecl, dynlib: lib, importc: "gtk_vscale_new_with_range".}
proc typeVscrollbar*(): GType
proc vscrollbar*(obj: Pointer): PVScrollbar
proc vscrollbarClass*(klass: Pointer): PVScrollbarClass
proc isVscrollbar*(obj: Pointer): Bool
proc isVscrollbarClass*(klass: Pointer): Bool
proc vscrollbarGetClass*(obj: Pointer): PVScrollbarClass
proc vscrollbarGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_vscrollbar_get_type".}
proc vscrollbarNew*(adjustment: PAdjustment): PVScrollbar{.cdecl, dynlib: lib, 
    importc: "gtk_vscrollbar_new".}
proc typeVseparator*(): GType
proc vseparator*(obj: Pointer): PVSeparator
proc vseparatorClass*(klass: Pointer): PVSeparatorClass
proc isVseparator*(obj: Pointer): Bool
proc isVseparatorClass*(klass: Pointer): Bool
proc vseparatorGetClass*(obj: Pointer): PVSeparatorClass
proc vseparatorGetType*(): TType{.cdecl, dynlib: lib, 
                                    importc: "gtk_vseparator_get_type".}
proc vseparatorNew*(): PVSeparator{.cdecl, dynlib: lib, 
                                     importc: "gtk_vseparator_new".}
proc typeObject*(): GType = 
  result = gtk2.object_get_type()

proc checkCast*(instance: Pointer, g_type: GType): PGTypeInstance = 
  result = gTypeCheckInstanceCast(instance, gType)

proc checkClassCast*(g_class: Pointer, g_type: GType): Pointer = 
  result = gTypeCheckClassCast(gClass, gType)

proc checkGetClass*(instance: Pointer, g_type: GType): PGTypeClass = 
  result = gTypeInstanceGetClass(instance, gType)

proc checkType*(instance: Pointer, g_type: GType): Bool = 
  result = gTypeCheckInstanceType(instance, gType)

proc checkClassType*(g_class: Pointer, g_type: GType): Bool = 
  result = gTypeCheckClassType(gClass, gType)

proc `object`*(anObject: pointer): PObject = 
  result = cast[PObject](checkCast(anObject, gtk2.typeObject()))

proc objectClass*(klass: pointer): PObjectClass = 
  result = cast[PObjectClass](checkClassCast(klass, gtk2.typeObject()))

proc isObject*(anObject: pointer): bool = 
  result = checkType(anObject, gtk2.typeObject())

proc isObjectClass*(klass: pointer): bool = 
  result = checkClassType(klass, gtk2.typeObject())

proc objectGetClass*(anObject: pointer): PObjectClass = 
  result = cast[PObjectClass](checkGetClass(anObject, gtk2.typeObject()))

proc objectType*(anObject: pointer): GType = 
  result = gTypeFromInstance(anObject)

proc objectTypeName*(anObject: pointer): cstring = 
  result = gTypeName(objectType(anObject))

proc objectFlags*(obj: pointer): guint32 = 
  result = (gtk2.`OBJECT`(obj)).flags

proc objectFloating*(obj: pointer): gboolean = 
  result = ((objectFlags(obj)) and Cint(FLOATING)) != 0'i32

proc objectSetFlags*(obj: pointer, flag: guint32) = 
  gtk2.`OBJECT`(obj).flags = gtk2.`OBJECT`(obj).flags or flag

proc objectUnsetFlags*(obj: pointer, flag: guint32) = 
  gtk2.`OBJECT`(obj).flags = gtk2.`OBJECT`(obj).flags and not (flag)

proc objectDataTryKey*(`string`: Cstring): TGQuark = 
  result = gQuarkTryString(`string`)

proc objectDataForceId*(`string`: Cstring): TGQuark = 
  result = gQuarkFromString(`string`)

proc className*(`class`: Pointer): Cstring = 
  result = gTypeName(gTypeFromClass(`class`))

proc classType*(`class`: Pointer): GType = 
  result = gTypeFromClass(`class`)

proc typeIsObject*(thetype: GType): Gboolean = 
  result = gTypeIsA(thetype, gtk2.typeObject())

proc typeIdentifier*(): GType = 
  result = identifierGetType()

proc signalFunc*(f: pointer): TSignalFunc = 
  result = cast[TSignalFunc](f)

proc typeName*(thetype: GType): Cstring = 
  result = gTypeName(thetype)

proc typeFromName*(name: Cstring): GType = 
  result = gTypeFromName(name)

proc typeParent*(thetype: GType): GType = 
  result = gTypeParent(thetype)

proc typeIsA*(thetype, is_a_type: GType): Gboolean = 
  result = gTypeIsA(thetype, isAType)

proc fundamentalType*(thetype: GType): GType = 
  result = gTypeFundamental(thetype)

proc valueChar*(a: TArg): Gchar = 
  var a = a
  Result = cast[ptr Gchar](addr(a.d))[] 

proc valueUchar*(a: TArg): Guchar = 
  var a = a
  Result = cast[ptr Guchar](addr(a.d))[] 

proc valueBool*(a: TArg): Gboolean = 
  var a = a
  Result = cast[ptr Gboolean](addr(a.d))[] 

proc valueInt*(a: TArg): Gint = 
  var a = a
  Result = cast[ptr Gint](addr(a.d))[] 

proc valueUint*(a: TArg): Guint = 
  var a = a
  Result = cast[ptr Guint](addr(a.d))[] 

proc valueLong*(a: TArg): Glong = 
  var a = a
  Result = cast[ptr Glong](addr(a.d))[] 

proc valueUlong*(a: TArg): Gulong = 
  var a = a
  Result = cast[ptr Gulong](addr(a.d))[] 

proc valueFloat*(a: TArg): Gfloat = 
  var a = a
  Result = cast[ptr Gfloat](addr(a.d))[] 

proc valueDouble*(a: TArg): Gdouble = 
  var a = a
  Result = cast[ptr Gdouble](addr(a.d))[] 

proc valueString*(a: TArg): Cstring = 
  var a = a
  Result = cast[ptr Cstring](addr(a.d))[] 

proc valueEnum*(a: TArg): Gint = 
  var a = a
  Result = cast[ptr Gint](addr(a.d))[] 

proc valueFlags*(a: TArg): Guint = 
  var a = a
  Result = cast[ptr Guint](addr(a.d))[] 

proc valueBoxed*(a: TArg): Gpointer = 
  var a = a
  Result = cast[ptr Gpointer](addr(a.d))[] 

proc valueObject*(a: TArg): PObject = 
  var a = a
  Result = cast[ptr PObject](addr(a.d))[] 

proc valuePointer*(a: TArg): Gpointer = 
  var a = a
  Result = cast[ptr Gpointer](addr(a.d))[] 

proc valueSignal*(a: TArg): TArgSignalData = 
  var a = a
  Result = cast[ptr TArgSignalData](addr(a.d))[] 

proc retlocChar*(a: TArg): Cstring = 
  var a = a
  Result = cast[ptr Cstring](addr(a.d))[] 

proc retlocUchar*(a: TArg): Pguchar = 
  var a = a
  Result = cast[ptr Pguchar](addr(a.d))[] 

proc retlocBool*(a: TArg): Pgboolean = 
  var a = a
  Result = cast[ptr Pgboolean](addr(a.d))[] 

proc retlocInt*(a: TArg): Pgint = 
  var a = a
  Result = cast[ptr Pgint](addr(a.d))[] 

proc retlocUint*(a: TArg): Pguint = 
  var a = a
  Result = cast[ptr Pguint](addr(a.d))[] 

proc retlocLong*(a: TArg): Pglong = 
  var a = a
  Result = cast[ptr Pglong](addr(a.d))[] 

proc retlocUlong*(a: TArg): Pgulong = 
  var a = a
  Result = cast[ptr Pgulong](addr(a.d))[] 

proc retlocFloat*(a: TArg): Pgfloat = 
  var a = a
  Result = cast[ptr Pgfloat](addr(a.d))[] 

proc retlocDouble*(a: TArg): Pgdouble = 
  var a = a
  Result = cast[ptr Pgdouble](addr(a.d))[] 

proc retlocString*(a: TArg): PPgchar = 
  var a = a
  Result = cast[ptr PPgchar](addr(a.d))[] 

proc retlocEnum*(a: TArg): Pgint = 
  var a = a
  Result = cast[ptr Pgint](addr(a.d))[] 

proc retlocFlags*(a: TArg): Pguint = 
  var a = a
  Result = cast[ptr Pguint](addr(a.d))[] 

proc retlocBoxed*(a: TArg): Pgpointer = 
  var a = a
  Result = cast[ptr Pgpointer](addr(a.d))[] 

proc retlocObject*(a: TArg): PPGtkObject = 
  var a = a
  Result = cast[ptr PPGtkObject](addr(a.d))[] 

proc retlocPointer*(a: TArg): Pgpointer = 
  var a = a
  Result = cast[ptr Pgpointer](addr(a.d))[] 

proc typeWidget*(): GType = 
  result = widgetGetType()

proc widget*(widget: pointer): PWidget = 
  result = cast[PWidget](checkCast(widget, typeWidget()))

proc widgetClass*(klass: pointer): PWidgetClass = 
  result = cast[PWidgetClass](checkClassCast(klass, typeWidget()))

proc isWidget*(widget: pointer): bool = 
  result = checkType(widget, typeWidget())

proc isWidgetClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeWidget())

proc widgetGetClass*(obj: pointer): PWidgetClass = 
  result = cast[PWidgetClass](checkGetClass(obj, typeWidget()))

proc widgetType*(wid: pointer): GType = 
  result = objectType(wid)

proc widgetState*(wid: pointer): int32 = 
  result = (widget(wid)).state

proc widgetSavedState*(wid: pointer): int32 = 
  result = (widget(wid)).saved_state

proc widgetFlags*(wid: pointer): guint32 = 
  result = objectFlags(wid)

proc widgetToplevel*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(TOPLEVEL)) != 0'i32

proc widgetNoWindow*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(NO_WINDOW)) != 0'i32

proc widgetRealized*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(constREALIZED)) != 0'i32

proc widgetMapped*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(MAPPED)) != 0'i32

proc widgetVisible*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(constVISIBLE)) != 0'i32

proc widgetDrawable*(wid: pointer): gboolean = 
  result = (widgetVisible(wid)) and (widgetMapped(wid))

proc widgetSensitive*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(SENSITIVE)) != 0'i32

proc widgetParentSensitive*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(PARENT_SENSITIVE)) != 0'i32

proc widgetIsSensitive*(wid: pointer): gboolean = 
  result = (widgetSensitive(wid)) and (widgetParentSensitive(wid))

proc widgetCanFocus*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(CAN_FOCUS)) != 0'i32

proc widgetHasFocus*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(constHAS_FOCUS)) != 0'i32

proc widgetCanDefault*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(CAN_DEFAULT)) != 0'i32

proc widgetHasDefault*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(HAS_DEFAULT)) != 0'i32

proc widgetHasGrab*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(HAS_GRAB)) != 0'i32

proc widgetRcStyle*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(RC_STYLE)) != 0'i32

proc widgetCompositeChild*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(COMPOSITE_CHILD)) != 0'i32

proc widgetAppPaintable*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(APP_PAINTABLE)) != 0'i32

proc widgetReceivesDefault*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(RECEIVES_DEFAULT)) != 0'i32

proc widgetDoubleBuffered*(wid: pointer): gboolean = 
  result = ((widgetFlags(wid)) and Cint(DOUBLE_BUFFERED)) != 0'i32

proc typeRequisition*(): GType = 
  result = requisitionGetType()

proc xSet*(a: PWidgetAuxInfo): guint = 
  result = (a.flag0 and bm_TGtkWidgetAuxInfo_x_set) shr
      bp_TGtkWidgetAuxInfo_x_set

proc setXSet*(a: PWidgetAuxInfo, `x_set`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`xSet` shl bp_TGtkWidgetAuxInfo_x_set) and
      bm_TGtkWidgetAuxInfo_x_set)

proc ySet*(a: PWidgetAuxInfo): guint = 
  result = (a.flag0 and bm_TGtkWidgetAuxInfo_y_set) shr
      bp_TGtkWidgetAuxInfo_y_set

proc setYSet*(a: PWidgetAuxInfo, `y_set`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`ySet` shl bp_TGtkWidgetAuxInfo_y_set) and
      bm_TGtkWidgetAuxInfo_y_set)

proc widgetSetVisual*(widget, visual: Pointer) = 
  if (widget != nil) and (visual != nil): nil
  
proc widgetPushVisual*(visual: Pointer) = 
  if (visual != nil): nil
  
proc widgetPopVisual*() = 
  nil

proc widgetSetDefaultVisual*(visual: Pointer) = 
  if (visual != nil): nil
  
proc widgetSetRcStyle*(widget: Pointer) = 
  setStyle(cast[PWidget](widget), nil)

proc widgetRestoreDefaultStyle*(widget: Pointer) = 
  setStyle(cast[PWidget](widget), nil)

proc setFlags*(wid: PWidget, flags: TWidgetFlags): TWidgetFlags = 
  cast[PObject](wid).flags = cast[PObject](wid).flags or (flags)
  result = cast[PObject](wid).flags

proc unsetFlags*(wid: PWidget, flags: TWidgetFlags): TWidgetFlags = 
  cast[PObject](wid).flags = cast[PObject](wid).flags and (not (flags))
  result = cast[PObject](wid).flags

proc typeMisc*(): GType = 
  result = miscGetType()

proc misc*(obj: pointer): PMisc = 
  result = cast[PMisc](checkCast(obj, typeMisc()))

proc miscClass*(klass: pointer): PMiscClass = 
  result = cast[PMiscClass](checkClassCast(klass, typeMisc()))

proc isMisc*(obj: pointer): bool = 
  result = checkType(obj, typeMisc())

proc isMiscClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeMisc())

proc miscGetClass*(obj: pointer): PMiscClass = 
  result = cast[PMiscClass](checkGetClass(obj, typeMisc()))

proc typeAccelGroup*(): GType = 
  result = accelGroupGetType()

proc accelGroup*(anObject: pointer): PAccelGroup = 
  result = cast[PAccelGroup](gTypeCheckInstanceCast(anObject, 
      typeAccelGroup()))

proc accelGroupClass*(klass: pointer): PAccelGroupClass = 
  result = cast[PAccelGroupClass](gTypeCheckClassCast(klass, 
      typeAccelGroup()))

proc isAccelGroup*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeAccelGroup())

proc isAccelGroupClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeAccelGroup())

proc accelGroupGetClass*(obj: pointer): PAccelGroupClass = 
  result = cast[PAccelGroupClass](gTypeInstanceGetClass(obj, 
      typeAccelGroup()))

proc accelFlags*(a: PAccelKey): guint = 
  result = (a.flag0 and bm_TGtkAccelKey_accel_flags) shr
      bp_TGtkAccelKey_accel_flags

proc setAccelFlags*(a: PAccelKey, `accel_flags`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`accelFlags` shl bp_TGtkAccelKey_accel_flags) and
      bm_TGtkAccelKey_accel_flags)

proc reference*(AccelGroup: PAccelGroup) = 
  discard gObjectRef(accelGroup)

proc unref*(AccelGroup: PAccelGroup) = 
  gObjectUnref(accelGroup)

proc typeContainer*(): GType = 
  result = containerGetType()

proc container*(obj: pointer): PContainer = 
  result = cast[PContainer](checkCast(obj, typeContainer()))

proc containerClass*(klass: pointer): PContainerClass = 
  result = cast[PContainerClass](checkClassCast(klass, typeContainer()))

proc isContainer*(obj: pointer): bool = 
  result = checkType(obj, typeContainer())

proc isContainerClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeContainer())

proc containerGetClass*(obj: pointer): PContainerClass = 
  result = cast[PContainerClass](checkGetClass(obj, typeContainer()))

proc isResizeContainer*(widget: pointer): bool = 
  result = (isContainer(widget)) and
      ((resizeMode(cast[PContainer](widget))) != Cint(RESIZE_PARENT))

proc borderWidth*(a: PContainer): guint = 
  result = (a.Container_flag0 and bm_TGtkContainer_border_width) shr
      bp_TGtkContainer_border_width

proc needResize*(a: PContainer): guint = 
  result = (a.Container_flag0 and bm_TGtkContainer_need_resize) shr
      bp_TGtkContainer_need_resize

proc setNeedResize*(a: PContainer, `need_resize`: guint) = 
  a.Container_flag0 = a.Container_flag0 or
      ((`needResize` shl bp_TGtkContainer_need_resize) and
      bm_TGtkContainer_need_resize)

proc resizeMode*(a: PContainer): guint = 
  result = (a.Container_flag0 and bm_TGtkContainer_resize_mode) shr
      bp_TGtkContainer_resize_mode

proc setResizeMode*(a: PContainer, `resize_mode`: guint) = 
  a.Containerflag0 = a.Containerflag0 or
      ((`resizeMode` shl bp_TGtkContainer_resize_mode) and
      bm_TGtkContainer_resize_mode)

proc reallocateRedraws*(a: PContainer): guint = 
  result = (a.Containerflag0 and bm_TGtkContainer_reallocate_redraws) shr
      bp_TGtkContainer_reallocate_redraws

proc setReallocateRedraws*(a: PContainer, `reallocate_redraws`: guint) = 
  a.Containerflag0 = a.Containerflag0 or
      ((`reallocateRedraws` shl bp_TGtkContainer_reallocate_redraws) and
      bm_TGtkContainer_reallocate_redraws)

proc hasFocusChain*(a: PContainer): guint = 
  result = (a.Containerflag0 and bm_TGtkContainer_has_focus_chain) shr
      bp_TGtkContainer_has_focus_chain

proc setHasFocusChain*(a: PContainer, `has_focus_chain`: guint) = 
  a.Containerflag0 = a.Containerflag0 or
      ((`hasFocusChain` shl bp_TGtkContainer_has_focus_chain) and
      bm_TGtkContainer_has_focus_chain)

proc containerWarnInvalidChildPropertyId*(anObject: pointer, 
    property_id: guint, pspec: pointer) = 
  write(stdout, "WARNING: invalid child property id\x0A")

proc typeBin*(): GType = 
  result = binGetType()

proc bin*(obj: pointer): PBin = 
  result = cast[PBin](checkCast(obj, typeBin()))

proc binClass*(klass: pointer): PBinClass = 
  result = cast[PBinClass](checkClassCast(klass, typeBin()))

proc isBin*(obj: pointer): bool = 
  result = checkType(obj, typeBin())

proc isBinClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeBin())

proc binGetClass*(obj: pointer): PBinClass = 
  result = cast[PBinClass](checkGetClass(obj, typeBin()))

proc typeWindow*(): GType = 
  result = windowGetType()

proc window*(obj: pointer): PWindow = 
  result = cast[PWindow](checkCast(obj, gtk2.typeWindow()))

proc windowClass*(klass: pointer): PWindowClass = 
  result = cast[PWindowClass](checkClassCast(klass, gtk2.typeWindow()))

proc isWindow*(obj: pointer): bool = 
  result = checkType(obj, gtk2.typeWindow())

proc isWindowClass*(klass: pointer): bool = 
  result = checkClassType(klass, gtk2.typeWindow())

proc windowGetClass*(obj: pointer): PWindowClass = 
  result = cast[PWindowClass](checkGetClass(obj, gtk2.typeWindow()))

proc allowShrink*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_allow_shrink) shr
      bp_TGtkWindow_allow_shrink

proc setAllowShrink*(a: gtk2.PWindow, `allow_shrink`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`allowShrink` shl bp_TGtkWindow_allow_shrink) and
      bm_TGtkWindow_allow_shrink)

proc allowGrow*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_allow_grow) shr
      bp_TGtkWindow_allow_grow

proc setAllowGrow*(a: gtk2.PWindow, `allow_grow`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`allowGrow` shl bp_TGtkWindow_allow_grow) and
      bm_TGtkWindow_allow_grow)

proc configureNotifyReceived*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_configure_notify_received) shr
      bp_TGtkWindow_configure_notify_received

proc setConfigureNotifyReceived*(a: gtk2.PWindow, 
                                    `configure_notify_received`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`configureNotifyReceived` shl
      bp_TGtkWindow_configure_notify_received) and
      bm_TGtkWindow_configure_notify_received)

proc needDefaultPosition*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_need_default_position) shr
      bp_TGtkWindow_need_default_position

proc setNeedDefaultPosition*(a: gtk2.PWindow, `need_default_position`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`needDefaultPosition` shl bp_TGtkWindow_need_default_position) and
      bm_TGtkWindow_need_default_position)

proc needDefaultSize*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_need_default_size) shr
      bp_TGtkWindow_need_default_size

proc setNeedDefaultSize*(a: gtk2.PWindow, `need_default_size`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`needDefaultSize` shl bp_TGtkWindow_need_default_size) and
      bm_TGtkWindow_need_default_size)

proc position*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_position) shr
      bp_TGtkWindow_position

proc getType*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_type) shr bp_TGtkWindow_type

proc setType*(a: gtk2.PWindow, `type`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`type` shl bp_TGtkWindow_type) and bm_TGtkWindow_type)

proc hasUserRefCount*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_has_user_ref_count) shr
      bp_TGtkWindow_has_user_ref_count

proc setHasUserRefCount*(a: gtk2.PWindow, `has_user_ref_count`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`hasUserRefCount` shl bp_TGtkWindow_has_user_ref_count) and
      bm_TGtkWindow_has_user_ref_count)

proc hasFocus*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_has_focus) shr
      bp_TGtkWindow_has_focus

proc setHasFocus*(a: gtk2.PWindow, `has_focus`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`hasFocus` shl bp_TGtkWindow_has_focus) and bm_TGtkWindow_has_focus)

proc modal*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_modal) shr bp_TGtkWindow_modal

proc setModal*(a: gtk2.PWindow, `modal`: guint) = 
  a.Window_flag0 = a.Window_flag0 or
      ((`modal` shl bp_TGtkWindow_modal) and bm_TGtkWindow_modal)

proc destroyWithParent*(a: gtk2.PWindow): guint = 
  result = (a.Window_flag0 and bm_TGtkWindow_destroy_with_parent) shr
      bp_TGtkWindow_destroy_with_parent

proc setDestroyWithParent*(a: gtk2.PWindow, `destroy_with_parent`: guint) = 
  a.Windowflag0 = a.Windowflag0 or
      ((`destroyWithParent` shl bp_TGtkWindow_destroy_with_parent) and
      bm_TGtkWindow_destroy_with_parent)

proc hasFrame*(a: gtk2.PWindow): guint = 
  result = (a.Windowflag0 and bm_TGtkWindow_has_frame) shr
      bp_TGtkWindow_has_frame

proc setHasFrame*(a: gtk2.PWindow, `has_frame`: guint) = 
  a.Windowflag0 = a.Windowflag0 or
      ((`hasFrame` shl bp_TGtkWindow_has_frame) and bm_TGtkWindow_has_frame)

proc iconifyInitially*(a: gtk2.PWindow): guint = 
  result = (a.Windowflag0 and bm_TGtkWindow_iconify_initially) shr
      bp_TGtkWindow_iconify_initially

proc setIconifyInitially*(a: gtk2.PWindow, `iconify_initially`: guint) = 
  a.Windowflag0 = a.Windowflag0 or
      ((`iconifyInitially` shl bp_TGtkWindow_iconify_initially) and
      bm_TGtkWindow_iconify_initially)

proc stickInitially*(a: gtk2.PWindow): guint = 
  result = (a.Windowflag0 and bm_TGtkWindow_stick_initially) shr
      bp_TGtkWindow_stick_initially

proc setStickInitially*(a: gtk2.PWindow, `stick_initially`: guint) = 
  a.Windowflag0 = a.Windowflag0 or
      ((`stickInitially` shl bp_TGtkWindow_stick_initially) and
      bm_TGtkWindow_stick_initially)

proc maximizeInitially*(a: gtk2.PWindow): guint = 
  result = (a.Windowflag0 and bm_TGtkWindow_maximize_initially) shr
      bp_TGtkWindow_maximize_initially

proc setMaximizeInitially*(a: gtk2.PWindow, `maximize_initially`: guint) = 
  a.Windowflag0 = a.Windowflag0 or
      ((`maximizeInitially` shl bp_TGtkWindow_maximize_initially) and
      bm_TGtkWindow_maximize_initially)

proc decorated*(a: gtk2.PWindow): guint = 
  result = (a.Windowflag0 and bm_TGtkWindow_decorated) shr
      bp_TGtkWindow_decorated

proc setDecorated*(a: gtk2.PWindow, `decorated`: guint) = 
  a.Windowflag0 = a.Windowflag0 or
      ((`decorated` shl bp_TGtkWindow_decorated) and bm_TGtkWindow_decorated)

proc typeHint*(a: gtk2.PWindow): guint = 
  result = (a.Windowflag0 and bm_TGtkWindow_type_hint) shr
      bp_TGtkWindow_type_hint

proc setTypeHint*(a: gtk2.PWindow, `type_hint`: guint) = 
  a.Windowflag0 = a.Windowflag0 or
      ((`typeHint` shl bp_TGtkWindow_type_hint) and bm_TGtkWindow_type_hint)

proc gravity*(a: gtk2.PWindow): guint = 
  result = (a.Windowflag0 and bm_TGtkWindow_gravity) shr
      bp_TGtkWindow_gravity

proc setGravity*(a: gtk2.PWindow, `gravity`: guint) = 
  a.Windowflag0 = a.Windowflag0 or
      ((`gravity` shl bp_TGtkWindow_gravity) and bm_TGtkWindow_gravity)

proc typeWindowGroup*(): GType = 
  result = windowGroupGetType()

proc windowGroup*(anObject: pointer): PWindowGroup = 
  result = cast[PWindowGroup](gTypeCheckInstanceCast(anObject, 
      typeWindowGroup()))

proc windowGroupClass*(klass: pointer): PWindowGroupClass = 
  result = cast[PWindowGroupClass](gTypeCheckClassCast(klass, 
      typeWindowGroup()))

proc isWindowGroup*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeWindowGroup())

proc isWindowGroupClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeWindowGroup())

proc windowGroupGetClass*(obj: pointer): PWindowGroupClass = 
  result = cast[PWindowGroupClass](gTypeInstanceGetClass(obj, 
      typeWindowGroup()))

proc typeLabel*(): GType = 
  result = labelGetType()

proc label*(obj: pointer): PLabel = 
  result = cast[PLabel](checkCast(obj, typeLabel()))

proc labelClass*(klass: pointer): PLabelClass = 
  result = cast[PLabelClass](checkClassCast(klass, typeLabel()))

proc isLabel*(obj: pointer): bool = 
  result = checkType(obj, typeLabel())

proc isLabelClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeLabel())

proc labelGetClass*(obj: pointer): PLabelClass = 
  result = cast[PLabelClass](checkGetClass(obj, typeLabel()))

proc jtype*(a: PLabel): guint = 
  result = (a.Labelflag0 and bm_TGtkLabel_jtype) shr bp_TGtkLabel_jtype

proc setJtype*(a: PLabel, `jtype`: guint) = 
  a.Labelflag0 = a.Labelflag0 or
      (Int16(`jtype` shl bp_TGtkLabel_jtype) and bm_TGtkLabel_jtype)

proc wrap*(a: PLabel): guint = 
  result = (a.Labelflag0 and bm_TGtkLabel_wrap) shr bp_TGtkLabel_wrap

proc setWrap*(a: PLabel, `wrap`: guint) = 
  a.Labelflag0 = a.Labelflag0 or
      (Int16(`wrap` shl bp_TGtkLabel_wrap) and bm_TGtkLabel_wrap)

proc useUnderline*(a: PLabel): guint = 
  result = (a.Labelflag0 and bm_TGtkLabel_use_underline) shr
      bp_TGtkLabel_use_underline

proc setUseUnderline*(a: PLabel, `use_underline`: guint) = 
  a.Labelflag0 = a.Labelflag0 or
      (Int16(`useUnderline` shl bp_TGtkLabel_use_underline) and
      bm_TGtkLabel_use_underline)

proc useMarkup*(a: PLabel): guint = 
  result = (a.Labelflag0 and bm_TGtkLabel_use_markup) shr
      bp_TGtkLabel_use_markup

proc setUseMarkup*(a: PLabel, `use_markup`: guint) = 
  a.Labelflag0 = a.Labelflag0 or
      (Int16(`useMarkup` shl bp_TGtkLabel_use_markup) and
      bm_TGtkLabel_use_markup)

proc typeAccelLabel*(): GType = 
  result = accelLabelGetType()

proc accelLabel*(obj: pointer): PAccelLabel = 
  result = cast[PAccelLabel](checkCast(obj, typeAccelLabel()))

proc accelLabelClass*(klass: pointer): PAccelLabelClass = 
  result = cast[PAccelLabelClass](checkClassCast(klass, typeAccelLabel()))

proc isAccelLabel*(obj: pointer): bool = 
  result = checkType(obj, typeAccelLabel())

proc isAccelLabelClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeAccelLabel())

proc accelLabelGetClass*(obj: pointer): PAccelLabelClass = 
  result = cast[PAccelLabelClass](checkGetClass(obj, typeAccelLabel()))

proc latin1ToChar*(a: PAccelLabelClass): guint = 
  result = (a.AccelLabelClassflag0 and bm_TGtkAccelLabelClass_latin1_to_char) shr
      bp_TGtkAccelLabelClass_latin1_to_char

proc setLatin1ToChar*(a: PAccelLabelClass, `latin1_to_char`: guint) = 
  a.AccelLabelClassflag0 = a.AccelLabelClassflag0 or
      (Int16(`latin1ToChar` shl bp_TGtkAccelLabelClass_latin1_to_char) and
      bm_TGtkAccelLabelClass_latin1_to_char)

proc acceleratorWidth*(accel_label: PAccelLabel): Guint = 
  result = getAccelWidth(accelLabel)

proc typeAccessible*(): GType = 
  result = accessibleGetType()

proc accessible*(obj: pointer): PAccessible = 
  result = cast[PAccessible](checkCast(obj, typeAccessible()))

proc accessibleClass*(klass: pointer): PAccessibleClass = 
  result = cast[PAccessibleClass](checkClassCast(klass, typeAccessible()))

proc isAccessible*(obj: pointer): bool = 
  result = checkType(obj, typeAccessible())

proc isAccessibleClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeAccessible())

proc accessibleGetClass*(obj: pointer): PAccessibleClass = 
  result = cast[PAccessibleClass](checkGetClass(obj, typeAccessible()))

proc typeAdjustment*(): GType = 
  result = adjustmentGetType()

proc adjustment*(obj: pointer): PAdjustment = 
  result = cast[PAdjustment](checkCast(obj, typeAdjustment()))

proc adjustmentClass*(klass: pointer): PAdjustmentClass = 
  result = cast[PAdjustmentClass](checkClassCast(klass, typeAdjustment()))

proc isAdjustment*(obj: pointer): bool = 
  result = checkType(obj, typeAdjustment())

proc isAdjustmentClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeAdjustment())

proc adjustmentGetClass*(obj: pointer): PAdjustmentClass = 
  result = cast[PAdjustmentClass](checkGetClass(obj, typeAdjustment()))

proc typeAlignment*(): GType = 
  result = alignmentGetType()

proc alignment*(obj: pointer): PAlignment = 
  result = cast[PAlignment](checkCast(obj, typeAlignment()))

proc alignmentClass*(klass: pointer): PAlignmentClass = 
  result = cast[PAlignmentClass](checkClassCast(klass, typeAlignment()))

proc isAlignment*(obj: pointer): bool = 
  result = checkType(obj, typeAlignment())

proc isAlignmentClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeAlignment())

proc alignmentGetClass*(obj: pointer): PAlignmentClass = 
  result = cast[PAlignmentClass](checkGetClass(obj, typeAlignment()))

proc typeFrame*(): GType = 
  result = frameGetType()

proc frame*(obj: pointer): PFrame = 
  result = cast[PFrame](checkCast(obj, typeFrame()))

proc frameClass*(klass: pointer): PFrameClass = 
  result = cast[PFrameClass](checkClassCast(klass, typeFrame()))

proc isFrame*(obj: pointer): bool = 
  result = checkType(obj, typeFrame())

proc isFrameClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeFrame())

proc frameGetClass*(obj: pointer): PFrameClass = 
  result = cast[PFrameClass](checkGetClass(obj, typeFrame()))

proc typeAspectFrame*(): GType = 
  result = aspectFrameGetType()

proc aspectFrame*(obj: pointer): PAspectFrame = 
  result = cast[PAspectFrame](checkCast(obj, typeAspectFrame()))

proc aspectFrameClass*(klass: pointer): PAspectFrameClass = 
  result = cast[PAspectFrameClass](checkClassCast(klass, typeAspectFrame()))

proc isAspectFrame*(obj: pointer): bool = 
  result = checkType(obj, typeAspectFrame())

proc isAspectFrameClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeAspectFrame())

proc aspectFrameGetClass*(obj: pointer): PAspectFrameClass = 
  result = cast[PAspectFrameClass](checkGetClass(obj, typeAspectFrame()))

proc typeArrow*(): GType = 
  result = arrowGetType()

proc arrow*(obj: pointer): PArrow = 
  result = cast[PArrow](checkCast(obj, typeArrow()))

proc arrowClass*(klass: pointer): PArrowClass = 
  result = cast[PArrowClass](checkClassCast(klass, typeArrow()))

proc isArrow*(obj: pointer): bool = 
  result = checkType(obj, typeArrow())

proc isArrowClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeArrow())

proc arrowGetClass*(obj: pointer): PArrowClass = 
  result = cast[PArrowClass](checkGetClass(obj, typeArrow()))

proc parsed*(a: PBindingSet): guint = 
  result = (a.flag0 and bm_TGtkBindingSet_parsed) shr
      bp_TGtkBindingSet_parsed

proc setParsed*(a: PBindingSet, `parsed`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`parsed` shl bp_TGtkBindingSet_parsed) and
      bm_TGtkBindingSet_parsed)

proc destroyed*(a: PBindingEntry): guint = 
  result = (a.flag0 and bm_TGtkBindingEntry_destroyed) shr
      bp_TGtkBindingEntry_destroyed

proc setDestroyed*(a: PBindingEntry, `destroyed`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`destroyed` shl bp_TGtkBindingEntry_destroyed) and
      bm_TGtkBindingEntry_destroyed)

proc inEmission*(a: PBindingEntry): guint = 
  result = (a.flag0 and bm_TGtkBindingEntry_in_emission) shr
      bp_TGtkBindingEntry_in_emission

proc setInEmission*(a: PBindingEntry, `in_emission`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`inEmission` shl bp_TGtkBindingEntry_in_emission) and
      bm_TGtkBindingEntry_in_emission)

proc entryAdd*(binding_set: PBindingSet, keyval: guint, 
                        modifiers: gdk2.TModifierType) = 
  entryClear(bindingSet, keyval, modifiers)

proc typeBox*(): GType = 
  result = boxGetType()

proc box*(obj: pointer): PBox = 
  result = cast[PBox](checkCast(obj, typeBox()))

proc boxClass*(klass: pointer): PBoxClass = 
  result = cast[PBoxClass](checkClassCast(klass, typeBox()))

proc isBox*(obj: pointer): bool = 
  result = checkType(obj, typeBox())

proc isBoxClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeBox())

proc boxGetClass*(obj: pointer): PBoxClass = 
  result = cast[PBoxClass](checkGetClass(obj, typeBox()))

proc homogeneous*(a: PBox): guint = 
  result = (a.Boxflag0 and bm_TGtkBox_homogeneous) shr bp_TGtkBox_homogeneous

proc setHomogeneous*(a: PBox, `homogeneous`: guint) = 
  a.Boxflag0 = a.Boxflag0 or
      (Int16(`homogeneous` shl bp_TGtkBox_homogeneous) and
      bm_TGtkBox_homogeneous)

proc expand*(a: PBoxChild): guint = 
  result = (a.flag0 and bm_TGtkBoxChild_expand) shr bp_TGtkBoxChild_expand

proc setExpand*(a: PBoxChild, `expand`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`expand` shl bp_TGtkBoxChild_expand) and bm_TGtkBoxChild_expand)

proc fill*(a: PBoxChild): guint = 
  result = (a.flag0 and bm_TGtkBoxChild_fill) shr bp_TGtkBoxChild_fill

proc setFill*(a: PBoxChild, `fill`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`fill` shl bp_TGtkBoxChild_fill) and bm_TGtkBoxChild_fill)

proc pack*(a: PBoxChild): guint = 
  result = (a.flag0 and bm_TGtkBoxChild_pack) shr bp_TGtkBoxChild_pack

proc setPack*(a: PBoxChild, `pack`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pack` shl bp_TGtkBoxChild_pack) and bm_TGtkBoxChild_pack)

proc isSecondary*(a: PBoxChild): guint = 
  result = (a.flag0 and bm_TGtkBoxChild_is_secondary) shr
      bp_TGtkBoxChild_is_secondary

proc setIsSecondary*(a: PBoxChild, `is_secondary`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isSecondary` shl bp_TGtkBoxChild_is_secondary) and
      bm_TGtkBoxChild_is_secondary)

proc typeButtonBox*(): GType = 
  result = buttonBoxGetType()

proc buttonBox*(obj: pointer): PButtonBox = 
  result = cast[PButtonBox](checkCast(obj, typeButtonBox()))

proc buttonBoxClass*(klass: pointer): PButtonBoxClass = 
  result = cast[PButtonBoxClass](checkClassCast(klass, typeButtonBox()))

proc isButtonBox*(obj: pointer): bool = 
  result = checkType(obj, typeButtonBox())

proc isButtonBoxClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeButtonBox())

proc buttonBoxGetClass*(obj: pointer): PButtonBoxClass = 
  result = cast[PButtonBoxClass](checkGetClass(obj, typeButtonBox()))

proc buttonBoxSetSpacing*(b: Pointer, s: Gint) = 
  setSpacing(box(b), s)

proc buttonBoxGetSpacing*(b: Pointer): Gint = 
  result = getSpacing(box(b))

proc typeButton*(): GType = 
  result = buttonGetType()

proc button*(obj: pointer): PButton = 
  result = cast[PButton](checkCast(obj, typeButton()))

proc buttonClass*(klass: pointer): PButtonClass = 
  result = cast[PButtonClass](checkClassCast(klass, typeButton()))

proc isButton*(obj: pointer): bool = 
  result = checkType(obj, typeButton())

proc isButtonClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeButton())

proc buttonGetClass*(obj: pointer): PButtonClass = 
  result = cast[PButtonClass](checkGetClass(obj, typeButton()))

proc constructed*(a: PButton): guint = 
  result = (a.Buttonflag0 and bm_TGtkButton_constructed) shr
      bp_TGtkButton_constructed

proc setConstructed*(a: PButton, `constructed`: guint) = 
  a.Buttonflag0 = a.Buttonflag0 or
      (Int16(`constructed` shl bp_TGtkButton_constructed) and
      bm_TGtkButton_constructed)

proc inButton*(a: PButton): guint = 
  result = (a.Buttonflag0 and bm_TGtkButton_in_button) shr
      bp_TGtkButton_in_button

proc setInButton*(a: PButton, `in_button`: guint) = 
  a.Buttonflag0 = a.Buttonflag0 or
      (Int16(`inButton` shl bp_TGtkButton_in_button) and
      bm_TGtkButton_in_button)

proc buttonDown*(a: PButton): guint = 
  result = (a.Buttonflag0 and bm_TGtkButton_button_down) shr
      bp_TGtkButton_button_down

proc setButtonDown*(a: PButton, `button_down`: guint) = 
  a.Buttonflag0 = a.Buttonflag0 or
      (Int16(`buttonDown` shl bp_TGtkButton_button_down) and
      bm_TGtkButton_button_down)

proc relief*(a: PButton): guint = 
  result = (a.Buttonflag0 and bm_TGtkButton_relief) shr bp_TGtkButton_relief

proc useUnderline*(a: PButton): guint = 
  result = (a.Buttonflag0 and bm_TGtkButton_use_underline) shr
      bp_TGtkButton_use_underline

proc setUseUnderline*(a: PButton, `use_underline`: guint) = 
  a.Buttonflag0 = a.Buttonflag0 or
      (Int16(`useUnderline` shl bp_TGtkButton_use_underline) and
      bm_TGtkButton_use_underline)

proc useStock*(a: PButton): guint = 
  result = (a.Buttonflag0 and bm_TGtkButton_use_stock) shr
      bp_TGtkButton_use_stock

proc setUseStock*(a: PButton, `use_stock`: guint) = 
  a.Buttonflag0 = a.Buttonflag0 or
      (Int16(`useStock` shl bp_TGtkButton_use_stock) and
      bm_TGtkButton_use_stock)

proc depressed*(a: PButton): guint = 
  result = (a.Buttonflag0 and bm_TGtkButton_depressed) shr
      bp_TGtkButton_depressed

proc setDepressed*(a: PButton, `depressed`: guint) = 
  a.Buttonflag0 = a.Buttonflag0 or
      (Int16(`depressed` shl bp_TGtkButton_depressed) and
      bm_TGtkButton_depressed)

proc depressOnActivate*(a: PButton): guint = 
  result = (a.Buttonflag0 and bm_TGtkButton_depress_on_activate) shr
      bp_TGtkButton_depress_on_activate

proc setDepressOnActivate*(a: PButton, `depress_on_activate`: guint) = 
  a.Buttonflag0 = a.Buttonflag0 or
      (Int16(`depressOnActivate` shl bp_TGtkButton_depress_on_activate) and
      bm_TGtkButton_depress_on_activate)

proc typeCalendar*(): GType = 
  result = calendarGetType()

proc calendar*(obj: pointer): PCalendar = 
  result = cast[PCalendar](checkCast(obj, typeCalendar()))

proc calendarClass*(klass: pointer): PCalendarClass = 
  result = cast[PCalendarClass](checkClassCast(klass, typeCalendar()))

proc isCalendar*(obj: pointer): bool = 
  result = checkType(obj, typeCalendar())

proc isCalendarClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCalendar())

proc calendarGetClass*(obj: pointer): PCalendarClass = 
  result = cast[PCalendarClass](checkGetClass(obj, typeCalendar()))

proc typeCellEditable*(): GType = 
  result = cellEditableGetType()

proc cellEditable*(obj: pointer): PCellEditable = 
  result = cast[PCellEditable](gTypeCheckInstanceCast(obj, 
      typeCellEditable()))

proc cellEditableClass*(obj: pointer): PCellEditableIface = 
  result = cast[PCellEditableIface](gTypeCheckClassCast(obj, 
      typeCellEditable()))

proc isCellEditable*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeCellEditable())

proc cellEditableGetIface*(obj: pointer): PCellEditableIface = 
  result = cast[PCellEditableIface](gTypeInstanceGetInterface(obj, 
      typeCellEditable()))

proc typeCellRenderer*(): GType = 
  result = cellRendererGetType()

proc cellRenderer*(obj: pointer): PCellRenderer = 
  result = cast[PCellRenderer](checkCast(obj, typeCellRenderer()))

proc cellRendererClass*(klass: pointer): PCellRendererClass = 
  result = cast[PCellRendererClass](checkClassCast(klass, typeCellRenderer()))

proc isCellRenderer*(obj: pointer): bool = 
  result = checkType(obj, typeCellRenderer())

proc isCellRendererClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCellRenderer())

proc cellRendererGetClass*(obj: pointer): PCellRendererClass = 
  result = cast[PCellRendererClass](checkGetClass(obj, typeCellRenderer()))

proc mode*(a: PCellRenderer): guint = 
  result = (a.CellRendererflag0 and bm_TGtkCellRenderer_mode) shr
      bp_TGtkCellRenderer_mode

proc setMode*(a: PCellRenderer, `mode`: guint) = 
  a.CellRendererflag0 = a.CellRendererflag0 or
      (Int16(`mode` shl bp_TGtkCellRenderer_mode) and
      bm_TGtkCellRenderer_mode)

proc visible*(a: PCellRenderer): guint = 
  result = (a.CellRendererflag0 and bm_TGtkCellRenderer_visible) shr
      bp_TGtkCellRenderer_visible

proc setVisible*(a: PCellRenderer, `visible`: guint) = 
  a.CellRendererflag0 = a.CellRendererflag0 or
      (Int16(`visible` shl bp_TGtkCellRenderer_visible) and
      bm_TGtkCellRenderer_visible)

proc isExpander*(a: PCellRenderer): guint = 
  result = (a.CellRendererflag0 and bm_TGtkCellRenderer_is_expander) shr
      bp_TGtkCellRenderer_is_expander

proc setIsExpander*(a: PCellRenderer, `is_expander`: guint) = 
  a.CellRendererflag0 = a.CellRendererflag0 or
      (Int16(`isExpander` shl bp_TGtkCellRenderer_is_expander) and
      bm_TGtkCellRenderer_is_expander)

proc isExpanded*(a: PCellRenderer): guint = 
  result = (a.CellRendererflag0 and bm_TGtkCellRenderer_is_expanded) shr
      bp_TGtkCellRenderer_is_expanded

proc setIsExpanded*(a: PCellRenderer, `is_expanded`: guint) = 
  a.CellRendererflag0 = a.CellRendererflag0 or
      (Int16(`isExpanded` shl bp_TGtkCellRenderer_is_expanded) and
      bm_TGtkCellRenderer_is_expanded)

proc cellBackgroundSet*(a: PCellRenderer): guint = 
  result = (a.CellRendererflag0 and bm_TGtkCellRenderer_cell_background_set) shr
      bp_TGtkCellRenderer_cell_background_set

proc setCellBackgroundSet*(a: PCellRenderer, `cell_background_set`: guint) = 
  a.CellRendererflag0 = a.CellRendererflag0 or
      (Int16(`cellBackgroundSet` shl
      bp_TGtkCellRenderer_cell_background_set) and
      bm_TGtkCellRenderer_cell_background_set)

proc typeCellRendererText*(): GType = 
  result = cellRendererTextGetType()

proc cellRendererText*(obj: pointer): PCellRendererText = 
  result = cast[PCellRendererText](checkCast(obj, typeCellRendererText()))

proc cellRendererTextClass*(klass: pointer): PCellRendererTextClass = 
  result = cast[PCellRendererTextClass](checkClassCast(klass, 
      typeCellRendererText()))

proc isCellRendererText*(obj: pointer): bool = 
  result = checkType(obj, typeCellRendererText())

proc isCellRendererTextClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCellRendererText())

proc cellRendererTextGetClass*(obj: pointer): PCellRendererTextClass = 
  result = cast[PCellRendererTextClass](checkGetClass(obj, 
      typeCellRendererText()))

proc strikethrough*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and bm_TGtkCellRendererText_strikethrough) shr
      bp_TGtkCellRendererText_strikethrough

proc setStrikethrough*(a: PCellRendererText, `strikethrough`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`strikethrough` shl bp_TGtkCellRendererText_strikethrough) and
      bm_TGtkCellRendererText_strikethrough)

proc editable*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and bm_TGtkCellRendererText_editable) shr
      bp_TGtkCellRendererText_editable

proc setEditable*(a: PCellRendererText, `editable`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`editable` shl bp_TGtkCellRendererText_editable) and
      bm_TGtkCellRendererText_editable)

proc scaleSet*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and bm_TGtkCellRendererText_scale_set) shr
      bp_TGtkCellRendererText_scale_set

proc setScaleSet*(a: PCellRendererText, `scale_set`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`scaleSet` shl bp_TGtkCellRendererText_scale_set) and
      bm_TGtkCellRendererText_scale_set)

proc foregroundSet*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and
      bm_TGtkCellRendererText_foreground_set) shr
      bp_TGtkCellRendererText_foreground_set

proc setForegroundSet*(a: PCellRendererText, `foreground_set`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`foregroundSet` shl bp_TGtkCellRendererText_foreground_set) and
      bm_TGtkCellRendererText_foreground_set)

proc backgroundSet*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and
      bm_TGtkCellRendererText_background_set) shr
      bp_TGtkCellRendererText_background_set

proc setBackgroundSet*(a: PCellRendererText, `background_set`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`backgroundSet` shl bp_TGtkCellRendererText_background_set) and
      bm_TGtkCellRendererText_background_set)

proc underlineSet*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and bm_TGtkCellRendererText_underline_set) shr
      bp_TGtkCellRendererText_underline_set

proc setUnderlineSet*(a: PCellRendererText, `underline_set`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`underlineSet` shl bp_TGtkCellRendererText_underline_set) and
      bm_TGtkCellRendererText_underline_set)

proc riseSet*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and bm_TGtkCellRendererText_rise_set) shr
      bp_TGtkCellRendererText_rise_set

proc setRiseSet*(a: PCellRendererText, `rise_set`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`riseSet` shl bp_TGtkCellRendererText_rise_set) and
      bm_TGtkCellRendererText_rise_set)

proc strikethroughSet*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and
      bm_TGtkCellRendererText_strikethrough_set) shr
      bp_TGtkCellRendererText_strikethrough_set

proc setStrikethroughSet*(a: PCellRendererText, `strikethrough_set`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`strikethroughSet` shl
      bp_TGtkCellRendererText_strikethrough_set) and
      bm_TGtkCellRendererText_strikethrough_set)

proc editableSet*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and bm_TGtkCellRendererText_editable_set) shr
      bp_TGtkCellRendererText_editable_set

proc setEditableSet*(a: PCellRendererText, `editable_set`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`editableSet` shl bp_TGtkCellRendererText_editable_set) and
      bm_TGtkCellRendererText_editable_set)

proc calcFixedHeight*(a: PCellRendererText): guint = 
  result = (a.CellRendererTextflag0 and
      bm_TGtkCellRendererText_calc_fixed_height) shr
      bp_TGtkCellRendererText_calc_fixed_height

proc setCalcFixedHeight*(a: PCellRendererText, `calc_fixed_height`: guint) = 
  a.CellRendererTextflag0 = a.CellRendererTextflag0 or
      (Int16(`calcFixedHeight` shl
      bp_TGtkCellRendererText_calc_fixed_height) and
      bm_TGtkCellRendererText_calc_fixed_height)

proc typeCellRendererToggle*(): GType = 
  result = cellRendererToggleGetType()

proc cellRendererToggle*(obj: pointer): PCellRendererToggle = 
  result = cast[PCellRendererToggle](checkCast(obj, typeCellRendererToggle()))

proc cellRendererToggleClass*(klass: pointer): PCellRendererToggleClass = 
  result = cast[PCellRendererToggleClass](checkClassCast(klass, 
      typeCellRendererToggle()))

proc isCellRendererToggle*(obj: pointer): bool = 
  result = checkType(obj, typeCellRendererToggle())

proc isCellRendererToggleClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCellRendererToggle())

proc cellRendererToggleGetClass*(obj: pointer): PCellRendererToggleClass = 
  result = cast[PCellRendererToggleClass](checkGetClass(obj, 
      typeCellRendererToggle()))

proc active*(a: PCellRendererToggle): guint = 
  result = (a.CellRendererToggleflag0 and bm_TGtkCellRendererToggle_active) shr
      bp_TGtkCellRendererToggle_active

proc setActive*(a: PCellRendererToggle, `active`: guint) = 
  a.CellRendererToggleflag0 = a.CellRendererToggleflag0 or
      (Int16(`active` shl bp_TGtkCellRendererToggle_active) and
      bm_TGtkCellRendererToggle_active)

proc activatable*(a: PCellRendererToggle): guint = 
  result = (a.CellRendererToggleflag0 and
      bm_TGtkCellRendererToggle_activatable) shr
      bp_TGtkCellRendererToggle_activatable

proc setActivatable*(a: PCellRendererToggle, `activatable`: guint) = 
  a.CellRendererToggleflag0 = a.CellRendererToggleflag0 or
      (Int16(`activatable` shl bp_TGtkCellRendererToggle_activatable) and
      bm_TGtkCellRendererToggle_activatable)

proc radio*(a: PCellRendererToggle): guint = 
  result = (a.CellRendererToggleflag0 and bm_TGtkCellRendererToggle_radio) shr
      bp_TGtkCellRendererToggle_radio

proc setRadio*(a: PCellRendererToggle, `radio`: guint) = 
  a.CellRendererToggleflag0 = a.CellRendererToggleflag0 or
      (Int16(`radio` shl bp_TGtkCellRendererToggle_radio) and
      bm_TGtkCellRendererToggle_radio)

proc typeCellRendererPixbuf*(): GType = 
  result = cellRendererPixbufGetType()

proc cellRendererPixbuf*(obj: pointer): PCellRendererPixbuf = 
  result = cast[PCellRendererPixbuf](checkCast(obj, typeCellRendererPixbuf()))

proc cellRendererPixbufClass*(klass: pointer): PCellRendererPixbufClass = 
  result = cast[PCellRendererPixbufClass](checkClassCast(klass, 
      typeCellRendererPixbuf()))

proc isCellRendererPixbuf*(obj: pointer): bool = 
  result = checkType(obj, typeCellRendererPixbuf())

proc isCellRendererPixbufClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCellRendererPixbuf())

proc cellRendererPixbufGetClass*(obj: pointer): PCellRendererPixbufClass = 
  result = cast[PCellRendererPixbufClass](checkGetClass(obj, 
      typeCellRendererPixbuf()))

proc typeItem*(): GType = 
  result = itemGetType()

proc item*(obj: pointer): PItem = 
  result = cast[PItem](checkCast(obj, typeItem()))

proc itemClass*(klass: pointer): PItemClass = 
  result = cast[PItemClass](checkClassCast(klass, typeItem()))

proc isItem*(obj: pointer): bool = 
  result = checkType(obj, typeItem())

proc isItemClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeItem())

proc itemGetClass*(obj: pointer): PItemClass = 
  result = cast[PItemClass](checkGetClass(obj, typeItem()))

proc typeMenuItem*(): GType = 
  result = menuItemGetType()

proc menuItem*(obj: pointer): PMenuItem = 
  result = cast[PMenuItem](checkCast(obj, typeMenuItem()))

proc menuItemClass*(klass: pointer): PMenuItemClass = 
  result = cast[PMenuItemClass](checkClassCast(klass, typeMenuItem()))

proc isMenuItem*(obj: pointer): bool = 
  result = checkType(obj, typeMenuItem())

proc isMenuItemClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeMenuItem())

proc menuItemGetClass*(obj: pointer): PMenuItemClass = 
  result = cast[PMenuItemClass](checkGetClass(obj, typeMenuItem()))

proc showSubmenuIndicator*(a: PMenuItem): guint = 
  result = (a.MenuItemflag0 and bm_TGtkMenuItem_show_submenu_indicator) shr
      bp_TGtkMenuItem_show_submenu_indicator

proc setShowSubmenuIndicator*(a: PMenuItem, 
                                 `show_submenu_indicator`: guint) = 
  a.MenuItemflag0 = a.MenuItemflag0 or
      (Int16(`showSubmenuIndicator` shl
      bp_TGtkMenuItem_show_submenu_indicator) and
      bm_TGtkMenuItem_show_submenu_indicator)

proc submenuPlacement*(a: PMenuItem): guint = 
  result = (a.MenuItemflag0 and bm_TGtkMenuItem_submenu_placement) shr
      bp_TGtkMenuItem_submenu_placement

proc setSubmenuPlacement*(a: PMenuItem, `submenu_placement`: guint) = 
  a.MenuItemflag0 = a.MenuItemflag0 or
      (Int16(`submenuPlacement` shl bp_TGtkMenuItem_submenu_placement) and
      bm_TGtkMenuItem_submenu_placement)

proc submenuDirection*(a: PMenuItem): guint = 
  result = (a.MenuItemflag0 and bm_TGtkMenuItem_submenu_direction) shr
      bp_TGtkMenuItem_submenu_direction

proc setSubmenuDirection*(a: PMenuItem, `submenu_direction`: guint) = 
  a.MenuItemflag0 = a.MenuItemflag0 or
      (Int16(`submenuDirection` shl bp_TGtkMenuItem_submenu_direction) and
      bm_TGtkMenuItem_submenu_direction)

proc rightJustify*(a: PMenuItem): guint = 
  result = (a.MenuItemflag0 and bm_TGtkMenuItem_right_justify) shr
      bp_TGtkMenuItem_right_justify

proc setRightJustify*(a: PMenuItem, `right_justify`: guint) = 
  a.MenuItemflag0 = a.MenuItemflag0 or
      (Int16(`rightJustify` shl bp_TGtkMenuItem_right_justify) and
      bm_TGtkMenuItem_right_justify)

proc timerFromKeypress*(a: PMenuItem): guint = 
  result = (a.MenuItemflag0 and bm_TGtkMenuItem_timer_from_keypress) shr
      bp_TGtkMenuItem_timer_from_keypress

proc setTimerFromKeypress*(a: PMenuItem, `timer_from_keypress`: guint) = 
  a.MenuItemflag0 = a.MenuItemflag0 or
      (Int16(`timerFromKeypress` shl bp_TGtkMenuItem_timer_from_keypress) and
      bm_TGtkMenuItem_timer_from_keypress)

proc hideOnActivate*(a: PMenuItemClass): guint = 
  result = (a.MenuItemClassflag0 and bm_TGtkMenuItemClass_hide_on_activate) shr
      bp_TGtkMenuItemClass_hide_on_activate

proc setHideOnActivate*(a: PMenuItemClass, `hide_on_activate`: guint) = 
  a.MenuItemClassflag0 = a.MenuItemClassflag0 or
      (Int16(`hideOnActivate` shl bp_TGtkMenuItemClass_hide_on_activate) and
      bm_TGtkMenuItemClass_hide_on_activate)

proc rightJustify*(menu_item: PMenuItem) = 
  setRightJustified(menuItem, system.true)

proc typeToggleButton*(): GType = 
  result = toggleButtonGetType()

proc toggleButton*(obj: pointer): PToggleButton = 
  result = cast[PToggleButton](checkCast(obj, typeToggleButton()))

proc toggleButtonClass*(klass: pointer): PToggleButtonClass = 
  result = cast[PToggleButtonClass](checkClassCast(klass, typeToggleButton()))

proc isToggleButton*(obj: pointer): bool = 
  result = checkType(obj, typeToggleButton())

proc isToggleButtonClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeToggleButton())

proc toggleButtonGetClass*(obj: pointer): PToggleButtonClass = 
  result = cast[PToggleButtonClass](checkGetClass(obj, typeToggleButton()))

proc active*(a: PToggleButton): guint = 
  result = (a.ToggleButtonflag0 and bm_TGtkToggleButton_active) shr
      bp_TGtkToggleButton_active

proc setActive*(a: PToggleButton, `active`: guint) = 
  a.ToggleButtonflag0 = a.ToggleButtonflag0 or
      (Int16(`active` shl bp_TGtkToggleButton_active) and
      bm_TGtkToggleButton_active)

proc drawIndicator*(a: PToggleButton): guint = 
  result = (a.ToggleButtonflag0 and bm_TGtkToggleButton_draw_indicator) shr
      bp_TGtkToggleButton_draw_indicator

proc setDrawIndicator*(a: PToggleButton, `draw_indicator`: guint) = 
  a.ToggleButtonflag0 = a.ToggleButtonflag0 or
      (Int16(`drawIndicator` shl bp_TGtkToggleButton_draw_indicator) and
      bm_TGtkToggleButton_draw_indicator)

proc inconsistent*(a: PToggleButton): guint = 
  result = (a.ToggleButtonflag0 and bm_TGtkToggleButton_inconsistent) shr
      bp_TGtkToggleButton_inconsistent

proc setInconsistent*(a: PToggleButton, `inconsistent`: guint) = 
  a.ToggleButtonflag0 = a.ToggleButtonflag0 or
      (Int16(`inconsistent` shl bp_TGtkToggleButton_inconsistent) and
      bm_TGtkToggleButton_inconsistent)

proc typeCheckButton*(): GType = 
  result = checkButtonGetType()

proc checkButton*(obj: pointer): PCheckButton = 
  result = cast[PCheckButton](checkCast(obj, typeCheckButton()))

proc checkButtonClass*(klass: pointer): PCheckButtonClass = 
  result = cast[PCheckButtonClass](checkClassCast(klass, typeCheckButton()))

proc isCheckButton*(obj: pointer): bool = 
  result = checkType(obj, typeCheckButton())

proc isCheckButtonClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCheckButton())

proc checkButtonGetClass*(obj: pointer): PCheckButtonClass = 
  result = cast[PCheckButtonClass](checkGetClass(obj, typeCheckButton()))

proc typeCheckMenuItem*(): GType = 
  result = checkMenuItemGetType()

proc checkMenuItem*(obj: pointer): PCheckMenuItem = 
  result = cast[PCheckMenuItem](checkCast(obj, typeCheckMenuItem()))

proc checkMenuItemClass*(klass: pointer): PCheckMenuItemClass = 
  result = cast[PCheckMenuItemClass](checkClassCast(klass, 
      typeCheckMenuItem()))

proc isCheckMenuItem*(obj: pointer): bool = 
  result = checkType(obj, typeCheckMenuItem())

proc isCheckMenuItemClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCheckMenuItem())

proc checkMenuItemGetClass*(obj: pointer): PCheckMenuItemClass = 
  result = cast[PCheckMenuItemClass](checkGetClass(obj, typeCheckMenuItem()))

proc active*(a: PCheckMenuItem): guint = 
  result = (a.CheckMenuItemflag0 and bm_TGtkCheckMenuItem_active) shr
      bp_TGtkCheckMenuItem_active

proc setActive*(a: PCheckMenuItem, `active`: guint) = 
  a.CheckMenuItemflag0 = a.CheckMenuItemflag0 or
      (Int16(`active` shl bp_TGtkCheckMenuItem_active) and
      bm_TGtkCheckMenuItem_active)

proc alwaysShowToggle*(a: PCheckMenuItem): guint = 
  result = (a.CheckMenuItemflag0 and bm_TGtkCheckMenuItem_always_show_toggle) shr
      bp_TGtkCheckMenuItem_always_show_toggle

proc setAlwaysShowToggle*(a: PCheckMenuItem, `always_show_toggle`: guint) = 
  a.CheckMenuItemflag0 = a.CheckMenuItemflag0 or
      (Int16(`alwaysShowToggle` shl bp_TGtkCheckMenuItem_always_show_toggle) and
      bm_TGtkCheckMenuItem_always_show_toggle)

proc inconsistent*(a: PCheckMenuItem): guint = 
  result = (a.CheckMenuItemflag0 and bm_TGtkCheckMenuItem_inconsistent) shr
      bp_TGtkCheckMenuItem_inconsistent

proc setInconsistent*(a: PCheckMenuItem, `inconsistent`: guint) = 
  a.CheckMenuItemflag0 = a.CheckMenuItemflag0 or
      (Int16(`inconsistent` shl bp_TGtkCheckMenuItem_inconsistent) and
      bm_TGtkCheckMenuItem_inconsistent)

proc typeClist*(): GType = 
  result = clistGetType()

proc clist*(obj: pointer): PCList = 
  result = cast[PCList](checkCast(obj, typeClist()))

proc clistClass*(klass: pointer): PCListClass = 
  result = cast[PCListClass](checkClassCast(klass, typeClist()))

proc isClist*(obj: pointer): bool = 
  result = checkType(obj, typeClist())

proc isClistClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeClist())

proc clistGetClass*(obj: pointer): PCListClass = 
  result = cast[PCListClass](checkGetClass(obj, typeClist()))

proc clistFlags*(clist: pointer): guint16 = 
  result = toU16(clist(clist).flags)

proc setFlag*(clist: PCList, flag: guint16) = 
  clist.flags = clist(clist).flags or (flag)

proc unsetFlag*(clist: PCList, flag: guint16) = 
  clist.flags = clist(clist).flags and not (flag)

proc cLISTINDRAGGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_IN_DRAG)) != 0'i32

proc cLISTROWHEIGHTSETGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_ROW_HEIGHT_SET)) != 0'i32

proc cLISTSHOWTITLESGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_SHOW_TITLES)) != 0'i32

proc cLISTADDMODEGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_ADD_MODE)) != 0'i32

proc cLISTAUTOSORTGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_AUTO_SORT)) != 0'i32

proc cLISTAUTORESIZEBLOCKEDGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_AUTO_RESIZE_BLOCKED)) != 0'i32

proc cLISTREORDERABLEGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_REORDERABLE)) != 0'i32

proc cLISTUSEDRAGICONSGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_USE_DRAG_ICONS)) != 0'i32

proc cLISTDRAWDRAGLINEGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_DRAW_DRAG_LINE)) != 0'i32

proc cLISTDRAWDRAGRECTGet*(clist: Pointer): Bool = 
  result = ((clistFlags(clist)) and Cint(CLIST_DRAW_DRAG_RECT)) != 0'i32

proc cLISTROWGet*(glist: PGList): PCListRow = 
  result = cast[PCListRow](glist.data)

when false: 
  proc CELL_TEXT_get*(cell: pointer): PCellText = 
    result = cast[PCellText](addr((cell)))

  proc CELL_PIXMAP_get*(cell: pointer): PCellPixmap = 
    result = cast[PCellPixmap](addr((cell)))

  proc CELL_PIXTEXT_get*(cell: pointer): PCellPixText = 
    result = cast[PCellPixText](addr((cell)))

  proc CELL_WIDGET_get*(cell: pointer): PCellWidget = 
    result = cast[PCellWidget](addr((cell)))

proc visible*(a: PCListColumn): guint = 
  result = (a.flag0 and bm_TGtkCListColumn_visible) shr
      bp_TGtkCListColumn_visible

proc setVisible*(a: PCListColumn, `visible`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`visible` shl bp_TGtkCListColumn_visible) and
      bm_TGtkCListColumn_visible)

proc widthSet*(a: PCListColumn): guint = 
  result = (a.flag0 and bm_TGtkCListColumn_width_set) shr
      bp_TGtkCListColumn_width_set

proc setWidthSet*(a: PCListColumn, `width_set`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`widthSet` shl bp_TGtkCListColumn_width_set) and
      bm_TGtkCListColumn_width_set)

proc resizeable*(a: PCListColumn): guint = 
  result = (a.flag0 and bm_TGtkCListColumn_resizeable) shr
      bp_TGtkCListColumn_resizeable

proc setResizeable*(a: PCListColumn, `resizeable`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`resizeable` shl bp_TGtkCListColumn_resizeable) and
      bm_TGtkCListColumn_resizeable)

proc autoResize*(a: PCListColumn): guint = 
  result = (a.flag0 and bm_TGtkCListColumn_auto_resize) shr
      bp_TGtkCListColumn_auto_resize

proc setAutoResize*(a: PCListColumn, `auto_resize`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`autoResize` shl bp_TGtkCListColumn_auto_resize) and
      bm_TGtkCListColumn_auto_resize)

proc buttonPassive*(a: PCListColumn): guint = 
  result = (a.flag0 and bm_TGtkCListColumn_button_passive) shr
      bp_TGtkCListColumn_button_passive

proc setButtonPassive*(a: PCListColumn, `button_passive`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`buttonPassive` shl bp_TGtkCListColumn_button_passive) and
      bm_TGtkCListColumn_button_passive)

proc fgSet*(a: PCListRow): guint = 
  result = (a.flag0 and bm_TGtkCListRow_fg_set) shr bp_TGtkCListRow_fg_set

proc setFgSet*(a: PCListRow, `fg_set`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`fgSet` shl bp_TGtkCListRow_fg_set) and bm_TGtkCListRow_fg_set)

proc bgSet*(a: PCListRow): guint = 
  result = (a.flag0 and bm_TGtkCListRow_bg_set) shr bp_TGtkCListRow_bg_set

proc setBgSet*(a: PCListRow, `bg_set`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`bgSet` shl bp_TGtkCListRow_bg_set) and bm_TGtkCListRow_bg_set)

proc selectable*(a: PCListRow): guint = 
  result = (a.flag0 and bm_TGtkCListRow_selectable) shr
      bp_TGtkCListRow_selectable

proc setSelectable*(a: PCListRow, `selectable`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`selectable` shl bp_TGtkCListRow_selectable) and
      bm_TGtkCListRow_selectable)

proc typeDialog*(): GType = 
  result = dialogGetType()

proc dialog*(obj: pointer): PDialog = 
  result = cast[PDialog](checkCast(obj, typeDialog()))

proc dialogClass*(klass: pointer): PDialogClass = 
  result = cast[PDialogClass](checkClassCast(klass, typeDialog()))

proc isDialog*(obj: pointer): bool = 
  result = checkType(obj, typeDialog())

proc isDialogClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeDialog())

proc dialogGetClass*(obj: pointer): PDialogClass = 
  result = cast[PDialogClass](checkGetClass(obj, typeDialog()))

proc typeVbox*(): GType = 
  result = vboxGetType()

proc vbox*(obj: pointer): PVBox = 
  result = cast[PVBox](checkCast(obj, typeVbox()))

proc vboxClass*(klass: pointer): PVBoxClass = 
  result = cast[PVBoxClass](checkClassCast(klass, typeVbox()))

proc isVbox*(obj: pointer): bool = 
  result = checkType(obj, typeVbox())

proc isVboxClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeVbox())

proc vboxGetClass*(obj: pointer): PVBoxClass = 
  result = cast[PVBoxClass](checkGetClass(obj, typeVbox()))

proc typeColorSelection*(): GType = 
  result = colorSelectionGetType()

proc colorSelection*(obj: pointer): PColorSelection = 
  result = cast[PColorSelection](checkCast(obj, typeColorSelection()))

proc colorSelectionClass*(klass: pointer): PColorSelectionClass = 
  result = cast[PColorSelectionClass](checkClassCast(klass, 
      typeColorSelection()))

proc isColorSelection*(obj: pointer): bool = 
  result = checkType(obj, typeColorSelection())

proc isColorSelectionClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeColorSelection())

proc colorSelectionGetClass*(obj: pointer): PColorSelectionClass = 
  result = cast[PColorSelectionClass](checkGetClass(obj, 
      typeColorSelection()))

proc typeColorSelectionDialog*(): GType = 
  result = colorSelectionDialogGetType()

proc colorSelectionDialog*(obj: pointer): PColorSelectionDialog = 
  result = cast[PColorSelectionDialog](checkCast(obj, 
      typeColorSelectionDialog()))

proc colorSelectionDialogClass*(klass: pointer): PColorSelectionDialogClass = 
  result = cast[PColorSelectionDialogClass](checkClassCast(klass, 
      typeColorSelectionDialog()))

proc isColorSelectionDialog*(obj: pointer): bool = 
  result = checkType(obj, typeColorSelectionDialog())

proc isColorSelectionDialogClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeColorSelectionDialog())

proc colorSelectionDialogGetClass*(obj: pointer): PColorSelectionDialogClass = 
  result = cast[PColorSelectionDialogClass](checkGetClass(obj, 
      typeColorSelectionDialog()))

proc typeHbox*(): GType = 
  result = hboxGetType()

proc hbox*(obj: pointer): PHBox = 
  result = cast[PHBox](checkCast(obj, typeHbox()))

proc hboxClass*(klass: pointer): PHBoxClass = 
  result = cast[PHBoxClass](checkClassCast(klass, typeHbox()))

proc isHbox*(obj: pointer): bool = 
  result = checkType(obj, typeHbox())

proc isHboxClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeHbox())

proc hboxGetClass*(obj: pointer): PHBoxClass = 
  result = cast[PHBoxClass](checkGetClass(obj, typeHbox()))

proc typeCombo*(): GType = 
  result = comboGetType()

proc combo*(obj: pointer): PCombo = 
  result = cast[PCombo](checkCast(obj, typeCombo()))

proc comboClass*(klass: pointer): PComboClass = 
  result = cast[PComboClass](checkClassCast(klass, typeCombo()))

proc isCombo*(obj: pointer): bool = 
  result = checkType(obj, typeCombo())

proc isComboClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCombo())

proc comboGetClass*(obj: pointer): PComboClass = 
  result = cast[PComboClass](checkGetClass(obj, typeCombo()))

proc valueInList*(a: PCombo): guint = 
  result = (a.Comboflag0 and bm_TGtkCombo_value_in_list) shr
      bp_TGtkCombo_value_in_list

proc setValueInList*(a: PCombo, `value_in_list`: guint) = 
  a.Comboflag0 = a.Comboflag0 or
      (Int16(`valueInList` shl bp_TGtkCombo_value_in_list) and
      bm_TGtkCombo_value_in_list)

proc okIfEmpty*(a: PCombo): guint = 
  result = (a.Comboflag0 and bm_TGtkCombo_ok_if_empty) shr
      bp_TGtkCombo_ok_if_empty

proc setOkIfEmpty*(a: PCombo, `ok_if_empty`: guint) = 
  a.Comboflag0 = a.Comboflag0 or
      (Int16(`okIfEmpty` shl bp_TGtkCombo_ok_if_empty) and
      bm_TGtkCombo_ok_if_empty)

proc caseSensitive*(a: PCombo): guint = 
  result = (a.Comboflag0 and bm_TGtkCombo_case_sensitive) shr
      bp_TGtkCombo_case_sensitive

proc setCaseSensitive*(a: PCombo, `case_sensitive`: guint) = 
  a.Comboflag0 = a.Comboflag0 or
      (Int16(`caseSensitive` shl bp_TGtkCombo_case_sensitive) and
      bm_TGtkCombo_case_sensitive)

proc useArrows*(a: PCombo): guint = 
  result = (a.Comboflag0 and bm_TGtkCombo_use_arrows) shr
      bp_TGtkCombo_use_arrows

proc setUseArrows*(a: PCombo, `use_arrows`: guint) = 
  a.Comboflag0 = a.Comboflag0 or
      (Int16(`useArrows` shl bp_TGtkCombo_use_arrows) and
      bm_TGtkCombo_use_arrows)

proc useArrowsAlways*(a: PCombo): guint = 
  result = (a.Comboflag0 and bm_TGtkCombo_use_arrows_always) shr
      bp_TGtkCombo_use_arrows_always

proc setUseArrowsAlways*(a: PCombo, `use_arrows_always`: guint) = 
  a.Comboflag0 = a.Comboflag0 or
      (Int16(`useArrowsAlways` shl bp_TGtkCombo_use_arrows_always) and
      bm_TGtkCombo_use_arrows_always)

proc typeCtree*(): GType = 
  result = ctreeGetType()

proc ctree*(obj: pointer): PCTree = 
  result = cast[PCTree](checkCast(obj, typeCtree()))

proc ctreeClass*(klass: pointer): PCTreeClass = 
  result = cast[PCTreeClass](checkClassCast(klass, typeCtree()))

proc isCtree*(obj: pointer): bool = 
  result = checkType(obj, typeCtree())

proc isCtreeClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCtree())

proc ctreeGetClass*(obj: pointer): PCTreeClass = 
  result = cast[PCTreeClass](checkGetClass(obj, typeCtree()))

proc ctreeRow*(node: TAddress): PCTreeRow = 
  result = cast[PCTreeRow]((cast[PGList](node)).data)

proc ctreeNode*(node: TAddress): PCTreeNode = 
  result = cast[PCTreeNode](node)

proc ctreeNodeNext*(nnode: TAddress): PCTreeNode = 
  result = cast[PCTreeNode]((cast[PGList](nnode)).next)

proc ctreeNodePrev*(pnode: TAddress): PCTreeNode = 
  result = cast[PCTreeNode]((cast[PGList](pnode)).prev)

proc ctreeFunc*(fun: TAddress): TCTreeFunc = 
  result = cast[TCTreeFunc](fun)

proc typeCtreeNode*(): GType = 
  result = ctreeNodeGetType()

proc lineStyle*(a: PCTree): guint = 
  result = (a.CTreeflag0 and bm_TGtkCTree_line_style) shr
      bp_TGtkCTree_line_style

proc setLineStyle*(a: PCTree, `line_style`: guint) = 
  a.CTreeflag0 = a.CTreeflag0 or
      (Int16(`lineStyle` shl bp_TGtkCTree_line_style) and
      bm_TGtkCTree_line_style)

proc expanderStyle*(a: PCTree): guint = 
  result = (a.CTreeflag0 and bm_TGtkCTree_expander_style) shr
      bp_TGtkCTree_expander_style

proc setExpanderStyle*(a: PCTree, `expander_style`: guint) = 
  a.CTreeflag0 = a.CTreeflag0 or
      (Int16(`expanderStyle` shl bp_TGtkCTree_expander_style) and
      bm_TGtkCTree_expander_style)

proc showStub*(a: PCTree): guint = 
  result = (a.CTreeflag0 and bm_TGtkCTree_show_stub) shr
      bp_TGtkCTree_show_stub

proc setShowStub*(a: PCTree, `show_stub`: guint) = 
  a.CTreeflag0 = a.CTreeflag0 or
      (Int16(`showStub` shl bp_TGtkCTree_show_stub) and
      bm_TGtkCTree_show_stub)

proc isLeaf*(a: PCTreeRow): guint = 
  result = (a.CTreeRow_flag0 and bm_TGtkCTreeRow_is_leaf) shr
      bp_TGtkCTreeRow_is_leaf

proc setIsLeaf*(a: PCTreeRow, `is_leaf`: guint) = 
  a.CTreeRow_flag0 = a.CTreeRow_flag0 or
      (Int16(`isLeaf` shl bp_TGtkCTreeRow_is_leaf) and
      bm_TGtkCTreeRow_is_leaf)

proc expanded*(a: PCTreeRow): guint = 
  result = (a.CTreeRow_flag0 and bm_TGtkCTreeRow_expanded) shr
      bp_TGtkCTreeRow_expanded

proc setExpanded*(a: PCTreeRow, `expanded`: guint) = 
  a.CTreeRow_flag0 = a.CTreeRowflag0 or
      (Int16(`expanded` shl bp_TGtkCTreeRow_expanded) and
      bm_TGtkCTreeRow_expanded)

proc ctreeSetReorderable*(t: pointer, r: bool) = 
  setReorderable(cast[PCList](t), r)

proc typeDrawingArea*(): GType = 
  result = drawingAreaGetType()

proc drawingArea*(obj: pointer): PDrawingArea = 
  result = cast[PDrawingArea](checkCast(obj, typeDrawingArea()))

proc drawingAreaClass*(klass: pointer): PDrawingAreaClass = 
  result = cast[PDrawingAreaClass](checkClassCast(klass, typeDrawingArea()))

proc isDrawingArea*(obj: pointer): bool = 
  result = checkType(obj, typeDrawingArea())

proc isDrawingAreaClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeDrawingArea())

proc drawingAreaGetClass*(obj: pointer): PDrawingAreaClass = 
  result = cast[PDrawingAreaClass](checkGetClass(obj, typeDrawingArea()))

proc typeCurve*(): GType = 
  result = curveGetType()

proc curve*(obj: pointer): PCurve = 
  result = cast[PCurve](checkCast(obj, typeCurve()))

proc curveClass*(klass: pointer): PCurveClass = 
  result = cast[PCurveClass](checkClassCast(klass, typeCurve()))

proc isCurve*(obj: pointer): bool = 
  result = checkType(obj, typeCurve())

proc isCurveClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeCurve())

proc curveGetClass*(obj: pointer): PCurveClass = 
  result = cast[PCurveClass](checkGetClass(obj, typeCurve()))

proc typeEditable*(): GType = 
  result = editableGetType()

proc editable*(obj: pointer): PEditable = 
  result = cast[PEditable](gTypeCheckInstanceCast(obj, typeEditable()))

proc editableClass*(vtable: pointer): PEditableClass = 
  result = cast[PEditableClass](gTypeCheckClassCast(vtable, typeEditable()))

proc isEditable*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeEditable())

proc isEditableClass*(vtable: pointer): bool = 
  result = gTypeCheckClassType(vtable, typeEditable())

proc editableGetClass*(inst: pointer): PEditableClass = 
  result = cast[PEditableClass](gTypeInstanceGetInterface(inst, 
      typeEditable()))

proc typeImContext*(): GType = 
  result = imContextGetType()

proc imContext*(obj: pointer): PIMContext = 
  result = cast[PIMContext](checkCast(obj, typeImContext()))

proc imContextClass*(klass: pointer): PIMContextClass = 
  result = cast[PIMContextClass](checkClassCast(klass, typeImContext()))

proc isImContext*(obj: pointer): bool = 
  result = checkType(obj, typeImContext())

proc isImContextClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeImContext())

proc imContextGetClass*(obj: pointer): PIMContextClass = 
  result = cast[PIMContextClass](checkGetClass(obj, typeImContext()))

proc typeMenuShell*(): GType = 
  result = menuShellGetType()

proc menuShell*(obj: pointer): PMenuShell = 
  result = cast[PMenuShell](checkCast(obj, typeMenuShell()))

proc menuShellClass*(klass: pointer): PMenuShellClass = 
  result = cast[PMenuShellClass](checkClassCast(klass, typeMenuShell()))

proc isMenuShell*(obj: pointer): bool = 
  result = checkType(obj, typeMenuShell())

proc isMenuShellClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeMenuShell())

proc menuShellGetClass*(obj: pointer): PMenuShellClass = 
  result = cast[PMenuShellClass](checkGetClass(obj, typeMenuShell()))

proc active*(a: PMenuShell): guint = 
  result = (a.MenuShellflag0 and bm_TGtkMenuShell_active) shr
      bp_TGtkMenuShell_active

proc setActive*(a: PMenuShell, `active`: guint) = 
  a.MenuShellflag0 = a.MenuShellflag0 or
      (Int16(`active` shl bp_TGtkMenuShell_active) and
      bm_TGtkMenuShell_active)

proc haveGrab*(a: PMenuShell): guint = 
  result = (a.MenuShellflag0 and bm_TGtkMenuShell_have_grab) shr
      bp_TGtkMenuShell_have_grab

proc setHaveGrab*(a: PMenuShell, `have_grab`: guint) = 
  a.MenuShellflag0 = a.MenuShellflag0 or
      (Int16(`haveGrab` shl bp_TGtkMenuShell_have_grab) and
      bm_TGtkMenuShell_have_grab)

proc haveXgrab*(a: PMenuShell): guint = 
  result = (a.MenuShellflag0 and bm_TGtkMenuShell_have_xgrab) shr
      bp_TGtkMenuShell_have_xgrab

proc setHaveXgrab*(a: PMenuShell, `have_xgrab`: guint) = 
  a.MenuShellflag0 = a.MenuShellflag0 or
      (Int16(`haveXgrab` shl bp_TGtkMenuShell_have_xgrab) and
      bm_TGtkMenuShell_have_xgrab)

proc ignoreLeave*(a: PMenuShell): guint = 
  result = (a.MenuShellflag0 and bm_TGtkMenuShell_ignore_leave) shr
      bp_TGtkMenuShell_ignore_leave

proc setIgnoreLeave*(a: PMenuShell, `ignore_leave`: guint) = 
  a.MenuShellflag0 = a.MenuShellflag0 or
      (Int16(`ignoreLeave` shl bp_TGtkMenuShell_ignore_leave) and
      bm_TGtkMenuShell_ignore_leave)

proc menuFlag*(a: PMenuShell): guint = 
  result = (a.MenuShellflag0 and bm_TGtkMenuShell_menu_flag) shr
      bp_TGtkMenuShell_menu_flag

proc setMenuFlag*(a: PMenuShell, `menu_flag`: guint) = 
  a.MenuShellflag0 = a.MenuShellflag0 or
      (Int16(`menuFlag` shl bp_TGtkMenuShell_menu_flag) and
      bm_TGtkMenuShell_menu_flag)

proc ignoreEnter*(a: PMenuShell): guint = 
  result = (a.MenuShellflag0 and bm_TGtkMenuShell_ignore_enter) shr
      bp_TGtkMenuShell_ignore_enter

proc setIgnoreEnter*(a: PMenuShell, `ignore_enter`: guint) = 
  a.MenuShellflag0 = a.MenuShellflag0 or
      (Int16(`ignoreEnter` shl bp_TGtkMenuShell_ignore_enter) and
      bm_TGtkMenuShell_ignore_enter)

proc submenuPlacement*(a: PMenuShellClass): guint = 
  result = (a.MenuShellClassflag0 and bm_TGtkMenuShellClass_submenu_placement) shr
      bp_TGtkMenuShellClass_submenu_placement

proc setSubmenuPlacement*(a: PMenuShellClass, `submenu_placement`: guint) = 
  a.MenuShellClassflag0 = a.MenuShellClassflag0 or
      (Int16(`submenuPlacement` shl bp_TGtkMenuShellClass_submenu_placement) and
      bm_TGtkMenuShellClass_submenu_placement)

proc typeMenu*(): GType = 
  result = menuGetType()

proc menu*(obj: pointer): PMenu = 
  result = cast[PMenu](checkCast(obj, typeMenu()))

proc menuClass*(klass: pointer): PMenuClass = 
  result = cast[PMenuClass](checkClassCast(klass, typeMenu()))

proc isMenu*(obj: pointer): bool = 
  result = checkType(obj, typeMenu())

proc isMenuClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeMenu())

proc menuGetClass*(obj: pointer): PMenuClass = 
  result = cast[PMenuClass](checkGetClass(obj, typeMenu()))

proc needsDestructionRefCount*(a: PMenu): guint = 
  result = (a.Menuflag0 and bm_TGtkMenu_needs_destruction_ref_count) shr
      bp_TGtkMenu_needs_destruction_ref_count

proc setNeedsDestructionRefCount*(a: PMenu, 
                                      `needs_destruction_ref_count`: guint) = 
  a.Menuflag0 = a.Menuflag0 or
      (Int16(`needsDestructionRefCount` shl
      bp_TGtkMenu_needs_destruction_ref_count) and
      bm_TGtkMenu_needs_destruction_ref_count)

proc tornOff*(a: PMenu): guint = 
  result = (a.Menuflag0 and bm_TGtkMenu_torn_off) shr bp_TGtkMenu_torn_off

proc setTornOff*(a: PMenu, `torn_off`: guint) = 
  a.Menuflag0 = a.Menuflag0 or
      (Int16(`tornOff` shl bp_TGtkMenu_torn_off) and bm_TGtkMenu_torn_off)

proc tearoffActive*(a: PMenu): guint = 
  result = (a.Menuflag0 and bm_TGtkMenu_tearoff_active) shr
      bp_TGtkMenu_tearoff_active

proc setTearoffActive*(a: PMenu, `tearoff_active`: guint) = 
  a.Menuflag0 = a.Menuflag0 or
      (Int16(`tearoffActive` shl bp_TGtkMenu_tearoff_active) and
      bm_TGtkMenu_tearoff_active)

proc scrollFast*(a: PMenu): guint = 
  result = (a.Menuflag0 and bm_TGtkMenu_scroll_fast) shr
      bp_TGtkMenu_scroll_fast

proc setScrollFast*(a: PMenu, `scroll_fast`: guint) = 
  a.Menuflag0 = a.Menuflag0 or
      (Int16(`scrollFast` shl bp_TGtkMenu_scroll_fast) and
      bm_TGtkMenu_scroll_fast)

proc upperArrowVisible*(a: PMenu): guint = 
  result = (a.Menuflag0 and bm_TGtkMenu_upper_arrow_visible) shr
      bp_TGtkMenu_upper_arrow_visible

proc setUpperArrowVisible*(a: PMenu, `upper_arrow_visible`: guint) = 
  a.Menuflag0 = a.Menuflag0 or
      (Int16(`upperArrowVisible` shl bp_TGtkMenu_upper_arrow_visible) and
      bm_TGtkMenu_upper_arrow_visible)

proc lowerArrowVisible*(a: PMenu): guint = 
  result = (a.Menuflag0 and bm_TGtkMenu_lower_arrow_visible) shr
      bp_TGtkMenu_lower_arrow_visible

proc setLowerArrowVisible*(a: PMenu, `lower_arrow_visible`: guint) = 
  a.Menuflag0 = a.Menuflag0 or
      (Int16(`lowerArrowVisible` shl bp_TGtkMenu_lower_arrow_visible) and
      bm_TGtkMenu_lower_arrow_visible)

proc upperArrowPrelight*(a: PMenu): guint = 
  result = (a.Menuflag0 and bm_TGtkMenu_upper_arrow_prelight) shr
      bp_TGtkMenu_upper_arrow_prelight

proc setUpperArrowPrelight*(a: PMenu, `upper_arrow_prelight`: guint) = 
  a.Menuflag0 = a.Menuflag0 or
      (Int16(`upperArrowPrelight` shl bp_TGtkMenu_upper_arrow_prelight) and
      bm_TGtkMenu_upper_arrow_prelight)

proc lowerArrowPrelight*(a: PMenu): guint = 
  result = (a.Menuflag0 and bm_TGtkMenu_lower_arrow_prelight) shr
      bp_TGtkMenu_lower_arrow_prelight

proc setLowerArrowPrelight*(a: PMenu, `lower_arrow_prelight`: guint) = 
  a.Menuflag0 = a.Menuflag0 or
      (Int16(`lowerArrowPrelight` shl bp_TGtkMenu_lower_arrow_prelight) and
      bm_TGtkMenu_lower_arrow_prelight)

proc menuAppend*(menu, child: PWidget) = 
  append(cast[PMenuShell](menu), child)

proc menuPrepend*(menu, child: PWidget) = 
  prepend(cast[PMenuShell](menu), child)

proc menuInsert*(menu, child: PWidget, pos: Gint) = 
  insert(cast[PMenuShell](menu), child, pos)

proc typeEntry*(): GType = 
  result = entryGetType()

proc entry*(obj: pointer): PEntry = 
  result = cast[PEntry](checkCast(obj, typeEntry()))

proc entryClass*(klass: pointer): PEntryClass = 
  result = cast[PEntryClass](checkClassCast(klass, typeEntry()))

proc isEntry*(obj: pointer): bool = 
  result = checkType(obj, typeEntry())

proc isEntryClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeEntry())

proc entryGetClass*(obj: pointer): PEntryClass = 
  result = cast[PEntryClass](checkGetClass(obj, typeEntry()))

proc editable*(a: PEntry): guint = 
  result = (a.Entryflag0 and bm_TGtkEntry_editable) shr bp_TGtkEntry_editable

proc setEditable*(a: PEntry, `editable`: guint) = 
  a.Entryflag0 = a.Entryflag0 or
      (Int16(`editable` shl bp_TGtkEntry_editable) and bm_TGtkEntry_editable)

proc visible*(a: PEntry): guint = 
  result = (a.Entryflag0 and bm_TGtkEntry_visible) shr bp_TGtkEntry_visible

proc setVisible*(a: PEntry, `visible`: guint) = 
  a.Entryflag0 = a.Entryflag0 or
      (Int16(`visible` shl bp_TGtkEntry_visible) and bm_TGtkEntry_visible)

proc overwriteMode*(a: PEntry): guint = 
  result = (a.Entryflag0 and bm_TGtkEntry_overwrite_mode) shr
      bp_TGtkEntry_overwrite_mode

proc setOverwriteMode*(a: PEntry, `overwrite_mode`: guint) = 
  a.Entryflag0 = a.Entryflag0 or
      (Int16(`overwriteMode` shl bp_TGtkEntry_overwrite_mode) and
      bm_TGtkEntry_overwrite_mode)

proc inDrag*(a: PEntry): guint = 
  result = (a.Entryflag0 and bm_TGtkEntry_in_drag) shr bp_TGtkEntry_in_drag

proc setInDrag*(a: PEntry, `in_drag`: guint) = 
  a.Entryflag0 = a.Entryflag0 or
      (Int16(`inDrag` shl bp_TGtkEntry_in_drag) and bm_TGtkEntry_in_drag)

proc cacheIncludesPreedit*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_cache_includes_preedit) shr
      bp_TGtkEntry_cache_includes_preedit

proc setCacheIncludesPreedit*(a: PEntry, `cache_includes_preedit`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`cacheIncludesPreedit` shl bp_TGtkEntry_cache_includes_preedit) and
      bm_TGtkEntry_cache_includes_preedit)

proc needImReset*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_need_im_reset) shr
      bp_TGtkEntry_need_im_reset

proc setNeedImReset*(a: PEntry, `need_im_reset`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`needImReset` shl bp_TGtkEntry_need_im_reset) and
      bm_TGtkEntry_need_im_reset)

proc hasFrame*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_has_frame) shr bp_TGtkEntry_has_frame

proc setHasFrame*(a: PEntry, `has_frame`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`hasFrame` shl bp_TGtkEntry_has_frame) and
      bm_TGtkEntry_has_frame)

proc activatesDefault*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_activates_default) shr
      bp_TGtkEntry_activates_default

proc setActivatesDefault*(a: PEntry, `activates_default`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`activatesDefault` shl bp_TGtkEntry_activates_default) and
      bm_TGtkEntry_activates_default)

proc cursorVisible*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_cursor_visible) shr
      bp_TGtkEntry_cursor_visible

proc setCursorVisible*(a: PEntry, `cursor_visible`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`cursorVisible` shl bp_TGtkEntry_cursor_visible) and
      bm_TGtkEntry_cursor_visible)

proc inClick*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_in_click) shr bp_TGtkEntry_in_click

proc setInClick*(a: PEntry, `in_click`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`inClick` shl bp_TGtkEntry_in_click) and bm_TGtkEntry_in_click)

proc isCellRenderer*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_is_cell_renderer) shr
      bp_TGtkEntry_is_cell_renderer

proc setIsCellRenderer*(a: PEntry, `is_cell_renderer`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`isCellRenderer` shl bp_TGtkEntry_is_cell_renderer) and
      bm_TGtkEntry_is_cell_renderer)

proc editingCanceled*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_editing_canceled) shr
      bp_TGtkEntry_editing_canceled

proc setEditingCanceled*(a: PEntry, `editing_canceled`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`editingCanceled` shl bp_TGtkEntry_editing_canceled) and
      bm_TGtkEntry_editing_canceled)

proc mouseCursorObscured*(a: PEntry): guint = 
  result = (a.flag1 and bm_TGtkEntry_mouse_cursor_obscured) shr
      bp_TGtkEntry_mouse_cursor_obscured

proc setMouseCursorObscured*(a: PEntry, `mouse_cursor_obscured`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`mouseCursorObscured` shl bp_TGtkEntry_mouse_cursor_obscured) and
      bm_TGtkEntry_mouse_cursor_obscured)

proc typeEventBox*(): GType = 
  result = eventBoxGetType()

proc eventBox*(obj: pointer): PEventBox = 
  result = cast[PEventBox](checkCast(obj, typeEventBox()))

proc eventBoxClass*(klass: pointer): PEventBoxClass = 
  result = cast[PEventBoxClass](checkClassCast(klass, typeEventBox()))

proc isEventBox*(obj: pointer): bool = 
  result = checkType(obj, typeEventBox())

proc isEventBoxClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeEventBox())

proc eventBoxGetClass*(obj: pointer): PEventBoxClass = 
  result = cast[PEventBoxClass](checkGetClass(obj, typeEventBox()))

proc typeFileSelection*(): GType = 
  result = fileSelectionGetType()

proc fileSelection*(obj: pointer): PFileSelection = 
  result = cast[PFileSelection](checkCast(obj, typeFileSelection()))

proc fileSelectionClass*(klass: pointer): PFileSelectionClass = 
  result = cast[PFileSelectionClass](checkClassCast(klass, 
      typeFileSelection()))

proc isFileSelection*(obj: pointer): bool = 
  result = checkType(obj, typeFileSelection())

proc isFileSelectionClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeFileSelection())

proc fileSelectionGetClass*(obj: pointer): PFileSelectionClass = 
  result = cast[PFileSelectionClass](checkGetClass(obj, typeFileSelection()))

proc typeFixed*(): GType = 
  result = fixedGetType()

proc fixed*(obj: pointer): PFixed = 
  result = cast[PFixed](checkCast(obj, typeFixed()))

proc fixedClass*(klass: pointer): PFixedClass = 
  result = cast[PFixedClass](checkClassCast(klass, typeFixed()))

proc isFixed*(obj: pointer): bool = 
  result = checkType(obj, typeFixed())

proc isFixedClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeFixed())

proc fixedGetClass*(obj: pointer): PFixedClass = 
  result = cast[PFixedClass](checkGetClass(obj, typeFixed()))

proc typeFontSelection*(): GType = 
  result = fontSelectionGetType()

proc fontSelection*(obj: pointer): PFontSelection = 
  result = cast[PFontSelection](checkCast(obj, typeFontSelection()))

proc fontSelectionClass*(klass: pointer): PFontSelectionClass = 
  result = cast[PFontSelectionClass](checkClassCast(klass, 
      typeFontSelection()))

proc isFontSelection*(obj: pointer): bool = 
  result = checkType(obj, typeFontSelection())

proc isFontSelectionClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeFontSelection())

proc fontSelectionGetClass*(obj: pointer): PFontSelectionClass = 
  result = cast[PFontSelectionClass](checkGetClass(obj, typeFontSelection()))

proc typeFontSelectionDialog*(): GType = 
  result = fontSelectionDialogGetType()

proc fontSelectionDialog*(obj: pointer): PFontSelectionDialog = 
  result = cast[PFontSelectionDialog](checkCast(obj, 
      typeFontSelectionDialog()))

proc fontSelectionDialogClass*(klass: pointer): PFontSelectionDialogClass = 
  result = cast[PFontSelectionDialogClass](checkClassCast(klass, 
      typeFontSelectionDialog()))

proc isFontSelectionDialog*(obj: pointer): bool = 
  result = checkType(obj, typeFontSelectionDialog())

proc isFontSelectionDialogClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeFontSelectionDialog())

proc fontSelectionDialogGetClass*(obj: pointer): PFontSelectionDialogClass = 
  result = cast[PFontSelectionDialogClass](checkGetClass(obj, 
      typeFontSelectionDialog()))

proc typeGammaCurve*(): GType = 
  result = gammaCurveGetType()

proc gammaCurve*(obj: pointer): PGammaCurve = 
  result = cast[PGammaCurve](checkCast(obj, typeGammaCurve()))

proc gammaCurveClass*(klass: pointer): PGammaCurveClass = 
  result = cast[PGammaCurveClass](checkClassCast(klass, typeGammaCurve()))

proc isGammaCurve*(obj: pointer): bool = 
  result = checkType(obj, typeGammaCurve())

proc isGammaCurveClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeGammaCurve())

proc gammaCurveGetClass*(obj: pointer): PGammaCurveClass = 
  result = cast[PGammaCurveClass](checkGetClass(obj, typeGammaCurve()))

proc typeHandleBox*(): GType = 
  result = handleBoxGetType()

proc handleBox*(obj: pointer): PHandleBox = 
  result = cast[PHandleBox](checkCast(obj, typeHandleBox()))

proc handleBoxClass*(klass: pointer): PHandleBoxClass = 
  result = cast[PHandleBoxClass](checkClassCast(klass, typeHandleBox()))

proc isHandleBox*(obj: pointer): bool = 
  result = checkType(obj, typeHandleBox())

proc isHandleBoxClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeHandleBox())

proc handleBoxGetClass*(obj: pointer): PHandleBoxClass = 
  result = cast[PHandleBoxClass](checkGetClass(obj, typeHandleBox()))

proc handlePosition*(a: PHandleBox): guint = 
  result = (a.HandleBoxflag0 and bm_TGtkHandleBox_handle_position) shr
      bp_TGtkHandleBox_handle_position

proc setHandlePosition*(a: PHandleBox, `handle_position`: guint) = 
  a.HandleBoxflag0 = a.HandleBoxflag0 or
      (Int16(`handlePosition` shl bp_TGtkHandleBox_handle_position) and
      bm_TGtkHandleBox_handle_position)

proc floatWindowMapped*(a: PHandleBox): guint = 
  result = (a.HandleBoxflag0 and bm_TGtkHandleBox_float_window_mapped) shr
      bp_TGtkHandleBox_float_window_mapped

proc setFloatWindowMapped*(a: PHandleBox, `float_window_mapped`: guint) = 
  a.HandleBoxflag0 = a.HandleBoxflag0 or
      (Int16(`floatWindowMapped` shl bp_TGtkHandleBox_float_window_mapped) and
      bm_TGtkHandleBox_float_window_mapped)

proc childDetached*(a: PHandleBox): guint = 
  result = (a.HandleBoxflag0 and bm_TGtkHandleBox_child_detached) shr
      bp_TGtkHandleBox_child_detached

proc setChildDetached*(a: PHandleBox, `child_detached`: guint) = 
  a.HandleBoxflag0 = a.HandleBoxflag0 or
      (Int16(`childDetached` shl bp_TGtkHandleBox_child_detached) and
      bm_TGtkHandleBox_child_detached)

proc inDrag*(a: PHandleBox): guint = 
  result = (a.HandleBoxflag0 and bm_TGtkHandleBox_in_drag) shr
      bp_TGtkHandleBox_in_drag

proc setInDrag*(a: PHandleBox, `in_drag`: guint) = 
  a.HandleBoxflag0 = a.HandleBoxflag0 or
      (Int16(`inDrag` shl bp_TGtkHandleBox_in_drag) and
      bm_TGtkHandleBox_in_drag)

proc shrinkOnDetach*(a: PHandleBox): guint = 
  result = (a.HandleBoxflag0 and bm_TGtkHandleBox_shrink_on_detach) shr
      bp_TGtkHandleBox_shrink_on_detach

proc setShrinkOnDetach*(a: PHandleBox, `shrink_on_detach`: guint) = 
  a.HandleBoxflag0 = a.HandleBoxflag0 or
      (Int16(`shrinkOnDetach` shl bp_TGtkHandleBox_shrink_on_detach) and
      bm_TGtkHandleBox_shrink_on_detach)

proc snapEdge*(a: PHandleBox): gint = 
  result = (a.HandleBoxflag0 and bm_TGtkHandleBox_snap_edge) shr
      bp_TGtkHandleBox_snap_edge

proc setSnapEdge*(a: PHandleBox, `snap_edge`: gint) = 
  a.HandleBoxflag0 = a.HandleBoxflag0 or
      (Int16(`snapEdge` shl bp_TGtkHandleBox_snap_edge) and
      bm_TGtkHandleBox_snap_edge)

proc typePaned*(): GType = 
  result = panedGetType()

proc paned*(obj: pointer): PPaned = 
  result = cast[PPaned](checkCast(obj, typePaned()))

proc panedClass*(klass: pointer): PPanedClass = 
  result = cast[PPanedClass](checkClassCast(klass, typePaned()))

proc isPaned*(obj: pointer): bool = 
  result = checkType(obj, typePaned())

proc isPanedClass*(klass: pointer): bool = 
  result = checkClassType(klass, typePaned())

proc panedGetClass*(obj: pointer): PPanedClass = 
  result = cast[PPanedClass](checkGetClass(obj, typePaned()))

proc positionSet*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_position_set) shr
      bp_TGtkPaned_position_set

proc setPositionSet*(a: PPaned, `position_set`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`positionSet` shl bp_TGtkPaned_position_set) and
      bm_TGtkPaned_position_set)

proc inDrag*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_in_drag) shr bp_TGtkPaned_in_drag

proc setInDrag*(a: PPaned, `in_drag`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`inDrag` shl bp_TGtkPaned_in_drag) and bm_TGtkPaned_in_drag)

proc child1Shrink*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_child1_shrink) shr
      bp_TGtkPaned_child1_shrink

proc setChild1Shrink*(a: PPaned, `child1_shrink`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`child1Shrink` shl bp_TGtkPaned_child1_shrink) and
      bm_TGtkPaned_child1_shrink)

proc child1Resize*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_child1_resize) shr
      bp_TGtkPaned_child1_resize

proc setChild1Resize*(a: PPaned, `child1_resize`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`child1Resize` shl bp_TGtkPaned_child1_resize) and
      bm_TGtkPaned_child1_resize)

proc child2Shrink*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_child2_shrink) shr
      bp_TGtkPaned_child2_shrink

proc setChild2Shrink*(a: PPaned, `child2_shrink`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`child2Shrink` shl bp_TGtkPaned_child2_shrink) and
      bm_TGtkPaned_child2_shrink)

proc child2Resize*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_child2_resize) shr
      bp_TGtkPaned_child2_resize

proc setChild2Resize*(a: PPaned, `child2_resize`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`child2Resize` shl bp_TGtkPaned_child2_resize) and
      bm_TGtkPaned_child2_resize)

proc orientation*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_orientation) shr
      bp_TGtkPaned_orientation

proc setOrientation*(a: PPaned, `orientation`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`orientation` shl bp_TGtkPaned_orientation) and
      bm_TGtkPaned_orientation)

proc inRecursion*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_in_recursion) shr
      bp_TGtkPaned_in_recursion

proc setInRecursion*(a: PPaned, `in_recursion`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`inRecursion` shl bp_TGtkPaned_in_recursion) and
      bm_TGtkPaned_in_recursion)

proc handlePrelit*(a: PPaned): guint = 
  result = (a.Panedflag0 and bm_TGtkPaned_handle_prelit) shr
      bp_TGtkPaned_handle_prelit

proc setHandlePrelit*(a: PPaned, `handle_prelit`: guint) = 
  a.Panedflag0 = a.Panedflag0 or
      (Int16(`handlePrelit` shl bp_TGtkPaned_handle_prelit) and
      bm_TGtkPaned_handle_prelit)

proc panedGutterSize*(p: Pointer, s: Gint) = 
  if (p != nil) and (s != 0'i32): nil
  
proc panedSetGutterSize*(p: Pointer, s: Gint) = 
  if (p != nil) and (s != 0'i32): nil
  
proc typeHbuttonBox*(): GType = 
  result = hbuttonBoxGetType()

proc hbuttonBox*(obj: pointer): PHButtonBox = 
  result = cast[PHButtonBox](checkCast(obj, typeHbuttonBox()))

proc hbuttonBoxClass*(klass: pointer): PHButtonBoxClass = 
  result = cast[PHButtonBoxClass](checkClassCast(klass, typeHbuttonBox()))

proc isHbuttonBox*(obj: pointer): bool = 
  result = checkType(obj, typeHbuttonBox())

proc isHbuttonBoxClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeHbuttonBox())

proc hbuttonBoxGetClass*(obj: pointer): PHButtonBoxClass = 
  result = cast[PHButtonBoxClass](checkGetClass(obj, typeHbuttonBox()))

proc typeHpaned*(): GType = 
  result = hpanedGetType()

proc hpaned*(obj: pointer): PHPaned = 
  result = cast[PHPaned](checkCast(obj, typeHpaned()))

proc hpanedClass*(klass: pointer): PHPanedClass = 
  result = cast[PHPanedClass](checkClassCast(klass, typeHpaned()))

proc isHpaned*(obj: pointer): bool = 
  result = checkType(obj, typeHpaned())

proc isHpanedClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeHpaned())

proc hpanedGetClass*(obj: pointer): PHPanedClass = 
  result = cast[PHPanedClass](checkGetClass(obj, typeHpaned()))

proc typeRuler*(): GType = 
  result = rulerGetType()

proc ruler*(obj: pointer): PRuler = 
  result = cast[PRuler](checkCast(obj, typeRuler()))

proc rulerClass*(klass: pointer): PRulerClass = 
  result = cast[PRulerClass](checkClassCast(klass, typeRuler()))

proc isRuler*(obj: pointer): bool = 
  result = checkType(obj, typeRuler())

proc isRulerClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeRuler())

proc rulerGetClass*(obj: pointer): PRulerClass = 
  result = cast[PRulerClass](checkGetClass(obj, typeRuler()))

proc typeHruler*(): GType = 
  result = hrulerGetType()

proc hruler*(obj: pointer): PHRuler = 
  result = cast[PHRuler](checkCast(obj, typeHruler()))

proc hrulerClass*(klass: pointer): PHRulerClass = 
  result = cast[PHRulerClass](checkClassCast(klass, typeHruler()))

proc isHruler*(obj: pointer): bool = 
  result = checkType(obj, typeHruler())

proc isHrulerClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeHruler())

proc hrulerGetClass*(obj: pointer): PHRulerClass = 
  result = cast[PHRulerClass](checkGetClass(obj, typeHruler()))

proc typeSettings*(): GType = 
  result = settingsGetType()

proc settings*(obj: pointer): PSettings = 
  result = cast[PSettings](checkCast(obj, typeSettings()))

proc settingsClass*(klass: pointer): PSettingsClass = 
  result = cast[PSettingsClass](checkClassCast(klass, typeSettings()))

proc isSettings*(obj: pointer): bool = 
  result = checkType(obj, typeSettings())

proc isSettingsClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeSettings())

proc settingsGetClass*(obj: pointer): PSettingsClass = 
  result = cast[PSettingsClass](checkGetClass(obj, typeSettings()))

proc typeRcStyle*(): GType = 
  result = rcStyleGetType()

proc rCSTYLEGet*(anObject: pointer): PRcStyle = 
  result = cast[PRcStyle](gTypeCheckInstanceCast(anObject, typeRcStyle()))

proc rcStyleClass*(klass: pointer): PRcStyleClass = 
  result = cast[PRcStyleClass](gTypeCheckClassCast(klass, typeRcStyle()))

proc isRcStyle*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeRcStyle())

proc isRcStyleClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeRcStyle())

proc rcStyleGetClass*(obj: pointer): PRcStyleClass = 
  result = cast[PRcStyleClass](gTypeInstanceGetClass(obj, typeRcStyle()))

proc engineSpecified*(a: PRcStyle): guint = 
  result = (a.RcStyleflag0 and bm_TGtkRcStyle_engine_specified) shr
      bp_TGtkRcStyle_engine_specified

proc setEngineSpecified*(a: PRcStyle, `engine_specified`: guint) = 
  a.RcStyleflag0 = a.RcStyleflag0 or
      (Int16(`engineSpecified` shl bp_TGtkRcStyle_engine_specified) and
      bm_TGtkRcStyle_engine_specified)

proc typeStyle*(): GType = 
  result = styleGetType()

proc style*(anObject: pointer): PStyle = 
  result = cast[PStyle](gTypeCheckInstanceCast(anObject, typeStyle()))

proc styleClass*(klass: pointer): PStyleClass = 
  result = cast[PStyleClass](gTypeCheckClassCast(klass, typeStyle()))

proc isStyle*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeStyle())

proc isStyleClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeStyle())

proc styleGetClass*(obj: pointer): PStyleClass = 
  result = cast[PStyleClass](gTypeInstanceGetClass(obj, typeStyle()))

proc typeBorder*(): GType = 
  result = borderGetType()

proc styleAttached*(style: pointer): bool = 
  result = ((style(style)).attach_count) > 0'i32

proc applyDefaultPixmap*(style: PStyle, window: gdk2.PWindow, 
                                 state_type: TStateType, area: gdk2.PRectangle, 
                                 x: Gint, y: Gint, width: Gint, height: Gint) = 
  applyDefaultBackground(style, window, true, stateType, area, x, y, 
                           width, height)

proc typeRange*(): GType = 
  result = rangeGetType()

proc range*(obj: pointer): PRange = 
  result = cast[PRange](checkCast(obj, typeRange()))

proc rangeClass*(klass: pointer): PRangeClass = 
  result = cast[PRangeClass](checkClassCast(klass, typeRange()))

proc isRange*(obj: pointer): bool = 
  result = checkType(obj, typeRange())

proc isRangeClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeRange())

proc rangeGetClass*(obj: pointer): PRangeClass = 
  result = cast[PRangeClass](checkGetClass(obj, typeRange()))

proc inverted*(a: PRange): guint = 
  result = (a.Rangeflag0 and bm_TGtkRange_inverted) shr bp_TGtkRange_inverted

proc setInverted*(a: PRange, `inverted`: guint) = 
  a.Rangeflag0 = a.Rangeflag0 or
      (Int16(`inverted` shl bp_TGtkRange_inverted) and bm_TGtkRange_inverted)

proc flippable*(a: PRange): guint = 
  result = (a.Rangeflag0 and bm_TGtkRange_flippable) shr
      bp_TGtkRange_flippable

proc setFlippable*(a: PRange, `flippable`: guint) = 
  a.Rangeflag0 = a.Rangeflag0 or
      (Int16(`flippable` shl bp_TGtkRange_flippable) and
      bm_TGtkRange_flippable)

proc hasStepperA*(a: PRange): guint = 
  result = (a.Rangeflag0 and bm_TGtkRange_has_stepper_a) shr
      bp_TGtkRange_has_stepper_a

proc setHasStepperA*(a: PRange, `has_stepper_a`: guint) = 
  a.Rangeflag0 = a.Rangeflag0 or
      (Int16(`hasStepperA` shl bp_TGtkRange_has_stepper_a) and
      bm_TGtkRange_has_stepper_a)

proc hasStepperB*(a: PRange): guint = 
  result = (a.Rangeflag0 and bm_TGtkRange_has_stepper_b) shr
      bp_TGtkRange_has_stepper_b

proc setHasStepperB*(a: PRange, `has_stepper_b`: guint) = 
  a.Rangeflag0 = a.Rangeflag0 or
      (Int16(`hasStepperB` shl bp_TGtkRange_has_stepper_b) and
      bm_TGtkRange_has_stepper_b)

proc hasStepperC*(a: PRange): guint = 
  result = (a.Rangeflag0 and bm_TGtkRange_has_stepper_c) shr
      bp_TGtkRange_has_stepper_c

proc setHasStepperC*(a: PRange, `has_stepper_c`: guint) = 
  a.Rangeflag0 = a.Rangeflag0 or
      (Int16(`hasStepperC` shl bp_TGtkRange_has_stepper_c) and
      bm_TGtkRange_has_stepper_c)

proc hasStepperD*(a: PRange): guint = 
  result = (a.Rangeflag0 and bm_TGtkRange_has_stepper_d) shr
      bp_TGtkRange_has_stepper_d

proc setHasStepperD*(a: PRange, `has_stepper_d`: guint) = 
  a.Rangeflag0 = a.Rangeflag0 or
      (Int16(`hasStepperD` shl bp_TGtkRange_has_stepper_d) and
      bm_TGtkRange_has_stepper_d)

proc needRecalc*(a: PRange): guint = 
  result = (a.Rangeflag0 and bm_TGtkRange_need_recalc) shr
      bp_TGtkRange_need_recalc

proc setNeedRecalc*(a: PRange, `need_recalc`: guint) = 
  a.Rangeflag0 = a.Rangeflag0 or
      (Int16(`needRecalc` shl bp_TGtkRange_need_recalc) and
      bm_TGtkRange_need_recalc)

proc sliderSizeFixed*(a: PRange): guint = 
  result = (a.Rangeflag0 and bm_TGtkRange_slider_size_fixed) shr
      bp_TGtkRange_slider_size_fixed

proc setSliderSizeFixed*(a: PRange, `slider_size_fixed`: guint) = 
  a.Rangeflag0 = a.Rangeflag0 or
      (Int16(`sliderSizeFixed` shl bp_TGtkRange_slider_size_fixed) and
      bm_TGtkRange_slider_size_fixed)

proc troughClickForward*(a: PRange): guint = 
  result = (a.flag1 and bm_TGtkRange_trough_click_forward) shr
      bp_TGtkRange_trough_click_forward

proc setTroughClickForward*(a: PRange, `trough_click_forward`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`troughClickForward` shl bp_TGtkRange_trough_click_forward) and
      bm_TGtkRange_trough_click_forward)

proc updatePending*(a: PRange): guint = 
  result = (a.flag1 and bm_TGtkRange_update_pending) shr
      bp_TGtkRange_update_pending

proc setUpdatePending*(a: PRange, `update_pending`: guint) = 
  a.flag1 = a.flag1 or
      (Int16(`updatePending` shl bp_TGtkRange_update_pending) and
      bm_TGtkRange_update_pending)

proc typeScale*(): GType = 
  result = scaleGetType()

proc scale*(obj: pointer): PScale = 
  result = cast[PScale](checkCast(obj, typeScale()))

proc scaleClass*(klass: pointer): PScaleClass = 
  result = cast[PScaleClass](checkClassCast(klass, typeScale()))

proc isScale*(obj: pointer): bool = 
  result = checkType(obj, typeScale())

proc isScaleClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeScale())

proc scaleGetClass*(obj: pointer): PScaleClass = 
  result = cast[PScaleClass](checkGetClass(obj, typeScale()))

proc drawValue*(a: PScale): guint = 
  result = (a.Scaleflag0 and bm_TGtkScale_draw_value) shr
      bp_TGtkScale_draw_value

proc setDrawValue*(a: PScale, `draw_value`: guint) = 
  a.Scaleflag0 = a.Scaleflag0 or
      (Int16(`drawValue` shl bp_TGtkScale_draw_value) and
      bm_TGtkScale_draw_value)

proc valuePos*(a: PScale): guint = 
  result = (a.Scaleflag0 and bm_TGtkScale_value_pos) shr
      bp_TGtkScale_value_pos

proc setValuePos*(a: PScale, `value_pos`: guint) = 
  a.Scaleflag0 = a.Scaleflag0 or
      (Int16(`valuePos` shl bp_TGtkScale_value_pos) and
      bm_TGtkScale_value_pos)

proc typeHscale*(): GType = 
  result = hscaleGetType()

proc hscale*(obj: pointer): PHScale = 
  result = cast[PHScale](checkCast(obj, typeHscale()))

proc hscaleClass*(klass: pointer): PHScaleClass = 
  result = cast[PHScaleClass](checkClassCast(klass, typeHscale()))

proc isHscale*(obj: pointer): bool = 
  result = checkType(obj, typeHscale())

proc isHscaleClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeHscale())

proc hscaleGetClass*(obj: pointer): PHScaleClass = 
  result = cast[PHScaleClass](checkGetClass(obj, typeHscale()))

proc typeScrollbar*(): GType = 
  result = scrollbarGetType()

proc scrollbar*(obj: pointer): PScrollbar = 
  result = cast[PScrollbar](checkCast(obj, typeScrollbar()))

proc scrollbarClass*(klass: pointer): PScrollbarClass = 
  result = cast[PScrollbarClass](checkClassCast(klass, typeScrollbar()))

proc isScrollbar*(obj: pointer): bool = 
  result = checkType(obj, typeScrollbar())

proc isScrollbarClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeScrollbar())

proc scrollbarGetClass*(obj: pointer): PScrollbarClass = 
  result = cast[PScrollbarClass](checkGetClass(obj, typeScrollbar()))

proc typeHscrollbar*(): GType = 
  result = hscrollbarGetType()

proc hscrollbar*(obj: pointer): PHScrollbar = 
  result = cast[PHScrollbar](checkCast(obj, typeHscrollbar()))

proc hscrollbarClass*(klass: pointer): PHScrollbarClass = 
  result = cast[PHScrollbarClass](checkClassCast(klass, typeHscrollbar()))

proc isHscrollbar*(obj: pointer): bool = 
  result = checkType(obj, typeHscrollbar())

proc isHscrollbarClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeHscrollbar())

proc hscrollbarGetClass*(obj: pointer): PHScrollbarClass = 
  result = cast[PHScrollbarClass](checkGetClass(obj, typeHscrollbar()))

proc typeSeparator*(): GType = 
  result = separatorGetType()

proc separator*(obj: pointer): PSeparator = 
  result = cast[PSeparator](checkCast(obj, typeSeparator()))

proc separatorClass*(klass: pointer): PSeparatorClass = 
  result = cast[PSeparatorClass](checkClassCast(klass, typeSeparator()))

proc isSeparator*(obj: pointer): bool = 
  result = checkType(obj, typeSeparator())

proc isSeparatorClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeSeparator())

proc separatorGetClass*(obj: pointer): PSeparatorClass = 
  result = cast[PSeparatorClass](checkGetClass(obj, typeSeparator()))

proc typeHseparator*(): GType = 
  result = hseparatorGetType()

proc hseparator*(obj: pointer): PHSeparator = 
  result = cast[PHSeparator](checkCast(obj, typeHseparator()))

proc hseparatorClass*(klass: pointer): PHSeparatorClass = 
  result = cast[PHSeparatorClass](checkClassCast(klass, typeHseparator()))

proc isHseparator*(obj: pointer): bool = 
  result = checkType(obj, typeHseparator())

proc isHseparatorClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeHseparator())

proc hseparatorGetClass*(obj: pointer): PHSeparatorClass = 
  result = cast[PHSeparatorClass](checkGetClass(obj, typeHseparator()))

proc typeIconFactory*(): GType = 
  result = iconFactoryGetType()

proc iconFactory*(anObject: pointer): PIconFactory = 
  result = cast[PIconFactory](gTypeCheckInstanceCast(anObject, 
      typeIconFactory()))

proc iconFactoryClass*(klass: pointer): PIconFactoryClass = 
  result = cast[PIconFactoryClass](gTypeCheckClassCast(klass, 
      typeIconFactory()))

proc isIconFactory*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeIconFactory())

proc isIconFactoryClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeIconFactory())

proc iconFactoryGetClass*(obj: pointer): PIconFactoryClass = 
  result = cast[PIconFactoryClass](gTypeInstanceGetClass(obj, 
      typeIconFactory()))

proc typeIconSet*(): GType = 
  result = iconSetGetType()

proc typeIconSource*(): GType = 
  result = iconSourceGetType()

proc typeImage*(): GType = 
  result = gtk2.image_get_type()

proc image*(obj: pointer): PImage = 
  result = cast[PImage](checkCast(obj, gtk2.typeImage()))

proc imageClass*(klass: pointer): PImageClass = 
  result = cast[PImageClass](checkClassCast(klass, gtk2.typeImage()))

proc isImage*(obj: pointer): bool = 
  result = checkType(obj, gtk2.typeImage())

proc isImageClass*(klass: pointer): bool = 
  result = checkClassType(klass, gtk2.typeImage())

proc imageGetClass*(obj: pointer): PImageClass = 
  result = cast[PImageClass](checkGetClass(obj, gtk2.typeImage()))

proc typeImageMenuItem*(): GType = 
  result = imageMenuItemGetType()

proc imageMenuItem*(obj: pointer): PImageMenuItem = 
  result = cast[PImageMenuItem](checkCast(obj, typeImageMenuItem()))

proc imageMenuItemClass*(klass: pointer): PImageMenuItemClass = 
  result = cast[PImageMenuItemClass](checkClassCast(klass, 
      typeImageMenuItem()))

proc isImageMenuItem*(obj: pointer): bool = 
  result = checkType(obj, typeImageMenuItem())

proc isImageMenuItemClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeImageMenuItem())

proc imageMenuItemGetClass*(obj: pointer): PImageMenuItemClass = 
  result = cast[PImageMenuItemClass](checkGetClass(obj, typeImageMenuItem()))

proc typeImContextSimple*(): GType = 
  result = imContextSimpleGetType()

proc imContextSimple*(obj: pointer): PIMContextSimple = 
  result = cast[PIMContextSimple](checkCast(obj, typeImContextSimple()))

proc imContextSimpleClass*(klass: pointer): PIMContextSimpleClass = 
  result = cast[PIMContextSimpleClass](checkClassCast(klass, 
      typeImContextSimple()))

proc isImContextSimple*(obj: pointer): bool = 
  result = checkType(obj, typeImContextSimple())

proc isImContextSimpleClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeImContextSimple())

proc imContextSimpleGetClass*(obj: pointer): PIMContextSimpleClass = 
  result = cast[PIMContextSimpleClass](checkGetClass(obj, 
      typeImContextSimple()))

proc inHexSequence*(a: PIMContextSimple): guint = 
  result = (a.IMContextSimpleflag0 and bm_TGtkIMContextSimple_in_hex_sequence) shr
      bp_TGtkIMContextSimple_in_hex_sequence

proc setInHexSequence*(a: PIMContextSimple, `in_hex_sequence`: guint) = 
  a.IMContextSimpleflag0 = a.IMContextSimpleflag0 or
      (Int16(`inHexSequence` shl bp_TGtkIMContextSimple_in_hex_sequence) and
      bm_TGtkIMContextSimple_in_hex_sequence)

proc typeImMulticontext*(): GType = 
  result = imMulticontextGetType()

proc imMulticontext*(obj: pointer): PIMMulticontext = 
  result = cast[PIMMulticontext](checkCast(obj, typeImMulticontext()))

proc imMulticontextClass*(klass: pointer): PIMMulticontextClass = 
  result = cast[PIMMulticontextClass](checkClassCast(klass, 
      typeImMulticontext()))

proc isImMulticontext*(obj: pointer): bool = 
  result = checkType(obj, typeImMulticontext())

proc isImMulticontextClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeImMulticontext())

proc imMulticontextGetClass*(obj: pointer): PIMMulticontextClass = 
  result = cast[PIMMulticontextClass](checkGetClass(obj, 
      typeImMulticontext()))

proc typeInputDialog*(): GType = 
  result = inputDialogGetType()

proc inputDialog*(obj: pointer): PInputDialog = 
  result = cast[PInputDialog](checkCast(obj, typeInputDialog()))

proc inputDialogClass*(klass: pointer): PInputDialogClass = 
  result = cast[PInputDialogClass](checkClassCast(klass, typeInputDialog()))

proc isInputDialog*(obj: pointer): bool = 
  result = checkType(obj, typeInputDialog())

proc isInputDialogClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeInputDialog())

proc inputDialogGetClass*(obj: pointer): PInputDialogClass = 
  result = cast[PInputDialogClass](checkGetClass(obj, typeInputDialog()))

proc typeInvisible*(): GType = 
  result = invisibleGetType()

proc invisible*(obj: pointer): PInvisible = 
  result = cast[PInvisible](checkCast(obj, typeInvisible()))

proc invisibleClass*(klass: pointer): PInvisibleClass = 
  result = cast[PInvisibleClass](checkClassCast(klass, typeInvisible()))

proc isInvisible*(obj: pointer): bool = 
  result = checkType(obj, typeInvisible())

proc isInvisibleClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeInvisible())

proc invisibleGetClass*(obj: pointer): PInvisibleClass = 
  result = cast[PInvisibleClass](checkGetClass(obj, typeInvisible()))

proc typeItemFactory*(): GType = 
  result = itemFactoryGetType()

proc itemFactory*(anObject: pointer): PItemFactory = 
  result = cast[PItemFactory](checkCast(anObject, typeItemFactory()))

proc itemFactoryClass*(klass: pointer): PItemFactoryClass = 
  result = cast[PItemFactoryClass](checkClassCast(klass, typeItemFactory()))

proc isItemFactory*(anObject: pointer): bool = 
  result = checkType(anObject, typeItemFactory())

proc isItemFactoryClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeItemFactory())

proc itemFactoryGetClass*(obj: pointer): PItemFactoryClass = 
  result = cast[PItemFactoryClass](checkGetClass(obj, typeItemFactory()))

proc typeLayout*(): GType = 
  result = gtk2.layout_get_type()

proc layout*(obj: pointer): PLayout = 
  result = cast[PLayout](checkCast(obj, gtk2.typeLayout()))

proc layoutClass*(klass: pointer): PLayoutClass = 
  result = cast[PLayoutClass](checkClassCast(klass, gtk2.typeLayout()))

proc isLayout*(obj: pointer): bool = 
  result = checkType(obj, gtk2.typeLayout())

proc isLayoutClass*(klass: pointer): bool = 
  result = checkClassType(klass, gtk2.typeLayout())

proc layoutGetClass*(obj: pointer): PLayoutClass = 
  result = cast[PLayoutClass](checkGetClass(obj, gtk2.typeLayout()))

proc typeList*(): GType = 
  result = listGetType()

proc list*(obj: pointer): PList = 
  result = cast[PList](checkCast(obj, typeList()))

proc listClass*(klass: pointer): PListClass = 
  result = cast[PListClass](checkClassCast(klass, typeList()))

proc isList*(obj: pointer): bool = 
  result = checkType(obj, typeList())

proc isListClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeList())

proc listGetClass*(obj: pointer): PListClass = 
  result = cast[PListClass](checkGetClass(obj, typeList()))

proc selectionMode*(a: PList): guint = 
  result = (a.Listflag0 and bm_TGtkList_selection_mode) shr
      bp_TGtkList_selection_mode

proc setSelectionMode*(a: PList, `selection_mode`: guint) = 
  a.Listflag0 = a.Listflag0 or
      (Int16(`selectionMode` shl bp_TGtkList_selection_mode) and
      bm_TGtkList_selection_mode)

proc dragSelection*(a: PList): guint = 
  result = (a.Listflag0 and bm_TGtkList_drag_selection) shr
      bp_TGtkList_drag_selection

proc setDragSelection*(a: PList, `drag_selection`: guint) = 
  a.Listflag0 = a.Listflag0 or
      (Int16(`dragSelection` shl bp_TGtkList_drag_selection) and
      bm_TGtkList_drag_selection)

proc addMode*(a: PList): guint = 
  result = (a.Listflag0 and bm_TGtkList_add_mode) shr bp_TGtkList_add_mode

proc setAddMode*(a: PList, `add_mode`: guint) = 
  a.Listflag0 = a.Listflag0 or
      (Int16(`addMode` shl bp_TGtkList_add_mode) and bm_TGtkList_add_mode)

proc listItemGetType(): GType{.importc: "gtk_list_item_get_type", cdecl, 
                                  dynlib: lib.}
proc typeListItem*(): GType = 
  result = listItemGetType()

type 
  TListItem = object of TItem
  TListItemClass = object of TItemClass
  PListItem = ptr TListItem
  PListItemClass = ptr TListItemClass

proc listItem*(obj: Pointer): PListItem = 
  result = cast[PListItem](checkCast(obj, typeListItem()))

proc listItemClass*(klass: Pointer): PListItemClass = 
  result = cast[PListItemClass](checkClassCast(klass, typeListItem()))

proc isListItem*(obj: Pointer): Bool = 
  result = checkType(obj, typeListItem())

proc isListItemClass*(klass: Pointer): Bool = 
  result = checkClassType(klass, typeListItem())

proc listItemGetClass*(obj: Pointer): PListItemClass = 
  #proc gtk_tree_model_get_type(): GType {.importc, cdecl, dynlib: gtklib.}
  result = cast[PListItemClass](checkGetClass(obj, typeListItem()))

proc typeTreeModel*(): GType = 
  result = treeModelGetType()

proc treeModel*(obj: pointer): PTreeModel = 
  result = cast[PTreeModel](gTypeCheckInstanceCast(obj, typeTreeModel()))

proc isTreeModel*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTreeModel())

proc treeModelGetIface*(obj: pointer): PTreeModelIface = 
  result = cast[PTreeModelIface](gTypeInstanceGetInterface(obj, 
      typeTreeModel()))

proc typeTreeIter*(): GType = 
  result = treeIterGetType()

proc typeTreePath*(): GType = 
  result = treePathGetType()

proc treePathNewRoot*(): PTreePath = 
  result = treePathNewFirst()

proc getIterRoot*(tree_model: PTreeModel, iter: PTreeIter): gboolean = 
  result = getIterFirst(treeModel, iter)

proc typeTreeSortable*(): GType = 
  result = treeSortableGetType()

proc treeSortable*(obj: pointer): PTreeSortable = 
  result = cast[PTreeSortable](gTypeCheckInstanceCast(obj, 
      typeTreeSortable()))

proc treeSortableClass*(obj: pointer): PTreeSortableIface = 
  result = cast[PTreeSortableIface](gTypeCheckClassCast(obj, 
      typeTreeSortable()))

proc isTreeSortable*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTreeSortable())

proc treeSortableGetIface*(obj: pointer): PTreeSortableIface = 
  result = cast[PTreeSortableIface](gTypeInstanceGetInterface(obj, 
      typeTreeSortable()))

proc typeTreeModelSort*(): GType = 
  result = treeModelSortGetType()

proc treeModelSort*(obj: pointer): PTreeModelSort = 
  result = cast[PTreeModelSort](checkCast(obj, typeTreeModelSort()))

proc treeModelSortClass*(klass: pointer): PTreeModelSortClass = 
  result = cast[PTreeModelSortClass](checkClassCast(klass, 
      typeTreeModelSort()))

proc isTreeModelSort*(obj: pointer): bool = 
  result = checkType(obj, typeTreeModelSort())

proc isTreeModelSortClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTreeModelSort())

proc treeModelSortGetClass*(obj: pointer): PTreeModelSortClass = 
  result = cast[PTreeModelSortClass](checkGetClass(obj, typeTreeModelSort()))

proc typeListStore*(): GType = 
  result = listStoreGetType()

proc listStore*(obj: pointer): PListStore = 
  result = cast[PListStore](checkCast(obj, typeListStore()))

proc listStoreClass*(klass: pointer): PListStoreClass = 
  result = cast[PListStoreClass](checkClassCast(klass, typeListStore()))

proc isListStore*(obj: pointer): bool = 
  result = checkType(obj, typeListStore())

proc isListStoreClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeListStore())

proc listStoreGetClass*(obj: pointer): PListStoreClass = 
  result = cast[PListStoreClass](checkGetClass(obj, typeListStore()))

proc columnsDirty*(a: PListStore): guint = 
  result = (a.ListStoreflag0 and bm_TGtkListStore_columns_dirty) shr
      bp_TGtkListStore_columns_dirty

proc setColumnsDirty*(a: PListStore, `columns_dirty`: guint) = 
  a.ListStoreflag0 = a.ListStoreflag0 or
      (Int16(`columnsDirty` shl bp_TGtkListStore_columns_dirty) and
      bm_TGtkListStore_columns_dirty)

proc typeMenuBar*(): GType = 
  result = menuBarGetType()

proc menuBar*(obj: pointer): PMenuBar = 
  result = cast[PMenuBar](checkCast(obj, typeMenuBar()))

proc menuBarClass*(klass: pointer): PMenuBarClass = 
  result = cast[PMenuBarClass](checkClassCast(klass, typeMenuBar()))

proc isMenuBar*(obj: pointer): bool = 
  result = checkType(obj, typeMenuBar())

proc isMenuBarClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeMenuBar())

proc menuBarGetClass*(obj: pointer): PMenuBarClass = 
  result = cast[PMenuBarClass](checkGetClass(obj, typeMenuBar()))

proc menuBarAppend*(menu, child: PWidget) = 
  append(cast[PMenuShell](menu), child)

proc menuBarPrepend*(menu, child: PWidget) = 
  prepend(cast[PMenuShell](menu), child)

proc menuBarInsert*(menu, child: PWidget, pos: Gint) = 
  insert(cast[PMenuShell](menu), child, pos)

proc typeMessageDialog*(): GType = 
  result = messageDialogGetType()

proc messageDialog*(obj: pointer): PMessageDialog = 
  result = cast[PMessageDialog](checkCast(obj, typeMessageDialog()))

proc messageDialogClass*(klass: pointer): PMessageDialogClass = 
  result = cast[PMessageDialogClass](checkClassCast(klass, 
      typeMessageDialog()))

proc isMessageDialog*(obj: pointer): bool = 
  result = checkType(obj, typeMessageDialog())

proc isMessageDialogClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeMessageDialog())

proc messageDialogGetClass*(obj: pointer): PMessageDialogClass = 
  result = cast[PMessageDialogClass](checkGetClass(obj, typeMessageDialog()))

proc typeNotebook*(): GType = 
  result = notebookGetType()

proc notebook*(obj: pointer): PNotebook = 
  result = cast[PNotebook](checkCast(obj, typeNotebook()))

proc notebookClass*(klass: pointer): PNotebookClass = 
  result = cast[PNotebookClass](checkClassCast(klass, typeNotebook()))

proc isNotebook*(obj: pointer): bool = 
  result = checkType(obj, typeNotebook())

proc isNotebookClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeNotebook())

proc notebookGetClass*(obj: pointer): PNotebookClass = 
  result = cast[PNotebookClass](checkGetClass(obj, typeNotebook()))

proc showTabs*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_show_tabs) shr
      bp_TGtkNotebook_show_tabs

proc setShowTabs*(a: PNotebook, `show_tabs`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`showTabs` shl bp_TGtkNotebook_show_tabs) and
      bm_TGtkNotebook_show_tabs)

proc homogeneous*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_homogeneous) shr
      bp_TGtkNotebook_homogeneous

proc setHomogeneous*(a: PNotebook, `homogeneous`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`homogeneous` shl bp_TGtkNotebook_homogeneous) and
      bm_TGtkNotebook_homogeneous)

proc showBorder*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_show_border) shr
      bp_TGtkNotebook_show_border

proc setShowBorder*(a: PNotebook, `show_border`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`showBorder` shl bp_TGtkNotebook_show_border) and
      bm_TGtkNotebook_show_border)

proc tabPos*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_tab_pos) shr
      bp_TGtkNotebook_tab_pos

proc setTabPos*(a: PNotebook, `tab_pos`: Guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`tabPos` shl bp_TGtkNotebook_tab_pos) and
      bm_TGtkNotebook_tab_pos)

proc scrollable*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_scrollable) shr
      bp_TGtkNotebook_scrollable

proc setScrollable*(a: PNotebook, `scrollable`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`scrollable` shl bp_TGtkNotebook_scrollable) and
      bm_TGtkNotebook_scrollable)

proc inChild*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_in_child) shr
      bp_TGtkNotebook_in_child

proc setInChild*(a: PNotebook, `in_child`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`inChild` shl bp_TGtkNotebook_in_child) and
      bm_TGtkNotebook_in_child)

proc clickChild*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_click_child) shr
      bp_TGtkNotebook_click_child

proc setClickChild*(a: PNotebook, `click_child`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`clickChild` shl bp_TGtkNotebook_click_child) and
      bm_TGtkNotebook_click_child)

proc button*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_button) shr
      bp_TGtkNotebook_button

proc setButton*(a: PNotebook, `button`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`button` shl bp_TGtkNotebook_button) and bm_TGtkNotebook_button)

proc needTimer*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_need_timer) shr
      bp_TGtkNotebook_need_timer

proc setNeedTimer*(a: PNotebook, `need_timer`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`needTimer` shl bp_TGtkNotebook_need_timer) and
      bm_TGtkNotebook_need_timer)

proc childHasFocus*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_child_has_focus) shr
      bp_TGtkNotebook_child_has_focus

proc setChildHasFocus*(a: PNotebook, `child_has_focus`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`childHasFocus` shl bp_TGtkNotebook_child_has_focus) and
      bm_TGtkNotebook_child_has_focus)

proc haveVisibleChild*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_have_visible_child) shr
      bp_TGtkNotebook_have_visible_child

proc setHaveVisibleChild*(a: PNotebook, `have_visible_child`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`haveVisibleChild` shl bp_TGtkNotebook_have_visible_child) and
      bm_TGtkNotebook_have_visible_child)

proc focusOut*(a: PNotebook): guint = 
  result = (a.Notebookflag0 and bm_TGtkNotebook_focus_out) shr
      bp_TGtkNotebook_focus_out

proc setFocusOut*(a: PNotebook, `focus_out`: guint) = 
  a.Notebookflag0 = a.Notebookflag0 or
      (Int16(`focusOut` shl bp_TGtkNotebook_focus_out) and
      bm_TGtkNotebook_focus_out)

proc typeOldEditable*(): GType = 
  result = oldEditableGetType()

proc oldEditable*(obj: pointer): POldEditable = 
  result = cast[POldEditable](checkCast(obj, typeOldEditable()))

proc oldEditableClass*(klass: pointer): POldEditableClass = 
  result = cast[POldEditableClass](checkClassCast(klass, typeOldEditable()))

proc isOldEditable*(obj: pointer): bool = 
  result = checkType(obj, typeOldEditable())

proc isOldEditableClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeOldEditable())

proc oldEditableGetClass*(obj: pointer): POldEditableClass = 
  result = cast[POldEditableClass](checkGetClass(obj, typeOldEditable()))

proc hasSelection*(a: POldEditable): guint = 
  result = (a.OldEditableflag0 and bm_TGtkOldEditable_has_selection) shr
      bp_TGtkOldEditable_has_selection

proc setHasSelection*(a: POldEditable, `has_selection`: guint) = 
  a.OldEditableflag0 = a.OldEditableflag0 or
      (Int16(`hasSelection` shl bp_TGtkOldEditable_has_selection) and
      bm_TGtkOldEditable_has_selection)

proc editable*(a: POldEditable): guint = 
  result = (a.OldEditableflag0 and bm_TGtkOldEditable_editable) shr
      bp_TGtkOldEditable_editable

proc setEditable*(a: POldEditable, `editable`: guint) = 
  a.OldEditableflag0 = a.OldEditableflag0 or
      (Int16(`editable` shl bp_TGtkOldEditable_editable) and
      bm_TGtkOldEditable_editable)

proc visible*(a: POldEditable): guint = 
  result = (a.OldEditableflag0 and bm_TGtkOldEditable_visible) shr
      bp_TGtkOldEditable_visible

proc setVisible*(a: POldEditable, `visible`: guint) = 
  a.OldEditableflag0 = a.OldEditableflag0 or
      (Int16(`visible` shl bp_TGtkOldEditable_visible) and
      bm_TGtkOldEditable_visible)

proc typeOptionMenu*(): GType = 
  result = optionMenuGetType()

proc optionMenu*(obj: pointer): POptionMenu = 
  result = cast[POptionMenu](checkCast(obj, typeOptionMenu()))

proc optionMenuClass*(klass: pointer): POptionMenuClass = 
  result = cast[POptionMenuClass](checkClassCast(klass, typeOptionMenu()))

proc isOptionMenu*(obj: pointer): bool = 
  result = checkType(obj, typeOptionMenu())

proc isOptionMenuClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeOptionMenu())

proc optionMenuGetClass*(obj: pointer): POptionMenuClass = 
  result = cast[POptionMenuClass](checkGetClass(obj, typeOptionMenu()))

proc typePixmap*(): GType = 
  result = gtk2.pixmap_get_type()

proc pixmap*(obj: pointer): PPixmap = 
  result = cast[PPixmap](checkCast(obj, gtk2.typePixmap()))

proc pixmapClass*(klass: pointer): PPixmapClass = 
  result = cast[PPixmapClass](checkClassCast(klass, gtk2.typePixmap()))

proc isPixmap*(obj: pointer): bool = 
  result = checkType(obj, gtk2.typePixmap())

proc isPixmapClass*(klass: pointer): bool = 
  result = checkClassType(klass, gtk2.typePixmap())

proc pixmapGetClass*(obj: pointer): PPixmapClass = 
  result = cast[PPixmapClass](checkGetClass(obj, gtk2.typePixmap()))

proc buildInsensitive*(a: PPixmap): guint = 
  result = (a.Pixmapflag0 and bm_TGtkPixmap_build_insensitive) shr
      bp_TGtkPixmap_build_insensitive

proc setBuildInsensitive*(a: PPixmap, `build_insensitive`: guint) = 
  a.Pixmapflag0 = a.Pixmapflag0 or
      (Int16(`buildInsensitive` shl bp_TGtkPixmap_build_insensitive) and
      bm_TGtkPixmap_build_insensitive)

proc typePlug*(): GType = 
  result = plugGetType()

proc plug*(obj: pointer): PPlug = 
  result = cast[PPlug](checkCast(obj, typePlug()))

proc plugClass*(klass: pointer): PPlugClass = 
  result = cast[PPlugClass](checkClassCast(klass, typePlug()))

proc isPlug*(obj: pointer): bool = 
  result = checkType(obj, typePlug())

proc isPlugClass*(klass: pointer): bool = 
  result = checkClassType(klass, typePlug())

proc plugGetClass*(obj: pointer): PPlugClass = 
  result = cast[PPlugClass](checkGetClass(obj, typePlug()))

proc sameApp*(a: PPlug): guint = 
  result = (a.Plugflag0 and bm_TGtkPlug_same_app) shr bp_TGtkPlug_same_app

proc setSameApp*(a: PPlug, `same_app`: guint) = 
  a.Plugflag0 = a.Plugflag0 or
      (Int16(`sameApp` shl bp_TGtkPlug_same_app) and bm_TGtkPlug_same_app)

proc typePreview*(): GType = 
  result = previewGetType()

proc preview*(obj: pointer): PPreview = 
  result = cast[PPreview](checkCast(obj, typePreview()))

proc previewClass*(klass: pointer): PPreviewClass = 
  result = cast[PPreviewClass](checkClassCast(klass, typePreview()))

proc isPreview*(obj: pointer): bool = 
  result = checkType(obj, typePreview())

proc isPreviewClass*(klass: pointer): bool = 
  result = checkClassType(klass, typePreview())

proc previewGetClass*(obj: pointer): PPreviewClass = 
  result = cast[PPreviewClass](checkGetClass(obj, typePreview()))

proc getType*(a: PPreview): guint = 
  result = (a.Previewflag0 and bm_TGtkPreview_type) shr bp_TGtkPreview_type

proc setType*(a: PPreview, `type`: guint) = 
  a.Previewflag0 = a.Previewflag0 or
      (Int16(`type` shl bp_TGtkPreview_type) and bm_TGtkPreview_type)

proc getExpand*(a: PPreview): guint = 
  result = (a.Previewflag0 and bm_TGtkPreview_expand) shr
      bp_TGtkPreview_expand

proc setExpand*(a: PPreview, `expand`: guint) = 
  a.Previewflag0 = a.Previewflag0 or
      (Int16(`expand` shl bp_TGtkPreview_expand) and bm_TGtkPreview_expand)

proc progressGetType(): GType{.importc: "gtk_progress_get_type", cdecl, 
                                 dynlib: lib.}
proc typeProgress*(): GType = 
  result = progressGetType()

proc progress*(obj: Pointer): PProgress = 
  result = cast[PProgress](checkCast(obj, typeProgress()))

proc progressClass*(klass: Pointer): PProgressClass = 
  result = cast[PProgressClass](checkClassCast(klass, typeProgress()))

proc isProgress*(obj: Pointer): Bool = 
  result = checkType(obj, typeProgress())

proc isProgressClass*(klass: Pointer): Bool = 
  result = checkClassType(klass, typeProgress())

proc progressGetClass*(obj: Pointer): PProgressClass = 
  result = cast[PProgressClass](checkGetClass(obj, typeProgress()))

proc showText*(a: PProgress): guint = 
  result = (a.Progressflag0 and bm_TGtkProgress_show_text) shr
      bp_TGtkProgress_show_text

proc setShowText*(a: PProgress, `show_text`: guint) = 
  a.Progressflag0 = a.Progressflag0 or
      (Int16(`showText` shl bp_TGtkProgress_show_text) and
      bm_TGtkProgress_show_text)

proc activityMode*(a: PProgress): guint = 
  result = (a.Progressflag0 and bm_TGtkProgress_activity_mode) shr
      bp_TGtkProgress_activity_mode

proc setActivityMode*(a: PProgress, `activity_mode`: guint) = 
  a.Progressflag0 = a.Progressflag0 or
      (Int16(`activityMode` shl bp_TGtkProgress_activity_mode) and
      bm_TGtkProgress_activity_mode)

proc useTextFormat*(a: PProgress): guint = 
  result = (a.Progressflag0 and bm_TGtkProgress_use_text_format) shr
      bp_TGtkProgress_use_text_format

proc setUseTextFormat*(a: PProgress, `use_text_format`: guint) = 
  a.Progressflag0 = a.Progressflag0 or
      (Int16(`useTextFormat` shl bp_TGtkProgress_use_text_format) and
      bm_TGtkProgress_use_text_format)

proc typeProgressBar*(): GType = 
  result = progressBarGetType()

proc progressBar*(obj: pointer): PProgressBar = 
  result = cast[PProgressBar](checkCast(obj, typeProgressBar()))

proc progressBarClass*(klass: pointer): PProgressBarClass = 
  result = cast[PProgressBarClass](checkClassCast(klass, typeProgressBar()))

proc isProgressBar*(obj: pointer): bool = 
  result = checkType(obj, typeProgressBar())

proc isProgressBarClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeProgressBar())

proc progressBarGetClass*(obj: pointer): PProgressBarClass = 
  result = cast[PProgressBarClass](checkGetClass(obj, typeProgressBar()))

proc activityDir*(a: PProgressBar): guint = 
  result = (a.ProgressBarflag0 and bm_TGtkProgressBar_activity_dir) shr
      bp_TGtkProgressBar_activity_dir

proc setActivityDir*(a: PProgressBar, `activity_dir`: guint) = 
  a.ProgressBarflag0 = a.ProgressBarflag0 or
      (Int16(`activityDir` shl bp_TGtkProgressBar_activity_dir) and
      bm_TGtkProgressBar_activity_dir)

proc typeRadioButton*(): GType = 
  result = radioButtonGetType()

proc radioButton*(obj: pointer): PRadioButton = 
  result = cast[PRadioButton](checkCast(obj, typeRadioButton()))

proc radioButtonClass*(klass: pointer): PRadioButtonClass = 
  result = cast[PRadioButtonClass](checkClassCast(klass, typeRadioButton()))

proc isRadioButton*(obj: pointer): bool = 
  result = checkType(obj, typeRadioButton())

proc isRadioButtonClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeRadioButton())

proc radioButtonGetClass*(obj: pointer): PRadioButtonClass = 
  result = cast[PRadioButtonClass](checkGetClass(obj, typeRadioButton()))

proc typeRadioMenuItem*(): GType = 
  result = radioMenuItemGetType()

proc radioMenuItem*(obj: pointer): PRadioMenuItem = 
  result = cast[PRadioMenuItem](checkCast(obj, typeRadioMenuItem()))

proc radioMenuItemClass*(klass: pointer): PRadioMenuItemClass = 
  result = cast[PRadioMenuItemClass](checkClassCast(klass, 
      typeRadioMenuItem()))

proc isRadioMenuItem*(obj: pointer): bool = 
  result = checkType(obj, typeRadioMenuItem())

proc isRadioMenuItemClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeRadioMenuItem())

proc radioMenuItemGetClass*(obj: pointer): PRadioMenuItemClass = 
  result = cast[PRadioMenuItemClass](checkGetClass(obj, typeRadioMenuItem()))

proc typeScrolledWindow*(): GType = 
  result = scrolledWindowGetType()

proc scrolledWindow*(obj: pointer): PScrolledWindow = 
  result = cast[PScrolledWindow](checkCast(obj, typeScrolledWindow()))

proc scrolledWindowClass*(klass: pointer): PScrolledWindowClass = 
  result = cast[PScrolledWindowClass](checkClassCast(klass, 
      typeScrolledWindow()))

proc isScrolledWindow*(obj: pointer): bool = 
  result = checkType(obj, typeScrolledWindow())

proc isScrolledWindowClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeScrolledWindow())

proc scrolledWindowGetClass*(obj: pointer): PScrolledWindowClass = 
  result = cast[PScrolledWindowClass](checkGetClass(obj, 
      typeScrolledWindow()))

proc hscrollbarPolicy*(a: PScrolledWindow): guint = 
  result = (a.ScrolledWindowflag0 and bm_TGtkScrolledWindow_hscrollbar_policy) shr
      bp_TGtkScrolledWindow_hscrollbar_policy

proc setHscrollbarPolicy*(a: PScrolledWindow, `hscrollbar_policy`: guint) = 
  a.ScrolledWindowflag0 = a.ScrolledWindowflag0 or
      (Int16(`hscrollbarPolicy` shl bp_TGtkScrolledWindow_hscrollbar_policy) and
      bm_TGtkScrolledWindow_hscrollbar_policy)

proc vscrollbarPolicy*(a: PScrolledWindow): guint = 
  result = (a.ScrolledWindowflag0 and bm_TGtkScrolledWindow_vscrollbar_policy) shr
      bp_TGtkScrolledWindow_vscrollbar_policy

proc setVscrollbarPolicy*(a: PScrolledWindow, `vscrollbar_policy`: guint) = 
  a.ScrolledWindowflag0 = a.ScrolledWindowflag0 or
      (Int16(`vscrollbarPolicy` shl bp_TGtkScrolledWindow_vscrollbar_policy) and
      bm_TGtkScrolledWindow_vscrollbar_policy)

proc hscrollbarVisible*(a: PScrolledWindow): guint = 
  result = (a.ScrolledWindowflag0 and
      bm_TGtkScrolledWindow_hscrollbar_visible) shr
      bp_TGtkScrolledWindow_hscrollbar_visible

proc setHscrollbarVisible*(a: PScrolledWindow, `hscrollbar_visible`: guint) = 
  a.ScrolledWindowflag0 = a.ScrolledWindowflag0 or
      (Int16(`hscrollbarVisible` shl
      bp_TGtkScrolledWindow_hscrollbar_visible) and
      bm_TGtkScrolledWindow_hscrollbar_visible)

proc vscrollbarVisible*(a: PScrolledWindow): guint = 
  result = (a.ScrolledWindowflag0 and
      bm_TGtkScrolledWindow_vscrollbar_visible) shr
      bp_TGtkScrolledWindow_vscrollbar_visible

proc setVscrollbarVisible*(a: PScrolledWindow, `vscrollbar_visible`: guint) = 
  a.ScrolledWindowflag0 = a.ScrolledWindowflag0 or
      Int16((`vscrollbarVisible` shl
      bp_TGtkScrolledWindow_vscrollbar_visible) and
      bm_TGtkScrolledWindow_vscrollbar_visible)

proc windowPlacement*(a: PScrolledWindow): guint = 
  result = (a.ScrolledWindowflag0 and bm_TGtkScrolledWindow_window_placement) shr
      bp_TGtkScrolledWindow_window_placement

proc setWindowPlacement*(a: PScrolledWindow, `window_placement`: guint) = 
  a.ScrolledWindowflag0 = a.ScrolledWindowflag0 or
      (Int16(`windowPlacement` shl bp_TGtkScrolledWindow_window_placement) and
      bm_TGtkScrolledWindow_window_placement)

proc focusOut*(a: PScrolledWindow): guint = 
  result = (a.ScrolledWindowflag0 and bm_TGtkScrolledWindow_focus_out) shr
      bp_TGtkScrolledWindow_focus_out

proc setFocusOut*(a: PScrolledWindow, `focus_out`: guint) = 
  a.ScrolledWindowflag0 = a.ScrolledWindowflag0 or
      (Int16(`focusOut` shl bp_TGtkScrolledWindow_focus_out) and
      bm_TGtkScrolledWindow_focus_out)

proc typeSelectionData*(): GType = 
  result = selectionDataGetType()

proc typeSeparatorMenuItem*(): GType = 
  result = separatorMenuItemGetType()

proc separatorMenuItem*(obj: pointer): PSeparatorMenuItem = 
  result = cast[PSeparatorMenuItem](checkCast(obj, typeSeparatorMenuItem()))

proc separatorMenuItemClass*(klass: pointer): PSeparatorMenuItemClass = 
  result = cast[PSeparatorMenuItemClass](checkClassCast(klass, 
      typeSeparatorMenuItem()))

proc isSeparatorMenuItem*(obj: pointer): bool = 
  result = checkType(obj, typeSeparatorMenuItem())

proc isSeparatorMenuItemClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeSeparatorMenuItem())

proc separatorMenuItemGetClass*(obj: pointer): PSeparatorMenuItemClass = 
  result = cast[PSeparatorMenuItemClass](checkGetClass(obj, 
      typeSeparatorMenuItem()))

proc signalLookup*(name: Cstring, object_type: GType): Guint = 
  result = gSignalLookup(name, objectType)

proc signalName*(signal_id: Guint): Cstring = 
  result = gSignalName(signalId)

proc signalEmitStop*(instance: Gpointer, signal_id: Guint, detail: TGQuark) = 
  if detail != 0'i32: gSignalStopEmission(instance, signalId, 0)
  
proc signalConnectFull*(anObject: PObject, name: Cstring, fun: TSignalFunc, 
                          unknown1: Pointer, func_data: Gpointer, 
                          unknown2: Pointer, unknown3, unknown4: Int): Gulong{.
    importc: "gtk_signal_connect_full", cdecl, dynlib: lib.}
proc signalCompatMatched*(anObject: PObject, fun: TSignalFunc, 
                            data: Gpointer, m: TGSignalMatchType, u: Int){.
    importc: "gtk_signal_compat_matched", cdecl, dynlib: lib.}
proc signalConnect*(anObject: PObject, name: Cstring, fun: TSignalFunc, 
                     func_data: Gpointer): Gulong = 
  result = signalConnectFull(anObject, name, fun, nil, funcData, nil, 0, 0)

proc signalConnectAfter*(anObject: PObject, name: Cstring, fun: TSignalFunc, 
                           func_data: Gpointer): Gulong = 
  result = signalConnectFull(anObject, name, fun, nil, funcData, nil, 0, 1)

proc signalConnectObject*(anObject: PObject, name: Cstring, 
                            fun: TSignalFunc, slot_object: Gpointer): Gulong = 
  result = signalConnectFull(anObject, name, fun, nil, slotObject, nil, 1, 
                               0)

proc signalConnectObjectAfter*(anObject: PObject, name: Cstring, 
                                  fun: TSignalFunc, slot_object: Gpointer): Gulong = 
  result = signalConnectFull(anObject, name, fun, nil, slotObject, nil, 1, 
                               1)

proc signalDisconnect*(anObject: Gpointer, handler_id: Gulong) = 
  gSignalHandlerDisconnect(anObject, handlerId)

proc signalHandlerBlock*(anObject: Gpointer, handler_id: Gulong) = 
  gSignalHandlerBlock(anObject, handlerId)

proc signalHandlerUnblock*(anObject: Gpointer, handler_id: Gulong) = 
  gSignalHandlerUnblock(anObject, handlerId)

proc signalDisconnectByData*(anObject: PObject, data: Gpointer) = 
  signalCompatMatched(anObject, nil, data, G_SIGNAL_MATCH_DATA, 0)

proc signalDisconnectByFunc*(anObject: PObject, fun: TSignalFunc, 
                                data: Gpointer) = 
  signalCompatMatched(anObject, fun, data, cast[TGSignalMatchType](G_SIGNAL_MATCH_FUNC or
      G_SIGNAL_MATCH_DATA), 0)

proc signalHandlerBlockByFunc*(anObject: PObject, fun: TSignalFunc, 
                                   data: Gpointer) = 
  signalCompatMatched(anObject, fun, data, TGSignalMatchType(
      G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 0)

proc signalHandlerBlockByData*(anObject: PObject, data: Gpointer) = 
  signalCompatMatched(anObject, nil, data, G_SIGNAL_MATCH_DATA, 1)

proc signalHandlerUnblockByFunc*(anObject: PObject, fun: TSignalFunc, 
                                     data: Gpointer) = 
  signalCompatMatched(anObject, fun, data, cast[TGSignalMatchType](G_SIGNAL_MATCH_FUNC or
      G_SIGNAL_MATCH_DATA), 0)

proc signalHandlerUnblockByData*(anObject: PObject, data: Gpointer) = 
  signalCompatMatched(anObject, nil, data, G_SIGNAL_MATCH_DATA, 2)

proc signalHandlerPending*(anObject: PObject, signal_id: Guint, 
                             may_be_blocked: Gboolean): Gboolean = 
  Result = gSignalHasHandlerPending(anObject, signalId, 0, mayBeBlocked)

proc signalHandlerPendingByFunc*(anObject: PObject, signal_id: Guint, 
                                     may_be_blocked: Gboolean, 
                                     fun: TSignalFunc, 
                                     data: Gpointer): Gboolean = 
  var t: TGSignalMatchType
  t = cast[TGSignalMatchType](G_SIGNAL_MATCH_ID or G_SIGNAL_MATCH_FUNC or
      G_SIGNAL_MATCH_DATA)
  if not mayBeBlocked: 
    t = t or cast[TGSignalMatchType](G_SIGNAL_MATCH_UNBLOCKED)
  Result = gSignalHandlerFind(anObject, t, signalId, 0, nil, fun, data) !=
      0

proc typeSizeGroup*(): GType = 
  result = sizeGroupGetType()

proc sizeGroup*(obj: pointer): PSizeGroup = 
  result = cast[PSizeGroup](checkCast(obj, typeSizeGroup()))

proc sizeGroupClass*(klass: pointer): PSizeGroupClass = 
  result = cast[PSizeGroupClass](checkClassCast(klass, typeSizeGroup()))

proc isSizeGroup*(obj: pointer): bool = 
  result = checkType(obj, typeSizeGroup())

proc isSizeGroupClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeSizeGroup())

proc sizeGroupGetClass*(obj: pointer): PSizeGroupClass = 
  result = cast[PSizeGroupClass](checkGetClass(obj, typeSizeGroup()))

proc haveWidth*(a: PSizeGroup): guint = 
  result = (a.SizeGroupflag0 and bm_TGtkSizeGroup_have_width) shr
      bp_TGtkSizeGroup_have_width

proc setHaveWidth*(a: PSizeGroup, `have_width`: guint) = 
  a.SizeGroupflag0 = a.SizeGroupflag0 or
      (Int16(`haveWidth` shl bp_TGtkSizeGroup_have_width) and
      bm_TGtkSizeGroup_have_width)

proc haveHeight*(a: PSizeGroup): guint = 
  result = (a.SizeGroupflag0 and bm_TGtkSizeGroup_have_height) shr
      bp_TGtkSizeGroup_have_height

proc setHaveHeight*(a: PSizeGroup, `have_height`: guint) = 
  a.SizeGroupflag0 = a.SizeGroupflag0 or
      (Int16(`haveHeight` shl bp_TGtkSizeGroup_have_height) and
      bm_TGtkSizeGroup_have_height)

proc typeSocket*(): GType = 
  result = socketGetType()

proc socket*(obj: pointer): PSocket = 
  result = cast[PSocket](checkCast(obj, typeSocket()))

proc socketClass*(klass: pointer): PSocketClass = 
  result = cast[PSocketClass](checkClassCast(klass, typeSocket()))

proc isSocket*(obj: pointer): bool = 
  result = checkType(obj, typeSocket())

proc isSocketClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeSocket())

proc socketGetClass*(obj: pointer): PSocketClass = 
  result = cast[PSocketClass](checkGetClass(obj, typeSocket()))

proc sameApp*(a: PSocket): guint = 
  result = (a.Socketflag0 and bm_TGtkSocket_same_app) shr
      bp_TGtkSocket_same_app

proc setSameApp*(a: PSocket, `same_app`: guint) = 
  a.Socketflag0 = a.Socketflag0 or
      (Int16(`sameApp` shl bp_TGtkSocket_same_app) and
      bm_TGtkSocket_same_app)

proc focusIn*(a: PSocket): guint = 
  result = (a.Socketflag0 and bm_TGtkSocket_focus_in) shr
      bp_TGtkSocket_focus_in

proc setFocusIn*(a: PSocket, `focus_in`: guint) = 
  a.Socketflag0 = a.Socketflag0 or
      (Int16(`focusIn` shl bp_TGtkSocket_focus_in) and
      bm_TGtkSocket_focus_in)

proc haveSize*(a: PSocket): guint = 
  result = (a.Socketflag0 and bm_TGtkSocket_have_size) shr
      bp_TGtkSocket_have_size

proc setHaveSize*(a: PSocket, `have_size`: guint) = 
  a.Socketflag0 = a.Socketflag0 or
      (Int16(`haveSize` shl bp_TGtkSocket_have_size) and
      bm_TGtkSocket_have_size)

proc needMap*(a: PSocket): guint = 
  result = (a.Socketflag0 and bm_TGtkSocket_need_map) shr
      bp_TGtkSocket_need_map

proc setNeedMap*(a: PSocket, `need_map`: guint) = 
  a.Socketflag0 = a.Socketflag0 or
      (Int16(`needMap` shl bp_TGtkSocket_need_map) and
      bm_TGtkSocket_need_map)

proc isMapped*(a: PSocket): guint = 
  result = (a.Socketflag0 and bm_TGtkSocket_is_mapped) shr
      bp_TGtkSocket_is_mapped

proc setIsMapped*(a: PSocket, `is_mapped`: guint) = 
  a.Socketflag0 = a.Socketflag0 or
      (Int16(`isMapped` shl bp_TGtkSocket_is_mapped) and
      bm_TGtkSocket_is_mapped)

proc typeSpinButton*(): GType = 
  result = spinButtonGetType()

proc spinButton*(obj: pointer): PSpinButton = 
  result = cast[PSpinButton](checkCast(obj, typeSpinButton()))

proc spinButtonClass*(klass: pointer): PSpinButtonClass = 
  result = cast[PSpinButtonClass](checkClassCast(klass, typeSpinButton()))

proc isSpinButton*(obj: pointer): bool = 
  result = checkType(obj, typeSpinButton())

proc isSpinButtonClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeSpinButton())

proc spinButtonGetClass*(obj: pointer): PSpinButtonClass = 
  result = cast[PSpinButtonClass](checkGetClass(obj, typeSpinButton()))

proc inChild*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_in_child) shr
      bp_TGtkSpinButton_in_child

proc setInChild*(a: PSpinButton, `in_child`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`inChild` shl bp_TGtkSpinButton_in_child) and
      bm_TGtkSpinButton_in_child)

proc clickChild*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_click_child) shr
      bp_TGtkSpinButton_click_child

proc setClickChild*(a: PSpinButton, `click_child`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`clickChild` shl bp_TGtkSpinButton_click_child) and
      bm_TGtkSpinButton_click_child)

proc button*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_button) shr
      bp_TGtkSpinButton_button

proc setButton*(a: PSpinButton, `button`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`button` shl bp_TGtkSpinButton_button) and bm_TGtkSpinButton_button)

proc needTimer*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_need_timer) shr
      bp_TGtkSpinButton_need_timer

proc setNeedTimer*(a: PSpinButton, `need_timer`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`needTimer` shl bp_TGtkSpinButton_need_timer) and
      bm_TGtkSpinButton_need_timer)

proc timerCalls*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_timer_calls) shr
      bp_TGtkSpinButton_timer_calls

proc setTimerCalls*(a: PSpinButton, `timer_calls`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`timerCalls` shl bp_TGtkSpinButton_timer_calls) and
      bm_TGtkSpinButton_timer_calls)

proc digits*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_digits) shr
      bp_TGtkSpinButton_digits

proc setDigits*(a: PSpinButton, `digits`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`digits` shl bp_TGtkSpinButton_digits) and bm_TGtkSpinButton_digits)

proc numeric*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_numeric) shr
      bp_TGtkSpinButton_numeric

proc setNumeric*(a: PSpinButton, `numeric`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`numeric` shl bp_TGtkSpinButton_numeric) and
      bm_TGtkSpinButton_numeric)

proc wrap*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_wrap) shr
      bp_TGtkSpinButton_wrap

proc setWrap*(a: PSpinButton, `wrap`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`wrap` shl bp_TGtkSpinButton_wrap) and bm_TGtkSpinButton_wrap)

proc snapToTicks*(a: PSpinButton): guint = 
  result = (a.SpinButtonflag0 and bm_TGtkSpinButton_snap_to_ticks) shr
      bp_TGtkSpinButton_snap_to_ticks

proc setSnapToTicks*(a: PSpinButton, `snap_to_ticks`: guint) = 
  a.SpinButtonflag0 = a.SpinButtonflag0 or
      ((`snapToTicks` shl bp_TGtkSpinButton_snap_to_ticks) and
      bm_TGtkSpinButton_snap_to_ticks)

proc typeStatusbar*(): GType = 
  result = statusbarGetType()

proc statusbar*(obj: pointer): PStatusbar = 
  result = cast[PStatusbar](checkCast(obj, typeStatusbar()))

proc statusbarClass*(klass: pointer): PStatusbarClass = 
  result = cast[PStatusbarClass](checkClassCast(klass, typeStatusbar()))

proc isStatusbar*(obj: pointer): bool = 
  result = checkType(obj, typeStatusbar())

proc isStatusbarClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeStatusbar())

proc statusbarGetClass*(obj: pointer): PStatusbarClass = 
  result = cast[PStatusbarClass](checkGetClass(obj, typeStatusbar()))

proc hasResizeGrip*(a: PStatusbar): guint = 
  result = (a.Statusbarflag0 and bm_TGtkStatusbar_has_resize_grip) shr
      bp_TGtkStatusbar_has_resize_grip

proc setHasResizeGrip*(a: PStatusbar, `has_resize_grip`: guint) = 
  a.Statusbarflag0 = a.Statusbarflag0 or
      (Int16(`hasResizeGrip` shl bp_TGtkStatusbar_has_resize_grip) and
      bm_TGtkStatusbar_has_resize_grip)

proc typeTable*(): GType = 
  result = gtk2.table_get_type()

proc table*(obj: pointer): PTable = 
  result = cast[PTable](checkCast(obj, gtk2.typeTable()))

proc tableClass*(klass: pointer): PTableClass = 
  result = cast[PTableClass](checkClassCast(klass, gtk2.typeTable()))

proc isTable*(obj: pointer): bool = 
  result = checkType(obj, gtk2.typeTable())

proc isTableClass*(klass: pointer): bool = 
  result = checkClassType(klass, gtk2.typeTable())

proc tableGetClass*(obj: pointer): PTableClass = 
  result = cast[PTableClass](checkGetClass(obj, gtk2.typeTable()))

proc homogeneous*(a: PTable): guint = 
  result = (a.Tableflag0 and bm_TGtkTable_homogeneous) shr
      bp_TGtkTable_homogeneous

proc setHomogeneous*(a: PTable, `homogeneous`: guint) = 
  a.Tableflag0 = a.Tableflag0 or
      (Int16(`homogeneous` shl bp_TGtkTable_homogeneous) and
      bm_TGtkTable_homogeneous)

proc xexpand*(a: PTableChild): guint = 
  result = (a.TableChildflag0 and bm_TGtkTableChild_xexpand) shr
      bp_TGtkTableChild_xexpand

proc setXexpand*(a: PTableChild, `xexpand`: guint) = 
  a.TableChildflag0 = a.TableChildflag0 or
      (Int16(`xexpand` shl bp_TGtkTableChild_xexpand) and
      bm_TGtkTableChild_xexpand)

proc yexpand*(a: PTableChild): guint = 
  result = (a.TableChildflag0 and bm_TGtkTableChild_yexpand) shr
      bp_TGtkTableChild_yexpand

proc setYexpand*(a: PTableChild, `yexpand`: guint) = 
  a.TableChildflag0 = a.TableChildflag0 or
      (Int16(`yexpand` shl bp_TGtkTableChild_yexpand) and
      bm_TGtkTableChild_yexpand)

proc xshrink*(a: PTableChild): guint = 
  result = (a.TableChildflag0 and bm_TGtkTableChild_xshrink) shr
      bp_TGtkTableChild_xshrink

proc setXshrink*(a: PTableChild, `xshrink`: guint) = 
  a.TableChildflag0 = a.TableChildflag0 or
      (Int16(`xshrink` shl bp_TGtkTableChild_xshrink) and
      bm_TGtkTableChild_xshrink)

proc yshrink*(a: PTableChild): guint = 
  result = (a.TableChildflag0 and bm_TGtkTableChild_yshrink) shr
      bp_TGtkTableChild_yshrink

proc setYshrink*(a: PTableChild, `yshrink`: guint) = 
  a.TableChildflag0 = a.TableChildflag0 or
      (Int16(`yshrink` shl bp_TGtkTableChild_yshrink) and
      bm_TGtkTableChild_yshrink)

proc xfill*(a: PTableChild): guint = 
  result = (a.TableChildflag0 and bm_TGtkTableChild_xfill) shr
      bp_TGtkTableChild_xfill

proc setXfill*(a: PTableChild, `xfill`: guint) = 
  a.TableChildflag0 = a.TableChildflag0 or
      (Int16(`xfill` shl bp_TGtkTableChild_xfill) and bm_TGtkTableChild_xfill)

proc yfill*(a: PTableChild): guint = 
  result = (a.TableChildflag0 and bm_TGtkTableChild_yfill) shr
      bp_TGtkTableChild_yfill

proc setYfill*(a: PTableChild, `yfill`: guint) = 
  a.TableChildflag0 = a.TableChildflag0 or
      (Int16(`yfill` shl bp_TGtkTableChild_yfill) and bm_TGtkTableChild_yfill)

proc needExpand*(a: PTableRowCol): guint = 
  result = (a.flag0 and bm_TGtkTableRowCol_need_expand) shr
      bp_TGtkTableRowCol_need_expand

proc setNeedExpand*(a: PTableRowCol, `need_expand`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`needExpand` shl bp_TGtkTableRowCol_need_expand) and
      bm_TGtkTableRowCol_need_expand)

proc needShrink*(a: PTableRowCol): guint = 
  result = (a.flag0 and bm_TGtkTableRowCol_need_shrink) shr
      bp_TGtkTableRowCol_need_shrink

proc setNeedShrink*(a: PTableRowCol, `need_shrink`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`needShrink` shl bp_TGtkTableRowCol_need_shrink) and
      bm_TGtkTableRowCol_need_shrink)

proc expand*(a: PTableRowCol): guint = 
  result = (a.flag0 and bm_TGtkTableRowCol_expand) shr
      bp_TGtkTableRowCol_expand

proc setExpand*(a: PTableRowCol, `expand`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`expand` shl bp_TGtkTableRowCol_expand) and
      bm_TGtkTableRowCol_expand)

proc shrink*(a: PTableRowCol): guint = 
  result = (a.flag0 and bm_TGtkTableRowCol_shrink) shr
      bp_TGtkTableRowCol_shrink

proc setShrink*(a: PTableRowCol, `shrink`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`shrink` shl bp_TGtkTableRowCol_shrink) and
      bm_TGtkTableRowCol_shrink)

proc empty*(a: PTableRowCol): guint = 
  result = (a.flag0 and bm_TGtkTableRowCol_empty) shr
      bp_TGtkTableRowCol_empty

proc setEmpty*(a: PTableRowCol, `empty`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`empty` shl bp_TGtkTableRowCol_empty) and
      bm_TGtkTableRowCol_empty)

proc typeTearoffMenuItem*(): GType = 
  result = tearoffMenuItemGetType()

proc tearoffMenuItem*(obj: pointer): PTearoffMenuItem = 
  result = cast[PTearoffMenuItem](checkCast(obj, typeTearoffMenuItem()))

proc tearoffMenuItemClass*(klass: pointer): PTearoffMenuItemClass = 
  result = cast[PTearoffMenuItemClass](checkClassCast(klass, 
      typeTearoffMenuItem()))

proc isTearoffMenuItem*(obj: pointer): bool = 
  result = checkType(obj, typeTearoffMenuItem())

proc isTearoffMenuItemClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTearoffMenuItem())

proc tearoffMenuItemGetClass*(obj: pointer): PTearoffMenuItemClass = 
  result = cast[PTearoffMenuItemClass](checkGetClass(obj, 
      typeTearoffMenuItem()))

proc tornOff*(a: PTearoffMenuItem): guint = 
  result = (a.TearoffMenuItemflag0 and bm_TGtkTearoffMenuItem_torn_off) shr
      bp_TGtkTearoffMenuItem_torn_off

proc setTornOff*(a: PTearoffMenuItem, `torn_off`: guint) = 
  a.TearoffMenuItemflag0 = a.TearoffMenuItemflag0 or
      (Int16(`tornOff` shl bp_TGtkTearoffMenuItem_torn_off) and
      bm_TGtkTearoffMenuItem_torn_off)

proc typeText*(): GType = 
  result = gtk2.text_get_type()

proc text*(obj: pointer): PText = 
  result = cast[PText](checkCast(obj, gtk2.typeText()))

proc textClass*(klass: pointer): PTextClass = 
  result = cast[PTextClass](checkClassCast(klass, gtk2.typeText()))

proc isText*(obj: pointer): bool = 
  result = checkType(obj, gtk2.typeText())

proc isTextClass*(klass: pointer): bool = 
  result = checkClassType(klass, gtk2.typeText())

proc textGetClass*(obj: pointer): PTextClass = 
  result = cast[PTextClass](checkGetClass(obj, gtk2.typeText()))

proc lineWrap*(a: PText): guint = 
  result = (a.Textflag0 and bm_TGtkText_line_wrap) shr bp_TGtkText_line_wrap

proc setLineWrap*(a: PText, `line_wrap`: guint) = 
  a.Textflag0 = a.Textflag0 or
      (Int16(`lineWrap` shl bp_TGtkText_line_wrap) and bm_TGtkText_line_wrap)

proc wordWrap*(a: PText): guint = 
  result = (a.Textflag0 and bm_TGtkText_word_wrap) shr bp_TGtkText_word_wrap

proc setWordWrap*(a: PText, `word_wrap`: guint) = 
  a.Textflag0 = a.Textflag0 or
      (Int16(`wordWrap` shl bp_TGtkText_word_wrap) and bm_TGtkText_word_wrap)

proc useWchar*(a: PText): gboolean = 
  result = ((a.Textflag0 and bm_TGtkText_use_wchar) shr bp_TGtkText_use_wchar) >
      0'i16

proc setUseWchar*(a: PText, `use_wchar`: gboolean) = 
  if `useWchar`: 
    a.Textflag0 = a.Textflag0 or bm_TGtkText_use_wchar
  else: 
    a.Textflag0 = a.Textflag0 and not bm_TGtkText_use_wchar

proc indexWchar*(t: PText, index: guint): guint32 = 
  nil

proc indexUchar*(t: PText, index: guint): GUChar = 
  nil

proc typeTextIter*(): GType = 
  result = textIterGetType()

proc typeTextTag*(): GType = 
  result = textTagGetType()

proc textTag*(obj: pointer): PTextTag = 
  result = cast[PTextTag](gTypeCheckInstanceCast(obj, typeTextTag()))

proc textTagClass*(klass: pointer): PTextTagClass = 
  result = cast[PTextTagClass](gTypeCheckClassCast(klass, typeTextTag()))

proc isTextTag*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTextTag())

proc isTextTagClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeTextTag())

proc textTagGetClass*(obj: pointer): PTextTagClass = 
  result = cast[PTextTagClass](gTypeInstanceGetClass(obj, typeTextTag()))

proc typeTextAttributes*(): GType = 
  result = textAttributesGetType()

proc bgColorSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_bg_color_set) shr
      bp_TGtkTextTag_bg_color_set

proc setBgColorSet*(a: PTextTag, `bg_color_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`bgColorSet` shl bp_TGtkTextTag_bg_color_set) and
      bm_TGtkTextTag_bg_color_set)

proc bgStippleSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_bg_stipple_set) shr
      bp_TGtkTextTag_bg_stipple_set

proc setBgStippleSet*(a: PTextTag, `bg_stipple_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`bgStippleSet` shl bp_TGtkTextTag_bg_stipple_set) and
      bm_TGtkTextTag_bg_stipple_set)

proc fgColorSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_fg_color_set) shr
      bp_TGtkTextTag_fg_color_set

proc setFgColorSet*(a: PTextTag, `fg_color_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`fgColorSet` shl bp_TGtkTextTag_fg_color_set) and
      bm_TGtkTextTag_fg_color_set)

proc scaleSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_scale_set) shr
      bp_TGtkTextTag_scale_set

proc setScaleSet*(a: PTextTag, `scale_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`scaleSet` shl bp_TGtkTextTag_scale_set) and
      bm_TGtkTextTag_scale_set)

proc fgStippleSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_fg_stipple_set) shr
      bp_TGtkTextTag_fg_stipple_set

proc setFgStippleSet*(a: PTextTag, `fg_stipple_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`fgStippleSet` shl bp_TGtkTextTag_fg_stipple_set) and
      bm_TGtkTextTag_fg_stipple_set)

proc justificationSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_justification_set) shr
      bp_TGtkTextTag_justification_set

proc setJustificationSet*(a: PTextTag, `justification_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`justificationSet` shl bp_TGtkTextTag_justification_set) and
      bm_TGtkTextTag_justification_set)

proc leftMarginSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_left_margin_set) shr
      bp_TGtkTextTag_left_margin_set

proc setLeftMarginSet*(a: PTextTag, `left_margin_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`leftMarginSet` shl bp_TGtkTextTag_left_margin_set) and
      bm_TGtkTextTag_left_margin_set)

proc indentSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_indent_set) shr
      bp_TGtkTextTag_indent_set

proc setIndentSet*(a: PTextTag, `indent_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`indentSet` shl bp_TGtkTextTag_indent_set) and
      bm_TGtkTextTag_indent_set)

proc riseSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_rise_set) shr
      bp_TGtkTextTag_rise_set

proc setRiseSet*(a: PTextTag, `rise_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`riseSet` shl bp_TGtkTextTag_rise_set) and bm_TGtkTextTag_rise_set)

proc strikethroughSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_strikethrough_set) shr
      bp_TGtkTextTag_strikethrough_set

proc setStrikethroughSet*(a: PTextTag, `strikethrough_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`strikethroughSet` shl bp_TGtkTextTag_strikethrough_set) and
      bm_TGtkTextTag_strikethrough_set)

proc rightMarginSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_right_margin_set) shr
      bp_TGtkTextTag_right_margin_set

proc setRightMarginSet*(a: PTextTag, `right_margin_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`rightMarginSet` shl bp_TGtkTextTag_right_margin_set) and
      bm_TGtkTextTag_right_margin_set)

proc pixelsAboveLinesSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_pixels_above_lines_set) shr
      bp_TGtkTextTag_pixels_above_lines_set

proc setPixelsAboveLinesSet*(a: PTextTag, 
                                 `pixels_above_lines_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`pixelsAboveLinesSet` shl bp_TGtkTextTag_pixels_above_lines_set) and
      bm_TGtkTextTag_pixels_above_lines_set)

proc pixelsBelowLinesSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_pixels_below_lines_set) shr
      bp_TGtkTextTag_pixels_below_lines_set

proc setPixelsBelowLinesSet*(a: PTextTag, 
                                 `pixels_below_lines_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`pixelsBelowLinesSet` shl bp_TGtkTextTag_pixels_below_lines_set) and
      bm_TGtkTextTag_pixels_below_lines_set)

proc pixelsInsideWrapSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_pixels_inside_wrap_set) shr
      bp_TGtkTextTag_pixels_inside_wrap_set

proc setPixelsInsideWrapSet*(a: PTextTag, 
                                 `pixels_inside_wrap_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`pixelsInsideWrapSet` shl bp_TGtkTextTag_pixels_inside_wrap_set) and
      bm_TGtkTextTag_pixels_inside_wrap_set)

proc tabsSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_tabs_set) shr
      bp_TGtkTextTag_tabs_set

proc setTabsSet*(a: PTextTag, `tabs_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`tabsSet` shl bp_TGtkTextTag_tabs_set) and bm_TGtkTextTag_tabs_set)

proc underlineSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_underline_set) shr
      bp_TGtkTextTag_underline_set

proc setUnderlineSet*(a: PTextTag, `underline_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`underlineSet` shl bp_TGtkTextTag_underline_set) and
      bm_TGtkTextTag_underline_set)

proc wrapModeSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_wrap_mode_set) shr
      bp_TGtkTextTag_wrap_mode_set

proc setWrapModeSet*(a: PTextTag, `wrap_mode_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`wrapModeSet` shl bp_TGtkTextTag_wrap_mode_set) and
      bm_TGtkTextTag_wrap_mode_set)

proc bgFullHeightSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_bg_full_height_set) shr
      bp_TGtkTextTag_bg_full_height_set

proc setBgFullHeightSet*(a: PTextTag, `bg_full_height_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`bgFullHeightSet` shl bp_TGtkTextTag_bg_full_height_set) and
      bm_TGtkTextTag_bg_full_height_set)

proc invisibleSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_invisible_set) shr
      bp_TGtkTextTag_invisible_set

proc setInvisibleSet*(a: PTextTag, `invisible_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`invisibleSet` shl bp_TGtkTextTag_invisible_set) and
      bm_TGtkTextTag_invisible_set)

proc editableSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_editable_set) shr
      bp_TGtkTextTag_editable_set

proc setEditableSet*(a: PTextTag, `editable_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`editableSet` shl bp_TGtkTextTag_editable_set) and
      bm_TGtkTextTag_editable_set)

proc languageSet*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_language_set) shr
      bp_TGtkTextTag_language_set

proc setLanguageSet*(a: PTextTag, `language_set`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`languageSet` shl bp_TGtkTextTag_language_set) and
      bm_TGtkTextTag_language_set)

proc pad1*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_pad1) shr bp_TGtkTextTag_pad1

proc setPad1*(a: PTextTag, `pad1`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`pad1` shl bp_TGtkTextTag_pad1) and bm_TGtkTextTag_pad1)

proc pad2*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_pad2) shr bp_TGtkTextTag_pad2

proc setPad2*(a: PTextTag, `pad2`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`pad2` shl bp_TGtkTextTag_pad2) and bm_TGtkTextTag_pad2)

proc pad3*(a: PTextTag): guint = 
  result = (a.TextTagflag0 and bm_TGtkTextTag_pad3) shr bp_TGtkTextTag_pad3

proc setPad3*(a: PTextTag, `pad3`: guint) = 
  a.TextTagflag0 = a.TextTagflag0 or
      ((`pad3` shl bp_TGtkTextTag_pad3) and bm_TGtkTextTag_pad3)

proc underline*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_underline) shr
      bp_TGtkTextAppearance_underline

proc setUnderline*(a: PTextAppearance, `underline`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`underline` shl bp_TGtkTextAppearance_underline) and
      bm_TGtkTextAppearance_underline)

proc strikethrough*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_strikethrough) shr
      bp_TGtkTextAppearance_strikethrough

proc setStrikethrough*(a: PTextAppearance, `strikethrough`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`strikethrough` shl bp_TGtkTextAppearance_strikethrough) and
      bm_TGtkTextAppearance_strikethrough)

proc drawBg*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_draw_bg) shr
      bp_TGtkTextAppearance_draw_bg

proc setDrawBg*(a: PTextAppearance, `draw_bg`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`drawBg` shl bp_TGtkTextAppearance_draw_bg) and
      bm_TGtkTextAppearance_draw_bg)

proc insideSelection*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_inside_selection) shr
      bp_TGtkTextAppearance_inside_selection

proc setInsideSelection*(a: PTextAppearance, `inside_selection`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`insideSelection` shl bp_TGtkTextAppearance_inside_selection) and
      bm_TGtkTextAppearance_inside_selection)

proc isText*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_is_text) shr
      bp_TGtkTextAppearance_is_text

proc setIsText*(a: PTextAppearance, `is_text`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isText` shl bp_TGtkTextAppearance_is_text) and
      bm_TGtkTextAppearance_is_text)

proc pad1*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_pad1) shr
      bp_TGtkTextAppearance_pad1

proc setPad1*(a: PTextAppearance, `pad1`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pad1` shl bp_TGtkTextAppearance_pad1) and
      bm_TGtkTextAppearance_pad1)

proc pad2*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_pad2) shr
      bp_TGtkTextAppearance_pad2

proc setPad2*(a: PTextAppearance, `pad2`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pad2` shl bp_TGtkTextAppearance_pad2) and
      bm_TGtkTextAppearance_pad2)

proc pad3*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_pad3) shr
      bp_TGtkTextAppearance_pad3

proc setPad3*(a: PTextAppearance, `pad3`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pad3` shl bp_TGtkTextAppearance_pad3) and
      bm_TGtkTextAppearance_pad3)

proc pad4*(a: PTextAppearance): guint = 
  result = (a.flag0 and bm_TGtkTextAppearance_pad4) shr
      bp_TGtkTextAppearance_pad4

proc setPad4*(a: PTextAppearance, `pad4`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pad4` shl bp_TGtkTextAppearance_pad4) and
      bm_TGtkTextAppearance_pad4)

proc invisible*(a: PTextAttributes): guint = 
  result = (a.flag0 and bm_TGtkTextAttributes_invisible) shr
      bp_TGtkTextAttributes_invisible

proc setInvisible*(a: PTextAttributes, `invisible`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`invisible` shl bp_TGtkTextAttributes_invisible) and
      bm_TGtkTextAttributes_invisible)

proc bgFullHeight*(a: PTextAttributes): guint = 
  result = (a.flag0 and bm_TGtkTextAttributes_bg_full_height) shr
      bp_TGtkTextAttributes_bg_full_height

proc setBgFullHeight*(a: PTextAttributes, `bg_full_height`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`bgFullHeight` shl bp_TGtkTextAttributes_bg_full_height) and
      bm_TGtkTextAttributes_bg_full_height)

proc editable*(a: PTextAttributes): guint = 
  result = (a.flag0 and bm_TGtkTextAttributes_editable) shr
      bp_TGtkTextAttributes_editable

proc setEditable*(a: PTextAttributes, `editable`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`editable` shl bp_TGtkTextAttributes_editable) and
      bm_TGtkTextAttributes_editable)

proc realized*(a: PTextAttributes): guint = 
  result = (a.flag0 and bm_TGtkTextAttributes_realized) shr
      bp_TGtkTextAttributes_realized

proc setRealized*(a: PTextAttributes, `realized`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`realized` shl bp_TGtkTextAttributes_realized) and
      bm_TGtkTextAttributes_realized)

proc pad1*(a: PTextAttributes): guint = 
  result = (a.flag0 and bm_TGtkTextAttributes_pad1) shr
      bp_TGtkTextAttributes_pad1

proc setPad1*(a: PTextAttributes, `pad1`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pad1` shl bp_TGtkTextAttributes_pad1) and
      bm_TGtkTextAttributes_pad1)

proc pad2*(a: PTextAttributes): guint = 
  result = (a.flag0 and bm_TGtkTextAttributes_pad2) shr
      bp_TGtkTextAttributes_pad2

proc setPad2*(a: PTextAttributes, `pad2`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pad2` shl bp_TGtkTextAttributes_pad2) and
      bm_TGtkTextAttributes_pad2)

proc pad3*(a: PTextAttributes): guint = 
  result = (a.flag0 and bm_TGtkTextAttributes_pad3) shr
      bp_TGtkTextAttributes_pad3

proc setPad3*(a: PTextAttributes, `pad3`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pad3` shl bp_TGtkTextAttributes_pad3) and
      bm_TGtkTextAttributes_pad3)

proc pad4*(a: PTextAttributes): guint = 
  result = (a.flag0 and bm_TGtkTextAttributes_pad4) shr
      bp_TGtkTextAttributes_pad4

proc setPad4*(a: PTextAttributes, `pad4`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`pad4` shl bp_TGtkTextAttributes_pad4) and
      bm_TGtkTextAttributes_pad4)

proc typeTextTagTable*(): GType = 
  result = textTagTableGetType()

proc textTagTable*(obj: pointer): PTextTagTable = 
  result = cast[PTextTagTable](gTypeCheckInstanceCast(obj, 
      typeTextTagTable()))

proc textTagTableClass*(klass: pointer): PTextTagTableClass = 
  result = cast[PTextTagTableClass](gTypeCheckClassCast(klass, 
      typeTextTagTable()))

proc isTextTagTable*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTextTagTable())

proc isTextTagTableClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeTextTagTable())

proc textTagTableGetClass*(obj: pointer): PTextTagTableClass = 
  result = cast[PTextTagTableClass](gTypeInstanceGetClass(obj, 
      typeTextTagTable()))

proc typeTextMark*(): GType = 
  result = textMarkGetType()

proc textMark*(anObject: pointer): PTextMark = 
  result = cast[PTextMark](gTypeCheckInstanceCast(anObject, typeTextMark()))

proc textMarkClass*(klass: pointer): PTextMarkClass = 
  result = cast[PTextMarkClass](gTypeCheckClassCast(klass, typeTextMark()))

proc isTextMark*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeTextMark())

proc isTextMarkClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeTextMark())

proc textMarkGetClass*(obj: pointer): PTextMarkClass = 
  result = cast[PTextMarkClass](gTypeInstanceGetClass(obj, typeTextMark()))

proc visible*(a: PTextMarkBody): guint = 
  result = (a.flag0 and bm_TGtkTextMarkBody_visible) shr
      bp_TGtkTextMarkBody_visible

proc setVisible*(a: PTextMarkBody, `visible`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`visible` shl bp_TGtkTextMarkBody_visible) and
      bm_TGtkTextMarkBody_visible)

proc notDeleteable*(a: PTextMarkBody): guint = 
  result = (a.flag0 and bm_TGtkTextMarkBody_not_deleteable) shr
      bp_TGtkTextMarkBody_not_deleteable

proc setNotDeleteable*(a: PTextMarkBody, `not_deleteable`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`notDeleteable` shl bp_TGtkTextMarkBody_not_deleteable) and
      bm_TGtkTextMarkBody_not_deleteable)

proc typeTextChildAnchor*(): GType = 
  result = textChildAnchorGetType()

proc textChildAnchor*(anObject: pointer): PTextChildAnchor = 
  result = cast[PTextChildAnchor](gTypeCheckInstanceCast(anObject, 
      typeTextChildAnchor()))

proc textChildAnchorClass*(klass: pointer): PTextChildAnchorClass = 
  result = cast[PTextChildAnchorClass](gTypeCheckClassCast(klass, 
      typeTextChildAnchor()))

proc isTextChildAnchor*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeTextChildAnchor())

proc isTextChildAnchorClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeTextChildAnchor())

proc textChildAnchorGetClass*(obj: pointer): PTextChildAnchorClass = 
  result = cast[PTextChildAnchorClass](gTypeInstanceGetClass(obj, 
      typeTextChildAnchor()))

proc width*(a: PTextLineData): gint = 
  result = a.flag0 and bm_TGtkTextLineData_width

proc setWidth*(a: PTextLineData, NewWidth: gint) = 
  a.flag0 = (bm_TGtkTextLineData_width and newWidth) or a.flag0

proc valid*(a: PTextLineData): gint = 
  result = (a.flag0 and bm_TGtkTextLineData_valid) shr
      bp_TGtkTextLineData_valid

proc setValid*(a: PTextLineData, `valid`: gint) = 
  a.flag0 = a.flag0 or
      ((`valid` shl bp_TGtkTextLineData_valid) and bm_TGtkTextLineData_valid)

proc typeTextBuffer*(): GType = 
  result = textBufferGetType()

proc textBuffer*(obj: pointer): PTextBuffer = 
  result = cast[PTextBuffer](gTypeCheckInstanceCast(obj, typeTextBuffer()))

proc textBufferClass*(klass: pointer): PTextBufferClass = 
  result = cast[PTextBufferClass](gTypeCheckClassCast(klass, 
      typeTextBuffer()))

proc isTextBuffer*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTextBuffer())

proc isTextBufferClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeTextBuffer())

proc textBufferGetClass*(obj: pointer): PTextBufferClass = 
  result = cast[PTextBufferClass](gTypeInstanceGetClass(obj, 
      typeTextBuffer()))

proc modified*(a: PTextBuffer): guint = 
  result = (a.TextBufferflag0 and bm_TGtkTextBuffer_modified) shr
      bp_TGtkTextBuffer_modified

proc setModified*(a: PTextBuffer, `modified`: guint) = 
  a.TextBufferflag0 = a.TextBufferflag0 or
      (Int16(`modified` shl bp_TGtkTextBuffer_modified) and
      bm_TGtkTextBuffer_modified)

proc typeTextLayout*(): GType = 
  result = textLayoutGetType()

proc textLayout*(obj: pointer): PTextLayout = 
  result = cast[PTextLayout](gTypeCheckInstanceCast(obj, typeTextLayout()))

proc textLayoutClass*(klass: pointer): PTextLayoutClass = 
  result = cast[PTextLayoutClass](gTypeCheckClassCast(klass, 
      typeTextLayout()))

proc isTextLayout*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTextLayout())

proc isTextLayoutClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeTextLayout())

proc textLayoutGetClass*(obj: pointer): PTextLayoutClass = 
  result = cast[PTextLayoutClass](gTypeInstanceGetClass(obj, 
      typeTextLayout()))

proc cursorVisible*(a: PTextLayout): guint = 
  result = (a.TextLayoutflag0 and bm_TGtkTextLayout_cursor_visible) shr
      bp_TGtkTextLayout_cursor_visible

proc setCursorVisible*(a: PTextLayout, `cursor_visible`: guint) = 
  a.TextLayoutflag0 = a.TextLayoutflag0 or
      (Int16(`cursorVisible` shl bp_TGtkTextLayout_cursor_visible) and
      bm_TGtkTextLayout_cursor_visible)

proc cursorDirection*(a: PTextLayout): gint = 
  result = (a.TextLayoutflag0 and bm_TGtkTextLayout_cursor_direction) shr
      bp_TGtkTextLayout_cursor_direction

proc setCursorDirection*(a: PTextLayout, `cursor_direction`: gint) = 
  a.TextLayoutflag0 = a.TextLayoutflag0 or
      (Int16(`cursorDirection` shl bp_TGtkTextLayout_cursor_direction) and
      bm_TGtkTextLayout_cursor_direction)

proc isStrong*(a: PTextCursorDisplay): guint = 
  result = (a.flag0 and bm_TGtkTextCursorDisplay_is_strong) shr
      bp_TGtkTextCursorDisplay_is_strong

proc setIsStrong*(a: PTextCursorDisplay, `is_strong`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isStrong` shl bp_TGtkTextCursorDisplay_is_strong) and
      bm_TGtkTextCursorDisplay_is_strong)

proc isWeak*(a: PTextCursorDisplay): guint = 
  result = (a.flag0 and bm_TGtkTextCursorDisplay_is_weak) shr
      bp_TGtkTextCursorDisplay_is_weak

proc setIsWeak*(a: PTextCursorDisplay, `is_weak`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isWeak` shl bp_TGtkTextCursorDisplay_is_weak) and
      bm_TGtkTextCursorDisplay_is_weak)

proc typeTextView*(): GType = 
  result = textViewGetType()

proc textView*(obj: pointer): PTextView = 
  result = cast[PTextView](checkCast(obj, typeTextView()))

proc textViewClass*(klass: pointer): PTextViewClass = 
  result = cast[PTextViewClass](checkClassCast(klass, typeTextView()))

proc isTextView*(obj: pointer): bool = 
  result = checkType(obj, typeTextView())

proc isTextViewClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTextView())

proc textViewGetClass*(obj: pointer): PTextViewClass = 
  result = cast[PTextViewClass](checkGetClass(obj, typeTextView()))

proc editable*(a: PTextView): guint = 
  result = (a.TextViewflag0 and bm_TGtkTextView_editable) shr
      bp_TGtkTextView_editable

proc setEditable*(a: PTextView, `editable`: guint) = 
  a.TextViewflag0 = a.TextViewflag0 or
      (Int16(`editable` shl bp_TGtkTextView_editable) and
      bm_TGtkTextView_editable)

proc overwriteMode*(a: PTextView): guint = 
  result = (a.TextViewflag0 and bm_TGtkTextView_overwrite_mode) shr
      bp_TGtkTextView_overwrite_mode

proc setOverwriteMode*(a: PTextView, `overwrite_mode`: guint) = 
  a.TextViewflag0 = a.TextViewflag0 or
      (Int16(`overwriteMode` shl bp_TGtkTextView_overwrite_mode) and
      bm_TGtkTextView_overwrite_mode)

proc cursorVisible*(a: PTextView): guint = 
  result = (a.TextViewflag0 and bm_TGtkTextView_cursor_visible) shr
      bp_TGtkTextView_cursor_visible

proc setCursorVisible*(a: PTextView, `cursor_visible`: guint) = 
  a.TextViewflag0 = a.TextViewflag0 or
      (Int16(`cursorVisible` shl bp_TGtkTextView_cursor_visible) and
      bm_TGtkTextView_cursor_visible)

proc needImReset*(a: PTextView): guint = 
  result = (a.TextViewflag0 and bm_TGtkTextView_need_im_reset) shr
      bp_TGtkTextView_need_im_reset

proc setNeedImReset*(a: PTextView, `need_im_reset`: guint) = 
  a.TextViewflag0 = a.TextViewflag0 or
      (Int16(`needImReset` shl bp_TGtkTextView_need_im_reset) and
      bm_TGtkTextView_need_im_reset)

proc justSelectedElement*(a: PTextView): guint = 
  result = (a.TextViewflag0 and bm_TGtkTextView_just_selected_element) shr
      bp_TGtkTextView_just_selected_element

proc setJustSelectedElement*(a: PTextView, `just_selected_element`: guint) = 
  a.TextViewflag0 = a.TextViewflag0 or
      (Int16(`justSelectedElement` shl
      bp_TGtkTextView_just_selected_element) and
      bm_TGtkTextView_just_selected_element)

proc disableScrollOnFocus*(a: PTextView): guint = 
  result = (a.TextViewflag0 and bm_TGtkTextView_disable_scroll_on_focus) shr
      bp_TGtkTextView_disable_scroll_on_focus

proc setDisableScrollOnFocus*(a: PTextView, 
                                  `disable_scroll_on_focus`: guint) = 
  a.TextViewflag0 = a.TextViewflag0 or
      (Int16(`disableScrollOnFocus` shl
      bp_TGtkTextView_disable_scroll_on_focus) and
      bm_TGtkTextView_disable_scroll_on_focus)

proc onscreenValidated*(a: PTextView): guint = 
  result = (a.TextViewflag0 and bm_TGtkTextView_onscreen_validated) shr
      bp_TGtkTextView_onscreen_validated

proc setOnscreenValidated*(a: PTextView, `onscreen_validated`: guint) = 
  a.TextViewflag0 = a.TextViewflag0 or
      (Int16(`onscreenValidated` shl bp_TGtkTextView_onscreen_validated) and
      bm_TGtkTextView_onscreen_validated)

proc mouseCursorObscured*(a: PTextView): guint = 
  result = (a.TextViewflag0 and bm_TGtkTextView_mouse_cursor_obscured) shr
      bp_TGtkTextView_mouse_cursor_obscured

proc setMouseCursorObscured*(a: PTextView, `mouse_cursor_obscured`: guint) = 
  a.TextViewflag0 = a.TextViewflag0 or
      (Int16(`mouseCursorObscured` shl
      bp_TGtkTextView_mouse_cursor_obscured) and
      bm_TGtkTextView_mouse_cursor_obscured)

proc typeTipsQuery*(): GType = 
  result = tipsQueryGetType()

proc tipsQuery*(obj: pointer): PTipsQuery = 
  result = cast[PTipsQuery](checkCast(obj, typeTipsQuery()))

proc tipsQueryClass*(klass: pointer): PTipsQueryClass = 
  result = cast[PTipsQueryClass](checkClassCast(klass, typeTipsQuery()))

proc isTipsQuery*(obj: pointer): bool = 
  result = checkType(obj, typeTipsQuery())

proc isTipsQueryClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTipsQuery())

proc tipsQueryGetClass*(obj: pointer): PTipsQueryClass = 
  result = cast[PTipsQueryClass](checkGetClass(obj, typeTipsQuery()))

proc emitAlways*(a: PTipsQuery): guint = 
  result = (a.TipsQueryflag0 and bm_TGtkTipsQuery_emit_always) shr
      bp_TGtkTipsQuery_emit_always

proc setEmitAlways*(a: PTipsQuery, `emit_always`: guint) = 
  a.TipsQueryflag0 = a.TipsQueryflag0 or
      (Int16(`emitAlways` shl bp_TGtkTipsQuery_emit_always) and
      bm_TGtkTipsQuery_emit_always)

proc inQuery*(a: PTipsQuery): guint = 
  result = (a.TipsQueryflag0 and bm_TGtkTipsQuery_in_query) shr
      bp_TGtkTipsQuery_in_query

proc setInQuery*(a: PTipsQuery, `in_query`: guint) = 
  a.TipsQueryflag0 = a.TipsQueryflag0 or
      (Int16(`inQuery` shl bp_TGtkTipsQuery_in_query) and
      bm_TGtkTipsQuery_in_query)

proc typeTooltips*(): GType = 
  result = tooltipsGetType()

proc tooltips*(obj: pointer): PTooltips = 
  result = cast[PTooltips](checkCast(obj, typeTooltips()))

proc tooltipsClass*(klass: pointer): PTooltipsClass = 
  result = cast[PTooltipsClass](checkClassCast(klass, typeTooltips()))

proc isTooltips*(obj: pointer): bool = 
  result = checkType(obj, typeTooltips())

proc isTooltipsClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTooltips())

proc tooltipsGetClass*(obj: pointer): PTooltipsClass = 
  result = cast[PTooltipsClass](checkGetClass(obj, typeTooltips()))

proc delay*(a: PTooltips): guint = 
  result = (a.Tooltipsflag0 and bm_TGtkTooltips_delay) shr
      bp_TGtkTooltips_delay

proc setDelay*(a: PTooltips, `delay`: guint) = 
  a.Tooltipsflag0 = a.Tooltipsflag0 or
      ((`delay` shl bp_TGtkTooltips_delay) and bm_TGtkTooltips_delay)

proc enabled*(a: PTooltips): guint = 
  result = (a.Tooltipsflag0 and bm_TGtkTooltips_enabled) shr
      bp_TGtkTooltips_enabled

proc setEnabled*(a: PTooltips, `enabled`: guint) = 
  a.Tooltipsflag0 = a.Tooltipsflag0 or
      ((`enabled` shl bp_TGtkTooltips_enabled) and bm_TGtkTooltips_enabled)

proc haveGrab*(a: PTooltips): guint = 
  result = (a.Tooltipsflag0 and bm_TGtkTooltips_have_grab) shr
      bp_TGtkTooltips_have_grab

proc setHaveGrab*(a: PTooltips, `have_grab`: guint) = 
  a.Tooltipsflag0 = a.Tooltipsflag0 or
      ((`haveGrab` shl bp_TGtkTooltips_have_grab) and
      bm_TGtkTooltips_have_grab)

proc useStickyDelay*(a: PTooltips): guint = 
  result = (a.Tooltipsflag0 and bm_TGtkTooltips_use_sticky_delay) shr
      bp_TGtkTooltips_use_sticky_delay

proc setUseStickyDelay*(a: PTooltips, `use_sticky_delay`: guint) = 
  a.Tooltipsflag0 = a.Tooltipsflag0 or
      ((`useStickyDelay` shl bp_TGtkTooltips_use_sticky_delay) and
      bm_TGtkTooltips_use_sticky_delay)

proc typeToolbar*(): GType = 
  result = toolbarGetType()

proc toolbar*(obj: pointer): PToolbar = 
  result = cast[PToolbar](checkCast(obj, typeToolbar()))

proc toolbarClass*(klass: pointer): PToolbarClass = 
  result = cast[PToolbarClass](checkClassCast(klass, typeToolbar()))

proc isToolbar*(obj: pointer): bool = 
  result = checkType(obj, typeToolbar())

proc isToolbarClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeToolbar())

proc toolbarGetClass*(obj: pointer): PToolbarClass = 
  result = cast[PToolbarClass](checkGetClass(obj, typeToolbar()))

proc styleSet*(a: PToolbar): guint = 
  result = (a.Toolbarflag0 and bm_TGtkToolbar_style_set) shr
      bp_TGtkToolbar_style_set

proc setStyleSet*(a: PToolbar, `style_set`: guint) = 
  a.Toolbarflag0 = a.Toolbarflag0 or
      (Int16(`styleSet` shl bp_TGtkToolbar_style_set) and
      bm_TGtkToolbar_style_set)

proc iconSizeSet*(a: PToolbar): guint = 
  result = (a.Toolbarflag0 and bm_TGtkToolbar_icon_size_set) shr
      bp_TGtkToolbar_icon_size_set

proc setIconSizeSet*(a: PToolbar, `icon_size_set`: guint) = 
  a.Toolbarflag0 = a.Toolbarflag0 or
      (Int16(`iconSizeSet` shl bp_TGtkToolbar_icon_size_set) and
      bm_TGtkToolbar_icon_size_set)

proc typeTree*(): GType = 
  result = treeGetType()

proc tree*(obj: pointer): PTree = 
  result = cast[PTree](checkCast(obj, typeTree()))

proc treeClass*(klass: pointer): PTreeClass = 
  result = cast[PTreeClass](checkClassCast(klass, typeTree()))

proc isTree*(obj: pointer): bool = 
  result = checkType(obj, typeTree())

proc isTreeClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTree())

proc treeGetClass*(obj: pointer): PTreeClass = 
  result = cast[PTreeClass](checkGetClass(obj, typeTree()))

proc isRootTree*(obj: pointer): bool = 
  result = (cast[PObject]((tree(obj)).root_tree)) == (cast[PObject](obj))

proc treeRootTree*(obj: pointer): PTree = 
  result = tree(obj).root_tree

proc treeSelectionOld*(obj: pointer): PGList = 
  result = (treeRootTree(obj)).selection

proc selectionMode*(a: PTree): guint = 
  result = (a.Treeflag0 and bm_TGtkTree_selection_mode) shr
      bp_TGtkTree_selection_mode

proc setSelectionMode*(a: PTree, `selection_mode`: guint) = 
  a.Treeflag0 = a.Treeflag0 or
      (Int16(`selectionMode` shl bp_TGtkTree_selection_mode) and
      bm_TGtkTree_selection_mode)

proc viewMode*(a: PTree): guint = 
  result = (a.Treeflag0 and bm_TGtkTree_view_mode) shr bp_TGtkTree_view_mode

proc setViewMode*(a: PTree, `view_mode`: guint) = 
  a.Treeflag0 = a.Treeflag0 or
      (Int16(`viewMode` shl bp_TGtkTree_view_mode) and bm_TGtkTree_view_mode)

proc viewLine*(a: PTree): guint = 
  result = (a.Treeflag0 and bm_TGtkTree_view_line) shr bp_TGtkTree_view_line

proc setViewLine*(a: PTree, `view_line`: guint) = 
  a.Treeflag0 = a.Treeflag0 or
      (Int16(`viewLine` shl bp_TGtkTree_view_line) and bm_TGtkTree_view_line)

proc typeTreeDragSource*(): GType = 
  result = treeDragSourceGetType()

proc treeDragSource*(obj: pointer): PTreeDragSource = 
  result = cast[PTreeDragSource](gTypeCheckInstanceCast(obj, 
      typeTreeDragSource()))

proc isTreeDragSource*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTreeDragSource())

proc treeDragSourceGetIface*(obj: pointer): PTreeDragSourceIface = 
  result = cast[PTreeDragSourceIface](gTypeInstanceGetInterface(obj, 
      typeTreeDragSource()))

proc typeTreeDragDest*(): GType = 
  result = treeDragDestGetType()

proc treeDragDest*(obj: pointer): PTreeDragDest = 
  result = cast[PTreeDragDest](gTypeCheckInstanceCast(obj, 
      typeTreeDragDest()))

proc isTreeDragDest*(obj: pointer): bool = 
  result = gTypeCheckInstanceType(obj, typeTreeDragDest())

proc treeDragDestGetIface*(obj: pointer): PTreeDragDestIface = 
  result = cast[PTreeDragDestIface](gTypeInstanceGetInterface(obj, 
      typeTreeDragDest()))

proc typeTreeItem*(): GType = 
  result = treeItemGetType()

proc treeItem*(obj: pointer): PTreeItem = 
  result = cast[PTreeItem](checkCast(obj, typeTreeItem()))

proc treeItemClass*(klass: pointer): PTreeItemClass = 
  result = cast[PTreeItemClass](checkClassCast(klass, typeTreeItem()))

proc isTreeItem*(obj: pointer): bool = 
  result = checkType(obj, typeTreeItem())

proc isTreeItemClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTreeItem())

proc treeItemGetClass*(obj: pointer): PTreeItemClass = 
  result = cast[PTreeItemClass](checkGetClass(obj, typeTreeItem()))

proc treeItemSubtree*(obj: pointer): PWidget = 
  result = (treeItem(obj)).subtree

proc expanded*(a: PTreeItem): guint = 
  result = (a.TreeItemflag0 and bm_TGtkTreeItem_expanded) shr
      bp_TGtkTreeItem_expanded

proc setExpanded*(a: PTreeItem, `expanded`: guint) = 
  a.TreeItemflag0 = a.TreeItemflag0 or
      (Int16(`expanded` shl bp_TGtkTreeItem_expanded) and
      bm_TGtkTreeItem_expanded)

proc typeTreeSelection*(): GType = 
  result = treeSelectionGetType()

proc treeSelection*(obj: pointer): PTreeSelection = 
  result = cast[PTreeSelection](checkCast(obj, typeTreeSelection()))

proc treeSelectionClass*(klass: pointer): PTreeSelectionClass = 
  result = cast[PTreeSelectionClass](checkClassCast(klass, 
      typeTreeSelection()))

proc isTreeSelection*(obj: pointer): bool = 
  result = checkType(obj, typeTreeSelection())

proc isTreeSelectionClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTreeSelection())

proc treeSelectionGetClass*(obj: pointer): PTreeSelectionClass = 
  result = cast[PTreeSelectionClass](checkGetClass(obj, typeTreeSelection()))

proc typeTreeStore*(): GType = 
  result = treeStoreGetType()

proc treeStore*(obj: pointer): PTreeStore = 
  result = cast[PTreeStore](checkCast(obj, typeTreeStore()))

proc treeStoreClass*(klass: pointer): PTreeStoreClass = 
  result = cast[PTreeStoreClass](checkClassCast(klass, typeTreeStore()))

proc isTreeStore*(obj: pointer): bool = 
  result = checkType(obj, typeTreeStore())

proc isTreeStoreClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTreeStore())

proc treeStoreGetClass*(obj: pointer): PTreeStoreClass = 
  result = cast[PTreeStoreClass](checkGetClass(obj, typeTreeStore()))

proc columnsDirty*(a: PTreeStore): guint = 
  result = (a.TreeStoreflag0 and bm_TGtkTreeStore_columns_dirty) shr
      bp_TGtkTreeStore_columns_dirty

proc setColumnsDirty*(a: PTreeStore, `columns_dirty`: guint) = 
  a.TreeStoreflag0 = a.TreeStoreflag0 or
      (Int16(`columnsDirty` shl bp_TGtkTreeStore_columns_dirty) and
      bm_TGtkTreeStore_columns_dirty)

proc typeTreeViewColumn*(): GType = 
  result = treeViewColumnGetType()

proc treeViewColumn*(obj: pointer): PTreeViewColumn = 
  result = cast[PTreeViewColumn](checkCast(obj, typeTreeViewColumn()))

proc treeViewColumnClass*(klass: pointer): PTreeViewColumnClass = 
  result = cast[PTreeViewColumnClass](checkClassCast(klass, 
      typeTreeViewColumn()))

proc isTreeViewColumn*(obj: pointer): bool = 
  result = checkType(obj, typeTreeViewColumn())

proc isTreeViewColumnClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTreeViewColumn())

proc treeViewColumnGetClass*(obj: pointer): PTreeViewColumnClass = 
  result = cast[PTreeViewColumnClass](checkGetClass(obj, 
      typeTreeViewColumn()))

proc visible*(a: PTreeViewColumn): guint = 
  result = (a.TreeViewColumnflag0 and bm_TGtkTreeViewColumn_visible) shr
      bp_TGtkTreeViewColumn_visible

proc setVisible*(a: PTreeViewColumn, `visible`: guint) = 
  a.TreeViewColumnflag0 = a.TreeViewColumnflag0 or
      (Int16(`visible` shl bp_TGtkTreeViewColumn_visible) and
      bm_TGtkTreeViewColumn_visible)

proc resizable*(a: PTreeViewColumn): guint = 
  result = (a.TreeViewColumnflag0 and bm_TGtkTreeViewColumn_resizable) shr
      bp_TGtkTreeViewColumn_resizable

proc setResizable*(a: PTreeViewColumn, `resizable`: guint) = 
  a.TreeViewColumnflag0 = a.TreeViewColumnflag0 or
      (Int16(`resizable` shl bp_TGtkTreeViewColumn_resizable) and
      bm_TGtkTreeViewColumn_resizable)

proc clickable*(a: PTreeViewColumn): guint = 
  result = (a.TreeViewColumnflag0 and bm_TGtkTreeViewColumn_clickable) shr
      bp_TGtkTreeViewColumn_clickable

proc setClickable*(a: PTreeViewColumn, `clickable`: guint) = 
  a.TreeViewColumnflag0 = a.TreeViewColumnflag0 or
      (Int16(`clickable` shl bp_TGtkTreeViewColumn_clickable) and
      bm_TGtkTreeViewColumn_clickable)

proc dirty*(a: PTreeViewColumn): guint = 
  result = (a.TreeViewColumnflag0 and bm_TGtkTreeViewColumn_dirty) shr
      bp_TGtkTreeViewColumn_dirty

proc setDirty*(a: PTreeViewColumn, `dirty`: guint) = 
  a.TreeViewColumnflag0 = a.TreeViewColumnflag0 or
      (Int16(`dirty` shl bp_TGtkTreeViewColumn_dirty) and
      bm_TGtkTreeViewColumn_dirty)

proc showSortIndicator*(a: PTreeViewColumn): guint = 
  result = (a.TreeViewColumnflag0 and
      bm_TGtkTreeViewColumn_show_sort_indicator) shr
      bp_TGtkTreeViewColumn_show_sort_indicator

proc setShowSortIndicator*(a: PTreeViewColumn, 
                              `show_sort_indicator`: guint) = 
  a.TreeViewColumnflag0 = a.TreeViewColumnflag0 or
      (Int16(`showSortIndicator` shl
      bp_TGtkTreeViewColumn_show_sort_indicator) and
      bm_TGtkTreeViewColumn_show_sort_indicator)

proc maybeReordered*(a: PTreeViewColumn): guint = 
  result = (a.TreeViewColumnflag0 and bm_TGtkTreeViewColumn_maybe_reordered) shr
      bp_TGtkTreeViewColumn_maybe_reordered

proc setMaybeReordered*(a: PTreeViewColumn, `maybe_reordered`: guint) = 
  a.TreeViewColumnflag0 = a.TreeViewColumnflag0 or
      (Int16(`maybeReordered` shl bp_TGtkTreeViewColumn_maybe_reordered) and
      bm_TGtkTreeViewColumn_maybe_reordered)

proc reorderable*(a: PTreeViewColumn): guint = 
  result = (a.TreeViewColumnflag0 and bm_TGtkTreeViewColumn_reorderable) shr
      bp_TGtkTreeViewColumn_reorderable

proc setReorderable*(a: PTreeViewColumn, `reorderable`: guint) = 
  a.TreeViewColumnflag0 = a.TreeViewColumnflag0 or
      (Int16(`reorderable` shl bp_TGtkTreeViewColumn_reorderable) and
      bm_TGtkTreeViewColumn_reorderable)

proc useResizedWidth*(a: PTreeViewColumn): guint = 
  result = (a.TreeViewColumnflag0 and bm_TGtkTreeViewColumn_use_resized_width) shr
      bp_TGtkTreeViewColumn_use_resized_width

proc setUseResizedWidth*(a: PTreeViewColumn, `use_resized_width`: guint) = 
  a.TreeViewColumnflag0 = a.TreeViewColumnflag0 or
      (Int16(`useResizedWidth` shl bp_TGtkTreeViewColumn_use_resized_width) and
      bm_TGtkTreeViewColumn_use_resized_width)

proc flags*(a: PRBNode): guint = 
  result = (a.flag0 and bm_TGtkRBNode_flags) shr bp_TGtkRBNode_flags

proc setFlags*(a: PRBNode, `flags`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`flags` shl bp_TGtkRBNode_flags) and bm_TGtkRBNode_flags)

proc parity*(a: PRBNode): guint = 
  result = (a.flag0 and bm_TGtkRBNode_parity) shr bp_TGtkRBNode_parity

proc setParity*(a: PRBNode, `parity`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`parity` shl bp_TGtkRBNode_parity) and bm_TGtkRBNode_parity)

proc getColor*(node: PRBNode): guint = 
  if node == nil: 
    Result = RBNODE_BLACK
  elif (Int(flags(node)) and RBNODE_RED) == RBNODE_RED: 
    Result = RBNODE_RED
  else: 
    Result = RBNODE_BLACK

proc setColor*(node: PRBNode, color: guint) = 
  if node == nil: 
    return 
  if ((flags(node) and (color)) != color): 
    setFlags(node, flags(node) xor Cint(RBNODE_RED or RBNODE_BLACK))

proc getHeight*(node: PRBNode): gint = 
  var ifLocal1: Gint
  if node.children != nil: 
    ifLocal1 = node.children.root.offset
  else: 
    ifLocal1 = 0
  result = node.offset -
      ((node.left.offset) + node.right.offset + ifLocal1)

proc flagSet*(node: PRBNode, flag: guint): bool = 
  result = (node != nil) and ((flags(node) and (flag)) == flag)

proc setFlag*(node: PRBNode, flag: guint16) = 
  setFlags(node, (flag) or flags(node))

proc unsetFlag*(node: PRBNode, flag: guint16) = 
  setFlags(node, (not (flag)) and flags(node))

proc flagSet*(tree_view: PTreeView, flag: guint): bool = 
  result = ((treeView.priv.flags) and (flag)) == flag

proc headerHeight*(tree_view: PTreeView): int32 = 
  var ifLocal1: Int32
  if flagSet(treeView, TREE_VIEW_HEADERS_VISIBLE): 
    ifLocal1 = treeView.priv.header_height
  else: 
    ifLocal1 = 0
  result = ifLocal1

proc columnRequestedWidth*(column: PTreeViewColumn): int32 = 
  var minWidth, maxWidth: Int
  if column.min_width != - 1'i32: 
    minWidth = column.min_width
  else: 
    minWidth = column.requested_width
  if column.max_width != - 1'i32: 
    maxWidth = column.max_width
  else: 
    maxWidth = column.requested_width
  result = clamp(column.requested_width, minWidth, maxWidth).Int32

proc drawExpanders*(tree_view: PTreeView): bool = 
  result = (not (flagSet(treeView, TREE_VIEW_IS_LIST))) and
      (flagSet(treeView, TREE_VIEW_SHOW_EXPANDERS))

proc columnDragDeadMultiplier*(tree_view: PTreeView): int32 = 
  result = 10'i32 * (headerHeight(treeView))

proc scrollToUseAlign*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_scroll_to_use_align) shr
      bp_TGtkTreeViewPrivate_scroll_to_use_align

proc setScrollToUseAlign*(a: PTreeViewPrivate, 
                              `scroll_to_use_align`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`scrollToUseAlign` shl
      bp_TGtkTreeViewPrivate_scroll_to_use_align) and
      bm_TGtkTreeViewPrivate_scroll_to_use_align)

proc fixedHeightCheck*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_fixed_height_check) shr
      bp_TGtkTreeViewPrivate_fixed_height_check

proc setFixedHeightCheck*(a: PTreeViewPrivate, 
                             `fixed_height_check`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`fixedHeightCheck` shl
      bp_TGtkTreeViewPrivate_fixed_height_check) and
      bm_TGtkTreeViewPrivate_fixed_height_check)

proc reorderable*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_reorderable) shr
      bp_TGtkTreeViewPrivate_reorderable

proc setReorderable*(a: PTreeViewPrivate, `reorderable`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`reorderable` shl bp_TGtkTreeViewPrivate_reorderable) and
      bm_TGtkTreeViewPrivate_reorderable)

proc headerHasFocus*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_header_has_focus) shr
      bp_TGtkTreeViewPrivate_header_has_focus

proc setHeaderHasFocus*(a: PTreeViewPrivate, `header_has_focus`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`headerHasFocus` shl bp_TGtkTreeViewPrivate_header_has_focus) and
      bm_TGtkTreeViewPrivate_header_has_focus)

proc dragColumnWindowState*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_drag_column_window_state) shr
      bp_TGtkTreeViewPrivate_drag_column_window_state

proc setDragColumnWindowState*(a: PTreeViewPrivate, 
                                   `drag_column_window_state`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`dragColumnWindowState` shl
      bp_TGtkTreeViewPrivate_drag_column_window_state) and
      bm_TGtkTreeViewPrivate_drag_column_window_state)

proc hasRules*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_has_rules) shr
      bp_TGtkTreeViewPrivate_has_rules

proc setHasRules*(a: PTreeViewPrivate, `has_rules`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`hasRules` shl bp_TGtkTreeViewPrivate_has_rules) and
      bm_TGtkTreeViewPrivate_has_rules)

proc markRowsColDirty*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_mark_rows_col_dirty) shr
      bp_TGtkTreeViewPrivate_mark_rows_col_dirty

proc setMarkRowsColDirty*(a: PTreeViewPrivate, 
                              `mark_rows_col_dirty`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`markRowsColDirty` shl
      bp_TGtkTreeViewPrivate_mark_rows_col_dirty) and
      bm_TGtkTreeViewPrivate_mark_rows_col_dirty)

proc enableSearch*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_enable_search) shr
      bp_TGtkTreeViewPrivate_enable_search

proc setEnableSearch*(a: PTreeViewPrivate, `enable_search`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`enableSearch` shl bp_TGtkTreeViewPrivate_enable_search) and
      bm_TGtkTreeViewPrivate_enable_search)

proc disablePopdown*(a: PTreeViewPrivate): guint = 
  result = (a.flag0 and bm_TGtkTreeViewPrivate_disable_popdown) shr
      bp_TGtkTreeViewPrivate_disable_popdown

proc setDisablePopdown*(a: PTreeViewPrivate, `disable_popdown`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`disablePopdown` shl bp_TGtkTreeViewPrivate_disable_popdown) and
      bm_TGtkTreeViewPrivate_disable_popdown)

proc setFlag*(tree_view: PTreeView, flag: guint) = 
  treeView.priv.flags = treeView.priv.flags or (flag)

proc unsetFlag*(tree_view: PTreeView, flag: guint) = 
  treeView.priv.flags = treeView.priv.flags and not (flag)

proc typeTreeView*(): GType = 
  result = treeViewGetType()

proc treeView*(obj: pointer): PTreeView = 
  result = cast[PTreeView](checkCast(obj, typeTreeView()))

proc treeViewClass*(klass: pointer): PTreeViewClass = 
  result = cast[PTreeViewClass](checkClassCast(klass, typeTreeView()))

proc isTreeView*(obj: pointer): bool = 
  result = checkType(obj, typeTreeView())

proc isTreeViewClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeTreeView())

proc treeViewGetClass*(obj: pointer): PTreeViewClass = 
  result = cast[PTreeViewClass](checkGetClass(obj, typeTreeView()))

proc typeVbuttonBox*(): GType = 
  result = vbuttonBoxGetType()

proc vbuttonBox*(obj: pointer): PVButtonBox = 
  result = cast[PVButtonBox](checkCast(obj, typeVbuttonBox()))

proc vbuttonBoxClass*(klass: pointer): PVButtonBoxClass = 
  result = cast[PVButtonBoxClass](checkClassCast(klass, typeVbuttonBox()))

proc isVbuttonBox*(obj: pointer): bool = 
  result = checkType(obj, typeVbuttonBox())

proc isVbuttonBoxClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeVbuttonBox())

proc vbuttonBoxGetClass*(obj: pointer): PVButtonBoxClass = 
  result = cast[PVButtonBoxClass](checkGetClass(obj, typeVbuttonBox()))

proc typeViewport*(): GType = 
  result = viewportGetType()

proc viewport*(obj: pointer): PViewport = 
  result = cast[PViewport](checkCast(obj, typeViewport()))

proc viewportClass*(klass: pointer): PViewportClass = 
  result = cast[PViewportClass](checkClassCast(klass, typeViewport()))

proc isViewport*(obj: pointer): bool = 
  result = checkType(obj, typeViewport())

proc isViewportClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeViewport())

proc viewportGetClass*(obj: pointer): PViewportClass = 
  result = cast[PViewportClass](checkGetClass(obj, typeViewport()))

proc typeVpaned*(): GType = 
  result = vpanedGetType()

proc vpaned*(obj: pointer): PVPaned = 
  result = cast[PVPaned](checkCast(obj, typeVpaned()))

proc vpanedClass*(klass: pointer): PVPanedClass = 
  result = cast[PVPanedClass](checkClassCast(klass, typeVpaned()))

proc isVpaned*(obj: pointer): bool = 
  result = checkType(obj, typeVpaned())

proc isVpanedClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeVpaned())

proc vpanedGetClass*(obj: pointer): PVPanedClass = 
  result = cast[PVPanedClass](checkGetClass(obj, typeVpaned()))

proc typeVruler*(): GType = 
  result = vrulerGetType()

proc vruler*(obj: pointer): PVRuler = 
  result = cast[PVRuler](checkCast(obj, typeVruler()))

proc vrulerClass*(klass: pointer): PVRulerClass = 
  result = cast[PVRulerClass](checkClassCast(klass, typeVruler()))

proc isVruler*(obj: pointer): bool = 
  result = checkType(obj, typeVruler())

proc isVrulerClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeVruler())

proc vrulerGetClass*(obj: pointer): PVRulerClass = 
  result = cast[PVRulerClass](checkGetClass(obj, typeVruler()))

proc typeVscale*(): GType = 
  result = vscaleGetType()

proc vscale*(obj: pointer): PVScale = 
  result = cast[PVScale](checkCast(obj, typeVscale()))

proc vscaleClass*(klass: pointer): PVScaleClass = 
  result = cast[PVScaleClass](checkClassCast(klass, typeVscale()))

proc isVscale*(obj: pointer): bool = 
  result = checkType(obj, typeVscale())

proc isVscaleClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeVscale())

proc vscaleGetClass*(obj: pointer): PVScaleClass = 
  result = cast[PVScaleClass](checkGetClass(obj, typeVscale()))

proc typeVscrollbar*(): GType = 
  result = vscrollbarGetType()

proc vscrollbar*(obj: pointer): PVScrollbar = 
  result = cast[PVScrollbar](checkCast(obj, typeVscrollbar()))

proc vscrollbarClass*(klass: pointer): PVScrollbarClass = 
  result = cast[PVScrollbarClass](checkClassCast(klass, typeVscrollbar()))

proc isVscrollbar*(obj: pointer): bool = 
  result = checkType(obj, typeVscrollbar())

proc isVscrollbarClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeVscrollbar())

proc vscrollbarGetClass*(obj: pointer): PVScrollbarClass = 
  result = cast[PVScrollbarClass](checkGetClass(obj, typeVscrollbar()))

proc typeVseparator*(): GType = 
  result = vseparatorGetType()

proc vseparator*(obj: pointer): PVSeparator = 
  result = cast[PVSeparator](checkCast(obj, typeVseparator()))

proc vseparatorClass*(klass: pointer): PVSeparatorClass = 
  result = cast[PVSeparatorClass](checkClassCast(klass, typeVseparator()))

proc isVseparator*(obj: pointer): bool = 
  result = checkType(obj, typeVseparator())

proc isVseparatorClass*(klass: pointer): bool = 
  result = checkClassType(klass, typeVseparator())

proc vseparatorGetClass*(obj: pointer): PVSeparatorClass = 
  # these were missing:
  result = cast[PVSeparatorClass](checkGetClass(obj, typeVseparator()))

type 
  Tcelllayout {.pure, final.} = object

  PCellLayout* = Tcelllayout
  PPGtkCellLayout* = ptr PCellLayout
  PSignalRunType* = ptr TSignalRunType
  TSignalRunType* = Int32
  PFileChooserAction* = ptr TFileChooserAction
  TFileChooserAction* = enum 
    FILE_CHOOSER_ACTION_OPEN, FILE_CHOOSER_ACTION_SAVE, 
    FILE_CHOOSER_ACTION_SELECT_FOLDER, FILE_CHOOSER_ACTION_CREATE_FOLDER
  PFileChooserError* = ptr TFileChooserError
  TFileChooserError* = enum 
    FILE_CHOOSER_ERROR_NONEXISTENT, FILE_CHOOSER_ERROR_BAD_FILENAME

  TFileChooser = object of TDialog
  PFileChooser* = ptr TFileChooser
  PPFileChooser* = ptr PFileChooser


const 
  ArgReadwrite* = ARG_READABLE or ARG_WRITABLE

proc entryAddSignal*(binding_set: PBindingSet, keyval: Guint, 
                               modifiers: gdk2.TModifierType, 
                               signal_name: Cstring, n_args: Guint){.varargs, 
    importc: "gtk_binding_entry_add_signal", cdecl, dynlib: lib.}
proc clistNewWithTitles*(columns: Gint): PCList{.varargs, cdecl, 
    importc: "gtk_clist_new_with_titles", dynlib: lib.}
proc prepend*(clist: PCList): Gint{.importc: "gtk_clist_prepend", varargs, 
    cdecl, dynlib: lib.}
proc append*(clist: PCList): Gint{.importc: "gtk_clist_append", varargs, 
    cdecl, dynlib: lib.}
proc insert*(clist: PCList, row: Gint): Gint{.varargs, cdecl, 
    importc: "gtk_clist_insert", dynlib: lib.}
proc setAttributes*(cell_layout: PCellLayout, cell: PCellRenderer){.
    cdecl, varargs, importc: "gtk_cell_layout_set_attributes", dynlib: lib, 
    importc: "gtk_cell_layout_set_attributes".}
proc addWithProperties*(container: PContainer, widget: PWidget, 
                                    first_prop_name: Cstring){.varargs, 
    importc: "gtk_container_add_with_properties", cdecl, dynlib: lib.}
proc childSet*(container: PContainer, child: PWidget, 
                          first_prop_name: Cstring){.varargs, cdecl, 
    importc: "gtk_container_child_set", dynlib: lib.}
proc childGet*(container: PContainer, child: PWidget, 
                          first_prop_name: Cstring){.varargs, cdecl, 
    importc: "gtk_container_child_get", dynlib: lib.}
proc childSetValist*(container: PContainer, child: PWidget, 
                                 first_property_name: Cstring){.varargs, 
    importc: "gtk_container_child_set_valist", cdecl, dynlib: lib.}
proc childGetValist*(container: PContainer, child: PWidget, 
                                 first_property_name: Cstring){.varargs, 
    importc: "gtk_container_child_get_valist", cdecl, dynlib: lib.}
proc ctreeNewWithTitles*(columns: Gint, tree_column: Gint): PCTree{.
    importc: "gtk_ctree_new_with_titles", varargs, cdecl, dynlib: lib.}
proc getVector*(curve: PCurve, veclen: Int32){.varargs, cdecl, 
    importc: "gtk_curve_get_vector", dynlib: lib.}
proc setVector*(curve: PCurve, veclen: Int32){.varargs, cdecl, 
    importc: "gtk_curve_set_vector", dynlib: lib.}
proc addButtons*(dialog: PDialog, first_button_text: Cstring){.varargs, 
    cdecl, importc: "gtk_dialog_add_buttons", dynlib: lib.}
proc dialogNewWithButtons*(title: Cstring, parent: PWindow, 
                              flags: TDialogFlags, first_button_text: Cstring): PDialog{.
    varargs, cdecl, importc: "gtk_dialog_new_with_buttons", dynlib: lib.}
proc listStoreNew*(n_columns: Gint): PListStore{.varargs, cdecl, 
    importc: "gtk_list_store_new", dynlib: lib.}
proc set*(list_store: PListStore, iter: PTreeIter){.varargs, cdecl, 
    importc: "gtk_list_store_set", dynlib: lib.}
proc setValist*(list_store: PListStore, iter: PTreeIter){.varargs, 
    cdecl, importc: "gtk_list_store_set_valist", dynlib: lib.}
proc messageDialogNew*(parent: PWindow, flags: TDialogFlags, 
                         thetype: TMessageType, buttons: TButtonsType, 
                         message_format: Cstring): PMessageDialog{.varargs, 
    cdecl, importc: "gtk_message_dialog_new", dynlib: lib.}
proc setMarkup*(msgDialog: PMessageDialog, str: Cstring) {.cdecl,
    importc: "gtk_message_dialog_set_markup", dynlib: lib.}

proc signalNew*(name: Cstring, signal_flags: TSignalRunType, 
                 object_type: TType, function_offset: Guint, 
                 marshaller: TSignalMarshaller, return_val: TType, n_args: Guint): Guint{.
    varargs, importc: "gtk_signal_new", cdecl, dynlib: lib.}
proc signalEmit*(anObject: PObject, signal_id: Guint){.varargs, cdecl, 
    importc: "gtk_signal_emit", dynlib: lib.}
proc signalEmitByName*(anObject: PObject, name: Cstring){.varargs, cdecl, 
    importc: "gtk_signal_emit_by_name", dynlib: lib.}
proc insertWithTags*(buffer: PTextBuffer, iter: PTextIter, 
                                   text: Cstring, length: Gint, 
                                   first_tag: PTextTag){.varargs, 
    importc: "gtk_text_buffer_insert_with_tags", cdecl, dynlib: lib.}
proc insertWithTagsByName*(buffer: PTextBuffer, iter: PTextIter, 
    text: Cstring, length: Gint, first_tag_name: Cstring){.varargs, 
    importc: "gtk_text_buffer_insert_with_tags_by_name", cdecl, dynlib: lib.}
proc createTag*(buffer: PTextBuffer, tag_name: Cstring, 
                             first_property_name: Cstring): PTextTag{.varargs, 
    importc: "gtk_text_buffer_create_tag", cdecl, dynlib: lib.}
proc get*(tree_model: PTreeModel, iter: PTreeIter){.varargs, 
    importc: "gtk_tree_model_get", cdecl, dynlib: lib.}
proc getValist*(tree_model: PTreeModel, iter: PTreeIter){.varargs, 
    importc: "gtk_tree_model_get_valist", cdecl, dynlib: lib.}
proc treeStoreNew*(n_columns: Gint): PTreeStore{.varargs, cdecl, 
    importc: "gtk_tree_store_new", dynlib: lib.}
proc set*(tree_store: PTreeStore, iter: PTreeIter){.varargs, cdecl, 
    importc: "gtk_tree_store_set", dynlib: lib.}
proc setValist*(tree_store: PTreeStore, iter: PTreeIter){.varargs, 
    cdecl, importc: "gtk_tree_store_set_valist", dynlib: lib.}
proc iterIsValid*(tree_store: PTreeStore, iter: PTreeIter): Gboolean{.
    cdecl, importc: "gtk_tree_store_iter_is_valid", dynlib: lib.}
proc reorder*(tree_store: PTreeStore, parent: PTreeIter, 
                         new_order: Pgint){.cdecl, 
    importc: "gtk_tree_store_reorder", dynlib: lib.}
proc swap*(tree_store: PTreeStore, a: PTreeIter, b: PTreeIter){.
    cdecl, importc: "gtk_tree_store_swap", dynlib: lib.}
proc moveBefore*(tree_store: PTreeStore, iter: PTreeIter, 
                             position: PTreeIter){.cdecl, 
    importc: "gtk_tree_store_move_before", dynlib: lib.}
proc moveAfter*(tree_store: PTreeStore, iter: PTreeIter, 
                            position: PTreeIter){.cdecl, 
    importc: "gtk_tree_store_move_after", dynlib: lib.}
proc insertColumnWithAttributes*(tree_view: PTreeView, 
    position: Gint, title: Cstring, cell: PCellRenderer): Gint{.varargs, 
    importc: "gtk_tree_view_insert_column_with_attributes", cdecl, dynlib: lib.}
proc treeViewColumnNewWithAttributes*(title: Cstring, cell: PCellRenderer): PTreeViewColumn{.
    importc: "gtk_tree_view_column_new_with_attributes", varargs, cdecl, 
    dynlib: lib.}
proc columnSetAttributes*(tree_column: PTreeViewColumn, 
                                      cell_renderer: PCellRenderer){.
    importc: "gtk_tree_view_column_set_attributes", varargs, cdecl, dynlib: lib.}
proc widgetNew*(thetype: TType, first_property_name: Cstring): PWidget{.
    importc: "gtk_widget_new", varargs, cdecl, dynlib: lib.}
proc set*(widget: PWidget, first_property_name: Cstring){.varargs, 
    importc: "gtk_widget_set", cdecl, dynlib: lib.}
proc queueClear*(widget: PWidget){.importc: "gtk_widget_queue_clear", 
    cdecl, dynlib: lib.}
proc queueClearArea*(widget: PWidget, x: Gint, y: Gint, width: Gint, 
                              height: Gint){.cdecl, 
    importc: "gtk_widget_queue_clear_area", dynlib: lib.}
proc draw*(widget: PWidget, area: gdk2.PRectangle){.cdecl, 
    importc: "gtk_widget_draw", dynlib: lib.}
proc styleGetValist*(widget: PWidget, first_property_name: Cstring){.
    varargs, cdecl, importc: "gtk_widget_style_get_valist", dynlib: lib.}
proc styleGet*(widget: PWidget, first_property_name: Cstring){.varargs, 
    cdecl, importc: "gtk_widget_style_get", dynlib: lib.}
proc fileChooserDialogNew*(title: Cstring, parent: PWindow, 
                              action: TFileChooserAction, 
                              first_button_text: Cstring): PFileChooser{.cdecl, 
    varargs, dynlib: lib, importc: "gtk_file_chooser_dialog_new".}
        
proc fileChooserDialogNewWithBackend*(title: Cstring, parent: PWindow, 
    action: TFileChooserAction, backend: Cstring, first_button_text: Cstring): PFileChooser{.
    varargs, cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_dialog_new_with_backend".}
proc reference*(anObject: PObject): PObject{.cdecl, importc: "gtk_object_ref", 
    dynlib: lib.}
proc unref*(anObject: PObject){.cdecl, importc: "gtk_object_unref", 
                                       dynlib: lib.}
proc weakref*(anObject: PObject, notify: TDestroyNotify, data: Gpointer){.
    cdecl, importc: "gtk_object_weakref", dynlib: lib.}
proc weakunref*(anObject: PObject, notify: TDestroyNotify, data: Gpointer){.
    cdecl, importc: "gtk_object_weakunref", dynlib: lib.}
proc setData*(anObject: PObject, key: Cstring, data: Gpointer){.cdecl, 
    importc: "gtk_object_set_data", dynlib: lib.}
proc setDataFull*(anObject: PObject, key: Cstring, data: Gpointer, 
                           destroy: TDestroyNotify){.
    importc: "gtk_object_set_data_full", cdecl, dynlib: lib.}
proc removeData*(anObject: PObject, key: Cstring){.cdecl, 
    importc: "gtk_object_remove_data", dynlib: lib.}
proc getData*(anObject: PObject, key: Cstring): Gpointer{.cdecl, 
    importc: "gtk_object_get_data", dynlib: lib.}
proc removeNoNotify*(anObject: PObject, key: Cstring){.cdecl, 
    importc: "gtk_object_remove_no_notify", dynlib: lib.}
proc setUserData*(anObject: PObject, data: Gpointer){.cdecl, 
    importc: "gtk_object_set_user_data", dynlib: lib.}
proc getUserData*(anObject: PObject): Gpointer{.cdecl, 
    importc: "gtk_object_get_user_data", dynlib: lib.}
proc setDataById*(anObject: PObject, data_id: TGQuark, data: Gpointer){.
    cdecl, importc: "gtk_object_set_data_by_id", dynlib: lib.}
proc setDataByIdFull*(anObject: PObject, data_id: TGQuark, 
                                 data: Gpointer, destroy: TDestroyNotify){.
    cdecl, importc: "gtk_object_set_data_by_id_full", dynlib: lib.}
proc getDataById*(anObject: PObject, data_id: TGQuark): Gpointer{.
    cdecl, importc: "gtk_object_get_data_by_id", dynlib: lib.}
proc removeDataById*(anObject: PObject, data_id: TGQuark){.cdecl, 
    importc: "gtk_object_remove_data_by_id", dynlib: lib.}
proc removeNoNotifyById*(anObject: PObject, key_id: TGQuark){.cdecl, 
    importc: "gtk_object_remove_no_notify_by_id", dynlib: lib.}
proc objectDataTryKey*(str: Cstring): TGQuark{.cdecl, 
    importc: "gtk_object_data_try_key", dynlib: lib.}
proc objectDataForceId*(str: Cstring): TGQuark{.cdecl, 
    importc: "gtk_object_data_force_id", dynlib: lib.}
proc get*(anObject: PObject, first_property_name: Cstring){.cdecl, 
    importc: "gtk_object_get", varargs, dynlib: lib.}
proc set*(anObject: PObject, first_property_name: Cstring){.cdecl, 
    importc: "gtk_object_set", varargs, dynlib: lib.}
proc objectAddArgType*(arg_name: Cstring, arg_type: TType, arg_flags: Guint, 
                          arg_id: Guint){.cdecl, 
    importc: "gtk_object_add_arg_type", dynlib: lib.}

type 
  TFileFilter {.pure, final.} = object
  PFileFilter* = ptr TFileFilter
  PPGtkFileFilter* = ptr PFileFilter
  PFileFilterFlags* = ptr TFileFilterFlags
  TFileFilterFlags* = enum 
    FILE_FILTER_FILENAME = 1 shl 0, FILE_FILTER_URI = 1 shl 1, 
    FILE_FILTER_DISPLAY_NAME = 1 shl 2, FILE_FILTER_MIME_TYPE = 1 shl 3
  PFileFilterInfo* = ptr TFileFilterInfo
  TFileFilterInfo*{.final, pure.} = object 
    contains*: TFileFilterFlags
    filename*: Cstring
    uri*: Cstring
    display_name*: Cstring
    mime_type*: Cstring

  TFileFilterFunc* = proc (filter_info: PFileFilterInfo, data: Gpointer): Gboolean{.
      cdecl.}

proc typeFileFilter*(): GType
proc fileFilter*(obj: Pointer): PFileFilter
proc isFileFilter*(obj: Pointer): Gboolean
proc fileFilterGetType*(): GType{.cdecl, dynlib: lib, 
                                     importc: "gtk_file_filter_get_type".}
proc fileFilterNew*(): PFileFilter{.cdecl, dynlib: lib, 
                                      importc: "gtk_file_filter_new".}
proc setName*(filter: PFileFilter, name: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_file_filter_set_name".}
proc getName*(filter: PFileFilter): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_file_filter_get_name".}
proc addMimeType*(filter: PFileFilter, mime_type: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_file_filter_add_mime_type".}
proc addPattern*(filter: PFileFilter, pattern: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_file_filter_add_pattern".}
proc addCustom*(filter: PFileFilter, needed: TFileFilterFlags, 
                             func: TFileFilterFunc, data: Gpointer, 
                             notify: TGDestroyNotify){.cdecl, dynlib: lib, 
    importc: "gtk_file_filter_add_custom".}
proc getNeeded*(filter: PFileFilter): TFileFilterFlags{.cdecl, 
    dynlib: lib, importc: "gtk_file_filter_get_needed".}
proc filter*(filter: PFileFilter, filter_info: PFileFilterInfo): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_filter_filter".}
proc typeFileFilter(): GType = 
  result = fileFilterGetType()

proc fileFilter(obj: pointer): PFileFilter = 
  result = cast[PFileFilter](gTypeCheckInstanceCast(obj, typeFileFilter()))

proc isFileFilter(obj: pointer): gboolean = 
  result = gTypeCheckInstanceType(obj, typeFileFilter())

proc fileChooserGetType*(): GType{.cdecl, dynlib: lib, 
                                      importc: "gtk_file_chooser_get_type".}
proc fileChooserErrorQuark*(): TGQuark{.cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_error_quark".}
proc typeFileChooser*(): GType = 
  result = fileChooserGetType()

proc fileChooser*(obj: Pointer): PFileChooser = 
  result = cast[PFileChooser](gTypeCheckInstanceCast(obj, 
      typeFileChooser()))

proc isFileChooser*(obj: Pointer): Gboolean = 
  result = gTypeCheckInstanceType(obj, typeFileChooser())

proc setAction*(chooser: PFileChooser, action: TFileChooserAction){.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_action".}
proc getAction*(chooser: PFileChooser): TFileChooserAction{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_action".}
proc setLocalOnly*(chooser: PFileChooser, local_only: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_local_only".}
proc getLocalOnly*(chooser: PFileChooser): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_local_only".}
proc setSelectMultiple*(chooser: PFileChooser, 
                                       select_multiple: Gboolean){.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_set_select_multiple".}
proc getSelectMultiple*(chooser: PFileChooser): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_select_multiple".}
proc setCurrentName*(chooser: PFileChooser, name: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_current_name".}
proc getFilename*(chooser: PFileChooser): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_filename".}
proc setFilename*(chooser: PFileChooser, filename: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_filename".}
proc selectFilename*(chooser: PFileChooser, filename: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_select_filename".}
proc unselectFilename*(chooser: PFileChooser, filename: Cstring){.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_unselect_filename".}
proc selectAll*(chooser: PFileChooser){.cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_select_all".}
proc unselectAll*(chooser: PFileChooser){.cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_unselect_all".}
proc getFilenames*(chooser: PFileChooser): PGSList{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_filenames".}
proc setCurrentFolder*(chooser: PFileChooser, filename: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_current_folder".}
proc getCurrentFolder*(chooser: PFileChooser): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_current_folder".}
proc getUri*(chooser: PFileChooser): Cstring{.cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_get_uri".}
proc setUri*(chooser: PFileChooser, uri: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_uri".}
proc selectUri*(chooser: PFileChooser, uri: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_select_uri".}
proc unselectUri*(chooser: PFileChooser, uri: Cstring){.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_unselect_uri".}
proc getUris*(chooser: PFileChooser): PGSList{.cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_get_uris".}
proc setCurrentFolderUri*(chooser: PFileChooser, uri: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_current_folder_uri".}
proc getCurrentFolderUri*(chooser: PFileChooser): Cstring{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_get_current_folder_uri".}
proc setPreviewWidget*(chooser: PFileChooser, 
                                      preview_widget: PWidget){.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_set_preview_widget".}
proc getPreviewWidget*(chooser: PFileChooser): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_preview_widget".}
proc setPreviewWidgetActive*(chooser: PFileChooser, 
    active: Gboolean){.cdecl, dynlib: lib, 
                       importc: "gtk_file_chooser_set_preview_widget_active".}
proc getPreviewWidgetActive*(chooser: PFileChooser): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_get_preview_widget_active".}
proc setUsePreviewLabel*(chooser: PFileChooser, 
    use_label: Gboolean){.cdecl, dynlib: lib, 
                          importc: "gtk_file_chooser_set_use_preview_label".}
proc getUsePreviewLabel*(chooser: PFileChooser): Gboolean{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_get_use_preview_label".}
proc getPreviewFilename*(chooser: PFileChooser): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_preview_filename".}
proc getPreviewUri*(chooser: PFileChooser): Cstring{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_preview_uri".}
proc setExtraWidget*(chooser: PFileChooser, extra_widget: PWidget){.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_extra_widget".}
proc getExtraWidget*(chooser: PFileChooser): PWidget{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_extra_widget".}
proc addFilter*(chooser: PFileChooser, filter: PFileFilter){.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_add_filter".}
proc removeFilter*(chooser: PFileChooser, filter: PFileFilter){.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_remove_filter".}
proc listFilters*(chooser: PFileChooser): PGSList{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_list_filters".}
proc setFilter*(chooser: PFileChooser, filter: PFileFilter){.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_set_filter".}
proc getFilter*(chooser: PFileChooser): PFileFilter{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_get_filter".}
proc addShortcutFolder*(chooser: PFileChooser, folder: Cstring, 
                                       error: Pointer): Gboolean{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_add_shortcut_folder".}
proc removeShortcutFolder*(chooser: PFileChooser, 
    folder: Cstring, error: Pointer): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_remove_shortcut_folder".}
proc listShortcutFolders*(chooser: PFileChooser): PGSList{.cdecl, 
    dynlib: lib, importc: "gtk_file_chooser_list_shortcut_folders".}
proc addShortcutFolderUri*(chooser: PFileChooser, uri: Cstring, 
    error: Pointer): Gboolean{.cdecl, dynlib: lib, importc: "gtk_file_chooser_add_shortcut_folder_uri".}
proc removeShortcutFolderUri*(chooser: PFileChooser, 
    uri: Cstring, error: Pointer): Gboolean{.cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_remove_shortcut_folder_uri".}
proc listShortcutFolderUris*(chooser: PFileChooser): PGSList{.
    cdecl, dynlib: lib, importc: "gtk_file_chooser_list_shortcut_folder_uris".}
proc setDoOverwriteConfirmation*(chooser: PFileChooser, 
    do_overwrite_confirmation: Gboolean){.cdecl, dynlib: lib, 
    importc: "gtk_file_chooser_set_do_overwrite_confirmation".}

proc getRealized*(w: PWidget): Gboolean {.cdecl, dynlib: lib,
                                           importc: "gtk_widget_get_realized".}

proc setSkipTaskbarHint*(window: PWindow, setting: Gboolean){.cdecl,
  dynlib: lib, importc: "gtk_window_set_skip_taskbar_hint".}

type
  TTooltip* {.pure, final.} = object
  PTooltip* = ptr TTooltip

proc setTooltipText*(w: PWidget, t: Cstring){.cdecl,
  dynlib: lib, importc: "gtk_widget_set_tooltip_text".}

proc getTooltipText*(w: PWidget): Cstring{.cdecl,
  dynlib: lib, importc: "gtk_widget_get_tooltip_text".}

proc setTooltipMarkup*(w: PWidget, m: Cstring) {.cdecl, dynlib: lib,
  importc: "gtk_widget_set_tooltip_markup".}

proc getTooltipMarkup*(w: PWidget): Cstring {.cdecl, dynlib: lib,
  importc: "gtk_widget_get_tooltip_markup".}

proc setTooltipColumn*(w: PTreeView, column: Gint){.cdecl,
  dynlib: lib, importc: "gtk_tree_view_set_tooltip_column".}

proc triggerTooltipQuery*(widg: PWidget){.cdecl, dynlib: lib, 
  importc: "gtk_widget_trigger_tooltip_query".}

proc triggerTooltipQuery*(widg: PTooltip){.cdecl, dynlib: lib, 
  importc: "gtk_tooltip_trigger_tooltip_query".}

proc setHasTooltip*(widget: PWidget, b: Gboolean){.cdecl, dynlib: lib, 
  importc: "gtk_widget_set_has_tooltip".}

proc getHasTooltip*(widget: PWidget): Gboolean{.cdecl, dynlib: lib, 
  importc: "gtk_widget_get_has_tooltip".}

proc setMarkup*(tp: PTooltip, mk: Cstring){.cdecl, dynlib: lib, 
  importc: "gtk_tooltip_set_markup".}

proc setVisibleWindow*(evBox: PEventBox, v: Gboolean){.cdecl, dynlib: lib,
  importc: "gtk_event_box_set_visible_window".}

proc getVadjustment*(scrolled_window: PTextView): PAdjustment{.
    cdecl, dynlib: lib, importc: "gtk_text_view_get_vadjustment".}

type
  TInfoBar* = object of THBox
  PInfoBar* = ptr TInfoBar

proc infoBarNew*(): PInfoBar{.cdecl, dynlib: lib, importc: "gtk_info_bar_new".}
proc infoBarNewWithButtons*(first_button_text: Cstring): PInfoBar {.cdecl, dynlib:lib,
    varargs, importc: "gtk_info_bar_new_with_buttons".}
proc addActionWidget*(infobar: PInfoBar, child: PWidget, respID: Gint) {.
    cdecl, dynlib: lib, importc: "gtk_info_bar_add_action_widget".}
proc addButton*(infobar: PInfoBar, btnText: Cstring, respID: Gint): PWidget{.
    cdecl, dynlib: lib, importc: "gtk_info_bar_add_button".}
proc setResponseSensitive*(infobar: PInfoBar, respID: Gint, setting: Gboolean){.
    cdecl, dynlib: lib, importc: "gtk_info_bar_set_response_sensitive".}
proc setDefaultResponse*(infobar: PInfoBar, respID: Gint){.cdecl,
    dynlib: lib, importc: "gtk_info_bar_set_default_response".}
proc response*(infobar: PInfoBar, respID: Gint){.cdecl, dynlib: lib,
    importc: "gtk_info_bar_response".}
proc setMessageType*(infobar: PInfoBar, messageType: TMessageType){.cdecl,
    dynlib: lib, importc: "gtk_info_bar_set_message_type".}
proc getMessageType*(infobar: PInfoBar): TMessageType{.cdecl, dynlib: lib,
    importc: "gtk_info_bar_get_message_type".}
proc getActionArea*(infobar: PInfoBar): PWidget{.cdecl, dynlib: lib,
    importc: "gtk_info_bar_get_action_area".}
proc getContentArea*(infobar: PInfoBar): PContainer{.cdecl, dynlib: lib,
    importc: "gtk_info_bar_get_content_area".}

type
  TComboBox* = object of TWidget
  PComboBox* = ptr TComboBox

proc comboBoxNew*(): PComboBox{.cdecl, importc: "gtk_combo_box_new", dynlib: lib.}
proc comboBoxNewWithEntry*(): PComboBox{.cdecl, 
                                       importc: "gtk_combo_box_new_with_entry", 
                                       dynlib: lib.}
proc comboBoxNewWithModel*(model: PTreeModel): PComboBox{.cdecl, 
    importc: "gtk_combo_box_new_with_model", dynlib: lib.}
proc comboBoxNewWithModelAndEntry*(model: PTreeModel): PComboBox{.cdecl, 
    importc: "gtk_combo_box_new_with_model_and_entry", dynlib: lib.}

proc getWrapWidth*(combo_box: PComboBox): Gint{.cdecl, 
    importc: "gtk_combo_box_get_wrap_width", dynlib: lib.}
proc setWrapWidth*(combo_box: PComboBox; width: Gint){.cdecl, 
    importc: "gtk_combo_box_set_wrap_width", dynlib: lib.}
proc getRowSpanColumn*(combo_box: PComboBox): Gint{.cdecl, 
    importc: "gtk_combo_box_get_row_span_column", dynlib: lib.}
proc setRowSpanColumn*(combo_box: PComboBox; row_span: Gint){.cdecl, 
    importc: "gtk_combo_box_set_row_span_column", dynlib: lib.}
proc getColumnSpanColumn*(combo_box: PComboBox): Gint{.cdecl, 
    importc: "gtk_combo_box_get_column_span_column", dynlib: lib.}
proc setColumnSpanColumn*(combo_box: PComboBox; column_span: Gint){.
    cdecl, importc: "gtk_combo_box_set_column_span_column", dynlib: lib.}
proc getAddTearoffs*(combo_box: PComboBox): Gboolean{.cdecl, 
    importc: "gtk_combo_box_get_add_tearoffs", dynlib: lib.}
proc setAddTearoffs*(combo_box: PComboBox; add_tearoffs: Gboolean){.
    cdecl, importc: "gtk_combo_box_set_add_tearoffs", dynlib: lib.}
proc getTitle*(combo_box: PComboBox): ptr Gchar{.cdecl, 
    importc: "gtk_combo_box_get_title", dynlib: lib.}
proc setTitle*(combo_box: PComboBox; title: ptr Gchar){.cdecl, 
    importc: "gtk_combo_box_set_title", dynlib: lib.}
proc getFocusOnClick*(combo: PComboBox): Gboolean{.cdecl, 
    importc: "gtk_combo_box_get_focus_on_click", dynlib: lib.}
proc setFocusOnClick*(combo: PComboBox; focus_on_click: Gboolean){.
    cdecl, importc: "gtk_combo_box_set_focus_on_click", dynlib: lib.}

proc getActive*(combo_box: PComboBox): Gint{.cdecl, 
    importc: "gtk_combo_box_get_active", dynlib: lib.}
proc setActive*(combo_box: PComboBox; index: Gint){.cdecl, 
    importc: "gtk_combo_box_set_active", dynlib: lib.}
proc getActiveIter*(combo_box: PComboBox; iter: PTreeIter): Gboolean{.
    cdecl, importc: "gtk_combo_box_get_active_iter", dynlib: lib.}
proc setActiveIter*(combo_box: PComboBox; iter: PTreeIter){.cdecl, 
    importc: "gtk_combo_box_set_active_iter", dynlib: lib.}

proc setModel*(combo_box: PComboBox; model: PTreeModel){.cdecl, 
    importc: "gtk_combo_box_set_model", dynlib: lib.}
proc getModel*(combo_box: PComboBox): PTreeModel{.cdecl, 
    importc: "gtk_combo_box_get_model", dynlib: lib.}
discard """proc get_row_separator_func*(combo_box: PComboBox): GtkTreeViewRowSeparatorFunc{.
    cdecl, importc: "gtk_combo_box_get_row_separator_func", dynlib: lib.}
proc set_row_separator_func*(combo_box: PComboBox; 
                             func: GtkTreeViewRowSeparatorFunc; data: gpointer; 
                             destroy: GDestroyNotify){.cdecl, 
    importc: "gtk_combo_box_set_row_separator_func", dynlib: lib.}"""
discard """proc set_button_sensitivity*(combo_box: PComboBox; 
                             sensitivity: GtkSensitivityType){.cdecl, 
    importc: "gtk_combo_box_set_button_sensitivity", dynlib: lib.}
proc get_button_sensitivity*(combo_box: PComboBox): GtkSensitivityType{.
    cdecl, importc: "gtk_combo_box_get_button_sensitivity", dynlib: lib.}"""
proc getHasEntry*(combo_box: PComboBox): Gboolean{.cdecl, 
    importc: "gtk_combo_box_get_has_entry", dynlib: lib.}
proc setEntryTextColumn*(combo_box: PComboBox; text_column: Gint){.
    cdecl, importc: "gtk_combo_box_set_entry_text_column", dynlib: lib.}
proc getEntryTextColumn*(combo_box: PComboBox): Gint{.cdecl, 
    importc: "gtk_combo_box_get_entry_text_column", dynlib: lib.}

proc popup*(combo_box: PComboBox){.cdecl, importc: "gtk_combo_box_popup", 
    dynlib: lib.}
proc popdown*(combo_box: PComboBox){.cdecl, 
    importc: "gtk_combo_box_popdown", dynlib: lib.}
discard """proc get_popup_accessible*(combo_box: PComboBox): ptr AtkObject{.cdecl, 
    importc: "gtk_combo_box_get_popup_accessible", dynlib: lib.}"""

type
  TComboBoxText* = object of TComboBox
  PComboBoxText* = ptr TComboBoxText

proc comboBoxTextNew*(): PComboBoxText{.cdecl, importc: "gtk_combo_box_text_new", 
                                 dynlib: lib.}
proc comboBoxTextNewWithEntry*(): PComboBoxText{.cdecl, 
    importc: "gtk_combo_box_text_new_with_entry", dynlib: lib.}
proc appendText*(combo_box: PComboBoxText; text: Cstring){.cdecl, 
    importc: "gtk_combo_box_text_append_text", dynlib: lib.}
proc insertText*(combo_box: PComboBoxText; position: Gint; 
                       text: Cstring){.cdecl, 
    importc: "gtk_combo_box_text_insert_text", dynlib: lib.}
proc prependText*(combo_box: PComboBoxText; text: Cstring){.cdecl, 
    importc: "gtk_combo_box_text_prepend_text", dynlib: lib.}
proc remove*(combo_box: PComboBoxText; position: Gint){.cdecl, 
    importc: "gtk_combo_box_text_remove", dynlib: lib.}
proc getActiveText*(combo_box: PComboBoxText): Cstring{.cdecl, 
    importc: "gtk_combo_box_text_get_active_text", dynlib: lib.}
proc isActive*(win: PWindow): Gboolean{.cdecl,
    importc: "gtk_window_is_active", dynlib: lib.}
proc hasToplevelFocus*(win: PWindow): Gboolean{.cdecl,
    importc: "gtk_window_has_toplevel_focus", dynlib: lib.}

proc nimrodInit*() =
  var
    cmdLine{.importc: "cmdLine".}: Array[0..255, Cstring]
    cmdCount{.importc: "cmdCount".}: Cint
  init(addr(cmdLine), addr(cmdCount))
