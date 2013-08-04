#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements a small wrapper for some needed Win API procedures,
## so that the Nimrod compiler does not depend on the huge Windows module.

const
  useWinUnicode* = not defined(useWinAnsi)

type
  THandle* = Int
  Long* = Int32
  Winbool* = Int32
  Dword* = Int32
  Hdc* = THandle
  Hglrc* = THandle

  TSECURITY_ATTRIBUTES* {.final, pure.} = object
    nLength*: Int32
    lpSecurityDescriptor*: Pointer
    bInheritHandle*: Winbool
  
  TSTARTUPINFO* {.final, pure.} = object
    cb*: Int32
    lpReserved*: Cstring
    lpDesktop*: Cstring
    lpTitle*: Cstring
    dwX*: Int32
    dwY*: Int32
    dwXSize*: Int32
    dwYSize*: Int32
    dwXCountChars*: Int32
    dwYCountChars*: Int32
    dwFillAttribute*: Int32
    dwFlags*: Int32
    wShowWindow*: Int16
    cbReserved2*: Int16
    lpReserved2*: Pointer
    hStdInput*: THANDLE
    hStdOutput*: THANDLE
    hStdError*: THANDLE

  TPROCESS_INFORMATION* {.final, pure.} = object
    hProcess*: THANDLE
    hThread*: THANDLE
    dwProcessId*: Int32
    dwThreadId*: Int32

  TFILETIME* {.final, pure.} = object ## CANNOT BE int64 BECAUSE OF ALIGNMENT
    dwLowDateTime*: Dword
    dwHighDateTime*: Dword
  
  TBY_HANDLE_FILE_INFORMATION* {.final, pure.} = object
    dwFileAttributes*: Dword
    ftCreationTime*: TFILETIME
    ftLastAccessTime*: TFILETIME
    ftLastWriteTime*: TFILETIME
    dwVolumeSerialNumber*: Dword
    nFileSizeHigh*: Dword
    nFileSizeLow*: Dword
    nNumberOfLinks*: Dword
    nFileIndexHigh*: Dword
    nFileIndexLow*: Dword

when useWinUnicode:
  type TWinChar* = TUtf16Char
else:
  type TWinChar* = char

const
  StartfUseshowwindow* = 1'i32
  StartfUsestdhandles* = 256'i32
  HighPriorityClass* = 128'i32
  IdlePriorityClass* = 64'i32
  NormalPriorityClass* = 32'i32
  RealtimePriorityClass* = 256'i32
  WaitObject0* = 0'i32
  WaitTimeout* = 0x00000102'i32
  WaitFailed* = 0xFFFFFFFF'i32
  Infinite* = -1'i32

  StdInputHandle* = -10'i32
  StdOutputHandle* = -11'i32
  StdErrorHandle* = -12'i32

  DetachedProcess* = 8'i32
  
  SwShownormal* = 1'i32
  InvalidHandleValue* = THANDLE(-1)
  
  CreateUnicodeEnvironment* = 1024'i32

proc closeHandle*(hObject: THANDLE): Winbool {.stdcall, dynlib: "kernel32",
    importc: "CloseHandle".}
    
proc readFile*(hFile: THandle, Buffer: Pointer, nNumberOfBytesToRead: Int32,
               lpNumberOfBytesRead: var Int32, lpOverlapped: Pointer): Winbool{.
    stdcall, dynlib: "kernel32", importc: "ReadFile".}
    
proc writeFile*(hFile: THandle, Buffer: Pointer, nNumberOfBytesToWrite: Int32,
                lpNumberOfBytesWritten: var Int32, 
                lpOverlapped: Pointer): Winbool{.
    stdcall, dynlib: "kernel32", importc: "WriteFile".}

proc createPipe*(hReadPipe, hWritePipe: var THandle,
                 lpPipeAttributes: var TSECURITY_ATTRIBUTES, 
                 nSize: Int32): Winbool{.
    stdcall, dynlib: "kernel32", importc: "CreatePipe".}

