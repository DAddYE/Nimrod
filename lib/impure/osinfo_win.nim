# XXX clean up this mess!

import winlean

const
  InvalidHandleValue = int(- 1) # GetStockObject

type
  TMEMORYSTATUSEX {.final, pure.} = object
    dwLength: Int32
    dwMemoryLoad: Int32
    ullTotalPhys: Int64
    ullAvailPhys: Int64
    ullTotalPageFile: Int64
    ullAvailPageFile: Int64
    ullTotalVirtual: Int64
    ullAvailVirtual: Int64
    ullAvailExtendedVirtual: Int64
    
  SystemInfo* {.final, pure.} = object
    wProcessorArchitecture*: Int16
    wReserved*: Int16
    dwPageSize*: Int32
    lpMinimumApplicationAddress*: Pointer
    lpMaximumApplicationAddress*: Pointer
    dwActiveProcessorMask*: Int32
    dwNumberOfProcessors*: Int32
    dwProcessorType*: Int32
    dwAllocationGranularity*: Int32
    wProcessorLevel*: Int16
    wProcessorRevision*: Int16

  LpsystemInfo* = ptr SystemInfo
  TSYSTEMINFO* = SystemInfo

  TMemoryInfo* = object
    memoryLoad*: Int ## occupied memory, in percent
    totalPhysMem*: Int64 ## Total Physical memory, in bytes
    availablePhysMem*: Int64 ## Available physical memory, in bytes
    totalPageFile*: Int64 ## The current committed memory limit 
                          ## for the system or the current process, whichever is smaller, in bytes.
    availablePageFile*: Int64 ## The maximum amount of memory the current process can commit, in bytes.
    totalVirtualMem*: Int64 ## Total virtual memory, in bytes
    availableVirtualMem*: Int64 ## Available virtual memory, in bytes
    
  TOSVERSIONINFOEX {.final, pure.} = object
    dwOSVersionInfoSize: Int32
    dwMajorVersion: Int32
    dwMinorVersion: Int32
    dwBuildNumber: Int32
    dwPlatformId: Int32
    szCSDVersion: Array[0..127, Char]
    wServicePackMajor: Int16
    wServicePackMinor: Int16
    wSuiteMask: Int16
    wProductType: Int8
    wReserved: Char
    
  TVersionInfo* = object
    majorVersion*: Int
    minorVersion*: Int
    buildNumber*: Int
    platformID*: Int
    sPVersion*: String ## Full Service pack version string
    sPMajor*: Int ## Major service pack version
    sPMinor*: Int ## Minor service pack version
    suiteMask*: Int
    productType*: Int
    
  TPartitionInfo* = tuple[freeSpace, totalSpace: Tfiletime]
  
