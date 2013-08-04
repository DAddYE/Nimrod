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
  Hdrop* = THandle
  UintPtr* = ptr Uint
  DwordPtr* = ptr Dword
  PHICON* = ptr Hicon
  PBool* = ptr Bool
  Startupinfow* {.final.} = object # a guess. Omission should get fixed in Windows.
    cb*: Dword
    lpReserved*: Lptstr
    lpDesktop*: Lptstr
    lpTitle*: Lptstr
    dwX*: Dword
    dwY*: Dword
    dwXSize*: Dword
    dwYSize*: Dword
    dwXCountChars*: Dword
    dwYCountChars*: Dword
    dwFillAttribute*: Dword
    dwFlags*: Dword
    wShowWindow*: Int16
    cbReserved2*: Int16
    lpReserved2*: Lpbyte
    hStdInput*: Handle
    hStdOutput*: Handle
    hStdError*: Handle

  Lpstartupinfow* = ptr Startupinfow
  TSTARTUPINFOW* = Startupinfow
  Pstartupinfow* = ptr Startupinfow #unicode

proc dragQueryFileA*(arg1: Hdrop, arg2: Uint, arg3: Lpstr, arg4: Uint): Uint{.
    stdcall, dynlib: "shell32.dll", importc: "DragQueryFileA".}
proc dragQueryFileW*(arg1: Hdrop, arg2: Uint, arg3: Lpwstr, arg4: Uint): Uint{.
    stdcall, dynlib: "shell32.dll", importc: "DragQueryFileW".}
proc dragQueryFile*(arg1: Hdrop, arg2: Uint, arg3: Lpstr, arg4: Uint): Uint{.
    stdcall, dynlib: "shell32.dll", importc: "DragQueryFileA".}
proc dragQueryFile*(arg1: Hdrop, arg2: Uint, arg3: Lpwstr, arg4: Uint): Uint{.
    stdcall, dynlib: "shell32.dll", importc: "DragQueryFileW".}
proc dragQueryPoint*(arg1: Hdrop, arg2: Lppoint): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "DragQueryPoint".}
proc dragFinish*(arg1: Hdrop){.stdcall, dynlib: "shell32.dll",
                               importc: "DragFinish".}
proc dragAcceptFiles*(hwnd: Hwnd, arg2: Bool){.stdcall, dynlib: "shell32.dll",
    importc: "DragAcceptFiles".}
proc shellExecuteA*(HWND: Hwnd, lpOperation: Lpcstr, lpFile: Lpcstr,
                    lpParameters: Lpcstr, lpDirectory: Lpcstr, nShowCmd: Int32): Hinst{.
    stdcall, dynlib: "shell32.dll", importc: "ShellExecuteA".}
proc shellExecuteW*(hwnd: Hwnd, lpOperation: Lpcwstr, lpFile: Lpcwstr,
                    lpParameters: Lpcwstr, lpDirectory: Lpcwstr, nShowCmd: Int32): Hinst{.
    stdcall, dynlib: "shell32.dll", importc: "ShellExecuteW".}
proc shellExecute*(HWND: Hwnd, lpOperation: Lpcstr, lpFile: Lpcstr,
                   lpParameters: Lpcstr, lpDirectory: Lpcstr, nShowCmd: Int32): Hinst{.
    stdcall, dynlib: "shell32.dll", importc: "ShellExecuteA".}
proc shellExecute*(hwnd: Hwnd, lpOperation: Lpcwstr, lpFile: Lpcwstr,
                   lpParameters: Lpcwstr, lpDirectory: Lpcwstr, nShowCmd: Int32): Hinst{.
    stdcall, dynlib: "shell32.dll", importc: "ShellExecuteW".}
proc findExecutableA*(lpFile: Lpcstr, lpDirectory: Lpcstr, lpResult: Lpstr): Hinst{.
    stdcall, dynlib: "shell32.dll", importc: "FindExecutableA".}
proc findExecutableW*(lpFile: Lpcwstr, lpDirectory: Lpcwstr, lpResult: Lpwstr): Hinst{.
    stdcall, dynlib: "shell32.dll", importc: "FindExecutableW".}
proc findExecutable*(lpFile: Lpcstr, lpDirectory: Lpcstr, lpResult: Lpstr): Hinst{.
    stdcall, dynlib: "shell32.dll", importc: "FindExecutableA".}
proc findExecutable*(lpFile: Lpcwstr, lpDirectory: Lpcwstr, lpResult: Lpwstr): Hinst{.
    stdcall, dynlib: "shell32.dll", importc: "FindExecutableW".}
proc commandLineToArgvW*(lpCmdLine: Lpcwstr, pNumArgs: ptr Int32): PLPWStr{.
    stdcall, dynlib: "shell32.dll", importc: "CommandLineToArgvW".}
proc shellAboutA*(HWND: Hwnd, szApp: Lpcstr, szOtherStuff: Lpcstr, HICON: Hicon): Int32{.
    stdcall, dynlib: "shell32.dll", importc: "ShellAboutA".}
proc shellAboutW*(HWND: Hwnd, szApp: Lpcwstr, szOtherStuff: Lpcwstr,
                  HICON: Hicon): Int32{.stdcall, dynlib: "shell32.dll",
                                        importc: "ShellAboutW".}
proc shellAbout*(HWND: Hwnd, szApp: Lpcstr, szOtherStuff: Lpcstr, HICON: Hicon): Int32{.
    stdcall, dynlib: "shell32.dll", importc: "ShellAboutA".}
