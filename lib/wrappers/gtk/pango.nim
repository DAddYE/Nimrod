{.deadCodeElim: on.}
import 
  glib2

when defined(win32): 
  const 
    lib* = "libpango-1.0-0.dll"
elif defined(macosx): 
  const 
    lib* = "libpango-1.0.dylib"
else: 
  const 
    lib* = "libpango-1.0.so.0"
type 
  TFont* {.pure, final.} = object
  PFont* = ptr TFont
  TFontFamily* {.pure, final.} = object
  PFontFamily* = ptr TFontFamily
  TFontSet* {.pure, final.} = object
  PFontset* = ptr TFontset
  TFontMetrics* {.pure, final.} = object
  PFontMetrics* = ptr TFontMetrics
  TFontFace* {.pure, final.} = object
  PFontFace* = ptr TFontFace
  TFontMap* {.pure, final.} = object
  PFontMap* = ptr TFontMap
  TFontsetClass {.pure, final.} = object
  PFontsetClass* = ptr TFontSetClass
  TFontFamilyClass* {.pure, final.} = object
  PFontFamilyClass* = ptr TFontFamilyClass
  TFontFaceClass* {.pure, final.} = object
  PFontFaceClass* = ptr TFontFaceClass
  TFontClass* {.pure, final.} = object
  PFontClass* = ptr TFontClass
  TFontMapClass* {.pure, final.} = object
  PFontMapClass* = ptr TFontMapClass
  PFontDescription* = ptr TFontDescription
  TFontDescription* {.pure, final.} = object
  PAttrList* = ptr TAttrList
  TAttrList* {.pure, final.} = object
  PAttrIterator* = ptr TAttrIterator
  TAttrIterator* {.pure, final.} = object
  PLayout* = ptr TLayout
  TLayout* {.pure, final.} = object
  PLayoutClass* = ptr TLayoutClass
  TLayoutClass* {.pure, final.} = object
  PLayoutIter* = ptr TLayoutIter
  TLayoutIter* {.pure, final.} = object
  PContext* = ptr TContext
  TContext* {.pure, final.} = object
  PContextClass* = ptr TContextClass
  TContextClass* {.pure, final.} = object
  PFontsetSimple* = ptr TFontsetSimple
  TFontsetSimple* {.pure, final.} = object
  PTabArray* = ptr TTabArray
  TTabArray* {.pure, final.} = object
  PGlyphString* = ptr TGlyphString
  PAnalysis* = ptr TAnalysis
  PItem* = ptr TItem
  PLanguage* = ptr TLanguage
  TLanguage* {.pure, final.} = object
  PGlyph* = ptr TGlyph
  TGlyph* = Guint32
  PRectangle* = ptr TRectangle
  TRectangle*{.final, pure.} = object 
    x*: Int32
    y*: Int32
    width*: Int32
    height*: Int32

  PDirection* = ptr TDirection
  TDirection* = enum 
    DIRECTION_LTR, DIRECTION_RTL, DIRECTION_TTB_LTR, DIRECTION_TTB_RTL
  PColor* = ptr TColor
  TColor*{.final, pure.} = object 
    red*: Guint16
    green*: Guint16
    blue*: Guint16

  PAttrType* = ptr TAttrType
  TAttrType* = Int32
  PUnderline* = ptr TUnderline
  TUnderline* = Int32
  PAttribute* = ptr TAttribute
  PAttrClass* = ptr TAttrClass
  TAttribute*{.final, pure.} = object 
    klass*: PAttrClass
    start_index*: Int
    end_index*: Int

  TAttrClass*{.final, pure.} = object 
    `type`*: TAttrType
    copy*: proc (attr: PAttribute): PAttribute{.cdecl.}
    destroy*: proc (attr: PAttribute){.cdecl.}
    equal*: proc (attr1: PAttribute, attr2: PAttribute): Gboolean{.cdecl.}

  PAttrString* = ptr TAttrString
  TAttrString*{.final, pure.} = object 
    attr*: TAttribute
    value*: Cstring

  PAttrLanguage* = ptr TAttrLanguage
  TAttrLanguage*{.final, pure.} = object 
    attr*: TAttribute
    value*: PLanguage

  PAttrInt* = ptr TAttrInt
  TAttrInt*{.final, pure.} = object 
    attr*: TAttribute
    value*: Int32

  PAttrFloat* = ptr TAttrFloat
  TAttrFloat*{.final, pure.} = object 
    attr*: TAttribute
    value*: Gdouble

  PAttrColor* = ptr TAttrColor
  TAttrColor*{.final, pure.} = object 
    attr*: TAttribute
    color*: TColor

  PAttrShape* = ptr TAttrShape
  TAttrShape*{.final, pure.} = object 
    attr*: TAttribute
    ink_rect*: TRectangle
    logical_rect*: TRectangle

  PAttrFontDesc* = ptr TAttrFontDesc
  TAttrFontDesc*{.final, pure.} = object 
    attr*: TAttribute
    desc*: PFontDescription

  PLogAttr* = ptr TLogAttr
  TLogAttr*{.final, pure.} = object 
    flag0*: Guint16

  PCoverageLevel* = ptr TCoverageLevel
  TCoverageLevel* = enum 
    COVERAGE_NONE, COVERAGE_FALLBACK, COVERAGE_APPROXIMATE, COVERAGE_EXACT
  PBlockInfo* = ptr TBlockInfo
  TBlockInfo*{.final, pure.} = object 
    data*: Pguchar
    level*: TCoverageLevel

  PCoverage* = ptr TCoverage
  TCoverage*{.final, pure.} = object 
    ref_count*: Int
    n_blocks*: Int32
    data_size*: Int32
    blocks*: PBlockInfo

  PEngineRange* = ptr TEngineRange
  TEngineRange*{.final, pure.} = object 
    start*: Int32
    theEnd*: Int32
    langs*: Cstring

  PEngineInfo* = ptr TEngineInfo
  TEngineInfo*{.final, pure.} = object 
    id*: Cstring
    engine_type*: Cstring
    render_type*: Cstring
    ranges*: PEngineRange
    n_ranges*: Gint

  PEngine* = ptr TEngine
  TEngine*{.final, pure.} = object 
    id*: Cstring
    `type`*: Cstring
    length*: Gint

  TEngineLangScriptBreak* = proc (text: Cstring, len: Int32, 
                                  analysis: PAnalysis, attrs: PLogAttr, 
                                  attrs_len: Int32){.cdecl.}
  PEngineLang* = ptr TEngineLang
  TEngineLang*{.final, pure.} = object 
    engine*: TEngine
    script_break*: TEngineLangScriptBreak

  TEngineShapeScript* = proc (font: PFont, text: Cstring, length: Int32, 
                              analysis: PAnalysis, glyphs: PGlyphString){.cdecl.}
  TEngineShapeGetCoverage* = proc (font: PFont, language: PLanguage): PCoverage{.
      cdecl.}
  PEngineShape* = ptr TEngineShape
  TEngineShape*{.final, pure.} = object 
    engine*: TEngine
    script_shape*: TEngineShapeScript
    get_coverage*: TEngineShapeGetCoverage

  PStyle* = ptr TStyle
  TStyle* = Gint
  PVariant* = ptr TVariant
  TVariant* = Gint
  PWeight* = ptr TWeight
  TWeight* = Gint
  PStretch* = ptr TStretch
  TStretch* = Gint
  PFontMask* = ptr TFontMask
  TFontMask* = Int32
  PGlyphUnit* = ptr TGlyphUnit
  TGlyphUnit* = Gint32
  PGlyphGeometry* = ptr TGlyphGeometry
  TGlyphGeometry*{.final, pure.} = object 
    width*: TGlyphUnit
    x_offset*: TGlyphUnit
    y_offset*: TGlyphUnit

  PGlyphVisAttr* = ptr TGlyphVisAttr
  TGlyphVisAttr*{.final, pure.} = object 
    flag0*: Int16

  PGlyphInfo* = ptr TGlyphInfo
  TGlyphInfo*{.final, pure.} = object 
    glyph*: TGlyph
    geometry*: TGlyphGeometry
    attr*: TGlyphVisAttr

  TGlyphString*{.final, pure.} = object 
    num_glyphs*: Gint
    glyphs*: PGlyphInfo
    log_clusters*: Pgint
    space*: Gint

  TAnalysis*{.final, pure.} = object 
    shape_engine*: PEngineShape
    lang_engine*: PEngineLang
    font*: PFont
    level*: Guint8
    language*: PLanguage
    extra_attrs*: PGSList

  TItem*{.final, pure.} = object 
    offset*: Gint
    length*: Gint
    num_chars*: Gint
    analysis*: TAnalysis

  PAlignment* = ptr TAlignment
  TAlignment* = enum 
    ALIGN_LEFT, ALIGN_CENTER, ALIGN_RIGHT
  PWrapMode* = ptr TWrapMode
  TWrapMode* = enum 
    WRAP_WORD, WRAP_CHAR
  PLayoutLine* = ptr TLayoutLine
  TLayoutLine*{.final, pure.} = object 
    layout*: PLayout
    start_index*: Gint
    length*: Gint
    runs*: PGSList

  PLayoutRun* = ptr TLayoutRun
  TLayoutRun*{.final, pure.} = object 
    item*: PItem
    glyphs*: PGlyphString

  PTabAlign* = ptr TTabAlign
  TTabAlign* = enum 
    TAB_LEFT

