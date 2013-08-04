#
# $Id: sphinxclient.h 2654 2011-01-31 01:20:58Z kevg $
#
#
# Copyright (c) 2001-2011, Andrew Aksyonoff
# Copyright (c) 2008-2011, Sphinx Technologies Inc
# All rights reserved
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Library General Public License. You should
# have received a copy of the LGPL license along with this program; if you
# did not, you can find it at http://www.gnu.org/
#

## Nimrod wrapper for ``sphinx``.

{.deadCodeElim: on.}
when defined(windows):
  const
    sphinxDll* = "spinx.dll"
elif defined(macosx):
  const
    sphinxDll* = "libspinx.dylib"
else:
  const
    sphinxDll* = "libspinxclient.so"

#/ known searchd status codes:
const
  SearchdOk* = 0
  SearchdError* = 1
  SearchdRetry* = 2
  SearchdWarning* = 3

#/ known match modes

const
  SphMatchAll* = 0
  SphMatchAny* = 1
  SphMatchPhrase* = 2
  SphMatchBoolean* = 3
  SphMatchExtended* = 4
  SphMatchFullscan* = 5
  SphMatchExtended2* = 6

#/ known ranking modes (ext2 only)

const
  SphRankProximityBm25* = 0
  SphRankBm25* = 1
  SphRankNone* = 2
  SphRankWordcount* = 3
  SphRankProximity* = 4
  SphRankMatchany* = 5
  SphRankFieldmask* = 6
  SphRankSph04* = 7
  SphRankDefault* = SPH_RANK_PROXIMITY_BM25

#/ known sort modes

const
  SphSortRelevance* = 0
  SphSortAttrDesc* = 1
  SphSortAttrAsc* = 2
  SphSortTimeSegments* = 3
  SphSortExtended* = 4
  SphSortExpr* = 5

#/ known filter types

const
  SphFilterValues* = 0
  SphFilterRange* = 1
  SphFilterFloatrange* = 2

#/ known attribute types

const
  SphAttrInteger* = 1
  SphAttrTimestamp* = 2
  SphAttrOrdinal* = 3
  SphAttrBool* = 4
  SphAttrFloat* = 5
  SphAttrBigint* = 6
  SphAttrString* = 7
  SphAttrMulti* = 0x40000000

#/ known grouping functions

const
  SphGroupbyDay* = 0
  SphGroupbyWeek* = 1
  SphGroupbyMonth* = 2
  SphGroupbyYear* = 3
  SphGroupbyAttr* = 4
  SphGroupbyAttrpair* = 5

type
  TSphinxBool* {.size: sizeof(cint).} = enum
    SPH_FALSE = 0,
    SPH_TRUE = 1

  Tclient {.pure, final.} = object
  PClient* = ptr Tclient
  Twordinfo*{.pure, final.} = object
    word*: Cstring
    docs*: Cint
    hits*: Cint

  TResult*{.pure, final.} = object
    error*: Cstring
    warning*: Cstring
    status*: Cint
    num_fields*: Cint
    fields*: CstringArray
    num_attrs*: Cint
    attr_names*: CstringArray
    attr_types*: ptr Array [0..100_000, Cint]
    num_matches*: Cint
    values_pool*: Pointer
    total*: Cint
    total_found*: Cint
    time_msec*: Cint
    num_words*: Cint
    words*: ptr Array [0..100_000, Twordinfo]

  TexcerptOptions*{.pure, final.} = object
    before_match*: Cstring
    after_match*: Cstring
    chunk_separator*: Cstring
    html_strip_mode*: Cstring
    passage_boundary*: Cstring
    limit*: Cint
    limit_passages*: Cint
    limit_words*: Cint
    around*: Cint
    start_passage_id*: Cint
    exact_phrase*: TSphinxBool
    single_passage*: TSphinxBool
    use_boundaries*: TSphinxBool
    weight_order*: TSphinxBool
    query_mode*: TSphinxBool
    force_all_words*: TSphinxBool
    load_files*: TSphinxBool
    allow_empty*: TSphinxBool
    emit_zones*: TSphinxBool

  TkeywordInfo*{.pure, final.} = object
    tokenized*: Cstring
    normalized*: Cstring
    num_docs*: Cint
    num_hits*: Cint