when useWinUnicode:
  proc createProcessW*(lpApplicationName, lpCommandLine: widecstring,
                     lpProcessAttributes: ptr TSECURITY_ATTRIBUTES,
                     lpThreadAttributes: ptr TSECURITY_ATTRIBUTES,
                     bInheritHandles: Winbool, dwCreationFlags: Int32,
                     lpEnvironment, lpCurrentDirectory: widecstring,
                     lpStartupInfo: var TSTARTUPINFO,
                     lpProcessInformation: var TPROCESS_INFORMATION): Winbool{.
    stdcall, dynlib: "kernel32", importc: "CreateProcessW".}

else:
  proc CreateProcessA*(lpApplicationName, lpCommandLine: cstring,
                       lpProcessAttributes: ptr TSECURITY_ATTRIBUTES,
                       lpThreadAttributes: ptr TSECURITY_ATTRIBUTES,
                       bInheritHandles: WINBOOL, dwCreationFlags: int32,
                       lpEnvironment: pointer, lpCurrentDirectory: cstring,
                       lpStartupInfo: var TSTARTUPINFO,
                       lpProcessInformation: var TPROCESS_INFORMATION): WINBOOL{.
      stdcall, dynlib: "kernel32", importc: "CreateProcessA".}


proc suspendThread*(hThread: THANDLE): Int32 {.stdcall, dynlib: "kernel32",
    importc: "SuspendThread".}
proc resumeThread*(hThread: THANDLE): Int32 {.stdcall, dynlib: "kernel32",
    importc: "ResumeThread".}

proc waitForSingleObject*(hHandle: THANDLE, dwMilliseconds: Int32): Int32 {.
    stdcall, dynlib: "kernel32", importc: "WaitForSingleObject".}

proc terminateProcess*(hProcess: THANDLE, uExitCode: Int): Winbool {.stdcall,
    dynlib: "kernel32", importc: "TerminateProcess".}

proc getExitCodeProcess*(hProcess: THANDLE, lpExitCode: var Int32): Winbool {.
    stdcall, dynlib: "kernel32", importc: "GetExitCodeProcess".}

proc getStdHandle*(nStdHandle: Int32): THANDLE {.stdcall, dynlib: "kernel32",
    importc: "GetStdHandle".}
proc setStdHandle*(nStdHandle: Int32, hHandle: THANDLE): Winbool {.stdcall,
    dynlib: "kernel32", importc: "SetStdHandle".}
proc flushFileBuffers*(hFile: THANDLE): Winbool {.stdcall, dynlib: "kernel32",
    importc: "FlushFileBuffers".}

proc GetLastError*(): Int32 {.importc, stdcall, dynlib: "kernel32".}

when useWinUnicode:
  proc FormatMessageW*(dwFlags: Int32, lpSource: Pointer,
                      dwMessageId, dwLanguageId: Int32,
                      lpBuffer: Pointer, nSize: Int32,
                      Arguments: Pointer): Int32 {.
                      importc, stdcall, dynlib: "kernel32".}
else:
  proc FormatMessageA*(dwFlags: int32, lpSource: pointer,
                    dwMessageId, dwLanguageId: int32,
                    lpBuffer: pointer, nSize: int32,
                    Arguments: pointer): int32 {.
                    importc, stdcall, dynlib: "kernel32".}

proc LocalFree*(p: Pointer) {.importc, stdcall, dynlib: "kernel32".}

when useWinUnicode:
  proc GetCurrentDirectoryW*(nBufferLength: Int32, 
                             lpBuffer: widecstring): Int32 {.
    importc, dynlib: "kernel32", stdcall.}
  proc SetCurrentDirectoryW*(lpPathName: widecstring): Int32 {.
    importc, dynlib: "kernel32", stdcall.}
  proc createDirectoryW*(pathName: widecstring, security: Pointer=nil): Int32 {.
    importc: "CreateDirectoryW", dynlib: "kernel32", stdcall.}
  proc RemoveDirectoryW*(lpPathName: widecstring): Int32 {.
    importc, dynlib: "kernel32", stdcall.}
  proc SetEnvironmentVariableW*(lpName, lpValue: widecstring): Int32 {.
    stdcall, dynlib: "kernel32", importc.}

  proc GetModuleFileNameW*(handle: THandle, buf: wideCString, 
                           size: Int32): Int32 {.importc, 
    dynlib: "kernel32", stdcall.}