const 
  Scale* = 1024

proc pixels*(d: Int): Int
proc ascent*(rect: TRectangle): Int32
proc descent*(rect: TRectangle): Int32
proc lbearing*(rect: TRectangle): Int32
proc rbearing*(rect: TRectangle): Int32
proc typeLanguage*(): GType
proc languageGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "pango_language_get_type".}
proc languageFromString*(language: Cstring): PLanguage{.cdecl, dynlib: lib, 
    importc: "pango_language_from_string".}
proc toString*(language: PLanguage): Cstring
proc matches*(language: PLanguage, range_list: Cstring): Gboolean{.
    cdecl, dynlib: lib, importc: "pango_language_matches".}
const 
  AttrInvalid* = 0
  AttrLanguage* = 1
  AttrFamily* = 2
  AttrStyle* = 3
  AttrWeight* = 4
  AttrVariant* = 5
  AttrStretch* = 6
  AttrSize* = 7
  AttrFontDesc* = 8
  AttrForeground* = 9
  AttrBackground* = 10
  AttrUnderline* = 11
  AttrStrikethrough* = 12
  AttrRise* = 13
  AttrShape* = 14
  AttrScale* = 15
  UnderlineNone* = 0
  UnderlineSingle* = 1
  UnderlineDouble* = 2
  UnderlineLow* = 3

proc typeColor*(): GType
proc colorGetType*(): GType{.cdecl, dynlib: lib, 
                               importc: "pango_color_get_type".}
proc copy*(src: PColor): PColor{.cdecl, dynlib: lib, 
                                       importc: "pango_color_copy".}
proc free*(color: PColor){.cdecl, dynlib: lib, importc: "pango_color_free".}
proc parse*(color: PColor, spec: Cstring): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_color_parse".}
proc typeAttrList*(): GType
proc attrTypeRegister*(name: Cstring): TAttrType{.cdecl, dynlib: lib, 
    importc: "pango_attr_type_register".}
proc copy*(attr: PAttribute): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attribute_copy".}
proc destroy*(attr: PAttribute){.cdecl, dynlib: lib, 
    importc: "pango_attribute_destroy".}
proc equal*(attr1: PAttribute, attr2: PAttribute): Gboolean{.cdecl, 
    dynlib: lib, importc: "pango_attribute_equal".}
proc attrLanguageNew*(language: PLanguage): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_language_new".}
proc attrFamilyNew*(family: Cstring): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_family_new".}
proc attrForegroundNew*(red: Guint16, green: Guint16, blue: Guint16): PAttribute{.
    cdecl, dynlib: lib, importc: "pango_attr_foreground_new".}
proc attrBackgroundNew*(red: Guint16, green: Guint16, blue: Guint16): PAttribute{.
    cdecl, dynlib: lib, importc: "pango_attr_background_new".}
proc attrSizeNew*(size: Int32): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_size_new".}
proc attrStyleNew*(style: TStyle): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_style_new".}
proc attrWeightNew*(weight: TWeight): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_weight_new".}
proc attrVariantNew*(variant: TVariant): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_variant_new".}
proc attrStretchNew*(stretch: TStretch): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_stretch_new".}
proc attrFontDescNew*(desc: PFontDescription): PAttribute{.cdecl, 
    dynlib: lib, importc: "pango_attr_font_desc_new".}
proc attrUnderlineNew*(underline: TUnderline): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_underline_new".}
proc attrStrikethroughNew*(strikethrough: Gboolean): PAttribute{.cdecl, 
    dynlib: lib, importc: "pango_attr_strikethrough_new".}
proc attrRiseNew*(rise: Int32): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_rise_new".}
proc attrShapeNew*(ink_rect: PRectangle, logical_rect: PRectangle): PAttribute{.
    cdecl, dynlib: lib, importc: "pango_attr_shape_new".}
proc attrScaleNew*(scale_factor: Gdouble): PAttribute{.cdecl, dynlib: lib, 
    importc: "pango_attr_scale_new".}
proc attrListGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "pango_attr_list_get_type".}
proc attrListNew*(): PAttrList{.cdecl, dynlib: lib, 
                                  importc: "pango_attr_list_new".}
proc reference*(list: PAttrList){.cdecl, dynlib: lib, 
                                      importc: "pango_attr_list_ref".}
proc unref*(list: PAttrList){.cdecl, dynlib: lib, 
                                        importc: "pango_attr_list_unref".}
proc copy*(list: PAttrList): PAttrList{.cdecl, dynlib: lib, 
    importc: "pango_attr_list_copy".}
proc insert*(list: PAttrList, attr: PAttribute){.cdecl, dynlib: lib, 
    importc: "pango_attr_list_insert".}
proc insertBefore*(list: PAttrList, attr: PAttribute){.cdecl, 
    dynlib: lib, importc: "pango_attr_list_insert_before".}
proc change*(list: PAttrList, attr: PAttribute){.cdecl, dynlib: lib, 
    importc: "pango_attr_list_change".}
proc splice*(list: PAttrList, other: PAttrList, pos: Gint, len: Gint){.
    cdecl, dynlib: lib, importc: "pango_attr_list_splice".}
