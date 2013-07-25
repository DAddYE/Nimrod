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

proc enumProcesses*(lpidProcess: ptr DWORD, cb: DWORD,
                    cbNeeded: ptr DWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "EnumProcesses".}
proc enumProcessModules*(hProcess: HANDLE, lphModule: ptr HMODULE, cb: DWORD, lpcbNeeded: LPDWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "EnumProcessModules".}

proc getModuleBaseNameA*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetModuleBaseNameA".}
proc getModuleBaseNameW*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetModuleBaseNameW".}
when defined(winUnicode):
  proc getModuleBaseName*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetModuleBaseNameW".}
else:
  proc getModuleBaseName*(hProcess: HANDLE, hModule: HMODULE, lpBaseName: LPSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetModuleBaseNameA".}

proc getModuleFileNameExA*(hProcess: HANDLE, hModule: HMODULE, lpFileNameEx: LPSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetModuleFileNameExA".}
proc getModuleFileNameExW*(hProcess: HANDLE, hModule: HMODULE, lpFileNameEx: LPWSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetModuleFileNameExW".}
when defined(winUnicode):
  proc getModuleFileNameEx*(hProcess: HANDLE, hModule: HMODULE, lpFileNameEx: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetModuleFileNameExW".}
else:
  proc getModuleFileNameEx*(hProcess: HANDLE, hModule: HMODULE, lpFileNameEx: LPSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetModuleFileNameExA".}

type
  MODULEINFO* {.final.} = object
    lpBaseOfDll*: LPVOID
    SizeOfImage*: DWORD
    EntryPoint*: LPVOID
  LPMODULEINFO* = ptr MODULEINFO

proc getModuleInformation*(hProcess: HANDLE, hModule: HMODULE, lpmodinfo: LPMODULEINFO, cb: DWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "GetModuleInformation".}
proc emptyWorkingSet*(hProcess: HANDLE): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "EmptyWorkingSet".}
proc queryWorkingSet*(hProcess: HANDLE, pv: PVOID, cb: DWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "QueryWorkingSet".}
proc queryWorkingSetEx*(hProcess: HANDLE, pv: PVOID, cb: DWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "QueryWorkingSetEx".}
proc initializeProcessForWsWatch*(hProcess: HANDLE): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "InitializeProcessForWsWatch".}

type
  PSAPI_WS_WATCH_INFORMATION* {.final.} = object
    FaultingPc*: LPVOID
    FaultingVa*: LPVOID
  PPSAPI_WS_WATCH_INFORMATION* = ptr PSAPI_WS_WATCH_INFORMATION

proc getWsChanges*(hProcess: HANDLE, lpWatchInfo: PPSAPI_WS_WATCH_INFORMATION, cb: DWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "GetWsChanges".}

proc getMappedFileNameA*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetMappedFileNameA".}
proc getMappedFileNameW*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPWSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetMappedFileNameW".}
when defined(winUnicode):
  proc getMappedFileName*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetMappedFileNameW".}
else:
  proc getMappedFileName*(hProcess: HANDLE, lpv: LPVOID, lpFilename: LPSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetMappedFileNameA".}

proc enumDeviceDrivers*(lpImageBase: LPVOID, cb: DWORD, lpcbNeeded: LPDWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "EnumDeviceDrivers".}

proc getDeviceDriverBaseNameA*(ImageBase: LPVOID, lpBaseName: LPSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetDeviceDriverBaseNameA".}
proc getDeviceDriverBaseNameW*(ImageBase: LPVOID, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetDeviceDriverBaseNameW".}
when defined(winUnicode):
  proc getDeviceDriverBaseName*(ImageBase: LPVOID, lpBaseName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetDeviceDriverBaseNameW".}
else:
  proc getDeviceDriverBaseName*(ImageBase: LPVOID, lpBaseName: LPSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetDeviceDriverBaseNameA".}

proc getDeviceDriverFileNameA*(ImageBase: LPVOID, lpFileName: LPSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetDeviceDriverFileNameA".}
proc getDeviceDriverFileNameW*(ImageBase: LPVOID, lpFileName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetDeviceDriverFileNameW".}
when defined(winUnicode):
  proc getDeviceDriverFileName*(ImageBase: LPVOID, lpFileName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetDeviceDriverFileNameW".}
else:
  proc getDeviceDriverFileName*(ImageBase: LPVOID, lpFileName: LPSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetDeviceDriverFileNameA".}

type
  PROCESS_MEMORY_COUNTERS* {.final.} = object
    cb*: DWORD
    PageFaultCount*: DWORD
    PeakWorkingSetSize: SIZE_T
    WorkingSetSize: SIZE_T
    QuotaPeakPagedPoolUsage: SIZE_T
    QuotaPagedPoolUsage: SIZE_T
    QuotaPeakNonPagedPoolUsage: SIZE_T
    QuotaNonPagedPoolUsage: SIZE_T
    PagefileUsage: SIZE_T
    PeakPagefileUsage: SIZE_T
  PPROCESS_MEMORY_COUNTERS* = ptr PROCESS_MEMORY_COUNTERS

type
  PROCESS_MEMORY_COUNTERS_EX* {.final.} = object
    cb*: DWORD
    PageFaultCount*: DWORD
    PeakWorkingSetSize: SIZE_T
    WorkingSetSize: SIZE_T
    QuotaPeakPagedPoolUsage: SIZE_T
    QuotaPagedPoolUsage: SIZE_T
    QuotaPeakNonPagedPoolUsage: SIZE_T
    QuotaNonPagedPoolUsage: SIZE_T
    PagefileUsage: SIZE_T
    PeakPagefileUsage: SIZE_T
    PrivateUsage: SIZE_T
  PPROCESS_MEMORY_COUNTERS_EX* = ptr PROCESS_MEMORY_COUNTERS_EX

proc getProcessMemoryInfo*(hProcess: HANDLE, ppsmemCounters: PPROCESS_MEMORY_COUNTERS, cb: DWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "GetProcessMemoryInfo".}

type
  PERFORMANCE_INFORMATION* {.final.} = object
    cb*: DWORD
    CommitTotal: SIZE_T
    CommitLimit: SIZE_T
    CommitPeak: SIZE_T
    PhysicalTotal: SIZE_T
    PhysicalAvailable: SIZE_T
    SystemCache: SIZE_T
    KernelTotal: SIZE_T
    KernelPaged: SIZE_T
    KernelNonpaged: SIZE_T
    PageSize: SIZE_T
    HandleCount*: DWORD
    ProcessCount*: DWORD
    ThreadCount*: DWORD
  PPERFORMANCE_INFORMATION* = ptr PERFORMANCE_INFORMATION
  # Skip definition of PERFORMACE_INFORMATION...

proc getPerformanceInfo*(pPerformanceInformation: PPERFORMANCE_INFORMATION, cb: DWORD): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "GetPerformanceInfo".}

type
  ENUM_PAGE_FILE_INFORMATION* {.final.} = object
    cb*: DWORD
    Reserved*: DWORD
    TotalSize: SIZE_T
    TotalInUse: SIZE_T
    PeakUsage: SIZE_T
  PENUM_PAGE_FILE_INFORMATION* = ptr ENUM_PAGE_FILE_INFORMATION

# Callback procedure
type
  PENUM_PAGE_FILE_CALLBACKW* = proc (pContext: LPVOID, pPageFileInfo: PENUM_PAGE_FILE_INFORMATION, lpFilename: LPCWSTR): WINBOOL{.stdcall.}
  PENUM_PAGE_FILE_CALLBACKA* = proc (pContext: LPVOID, pPageFileInfo: PENUM_PAGE_FILE_INFORMATION, lpFilename: LPCSTR): WINBOOL{.stdcall.}

#TODO
proc enumPageFilesA*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKA, pContext: LPVOID): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "EnumPageFilesA".}
proc enumPageFilesW*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKW, pContext: LPVOID): WINBOOL {.stdcall,
    dynlib: psapiDll, importc: "EnumPageFilesW".}
when defined(winUnicode):
  proc enumPageFiles*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKW, pContext: LPVOID): WINBOOL {.stdcall,
      dynlib: psapiDll, importc: "EnumPageFilesW".}
  type PENUM_PAGE_FILE_CALLBACK* = proc (pContext: LPVOID, pPageFileInfo: PENUM_PAGE_FILE_INFORMATION, lpFilename: LPCWSTR): WINBOOL{.stdcall.}
else:
  proc enumPageFiles*(pCallBackRoutine: PENUM_PAGE_FILE_CALLBACKA, pContext: LPVOID): WINBOOL {.stdcall,
      dynlib: psapiDll, importc: "EnumPageFilesA".}
  type PENUM_PAGE_FILE_CALLBACK* = proc (pContext: LPVOID, pPageFileInfo: PENUM_PAGE_FILE_INFORMATION, lpFilename: LPCSTR): WINBOOL{.stdcall.}

proc getProcessImageFileNameA*(hProcess: HANDLE, lpImageFileName: LPSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetProcessImageFileNameA".}
proc getProcessImageFileNameW*(hProcess: HANDLE, lpImageFileName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
    dynlib: psapiDll, importc: "GetProcessImageFileNameW".}
when defined(winUnicode):
  proc getProcessImageFileName*(hProcess: HANDLE, lpImageFileName: LPWSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetProcessImageFileNameW".}
else:
  proc getProcessImageFileName*(hProcess: HANDLE, lpImageFileName: LPSTR, nSize: DWORD): DWORD {.stdcall,
      dynlib: psapiDll, importc: "GetProcessImageFileNameA".}