const
  # SuiteMask - VersionInfo.SuiteMask
  VerSuiteBackoffice* = 0x00000004
  VerSuiteBlade* = 0x00000400
  VerSuiteComputeServer* = 0x00004000
  VerSuiteDatacenter* = 0x00000080
  VerSuiteEnterprise* = 0x00000002
  VerSuiteEmbeddednt* = 0x00000040
  VerSuitePersonal* = 0x00000200
  VerSuiteSingleuserts* = 0x00000100
  VerSuiteSmallbusiness* = 0x00000001
  VerSuiteSmallbusinessRestricted* = 0x00000020
  VerSuiteStorageServer* = 0x00002000
  VerSuiteTerminal* = 0x00000010
  VerSuiteWhServer* = 0x00008000

  # ProductType - VersionInfo.ProductType
  VerNtDomainController* = 0x0000002
  VerNtServer* = 0x0000003
  VerNtWorkstation* = 0x0000001
  
  VerPlatformWin32Nt* = 2
  
  # Product Info - getProductInfo() - (Remove unused ones ?)
  ProductBusiness* = 0x00000006
  ProductBusinessN* = 0x00000010
  ProductClusterServer* = 0x00000012
  ProductDatacenterServer* = 0x00000008
  ProductDatacenterServerCore* = 0x0000000C
  ProductDatacenterServerCoreV* = 0x00000027
  ProductDatacenterServerV* = 0x00000025
  ProductEnterprise* = 0x00000004
  ProductEnterpriseE* = 0x00000046
  ProductEnterpriseN* = 0x0000001B
  ProductEnterpriseServer* = 0x0000000A
  ProductEnterpriseServerCore* = 0x0000000E
  ProductEnterpriseServerCoreV* = 0x00000029
  ProductEnterpriseServerIa64* = 0x0000000F
  ProductEnterpriseServerV* = 0x00000026
  ProductHomeBasic* = 0x00000002
  ProductHomeBasicE* = 0x00000043
  ProductHomeBasicN* = 0x00000005
  ProductHomePremium* = 0x00000003
  ProductHomePremiumE* = 0x00000044
  ProductHomePremiumN* = 0x0000001A
  ProductHyperv* = 0x0000002A
  ProductMediumbusinessServerManagement* = 0x0000001E
  ProductMediumbusinessServerMessaging* = 0x00000020
  ProductMediumbusinessServerSecurity* = 0x0000001F
  ProductProfessional* = 0x00000030
  ProductProfessionalE* = 0x00000045
  ProductProfessionalN* = 0x00000031
  ProductServerForSmallbusiness* = 0x00000018
  ProductServerForSmallbusinessV* = 0x00000023
  ProductServerFoundation* = 0x00000021
  ProductSmallbusinessServer* = 0x00000009
  ProductStandardServer* = 0x00000007
  ProductStandardServerCore * = 0x0000000D
  ProductStandardServerCoreV* = 0x00000028
  ProductStandardServerV* = 0x00000024
  ProductStarter* = 0x0000000B
  ProductStarterE* = 0x00000042
  ProductStarterN* = 0x0000002F
  ProductStorageEnterpriseServer* = 0x00000017
  ProductStorageExpressServer* = 0x00000014
  ProductStorageStandardServer* = 0x00000015
  ProductStorageWorkgroupServer* = 0x00000016
  ProductUndefined* = 0x00000000
  ProductUltimate* = 0x00000001
  ProductUltimateE* = 0x00000047
  ProductUltimateN* = 0x0000001C
  ProductWebServer* = 0x00000011
  ProductWebServerCore* = 0x0000001D
  
  ProcessorArchitectureAmd64* = 9 ## x64 (AMD or Intel)
  ProcessorArchitectureIa64* = 6 ## Intel Itanium Processor Family (IPF)
  ProcessorArchitectureIntel* = 0 ## x86
  ProcessorArchitectureUnknown* = 0xffff ## Unknown architecture.
  
  # GetSystemMetrics
  SmServerr2 = 89 
  
proc globalMemoryStatusEx*(lpBuffer: var TMEMORYSTATUSEX){.stdcall, dynlib: "kernel32",
    importc: "GlobalMemoryStatusEx".}
    
proc getMemoryInfo*(): TMemoryInfo =
  ## Retrieves memory info
  var statex: TMEMORYSTATUSEX
  statex.dwLength = sizeof(statex).Int32

  globalMemoryStatusEx(statex)
  result.MemoryLoad = statex.dwMemoryLoad
  result.TotalPhysMem = statex.ullTotalPhys
  result.AvailablePhysMem = statex.ullAvailPhys
  result.TotalPageFile = statex.ullTotalPageFile
  result.AvailablePageFile = statex.ullAvailPageFile
  result.TotalVirtualMem = statex.ullTotalVirtual
  result.AvailableVirtualMem = statex.ullAvailExtendedVirtual

proc getVersionEx*(lpVersionInformation: var TOSVERSIONINFOEX): Winbool{.stdcall,
    dynlib: "kernel32", importc: "GetVersionExA".}

proc getProcAddress*(hModule: Int, lpProcName: Cstring): Pointer{.stdcall,
    dynlib: "kernel32", importc: "GetProcAddress".}

proc GetModuleHandleA*(lpModuleName: Cstring): Int{.stdcall,
     dynlib: "kernel32", importc.}

proc getVersionInfo*(): TVersionInfo =
  ## Retrieves operating system info
  var osvi: TOSVERSIONINFOEX
  osvi.dwOSVersionInfoSize = sizeof(osvi).Int32
  discard getVersionEx(osvi)
  result.majorVersion = osvi.dwMajorVersion
  result.minorVersion = osvi.dwMinorVersion
  result.buildNumber = osvi.dwBuildNumber
  result.platformID = osvi.dwPlatformId
  result.SPVersion = $osvi.szCSDVersion
  result.SPMajor = osvi.wServicePackMajor
  result.SPMinor = osvi.wServicePackMinor
  result.SuiteMask = osvi.wSuiteMask
  result.ProductType = osvi.wProductType

