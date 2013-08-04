#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2009 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

#       PSAPI interface unit

# Contains the definitions for the APIs provided by PSAPI.DLL

import                        # Data structure templates
  Windows

const
  psapiDll = "psapi.dll"

proc enumProcesses*(lpidProcess: ptr Dword, cb: Dword, 
                    cbNeeded: ptr Dword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "EnumProcesses".}
proc enumProcessModules*(hProcess: Handle, lphModule: ptr Hmodule, cb: Dword, lpcbNeeded: Lpdword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "EnumProcessModules".}

proc getModuleBaseNameA*(hProcess: Handle, hModule: Hmodule, lpBaseName: Lpstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetModuleBaseNameA".}
proc getModuleBaseNameW*(hProcess: Handle, hModule: Hmodule, lpBaseName: Lpwstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetModuleBaseNameW".}
when defined(winUnicode):
  proc GetModuleBaseName*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetModuleBaseNameW".}
else:
  proc getModuleBaseName*(hProcess: Handle, hModule: Hmodule, lpBaseName: Lpstr, nSize: Dword): Dword {.stdcall,
      dynlib: psapiDll, importc: "GetModuleBaseNameA".}

proc getModuleFileNameExA*(hProcess: Handle, hModule: Hmodule, lpFileNameEx: Lpstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetModuleFileNameExA".}
proc getModuleFileNameExW*(hProcess: Handle, hModule: Hmodule, lpFileNameEx: Lpwstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetModuleFileNameExW".}
when defined(winUnicode):
  proc GetModuleFileNameEx*(hProcess: HANDLE, hModule: HMODULE, lpFileNameEx: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetModuleFileNameExW".}
else:
  proc getModuleFileNameEx*(hProcess: Handle, hModule: Hmodule, lpFileNameEx: Lpstr, nSize: Dword): Dword {.stdcall,
      dynlib: psapiDll, importc: "GetModuleFileNameExA".}

type
  Moduleinfo* {.final.} = object
    lpBaseOfDll*: Lpvoid
    SizeOfImage*: Dword
    EntryPoint*: Lpvoid
  Lpmoduleinfo* = ptr Moduleinfo

proc getModuleInformation*(hProcess: Handle, hModule: Hmodule, lpmodinfo: Lpmoduleinfo, cb: Dword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "GetModuleInformation".}
proc emptyWorkingSet*(hProcess: Handle): Winbool {.stdcall,
    dynlib: psapiDll, importc: "EmptyWorkingSet".}
proc queryWorkingSet*(hProcess: Handle, pv: Pvoid, cb: Dword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "QueryWorkingSet".}
proc queryWorkingSetEx*(hProcess: Handle, pv: Pvoid, cb: Dword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "QueryWorkingSetEx".}
proc initializeProcessForWsWatch*(hProcess: Handle): Winbool {.stdcall,
    dynlib: psapiDll, importc: "InitializeProcessForWsWatch".}

type
  PsapiWsWatchInformation* {.final.} = object
    FaultingPc*: Lpvoid
    FaultingVa*: Lpvoid
  PpsapiWsWatchInformation* = ptr PsapiWsWatchInformation

proc getWsChanges*(hProcess: Handle, lpWatchInfo: PpsapiWsWatchInformation, cb: Dword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "GetWsChanges".}

proc getMappedFileNameA*(hProcess: Handle, lpv: Lpvoid, lpFilename: Lpstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetMappedFileNameA".}
proc getMappedFileNameW*(hProcess: Handle, lpv: Lpvoid, lpFilename: Lpwstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetMappedFileNameW".}
when defined(winUnicode):
  proc GetMappedFileName*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetMappedFileNameW".}
else:
  proc getMappedFileName*(hProcess: Handle, lpv: Lpvoid, lpFilename: Lpstr, nSize: Dword): Dword {.stdcall,
      dynlib: psapiDll, importc: "GetMappedFileNameA".}

proc enumDeviceDrivers*(lpImageBase: Lpvoid, cb: Dword, lpcbNeeded: Lpdword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "EnumDeviceDrivers".}

proc getDeviceDriverBaseNameA*(ImageBase: Lpvoid, lpBaseName: Lpstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetDeviceDriverBaseNameA".}
proc getDeviceDriverBaseNameW*(ImageBase: Lpvoid, lpBaseName: Lpwstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetDeviceDriverBaseNameW".}
when defined(winUnicode):
  proc GetDeviceDriverBaseName*(ImageBase: LPVOID, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetDeviceDriverBaseNameW".}
else:
  proc getDeviceDriverBaseName*(ImageBase: Lpvoid, lpBaseName: Lpstr, nSize: Dword): Dword {.stdcall,
      dynlib: psapiDll, importc: "GetDeviceDriverBaseNameA".}

proc getDeviceDriverFileNameA*(ImageBase: Lpvoid, lpFileName: Lpstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetDeviceDriverFileNameA".}
proc getDeviceDriverFileNameW*(ImageBase: Lpvoid, lpFileName: Lpwstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetDeviceDriverFileNameW".}
when defined(winUnicode):
  proc GetDeviceDriverFileName*(ImageBase: LPVOID, lpFileName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetDeviceDriverFileNameW".}
else:
  proc getDeviceDriverFileName*(ImageBase: Lpvoid, lpFileName: Lpstr, nSize: Dword): Dword {.stdcall,
      dynlib: psapiDll, importc: "GetDeviceDriverFileNameA".}

type
  ProcessMemoryCounters* {.final.} = object
    cb*: Dword
    PageFaultCount*: Dword
    PeakWorkingSetSize: SizeT
    WorkingSetSize: SizeT
    QuotaPeakPagedPoolUsage: SizeT
    QuotaPagedPoolUsage: SizeT
    QuotaPeakNonPagedPoolUsage: SizeT
    QuotaNonPagedPoolUsage: SizeT
    PagefileUsage: SizeT
    PeakPagefileUsage: SizeT
  PprocessMemoryCounters* = ptr ProcessMemoryCounters

type
  ProcessMemoryCountersEx* {.final.} = object
    cb*: Dword
    PageFaultCount*: Dword
    PeakWorkingSetSize: SizeT
    WorkingSetSize: SizeT
    QuotaPeakPagedPoolUsage: SizeT
    QuotaPagedPoolUsage: SizeT
    QuotaPeakNonPagedPoolUsage: SizeT
    QuotaNonPagedPoolUsage: SizeT
    PagefileUsage: SizeT
    PeakPagefileUsage: SizeT
    PrivateUsage: SizeT
  PprocessMemoryCountersEx* = ptr ProcessMemoryCountersEx

proc getProcessMemoryInfo*(hProcess: Handle, ppsmemCounters: PprocessMemoryCounters, cb: Dword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "GetProcessMemoryInfo".}

type
  PerformanceInformation* {.final.} = object
    cb*: Dword
    CommitTotal: SizeT
    CommitLimit: SizeT
    CommitPeak: SizeT
    PhysicalTotal: SizeT
    PhysicalAvailable: SizeT
    SystemCache: SizeT
    KernelTotal: SizeT
    KernelPaged: SizeT
    KernelNonpaged: SizeT
    PageSize: SizeT
    HandleCount*: Dword
    ProcessCount*: Dword
    ThreadCount*: Dword
  PperformanceInformation* = ptr PerformanceInformation
  # Skip definition of PERFORMACE_INFORMATION...

proc getPerformanceInfo*(pPerformanceInformation: PperformanceInformation, cb: Dword): Winbool {.stdcall,
    dynlib: psapiDll, importc: "GetPerformanceInfo".}

type
  EnumPageFileInformation* {.final.} = object
    cb*: Dword
    Reserved*: Dword
    TotalSize: SizeT
    TotalInUse: SizeT
    PeakUsage: SizeT
  PenumPageFileInformation* = ptr EnumPageFileInformation

# Callback procedure
type
  PenumPageFileCallbackw* = proc (pContext: Lpvoid, pPageFileInfo: PenumPageFileInformation, lpFilename: Lpcwstr): Winbool{.stdcall.}
  PenumPageFileCallbacka* = proc (pContext: Lpvoid, pPageFileInfo: PenumPageFileInformation, lpFilename: Lpcstr): Winbool{.stdcall.}

#TODO
proc enumPageFilesA*(pCallBackRoutine: PenumPageFileCallbacka, pContext: Lpvoid): Winbool {.stdcall,
    dynlib: psapiDll, importc: "EnumPageFilesA".}
proc enumPageFilesW*(pCallBackRoutine: PenumPageFileCallbackw, pContext: Lpvoid): Winbool {.stdcall,
    dynlib: psapiDll, importc: "EnumPageFilesW".}
when defined(winUnicode):
  proc EnumPageFiles*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKW, pContext: LPVOID): WINBOOL {.stdcall,
      dynlib: psapiDll, importc: "EnumPageFilesW".}
  type PENUM_PAGE_FILE_CALLBACK* = proc (pContext: LPVOID, pPageFileInfo: PENUM_PAGE_FILE_INFORMATION, lpFilename: LPCWSTR): WINBOOL{.stdcall.}
else:
  proc enumPageFiles*(pCallBackRoutine: PenumPageFileCallbacka, pContext: Lpvoid): Winbool {.stdcall,
      dynlib: psapiDll, importc: "EnumPageFilesA".}
  type PenumPageFileCallback* = proc (pContext: Lpvoid, pPageFileInfo: PenumPageFileInformation, lpFilename: Lpcstr): Winbool{.stdcall.}

proc getProcessImageFileNameA*(hProcess: Handle, lpImageFileName: Lpstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetProcessImageFileNameA".}
proc getProcessImageFileNameW*(hProcess: Handle, lpImageFileName: Lpwstr, nSize: Dword): Dword {.stdcall,
    dynlib: psapiDll, importc: "GetProcessImageFileNameW".}
when defined(winUnicode):
  proc GetProcessImageFileName*(hProcess: HANDLE, lpImageFileName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetProcessImageFileNameW".}
else:
  proc getProcessImageFileName*(hProcess: Handle, lpImageFileName: Lpstr, nSize: Dword): Dword {.stdcall,
      dynlib: psapiDll, importc: "GetProcessImageFileNameA".}