proc getIterator*(list: PAttrList): PAttrIterator{.cdecl, 
    dynlib: lib, importc: "pango_attr_list_get_iterator".}
proc attrIteratorRange*(`iterator`: PAttrIterator, start: Pgint, theEnd: Pgint){.
    cdecl, dynlib: lib, importc: "pango_attr_iterator_range".}
proc attrIteratorNext*(`iterator`: PAttrIterator): Gboolean{.cdecl, 
    dynlib: lib, importc: "pango_attr_iterator_next".}
proc attrIteratorCopy*(`iterator`: PAttrIterator): PAttrIterator{.cdecl, 
    dynlib: lib, importc: "pango_attr_iterator_copy".}
proc attrIteratorDestroy*(`iterator`: PAttrIterator){.cdecl, dynlib: lib, 
    importc: "pango_attr_iterator_destroy".}
proc attrIteratorGet*(`iterator`: PAttrIterator, `type`: TAttrType): PAttribute{.
    cdecl, dynlib: lib, importc: "pango_attr_iterator_get".}
proc attrIteratorGetFont*(`iterator`: PAttrIterator, desc: PFontDescription, 
                             language: var PLanguage, extra_attrs: PPGSList){.
    cdecl, dynlib: lib, importc: "pango_attr_iterator_get_font".}
proc parseMarkup*(markup_text: Cstring, length: Int32, accel_marker: Gunichar, 
                   attr_list: var PAttrList, text: PPchar, 
                   accel_char: Pgunichar, error: Pointer): Gboolean{.cdecl, 
    dynlib: lib, importc: "pango_parse_markup".}
const 
  bmTPangoLogAttrIsLineBreak* = 0x0001'i16
  bpTPangoLogAttrIsLineBreak* = 0'i16
  bmTPangoLogAttrIsMandatoryBreak* = 0x0002'i16
  bpTPangoLogAttrIsMandatoryBreak* = 1'i16
  bmTPangoLogAttrIsCharBreak* = 0x0004'i16
  bpTPangoLogAttrIsCharBreak* = 2'i16
  bmTPangoLogAttrIsWhite* = 0x0008'i16
  bpTPangoLogAttrIsWhite* = 3'i16
  bmTPangoLogAttrIsCursorPosition* = 0x0010'i16
  bpTPangoLogAttrIsCursorPosition* = 4'i16
  bmTPangoLogAttrIsWordStart* = 0x0020'i16
  bpTPangoLogAttrIsWordStart* = 5'i16
  bmTPangoLogAttrIsWordEnd* = 0x0040'i16
  bpTPangoLogAttrIsWordEnd* = 6'i16
  bmTPangoLogAttrIsSentenceBoundary* = 0x0080'i16
  bpTPangoLogAttrIsSentenceBoundary* = 7'i16
  bmTPangoLogAttrIsSentenceStart* = 0x0100'i16
  bpTPangoLogAttrIsSentenceStart* = 8'i16
  bmTPangoLogAttrIsSentenceEnd* = 0x0200'i16
  bpTPangoLogAttrIsSentenceEnd* = 9'i16

proc isLineBreak*(a: PLogAttr): Guint
proc setIsLineBreak*(a: PLogAttr, `is_line_break`: Guint)
proc isMandatoryBreak*(a: PLogAttr): Guint
proc setIsMandatoryBreak*(a: PLogAttr, `is_mandatory_break`: Guint)
proc isCharBreak*(a: PLogAttr): Guint
proc setIsCharBreak*(a: PLogAttr, `is_char_break`: Guint)
proc isWhite*(a: PLogAttr): Guint
proc setIsWhite*(a: PLogAttr, `is_white`: Guint)
proc isCursorPosition*(a: PLogAttr): Guint
proc setIsCursorPosition*(a: PLogAttr, `is_cursor_position`: Guint)
proc isWordStart*(a: PLogAttr): Guint
proc setIsWordStart*(a: PLogAttr, `is_word_start`: Guint)
proc isWordEnd*(a: PLogAttr): Guint
proc setIsWordEnd*(a: PLogAttr, `is_word_end`: Guint)
proc isSentenceBoundary*(a: PLogAttr): Guint
proc setIsSentenceBoundary*(a: PLogAttr, `is_sentence_boundary`: Guint)
proc isSentenceStart*(a: PLogAttr): Guint
proc setIsSentenceStart*(a: PLogAttr, `is_sentence_start`: Guint)
proc isSentenceEnd*(a: PLogAttr): Guint
proc setIsSentenceEnd*(a: PLogAttr, `is_sentence_end`: Guint)
proc `break`*(text: Cstring, length: Int32, analysis: PAnalysis, attrs: PLogAttr, 
            attrs_len: Int32){.cdecl, dynlib: lib, importc: "pango_break".}
proc findParagraphBoundary*(text: Cstring, length: Gint, 
                              paragraph_delimiter_index: Pgint, 
                              next_paragraph_start: Pgint){.cdecl, dynlib: lib, 
    importc: "pango_find_paragraph_boundary".}
proc getLogAttrs*(text: Cstring, length: Int32, level: Int32, 
                    language: PLanguage, log_attrs: PLogAttr, attrs_len: Int32){.
    cdecl, dynlib: lib, importc: "pango_get_log_attrs".}
proc typeContext*(): GType
proc context*(anObject: Pointer): PContext
proc contextClass*(klass: Pointer): PContextClass
proc isContext*(anObject: Pointer): Bool
proc isContextClass*(klass: Pointer): Bool
proc getClass*(obj: PContext): PContextClass
proc contextGetType*(): GType{.cdecl, dynlib: lib, 
                                 importc: "pango_context_get_type".}
proc listFamilies*(context: PContext, 
                            families: Openarray[ptr PFontFamily]){.cdecl, 
    dynlib: lib, importc: "pango_context_list_families".}
proc loadFont*(context: PContext, desc: PFontDescription): PFont{.
    cdecl, dynlib: lib, importc: "pango_context_load_font".}
proc loadFontset*(context: PContext, desc: PFontDescription, 
                           language: PLanguage): PFontset{.cdecl, dynlib: lib, 
    importc: "pango_context_load_fontset".}
proc getMetrics*(context: PContext, desc: PFontDescription, 
                          language: PLanguage): PFontMetrics{.cdecl, 
    dynlib: lib, importc: "pango_context_get_metrics".}
proc setFontDescription*(context: PContext, desc: PFontDescription){.
    cdecl, dynlib: lib, importc: "pango_context_set_font_description".}
proc getFontDescription*(context: PContext): PFontDescription{.cdecl, 
    dynlib: lib, importc: "pango_context_get_font_description".}
proc getLanguage*(context: PContext): PLanguage{.cdecl, dynlib: lib, 
    importc: "pango_context_get_language".}
proc setLanguage*(context: PContext, language: PLanguage){.cdecl, 
    dynlib: lib, importc: "pango_context_set_language".}
proc setBaseDir*(context: PContext, direction: TDirection){.cdecl, 
    dynlib: lib, importc: "pango_context_set_base_dir".}
proc getBaseDir*(context: PContext): TDirection{.cdecl, dynlib: lib, 
    importc: "pango_context_get_base_dir".}
proc itemize*(context: PContext, text: Cstring, start_index: Int32, 
              length: Int32, attrs: PAttrList, cached_iter: PAttrIterator): PGList{.
    cdecl, dynlib: lib, importc: "pango_itemize".}
