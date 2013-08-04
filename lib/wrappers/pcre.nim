#************************************************
#       Perl-Compatible Regular Expressions      *
#***********************************************
# This is the public header file for the PCRE library, to be #included by
#applications that call the PCRE functions.
#
#           Copyright (c) 1997-2010 University of Cambridge
#
#-----------------------------------------------------------------------------
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
#     Redistributions of source code must retain the above copyright notice,
#      this list of conditions and the following disclaimer.
#
#     Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#
#     Neither the name of the University of Cambridge nor the names of its
#      contributors may be used to endorse or promote products derived from
#      this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
#LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#POSSIBILITY OF SUCH DAMAGE.
#-----------------------------------------------------------------------------
#

{.deadcodeElim: on.}

when not defined(pcreDll):
  when hostOS == "windows":
    const pcreDll = "pcre.dll"
  elif hostOS == "macosx":
    const pcreDll = "libpcre(.3|.1|).dylib"
  else:
    const pcreDll = "libpcre.so(.3|.1|)"
  {.pragma: pcreImport, dynlib: pcreDll.}
else:
  {.pragma: pcreImport, header: "<pcre.h>".}

# The current PCRE version information. 

const 
  Major* = 8
  Minor* = 31
  Prerelease* = true
  Date* = "2012-07-06"

# When an application links to a PCRE DLL in Windows, the symbols that are
# imported have to be identified as such. When building PCRE, the appropriate
# export setting is defined in pcre_internal.h, which includes this file. So we
# don't change existing definitions of PCRE_EXP_DECL and PCRECPP_EXP_DECL. 

# Have to include stdlib.h in order to ensure that size_t is defined;
# it is needed here for malloc. 

# Allow for C++ users 

# Options. Some are compile-time only, some are run-time only, and some are
# both, so we keep them all distinct. 

const 
  Caseless* = 0x00000001
  Multiline* = 0x00000002
  Dotall* = 0x00000004
  Extended* = 0x00000008
  Anchored* = 0x00000010
  DollarEndonly* = 0x00000020
  Extra* = 0x00000040
  Notbol* = 0x00000080
  Noteol* = 0x00000100
  Ungreedy* = 0x00000200
  Notempty* = 0x00000400
  Utf8* = 0x00000800
  NoAutoCapture* = 0x00001000
  NoUtf8Check* = 0x00002000
  AutoCallout* = 0x00004000
  PartialSoft* = 0x00008000
  Partial* = 0x00008000       # Backwards compatible synonym 
  DfaShortest* = 0x00010000
  DfaRestart* = 0x00020000
  Firstline* = 0x00040000
  Dupnames* = 0x00080000
  NewlineCr* = 0x00100000
  NewlineLf* = 0x00200000
  NewlineCrlf* = 0x00300000
  NewlineAny* = 0x00400000
  NewlineAnycrlf* = 0x00500000
  BsrAnycrlf* = 0x00800000
  BsrUnicode* = 0x01000000
  JavascriptCompat* = 0x02000000
  NoStartOptimize* = 0x04000000
  NoStartOptimise* = 0x04000000
  PartialHard* = 0x08000000
  NotemptyAtstart* = 0x10000000
  Ucp* = 0x20000000

# Exec-time and get/set-time error codes 

const 
  ErrorNomatch* = (- 1)
  ErrorNull* = (- 2)
  ErrorBadoption* = (- 3)
  ErrorBadmagic* = (- 4)
  ErrorUnknownOpcode* = (- 5)
  ErrorUnknownNode* = (- 5) # For backward compatibility 
  ErrorNomemory* = (- 6)
  ErrorNosubstring* = (- 7)
  ErrorMatchlimit* = (- 8)
  ErrorCallout* = (- 9)      # Never used by PCRE itself 
  ErrorBadutf8* = (- 10)
  ErrorBadutf8Offset* = (- 11)
  ErrorPartial* = (- 12)
  ErrorBadpartial* = (- 13)
  ErrorInternal* = (- 14)
  ErrorBadcount* = (- 15)
  ErrorDfaUitem* = (- 16)
  ErrorDfaUcond* = (- 17)
  ErrorDfaUmlimit* = (- 18)
  ErrorDfaWssize* = (- 19)
  ErrorDfaRecurse* = (- 20)
  ErrorRecursionlimit* = (- 21)
  ErrorNullwslimit* = (- 22) # No longer actually used 
  ErrorBadnewline* = (- 23)
  ErrorBadoffset* = (- 24)
  ErrorShortutf8* = (- 25)
  ErrorRecurseloop* = (- 26)
  ErrorJitStacklimit* = (- 27)
  ErrorBadmode* = (- 28)
  ErrorBadendianness* = (- 29)
  ErrorDfaBadrestart* = (- 30)

# Specific error codes for UTF-8 validity checks

