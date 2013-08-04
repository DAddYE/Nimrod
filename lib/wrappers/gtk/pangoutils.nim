{.deadCodeElim: on.}
import 
  glib2, pango

proc splitFileList*(str: Cstring): PPchar{.cdecl, dynlib: lib, 
    importc: "pango_split_file_list".}
proc trimString*(str: Cstring): Cstring{.cdecl, dynlib: lib, 
    importc: "pango_trim_string".}
proc readLine*(stream: TFile, str: PGString): Gint{.cdecl, dynlib: lib, 
    importc: "pango_read_line".}
proc skipSpace*(pos: PPchar): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_skip_space".}
proc scanWord*(pos: PPchar, OutStr: PGString): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_scan_word".}
proc scanString*(pos: PPchar, OutStr: PGString): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_scan_string".}
proc scanInt*(pos: PPchar, OutInt: ptr Int32): Gboolean{.cdecl, dynlib: lib, 
    importc: "pango_scan_int".}
proc configKeyGet*(key: Cstring): Cstring{.cdecl, dynlib: lib, 
    importc: "pango_config_key_get".}
proc lookupAliases*(fontname: Cstring, families: PPPchar, n_families: ptr Int32){.
    cdecl, dynlib: lib, importc: "pango_lookup_aliases".}
proc parseStyle*(str: Cstring, style: PStyle, warn: Gboolean): Gboolean{.cdecl, 
    dynlib: lib, importc: "pango_parse_style".}
proc parseVariant*(str: Cstring, variant: PVariant, warn: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "pango_parse_variant".}
proc parseWeight*(str: Cstring, weight: PWeight, warn: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "pango_parse_weight".}
proc parseStretch*(str: Cstring, stretch: PStretch, warn: Gboolean): Gboolean{.
    cdecl, dynlib: lib, importc: "pango_parse_stretch".}
proc getSysconfSubdirectory*(): Cstring{.cdecl, dynlib: lib, 
    importc: "pango_get_sysconf_subdirectory".}
proc getLibSubdirectory*(): Cstring{.cdecl, dynlib: lib, 
                                      importc: "pango_get_lib_subdirectory".}
proc log2visGetEmbeddingLevels*(str: Pgunichar, len: Int32, 
                                   pbase_dir: PDirection, 
                                   embedding_level_list: Pguint8): Gboolean{.
    cdecl, dynlib: lib, importc: "pango_log2vis_get_embedding_levels".}
proc getMirrorChar*(ch: Gunichar, mirrored_ch: Pgunichar): Gboolean{.cdecl, 
    dynlib: lib, importc: "pango_get_mirror_char".}
proc getSampleString*(language: PLanguage): Cstring{.cdecl, 
    dynlib: lib, importc: "pango_language_get_sample_string".}