proc coverageNew*(): PCoverage{.cdecl, dynlib: lib, 
                                 importc: "pango_coverage_new".}
proc reference*(coverage: PCoverage): PCoverage{.cdecl, dynlib: lib, 
    importc: "pango_coverage_ref".}
proc unref*(coverage: PCoverage){.cdecl, dynlib: lib, 
    importc: "pango_coverage_unref".}
proc copy*(coverage: PCoverage): PCoverage{.cdecl, dynlib: lib, 
    importc: "pango_coverage_copy".}
proc get*(coverage: PCoverage, index: Int32): TCoverageLevel{.cdecl, 
    dynlib: lib, importc: "pango_coverage_get".}
proc set*(coverage: PCoverage, index: Int32, level: TCoverageLevel){.
    cdecl, dynlib: lib, importc: "pango_coverage_set".}
proc max*(coverage: PCoverage, other: PCoverage){.cdecl, dynlib: lib, 
    importc: "pango_coverage_max".}
proc toBytes*(coverage: PCoverage, bytes: PPguchar, n_bytes: var Int32){.
    cdecl, dynlib: lib, importc: "pango_coverage_to_bytes".}
proc coverageFromBytes*(bytes: Pguchar, n_bytes: Int32): PCoverage{.cdecl, 
    dynlib: lib, importc: "pango_coverage_from_bytes".}
proc typeFontset*(): GType
proc fontset*(anObject: Pointer): PFontset
proc isFontset*(anObject: Pointer): Bool
proc fontsetGetType*(): GType{.cdecl, dynlib: lib, 
                                 importc: "pango_fontset_get_type".}
proc getFont*(fontset: PFontset, wc: Guint): PFont{.cdecl, dynlib: lib, 
    importc: "pango_fontset_get_font".}
proc getMetrics*(fontset: PFontset): PFontMetrics{.cdecl, dynlib: lib, 
    importc: "pango_fontset_get_metrics".}
const 
  StyleNormal* = 0
  StyleOblique* = 1
  StyleItalic* = 2
  VariantNormal* = 0
  VariantSmallCaps* = 1
  WeightUltralight* = 200
  WeightLight* = 300
  WeightNormal* = 400
  WeightBold* = 700
  WeightUltrabold* = 800
  WeightHeavy* = 900
  StretchUltraCondensed* = 0
  StretchExtraCondensed* = 1
  StretchCondensed* = 2
  StretchSemiCondensed* = 3
  StretchNormal* = 4
  StretchSemiExpanded* = 5
  StretchExpanded* = 6
  StretchExtraExpanded* = 7
  StretchUltraExpanded* = 8
  FontMaskFamily* = 1 shl 0
  FontMaskStyle* = 1 shl 1
  FontMaskVariant* = 1 shl 2
  FontMaskWeight* = 1 shl 3
  FontMaskStretch* = 1 shl 4
  FontMaskSize* = 1 shl 5
  ScaleXxSmall* = 0.578704
  ScaleXSmall* = 0.644444
  ScaleSmall* = 0.833333
  ScaleMedium* = 1.00000
  ScaleLarge* = 1.20000
  ScaleXLarge* = 1.44000
  ScaleXxLarge* = 1.72800

proc typeFontDescription*(): GType
proc fontDescriptionGetType*(): GType{.cdecl, dynlib: lib, 
    importc: "pango_font_description_get_type".}
proc fontDescriptionNew*(): PFontDescription{.cdecl, dynlib: lib, 
    importc: "pango_font_description_new".}
proc copy*(desc: PFontDescription): PFontDescription{.cdecl, 
    dynlib: lib, importc: "pango_font_description_copy".}
proc copyStatic*(desc: PFontDescription): PFontDescription{.
    cdecl, dynlib: lib, importc: "pango_font_description_copy_static".}
proc hash*(desc: PFontDescription): Guint{.cdecl, dynlib: lib, 
    importc: "pango_font_description_hash".}
proc equal*(desc1: PFontDescription, desc2: PFontDescription): Gboolean{.
    cdecl, dynlib: lib, importc: "pango_font_description_equal".}
proc free*(desc: PFontDescription){.cdecl, dynlib: lib, 
    importc: "pango_font_description_free".}
proc fontDescriptionsFree*(descs: var PFontDescription, n_descs: Int32){.
    cdecl, dynlib: lib, importc: "pango_font_descriptions_free".}
proc setFamily*(desc: PFontDescription, family: Cstring){.
    cdecl, dynlib: lib, importc: "pango_font_description_set_family".}
proc setFamilyStatic*(desc: PFontDescription, family: Cstring){.
    cdecl, dynlib: lib, importc: "pango_font_description_set_family_static".}
proc getFamily*(desc: PFontDescription): Cstring{.cdecl, 
    dynlib: lib, importc: "pango_font_description_get_family".}
proc setStyle*(desc: PFontDescription, style: TStyle){.cdecl, 
    dynlib: lib, importc: "pango_font_description_set_style".}
proc getStyle*(desc: PFontDescription): TStyle{.cdecl, 
    dynlib: lib, importc: "pango_font_description_get_style".}
proc setVariant*(desc: PFontDescription, variant: TVariant){.
    cdecl, dynlib: lib, importc: "pango_font_description_set_variant".}
proc getVariant*(desc: PFontDescription): TVariant{.cdecl, 
    dynlib: lib, importc: "pango_font_description_get_variant".}
proc setWeight*(desc: PFontDescription, weight: TWeight){.
    cdecl, dynlib: lib, importc: "pango_font_description_set_weight".}
proc getWeight*(desc: PFontDescription): TWeight{.cdecl, 
    dynlib: lib, importc: "pango_font_description_get_weight".}
proc setStretch*(desc: PFontDescription, stretch: TStretch){.
    cdecl, dynlib: lib, importc: "pango_font_description_set_stretch".}
proc getStretch*(desc: PFontDescription): TStretch{.cdecl, 
    dynlib: lib, importc: "pango_font_description_get_stretch".}
proc setSize*(desc: PFontDescription, size: Gint){.cdecl, 
    dynlib: lib, importc: "pango_font_description_set_size".}
proc getSize*(desc: PFontDescription): Gint{.cdecl, 
    dynlib: lib, importc: "pango_font_description_get_size".}
proc setAbsoluteSize*(desc: PFontDescription, size: Float64){.
    cdecl, dynlib: lib, importc: "pango_font_description_set_absolute_size".}
proc getSizeIsAbsolute*(desc: PFontDescription, 
    size: Float64): Gboolean{.cdecl, dynlib: lib, importc: "pango_font_description_get_size_is_absolute".}
proc getSetFields*(desc: PFontDescription): TFontMask{.cdecl, 
    dynlib: lib, importc: "pango_font_description_get_set_fields".}
proc unsetFields*(desc: PFontDescription, to_unset: TFontMask){.
    cdecl, dynlib: lib, importc: "pango_font_description_unset_fields".}
proc merge*(desc: PFontDescription, 
                             desc_to_merge: PFontDescription, 
                             replace_existing: Gboolean){.cdecl, dynlib: lib, 
    importc: "pango_font_description_merge".}
