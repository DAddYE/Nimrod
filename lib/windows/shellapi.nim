#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2006 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

{.deadCodeElim: on.}

# leave out unused functions so the unit can be used on win2000 as well

#+-------------------------------------------------------------------------
#
#  Microsoft Windows
#  Copyright (c) Microsoft Corporation. All rights reserved.
#
#  File: shellapi.h
#
#  Header translation by Marco van de Voort for Free Pascal Platform
#  SDK dl'ed January 2002
#
#--------------------------------------------------------------------------

#
#    shellapi.h -  SHELL.DLL functions, types, and definitions
#    Copyright (c) Microsoft Corporation. All rights reserved.

import
  Windows

type
  HDROP* = THandle
  UINT_PTR* = ptr UINT
  DWORD_PTR* = ptr DWORD
  pHICON* = ptr HICON
  pBool* = ptr BOOL
  STARTUPINFOW* {.final.} = object # a guess. Omission should get fixed in Windows.
    cb*: DWORD
    lpReserved*: LPTSTR
    lpDesktop*: LPTSTR
    lpTitle*: LPTSTR
    dwX*: DWORD
    dwY*: DWORD
    dwXSize*: DWORD
    dwYSize*: DWORD
    dwXCountChars*: DWORD
    dwYCountChars*: DWORD
    dwFillAttribute*: DWORD
    dwFlags*: DWORD
    wShowWindow*: int16
    cbReserved2*: int16
    lpReserved2*: LPBYTE
    hStdInput*: HANDLE
    hStdOutput*: HANDLE
    hStdError*: HANDLE

  LPSTARTUPINFOW* = ptr STARTUPINFOW
  TSTARTUPINFOW* = STARTUPINFOW
  PSTARTUPINFOW* = ptr STARTUPINFOW #unicode

proc dragQueryFileA*(arg1: HDROP, arg2: UINT, arg3: LPSTR, arg4: UINT): UINT{.
    stdcall, dynlib: "shell32.dll", importc: "DragQueryFileA".}
proc dragQueryFileW*(arg1: HDROP, arg2: UINT, arg3: LPWSTR, arg4: UINT): UINT{.
    stdcall, dynlib: "shell32.dll", importc: "DragQueryFileW".}
proc dragQueryFile*(arg1: HDROP, arg2: UINT, arg3: LPSTR, arg4: UINT): UINT{.
    stdcall, dynlib: "shell32.dll", importc: "DragQueryFileA".}
proc dragQueryFile*(arg1: HDROP, arg2: UINT, arg3: LPWSTR, arg4: UINT): UINT{.
    stdcall, dynlib: "shell32.dll", importc: "DragQueryFileW".}
proc dragQueryPoint*(arg1: HDROP, arg2: LPPOINT): BOOL{.stdcall,
    dynlib: "shell32.dll", importc: "DragQueryPoint".}
proc dragFinish*(arg1: HDROP){.stdcall, dynlib: "shell32.dll",
                               importc: "DragFinish".}
proc dragAcceptFiles*(hwnd: HWND, arg2: BOOL){.stdcall, dynlib: "shell32.dll",
    importc: "DragAcceptFiles".}
proc shellExecuteA*(HWND: hwnd, lpOperation: LPCSTR, lpFile: LPCSTR,
                    lpParameters: LPCSTR, lpDirectory: LPCSTR, nShowCmd: int32): HInst{.
    stdcall, dynlib: "shell32.dll", importc: "ShellExecuteA".}
proc shellExecuteW*(hwnd: HWND, lpOperation: LPCWSTR, lpFile: LPCWSTR,
                    lpParameters: LPCWSTR, lpDirectory: LPCWSTR, nShowCmd: int32): HInst{.
    stdcall, dynlib: "shell32.dll", importc: "ShellExecuteW".}
proc shellExecute*(HWND: hwnd, lpOperation: LPCSTR, lpFile: LPCSTR,
                   lpParameters: LPCSTR, lpDirectory: LPCSTR, nShowCmd: int32): HInst{.
    stdcall, dynlib: "shell32.dll", importc: "ShellExecuteA".}
proc shellExecute*(hwnd: HWND, lpOperation: LPCWSTR, lpFile: LPCWSTR,
                   lpParameters: LPCWSTR, lpDirectory: LPCWSTR, nShowCmd: int32): HInst{.
    stdcall, dynlib: "shell32.dll", importc: "ShellExecuteW".}
proc findExecutableA*(lpFile: LPCSTR, lpDirectory: LPCSTR, lpResult: LPSTR): HInst{.
    stdcall, dynlib: "shell32.dll", importc: "FindExecutableA".}
proc findExecutableW*(lpFile: LPCWSTR, lpDirectory: LPCWSTR, lpResult: LPWSTR): HInst{.
    stdcall, dynlib: "shell32.dll", importc: "FindExecutableW".}
proc findExecutable*(lpFile: LPCSTR, lpDirectory: LPCSTR, lpResult: LPSTR): HInst{.
    stdcall, dynlib: "shell32.dll", importc: "FindExecutableA".}
proc findExecutable*(lpFile: LPCWSTR, lpDirectory: LPCWSTR, lpResult: LPWSTR): HInst{.
    stdcall, dynlib: "shell32.dll", importc: "FindExecutableW".}
proc commandLineToArgvW*(lpCmdLine: LPCWSTR, pNumArgs: ptr int32): pLPWSTR{.
    stdcall, dynlib: "shell32.dll", importc: "CommandLineToArgvW".}
proc shellAboutA*(HWND: hWnd, szApp: LPCSTR, szOtherStuff: LPCSTR, HICON: hIcon): int32{.
    stdcall, dynlib: "shell32.dll", importc: "ShellAboutA".}
proc shellAboutW*(HWND: hWnd, szApp: LPCWSTR, szOtherStuff: LPCWSTR,
                  HICON: hIcon): int32{.stdcall, dynlib: "shell32.dll",
                                        importc: "ShellAboutW".}
