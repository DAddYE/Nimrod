{.deadCodeElim: on.}
when defined(windows): 
  const 
    gliblib = "libglib-2.0-0.dll"
    gmodulelib = "libgmodule-2.0-0.dll"
    gobjectlib = "libgobject-2.0-0.dll"
elif defined(macosx): 
  const 
    gliblib = "libglib-2.0.dylib"
    gmodulelib = "libgmodule-2.0.dylib"
    gobjectlib = "libgobject-2.0.dylib"
else: 
  const 
    gliblib = "libglib-2.0.so(|.0)"
    gmodulelib = "libgmodule-2.0.so(|.0)"
    gobjectlib = "libgobject-2.0.so(|.0)"
# gthreadlib = "libgthread-2.0.so"

type 
  PGTypePlugin* = Pointer
  PGParamSpecPool* = Pointer
  PPchar* = ptr Cstring
  PPPchar* = ptr PPchar
  PPPgchar* = ptr PPgchar
  PPgchar* = ptr Cstring
  Gchar* = Char
  Gshort* = Cshort
  Glong* = Clong
  Gint* = Cint
  Gboolean* = distinct Gint
  Guchar* = Char
  Gushort* = Int16
  Gulong* = Int
  Guint* = Cint
  Gfloat* = Cfloat
  Gdouble* = Cdouble
  Gpointer* = Pointer
  Pgshort* = ptr Gshort
  Pglong* = ptr Glong
  Pgint* = ptr Gint
  PPgint* = ptr Pgint
  Pgboolean* = ptr Gboolean
  Pguchar* = ptr Guchar
  PPguchar* = ptr Pguchar
  Pgushort* = ptr Gushort
  Pgulong* = ptr Gulong
  Pguint* = ptr Guint
  Pgfloat* = ptr Gfloat
  Pgdouble* = ptr Gdouble
  Pgpointer* = ptr Gpointer
  Gconstpointer* = Pointer
  PGCompareFunc* = ptr TGCompareFunc
  TGCompareFunc* = proc (a, b: Gconstpointer): Gint{.cdecl.}
  PGCompareDataFunc* = ptr TGCompareDataFunc
  TGCompareDataFunc* = proc (a, b: Gconstpointer, user_data: Gpointer): Gint{.
      cdecl.}
  PGEqualFunc* = ptr TGEqualFunc
  TGEqualFunc* = proc (a, b: Gconstpointer): Gboolean{.cdecl.}
  PGDestroyNotify* = ptr TGDestroyNotify
  TGDestroyNotify* = proc (data: Gpointer){.cdecl.}
  PGFunc* = ptr TGFunc
  TGFunc* = proc (data, userdata: Gpointer, key: Gconstpointer){.cdecl.}
  PGHashFunc* = ptr TGHashFunc
  TGHashFunc* = proc (key: Gconstpointer): Guint{.cdecl.}
  PGHFunc* = ptr TGHFunc
  TGHFunc* = proc (key, value, user_data: Gpointer){.cdecl.}
  PGFreeFunc* = proc (data: Gpointer){.cdecl.}
  PGTimeVal* = ptr TGTimeVal
  TGTimeVal*{.final.} = object 
    tv_sec*: Glong
    tv_usec*: Glong

  Guint64* = Int64
  Gint8* = Int8
  Guint8* = Int8
  Gint16* = Int16
  Guint16* = Int16
  Gint32* = Int32
  Guint32* = Int32
  Gint64* = Int64
  Gssize* = Int32
  Gsize* = Int32
  Pgint8* = ptr Gint8
  Pguint8* = ptr Guint8
  Pgint16* = ptr Gint16
  Pguint16* = ptr Guint16
  Pgint32* = ptr Gint32
  Pguint32* = ptr Guint32
  Pgint64* = ptr Gint64
  Pguint64* = ptr Guint64
  Pgssize* = ptr Gssize
  Pgsize* = ptr Gsize
  TGQuark* = Guint32
  PGQuark* = ptr TGQuark
  PGTypeCValue* = ptr TGTypeCValue
  TGTypeCValue*{.final.} = object 
    v_double*: Gdouble

  GType* = Gulong
  PGType* = ptr GType
  PGTypeClass* = ptr TGTypeClass
  TGTypeClass*{.final.} = object 
    gType*: GType

  PGTypeInstance* = ptr TGTypeInstance
  TGTypeInstance*{.final.} = object 
    gClass*: PGTypeClass

  PGTypeInterface* = ptr TGTypeInterface
  TGTypeInterface*{.pure, inheritable.} = object 
    gType*: GType
    g_instance_type*: GType

  PGTypeQuery* = ptr TGTypeQuery
  TGTypeQuery*{.final.} = object 
    theType*: GType
    type_name*: Cstring
    class_size*: Guint
    instance_size*: Guint

  PGValue* = ptr TGValue
  TGValue*{.final.} = object 
    gType*: GType
    data*: Array[0..1, Gdouble]

  PGData* = Pointer
  PPGData* = ptr PGData
  PGSList* = ptr TGSList
  PPGSList* = ptr PGSList
  TGSList*{.final.} = object 
    data*: Gpointer
    next*: PGSList

  PGList* = ptr TGList
  TGList*{.final.} = object 
    data*: Gpointer
    next*: PGList
    prev*: PGList

  TGParamFlags* = Int32
  PGParamFlags* = ptr TGParamFlags
  PGParamSpec* = ptr TGParamSpec
  PPGParamSpec* = ptr PGParamSpec
  TGParamSpec*{.final.} = object 
    g_type_instance*: TGTypeInstance
    name*: Cstring
    flags*: TGParamFlags
    valueType*: GType
    owner_type*: GType
    nick*: Cstring
    blurb*: Cstring
    qdata*: PGData
    ref_count*: Guint
    param_id*: Guint

  PGParamSpecClass* = ptr TGParamSpecClass
  TGParamSpecClass*{.final.} = object 
    g_type_class*: TGTypeClass
    value_type*: GType
    finalize*: proc (pspec: PGParamSpec){.cdecl.}
    value_set_default*: proc (pspec: PGParamSpec, value: PGValue){.cdecl.}
    value_validate*: proc (pspec: PGParamSpec, value: PGValue): Gboolean{.cdecl.}
    values_cmp*: proc (pspec: PGParamSpec, value1: PGValue, value2: PGValue): Gint{.
        cdecl.}
    dummy*: Array[0..3, Gpointer]

  PGParameter* = ptr TGParameter
  TGParameter*{.final.} = object 
    name*: Cstring
    value*: TGValue

  TGBoxedCopyFunc* = proc (boxed: Gpointer): Gpointer{.cdecl.}
  TGBoxedFreeFunc* = proc (boxed: Gpointer){.cdecl.}
  PGsource = Pointer          # I don't know and don't care

converter gbool*(nimbool: Bool): Gboolean =
  return ord(nimbool).Gboolean

converter toBool*(gbool: Gboolean): Bool =
  return Int(gbool) == 1

