#
#    $Id: header,v 1.1 2000/07/13 06:33:45 michael Exp $
#    This file is part of the Free Pascal packages
#    Copyright (c) 1999-2000 by the Free Pascal development team
#
#    See the file COPYING.FPC, included in this distribution,
#    for details about the copyright.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# **********************************************************************
#
#   the curl library is governed by its own copyright, see the curl
#   website for this. 
# 

{.deadCodeElim: on.}

import 
  times

when defined(windows): 
  const 
    libname = "libcurl.dll"
elif defined(macosx): 
  const 
    libname = "libcurl-7.19.3.dylib"
elif defined(unix): 
  const 
    libname = "libcurl.so.4"
type 
  PcallocCallback* = ptr TcallocCallback
  Pclosepolicy* = ptr Tclosepolicy
  Pforms* = ptr Tforms
  Pftpauth* = ptr Tftpauth
  Pftpmethod* = ptr Tftpmethod
  Pftpssl* = ptr Tftpssl
  PhttpVersion* = ptr THTTP_VERSION
  Phttppost* = ptr Thttppost
  PPcurlHttppost* = ptr Phttppost
  Pinfotype* = ptr Tinfotype
  PlockAccess* = ptr TlockAccess
  PlockData* = ptr TlockData
  PmallocCallback* = ptr TmallocCallback
  PnetrcOption* = ptr TNETRC_OPTION
  Pproxytype* = ptr Tproxytype
  PreallocCallback* = ptr TreallocCallback
  Pslist* = ptr Tslist
  Psocket* = ptr Tsocket
  PsslVersion* = ptr TSSL_VERSION
  PstrdupCallback* = ptr TstrdupCallback
  Ptimecond* = ptr TTIMECOND
  PversionInfoData* = ptr TversionInfoData
  Pcode* = ptr Tcode
  PFORMcode* = ptr TFORMcode
  Pformoption* = ptr Tformoption
  Pinfo* = ptr TINFO
  Piocmd* = ptr Tiocmd
  Pioerr* = ptr Tioerr
  Pm* = ptr TM
  PMcode* = ptr TMcode
  PMoption* = ptr TMoption
  Pmsg* = ptr TMSG
  Poption* = ptr Toption
  Psh* = ptr TSH
  PSHcode* = ptr TSHcode
  PSHoption* = ptr TSHoption
  Pversion* = ptr Tversion
  PfdSet* = Pointer
  PCurl* = ptr TCurl
  TCurl* = Pointer
  Thttppost*{.final, pure.} = object 
    next*: Phttppost
    name*: Cstring
    namelength*: Int32
    contents*: Cstring
    contentslength*: Int32
    buffer*: Cstring
    bufferlength*: Int32
    contenttype*: Cstring
    contentheader*: Pslist
    more*: Phttppost
    flags*: Int32
    showfilename*: Cstring

  TprogressCallback* = proc (clientp: Pointer, dltotal: Float64, 
                              dlnow: Float64, ultotal: Float64, 
                              ulnow: Float64): Int32 {.cdecl.}
  TwriteCallback* = proc (buffer: Cstring, size: Int, nitems: Int, 
                           outstream: Pointer): Int{.cdecl.}
  TreadCallback* = proc (buffer: Cstring, size: Int, nitems: Int, 
                          instream: Pointer): Int{.cdecl.}
  TpasswdCallback* = proc (clientp: Pointer, prompt: Cstring, buffer: Cstring, 
                            buflen: Int32): Int32{.cdecl.}
  Tioerr* = enum 
    IOE_OK, IOE_UNKNOWNCMD, IOE_FAILRESTART, IOE_LAST
  Tiocmd* = enum 
    IOCMD_NOP, IOCMD_RESTARTREAD, IOCMD_LAST
  TioctlCallback* = proc (handle: PCurl, cmd: Int32, clientp: Pointer): Tioerr{.
      cdecl.}
  TmallocCallback* = proc (size: Int): Pointer{.cdecl.}
  TfreeCallback* = proc (p: Pointer){.cdecl.}
  TreallocCallback* = proc (p: Pointer, size: Int): Pointer{.cdecl.}
  TstrdupCallback* = proc (str: Cstring): Cstring{.cdecl.}
  TcallocCallback* = proc (nmemb: Int, size: Int): Pointer{.noconv.}
  Tinfotype* = enum 
    INFO_TEXT = 0, INFO_HEADER_IN, INFO_HEADER_OUT, INFO_DATA_IN, INFO_DATA_OUT, 
    INFO_SSL_DATA_IN, INFO_SSL_DATA_OUT, INFO_END
  TdebugCallback* = proc (handle: PCurl, theType: Tinfotype, data: Cstring, 
                           size: Int, userptr: Pointer): Int32{.cdecl.}
  Tcode* = enum 
    E_OK = 0, E_UNSUPPORTED_PROTOCOL, E_FAILED_INIT, E_URL_MALFORMAT, 
    E_URL_MALFORMAT_USER, E_COULDNT_RESOLVE_PROXY, E_COULDNT_RESOLVE_HOST, 
    E_COULDNT_CONNECT, E_FTP_WEIRD_SERVER_REPLY, E_FTP_ACCESS_DENIED, 
    E_FTP_USER_PASSWORD_INCORRECT, E_FTP_WEIRD_PASS_REPLY, 
    E_FTP_WEIRD_USER_REPLY, E_FTP_WEIRD_PASV_REPLY, E_FTP_WEIRD_227_FORMAT, 
    E_FTP_CANT_GET_HOST, E_FTP_CANT_RECONNECT, E_FTP_COULDNT_SET_BINARY, 
    E_PARTIAL_FILE, E_FTP_COULDNT_RETR_FILE, E_FTP_WRITE_ERROR, 
    E_FTP_QUOTE_ERROR, E_HTTP_RETURNED_ERROR, E_WRITE_ERROR, E_MALFORMAT_USER, 
    E_FTP_COULDNT_STOR_FILE, E_READ_ERROR, E_OUT_OF_MEMORY, 
    E_OPERATION_TIMEOUTED, E_FTP_COULDNT_SET_ASCII, E_FTP_PORT_FAILED, 
    E_FTP_COULDNT_USE_REST, E_FTP_COULDNT_GET_SIZE, E_HTTP_RANGE_ERROR, 
    E_HTTP_POST_ERROR, E_SSL_CONNECT_ERROR, E_BAD_DOWNLOAD_RESUME, 
    E_FILE_COULDNT_READ_FILE, E_LDAP_CANNOT_BIND, E_LDAP_SEARCH_FAILED, 
    E_LIBRARY_NOT_FOUND, E_FUNCTION_NOT_FOUND, E_ABORTED_BY_CALLBACK, 
    E_BAD_FUNCTION_ARGUMENT, E_BAD_CALLING_ORDER, E_INTERFACE_FAILED, 
    E_BAD_PASSWORD_ENTERED, E_TOO_MANY_REDIRECTS, E_UNKNOWN_TELNET_OPTION, 
    E_TELNET_OPTION_SYNTAX, E_OBSOLETE, E_SSL_PEER_CERTIFICATE, E_GOT_NOTHING, 
    E_SSL_ENGINE_NOTFOUND, E_SSL_ENGINE_SETFAILED, E_SEND_ERROR, E_RECV_ERROR, 
    E_SHARE_IN_USE, E_SSL_CERTPROBLEM, E_SSL_CIPHER, E_SSL_CACERT, 
    E_BAD_CONTENT_ENCODING, E_LDAP_INVALID_URL, E_FILESIZE_EXCEEDED, 
    E_FTP_SSL_FAILED, E_SEND_FAIL_REWIND, E_SSL_ENGINE_INITFAILED, 
    E_LOGIN_DENIED, E_TFTP_NOTFOUND, E_TFTP_PERM, E_TFTP_DISKFULL, 
    E_TFTP_ILLEGAL, E_TFTP_UNKNOWNID, E_TFTP_EXISTS, E_TFTP_NOSUCHUSER, 
    E_CONV_FAILED, E_CONV_REQD, LAST
  TconvCallback* = proc (buffer: Cstring, len: Int): Tcode{.cdecl.}
  TsslCtxCallback* = proc (curl: PCurl, ssl_ctx, userptr: Pointer): Tcode{.cdecl.}
  Tproxytype* = enum 
    PROXY_HTTP = 0, PROXY_SOCKS4 = 4, PROXY_SOCKS5 = 5
  Tftpssl* = enum 
    FTPSSL_NONE, FTPSSL_TRY, FTPSSL_CONTROL, FTPSSL_ALL, FTPSSL_LAST
  Tftpauth* = enum 
    FTPAUTH_DEFAULT, FTPAUTH_SSL, FTPAUTH_TLS, FTPAUTH_LAST
  Tftpmethod* = enum 
    FTPMETHOD_DEFAULT, FTPMETHOD_MULTICWD, FTPMETHOD_NOCWD, FTPMETHOD_SINGLECWD, 
    FTPMETHOD_LAST
  Toption* = enum 
    OPT_PORT = 0 + 3, OPT_TIMEOUT = 0 + 13, OPT_INFILESIZE = 0 + 14, 
    OPT_LOW_SPEED_LIMIT = 0 + 19, OPT_LOW_SPEED_TIME = 0 + 20, 
    OPT_RESUME_FROM = 0 + 21, OPT_CRLF = 0 + 27, OPT_SSLVERSION = 0 + 32, 
    OPT_TIMECONDITION = 0 + 33, OPT_TIMEVALUE = 0 + 34, OPT_VERBOSE = 0 + 41, 
    OPT_HEADER = 0 + 42, OPT_NOPROGRESS = 0 + 43, OPT_NOBODY = 0 + 44, 
    OPT_FAILONERROR = 0 + 45, OPT_UPLOAD = 0 + 46, OPT_POST = 0 + 47, 
    OPT_FTPLISTONLY = 0 + 48, OPT_FTPAPPEND = 0 + 50, OPT_NETRC = 0 + 51, 
    OPT_FOLLOWLOCATION = 0 + 52, OPT_TRANSFERTEXT = 0 + 53, OPT_PUT = 0 + 54, 
    OPT_AUTOREFERER = 0 + 58, OPT_PROXYPORT = 0 + 59, 
    OPT_POSTFIELDSIZE = 0 + 60, OPT_HTTPPROXYTUNNEL = 0 + 61, 
    OPT_SSL_VERIFYPEER = 0 + 64, OPT_MAXREDIRS = 0 + 68, OPT_FILETIME = 0 + 69, 
    OPT_MAXCONNECTS = 0 + 71, OPT_CLOSEPOLICY = 0 + 72, 
    OPT_FRESH_CONNECT = 0 + 74, OPT_FORBID_REUSE = 0 + 75, 
    OPT_CONNECTTIMEOUT = 0 + 78, OPT_HTTPGET = 0 + 80, 
    OPT_SSL_VERIFYHOST = 0 + 81, OPT_HTTP_VERSION = 0 + 84, 
    OPT_FTP_USE_EPSV = 0 + 85, OPT_SSLENGINE_DEFAULT = 0 + 90, 
    OPT_DNS_USE_GLOBAL_CACHE = 0 + 91, OPT_DNS_CACHE_TIMEOUT = 0 + 92, 
    OPT_COOKIESESSION = 0 + 96, OPT_BUFFERSIZE = 0 + 98, OPT_NOSIGNAL = 0 + 99, 
    OPT_PROXYTYPE = 0 + 101, OPT_UNRESTRICTED_AUTH = 0 + 105, 
    OPT_FTP_USE_EPRT = 0 + 106, OPT_HTTPAUTH = 0 + 107, 
    OPT_FTP_CREATE_MISSING_DIRS = 0 + 110, OPT_PROXYAUTH = 0 + 111, 
    OPT_FTP_RESPONSE_TIMEOUT = 0 + 112, OPT_IPRESOLVE = 0 + 113, 
    OPT_MAXFILESIZE = 0 + 114, OPT_FTP_SSL = 0 + 119, OPT_TCP_NODELAY = 0 + 121, 
    OPT_FTPSSLAUTH = 0 + 129, OPT_IGNORE_CONTENT_LENGTH = 0 + 136, 
    OPT_FTP_SKIP_PASV_IP = 0 + 137, OPT_FTP_FILEMETHOD = 0 + 138, 
    OPT_LOCALPORT = 0 + 139, OPT_LOCALPORTRANGE = 0 + 140, 
    OPT_CONNECT_ONLY = 0 + 141, OPT_FILE = 10000 + 1, OPT_URL = 10000 + 2, 
    OPT_PROXY = 10000 + 4, OPT_USERPWD = 10000 + 5, 
    OPT_PROXYUSERPWD = 10000 + 6, OPT_RANGE = 10000 + 7, OPT_INFILE = 10000 + 9, 
    OPT_ERRORBUFFER = 10000 + 10, OPT_POSTFIELDS = 10000 + 15, 
    OPT_REFERER = 10000 + 16, OPT_FTPPORT = 10000 + 17, 
    OPT_USERAGENT = 10000 + 18, OPT_COOKIE = 10000 + 22, 
    OPT_HTTPHEADER = 10000 + 23, OPT_HTTPPOST = 10000 + 24, 
    OPT_SSLCERT = 10000 + 25, OPT_SSLCERTPASSWD = 10000 + 26, 
    OPT_QUOTE = 10000 + 28, OPT_WRITEHEADER = 10000 + 29, 
    OPT_COOKIEFILE = 10000 + 31, OPT_CUSTOMREQUEST = 10000 + 36, 
    OPT_STDERR = 10000 + 37, OPT_POSTQUOTE = 10000 + 39, 
    OPT_WRITEINFO = 10000 + 40, OPT_PROGRESSDATA = 10000 + 57, 
    OPT_INTERFACE = 10000 + 62, OPT_KRB4LEVEL = 10000 + 63, 
    OPT_CAINFO = 10000 + 65, OPT_TELNETOPTIONS = 10000 + 70, 
    OPT_RANDOM_FILE = 10000 + 76, OPT_EGDSOCKET = 10000 + 77, 
    OPT_COOKIEJAR = 10000 + 82, OPT_SSL_CIPHER_LIST = 10000 + 83, 
    OPT_SSLCERTTYPE = 10000 + 86, OPT_SSLKEY = 10000 + 87, 
    OPT_SSLKEYTYPE = 10000 + 88, OPT_SSLENGINE = 10000 + 89, 
    OPT_PREQUOTE = 10000 + 93, OPT_DEBUGDATA = 10000 + 95, 
    OPT_CAPATH = 10000 + 97, OPT_SHARE = 10000 + 100, 
    OPT_ENCODING = 10000 + 102, OPT_PRIVATE = 10000 + 103, 
    OPT_HTTP200ALIASES = 10000 + 104, OPT_SSL_CTX_DATA = 10000 + 109, 
    OPT_NETRC_FILE = 10000 + 118, OPT_SOURCE_USERPWD = 10000 + 123, 
    OPT_SOURCE_PREQUOTE = 10000 + 127, OPT_SOURCE_POSTQUOTE = 10000 + 128, 
    OPT_IOCTLDATA = 10000 + 131, OPT_SOURCE_URL = 10000 + 132, 
    OPT_SOURCE_QUOTE = 10000 + 133, OPT_FTP_ACCOUNT = 10000 + 134, 
    OPT_COOKIELIST = 10000 + 135, OPT_FTP_ALTERNATIVE_TO_USER = 10000 + 147, 
    OPT_LASTENTRY = 10000 + 148, OPT_WRITEFUNCTION = 20000 + 11, 
    OPT_READFUNCTION = 20000 + 12, OPT_PROGRESSFUNCTION = 20000 + 56, 
    OPT_HEADERFUNCTION = 20000 + 79, OPT_DEBUGFUNCTION = 20000 + 94, 
    OPT_SSL_CTX_FUNCTION = 20000 + 108, OPT_IOCTLFUNCTION = 20000 + 130, 
    OPT_CONV_FROM_NETWORK_FUNCTION = 20000 + 142, 
    OPT_CONV_TO_NETWORK_FUNCTION = 20000 + 143, 
    OPT_CONV_FROM_UTF8_FUNCTION = 20000 + 144, 
    OPT_INFILESIZE_LARGE = 30000 + 115, OPT_RESUME_FROM_LARGE = 30000 + 116, 
    OPT_MAXFILESIZE_LARGE = 30000 + 117, OPT_POSTFIELDSIZE_LARGE = 30000 + 120, 
    OPT_MAX_SEND_SPEED_LARGE = 30000 + 145, 
    OPT_MAX_RECV_SPEED_LARGE = 30000 + 146
  THTTP_VERSION* = enum 
    HTTP_VERSION_NONE, HTTP_VERSION_1_0, HTTP_VERSION_1_1, HTTP_VERSION_LAST
  TNETRC_OPTION* = enum 
    NETRC_IGNORED, NETRC_OPTIONAL, NETRC_REQUIRED, NETRC_LAST
  TSSL_VERSION* = enum 
    SSLVERSION_DEFAULT, SSLVERSION_TLSv1, SSLVERSION_SSLv2, SSLVERSION_SSLv3, 
    SSLVERSION_LAST
  TTIMECOND* = enum 
    TIMECOND_NONE, TIMECOND_IFMODSINCE, TIMECOND_IFUNMODSINCE, TIMECOND_LASTMOD, 
    TIMECOND_LAST
  Tformoption* = enum 
    FORM_NOTHING, FORM_COPYNAME, FORM_PTRNAME, FORM_NAMELENGTH, 
    FORM_COPYCONTENTS, FORM_PTRCONTENTS, FORM_CONTENTSLENGTH, FORM_FILECONTENT, 
    FORM_ARRAY, FORM_OBSOLETE, FORM_FILE, FORM_BUFFER, FORM_BUFFERPTR, 
    FORM_BUFFERLENGTH, FORM_CONTENTTYPE, FORM_CONTENTHEADER, FORM_FILENAME, 
    FORM_END, FORM_OBSOLETE2, FORM_LASTENTRY
  Tforms*{.pure, final.} = object 
    option*: Tformoption
    value*: Cstring

  TFORMcode* = enum 
    FORMADD_OK, FORMADD_MEMORY, FORMADD_OPTION_TWICE, FORMADD_NULL, 
    FORMADD_UNKNOWN_OPTION, FORMADD_INCOMPLETE, FORMADD_ILLEGAL_ARRAY, 
    FORMADD_DISABLED, FORMADD_LAST
  TformgetCallback* = proc (arg: Pointer, buf: Cstring, length: Int): Int{.
      cdecl.}
  Tslist*{.pure, final.} = object 
    data*: Cstring
    next*: Pslist

  TINFO* = enum 
    INFO_NONE = 0, INFO_LASTONE = 30, INFO_EFFECTIVE_URL = 0x00100000 + 1, 
    INFO_CONTENT_TYPE = 0x00100000 + 18, INFO_PRIVATE = 0x00100000 + 21, 
    INFO_FTP_ENTRY_PATH = 0x00100000 + 30, INFO_RESPONSE_CODE = 0x00200000 + 2, 
    INFO_HEADER_SIZE = 0x00200000 + 11, INFO_REQUEST_SIZE = 0x00200000 + 12, 
    INFO_SSL_VERIFYRESULT = 0x00200000 + 13, INFO_FILETIME = 0x00200000 + 14, 
    INFO_REDIRECT_COUNT = 0x00200000 + 20, 
    INFO_HTTP_CONNECTCODE = 0x00200000 + 22, 
    INFO_HTTPAUTH_AVAIL = 0x00200000 + 23, 
    INFO_PROXYAUTH_AVAIL = 0x00200000 + 24, INFO_OS_ERRNO = 0x00200000 + 25, 
    INFO_NUM_CONNECTS = 0x00200000 + 26, INFO_LASTSOCKET = 0x00200000 + 29, 
    INFO_TOTAL_TIME = 0x00300000 + 3, INFO_NAMELOOKUP_TIME = 0x00300000 + 4, 
    INFO_CONNECT_TIME = 0x00300000 + 5, INFO_PRETRANSFER_TIME = 0x00300000 + 6, 
    INFO_SIZE_UPLOAD = 0x00300000 + 7, INFO_SIZE_DOWNLOAD = 0x00300000 + 8, 
    INFO_SPEED_DOWNLOAD = 0x00300000 + 9, INFO_SPEED_UPLOAD = 0x00300000 + 10, 
    INFO_CONTENT_LENGTH_DOWNLOAD = 0x00300000 + 15, 
    INFO_CONTENT_LENGTH_UPLOAD = 0x00300000 + 16, 
    INFO_STARTTRANSFER_TIME = 0x00300000 + 17, 
    INFO_REDIRECT_TIME = 0x00300000 + 19, INFO_SSL_ENGINES = 0x00400000 + 27, 
    INFO_COOKIELIST = 0x00400000 + 28
  Tclosepolicy* = enum 
    CLOSEPOLICY_NONE, CLOSEPOLICY_OLDEST, CLOSEPOLICY_LEAST_RECENTLY_USED, 
    CLOSEPOLICY_LEAST_TRAFFIC, CLOSEPOLICY_SLOWEST, CLOSEPOLICY_CALLBACK, 
    CLOSEPOLICY_LAST
  TlockData* = enum 
    LOCK_DATA_NONE = 0, LOCK_DATA_SHARE, LOCK_DATA_COOKIE, LOCK_DATA_DNS, 
    LOCK_DATA_SSL_SESSION, LOCK_DATA_CONNECT, LOCK_DATA_LAST
  TlockAccess* = enum 
    LOCK_ACCESS_NONE = 0, LOCK_ACCESS_SHARED = 1, LOCK_ACCESS_SINGLE = 2, 
    LOCK_ACCESS_LAST
  TlockFunction* = proc (handle: PCurl, data: TlockData,
                          locktype: TlockAccess, 
                          userptr: Pointer){.cdecl.}
  TunlockFunction* = proc (handle: PCurl, data: TlockData, userptr: Pointer){.
      cdecl.}
  TSH* = Pointer
  TSHcode* = enum 
    SHE_OK, SHE_BAD_OPTION, SHE_IN_USE, SHE_INVALID, SHE_NOMEM, SHE_LAST
  TSHoption* = enum 
    SHOPT_NONE, SHOPT_SHARE, SHOPT_UNSHARE, SHOPT_LOCKFUNC, SHOPT_UNLOCKFUNC, 
    SHOPT_USERDATA, SHOPT_LAST
  Tversion* = enum 
    VERSION_FIRST, VERSION_SECOND, VERSION_THIRD, VERSION_LAST
  TversionInfoData*{.pure, final.} = object 
    age*: Tversion
    version*: Cstring
    version_num*: Int32
    host*: Cstring
    features*: Int32
    ssl_version*: Cstring
    ssl_version_num*: Int32
    libz_version*: Cstring
    protocols*: CstringArray
    ares*: Cstring
    ares_num*: Int32
    libidn*: Cstring
    iconv_ver_num*: Int32

  TM* = Pointer
  Tsocket* = Int32
  TMcode* = enum 
    M_CALL_MULTI_PERFORM = - 1, M_OK = 0, M_BAD_HANDLE, M_BAD_EASY_HANDLE, 
    M_OUT_OF_MEMORY, M_INTERNAL_ERROR, M_BAD_SOCKET, M_UNKNOWN_OPTION, M_LAST
  TMSGEnum* = enum 
    MSG_NONE, MSG_DONE, MSG_LAST
  TMsg*{.pure, final.} = object 
    msg*: TMSGEnum
    easy_handle*: PCurl
    whatever*: Pointer        #data : record
                              #      case longint of
                              #        0 : ( whatever : pointer );
                              #        1 : ( result : CURLcode );
                              #    end;
  
  TsocketCallback* = proc (easy: PCurl, s: Tsocket, what: Int32, 
                            userp, socketp: Pointer): Int32{.cdecl.}
  TMoption* = enum 
    MOPT_SOCKETDATA = 10000 + 2, MOPT_LASTENTRY = 10000 + 3, 
    MOPT_SOCKETFUNCTION = 20000 + 1