proc getProductInfo*(majorVersion, minorVersion, SPMajorVersion, 
                     SPMinorVersion: Int): Int =
  ## Retrieves Windows' ProductInfo, this function only works in Vista and 7

  var pGPI = cast[proc (dwOSMajorVersion, dwOSMinorVersion, 
              dwSpMajorVersion, dwSpMinorVersion: Int32, outValue: PInt32)](getProcAddress(
                GetModuleHandleA("kernel32.dll"), "GetProductInfo"))
                
  if pGPI != nil:
    var dwType: Int32
    pGPI(Int32(majorVersion), Int32(minorVersion), Int32(sPMajorVersion), Int32(sPMinorVersion), addr(dwType))
    result = Int(dwType)
  else:
    return PRODUCT_UNDEFINED

proc getSystemInfo*(lpSystemInfo: LpsystemInfo){.stdcall, dynlib: "kernel32",
    importc: "GetSystemInfo".}
    
proc getSystemInfo*(): TSYSTEM_INFO =
  ## Returns the SystemInfo

  # Use GetNativeSystemInfo if it's available
  var pGNSI = cast[proc (lpSystemInfo: LpsystemInfo)](getProcAddress(
                GetModuleHandleA("kernel32.dll"), "GetNativeSystemInfo"))
                
  var systemi: TSYSTEM_INFO              
  if pGNSI != nil:
    pGNSI(addr(systemi))
  else:
    getSystemInfo(addr(systemi))

  return systemi

proc getSystemMetrics*(nIndex: Int32): Int32{.stdcall, dynlib: "user32",
    importc: "GetSystemMetrics".}

