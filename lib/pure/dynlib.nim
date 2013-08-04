#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements the ability to access symbols from shared
## libraries. On POSIX this uses the ``dlsym`` mechanism, on 
## Windows ``LoadLibrary``. 

type
  TLibHandle* = Pointer ## a handle to a dynamically loaded library

proc loadLib*(path: String): TLibHandle
  ## loads a library from `path`. Returns nil if the library could not 
  ## be loaded.

proc loadLib*(): TLibHandle
  ## gets the handle from the current executable. Returns nil if the 
  ## library could not be loaded.

proc unloadLib*(lib: TLibHandle)
  ## unloads the library `lib`

proc raiseInvalidLibrary*(name: Cstring) {.noinline, noreturn.} =
  ## raises an `EInvalidLibrary` exception.
  var e: ref EInvalidLibrary
  new(e)
  e.msg = "could not find symbol: " & $name
  raise e

proc symAddr*(lib: TLibHandle, name: Cstring): Pointer
  ## retrieves the address of a procedure/variable from `lib`. Returns nil
  ## if the symbol could not be found.

proc checkedSymAddr*(lib: TLibHandle, name: Cstring): Pointer =
  ## retrieves the address of a procedure/variable from `lib`. Raises
  ## `EInvalidLibrary` if the symbol could not be found.
  result = symAddr(lib, name)
  if result == nil: raiseInvalidLibrary(name)

when defined(posix):
  #
  # =========================================================================
  # This is an implementation based on the dlfcn interface.
  # The dlfcn interface is available in Linux, SunOS, Solaris, IRIX, FreeBSD,
  # NetBSD, AIX 4.2, HPUX 11, and probably most other Unix flavors, at least
  # as an emulation layer on top of native functions.
  # =========================================================================
  #
  var
    rtldNow {.importc: "RTLD_NOW", header: "<dlfcn.h>".}: Int

  proc dlclose(lib: TLibHandle) {.importc, header: "<dlfcn.h>".}
  proc dlopen(path: Cstring, mode: Int): TLibHandle {.
      importc, header: "<dlfcn.h>".}
  proc dlsym(lib: TLibHandle, name: Cstring): Pointer {.
      importc, header: "<dlfcn.h>".}

  proc loadLib(path: string): TLibHandle = return dlopen(path, rtldNow)
  proc loadLib(): TLibHandle = return dlopen(nil, rtldNow)
  proc unloadLib(lib: TLibHandle) = dlclose(lib)
  proc symAddr(lib: TLibHandle, name: cstring): pointer = 
    return dlsym(lib, name)

elif defined(windows) or defined(dos):
  #
  # =======================================================================
  # Native Windows Implementation
  # =======================================================================
  #
  type
    THINSTANCE {.importc: "HINSTANCE".} = pointer

  proc FreeLibrary(lib: THINSTANCE) {.importc, header: "<windows.h>", stdcall.}
  proc winLoadLibrary(path: cstring): THINSTANCE {.
      importc: "LoadLibraryA", header: "<windows.h>", stdcall.}
  proc GetProcAddress(lib: THINSTANCE, name: cstring): pointer {.
      importc: "GetProcAddress", header: "<windows.h>", stdcall.}

  proc LoadLib(path: string): TLibHandle =
    result = cast[TLibHandle](winLoadLibrary(path))
  proc LoadLib(): TLibHandle =
    result = cast[TLibHandle](winLoadLibrary(nil))
  proc UnloadLib(lib: TLibHandle) = FreeLibrary(cast[THINSTANCE](lib))

  proc symAddr(lib: TLibHandle, name: cstring): pointer =
    result = GetProcAddress(cast[THINSTANCE](lib), name)

else:
  {.error: "no implementation for dynlib".}
