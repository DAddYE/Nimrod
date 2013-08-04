import posix, strutils, os

type
  Tstatfs {.importc: "struct statfs64", 
            header: "<sys/statfs.h>", final, pure.} = object
    f_type: Int
    f_bsize: Int
    f_blocks: Int
    f_bfree: Int
    f_bavail: Int
    f_files: Int
    f_ffree: Int
    f_fsid: Int
    f_namelen: Int

proc statfs(path: String, buf: var Tstatfs): Int {.
  importc, header: "<sys/vfs.h>".}


proc getSystemVersion*(): String =
  result = ""
  
  var unixInfo: Tutsname
  
  if uname(unixInfo) != 0:
    os.OSError()
  
  if $unixInfo.sysname == "Linux":
    # Linux
    result.add("Linux ")

    result.add($unixInfo.release & " ")
    result.add($unixInfo.machine)
  elif $unixInfo.sysname == "Darwin":
    # Darwin
    result.add("Mac OS X ")
    if "10" in $unixInfo.release:
      result.add("v10.6 Snow Leopard")
    elif "9" in $unixInfo.release:
      result.add("v10.5 Leopard")
    elif "8" in $unixInfo.release:
      result.add("v10.4 Tiger")
    elif "7" in $unixInfo.release:
      result.add("v10.3 Panther")
    elif "6" in $unixInfo.release:
      result.add("v10.2 Jaguar")
    elif "1.4" in $unixInfo.release:
      result.add("v10.1 Puma")
    elif "1.3" in $unixInfo.release:
      result.add("v10.0 Cheetah")
    elif "0" in $unixInfo.release:
      result.add("Server 1.0 Hera")
  else:
    result.add($unixInfo.sysname & " " & $unixInfo.release)
    
    
when false:
  var unix_info: TUtsname
  echo(uname(unix_info))
  echo(unix_info.sysname)
  echo("8" in $unix_info.release)

  echo(getSystemVersion())

  var stfs: TStatfs
  echo(statfs("sysinfo_posix.nim", stfs))
  echo(stfs.f_files)
  