const 
  GTypeFundamentalShift* = 2
  GTypeFundamentalMax* = 255 shl G_TYPE_FUNDAMENTAL_SHIFT
  GTypeInvalid* = GType(0 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeNone* = GType(1 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeInterface* = GType(2 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeChar* = GType(3 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeUchar* = GType(4 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeBoolean* = GType(5 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeInt* = GType(6 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeUint* = GType(7 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeLong* = GType(8 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeUlong* = GType(9 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeInt64* = GType(10 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeUint64* = GType(11 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeEnum* = GType(12 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeFlags* = GType(13 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeFloat* = GType(14 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeDouble* = GType(15 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeString* = GType(16 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypePointer* = GType(17 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeBoxed* = GType(18 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeParam* = GType(19 shl G_TYPE_FUNDAMENTAL_SHIFT)
  GTypeObject* = GType(20 shl G_TYPE_FUNDAMENTAL_SHIFT)

const
  GPriorityHighIdle* = 100
  GPriorityDefaultIdle* = 200
  GPriorityLow* = 300
  GPriorityHigh* = -100
  GPriorityDefault* = 0
  

proc gTypeMakeFundamental*(x: Int): GType
const 
  GTypeReservedGlibFirst* = 21
  GTypeReservedGlibLast* = 31
  GTypeReservedBseFirst* = 32
  GTypeReservedBseLast* = 48
  GTypeReservedUserFirst* = 49

proc gTypeIsFundamental*(theType: GType): Bool
proc gTypeIsDerived*(theType: GType): Bool
proc gTypeIsInterface*(theType: GType): Bool
proc gTypeIsClassed*(theType: GType): Gboolean
proc gTypeIsInstantiatable*(theType: GType): Bool
proc gTypeIsDerivable*(theType: GType): Bool
proc gTypeIsDeepDerivable*(theType: GType): Bool
proc gTypeIsAbstract*(theType: GType): Bool
proc gTypeIsValueAbstract*(theType: GType): Bool
proc gTypeIsValueType*(theType: GType): Bool
proc gTypeHasValueTable*(theType: GType): Bool
proc gTypeCheckInstance*(instance: Pointer): Gboolean
proc gTypeCheckInstanceCast*(instance: Pointer, g_type: GType): PGTypeInstance
proc gTypeCheckInstanceType*(instance: Pointer, g_type: GType): Bool
proc gTypeInstanceGetClass*(instance: Pointer, g_type: GType): PGTypeClass
proc gTypeInstanceGetInterface*(instance: Pointer, g_type: GType): Pointer
proc gTypeCheckClassCast*(g_class: Pointer, g_type: GType): Pointer
proc gTypeCheckClassType*(g_class: Pointer, g_type: GType): Bool
proc gTypeCheckValue*(value: Pointer): Bool
proc gTypeCheckValueType*(value: Pointer, g_type: GType): Bool
proc gTypeFromInstance*(instance: Pointer): GType
proc gTypeFromClass*(g_class: Pointer): GType
proc gTypeFromInterface*(g_iface: Pointer): GType
type 
  TGTypeDebugFlags* = Int32
  PGTypeDebugFlags* = ptr TGTypeDebugFlags

const 
  GTypeDebugNone* = 0
  GTypeDebugObjects* = 1 shl 0
  GTypeDebugSignals* = 1 shl 1
  GTypeDebugMask* = 0x00000003

proc gTypeInit*(){.cdecl, dynlib: gobjectlib, importc: "g_type_init".}
proc gTypeInit*(debug_flags: TGTypeDebugFlags){.cdecl, 
    dynlib: gobjectlib, importc: "g_type_init_with_debug_flags".}
proc gTypeName*(theType: GType): Cstring{.cdecl, dynlib: gobjectlib, 
    importc: "g_type_name".}
proc gTypeQname*(theType: GType): TGQuark{.cdecl, dynlib: gobjectlib, 
    importc: "g_type_qname".}
proc gTypeFromName*(name: Cstring): GType{.cdecl, dynlib: gobjectlib, 
    importc: "g_type_from_name".}
proc gTypeParent*(theType: GType): GType{.cdecl, dynlib: gobjectlib, 
    importc: "g_type_parent".}
proc gTypeDepth*(theType: GType): Guint{.cdecl, dynlib: gobjectlib, 
    importc: "g_type_depth".}
proc gTypeNextBase*(leaf_type: GType, root_type: GType): GType{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_next_base".}
proc gTypeIsA*(theType: GType, is_a_type: GType): Gboolean{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_is_a".}
proc gTypeClassRef*(theType: GType): Gpointer{.cdecl, dynlib: gobjectlib, 
    importc: "g_type_class_ref".}
proc gTypeClassPeek*(theType: GType): Gpointer{.cdecl, dynlib: gobjectlib, 
    importc: "g_type_class_peek".}
proc gTypeClassUnref*(g_class: Gpointer){.cdecl, dynlib: gobjectlib, 
    importc: "g_type_class_unref".}
proc gTypeClassPeekParent*(g_class: Gpointer): Gpointer{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_class_peek_parent".}
proc gTypeInterfacePeek*(instance_class: Gpointer, iface_type: GType): Gpointer{.
    cdecl, dynlib: gobjectlib, importc: "g_type_interface_peek".}
proc gTypeInterfacePeekParent*(g_iface: Gpointer): Gpointer{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_interface_peek_parent".}
proc gTypeChildren*(theType: GType, n_children: Pguint): PGType{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_children".}
proc gTypeInterfaces*(theType: GType, n_interfaces: Pguint): PGType{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_interfaces".}
proc gTypeSetQdata*(theType: GType, quark: TGQuark, data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_type_set_qdata".}
proc gTypeGetQdata*(theType: GType, quark: TGQuark): Gpointer{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_get_qdata".}
proc gTypeQuery*(theType: GType, query: PGTypeQuery){.cdecl, 
    dynlib: gobjectlib, importc: "g_type_query".}
type 
  TGBaseInitFunc* = proc (g_class: Gpointer){.cdecl.}
  TGBaseFinalizeFunc* = proc (g_class: Gpointer){.cdecl.}
  TGClassInitFunc* = proc (g_class: Gpointer, class_data: Gpointer){.cdecl.}
  TGClassFinalizeFunc* = proc (g_class: Gpointer, class_data: Gpointer){.cdecl.}
  TGInstanceInitFunc* = proc (instance: PGTypeInstance, g_class: Gpointer){.
      cdecl.}
  TGInterfaceInitFunc* = proc (g_iface: Gpointer, iface_data: Gpointer){.cdecl.}
  TGInterfaceFinalizeFunc* = proc (g_iface: Gpointer, iface_data: Gpointer){.
      cdecl.}
  TGTypeClassCacheFunc* = proc (cache_data: Gpointer, g_class: PGTypeClass): Gboolean{.
      cdecl.}
  TGTypeFundamentalFlags* = Int32
  PGTypeFundamentalFlags* = ptr TGTypeFundamentalFlags

const 
  GTypeFlagClassed* = 1 shl 0
  GTypeFlagInstantiatable* = 1 shl 1
  GTypeFlagDerivable* = 1 shl 2
  GTypeFlagDeepDerivable* = 1 shl 3

type 
  TGTypeFlags* = Int32
  PGTypeFlags* = ptr TGTypeFlags

const 
  GTypeFlagAbstract* = 1 shl 4
  GTypeFlagValueAbstract* = 1 shl 5

type 
  PGTypeValueTable* = ptr TGTypeValueTable
  TGTypeValueTable*{.final.} = object 
    value_init*: proc (value: PGValue){.cdecl.}
    value_free*: proc (value: PGValue){.cdecl.}
    value_copy*: proc (src_value: PGValue, dest_value: PGValue){.cdecl.}
    value_peek_pointer*: proc (value: PGValue): Gpointer{.cdecl.}
    collect_format*: Cstring
    collect_value*: proc (value: PGValue, n_collect_values: Guint, 
                          collect_values: PGTypeCValue, collect_flags: Guint): Cstring{.
        cdecl.}
    lcopy_format*: Cstring
    lcopy_value*: proc (value: PGValue, n_collect_values: Guint, 
                        collect_values: PGTypeCValue, collect_flags: Guint): Cstring{.
        cdecl.}

  PGTypeInfo* = ptr TGTypeInfo
  TGTypeInfo*{.final.} = object 
    class_size*: Guint16
    base_init*: TGBaseInitFunc
    base_finalize*: TGBaseFinalizeFunc
    class_init*: TGClassInitFunc
    class_finalize*: TGClassFinalizeFunc
    class_data*: Gconstpointer
    instance_size*: Guint16
    n_preallocs*: Guint16
    instance_init*: TGInstanceInitFunc
    value_table*: PGTypeValueTable

  PGTypeFundamentalInfo* = ptr TGTypeFundamentalInfo
  TGTypeFundamentalInfo*{.final.} = object 
    type_flags*: TGTypeFundamentalFlags

  PGInterfaceInfo* = ptr TGInterfaceInfo
  TGInterfaceInfo*{.final.} = object 
    interface_init*: TGInterfaceInitFunc
    interface_finalize*: TGInterfaceFinalizeFunc
    interface_data*: Gpointer


proc gTypeRegisterStatic*(parent_type: GType, type_name: Cstring, 
                             info: PGTypeInfo, flags: TGTypeFlags): GType{.
    cdecl, dynlib: gobjectlib, importc: "g_type_register_static".}
proc gTypeRegisterDynamic*(parent_type: GType, type_name: Cstring, 
                              plugin: PGTypePlugin, flags: TGTypeFlags): GType{.
    cdecl, dynlib: gobjectlib, importc: "g_type_register_dynamic".}
proc gTypeRegisterFundamental*(type_id: GType, type_name: Cstring, 
                                  info: PGTypeInfo, 
                                  finfo: PGTypeFundamentalInfo, 
                                  flags: TGTypeFlags): GType{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_register_fundamental".}
proc gTypeAddInterfaceStatic*(instance_type: GType, interface_type: GType, 
                                  info: PGInterfaceInfo){.cdecl, 
    dynlib: gobjectlib, importc: "g_type_add_interface_static".}
proc gTypeAddInterfaceDynamic*(instance_type: GType, interface_type: GType, 
                                   plugin: PGTypePlugin){.cdecl, 
    dynlib: gobjectlib, importc: "g_type_add_interface_dynamic".}
proc gTypeInterfaceAddPrerequisite*(interface_type: GType, 
                                        prerequisite_type: GType){.cdecl, 
    dynlib: gobjectlib, importc: "g_type_interface_add_prerequisite".}
proc gTypeGetPlugin*(theType: GType): PGTypePlugin{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_get_plugin".}
proc gTypeInterfaceGetPlugin*(instance_type: GType, 
                                  implementation_type: GType): PGTypePlugin{.
    cdecl, dynlib: gobjectlib, importc: "g_type_interface_get_plugin".}
proc gTypeFundamentalNext*(): GType{.cdecl, dynlib: gobjectlib, 
                                        importc: "g_type_fundamental_next".}
proc gTypeFundamental*(type_id: GType): GType{.cdecl, dynlib: gobjectlib, 
    importc: "g_type_fundamental".}
proc gTypeCreateInstance*(theType: GType): PGTypeInstance{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_create_instance".}
proc freeInstance*(instance: PGTypeInstance){.cdecl, dynlib: gobjectlib, 
    importc: "g_type_free_instance".}
proc gTypeAddClassCacheFunc*(cache_data: Gpointer, 
                                  cache_func: TGTypeClassCacheFunc){.cdecl, 
    dynlib: gobjectlib, importc: "g_type_add_class_cache_func".}
proc gTypeRemoveClassCacheFunc*(cache_data: Gpointer, 
                                     cache_func: TGTypeClassCacheFunc){.cdecl, 
    dynlib: gobjectlib, importc: "g_type_remove_class_cache_func".}
proc gTypeClassUnrefUncached*(g_class: Gpointer){.cdecl, dynlib: gobjectlib, 
    importc: "g_type_class_unref_uncached".}
proc gTypeValueTablePeek*(theType: GType): PGTypeValueTable{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_value_table_peek".}
proc privateGTypeCheckInstance*(instance: PGTypeInstance): Gboolean{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_check_instance".}
proc privateGTypeCheckInstanceCast*(instance: PGTypeInstance, 
    iface_type: GType): PGTypeInstance{.cdecl, dynlib: gobjectlib, 
                                        importc: "g_type_check_instance_cast".}
proc privateGTypeCheckInstanceIsA*(instance: PGTypeInstance, 
    iface_type: GType): Gboolean{.cdecl, dynlib: gobjectlib, 
                                  importc: "g_type_check_instance_is_a".}
proc privateGTypeCheckClassCast*(g_class: PGTypeClass, is_a_type: GType): PGTypeClass{.
    cdecl, dynlib: gobjectlib, importc: "g_type_check_class_cast".}
proc privateGTypeCheckClassIsA*(g_class: PGTypeClass, is_a_type: GType): Gboolean{.
    cdecl, dynlib: gobjectlib, importc: "g_type_check_class_is_a".}
proc privateGTypeCheckIsValueType*(theType: GType): Gboolean{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_check_is_value_type".}
proc privateGTypeCheckValue*(value: PGValue): Gboolean{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_check_value".}
proc privateGTypeCheckValueHolds*(value: PGValue, theType: GType): Gboolean{.
    cdecl, dynlib: gobjectlib, importc: "g_type_check_value_holds".}
proc privateGTypeTestFlags*(theType: GType, flags: Guint): Gboolean{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_test_flags".}
proc nameFromInstance*(instance: PGTypeInstance): Cstring{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_name_from_instance".}
proc nameFromClass*(g_class: PGTypeClass): Cstring{.cdecl, 
    dynlib: gobjectlib, importc: "g_type_name_from_class".}
const 
  GTypeFlagReservedIdBit* = GType(1 shl 0)

proc gTypeIsValue*(theType: GType): Bool
proc gIsValue*(value: Pointer): Bool
proc gValueType*(value: Pointer): GType
proc gValueTypeName*(value: Pointer): Cstring
proc gValueHolds*(value: Pointer, g_type: GType): Bool
type 
  TGValueTransform* = proc (src_value: PGValue, dest_value: PGValue){.cdecl.}

proc init*(value: PGValue, g_type: GType): PGValue{.cdecl, 
    dynlib: gobjectlib, importc: "g_value_init".}
proc copy*(src_value: PGValue, dest_value: PGValue){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_copy".}
proc reset*(value: PGValue): PGValue{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_reset".}
proc unset*(value: PGValue){.cdecl, dynlib: gobjectlib, 
                                     importc: "g_value_unset".}
proc setInstance*(value: PGValue, instance: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_instance".}
proc fitsPointer*(value: PGValue): Gboolean{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_fits_pointer".}
proc peekPointer*(value: PGValue): Gpointer{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_peek_pointer".}
proc gValueTypeCompatible*(src_type: GType, dest_type: GType): Gboolean{.
    cdecl, dynlib: gobjectlib, importc: "g_value_type_compatible".}
proc gValueTypeTransformable*(src_type: GType, dest_type: GType): Gboolean{.
    cdecl, dynlib: gobjectlib, importc: "g_value_type_transformable".}
proc transform*(src_value: PGValue, dest_value: PGValue): Gboolean{.
    cdecl, dynlib: gobjectlib, importc: "g_value_transform".}
proc gValueRegisterTransformFunc*(src_type: GType, dest_type: GType, 
                                      transform_func: TGValueTransform){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_register_transform_func".}
const 
  GValueNocopyContents* = 1 shl 27

type 
  PGValueArray* = ptr TGValueArray
  TGValueArray*{.final.} = object 
    n_values*: Guint
    values*: PGValue
    n_prealloced*: Guint


proc arrayGetNth*(value_array: PGValueArray, index: Guint): PGValue{.
    cdecl, dynlib: gobjectlib, importc: "g_value_array_get_nth".}
proc gValueArrayNew*(n_prealloced: Guint): PGValueArray{.cdecl, 
    dynlib: gobjectlib, importc: "g_value_array_new".}
proc arrayFree*(value_array: PGValueArray){.cdecl, dynlib: gobjectlib, 
    importc: "g_value_array_free".}
proc arrayCopy*(value_array: PGValueArray): PGValueArray{.cdecl, 
    dynlib: gobjectlib, importc: "g_value_array_copy".}
proc arrayPrepend*(value_array: PGValueArray, value: PGValue): PGValueArray{.
    cdecl, dynlib: gobjectlib, importc: "g_value_array_prepend".}
proc arrayAppend*(value_array: PGValueArray, value: PGValue): PGValueArray{.
    cdecl, dynlib: gobjectlib, importc: "g_value_array_append".}
proc arrayInsert*(value_array: PGValueArray, index: Guint, 
                           value: PGValue): PGValueArray{.cdecl, 
    dynlib: gobjectlib, importc: "g_value_array_insert".}
proc arrayRemove*(value_array: PGValueArray, index: Guint): PGValueArray{.
    cdecl, dynlib: gobjectlib, importc: "g_value_array_remove".}
proc arraySort*(value_array: PGValueArray, compare_func: TGCompareFunc): PGValueArray{.
    cdecl, dynlib: gobjectlib, importc: "g_value_array_sort".}
proc arraySort*(value_array: PGValueArray, 
                                   compare_func: TGCompareDataFunc, 
                                   user_data: Gpointer): PGValueArray{.cdecl, 
    dynlib: gobjectlib, importc: "g_value_array_sort_with_data".}
const 
  GValueCollectInt* = 'i'
  GValueCollectLong* = 'l'
  GValueCollectInt64* = 'q'
  GValueCollectDouble* = 'd'
  GValueCollectPointer* = 'p'
  GValueCollectFormatMaxLength* = 8

proc holdsChar*(value: PGValue): Bool
proc holdsUchar*(value: PGValue): Bool
proc holdsBoolean*(value: PGValue): Bool
proc holdsInt*(value: PGValue): Bool
proc holdsUint*(value: PGValue): Bool
proc holdsLong*(value: PGValue): Bool
proc holdsUlong*(value: PGValue): Bool
proc holdsInt64*(value: PGValue): Bool
proc holdsUint64*(value: PGValue): Bool
proc holdsFloat*(value: PGValue): Bool
proc holdsDouble*(value: PGValue): Bool
proc holdsString*(value: PGValue): Bool
proc holdsPointer*(value: PGValue): Bool
proc setChar*(value: PGValue, v_char: Gchar){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_char".}
proc getChar*(value: PGValue): Gchar{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_char".}
proc setUchar*(value: PGValue, v_uchar: Guchar){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_uchar".}
proc getUchar*(value: PGValue): Guchar{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_uchar".}
proc setBoolean*(value: PGValue, v_boolean: Gboolean){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_boolean".}
proc getBoolean*(value: PGValue): Gboolean{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_boolean".}
proc setInt*(value: PGValue, v_int: Gint){.cdecl, dynlib: gobjectlib, 
    importc: "g_value_set_int".}
proc getInt*(value: PGValue): Gint{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_int".}
proc setUint*(value: PGValue, v_uint: Guint){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_uint".}
proc getUint*(value: PGValue): Guint{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_uint".}
proc setLong*(value: PGValue, v_long: Glong){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_long".}
proc getLong*(value: PGValue): Glong{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_long".}
proc setUlong*(value: PGValue, v_ulong: Gulong){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_ulong".}
proc getUlong*(value: PGValue): Gulong{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_ulong".}
proc setInt64*(value: PGValue, v_int64: Gint64){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_int64".}
proc getInt64*(value: PGValue): Gint64{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_int64".}
proc setUint64*(value: PGValue, v_uint64: Guint64){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_uint64".}
proc getUint64*(value: PGValue): Guint64{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_uint64".}
proc setFloat*(value: PGValue, v_float: Gfloat){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_float".}
proc getFloat*(value: PGValue): Gfloat{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_float".}
proc setDouble*(value: PGValue, v_double: Gdouble){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_double".}
proc getDouble*(value: PGValue): Gdouble{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_double".}
proc setString*(value: PGValue, v_string: Cstring){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_string".}
proc setStaticString*(value: PGValue, v_string: Cstring){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_static_string".}
proc getString*(value: PGValue): Cstring{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_string".}
proc dupString*(value: PGValue): Cstring{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_dup_string".}
proc setPointer*(value: PGValue, v_pointer: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_pointer".}
proc getPointer*(value: PGValue): Gpointer{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_pointer".}
proc gPointerTypeRegisterStatic*(name: Cstring): GType{.cdecl, 
    dynlib: gobjectlib, importc: "g_pointer_type_register_static".}
proc strdupValueContents*(value: PGValue): Cstring{.cdecl, 
    dynlib: gobjectlib, importc: "g_strdup_value_contents".}
proc setStringTakeOwnership*(value: PGValue, v_string: Cstring){.
    cdecl, dynlib: gobjectlib, importc: "g_value_set_string_take_ownership".}
type 
  Tgchararray* = Gchar
  Pgchararray* = ptr Tgchararray

proc gTypeIsParam*(theType: GType): Bool
proc gParamSpec*(pspec: Pointer): PGParamSpec
proc gIsParamSpec*(pspec: Pointer): Bool
proc gParamSpecClass*(pclass: Pointer): PGParamSpecClass
proc gIsParamSpecClass*(pclass: Pointer): Bool
proc gParamSpecGetClass*(pspec: Pointer): PGParamSpecClass
proc gParamSpecType*(pspec: Pointer): GType
proc gParamSpecTypeName*(pspec: Pointer): Cstring
proc gParamSpecValueType*(pspec: Pointer): GType
proc gValueHoldsParam*(value: Pointer): Bool
const 
  GParamReadable* = 1 shl 0
  GParamWritable* = 1 shl 1
  GParamConstruct* = 1 shl 2
  GParamConstructOnly* = 1 shl 3
  GParamLaxValidation* = 1 shl 4
  GParamPrivate* = 1 shl 5
  GParamReadwrite* = G_PARAM_READABLE or G_PARAM_WRITABLE
  GParamMask* = 0x000000FF
  GParamUserShift* = 8

proc specRef*(pspec: PGParamSpec): PGParamSpec{.cdecl, dynlib: gliblib, 
    importc: "g_param_spec_ref".}
proc specUnref*(pspec: PGParamSpec){.cdecl, dynlib: gliblib, 
    importc: "g_param_spec_unref".}
proc specSink*(pspec: PGParamSpec){.cdecl, dynlib: gliblib, 
    importc: "g_param_spec_sink".}
proc specGetQdata*(pspec: PGParamSpec, quark: TGQuark): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_param_spec_get_qdata".}
proc specSetQdata*(pspec: PGParamSpec, quark: TGQuark, data: Gpointer){.
    cdecl, dynlib: gliblib, importc: "g_param_spec_set_qdata".}
proc specSetQdataFull*(pspec: PGParamSpec, quark: TGQuark, 
                                  data: Gpointer, destroy: TGDestroyNotify){.
    cdecl, dynlib: gliblib, importc: "g_param_spec_set_qdata_full".}
proc specStealQdata*(pspec: PGParamSpec, quark: TGQuark): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_param_spec_steal_qdata".}
proc valueSetDefault*(pspec: PGParamSpec, value: PGValue){.cdecl, 
    dynlib: gliblib, importc: "g_param_value_set_default".}
proc valueDefaults*(pspec: PGParamSpec, value: PGValue): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_param_value_defaults".}
proc valueValidate*(pspec: PGParamSpec, value: PGValue): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_param_value_validate".}
proc valueConvert*(pspec: PGParamSpec, src_value: PGValue, 
                            dest_value: PGValue, strict_validation: Gboolean): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_param_value_convert".}
proc valuesCmp*(pspec: PGParamSpec, value1: PGValue, value2: PGValue): Gint{.
    cdecl, dynlib: gliblib, importc: "g_param_values_cmp".}
proc specGetName*(pspec: PGParamSpec): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_param_spec_get_name".}
proc specGetNick*(pspec: PGParamSpec): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_param_spec_get_nick".}
proc specGetBlurb*(pspec: PGParamSpec): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_param_spec_get_blurb".}
proc setParam*(value: PGValue, param: PGParamSpec){.cdecl, 
    dynlib: gliblib, importc: "g_value_set_param".}
proc getParam*(value: PGValue): PGParamSpec{.cdecl, dynlib: gliblib, 
    importc: "g_value_get_param".}
proc dupParam*(value: PGValue): PGParamSpec{.cdecl, dynlib: gliblib, 
    importc: "g_value_dup_param".}
proc setParamTakeOwnership*(value: PGValue, param: PGParamSpec){.
    cdecl, dynlib: gliblib, importc: "g_value_set_param_take_ownership".}
type 
  PGParamSpecTypeInfo* = ptr TGParamSpecTypeInfo
  TGParamSpecTypeInfo*{.final.} = object 
    instance_size*: Guint16
    n_preallocs*: Guint16
    instance_init*: proc (pspec: PGParamSpec){.cdecl.}
    value_type*: GType
    finalize*: proc (pspec: PGParamSpec){.cdecl.}
    value_set_default*: proc (pspec: PGParamSpec, value: PGValue){.cdecl.}
    value_validate*: proc (pspec: PGParamSpec, value: PGValue): Gboolean{.cdecl.}
    values_cmp*: proc (pspec: PGParamSpec, value1: PGValue, value2: PGValue): Gint{.
        cdecl.}


proc gParamTypeRegisterStatic*(name: Cstring, 
                                   pspec_info: PGParamSpecTypeInfo): GType{.
    cdecl, dynlib: gliblib, importc: "g_param_type_register_static".}
proc gParamTypeRegisterStaticConstant*(name: Cstring, 
    pspec_info: PGParamSpecTypeInfo, opt_type: GType): GType{.cdecl, 
    dynlib: gliblib, importc: "`g_param_type_register_static_constant`".}
proc gParamSpecInternal*(param_type: GType, name: Cstring, nick: Cstring, 
                            blurb: Cstring, flags: TGParamFlags): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_param_spec_internal".}
proc gParamSpecPoolNew*(type_prefixing: Gboolean): PGParamSpecPool{.cdecl, 
    dynlib: gliblib, importc: "g_param_spec_pool_new".}
proc specPoolInsert*(pool: PGParamSpecPool, pspec: PGParamSpec, 
                               owner_type: GType){.cdecl, dynlib: gliblib, 
    importc: "g_param_spec_pool_insert".}
proc specPoolRemove*(pool: PGParamSpecPool, pspec: PGParamSpec){.
    cdecl, dynlib: gliblib, importc: "g_param_spec_pool_remove".}
proc specPoolLookup*(pool: PGParamSpecPool, param_name: Cstring, 
                               owner_type: GType, walk_ancestors: Gboolean): PGParamSpec{.
    cdecl, dynlib: gliblib, importc: "g_param_spec_pool_lookup".}
proc specPoolListOwned*(pool: PGParamSpecPool, owner_type: GType): PGList{.
    cdecl, dynlib: gliblib, importc: "g_param_spec_pool_list_owned".}
proc specPoolList*(pool: PGParamSpecPool, owner_type: GType, 
                             n_pspecs_p: Pguint): PPGParamSpec{.cdecl, 
    dynlib: gliblib, importc: "g_param_spec_pool_list".}
type 
  PGClosure* = ptr TGClosure
  PGClosureNotifyData* = ptr TGClosureNotifyData
  TGClosureNotify* = proc (data: Gpointer, closure: PGClosure){.cdecl.}
  TGClosure*{.final.} = object 
    flag0*: Int32
    marshal*: proc (closure: PGClosure, return_value: PGValue, 
                    n_param_values: Guint, param_values: PGValue, 
                    invocation_hint, marshal_data: Gpointer){.cdecl.}
    data*: Gpointer
    notifiers*: PGClosureNotifyData

  TGCallBackProcedure* = proc (){.cdecl.}
  TGCallback* = proc (){.cdecl.}
  TGClosureMarshal* = proc (closure: PGClosure, return_value: PGValue, 
                            n_param_values: Guint, param_values: PGValue, 
                            invocation_hint: Gpointer, marshal_data: Gpointer){.
      cdecl.}
  TGClosureNotifyData*{.final.} = object 
    data*: Gpointer
    notify*: TGClosureNotify


proc gClosureNeedsMarshal*(closure: Pointer): Bool
proc nNotifiers*(cl: PGClosure): Int32
proc cclosureSwapData*(cclosure: PGClosure): Int32
proc gCallback*(f: Pointer): TGCallback
const 
  bmTGClosureRefCount* = 0x00007FFF'i32
  bpTGClosureRefCount* = 0'i32
  bmTGClosureMetaMarshal* = 0x00008000'i32
  bpTGClosureMetaMarshal* = 15'i32
  bmTGClosureNGuards* = 0x00010000'i32
  bpTGClosureNGuards* = 16'i32
  bmTGClosureNFnotifiers* = 0x00060000'i32
  bpTGClosureNFnotifiers* = 17'i32
  bmTGClosureNInotifiers* = 0x07F80000'i32
  bpTGClosureNInotifiers* = 19'i32
  bmTGClosureInInotify* = 0x08000000'i32
  bpTGClosureInInotify* = 27'i32
  bmTGClosureFloating* = 0x10000000'i32
  bpTGClosureFloating* = 28'i32
  bmTGClosureDerivativeFlag* = 0x20000000'i32
  bpTGClosureDerivativeFlag* = 29'i32
  bmTGClosureInMarshal* = 0x40000000'i32
  bpTGClosureInMarshal* = 30'i32
  bmTGClosureIsInvalid* = 0x80000000'i32
  bpTGClosureIsInvalid* = 31'i32

proc refCount*(a: PGClosure): Guint
proc setRefCount*(a: PGClosure, ref_count: Guint)
proc metaMarshal*(a: PGClosure): Guint
proc setMetaMarshal*(a: PGClosure, meta_marshal: Guint)
proc nGuards*(a: PGClosure): Guint
proc setNGuards*(a: PGClosure, n_guards: Guint)
proc nFnotifiers*(a: PGClosure): Guint
proc setNFnotifiers*(a: PGClosure, n_fnotifiers: Guint)
proc nInotifiers*(a: PGClosure): Guint
proc inInotify*(a: PGClosure): Guint
proc setInInotify*(a: PGClosure, in_inotify: Guint)
proc floating*(a: PGClosure): Guint
proc setFloating*(a: PGClosure, floating: Guint)
proc derivativeFlag*(a: PGClosure): Guint
proc setDerivativeFlag*(a: PGClosure, derivative_flag: Guint)
proc inMarshal*(a: PGClosure): Guint
proc setInMarshal*(a: PGClosure, in_marshal: Guint)
proc isInvalid*(a: PGClosure): Guint
proc setIsInvalid*(a: PGClosure, is_invalid: Guint)
type 
  PGCClosure* = ptr TGCClosure
  TGCClosure*{.final.} = object 
    closure*: TGClosure
    callback*: Gpointer


proc gCclosureNew*(callback_func: TGCallback, user_data: Gpointer, 
                     destroy_data: TGClosureNotify): PGClosure{.cdecl, 
    dynlib: gliblib, importc: "g_cclosure_new".}
proc gCclosureNewSwap*(callback_func: TGCallback, user_data: Gpointer, 
                          destroy_data: TGClosureNotify): PGClosure{.cdecl, 
    dynlib: gliblib, importc: "g_cclosure_new_swap".}
proc gSignalTypeCclosureNew*(itype: GType, struct_offset: Guint): PGClosure{.
    cdecl, dynlib: gliblib, importc: "g_signal_type_cclosure_new".}
proc reference*(closure: PGClosure): PGClosure{.cdecl, dynlib: gliblib, 
    importc: "g_closure_ref".}
proc sink*(closure: PGClosure){.cdecl, dynlib: gliblib, 
    importc: "g_closure_sink".}
proc unref*(closure: PGClosure){.cdecl, dynlib: gliblib, 
    importc: "g_closure_unref".}
proc gClosureNewSimple*(sizeof_closure: Guint, data: Gpointer): PGClosure{.
    cdecl, dynlib: gliblib, importc: "g_closure_new_simple".}
proc addFinalizeNotifier*(closure: PGClosure, notify_data: Gpointer, 
                                      notify_func: TGClosureNotify){.cdecl, 
    dynlib: gliblib, importc: "g_closure_add_finalize_notifier".}
proc removeFinalizeNotifier*(closure: PGClosure, 
    notify_data: Gpointer, notify_func: TGClosureNotify){.cdecl, 
    dynlib: gliblib, importc: "g_closure_remove_finalize_notifier".}
proc addInvalidateNotifier*(closure: PGClosure, 
                                        notify_data: Gpointer, 
                                        notify_func: TGClosureNotify){.cdecl, 
    dynlib: gliblib, importc: "g_closure_add_invalidate_notifier".}
proc removeInvalidateNotifier*(closure: PGClosure, 
    notify_data: Gpointer, notify_func: TGClosureNotify){.cdecl, 
    dynlib: gliblib, importc: "g_closure_remove_invalidate_notifier".}
proc addMarshalGuards*(closure: PGClosure, 
                                   pre_marshal_data: Gpointer, 
                                   pre_marshal_notify: TGClosureNotify, 
                                   post_marshal_data: Gpointer, 
                                   post_marshal_notify: TGClosureNotify){.cdecl, 
    dynlib: gliblib, importc: "g_closure_add_marshal_guards".}
proc setMarshal*(closure: PGClosure, marshal: TGClosureMarshal){.
    cdecl, dynlib: gliblib, importc: "g_closure_set_marshal".}
proc setMetaMarshal*(closure: PGClosure, marshal_data: Gpointer, 
                                 meta_marshal: TGClosureMarshal){.cdecl, 
    dynlib: gliblib, importc: "g_closure_set_meta_marshal".}
proc invalidate*(closure: PGClosure){.cdecl, dynlib: gliblib, 
    importc: "g_closure_invalidate".}
proc invoke*(closure: PGClosure, return_value: PGValue, 
                       n_param_values: Guint, param_values: PGValue, 
                       invocation_hint: Gpointer){.cdecl, dynlib: gliblib, 
    importc: "g_closure_invoke".}
type 
  PGSignalInvocationHint* = ptr TGSignalInvocationHint
  PGSignalCMarshaller* = ptr TGSignalCMarshaller
  TGSignalCMarshaller* = TGClosureMarshal
  TGSignalEmissionHook* = proc (ihint: PGSignalInvocationHint, 
                                n_param_values: Guint, param_values: PGValue, 
                                data: Gpointer): Gboolean{.cdecl.}
  TGSignalAccumulator* = proc (ihint: PGSignalInvocationHint, 
                               return_accu: PGValue, handler_return: PGValue, 
                               data: Gpointer): Gboolean{.cdecl.}
  PGSignalFlags* = ptr TGSignalFlags
  TGSignalFlags* = Int32
  TGSignalInvocationHint*{.final.} = object 
    signal_id*: Guint
    detail*: TGQuark
    run_type*: TGSignalFlags

  PGSignalQuery* = ptr TGSignalQuery
  TGSignalQuery*{.final.} = object 
    signal_id*: Guint
    signal_name*: Cstring
    itype*: GType
    signal_flags*: TGSignalFlags
    return_type*: GType
    n_params*: Guint
    param_types*: PGType


const 
  GSignalRunFirst* = 1 shl 0
  GSignalRunLast* = 1 shl 1
  GSignalRunCleanup* = 1 shl 2
  GSignalNoRecurse* = 1 shl 3
  GSignalDetailed* = 1 shl 4
  GSignalAction* = 1 shl 5
  GSignalNoHooks* = 1 shl 6
  GSignalFlagsMask* = 0x0000007F

type 
  PGConnectFlags* = ptr TGConnectFlags
  TGConnectFlags* = Int32

const 
  GConnectAfter* = 1 shl 0
  GConnectSwapped* = 1 shl 1

type 
  PGSignalMatchType* = ptr TGSignalMatchType
  TGSignalMatchType* = Int32

const 
  GSignalMatchId* = 1 shl 0
  GSignalMatchDetail* = 1 shl 1
  GSignalMatchClosure* = 1 shl 2
  GSignalMatchFunc* = 1 shl 3
  GSignalMatchData* = 1 shl 4
  GSignalMatchUnblocked* = 1 shl 5
  GSignalMatchMask* = 0x0000003F
  GSignalTypeStaticScope* = G_TYPE_FLAG_RESERVED_ID_BIT

proc gSignalNewv*(signal_name: Cstring, itype: GType, 
                    signal_flags: TGSignalFlags, class_closure: PGClosure, 
                    accumulator: TGSignalAccumulator, accu_data: Gpointer, 
                    c_marshaller: TGSignalCMarshaller, return_type: GType, 
                    n_params: Guint, param_types: PGType): Guint{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_newv".}
proc signalEmitv*(instance_and_params: PGValue, signal_id: Guint, 
                     detail: TGQuark, return_value: PGValue){.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_emitv".}
proc gSignalLookup*(name: Cstring, itype: GType): Guint{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_lookup".}
proc gSignalName*(signal_id: Guint): Cstring{.cdecl, dynlib: gobjectlib, 
    importc: "g_signal_name".}
proc gSignalQuery*(signal_id: Guint, query: PGSignalQuery){.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_query".}
proc gSignalListIds*(itype: GType, n_ids: Pguint): Pguint{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_list_ids".}
proc gSignalParseName*(detailed_signal: Cstring, itype: GType, 
                          signal_id_p: Pguint, detail_p: PGQuark, 
                          force_detail_quark: Gboolean): Gboolean{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_parse_name".}
proc gSignalGetInvocationHint*(instance: Gpointer): PGSignalInvocationHint{.
    cdecl, dynlib: gobjectlib, importc: "g_signal_get_invocation_hint".}
proc gSignalStopEmission*(instance: Gpointer, signal_id: Guint, 
                             detail: TGQuark){.cdecl, dynlib: gobjectlib, 
    importc: "g_signal_stop_emission".}
proc gSignalStopEmissionByName*(instance: Gpointer, 
                                     detailed_signal: Cstring){.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_stop_emission_by_name".}
proc gSignalAddEmissionHook*(signal_id: Guint, quark: TGQuark, 
                                 hook_func: TGSignalEmissionHook, 
                                 hook_data: Gpointer, 
                                 data_destroy: TGDestroyNotify): Gulong{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_add_emission_hook".}
proc gSignalRemoveEmissionHook*(signal_id: Guint, hook_id: Gulong){.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_remove_emission_hook".}
proc gSignalHasHandlerPending*(instance: Gpointer, signal_id: Guint, 
                                   detail: TGQuark, may_be_blocked: Gboolean): Gboolean{.
    cdecl, dynlib: gobjectlib, importc: "g_signal_has_handler_pending".}
proc gSignalConnectClosureById*(instance: Gpointer, signal_id: Guint, 
                                     detail: TGQuark, closure: PGClosure, 
                                     after: Gboolean): Gulong{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_connect_closure_by_id".}
proc gSignalConnectClosure*(instance: Gpointer, detailed_signal: Cstring, 
                               closure: PGClosure, after: Gboolean): Gulong{.
    cdecl, dynlib: gobjectlib, importc: "g_signal_connect_closure".}
proc gSignalConnectData*(instance: Gpointer, detailed_signal: Cstring, 
                            c_handler: TGCallback, data: Gpointer, 
                            destroy_data: TGClosureNotify, 
                            connect_flags: TGConnectFlags): Gulong{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_connect_data".}
proc gSignalHandlerBlock*(instance: Gpointer, handler_id: Gulong){.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_handler_block".}
proc gSignalHandlerUnblock*(instance: Gpointer, handler_id: Gulong){.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_handler_unblock".}
proc gSignalHandlerDisconnect*(instance: Gpointer, handler_id: Gulong){.
    cdecl, dynlib: gobjectlib, importc: "g_signal_handler_disconnect".}
proc gSignalHandlerIsConnected*(instance: Gpointer, handler_id: Gulong): Gboolean{.
    cdecl, dynlib: gobjectlib, importc: "g_signal_handler_is_connected".}
proc gSignalHandlerFind*(instance: Gpointer, mask: TGSignalMatchType, 
                            signal_id: Guint, detail: TGQuark, 
                            closure: PGClosure, func: Gpointer, data: Gpointer): Gulong{.
    cdecl, dynlib: gobjectlib, importc: "g_signal_handler_find".}
proc gSignalHandlersBlockMatched*(instance: Gpointer, 
                                      mask: TGSignalMatchType, signal_id: Guint, 
                                      detail: TGQuark, closure: PGClosure, 
                                      func: Gpointer, data: Gpointer): Guint{.
    cdecl, dynlib: gobjectlib, importc: "g_signal_handlers_block_matched".}
proc gSignalHandlersUnblockMatched*(instance: Gpointer, 
                                        mask: TGSignalMatchType, 
                                        signal_id: Guint, detail: TGQuark, 
                                        closure: PGClosure, func: Gpointer, 
                                        data: Gpointer): Guint{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_handlers_unblock_matched".}
proc gSignalHandlersDisconnectMatched*(instance: Gpointer, 
    mask: TGSignalMatchType, signal_id: Guint, detail: TGQuark, 
    closure: PGClosure, func: Gpointer, data: Gpointer): Guint{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_handlers_disconnect_matched".}
proc gSignalOverrideClassClosure*(signal_id: Guint, instance_type: GType, 
                                      class_closure: PGClosure){.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_override_class_closure".}
proc signalChainFromOverridden*(instance_and_params: PGValue, 
                                     return_value: PGValue){.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_chain_from_overridden".}
proc gSignalConnect*(instance: Gpointer, detailed_signal: Cstring, 
                       c_handler: TGCallback, data: Gpointer): Gulong
proc gSignalConnectAfter*(instance: Gpointer, detailed_signal: Cstring, 
                             c_handler: TGCallback, data: Gpointer): Gulong
proc gSignalConnectSwapped*(instance: Gpointer, detailed_signal: Cstring, 
                               c_handler: TGCallback, data: Gpointer): Gulong
proc gSignalHandlersDisconnectByFunc*(instance: Gpointer, 
    func, data: Gpointer): Guint
proc gSignalHandlersBlockByFunc*(instance: Gpointer, func, data: Gpointer)
proc gSignalHandlersUnblockByFunc*(instance: Gpointer, func, data: Gpointer)
proc gSignalHandlersDestroy*(instance: Gpointer){.cdecl, dynlib: gobjectlib, 
    importc: "g_signal_handlers_destroy".}
proc gSignalsDestroy*(itype: GType){.cdecl, dynlib: gobjectlib, 
                                       importc: "`g_signals_destroy`".}
type 
  TGTypePluginUse* = proc (plugin: PGTypePlugin){.cdecl.}
  TGTypePluginUnuse* = proc (plugin: PGTypePlugin){.cdecl.}
  TGTypePluginCompleteTypeInfo* = proc (plugin: PGTypePlugin, g_type: GType, 
                                        info: PGTypeInfo, 
                                        value_table: PGTypeValueTable){.cdecl.}
  TGTypePluginCompleteInterfaceInfo* = proc (plugin: PGTypePlugin, 
      instance_type: GType, interface_type: GType, info: PGInterfaceInfo){.cdecl.}
  PGTypePluginClass* = ptr TGTypePluginClass
  TGTypePluginClass*{.final.} = object 
    base_iface*: TGTypeInterface
    use_plugin*: TGTypePluginUse
    unuse_plugin*: TGTypePluginUnuse
    complete_type_info*: TGTypePluginCompleteTypeInfo
    complete_interface_info*: TGTypePluginCompleteInterfaceInfo


proc gTypeTypePlugin*(): GType
proc gTypePlugin*(inst: Pointer): PGTypePlugin
proc gTypePluginClass*(vtable: Pointer): PGTypePluginClass
proc gIsTypePlugin*(inst: Pointer): Bool
proc gIsTypePluginClass*(vtable: Pointer): Bool
proc gTypePluginGetClass*(inst: Pointer): PGTypePluginClass
proc gTypePluginGetType*(): GType{.cdecl, dynlib: gliblib, 
                                       importc: "g_type_plugin_get_type".}
proc pluginUse*(plugin: PGTypePlugin){.cdecl, dynlib: gliblib, 
    importc: "g_type_plugin_use".}
proc pluginUnuse*(plugin: PGTypePlugin){.cdecl, dynlib: gliblib, 
    importc: "g_type_plugin_unuse".}
proc pluginCompleteTypeInfo*(plugin: PGTypePlugin, g_type: GType, 
                                       info: PGTypeInfo, 
                                       value_table: PGTypeValueTable){.cdecl, 
    dynlib: gliblib, importc: "g_type_plugin_complete_type_info".}
proc pluginCompleteInterfaceInfo*(plugin: PGTypePlugin, 
    instance_type: GType, interface_type: GType, info: PGInterfaceInfo){.cdecl, 
    dynlib: gliblib, importc: "g_type_plugin_complete_interface_info".}
type 
  PGObject* = ptr TGObject
  TGObject*{.pure, inheritable.} = object 
    g_type_instance*: TGTypeInstance
    ref_count*: Guint
    qdata*: PGData

  TGObjectGetPropertyFunc* = proc (anObject: PGObject, property_id: Guint, 
                                   value: PGValue, pspec: PGParamSpec){.cdecl.}
  TGObjectSetPropertyFunc* = proc (anObject: PGObject, property_id: Guint, 
                                   value: PGValue, pspec: PGParamSpec){.cdecl.}
  TGObjectFinalizeFunc* = proc (anObject: PGObject){.cdecl.}
  TGWeakNotify* = proc (data: Gpointer, where_the_object_was: PGObject){.cdecl.}
  PGObjectConstructParam* = ptr TGObjectConstructParam
  PGObjectClass* = ptr TGObjectClass
  TGObjectClass*{.pure, inheritable.} = object 
    g_type_class*: TGTypeClass
    construct_properties*: PGSList
    constructor*: proc (theType: GType, n_construct_properties: Guint, 
                        construct_properties: PGObjectConstructParam): PGObject{.
        cdecl.}
    set_property*: proc (anObject: PGObject, property_id: Guint, value: PGValue, 
                         pspec: PGParamSpec){.cdecl.}
    get_property*: proc (anObject: PGObject, property_id: Guint, value: PGValue, 
                         pspec: PGParamSpec){.cdecl.}
    dispose*: proc (anObject: PGObject){.cdecl.}
    finalize*: proc (anObject: PGObject){.cdecl.}
    dispatch_properties_changed*: proc (anObject: PGObject, n_pspecs: Guint, 
                                        pspecs: PPGParamSpec){.cdecl.}
    notify*: proc (anObject: PGObject, pspec: PGParamSpec){.cdecl.}
    pdummy*: Array[0..7, Gpointer]

  TGObjectConstructParam*{.final.} = object 
    pspec*: PGParamSpec
    value*: PGValue


proc gTypeIsObject*(theType: GType): Bool
proc gObject*(anObject: Pointer): PGObject
proc gObjectClass*(class: Pointer): PGObjectClass
proc gIsObject*(anObject: Pointer): Bool
proc gIsObjectClass*(class: Pointer): Bool
proc gObjectGetClass*(anObject: Pointer): PGObjectClass
proc gObjectType*(anObject: Pointer): GType
proc gObjectTypeName*(anObject: Pointer): Cstring
proc gObjectClassType*(class: Pointer): GType
proc gObjectClassName*(class: Pointer): Cstring
proc gValueHoldsObject*(value: Pointer): Bool
proc classInstallProperty*(oclass: PGObjectClass, property_id: Guint, 
                                      pspec: PGParamSpec){.cdecl, 
    dynlib: gobjectlib, importc: "g_object_class_install_property".}
proc classFindProperty*(oclass: PGObjectClass, property_name: Cstring): PGParamSpec{.
    cdecl, dynlib: gobjectlib, importc: "g_object_class_find_property".}
proc classListProperties*(oclass: PGObjectClass, n_properties: Pguint): PPGParamSpec{.
    cdecl, dynlib: gobjectlib, importc: "g_object_class_list_properties".}
proc setProperty*(anObject: PGObject, property_name: Cstring, 
                            value: PGValue){.cdecl, dynlib: gobjectlib, 
    importc: "g_object_set_property".}
proc getProperty*(anObject: PGObject, property_name: Cstring, 
                            value: PGValue){.cdecl, dynlib: gobjectlib, 
    importc: "g_object_get_property".}
proc freezeNotify*(anObject: PGObject){.cdecl, dynlib: gobjectlib, 
    importc: "g_object_freeze_notify".}
proc notify*(anObject: PGObject, property_name: Cstring){.cdecl, 
    dynlib: gobjectlib, importc: "g_object_notify".}
proc thawNotify*(anObject: PGObject){.cdecl, dynlib: gobjectlib, 
    importc: "g_object_thaw_notify".}
proc gObjectRef*(anObject: Gpointer): Gpointer{.cdecl, dynlib: gobjectlib, 
    importc: "g_object_ref".}
proc gObjectUnref*(anObject: Gpointer){.cdecl, dynlib: gobjectlib, 
    importc: "g_object_unref".}
proc weakRef*(anObject: PGObject, notify: TGWeakNotify, data: Gpointer){.
    cdecl, dynlib: gobjectlib, importc: "g_object_weak_ref".}
proc weakUnref*(anObject: PGObject, notify: TGWeakNotify, 
                          data: Gpointer){.cdecl, dynlib: gobjectlib, 
    importc: "g_object_weak_unref".}
proc addWeakPointer*(anObject: PGObject, 
                                weak_pointer_location: Pgpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_object_add_weak_pointer".}
proc removeWeakPointer*(anObject: PGObject, 
                                   weak_pointer_location: Pgpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_object_remove_weak_pointer".}
proc getQdata*(anObject: PGObject, quark: TGQuark): Gpointer{.cdecl, 
    dynlib: gobjectlib, importc: "g_object_get_qdata".}
proc setQdata*(anObject: PGObject, quark: TGQuark, data: Gpointer){.
    cdecl, dynlib: gobjectlib, importc: "g_object_set_qdata".}
proc setQdataFull*(anObject: PGObject, quark: TGQuark, 
                              data: Gpointer, destroy: TGDestroyNotify){.cdecl, 
    dynlib: gobjectlib, importc: "g_object_set_qdata_full".}
proc stealQdata*(anObject: PGObject, quark: TGQuark): Gpointer{.cdecl, 
    dynlib: gobjectlib, importc: "g_object_steal_qdata".}
proc getData*(anObject: PGObject, key: Cstring): Gpointer{.cdecl, 
    dynlib: gobjectlib, importc: "g_object_get_data".}
proc setData*(anObject: PGObject, key: Cstring, data: Gpointer){.
    cdecl, dynlib: gobjectlib, importc: "g_object_set_data".}
proc setDataFull*(anObject: PGObject, key: Cstring, data: Gpointer, 
                             destroy: TGDestroyNotify){.cdecl, 
    dynlib: gobjectlib, importc: "g_object_set_data_full".}
proc stealData*(anObject: PGObject, key: Cstring): Gpointer{.cdecl, 
    dynlib: gobjectlib, importc: "g_object_steal_data".}
proc watchClosure*(anObject: PGObject, closure: PGClosure){.cdecl, 
    dynlib: gobjectlib, importc: "g_object_watch_closure".}
proc gCclosureNewObject*(callback_func: TGCallback, anObject: PGObject): PGClosure{.
    cdecl, dynlib: gobjectlib, importc: "g_cclosure_new_object".}
proc gCclosureNewObjectSwap*(callback_func: TGCallback, anObject: PGObject): PGClosure{.
    cdecl, dynlib: gobjectlib, importc: "g_cclosure_new_object_swap".}
proc gClosureNewObject*(sizeof_closure: Guint, anObject: PGObject): PGClosure{.
    cdecl, dynlib: gobjectlib, importc: "g_closure_new_object".}
proc setObject*(value: PGValue, v_object: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_object".}
proc getObject*(value: PGValue): Gpointer{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_object".}
proc dupObject*(value: PGValue): PGObject{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_dup_object".}
proc gSignalConnectObject*(instance: Gpointer, detailed_signal: Cstring, 
                              c_handler: TGCallback, gobject: Gpointer, 
                              connect_flags: TGConnectFlags): Gulong{.cdecl, 
    dynlib: gobjectlib, importc: "g_signal_connect_object".}
proc runDispose*(anObject: PGObject){.cdecl, dynlib: gobjectlib, 
    importc: "g_object_run_dispose".}
proc setObjectTakeOwnership*(value: PGValue, v_object: Gpointer){.
    cdecl, dynlib: gobjectlib, importc: "g_value_set_object_take_ownership".}
proc gObjectWarnInvalidPspec*(anObject: Gpointer, pname: Cstring, 
                                  property_id: Gint, pspec: Gpointer)
proc gObjectWarnInvalidPropertyId*(anObject: Gpointer, property_id: gint, 
                                        pspec: Gpointer)
type 
  GFlagsType* = GType

const 
  GE* = 2.71828
  GLn2* = 0.693147
  GLn10* = 2.30259
  GPi* = 3.14159
  GPi2* = 1.57080
  GPi4* = 0.785398
  GSqrt2* = 1.41421
  GLittleEndian* = 1234
  GBigEndian* = 4321
  GPdpEndian* = 3412

proc guint16SwapLeBeConstant*(val: Guint16): Guint16
proc guint32SwapLeBeConstant*(val: Guint32): Guint32
type 
  PGEnumClass* = ptr TGEnumClass
  PGEnumValue* = ptr TGEnumValue
  TGEnumClass*{.final.} = object 
    g_type_class*: TGTypeClass
    minimum*: Gint
    maximum*: Gint
    n_values*: Guint
    values*: PGEnumValue

  TGEnumValue*{.final.} = object 
    value*: Gint
    value_name*: Cstring
    value_nick*: Cstring

  PGFlagsClass* = ptr TGFlagsClass
  PGFlagsValue* = ptr TGFlagsValue
  TGFlagsClass*{.final.} = object 
    g_type_class*: TGTypeClass
    mask*: Guint
    n_values*: Guint
    values*: PGFlagsValue

  TGFlagsValue*{.final.} = object 
    value*: Guint
    value_name*: Cstring
    value_nick*: Cstring


proc gTypeIsEnum*(theType: GType): Gboolean
proc gEnumClass*(class: Pointer): PGEnumClass
proc gIsEnumClass*(class: Pointer): Gboolean
proc gEnumClassType*(class: Pointer): GType
proc gEnumClassTypeName*(class: Pointer): Cstring
proc gTypeIsFlags*(theType: GType): Gboolean
proc gFlagsClass*(class: Pointer): PGFlagsClass
proc gIsFlagsClass*(class: Pointer): Gboolean
proc gFlagsClassType*(class: Pointer): GType
proc gFlagsClassTypeName*(class: Pointer): Cstring
proc gValueHoldsEnum*(value: Pointer): Gboolean
proc gValueHoldsFlags*(value: Pointer): Gboolean
proc getValue*(enum_class: PGEnumClass, value: Gint): PGEnumValue{.
    cdecl, dynlib: gliblib, importc: "g_enum_get_value".}
proc getValueByName*(enum_class: PGEnumClass, name: Cstring): PGEnumValue{.
    cdecl, dynlib: gliblib, importc: "g_enum_get_value_by_name".}
proc getValueByNick*(enum_class: PGEnumClass, nick: Cstring): PGEnumValue{.
    cdecl, dynlib: gliblib, importc: "g_enum_get_value_by_nick".}
proc getFirstValue*(flags_class: PGFlagsClass, value: Guint): PGFlagsValue{.
    cdecl, dynlib: gliblib, importc: "g_flags_get_first_value".}
proc getValueByName*(flags_class: PGFlagsClass, name: Cstring): PGFlagsValue{.
    cdecl, dynlib: gliblib, importc: "g_flags_get_value_by_name".}
proc getValueByNick*(flags_class: PGFlagsClass, nick: Cstring): PGFlagsValue{.
    cdecl, dynlib: gliblib, importc: "g_flags_get_value_by_nick".}
proc setEnum*(value: PGValue, v_enum: Gint){.cdecl, dynlib: gliblib, 
    importc: "g_value_set_enum".}
proc getEnum*(value: PGValue): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_value_get_enum".}
proc setFlags*(value: PGValue, v_flags: Guint){.cdecl, dynlib: gliblib, 
    importc: "g_value_set_flags".}
proc getFlags*(value: PGValue): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_value_get_flags".}
proc gEnumRegisterStatic*(name: Cstring, const_static_values: PGEnumValue): GType{.
    cdecl, dynlib: gliblib, importc: "g_enum_register_static".}
proc gFlagsRegisterStatic*(name: Cstring, const_static_values: PGFlagsValue): GType{.
    cdecl, dynlib: gliblib, importc: "g_flags_register_static".}
proc gEnumCompleteTypeInfo*(g_enum_type: GType, info: PGTypeInfo, 
                                const_values: PGEnumValue){.cdecl, 
    dynlib: gliblib, importc: "g_enum_complete_type_info".}
proc gFlagsCompleteTypeInfo*(g_flags_type: GType, info: PGTypeInfo, 
                                 const_values: PGFlagsValue){.cdecl, 
    dynlib: gliblib, importc: "g_flags_complete_type_info".}
const 
  GMinfloat* = 0.00000
  GMaxfloat* = 1.70000e+308
  GMindouble* = G_MINFLOAT
  GMaxdouble* = G_MAXFLOAT
  GMaxshort* = 32767
  GMinshort* = - G_MAXSHORT - 1
  GMaxushort* = 2 * G_MAXSHORT + 1
  GMaxint* = 2147483647
  GMinint* = - G_MAXINT - 1
  GMaxuint* = - 1
  GMinlong* = G_MININT
  GMaxlong* = G_MAXINT
  GMaxulong* = G_MAXUINT
  GMaxint64* = high(int64)
  GMinint64* = low(int64)

const 
  GGint16Format* = "hi"
  GGuint16Format* = "hu"
  GGint32Format* = 'i'
  GGuint32Format* = 'u'
  GHaveGint64* = 1
  GGint64Format* = "I64i"
  GGuint64Format* = "I64u"
  GlibSizeofVoidP* = SizeOf(Pointer)
  GlibSizeofLong* = SizeOf(int32)
  GlibSizeofSizeT* = SizeOf(int32)

type 
  PGSystemThread* = ptr TGSystemThread
  TGSystemThread*{.final.} = object 
    data*: Array[0..3, Char]
    dummy_double*: Float64
    dummy_pointer*: Pointer
    dummy_long*: Int32


const 
  GlibSysdefPollin* = 1
  GlibSysdefPollout* = 4
  GlibSysdefPollpri* = 2
  GlibSysdefPollerr* = 8
  GlibSysdefPollhup* = 16
  GlibSysdefPollnval* = 32

proc guintToPointer*(i: Guint): Pointer
type 
  PGAsciiType* = ptr TGAsciiType
  TGAsciiType* = Int32

const 
  GAsciiAlnum* = 1 shl 0
  GAsciiAlpha* = 1 shl 1
  GAsciiCntrl* = 1 shl 2
  GAsciiDigit* = 1 shl 3
  GAsciiGraph* = 1 shl 4
  GAsciiLower* = 1 shl 5
  GAsciiPrint* = 1 shl 6
  GAsciiPunct* = 1 shl 7
  GAsciiSpace* = 1 shl 8
  GAsciiUpper* = 1 shl 9
  GAsciiXdigit* = 1 shl 10

proc gAsciiTolower*(c: Gchar): Gchar{.cdecl, dynlib: gliblib, 
                                        importc: "g_ascii_tolower".}
proc gAsciiToupper*(c: Gchar): Gchar{.cdecl, dynlib: gliblib, 
                                        importc: "g_ascii_toupper".}
proc gAsciiDigitValue*(c: Gchar): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_ascii_digit_value".}
proc gAsciiXdigitValue*(c: Gchar): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_ascii_xdigit_value".}
const 
  GStrDelimiters* = "``-|> <."

proc gStrdelimit*(str: Cstring, delimiters: Cstring, new_delimiter: Gchar): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_strdelimit".}
proc gStrcanon*(str: Cstring, valid_chars: Cstring, substitutor: Gchar): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_strcanon".}
proc gStrerror*(errnum: Gint): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_strerror".}
proc gStrsignal*(signum: Gint): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_strsignal".}
proc gStrreverse*(str: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_strreverse".}
proc gStrlcpy*(dest: Cstring, src: Cstring, dest_size: Gsize): Gsize{.cdecl, 
    dynlib: gliblib, importc: "g_strlcpy".}
proc gStrlcat*(dest: Cstring, src: Cstring, dest_size: Gsize): Gsize{.cdecl, 
    dynlib: gliblib, importc: "g_strlcat".}
proc gStrstrLen*(haystack: Cstring, haystack_len: Gssize, needle: Cstring): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_strstr_len".}
proc gStrrstr*(haystack: Cstring, needle: Cstring): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_strrstr".}
proc gStrrstrLen*(haystack: Cstring, haystack_len: Gssize, needle: Cstring): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_strrstr_len".}
proc gStrHasSuffix*(str: Cstring, suffix: Cstring): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_str_has_suffix".}
proc gStrHasPrefix*(str: Cstring, prefix: Cstring): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_str_has_prefix".}
proc gStrtod*(nptr: Cstring, endptr: PPgchar): Gdouble{.cdecl, dynlib: gliblib, 
    importc: "g_strtod".}
proc gAsciiStrtod*(nptr: Cstring, endptr: PPgchar): Gdouble{.cdecl, 
    dynlib: gliblib, importc: "g_ascii_strtod".}
const 
  GAsciiDtostrBufSize* = 29 + 10

proc gAsciiDtostr*(buffer: Cstring, buf_len: Gint, d: Gdouble): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_ascii_dtostr".}
proc gAsciiFormatd*(buffer: Cstring, buf_len: Gint, format: Cstring, 
                      d: Gdouble): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_ascii_formatd".}
proc gStrchug*(str: Cstring): Cstring{.cdecl, dynlib: gliblib, 
                                        importc: "g_strchug".}
proc gStrchomp*(str: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_strchomp".}
proc gAsciiStrcasecmp*(s1: Cstring, s2: Cstring): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_ascii_strcasecmp".}
proc gAsciiStrncasecmp*(s1: Cstring, s2: Cstring, n: Gsize): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_ascii_strncasecmp".}
proc gAsciiStrdown*(str: Cstring, len: Gssize): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_ascii_strdown".}
proc gAsciiStrup*(str: Cstring, len: Gssize): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_ascii_strup".}
proc gStrdup*(str: Cstring): Cstring{.cdecl, dynlib: gliblib, 
                                       importc: "g_strdup".}
proc gStrndup*(str: Cstring, n: Gsize): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_strndup".}
proc gStrnfill*(length: Gsize, fill_char: Gchar): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_strnfill".}
proc gStrcompress*(source: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_strcompress".}
proc gStrescape*(source: Cstring, exceptions: Cstring): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_strescape".}
proc gMemdup*(mem: Gconstpointer, byte_size: Guint): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_memdup".}
proc gStrsplit*(str: Cstring, delimiter: Cstring, max_tokens: Gint): PPgchar{.
    cdecl, dynlib: gliblib, importc: "g_strsplit".}
proc gStrjoinv*(separator: Cstring, str_array: PPgchar): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_strjoinv".}
proc gStrfreev*(str_array: PPgchar){.cdecl, dynlib: gliblib, 
                                      importc: "g_strfreev".}
proc gStrdupv*(str_array: PPgchar): PPgchar{.cdecl, dynlib: gliblib, 
    importc: "g_strdupv".}
proc gStpcpy*(dest: Cstring, src: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_stpcpy".}
proc gGetUserName*(): Cstring{.cdecl, dynlib: gliblib, 
                                  importc: "g_get_user_name".}
proc gGetRealName*(): Cstring{.cdecl, dynlib: gliblib, 
                                  importc: "g_get_real_name".}
proc gGetHomeDir*(): Cstring{.cdecl, dynlib: gliblib, 
                                 importc: "g_get_home_dir".}
proc gGetTmpDir*(): Cstring{.cdecl, dynlib: gliblib, importc: "g_get_tmp_dir".}
proc gGetPrgname*(): Cstring{.cdecl, dynlib: gliblib, importc: "g_get_prgname".}
proc gSetPrgname*(prgname: Cstring){.cdecl, dynlib: gliblib, 
                                       importc: "g_set_prgname".}
type 
  PGDebugKey* = ptr TGDebugKey
  TGDebugKey*{.final.} = object 
    key*: Cstring
    value*: Guint


proc gParseDebugString*(str: Cstring, keys: PGDebugKey, nkeys: Guint): Guint{.
    cdecl, dynlib: gliblib, importc: "g_parse_debug_string".}
proc gPathIsAbsolute*(file_name: Cstring): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_path_is_absolute".}
proc gPathSkipRoot*(file_name: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_path_skip_root".}
proc gBasename*(file_name: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_basename".}
proc gDirname*(file_name: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_path_get_dirname".}
proc gGetCurrentDir*(): Cstring{.cdecl, dynlib: gliblib, 
                                    importc: "g_get_current_dir".}
proc gPathGetBasename*(file_name: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_path_get_basename".}
proc gPathGetDirname*(file_name: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_path_get_dirname".}
proc nullifyPointer*(nullify_location: Pgpointer){.cdecl, dynlib: gliblib, 
    importc: "g_nullify_pointer".}
proc gGetenv*(variable: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_getenv".}
type 
  TGVoidFunc* = proc (){.cdecl.}

proc gAtexit*(func: TGVoidFunc){.cdecl, dynlib: gliblib, importc: "g_atexit".}
proc gFindProgramInPath*(program: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_find_program_in_path".}
proc gBitNthLsf*(mask: Gulong, nth_bit: Gint): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_bit_nth_lsf".}
proc gBitNthMsf*(mask: Gulong, nth_bit: Gint): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_bit_nth_msf".}
proc gBitStorage*(number: Gulong): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_bit_storage".}
type 
  PPGTrashStack* = ptr PGTrashStack
  PGTrashStack* = ptr TGTrashStack
  TGTrashStack*{.final.} = object 
    next*: PGTrashStack


proc gTrashStackPush*(stack_p: PPGTrashStack, data_p: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_trash_stack_push".}
proc gTrashStackPop*(stack_p: PPGTrashStack): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_trash_stack_pop".}
proc gTrashStackPeek*(stack_p: PPGTrashStack): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_trash_stack_peek".}
proc gTrashStackHeight*(stack_p: PPGTrashStack): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_trash_stack_height".}
type 
  PGHashTable* = Pointer
  TGHRFunc* = proc (key, value, user_data: Gpointer): Gboolean{.cdecl.}

proc gHashTableNew*(hash_func: TGHashFunc, key_equal_func: TGEqualFunc): PGHashTable{.
    cdecl, dynlib: gliblib, importc: "g_hash_table_new".}
proc gHashTableNewFull*(hash_func: TGHashFunc, key_equal_func: TGEqualFunc, 
                            key_destroy_func: TGDestroyNotify, 
                            value_destroy_func: TGDestroyNotify): PGHashTable{.
    cdecl, dynlib: gliblib, importc: "g_hash_table_new_full".}
proc tableDestroy*(hash_table: PGHashTable){.cdecl, dynlib: gliblib, 
    importc: "g_hash_table_destroy".}
proc tableInsert*(hash_table: PGHashTable, key: Gpointer, 
                          value: Gpointer){.cdecl, dynlib: gliblib, 
    importc: "g_hash_table_insert".}
proc tableReplace*(hash_table: PGHashTable, key: Gpointer, 
                           value: Gpointer){.cdecl, dynlib: gliblib, 
    importc: "g_hash_table_replace".}
proc tableRemove*(hash_table: PGHashTable, key: Gconstpointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_hash_table_remove".}
proc tableSteal*(hash_table: PGHashTable, key: Gconstpointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_hash_table_steal".}
proc tableLookup*(hash_table: PGHashTable, key: Gconstpointer): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_hash_table_lookup".}
proc tableLookupExtended*(hash_table: PGHashTable, 
                                   lookup_key: Gconstpointer, 
                                   orig_key: Pgpointer, value: Pgpointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_hash_table_lookup_extended".}
proc tableForeach*(hash_table: PGHashTable, func: TGHFunc, 
                           user_data: Gpointer){.cdecl, dynlib: gliblib, 
    importc: "g_hash_table_foreach".}
proc tableForeachRemove*(hash_table: PGHashTable, func: TGHRFunc, 
                                  user_data: Gpointer): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_hash_table_foreach_remove".}
proc tableForeachSteal*(hash_table: PGHashTable, func: TGHRFunc, 
                                 user_data: Gpointer): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_hash_table_foreach_steal".}
proc tableSize*(hash_table: PGHashTable): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_hash_table_size".}
proc gStrEqual*(v: Gconstpointer, v2: Gconstpointer): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_str_equal".}
proc gStrHash*(v: Gconstpointer): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_str_hash".}
proc gIntEqual*(v: Gconstpointer, v2: Gconstpointer): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_int_equal".}
proc gIntHash*(v: Gconstpointer): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_int_hash".}
proc gDirectHash*(v: Gconstpointer): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_direct_hash".}
proc gDirectEqual*(v: Gconstpointer, v2: Gconstpointer): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_direct_equal".}
proc gQuarkTryString*(str: Cstring): TGQuark{.cdecl, dynlib: gliblib, 
    importc: "g_quark_try_string".}
proc gQuarkFromStaticString*(str: Cstring): TGQuark{.cdecl, dynlib: gliblib, 
    importc: "g_quark_from_static_string".}
proc gQuarkFromString*(str: Cstring): TGQuark{.cdecl, dynlib: gliblib, 
    importc: "g_quark_from_string".}
proc gQuarkToString*(quark: TGQuark): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_quark_to_string".}
const 
  GMemAlign* = GLIB_SIZEOF_VOID_P

type 
  PGMemVTable* = ptr TGMemVTable
  TGMemVTable*{.final.} = object 
    malloc*: proc (n_bytes: Gsize): Gpointer{.cdecl.}
    realloc*: proc (mem: Gpointer, n_bytes: Gsize): Gpointer{.cdecl.}
    free*: proc (mem: Gpointer){.cdecl.}
    calloc*: proc (n_blocks: Gsize, n_block_bytes: Gsize): Gpointer{.cdecl.}
    try_malloc*: proc (n_bytes: Gsize): Gpointer{.cdecl.}
    try_realloc*: proc (mem: Gpointer, n_bytes: Gsize): Gpointer{.cdecl.}

  PGMemChunk* = Pointer
  PGAllocator* = Pointer

proc gMalloc*(n_bytes: Gulong): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_malloc".}
proc gMalloc0*(n_bytes: Gulong): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_malloc0".}
proc gRealloc*(mem: Gpointer, n_bytes: Gulong): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_realloc".}
proc gFree*(mem: Gpointer){.cdecl, dynlib: gliblib, importc: "g_free".}
proc gTryMalloc*(n_bytes: Gulong): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_try_malloc".}
proc gTryRealloc*(mem: Gpointer, n_bytes: Gulong): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_try_realloc".}
#proc g_new*(bytes_per_struct, n_structs: gsize): gpointer
#proc g_new0*(bytes_per_struct, n_structs: gsize): gpointer
#proc g_renew*(struct_size: gsize, OldMem: gpointer, n_structs: gsize): gpointer

proc setVtable*(vtable: PGMemVTable){.cdecl, dynlib: gliblib, 
    importc: "g_mem_set_vtable".}
proc gMemIsSystemMalloc*(): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_mem_is_system_malloc".}
proc gMemProfile*(){.cdecl, dynlib: gliblib, importc: "g_mem_profile".}
proc gChunkNew*(chunk: Pointer): Pointer
proc gChunkNew0*(chunk: Pointer): Pointer

const 
  GAllocOnly* = 1
  GAllocAndFree* = 2

proc gMemChunkNew*(name: Cstring, atom_size: Gint, area_size: Gulong, 
                      theType: Gint): PGMemChunk{.cdecl, dynlib: gliblib, 
    importc: "g_mem_chunk_new".}
proc chunkDestroy*(mem_chunk: PGMemChunk){.cdecl, dynlib: gliblib, 
    importc: "g_mem_chunk_destroy".}
proc chunkAlloc*(mem_chunk: PGMemChunk): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_mem_chunk_alloc".}
proc chunkAlloc0*(mem_chunk: PGMemChunk): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_mem_chunk_alloc0".}
proc chunkFree*(mem_chunk: PGMemChunk, mem: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_mem_chunk_free".}
proc chunkClean*(mem_chunk: PGMemChunk){.cdecl, dynlib: gliblib, 
    importc: "g_mem_chunk_clean".}
proc chunkReset*(mem_chunk: PGMemChunk){.cdecl, dynlib: gliblib, 
    importc: "g_mem_chunk_reset".}
proc chunkPrint*(mem_chunk: PGMemChunk){.cdecl, dynlib: gliblib, 
    importc: "g_mem_chunk_print".}
proc gMemChunkInfo*(){.cdecl, dynlib: gliblib, importc: "g_mem_chunk_info".}
proc gBlowChunks*(){.cdecl, dynlib: gliblib, importc: "g_blow_chunks".}
proc gAllocatorNew*(name: Cstring, n_preallocs: Guint): PGAllocator{.cdecl, 
    dynlib: gliblib, importc: "g_allocator_new".}
proc free*(allocator: PGAllocator){.cdecl, dynlib: gliblib, 
    importc: "g_allocator_free".}
const 
  GAllocatorList* = 1
  GAllocatorSlist* = 2
  GAllocatorNode* = 3

proc slistPushAllocator*(allocator: PGAllocator){.cdecl, dynlib: gliblib, 
    importc: "g_slist_push_allocator".}
proc gSlistPopAllocator*(){.cdecl, dynlib: gliblib, 
                               importc: "g_slist_pop_allocator".}
proc gSlistAlloc*(): PGSList{.cdecl, dynlib: gliblib, importc: "g_slist_alloc".}
proc free*(list: PGSList){.cdecl, dynlib: gliblib, 
                                   importc: "g_slist_free".}
proc free1*(list: PGSList){.cdecl, dynlib: gliblib, 
                                     importc: "g_slist_free_1".}
proc append*(list: PGSList, data: Gpointer): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_append".}
proc prepend*(list: PGSList, data: Gpointer): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_prepend".}
proc insert*(list: PGSList, data: Gpointer, position: Gint): PGSList{.
    cdecl, dynlib: gliblib, importc: "g_slist_insert".}
proc insertSorted*(list: PGSList, data: Gpointer, func: TGCompareFunc): PGSList{.
    cdecl, dynlib: gliblib, importc: "g_slist_insert_sorted".}
proc insertBefore*(slist: PGSList, sibling: PGSList, data: Gpointer): PGSList{.
    cdecl, dynlib: gliblib, importc: "g_slist_insert_before".}
proc concat*(list1: PGSList, list2: PGSList): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_concat".}
proc remove*(list: PGSList, data: Gconstpointer): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_remove".}
proc removeAll*(list: PGSList, data: Gconstpointer): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_remove_all".}
proc removeLink*(list: PGSList, link: PGSList): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_remove_link".}
proc deleteLink*(list: PGSList, link: PGSList): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_delete_link".}
proc reverse*(list: PGSList): PGSList{.cdecl, dynlib: gliblib, 
    importc: "g_slist_reverse".}
proc copy*(list: PGSList): PGSList{.cdecl, dynlib: gliblib, 
    importc: "g_slist_copy".}
proc nth*(list: PGSList, n: Guint): PGSList{.cdecl, dynlib: gliblib, 
    importc: "g_slist_nth".}
proc find*(list: PGSList, data: Gconstpointer): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_find".}
proc findCustom*(list: PGSList, data: Gconstpointer, 
                          func: TGCompareFunc): PGSList{.cdecl, dynlib: gliblib, 
    importc: "g_slist_find_custom".}
proc position*(list: PGSList, llink: PGSList): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_slist_position".}
proc index*(list: PGSList, data: Gconstpointer): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_slist_index".}
proc last*(list: PGSList): PGSList{.cdecl, dynlib: gliblib, 
    importc: "g_slist_last".}
proc length*(list: PGSList): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_slist_length".}
proc foreach*(list: PGSList, func: TGFunc, user_data: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_slist_foreach".}
proc sort*(list: PGSList, compare_func: TGCompareFunc): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_sort".}
proc sort*(list: PGSList, compare_func: TGCompareDataFunc, 
                             user_data: Gpointer): PGSList{.cdecl, 
    dynlib: gliblib, importc: "g_slist_sort_with_data".}
proc nthData*(list: PGSList, n: Guint): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_slist_nth_data".}
proc next*(slist: PGSList): PGSList
proc listPushAllocator*(allocator: PGAllocator){.cdecl, dynlib: gliblib, 
    importc: "g_list_push_allocator".}
proc gListPopAllocator*(){.cdecl, dynlib: gliblib, 
                              importc: "g_list_pop_allocator".}
proc gListAlloc*(): PGList{.cdecl, dynlib: gliblib, importc: "g_list_alloc".}
proc free*(list: PGList){.cdecl, dynlib: gliblib, importc: "g_list_free".}
proc free1*(list: PGList){.cdecl, dynlib: gliblib, 
                                   importc: "g_list_free_1".}
proc append*(list: PGList, data: Gpointer): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_append".}
proc prepend*(list: PGList, data: Gpointer): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_prepend".}
proc insert*(list: PGList, data: Gpointer, position: Gint): PGList{.
    cdecl, dynlib: gliblib, importc: "g_list_insert".}
proc insertSorted*(list: PGList, data: Gpointer, func: TGCompareFunc): PGList{.
    cdecl, dynlib: gliblib, importc: "g_list_insert_sorted".}
proc insertBefore*(list: PGList, sibling: PGList, data: Gpointer): PGList{.
    cdecl, dynlib: gliblib, importc: "g_list_insert_before".}
proc concat*(list1: PGList, list2: PGList): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_concat".}
proc remove*(list: PGList, data: Gconstpointer): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_remove".}
proc removeAll*(list: PGList, data: Gconstpointer): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_remove_all".}
proc removeLink*(list: PGList, llink: PGList): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_remove_link".}
proc deleteLink*(list: PGList, link: PGList): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_delete_link".}
proc reverse*(list: PGList): PGList{.cdecl, dynlib: gliblib, 
    importc: "g_list_reverse".}
proc copy*(list: PGList): PGList{.cdecl, dynlib: gliblib, 
    importc: "g_list_copy".}
proc nth*(list: PGList, n: Guint): PGList{.cdecl, dynlib: gliblib, 
    importc: "g_list_nth".}
proc nthPrev*(list: PGList, n: Guint): PGList{.cdecl, dynlib: gliblib, 
    importc: "g_list_nth_prev".}
proc find*(list: PGList, data: Gconstpointer): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_find".}
proc findCustom*(list: PGList, data: Gconstpointer, func: TGCompareFunc): PGList{.
    cdecl, dynlib: gliblib, importc: "g_list_find_custom".}
proc position*(list: PGList, llink: PGList): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_list_position".}
proc index*(list: PGList, data: Gconstpointer): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_list_index".}
proc last*(list: PGList): PGList{.cdecl, dynlib: gliblib, 
    importc: "g_list_last".}
proc first*(list: PGList): PGList{.cdecl, dynlib: gliblib, 
    importc: "g_list_first".}
proc length*(list: PGList): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_list_length".}
proc foreach*(list: PGList, func: TGFunc, user_data: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_list_foreach".}
proc sort*(list: PGList, compare_func: TGCompareFunc): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_sort".}
proc sort*(list: PGList, compare_func: TGCompareDataFunc, 
                            user_data: Gpointer): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_list_sort_with_data".}
proc nthData*(list: PGList, n: Guint): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_list_nth_data".}
proc previous*(list: PGList): PGList
proc next*(list: PGList): PGList
type 
  PGCache* = Pointer
  TGCacheNewFunc* = proc (key: Gpointer): Gpointer{.cdecl.}
  TGCacheDupFunc* = proc (value: Gpointer): Gpointer{.cdecl.}
  TGCacheDestroyFunc* = proc (value: Gpointer){.cdecl.}

proc gCacheNew*(value_new_func: TGCacheNewFunc, 
                  value_destroy_func: TGCacheDestroyFunc, 
                  key_dup_func: TGCacheDupFunc, 
                  key_destroy_func: TGCacheDestroyFunc, 
                  hash_key_func: TGHashFunc, hash_value_func: TGHashFunc, 
                  key_equal_func: TGEqualFunc): PGCache{.cdecl, dynlib: gliblib, 
    importc: "g_cache_new".}
proc destroy*(cache: PGCache){.cdecl, dynlib: gliblib, 
                                       importc: "g_cache_destroy".}
proc insert*(cache: PGCache, key: Gpointer): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_cache_insert".}
proc remove*(cache: PGCache, value: Gconstpointer){.cdecl, 
    dynlib: gliblib, importc: "g_cache_remove".}
proc keyForeach*(cache: PGCache, func: TGHFunc, user_data: Gpointer){.
    cdecl, dynlib: gliblib, importc: "g_cache_key_foreach".}
proc valueForeach*(cache: PGCache, func: TGHFunc, user_data: Gpointer){.
    cdecl, dynlib: gliblib, importc: "g_cache_value_foreach".}
type 
  PGCompletionFunc* = ptr TGCompletionFunc
  TGCompletionFunc* = Gchar
  TGCompletionStrncmpFunc* = proc (s1: Cstring, s2: Cstring, n: Gsize): Gint{.
      cdecl.}
  PGCompletion* = ptr TGCompletion
  TGCompletion*{.final.} = object 
    items*: PGList
    func*: TGCompletionFunc
    prefix*: Cstring
    cache*: PGList
    strncmp_func*: TGCompletionStrncmpFunc


proc gCompletionNew*(func: TGCompletionFunc): PGCompletion{.cdecl, 
    dynlib: gliblib, importc: "g_completion_new".}
proc addItems*(cmp: PGCompletion, items: PGList){.cdecl, 
    dynlib: gliblib, importc: "g_completion_add_items".}
proc removeItems*(cmp: PGCompletion, items: PGList){.cdecl, 
    dynlib: gliblib, importc: "g_completion_remove_items".}
proc clearItems*(cmp: PGCompletion){.cdecl, dynlib: gliblib, 
    importc: "g_completion_clear_items".}
proc complete*(cmp: PGCompletion, prefix: Cstring, 
                            new_prefix: PPgchar): PGList{.cdecl, 
    dynlib: gliblib, importc: "g_completion_complete".}
proc setCompare*(cmp: PGCompletion, 
                               strncmp_func: TGCompletionStrncmpFunc){.cdecl, 
    dynlib: gliblib, importc: "g_completion_set_compare".}
proc free*(cmp: PGCompletion){.cdecl, dynlib: gliblib, 
    importc: "g_completion_free".}
type 
  PGConvertError* = ptr TGConvertError
  TGConvertError* = enum 
    G_CONVERT_ERROR_NO_CONVERSION, G_CONVERT_ERROR_ILLEGAL_SEQUENCE, 
    G_CONVERT_ERROR_FAILED, G_CONVERT_ERROR_PARTIAL_INPUT, 
    G_CONVERT_ERROR_BAD_URI, G_CONVERT_ERROR_NOT_ABSOLUTE_PATH

proc gConvertError*(): TGQuark
proc gConvertErrorQuark*(): TGQuark{.cdecl, dynlib: gliblib, 
                                        importc: "g_convert_error_quark".}
type 
  PGIConv* = ptr TGIConv
  TGIConv* = Pointer

proc gIconvOpen*(to_codeset: Cstring, from_codeset: Cstring): TGIConv{.cdecl, 
    dynlib: gliblib, importc: "g_iconv_open".}
proc gIconv*(`converter`: TGIConv, inbuf: PPgchar, inbytes_left: Pgsize, 
              outbuf: PPgchar, outbytes_left: Pgsize): Gsize{.cdecl, 
    dynlib: gliblib, importc: "g_iconv".}
proc gIconvClose*(`converter`: TGIConv): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_iconv_close".}
proc gConvert*(str: Cstring, len: Gssize, to_codeset: Cstring, 
                from_codeset: Cstring, bytes_read: Pgsize, 
                bytes_written: Pgsize, error: Pointer): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_convert".}
proc gConvert*(str: Cstring, len: Gssize, `converter`: TGIConv, 
                           bytes_read: Pgsize, bytes_written: Pgsize, 
                           error: Pointer): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_convert_with_iconv".}
proc gConvert*(str: Cstring, len: Gssize, to_codeset: Cstring, 
                              from_codeset: Cstring, fallback: Cstring, 
                              bytes_read: Pgsize, bytes_written: Pgsize, 
                              error: Pointer): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_convert_with_fallback".}
proc gLocaleToUtf8*(opsysstring: Cstring, len: Gssize, bytes_read: Pgsize, 
                       bytes_written: Pgsize, error: Pointer): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_locale_to_utf8".}
proc gLocaleFromUtf8*(utf8string: Cstring, len: Gssize, bytes_read: Pgsize, 
                         bytes_written: Pgsize, error: Pointer): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_locale_from_utf8".}
proc gFilenameToUtf8*(opsysstring: Cstring, len: Gssize, bytes_read: Pgsize, 
                         bytes_written: Pgsize, error: Pointer): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_filename_to_utf8".}
proc gFilenameFromUtf8*(utf8string: Cstring, len: Gssize, bytes_read: Pgsize, 
                           bytes_written: Pgsize, error: Pointer): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_filename_from_utf8".}
proc gFilenameFromUri*(uri: Cstring, hostname: PPchar, error: Pointer): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_filename_from_uri".}
proc gFilenameToUri*(filename: Cstring, hostname: Cstring, error: Pointer): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_filename_to_uri".}
type 
  TGDataForeachFunc* = proc (key_id: TGQuark, data: Gpointer, 
                             user_data: Gpointer){.cdecl.}

proc gDatalistInit*(datalist: PPGData){.cdecl, dynlib: gliblib, 
    importc: "g_datalist_init".}
proc gDatalistClear*(datalist: PPGData){.cdecl, dynlib: gliblib, 
    importc: "g_datalist_clear".}
proc gDatalistIdGetData*(datalist: PPGData, key_id: TGQuark): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_datalist_id_get_data".}
proc gDatalistIdSetDataFull*(datalist: PPGData, key_id: TGQuark, 
                                  data: Gpointer, destroy_func: TGDestroyNotify){.
    cdecl, dynlib: gliblib, importc: "g_datalist_id_set_data_full".}
proc gDatalistIdRemoveNoNotify*(datalist: PPGData, key_id: TGQuark): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_datalist_id_remove_no_notify".}
proc gDatalistForeach*(datalist: PPGData, func: TGDataForeachFunc, 
                         user_data: Gpointer){.cdecl, dynlib: gliblib, 
    importc: "g_datalist_foreach".}
proc gDatalistIdSetData*(datalist: PPGData, key_id: TGQuark, data: Gpointer)
proc gDatalistIdRemoveData*(datalist: PPGData, key_id: TGQuark)
proc gDatalistGetData*(datalist: PPGData, key_str: Cstring): PPGData
proc gDatalistSetDataFull*(datalist: PPGData, key_str: Cstring, 
                               data: Gpointer, destroy_func: TGDestroyNotify)
proc gDatalistSetData*(datalist: PPGData, key_str: Cstring, data: Gpointer)
proc gDatalistRemoveNoNotify*(datalist: PPGData, key_str: Cstring)
proc gDatalistRemoveData*(datalist: PPGData, key_str: Cstring)
proc gDatasetIdGetData*(dataset_location: Gconstpointer, key_id: TGQuark): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_dataset_id_get_data".}
proc gDatasetIdSetDataFull*(dataset_location: Gconstpointer, 
                                 key_id: TGQuark, data: Gpointer, 
                                 destroy_func: TGDestroyNotify){.cdecl, 
    dynlib: gliblib, importc: "g_dataset_id_set_data_full".}
proc gDatasetIdRemoveNoNotify*(dataset_location: Gconstpointer, 
                                    key_id: TGQuark): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_dataset_id_remove_no_notify".}
proc gDatasetForeach*(dataset_location: Gconstpointer, 
                        func: TGDataForeachFunc, user_data: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_dataset_foreach".}
proc gDatasetIdSetData*(location: Gconstpointer, key_id: TGQuark, 
                            data: Gpointer)
proc gDatasetIdRemoveData*(location: Gconstpointer, key_id: TGQuark)
proc gDatasetGetData*(location: Gconstpointer, key_str: Cstring): Gpointer
proc gDatasetSetDataFull*(location: Gconstpointer, key_str: Cstring, 
                              data: Gpointer, destroy_func: TGDestroyNotify)
proc gDatasetRemoveNoNotify*(location: Gconstpointer, key_str: Cstring)
proc gDatasetSetData*(location: Gconstpointer, key_str: Cstring, 
                         data: Gpointer)
proc gDatasetRemoveData*(location: Gconstpointer, key_str: Cstring)
type 
  PGTime* = ptr TGTime
  TGTime* = Gint32
  PGDateYear* = ptr TGDateYear
  TGDateYear* = Guint16
  PGDateDay* = ptr TGDateDay
  TGDateDay* = Guint8
  Ptm* = ptr Ttm
  Ttm*{.final.} = object 
    tm_sec*: Gint
    tm_min*: Gint
    tm_hour*: Gint
    tm_mday*: Gint
    tm_mon*: Gint
    tm_year*: Gint
    tm_wday*: Gint
    tm_yday*: Gint
    tm_isdst*: Gint
    tm_gmtoff*: Glong
    tm_zone*: Cstring


type 
  PGDateDMY* = ptr TGDateDMY
  TGDateDMY* = Int

const 
  GDateDay* = 0
  GDateMonth* = 1
  GDateYear* = 2

type 
  PGDateWeekday* = ptr TGDateWeekday
  TGDateWeekday* = Int

const 
  GDateBadWeekday* = 0
  GDateMonday* = 1
  GDateTuesday* = 2
  GDateWednesday* = 3
  GDateThursday* = 4
  GDateFriday* = 5
  GDateSaturday* = 6
  GDateSunday* = 7

type 
  PGDateMonth* = ptr TGDateMonth
  TGDateMonth* = Int

const 
  GDateBadMonth* = 0
  GDateJanuary* = 1
  GDateFebruary* = 2
  GDateMarch* = 3
  GDateApril* = 4
  GDateMay* = 5
  GDateJune* = 6
  GDateJuly* = 7
  GDateAugust* = 8
  GDateSeptember* = 9
  GDateOctober* = 10
  GDateNovember* = 11
  GDateDecember* = 12

const 
  GDateBadJulian* = 0
  GDateBadDay* = 0
  GDateBadYear* = 0

type 
  PGDate* = ptr TGDate
  TGDate*{.final.} = object 
    flag0*: Int32
    flag1*: Int32


proc gDateNew*(): PGDate{.cdecl, dynlib: gliblib, importc: "g_date_new".}
proc gDateNewDmy*(day: TGDateDay, month: TGDateMonth, year: TGDateYear): PGDate{.
    cdecl, dynlib: gliblib, importc: "g_date_new_dmy".}
proc gDateNewJulian*(julian_day: Guint32): PGDate{.cdecl, dynlib: gliblib, 
    importc: "g_date_new_julian".}
proc free*(date: PGDate){.cdecl, dynlib: gliblib, importc: "g_date_free".}
proc valid*(date: PGDate): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_date_valid".}
proc gDateValidMonth*(month: TGDateMonth): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_date_valid_month".}
proc gDateValidYear*(year: TGDateYear): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_date_valid_year".}
proc gDateValidWeekday*(weekday: TGDateWeekday): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_date_valid_weekday".}
proc gDateValidJulian*(julian_date: Guint32): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_date_valid_julian".}
proc getWeekday*(date: PGDate): TGDateWeekday{.cdecl, dynlib: gliblib, 
    importc: "g_date_get_weekday".}
proc getMonth*(date: PGDate): TGDateMonth{.cdecl, dynlib: gliblib, 
    importc: "g_date_get_month".}
proc getYear*(date: PGDate): TGDateYear{.cdecl, dynlib: gliblib, 
    importc: "g_date_get_year".}
proc getDay*(date: PGDate): TGDateDay{.cdecl, dynlib: gliblib, 
    importc: "g_date_get_day".}
proc getJulian*(date: PGDate): Guint32{.cdecl, dynlib: gliblib, 
    importc: "g_date_get_julian".}
proc getDayOfYear*(date: PGDate): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_date_get_day_of_year".}
proc getMondayWeekOfYear*(date: PGDate): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_date_get_monday_week_of_year".}
proc getSundayWeekOfYear*(date: PGDate): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_date_get_sunday_week_of_year".}
proc clear*(date: PGDate, n_dates: Guint){.cdecl, dynlib: gliblib, 
    importc: "g_date_clear".}
proc setParse*(date: PGDate, str: Cstring){.cdecl, dynlib: gliblib, 
    importc: "g_date_set_parse".}
proc setTime*(date: PGDate, time: TGTime){.cdecl, dynlib: gliblib, 
    importc: "g_date_set_time".}
proc setMonth*(date: PGDate, month: TGDateMonth){.cdecl, 
    dynlib: gliblib, importc: "g_date_set_month".}
proc setDay*(date: PGDate, day: TGDateDay){.cdecl, dynlib: gliblib, 
    importc: "g_date_set_day".}
proc setYear*(date: PGDate, year: TGDateYear){.cdecl, dynlib: gliblib, 
    importc: "g_date_set_year".}
proc setDmy*(date: PGDate, day: TGDateDay, month: TGDateMonth, 
                     y: TGDateYear){.cdecl, dynlib: gliblib, 
                                     importc: "g_date_set_dmy".}
proc setJulian*(date: PGDate, julian_date: Guint32){.cdecl, 
    dynlib: gliblib, importc: "g_date_set_julian".}
proc isFirstOfMonth*(date: PGDate): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_date_is_first_of_month".}
proc isLastOfMonth*(date: PGDate): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_date_is_last_of_month".}
proc addDays*(date: PGDate, n_days: Guint){.cdecl, dynlib: gliblib, 
    importc: "g_date_add_days".}
proc subtractDays*(date: PGDate, n_days: Guint){.cdecl, dynlib: gliblib, 
    importc: "g_date_subtract_days".}
proc addMonths*(date: PGDate, n_months: Guint){.cdecl, dynlib: gliblib, 
    importc: "g_date_add_months".}
proc subtractMonths*(date: PGDate, n_months: Guint){.cdecl, 
    dynlib: gliblib, importc: "g_date_subtract_months".}
proc addYears*(date: PGDate, n_years: Guint){.cdecl, dynlib: gliblib, 
    importc: "g_date_add_years".}
proc subtractYears*(date: PGDate, n_years: Guint){.cdecl, 
    dynlib: gliblib, importc: "g_date_subtract_years".}
proc gDateIsLeapYear*(year: TGDateYear): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_date_is_leap_year".}
proc gDateGetDaysInMonth*(month: TGDateMonth, year: TGDateYear): Guint8{.
    cdecl, dynlib: gliblib, importc: "g_date_get_days_in_month".}
proc gDateGetMondayWeeksInYear*(year: TGDateYear): Guint8{.cdecl, 
    dynlib: gliblib, importc: "g_date_get_monday_weeks_in_year".}
proc gDateGetSundayWeeksInYear*(year: TGDateYear): Guint8{.cdecl, 
    dynlib: gliblib, importc: "g_date_get_sunday_weeks_in_year".}
proc daysBetween*(date1: PGDate, date2: PGDate): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_date_days_between".}
proc compare*(lhs: PGDate, rhs: PGDate): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_date_compare".}
proc toStructTm*(date: PGDate, tm: Ptm){.cdecl, dynlib: gliblib, 
    importc: "g_date_to_struct_tm".}
proc clamp*(date: PGDate, min_date: PGDate, max_date: PGDate){.cdecl, 
    dynlib: gliblib, importc: "g_date_clamp".}
proc order*(date1: PGDate, date2: PGDate){.cdecl, dynlib: gliblib, 
    importc: "g_date_order".}
proc gDateStrftime*(s: Cstring, slen: Gsize, format: Cstring, date: PGDate): Gsize{.
    cdecl, dynlib: gliblib, importc: "g_date_strftime".}
type 
  PGDir* = Pointer

proc gDirOpen*(path: Cstring, flags: Guint, error: Pointer): PGDir{.cdecl, 
    dynlib: gliblib, importc: "g_dir_open".}
proc readName*(dir: PGDir): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_dir_read_name".}
proc rewind*(dir: PGDir){.cdecl, dynlib: gliblib, importc: "g_dir_rewind".}
proc close*(dir: PGDir){.cdecl, dynlib: gliblib, importc: "g_dir_close".}
type 
  PGFileError* = ptr TGFileError
  TGFileError* = Gint

type 
  PGFileTest* = ptr TGFileTest
  TGFileTest* = Int

const 
  GFileTestIsRegular* = 1 shl 0
  GFileTestIsSymlink* = 1 shl 1
  GFileTestIsDir* = 1 shl 2
  GFileTestIsExecutable* = 1 shl 3
  GFileTestExists* = 1 shl 4

const 
  GFileErrorExist* = 0
  GFileErrorIsdir* = 1
  GFileErrorAcces* = 2
  GFileErrorNametoolong* = 3
  GFileErrorNoent* = 4
  GFileErrorNotdir* = 5
  GFileErrorNxio* = 6
  GFileErrorNodev* = 7
  GFileErrorRofs* = 8
  GFileErrorTxtbsy* = 9
  GFileErrorFault* = 10
  GFileErrorLoop* = 11
  GFileErrorNospc* = 12
  GFileErrorNomem* = 13
  GFileErrorMfile* = 14
  GFileErrorNfile* = 15
  GFileErrorBadf* = 16
  GFileErrorInval* = 17
  GFileErrorPipe* = 18
  GFileErrorAgain* = 19
  GFileErrorIntr* = 20
  GFileErrorIo* = 21
  GFileErrorPerm* = 22
  GFileErrorFailed* = 23

proc gFileError*(): TGQuark
proc gFileErrorQuark*(): TGQuark{.cdecl, dynlib: gliblib, 
                                     importc: "g_file_error_quark".}
proc gFileErrorFromErrno*(err_no: Gint): TGFileError{.cdecl, 
    dynlib: gliblib, importc: "g_file_error_from_errno".}
proc gFileTest*(filename: Cstring, test: TGFileTest): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_file_test".}
proc gFileGetContents*(filename: Cstring, contents: PPgchar, length: Pgsize, 
                          error: Pointer): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_file_get_contents".}
proc gMkstemp*(tmpl: Cstring): Int32{.cdecl, dynlib: gliblib, 
                                       importc: "g_mkstemp".}
proc gFileOpenTmp*(tmpl: Cstring, name_used: PPchar, error: Pointer): Int32{.
    cdecl, dynlib: gliblib, importc: "g_file_open_tmp".}
type 
  PGHook* = ptr TGHook
  TGHook*{.final.} = object 
    data*: Gpointer
    next*: PGHook
    prev*: PGHook
    refCount*: Guint
    hookId*: Gulong
    flags*: Guint
    func*: Gpointer
    destroy*: TGDestroyNotify

  PGHookList* = ptr TGHookList
  TGHookCompareFunc* = proc (new_hook: PGHook, sibling: PGHook): Gint{.cdecl.}
  TGHookFindFunc* = proc (hook: PGHook, data: Gpointer): Gboolean{.cdecl.}
  TGHookMarshaller* = proc (hook: PGHook, marshal_data: Gpointer){.cdecl.}
  TGHookCheckMarshaller* = proc (hook: PGHook, marshal_data: Gpointer): Gboolean{.
      cdecl.}
  TGHookFunc* = proc (data: Gpointer){.cdecl.}
  TGHookCheckFunc* = proc (data: Gpointer): Gboolean{.cdecl.}
  TGHookFinalizeFunc* = proc (hook_list: PGHookList, hook: PGHook){.cdecl.}
  TGHookList*{.final.} = object 
    seq_id*: Gulong
    flag0*: Int32
    hooks*: PGHook
    hook_memchunk*: PGMemChunk
    finalize_hook*: TGHookFinalizeFunc
    dummy*: Array[0..1, Gpointer]


type 
  PGHookFlagMask* = ptr TGHookFlagMask
  TGHookFlagMask* = Int

const 
  GHookFlagActive* = 1'i32 shl 0'i32
  GHookFlagInCall* = 1'i32 shl 1'i32
  GHookFlagMask* = 0x0000000F'i32

const 
  GHookFlagUserShift* = 4'i32
  bmTGHookListHookSize* = 0x0000FFFF'i32
  bpTGHookListHookSize* = 0'i32
  bmTGHookListIsSetup* = 0x00010000'i32
  bpTGHookListIsSetup* = 16'i32

proc tGHookListHookSize*(a: PGHookList): Guint
proc tGHookListSetHookSize*(a: PGHookList, `hook_size`: Guint)
proc tGHookListIsSetup*(a: PGHookList): Guint
proc tGHookListSetIsSetup*(a: PGHookList, `is_setup`: Guint)
proc gHook*(hook: Pointer): PGHook
proc flags*(hook: PGHook): Guint
proc active*(hook: PGHook): Bool
proc inCall*(hook: PGHook): Bool
proc isValid*(hook: PGHook): Bool
proc isUnlinked*(hook: PGHook): Bool
proc listInit*(hook_list: PGHookList, hook_size: Guint){.cdecl, 
    dynlib: gliblib, importc: "g_hook_list_init".}
proc listClear*(hook_list: PGHookList){.cdecl, dynlib: gliblib, 
    importc: "g_hook_list_clear".}
proc alloc*(hook_list: PGHookList): PGHook{.cdecl, dynlib: gliblib, 
    importc: "g_hook_alloc".}
proc free*(hook_list: PGHookList, hook: PGHook){.cdecl, dynlib: gliblib, 
    importc: "g_hook_free".}
proc reference*(hook_list: PGHookList, hook: PGHook){.cdecl, dynlib: gliblib, 
    importc: "g_hook_ref".}
proc unref*(hook_list: PGHookList, hook: PGHook){.cdecl, dynlib: gliblib, 
    importc: "g_hook_unref".}
proc destroy*(hook_list: PGHookList, hook_id: Gulong): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_hook_destroy".}
proc destroyLink*(hook_list: PGHookList, hook: PGHook){.cdecl, 
    dynlib: gliblib, importc: "g_hook_destroy_link".}
proc prepend*(hook_list: PGHookList, hook: PGHook){.cdecl, 
    dynlib: gliblib, importc: "g_hook_prepend".}
proc insertBefore*(hook_list: PGHookList, sibling: PGHook, hook: PGHook){.
    cdecl, dynlib: gliblib, importc: "g_hook_insert_before".}
proc insertSorted*(hook_list: PGHookList, hook: PGHook, 
                           func: TGHookCompareFunc){.cdecl, dynlib: gliblib, 
    importc: "g_hook_insert_sorted".}
proc get*(hook_list: PGHookList, hook_id: Gulong): PGHook{.cdecl, 
    dynlib: gliblib, importc: "g_hook_get".}
proc find*(hook_list: PGHookList, need_valids: Gboolean, 
                  func: TGHookFindFunc, data: Gpointer): PGHook{.cdecl, 
    dynlib: gliblib, importc: "g_hook_find".}
proc findData*(hook_list: PGHookList, need_valids: Gboolean, 
                       data: Gpointer): PGHook{.cdecl, dynlib: gliblib, 
    importc: "g_hook_find_data".}
proc findFunc*(hook_list: PGHookList, need_valids: Gboolean, 
                       func: Gpointer): PGHook{.cdecl, dynlib: gliblib, 
    importc: "g_hook_find_func".}
proc findFuncData*(hook_list: PGHookList, need_valids: Gboolean, 
                            func: Gpointer, data: Gpointer): PGHook{.cdecl, 
    dynlib: gliblib, importc: "g_hook_find_func_data".}
proc firstValid*(hook_list: PGHookList, may_be_in_call: Gboolean): PGHook{.
    cdecl, dynlib: gliblib, importc: "g_hook_first_valid".}
proc nextValid*(hook_list: PGHookList, hook: PGHook, 
                        may_be_in_call: Gboolean): PGHook{.cdecl, 
    dynlib: gliblib, importc: "g_hook_next_valid".}
proc compareIds*(new_hook: PGHook, sibling: PGHook): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_hook_compare_ids".}
proc append*(hook_list: PGHookList, hook: PGHook)
proc listInvokeCheck*(hook_list: PGHookList, may_recurse: Gboolean){.
    cdecl, dynlib: gliblib, importc: "g_hook_list_invoke_check".}
proc listMarshal*(hook_list: PGHookList, may_recurse: Gboolean, 
                          marshaller: TGHookMarshaller, marshal_data: Gpointer){.
    cdecl, dynlib: gliblib, importc: "g_hook_list_marshal".}
proc listMarshalCheck*(hook_list: PGHookList, may_recurse: Gboolean, 
                                marshaller: TGHookCheckMarshaller, 
                                marshal_data: Gpointer){.cdecl, dynlib: gliblib, 
    importc: "g_hook_list_marshal_check".}
type 
  PGThreadPool* = ptr TGThreadPool
  TGThreadPool*{.final.} = object 
    func*: TGFunc
    user_data*: Gpointer
    exclusive*: Gboolean


proc gThreadPoolNew*(func: TGFunc, user_data: Gpointer, max_threads: Gint, 
                        exclusive: Gboolean, error: Pointer): PGThreadPool{.
    cdecl, dynlib: gliblib, importc: "g_thread_pool_new".}
proc poolPush*(pool: PGThreadPool, data: Gpointer, error: Pointer){.
    cdecl, dynlib: gliblib, importc: "g_thread_pool_push".}
proc poolSetMaxThreads*(pool: PGThreadPool, max_threads: Gint, 
                                    error: Pointer){.cdecl, dynlib: gliblib, 
    importc: "g_thread_pool_set_max_threads".}
proc poolGetMaxThreads*(pool: PGThreadPool): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_thread_pool_get_max_threads".}
proc poolGetNumThreads*(pool: PGThreadPool): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_thread_pool_get_num_threads".}
proc poolUnprocessed*(pool: PGThreadPool): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_thread_pool_unprocessed".}
proc poolFree*(pool: PGThreadPool, immediate: Gboolean, wait: Gboolean){.
    cdecl, dynlib: gliblib, importc: "g_thread_pool_free".}
proc gThreadPoolSetMaxUnusedThreads*(max_threads: gint){.cdecl, 
    dynlib: gliblib, importc: "g_thread_pool_set_max_unused_threads".}
proc gThreadPoolGetMaxUnusedThreads*(): gint{.cdecl, dynlib: gliblib, 
    importc: "g_thread_pool_get_max_unused_threads".}
proc gThreadPoolGetNumUnusedThreads*(): guint{.cdecl, dynlib: gliblib, 
    importc: "g_thread_pool_get_num_unused_threads".}
proc gThreadPoolStopUnusedThreads*(){.cdecl, dynlib: gliblib, 
    importc: "g_thread_pool_stop_unused_threads".}
type 
  PGTimer* = Pointer

const 
  GUsecPerSec* = 1000000

proc gTimerNew*(): PGTimer{.cdecl, dynlib: gliblib, importc: "g_timer_new".}
proc destroy*(timer: PGTimer){.cdecl, dynlib: gliblib, 
                                       importc: "g_timer_destroy".}
proc start*(timer: PGTimer){.cdecl, dynlib: gliblib, 
                                     importc: "g_timer_start".}
proc stop*(timer: PGTimer){.cdecl, dynlib: gliblib, 
                                    importc: "g_timer_stop".}
proc reset*(timer: PGTimer){.cdecl, dynlib: gliblib, 
                                     importc: "g_timer_reset".}
proc elapsed*(timer: PGTimer, microseconds: Pgulong): Gdouble{.cdecl, 
    dynlib: gliblib, importc: "g_timer_elapsed".}
proc gUsleep*(microseconds: Gulong){.cdecl, dynlib: gliblib, 
                                      importc: "g_usleep".}
proc valAdd*(time: PGTimeVal, microseconds: Glong){.cdecl, 
    dynlib: gliblib, importc: "g_time_val_add".}
type 
  Pgunichar* = ptr Gunichar
  Gunichar* = Guint32
  Pgunichar2* = ptr Gunichar2
  Gunichar2* = Guint16
  PGUnicodeType* = ptr TGUnicodeType
  TGUnicodeType* = enum 
    G_UNICODE_CONTROL, G_UNICODE_FORMAT, G_UNICODE_UNASSIGNED, 
    G_UNICODE_PRIVATE_USE, G_UNICODE_SURROGATE, G_UNICODE_LOWERCASE_LETTER, 
    G_UNICODE_MODIFIER_LETTER, G_UNICODE_OTHER_LETTER, 
    G_UNICODE_TITLECASE_LETTER, G_UNICODE_UPPERCASE_LETTER, 
    G_UNICODE_COMBINING_MARK, G_UNICODE_ENCLOSING_MARK, 
    G_UNICODE_NON_SPACING_MARK, G_UNICODE_DECIMAL_NUMBER, 
    G_UNICODE_LETTER_NUMBER, G_UNICODE_OTHER_NUMBER, 
    G_UNICODE_CONNECT_PUNCTUATION, G_UNICODE_DASH_PUNCTUATION, 
    G_UNICODE_CLOSE_PUNCTUATION, G_UNICODE_FINAL_PUNCTUATION, 
    G_UNICODE_INITIAL_PUNCTUATION, G_UNICODE_OTHER_PUNCTUATION, 
    G_UNICODE_OPEN_PUNCTUATION, G_UNICODE_CURRENCY_SYMBOL, 
    G_UNICODE_MODIFIER_SYMBOL, G_UNICODE_MATH_SYMBOL, G_UNICODE_OTHER_SYMBOL, 
    G_UNICODE_LINE_SEPARATOR, G_UNICODE_PARAGRAPH_SEPARATOR, 
    G_UNICODE_SPACE_SEPARATOR
  PGUnicodeBreakType* = ptr TGUnicodeBreakType
  TGUnicodeBreakType* = enum 
    G_UNICODE_BREAK_MANDATORY, G_UNICODE_BREAK_CARRIAGE_RETURN, 
    G_UNICODE_BREAK_LINE_FEED, G_UNICODE_BREAK_COMBINING_MARK, 
    G_UNICODE_BREAK_SURROGATE, G_UNICODE_BREAK_ZERO_WIDTH_SPACE, 
    G_UNICODE_BREAK_INSEPARABLE, G_UNICODE_BREAK_NON_BREAKING_GLUE, 
    G_UNICODE_BREAK_CONTINGENT, G_UNICODE_BREAK_SPACE, G_UNICODE_BREAK_AFTER, 
    G_UNICODE_BREAK_BEFORE, G_UNICODE_BREAK_BEFORE_AND_AFTER, 
    G_UNICODE_BREAK_HYPHEN, G_UNICODE_BREAK_NON_STARTER, 
    G_UNICODE_BREAK_OPEN_PUNCTUATION, G_UNICODE_BREAK_CLOSE_PUNCTUATION, 
    G_UNICODE_BREAK_QUOTATION, G_UNICODE_BREAK_EXCLAMATION, 
    G_UNICODE_BREAK_IDEOGRAPHIC, G_UNICODE_BREAK_NUMERIC, 
    G_UNICODE_BREAK_INFIX_SEPARATOR, G_UNICODE_BREAK_SYMBOL, 
    G_UNICODE_BREAK_ALPHABETIC, G_UNICODE_BREAK_PREFIX, G_UNICODE_BREAK_POSTFIX, 
    G_UNICODE_BREAK_COMPLEX_CONTEXT, G_UNICODE_BREAK_AMBIGUOUS, 
    G_UNICODE_BREAK_UNKNOWN

proc gGetCharset*(charset: PPchar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_get_charset".}
proc gUnicharIsalnum*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isalnum".}
proc gUnicharIsalpha*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isalpha".}
proc gUnicharIscntrl*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_iscntrl".}
proc gUnicharIsdigit*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isdigit".}
proc gUnicharIsgraph*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isgraph".}
proc gUnicharIslower*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_islower".}
proc gUnicharIsprint*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isprint".}
proc gUnicharIspunct*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_ispunct".}
proc gUnicharIsspace*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isspace".}
proc gUnicharIsupper*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isupper".}
proc gUnicharIsxdigit*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isxdigit".}
proc gUnicharIstitle*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_istitle".}
proc gUnicharIsdefined*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_isdefined".}
proc gUnicharIswide*(c: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_iswide".}
proc gUnicharToupper*(c: Gunichar): Gunichar{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_toupper".}
proc gUnicharTolower*(c: Gunichar): Gunichar{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_tolower".}
proc gUnicharTotitle*(c: Gunichar): Gunichar{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_totitle".}
proc gUnicharDigitValue*(c: Gunichar): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_digit_value".}
proc gUnicharXdigitValue*(c: Gunichar): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_xdigit_value".}
proc gUnicharType*(c: Gunichar): TGUnicodeType{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_type".}
proc gUnicharBreakType*(c: Gunichar): TGUnicodeBreakType{.cdecl, 
    dynlib: gliblib, importc: "g_unichar_break_type".}
proc unicodeCanonicalOrdering*(str: Pgunichar, len: Gsize){.cdecl, 
    dynlib: gliblib, importc: "g_unicode_canonical_ordering".}
proc gUnicodeCanonicalDecomposition*(ch: Gunichar, result_len: Pgsize): Pgunichar{.
    cdecl, dynlib: gliblib, importc: "g_unicode_canonical_decomposition".}
proc utf8NextChar*(p: Pguchar): Pguchar
proc gUtf8GetChar*(p: Cstring): Gunichar{.cdecl, dynlib: gliblib, 
    importc: "g_utf8_get_char".}
proc gUtf8GetCharValidated*(p: Cstring, max_len: Gssize): Gunichar{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_get_char_validated".}
proc gUtf8OffsetToPointer*(str: Cstring, offset: Glong): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_offset_to_pointer".}
proc gUtf8PointerToOffset*(str: Cstring, pos: Cstring): Glong{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_pointer_to_offset".}
proc gUtf8PrevChar*(p: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_utf8_prev_char".}
proc gUtf8FindNextChar*(p: Cstring, `end`: Cstring): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_find_next_char".}
proc gUtf8FindPrevChar*(str: Cstring, p: Cstring): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_find_prev_char".}
proc gUtf8Strlen*(p: Cstring, max: Gssize): Glong{.cdecl, dynlib: gliblib, 
    importc: "g_utf8_strlen".}
proc gUtf8Strncpy*(dest: Cstring, src: Cstring, n: Gsize): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_strncpy".}
proc gUtf8Strchr*(p: Cstring, len: Gssize, c: Gunichar): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_strchr".}
proc gUtf8Strrchr*(p: Cstring, len: Gssize, c: Gunichar): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_strrchr".}
proc gUtf8ToUtf16*(str: Cstring, len: Glong, items_read: Pglong, 
                      items_written: Pglong, error: Pointer): Pgunichar2{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_to_utf16".}
proc gUtf8ToUcs4*(str: Cstring, len: Glong, items_read: Pglong, 
                     items_written: Pglong, error: Pointer): Pgunichar{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_to_ucs4".}
proc gUtf8ToUcs4Fast*(str: Cstring, len: Glong, items_written: Pglong): Pgunichar{.
    cdecl, dynlib: gliblib, importc: "g_utf8_to_ucs4_fast".}
proc utf16ToUcs4*(str: Pgunichar2, len: Glong, items_read: Pglong, 
                      items_written: Pglong, error: Pointer): Pgunichar{.cdecl, 
    dynlib: gliblib, importc: "g_utf16_to_ucs4".}
proc utf16ToUtf8*(str: Pgunichar2, len: Glong, items_read: Pglong, 
                      items_written: Pglong, error: Pointer): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf16_to_utf8".}
proc ucs4ToUtf16*(str: Pgunichar, len: Glong, items_read: Pglong, 
                      items_written: Pglong, error: Pointer): Pgunichar2{.cdecl, 
    dynlib: gliblib, importc: "g_ucs4_to_utf16".}
proc ucs4ToUtf8*(str: Pgunichar, len: Glong, items_read: Pglong, 
                     items_written: Pglong, error: Pointer): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_ucs4_to_utf8".}
proc gUnicharToUtf8*(c: Gunichar, outbuf: Cstring): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_unichar_to_utf8".}
proc gUtf8Validate*(str: Cstring, max_len: Gssize, `end`: PPgchar): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_utf8_validate".}
proc gUnicharValidate*(ch: Gunichar): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_unichar_validate".}
proc gUtf8Strup*(str: Cstring, len: Gssize): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_utf8_strup".}
proc gUtf8Strdown*(str: Cstring, len: Gssize): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_strdown".}
proc gUtf8Casefold*(str: Cstring, len: Gssize): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_casefold".}
type 
  PGNormalizeMode* = ptr TGNormalizeMode
  TGNormalizeMode* = Gint

const 
  GNormalizeDefault* = 0
  GNormalizeNfd* = G_NORMALIZE_DEFAULT
  GNormalizeDefaultCompose* = 1
  GNormalizeNfc* = G_NORMALIZE_DEFAULT_COMPOSE
  GNormalizeAll* = 2
  GNormalizeNfkd* = G_NORMALIZE_ALL
  GNormalizeAllCompose* = 3
  GNormalizeNfkc* = G_NORMALIZE_ALL_COMPOSE

proc gUtf8Normalize*(str: Cstring, len: Gssize, mode: TGNormalizeMode): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_utf8_normalize".}
proc gUtf8Collate*(str1: Cstring, str2: Cstring): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_collate".}
proc gUtf8CollateKey*(str: Cstring, len: Gssize): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_utf8_collate_key".}
type 
  PGString* = ptr TGString
  TGString*{.final.} = object 
    str*: Cstring
    len*: Gsize
    allocated_len*: Gsize

  PGStringChunk* = Pointer

proc gStringChunkNew*(size: Gsize): PGStringChunk{.cdecl, dynlib: gliblib, 
    importc: "g_string_chunk_new".}
proc chunkFree*(chunk: PGStringChunk){.cdecl, dynlib: gliblib, 
    importc: "g_string_chunk_free".}
proc chunkInsert*(chunk: PGStringChunk, str: Cstring): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_string_chunk_insert".}
proc chunkInsertConst*(chunk: PGStringChunk, str: Cstring): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_string_chunk_insert_const".}
proc gStringNew*(init: Cstring): PGString{.cdecl, dynlib: gliblib, 
    importc: "g_string_new".}
proc gStringNewLen*(init: Cstring, len: Gssize): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_new_len".}
proc gStringSizedNew*(dfl_size: Gsize): PGString{.cdecl, dynlib: gliblib, 
    importc: "g_string_sized_new".}
proc free*(str: PGString, free_segment: Gboolean): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_string_free".}
proc equal*(v: PGString, v2: PGString): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_string_equal".}
proc hash*(str: PGString): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_string_hash".}
proc assign*(str: PGString, rval: Cstring): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_assign".}
proc truncate*(str: PGString, len: Gsize): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_truncate".}
proc setSize*(str: PGString, len: Gsize): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_set_size".}
proc insertLen*(str: PGString, pos: Gssize, val: Cstring, len: Gssize): PGString{.
    cdecl, dynlib: gliblib, importc: "g_string_insert_len".}
proc append*(str: PGString, val: Cstring): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_append".}
proc appendLen*(str: PGString, val: Cstring, len: Gssize): PGString{.
    cdecl, dynlib: gliblib, importc: "g_string_append_len".}
proc appendC*(str: PGString, c: Gchar): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_append_c".}
proc appendUnichar*(str: PGString, wc: Gunichar): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_append_unichar".}
proc prepend*(str: PGString, val: Cstring): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_prepend".}
proc prependC*(str: PGString, c: Gchar): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_prepend_c".}
proc prependUnichar*(str: PGString, wc: Gunichar): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_prepend_unichar".}
proc prependLen*(str: PGString, val: Cstring, len: Gssize): PGString{.
    cdecl, dynlib: gliblib, importc: "g_string_prepend_len".}
proc insert*(str: PGString, pos: Gssize, val: Cstring): PGString{.
    cdecl, dynlib: gliblib, importc: "g_string_insert".}
proc insertC*(str: PGString, pos: Gssize, c: Gchar): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_insert_c".}
proc insertUnichar*(str: PGString, pos: Gssize, wc: Gunichar): PGString{.
    cdecl, dynlib: gliblib, importc: "g_string_insert_unichar".}
proc erase*(str: PGString, pos: Gssize, len: Gssize): PGString{.cdecl, 
    dynlib: gliblib, importc: "g_string_erase".}
proc asciiDown*(str: PGString): PGString{.cdecl, dynlib: gliblib, 
    importc: "g_string_ascii_down".}
proc asciiUp*(str: PGString): PGString{.cdecl, dynlib: gliblib, 
    importc: "g_string_ascii_up".}
proc down*(str: PGString): PGString{.cdecl, dynlib: gliblib, 
    importc: "g_string_down".}
proc up*(str: PGString): PGString{.cdecl, dynlib: gliblib, 
    importc: "g_string_up".}
type 
  PGIOError* = ptr TGIOError
  TGIOError* = enum 
    G_IO_ERROR_NONE, G_IO_ERROR_AGAIN, G_IO_ERROR_INVAL, G_IO_ERROR_UNKNOWN

proc gIoChannelError*(): TGQuark
type 
  PGIOChannelError* = ptr TGIOChannelError
  TGIOChannelError* = enum 
    G_IO_CHANNEL_ERROR_FBIG, G_IO_CHANNEL_ERROR_INVAL, G_IO_CHANNEL_ERROR_IO, 
    G_IO_CHANNEL_ERROR_ISDIR, G_IO_CHANNEL_ERROR_NOSPC, G_IO_CHANNEL_ERROR_NXIO, 
    G_IO_CHANNEL_ERROR_OVERFLOW, G_IO_CHANNEL_ERROR_PIPE, 
    G_IO_CHANNEL_ERROR_FAILED
  PGIOStatus* = ptr TGIOStatus
  TGIOStatus* = enum 
    G_IO_STATUS_ERROR, G_IO_STATUS_NORMAL, G_IO_STATUS_EOF, G_IO_STATUS_AGAIN
  PGSeekType* = ptr TGSeekType
  TGSeekType* = enum 
    G_SEEK_CUR, G_SEEK_SET, G_SEEK_END
  PGIOCondition* = ptr TGIOCondition
  TGIOCondition* = Gint

const 
  GIoIn* = GLIB_SYSDEF_POLLIN
  GIoOut* = GLIB_SYSDEF_POLLOUT
  GIoPri* = GLIB_SYSDEF_POLLPRI
  GIoErr* = GLIB_SYSDEF_POLLERR
  GIoHup* = GLIB_SYSDEF_POLLHUP
  GIoNval* = GLIB_SYSDEF_POLLNVAL

type 
  PGIOFlags* = ptr TGIOFlags
  TGIOFlags* = Gint

const 
  GIoFlagAppend* = 1 shl 0
  GIoFlagNonblock* = 1 shl 1
  GIoFlagIsReadable* = 1 shl 2
  GIoFlagIsWriteable* = 1 shl 3
  GIoFlagIsSeekable* = 1 shl 4
  GIoFlagMask* = (1 shl 5) - 1
  GIoFlagGetMask* = G_IO_FLAG_MASK
  GIoFlagSetMask* = G_IO_FLAG_APPEND or G_IO_FLAG_NONBLOCK

type 
  PGIOChannel* = ptr TGIOChannel
  TGIOFunc* = proc (source: PGIOChannel, condition: TGIOCondition, 
                    data: Gpointer): Gboolean{.cdecl.}
  PGIOFuncs* = ptr TGIOFuncs
  TGIOFuncs*{.final.} = object 
    io_read*: proc (channel: PGIOChannel, buf: Cstring, count: Gsize, 
                    bytes_read: Pgsize, err: Pointer): TGIOStatus{.cdecl.}
    io_write*: proc (channel: PGIOChannel, buf: Cstring, count: Gsize, 
                     bytes_written: Pgsize, err: Pointer): TGIOStatus{.cdecl.}
    io_seek*: proc (channel: PGIOChannel, offset: Gint64, theType: TGSeekType, 
                    err: Pointer): TGIOStatus{.cdecl.}
    io_close*: proc (channel: PGIOChannel, err: Pointer): TGIOStatus{.cdecl.}
    io_create_watch*: proc (channel: PGIOChannel, condition: TGIOCondition): PGsource{.
        cdecl.}
    io_free*: proc (channel: PGIOChannel){.cdecl.}
    io_set_flags*: proc (channel: PGIOChannel, flags: TGIOFlags, err: Pointer): TGIOStatus{.
        cdecl.}
    io_get_flags*: proc (channel: PGIOChannel): TGIOFlags{.cdecl.}

  TGIOChannel*{.final.} = object 
    ref_count*: Guint
    funcs*: PGIOFuncs
    encoding*: Cstring
    read_cd*: TGIConv
    write_cd*: TGIConv
    line_term*: Cstring
    line_term_len*: Guint
    buf_size*: Gsize
    read_buf*: PGString
    encoded_read_buf*: PGString
    write_buf*: PGString
    partial_write_buf*: Array[0..5, Gchar]
    flag0*: Guint16
    reserved1*: Gpointer
    reserved2*: Gpointer


const 
  bmTGIOChannelUseBuffer* = 0x0001'i16
  bpTGIOChannelUseBuffer* = 0'i16
  bmTGIOChannelDoEncode* = 0x0002'i16
  bpTGIOChannelDoEncode* = 1'i16
  bmTGIOChannelCloseOnUnref* = 0x0004'i16
  bpTGIOChannelCloseOnUnref* = 2'i16
  bmTGIOChannelIsReadable* = 0x0008'i16
  bpTGIOChannelIsReadable* = 3'i16
  bmTGIOChannelIsWriteable* = 0x0010'i16
  bpTGIOChannelIsWriteable* = 4'i16
  bmTGIOChannelIsSeekable* = 0x0020'i16
  bpTGIOChannelIsSeekable* = 5'i16

proc tGIOChannelUseBuffer*(a: PGIOChannel): Guint
proc tGIOChannelSetUseBuffer*(a: PGIOChannel, `use_buffer`: Guint)
proc tGIOChannelDoEncode*(a: PGIOChannel): Guint
proc tGIOChannelSetDoEncode*(a: PGIOChannel, `do_encode`: Guint)
proc tGIOChannelCloseOnUnref*(a: PGIOChannel): Guint
proc tGIOChannelSetCloseOnUnref*(a: PGIOChannel, `close_on_unref`: Guint)
proc tGIOChannelIsReadable*(a: PGIOChannel): Guint
proc tGIOChannelSetIsReadable*(a: PGIOChannel, `is_readable`: Guint)
proc tGIOChannelIsWriteable*(a: PGIOChannel): Guint
proc tGIOChannelSetIsWriteable*(a: PGIOChannel, `is_writeable`: Guint)
proc tGIOChannelIsSeekable*(a: PGIOChannel): Guint
proc tGIOChannelSetIsSeekable*(a: PGIOChannel, `is_seekable`: Guint)
proc channelInit*(channel: PGIOChannel){.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_init".}
proc channelRef*(channel: PGIOChannel){.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_ref".}
proc channelUnref*(channel: PGIOChannel){.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_unref".}
proc channelRead*(channel: PGIOChannel, buf: Cstring, count: Gsize, 
                        bytes_read: Pgsize): TGIOError{.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_read".}
proc channelWrite*(channel: PGIOChannel, buf: Cstring, count: Gsize, 
                         bytes_written: Pgsize): TGIOError{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_write".}
proc channelSeek*(channel: PGIOChannel, offset: Gint64, 
                        theType: TGSeekType): TGIOError{.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_seek".}
proc channelClose*(channel: PGIOChannel){.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_close".}
proc channelShutdown*(channel: PGIOChannel, flush: Gboolean, err: Pointer): TGIOStatus{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_shutdown".}
proc addWatchFull*(channel: PGIOChannel, priority: Gint, 
                          condition: TGIOCondition, func: TGIOFunc, 
                          user_data: Gpointer, notify: TGDestroyNotify): Guint{.
    cdecl, dynlib: gliblib, importc: "g_io_add_watch_full".}
proc createWatch*(channel: PGIOChannel, condition: TGIOCondition): PGsource{.
    cdecl, dynlib: gliblib, importc: "g_io_create_watch".}
proc addWatch*(channel: PGIOChannel, condition: TGIOCondition, 
                     func: TGIOFunc, user_data: Gpointer): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_io_add_watch".}
proc channelSetBufferSize*(channel: PGIOChannel, size: Gsize){.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_set_buffer_size".}
proc channelGetBufferSize*(channel: PGIOChannel): Gsize{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_get_buffer_size".}
proc channelGetBufferCondition*(channel: PGIOChannel): TGIOCondition{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_get_buffer_condition".}
proc channelSetFlags*(channel: PGIOChannel, flags: TGIOFlags, 
                             error: Pointer): TGIOStatus{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_set_flags".}
proc channelGetFlags*(channel: PGIOChannel): TGIOFlags{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_get_flags".}
proc channelSetLineTerm*(channel: PGIOChannel, line_term: Cstring, 
                                 length: Gint){.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_set_line_term".}
proc channelGetLineTerm*(channel: PGIOChannel, length: Pgint): Cstring{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_get_line_term".}
proc channelSetBuffered*(channel: PGIOChannel, buffered: Gboolean){.
    cdecl, dynlib: gliblib, importc: "g_io_channel_set_buffered".}
proc channelGetBuffered*(channel: PGIOChannel): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_get_buffered".}
proc channelSetEncoding*(channel: PGIOChannel, encoding: Cstring, 
                                error: Pointer): TGIOStatus{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_set_encoding".}
proc channelGetEncoding*(channel: PGIOChannel): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_get_encoding".}
proc channelSetCloseOnUnref*(channel: PGIOChannel, do_close: Gboolean){.
    cdecl, dynlib: gliblib, importc: "g_io_channel_set_close_on_unref".}
proc channelGetCloseOnUnref*(channel: PGIOChannel): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_get_close_on_unref".}
proc channelFlush*(channel: PGIOChannel, error: Pointer): TGIOStatus{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_flush".}
proc channelReadLine*(channel: PGIOChannel, str_return: PPgchar, 
                             length: Pgsize, terminator_pos: Pgsize, 
                             error: Pointer): TGIOStatus{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_read_line".}
proc channelReadLineString*(channel: PGIOChannel, buffer: PGString, 
                                    terminator_pos: Pgsize, error: Pointer): TGIOStatus{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_read_line_string".}
proc channelReadToEnd*(channel: PGIOChannel, str_return: PPgchar, 
                               length: Pgsize, error: Pointer): TGIOStatus{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_read_to_end".}
proc channelReadChars*(channel: PGIOChannel, buf: Cstring, count: Gsize, 
                              bytes_read: Pgsize, error: Pointer): TGIOStatus{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_read_chars".}
proc channelReadUnichar*(channel: PGIOChannel, thechar: Pgunichar, 
                                error: Pointer): TGIOStatus{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_read_unichar".}
proc channelWriteChars*(channel: PGIOChannel, buf: Cstring, 
                               count: Gssize, bytes_written: Pgsize, 
                               error: Pointer): TGIOStatus{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_write_chars".}
proc channelWriteUnichar*(channel: PGIOChannel, thechar: Gunichar, 
                                 error: Pointer): TGIOStatus{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_write_unichar".}
proc channelSeekPosition*(channel: PGIOChannel, offset: Gint64, 
                                 theType: TGSeekType, error: Pointer): TGIOStatus{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_seek_position".}
proc gIoChannelNewFile*(filename: Cstring, mode: Cstring, error: Pointer): PGIOChannel{.
    cdecl, dynlib: gliblib, importc: "g_io_channel_new_file".}
proc gIoChannelErrorQuark*(): TGQuark{.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_error_quark".}
proc gIoChannelErrorFromErrno*(en: gint): TGIOChannelError{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_error_from_errno".}
proc gIoChannelUnixNew*(fd: Int32): PGIOChannel{.cdecl, dynlib: gliblib, 
    importc: "g_io_channel_unix_new".}
proc channelUnixGetFd*(channel: PGIOChannel): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_io_channel_unix_get_fd".}
const 
  GLogLevelUserShift* = 8

type 
  PGLogLevelFlags* = ptr TGLogLevelFlags
  TGLogLevelFlags* = Int32

const 
  GLogFlagRecursion* = 1 shl 0
  GLogFlagFatal* = 1 shl 1
  GLogLevelError* = 1 shl 2
  GLogLevelCritical* = 1 shl 3
  GLogLevelWarning* = 1 shl 4
  GLogLevelMessage* = 1 shl 5
  GLogLevelInfo* = 1 shl 6
  GLogLevelDebug* = 1 shl 7
  GLogLevelMask* = not 3

const 
  GLogFatalMask* = 5

type 
  TGLogFunc* = proc (log_domain: Cstring, log_level: TGLogLevelFlags, 
                     TheMessage: Cstring, user_data: Gpointer){.cdecl.}

proc gLogSetHandler*(log_domain: Cstring, log_levels: TGLogLevelFlags, 
                        log_func: TGLogFunc, user_data: Gpointer): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_log_set_handler".}
proc gLogRemoveHandler*(log_domain: Cstring, handler_id: Guint){.cdecl, 
    dynlib: gliblib, importc: "g_log_remove_handler".}
proc gLogDefaultHandler*(log_domain: Cstring, log_level: TGLogLevelFlags, 
                            TheMessage: Cstring, unused_data: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_log_default_handler".}
proc gLogSetFatalMask*(log_domain: Cstring, fatal_mask: TGLogLevelFlags): TGLogLevelFlags{.
    cdecl, dynlib: gliblib, importc: "g_log_set_fatal_mask".}
proc gLogSetAlwaysFatal*(fatal_mask: TGLogLevelFlags): TGLogLevelFlags{.
    cdecl, dynlib: gliblib, importc: "g_log_set_always_fatal".}
proc `gLogFallbackHandler`*(log_domain: Cstring, log_level: TGLogLevelFlags, 
                               message: Cstring, unused_data: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_log_fallback_handler".}
const 
  GLogDomain* = nil

when false: 
  proc g_error*(format: cstring){.varargs.}
  proc g_message*(format: cstring){.varargs.}
  proc g_critical*(format: cstring){.varargs.}
  proc g_warning*(format: cstring){.varargs.}
type 
  TGPrintFunc* = proc (str: Cstring){.cdecl, varargs.}

proc gSetPrintHandler*(func: TGPrintFunc): TGPrintFunc{.cdecl, 
    dynlib: gliblib, importc: "g_set_print_handler".}
proc gSetPrinterrHandler*(func: TGPrintFunc): TGPrintFunc{.cdecl, 
    dynlib: gliblib, importc: "g_set_printerr_handler".}
type 
  PGMarkupError* = ptr TGMarkupError
  TGMarkupError* = enum 
    G_MARKUP_ERROR_BAD_UTF8, G_MARKUP_ERROR_EMPTY, G_MARKUP_ERROR_PARSE, 
    G_MARKUP_ERROR_UNKNOWN_ELEMENT, G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE, 
    G_MARKUP_ERROR_INVALID_CONTENT

proc gMarkupError*(): TGQuark
proc gMarkupErrorQuark*(): TGQuark{.cdecl, dynlib: gliblib, 
                                       importc: "g_markup_error_quark".}
type 
  PGMarkupParseFlags* = ptr TGMarkupParseFlags
  TGMarkupParseFlags* = Int

const 
  GMarkupDoNotUseThisUnsupportedFlag* = 1 shl 0

type 
  PGMarkupParseContext* = ptr TGMarkupParseContext
  TGMarkupParseContext* = Pointer
  PGMarkupParser* = ptr TGMarkupParser
  TGMarkupParser*{.final.} = object 
    start_element*: proc (context: PGMarkupParseContext, element_name: Cstring, 
                          attribute_names: PPgchar, attribute_values: PPgchar, 
                          user_data: Gpointer, error: Pointer){.cdecl.}
    end_element*: proc (context: PGMarkupParseContext, element_name: Cstring, 
                        user_data: Gpointer, error: Pointer){.cdecl.}
    text*: proc (context: PGMarkupParseContext, text: Cstring, text_len: Gsize, 
                 user_data: Gpointer, error: Pointer){.cdecl.}
    passthrough*: proc (context: PGMarkupParseContext, 
                        passthrough_text: Cstring, text_len: Gsize, 
                        user_data: Gpointer, error: Pointer){.cdecl.}
    error*: proc (context: PGMarkupParseContext, error: Pointer, 
                  user_data: Gpointer){.cdecl.}


proc parseContextNew*(parser: PGMarkupParser, 
                                 flags: TGMarkupParseFlags, user_data: Gpointer, 
                                 user_data_dnotify: TGDestroyNotify): PGMarkupParseContext{.
    cdecl, dynlib: gliblib, importc: "g_markup_parse_context_new".}
proc parseContextFree*(context: PGMarkupParseContext){.cdecl, 
    dynlib: gliblib, importc: "g_markup_parse_context_free".}
proc parseContextParse*(context: PGMarkupParseContext, text: Cstring, 
                                   text_len: Gssize, error: Pointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_markup_parse_context_parse".}
proc parseContextEndParse*(context: PGMarkupParseContext, 
                                       error: Pointer): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_markup_parse_context_end_parse".}
proc parseContextGetPosition*(context: PGMarkupParseContext, 
    line_number: Pgint, char_number: Pgint){.cdecl, dynlib: gliblib, 
    importc: "g_markup_parse_context_get_position".}
proc gMarkupEscapeText*(text: Cstring, length: Gssize): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_markup_escape_text".}
type 
  PGNode* = ptr TGNode
  TGNode*{.final.} = object 
    data*: Gpointer
    next*: PGNode
    prev*: PGNode
    parent*: PGNode
    children*: PGNode

  PGTraverseFlags* = ptr TGTraverseFlags
  TGTraverseFlags* = Gint

const 
  GTraverseLeafs* = 1 shl 0
  GTraverseNonLeafs* = 1 shl 1
  GTraverseAll* = G_TRAVERSE_LEAFS or G_TRAVERSE_NON_LEAFS
  GTraverseMask* = 0x00000003

type 
  PGTraverseType* = ptr TGTraverseType
  TGTraverseType* = enum 
    G_IN_ORDER, G_PRE_ORDER, G_POST_ORDER, G_LEVEL_ORDER
  TGNodeTraverseFunc* = proc (node: PGNode, data: Gpointer): Gboolean{.cdecl.}
  TGNodeForeachFunc* = proc (node: PGNode, data: Gpointer){.cdecl.}

proc isRoot*(node: PGNode): Bool
proc isLeaf*(node: PGNode): Bool
proc nodePushAllocator*(allocator: PGAllocator){.cdecl, dynlib: gliblib, 
    importc: "g_node_push_allocator".}
proc gNodePopAllocator*(){.cdecl, dynlib: gliblib, 
                              importc: "g_node_pop_allocator".}
proc gNodeNew*(data: Gpointer): PGNode{.cdecl, dynlib: gliblib, 
    importc: "g_node_new".}
proc destroy*(root: PGNode){.cdecl, dynlib: gliblib, 
                                    importc: "g_node_destroy".}
proc unlink*(node: PGNode){.cdecl, dynlib: gliblib, 
                                   importc: "g_node_unlink".}
proc copy*(node: PGNode): PGNode{.cdecl, dynlib: gliblib, 
    importc: "g_node_copy".}
proc insert*(parent: PGNode, position: Gint, node: PGNode): PGNode{.
    cdecl, dynlib: gliblib, importc: "g_node_insert".}
proc insertBefore*(parent: PGNode, sibling: PGNode, node: PGNode): PGNode{.
    cdecl, dynlib: gliblib, importc: "g_node_insert_before".}
proc insertAfter*(parent: PGNode, sibling: PGNode, node: PGNode): PGNode{.
    cdecl, dynlib: gliblib, importc: "g_node_insert_after".}
proc prepend*(parent: PGNode, node: PGNode): PGNode{.cdecl, 
    dynlib: gliblib, importc: "g_node_prepend".}
proc nNodes*(root: PGNode, flags: TGTraverseFlags): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_node_n_nodes".}
proc getRoot*(node: PGNode): PGNode{.cdecl, dynlib: gliblib, 
    importc: "g_node_get_root".}
proc isAncestor*(node: PGNode, descendant: PGNode): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_node_is_ancestor".}
proc depth*(node: PGNode): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_node_depth".}
proc find*(root: PGNode, order: TGTraverseType, flags: TGTraverseFlags, 
                  data: Gpointer): PGNode{.cdecl, dynlib: gliblib, 
    importc: "g_node_find".}
proc append*(parent: PGNode, node: PGNode): PGNode
proc insertData*(parent: PGNode, position: Gint, data: Gpointer): PGNode
proc insertDataBefore*(parent: PGNode, sibling: PGNode, data: Gpointer): PGNode
proc prependData*(parent: PGNode, data: Gpointer): PGNode
proc appendData*(parent: PGNode, data: Gpointer): PGNode
proc traverse*(root: PGNode, order: TGTraverseType, 
                      flags: TGTraverseFlags, max_depth: Gint, 
                      func: TGNodeTraverseFunc, data: Gpointer): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_node_traverse".}
proc maxHeight*(root: PGNode): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_node_max_height".}
proc childrenForeach*(node: PGNode, flags: TGTraverseFlags, 
                              func: TGNodeForeachFunc, data: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_node_children_foreach".}
proc reverseChildren*(node: PGNode){.cdecl, dynlib: gliblib, 
    importc: "g_node_reverse_children".}
proc nChildren*(node: PGNode): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_node_n_children".}
proc nthChild*(node: PGNode, n: Guint): PGNode{.cdecl, dynlib: gliblib, 
    importc: "g_node_nth_child".}
proc lastChild*(node: PGNode): PGNode{.cdecl, dynlib: gliblib, 
    importc: "g_node_last_child".}
proc findChild*(node: PGNode, flags: TGTraverseFlags, data: Gpointer): PGNode{.
    cdecl, dynlib: gliblib, importc: "g_node_find_child".}
proc childPosition*(node: PGNode, child: PGNode): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_node_child_position".}
proc childIndex*(node: PGNode, data: Gpointer): Gint{.cdecl, 
    dynlib: gliblib, importc: "g_node_child_index".}
proc firstSibling*(node: PGNode): PGNode{.cdecl, dynlib: gliblib, 
    importc: "g_node_first_sibling".}
proc lastSibling*(node: PGNode): PGNode{.cdecl, dynlib: gliblib, 
    importc: "g_node_last_sibling".}
proc prevSibling*(node: PGNode): PGNode
proc nextSibling*(node: PGNode): PGNode
proc firstChild*(node: PGNode): PGNode
type 
  PGTree* = Pointer
  TGTraverseFunc* = proc (key: Gpointer, value: Gpointer, data: Gpointer): Gboolean{.
      cdecl.}

proc gTreeNew*(key_compare_func: TGCompareFunc): PGTree{.cdecl, 
    dynlib: gliblib, importc: "g_tree_new".}
proc gTreeNew*(key_compare_func: TGCompareDataFunc, 
                           key_compare_data: Gpointer): PGTree{.cdecl, 
    dynlib: gliblib, importc: "g_tree_new_with_data".}
proc gTreeNewFull*(key_compare_func: TGCompareDataFunc, 
                      key_compare_data: Gpointer, 
                      key_destroy_func: TGDestroyNotify, 
                      value_destroy_func: TGDestroyNotify): PGTree{.cdecl, 
    dynlib: gliblib, importc: "g_tree_new_full".}
proc destroy*(tree: PGTree){.cdecl, dynlib: gliblib, 
                                    importc: "g_tree_destroy".}
proc insert*(tree: PGTree, key: Gpointer, value: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_tree_insert".}
proc replace*(tree: PGTree, key: Gpointer, value: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_tree_replace".}
proc remove*(tree: PGTree, key: Gconstpointer){.cdecl, dynlib: gliblib, 
    importc: "g_tree_remove".}
proc steal*(tree: PGTree, key: Gconstpointer){.cdecl, dynlib: gliblib, 
    importc: "g_tree_steal".}
proc lookup*(tree: PGTree, key: Gconstpointer): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_tree_lookup".}
proc lookupExtended*(tree: PGTree, lookup_key: Gconstpointer, 
                             orig_key: Pgpointer, value: Pgpointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_tree_lookup_extended".}
proc foreach*(tree: PGTree, func: TGTraverseFunc, user_data: Gpointer){.
    cdecl, dynlib: gliblib, importc: "g_tree_foreach".}
proc search*(tree: PGTree, search_func: TGCompareFunc, 
                    user_data: Gconstpointer): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_tree_search".}
proc height*(tree: PGTree): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_tree_height".}
proc nnodes*(tree: PGTree): Gint{.cdecl, dynlib: gliblib, 
    importc: "g_tree_nnodes".}
type 
  PGPatternSpec* = Pointer

proc gPatternSpecNew*(pattern: Cstring): PGPatternSpec{.cdecl, 
    dynlib: gliblib, importc: "g_pattern_spec_new".}
proc specFree*(pspec: PGPatternSpec){.cdecl, dynlib: gliblib, 
    importc: "g_pattern_spec_free".}
proc specEqual*(pspec1: PGPatternSpec, pspec2: PGPatternSpec): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_pattern_spec_equal".}
proc match*(pspec: PGPatternSpec, string_length: Guint, str: Cstring, 
                      string_reversed: Cstring): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_pattern_match".}
proc matchString*(pspec: PGPatternSpec, str: Cstring): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_pattern_match_string".}
proc gPatternMatchSimple*(pattern: Cstring, str: Cstring): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_pattern_match_simple".}
proc gSpacedPrimesClosest*(num: Guint): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_spaced_primes_closest".}
proc gQsort*(pbase: Gconstpointer, total_elems: Gint, size: Gsize, 
                        compare_func: TGCompareDataFunc, user_data: Gpointer){.
    cdecl, dynlib: gliblib, importc: "g_qsort_with_data".}
type 
  PGQueue* = ptr TGQueue
  TGQueue*{.final.} = object 
    head*: PGList
    tail*: PGList
    length*: Guint


proc gQueueNew*(): PGQueue{.cdecl, dynlib: gliblib, importc: "g_queue_new".}
proc free*(queue: PGQueue){.cdecl, dynlib: gliblib, 
                                    importc: "g_queue_free".}
proc pushHead*(queue: PGQueue, data: Gpointer){.cdecl, dynlib: gliblib, 
    importc: "g_queue_push_head".}
proc pushTail*(queue: PGQueue, data: Gpointer){.cdecl, dynlib: gliblib, 
    importc: "g_queue_push_tail".}
proc popHead*(queue: PGQueue): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_queue_pop_head".}
proc popTail*(queue: PGQueue): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_queue_pop_tail".}
proc isEmpty*(queue: PGQueue): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_queue_is_empty".}
proc peekHead*(queue: PGQueue): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_queue_peek_head".}
proc peekTail*(queue: PGQueue): Gpointer{.cdecl, dynlib: gliblib, 
    importc: "g_queue_peek_tail".}
proc pushHeadLink*(queue: PGQueue, link: PGList){.cdecl, 
    dynlib: gliblib, importc: "g_queue_push_head_link".}
proc pushTailLink*(queue: PGQueue, link: PGList){.cdecl, 
    dynlib: gliblib, importc: "g_queue_push_tail_link".}
proc popHeadLink*(queue: PGQueue): PGList{.cdecl, dynlib: gliblib, 
    importc: "g_queue_pop_head_link".}
proc popTailLink*(queue: PGQueue): PGList{.cdecl, dynlib: gliblib, 
    importc: "g_queue_pop_tail_link".}
type 
  PGRand* = Pointer

proc gRandNew*(seed: Guint32): PGRand{.cdecl, dynlib: gliblib, 
    importc: "g_rand_new_with_seed".}
proc gRandNew*(): PGRand{.cdecl, dynlib: gliblib, importc: "g_rand_new".}
proc free*(rand: PGRand){.cdecl, dynlib: gliblib, importc: "g_rand_free".}
proc setSeed*(rand: PGRand, seed: Guint32){.cdecl, dynlib: gliblib, 
    importc: "g_rand_set_seed".}
proc boolean*(rand: PGRand): Gboolean
proc randint*(rand: PGRand): Guint32{.cdecl, dynlib: gliblib, 
    importc: "g_rand_int".}
proc intRange*(rand: PGRand, `begin`: Gint32, `end`: Gint32): Gint32{.
    cdecl, dynlib: gliblib, importc: "g_rand_int_range".}
proc double*(rand: PGRand): Gdouble{.cdecl, dynlib: gliblib, 
    importc: "g_rand_double".}
proc doubleRange*(rand: PGRand, `begin`: Gdouble, `end`: Gdouble): Gdouble{.
    cdecl, dynlib: gliblib, importc: "g_rand_double_range".}
proc gRandomSetSeed*(seed: Guint32){.cdecl, dynlib: gliblib, 
                                        importc: "g_random_set_seed".}
proc gRandomBoolean*(): Gboolean
proc gRandomInt*(): Guint32{.cdecl, dynlib: gliblib, importc: "g_random_int".}
proc gRandomIntRange*(`begin`: Gint32, `end`: Gint32): Gint32{.cdecl, 
    dynlib: gliblib, importc: "g_random_int_range".}
proc gRandomDouble*(): Gdouble{.cdecl, dynlib: gliblib, 
                                  importc: "g_random_double".}
proc gRandomDoubleRange*(`begin`: Gdouble, `end`: Gdouble): Gdouble{.cdecl, 
    dynlib: gliblib, importc: "g_random_double_range".}
type 
  PGTuples* = ptr TGTuples
  TGTuples*{.final.} = object 
    len*: Guint

  PGRelation* = Pointer

proc gRelationNew*(fields: Gint): PGRelation{.cdecl, dynlib: gliblib, 
    importc: "g_relation_new".}
proc destroy*(relation: PGRelation){.cdecl, dynlib: gliblib, 
    importc: "g_relation_destroy".}
proc index*(relation: PGRelation, field: Gint, hash_func: TGHashFunc, 
                       key_equal_func: TGEqualFunc){.cdecl, dynlib: gliblib, 
    importc: "g_relation_index".}
proc delete*(relation: PGRelation, key: Gconstpointer, field: Gint): Gint{.
    cdecl, dynlib: gliblib, importc: "g_relation_delete".}
proc select*(relation: PGRelation, key: Gconstpointer, field: Gint): PGTuples{.
    cdecl, dynlib: gliblib, importc: "g_relation_select".}
proc count*(relation: PGRelation, key: Gconstpointer, field: Gint): Gint{.
    cdecl, dynlib: gliblib, importc: "g_relation_count".}
proc print*(relation: PGRelation){.cdecl, dynlib: gliblib, 
    importc: "g_relation_print".}
proc destroy*(tuples: PGTuples){.cdecl, dynlib: gliblib, 
    importc: "g_tuples_destroy".}
proc index*(tuples: PGTuples, index: Gint, field: Gint): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_tuples_index".}
type 
  PGTokenType* = ptr TGTokenType
  TGTokenType* = Gint

const 
  GTokenLeftParen* = 40
  GTokenRightParen* = 41
  GTokenLeftCurly* = 123
  GTokenRightCurly* = 125
  GTokenLeftBrace* = 91
  GTokenRightBrace* = 93
  GTokenEqualSign* = 61
  GTokenComma* = 44
  GTokenNone* = 256
  GTokenError* = 257
  GTokenChar* = 258
  GTokenOctal* = 260
  GTokenInt* = 261
  GTokenHex* = 262
  GTokenFloat* = 263
  GTokenString* = 264
  GTokenSymbol* = 265
  GTokenIdentifier* = 266
  GTokenIdentifierNull* = 267
  GTokenCommentSingle* = 268
  GTokenCommentMulti* = 269
  GTokenLast* = 270

type 
  PGScanner* = ptr TGScanner
  PGScannerConfig* = ptr TGScannerConfig
  PGTokenValue* = ptr TGTokenValue
  TGTokenValue*{.final.} = object 
    v_float*: Gdouble

  TGScannerMsgFunc* = proc (scanner: PGScanner, message: Cstring, 
                            error: Gboolean){.cdecl.}
  TGScanner*{.final.} = object 
    user_data*: Gpointer
    max_parse_errors*: Guint
    parse_errors*: Guint
    input_name*: Cstring
    qdata*: PGData
    config*: PGScannerConfig
    token*: TGTokenType
    value*: TGTokenValue
    line*: Guint
    position*: Guint
    next_token*: TGTokenType
    next_value*: TGTokenValue
    next_line*: Guint
    next_position*: Guint
    symbol_table*: PGHashTable
    input_fd*: Gint
    text*: Cstring
    text_end*: Cstring
    buffer*: Cstring
    scope_id*: Guint
    msg_handler*: TGScannerMsgFunc

  TGScannerConfig*{.final.} = object 
    cset_skip_characters*: Cstring
    cset_identifier_first*: Cstring
    cset_identifier_nth*: Cstring
    cpair_comment_single*: Cstring
    flag0*: Int32
    padding_dummy*: Guint


const 
  GCsetA2ZUcase* = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  GCSETA2ZLcase* = "abcdefghijklmnopqrstuvwxyz"
  GCsetDigits* = "0123456789"

const 
  bmTGScannerConfigCaseSensitive* = 0x00000001'i32
  bpTGScannerConfigCaseSensitive* = 0'i32
  bmTGScannerConfigSkipCommentMulti* = 0x00000002'i32
  bpTGScannerConfigSkipCommentMulti* = 1'i32
  bmTGScannerConfigSkipCommentSingle* = 0x00000004'i32
  bpTGScannerConfigSkipCommentSingle* = 2'i32
  bmTGScannerConfigScanCommentMulti* = 0x00000008'i32
  bpTGScannerConfigScanCommentMulti* = 3'i32
  bmTGScannerConfigScanIdentifier* = 0x00000010'i32
  bpTGScannerConfigScanIdentifier* = 4'i32
  bmTGScannerConfigScanIdentifier1char* = 0x00000020'i32
  bpTGScannerConfigScanIdentifier1char* = 5'i32
  bmTGScannerConfigScanIdentifierNULL* = 0x00000040'i32
  bpTGScannerConfigScanIdentifierNULL* = 6'i32
  bmTGScannerConfigScanSymbols* = 0x00000080'i32
  bpTGScannerConfigScanSymbols* = 7'i32
  bmTGScannerConfigScanBinary* = 0x00000100'i32
  bpTGScannerConfigScanBinary* = 8'i32
  bmTGScannerConfigScanOctal* = 0x00000200'i32
  bpTGScannerConfigScanOctal* = 9'i32
  bmTGScannerConfigScanFloat* = 0x00000400'i32
  bpTGScannerConfigScanFloat* = 10'i32
  bmTGScannerConfigScanHex* = 0x00000800'i32
  bpTGScannerConfigScanHex* = 11'i32
  bmTGScannerConfigScanHexDollar* = 0x00001000'i32
  bpTGScannerConfigScanHexDollar* = 12'i32
  bmTGScannerConfigScanStringSq* = 0x00002000'i32
  bpTGScannerConfigScanStringSq* = 13'i32
  bmTGScannerConfigScanStringDq* = 0x00004000'i32
  bpTGScannerConfigScanStringDq* = 14'i32
  bmTGScannerConfigNumbers2Int* = 0x00008000'i32
  bpTGScannerConfigNumbers2Int* = 15'i32
  bmTGScannerConfigInt2Float* = 0x00010000'i32
  bpTGScannerConfigInt2Float* = 16'i32
  bmTGScannerConfigIdentifier2String* = 0x00020000'i32
  bpTGScannerConfigIdentifier2String* = 17'i32
  bmTGScannerConfigChar2Token* = 0x00040000'i32
  bpTGScannerConfigChar2Token* = 18'i32
  bmTGScannerConfigSymbol2Token* = 0x00080000'i32
  bpTGScannerConfigSymbol2Token* = 19'i32
  bmTGScannerConfigScope0Fallback* = 0x00100000'i32
  bpTGScannerConfigScope0Fallback* = 20'i32

proc tGScannerConfigCaseSensitive*(a: PGScannerConfig): Guint
proc tGScannerConfigSetCaseSensitive*(a: PGScannerConfig, 
    `case_sensitive`: Guint)
proc tGScannerConfigSkipCommentMulti*(a: PGScannerConfig): Guint
proc tGScannerConfigSetSkipCommentMulti*(a: PGScannerConfig, 
    `skip_comment_multi`: Guint)
proc tGScannerConfigSkipCommentSingle*(a: PGScannerConfig): Guint
proc tGScannerConfigSetSkipCommentSingle*(a: PGScannerConfig, 
    `skip_comment_single`: Guint)
proc tGScannerConfigScanCommentMulti*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanCommentMulti*(a: PGScannerConfig, 
    `scan_comment_multi`: Guint)
proc tGScannerConfigScanIdentifier*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanIdentifier*(a: PGScannerConfig, 
    `scan_identifier`: Guint)
proc tGScannerConfigScanIdentifier1char*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanIdentifier1char*(a: PGScannerConfig, 
    `scan_identifier_1char`: Guint)
proc tGScannerConfigScanIdentifierNULL*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanIdentifierNULL*(a: PGScannerConfig, 
    `scan_identifier_NULL`: Guint)
proc tGScannerConfigScanSymbols*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanSymbols*(a: PGScannerConfig, 
                                       `scan_symbols`: Guint)
proc tGScannerConfigScanBinary*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanBinary*(a: PGScannerConfig, 
                                      `scan_binary`: Guint)
proc tGScannerConfigScanOctal*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanOctal*(a: PGScannerConfig, `scan_octal`: Guint)
proc tGScannerConfigScanFloat*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanFloat*(a: PGScannerConfig, `scan_float`: Guint)
proc tGScannerConfigScanHex*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanHex*(a: PGScannerConfig, `scan_hex`: Guint)
proc tGScannerConfigScanHexDollar*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanHexDollar*(a: PGScannerConfig, 
    `scan_hex_dollar`: Guint)
proc tGScannerConfigScanStringSq*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanStringSq*(a: PGScannerConfig, 
    `scan_string_sq`: Guint)
proc tGScannerConfigScanStringDq*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScanStringDq*(a: PGScannerConfig, 
    `scan_string_dq`: Guint)
proc tGScannerConfigNumbers2Int*(a: PGScannerConfig): Guint
proc tGScannerConfigSetNumbers2Int*(a: PGScannerConfig, 
                                        `numbers_2_int`: Guint)
proc tGScannerConfigInt2Float*(a: PGScannerConfig): Guint
proc tGScannerConfigSetInt2Float*(a: PGScannerConfig, 
                                      `int_2_float`: Guint)
proc tGScannerConfigIdentifier2String*(a: PGScannerConfig): Guint
proc tGScannerConfigSetIdentifier2String*(a: PGScannerConfig, 
    `identifier_2_string`: Guint)
proc tGScannerConfigChar2Token*(a: PGScannerConfig): Guint
proc tGScannerConfigSetChar2Token*(a: PGScannerConfig, 
                                       `char_2_token`: Guint)
proc tGScannerConfigSymbol2Token*(a: PGScannerConfig): Guint
proc tGScannerConfigSetSymbol2Token*(a: PGScannerConfig, 
    `symbol_2_token`: Guint)
proc tGScannerConfigScope0Fallback*(a: PGScannerConfig): Guint
proc tGScannerConfigSetScope0Fallback*(a: PGScannerConfig, 
    `scope_0_fallback`: Guint)
proc new*(config_templ: PGScannerConfig): PGScanner{.cdecl, 
    dynlib: gliblib, importc: "g_scanner_new".}
proc destroy*(scanner: PGScanner){.cdecl, dynlib: gliblib, 
    importc: "g_scanner_destroy".}
proc inputFile*(scanner: PGScanner, input_fd: Gint){.cdecl, 
    dynlib: gliblib, importc: "g_scanner_input_file".}
proc syncFileOffset*(scanner: PGScanner){.cdecl, dynlib: gliblib, 
    importc: "g_scanner_sync_file_offset".}
proc inputText*(scanner: PGScanner, text: Cstring, text_len: Guint){.
    cdecl, dynlib: gliblib, importc: "g_scanner_input_text".}
proc getNextToken*(scanner: PGScanner): TGTokenType{.cdecl, 
    dynlib: gliblib, importc: "g_scanner_get_next_token".}
proc peekNextToken*(scanner: PGScanner): TGTokenType{.cdecl, 
    dynlib: gliblib, importc: "g_scanner_peek_next_token".}
proc curToken*(scanner: PGScanner): TGTokenType{.cdecl, 
    dynlib: gliblib, importc: "g_scanner_cur_token".}
proc curValue*(scanner: PGScanner): TGTokenValue{.cdecl, 
    dynlib: gliblib, importc: "g_scanner_cur_value".}
proc curLine*(scanner: PGScanner): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_scanner_cur_line".}
proc curPosition*(scanner: PGScanner): Guint{.cdecl, dynlib: gliblib, 
    importc: "g_scanner_cur_position".}
proc eof*(scanner: PGScanner): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_scanner_eof".}
proc setScope*(scanner: PGScanner, scope_id: Guint): Guint{.cdecl, 
    dynlib: gliblib, importc: "g_scanner_set_scope".}
proc scopeAddSymbol*(scanner: PGScanner, scope_id: Guint, 
                                 symbol: Cstring, value: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_scanner_scope_add_symbol".}
proc scopeRemoveSymbol*(scanner: PGScanner, scope_id: Guint, 
                                    symbol: Cstring){.cdecl, dynlib: gliblib, 
    importc: "g_scanner_scope_remove_symbol".}
proc scopeLookupSymbol*(scanner: PGScanner, scope_id: Guint, 
                                    symbol: Cstring): Gpointer{.cdecl, 
    dynlib: gliblib, importc: "g_scanner_scope_lookup_symbol".}
proc scopeForeachSymbol*(scanner: PGScanner, scope_id: Guint, 
                                     func: TGHFunc, user_data: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_scanner_scope_foreach_symbol".}
proc lookupSymbol*(scanner: PGScanner, symbol: Cstring): Gpointer{.
    cdecl, dynlib: gliblib, importc: "g_scanner_lookup_symbol".}
proc unexpToken*(scanner: PGScanner, expected_token: TGTokenType, 
                            identifier_spec: Cstring, symbol_spec: Cstring, 
                            symbol_name: Cstring, `message`: Cstring, 
                            is_error: Gint){.cdecl, dynlib: gliblib, 
    importc: "g_scanner_unexp_token".}
proc gShellError*(): TGQuark
type 
  PGShellError* = ptr TGShellError
  TGShellError* = enum 
    G_SHELL_ERROR_BAD_QUOTING, G_SHELL_ERROR_EMPTY_STRING, G_SHELL_ERROR_FAILED

proc gShellErrorQuark*(): TGQuark{.cdecl, dynlib: gliblib, 
                                      importc: "g_shell_error_quark".}
proc gShellQuote*(unquoted_string: Cstring): Cstring{.cdecl, dynlib: gliblib, 
    importc: "g_shell_quote".}
proc gShellUnquote*(quoted_string: Cstring, error: Pointer): Cstring{.cdecl, 
    dynlib: gliblib, importc: "g_shell_unquote".}
proc gShellParseArgv*(command_line: Cstring, argcp: Pgint, argvp: PPPgchar, 
                         error: Pointer): Gboolean{.cdecl, dynlib: gliblib, 
    importc: "g_shell_parse_argv".}
proc gSpawnError*(): TGQuark
type 
  PGSpawnError* = ptr TGSpawnError
  TGSpawnError* = enum 
    G_SPAWN_ERROR_FORK, G_SPAWN_ERROR_READ, G_SPAWN_ERROR_CHDIR, 
    G_SPAWN_ERROR_ACCES, G_SPAWN_ERROR_PERM, G_SPAWN_ERROR_2BIG, 
    G_SPAWN_ERROR_NOEXEC, G_SPAWN_ERROR_NAMETOOLONG, G_SPAWN_ERROR_NOENT, 
    G_SPAWN_ERROR_NOMEM, G_SPAWN_ERROR_NOTDIR, G_SPAWN_ERROR_LOOP, 
    G_SPAWN_ERROR_TXTBUSY, G_SPAWN_ERROR_IO, G_SPAWN_ERROR_NFILE, 
    G_SPAWN_ERROR_MFILE, G_SPAWN_ERROR_INVAL, G_SPAWN_ERROR_ISDIR, 
    G_SPAWN_ERROR_LIBBAD, G_SPAWN_ERROR_FAILED
  TGSpawnChildSetupFunc* = proc (user_data: Gpointer){.cdecl.}
  PGSpawnFlags* = ptr TGSpawnFlags
  TGSpawnFlags* = Int

const 
  GSpawnLeaveDescriptorsOpen* = 1 shl 0
  GSpawnDoNotReapChild* = 1 shl 1
  GSpawnSearchPath* = 1 shl 2
  GSpawnStdoutToDevNull* = 1 shl 3
  GSpawnStderrToDevNull* = 1 shl 4
  GSpawnChildInheritsStdin* = 1 shl 5
  GSpawnFileAndArgvZero* = 1 shl 6

proc gSpawnErrorQuark*(): TGQuark{.cdecl, dynlib: gliblib, 
                                      importc: "g_spawn_error_quark".}
proc gSpawnAsync*(working_directory: Cstring, argv: PPgchar, envp: PPgchar, 
                    flags: TGSpawnFlags, child_setup: TGSpawnChildSetupFunc, 
                    user_data: Gpointer, child_pid: Pgint, error: Pointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_spawn_async".}
proc gSpawnAsync*(working_directory: Cstring, argv: PPgchar, 
                               envp: PPgchar, flags: TGSpawnFlags, 
                               child_setup: TGSpawnChildSetupFunc, 
                               user_data: Gpointer, child_pid: Pgint, 
                               standard_input: Pgint, standard_output: Pgint, 
                               standard_error: Pgint, error: Pointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_spawn_async_with_pipes".}
proc gSpawnSync*(working_directory: Cstring, argv: PPgchar, envp: PPgchar, 
                   flags: TGSpawnFlags, child_setup: TGSpawnChildSetupFunc, 
                   user_data: Gpointer, standard_output: PPgchar, 
                   standard_error: PPgchar, exit_status: Pgint, error: Pointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_spawn_sync".}
proc gSpawnCommandLineSync*(command_line: Cstring, standard_output: PPgchar, 
                                standard_error: PPgchar, exit_status: Pgint, 
                                error: Pointer): Gboolean{.cdecl, 
    dynlib: gliblib, importc: "g_spawn_command_line_sync".}
proc gSpawnCommandLineAsync*(command_line: Cstring, error: Pointer): Gboolean{.
    cdecl, dynlib: gliblib, importc: "g_spawn_command_line_async".}
proc gTypeIsBoxed*(theType: GType): Gboolean
proc holdsBoxed*(value: PGValue): Gboolean
proc gTypeClosure*(): GType
proc gTypeValue*(): GType
proc gTypeValueArray*(): GType
proc gTypeGstring*(): GType
proc gBoxedCopy*(boxed_type: GType, src_boxed: Gconstpointer): Gpointer{.
    cdecl, dynlib: gobjectlib, importc: "g_boxed_copy".}
proc gBoxedFree*(boxed_type: GType, boxed: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_boxed_free".}
proc setBoxed*(value: PGValue, v_boxed: Gconstpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_boxed".}
proc setStaticBoxed*(value: PGValue, v_boxed: Gconstpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_value_set_static_boxed".}
proc getBoxed*(value: PGValue): Gpointer{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_get_boxed".}
proc dupBoxed*(value: PGValue): Gpointer{.cdecl, dynlib: gobjectlib, 
    importc: "g_value_dup_boxed".}
proc gBoxedTypeRegisterStatic*(name: Cstring, boxed_copy: TGBoxedCopyFunc, 
                                   boxed_free: TGBoxedFreeFunc): GType{.cdecl, 
    dynlib: gobjectlib, importc: "g_boxed_type_register_static".}
proc setBoxedTakeOwnership*(value: PGValue, v_boxed: Gconstpointer){.
    cdecl, dynlib: gobjectlib, importc: "g_value_set_boxed_take_ownership".}
proc gClosureGetType*(): GType{.cdecl, dynlib: gobjectlib, 
                                   importc: "g_closure_get_type".}
proc gValueGetType*(): GType{.cdecl, dynlib: gobjectlib, 
                                 importc: "g_value_get_type".}
proc gValueArrayGetType*(): GType{.cdecl, dynlib: gobjectlib, 
                                       importc: "g_value_array_get_type".}
proc gGstringGetType*(): GType{.cdecl, dynlib: gobjectlib, 
                                   importc: "g_gstring_get_type".}
type 
  PGModule* = Pointer
  TGModuleFlags* = Int32
  TGModuleCheckInit* = proc (module: PGModule): Cstring{.cdecl.}
  TGModuleUnload* = proc (module: PGModule){.cdecl.}

const 
  GModuleBindLazy* = 1 shl 0
  GModuleBindMask* = 1

proc gModuleSupported*(): Gboolean{.cdecl, dynlib: gmodulelib, 
                                      importc: "g_module_supported".}
proc gModuleOpen*(file_name: Cstring, flags: TGModuleFlags): PGModule{.cdecl, 
    dynlib: gmodulelib, importc: "g_module_open".}
proc close*(module: PGModule): Gboolean{.cdecl, dynlib: gmodulelib, 
    importc: "g_module_close".}
proc makeResident*(module: PGModule){.cdecl, dynlib: gmodulelib, 
    importc: "g_module_make_resident".}
proc gModuleError*(): Cstring{.cdecl, dynlib: gmodulelib, 
                                 importc: "g_module_error".}
proc symbol*(module: PGModule, symbol_name: Cstring, symbol: Pgpointer): Gboolean{.
    cdecl, dynlib: gmodulelib, importc: "g_module_symbol".}
proc name*(module: PGModule): Cstring{.cdecl, dynlib: gmodulelib, 
    importc: "g_module_name".}
proc gModuleBuildPath*(directory: Cstring, module_name: Cstring): Cstring{.
    cdecl, dynlib: gmodulelib, importc: "g_module_build_path".}
proc cclosureMarshalVOIDVOID*(closure: PGClosure, return_value: PGValue, 
                                    n_param_values: Guint, 
                                    param_values: PGValue, 
                                    invocation_hint: Gpointer, 
                                    marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__VOID".}
proc cclosureMarshalVOIDBOOLEAN*(closure: PGClosure, 
                                       return_value: PGValue, 
                                       n_param_values: Guint, 
                                       param_values: PGValue, 
                                       invocation_hint: Gpointer, 
                                       marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__BOOLEAN".}
proc cclosureMarshalVOIDCHAR*(closure: PGClosure, return_value: PGValue, 
                                    n_param_values: Guint, 
                                    param_values: PGValue, 
                                    invocation_hint: Gpointer, 
                                    marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__CHAR".}
proc cclosureMarshalVOIDUCHAR*(closure: PGClosure, return_value: PGValue, 
                                     n_param_values: Guint, 
                                     param_values: PGValue, 
                                     invocation_hint: Gpointer, 
                                     marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__UCHAR".}
proc cclosureMarshalVOIDINT*(closure: PGClosure, return_value: PGValue, 
                                   n_param_values: Guint, param_values: PGValue, 
                                   invocation_hint: Gpointer, 
                                   marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__INT".}
proc cclosureMarshalVOIDUINT*(closure: PGClosure, return_value: PGValue, 
                                    n_param_values: Guint, 
                                    param_values: PGValue, 
                                    invocation_hint: Gpointer, 
                                    marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__UINT".}
proc cclosureMarshalVOIDLONG*(closure: PGClosure, return_value: PGValue, 
                                    n_param_values: Guint, 
                                    param_values: PGValue, 
                                    invocation_hint: Gpointer, 
                                    marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__LONG".}
proc cclosureMarshalVOIDULONG*(closure: PGClosure, return_value: PGValue, 
                                     n_param_values: Guint, 
                                     param_values: PGValue, 
                                     invocation_hint: Gpointer, 
                                     marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__ULONG".}
proc cclosureMarshalVOIDENUM*(closure: PGClosure, return_value: PGValue, 
                                    n_param_values: Guint, 
                                    param_values: PGValue, 
                                    invocation_hint: Gpointer, 
                                    marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__ENUM".}
proc cclosureMarshalVOIDFLAGS*(closure: PGClosure, return_value: PGValue, 
                                     n_param_values: Guint, 
                                     param_values: PGValue, 
                                     invocation_hint: Gpointer, 
                                     marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__FLAGS".}
proc cclosureMarshalVOIDFLOAT*(closure: PGClosure, return_value: PGValue, 
                                     n_param_values: Guint, 
                                     param_values: PGValue, 
                                     invocation_hint: Gpointer, 
                                     marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__FLOAT".}
proc cclosureMarshalVOIDDOUBLE*(closure: PGClosure, return_value: PGValue, 
                                      n_param_values: Guint, 
                                      param_values: PGValue, 
                                      invocation_hint: Gpointer, 
                                      marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__DOUBLE".}
proc cclosureMarshalVOIDSTRING*(closure: PGClosure, return_value: PGValue, 
                                      n_param_values: Guint, 
                                      param_values: PGValue, 
                                      invocation_hint: Gpointer, 
                                      marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__STRING".}
proc cclosureMarshalVOIDPARAM*(closure: PGClosure, return_value: PGValue, 
                                     n_param_values: Guint, 
                                     param_values: PGValue, 
                                     invocation_hint: Gpointer, 
                                     marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__PARAM".}
proc cclosureMarshalVOIDBOXED*(closure: PGClosure, return_value: PGValue, 
                                     n_param_values: Guint, 
                                     param_values: PGValue, 
                                     invocation_hint: Gpointer, 
                                     marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__BOXED".}
proc cclosureMarshalVOIDPOINTER*(closure: PGClosure, 
                                       return_value: PGValue, 
                                       n_param_values: Guint, 
                                       param_values: PGValue, 
                                       invocation_hint: Gpointer, 
                                       marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__POINTER".}
proc cclosureMarshalVOIDOBJECT*(closure: PGClosure, return_value: PGValue, 
                                      n_param_values: Guint, 
                                      param_values: PGValue, 
                                      invocation_hint: Gpointer, 
                                      marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__OBJECT".}
proc cclosureMarshalSTRINGOBJECTPOINTER*(closure: PGClosure, 
    return_value: PGValue, n_param_values: Guint, param_values: PGValue, 
    invocation_hint: Gpointer, marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_STRING__OBJECT_POINTER".}
proc cclosureMarshalVOIDUINTPOINTER*(closure: PGClosure, 
    return_value: PGValue, n_param_values: Guint, param_values: PGValue, 
    invocation_hint: Gpointer, marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_VOID__UINT_POINTER".}
proc cclosureMarshalBOOLEANFLAGS*(closure: PGClosure, 
                                        return_value: PGValue, 
                                        n_param_values: Guint, 
                                        param_values: PGValue, 
                                        invocation_hint: Gpointer, 
                                        marshal_data: Gpointer){.cdecl, 
    dynlib: gobjectlib, importc: "g_cclosure_marshal_BOOLEAN__FLAGS".}
proc cclosureMarshalBOOLFLAGS*(closure: PGClosure, return_value: PGValue, 
                                     n_param_values: Guint, 
                                     param_values: PGValue, 
                                     invocation_hint: Gpointer, 
                                     marshal_data: Gpointer){.cdecl, 
    dynlib: gliblib, importc: "g_cclosure_marshal_BOOLEAN__FLAGS".}
proc guint16SwapLeBeConstant*(val: guint16): guint16 = 
  Result = ((val and 0x00FF'i16) shl 8'i16) or
      ((val and 0xFF00'i16) shr 8'i16)

proc guint32SwapLeBeConstant*(val: guint32): guint32 = 
  Result = ((val and 0x000000FF'i32) shl 24'i32) or
      ((val and 0x0000FF00'i32) shl 8'i32) or
      ((val and 0x00FF0000'i32) shr 8'i32) or
      ((val and 0xFF000000'i32) shr 24'i32)

proc guintToPointer*(i: guint): pointer = 
  Result = cast[Pointer](TAddress(i))

when false: 
  type 
    PGArray* = pointer
  proc g_array_append_val*(a: PGArray, v: gpointer): PGArray = 
    result = g_array_append_vals(a, addr(v), 1)

  proc g_array_prepend_val*(a: PGArray, v: gpointer): PGArray = 
    result = g_array_prepend_vals(a, addr(v), 1)

  proc g_array_insert_val*(a: PGArray, i: guint, v: gpointer): PGArray = 
    result = g_array_insert_vals(a, i, addr(v), 1)

  proc g_ptr_array_index*(parray: PGPtrArray, index: guint): gpointer = 
    result = cast[PGPointer](cast[int](parray []. pdata) +
        index * SizeOf(GPointer))[] 

  proc G_THREAD_ERROR*(): TGQuark = 
    result = g_thread_error_quark()

  proc g_mutex_lock*(mutex: PGMutex) = 
    if g_threads_got_initialized: 
      g_thread_functions_for_glib_use.mutex_lock(mutex)

  proc g_mutex_trylock*(mutex: PGMutex): gboolean = 
    if g_threads_got_initialized: 
      result = g_thread_functions_for_glib_use.mutex_trylock(mutex)
    else: 
      result = true

  proc g_mutex_unlock*(mutex: PGMutex) = 
    if g_threads_got_initialized: 
      g_thread_functions_for_glib_use.mutex_unlock(mutex)

  proc g_mutex_free*(mutex: PGMutex) = 
    if g_threads_got_initialized: 
      g_thread_functions_for_glib_use.mutex_free(mutex)

  proc g_cond_wait*(cond: PGCond, mutex: PGMutex) = 
    if g_threads_got_initialized: 
      g_thread_functions_for_glib_use.cond_wait(cond, mutex)

  proc g_cond_timed_wait*(cond: PGCond, mutex: PGMutex, end_time: PGTimeVal): gboolean = 
    if g_threads_got_initialized: 
      result = g_thread_functions_for_glib_use.cond_timed_wait(cond, mutex, 
          end_time)
    else: 
      result = true

  proc g_thread_supported*(): gboolean = 
    result = g_threads_got_initialized

  proc g_mutex_new*(): PGMutex = 
    result = g_thread_functions_for_glib_use.mutex_new()

  proc g_cond_new*(): PGCond = 
    result = g_thread_functions_for_glib_use.cond_new()

  proc g_cond_signal*(cond: PGCond) = 
    if g_threads_got_initialized: 
      g_thread_functions_for_glib_use.cond_signal(cond)

  proc g_cond_broadcast*(cond: PGCond) = 
    if g_threads_got_initialized: 
      g_thread_functions_for_glib_use.cond_broadcast(cond)

  proc g_cond_free*(cond: PGCond) = 
    if g_threads_got_initialized: 
      g_thread_functions_for_glib_use.cond_free(cond)

  proc g_private_new*(dest: TGDestroyNotify): PGPrivate = 
    result = g_thread_functions_for_glib_use.private_new(dest)

  proc g_private_get*(private_key: PGPrivate): gpointer = 
    if g_threads_got_initialized: 
      result = g_thread_functions_for_glib_use.private_get(private_key)
    else: 
      result = private_key

  proc g_private_set*(private_key: var PGPrivate, data: gpointer) = 
    if g_threads_got_initialized: 
      nil
    else: 
      private_key = data

  proc g_thread_yield*() = 
    if g_threads_got_initialized: 
      g_thread_functions_for_glib_use.thread_yield

  proc g_thread_create*(func: TGThreadFunc, data: gpointer, joinable: gboolean, 
                        error: pointer): PGThread = 
    result = g_thread_create_full(func, data, 0, joinable, false, 
                                  G_THREAD_PRIORITY_NORMAL, error)

  proc g_static_mutex_get_mutex*(mutex: PPGMutex): PGMutex = 
    result = g_static_mutex_get_mutex_impl(mutex)

  proc g_static_mutex_lock*(mutex: PGStaticMutex) = 
    g_mutex_lock(g_static_mutex_get_mutex_impl(PPGMutex(mutex)))

  proc g_static_mutex_trylock*(mutex: PGStaticMutex): gboolean = 
    result = g_mutex_trylock(g_static_mutex_get_mutex(PPGMutex(mutex)))

  proc g_static_mutex_unlock*(mutex: PGStaticMutex) = 
    g_mutex_unlock(g_static_mutex_get_mutex_impl(PPGMutex(mutex)))

  proc g_main_new*(is_running: gboolean): PGMainLoop = 
    result = g_main_loop_new(nil, is_running)

  proc g_main_iteration*(may_block: gboolean): gboolean = 
    result = g_main_context_iteration(nil, may_block)

  proc g_main_pending*(): gboolean = 
    result = g_main_context_pending(nil)

  proc g_main_set_poll_func*(func: TGPollFunc) = 
    g_main_context_set_poll_func(nil, func)

proc next*(slist: PGSList): PGSList = 
  if slist != nil: 
    result = slist.next
  else: 
    result = nil

proc gNew*(bytes_per_struct, n_structs: Int): Gpointer = 
  result = gMalloc(nStructs * bytesPerStruct)

proc gNew0*(bytes_per_struct, n_structs: Int): Gpointer = 
  result = gMalloc0(nStructs * bytesPerStruct)

proc gRenew*(struct_size: Int, OldMem: Gpointer, n_structs: Int): Gpointer = 
  result = gRealloc(oldMem, structSize * nStructs)

proc gChunkNew*(chunk: Pointer): Pointer = 
  result = chunkAlloc(chunk)

proc gChunkNew0*(chunk: Pointer): Pointer = 
  result = chunkAlloc0(chunk)

proc previous*(list: PGList): PGList = 
  if list != nil: 
    result = list.prev
  else: 
    result = nil

proc next*(list: PGList): PGList = 
  if list != nil: 
    result = list.next
  else: 
    result = nil

proc gConvertError*(): TGQuark = 
  result = gConvertErrorQuark()

proc gDatalistIdSetData*(datalist: PPGData, key_id: TGQuark, data: gpointer) = 
  gDatalistIdSetDataFull(datalist, keyId, data, TGDestroyNotify(nil))

proc gDatalistIdRemoveData*(datalist: PPGData, key_id: TGQuark) = 
  gDatalistIdSetData(datalist, keyId, nil)

proc gDatalistGetData*(datalist: PPGData, key_str: cstring): PPGData = 
  result = cast[PPGData](gDatalistIdGetData(datalist, 
      gQuarkTryString(keyStr)))

proc gDatalistSetDataFull*(datalist: PPGData, key_str: cstring, 
                               data: gpointer, destroy_func: TGDestroyNotify) = 
  gDatalistIdSetDataFull(datalist, gQuarkFromString(key_str), data, 
                              destroyFunc)

proc gDatalistSetData*(datalist: PPGData, key_str: cstring, data: gpointer) = 
  gDatalistSetDataFull(datalist, keyStr, data, nil)

proc gDatalistRemoveNoNotify*(datalist: PPGData, key_str: cstring) = 
  discard gDatalistIdRemoveNoNotify(datalist, gQuarkTryString(key_str))

proc gDatalistRemoveData*(datalist: PPGData, key_str: cstring) = 
  gDatalistIdSetData(datalist, gQuarkTryString(keyStr), nil)

proc gDatasetIdSetData*(location: gconstpointer, key_id: TGQuark, 
                            data: gpointer) = 
  gDatasetIdSetDataFull(location, keyId, data, nil)

proc gDatasetIdRemoveData*(location: gconstpointer, key_id: TGQuark) = 
  gDatasetIdSetData(location, keyId, nil)

proc gDatasetGetData*(location: gconstpointer, key_str: cstring): gpointer = 
  result = gDatasetIdGetData(location, gQuarkTryString(keyStr))

proc gDatasetSetDataFull*(location: gconstpointer, key_str: cstring, 
                              data: gpointer, destroy_func: TGDestroyNotify) = 
  gDatasetIdSetDataFull(location, gQuarkFromString(key_str), data, 
                             destroyFunc)

proc gDatasetRemoveNoNotify*(location: gconstpointer, key_str: cstring) = 
  discard gDatasetIdRemoveNoNotify(location, gQuarkTryString(key_str))

proc gDatasetSetData*(location: gconstpointer, key_str: cstring, 
                         data: gpointer) = 
  gDatasetSetDataFull(location, keyStr, data, nil)

proc gDatasetRemoveData*(location: gconstpointer, key_str: cstring) = 
  gDatasetIdSetData(location, gQuarkTryString(keyStr), nil)

proc gFileError*(): TGQuark = 
  result = gFileErrorQuark()

proc tGHookListHookSize*(a: PGHookList): guint = 
  result = (a.flag0 and bm_TGHookList_hook_size) shr bp_TGHookList_hook_size

proc tGHookListSetHookSize*(a: PGHookList, `hook_size`: guint) = 
  a.flag0 = a.flag0 or
      ((`hookSize` shl bp_TGHookList_hook_size) and bm_TGHookList_hook_size)

proc tGHookListIsSetup*(a: PGHookList): guint = 
  result = (a.flag0 and bm_TGHookList_is_setup) shr bp_TGHookList_is_setup

proc tGHookListSetIsSetup*(a: PGHookList, `is_setup`: guint) = 
  a.flag0 = a.flag0 or
      ((`isSetup` shl bp_TGHookList_is_setup) and bm_TGHookList_is_setup)

proc gHook*(hook: pointer): PGHook = 
  result = cast[PGHook](hook)

proc flags*(hook: PGHook): guint = 
  result = hook.flags

proc active*(hook: PGHook): bool = 
  result = (hook.flags and G_HOOK_FLAG_ACTIVE) != 0'i32

proc inCall*(hook: PGHook): bool = 
  result = (hook.flags and G_HOOK_FLAG_IN_CALL) != 0'i32

proc isValid*(hook: PGHook): bool = 
  result = (hook.hook_id != 0) and active(hook)

proc isUnlinked*(hook: PGHook): bool = 
  result = (hook.next == nil) and (hook.prev == nil) and (hook.hook_id == 0) and
      (hook.ref_count == 0'i32)

proc append*(hook_list: PGHookList, hook: PGHook) = 
  insertBefore(hookList, nil, hook)

proc gIoChannelError*(): TGQuark = 
  result = gIoChannelErrorQuark()

proc tGIOChannelUseBuffer*(a: PGIOChannel): guint = 
  result = (a.flag0 and bm_TGIOChannel_use_buffer) shr
      bp_TGIOChannel_use_buffer

proc tGIOChannelSetUseBuffer*(a: PGIOChannel, `use_buffer`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`useBuffer` shl bp_TGIOChannel_use_buffer) and
      bm_TGIOChannel_use_buffer)

proc tGIOChannelDoEncode*(a: PGIOChannel): guint = 
  result = (a.flag0 and bm_TGIOChannel_do_encode) shr
      bp_TGIOChannel_do_encode

proc tGIOChannelSetDoEncode*(a: PGIOChannel, `do_encode`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`doEncode` shl bp_TGIOChannel_do_encode) and
      bm_TGIOChannel_do_encode)

proc tGIOChannelCloseOnUnref*(a: PGIOChannel): guint = 
  result = (a.flag0 and bm_TGIOChannel_close_on_unref) shr
      bp_TGIOChannel_close_on_unref

proc tGIOChannelSetCloseOnUnref*(a: PGIOChannel, `close_on_unref`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`closeOnUnref` shl bp_TGIOChannel_close_on_unref) and
      bm_TGIOChannel_close_on_unref)

proc tGIOChannelIsReadable*(a: PGIOChannel): guint = 
  result = (a.flag0 and bm_TGIOChannel_is_readable) shr
      bp_TGIOChannel_is_readable

proc tGIOChannelSetIsReadable*(a: PGIOChannel, `is_readable`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isReadable` shl bp_TGIOChannel_is_readable) and
      bm_TGIOChannel_is_readable)

proc tGIOChannelIsWriteable*(a: PGIOChannel): guint = 
  result = (a.flag0 and bm_TGIOChannel_is_writeable) shr
      bp_TGIOChannel_is_writeable

proc tGIOChannelSetIsWriteable*(a: PGIOChannel, `is_writeable`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isWriteable` shl bp_TGIOChannel_is_writeable) and
      bm_TGIOChannel_is_writeable)

proc tGIOChannelIsSeekable*(a: PGIOChannel): guint = 
  result = (a.flag0 and bm_TGIOChannel_is_seekable) shr
      bp_TGIOChannel_is_seekable

proc tGIOChannelSetIsSeekable*(a: PGIOChannel, `is_seekable`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isSeekable` shl bp_TGIOChannel_is_seekable) and
      bm_TGIOChannel_is_seekable)

proc utf8NextChar*(p: pguchar): pguchar = 
  result = cast[Pguchar](cast[TAddress](p) + 1) # p + ord((g_utf8_skip + p[] )[] )
  
when false: 
  proc GLIB_CHECK_VERSION*(major, minor, micro: guint): bool = 
    result = ((GLIB_MAJOR_VERSION > major) or
        ((GLIB_MAJOR_VERSION == major) and (GLIB_MINOR_VERSION > minor)) or
        ((GLIB_MAJOR_VERSION == major) and (GLIB_MINOR_VERSION == minor) and
        (GLIB_MICRO_VERSION >= micro)))

  proc g_error*(format: cstring) = 
    g_log(G_LOG_DOMAIN, G_LOG_LEVEL_ERROR, format)

  proc g_message*(format: cstring) = 
    g_log(G_LOG_DOMAIN, G_LOG_LEVEL_MESSAGE, format)

  proc g_critical*(format: cstring) = 
    g_log(G_LOG_DOMAIN, G_LOG_LEVEL_CRITICAL, format)

  proc g_warning*(format: cstring) = 
    g_log(G_LOG_DOMAIN, G_LOG_LEVEL_WARNING, format)

proc gMarkupError*(): TGQuark = 
  result = gMarkupErrorQuark()

proc isRoot*(node: PGNode): bool = 
  result = (node.parent == nil) and (node.next == nil) and (node.prev == nil)

proc isLeaf*(node: PGNode): bool = 
  result = node.children == nil

proc append*(parent: PGNode, node: PGNode): PGNode = 
  result = insertBefore(parent, nil, node)

proc insertData*(parent: PGNode, position: gint, data: gpointer): PGNode = 
  result = insert(parent, position, gNodeNew(data))

proc insertDataBefore*(parent: PGNode, sibling: PGNode, 
                         data: gpointer): PGNode = 
  result = insertBefore(parent, sibling, gNodeNew(data))

proc prependData*(parent: PGNode, data: gpointer): PGNode = 
  result = prepend(parent, gNodeNew(data))

proc appendData*(parent: PGNode, data: gpointer): PGNode = 
  result = insertBefore(parent, nil, gNodeNew(data))

proc prevSibling*(node: PGNode): PGNode = 
  if node != nil: 
    result = node.prev
  else: 
    result = nil

proc nextSibling*(node: PGNode): PGNode = 
  if node != nil: 
    result = node.next
  else: 
    result = nil

proc firstChild*(node: PGNode): PGNode = 
  if node != nil: 
    result = node.children
  else: 
    result = nil

proc boolean*(rand: PGRand): gboolean = 
  result = (Int(randint(rand)) and (1 shl 15)) != 0

proc gRandomBoolean*(): gboolean = 
  result = (Int(gRandomInt()) and (1 shl 15)) != 0

proc tGScannerConfigCaseSensitive*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_case_sensitive) shr
      bp_TGScannerConfig_case_sensitive

proc tGScannerConfigSetCaseSensitive*(a: PGScannerConfig, 
    `case_sensitive`: guint) = 
  a.flag0 = a.flag0 or
      ((`caseSensitive` shl bp_TGScannerConfig_case_sensitive) and
      bm_TGScannerConfig_case_sensitive)

proc tGScannerConfigSkipCommentMulti*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_skip_comment_multi) shr
      bp_TGScannerConfig_skip_comment_multi

proc tGScannerConfigSetSkipCommentMulti*(a: PGScannerConfig, 
    `skip_comment_multi`: guint) = 
  a.flag0 = a.flag0 or
      ((`skipCommentMulti` shl bp_TGScannerConfig_skip_comment_multi) and
      bm_TGScannerConfig_skip_comment_multi)

proc tGScannerConfigSkipCommentSingle*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_skip_comment_single) shr
      bp_TGScannerConfig_skip_comment_single

proc tGScannerConfigSetSkipCommentSingle*(a: PGScannerConfig, 
    `skip_comment_single`: guint) = 
  a.flag0 = a.flag0 or
      ((`skipCommentSingle` shl bp_TGScannerConfig_skip_comment_single) and
      bm_TGScannerConfig_skip_comment_single)

proc tGScannerConfigScanCommentMulti*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_comment_multi) shr
      bp_TGScannerConfig_scan_comment_multi

proc tGScannerConfigSetScanCommentMulti*(a: PGScannerConfig, 
    `scan_comment_multi`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanCommentMulti` shl bp_TGScannerConfig_scan_comment_multi) and
      bm_TGScannerConfig_scan_comment_multi)

proc tGScannerConfigScanIdentifier*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_identifier) shr
      bp_TGScannerConfig_scan_identifier

proc tGScannerConfigSetScanIdentifier*(a: PGScannerConfig, 
    `scan_identifier`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanIdentifier` shl bp_TGScannerConfig_scan_identifier) and
      bm_TGScannerConfig_scan_identifier)

proc tGScannerConfigScanIdentifier1char*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_identifier_1char) shr
      bp_TGScannerConfig_scan_identifier_1char

proc tGScannerConfigSetScanIdentifier1char*(a: PGScannerConfig, 
    `scan_identifier_1char`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanIdentifier1char` shl bp_TGScannerConfig_scan_identifier_1char) and
      bm_TGScannerConfig_scan_identifier_1char)

proc tGScannerConfigScanIdentifierNULL*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_identifier_NULL) shr
      bp_TGScannerConfig_scan_identifier_NULL

proc tGScannerConfigSetScanIdentifierNULL*(a: PGScannerConfig, 
    `scan_identifier_NULL`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanIdentifierNULL` shl bp_TGScannerConfig_scan_identifier_NULL) and
      bm_TGScannerConfig_scan_identifier_NULL)

proc tGScannerConfigScanSymbols*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_symbols) shr
      bp_TGScannerConfig_scan_symbols

proc tGScannerConfigSetScanSymbols*(a: PGScannerConfig, 
                                       `scan_symbols`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanSymbols` shl bp_TGScannerConfig_scan_symbols) and
      bm_TGScannerConfig_scan_symbols)

proc tGScannerConfigScanBinary*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_binary) shr
      bp_TGScannerConfig_scan_binary

proc tGScannerConfigSetScanBinary*(a: PGScannerConfig, 
                                      `scan_binary`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanBinary` shl bp_TGScannerConfig_scan_binary) and
      bm_TGScannerConfig_scan_binary)

proc tGScannerConfigScanOctal*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_octal) shr
      bp_TGScannerConfig_scan_octal

proc tGScannerConfigSetScanOctal*(a: PGScannerConfig, `scan_octal`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanOctal` shl bp_TGScannerConfig_scan_octal) and
      bm_TGScannerConfig_scan_octal)

proc tGScannerConfigScanFloat*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_float) shr
      bp_TGScannerConfig_scan_float

proc tGScannerConfigSetScanFloat*(a: PGScannerConfig, `scan_float`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanFloat` shl bp_TGScannerConfig_scan_float) and
      bm_TGScannerConfig_scan_float)

proc tGScannerConfigScanHex*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_hex) shr
      bp_TGScannerConfig_scan_hex

proc tGScannerConfigSetScanHex*(a: PGScannerConfig, `scan_hex`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanHex` shl bp_TGScannerConfig_scan_hex) and
      bm_TGScannerConfig_scan_hex)

proc tGScannerConfigScanHexDollar*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_hex_dollar) shr
      bp_TGScannerConfig_scan_hex_dollar

proc tGScannerConfigSetScanHexDollar*(a: PGScannerConfig, 
    `scan_hex_dollar`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanHexDollar` shl bp_TGScannerConfig_scan_hex_dollar) and
      bm_TGScannerConfig_scan_hex_dollar)

proc tGScannerConfigScanStringSq*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_string_sq) shr
      bp_TGScannerConfig_scan_string_sq

proc tGScannerConfigSetScanStringSq*(a: PGScannerConfig, 
    `scan_string_sq`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanStringSq` shl bp_TGScannerConfig_scan_string_sq) and
      bm_TGScannerConfig_scan_string_sq)

proc tGScannerConfigScanStringDq*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scan_string_dq) shr
      bp_TGScannerConfig_scan_string_dq

proc tGScannerConfigSetScanStringDq*(a: PGScannerConfig, 
    `scan_string_dq`: guint) = 
  a.flag0 = a.flag0 or
      ((`scanStringDq` shl bp_TGScannerConfig_scan_string_dq) and
      bm_TGScannerConfig_scan_string_dq)

proc tGScannerConfigNumbers2Int*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_numbers_2_int) shr
      bp_TGScannerConfig_numbers_2_int

proc tGScannerConfigSetNumbers2Int*(a: PGScannerConfig, 
                                        `numbers_2_int`: guint) = 
  a.flag0 = a.flag0 or
      ((`numbers2Int` shl bp_TGScannerConfig_numbers_2_int) and
      bm_TGScannerConfig_numbers_2_int)

proc tGScannerConfigInt2Float*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_int_2_float) shr
      bp_TGScannerConfig_int_2_float

proc tGScannerConfigSetInt2Float*(a: PGScannerConfig, 
                                      `int_2_float`: guint) = 
  a.flag0 = a.flag0 or
      ((`int2Float` shl bp_TGScannerConfig_int_2_float) and
      bm_TGScannerConfig_int_2_float)

proc tGScannerConfigIdentifier2String*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_identifier_2_string) shr
      bp_TGScannerConfig_identifier_2_string

proc tGScannerConfigSetIdentifier2String*(a: PGScannerConfig, 
    `identifier_2_string`: guint) = 
  a.flag0 = a.flag0 or
      ((`identifier2String` shl bp_TGScannerConfig_identifier_2_string) and
      bm_TGScannerConfig_identifier_2_string)

proc tGScannerConfigChar2Token*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_char_2_token) shr
      bp_TGScannerConfig_char_2_token

proc tGScannerConfigSetChar2Token*(a: PGScannerConfig, 
                                       `char_2_token`: guint) = 
  a.flag0 = a.flag0 or
      ((`char2Token` shl bp_TGScannerConfig_char_2_token) and
      bm_TGScannerConfig_char_2_token)

proc tGScannerConfigSymbol2Token*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_symbol_2_token) shr
      bp_TGScannerConfig_symbol_2_token

proc tGScannerConfigSetSymbol2Token*(a: PGScannerConfig, 
    `symbol_2_token`: guint) = 
  a.flag0 = a.flag0 or
      ((`symbol2Token` shl bp_TGScannerConfig_symbol_2_token) and
      bm_TGScannerConfig_symbol_2_token)

proc tGScannerConfigScope0Fallback*(a: PGScannerConfig): guint = 
  result = (a.flag0 and bm_TGScannerConfig_scope_0_fallback) shr
      bp_TGScannerConfig_scope_0_fallback

proc tGScannerConfigSetScope0Fallback*(a: PGScannerConfig, 
    `scope_0_fallback`: guint) = 
  a.flag0 = a.flag0 or
      ((`scope0Fallback` shl bp_TGScannerConfig_scope_0_fallback) and
      bm_TGScannerConfig_scope_0_fallback)

proc freezeSymbolTable*(scanner: PGScanner) = 
  if scanner == nil: nil
  
proc thawSymbolTable*(scanner: PGScanner) = 
  if scanner == nil: nil
  
proc gShellError*(): TGQuark = 
  result = gShellErrorQuark()

proc gSpawnError*(): TGQuark = 
  result = gSpawnErrorQuark()

when false: 
  proc g_ascii_isalnum*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_ALNUM) != 0

  proc g_ascii_isalpha*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_ALPHA) != 0

  proc g_ascii_iscntrl*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_CNTRL) != 0

  proc g_ascii_isdigit*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_DIGIT) != 0

  proc g_ascii_isgraph*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_GRAPH) != 0

  proc g_ascii_islower*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_LOWER) != 0

  proc g_ascii_isprint*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_PRINT) != 0

  proc g_ascii_ispunct*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_PUNCT) != 0

  proc g_ascii_isspace*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_SPACE) != 0

  proc g_ascii_isupper*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_UPPER) != 0

  proc g_ascii_isxdigit*(c: gchar): bool = 
    result = ((g_ascii_table[guchar(c)]) and G_ASCII_XDIGIT) != 0

  proc g_strstrip*(str: cstring): cstring = 
    result = g_strchomp(g_strchug(str))

proc gTypeMakeFundamental*(x: int): GType = 
  result = GType(x shl G_TYPE_FUNDAMENTAL_SHIFT)

proc gTypeIsFundamental*(theType: GType): bool = 
  result = theType <= G_TYPE_FUNDAMENTAL_MAX

proc gTypeIsDerived*(theType: GType): bool = 
  result = theType > G_TYPE_FUNDAMENTAL_MAX

proc gTypeIsInterface*(theType: GType): bool = 
  result = (gTypeFundamental(theType)) == G_TYPE_INTERFACE

proc gTypeIsClassed*(theType: GType): gboolean = 
  result = privateGTypeTestFlags(theType, G_TYPE_FLAG_CLASSED)

proc gTypeIsInstantiatable*(theType: GType): bool = 
  result = privateGTypeTestFlags(theType, G_TYPE_FLAG_INSTANTIATABLE)

proc gTypeIsDerivable*(theType: GType): bool = 
  result = privateGTypeTestFlags(theType, G_TYPE_FLAG_DERIVABLE)

proc gTypeIsDeepDerivable*(theType: GType): bool = 
  result = privateGTypeTestFlags(theType, G_TYPE_FLAG_DEEP_DERIVABLE)

proc gTypeIsAbstract*(theType: GType): bool = 
  result = privateGTypeTestFlags(theType, G_TYPE_FLAG_ABSTRACT)

proc gTypeIsValueAbstract*(theType: GType): bool = 
  result = privateGTypeTestFlags(theType, G_TYPE_FLAG_VALUE_ABSTRACT)

proc gTypeIsValueType*(theType: GType): bool = 
  result = privateGTypeCheckIsValueType(theType)

proc gTypeHasValueTable*(theType: GType): bool = 
  result = (gTypeValueTablePeek(theType)) != nil

proc gTypeCheckInstance*(instance: Pointer): gboolean = 
  result = privateGTypeCheckInstance(cast[PGTypeInstance](instance))

proc gTypeCheckInstanceCast*(instance: Pointer, g_type: GType): PGTypeInstance = 
  result = cast[PGTypeInstance](privateGTypeCheckInstanceCast(
      cast[PGTypeInstance](instance), gType))

proc gTypeCheckInstanceType*(instance: Pointer, g_type: GType): bool = 
  result = privateGTypeCheckInstanceIsA(cast[PGTypeInstance](instance), 
      gType)

proc gTypeInstanceGetClass*(instance: Pointer, g_type: GType): PGTypeClass = 
  result = cast[PGTypeInstance](instance).g_class
  result = privateGTypeCheckClassCast(result, gType)

proc gTypeInstanceGetInterface*(instance: Pointer, g_type: GType): Pointer = 
  result = gTypeInterfacePeek((cast[PGTypeInstance](instance)).g_class, 
                                 gType)

proc gTypeCheckClassCast*(g_class: pointer, g_type: GType): Pointer = 
  result = privateGTypeCheckClassCast(cast[PGTypeClass](gClass), gType)

proc gTypeCheckClassType*(g_class: pointer, g_type: GType): bool = 
  result = privateGTypeCheckClassIsA(cast[PGTypeClass](gClass), g_type)

proc gTypeCheckValue*(value: Pointer): bool = 
  result = privateGTypeCheckValue(cast[PGValue](value))

proc gTypeCheckValueType*(value: pointer, g_type: GType): bool = 
  result = privateGTypeCheckValueHolds(cast[PGValue](value), gType)

proc gTypeFromInstance*(instance: Pointer): GType = 
  result = gTypeFromClass((cast[PGTypeInstance](instance)).g_class)

proc gTypeFromClass*(g_class: Pointer): GType = 
  result = (cast[PGTypeClass](gClass)).g_type

proc gTypeFromInterface*(g_iface: Pointer): GType = 
  result = (cast[PGTypeInterface](gIface)).g_type

proc gTypeIsValue*(theType: GType): bool = 
  result = privateGTypeCheckIsValueType(theType)

proc gIsValue*(value: Pointer): bool = 
  result = gTypeCheckValue(value)

proc gValueType*(value: Pointer): GType = 
  result = (cast[PGValue](value)).g_type

proc gValueTypeName*(value: Pointer): cstring = 
  result = gTypeName(gValueType(value))

proc gValueHolds*(value: pointer, g_type: GType): bool = 
  result = gTypeCheckValueType(value, gType)

proc gTypeIsParam*(theType: GType): bool = 
  result = (gTypeFundamental(theType)) == G_TYPE_PARAM

proc gParamSpec*(pspec: Pointer): PGParamSpec = 
  result = cast[PGParamSpec](gTypeCheckInstanceCast(pspec, G_TYPE_PARAM))

proc gIsParamSpec*(pspec: Pointer): bool = 
  result = gTypeCheckInstanceType(pspec, G_TYPE_PARAM)

proc gParamSpecClass*(pclass: Pointer): PGParamSpecClass = 
  result = cast[PGParamSpecClass](gTypeCheckClassCast(pclass, G_TYPE_PARAM))

proc gIsParamSpecClass*(pclass: Pointer): bool = 
  result = gTypeCheckClassType(pclass, G_TYPE_PARAM)

proc gParamSpecGetClass*(pspec: Pointer): PGParamSpecClass = 
  result = cast[PGParamSpecClass](gTypeInstanceGetClass(pspec, G_TYPE_PARAM))

proc gParamSpecType*(pspec: Pointer): GType = 
  result = gTypeFromInstance(pspec)

proc gParamSpecTypeName*(pspec: Pointer): cstring = 
  result = gTypeName(gParamSpecType(pspec))

proc gParamSpecValueType*(pspec: Pointer): GType = 
  result = (gParamSpec(pspec)).value_type

proc gValueHoldsParam*(value: Pointer): bool = 
  result = gTypeCheckValueType(value, G_TYPE_PARAM)

proc gClosureNeedsMarshal*(closure: Pointer): bool = 
  result = cast[PGClosure](closure).marshal == nil

proc nNotifiers*(cl: PGClosure): int32 = 
  result = ((metaMarshal(cl) + ((nGuards(cl)) shl 1'i32)) +
      (nFnotifiers(cl))) + (nInotifiers(cl))

proc cclosureSwapData*(cclosure: PGClosure): int32 = 
  result = derivativeFlag(cclosure)

proc gCallback*(f: pointer): TGCallback = 
  result = cast[TGCallback](f)

proc refCount*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_ref_count) shr bp_TGClosure_ref_count

proc setRefCount*(a: PGClosure, `ref_count`: guint) = 
  a.flag0 = a.flag0 or
      ((`refCount` shl bp_TGClosure_ref_count) and bm_TGClosure_ref_count)

proc metaMarshal*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_meta_marshal) shr
      bp_TGClosure_meta_marshal

proc setMetaMarshal*(a: PGClosure, `meta_marshal`: guint) = 
  a.flag0 = a.flag0 or
      ((`metaMarshal` shl bp_TGClosure_meta_marshal) and
      bm_TGClosure_meta_marshal)

proc nGuards*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_n_guards) shr bp_TGClosure_n_guards

proc setNGuards*(a: PGClosure, `n_guards`: guint) = 
  a.flag0 = a.flag0 or
      ((`nGuards` shl bp_TGClosure_n_guards) and bm_TGClosure_n_guards)

proc nFnotifiers*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_n_fnotifiers) shr
      bp_TGClosure_n_fnotifiers

proc setNFnotifiers*(a: PGClosure, `n_fnotifiers`: guint) = 
  a.flag0 = a.flag0 or
      ((`nFnotifiers` shl bp_TGClosure_n_fnotifiers) and
      bm_TGClosure_n_fnotifiers)

proc nInotifiers*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_n_inotifiers) shr
      bp_TGClosure_n_inotifiers

proc setNInotifiers*(a: PGClosure, `n_inotifiers`: Guint) = 
  a.flag0 = a.flag0 or
      ((`nInotifiers` shl bp_TGClosure_n_inotifiers) and
      bm_TGClosure_n_inotifiers)

proc inInotify*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_in_inotify) shr bp_TGClosure_in_inotify

proc setInInotify*(a: PGClosure, `in_inotify`: guint) = 
  a.flag0 = a.flag0 or
      ((`inInotify` shl bp_TGClosure_in_inotify) and bm_TGClosure_in_inotify)

proc floating*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_floating) shr bp_TGClosure_floating

proc setFloating*(a: PGClosure, `floating`: guint) = 
  a.flag0 = a.flag0 or
      ((`floating` shl bp_TGClosure_floating) and bm_TGClosure_floating)

proc derivativeFlag*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_derivative_flag) shr
      bp_TGClosure_derivative_flag

proc setDerivativeFlag*(a: PGClosure, `derivative_flag`: guint) = 
  a.flag0 = a.flag0 or
      ((`derivativeFlag` shl bp_TGClosure_derivative_flag) and
      bm_TGClosure_derivative_flag)

proc inMarshal*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_in_marshal) shr bp_TGClosure_in_marshal

proc setInMarshal*(a: PGClosure, in_marshal: guint) = 
  a.flag0 = a.flag0 or
      ((inMarshal shl bp_TGClosure_in_marshal) and bm_TGClosure_in_marshal)

proc isInvalid*(a: PGClosure): guint = 
  result = (a.flag0 and bm_TGClosure_is_invalid) shr bp_TGClosure_is_invalid

proc setIsInvalid*(a: PGClosure, is_invalid: guint) = 
  a.flag0 = a.flag0 or
      ((isInvalid shl bp_TGClosure_is_invalid) and bm_TGClosure_is_invalid)

proc gSignalConnect*(instance: gpointer, detailed_signal: cstring, 
                       c_handler: TGCallback, data: gpointer): gulong = 
  result = gSignalConnectData(instance, detailedSignal, cHandler, data, 
                                 nil, TGConnectFlags(0))

proc gSignalConnectAfter*(instance: gpointer, detailed_signal: cstring, 
                             c_handler: TGCallback, data: gpointer): gulong = 
  result = gSignalConnectData(instance, detailedSignal, cHandler, data, 
                                 nil, G_CONNECT_AFTER)

proc gSignalConnectSwapped*(instance: gpointer, detailed_signal: cstring, 
                               c_handler: TGCallback, data: gpointer): gulong = 
  result = gSignalConnectData(instance, detailedSignal, cHandler, data, 
                                 nil, G_CONNECT_SWAPPED)

proc gSignalHandlersDisconnectByFunc*(instance: gpointer, 
    func, data: gpointer): guint = 
  result = gSignalHandlersDisconnectMatched(instance, 
      TGSignalMatchType(G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 0, 0, nil, 
      func, data)

proc gSignalHandlersBlockByFunc*(instance: gpointer, func, data: gpointer) = 
  discard gSignalHandlersBlockMatched(instance, 
      TGSignalMatchType(G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 0, 0, nil, 
      func, data)

proc gSignalHandlersUnblockByFunc*(instance: gpointer, func, data: gpointer) = 
  discard gSignalHandlersUnblockMatched(instance, 
      TGSignalMatchType(G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 0, 0, nil, 
      func, data)

proc gTypeIsObject*(theType: GType): bool = 
  result = (gTypeFundamental(theType)) == G_TYPE_OBJECT

proc gObject*(anObject: pointer): PGObject = 
  result = cast[PGObject](gTypeCheckInstanceCast(anObject, G_TYPE_OBJECT))

proc gObjectClass*(class: Pointer): PGObjectClass = 
  result = cast[PGObjectClass](gTypeCheckClassCast(class, G_TYPE_OBJECT))

proc gIsObject*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, G_TYPE_OBJECT)

proc gIsObjectClass*(class: Pointer): bool = 
  result = gTypeCheckClassType(class, G_TYPE_OBJECT)

proc gObjectGetClass*(anObject: pointer): PGObjectClass = 
  result = cast[PGObjectClass](gTypeInstanceGetClass(anObject, G_TYPE_OBJECT))

proc gObjectType*(anObject: pointer): GType = 
  result = gTypeFromInstance(anObject)

proc gObjectTypeName*(anObject: pointer): cstring = 
  result = gTypeName(gObjectType(anObject))

proc gObjectClassType*(class: Pointer): GType = 
  result = gTypeFromClass(class)

proc gObjectClassName*(class: Pointer): cstring = 
  result = gTypeName(gObjectClassType(class))

proc gValueHoldsObject*(value: Pointer): bool = 
  result = gTypeCheckValueType(value, G_TYPE_OBJECT)

proc gObjectWarnInvalidPropertyId*(anObject: gpointer, property_id: gint, 
                                        pspec: gpointer) = 
  gObjectWarnInvalidPspec(anObject, "property", propertyId, pspec)

proc gObjectWarnInvalidPspec*(anObject: gpointer, pname: cstring, 
                                  property_id: gint, pspec: gpointer) = 
  var 
    theObject: PGObject
    pspec2: PGParamSpec
    propertyId: Guint
  theObject = cast[PGObject](anObject)
  pspec2 = cast[PGParamSpec](pspec)
  propertyId = (propertyId)
  write(stdout, "invalid thingy\x0A")
  #g_warning("%s: invalid %s id %u for \"%s\" of type `%s\' in `%s\'", "", pname,
  #          `property_id`, `pspec` . name,
  #          g_type_name(G_PARAM_SPEC_TYPE(`pspec`)),
  #          G_OBJECT_TYPE_NAME(theobject))
  
proc gTypeTypePlugin*(): GType = 
  result = gTypePluginGetType()

proc gTypePlugin*(inst: Pointer): PGTypePlugin = 
  result = PGTypePlugin(gTypeCheckInstanceCast(inst, gTypeTypePlugin()))

proc gTypePluginClass*(vtable: Pointer): PGTypePluginClass = 
  result = cast[PGTypePluginClass](gTypeCheckClassCast(vtable, 
      gTypeTypePlugin()))

proc gIsTypePlugin*(inst: Pointer): bool = 
  result = gTypeCheckInstanceType(inst, gTypeTypePlugin())

proc gIsTypePluginClass*(vtable: Pointer): bool = 
  result = gTypeCheckClassType(vtable, gTypeTypePlugin())

proc gTypePluginGetClass*(inst: Pointer): PGTypePluginClass = 
  result = cast[PGTypePluginClass](gTypeInstanceGetInterface(inst, 
      gTypeTypePlugin()))

proc gTypeIsEnum*(theType: GType): gboolean = 
  result = (gTypeFundamental(theType) == G_TYPE_ENUM)

proc gEnumClass*(class: pointer): PGEnumClass = 
  result = cast[PGEnumClass](gTypeCheckClassCast(class, G_TYPE_ENUM))

proc gIsEnumClass*(class: pointer): gboolean = 
  result = gTypeCheckClassType(class, G_TYPE_ENUM)

proc gEnumClassType*(class: pointer): GType = 
  result = gTypeFromClass(class)

proc gEnumClassTypeName*(class: pointer): cstring = 
  result = gTypeName(gEnumClassType(class))

proc gTypeIsFlags*(theType: GType): gboolean = 
  result = (gTypeFundamental(theType)) == G_TYPE_FLAGS

proc gFlagsClass*(class: pointer): PGFlagsClass = 
  result = cast[PGFlagsClass](gTypeCheckClassCast(class, G_TYPE_FLAGS))

proc gIsFlagsClass*(class: pointer): gboolean = 
  result = gTypeCheckClassType(class, G_TYPE_FLAGS)

proc gFlagsClassType*(class: pointer): GType = 
  result = gTypeFromClass(class)

proc gFlagsClassTypeName*(class: pointer): cstring = 
  result = gTypeName(GFlagsType(cast[TAddress](class)))

proc gValueHoldsEnum*(value: pointer): gboolean = 
  result = gTypeCheckValueType(value, G_TYPE_ENUM)

proc gValueHoldsFlags*(value: pointer): gboolean = 
  result = gTypeCheckValueType(value, G_TYPE_FLAGS)

proc clamp*(x, MinX, MaxX: Int): Int = 
  if x < minX: 
    result = minX
  elif x > maxX: 
    result = maxX
  else: 
    result = x

proc gpointerToSize*(p: Gpointer): Gsize = 
  result = Gsize(cast[TAddress](p))

proc gsizeToPointer*(s: Gsize): Gpointer = 
  result = cast[Gpointer](s)

proc holdsChar*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_CHAR)

proc holdsUchar*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_UCHAR)

proc holdsBoolean*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_BOOLEAN)

proc holdsInt*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_INT)

proc holdsUint*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_UINT)

proc holdsLong*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_LONG)

proc holdsUlong*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_ULONG)

proc holdsInt64*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_INT64)

proc holdsUint64*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_UINT64)

proc holdsFloat*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_FLOAT)

proc holdsDouble*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_DOUBLE)

proc holdsString*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_STRING)

proc holdsPointer*(value: PGValue): bool = 
  result = gTypeCheckValueType(value, G_TYPE_POINTER)

proc gTypeIsBoxed*(theType: GType): gboolean = 
  result = (gTypeFundamental(theType)) == G_TYPE_BOXED

proc holdsBoxed*(value: PGValue): gboolean = 
  result = gTypeCheckValueType(value, G_TYPE_BOXED)

proc gTypeClosure*(): GType = 
  result = gClosureGetType()

proc gTypeValue*(): GType = 
  result = gValueGetType()

proc gTypeValueArray*(): GType = 
  result = gValueArrayGetType()

proc gTypeGstring*(): GType = 
  result = gGstringGetType()
  
proc gThreadInit*(vtable: Pointer) {.
  cdecl, dynlib: gobjectlib, importc: "g_thread_init".}

proc gTimeoutAdd*(interval: Guint, function, data: Gpointer): Guint {.
  cdecl, dynlib: gliblib, importc: "g_timeout_add".}

proc gTimeoutAddFull*(priority: Guint, interval: Guint, function,
  data, notify: Gpointer): Guint {.cdecl, dynlib: gliblib, 
  importc: "g_timeout_add_full".}

proc gIdleAdd*(function, data: Gpointer): Guint {.
  cdecl, dynlib: gliblib, importc: "g_idle_add".}

proc gIdleAddFull*(priority: Guint, function,
  data, notify: Gpointer): Guint {.cdecl, dynlib: gliblib, 
  importc: "g_idle_add_full".}

proc gSourceRemove*(tag: Guint): Gboolean {.
  cdecl, dynlib: gliblib, importc: "g_source_remove".}

proc g_signal_emit_by_name*(instance: Gpointer, detailed_signal: Cstring) {.
  cdecl, varargs, dynlib: gobjectlib, importc.}