const 
  OptSslkeypasswd* = OPT_SSLCERTPASSWD
  AuthAny* = not (0)
  AuthBasic* = 1 shl 0
  AuthAnysafe* = not (AUTH_BASIC)
  AuthDigest* = 1 shl 1
  AuthGssnegotiate* = 1 shl 2
  AuthNone* = 0
  AuthNtlm* = 1 shl 3
  EAlreadyComplete* = 99999
  EFtpBadDownloadResume* = E_BAD_DOWNLOAD_RESUME
  EFtpPartialFile* = E_PARTIAL_FILE
  EHttpNotFound* = E_HTTP_RETURNED_ERROR
  EHttpPortFailed* = E_INTERFACE_FAILED
  EOperationTimedout* = E_OPERATION_TIMEOUTED
  ErrorSize* = 256
  FormatOffT* = "%ld"
  GlobalNothing* = 0
  GlobalSsl* = 1 shl 0
  GlobalWin32* = 1 shl 1
  GlobalAll* = GLOBAL_SSL or GLOBAL_WIN32
  GlobalDefault* = GLOBAL_ALL
  InfoDouble* = 0x00300000
  InfoHttpCode* = INFO_RESPONSE_CODE
  InfoLong* = 0x00200000
  InfoMask* = 0x000FFFFF
  InfoSlist* = 0x00400000
  InfoString* = 0x00100000
  InfoTypemask* = 0x00F00000
  IpresolveV4* = 1
  IpresolveV6* = 2
  IpresolveWhatever* = 0
  MaxWriteSize* = 16384
  MCallMultiSocket* = M_CALL_MULTI_PERFORM
  OptClosefunction* = - (5)
  OptFtpascii* = OPT_TRANSFERTEXT
  OptHeaderdata* = OPT_WRITEHEADER
  OptHttprequest* = - (1)
  OptMute* = - (2)
  OptPasswddata* = - (4)
  OptPasswdfunction* = - (3)
  OptPasvHost* = - (9)
  OptReaddata* = OPT_INFILE
  OptSourceHost* = - (6)
  OptSourcePath* = - (7)
  OptSourcePort* = - (8)
  OpttypeFunctionpoint* = 20000
  OpttypeLong* = 0
  OpttypeObjectpoint* = 10000
  OpttypeOffT* = 30000
  OptWritedata* = OPT_FILE
  PollIn* = 1
  PollInout* = 3
  PollNone* = 0
  PollOut* = 2
  PollRemove* = 4
  ReadfuncAbort* = 0x10000000
  SocketBad* = - (1)
  SocketTimeout* = SOCKET_BAD
  VersionAsynchdns* = 1 shl 7
  VersionConv* = 1 shl 12
  VersionDebug* = 1 shl 6
  VersionGssnegotiate* = 1 shl 5
  VersionIdn* = 1 shl 10
  VersionIpv6* = 1 shl 0
  VersionKerberos4* = 1 shl 1
  VersionLargefile* = 1 shl 9
  VersionLibz* = 1 shl 3
  VersionNow* = VERSION_THIRD
  VersionNtlm* = 1 shl 4
  VersionSpnego* = 1 shl 8
  VersionSsl* = 1 shl 2
  VersionSspi* = 1 shl 11
  FileOffsetBits* = 0
  Filesizebits* = 0
  Functionpoint* = OPTTYPE_FUNCTIONPOINT
  HttppostBuffer* = 1 shl 4
  HttppostFilename* = 1 shl 0
  HttppostPtrbuffer* = 1 shl 5
  HttppostPtrcontents* = 1 shl 3
  HttppostPtrname* = 1 shl 2
  HttppostReadfile* = 1 shl 1
  LibcurlVersion* = "7.15.5"
  LibcurlVersionMajor* = 7
  LibcurlVersionMinor* = 15
  LibcurlVersionNum* = 0x00070F05
  LibcurlVersionPatch* = 5

