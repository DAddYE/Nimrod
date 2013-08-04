#
#  tre.h - TRE public API definitions
#
#  This software is released under a BSD-style license.
#  See the file LICENSE for details and copyright.
#
#

when not defined(treDll):
  when hostOS == "windows":
    const treDll = "tre.dll"
  elif hostOS == "macosx":
    const treDll = "libtre.dylib"
  else:
    const treDll = "libtre.so(.5|)"

const 
  Approx* = 1 ## approximate matching functionality
  Multibyte* = 1 ## multibyte character set support. 
  Version* = "0.8.0" ## TRE version string. 
  Version1* = 0 ## TRE version level 1. 
  Version2* = 8 ## TRE version level 2. 
  Version3* = 0 ## TRE version level 3. 


# If the we're not using system regex.h, we need to define the
#   structs and enums ourselves. 

type 
  TRegoff* = Cint
  TRegex*{.pure, final.} = object 
    re_nsub*: Int          ## Number of parenthesized subexpressions. 
    value*: Pointer        ## For internal use only. 
  
  TRegmatch*{.pure, final.} = object 
    rm_so*: TRegoff
    rm_eo*: TRegoff

  TReg_errcode*{.size: 4.} = enum  ## POSIX tre_regcomp() return error codes. 
                                   ## (In the order listed in the standard.)	 
    REG_OK = 0,               ## No error. 
    REG_NOMATCH,              ## No match. 
    REG_BADPAT,               ## Invalid regexp. 
    REG_ECOLLATE,             ## Unknown collating element. 
    REG_ECTYPE,               ## Unknown character class name. 
    REG_EESCAPE,              ## Trailing backslash. 
    REG_ESUBREG,              ## Invalid back reference. 
    REG_EBRACK,               ## "[]" imbalance 
    REG_EPAREN,               ## "\(\)" or "()" imbalance 
    REG_EBRACE,               ## "\{\}" or "{}" imbalance 
    REG_BADBR,                ## Invalid content of {} 
    REG_ERANGE,               ## Invalid use of range operator 
    REG_ESPACE,               ## Out of memory.  
    REG_BADRPT                ## Invalid use of repetition operators. 

# POSIX tre_regcomp() flags. 

const 
  RegExtended* = 1
  RegIcase* = (REG_EXTENDED shl 1)
  RegNewline* = (REG_ICASE shl 1)
  RegNosub* = (REG_NEWLINE shl 1)

# Extra tre_regcomp() flags. 

const 
  RegBasic* = 0
  RegLiteral* = (REG_NOSUB shl 1)
  RegRightAssoc* = (REG_LITERAL shl 1)
  RegUngreedy* = (REG_RIGHT_ASSOC shl 1)

# POSIX tre_regexec() flags. 

const 
  RegNotbol* = 1
  RegNoteol* = (REG_NOTBOL shl 1)

# Extra tre_regexec() flags. 

const 
  RegApproxMatcher* = (REG_NOTEOL shl 1)
  RegBacktrackingMatcher* = (REG_APPROX_MATCHER shl 1)

# The maximum number of iterations in a bound expression. 

const 
  ReDupMax* = 255

# The POSIX.2 regexp functions 

proc regcomp*(preg: var TRegex, regex: Cstring, cflags: Cint): Cint{.cdecl, 
    importc: "tre_regcomp", dynlib: treDll.}
proc regexec*(preg: var TRegex, string: Cstring, nmatch: Int, 
              pmatch: ptr TRegmatch, eflags: Cint): Cint{.cdecl, 
    importc: "tre_regexec", dynlib: treDll.}
proc regerror*(errcode: Cint, preg: var TRegex, errbuf: Cstring, 
               errbuf_size: Int): Int{.cdecl, importc: "tre_regerror", 
    dynlib: treDll.}
proc regfree*(preg: var TRegex){.cdecl, importc: "tre_regfree", dynlib: treDll.}
# Versions with a maximum length argument and therefore the capability to
#   handle null characters in the middle of the strings (not in POSIX.2). 

