#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module contains the data structures for the C code generation phase.

import 
  ast, astalgo, ropes, passes, options, intsets, lists, platform

type
  TLabel* = PRope             # for the C generator a label is just a rope
  TCFileSection* = enum       # the sections a generated C file consists of
    cfsMergeInfo,             # section containing merge information
    cfsHeaders,               # section for C include file headers
    cfsForwardTypes,          # section for C forward typedefs
    cfsTypes,                 # section for C typedefs
    cfsSeqTypes,              # section for sequence types only
                              # this is needed for strange type generation
                              # reasons
    cfsFieldInfo,             # section for field information
    cfsTypeInfo,              # section for type information
    cfsProcHeaders,           # section for C procs prototypes
    cfsData,                  # section for C constant data
    cfsVars,                  # section for C variable declarations
    cfsProcs,                 # section for C procs that are not inline
    cfsInitProc,              # section for the C init proc
    cfsTypeInit1,             # section 1 for declarations of type information
    cfsTypeInit2,             # section 2 for init of type information
    cfsTypeInit3,             # section 3 for init of type information
    cfsDebugInit,             # section for init of debug information
    cfsDynLibInit,            # section for init of dynamic library binding
    cfsDynLibDeinit           # section for deinitialization of dynamic
                              # libraries
  TCTypeKind* = enum          # describes the type kind of a C type
    ctVoid, ctChar, ctBool,
    ctInt, ctInt8, ctInt16, ctInt32, ctInt64,
    ctFloat, ctFloat32, ctFloat64, ctFloat128,
    ctUInt, ctUInt8, ctUInt16, ctUInt32, ctUInt64,
    ctArray, ctStruct, ctPtr, ctNimStr, ctNimSeq, ctProc, ctCString
  TCFileSections* = Array[TCFileSection, PRope] # represents a generated C file
  TCProcSection* = enum       # the sections a generated C proc consists of
    cpsLocals,                # section of local variables for C proc
    cpsInit,                  # section for init of variables for C proc
    cpsStmts                  # section of local statements for C proc
  TCProcSections* = Array[TCProcSection, PRope] # represents a generated C proc
  BModule* = ref TCGen
  BProc* = ref TCProc
  TBlock*{.final.} = object 
    id*: Int                  # the ID of the label; positive means that it
    label*: PRope             # generated text for the label
                              # nil if label is not used
    sections*: TCProcSections # the code beloging
    isLoop*: Bool             # whether block is a loop
    nestedTryStmts*: Int16    # how many try statements is it nested into
    frameLen*: Int16
  
  TCProc{.final.} = object    # represents C proc that is currently generated
    prc*: PSym                # the Nimrod proc that this C proc belongs to
    beforeRetNeeded*: Bool    # true iff 'BeforeRet' label for proc is needed
    threadVarAccessed*: Bool  # true if the proc already accessed some threadvar
    nestedTryStmts*: Seq[PNode] # in how many nested try statements we are
                                # (the vars must be volatile then)
    inExceptBlock*: Int       # are we currently inside an except block?
                              # leaving such scopes by raise or by return must
                              # execute any applicable finally blocks
    labels*: Natural          # for generating unique labels in the C proc
    blocks*: Seq[TBlock]      # nested blocks
    breakIdx*: Int            # the block that will be exited
                              # with a regular break
    options*: TOptions        # options that should be used for code
                              # generation; this is the same as prc.options
                              # unless prc == nil
    maxFrameLen*: Int         # max length of frame descriptor
    module*: BModule          # used to prevent excessive parameter passing
    withinLoop*: Int          # > 0 if we are within a loop
    gcFrameId*: Natural       # for the GC stack marking
    gcFrameType*: PRope       # the struct {} we put the GC markers into
  
  TTypeSeq* = Seq[PType]
  TCGen = object of TPassContext # represents a C source file
    module*: PSym
    filename*: String
    s*: TCFileSections        # sections of the C file
    preventStackTrace*: Bool  # true if stack traces need to be prevented
    usesThreadVars*: Bool     # true if the module uses a thread var
    frameDeclared*: Bool      # hack for ROD support so that we don't declare
                              # a frame var twice in an init proc
    isHeaderFile*: Bool       # C source file is the header file
    cfilename*: String        # filename of the module (including path,
                              # without extension)
    typeCache*: TIdTable      # cache the generated types
    forwTypeCache*: TIdTable  # cache for forward declarations of types
    declaredThings*: TIntSet  # things we have declared in this .c file
    declaredProtos*: TIntSet  # prototypes we have declared in this .c file
    headerFiles*: TLinkedList # needed headers to include
    typeInfoMarker*: TIntSet  # needed for generating type information
    initProc*: BProc          # code for init procedure
    preInitProc*: BProc       # code executed before the init proc
                              # used for initialization code for
                              # .global. variables
                              # (or instantiated generic variables)
    typeStack*: TTypeSeq      # used for type generation
    dataCache*: TNodeTable
    forwardedProcs*: TSymSeq  # keep forwarded procs here
    typeNodes*, nimTypes*: Int # used for type info generation
    typeNodesName*, nimTypesName*: PRope # used for type info generation
    labels*: Natural          # for generating unique module-scope names
    extensionLoaders*: Array['0'..'9', PRope] # special procs for the
                                              # OpenGL wrapper

var
  mainModProcs*, mainModInit*, mainDatInit*: PRope # parts of the main module
  gMapping*: PRope             # the generated mapping file (if requested)
  gModules*: Seq[BModule] = @[] # list of all compiled modules
  gForwardedProcsCounter*: Int = 0

proc s*(p: BProc, s: TCProcSection): var PRope {.inline.} =
  # section in the current block
  result = p.blocks[p.blocks.len - 1].sections[s]

proc procSec*(p: BProc, s: TCProcSection): var PRope {.inline.} =
  # top level proc sections
  result = p.blocks[0].sections[s]

proc bmod*(module: PSym): BModule =
  # obtains the BModule for a given module PSym
  result = gModules[module.position]

proc newProc*(prc: PSym, module: BModule): BProc = 
  new(result)
  result.prc = prc
  result.module = module
  if prc != nil: result.options = prc.options
  else: result.options = gOptions
  newSeq(result.blocks, 1)
  result.nestedTryStmts = @[]

iterator cgenModules*: var BModule =
  for i in 0..high(gModules):
    # ultimately, we are iterating over the file ids here.
    # some "files" won't have an associated cgen module (like stdin)
    # and we must skip over them.
    if gModules[i] != nil: yield gModules[i]