proc strequal*(s1, s2: Cstring): Int32{.cdecl, dynlib: libname, 
                                        importc: "curl_strequal".}
proc strnequal*(s1, s2: Cstring, n: Int): Int32{.cdecl, dynlib: libname, 
    importc: "curl_strnequal".}
proc formadd*(httppost, last_post: PPcurlHttppost): TFORMcode{.cdecl, varargs, 
    dynlib: libname, importc: "curl_formadd".}
proc formget*(form: Phttppost, arg: Pointer, append: TformgetCallback): Int32{.
    cdecl, dynlib: libname, importc: "curl_formget".}
proc formfree*(form: Phttppost){.cdecl, dynlib: libname, 
                                 importc: "curl_formfree".}
proc getenv*(variable: Cstring): Cstring{.cdecl, dynlib: libname, 
    importc: "curl_getenv".}
proc version*(): Cstring{.cdecl, dynlib: libname, importc: "curl_version".}
proc easyEscape*(handle: PCurl, str: Cstring, len: Int32): Cstring{.cdecl, 
    dynlib: libname, importc: "curl_easy_escape".}
proc escape*(str: Cstring, len: Int32): Cstring{.cdecl, dynlib: libname, 
    importc: "curl_escape".}
proc easyUnescape*(handle: PCurl, str: Cstring, len: Int32, outlength: var Int32): Cstring{.
    cdecl, dynlib: libname, importc: "curl_easy_unescape".}