else:
  proc GetCurrentDirectoryA*(nBufferLength: int32, lpBuffer: cstring): int32 {.
    importc, dynlib: "kernel32", stdcall.}
  proc SetCurrentDirectoryA*(lpPathName: cstring): int32 {.
    importc, dynlib: "kernel32", stdcall.}
  proc CreateDirectoryA*(pathName: cstring, security: Pointer=nil): int32 {.
    importc: "CreateDirectoryA", dynlib: "kernel32", stdcall.}
  proc RemoveDirectoryA*(lpPathName: cstring): int32 {.
    importc, dynlib: "kernel32", stdcall.}
  proc SetEnvironmentVariableA*(lpName, lpValue: cstring): int32 {.
    stdcall, dynlib: "kernel32", importc.}

  proc GetModuleFileNameA*(handle: THandle, buf: CString, size: int32): int32 {.
    importc, dynlib: "kernel32", stdcall.}
  
const
  FileAttributeArchive* = 32'i32
  FileAttributeCompressed* = 2048'i32
  FileAttributeNormal* = 128'i32
  FileAttributeDirectory* = 16'i32
  FileAttributeHidden* = 2'i32
  FileAttributeReadonly* = 1'i32
  FileAttributeSystem* = 4'i32
  FileAttributeTemporary* = 256'i32

  MaxPath* = 260
type
  TWIN32_FIND_DATA* {.pure.} = object
    dwFileAttributes*: Int32
    ftCreationTime*: TFILETIME
    ftLastAccessTime*: TFILETIME
    ftLastWriteTime*: TFILETIME
    nFileSizeHigh*: Int32
    nFileSizeLow*: Int32
    dwReserved0: Int32
    dwReserved1: Int32
    cFileName*: Array[0..(MAX_PATH) - 1, TWinChar]
    cAlternateFileName*: Array[0..13, TWinChar]

when useWinUnicode:
  proc findFirstFileW*(lpFileName: widecstring,
                      lpFindFileData: var TWIN32_FIND_DATA): THANDLE {.
      stdcall, dynlib: "kernel32", importc: "FindFirstFileW".}
  proc findNextFileW*(hFindFile: THANDLE,
                     lpFindFileData: var TWIN32_FIND_DATA): Int32 {.
      stdcall, dynlib: "kernel32", importc: "FindNextFileW".}
else:
  proc FindFirstFileA*(lpFileName: cstring,
                      lpFindFileData: var TWIN32_FIND_DATA): THANDLE {.
      stdcall, dynlib: "kernel32", importc: "FindFirstFileA".}
  proc FindNextFileA*(hFindFile: THANDLE,
                     lpFindFileData: var TWIN32_FIND_DATA): int32 {.
      stdcall, dynlib: "kernel32", importc: "FindNextFileA".}

proc findClose*(hFindFile: THANDLE) {.stdcall, dynlib: "kernel32",
  importc: "FindClose".}

when useWinUnicode:
  proc GetFullPathNameW*(lpFileName: widecstring, nBufferLength: Int32,
                        lpBuffer: widecstring, 
                        lpFilePart: var widecstring): Int32 {.
                        stdcall, dynlib: "kernel32", importc.}
  proc GetFileAttributesW*(lpFileName: widecstring): Int32 {.
                          stdcall, dynlib: "kernel32", importc.}
  proc setFileAttributesW*(lpFileName: widecstring, 
                           dwFileAttributes: Int32): Winbool {.
      stdcall, dynlib: "kernel32", importc: "SetFileAttributesW".}

  proc CopyFileW*(lpExistingFileName, lpNewFileName: wideCString,
                 bFailIfExists: Cint): Cint {.
    importc, stdcall, dynlib: "kernel32".}

  proc GetEnvironmentStringsW*(): widecstring {.
    stdcall, dynlib: "kernel32", importc.}
  proc FreeEnvironmentStringsW*(para1: widecstring): Int32 {.
    stdcall, dynlib: "kernel32", importc.}

  proc GetCommandLineW*(): wideCString {.importc, stdcall, dynlib: "kernel32".}

