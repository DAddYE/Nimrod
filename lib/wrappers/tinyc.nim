#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2010 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

type
  TccState {.pure, final.} = object
  PccState* = ptr TccState
  
  TErrorFunc* = proc (opaque: Pointer, msg: Cstring) {.cdecl.}

proc openCCState*(): PccState {.importc: "tcc_new", cdecl.}
  ## create a new TCC compilation context

proc closeCCState*(s: PccState) {.importc: "tcc_delete", cdecl.}
  ## free a TCC compilation context

proc enableDebug*(s: PccState) {.importc: "tcc_enable_debug", cdecl.}
  ## add debug information in the generated code

proc setErrorFunc*(s: PccState, errorOpaque: Pointer, errorFun: TErrorFunc) {.
  cdecl, importc: "tcc_set_error_func".}
  ## set error/warning display callback

proc setWarning*(s: PccState, warningName: Cstring, value: Int) {.cdecl,
  importc: "tcc_set_warning".}
  ## set/reset a warning

# preprocessor 

proc addIncludePath*(s: PccState, pathname: Cstring) {.cdecl, 
  importc: "tcc_add_include_path".}
  ## add include path

proc addSysincludePath*(s: PccState, pathname: Cstring) {.cdecl, 
  importc: "tcc_add_sysinclude_path".}
  ## add in system include path


proc defineSymbol*(s: PccState, sym, value: Cstring) {.cdecl, 
  importc: "tcc_define_symbol".}
  ## define preprocessor symbol 'sym'. Can put optional value

proc undefineSymbol*(s: PccState, sym: Cstring) {.cdecl, 
  importc: "tcc_undefine_symbol".}
  ## undefine preprocess symbol 'sym'

# compiling 

proc addFile*(s: PccState, filename: Cstring): Cint {.cdecl, 
  importc: "tcc_add_file".}
  ## add a file (either a C file, dll, an object, a library or an ld
  ## script). Return -1 if error.

proc compileString*(s: PccState, buf: Cstring): Cint {.cdecl, 
  importc: "tcc_compile_string".}
  ## compile a string containing a C source. Return non zero if error.

# linking commands


const
  OutputMemory*: Cint = 0 ## output will be ran in memory (no
                          ## output file) (default)
  OutputExe*: Cint = 1 ## executable file
  OutputDll*: Cint = 2 ## dynamic library
  OutputObj*: Cint = 3 ## object file
  OutputPreprocess*: Cint = 4 ## preprocessed file (used internally)
  
  OutputFormatElf*: Cint = 0 ## default output format: ELF
  OutputFormatBinary*: Cint = 1 ## binary image output
  OutputFormatCoff*: Cint = 2 ## COFF

proc setOutputType*(s: PccState, outputType: Cint): Cint {.cdecl, 
  importc: "tcc_set_output_type".}
  ## set output type. MUST BE CALLED before any compilation

proc addLibraryPath*(s: PccState, pathname: Cstring): Cint {.cdecl,
  importc: "tcc_add_library_path".}
  ## equivalent to -Lpath option

proc addLibrary*(s: PccState, libraryname: Cstring): Cint {.cdecl,
  importc: "tcc_add_library".}
  ## the library name is the same as the argument of the '-l' option

proc addSymbol*(s: PccState, name: Cstring, val: Pointer): Cint {.cdecl,
  importc: "tcc_add_symbol".}
  ## add a symbol to the compiled program

proc outputFile*(s: PccState, filename: Cstring): Cint {.cdecl,
  importc: "tcc_output_file".}
  ## output an executable, library or object file. DO NOT call
  ## tcc_relocate() before.

proc run*(s: PccState, argc: Cint, argv: CstringArray): Cint {.cdecl,
  importc: "tcc_run".}
  ## link and run main() function and return its value. DO NOT call
  ## tcc_relocate() before.

proc relocate*(s: PccState, p: Pointer): Cint {.cdecl,
  importc: "tcc_relocate".}
  ## copy code into memory passed in by the caller and do all relocations
  ## (needed before using tcc_get_symbol()).
  ## returns -1 on error and required size if ptr is NULL

proc getSymbol*(s: PccState, name: Cstring): Pointer {.cdecl,
  importc: "tcc_get_symbol".}
  ## return symbol value or NULL if not found

proc setLibPath*(s: PccState, path: Cstring) {.cdecl,
  importc: "tcc_set_lib_path".}
  ## set CONFIG_TCCDIR at runtime
  