proc mergeStatic*(desc: PFontDescription, 
                                    desc_to_merge: PFontDescription, 
                                    replace_existing: Gboolean){.cdecl, 
    dynlib: lib, importc: "pango_font_description_merge_static".}
proc betterMatch*(desc: PFontDescription, 
                                    old_match: PFontDescription, 
                                    new_match: PFontDescription): Gboolean{.
    cdecl, dynlib: lib, importc: "pango_font_description_better_match".}
proc fontDescriptionFromString*(str: Cstring): PFontDescription{.cdecl, 
    dynlib: lib, importc: "pango_font_description_from_string".}
proc toString*(desc: PFontDescription): Cstring{.cdecl, 
    dynlib: lib, importc: "pango_font_description_to_string".}
proc toFilename*(desc: PFontDescription): Cstring{.cdecl, 
    dynlib: lib, importc: "pango_font_description_to_filename".}
proc typeFontMetrics*(): GType
proc fontMetricsGetType*(): GType{.cdecl, dynlib: lib, 
                                      importc: "pango_font_metrics_get_type".}
proc reference*(metrics: PFontMetrics): PFontMetrics{.cdecl, dynlib: lib, 
    importc: "pango_font_metrics_ref".}
proc unref*(metrics: PFontMetrics){.cdecl, dynlib: lib, 
    importc: "pango_font_metrics_unref".}
proc getAscent*(metrics: PFontMetrics): Int32{.cdecl, dynlib: lib, 
    importc: "pango_font_metrics_get_ascent".}
proc getDescent*(metrics: PFontMetrics): Int32{.cdecl, 
    dynlib: lib, importc: "pango_font_metrics_get_descent".}
proc getApproximateCharWidth*(metrics: PFontMetrics): Int32{.
    cdecl, dynlib: lib, importc: "pango_font_metrics_get_approximate_char_width".}
proc getApproximateDigitWidth*(metrics: PFontMetrics): Int32{.
    cdecl, dynlib: lib, 
    importc: "pango_font_metrics_get_approximate_digit_width".}
proc typeFontFamily*(): GType
proc fontFamily*(anObject: Pointer): PFontFamily
proc isFontFamily*(anObject: Pointer): Bool
proc fontFamilyGetType*(): GType{.cdecl, dynlib: lib, 
                                     importc: "pango_font_family_get_type".}
proc listFaces*(family: PFontFamily, 
                             faces: var Openarray[ptr PFontFace]){.cdecl, 
    dynlib: lib, importc: "pango_font_family_list_faces".}
proc getName*(family: PFontFamily): Cstring{.cdecl, dynlib: lib, 
    importc: "pango_font_family_get_name".}
proc typeFontFace*(): GType
proc fontFace*(anObject: Pointer): PFontFace
proc isFontFace*(anObject: Pointer): Bool
proc fontFaceGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "pango_font_face_get_type".}
proc describe*(face: PFontFace): PFontDescription{.cdecl, dynlib: lib, 
    importc: "pango_font_face_describe".}
proc getFaceName*(face: PFontFace): Cstring{.cdecl, dynlib: lib, 
    importc: "pango_font_face_get_face_name".}
proc typeFont*(): GType
proc font*(anObject: Pointer): PFont
proc isFont*(anObject: Pointer): Bool
proc fontGetType*(): GType{.cdecl, dynlib: lib, importc: "pango_font_get_type".}
proc describe*(font: PFont): PFontDescription{.cdecl, dynlib: lib, 
    importc: "pango_font_describe".}
proc getCoverage*(font: PFont, language: PLanguage): PCoverage{.cdecl, 
    dynlib: lib, importc: "pango_font_get_coverage".}
proc findShaper*(font: PFont, language: PLanguage, ch: Guint32): PEngineShape{.
    cdecl, dynlib: lib, importc: "pango_font_find_shaper".}
proc getMetrics*(font: PFont, language: PLanguage): PFontMetrics{.cdecl, 
    dynlib: lib, importc: "pango_font_get_metrics".}
proc getGlyphExtents*(font: PFont, glyph: TGlyph, ink_rect: PRectangle, 
                             logical_rect: PRectangle){.cdecl, dynlib: lib, 
    importc: "pango_font_get_glyph_extents".}
proc typeFontMap*(): GType
proc fontMap*(anObject: Pointer): PFontMap
proc isFontMap*(anObject: Pointer): Bool
proc fontMapGetType*(): GType{.cdecl, dynlib: lib, 
                                  importc: "pango_font_map_get_type".}
proc loadFont*(fontmap: PFontMap, context: PContext, 
                         desc: PFontDescription): PFont{.cdecl, dynlib: lib, 
    importc: "pango_font_map_load_font".}
proc loadFontset*(fontmap: PFontMap, context: PContext, 
                            desc: PFontDescription, language: PLanguage): PFontset{.
    cdecl, dynlib: lib, importc: "pango_font_map_load_fontset".}
proc listFamilies*(fontmap: PFontMap, 
                             families: var Openarray[ptr PFontFamily]){.cdecl, 
    dynlib: lib, importc: "pango_font_map_list_families".}
const 
  bmTPangoGlyphVisAttrIsClusterStart* = 0x0001'i16
  bpTPangoGlyphVisAttrIsClusterStart* = 0'i16

proc isClusterStart*(a: PGlyphVisAttr): Guint
proc setIsClusterStart*(a: PGlyphVisAttr, `is_cluster_start`: Guint)
proc typeGlyphString*(): GType
proc glyphStringNew*(): PGlyphString{.cdecl, dynlib: lib, 
                                        importc: "pango_glyph_string_new".}
proc glyphStringSetSize*(`string`: PGlyphString, new_len: Gint){.cdecl, 
    dynlib: lib, importc: "pango_glyph_string_set_size".}
proc glyphStringGetType*(): GType{.cdecl, dynlib: lib, 
                                      importc: "pango_glyph_string_get_type".}
proc glyphStringCopy*(`string`: PGlyphString): PGlyphString{.cdecl, 
    dynlib: lib, importc: "pango_glyph_string_copy".}
proc glyphStringFree*(`string`: PGlyphString){.cdecl, dynlib: lib, 
    importc: "pango_glyph_string_free".}
proc extents*(glyphs: PGlyphString, font: PFont, 
                           ink_rect: PRectangle, logical_rect: PRectangle){.
    cdecl, dynlib: lib, importc: "pango_glyph_string_extents".}
proc extentsRange*(glyphs: PGlyphString, start: Int32, 
                                 theEnd: Int32, font: PFont, 
                                 ink_rect: PRectangle, logical_rect: PRectangle){.
    cdecl, dynlib: lib, importc: "pango_glyph_string_extents_range".}
proc getLogicalWidths*(glyphs: PGlyphString, text: Cstring, 
                                      length: Int32, embedding_level: Int32, 
                                      logical_widths: var Int32){.cdecl, 
    dynlib: lib, importc: "pango_glyph_string_get_logical_widths".}
proc indexToX*(glyphs: PGlyphString, text: Cstring, 
                              length: Int32, analysis: PAnalysis, index: Int32, 
                              trailing: Gboolean, x_pos: var Int32){.cdecl, 
    dynlib: lib, importc: "pango_glyph_string_index_to_x".}