else:
  proc GetFullPathNameA*(lpFileName: cstring, nBufferLength: int32,
                        lpBuffer: cstring, lpFilePart: var cstring): int32 {.
                        stdcall, dynlib: "kernel32", importc.}
  proc GetFileAttributesA*(lpFileName: cstring): int32 {.
                          stdcall, dynlib: "kernel32", importc.}
  proc SetFileAttributesA*(lpFileName: cstring, 
                           dwFileAttributes: int32): WINBOOL {.
      stdcall, dynlib: "kernel32", importc: "SetFileAttributesA".}

  proc CopyFileA*(lpExistingFileName, lpNewFileName: CString,
                 bFailIfExists: cint): cint {.
    importc, stdcall, dynlib: "kernel32".}

  proc GetEnvironmentStringsA*(): cstring {.
    stdcall, dynlib: "kernel32", importc.}
  proc FreeEnvironmentStringsA*(para1: cstring): int32 {.
    stdcall, dynlib: "kernel32", importc.}

  proc GetCommandLineA*(): CString {.importc, stdcall, dynlib: "kernel32".}

proc rdFileTime*(f: TFILETIME): Int64 = 
  result = ze64(f.dwLowDateTime) or (ze64(f.dwHighDateTime) shl 32)

proc rdFileSize*(f: TWin32FindData): Int64 = 
  result = ze64(f.nFileSizeLow) or (ze64(f.nFileSizeHigh) shl 32)

proc getSystemTimeAsFileTime*(lpSystemTimeAsFileTime: var TFILETIME) {.
  importc: "GetSystemTimeAsFileTime", dynlib: "kernel32", stdcall.}

proc sleep*(dwMilliseconds: Int32){.stdcall, dynlib: "kernel32",
                                    importc: "Sleep".}

when useWinUnicode:
  proc shellExecuteW*(HWND: THandle, lpOperation, lpFile,
                     lpParameters, lpDirectory: widecstring,
                     nShowCmd: Int32): THandle{.
      stdcall, dynlib: "shell32.dll", importc: "ShellExecuteW".}

else:
  proc ShellExecuteA*(HWND: THandle, lpOperation, lpFile,
                     lpParameters, lpDirectory: cstring,
                     nShowCmd: int32): THandle{.
      stdcall, dynlib: "shell32.dll", importc: "ShellExecuteA".}
  
proc getFileInformationByHandle*(hFile: THandle,
  lpFileInformation: ptr TBY_HANDLE_FILE_INFORMATION): Winbool{.
    stdcall, dynlib: "kernel32", importc: "GetFileInformationByHandle".}

const
  WsadescriptionLen* = 256
  WsasysStatusLen* = 128
  FdSetsize* = 64
  MsgPeek* = 2
 
  InaddrAny* = 0
  InaddrLoopback* = 0x7F000001
  InaddrBroadcast* = -1
  InaddrNone* = -1
  
  ws2dll = "Ws2_32.dll"

  Wsaewouldblock* = 10035
  Wsaeinprogress* = 10036

proc wSAGetLastError*(): Cint {.importc: "WSAGetLastError", dynlib: ws2dll.}