proc create*(copy_args: TSphinxBool): PClient{.cdecl, importc: "sphinx_create",
    dynlib: sphinxDll.}
proc cleanup*(client: PClient){.cdecl, importc: "sphinx_cleanup",
                                    dynlib: sphinxDll.}
proc destroy*(client: PClient){.cdecl, importc: "sphinx_destroy",
                                    dynlib: sphinxDll.}
proc error*(client: PClient): Cstring{.cdecl, importc: "sphinx_error",
    dynlib: sphinxDll.}
proc warning*(client: PClient): Cstring{.cdecl, importc: "sphinx_warning",
    dynlib: sphinxDll.}
proc setServer*(client: PClient, host: Cstring, port: Cint): TSphinxBool{.cdecl,
    importc: "sphinx_set_server", dynlib: sphinxDll.}
proc setConnectTimeout*(client: PClient, seconds: Float32): TSphinxBool{.cdecl,
    importc: "sphinx_set_connect_timeout", dynlib: sphinxDll.}
proc open*(client: PClient): TSphinxBool{.cdecl, importc: "sphinx_open",
                                        dynlib: sphinxDll.}
proc close*(client: PClient): TSphinxBool{.cdecl, importc: "sphinx_close",
    dynlib: sphinxDll.}
proc setLimits*(client: PClient, offset: Cint, limit: Cint,
                 max_matches: Cint, cutoff: Cint): TSphinxBool{.cdecl,
    importc: "sphinx_set_limits", dynlib: sphinxDll.}
proc setMaxQueryTime*(client: PClient, max_query_time: Cint): TSphinxBool{.
    cdecl, importc: "sphinx_set_max_query_time", dynlib: sphinxDll.}
proc setMatchMode*(client: PClient, mode: Cint): TSphinxBool{.cdecl,
    importc: "sphinx_set_match_mode", dynlib: sphinxDll.}
proc setRankingMode*(client: PClient, ranker: Cint): TSphinxBool{.cdecl,
    importc: "sphinx_set_ranking_mode", dynlib: sphinxDll.}
proc setSortMode*(client: PClient, mode: Cint, sortby: Cstring): TSphinxBool{.
    cdecl, importc: "sphinx_set_sort_mode", dynlib: sphinxDll.}
proc setFieldWeights*(client: PClient, num_weights: Cint,
                        field_names: CstringArray, field_weights: ptr Cint): TSphinxBool{.
    cdecl, importc: "sphinx_set_field_weights", dynlib: sphinxDll.}
proc setIndexWeights*(client: PClient, num_weights: Cint,
                        index_names: CstringArray, index_weights: ptr Cint): TSphinxBool{.
    cdecl, importc: "sphinx_set_index_weights", dynlib: sphinxDll.}
proc setIdRange*(client: PClient, minid: Int64, maxid: Int64): TSphinxBool{.
    cdecl, importc: "sphinx_set_id_range", dynlib: sphinxDll.}
proc addFilter*(client: PClient, attr: Cstring, num_values: Cint,
                 values: ptr Int64, exclude: TSphinxBool): TSphinxBool{.cdecl,
    importc: "sphinx_add_filter", dynlib: sphinxDll.}
proc addFilterRange*(client: PClient, attr: Cstring, umin: Int64,
                       umax: Int64, exclude: TSphinxBool): TSphinxBool{.cdecl,
    importc: "sphinx_add_filter_range", dynlib: sphinxDll.}
proc addFilterFloatRange*(client: PClient, attr: Cstring, fmin: Float32,
                             fmax: Float32, exclude: TSphinxBool): TSphinxBool{.cdecl,
    importc: "sphinx_add_filter_float_range", dynlib: sphinxDll.}
proc setGeoanchor*(client: PClient, attr_latitude: Cstring,
                    attr_longitude: Cstring, latitude: Float32, longitude: Float32): TSphinxBool{.
    cdecl, importc: "sphinx_set_geoanchor", dynlib: sphinxDll.}
proc setGroupby*(client: PClient, attr: Cstring, groupby_func: Cint,
                  group_sort: Cstring): TSphinxBool{.cdecl,
    importc: "sphinx_set_groupby", dynlib: sphinxDll.}
proc setGroupbyDistinct*(client: PClient, attr: Cstring): TSphinxBool{.cdecl,
    importc: "sphinx_set_groupby_distinct", dynlib: sphinxDll.}