const
  Utf8Err0* = 0
  Utf8Err1* = 1
  Utf8Err2* = 2
  Utf8Err3* = 3
  Utf8Err4* = 4
  Utf8Err5* = 5
  Utf8Err6* = 6
  Utf8Err7* = 7
  Utf8Err8* = 8
  Utf8Err9* = 9
  Utf8Err10* = 10
  Utf8Err11* = 11
  Utf8Err12* = 12
  Utf8Err13* = 13
  Utf8Err14* = 14
  Utf8Err15* = 15
  Utf8Err16* = 16
  Utf8Err17* = 17
  Utf8Err18* = 18
  Utf8Err19* = 19
  Utf8Err20* = 20
  Utf8Err21* = 21

# Request types for pcre_fullinfo() 

const 
  InfoOptions* = 0
  InfoSize* = 1
  InfoCapturecount* = 2
  InfoBackrefmax* = 3
  InfoFirstbyte* = 4
  InfoFirstchar* = 4         # For backwards compatibility 
  InfoFirsttable* = 5
  InfoLastliteral* = 6
  InfoNameentrysize* = 7
  InfoNamecount* = 8
  InfoNametable* = 9
  InfoStudysize* = 10
  InfoDefaultTables* = 11
  InfoOkpartial* = 12
  InfoJchanged* = 13
  InfoHascrorlf* = 14
  InfoMinlength* = 15
  InfoJit* = 16
  InfoJitsize* = 17
  InfoMaxlookbehind* = 18

# Request types for pcre_config(). Do not re-arrange, in order to remain
# compatible. 

const 
  ConfigUtf8* = 0
  ConfigNewline* = 1
  ConfigLinkSize* = 2
  ConfigPosixMallocThreshold* = 3
  ConfigMatchLimit* = 4
  ConfigStackrecurse* = 5
  ConfigUnicodeProperties* = 6
  ConfigMatchLimitRecursion* = 7
  ConfigBsr* = 8
  ConfigJit* = 9
  ConfigJittarget* = 11

# Request types for pcre_study(). Do not re-arrange, in order to remain
# compatible.

const
  StudyJitCompile* = 0x00000001
  StudyJitPartialSoftCompile* = 0x00000002
  StudyJitPartialHardCompile* = 0x00000004

# Bit flags for the pcre_extra structure. Do not re-arrange or redefine
# these bits, just add new ones on the end, in order to remain compatible. 

const 
  ExtraStudyData* = 0x00000001
  ExtraMatchLimit* = 0x00000002
  ExtraCalloutData* = 0x00000004
  ExtraTables* = 0x00000008
  ExtraMatchLimitRecursion* = 0x00000010
  ExtraMark* = 0x00000020
  ExtraExecutableJit* = 0x00000040

# Types 

type 
  TPcre*{.pure, final.} = object
  PPcre* = ptr TPcre
  TjitStack*{.pure, final.} = object
  PjitStack* = ptr TjitStack

# When PCRE is compiled as a C++ library, the subject pointer type can be
# replaced with a custom type. For conventional use, the public interface is a
# const char *. 

# The structure for passing additional data to pcre_exec(). This is defined in
# such as way as to be extensible. Always add new fields at the end, in order to
# remain compatible. 

type 
  Textra*{.pure, final.} = object 
    flags*: Int                 ## Bits for which fields are set 
    study_data*: Pointer        ## Opaque data from pcre_study() 
    match_limit*: Int           ## Maximum number of calls to match() 
    callout_data*: Pointer      ## Data passed back in callouts 
    tables*: Cstring            ## Pointer to character tables 
    match_limit_recursion*: Int ## Max recursive calls to match() 
    mark*: ptr Cstring          ## For passing back a mark pointer 
    executable_jit*: Pointer    ## Contains a pointer to a compiled jit code
  

# The structure for passing out data via the pcre_callout_function. We use a
# structure so that new fields can be added on the end in future versions,
# without changing the API of the function, thereby allowing old clients to work
# without modification. 

type 
  TcalloutBlock*{.pure, final.} = object 
    version*: Cint            ## Identifies version of block 
    callout_number*: Cint     ## Number compiled into pattern 
    offset_vector*: ptr Cint  ## The offset vector 
    subject*: Cstring         ## The subject being matched 
    subject_length*: Cint     ## The length of the subject 
    start_match*: Cint        ## Offset to start of this match attempt 
    current_position*: Cint   ## Where we currently are in the subject 
    capture_top*: Cint        ## Max current capture 
    capture_last*: Cint       ## Most recently closed capture 
    callout_data*: Pointer    ## Data passed in with the call 
    pattern_position*: Cint   ## Offset to next item in the pattern 
    next_item_length*: Cint   ## Length of next item in the pattern
    mark*: Cstring            ## Pointer to current mark or NULL

# Indirection for store get and free functions. These can be set to
#alternative malloc/free functions if required. Special ones are used in the
#non-recursive case for "frames". There is also an optional callout function
#that is triggered by the (?) regex item. For Virtual Pascal, these definitions
#have to take another form.