type
  TWSAData* {.pure, final, importc: "WSADATA", header: "Winsock2.h".} = object 
    wVersion, wHighVersion: Int16
    szDescription: Array[0..WSADESCRIPTION_LEN, Char]
    szSystemStatus: Array[0..WSASYS_STATUS_LEN, Char]
    iMaxSockets, iMaxUdpDg: Int16
    lpVendorInfo: Cstring
    
  TSockAddr* {.pure, final, importc: "SOCKADDR", header: "Winsock2.h".} = object 
    sa_family*: Int16 # unsigned
    sa_data: Array[0..13, Char]

  TInAddr* {.pure, final, importc: "IN_ADDR", header: "Winsock2.h".} = object
    s_addr*: Int32  # IP address
  
  TsockaddrIn* {.pure, final, importc: "SOCKADDR_IN", 
                  header: "Winsock2.h".} = object
    sin_family*: Int16
    sin_port*: Int16 # unsigned
    sin_addr*: TInAddr
    sin_zero*: Array[0..7, Char]

  Tin6Addr* {.pure, final, importc: "IN6_ADDR", header: "Winsock2.h".} = object 
    bytes*: Array[0..15, Char]

  TsockaddrIn6* {.pure, final, importc: "SOCKADDR_IN6", 
                   header: "Winsock2.h".} = object
    sin6_family*: Int16
    sin6_port*: Int16 # unsigned
    sin6_flowinfo*: Int32 # unsigned
    sin6_addr*: Tin6Addr
    sin6_scope_id*: Int32 # unsigned

  TsockaddrIn6Old* {.pure, final.} = object
    sin6_family*: Int16
    sin6_port*: Int16 # unsigned
    sin6_flowinfo*: Int32 # unsigned
    sin6_addr*: Tin6Addr

  TServent* {.pure, final.} = object
    s_name*: Cstring
    s_aliases*: CstringArray
    when defined(cpu64):
      s_proto*: Cstring
      s_port*: Int16
    else:
      s_port*: int16
      s_proto*: cstring

  Thostent* {.pure, final.} = object
    h_name*: Cstring
    h_aliases*: CstringArray
    h_addrtype*: Int16
    h_length*: Int16
    h_addr_list*: CstringArray
    
  TWinSocket* = Cint
  
  TFdSet* {.pure, final.} = object
    fdCount*: Cint # unsigned
    fdArray*: Array[0..FD_SETSIZE-1, TWinSocket]
    
  TTimeval* {.pure, final.} = object
    tv_sec*, tv_usec*: Int32
    
  TAddrInfo* {.pure, final.} = object
    ai_flags*: Cint         ## Input flags. 
    ai_family*: Cint        ## Address family of socket. 
    ai_socktype*: Cint      ## Socket type. 
    ai_protocol*: Cint      ## Protocol of socket. 
    ai_addrlen*: Int        ## Length of socket address. 
    ai_canonname*: Cstring  ## Canonical name of service location.
    ai_addr*: ptr TSockAddr ## Socket address of socket. 
    ai_next*: ptr TAddrInfo ## Pointer to next in list. 

  Tsocklen* = Cuint

var
  SOMAXCONN* {.importc, header: "Winsock2.h".}: Cint

proc getservbyname*(name, proto: Cstring): ptr TServent {.
  stdcall, importc: "getservbyname", dynlib: ws2dll.}

proc getservbyport*(port: Cint, proto: Cstring): ptr TServent {.
  stdcall, importc: "getservbyport", dynlib: ws2dll.}

proc gethostbyaddr*(ip: ptr TInAddr, len: Cuint, theType: Cint): ptr Thostent {.
  stdcall, importc: "gethostbyaddr", dynlib: ws2dll.}

proc gethostbyname*(name: Cstring): ptr Thostent {.
  stdcall, importc: "gethostbyname", dynlib: ws2dll.}

proc socket*(af, typ, protocol: Cint): TWinSocket {.
  stdcall, importc: "socket", dynlib: ws2dll.}

proc closesocket*(s: TWinSocket): Cint {.
  stdcall, importc: "closesocket", dynlib: ws2dll.}

proc accept*(s: TWinSocket, a: ptr TSockAddr, addrlen: ptr Tsocklen): TWinSocket {.
  stdcall, importc: "accept", dynlib: ws2dll.}