proc shellAbout*(HWND: hWnd, szApp: LPCSTR, szOtherStuff: LPCSTR, HICON: hIcon): int32{.
    stdcall, dynlib: "shell32.dll", importc: "ShellAboutA".}
proc shellAbout*(HWND: hWnd, szApp: LPCWSTR, szOtherStuff: LPCWSTR, HICON: hIcon): int32{.
    stdcall, dynlib: "shell32.dll", importc: "ShellAboutW".}
proc duplicateIcon*(inst: HINST, icon: HICON): HIcon{.stdcall,
    dynlib: "shell32.dll", importc: "DuplicateIcon".}
proc extractAssociatedIconA*(hInst: HINST, lpIconPath: LPSTR, lpiIcon: LPWORD): HICON{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractAssociatedIconA".}
proc extractAssociatedIconW*(hInst: HINST, lpIconPath: LPWSTR, lpiIcon: LPWORD): HICON{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractAssociatedIconW".}
proc extractAssociatedIcon*(hInst: HINST, lpIconPath: LPSTR, lpiIcon: LPWORD): HICON{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractAssociatedIconA".}
proc extractAssociatedIcon*(hInst: HINST, lpIconPath: LPWSTR, lpiIcon: LPWORD): HICON{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractAssociatedIconW".}
proc extractIconA*(hInst: HINST, lpszExeFileName: LPCSTR, nIconIndex: UINT): HICON{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconA".}
proc extractIconW*(hInst: HINST, lpszExeFileName: LPCWSTR, nIconIndex: UINT): HICON{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconW".}
proc extractIcon*(hInst: HINST, lpszExeFileName: LPCSTR, nIconIndex: UINT): HICON{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconA".}
proc extractIcon*(hInst: HINST, lpszExeFileName: LPCWSTR, nIconIndex: UINT): HICON{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconW".}
  # if(WINVER >= 0x0400)
type                          # init with sizeof(DRAGINFO)
  DRAGINFOA* {.final.} = object
    uSize*: UINT
    pt*: POINT
    fNC*: BOOL
    lpFileList*: LPSTR
    grfKeyState*: DWORD

  TDRAGINFOA* = DRAGINFOA
  LPDRAGINFOA* = ptr DRAGINFOA # init with sizeof(DRAGINFO)
  DRAGINFOW* {.final.} = object
    uSize*: UINT
    pt*: POINT
    fNC*: BOOL
    lpFileList*: LPWSTR
    grfKeyState*: DWORD

  TDRAGINFOW* = DRAGINFOW
  LPDRAGINFOW* = ptr DRAGINFOW

when defined(UNICODE):
  type
    DRAGINFO* = DRAGINFOW
    TDRAGINFO* = DRAGINFOW
    LPDRAGINFO* = LPDRAGINFOW
else:
  type
    DRAGINFO* = DRAGINFOA
    TDRAGINFO* = DRAGINFOW
    LPDRAGINFO* = LPDRAGINFOA
const
  ABM_NEW* = 0x00000000
  ABM_REMOVE* = 0x00000001
  ABM_QUERYPOS* = 0x00000002
  ABM_SETPOS* = 0x00000003
  ABM_GETSTATE* = 0x00000004
  ABM_GETTASKBARPOS* = 0x00000005
  ABM_ACTIVATE* = 0x00000006  # lParam == TRUE/FALSE means activate/deactivate
  ABM_GETAUTOHIDEBAR* = 0x00000007
  ABM_SETAUTOHIDEBAR* = 0x00000008 # this can fail at any time.  MUST check the result
                                   # lParam = TRUE/FALSE  Set/Unset
                                   # uEdge = what edge
  ABM_WINDOWPOSCHANGED* = 0x00000009
  ABM_SETSTATE* = 0x0000000A
  ABN_STATECHANGE* = 0x00000000 # these are put in the wparam of callback messages
  ABN_POSCHANGED* = 0x00000001
  ABN_FULLSCREENAPP* = 0x00000002
  ABN_WINDOWARRANGE* = 0x00000003 # lParam == TRUE means hide
                                  # flags for get state
  ABS_AUTOHIDE* = 0x00000001
  ABS_ALWAYSONTOP* = 0x00000002
  ABE_LEFT* = 0
  ABE_TOP* = 1
  ABE_RIGHT* = 2
  ABE_BOTTOM* = 3

type
  AppBarData* {.final.} = object
    cbSize*: DWORD
    hWnd*: HWND
    uCallbackMessage*: UINT
    uEdge*: UINT
    rc*: RECT
    lParam*: LPARAM           # message specific

  TAPPBARDATA* = AppBarData
  PAPPBARDATA* = ptr AppBarData

proc sHAppBarMessage*(dwMessage: DWORD, pData: APPBARDATA): UINT_PTR{.stdcall,
    dynlib: "shell32.dll", importc: "SHAppBarMessage".}
  #
  #  EndAppBar
  #
proc doEnvironmentSubstA*(szString: LPSTR, cchString: UINT): DWORD{.stdcall,
    dynlib: "shell32.dll", importc: "DoEnvironmentSubstA".}
proc doEnvironmentSubstW*(szString: LPWSTR, cchString: UINT): DWORD{.stdcall,
    dynlib: "shell32.dll", importc: "DoEnvironmentSubstW".}
proc doEnvironmentSubst*(szString: LPSTR, cchString: UINT): DWORD{.stdcall,
    dynlib: "shell32.dll", importc: "DoEnvironmentSubstA".}
proc doEnvironmentSubst*(szString: LPWSTR, cchString: UINT): DWORD{.stdcall,
    dynlib: "shell32.dll", importc: "DoEnvironmentSubstW".}
  #Macro
proc eIRESID*(x: int32): int32
proc extractIconExA*(lpszFile: LPCSTR, nIconIndex: int32, phiconLarge: pHICON,
                     phiconSmall: pHIcon, nIcons: UINT): UINT{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExA".}
proc extractIconExW*(lpszFile: LPCWSTR, nIconIndex: int32, phiconLarge: pHICON,
                     phiconSmall: pHIcon, nIcons: UINT): UINT{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExW".}
proc extractIconExA*(lpszFile: LPCSTR, nIconIndex: int32,
                     phiconLarge: var HICON, phiconSmall: var HIcon,
                     nIcons: UINT): UINT{.stdcall, dynlib: "shell32.dll",
    importc: "ExtractIconExA".}
proc extractIconExW*(lpszFile: LPCWSTR, nIconIndex: int32,
                     phiconLarge: var HICON, phiconSmall: var HIcon,
                     nIcons: UINT): UINT{.stdcall, dynlib: "shell32.dll",
    importc: "ExtractIconExW".}
proc extractIconEx*(lpszFile: LPCSTR, nIconIndex: int32, phiconLarge: pHICON,
                    phiconSmall: pHIcon, nIcons: UINT): UINT{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExA".}
proc extractIconEx*(lpszFile: LPCWSTR, nIconIndex: int32, phiconLarge: pHICON,
                    phiconSmall: pHIcon, nIcons: UINT): UINT{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExW".}
proc extractIconEx*(lpszFile: LPCSTR, nIconIndex: int32, phiconLarge: var HICON,
                    phiconSmall: var HIcon, nIcons: UINT): UINT{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExA".}
proc extractIconEx*(lpszFile: LPCWSTR, nIconIndex: int32,
                    phiconLarge: var HICON, phiconSmall: var HIcon, nIcons: UINT): UINT{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconExW".}
  #
  # Shell File Operations
  #
  #ifndef FO_MOVE  //these need to be kept in sync with the ones in shlobj.h}
const
  FO_MOVE* = 0x00000001
  FO_COPY* = 0x00000002
  FO_DELETE* = 0x00000003
  FO_RENAME* = 0x00000004
  FOF_MULTIDESTFILES* = 0x00000001
  FOF_CONFIRMMOUSE* = 0x00000002
  FOF_SILENT* = 0x00000004    # don't create progress/report
  FOF_RENAMEONCOLLISION* = 0x00000008
  FOF_NOCONFIRMATION* = 0x00000010 # Don't prompt the user.
  FOF_WANTMAPPINGHANDLE* = 0x00000020 # Fill in SHFILEOPSTRUCT.hNameMappings
  FOF_ALLOWUNDO* = 0x00000040 # Must be freed using SHFreeNameMappings
  FOF_FILESONLY* = 0x00000080 # on *.*, do only files
  FOF_SIMPLEPROGRESS* = 0x00000100 # means don't show names of files
  FOF_NOCONFIRMMKDIR* = 0x00000200 # don't confirm making any needed dirs
  FOF_NOERRORUI* = 0x00000400 # don't put up error UI
  FOF_NOCOPYSECURITYATTRIBS* = 0x00000800 # dont copy NT file Security Attributes
  FOF_NORECURSION* = 0x00001000 # don't recurse into directories.
                                #if (_WIN32_IE >= 0x0500)
  FOF_NO_CONNECTED_ELEMENTS* = 0x00002000 # don't operate on connected elements.
  FOF_WANTNUKEWARNING* = 0x00004000 # during delete operation, warn if nuking instead of recycling (partially overrides FOF_NOCONFIRMATION)
                                    #endif
                                    #if (_WIN32_WINNT >= 0x0501)
  FOF_NORECURSEREPARSE* = 0x00008000 # treat reparse points as objects, not containers
                                     #endif

type
  FILEOP_FLAGS* = int16

const
  PO_DELETE* = 0x00000013     # printer is being deleted
  PO_RENAME* = 0x00000014     # printer is being renamed
  PO_PORTCHANGE* = 0x00000020 # port this printer connected to is being changed
                              # if this id is set, the strings received by
                              # the copyhook are a doubly-null terminated
                              # list of strings.  The first is the printer
                              # name and the second is the printer port.
  PO_REN_PORT* = 0x00000034   # PO_RENAME and PO_PORTCHANGE at same time.
                              # no POF_ flags currently defined

type
  PRINTEROP_FLAGS* = int16 #endif}
                           # FO_MOVE
                           # implicit parameters are:
                           #      if pFrom or pTo are unqualified names the current directories are
                           #      taken from the global current drive/directory settings managed
                           #      by Get/SetCurrentDrive/Directory
                           #
                           #      the global confirmation settings
                           # only used if FOF_SIMPLEPROGRESS

type
  SHFILEOPSTRUCTA* {.final.} = object
    hwnd*: HWND
    wFunc*: UINT
    pFrom*: LPCSTR
    pTo*: LPCSTR
    fFlags*: FILEOP_FLAGS
    fAnyOperationsAborted*: BOOL
    hNameMappings*: LPVOID
    lpszProgressTitle*: LPCSTR # only used if FOF_SIMPLEPROGRESS

  TSHFILEOPSTRUCTA* = SHFILEOPSTRUCTA
  LPSHFILEOPSTRUCTA* = ptr SHFILEOPSTRUCTA
  SHFILEOPSTRUCTW* {.final.} = object
    hwnd*: HWND
    wFunc*: UINT
    pFrom*: LPCWSTR
    pTo*: LPCWSTR
    fFlags*: FILEOP_FLAGS
    fAnyOperationsAborted*: BOOL
    hNameMappings*: LPVOID
    lpszProgressTitle*: LPCWSTR

  TSHFILEOPSTRUCTW* = SHFILEOPSTRUCTW
  LPSHFILEOPSTRUCTW* = ptr SHFILEOPSTRUCTW

when defined(UNICODE):
  type
    SHFILEOPSTRUCT* = SHFILEOPSTRUCTW
    TSHFILEOPSTRUCT* = SHFILEOPSTRUCTW
    LPSHFILEOPSTRUCT* = LPSHFILEOPSTRUCTW
else:
  type
    SHFILEOPSTRUCT* = SHFILEOPSTRUCTA
    TSHFILEOPSTRUCT* = SHFILEOPSTRUCTA
    LPSHFILEOPSTRUCT* = LPSHFILEOPSTRUCTA
proc sHFileOperationA*(lpFileOp: LPSHFILEOPSTRUCTA): int32{.stdcall,
    dynlib: "shell32.dll", importc: "SHFileOperationA".}
proc sHFileOperationW*(lpFileOp: LPSHFILEOPSTRUCTW): int32{.stdcall,
    dynlib: "shell32.dll", importc: "SHFileOperationW".}
proc sHFileOperation*(lpFileOp: LPSHFILEOPSTRUCTA): int32{.stdcall,
    dynlib: "shell32.dll", importc: "SHFileOperationA".}
proc sHFileOperation*(lpFileOp: LPSHFILEOPSTRUCTW): int32{.stdcall,
    dynlib: "shell32.dll", importc: "SHFileOperationW".}
proc sHFreeNameMappings*(hNameMappings: THandle){.stdcall,
    dynlib: "shell32.dll", importc: "SHFreeNameMappings".}
type
  SHNAMEMAPPINGA* {.final.} = object
    pszOldPath*: LPSTR
    pszNewPath*: LPSTR
    cchOldPath*: int32
    cchNewPath*: int32

  TSHNAMEMAPPINGA* = SHNAMEMAPPINGA
  LPSHNAMEMAPPINGA* = ptr SHNAMEMAPPINGA
  SHNAMEMAPPINGW* {.final.} = object
    pszOldPath*: LPWSTR
    pszNewPath*: LPWSTR
    cchOldPath*: int32
    cchNewPath*: int32

  TSHNAMEMAPPINGW* = SHNAMEMAPPINGW
  LPSHNAMEMAPPINGW* = ptr SHNAMEMAPPINGW

when not(defined(UNICODE)):
  type
    SHNAMEMAPPING* = SHNAMEMAPPINGW
    TSHNAMEMAPPING* = SHNAMEMAPPINGW
    LPSHNAMEMAPPING* = LPSHNAMEMAPPINGW
else:
  type
    SHNAMEMAPPING* = SHNAMEMAPPINGA
    TSHNAMEMAPPING* = SHNAMEMAPPINGA
    LPSHNAMEMAPPING* = LPSHNAMEMAPPINGA
#
# End Shell File Operations
#
#
#  Begin ShellExecuteEx and family
#
# ShellExecute() and ShellExecuteEx() error codes
# regular WinExec() codes

const
  SE_ERR_FNF* = 2             # file not found
  SE_ERR_PNF* = 3             # path not found
  SE_ERR_ACCESSDENIED* = 5    # access denied
  SE_ERR_OOM* = 8             # out of memory
  SE_ERR_DLLNOTFOUND* = 32    # endif   WINVER >= 0x0400
                              # error values for ShellExecute() beyond the regular WinExec() codes
  SE_ERR_SHARE* = 26
  SE_ERR_ASSOCINCOMPLETE* = 27
  SE_ERR_DDETIMEOUT* = 28
  SE_ERR_DDEFAIL* = 29
  SE_ERR_DDEBUSY* = 30
  SE_ERR_NOASSOC* = 31        #if(WINVER >= 0x0400)}
                              # Note CLASSKEY overrides CLASSNAME
  SEE_MASK_CLASSNAME* = 0x00000001
  SEE_MASK_CLASSKEY* = 0x00000003 # Note INVOKEIDLIST overrides IDLIST
  SEE_MASK_IDLIST* = 0x00000004
  SEE_MASK_INVOKEIDLIST* = 0x0000000C
  SEE_MASK_ICON* = 0x00000010
  SEE_MASK_HOTKEY* = 0x00000020
  SEE_MASK_NOCLOSEPROCESS* = 0x00000040
  SEE_MASK_CONNECTNETDRV* = 0x00000080
  SEE_MASK_FLAG_DDEWAIT* = 0x00000100
  SEE_MASK_DOENVSUBST* = 0x00000200
  SEE_MASK_FLAG_NO_UI* = 0x00000400
  SEE_MASK_UNICODE* = 0x00004000
  SEE_MASK_NO_CONSOLE* = 0x00008000
  SEE_MASK_ASYNCOK* = 0x00100000
  SEE_MASK_HMONITOR* = 0x00200000 #if (_WIN32_IE >= 0x0500)
  SEE_MASK_NOQUERYCLASSSTORE* = 0x01000000
  SEE_MASK_WAITFORINPUTIDLE* = 0x02000000 #endif  (_WIN32_IE >= 0x500)
                                          #if (_WIN32_IE >= 0x0560)
  SEE_MASK_FLAG_LOG_USAGE* = 0x04000000 #endif
                                        # (_WIN32_IE >= 0x560)

type
  SHELLEXECUTEINFOA* {.final.} = object
    cbSize*: DWORD
    fMask*: ULONG
    hwnd*: HWND
    lpVerb*: LPCSTR
    lpFile*: LPCSTR
    lpParameters*: LPCSTR
    lpDirectory*: LPCSTR
    nShow*: int32
    hInstApp*: HINST
    lpIDList*: LPVOID
    lpClass*: LPCSTR
    hkeyClass*: HKEY
    dwHotKey*: DWORD
    hMonitor*: HANDLE         # also: hIcon
    hProcess*: HANDLE

  TSHELLEXECUTEINFOA* = SHELLEXECUTEINFOA
  LPSHELLEXECUTEINFOA* = ptr SHELLEXECUTEINFOA
  SHELLEXECUTEINFOW* {.final.} = object
    cbSize*: DWORD
    fMask*: ULONG
    hwnd*: HWND
    lpVerb*: lpcwstr
    lpFile*: lpcwstr
    lpParameters*: lpcwstr
    lpDirectory*: lpcwstr
    nShow*: int32
    hInstApp*: HINST
    lpIDList*: LPVOID
    lpClass*: LPCWSTR
    hkeyClass*: HKEY
    dwHotKey*: DWORD
    hMonitor*: HANDLE         # also: hIcon
    hProcess*: HANDLE

  TSHELLEXECUTEINFOW* = SHELLEXECUTEINFOW
  LPSHELLEXECUTEINFOW* = ptr SHELLEXECUTEINFOW

when defined(UNICODE):
  type
    SHELLEXECUTEINFO* = SHELLEXECUTEINFOW
    TSHELLEXECUTEINFO* = SHELLEXECUTEINFOW
    LPSHELLEXECUTEINFO* = LPSHELLEXECUTEINFOW
else:
  type
    SHELLEXECUTEINFO* = SHELLEXECUTEINFOA
    TSHELLEXECUTEINFO* = SHELLEXECUTEINFOA
    LPSHELLEXECUTEINFO* = LPSHELLEXECUTEINFOA
proc shellExecuteExA*(lpExecInfo: LPSHELLEXECUTEINFOA): bool{.stdcall,
    dynlib: "shell32.dll", importc: "ShellExecuteExA".}
proc shellExecuteExW*(lpExecInfo: LPSHELLEXECUTEINFOW): bool{.stdcall,
    dynlib: "shell32.dll", importc: "ShellExecuteExW".}
proc shellExecuteEx*(lpExecInfo: LPSHELLEXECUTEINFOA): bool{.stdcall,
    dynlib: "shell32.dll", importc: "ShellExecuteExA".}
proc shellExecuteEx*(lpExecInfo: LPSHELLEXECUTEINFOW): bool{.stdcall,
    dynlib: "shell32.dll", importc: "ShellExecuteExW".}
proc winExecErrorA*(HWND: hwnd, error: int32, lpstrFileName: LPCSTR,
                    lpstrTitle: LPCSTR){.stdcall, dynlib: "shell32.dll",
    importc: "WinExecErrorA".}
proc winExecErrorW*(HWND: hwnd, error: int32, lpstrFileName: LPCWSTR,
                    lpstrTitle: LPCWSTR){.stdcall, dynlib: "shell32.dll",
    importc: "WinExecErrorW".}
proc winExecError*(HWND: hwnd, error: int32, lpstrFileName: LPCSTR,
                   lpstrTitle: LPCSTR){.stdcall, dynlib: "shell32.dll",
                                        importc: "WinExecErrorA".}
proc winExecError*(HWND: hwnd, error: int32, lpstrFileName: LPCWSTR,
                   lpstrTitle: LPCWSTR){.stdcall, dynlib: "shell32.dll",
    importc: "WinExecErrorW".}
type
  SHCREATEPROCESSINFOW* {.final.} = object
    cbSize*: DWORD
    fMask*: ULONG
    hwnd*: HWND
    pszFile*: LPCWSTR
    pszParameters*: LPCWSTR
    pszCurrentDirectory*: LPCWSTR
    hUserToken*: HANDLE
    lpProcessAttributes*: LPSECURITY_ATTRIBUTES
    lpThreadAttributes*: LPSECURITY_ATTRIBUTES
    bInheritHandles*: BOOL
    dwCreationFlags*: DWORD
    lpStartupInfo*: LPSTARTUPINFOW
    lpProcessInformation*: LPPROCESS_INFORMATION

  TSHCREATEPROCESSINFOW* = SHCREATEPROCESSINFOW
  PSHCREATEPROCESSINFOW* = ptr SHCREATEPROCESSINFOW

proc sHCreateProcessAsUserW*(pscpi: PSHCREATEPROCESSINFOW): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHCreateProcessAsUserW".}
  #
  #  End ShellExecuteEx and family }
  #
  #
  # RecycleBin
  #
  # struct for query recycle bin info
type
  SHQUERYRBINFO* {.final.} = object
    cbSize*: DWORD
    i64Size*: int64
    i64NumItems*: int64

  TSHQUERYRBINFO* = SHQUERYRBINFO
  LPSHQUERYRBINFO* = ptr SHQUERYRBINFO # flags for SHEmptyRecycleBin

const
  SHERB_NOCONFIRMATION* = 0x00000001
  SHERB_NOPROGRESSUI* = 0x00000002
  SHERB_NOSOUND* = 0x00000004

proc sHQueryRecycleBinA*(pszRootPath: LPCSTR, pSHQueryRBInfo: LPSHQUERYRBINFO): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHQueryRecycleBinA".}
proc sHQueryRecycleBinW*(pszRootPath: LPCWSTR, pSHQueryRBInfo: LPSHQUERYRBINFO): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHQueryRecycleBinW".}
proc sHQueryRecycleBin*(pszRootPath: LPCSTR, pSHQueryRBInfo: LPSHQUERYRBINFO): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHQueryRecycleBinA".}
proc sHQueryRecycleBin*(pszRootPath: LPCWSTR, pSHQueryRBInfo: LPSHQUERYRBINFO): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHQueryRecycleBinW".}
proc sHEmptyRecycleBinA*(hwnd: HWND, pszRootPath: LPCSTR, dwFlags: DWORD): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHEmptyRecycleBinA".}
proc sHEmptyRecycleBinW*(hwnd: HWND, pszRootPath: LPCWSTR, dwFlags: DWORD): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHEmptyRecycleBinW".}
proc sHEmptyRecycleBin*(hwnd: HWND, pszRootPath: LPCSTR, dwFlags: DWORD): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHEmptyRecycleBinA".}
proc sHEmptyRecycleBin*(hwnd: HWND, pszRootPath: LPCWSTR, dwFlags: DWORD): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHEmptyRecycleBinW".}
  #
  # end of RecycleBin
  #
  #
  # Tray notification definitions
  #
type
  NOTIFYICONDATAA* {.final.} = object
    cbSize*: DWORD
    hWnd*: HWND
    uID*: UINT
    uFlags*: UINT
    uCallbackMessage*: UINT
    hIcon*: HICON
    szTip*: array[0..127, CHAR]
    dwState*: DWORD
    dwStateMask*: DWORD
    szInfo*: array[0..255, CHAR]
    uTimeout*: UINT           # also: uVersion
    szInfoTitle*: array[0..63, CHAR]
    dwInfoFlags*: DWORD
    guidItem*: TGUID

  TNOTIFYICONDATAA* = NOTIFYICONDATAA
  PNOTIFYICONDATAA* = ptr NOTIFYICONDATAA
  NOTIFYICONDATAW* {.final.} = object
    cbSize*: DWORD
    hWnd*: HWND
    uID*: UINT
    uFlags*: UINT
    uCallbackMessage*: UINT
    hIcon*: HICON
    szTip*: array[0..127, WCHAR]
    dwState*: DWORD
    dwStateMask*: DWORD
    szInfo*: array[0..255, WCHAR]
    uTimeout*: UINT           # also uVersion : UINT
    szInfoTitle*: array[0..63, CHAR]
    dwInfoFlags*: DWORD
    guidItem*: TGUID

  TNOTIFYICONDATAW* = NOTIFYICONDATAW
  PNOTIFYICONDATAW* = ptr NOTIFYICONDATAW

when defined(UNICODE):
  type
    NOTIFYICONDATA* = NOTIFYICONDATAW
    TNOTIFYICONDATA* = NOTIFYICONDATAW
    PNOTIFYICONDATA* = PNOTIFYICONDATAW
else:
  type
    NOTIFYICONDATA* = NOTIFYICONDATAA
    TNOTIFYICONDATA* = NOTIFYICONDATAA
    PNOTIFYICONDATA* = PNOTIFYICONDATAA
const
  NIN_SELECT* = WM_USER + 0
  NINF_KEY* = 0x00000001
  NIN_KEYSELECT* = NIN_SELECT or NINF_KEY
  NIN_BALLOONSHOW* = WM_USER + 2
  NIN_BALLOONHIDE* = WM_USER + 3
  NIN_BALLOONTIMEOUT* = WM_USER + 4
  NIN_BALLOONUSERCLICK* = WM_USER + 5
  NIM_ADD* = 0x00000000
  NIM_MODIFY* = 0x00000001
  NIM_DELETE* = 0x00000002
  NIM_SETFOCUS* = 0x00000003
  NIM_SETVERSION* = 0x00000004
  NOTIFYICON_VERSION* = 3
  NIF_MESSAGE* = 0x00000001
  NIF_ICON* = 0x00000002
  NIF_TIP* = 0x00000004
  NIF_STATE* = 0x00000008
  NIF_INFO* = 0x00000010
  NIF_GUID* = 0x00000020
  NIS_HIDDEN* = 0x00000001
  NIS_SHAREDICON* = 0x00000002 # says this is the source of a shared icon
                               # Notify Icon Infotip flags
  NIIF_NONE* = 0x00000000     # icon flags are mutually exclusive
                              # and take only the lowest 2 bits
  NIIF_INFO* = 0x00000001
  NIIF_WARNING* = 0x00000002
  NIIF_ERROR* = 0x00000003
  NIIF_ICON_MASK* = 0x0000000F
  NIIF_NOSOUND* = 0x00000010

proc shell_NotifyIconA*(dwMessage: Dword, lpData: PNOTIFYICONDATAA): bool{.
    stdcall, dynlib: "shell32.dll", importc: "Shell_NotifyIconA".}
proc shell_NotifyIconW*(dwMessage: Dword, lpData: PNOTIFYICONDATAW): bool{.
    stdcall, dynlib: "shell32.dll", importc: "Shell_NotifyIconW".}
proc shell_NotifyIcon*(dwMessage: Dword, lpData: PNOTIFYICONDATAA): bool{.
    stdcall, dynlib: "shell32.dll", importc: "Shell_NotifyIconA".}
proc shell_NotifyIcon*(dwMessage: Dword, lpData: PNOTIFYICONDATAW): bool{.
    stdcall, dynlib: "shell32.dll", importc: "Shell_NotifyIconW".}
  #
  #       The SHGetFileInfo API provides an easy way to get attributes
  #       for a file given a pathname.
  #
  #         PARAMETERS
  #
  #           pszPath              file name to get info about
  #           dwFileAttributes     file attribs, only used with SHGFI_USEFILEATTRIBUTES
  #           psfi                 place to return file info
  #           cbFileInfo           size of structure
  #           uFlags               flags
  #
  #         RETURN
  #           TRUE if things worked
  #
  # out: icon
  # out: icon index
  # out: SFGAO_ flags
  # out: display name (or path)
  # out: type name
type
  SHFILEINFOA* {.final.} = object
    hIcon*: HICON             # out: icon
    iIcon*: int32             # out: icon index
    dwAttributes*: DWORD      # out: SFGAO_ flags
    szDisplayName*: array[0..(MAX_PATH) - 1, CHAR] # out: display name (or path)
    szTypeName*: array[0..79, CHAR] # out: type name

  TSHFILEINFOA* = SHFILEINFOA
  pSHFILEINFOA* = ptr SHFILEINFOA
  SHFILEINFOW* {.final.} = object
    hIcon*: HICON             # out: icon
    iIcon*: int32             # out: icon index
    dwAttributes*: DWORD      # out: SFGAO_ flags
    szDisplayName*: array[0..(MAX_PATH) - 1, WCHAR] # out: display name (or path)
    szTypeName*: array[0..79, WCHAR] # out: type name

  TSHFILEINFOW* = SHFILEINFOW
  pSHFILEINFOW* = ptr SHFILEINFOW

when defined(UNICODE):
  type
    SHFILEINFO* = SHFILEINFOW
    TSHFILEINFO* = SHFILEINFOW
    pFILEINFO* = SHFILEINFOW
else:
  type
    SHFILEINFO* = SHFILEINFOA
    TSHFILEINFO* = SHFILEINFOA
    pFILEINFO* = SHFILEINFOA
# NOTE: This is also in shlwapi.h.  Please keep in synch.

const
  SHGFI_ICON* = 0x00000100    # get Icon
  SHGFI_DISPLAYNAME* = 0x00000200 # get display name
  SHGFI_TYPENAME* = 0x00000400 # get type name
  SHGFI_ATTRIBUTES* = 0x00000800 # get attributes
  SHGFI_ICONLOCATION* = 0x00001000 # get icon location
  SHGFI_EXETYPE* = 0x00002000 # return exe type
  SHGFI_SYSICONINDEX* = 0x00004000 # get system icon index
  SHGFI_LINKOVERLAY* = 0x00008000 # put a link overlay on icon
  SHGFI_SELECTED* = 0x00010000 # show icon in selected state
  SHGFI_ATTR_SPECIFIED* = 0x00020000 # get only specified attributes
  SHGFI_LARGEICON* = 0x00000000 # get large icon
  SHGFI_SMALLICON* = 0x00000001 # get small icon
  SHGFI_OPENICON* = 0x00000002 # get open icon
  SHGFI_SHELLICONSIZE* = 0x00000004 # get shell size icon
  SHGFI_PIDL* = 0x00000008    # pszPath is a pidl
  SHGFI_USEFILEATTRIBUTES* = 0x00000010 # use passed dwFileAttribute
  SHGFI_ADDOVERLAYS* = 0x00000020 # apply the appropriate overlays
  SHGFI_OVERLAYINDEX* = 0x00000040 # Get the index of the overlay
                                   # in the upper 8 bits of the iIcon

proc sHGetFileInfoA*(pszPath: LPCSTR, dwFileAttributes: DWORD,
                     psfi: pSHFILEINFOA, cbFileInfo, UFlags: UINT): DWORD{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoA".}
proc sHGetFileInfoW*(pszPath: LPCWSTR, dwFileAttributes: DWORD,
                     psfi: pSHFILEINFOW, cbFileInfo, UFlags: UINT): DWORD{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoW".}
proc sHGetFileInfo*(pszPath: LPCSTR, dwFileAttributes: DWORD,
                    psfi: pSHFILEINFOA, cbFileInfo, UFlags: UINT): DWORD{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoA".}
proc sHGetFileInfoA*(pszPath: LPCSTR, dwFileAttributes: DWORD,
                     psfi: var TSHFILEINFOA, cbFileInfo, UFlags: UINT): DWORD{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoA".}
proc sHGetFileInfoW*(pszPath: LPCWSTR, dwFileAttributes: DWORD,
                     psfi: var TSHFILEINFOW, cbFileInfo, UFlags: UINT): DWORD{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoW".}
proc sHGetFileInfo*(pszPath: LPCSTR, dwFileAttributes: DWORD,
                    psfi: var TSHFILEINFOA, cbFileInfo, UFlags: UINT): DWORD{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoA".}
proc sHGetFileInfo*(pszPath: LPCWSTR, dwFileAttributes: DWORD,
                    psfi: var TSHFILEINFOW, cbFileInfo, UFlags: UINT): DWORD{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoW".}
proc sHGetDiskFreeSpaceExA*(pszDirectoryName: LPCSTR,
                            pulFreeBytesAvailableToCaller: pULARGE_INTEGER,
                            pulTotalNumberOfBytes: pULARGE_INTEGER,
                            pulTotalNumberOfFreeBytes: pULARGE_INTEGER): bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExA".}
proc sHGetDiskFreeSpaceExW*(pszDirectoryName: LPCWSTR,
                            pulFreeBytesAvailableToCaller: pULARGE_INTEGER,
                            pulTotalNumberOfBytes: pULARGE_INTEGER,
                            pulTotalNumberOfFreeBytes: pULARGE_INTEGER): bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExW".}
proc sHGetDiskFreeSpaceEx*(pszDirectoryName: LPCSTR,
                           pulFreeBytesAvailableToCaller: pULARGE_INTEGER,
                           pulTotalNumberOfBytes: pULARGE_INTEGER,
                           pulTotalNumberOfFreeBytes: pULARGE_INTEGER): bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExA".}
proc sHGetDiskFreeSpace*(pszDirectoryName: LPCSTR,
                         pulFreeBytesAvailableToCaller: pULARGE_INTEGER,
                         pulTotalNumberOfBytes: pULARGE_INTEGER,
                         pulTotalNumberOfFreeBytes: pULARGE_INTEGER): bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExA".}
proc sHGetDiskFreeSpaceEx*(pszDirectoryName: LPCWSTR,
                           pulFreeBytesAvailableToCaller: pULARGE_INTEGER,
                           pulTotalNumberOfBytes: pULARGE_INTEGER,
                           pulTotalNumberOfFreeBytes: pULARGE_INTEGER): bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExW".}
proc sHGetDiskFreeSpace*(pszDirectoryName: LPCWSTR,
                         pulFreeBytesAvailableToCaller: pULARGE_INTEGER,
                         pulTotalNumberOfBytes: pULARGE_INTEGER,
                         pulTotalNumberOfFreeBytes: pULARGE_INTEGER): bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExW".}
proc sHGetNewLinkInfoA*(pszLinkTo: LPCSTR, pszDir: LPCSTR, pszName: LPSTR,
                        pfMustCopy: pBool, uFlags: UINT): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetNewLinkInfoA".}
proc sHGetNewLinkInfoW*(pszLinkTo: LPCWSTR, pszDir: LPCWSTR, pszName: LPWSTR,
                        pfMustCopy: pBool, uFlags: UINT): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetNewLinkInfoW".}
proc sHGetNewLinkInfo*(pszLinkTo: LPCSTR, pszDir: LPCSTR, pszName: LPSTR,
                       pfMustCopy: pBool, uFlags: UINT): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetNewLinkInfoA".}
proc sHGetNewLinkInfo*(pszLinkTo: LPCWSTR, pszDir: LPCWSTR, pszName: LPWSTR,
                       pfMustCopy: pBool, uFlags: UINT): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetNewLinkInfoW".}
const
  SHGNLI_PIDL* = 0x00000001   # pszLinkTo is a pidl
  SHGNLI_PREFIXNAME* = 0x00000002 # Make name "Shortcut to xxx"
  SHGNLI_NOUNIQUE* = 0x00000004 # don't do the unique name generation
  SHGNLI_NOLNK* = 0x00000008  # don't add ".lnk" extension
  PRINTACTION_OPEN* = 0
  PRINTACTION_PROPERTIES* = 1
  PRINTACTION_NETINSTALL* = 2
  PRINTACTION_NETINSTALLLINK* = 3
  PRINTACTION_TESTPAGE* = 4
  PRINTACTION_OPENNETPRN* = 5
  PRINTACTION_DOCUMENTDEFAULTS* = 6
  PRINTACTION_SERVERPROPERTIES* = 7

proc sHInvokePrinterCommandA*(HWND: hwnd, uAction: UINT, lpBuf1: LPCSTR,
                              lpBuf2: LPCSTR, fModal: bool): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandA".}
proc sHInvokePrinterCommandW*(HWND: hwnd, uAction: UINT, lpBuf1: LPCWSTR,
                              lpBuf2: LPCWSTR, fModal: bool): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandW".}
proc sHInvokePrinterCommand*(HWND: hwnd, uAction: UINT, lpBuf1: LPCSTR,
                             lpBuf2: LPCSTR, fModal: bool): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandA".}
proc sHInvokePrinterCommand*(HWND: hwnd, uAction: UINT, lpBuf1: LPCWSTR,
                             lpBuf2: LPCWSTR, fModal: bool): bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandW".}
proc sHLoadNonloadedIconOverlayIdentifiers*(): HResult{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandW".}
proc sHIsFileAvailableOffline*(pwszPath: LPCWSTR, pdwStatus: LPDWORD): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHIsFileAvailableOffline".}
const
  OFFLINE_STATUS_LOCAL* = 0x00000001 # If open, it's open locally
  OFFLINE_STATUS_REMOTE* = 0x00000002 # If open, it's open remotely
  OFFLINE_STATUS_INCOMPLETE* = 0x00000004 # The local copy is currently incomplete.
                                          # The file will not be available offline
                                          # until it has been synchronized.
                                          #  sets the specified path to use the string resource
                                          #  as the UI instead of the file system name

proc sHSetLocalizedName*(pszPath: LPWSTR, pszResModule: LPCWSTR, idsRes: int32): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHSetLocalizedName".}
proc sHEnumerateUnreadMailAccountsA*(hKeyUser: HKEY, dwIndex: DWORD,
                                     pszMailAddress: LPSTR,
                                     cchMailAddress: int32): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHEnumerateUnreadMailAccountsA".}
proc sHEnumerateUnreadMailAccountsW*(hKeyUser: HKEY, dwIndex: DWORD,
                                     pszMailAddress: LPWSTR,
                                     cchMailAddress: int32): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHEnumerateUnreadMailAccountsW".}
proc sHEnumerateUnreadMailAccounts*(hKeyUser: HKEY, dwIndex: DWORD,
                                    pszMailAddress: LPWSTR,
                                    cchMailAddress: int32): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHEnumerateUnreadMailAccountsW".}
proc sHGetUnreadMailCountA*(hKeyUser: HKEY, pszMailAddress: LPCSTR,
                            pdwCount: PDWORD, pFileTime: PFILETIME,
                            pszShellExecuteCommand: LPSTR,
                            cchShellExecuteCommand: int32): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetUnreadMailCountA".}
proc sHGetUnreadMailCountW*(hKeyUser: HKEY, pszMailAddress: LPCWSTR,
                            pdwCount: PDWORD, pFileTime: PFILETIME,
                            pszShellExecuteCommand: LPWSTR,
                            cchShellExecuteCommand: int32): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetUnreadMailCountW".}
proc sHGetUnreadMailCount*(hKeyUser: HKEY, pszMailAddress: LPCSTR,
                           pdwCount: PDWORD, pFileTime: PFILETIME,
                           pszShellExecuteCommand: LPSTR,
                           cchShellExecuteCommand: int32): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetUnreadMailCountA".}
proc sHGetUnreadMailCount*(hKeyUser: HKEY, pszMailAddress: LPCWSTR,
                           pdwCount: PDWORD, pFileTime: PFILETIME,
                           pszShellExecuteCommand: LPWSTR,
                           cchShellExecuteCommand: int32): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetUnreadMailCountW".}
proc sHSetUnreadMailCountA*(pszMailAddress: LPCSTR, dwCount: DWORD,
                            pszShellExecuteCommand: LPCSTR): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHSetUnreadMailCountA".}
proc sHSetUnreadMailCountW*(pszMailAddress: LPCWSTR, dwCount: DWORD,
                            pszShellExecuteCommand: LPCWSTR): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHSetUnreadMailCountW".}
proc sHSetUnreadMailCount*(pszMailAddress: LPCSTR, dwCount: DWORD,
                           pszShellExecuteCommand: LPCSTR): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHSetUnreadMailCountA".}
proc sHSetUnreadMailCount*(pszMailAddress: LPCWSTR, dwCount: DWORD,
                           pszShellExecuteCommand: LPCWSTR): HRESULT{.stdcall,
    dynlib: "shell32.dll", importc: "SHSetUnreadMailCountW".}
proc sHGetImageList*(iImageList: int32, riid: TIID, ppvObj: ptr pointer): HRESULT{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetImageList".}
const
  SHIL_LARGE* = 0             # normally 32x32
  SHIL_SMALL* = 1             # normally 16x16
  SHIL_EXTRALARGE* = 2
  SHIL_SYSSMALL* = 3          # like SHIL_SMALL, but tracks system small icon metric correctly
  SHIL_LAST* = SHIL_SYSSMALL

# implementation

proc eIRESID(x: int32): int32 =
  result = -x