proc unescape*(str: Cstring, len: Int32): Cstring{.cdecl, dynlib: libname, 
    importc: "curl_unescape".}
proc free*(p: Pointer){.cdecl, dynlib: libname, importc: "curl_free".}
proc globalInit*(flags: Int32): Tcode{.cdecl, dynlib: libname, 
                                        importc: "curl_global_init".}
proc globalInitMem*(flags: Int32, m: TmallocCallback, f: TfreeCallback, 
                      r: TreallocCallback, s: TstrdupCallback, 
                      c: TcallocCallback): Tcode{.cdecl, dynlib: libname, 
    importc: "curl_global_init_mem".}
proc globalCleanup*(){.cdecl, dynlib: libname, importc: "curl_global_cleanup".}
proc slistAppend*(slist: Pslist, p: Cstring): Pslist{.cdecl, dynlib: libname, 
    importc: "curl_slist_append".}
proc slistFreeAll*(para1: Pslist){.cdecl, dynlib: libname, 
                                     importc: "curl_slist_free_all".}
proc getdate*(p: Cstring, unused: ptr TTime): TTime{.cdecl, dynlib: libname, 
    importc: "curl_getdate".}
proc shareInit*(): Psh{.cdecl, dynlib: libname, importc: "curl_share_init".}
proc shareSetopt*(para1: Psh, option: TSHoption): TSHcode{.cdecl, varargs, 
    dynlib: libname, importc: "curl_share_setopt".}
