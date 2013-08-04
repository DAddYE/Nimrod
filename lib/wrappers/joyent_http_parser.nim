type
  Csize = Int
  
  HttpDataProc* = proc (a2: ptr THttpParser, at: Cstring, length: Csize): Cint {.cdecl.}
  HttpProc* = proc (a2: ptr THttpParser): Cint {.cdecl.}

  THttpMethod* = enum
    HTTP_DELETE = 0, HTTP_GET, HTTP_HEAD, HTTP_POST, HTTP_PUT, HTTP_CONNECT,
    HTTP_OPTIONS, HTTP_TRACE, HTTP_COPY, HTTP_LOCK, HTTP_MKCOL, HTTP_MOVE,
    HTTP_PROPFIND, HTTP_PROPPATCH, HTTP_UNLOCK, HTTP_REPORT, HTTP_MKACTIVITY,
    HTTP_CHECKOUT, HTTP_MERGE, HTTP_MSEARCH, HTTP_NOTIFY, HTTP_SUBSCRIBE,
    HTTP_UNSUBSCRIBE, HTTP_PATCH

  THttpParserType* = enum
    HTTP_REQUEST, HTTP_RESPONSE, HTTP_BOTH

  TParserFlag* = enum
    F_CHUNKED = 1 shl 0,
    F_CONNECTION_KEEP_ALIVE = 1 shl 1,
    F_CONNECTION_CLOSE = 1 shl 2,
    F_TRAILING = 1 shl 3,
    F_UPGRADE = 1 shl 4,
    F_SKIPBODY = 1 shl 5

  THttpErrNo* = enum
    HPE_OK, HPE_CB_message_begin, HPE_CB_path, HPE_CB_query_string, HPE_CB_url,
    HPE_CB_fragment, HPE_CB_header_field, HPE_CB_header_value,
    HPE_CB_headers_complete, HPE_CB_body, HPE_CB_message_complete,
    HPE_INVALID_EOF_STATE, HPE_HEADER_OVERFLOW, HPE_CLOSED_CONNECTION,
    HPE_INVALID_VERSION, HPE_INVALID_STATUS, HPE_INVALID_METHOD,
    HPE_INVALID_URL, HPE_INVALID_HOST, HPE_INVALID_PORT, HPE_INVALID_PATH,
    HPE_INVALID_QUERY_STRING, HPE_INVALID_FRAGMENT, HPE_LF_EXPECTED,
    HPE_INVALID_HEADER_TOKEN, HPE_INVALID_CONTENT_LENGTH,
    HPE_INVALID_CHUNK_SIZE, HPE_INVALID_CONSTANT, HPE_INVALID_INTERNAL_STATE,
    HPE_STRICT, HPE_UNKNOWN

  THttpParser*{.pure, final, importc: "http_parser", header: "http_parser.h".} = object
    typ {.importc: "type".}: Char
    flags {.importc: "flags".}: Char
    state*{.importc: "state".}: Char
    header_state*{.importc: "header_state".}: Char
    index*{.importc: "index".}: Char
    nread*{.importc: "nread".}: Cint
    content_length*{.importc: "content_length".}: Int64
    http_major*{.importc: "http_major".}: Cshort
    http_minor*{.importc: "http_minor".}: Cshort
    status_code*{.importc: "status_code".}: Cshort
    http_method*{.importc: "method".}: Cshort
    http_errno_bits {.importc: "http_errno".}: Char
    upgrade {.importc: "upgrade".}: Bool
    data*{.importc: "data".}: Pointer

  THttpParserSettings*{.pure, final, importc: "http_parser_settings", header: "http_parser.h".} = object
    on_message_begin*{.importc: "on_message_begin".}: HttpProc
    on_url*{.importc: "on_url".}: HttpDataProc
    on_header_field*{.importc: "on_header_field".}: HttpDataProc
    on_header_value*{.importc: "on_header_value".}: HttpDataProc
    on_headers_complete*{.importc: "on_headers_complete".}: HttpProc
    on_body*{.importc: "on_body".}: HttpDataProc
    on_message_complete*{.importc: "on_message_complete".}: HttpProc

proc httpParserInit*(parser: var THttpParser, typ: THttpParserType){.
    importc: "http_parser_init", header: "http_parser.h".}

proc httpParserExecute*(parser: var THttpParser,
                          settings: var THttpParserSettings, data: Cstring,
                          len: Csize): Csize {.
    importc: "http_parser_execute", header: "http_parser.h".}

proc httpShouldKeepAlive*(parser: var THttpParser): Cint{.
    importc: "http_should_keep_alive", header: "http_parser.h".}

proc httpMethodStr*(m: THttpMethod): Cstring{.
    importc: "http_method_str", header: "http_parser.h".}

proc httpErrnoName*(err: THttpErrNo): Cstring{.
    importc: "http_errno_name", header: "http_parser.h".}

proc httpErrnoDescription*(err: THttpErrNo): Cstring{.
    importc: "http_errno_description", header: "http_parser.h".}