proc regncomp*(preg: var TRegex, regex: Cstring, len: Int, cflags: Cint): Cint{.
    cdecl, importc: "tre_regncomp", dynlib: treDll.}
proc regnexec*(preg: var TRegex, string: Cstring, len: Int, nmatch: Int, 
               pmatch: ptr TRegmatch, eflags: Cint): Cint{.cdecl, 
    importc: "tre_regnexec", dynlib: treDll.}
# Approximate matching parameter struct. 

type 
  TRegaparams*{.pure, final.} = object 
    cost_ins*: Cint           ## Default cost of an inserted character. 
    cost_del*: Cint           ## Default cost of a deleted character. 
    cost_subst*: Cint         ## Default cost of a substituted character. 
    max_cost*: Cint           ## Maximum allowed cost of a match. 
    max_ins*: Cint            ## Maximum allowed number of inserts. 
    max_del*: Cint            ## Maximum allowed number of deletes. 
    max_subst*: Cint          ## Maximum allowed number of substitutes. 
    max_err*: Cint            ## Maximum allowed number of errors total. 
  

# Approximate matching result struct. 

type 
  TRegamatch*{.pure, final.} = object 
    nmatch*: Int              ## Length of pmatch[] array. 
    pmatch*: ptr TRegmatch    ## Submatch data. 
    cost*: Cint               ## Cost of the match. 
    num_ins*: Cint            ## Number of inserts in the match. 
    num_del*: Cint            ## Number of deletes in the match. 
    num_subst*: Cint          ## Number of substitutes in the match. 
  

# Approximate matching functions. 

proc regaexec*(preg: var TRegex, string: Cstring, match: ptr TRegamatch, 
               params: TRegaparams, eflags: Cint): Cint{.cdecl, 
    importc: "tre_regaexec", dynlib: treDll.}
proc reganexec*(preg: var TRegex, string: Cstring, len: Int, 
                match: ptr TRegamatch, params: TRegaparams, 
                eflags: Cint): Cint{.
    cdecl, importc: "tre_reganexec", dynlib: treDll.}
# Sets the parameters to default values. 

proc regaparamsDefault*(params: ptr TRegaparams){.cdecl, 
    importc: "tre_regaparams_default", dynlib: treDll.}

type 
  TStrSource*{.pure, final.} = object 
    get_next_char*: proc (c: Cstring, pos_add: ptr Cint, 
                          context: Pointer): Cint{.cdecl.}
    rewind*: proc (pos: Int, context: Pointer){.cdecl.}
    compare*: proc (pos1: Int, pos2: Int, len: Int, context: Pointer): Cint{.
        cdecl.}
    context*: Pointer


proc reguexec*(preg: var TRegex, string: ptr TStrSource, nmatch: Int, 
               pmatch: ptr TRegmatch, eflags: Cint): Cint{.cdecl, 
    importc: "tre_reguexec", dynlib: treDll.}

proc runtimeVersion*(): Cstring{.cdecl, importc: "tre_version", dynlib: treDll.}
  # Returns the version string.	The returned string is static. 

proc config*(query: Cint, result: Pointer): Cint{.cdecl, importc: "tre_config", 
    dynlib: treDll.}
  # Returns the value for a config parameter.  The type to which `result`
  # must point to depends of the value of `query`, see documentation for
  # more details. 

const 
  ConfigApprox* = 0
  ConfigWchar* = 1
  ConfigMultibyte* = 2
  ConfigSystemAbi* = 3
  ConfigVersion* = 4

# Returns 1 if the compiled pattern has back references, 0 if not. 

proc haveBackrefs*(preg: var TRegex): Cint{.cdecl, 
    importc: "tre_have_backrefs", dynlib: treDll.}
# Returns 1 if the compiled pattern uses approximate matching features,
#   0 if not. 

proc haveApprox*(preg: var TRegex): Cint{.cdecl, importc: "tre_have_approx", 
    dynlib: treDll.}