proc shellAbout*(HWND: Hwnd, szApp: Lpcwstr, szOtherStuff: Lpcwstr, HICON: Hicon): Int32{.
    stdcall, dynlib: "shell32.dll", importc: "ShellAboutW".}
proc duplicateIcon*(inst: Hinst, icon: Hicon): Hicon{.stdcall,
    dynlib: "shell32.dll", importc: "DuplicateIcon".}
proc extractAssociatedIconA*(hInst: Hinst, lpIconPath: Lpstr, lpiIcon: Lpword): Hicon{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractAssociatedIconA".}
proc extractAssociatedIconW*(hInst: Hinst, lpIconPath: Lpwstr, lpiIcon: Lpword): Hicon{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractAssociatedIconW".}
proc extractAssociatedIcon*(hInst: Hinst, lpIconPath: Lpstr, lpiIcon: Lpword): Hicon{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractAssociatedIconA".}
proc extractAssociatedIcon*(hInst: Hinst, lpIconPath: Lpwstr, lpiIcon: Lpword): Hicon{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractAssociatedIconW".}
proc extractIconA*(hInst: Hinst, lpszExeFileName: Lpcstr, nIconIndex: Uint): Hicon{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconA".}
proc extractIconW*(hInst: Hinst, lpszExeFileName: Lpcwstr, nIconIndex: Uint): Hicon{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconW".}
proc extractIcon*(hInst: Hinst, lpszExeFileName: Lpcstr, nIconIndex: Uint): Hicon{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconA".}
proc extractIcon*(hInst: Hinst, lpszExeFileName: Lpcwstr, nIconIndex: Uint): Hicon{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconW".}
  # if(WINVER >= 0x0400)
type                          # init with sizeof(DRAGINFO)
  Draginfoa* {.final.} = object
    uSize*: Uint
    pt*: Point
    fNC*: Bool
    lpFileList*: Lpstr
    grfKeyState*: Dword

  TDRAGINFOA* = Draginfoa
  Lpdraginfoa* = ptr Draginfoa # init with sizeof(DRAGINFO)
  Draginfow* {.final.} = object
    uSize*: Uint
    pt*: Point
    fNC*: Bool
    lpFileList*: Lpwstr
    grfKeyState*: Dword

  TDRAGINFOW* = Draginfow
  Lpdraginfow* = ptr Draginfow

when defined(UNICODE):
  type
    DRAGINFO* = DRAGINFOW
    TDRAGINFO* = DRAGINFOW
    LPDRAGINFO* = LPDRAGINFOW
else:
  type
    Draginfo* = Draginfoa
    TDRAGINFO* = Draginfow
    Lpdraginfo* = Lpdraginfoa
const
  AbmNew* = 0x00000000
  AbmRemove* = 0x00000001
  AbmQuerypos* = 0x00000002
  AbmSetpos* = 0x00000003
  AbmGetstate* = 0x00000004
  AbmGettaskbarpos* = 0x00000005
  AbmActivate* = 0x00000006  # lParam == TRUE/FALSE means activate/deactivate
  AbmGetautohidebar* = 0x00000007
  AbmSetautohidebar* = 0x00000008 # this can fail at any time.  MUST check the result
                                   # lParam = TRUE/FALSE  Set/Unset
                                   # uEdge = what edge
  AbmWindowposchanged* = 0x00000009
  AbmSetstate* = 0x0000000A
  AbnStatechange* = 0x00000000 # these are put in the wparam of callback messages
  AbnPoschanged* = 0x00000001
  AbnFullscreenapp* = 0x00000002
  AbnWindowarrange* = 0x00000003 # lParam == TRUE means hide
                                  # flags for get state
  AbsAutohide* = 0x00000001
  AbsAlwaysontop* = 0x00000002
  AbeLeft* = 0
  AbeTop* = 1
  AbeRight* = 2
  AbeBottom* = 3

type
  AppBarData* {.final.} = object
    cbSize*: Dword
    hWnd*: Hwnd
    uCallbackMessage*: Uint
    uEdge*: Uint
    rc*: Rect
    lParam*: Lparam           # message specific

  TAPPBARDATA* = AppBarData
  Pappbardata* = ptr AppBarData

proc sHAppBarMessage*(dwMessage: Dword, pData: AppBarData): UintPtr{.stdcall,
    dynlib: "shell32.dll", importc: "SHAppBarMessage".}
  #
  #  EndAppBar
  #
proc doEnvironmentSubstA*(szString: Lpstr, cchString: Uint): Dword{.stdcall,
    dynlib: "shell32.dll", importc: "DoEnvironmentSubstA".}
proc doEnvironmentSubstW*(szString: Lpwstr, cchString: Uint): Dword{.stdcall,
    dynlib: "shell32.dll", importc: "DoEnvironmentSubstW".}
proc doEnvironmentSubst*(szString: Lpstr, cchString: Uint): Dword{.stdcall,
    dynlib: "shell32.dll", importc: "DoEnvironmentSubstA".}
proc doEnvironmentSubst*(szString: Lpwstr, cchString: Uint): Dword{.stdcall,
    dynlib: "shell32.dll", importc: "DoEnvironmentSubstW".}
  #Macro
proc eiresid*(x: Int32): Int32
proc extractIconExA*(lpszFile: Lpcstr, nIconIndex: Int32, phiconLarge: PHICON,
                     phiconSmall: PHICON, nIcons: Uint): Uint{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExA".}
proc extractIconExW*(lpszFile: Lpcwstr, nIconIndex: Int32, phiconLarge: PHICON,
                     phiconSmall: PHICON, nIcons: Uint): Uint{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExW".}
proc extractIconExA*(lpszFile: Lpcstr, nIconIndex: Int32,
                     phiconLarge: var Hicon, phiconSmall: var Hicon,
                     nIcons: Uint): Uint{.stdcall, dynlib: "shell32.dll",
    importc: "ExtractIconExA".}
proc extractIconExW*(lpszFile: Lpcwstr, nIconIndex: Int32,
                     phiconLarge: var Hicon, phiconSmall: var Hicon,
                     nIcons: Uint): Uint{.stdcall, dynlib: "shell32.dll",
    importc: "ExtractIconExW".}
proc extractIconEx*(lpszFile: Lpcstr, nIconIndex: Int32, phiconLarge: PHICON,
                    phiconSmall: PHICON, nIcons: Uint): Uint{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExA".}
proc extractIconEx*(lpszFile: Lpcwstr, nIconIndex: Int32, phiconLarge: PHICON,
                    phiconSmall: PHICON, nIcons: Uint): Uint{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExW".}
proc extractIconEx*(lpszFile: Lpcstr, nIconIndex: Int32, phiconLarge: var Hicon,
                    phiconSmall: var Hicon, nIcons: Uint): Uint{.stdcall,
    dynlib: "shell32.dll", importc: "ExtractIconExA".}
proc extractIconEx*(lpszFile: Lpcwstr, nIconIndex: Int32,
                    phiconLarge: var Hicon, phiconSmall: var Hicon, nIcons: Uint): Uint{.
    stdcall, dynlib: "shell32.dll", importc: "ExtractIconExW".}
  #
  # Shell File Operations
  #
  #ifndef FO_MOVE  //these need to be kept in sync with the ones in shlobj.h}
const
  FoMove* = 0x00000001
  FoCopy* = 0x00000002
  FoDelete* = 0x00000003
  FoRename* = 0x00000004
  FofMultidestfiles* = 0x00000001
  FofConfirmmouse* = 0x00000002
  FofSilent* = 0x00000004    # don't create progress/report
  FofRenameoncollision* = 0x00000008
  FofNoconfirmation* = 0x00000010 # Don't prompt the user.
  FofWantmappinghandle* = 0x00000020 # Fill in SHFILEOPSTRUCT.hNameMappings
  FofAllowundo* = 0x00000040 # Must be freed using SHFreeNameMappings
  FofFilesonly* = 0x00000080 # on *.*, do only files
  FofSimpleprogress* = 0x00000100 # means don't show names of files
  FofNoconfirmmkdir* = 0x00000200 # don't confirm making any needed dirs
  FofNoerrorui* = 0x00000400 # don't put up error UI
  FofNocopysecurityattribs* = 0x00000800 # dont copy NT file Security Attributes
  FofNorecursion* = 0x00001000 # don't recurse into directories.
                                #if (_WIN32_IE >= 0x0500)
  FofNoConnectedElements* = 0x00002000 # don't operate on connected elements.
  FofWantnukewarning* = 0x00004000 # during delete operation, warn if nuking instead of recycling (partially overrides FOF_NOCONFIRMATION)
                                    #endif
                                    #if (_WIN32_WINNT >= 0x0501)
  FofNorecursereparse* = 0x00008000 # treat reparse points as objects, not containers
                                     #endif

type
  FileopFlags* = Int16

const
  PoDelete* = 0x00000013     # printer is being deleted
  PoRename* = 0x00000014     # printer is being renamed
  PoPortchange* = 0x00000020 # port this printer connected to is being changed
                              # if this id is set, the strings received by
                              # the copyhook are a doubly-null terminated
                              # list of strings.  The first is the printer
                              # name and the second is the printer port.
  PoRenPort* = 0x00000034   # PO_RENAME and PO_PORTCHANGE at same time.
                              # no POF_ flags currently defined

type
  PrinteropFlags* = Int16 #endif}
                           # FO_MOVE
                           # implicit parameters are:
                           #      if pFrom or pTo are unqualified names the current directories are
                           #      taken from the global current drive/directory settings managed
                           #      by Get/SetCurrentDrive/Directory
                           #
                           #      the global confirmation settings
                           # only used if FOF_SIMPLEPROGRESS

type
  Shfileopstructa* {.final.} = object
    hwnd*: Hwnd
    wFunc*: Uint
    pFrom*: Lpcstr
    pTo*: Lpcstr
    fFlags*: FileopFlags
    fAnyOperationsAborted*: Bool
    hNameMappings*: Lpvoid
    lpszProgressTitle*: Lpcstr # only used if FOF_SIMPLEPROGRESS

  TSHFILEOPSTRUCTA* = Shfileopstructa
  Lpshfileopstructa* = ptr Shfileopstructa
  Shfileopstructw* {.final.} = object
    hwnd*: Hwnd
    wFunc*: Uint
    pFrom*: Lpcwstr
    pTo*: Lpcwstr
    fFlags*: FileopFlags
    fAnyOperationsAborted*: Bool
    hNameMappings*: Lpvoid
    lpszProgressTitle*: Lpcwstr

  TSHFILEOPSTRUCTW* = Shfileopstructw
  Lpshfileopstructw* = ptr Shfileopstructw

when defined(UNICODE):
  type
    SHFILEOPSTRUCT* = SHFILEOPSTRUCTW
    TSHFILEOPSTRUCT* = SHFILEOPSTRUCTW
    LPSHFILEOPSTRUCT* = LPSHFILEOPSTRUCTW
else:
  type
    Shfileopstruct* = Shfileopstructa
    TSHFILEOPSTRUCT* = Shfileopstructa
    Lpshfileopstruct* = Lpshfileopstructa
proc sHFileOperationA*(lpFileOp: Lpshfileopstructa): Int32{.stdcall,
    dynlib: "shell32.dll", importc: "SHFileOperationA".}
proc sHFileOperationW*(lpFileOp: Lpshfileopstructw): Int32{.stdcall,
    dynlib: "shell32.dll", importc: "SHFileOperationW".}
proc sHFileOperation*(lpFileOp: Lpshfileopstructa): Int32{.stdcall,
    dynlib: "shell32.dll", importc: "SHFileOperationA".}
proc sHFileOperation*(lpFileOp: Lpshfileopstructw): Int32{.stdcall,
    dynlib: "shell32.dll", importc: "SHFileOperationW".}
proc sHFreeNameMappings*(hNameMappings: THandle){.stdcall,
    dynlib: "shell32.dll", importc: "SHFreeNameMappings".}
type
  Shnamemappinga* {.final.} = object
    pszOldPath*: Lpstr
    pszNewPath*: Lpstr
    cchOldPath*: Int32
    cchNewPath*: Int32

  TSHNAMEMAPPINGA* = Shnamemappinga
  Lpshnamemappinga* = ptr Shnamemappinga
  Shnamemappingw* {.final.} = object
    pszOldPath*: Lpwstr
    pszNewPath*: Lpwstr
    cchOldPath*: Int32
    cchNewPath*: Int32

  TSHNAMEMAPPINGW* = Shnamemappingw
  Lpshnamemappingw* = ptr Shnamemappingw

when not(defined(UNICODE)):
  type
    Shnamemapping* = Shnamemappingw
    TSHNAMEMAPPING* = Shnamemappingw
    Lpshnamemapping* = Lpshnamemappingw
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
  SeErrFnf* = 2             # file not found
  SeErrPnf* = 3             # path not found
  SeErrAccessdenied* = 5    # access denied
  SeErrOom* = 8             # out of memory
  SeErrDllnotfound* = 32    # endif   WINVER >= 0x0400
                              # error values for ShellExecute() beyond the regular WinExec() codes
  SeErrShare* = 26
  SeErrAssocincomplete* = 27
  SeErrDdetimeout* = 28
  SeErrDdefail* = 29
  SeErrDdebusy* = 30
  SeErrNoassoc* = 31        #if(WINVER >= 0x0400)}
                              # Note CLASSKEY overrides CLASSNAME
  SeeMaskClassname* = 0x00000001
  SeeMaskClasskey* = 0x00000003 # Note INVOKEIDLIST overrides IDLIST
  SeeMaskIdlist* = 0x00000004
  SeeMaskInvokeidlist* = 0x0000000C
  SeeMaskIcon* = 0x00000010
  SeeMaskHotkey* = 0x00000020
  SeeMaskNocloseprocess* = 0x00000040
  SeeMaskConnectnetdrv* = 0x00000080
  SeeMaskFlagDdewait* = 0x00000100
  SeeMaskDoenvsubst* = 0x00000200
  SeeMaskFlagNoUi* = 0x00000400
  SeeMaskUnicode* = 0x00004000
  SeeMaskNoConsole* = 0x00008000
  SeeMaskAsyncok* = 0x00100000
  SeeMaskHmonitor* = 0x00200000 #if (_WIN32_IE >= 0x0500)
  SeeMaskNoqueryclassstore* = 0x01000000
  SeeMaskWaitforinputidle* = 0x02000000 #endif  (_WIN32_IE >= 0x500)
                                          #if (_WIN32_IE >= 0x0560)
  SeeMaskFlagLogUsage* = 0x04000000 #endif
                                        # (_WIN32_IE >= 0x560)

type
  Shellexecuteinfoa* {.final.} = object
    cbSize*: Dword
    fMask*: Ulong
    hwnd*: Hwnd
    lpVerb*: Lpcstr
    lpFile*: Lpcstr
    lpParameters*: Lpcstr
    lpDirectory*: Lpcstr
    nShow*: Int32
    hInstApp*: Hinst
    lpIDList*: Lpvoid
    lpClass*: Lpcstr
    hkeyClass*: Hkey
    dwHotKey*: Dword
    hMonitor*: Handle         # also: hIcon
    hProcess*: Handle

  TSHELLEXECUTEINFOA* = Shellexecuteinfoa
  Lpshellexecuteinfoa* = ptr Shellexecuteinfoa
  Shellexecuteinfow* {.final.} = object
    cbSize*: Dword
    fMask*: Ulong
    hwnd*: Hwnd
    lpVerb*: Lpcwstr
    lpFile*: Lpcwstr
    lpParameters*: Lpcwstr
    lpDirectory*: Lpcwstr
    nShow*: Int32
    hInstApp*: Hinst
    lpIDList*: Lpvoid
    lpClass*: Lpcwstr
    hkeyClass*: Hkey
    dwHotKey*: Dword
    hMonitor*: Handle         # also: hIcon
    hProcess*: Handle

  TSHELLEXECUTEINFOW* = Shellexecuteinfow
  Lpshellexecuteinfow* = ptr Shellexecuteinfow

when defined(UNICODE):
  type
    SHELLEXECUTEINFO* = SHELLEXECUTEINFOW
    TSHELLEXECUTEINFO* = SHELLEXECUTEINFOW
    LPSHELLEXECUTEINFO* = LPSHELLEXECUTEINFOW
else:
  type
    Shellexecuteinfo* = Shellexecuteinfoa
    TSHELLEXECUTEINFO* = Shellexecuteinfoa
    Lpshellexecuteinfo* = Lpshellexecuteinfoa
proc shellExecuteExA*(lpExecInfo: Lpshellexecuteinfoa): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "ShellExecuteExA".}
proc shellExecuteExW*(lpExecInfo: Lpshellexecuteinfow): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "ShellExecuteExW".}
proc shellExecuteEx*(lpExecInfo: Lpshellexecuteinfoa): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "ShellExecuteExA".}
proc shellExecuteEx*(lpExecInfo: Lpshellexecuteinfow): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "ShellExecuteExW".}
proc winExecErrorA*(HWND: Hwnd, error: Int32, lpstrFileName: Lpcstr,
                    lpstrTitle: Lpcstr){.stdcall, dynlib: "shell32.dll",
    importc: "WinExecErrorA".}
proc winExecErrorW*(HWND: Hwnd, error: Int32, lpstrFileName: Lpcwstr,
                    lpstrTitle: Lpcwstr){.stdcall, dynlib: "shell32.dll",
    importc: "WinExecErrorW".}
proc winExecError*(HWND: Hwnd, error: Int32, lpstrFileName: Lpcstr,
                   lpstrTitle: Lpcstr){.stdcall, dynlib: "shell32.dll",
                                        importc: "WinExecErrorA".}
proc winExecError*(HWND: Hwnd, error: Int32, lpstrFileName: Lpcwstr,
                   lpstrTitle: Lpcwstr){.stdcall, dynlib: "shell32.dll",
    importc: "WinExecErrorW".}
type
  Shcreateprocessinfow* {.final.} = object
    cbSize*: Dword
    fMask*: Ulong
    hwnd*: Hwnd
    pszFile*: Lpcwstr
    pszParameters*: Lpcwstr
    pszCurrentDirectory*: Lpcwstr
    hUserToken*: Handle
    lpProcessAttributes*: LpsecurityAttributes
    lpThreadAttributes*: LpsecurityAttributes
    bInheritHandles*: Bool
    dwCreationFlags*: Dword
    lpStartupInfo*: Lpstartupinfow
    lpProcessInformation*: LpprocessInformation

  TSHCREATEPROCESSINFOW* = Shcreateprocessinfow
  Pshcreateprocessinfow* = ptr Shcreateprocessinfow

proc sHCreateProcessAsUserW*(pscpi: Pshcreateprocessinfow): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHCreateProcessAsUserW".}
  #
  #  End ShellExecuteEx and family }
  #
  #
  # RecycleBin
  #
  # struct for query recycle bin info
type
  Shqueryrbinfo* {.final.} = object
    cbSize*: Dword
    i64Size*: Int64
    i64NumItems*: Int64

  TSHQUERYRBINFO* = Shqueryrbinfo
  Lpshqueryrbinfo* = ptr Shqueryrbinfo # flags for SHEmptyRecycleBin

const
  SherbNoconfirmation* = 0x00000001
  SherbNoprogressui* = 0x00000002
  SherbNosound* = 0x00000004

proc sHQueryRecycleBinA*(pszRootPath: Lpcstr, pSHQueryRBInfo: Lpshqueryrbinfo): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHQueryRecycleBinA".}
proc sHQueryRecycleBinW*(pszRootPath: Lpcwstr, pSHQueryRBInfo: Lpshqueryrbinfo): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHQueryRecycleBinW".}
proc sHQueryRecycleBin*(pszRootPath: Lpcstr, pSHQueryRBInfo: Lpshqueryrbinfo): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHQueryRecycleBinA".}
proc sHQueryRecycleBin*(pszRootPath: Lpcwstr, pSHQueryRBInfo: Lpshqueryrbinfo): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHQueryRecycleBinW".}
proc sHEmptyRecycleBinA*(hwnd: Hwnd, pszRootPath: Lpcstr, dwFlags: Dword): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHEmptyRecycleBinA".}
proc sHEmptyRecycleBinW*(hwnd: Hwnd, pszRootPath: Lpcwstr, dwFlags: Dword): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHEmptyRecycleBinW".}
proc sHEmptyRecycleBin*(hwnd: Hwnd, pszRootPath: Lpcstr, dwFlags: Dword): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHEmptyRecycleBinA".}
proc sHEmptyRecycleBin*(hwnd: Hwnd, pszRootPath: Lpcwstr, dwFlags: Dword): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHEmptyRecycleBinW".}
  #
  # end of RecycleBin
  #
  #
  # Tray notification definitions
  #
type
  Notifyicondataa* {.final.} = object
    cbSize*: Dword
    hWnd*: Hwnd
    uID*: Uint
    uFlags*: Uint
    uCallbackMessage*: Uint
    hIcon*: Hicon
    szTip*: Array[0..127, Char]
    dwState*: Dword
    dwStateMask*: Dword
    szInfo*: Array[0..255, Char]
    uTimeout*: Uint           # also: uVersion
    szInfoTitle*: Array[0..63, Char]
    dwInfoFlags*: Dword
    guidItem*: TGUID

  TNOTIFYICONDATAA* = Notifyicondataa
  Pnotifyicondataa* = ptr Notifyicondataa
  Notifyicondataw* {.final.} = object
    cbSize*: Dword
    hWnd*: Hwnd
    uID*: Uint
    uFlags*: Uint
    uCallbackMessage*: Uint
    hIcon*: Hicon
    szTip*: Array[0..127, Wchar]
    dwState*: Dword
    dwStateMask*: Dword
    szInfo*: Array[0..255, Wchar]
    uTimeout*: Uint           # also uVersion : UINT
    szInfoTitle*: Array[0..63, Char]
    dwInfoFlags*: Dword
    guidItem*: TGUID

  TNOTIFYICONDATAW* = Notifyicondataw
  Pnotifyicondataw* = ptr Notifyicondataw

when defined(UNICODE):
  type
    NOTIFYICONDATA* = NOTIFYICONDATAW
    TNOTIFYICONDATA* = NOTIFYICONDATAW
    PNOTIFYICONDATA* = PNOTIFYICONDATAW
else:
  type
    Notifyicondata* = Notifyicondataa
    TNOTIFYICONDATA* = Notifyicondataa
    Pnotifyicondata* = Pnotifyicondataa
const
  NinSelect* = WM_USER + 0
  NinfKey* = 0x00000001
  NinKeyselect* = NIN_SELECT or NINF_KEY
  NinBalloonshow* = WM_USER + 2
  NinBalloonhide* = WM_USER + 3
  NinBalloontimeout* = WM_USER + 4
  NinBalloonuserclick* = WM_USER + 5
  NimAdd* = 0x00000000
  NimModify* = 0x00000001
  NimDelete* = 0x00000002
  NimSetfocus* = 0x00000003
  NimSetversion* = 0x00000004
  NotifyiconVersion* = 3
  NifMessage* = 0x00000001
  NifIcon* = 0x00000002
  NifTip* = 0x00000004
  NifState* = 0x00000008
  NifInfo* = 0x00000010
  NifGuid* = 0x00000020
  NisHidden* = 0x00000001
  NisSharedicon* = 0x00000002 # says this is the source of a shared icon
                               # Notify Icon Infotip flags
  NiifNone* = 0x00000000     # icon flags are mutually exclusive
                              # and take only the lowest 2 bits
  NiifInfo* = 0x00000001
  NiifWarning* = 0x00000002
  NiifError* = 0x00000003
  NiifIconMask* = 0x0000000F
  NiifNosound* = 0x00000010

proc shellNotifyIconA*(dwMessage: Dword, lpData: Pnotifyicondataa): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "Shell_NotifyIconA".}
proc shellNotifyIconW*(dwMessage: Dword, lpData: Pnotifyicondataw): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "Shell_NotifyIconW".}
proc shellNotifyIcon*(dwMessage: Dword, lpData: Pnotifyicondataa): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "Shell_NotifyIconA".}
proc shellNotifyIcon*(dwMessage: Dword, lpData: Pnotifyicondataw): Bool{.
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
  Shfileinfoa* {.final.} = object
    hIcon*: Hicon             # out: icon
    iIcon*: Int32             # out: icon index
    dwAttributes*: Dword      # out: SFGAO_ flags
    szDisplayName*: Array[0..(MAX_PATH) - 1, Char] # out: display name (or path)
    szTypeName*: Array[0..79, Char] # out: type name

  TSHFILEINFOA* = Shfileinfoa
  PSHFILEINFOA* = ptr Shfileinfoa
  Shfileinfow* {.final.} = object
    hIcon*: Hicon             # out: icon
    iIcon*: Int32             # out: icon index
    dwAttributes*: Dword      # out: SFGAO_ flags
    szDisplayName*: Array[0..(MAX_PATH) - 1, Wchar] # out: display name (or path)
    szTypeName*: Array[0..79, Wchar] # out: type name

  TSHFILEINFOW* = Shfileinfow
  PSHFILEINFOW* = ptr Shfileinfow

when defined(UNICODE):
  type
    SHFILEINFO* = SHFILEINFOW
    TSHFILEINFO* = SHFILEINFOW
    pFILEINFO* = SHFILEINFOW
else:
  type
    Shfileinfo* = Shfileinfoa
    TSHFILEINFO* = Shfileinfoa
    PFILEINFO* = Shfileinfoa
# NOTE: This is also in shlwapi.h.  Please keep in synch.

const
  ShgfiIcon* = 0x00000100    # get Icon
  ShgfiDisplayname* = 0x00000200 # get display name
  ShgfiTypename* = 0x00000400 # get type name
  ShgfiAttributes* = 0x00000800 # get attributes
  ShgfiIconlocation* = 0x00001000 # get icon location
  ShgfiExetype* = 0x00002000 # return exe type
  ShgfiSysiconindex* = 0x00004000 # get system icon index
  ShgfiLinkoverlay* = 0x00008000 # put a link overlay on icon
  ShgfiSelected* = 0x00010000 # show icon in selected state
  ShgfiAttrSpecified* = 0x00020000 # get only specified attributes
  ShgfiLargeicon* = 0x00000000 # get large icon
  ShgfiSmallicon* = 0x00000001 # get small icon
  ShgfiOpenicon* = 0x00000002 # get open icon
  ShgfiShelliconsize* = 0x00000004 # get shell size icon
  ShgfiPidl* = 0x00000008    # pszPath is a pidl
  ShgfiUsefileattributes* = 0x00000010 # use passed dwFileAttribute
  ShgfiAddoverlays* = 0x00000020 # apply the appropriate overlays
  ShgfiOverlayindex* = 0x00000040 # Get the index of the overlay
                                   # in the upper 8 bits of the iIcon

proc sHGetFileInfoA*(pszPath: Lpcstr, dwFileAttributes: Dword,
                     psfi: PSHFILEINFOA, cbFileInfo, UFlags: Uint): Dword{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoA".}
proc sHGetFileInfoW*(pszPath: Lpcwstr, dwFileAttributes: Dword,
                     psfi: PSHFILEINFOW, cbFileInfo, UFlags: Uint): Dword{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoW".}
proc sHGetFileInfo*(pszPath: Lpcstr, dwFileAttributes: Dword,
                    psfi: PSHFILEINFOA, cbFileInfo, UFlags: Uint): Dword{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoA".}
proc sHGetFileInfoA*(pszPath: Lpcstr, dwFileAttributes: Dword,
                     psfi: var TSHFILEINFOA, cbFileInfo, UFlags: Uint): Dword{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoA".}
proc sHGetFileInfoW*(pszPath: Lpcwstr, dwFileAttributes: Dword,
                     psfi: var TSHFILEINFOW, cbFileInfo, UFlags: Uint): Dword{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoW".}
proc sHGetFileInfo*(pszPath: Lpcstr, dwFileAttributes: Dword,
                    psfi: var TSHFILEINFOA, cbFileInfo, UFlags: Uint): Dword{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoA".}
proc sHGetFileInfo*(pszPath: Lpcwstr, dwFileAttributes: Dword,
                    psfi: var TSHFILEINFOW, cbFileInfo, UFlags: Uint): Dword{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetFileInfoW".}
proc sHGetDiskFreeSpaceExA*(pszDirectoryName: Lpcstr,
                            pulFreeBytesAvailableToCaller: PulargeInteger,
                            pulTotalNumberOfBytes: PulargeInteger,
                            pulTotalNumberOfFreeBytes: PulargeInteger): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExA".}
proc sHGetDiskFreeSpaceExW*(pszDirectoryName: Lpcwstr,
                            pulFreeBytesAvailableToCaller: PulargeInteger,
                            pulTotalNumberOfBytes: PulargeInteger,
                            pulTotalNumberOfFreeBytes: PulargeInteger): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExW".}
proc sHGetDiskFreeSpaceEx*(pszDirectoryName: Lpcstr,
                           pulFreeBytesAvailableToCaller: PulargeInteger,
                           pulTotalNumberOfBytes: PulargeInteger,
                           pulTotalNumberOfFreeBytes: PulargeInteger): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExA".}
proc sHGetDiskFreeSpace*(pszDirectoryName: Lpcstr,
                         pulFreeBytesAvailableToCaller: PulargeInteger,
                         pulTotalNumberOfBytes: PulargeInteger,
                         pulTotalNumberOfFreeBytes: PulargeInteger): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExA".}
proc sHGetDiskFreeSpaceEx*(pszDirectoryName: Lpcwstr,
                           pulFreeBytesAvailableToCaller: PulargeInteger,
                           pulTotalNumberOfBytes: PulargeInteger,
                           pulTotalNumberOfFreeBytes: PulargeInteger): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExW".}
proc sHGetDiskFreeSpace*(pszDirectoryName: Lpcwstr,
                         pulFreeBytesAvailableToCaller: PulargeInteger,
                         pulTotalNumberOfBytes: PulargeInteger,
                         pulTotalNumberOfFreeBytes: PulargeInteger): Bool{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetDiskFreeSpaceExW".}
proc sHGetNewLinkInfoA*(pszLinkTo: Lpcstr, pszDir: Lpcstr, pszName: Lpstr,
                        pfMustCopy: PBool, uFlags: Uint): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetNewLinkInfoA".}
proc sHGetNewLinkInfoW*(pszLinkTo: Lpcwstr, pszDir: Lpcwstr, pszName: Lpwstr,
                        pfMustCopy: PBool, uFlags: Uint): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetNewLinkInfoW".}
proc sHGetNewLinkInfo*(pszLinkTo: Lpcstr, pszDir: Lpcstr, pszName: Lpstr,
                       pfMustCopy: PBool, uFlags: Uint): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetNewLinkInfoA".}
proc sHGetNewLinkInfo*(pszLinkTo: Lpcwstr, pszDir: Lpcwstr, pszName: Lpwstr,
                       pfMustCopy: PBool, uFlags: Uint): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetNewLinkInfoW".}
const
  ShgnliPidl* = 0x00000001   # pszLinkTo is a pidl
  ShgnliPrefixname* = 0x00000002 # Make name "Shortcut to xxx"
  ShgnliNounique* = 0x00000004 # don't do the unique name generation
  ShgnliNolnk* = 0x00000008  # don't add ".lnk" extension
  PrintactionOpen* = 0
  PrintactionProperties* = 1
  PrintactionNetinstall* = 2
  PrintactionNetinstalllink* = 3
  PrintactionTestpage* = 4
  PrintactionOpennetprn* = 5
  PrintactionDocumentdefaults* = 6
  PrintactionServerproperties* = 7

proc sHInvokePrinterCommandA*(HWND: Hwnd, uAction: Uint, lpBuf1: Lpcstr,
                              lpBuf2: Lpcstr, fModal: Bool): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandA".}
proc sHInvokePrinterCommandW*(HWND: Hwnd, uAction: Uint, lpBuf1: Lpcwstr,
                              lpBuf2: Lpcwstr, fModal: Bool): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandW".}
proc sHInvokePrinterCommand*(HWND: Hwnd, uAction: Uint, lpBuf1: Lpcstr,
                             lpBuf2: Lpcstr, fModal: Bool): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandA".}
proc sHInvokePrinterCommand*(HWND: Hwnd, uAction: Uint, lpBuf1: Lpcwstr,
                             lpBuf2: Lpcwstr, fModal: Bool): Bool{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandW".}
proc sHLoadNonloadedIconOverlayIdentifiers*(): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHInvokePrinterCommandW".}
proc sHIsFileAvailableOffline*(pwszPath: Lpcwstr, pdwStatus: Lpdword): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHIsFileAvailableOffline".}
const
  OfflineStatusLocal* = 0x00000001 # If open, it's open locally
  OfflineStatusRemote* = 0x00000002 # If open, it's open remotely
  OfflineStatusIncomplete* = 0x00000004 # The local copy is currently incomplete.
                                          # The file will not be available offline
                                          # until it has been synchronized.
                                          #  sets the specified path to use the string resource
                                          #  as the UI instead of the file system name

proc sHSetLocalizedName*(pszPath: Lpwstr, pszResModule: Lpcwstr, idsRes: Int32): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHSetLocalizedName".}
proc sHEnumerateUnreadMailAccountsA*(hKeyUser: Hkey, dwIndex: Dword,
                                     pszMailAddress: Lpstr,
                                     cchMailAddress: Int32): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHEnumerateUnreadMailAccountsA".}
proc sHEnumerateUnreadMailAccountsW*(hKeyUser: Hkey, dwIndex: Dword,
                                     pszMailAddress: Lpwstr,
                                     cchMailAddress: Int32): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHEnumerateUnreadMailAccountsW".}
proc sHEnumerateUnreadMailAccounts*(hKeyUser: Hkey, dwIndex: Dword,
                                    pszMailAddress: Lpwstr,
                                    cchMailAddress: Int32): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHEnumerateUnreadMailAccountsW".}
proc sHGetUnreadMailCountA*(hKeyUser: Hkey, pszMailAddress: Lpcstr,
                            pdwCount: Pdword, pFileTime: Pfiletime,
                            pszShellExecuteCommand: Lpstr,
                            cchShellExecuteCommand: Int32): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetUnreadMailCountA".}
proc sHGetUnreadMailCountW*(hKeyUser: Hkey, pszMailAddress: Lpcwstr,
                            pdwCount: Pdword, pFileTime: Pfiletime,
                            pszShellExecuteCommand: Lpwstr,
                            cchShellExecuteCommand: Int32): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetUnreadMailCountW".}
proc sHGetUnreadMailCount*(hKeyUser: Hkey, pszMailAddress: Lpcstr,
                           pdwCount: Pdword, pFileTime: Pfiletime,
                           pszShellExecuteCommand: Lpstr,
                           cchShellExecuteCommand: Int32): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetUnreadMailCountA".}
proc sHGetUnreadMailCount*(hKeyUser: Hkey, pszMailAddress: Lpcwstr,
                           pdwCount: Pdword, pFileTime: Pfiletime,
                           pszShellExecuteCommand: Lpwstr,
                           cchShellExecuteCommand: Int32): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHGetUnreadMailCountW".}
proc sHSetUnreadMailCountA*(pszMailAddress: Lpcstr, dwCount: Dword,
                            pszShellExecuteCommand: Lpcstr): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHSetUnreadMailCountA".}
proc sHSetUnreadMailCountW*(pszMailAddress: Lpcwstr, dwCount: Dword,
                            pszShellExecuteCommand: Lpcwstr): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHSetUnreadMailCountW".}
proc sHSetUnreadMailCount*(pszMailAddress: Lpcstr, dwCount: Dword,
                           pszShellExecuteCommand: Lpcstr): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHSetUnreadMailCountA".}
proc sHSetUnreadMailCount*(pszMailAddress: Lpcwstr, dwCount: Dword,
                           pszShellExecuteCommand: Lpcwstr): Hresult{.stdcall,
    dynlib: "shell32.dll", importc: "SHSetUnreadMailCountW".}
proc sHGetImageList*(iImageList: Int32, riid: TIID, ppvObj: ptr Pointer): Hresult{.
    stdcall, dynlib: "shell32.dll", importc: "SHGetImageList".}
const
  ShilLarge* = 0             # normally 32x32
  ShilSmall* = 1             # normally 16x16
  ShilExtralarge* = 2
  ShilSyssmall* = 3          # like SHIL_SMALL, but tracks system small icon metric correctly
  ShilLast* = SHIL_SYSSMALL

# implementation

proc eiresid(x: int32): int32 =
  result = -x