proc bindSocket*(s: TWinSocket, name: ptr TSockAddr, namelen: Tsocklen): Cint {.
  stdcall, importc: "bind", dynlib: ws2dll.}
proc connect*(s: TWinSocket, name: ptr TSockAddr, namelen: Tsocklen): Cint {.
  stdcall, importc: "connect", dynlib: ws2dll.}
proc getsockname*(s: TWinSocket, name: ptr TSockAddr, 
                  namelen: ptr Tsocklen): Cint {.
  stdcall, importc: "getsockname", dynlib: ws2dll.}
proc getsockopt*(s: TWinSocket, level, optname: Cint, optval: Pointer,
                 optlen: ptr Tsocklen): Cint {.
  stdcall, importc: "getsockopt", dynlib: ws2dll.}
proc setsockopt*(s: TWinSocket, level, optname: Cint, optval: Pointer,
                 optlen: Tsocklen): Cint {.
  stdcall, importc: "setsockopt", dynlib: ws2dll.}

proc listen*(s: TWinSocket, backlog: Cint): Cint {.
  stdcall, importc: "listen", dynlib: ws2dll.}
proc recv*(s: TWinSocket, buf: Pointer, len, flags: Cint): Cint {.
  stdcall, importc: "recv", dynlib: ws2dll.}
proc recvfrom*(s: TWinSocket, buf: Cstring, len, flags: Cint, 
               fromm: ptr TSockAddr, fromlen: ptr Tsocklen): Cint {.
  stdcall, importc: "recvfrom", dynlib: ws2dll.}
proc select*(nfds: Cint, readfds, writefds, exceptfds: ptr TFdSet,
             timeout: ptr TTimeval): Cint {.
  stdcall, importc: "select", dynlib: ws2dll.}
proc send*(s: TWinSocket, buf: Pointer, len, flags: Cint): Cint {.
  stdcall, importc: "send", dynlib: ws2dll.}
proc sendto*(s: TWinSocket, buf: Pointer, len, flags: Cint,
             to: ptr TSockAddr, tolen: Tsocklen): Cint {.
  stdcall, importc: "sendto", dynlib: ws2dll.}

proc shutdown*(s: TWinSocket, how: Cint): Cint {.
  stdcall, importc: "shutdown", dynlib: ws2dll.}
  
proc getnameinfo*(a1: ptr Tsockaddr, a2: Tsocklen,
                  a3: Cstring, a4: Tsocklen, a5: Cstring,
                  a6: Tsocklen, a7: Cint): Cint {.
  stdcall, importc: "getnameinfo", dynlib: ws2dll.}
  
proc inetAddr*(cp: Cstring): Int32 {.
  stdcall, importc: "inet_addr", dynlib: ws2dll.} 

proc wSAFDIsSet(s: TWinSocket, FDSet: var TFDSet): Bool {.
  stdcall, importc: "__WSAFDIsSet", dynlib: ws2dll.}

proc fdIsset*(Socket: TWinSocket, FDSet: var TFDSet): Cint = 
  result = if wSAFDIsSet(socket, fDSet): 1'i32 else: 0'i32

proc fdSet*(Socket: TWinSocket, FDSet: var TFDSet) = 
  if fDSet.fd_count < FD_SETSIZE:
    fDSet.fd_array[Int(fDSet.fd_count)] = socket
    inc(fDSet.fd_count)

proc fdZero*(FDSet: var TFDSet) =
  fDSet.fd_count = 0

proc wSAStartup*(wVersionRequired: Int16, WSData: ptr TWSAData): Cint {.
  stdcall, importc: "WSAStartup", dynlib: ws2dll.}

proc getaddrinfo*(nodename, servname: Cstring, hints: ptr TAddrInfo,
                  res: var ptr TAddrInfo): Cint {.
  stdcall, importc: "getaddrinfo", dynlib: ws2dll.}

proc freeaddrinfo*(ai: ptr TAddrInfo) {.
  stdcall, importc: "freeaddrinfo", dynlib: ws2dll.}