proc setRetries*(client: PClient, count: Cint, delay: Cint): TSphinxBool{.cdecl,
    importc: "sphinx_set_retries", dynlib: sphinxDll.}
proc addOverride*(client: PClient, attr: Cstring, docids: ptr Int64,
                   num_values: Cint, values: ptr Cint): TSphinxBool{.cdecl,
    importc: "sphinx_add_override", dynlib: sphinxDll.}
proc setSelect*(client: PClient, select_list: Cstring): TSphinxBool{.cdecl,
    importc: "sphinx_set_select", dynlib: sphinxDll.}
proc resetFilters*(client: PClient){.cdecl,
    importc: "sphinx_reset_filters", dynlib: sphinxDll.}
proc resetGroupby*(client: PClient){.cdecl,
    importc: "sphinx_reset_groupby", dynlib: sphinxDll.}
proc query*(client: PClient, query: Cstring, index_list: Cstring,
            comment: Cstring): ptr TResult{.cdecl, importc: "sphinx_query",
    dynlib: sphinxDll.}
proc addQuery*(client: PClient, query: Cstring, index_list: Cstring,
                comment: Cstring): Cint{.cdecl, importc: "sphinx_add_query",
    dynlib: sphinxDll.}
proc runQueries*(client: PClient): ptr TResult{.cdecl,
    importc: "sphinx_run_queries", dynlib: sphinxDll.}
proc getNumResults*(client: PClient): Cint{.cdecl,
    importc: "sphinx_get_num_results", dynlib: sphinxDll.}
proc getId*(result: ptr TResult, match: Cint): Int64{.cdecl,
    importc: "sphinx_get_id", dynlib: sphinxDll.}
proc getWeight*(result: ptr TResult, match: Cint): Cint{.cdecl,
    importc: "sphinx_get_weight", dynlib: sphinxDll.}
proc getInt*(result: ptr TResult, match: Cint, attr: Cint): Int64{.cdecl,
    importc: "sphinx_get_int", dynlib: sphinxDll.}
proc getFloat*(result: ptr TResult, match: Cint, attr: Cint): Float32{.cdecl,
    importc: "sphinx_get_float", dynlib: sphinxDll.}
proc getMva*(result: ptr TResult, match: Cint, attr: Cint): ptr Cint{.
    cdecl, importc: "sphinx_get_mva", dynlib: sphinxDll.}
proc getString*(result: ptr TResult, match: Cint, attr: Cint): Cstring{.cdecl,
    importc: "sphinx_get_string", dynlib: sphinxDll.}
proc initExcerptOptions*(opts: ptr TexcerptOptions){.cdecl,
    importc: "sphinx_init_excerpt_options", dynlib: sphinxDll.}
proc buildExcerpts*(client: PClient, num_docs: Cint, docs: CstringArray,
                     index: Cstring, words: Cstring, opts: ptr TexcerptOptions): CstringArray{.
    cdecl, importc: "sphinx_build_excerpts", dynlib: sphinxDll.}
proc updateAttributes*(client: PClient, index: Cstring, num_attrs: Cint,
                        attrs: CstringArray, num_docs: Cint,
                        docids: ptr Int64, values: ptr Int64): Cint{.
    cdecl, importc: "sphinx_update_attributes", dynlib: sphinxDll.}
proc updateAttributesMva*(client: PClient, index: Cstring, attr: Cstring,
                            docid: Int64, num_values: Cint,
                            values: ptr Cint): Cint{.cdecl,
    importc: "sphinx_update_attributes_mva", dynlib: sphinxDll.}
proc buildKeywords*(client: PClient, query: Cstring, index: Cstring,
                     hits: TSphinxBool, out_num_keywords: ptr Cint): ptr TkeywordInfo{.
    cdecl, importc: "sphinx_build_keywords", dynlib: sphinxDll.}
proc status*(client: PClient, num_rows: ptr Cint, num_cols: ptr Cint): CstringArray{.
    cdecl, importc: "sphinx_status", dynlib: sphinxDll.}
proc statusDestroy*(status: CstringArray, num_rows: Cint, num_cols: Cint){.
    cdecl, importc: "sphinx_status_destroy", dynlib: sphinxDll.}