proc xToIndex*(glyphs: PGlyphString, text: Cstring, 
                              length: Int32, analysis: PAnalysis, x_pos: Int32, 
                              index, trailing: var Int32){.cdecl, dynlib: lib, 
    importc: "pango_glyph_string_x_to_index".}
proc shape*(text: Cstring, length: Gint, analysis: PAnalysis, 
            glyphs: PGlyphString){.cdecl, dynlib: lib, importc: "pango_shape".}
proc reorderItems*(logical_items: PGList): PGList{.cdecl, dynlib: lib, 
    importc: "pango_reorder_items".}
proc itemNew*(): PItem{.cdecl, dynlib: lib, importc: "pango_item_new".}
proc copy*(item: PItem): PItem{.cdecl, dynlib: lib, 
                                     importc: "pango_item_copy".}
proc free*(item: PItem){.cdecl, dynlib: lib, importc: "pango_item_free".}
proc split*(orig: PItem, split_index: Int32, split_offset: Int32): PItem{.
    cdecl, dynlib: lib, importc: "pango_item_split".}
proc typeLayout*(): GType
proc layout*(anObject: Pointer): PLayout
proc layoutClass*(klass: Pointer): PLayoutClass
proc isLayout*(anObject: Pointer): Bool
proc isLayoutClass*(klass: Pointer): Bool
proc getClass*(obj: PLayout): PLayoutClass
proc layoutGetType*(): GType{.cdecl, dynlib: lib, 
                                importc: "pango_layout_get_type".}
proc layoutNew*(context: PContext): PLayout{.cdecl, dynlib: lib, 
    importc: "pango_layout_new".}
proc copy*(src: PLayout): PLayout{.cdecl, dynlib: lib, 
    importc: "pango_layout_copy".}