proc shareCleanup*(para1: Psh): TSHcode{.cdecl, dynlib: libname, 
    importc: "curl_share_cleanup".}
proc versionInfo*(para1: Tversion): PversionInfoData{.cdecl, dynlib: libname, 
    importc: "curl_version_info".}
proc easyStrerror*(para1: Tcode): Cstring{.cdecl, dynlib: libname, 
    importc: "curl_easy_strerror".}
proc shareStrerror*(para1: TSHcode): Cstring{.cdecl, dynlib: libname, 
    importc: "curl_share_strerror".}
proc easyInit*(): PCurl{.cdecl, dynlib: libname, importc: "curl_easy_init".}
proc easySetopt*(curl: PCurl, option: Toption): Tcode{.cdecl, varargs, dynlib: libname, 
    importc: "curl_easy_setopt".}
proc easyPerform*(curl: PCurl): Tcode{.cdecl, dynlib: libname, 
                                importc: "curl_easy_perform".}
proc easyCleanup*(curl: PCurl){.cdecl, dynlib: libname, importc: "curl_easy_cleanup".}
proc easyGetinfo*(curl: PCurl, info: TINFO): Tcode{.cdecl, varargs, dynlib: libname, 
    importc: "curl_easy_getinfo".}
proc easyDuphandle*(curl: PCurl): PCurl{.cdecl, dynlib: libname, 
                              importc: "curl_easy_duphandle".}