proc inet_ntoa*(i: TInAddr): Cstring {.
  stdcall, importc, dynlib: ws2dll.}

const
  MaximumWaitObjects* = 0x00000040

type
  TWOHandleArray* = Array[0..MAXIMUM_WAIT_OBJECTS - 1, THANDLE]
  PWOHandleArray* = ptr TWOHandleArray

proc waitForMultipleObjects*(nCount: Dword, lpHandles: PWOHandleArray,
                             bWaitAll: Winbool, dwMilliseconds: Dword): Dword{.
    stdcall, dynlib: "kernel32", importc: "WaitForMultipleObjects".}
    
    
# for memfiles.nim:

const
  GenericRead* = 0x80000000'i32
  GenericAll* = 0x10000000'i32
  FileShareRead* = 1'i32
  FileShareDelete* = 4'i32
  FileShareWrite* = 2'i32
 
  CreateAlways* = 2'i32
  OpenExisting* = 3'i32
  FileBegin* = 0'i32
  InvalidSetFilePointer* = -1'i32
  NoError* = 0'i32
  PageReadonly* = 2'i32
  PageReadwrite* = 4'i32
  FileMapRead* = 4'i32
  FileMapWrite* = 2'i32
  InvalidFileSize* = -1'i32

  FileFlagBackupSemantics* = 33554432'i32

when useWinUnicode:
  proc createFileW*(lpFileName: widecstring, dwDesiredAccess, dwShareMode: Dword,
                    lpSecurityAttributes: Pointer,
                    dwCreationDisposition, dwFlagsAndAttributes: Dword,
                    hTemplateFile: THANDLE): THANDLE {.
      stdcall, dynlib: "kernel32", importc: "CreateFileW".}
else:
  proc CreateFileA*(lpFileName: cstring, dwDesiredAccess, dwShareMode: DWORD,
                    lpSecurityAttributes: pointer,
                    dwCreationDisposition, dwFlagsAndAttributes: DWORD,
                    hTemplateFile: THANDLE): THANDLE {.
      stdcall, dynlib: "kernel32", importc: "CreateFileA".}

proc setEndOfFile*(hFile: THANDLE): Winbool {.stdcall, dynlib: "kernel32",
    importc: "SetEndOfFile".}

proc setFilePointer*(hFile: THANDLE, lDistanceToMove: Long,
                     lpDistanceToMoveHigh: ptr Long, 
                     dwMoveMethod: Dword): Dword {.
    stdcall, dynlib: "kernel32", importc: "SetFilePointer".}

proc getFileSize*(hFile: THANDLE, lpFileSizeHigh: ptr Dword): Dword{.stdcall,
    dynlib: "kernel32", importc: "GetFileSize".}

proc mapViewOfFileEx*(hFileMappingObject: THANDLE, dwDesiredAccess: Dword,
                      dwFileOffsetHigh, dwFileOffsetLow: Dword,
                      dwNumberOfBytesToMap: Dword, 
                      lpBaseAddress: Pointer): Pointer{.
    stdcall, dynlib: "kernel32", importc: "MapViewOfFileEx".}

proc createFileMappingW*(hFile: THANDLE,
                       lpFileMappingAttributes: Pointer,
                       flProtect, dwMaximumSizeHigh: Dword,
                       dwMaximumSizeLow: Dword, 
                       lpName: Pointer): THANDLE {.
  stdcall, dynlib: "kernel32", importc: "CreateFileMappingW".}

when not useWinUnicode:
  proc CreateFileMappingA*(hFile: THANDLE,
                           lpFileMappingAttributes: pointer,
                           flProtect, dwMaximumSizeHigh: DWORD,
                           dwMaximumSizeLow: DWORD, lpName: cstring): THANDLE {.
      stdcall, dynlib: "kernel32", importc: "CreateFileMappingA".}

proc unmapViewOfFile*(lpBaseAddress: Pointer): Winbool {.stdcall,
    dynlib: "kernel32", importc: "UnmapViewOfFile".}