proc getContext*(layout: PLayout): PContext{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_context".}
proc setAttributes*(layout: PLayout, attrs: PAttrList){.cdecl, 
    dynlib: lib, importc: "pango_layout_set_attributes".}
proc getAttributes*(layout: PLayout): PAttrList{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_attributes".}
proc setText*(layout: PLayout, text: Cstring, length: Int32){.cdecl, 
    dynlib: lib, importc: "pango_layout_set_text".}
proc getText*(layout: PLayout): Cstring{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_text".}
proc setMarkup*(layout: PLayout, markup: Cstring, length: Int32){.cdecl, 
    dynlib: lib, importc: "pango_layout_set_markup".}
proc setMarkup*(layout: PLayout, markup: Cstring, 
                                   length: Int32, accel_marker: Gunichar, 
                                   accel_char: Pgunichar){.cdecl, dynlib: lib, 
    importc: "pango_layout_set_markup_with_accel".}
proc setFontDescription*(layout: PLayout, desc: PFontDescription){.
    cdecl, dynlib: lib, importc: "pango_layout_set_font_description".}
proc setWidth*(layout: PLayout, width: Int32){.cdecl, dynlib: lib, 
    importc: "pango_layout_set_width".}
proc getWidth*(layout: PLayout): Int32{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_width".}
proc setWrap*(layout: PLayout, wrap: TWrapMode){.cdecl, dynlib: lib, 
    importc: "pango_layout_set_wrap".}
proc getWrap*(layout: PLayout): TWrapMode{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_wrap".}
proc setIndent*(layout: PLayout, indent: Int32){.cdecl, dynlib: lib, 
    importc: "pango_layout_set_indent".}
proc getIndent*(layout: PLayout): Int32{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_indent".}
proc setSpacing*(layout: PLayout, spacing: Int32){.cdecl, dynlib: lib, 
    importc: "pango_layout_set_spacing".}
proc getSpacing*(layout: PLayout): Int32{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_spacing".}
proc setJustify*(layout: PLayout, justify: Gboolean){.cdecl, 
    dynlib: lib, importc: "pango_layout_set_justify".}
proc getJustify*(layout: PLayout): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_justify".}
proc setAlignment*(layout: PLayout, alignment: TAlignment){.cdecl, 
    dynlib: lib, importc: "pango_layout_set_alignment".}
proc getAlignment*(layout: PLayout): TAlignment{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_alignment".}
proc setTabs*(layout: PLayout, tabs: PTabArray){.cdecl, dynlib: lib, 
    importc: "pango_layout_set_tabs".}
proc getTabs*(layout: PLayout): PTabArray{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_tabs".}
proc setSingleParagraphMode*(layout: PLayout, setting: Gboolean){.
    cdecl, dynlib: lib, importc: "pango_layout_set_single_paragraph_mode".}
proc getSingleParagraphMode*(layout: PLayout): Gboolean{.cdecl, 
    dynlib: lib, importc: "pango_layout_get_single_paragraph_mode".}
proc contextChanged*(layout: PLayout){.cdecl, dynlib: lib, 
    importc: "pango_layout_context_changed".}
proc getLogAttrs*(layout: PLayout, attrs: var PLogAttr, n_attrs: Pgint){.
    cdecl, dynlib: lib, importc: "pango_layout_get_log_attrs".}
proc indexToPos*(layout: PLayout, index: Int32, pos: PRectangle){.
    cdecl, dynlib: lib, importc: "pango_layout_index_to_pos".}
proc getCursorPos*(layout: PLayout, index: Int32, 
                            strong_pos: PRectangle, weak_pos: PRectangle){.
    cdecl, dynlib: lib, importc: "pango_layout_get_cursor_pos".}
proc moveCursorVisually*(layout: PLayout, strong: Gboolean, 
                                  old_index: Int32, old_trailing: Int32, 
                                  direction: Int32, 
                                  new_index, new_trailing: var Int32){.cdecl, 
    dynlib: lib, importc: "pango_layout_move_cursor_visually".}
proc xyToIndex*(layout: PLayout, x: Int32, y: Int32, 
                         index, trailing: var Int32): Gboolean{.cdecl, 
    dynlib: lib, importc: "pango_layout_xy_to_index".}
proc getExtents*(layout: PLayout, ink_rect: PRectangle, 
                         logical_rect: PRectangle){.cdecl, dynlib: lib, 
    importc: "pango_layout_get_extents".}
proc getPixelExtents*(layout: PLayout, ink_rect: PRectangle, 
                               logical_rect: PRectangle){.cdecl, dynlib: lib, 
    importc: "pango_layout_get_pixel_extents".}
proc getSize*(layout: PLayout, width: var Int32, height: var Int32){.
    cdecl, dynlib: lib, importc: "pango_layout_get_size".}
proc getPixelSize*(layout: PLayout, width: var Int32, height: var Int32){.
    cdecl, dynlib: lib, importc: "pango_layout_get_pixel_size".}
proc getLineCount*(layout: PLayout): Int32{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_line_count".}
proc getLine*(layout: PLayout, line: Int32): PLayoutLine{.cdecl, 
    dynlib: lib, importc: "pango_layout_get_line".}
proc getLines*(layout: PLayout): PGSList{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_lines".}
proc reference*(line: PLayoutLine){.cdecl, dynlib: lib, 
    importc: "pango_layout_line_ref".}
proc unref*(line: PLayoutLine){.cdecl, dynlib: lib, 
    importc: "pango_layout_line_unref".}
proc xToIndex*(line: PLayoutLine, x_pos: Int32, index: var Int32, 
                             trailing: var Int32): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_layout_line_x_to_index".}
proc indexToX*(line: PLayoutLine, index: Int32, 
                             trailing: Gboolean, x_pos: var Int32){.cdecl, 
    dynlib: lib, importc: "pango_layout_line_index_to_x".}
proc getExtents*(line: PLayoutLine, ink_rect: PRectangle, 
                              logical_rect: PRectangle){.cdecl, dynlib: lib, 
    importc: "pango_layout_line_get_extents".}
proc getPixelExtents*(layout_line: PLayoutLine, 
                                    ink_rect: PRectangle, 
                                    logical_rect: PRectangle){.cdecl, 
    dynlib: lib, importc: "pango_layout_line_get_pixel_extents".}
proc getIter*(layout: PLayout): PLayoutIter{.cdecl, dynlib: lib, 
    importc: "pango_layout_get_iter".}
proc free*(iter: PLayoutIter){.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_free".}
proc getIndex*(iter: PLayoutIter): Int32{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_get_index".}
proc getRun*(iter: PLayoutIter): PLayoutRun{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_get_run".}
proc getLine*(iter: PLayoutIter): PLayoutLine{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_get_line".}
proc atLastLine*(iter: PLayoutIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_at_last_line".}
proc nextChar*(iter: PLayoutIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_next_char".}
proc nextCluster*(iter: PLayoutIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_next_cluster".}
proc nextRun*(iter: PLayoutIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_next_run".}
proc nextLine*(iter: PLayoutIter): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_next_line".}
proc getCharExtents*(iter: PLayoutIter, logical_rect: PRectangle){.
    cdecl, dynlib: lib, importc: "pango_layout_iter_get_char_extents".}
proc getClusterExtents*(iter: PLayoutIter, ink_rect: PRectangle, 
                                      logical_rect: PRectangle){.cdecl, 
    dynlib: lib, importc: "pango_layout_iter_get_cluster_extents".}
proc getRunExtents*(iter: PLayoutIter, ink_rect: PRectangle, 
                                  logical_rect: PRectangle){.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_get_run_extents".}
proc getLineExtents*(iter: PLayoutIter, ink_rect: PRectangle, 
                                   logical_rect: PRectangle){.cdecl, 
    dynlib: lib, importc: "pango_layout_iter_get_line_extents".}
proc getLineYrange*(iter: PLayoutIter, y0: var Int32, 
                                  y1: var Int32){.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_get_line_yrange".}
proc getLayoutExtents*(iter: PLayoutIter, ink_rect: PRectangle, 
                                     logical_rect: PRectangle){.cdecl, 
    dynlib: lib, importc: "pango_layout_iter_get_layout_extents".}
proc getBaseline*(iter: PLayoutIter): Int32{.cdecl, dynlib: lib, 
    importc: "pango_layout_iter_get_baseline".}
proc typeTabArray*(): GType
proc tabArrayNew*(initial_size: Gint, positions_in_pixels: Gboolean): PTabArray{.
    cdecl, dynlib: lib, importc: "pango_tab_array_new".}
proc tabArrayGetType*(): GType{.cdecl, dynlib: lib, 
                                   importc: "pango_tab_array_get_type".}
proc copy*(src: PTabArray): PTabArray{.cdecl, dynlib: lib, 
    importc: "pango_tab_array_copy".}
proc free*(tab_array: PTabArray){.cdecl, dynlib: lib, 
    importc: "pango_tab_array_free".}
proc getSize*(tab_array: PTabArray): Gint{.cdecl, dynlib: lib, 
    importc: "pango_tab_array_get_size".}
proc resize*(tab_array: PTabArray, new_size: Gint){.cdecl, 
    dynlib: lib, importc: "pango_tab_array_resize".}
proc setTab*(tab_array: PTabArray, tab_index: Gint, 
                        alignment: TTabAlign, location: Gint){.cdecl, 
    dynlib: lib, importc: "pango_tab_array_set_tab".}
proc getTab*(tab_array: PTabArray, tab_index: Gint, 
                        alignment: PTabAlign, location: Pgint){.cdecl, 
    dynlib: lib, importc: "pango_tab_array_get_tab".}
proc getPositionsInPixels*(tab_array: PTabArray): Gboolean{.cdecl, 
    dynlib: lib, importc: "pango_tab_array_get_positions_in_pixels".}
proc ascent*(rect: TRectangle): int32 = 
  result = -rect.y

proc descent*(rect: TRectangle): int32 = 
  result = (rect.y) + (rect.height)

proc lbearing*(rect: TRectangle): int32 = 
  result = rect.x

proc rbearing*(rect: TRectangle): int32 = 
  result = (rect.x) + (rect.width)

proc typeLanguage*(): GType = 
  result = languageGetType()

proc toString*(language: PLanguage): cstring = 
  result = cast[Cstring](language)

proc pixels*(d: int): int = 
  if d >= 0: 
    result = (d + (SCALE div 2)) div SCALE
  else: 
    result = (d - (SCALE div 2)) div SCALE

proc typeColor*(): GType = 
  result = colorGetType()

proc typeAttrList*(): GType = 
  result = attrListGetType()

proc isLineBreak*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_line_break) shr
      bp_TPangoLogAttr_is_line_break

proc setIsLineBreak*(a: PLogAttr, `is_line_break`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isLineBreak` shl bp_TPangoLogAttr_is_line_break) and
      bm_TPangoLogAttr_is_line_break)

proc isMandatoryBreak*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_mandatory_break) shr
      bp_TPangoLogAttr_is_mandatory_break

proc setIsMandatoryBreak*(a: PLogAttr, `is_mandatory_break`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isMandatoryBreak` shl bp_TPangoLogAttr_is_mandatory_break) and
      bm_TPangoLogAttr_is_mandatory_break)

proc isCharBreak*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_char_break) shr
      bp_TPangoLogAttr_is_char_break

proc setIsCharBreak*(a: PLogAttr, `is_char_break`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isCharBreak` shl bp_TPangoLogAttr_is_char_break) and
      bm_TPangoLogAttr_is_char_break)

proc isWhite*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_white) shr
      bp_TPangoLogAttr_is_white

proc setIsWhite*(a: PLogAttr, `is_white`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isWhite` shl bp_TPangoLogAttr_is_white) and
      bm_TPangoLogAttr_is_white)

proc isCursorPosition*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_cursor_position) shr
      bp_TPangoLogAttr_is_cursor_position

proc setIsCursorPosition*(a: PLogAttr, `is_cursor_position`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isCursorPosition` shl bp_TPangoLogAttr_is_cursor_position) and
      bm_TPangoLogAttr_is_cursor_position)

proc isWordStart*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_word_start) shr
      bp_TPangoLogAttr_is_word_start

proc setIsWordStart*(a: PLogAttr, `is_word_start`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isWordStart` shl bp_TPangoLogAttr_is_word_start) and
      bm_TPangoLogAttr_is_word_start)

proc isWordEnd*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_word_end) shr
      bp_TPangoLogAttr_is_word_end

proc setIsWordEnd*(a: PLogAttr, `is_word_end`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isWordEnd` shl bp_TPangoLogAttr_is_word_end) and
      bm_TPangoLogAttr_is_word_end)

proc isSentenceBoundary*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_sentence_boundary) shr
      bp_TPangoLogAttr_is_sentence_boundary

proc setIsSentenceBoundary*(a: PLogAttr, `is_sentence_boundary`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isSentenceBoundary` shl bp_TPangoLogAttr_is_sentence_boundary) and
      bm_TPangoLogAttr_is_sentence_boundary)

proc isSentenceStart*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_sentence_start) shr
      bp_TPangoLogAttr_is_sentence_start

proc setIsSentenceStart*(a: PLogAttr, `is_sentence_start`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isSentenceStart` shl bp_TPangoLogAttr_is_sentence_start) and
      bm_TPangoLogAttr_is_sentence_start)

proc isSentenceEnd*(a: PLogAttr): guint = 
  result = (a.flag0 and bm_TPangoLogAttr_is_sentence_end) shr
      bp_TPangoLogAttr_is_sentence_end

proc setIsSentenceEnd*(a: PLogAttr, `is_sentence_end`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isSentenceEnd` shl bp_TPangoLogAttr_is_sentence_end) and
      bm_TPangoLogAttr_is_sentence_end)

proc typeContext*(): GType = 
  result = contextGetType()

proc context*(anObject: pointer): PContext = 
  result = cast[PContext](gTypeCheckInstanceCast(anObject, typeContext()))

proc contextClass*(klass: pointer): PContextClass = 
  result = cast[PContextClass](gTypeCheckClassCast(klass, typeContext()))

proc isContext*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeContext())

proc isContextClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeContext())

proc getClass*(obj: PContext): PContextClass = 
  result = cast[PContextClass](gTypeInstanceGetClass(obj, typeContext()))

proc typeFontset*(): GType = 
  result = fontsetGetType()

proc fontset*(anObject: pointer): PFontset = 
  result = cast[PFontset](gTypeCheckInstanceCast(anObject, typeFontset()))

proc isFontset*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeFontset())

proc fontsetClass*(klass: Pointer): PFontsetClass = 
  result = cast[PFontsetClass](gTypeCheckClassCast(klass, typeFontset()))

proc isFontsetClass*(klass: Pointer): Bool = 
  result = gTypeCheckClassType(klass, typeFontset())

proc getClass*(obj: PFontset): PFontsetClass = 
  result = cast[PFontsetClass](gTypeInstanceGetClass(obj, typeFontset()))

proc fontsetSimpleGetType(): GType{.importc: "pango_fontset_simple_get_type", 
                                       cdecl, dynlib: lib.}
proc typeFontsetSimple*(): GType = 
  result = fontsetSimpleGetType()

proc fontsetSimple*(anObject: Pointer): PFontsetSimple = 
  result = cast[PFontsetSimple](gTypeCheckInstanceCast(anObject, 
      typeFontsetSimple()))

proc isFontsetSimple*(anObject: Pointer): Bool = 
  result = gTypeCheckInstanceType(anObject, typeFontsetSimple())

proc typeFontDescription*(): GType = 
  result = fontDescriptionGetType()

proc typeFontMetrics*(): GType = 
  result = fontMetricsGetType()

proc typeFontFamily*(): GType = 
  result = fontFamilyGetType()

proc fontFamily*(anObject: pointer): PFontFamily = 
  result = cast[PFontFamily](gTypeCheckInstanceCast(anObject, 
      typeFontFamily()))

proc isFontFamily*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeFontFamily())

proc fontFamilyClass*(klass: Pointer): PFontFamilyClass = 
  result = cast[PFontFamilyClass](gTypeCheckClassCast(klass, 
      typeFontFamily()))

proc isFontFamilyClass*(klass: Pointer): Bool = 
  result = gTypeCheckClassType(klass, typeFontFamily())

proc getClass*(obj: PFontFamily): PFontFamilyClass = 
  result = cast[PFontFamilyClass](gTypeInstanceGetClass(obj, 
      typeFontFamily()))

proc typeFontFace*(): GType = 
  result = fontFaceGetType()

proc fontFace*(anObject: Pointer): PFontFace = 
  result = cast[PFontFace](gTypeCheckInstanceCast(anObject, typeFontFace()))

proc isFontFace*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeFontFace())

proc fontFaceClass*(klass: Pointer): PFontFaceClass = 
  result = cast[PFontFaceClass](gTypeCheckClassCast(klass, typeFontFace()))

proc isFontFaceClass*(klass: Pointer): Bool = 
  result = gTypeCheckClassType(klass, typeFontFace())

proc fontFaceGetClass*(obj: Pointer): PFontFaceClass = 
  result = cast[PFontFaceClass](gTypeInstanceGetClass(obj, typeFontFace()))

proc typeFont*(): GType = 
  result = fontGetType()

proc font*(anObject: Pointer): PFont = 
  result = cast[PFont](gTypeCheckInstanceCast(anObject, typeFont()))

proc isFont*(anObject: Pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeFont())

proc fontClass*(klass: Pointer): PFontClass = 
  result = cast[PFontClass](gTypeCheckClassCast(klass, typeFont()))

proc isFontClass*(klass: Pointer): Bool = 
  result = gTypeCheckClassType(klass, typeFont())

proc getClass*(obj: PFont): PFontClass = 
  result = cast[PFontClass](gTypeInstanceGetClass(obj, typeFont()))

proc typeFontMap*(): GType = 
  result = fontMapGetType()

proc fontMap*(anObject: pointer): PFontmap = 
  result = cast[PFontMap](gTypeCheckInstanceCast(anObject, typeFontMap()))

proc isFontMap*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeFontMap())

proc fontMapClass*(klass: Pointer): PFontMapClass = 
  result = cast[PFontMapClass](gTypeCheckClassCast(klass, typeFontMap()))

proc isFontMapClass*(klass: Pointer): Bool = 
  result = gTypeCheckClassType(klass, typeFontMap())

proc getClass*(obj: PFontMap): PFontMapClass = 
  result = cast[PFontMapClass](gTypeInstanceGetClass(obj, typeFontMap()))

proc isClusterStart*(a: PGlyphVisAttr): guint = 
  result = (a.flag0 and bm_TPangoGlyphVisAttr_is_cluster_start) shr
      bp_TPangoGlyphVisAttr_is_cluster_start

proc setIsClusterStart*(a: PGlyphVisAttr, `is_cluster_start`: guint) = 
  a.flag0 = a.flag0 or
      (Int16(`isClusterStart` shl bp_TPangoGlyphVisAttr_is_cluster_start) and
      bm_TPangoGlyphVisAttr_is_cluster_start)

proc typeGlyphString*(): GType = 
  result = glyphStringGetType()

proc typeLayout*(): GType = 
  result = layoutGetType()

proc layout*(anObject: pointer): PLayout = 
  result = cast[PLayout](gTypeCheckInstanceCast(anObject, typeLayout()))

proc layoutClass*(klass: pointer): PLayoutClass = 
  result = cast[PLayoutClass](gTypeCheckClassCast(klass, typeLayout()))

proc isLayout*(anObject: pointer): bool = 
  result = gTypeCheckInstanceType(anObject, typeLayout())

proc isLayoutClass*(klass: pointer): bool = 
  result = gTypeCheckClassType(klass, typeLayout())

proc getClass*(obj: PLayout): PLayoutClass = 
  result = cast[PLayoutClass](gTypeInstanceGetClass(obj, typeLayout()))

proc typeTabArray*(): GType = 
  result = tabArrayGetType()