# User defined callback which provides a stack just before the match starts.

type
  TjitCallback* = proc(p: Pointer): ptr TjitStack{.cdecl.}

# Exported PCRE functions 

proc compile*(a2: Cstring, a3: Cint, a4: ptr Cstring, a5: ptr Cint, 
              a6: ptr Char): ptr TPcre{.cdecl, importc: "pcre_compile", 
    pcreImport.}
proc compile2*(a2: Cstring, a3: Cint, a4: ptr Cint, a5: ptr Cstring, 
               a6: ptr Cint, a7: ptr Char): ptr TPcre{.cdecl, 
    importc: "pcre_compile2", pcreImport.}
proc config*(a2: Cint, a3: Pointer): Cint{.cdecl, importc: "pcre_config", 
    pcreImport.}
proc copyNamedSubstring*(a2: ptr TPcre, a3: Cstring, a4: ptr Cint, a5: Cint, 
                           a6: Cstring, a7: Cstring, a8: Cint): Cint{.cdecl, 
    importc: "pcre_copy_named_substring", pcreImport.}
proc copySubstring*(a2: Cstring, a3: ptr Cint, a4: Cint, a5: Cint, 
                     a6: Cstring, 
                     a7: Cint): Cint{.cdecl, importc: "pcre_copy_substring", 
                                      pcreImport.}
proc dfaExec*(a2: ptr TPcre, a3: ptr Textra, a4: Cstring, a5: Cint, 
               a6: Cint, a7: Cint, a8: ptr Cint, a9: Cint, a10: ptr Cint, 
               a11: Cint): Cint{.cdecl, importc: "pcre_dfa_exec", 
                                 pcreImport.}
proc exec*(a2: ptr TPcre, a3: ptr Textra, a4: Cstring, a5: Cint, a6: Cint, 
           a7: Cint, a8: ptr Cint, a9: Cint): Cint {.
           cdecl, importc: "pcre_exec", pcreImport.}
proc freeSubstring*(a2: Cstring){.cdecl, importc: "pcre_free_substring", 
                                   pcreImport.}
proc freeSubstringList*(a2: CstringArray){.cdecl, 
    importc: "pcre_free_substring_list", pcreImport.}
proc fullinfo*(a2: ptr TPcre, a3: ptr Textra, a4: Cint, a5: Pointer): Cint{.
    cdecl, importc: "pcre_fullinfo", pcreImport.}
proc getNamedSubstring*(a2: ptr TPcre, a3: Cstring, a4: ptr Cint, a5: Cint, 
                          a6: Cstring, a7: CstringArray): Cint{.cdecl, 
    importc: "pcre_get_named_substring", pcreImport.}
proc getStringnumber*(a2: ptr TPcre, a3: Cstring): Cint{.cdecl, 
    importc: "pcre_get_stringnumber", pcreImport.}
proc getStringtableEntries*(a2: ptr TPcre, a3: Cstring, a4: CstringArray, 
                              a5: CstringArray): Cint{.cdecl, 
    importc: "pcre_get_stringtable_entries", pcreImport.}
proc getSubstring*(a2: Cstring, a3: ptr Cint, a4: Cint, a5: Cint, 
                    a6: CstringArray): Cint{.cdecl, 
    importc: "pcre_get_substring", pcreImport.}
proc getSubstringList*(a2: Cstring, a3: ptr Cint, a4: Cint, 
                         a5: ptr CstringArray): Cint{.cdecl, 
    importc: "pcre_get_substring_list", pcreImport.}
proc maketables*(): ptr Char{.cdecl, importc: "pcre_maketables", 
                                       pcreImport.}
proc refcount*(a2: ptr TPcre, a3: Cint): Cint{.cdecl, importc: "pcre_refcount", 
    pcreImport.}
proc study*(a2: ptr TPcre, a3: Cint, a4: var Cstring): ptr Textra{.cdecl, 
    importc: "pcre_study", pcreImport.}
proc version*(): Cstring{.cdecl, importc: "pcre_version", pcreImport.}

# Utility functions for byte order swaps.

proc patternToHostByteOrder*(a2: ptr TPcre, a3: ptr Textra,
    a4: ptr Char): Cint{.cdecl, importc: "pcre_pattern_to_host_byte_order",
    pcreImport.}

# JIT compiler related functions.

proc jitStackAlloc*(a2: Cint, a3: Cint): ptr TjitStack{.cdecl,
    importc: "pcre_jit_stack_alloc", pcreImport.}
proc jitStackFree*(a2: ptr TjitStack){.cdecl, importc: "pcre_jit_stack_free",
    pcreImport.}
proc assignJitStack*(a2: ptr Textra, a3: TjitCallback, a4: Pointer){.cdecl,
    importc: "pcre_assign_jit_stack", pcreImport.}

var 
  pcreFree*: proc (p: ptr TPcre) {.cdecl.} 