proc `$`*(osvi: TVersionInfo): String =
  ## Turns a VersionInfo object, into a string

  if osvi.platformID == VER_PLATFORM_WIN32_NT and osvi.majorVersion > 4:
    result = "Microsoft "
    
    var si = getSystemInfo()
    # Test for the specific product
    if osvi.majorVersion == 6:
      if osvi.minorVersion == 0:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.add("Windows Vista ")
        else: result.add("Windows Server 2008 ")
      elif osvi.minorVersion == 1:
        if osvi.ProductType == VER_NT_WORKSTATION:
          result.add("Windows 7 ")
        else: result.add("Windows Server 2008 R2 ")
    
      var dwType = getProductInfo(osvi.majorVersion, osvi.minorVersion, 0, 0)
      case dwType
      of PRODUCT_ULTIMATE:
        result.add("Ultimate Edition")
      of PRODUCT_PROFESSIONAL:
        result.add("Professional")
      of PRODUCT_HOME_PREMIUM:
        result.add("Home Premium Edition")
      of PRODUCT_HOME_BASIC:
        result.add("Home Basic Edition")
      of PRODUCT_ENTERPRISE:
        result.add("Enterprise Edition")
      of PRODUCT_BUSINESS:
        result.add("Business Edition")
      of PRODUCT_STARTER:
        result.add("Starter Edition")
      of PRODUCT_CLUSTER_SERVER:
        result.add("Cluster Server Edition")
      of PRODUCT_DATACENTER_SERVER:
        result.add("Datacenter Edition")
      of PRODUCT_DATACENTER_SERVER_CORE:
        result.add("Datacenter Edition (core installation)")
      of PRODUCT_ENTERPRISE_SERVER:
        result.add("Enterprise Edition")
      of PRODUCT_ENTERPRISE_SERVER_CORE:
        result.add("Enterprise Edition (core installation)")
      of PRODUCT_ENTERPRISE_SERVER_IA64:
        result.add("Enterprise Edition for Itanium-based Systems")
      of PRODUCT_SMALLBUSINESS_SERVER:
        result.add("Small Business Server")
      of PRODUCT_STANDARD_SERVER:
        result.add("Standard Edition")
      of PRODUCT_STANDARD_SERVER_CORE:
        result.add("Standard Edition (core installation)")
      of PRODUCT_WEB_SERVER:
        result.add("Web Server Edition")
      else:
        nil
    # End of Windows 6.*

    if osvi.majorVersion == 5 and osvi.minorVersion == 2:
      if getSystemMetrics(SM_SERVERR2) != 0:
        result.add("Windows Server 2003 R2, ")
      elif (osvi.SuiteMask and VER_SUITE_PERSONAL) != 0: # Not sure if this will work
        result.add("Windows Storage Server 2003")
      elif (osvi.SuiteMask and VER_SUITE_WH_SERVER) != 0:
        result.add("Windows Home Server")
      elif osvi.ProductType == VER_NT_WORKSTATION and 
          si.wProcessorArchitecture==PROCESSOR_ARCHITECTURE_AMD64:
        result.add("Windows XP Professional x64 Edition")
      else:
        result.add("Windows Server 2003, ")
      
      # Test for the specific product
      if osvi.ProductType != VER_NT_WORKSTATION:
        if ze(si.wProcessorArchitecture) == PROCESSOR_ARCHITECTURE_IA64:
          if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
            result.add("Datacenter Edition for Itanium-based Systems")
          elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
            result.add("Enterprise Edition for Itanium-based Systems")
        elif ze(si.wProcessorArchitecture) == PROCESSOR_ARCHITECTURE_AMD64:
          if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
            result.add("Datacenter x64 Edition")
          elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
            result.add("Enterprise x64 Edition")
          else:
            result.add("Standard x64 Edition")
        else:
          if (osvi.SuiteMask and VER_SUITE_COMPUTE_SERVER) != 0:
            result.add("Compute Cluster Edition")
          elif (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
            result.add("Datacenter Edition")
          elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
            result.add("Enterprise Edition")
          elif (osvi.SuiteMask and VER_SUITE_BLADE) != 0:
            result.add("Web Edition")
          else:
            result.add("Standard Edition")
    # End of 5.2
    
    if osvi.majorVersion == 5 and osvi.minorVersion == 1:
      result.add("Windows XP ")
      if (osvi.SuiteMask and VER_SUITE_PERSONAL) != 0:
        result.add("Home Edition")
      else:
        result.add("Professional")
    # End of 5.1
    
    if osvi.majorVersion == 5 and osvi.minorVersion == 0:
      result.add("Windows 2000 ")
      if osvi.ProductType == VER_NT_WORKSTATION:
        result.add("Professional")
      else:
        if (osvi.SuiteMask and VER_SUITE_DATACENTER) != 0:
          result.add("Datacenter Server")
        elif (osvi.SuiteMask and VER_SUITE_ENTERPRISE) != 0:
          result.add("Advanced Server")
        else:
          result.add("Server")
    # End of 5.0
    
    # Include service pack (if any) and build number.
    if len(osvi.SPVersion) > 0:
      result.add(" ")
      result.add(osvi.SPVersion)
    
    result.add(" (build " & $osvi.buildNumber & ")")
    
    if osvi.majorVersion >= 6:
      if ze(si.wProcessorArchitecture) == PROCESSOR_ARCHITECTURE_AMD64:
        result.add(", 64-bit")
      elif ze(si.wProcessorArchitecture) == PROCESSOR_ARCHITECTURE_INTEL:
        result.add(", 32-bit")
    
  else:
    # Windows 98 etc...
    result = "Unknown version of windows[Kernel version <= 4]"
    

proc getFileSize*(file: String): BiggestInt =
  var fileData: TWIN32_FIND_DATA

  when useWinUnicode:
    var aa = newWideCString(file)
    var hFile = findFirstFileW(aa, fileData)
  else:
    var hFile = FindFirstFileA(file, fileData)
  
  if hFile == INVALID_HANDLE_VALUE:
    raise newException(Eio, $GetLastError())
  
  return fileData.nFileSizeLow

proc getDiskFreeSpaceEx*(lpDirectoryName: Cstring, lpFreeBytesAvailableToCaller,
                         lpTotalNumberOfBytes,
                         lpTotalNumberOfFreeBytes: var TFiletime): Winbool{.
    stdcall, dynlib: "kernel32", importc: "GetDiskFreeSpaceExA".}

proc getPartitionInfo*(partition: String): TPartitionInfo =
  ## Retrieves partition info, for example ``partition`` may be ``"C:\"``
  var freeBytes, totalBytes, totalFreeBytes: TFiletime 
  var res = getDiskFreeSpaceEx(r"C:\", freeBytes, totalBytes, 
                               totalFreeBytes)
  return (freeBytes, totalBytes)

when isMainModule:
  var r = getMemoryInfo()
  echo("Memory load: ", r.MemoryLoad, "%")
  
  var osvi = getVersionInfo()
  
  echo($osvi)

  echo(getFileSize(r"osinfo_win.nim") div 1024 div 1024)
  
  echo(rdFileTime(getPartitionInfo(r"C:\")[0]))