proc easyReset*(curl: PCurl){.cdecl, dynlib: libname, importc: "curl_easy_reset".}
proc multiInit*(): Pm{.cdecl, dynlib: libname, importc: "curl_multi_init".}
proc multiAddHandle*(multi_handle: Pm, handle: PCurl): TMcode{.cdecl, 
    dynlib: libname, importc: "curl_multi_add_handle".}
proc multiRemoveHandle*(multi_handle: Pm, handle: PCurl): TMcode{.cdecl, 
    dynlib: libname, importc: "curl_multi_remove_handle".}
proc multiFdset*(multi_handle: Pm, read_fd_set: PfdSet, write_fd_set: PfdSet, 
                  exc_fd_set: PfdSet, max_fd: var Int32): TMcode{.cdecl, 
    dynlib: libname, importc: "curl_multi_fdset".}
proc multiPerform*(multi_handle: Pm, running_handles: var Int32): TMcode{.
    cdecl, dynlib: libname, importc: "curl_multi_perform".}
proc multiCleanup*(multi_handle: Pm): TMcode{.cdecl, dynlib: libname, 
    importc: "curl_multi_cleanup".}
proc multiInfoRead*(multi_handle: Pm, msgs_in_queue: var Int32): Pmsg{.cdecl, 
    dynlib: libname, importc: "curl_multi_info_read".}
proc multiStrerror*(para1: TMcode): Cstring{.cdecl, dynlib: libname, 
    importc: "curl_multi_strerror".}
proc multiSocket*(multi_handle: Pm, s: Tsocket, running_handles: var Int32): TMcode{.
    cdecl, dynlib: libname, importc: "curl_multi_socket".}
proc multiSocketAll*(multi_handle: Pm, running_handles: var Int32): TMcode{.
    cdecl, dynlib: libname, importc: "curl_multi_socket_all".}
proc multiTimeout*(multi_handle: Pm, milliseconds: var Int32): TMcode{.cdecl, 
    dynlib: libname, importc: "curl_multi_timeout".}
proc multiSetopt*(multi_handle: Pm, option: TMoption): TMcode{.cdecl, varargs, 
    dynlib: libname, importc: "curl_multi_setopt".}
proc multiAssign*(multi_handle: Pm, sockfd: Tsocket, sockp: Pointer): TMcode{.
    cdecl, dynlib: libname, importc: "curl_multi_assign".}
