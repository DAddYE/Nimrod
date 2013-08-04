#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# Headers for procs that the code generator depends on ("compilerprocs")

proc addChar(s: NimString, c: Char): NimString {.compilerProc.}

type
  TLibHandle = Pointer       # private type
  TProcAddr = Pointer        # libary loading and loading of procs:

proc nimLoadLibrary(path: String): TLibHandle {.compilerproc.}
proc nimUnloadLibrary(lib: TLibHandle) {.compilerproc.}
proc nimGetProcAddr(lib: TLibHandle, name: Cstring): TProcAddr {.compilerproc.}

proc nimLoadLibraryError(path: String) {.compilerproc, noinline.}

proc setStackBottom(theStackBottom: Pointer) {.compilerRtl, noinline.}

