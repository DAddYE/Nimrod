#
#    Light-weight binding for the Python interpreter
#       (c) 2010 Andreas Rumpf 
#    Based on 'PythonEngine' module by Dr. Dietmar Budelsky
#
#
#************************************************************************
#                                                                        
# Module:  Unit 'PythonEngine'     Copyright (c) 1997                    
#                                                                        
# Version: 3.0                     Dr. Dietmar Budelsky                  
# Sub-Version: 0.25                dbudelsky@web.de                      
#                                  Germany                               
#                                                                        
#                                  Morgan Martinet                       
#                                  4721 rue Brebeuf                      
#                                  H2J 3L2 MONTREAL (QC)                 
#                                  CANADA                                
#                                  e-mail: mmm@free.fr                   
#                                                                        
#  look our page at: http://www.multimania.com/marat                     
#************************************************************************
#  Functionality:  Delphi Components that provide an interface to the    
#                  Python language (see python.txt for more infos on     
#                  Python itself).                                       
#                                                                        
#************************************************************************
#  Contributors:                                                         
#      Grzegorz Makarewicz (mak@mikroplan.com.pl)                        
#      Andrew Robinson (andy@hps1.demon.co.uk)                           
#      Mark Watts(mark_watts@hotmail.com)                                
#      Olivier Deckmyn (olivier.deckmyn@mail.dotcom.fr)                  
#      Sigve Tjora (public@tjora.no)                                     
#      Mark Derricutt (mark@talios.com)                                  
#      Igor E. Poteryaev (jah@mail.ru)                                   
#      Yuri Filimonov (fil65@mail.ru)                                    
#      Stefan Hoffmeister (Stefan.Hoffmeister@Econos.de)                 
#************************************************************************
# This source code is distributed with no WARRANTY, for no reason or use.
# Everyone is allowed to use and change this code free for his own tasks 
# and projects, as long as this header and its copyright text is intact. 
# For changed versions of this code, which are public distributed the    
# following additional conditions have to be fullfilled:                 
# 1) The header has to contain a comment on the change and the author of 
#    it.                                                                 
# 2) A copy of the changed source has to be sent to the above E-Mail     
#    address or my then valid address, if this is possible to the        
#    author.                                                             
# The second condition has the target to maintain an up to date central  
# version of the component. If this condition is not acceptable for      
# confidential or legal reasons, everyone is free to derive a component  
# or to generate a diff file to my or other original sources.            
# Dr. Dietmar Budelsky, 1997-11-17                                       
#************************************************************************

{.deadCodeElim: on.}

import 
  dynlib


when defined(windows): 
  const dllname = "python(27|26|25|24|23|22|21|20|16|15).dll"
elif defined(macosx):
  const dllname = "libpython(2.7|2.6|2.5|2.4|2.3|2.2|2.1|2.0|1.6|1.5).dylib"
else: 
  const dllver = ".1"
  const dllname = "libpython(2.7|2.6|2.5|2.4|2.3|2.2|2.1|2.0|1.6|1.5).so" & 
                  dllver

  
const 
  PytMethodBufferIncrease* = 10
  PytMemberBufferIncrease* = 10
  PytGetsetBufferIncrease* = 10
  MethVarargs* = 0x0001
  MethKeywords* = 0x0002 # Masks for the co_flags field of PyCodeObject
  CoOptimized* = 0x0001
  CoNewlocals* = 0x0002
  CoVarargs* = 0x0004
  CoVarkeywords* = 0x0008

type                          # Rich comparison opcodes introduced in version 2.1
  TRichComparisonOpcode* = enum 
    pyLT, pyLE, pyEQ, pyNE, pyGT, pyGE

const
  PyTPFLAGSHAVEGETCHARBUFFER* = (1 shl 0) # PySequenceMethods contains sq_contains
  PyTPFLAGSHAVESEQUENCEIN* = (1 shl 1) # Objects which participate in garbage collection (see objimp.h)
  PyTPFLAGSGC* = (1 shl 2)  # PySequenceMethods and PyNumberMethods contain in-place operators
  PyTPFLAGSHAVEINPLACEOPS* = (1 shl 3) # PyNumberMethods do their own coercion */
  PyTPFLAGSCHECKTYPES* = (1 shl 4)
  PyTPFLAGSHAVERICHCOMPARE* = (1 shl 5) # Objects which are weakly referencable if their tp_weaklistoffset is >0
                                           # XXX Should this have the same value as Py_TPFLAGS_HAVE_RICHCOMPARE?
                                           # These both indicate a feature that appeared in the same alpha release.
  PyTPFLAGSHAVEWEAKREFS* = (1 shl 6) # tp_iter is defined
  PyTPFLAGSHAVEITER* = (1 shl 7) # New members introduced by Python 2.2 exist
  PyTPFLAGSHAVECLASS* = (1 shl 8) # Set if the type object is dynamically allocated
  PyTPFLAGSHEAPTYPE* = (1 shl 9) # Set if the type allows subclassing
  PyTPFLAGSBASETYPE* = (1 shl 10) # Set if the type is 'ready' -- fully initialized
  PyTPFLAGSREADY* = (1 shl 12) # Set while the type is being 'readied', to prevent recursive ready calls
  PyTPFLAGSREADYING* = (1 shl 13) # Objects support garbage collection (see objimp.h)
  PyTPFLAGSHAVEGC* = (1 shl 14)
  PyTPFLAGSDEFAULT* = Py_TPFLAGS_HAVE_GETCHARBUFFER or
      Py_TPFLAGS_HAVE_SEQUENCE_IN or Py_TPFLAGS_HAVE_INPLACEOPS or
      Py_TPFLAGS_HAVE_RICHCOMPARE or Py_TPFLAGS_HAVE_WEAKREFS or
      Py_TPFLAGS_HAVE_ITER or Py_TPFLAGS_HAVE_CLASS 

type 
  TPFlag* = enum 
    tpfHaveGetCharBuffer, tpfHaveSequenceIn, tpfGC, tpfHaveInplaceOps, 
    tpfCheckTypes, tpfHaveRichCompare, tpfHaveWeakRefs, tpfHaveIter, 
    tpfHaveClass, tpfHeapType, tpfBaseType, tpfReady, tpfReadying, tpfHaveGC
  TPFlags* = Set[TPFlag]

const 
  TpflagsDefault* = {tpfHaveGetCharBuffer, tpfHaveSequenceIn, 
    tpfHaveInplaceOps, tpfHaveRichCompare, tpfHaveWeakRefs, tpfHaveIter, 
    tpfHaveClass}

const # Python opcodes
  singleInput* = 256 
  fileInput* = 257
  evalInput* = 258
  funcdef* = 259
  parameters* = 260
  varargslist* = 261
  fpdef* = 262
  fplist* = 263
  stmt* = 264
  simpleStmt* = 265
  smallStmt* = 266
  exprStmt* = 267
  augassign* = 268
  printStmt* = 269
  delStmt* = 270
  passStmt* = 271
  flowStmt* = 272
  breakStmt* = 273
  continueStmt* = 274
  returnStmt* = 275
  raiseStmt* = 276
  importStmt* = 277
  importAsName* = 278
  dottedAsName* = 279
  dottedName* = 280
  globalStmt* = 281
  execStmt* = 282
  assertStmt* = 283
  compoundStmt* = 284
  ifStmt* = 285
  whileStmt* = 286
  forStmt* = 287
  tryStmt* = 288
  exceptClause* = 289
  suite* = 290
  test* = 291
  andTest* = 291
  notTest* = 293
  comparison* = 294
  compOp* = 295
  expr* = 296
  xorExpr* = 297
  andExpr* = 298
  shiftExpr* = 299
  arithExpr* = 300
  term* = 301
  factor* = 302
  power* = 303
  atom* = 304
  listmaker* = 305
  lambdef* = 306
  trailer* = 307
  subscriptlist* = 308
  subscript* = 309
  sliceop* = 310
  exprlist* = 311
  testlist* = 312
  dictmaker* = 313
  classdef* = 314
  arglist* = 315
  argument* = 316
  listIter* = 317
  listFor* = 318
  listIf* = 319

const 
  TShort* = 0
  TInt* = 1
  TLong* = 2
  TFloat* = 3
  TDouble* = 4
  TString* = 5
  TObject* = 6
  TChar* = 7                 # 1-character string
  TByte* = 8                 # 8-bit signed int
  TUbyte* = 9
  TUshort* = 10
  TUint* = 11
  TUlong* = 12
  TStringInplace* = 13
  TObjectEx* = 16 
  Readonly* = 1
  Ro* = READONLY              # Shorthand 
  ReadRestricted* = 2
  WriteRestricted* = 4
  Restricted* = (READ_RESTRICTED or WRITE_RESTRICTED)

type 
  TPyMemberType* = enum 
    mtShort, mtInt, mtLong, mtFloat, mtDouble, mtString, mtObject, mtChar, 
    mtByte, mtUByte, mtUShort, mtUInt, mtULong, mtStringInplace, mtObjectEx
  TPyMemberFlag* = enum 
    mfDefault, mfReadOnly, mfReadRestricted, mfWriteRestricted, mfRestricted

type 
  PInt* = ptr Int

#  PLong* = ptr int32
#  PFloat* = ptr float32
#  PShort* = ptr int8
  
type 
  PPFrozen* = ptr PFrozen
  PFrozen* = ptr Tfrozen
  PPyObject* = ptr TPyObject
  PPPyObject* = ptr PPyObject
  PPPPyObject* = ptr PPPyObject
  PPyIntObject* = ptr TPyIntObject
  PPyTypeObject* = ptr TPyTypeObject
  PPySliceObject* = ptr TPySliceObject
  TPyCFunction* = proc (self, args: PPyObject): PPyObject{.cdecl.}
  Tunaryfunc* = proc (ob1: PPyObject): PPyObject{.cdecl.}
  Tbinaryfunc* = proc (ob1, ob2: PPyObject): PPyObject{.cdecl.}
  Tternaryfunc* = proc (ob1, ob2, ob3: PPyObject): PPyObject{.cdecl.}
  Tinquiry* = proc (ob1: PPyObject): Int{.cdecl.}
  Tcoercion* = proc (ob1, ob2: PPPyObject): Int{.cdecl.}
  Tintargfunc* = proc (ob1: PPyObject, i: Int): PPyObject{.cdecl.}
  Tintintargfunc* = proc (ob1: PPyObject, i1, i2: Int): PPyObject{.cdecl.}
  Tintobjargproc* = proc (ob1: PPyObject, i: Int, ob2: PPyObject): Int{.cdecl.}
  Tintintobjargproc* = proc (ob1: PPyObject, i1, i2: Int, ob2: PPyObject): Int{.
      cdecl.}
  Tobjobjargproc* = proc (ob1, ob2, ob3: PPyObject): Int{.cdecl.}
  Tpydestructor* = proc (ob: PPyObject){.cdecl.}
  Tprintfunc* = proc (ob: PPyObject, f: TFile, i: Int): Int{.cdecl.}
  Tgetattrfunc* = proc (ob1: PPyObject, name: Cstring): PPyObject{.cdecl.}
  Tsetattrfunc* = proc (ob1: PPyObject, name: Cstring, ob2: PPyObject): Int{.
      cdecl.}
  Tcmpfunc* = proc (ob1, ob2: PPyObject): Int{.cdecl.}
  Treprfunc* = proc (ob: PPyObject): PPyObject{.cdecl.}
  Thashfunc* = proc (ob: PPyObject): Int32{.cdecl.}
  Tgetattrofunc* = proc (ob1, ob2: PPyObject): PPyObject{.cdecl.}
  Tsetattrofunc* = proc (ob1, ob2, ob3: PPyObject): Int{.cdecl.} 
  Tgetreadbufferproc* = proc (ob1: PPyObject, i: Int, p: Pointer): Int{.cdecl.}
  Tgetwritebufferproc* = proc (ob1: PPyObject, i: Int, p: Pointer): Int{.cdecl.}
  Tgetsegcountproc* = proc (ob1: PPyObject, i: Int): Int{.cdecl.}
  Tgetcharbufferproc* = proc (ob1: PPyObject, i: Int, pstr: Cstring): Int{.cdecl.}
  Tobjobjproc* = proc (ob1, ob2: PPyObject): Int{.cdecl.}
  Tvisitproc* = proc (ob1: PPyObject, p: Pointer): Int{.cdecl.}
  Ttraverseproc* = proc (ob1: PPyObject, prc: Tvisitproc, p: Pointer): Int{.
      cdecl.}
  Trichcmpfunc* = proc (ob1, ob2: PPyObject, i: Int): PPyObject{.cdecl.}
  Tgetiterfunc* = proc (ob1: PPyObject): PPyObject{.cdecl.}
  Titernextfunc* = proc (ob1: PPyObject): PPyObject{.cdecl.}
  Tdescrgetfunc* = proc (ob1, ob2, ob3: PPyObject): PPyObject{.cdecl.}
  Tdescrsetfunc* = proc (ob1, ob2, ob3: PPyObject): Int{.cdecl.}
  Tinitproc* = proc (self, args, kwds: PPyObject): Int{.cdecl.}
  Tnewfunc* = proc (subtype: PPyTypeObject, args, kwds: PPyObject): PPyObject{.
      cdecl.}
  Tallocfunc* = proc (self: PPyTypeObject, nitems: Int): PPyObject{.cdecl.}
  TPyNumberMethods*{.final.} = object 
    nb_add*: Tbinaryfunc
    nb_substract*: Tbinaryfunc
    nb_multiply*: Tbinaryfunc
    nb_divide*: Tbinaryfunc
    nb_remainder*: Tbinaryfunc
    nb_divmod*: Tbinaryfunc
    nb_power*: Tternaryfunc
    nb_negative*: Tunaryfunc
    nb_positive*: Tunaryfunc
    nb_absolute*: Tunaryfunc
    nb_nonzero*: Tinquiry
    nb_invert*: Tunaryfunc
    nb_lshift*: Tbinaryfunc
    nb_rshift*: Tbinaryfunc
    nb_and*: Tbinaryfunc
    nb_xor*: Tbinaryfunc
    nb_or*: Tbinaryfunc
    nb_coerce*: Tcoercion
    nb_int*: Tunaryfunc
    nb_long*: Tunaryfunc
    nb_float*: Tunaryfunc
    nb_oct*: Tunaryfunc
    nb_hex*: Tunaryfunc       #/ jah 29-sep-2000: updated for python 2.0
                              #/                   added from .h
    nb_inplace_add*: Tbinaryfunc
    nb_inplace_subtract*: Tbinaryfunc
    nb_inplace_multiply*: Tbinaryfunc
    nb_inplace_divide*: Tbinaryfunc
    nb_inplace_remainder*: Tbinaryfunc
    nb_inplace_power*: Tternaryfunc
    nb_inplace_lshift*: Tbinaryfunc
    nb_inplace_rshift*: Tbinaryfunc
    nb_inplace_and*: Tbinaryfunc
    nb_inplace_xor*: Tbinaryfunc
    nb_inplace_or*: Tbinaryfunc # Added in release 2.2
                                # The following require the Py_TPFLAGS_HAVE_CLASS flag
    nb_floor_divide*: Tbinaryfunc
    nb_true_divide*: Tbinaryfunc
    nb_inplace_floor_divide*: Tbinaryfunc
    nb_inplace_true_divide*: Tbinaryfunc

  PPyNumberMethods* = ptr TPyNumberMethods
  TPySequenceMethods*{.final.} = object 
    sq_length*: Tinquiry
    sq_concat*: Tbinaryfunc
    sq_repeat*: Tintargfunc
    sq_item*: Tintargfunc
    sq_slice*: Tintintargfunc
    sq_ass_item*: Tintobjargproc
    sq_ass_slice*: Tintintobjargproc 
    sq_contains*: Tobjobjproc
    sq_inplace_concat*: Tbinaryfunc
    sq_inplace_repeat*: Tintargfunc

  PPySequenceMethods* = ptr TPySequenceMethods
  TPyMappingMethods*{.final.} = object 
    mp_length*: Tinquiry
    mp_subscript*: Tbinaryfunc
    mp_ass_subscript*: Tobjobjargproc

  PPyMappingMethods* = ptr TPyMappingMethods 
  TPyBufferProcs*{.final.} = object 
    bf_getreadbuffer*: Tgetreadbufferproc
    bf_getwritebuffer*: Tgetwritebufferproc
    bf_getsegcount*: Tgetsegcountproc
    bf_getcharbuffer*: Tgetcharbufferproc

  PPyBufferProcs* = ptr TPyBufferProcs
  TPy_complex*{.final.} = object 
    float*: Float64
    imag*: Float64

  TPyObject*{.pure, inheritable.} = object 
    obRefcnt*: Int
    obType*: PPyTypeObject

  TPyIntObject* = object of TPyObject
    ob_ival*: Int32

  PByte* = ptr Int8
  Tfrozen*{.final.} = object 
    name*: Cstring
    code*: PByte
    size*: Int

  TPySliceObject* = object of TPyObject
    start*, stop*, step*: PPyObject

  PPyMethodDef* = ptr TPyMethodDef
  TPyMethodDef*{.final.} = object  # structmember.h
    ml_name*: Cstring
    ml_meth*: TPyCFunction
    ml_flags*: Int
    ml_doc*: Cstring

  PPyMemberDef* = ptr TPyMemberDef
  TPyMemberDef*{.final.} = object  # descrobject.h
                                   # Descriptors
    name*: Cstring
    theType*: Int
    offset*: Int
    flags*: Int
    doc*: Cstring

  Tgetter* = proc (obj: PPyObject, context: Pointer): PPyObject{.cdecl.}
  Tsetter* = proc (obj, value: PPyObject, context: Pointer): Int{.cdecl.}
  PPyGetSetDef* = ptr TPyGetSetDef
  TPyGetSetDef*{.final.} = object 
    name*: Cstring
    get*: Tgetter
    setter*: Tsetter
    doc*: Cstring
    closure*: Pointer

  Twrapperfunc* = proc (self, args: PPyObject, wrapped: Pointer): PPyObject{.
      cdecl.}
  Pwrapperbase* = ptr Twrapperbase
  Twrapperbase*{.final.} = object  # Various kinds of descriptor objects
                                   ##define PyDescr_COMMON \
                                   #          PyObject_HEAD \
                                   #          PyTypeObject *d_type; \
                                   #          PyObject *d_name
                                   #  
    name*: Cstring
    wrapper*: Twrapperfunc
    doc*: Cstring

  PPyDescrObject* = ptr TPyDescrObject
  TPyDescrObject* = object of TPyObject
    d_type*: PPyTypeObject
    d_name*: PPyObject

  PPyMethodDescrObject* = ptr TPyMethodDescrObject
  TPyMethodDescrObject* = object of TPyDescrObject
    d_method*: PPyMethodDef

  PPyMemberDescrObject* = ptr TPyMemberDescrObject
  TPyMemberDescrObject* = object of TPyDescrObject
    d_member*: PPyMemberDef

  PPyGetSetDescrObject* = ptr TPyGetSetDescrObject
  TPyGetSetDescrObject* = object of TPyDescrObject
    d_getset*: PPyGetSetDef

  PPyWrapperDescrObject* = ptr TPyWrapperDescrObject
  TPyWrapperDescrObject* = object of TPyDescrObject # object.h
    d_base*: Pwrapperbase
    d_wrapped*: Pointer       # This can be any function pointer
  
  TPyTypeObject* = object of TPyObject
    ob_size*: Int             # Number of items in variable part
    tp_name*: Cstring         # For printing
    tp_basicsize*, tp_itemsize*: Int # For allocation
                                     # Methods to implement standard operations
    tpDealloc*: Tpydestructor
    tp_print*: Tprintfunc
    tp_getattr*: Tgetattrfunc
    tp_setattr*: Tsetattrfunc
    tp_compare*: Tcmpfunc
    tp_repr*: Treprfunc       # Method suites for standard classes
    tp_as_number*: PPyNumberMethods
    tp_as_sequence*: PPySequenceMethods
    tp_as_mapping*: PPyMappingMethods # More standard operations (here for binary compatibility)
    tp_hash*: Thashfunc
    tp_call*: Tternaryfunc
    tp_str*: Treprfunc
    tp_getattro*: Tgetattrofunc
    tp_setattro*: Tsetattrofunc #/ jah 29-sep-2000: updated for python 2.0
                                # Functions to access object as input/output buffer
    tp_as_buffer*: PPyBufferProcs # Flags to define presence of optional/expanded features
    tpFlags*: Int32
    tp_doc*: Cstring          # Documentation string
                              # call function for all accessible objects
    tp_traverse*: Ttraverseproc # delete references to contained objects
    tp_clear*: Tinquiry       # rich comparisons
    tp_richcompare*: Trichcmpfunc # weak reference enabler
    tp_weaklistoffset*: Int32 # Iterators
    tp_iter*: Tgetiterfunc
    tp_iternext*: Titernextfunc # Attribute descriptor and subclassing stuff
    tp_methods*: PPyMethodDef
    tp_members*: PPyMemberDef
    tp_getset*: PPyGetSetDef
    tp_base*: PPyTypeObject
    tp_dict*: PPyObject
    tp_descr_get*: Tdescrgetfunc
    tp_descr_set*: Tdescrsetfunc
    tp_dictoffset*: Int32
    tp_init*: Tinitproc
    tp_alloc*: Tallocfunc
    tp_new*: Tnewfunc
    tp_free*: Tpydestructor   # Low-level free-memory routine
    tpIsGc*: Tinquiry       # For PyObject_IS_GC
    tp_bases*: PPyObject
    tp_mro*: PPyObject        # method resolution order
    tp_cache*: PPyObject
    tp_subclasses*: PPyObject
    tp_weaklist*: PPyObject   #More spares
    tp_xxx7*: Pointer
    tp_xxx8*: Pointer

  PPyMethodChain* = ptr TPyMethodChain
  TPyMethodChain*{.final.} = object 
    methods*: PPyMethodDef
    link*: PPyMethodChain

  PPyClassObject* = ptr TPyClassObject
  TPyClassObject* = object of TPyObject
    cl_bases*: PPyObject      # A tuple of class objects
    cl_dict*: PPyObject       # A dictionary
    cl_name*: PPyObject       # A string
                              # The following three are functions or NULL
    cl_getattr*: PPyObject
    cl_setattr*: PPyObject
    cl_delattr*: PPyObject

  PPyInstanceObject* = ptr TPyInstanceObject
  TPyInstanceObject* = object of TPyObject 
    in_class*: PPyClassObject # The class object
    in_dict*: PPyObject       # A dictionary
  
  PPyMethodObject* = ptr TPyMethodObject
  TPyMethodObject* = object of TPyObject # Bytecode object, compile.h
    im_func*: PPyObject       # The function implementing the method
    im_self*: PPyObject       # The instance it is bound to, or NULL
    im_class*: PPyObject      # The class that defined the method
  
  PPyCodeObject* = ptr TPyCodeObject
  TPyCodeObject* = object of TPyObject # from pystate.h
    co_argcount*: Int         # #arguments, except *args
    co_nlocals*: Int          # #local variables
    co_stacksize*: Int        # #entries needed for evaluation stack
    co_flags*: Int            # CO_..., see below
    co_code*: PPyObject       # instruction opcodes (it hides a PyStringObject)
    co_consts*: PPyObject     # list (constants used)
    co_names*: PPyObject      # list of strings (names used)
    co_varnames*: PPyObject   # tuple of strings (local variable names)
    co_freevars*: PPyObject   # tuple of strings (free variable names)
    co_cellvars*: PPyObject   # tuple of strings (cell variable names)
                              # The rest doesn't count for hash/cmp
    coFilename*: PPyObject   # string (where it was loaded from)
    co_name*: PPyObject       # string (name, for reference)
    co_firstlineno*: Int      # first source line number
    co_lnotab*: PPyObject     # string (encoding addr<->lineno mapping)
  
  PPyInterpreterState* = ptr TPyInterpreterState
  PPyThreadState* = ptr TPyThreadState
  PPyFrameObject* = ptr TPyFrameObject # Interpreter environments
  TPyInterpreterState*{.final.} = object  # Thread specific information
    next*: PPyInterpreterState
    tstate_head*: PPyThreadState
    modules*: PPyObject
    sysdict*: PPyObject
    builtins*: PPyObject
    checkinterval*: Int

  TPyThreadState*{.final.} = object  # from frameobject.h
    next*: PPyThreadState
    interp*: PPyInterpreterState
    frame*: PPyFrameObject
    recursion_depth*: Int
    ticker*: Int
    tracing*: Int
    sys_profilefunc*: PPyObject
    sys_tracefunc*: PPyObject
    curexc_type*: PPyObject
    curexc_value*: PPyObject
    curexc_traceback*: PPyObject
    exc_type*: PPyObject
    exc_value*: PPyObject
    exc_traceback*: PPyObject
    dict*: PPyObject

  PPyTryBlock* = ptr TPyTryBlock
  TPyTryBlock*{.final.} = object 
    b_type*: Int              # what kind of block this is
    b_handler*: Int           # where to jump to find handler
    b_level*: Int             # value stack level to pop to
  
  CoMaxblocks* = Range[0..19]
  TPyFrameObject* = object of TPyObject # start of the VAR_HEAD of an object
                                        # From traceback.c
    ob_size*: Int             # Number of items in variable part
                              # End of the Head of an object
    f_back*: PPyFrameObject   # previous frame, or NULL
    f_code*: PPyCodeObject    # code segment
    f_builtins*: PPyObject    # builtin symbol table (PyDictObject)
    f_globals*: PPyObject     # global symbol table (PyDictObject)
    f_locals*: PPyObject      # local symbol table (PyDictObject)
    f_valuestack*: PPPyObject # points after the last local
                              # Next free slot in f_valuestack. Frame creation sets to f_valuestack.
                              # Frame evaluation usually NULLs it, but a frame that yields sets it
                              # to the current stack top. 
    f_stacktop*: PPPyObject
    f_trace*: PPyObject       # Trace function
    f_exc_type*, f_exc_value*, f_exc_traceback*: PPyObject
    f_tstate*: PPyThreadState
    f_lasti*: Int             # Last instruction if called
    f_lineno*: Int            # Current line number
    f_restricted*: Int        # Flag set if restricted operations
                              # in this scope
    f_iblock*: Int            # index in f_blockstack
    f_blockstack*: Array[CO_MAXBLOCKS, TPyTryBlock] # for try and loop blocks
    f_nlocals*: Int           # number of locals
    f_ncells*: Int
    f_nfreevars*: Int
    f_stacksize*: Int         # size of value stack
    f_localsplus*: Array[0..0, PPyObject] # locals+stack, dynamically sized
  
  PPyTraceBackObject* = ptr TPyTraceBackObject
  TPyTraceBackObject* = object of TPyObject # Parse tree node interface
    tb_next*: PPyTraceBackObject
    tb_frame*: PPyFrameObject
    tb_lasti*: Int
    tb_lineno*: Int

  PNode* = ptr Tnode
  Tnode*{.final.} = object    # From weakrefobject.h
    n_type*: Int16
    n_str*: Cstring
    n_lineno*: Int16
    n_nchildren*: Int16
    n_child*: PNode

  PPyWeakReference* = ptr TPyWeakReference
  TPyWeakReference* = object of TPyObject 
    wr_object*: PPyObject
    wr_callback*: PPyObject
    hash*: Int32
    wr_prev*: PPyWeakReference
    wr_next*: PPyWeakReference


const                         
  PyDateTimeDATEDATASIZE* = 4 # # of bytes for year, month, and day
  PyDateTimeTIMEDATASIZE* = 6 # # of bytes for hour, minute, second, and usecond
  PyDateTimeDATETIMEDATASIZE* = 10 # # of bytes for year, month, 
                                     # day, hour, minute, second, and usecond. 

type 
  TPyDateTime_Delta* = object of TPyObject
    hashcode*: Int            # -1 when unknown
    days*: Int                # -MAX_DELTA_DAYS <= days <= MAX_DELTA_DAYS
    seconds*: Int             # 0 <= seconds < 24*3600 is invariant
    microseconds*: Int        # 0 <= microseconds < 1000000 is invariant
  
  PPyDateTimeDelta* = ptr TPyDateTime_Delta
  TPyDateTime_TZInfo* = object of TPyObject # a pure abstract base clase
  PPyDateTimeTZInfo* = ptr TPyDateTime_TZInfo 
  TPyDateTime_BaseTZInfo* = object of TPyObject
    hashcode*: Int
    hastzinfo*: Bool          # boolean flag
  
  PPyDateTimeBaseTZInfo* = ptr TPyDateTime_BaseTZInfo 
  TPyDateTime_BaseTime* = object of TPyDateTime_BaseTZInfo
    data*: Array[0..Pred(PyDateTime_TIME_DATASIZE), Int8]

  PPyDateTimeBaseTime* = ptr TPyDateTime_BaseTime
  TPyDateTime_Time* = object of TPyDateTime_BaseTime # hastzinfo true
    tzinfo*: PPyObject

  PPyDateTimeTime* = ptr TPyDateTime_Time 
  TPyDateTime_Date* = object of TPyDateTime_BaseTZInfo
    data*: Array[0..Pred(PyDateTime_DATE_DATASIZE), Int8]

  PPyDateTimeDate* = ptr TPyDateTime_Date 
  TPyDateTime_BaseDateTime* = object of TPyDateTime_BaseTZInfo
    data*: Array[0..Pred(PyDateTime_DATETIME_DATASIZE), Int8]

  PPyDateTimeBaseDateTime* = ptr TPyDateTime_BaseDateTime
  TPyDateTime_DateTime* = object of TPyDateTime_BaseTZInfo
    data*: Array[0..Pred(PyDateTime_DATETIME_DATASIZE), Int8]
    tzinfo*: PPyObject

  PPyDateTimeDateTime* = ptr TPyDateTime_DateTime 

#----------------------------------------------------#
#                                                    #
#         New exception classes                      #
#                                                    #
#----------------------------------------------------#

#
#  // Python's exceptions
#  EPythonError   = object(Exception)
#      EName: String;
#      EValue: String;
#  end;
#  EPyExecError   = object(EPythonError)
#  end;
#
#  // Standard exception classes of Python
#
#/// jah 29-sep-2000: updated for python 2.0
#///                   base classes updated according python documentation
#
#{ Hierarchy of Python exceptions, Python 2.3, copied from <INSTALL>\Python\exceptions.c
#
#Exception\n\
# |\n\
# +-- SystemExit\n\
# +-- StopIteration\n\
# +-- StandardError\n\
# |    |\n\
# |    +-- KeyboardInterrupt\n\
# |    +-- ImportError\n\
# |    +-- EnvironmentError\n\
# |    |    |\n\
# |    |    +-- IOError\n\
# |    |    +-- OSError\n\
# |    |         |\n\
# |    |         +-- WindowsError\n\
# |    |         +-- VMSError\n\
# |    |\n\
# |    +-- EOFError\n\
# |    +-- RuntimeError\n\
# |    |    |\n\
# |    |    +-- NotImplementedError\n\
# |    |\n\
# |    +-- NameError\n\
# |    |    |\n\
# |    |    +-- UnboundLocalError\n\
# |    |\n\
# |    +-- AttributeError\n\
# |    +-- SyntaxError\n\
# |    |    |\n\
# |    |    +-- IndentationError\n\
# |    |         |\n\
# |    |         +-- TabError\n\
# |    |\n\
# |    +-- TypeError\n\
# |    +-- AssertionError\n\
# |    +-- LookupError\n\
# |    |    |\n\
# |    |    +-- IndexError\n\
# |    |    +-- KeyError\n\
# |    |\n\
# |    +-- ArithmeticError\n\
# |    |    |\n\
# |    |    +-- OverflowError\n\
# |    |    +-- ZeroDivisionError\n\
# |    |    +-- FloatingPointError\n\
# |    |\n\
# |    +-- ValueError\n\
# |    |    |\n\
# |    |    +-- UnicodeError\n\
# |    |        |\n\
# |    |        +-- UnicodeEncodeError\n\
# |    |        +-- UnicodeDecodeError\n\
# |    |        +-- UnicodeTranslateError\n\
# |    |\n\
# |    +-- ReferenceError\n\
# |    +-- SystemError\n\
# |    +-- MemoryError\n\
# |\n\
# +---Warning\n\
#      |\n\
#      +-- UserWarning\n\
#      +-- DeprecationWarning\n\
#      +-- PendingDeprecationWarning\n\
#      +-- SyntaxWarning\n\
#      +-- OverflowWarning\n\
#      +-- RuntimeWarning\n\
#      +-- FutureWarning"
#}
#   EPyException = class (EPythonError);
#   EPyStandardError = class (EPyException);
#   EPyArithmeticError = class (EPyStandardError);
#   EPyLookupError = class (EPyStandardError);
#   EPyAssertionError = class (EPyStandardError);
#   EPyAttributeError = class (EPyStandardError);
#   EPyEOFError = class (EPyStandardError);
#   EPyFloatingPointError = class (EPyArithmeticError);
#   EPyEnvironmentError = class (EPyStandardError);
#   EPyIOError = class (EPyEnvironmentError);
#   EPyOSError = class (EPyEnvironmentError);
#   EPyImportError = class (EPyStandardError);
#   EPyIndexError = class (EPyLookupError);
#   EPyKeyError = class (EPyLookupError);
#   EPyKeyboardInterrupt = class (EPyStandardError);
#   EPyMemoryError = class (EPyStandardError);
#   EPyNameError = class (EPyStandardError);
#   EPyOverflowError = class (EPyArithmeticError);
#   EPyRuntimeError = class (EPyStandardError);
#   EPyNotImplementedError = class (EPyRuntimeError);
#   EPySyntaxError = class (EPyStandardError)
#   public
#      EFileName: string;
#      ELineStr: string;
#      ELineNumber: Integer;
#      EOffset: Integer;
#   end;
#   EPyIndentationError = class (EPySyntaxError);
#   EPyTabError = class (EPyIndentationError);
#   EPySystemError = class (EPyStandardError);
#   EPySystemExit = class (EPyException);
#   EPyTypeError = class (EPyStandardError);
#   EPyUnboundLocalError = class (EPyNameError);
#   EPyValueError = class (EPyStandardError);
#   EPyUnicodeError = class (EPyValueError);
#   UnicodeEncodeError = class (EPyUnicodeError);
#   UnicodeDecodeError = class (EPyUnicodeError);
#   UnicodeTranslateError = class (EPyUnicodeError);
#   EPyZeroDivisionError = class (EPyArithmeticError);
#   EPyStopIteration = class(EPyException);
#   EPyWarning = class (EPyException);
#   EPyUserWarning = class (EPyWarning);
#   EPyDeprecationWarning = class (EPyWarning);
#   PendingDeprecationWarning = class (EPyWarning);
#   FutureWarning = class (EPyWarning);
#   EPySyntaxWarning = class (EPyWarning);
#   EPyOverflowWarning = class (EPyWarning);
#   EPyRuntimeWarning = class (EPyWarning);
#   EPyReferenceError = class (EPyStandardError);
#

var 
  pyArgParse*: proc (args: PPyObject, format: Cstring): Int{.cdecl, varargs.} 
  pyArgParseTuple*: proc (args: PPyObject, format: Cstring, x1: Pointer = nil, 
                           x2: Pointer = nil, x3: Pointer = nil): Int{.cdecl, varargs.} 
  pyBuildValue*: proc (format: Cstring): PPyObject{.cdecl, varargs.} 
  pyCodeAddr2Line*: proc (co: PPyCodeObject, addrq: Int): Int{.cdecl.}
  dLLPyGetBuildInfo*: proc (): Cstring{.cdecl.}

var
  pyDebugFlag*: PInt
  pyVerboseFlag*: PInt
  pyInteractiveFlag*: PInt
  pyOptimizeFlag*: PInt
  pyNoSiteFlag*: PInt
  pyUseClassExceptionsFlag*: PInt
  pyFrozenFlag*: PInt
  pyTabcheckFlag*: PInt
  pyUnicodeFlag*: PInt
  pyIgnoreEnvironmentFlag*: PInt
  pyDivisionWarningFlag*: PInt 
  #_PySys_TraceFunc:    PPPyObject;
  #_PySys_ProfileFunc: PPPPyObject;
  pyImportFrozenModules*: PPFrozen
  pyNone*: PPyObject
  pyEllipsis*: PPyObject
  pyFalse*: PPyIntObject
  pyTrue*: PPyIntObject
  pyNotImplemented*: PPyObject
  pyExcAttributeError*: PPPyObject
  pyExcEOFError*: PPPyObject
  pyExcIOError*: PPPyObject
  pyExcImportError*: PPPyObject
  pyExcIndexError*: PPPyObject
  pyExcKeyError*: PPPyObject
  pyExcKeyboardInterrupt*: PPPyObject
  pyExcMemoryError*: PPPyObject
  pyExcNameError*: PPPyObject
  pyExcOverflowError*: PPPyObject
  pyExcRuntimeError*: PPPyObject
  pyExcSyntaxError*: PPPyObject
  pyExcSystemError*: PPPyObject
  pyExcSystemExit*: PPPyObject
  pyExcTypeError*: PPPyObject
  pyExcValueError*: PPPyObject
  pyExcZeroDivisionError*: PPPyObject
  pyExcArithmeticError*: PPPyObject
  pyExcException*: PPPyObject
  pyExcFloatingPointError*: PPPyObject
  pyExcLookupError*: PPPyObject
  pyExcStandardError*: PPPyObject
  pyExcAssertionError*: PPPyObject
  pyExcEnvironmentError*: PPPyObject
  pyExcIndentationError*: PPPyObject
  pyExcMemoryErrorInst*: PPPyObject
  pyExcNotImplementedError*: PPPyObject
  pyExcOSError*: PPPyObject
  pyExcTabError*: PPPyObject
  pyExcUnboundLocalError*: PPPyObject
  pyExcUnicodeError*: PPPyObject
  pyExcWarning*: PPPyObject
  pyExcDeprecationWarning*: PPPyObject
  pyExcRuntimeWarning*: PPPyObject
  pyExcSyntaxWarning*: PPPyObject
  pyExcUserWarning*: PPPyObject
  pyExcOverflowWarning*: PPPyObject
  pyExcReferenceError*: PPPyObject
  pyExcStopIteration*: PPPyObject
  pyExcFutureWarning*: PPPyObject
  pyExcPendingDeprecationWarning*: PPPyObject
  pyExcUnicodeDecodeError*: PPPyObject
  pyExcUnicodeEncodeError*: PPPyObject
  pyExcUnicodeTranslateError*: PPPyObject
  pyTypeType*: PPyTypeObject
  pyCFunctionType*: PPyTypeObject
  pyCObjectType*: PPyTypeObject
  pyClassType*: PPyTypeObject
  pyCodeType*: PPyTypeObject
  pyComplexType*: PPyTypeObject
  pyDictType*: PPyTypeObject
  pyFileType*: PPyTypeObject
  pyFloatType*: PPyTypeObject
  pyFrameType*: PPyTypeObject
  pyFunctionType*: PPyTypeObject
  pyInstanceType*: PPyTypeObject
  pyIntType*: PPyTypeObject
  pyListType*: PPyTypeObject
  pyLongType*: PPyTypeObject
  pyMethodType*: PPyTypeObject
  pyModuleType*: PPyTypeObject
  pyObjectType*: PPyTypeObject
  pyRangeType*: PPyTypeObject
  pySliceType*: PPyTypeObject
  pyStringType*: PPyTypeObject
  pyTupleType*: PPyTypeObject
  pyBaseObjectType*: PPyTypeObject
  pyBufferType*: PPyTypeObject
  pyCallIterType*: PPyTypeObject
  pyCellType*: PPyTypeObject
  pyClassMethodType*: PPyTypeObject
  pyPropertyType*: PPyTypeObject
  pySeqIterType*: PPyTypeObject
  pyStaticMethodType*: PPyTypeObject
  pySuperType*: PPyTypeObject
  pySymtableEntryType*: PPyTypeObject
  pyTraceBackType*: PPyTypeObject
  pyUnicodeType*: PPyTypeObject
  pyWrapperDescrType*: PPyTypeObject
  pyBaseStringType*: PPyTypeObject
  pyBoolType*: PPyTypeObject
  pyEnumType*: PPyTypeObject

  #PyArg_GetObject: proc(args: PPyObject; nargs, i: integer; p_a: PPPyObject): integer; cdecl;
  #PyArg_GetLong: proc(args: PPyObject; nargs, i: integer; p_a: PLong): integer; cdecl;
  #PyArg_GetShort: proc(args: PPyObject; nargs, i: integer; p_a: PShort): integer; cdecl;
  #PyArg_GetFloat: proc(args: PPyObject; nargs, i: integer; p_a: PFloat): integer; cdecl;
  #PyArg_GetString: proc(args: PPyObject; nargs, i: integer; p_a: PString): integer; cdecl;
  #PyArgs_VaParse:  proc (args: PPyObject; format: PChar; 
  #                          va_list: array of const): integer; cdecl;
  # Does not work!
  # Py_VaBuildValue: proc (format: PChar; va_list: array of const): PPyObject; cdecl;
  #PyBuiltin_Init: proc; cdecl;
proc PyComplex_FromCComplex*(c: TPy_complex): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyComplex_FromDoubles*(realv, imag: Float64): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyComplex_RealAsDouble*(op: PPyObject): Float64{.cdecl, importc, dynlib: dllname.}
proc PyComplex_ImagAsDouble*(op: PPyObject): Float64{.cdecl, importc, dynlib: dllname.}
proc PyComplex_AsCComplex*(op: PPyObject): TPy_complex{.cdecl, importc, dynlib: dllname.}
proc PyCFunction_GetFunction*(ob: PPyObject): Pointer{.cdecl, importc, dynlib: dllname.}
proc PyCFunction_GetSelf*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyCallable_Check*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.}
proc PyCObject_FromVoidPtr*(cobj, destruct: Pointer): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyCObject_AsVoidPtr*(ob: PPyObject): Pointer{.cdecl, importc, dynlib: dllname.}
proc PyClass_New*(ob1, ob2, ob3: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyClass_IsSubclass*(ob1, ob2: PPyObject): Int{.cdecl, importc, dynlib: dllname.}
proc Py_InitModule4*(name: Cstring, methods: PPyMethodDef, doc: Cstring, 
                         passthrough: PPyObject, Api_Version: Int): PPyObject{.
      cdecl, importc, dynlib: dllname.}
proc PyErr_BadArgument*(): Int{.cdecl, importc, dynlib: dllname.}
proc PyErr_BadInternalCall*(){.cdecl, importc, dynlib: dllname.}
proc PyErr_CheckSignals*(): Int{.cdecl, importc, dynlib: dllname.}
proc PyErr_Clear*(){.cdecl, importc, dynlib: dllname.}
proc PyErr_Fetch*(errtype, errvalue, errtraceback: PPPyObject){.cdecl, importc, dynlib: dllname.}
proc PyErr_NoMemory*(): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyErr_Occurred*(): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyErr_Print*(){.cdecl, importc, dynlib: dllname.}
proc PyErr_Restore*(errtype, errvalue, errtraceback: PPyObject){.cdecl, importc, dynlib: dllname.}
proc PyErr_SetFromErrno*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyErr_SetNone*(value: PPyObject){.cdecl, importc, dynlib: dllname.}
proc PyErr_SetObject*(ob1, ob2: PPyObject){.cdecl, importc, dynlib: dllname.}
proc PyErr_SetString*(ErrorObject: PPyObject, text: Cstring){.cdecl, importc, dynlib: dllname.}
proc PyImport_GetModuleDict*(): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyInt_FromLong*(x: Int32): PPyObject{.cdecl, importc, dynlib: dllname.}
proc Py_Initialize*(){.cdecl, importc, dynlib: dllname.}
proc Py_Exit*(RetVal: Int){.cdecl, importc, dynlib: dllname.}
proc PyEval_GetBuiltins*(): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyDict_GetItem*(mp, key: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyDict_SetItem*(mp, key, item: PPyObject): Int{.cdecl, importc, dynlib: dllname.}
proc PyDict_DelItem*(mp, key: PPyObject): Int{.cdecl, importc, dynlib: dllname.}
proc PyDict_Clear*(mp: PPyObject){.cdecl, importc, dynlib: dllname.}
proc PyDict_Next*(mp: PPyObject, pos: PInt, key, value: PPPyObject): Int{.
      cdecl, importc, dynlib: dllname.}
proc PyDict_Keys*(mp: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyDict_Values*(mp: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyDict_Items*(mp: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyDict_Size*(mp: PPyObject): Int{.cdecl, importc, dynlib: dllname.}
proc PyDict_DelItemString*(dp: PPyObject, key: Cstring): Int{.cdecl, importc, dynlib: dllname.}
proc PyDict_New*(): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyDict_GetItemString*(dp: PPyObject, key: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyDict_SetItemString*(dp: PPyObject, key: Cstring, item: PPyObject): Int{.
      cdecl, importc, dynlib: dllname.}
proc PyDictProxy_New*(obj: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyModule_GetDict*(module: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyObject_Str*(v: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyRun_String*(str: Cstring, start: Int, globals: PPyObject, 
                       locals: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyRun_SimpleString*(str: Cstring): Int{.cdecl, importc, dynlib: dllname.}
proc PyString_AsString*(ob: PPyObject): Cstring{.cdecl, importc, dynlib: dllname.}
proc PyString_FromString*(str: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PySys_SetArgv*(argc: Int, argv: CstringArray){.cdecl, importc, dynlib: dllname.} 
  #+ means, Grzegorz or me has tested his non object version of this function
  #+
proc PyCFunction_New*(md: PPyMethodDef, ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyEval_CallObject*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyEval_CallObjectWithKeywords*(ob1, ob2, ob3: PPyObject): PPyObject{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PyEval_GetFrame*(): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyEval_GetGlobals*(): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyEval_GetLocals*(): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyEval_GetOwner*(): PPyObject {.cdecl, importc, dynlib: dllname.}
proc PyEval_GetRestricted*(): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyEval_InitThreads*(){.cdecl, importc, dynlib: dllname.} #-
proc PyEval_RestoreThread*(tstate: PPyThreadState){.cdecl, importc, dynlib: dllname.} #-
proc PyEval_SaveThread*(): PPyThreadState{.cdecl, importc, dynlib: dllname.} #-
proc PyFile_FromString*(pc1, pc2: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyFile_GetLine*(ob: PPyObject, i: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyFile_Name*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyFile_SetBufSize*(ob: PPyObject, i: Int){.cdecl, importc, dynlib: dllname.} #-
proc PyFile_SoftSpace*(ob: PPyObject, i: Int): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyFile_WriteObject*(ob1, ob2: PPyObject, i: Int): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyFile_WriteString*(s: Cstring, ob: PPyObject){.cdecl, importc, dynlib: dllname.} #+
proc PyFloat_AsDouble*(ob: PPyObject): Float64{.cdecl, importc, dynlib: dllname.} #+
proc PyFloat_FromDouble*(db: Float64): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyFunction_GetCode*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyFunction_GetGlobals*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyFunction_New*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyImport_AddModule*(name: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyImport_Cleanup*(){.cdecl, importc, dynlib: dllname.} #-
proc PyImport_GetMagicNumber*(): Int32{.cdecl, importc, dynlib: dllname.} #+
proc PyImport_ImportFrozenModule*(key: Cstring): Int{.cdecl, importc, dynlib: dllname.} #+
proc PyImport_ImportModule*(name: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyImport_Import*(name: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
                                                               
proc PyImport_Init*() {.cdecl, importc, dynlib: dllname.}
proc PyImport_ReloadModule*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyInstance_New*(obClass, obArg, obKW: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyInt_AsLong*(ob: PPyObject): Int32{.cdecl, importc, dynlib: dllname.} #-
proc PyList_Append*(ob1, ob2: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyList_AsTuple*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyList_GetItem*(ob: PPyObject, i: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyList_GetSlice*(ob: PPyObject, i1, i2: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyList_Insert*(dp: PPyObject, idx: Int, item: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyList_New*(size: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyList_Reverse*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyList_SetItem*(dp: PPyObject, idx: Int, item: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyList_SetSlice*(ob: PPyObject, i1, i2: Int, ob2: PPyObject): Int{.
      cdecl, importc, dynlib: dllname.}                 #+
proc PyList_Size*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyList_Sort*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyLong_AsDouble*(ob: PPyObject): Float64{.cdecl, importc, dynlib: dllname.} #+
proc PyLong_AsLong*(ob: PPyObject): Int32{.cdecl, importc, dynlib: dllname.} #+
proc PyLong_FromDouble*(db: Float64): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyLong_FromLong*(L: Int32): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyLong_FromString*(pc: Cstring, ppc: var Cstring, i: Int): PPyObject{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PyLong_FromUnsignedLong*(val: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyLong_AsUnsignedLong*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyLong_FromUnicode*(ob: PPyObject, a, b: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyLong_FromLongLong*(val: Int64): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyLong_AsLongLong*(ob: PPyObject): Int64{.cdecl, importc, dynlib: dllname.} #-
proc PyMapping_Check*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyMapping_GetItemString*(ob: PPyObject, key: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyMapping_HasKey*(ob, key: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyMapping_HasKeyString*(ob: PPyObject, key: Cstring): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyMapping_Length*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyMapping_SetItemString*(ob: PPyObject, key: Cstring, value: PPyObject): Int{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PyMethod_Class*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyMethod_Function*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyMethod_New*(ob1, ob2, ob3: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyMethod_Self*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyModule_GetName*(ob: PPyObject): Cstring{.cdecl, importc, dynlib: dllname.} #-
proc PyModule_New*(key: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Absolute*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Add*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_And*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Check*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Coerce*(ob1, ob2: var PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Divide*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_FloorDivide*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_TrueDivide*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Divmod*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Float*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Int*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Invert*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Long*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Lshift*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Multiply*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Negative*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Or*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Positive*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Power*(ob1, ob2, ob3: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Remainder*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Rshift*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Subtract*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyNumber_Xor*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyOS_InitInterrupts*(){.cdecl, importc, dynlib: dllname.} #-
proc PyOS_InterruptOccurred*(): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_CallObject*(ob, args: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_Compare*(ob1, ob2: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GetAttr*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyObject_GetAttrString*(ob: PPyObject, c: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GetItem*(ob, key: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_DelItem*(ob, key: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_HasAttrString*(ob: PPyObject, key: Cstring): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_Hash*(ob: PPyObject): Int32{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_IsTrue*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_Length*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_Repr*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_SetAttr*(ob1, ob2, ob3: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_SetAttrString*(ob: PPyObject, key: Cstring, value: PPyObject): Int{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PyObject_SetItem*(ob1, ob2, ob3: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_Init*(ob: PPyObject, t: PPyTypeObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_InitVar*(ob: PPyObject, t: PPyTypeObject, size: Int): PPyObject{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PyObject_New*(t: PPyTypeObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_NewVar*(t: PPyTypeObject, size: Int): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyObject_Free*(ob: PPyObject){.cdecl, importc, dynlib: dllname.} #-
proc PyObject_IsInstance*(inst, cls: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_IsSubclass*(derived, cls: PPyObject): Int{.cdecl, importc, dynlib: dllname.}
proc PyObject_GenericGetAttr*(obj, name: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyObject_GenericSetAttr*(obj, name, value: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GC_Malloc*(size: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GC_New*(t: PPyTypeObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GC_NewVar*(t: PPyTypeObject, size: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GC_Resize*(t: PPyObject, newsize: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GC_Del*(ob: PPyObject){.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GC_Track*(ob: PPyObject){.cdecl, importc, dynlib: dllname.} #-
proc PyObject_GC_UnTrack*(ob: PPyObject){.cdecl, importc, dynlib: dllname.} #-
proc PyRange_New*(l1, l2, l3: Int32, i: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_Check*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_Concat*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_Count*(ob1, ob2: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_GetItem*(ob: PPyObject, i: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_GetSlice*(ob: PPyObject, i1, i2: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_In*(ob1, ob2: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_Index*(ob1, ob2: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_Length*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_Repeat*(ob: PPyObject, count: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_SetItem*(ob: PPyObject, i: Int, value: PPyObject): Int{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PySequence_SetSlice*(ob: PPyObject, i1, i2: Int, value: PPyObject): Int{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PySequence_DelSlice*(ob: PPyObject, i1, i2: Int): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_Tuple*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PySequence_Contains*(ob, value: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySlice_GetIndices*(ob: PPySliceObject, len: Int, 
                             start, stop, step: var Int): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySlice_GetIndicesEx*(ob: PPySliceObject, len: Int, 
                               start, stop, step, slicelength: var Int): Int{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PySlice_New*(start, stop, step: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyString_Concat*(ob1: var PPyObject, ob2: PPyObject){.cdecl, importc, dynlib: dllname.} #-
proc PyString_ConcatAndDel*(ob1: var PPyObject, ob2: PPyObject){.cdecl, importc, dynlib: dllname.} #-
proc PyString_Format*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyString_FromStringAndSize*(s: Cstring, i: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyString_Size*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyString_DecodeEscape*(s: Cstring, length: Int, errors: Cstring, 
                                unicode: Int, recode_encoding: Cstring): PPyObject{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PyString_Repr*(ob: PPyObject, smartquotes: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PySys_GetObject*(s: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.} 
#-
#PySys_Init:procedure; cdecl, importc, dynlib: dllname;
#-
proc PySys_SetObject*(s: Cstring, ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PySys_SetPath*(path: Cstring){.cdecl, importc, dynlib: dllname.} #-
#PyTraceBack_Fetch:function:PPyObject; cdecl, importc, dynlib: dllname;
#-
proc PyTraceBack_Here*(p: Pointer): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyTraceBack_Print*(ob1, ob2: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
#PyTraceBack_Store:function (ob:PPyObject):integer; cdecl, importc, dynlib: dllname;
#+
proc PyTuple_GetItem*(ob: PPyObject, i: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc PyTuple_GetSlice*(ob: PPyObject, i1, i2: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyTuple_New*(size: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyTuple_SetItem*(ob: PPyObject, key: Int, value: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #+
proc PyTuple_Size*(ob: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #+
proc PyType_IsSubtype*(a, b: PPyTypeObject): Int{.cdecl, importc, dynlib: dllname.}
proc PyType_GenericAlloc*(atype: PPyTypeObject, nitems: Int): PPyObject{.
      cdecl, importc, dynlib: dllname.}
proc PyType_GenericNew*(atype: PPyTypeObject, args, kwds: PPyObject): PPyObject{.
      cdecl, importc, dynlib: dllname.}
proc PyType_Ready*(atype: PPyTypeObject): Int{.cdecl, importc, dynlib: dllname.} #+
proc PyUnicode_FromWideChar*(w: Pointer, size: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #+
proc PyUnicode_AsWideChar*(unicode: PPyObject, w: Pointer, size: Int): Int{.
      cdecl, importc, dynlib: dllname.}                 #-
proc PyUnicode_FromOrdinal*(ordinal: Int): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyWeakref_GetObject*(theRef: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyWeakref_NewProxy*(ob, callback: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyWeakref_NewRef*(ob, callback: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyWrapper_New*(ob1, ob2: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
proc PyBool_FromLong*(ok: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc Py_AtExit*(prc: proc () {.cdecl.}): Int{.cdecl, importc, dynlib: dllname.} #-
#Py_Cleanup:procedure; cdecl, importc, dynlib: dllname;
#-
proc Py_CompileString*(s1, s2: Cstring, i: Int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
proc Py_FatalError*(s: Cstring){.cdecl, importc, dynlib: dllname.} #-
proc Py_FindMethod*(md: PPyMethodDef, ob: PPyObject, key: Cstring): PPyObject{.
      cdecl, importc, dynlib: dllname.}                 #-
proc Py_FindMethodInChain*(mc: PPyMethodChain, ob: PPyObject, key: Cstring): PPyObject{.
      cdecl, importc, dynlib: dllname.}                 #-
proc Py_FlushLine*(){.cdecl, importc, dynlib: dllname.} #+
proc Py_Finalize*(){.cdecl, importc, dynlib: dllname.} #-
proc PyErr_ExceptionMatches*(exc: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyErr_GivenExceptionMatches*(raised_exc, exc: PPyObject): Int{.cdecl, importc, dynlib: dllname.} #-
proc PyEval_EvalCode*(co: PPyCodeObject, globals, locals: PPyObject): PPyObject{.
      cdecl, importc, dynlib: dllname.}                 #+
proc Py_GetVersion*(): Cstring{.cdecl, importc, dynlib: dllname.} #+
proc Py_GetCopyright*(): Cstring{.cdecl, importc, dynlib: dllname.} #+
proc Py_GetExecPrefix*(): Cstring{.cdecl, importc, dynlib: dllname.} #+
proc Py_GetPath*(): Cstring{.cdecl, importc, dynlib: dllname.} #+
proc Py_GetPrefix*(): Cstring{.cdecl, importc, dynlib: dllname.} #+
proc Py_GetProgramName*(): Cstring{.cdecl, importc, dynlib: dllname.} #-
proc PyParser_SimpleParseString*(str: Cstring, start: Int): PNode{.cdecl, importc, dynlib: dllname.} #-
proc PyNode_Free*(n: PNode){.cdecl, importc, dynlib: dllname.} #-
proc PyErr_NewException*(name: Cstring, base, dict: PPyObject): PPyObject{.
      cdecl, importc, dynlib: dllname.}                 #-
proc Py_Malloc*(size: Int): Pointer {.cdecl, importc, dynlib: dllname.}
proc PyMem_Malloc*(size: Int): Pointer {.cdecl, importc, dynlib: dllname.}
proc PyObject_CallMethod*(obj: PPyObject, theMethod, 
                              format: Cstring): PPyObject{.cdecl, importc, dynlib: dllname.}
proc Py_SetProgramName*(name: Cstring){.cdecl, importc, dynlib: dllname.}
proc Py_IsInitialized*(): Int{.cdecl, importc, dynlib: dllname.}
proc Py_GetProgramFullPath*(): Cstring{.cdecl, importc, dynlib: dllname.}
proc Py_NewInterpreter*(): PPyThreadState{.cdecl, importc, dynlib: dllname.}
proc Py_EndInterpreter*(tstate: PPyThreadState){.cdecl, importc, dynlib: dllname.}
proc PyEval_AcquireLock*(){.cdecl, importc, dynlib: dllname.}
proc PyEval_ReleaseLock*(){.cdecl, importc, dynlib: dllname.}
proc PyEval_AcquireThread*(tstate: PPyThreadState){.cdecl, importc, dynlib: dllname.}
proc PyEval_ReleaseThread*(tstate: PPyThreadState){.cdecl, importc, dynlib: dllname.}
proc PyInterpreterState_New*(): PPyInterpreterState{.cdecl, importc, dynlib: dllname.}
proc PyInterpreterState_Clear*(interp: PPyInterpreterState){.cdecl, importc, dynlib: dllname.}
proc PyInterpreterState_Delete*(interp: PPyInterpreterState){.cdecl, importc, dynlib: dllname.}
proc PyThreadState_New*(interp: PPyInterpreterState): PPyThreadState{.cdecl, importc, dynlib: dllname.}
proc PyThreadState_Clear*(tstate: PPyThreadState){.cdecl, importc, dynlib: dllname.}
proc PyThreadState_Delete*(tstate: PPyThreadState){.cdecl, importc, dynlib: dllname.}
proc PyThreadState_Get*(): PPyThreadState{.cdecl, importc, dynlib: dllname.}
proc PyThreadState_Swap*(tstate: PPyThreadState): PPyThreadState{.cdecl, importc, dynlib: dllname.} 

#Further exported Objects, may be implemented later
#
#    PyCode_New: Pointer;
#    PyErr_SetInterrupt: Pointer;
#    PyFile_AsFile: Pointer;
#    PyFile_FromFile: Pointer;
#    PyFloat_AsString: Pointer;
#    PyFrame_BlockPop: Pointer;
#    PyFrame_BlockSetup: Pointer;
#    PyFrame_ExtendStack: Pointer;
#    PyFrame_FastToLocals: Pointer;
#    PyFrame_LocalsToFast: Pointer;
#    PyFrame_New: Pointer;
#    PyGrammar_AddAccelerators: Pointer;
#    PyGrammar_FindDFA: Pointer;
#    PyGrammar_LabelRepr: Pointer;
#    PyInstance_DoBinOp: Pointer;
#    PyInt_GetMax: Pointer;
#    PyMarshal_Init: Pointer;
#    PyMarshal_ReadLongFromFile: Pointer;
#    PyMarshal_ReadObjectFromFile: Pointer;
#    PyMarshal_ReadObjectFromString: Pointer;
#    PyMarshal_WriteLongToFile: Pointer;
#    PyMarshal_WriteObjectToFile: Pointer;
#    PyMember_Get: Pointer;
#    PyMember_Set: Pointer;
#    PyNode_AddChild: Pointer;
#    PyNode_Compile: Pointer;
#    PyNode_New: Pointer;
#    PyOS_GetLastModificationTime: Pointer;
#    PyOS_Readline: Pointer;
#    PyOS_strtol: Pointer;
#    PyOS_strtoul: Pointer;
#    PyObject_CallFunction: Pointer;
#    PyObject_CallMethod: Pointer;
#    PyObject_Print: Pointer;
#    PyParser_AddToken: Pointer;
#    PyParser_Delete: Pointer;
#    PyParser_New: Pointer;
#    PyParser_ParseFile: Pointer;
#    PyParser_ParseString: Pointer;
#    PyParser_SimpleParseFile: Pointer;
#    PyRun_AnyFile: Pointer;
#    PyRun_File: Pointer;
#    PyRun_InteractiveLoop: Pointer;
#    PyRun_InteractiveOne: Pointer;
#    PyRun_SimpleFile: Pointer;
#    PySys_GetFile: Pointer;
#    PyToken_OneChar: Pointer;
#    PyToken_TwoChars: Pointer;
#    PyTokenizer_Free: Pointer;
#    PyTokenizer_FromFile: Pointer;
#    PyTokenizer_FromString: Pointer;
#    PyTokenizer_Get: Pointer;
#    Py_Main: Pointer;
#    _PyObject_NewVar: Pointer;
#    _PyParser_Grammar: Pointer;
#    _PyParser_TokenNames: Pointer;
#    _PyThread_Started: Pointer;
#    _Py_c_diff: Pointer;
#    _Py_c_neg: Pointer;
#    _Py_c_pow: Pointer;
#    _Py_c_prod: Pointer;
#    _Py_c_quot: Pointer;
#    _Py_c_sum: Pointer;
#

# This function handles all cardinals, pointer types (with no adjustment of pointers!)
# (Extended) floats, which are handled as Python doubles and currencies, handled
# as (normalized) Python doubles.
proc pyImportExecCodeModule*(name: String, codeobject: PPyObject): PPyObject
proc pyStringCheck*(obj: PPyObject): Bool
proc pyStringCheckExact*(obj: PPyObject): Bool
proc pyFloatCheck*(obj: PPyObject): Bool
proc pyFloatCheckExact*(obj: PPyObject): Bool
proc pyIntCheck*(obj: PPyObject): Bool
proc pyIntCheckExact*(obj: PPyObject): Bool
proc pyLongCheck*(obj: PPyObject): Bool
proc pyLongCheckExact*(obj: PPyObject): Bool
proc pyTupleCheck*(obj: PPyObject): Bool
proc pyTupleCheckExact*(obj: PPyObject): Bool
proc pyInstanceCheck*(obj: PPyObject): Bool
proc pyClassCheck*(obj: PPyObject): Bool
proc pyMethodCheck*(obj: PPyObject): Bool
proc pyListCheck*(obj: PPyObject): Bool
proc pyListCheckExact*(obj: PPyObject): Bool
proc pyDictCheck*(obj: PPyObject): Bool
proc pyDictCheckExact*(obj: PPyObject): Bool
proc pyModuleCheck*(obj: PPyObject): Bool
proc pyModuleCheckExact*(obj: PPyObject): Bool
proc pySliceCheck*(obj: PPyObject): Bool
proc pyFunctionCheck*(obj: PPyObject): Bool
proc pyUnicodeCheck*(obj: PPyObject): Bool
proc pyUnicodeCheckExact*(obj: PPyObject): Bool
proc pyTypeISGC*(t: PPyTypeObject): Bool
proc pyObjectISGC*(obj: PPyObject): Bool
proc pyBoolCheck*(obj: PPyObject): Bool
proc pyBaseStringCheck*(obj: PPyObject): Bool
proc pyEnumCheck*(obj: PPyObject): Bool
proc pyObjectTypeCheck*(obj: PPyObject, t: PPyTypeObject): Bool
proc pyInitModule*(name: Cstring, md: PPyMethodDef): PPyObject
proc pyTypeHasFeature*(AType: PPyTypeObject, AFlag: Int): Bool
# implementation

proc pyINCREF*(op: PPyObject) {.inline.} = 
  inc(op.ob_refcnt)

proc pyDECREF*(op: PPyObject) {.inline.} = 
  dec(op.ob_refcnt)
  if op.ob_refcnt == 0: 
    op.ob_type.tp_dealloc(op)

proc pyXINCREF*(op: PPyObject) {.inline.} = 
  if op != nil: pyINCREF(op)
  
proc pyXDECREF*(op: PPyObject) {.inline.} = 
  if op != nil: pyDECREF(op)
  
proc pyImportExecCodeModule(name: string, codeobject: PPyObject): PPyObject = 
  var m, d, v, modules: PPyObject
  m = PyImport_AddModule(Cstring(name))
  if m == nil: 
    return nil
  d = PyModule_GetDict(m)
  if PyDict_GetItemString(d, "__builtins__") == nil: 
    if PyDict_SetItemString(d, "__builtins__", PyEval_GetBuiltins()) != 0: 
      return nil
  if PyDict_SetItemString(d, "__file__", 
                          PPyCodeObject(codeobject).co_filename) != 0: 
    PyErr_Clear() # Not important enough to report
  v = PyEval_EvalCode(PPyCodeObject(codeobject), d, d) # XXX owner ?
  if v == nil: 
    return nil
  pyXDECREF(v)
  modules = PyImport_GetModuleDict()
  if PyDict_GetItemString(modules, Cstring(name)) == nil: 
    PyErr_SetString(pyExcImportError[] , Cstring(
        "Loaded module " & name & "not found in sys.modules"))
    return nil
  pyXINCREF(m)
  Result = m

proc pyStringCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyStringType)

proc pyStringCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj.ob_type == pyStringType)

proc pyFloatCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyFloatType)

proc pyFloatCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj.ob_type == pyFloatType)

proc pyIntCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyIntType)

proc pyIntCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj.ob_type == pyIntType)

proc pyLongCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyLongType)

proc pyLongCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj.ob_type == pyLongType)

proc pyTupleCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyTupleType)

proc pyTupleCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj[].ob_type == pyTupleType)

proc pyInstanceCheck(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj[].ob_type == pyInstanceType)

proc pyClassCheck(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj[].ob_type == pyClassType)

proc pyMethodCheck(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj[].ob_type == pyMethodType)

proc pyListCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyListType)

proc pyListCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj[].ob_type == pyListType)

proc pyDictCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyDictType)

proc pyDictCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj[].ob_type == pyDictType)

proc pyModuleCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyModuleType)

proc pyModuleCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj[].ob_type == pyModuleType)

proc pySliceCheck(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj[].ob_type == pySliceType)

proc pyFunctionCheck(obj: PPyObject): bool = 
  Result = (obj != nil) and
      ((obj.ob_type == pyCFunctionType) or
      (obj.ob_type == pyFunctionType))

proc pyUnicodeCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyUnicodeType)

proc pyUnicodeCheckExact(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj.ob_type == pyUnicodeType)

proc pyTypeISGC(t: PPyTypeObject): bool = 
  Result = pyTypeHasFeature(t, Py_TPFLAGS_HAVE_GC)

proc pyObjectISGC(obj: PPyObject): bool = 
  Result = pyTypeISGC(obj.ob_type) and
      ((obj.ob_type.tp_is_gc == nil) or (obj.ob_type.tp_is_gc(obj) == 1))

proc pyBoolCheck(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj.ob_type == pyBoolType)

proc pyBaseStringCheck(obj: PPyObject): bool = 
  Result = pyObjectTypeCheck(obj, pyBaseStringType)

proc pyEnumCheck(obj: PPyObject): bool = 
  Result = (obj != nil) and (obj.ob_type == pyEnumType)

proc pyObjectTypeCheck(obj: PPyObject, t: PPyTypeObject): bool = 
  Result = (obj != nil) and (obj.ob_type == t)
  if not Result and (obj != nil) and (t != nil): 
    Result = PyType_IsSubtype(obj.ob_type, t) == 1
  
proc pyInitModule(name: cstring, md: PPyMethodDef): PPyObject = 
  result = Py_InitModule4(name, md, nil, nil, 1012)

proc pyTypeHasFeature(AType: PPyTypeObject, AFlag: int): bool = 
  #(((t)->tp_flags & (f)) != 0)
  Result = (aType.tp_flags and aFlag) != 0

proc init(lib: TLibHandle) = 
  pyDebugFlag = cast[PInt](symAddr(lib, "Py_DebugFlag"))
  pyVerboseFlag = cast[PInt](symAddr(lib, "Py_VerboseFlag"))
  pyInteractiveFlag = cast[PInt](symAddr(lib, "Py_InteractiveFlag"))
  pyOptimizeFlag = cast[PInt](symAddr(lib, "Py_OptimizeFlag"))
  pyNoSiteFlag = cast[PInt](symAddr(lib, "Py_NoSiteFlag"))
  pyUseClassExceptionsFlag = cast[PInt](symAddr(lib, "Py_UseClassExceptionsFlag"))
  pyFrozenFlag = cast[PInt](symAddr(lib, "Py_FrozenFlag"))
  pyTabcheckFlag = cast[PInt](symAddr(lib, "Py_TabcheckFlag"))
  pyUnicodeFlag = cast[PInt](symAddr(lib, "Py_UnicodeFlag"))
  pyIgnoreEnvironmentFlag = cast[PInt](symAddr(lib, "Py_IgnoreEnvironmentFlag"))
  pyDivisionWarningFlag = cast[PInt](symAddr(lib, "Py_DivisionWarningFlag"))
  pyNone = cast[PPyObject](symAddr(lib, "_Py_NoneStruct"))
  pyEllipsis = cast[PPyObject](symAddr(lib, "_Py_EllipsisObject"))
  pyFalse = cast[PPyIntObject](symAddr(lib, "_Py_ZeroStruct"))
  pyTrue = cast[PPyIntObject](symAddr(lib, "_Py_TrueStruct"))
  pyNotImplemented = cast[PPyObject](symAddr(lib, "_Py_NotImplementedStruct"))
  pyImportFrozenModules = cast[PPFrozen](symAddr(lib, "PyImport_FrozenModules"))
  pyExcAttributeError = cast[PPPyObject](symAddr(lib, "PyExc_AttributeError"))
  pyExcEOFError = cast[PPPyObject](symAddr(lib, "PyExc_EOFError"))
  pyExcIOError = cast[PPPyObject](symAddr(lib, "PyExc_IOError"))
  pyExcImportError = cast[PPPyObject](symAddr(lib, "PyExc_ImportError"))
  pyExcIndexError = cast[PPPyObject](symAddr(lib, "PyExc_IndexError"))
  pyExcKeyError = cast[PPPyObject](symAddr(lib, "PyExc_KeyError"))
  pyExcKeyboardInterrupt = cast[PPPyObject](symAddr(lib, "PyExc_KeyboardInterrupt"))
  pyExcMemoryError = cast[PPPyObject](symAddr(lib, "PyExc_MemoryError"))
  pyExcNameError = cast[PPPyObject](symAddr(lib, "PyExc_NameError"))
  pyExcOverflowError = cast[PPPyObject](symAddr(lib, "PyExc_OverflowError"))
  pyExcRuntimeError = cast[PPPyObject](symAddr(lib, "PyExc_RuntimeError"))
  pyExcSyntaxError = cast[PPPyObject](symAddr(lib, "PyExc_SyntaxError"))
  pyExcSystemError = cast[PPPyObject](symAddr(lib, "PyExc_SystemError"))
  pyExcSystemExit = cast[PPPyObject](symAddr(lib, "PyExc_SystemExit"))
  pyExcTypeError = cast[PPPyObject](symAddr(lib, "PyExc_TypeError"))
  pyExcValueError = cast[PPPyObject](symAddr(lib, "PyExc_ValueError"))
  pyExcZeroDivisionError = cast[PPPyObject](symAddr(lib, "PyExc_ZeroDivisionError"))
  pyExcArithmeticError = cast[PPPyObject](symAddr(lib, "PyExc_ArithmeticError"))
  pyExcException = cast[PPPyObject](symAddr(lib, "PyExc_Exception"))
  pyExcFloatingPointError = cast[PPPyObject](symAddr(lib, "PyExc_FloatingPointError"))
  pyExcLookupError = cast[PPPyObject](symAddr(lib, "PyExc_LookupError"))
  pyExcStandardError = cast[PPPyObject](symAddr(lib, "PyExc_StandardError"))
  pyExcAssertionError = cast[PPPyObject](symAddr(lib, "PyExc_AssertionError"))
  pyExcEnvironmentError = cast[PPPyObject](symAddr(lib, "PyExc_EnvironmentError"))
  pyExcIndentationError = cast[PPPyObject](symAddr(lib, "PyExc_IndentationError"))
  pyExcMemoryErrorInst = cast[PPPyObject](symAddr(lib, "PyExc_MemoryErrorInst"))
  pyExcNotImplementedError = cast[PPPyObject](symAddr(lib, "PyExc_NotImplementedError"))
  pyExcOSError = cast[PPPyObject](symAddr(lib, "PyExc_OSError"))
  pyExcTabError = cast[PPPyObject](symAddr(lib, "PyExc_TabError"))
  pyExcUnboundLocalError = cast[PPPyObject](symAddr(lib, "PyExc_UnboundLocalError"))
  pyExcUnicodeError = cast[PPPyObject](symAddr(lib, "PyExc_UnicodeError"))
  pyExcWarning = cast[PPPyObject](symAddr(lib, "PyExc_Warning"))
  pyExcDeprecationWarning = cast[PPPyObject](symAddr(lib, "PyExc_DeprecationWarning"))
  pyExcRuntimeWarning = cast[PPPyObject](symAddr(lib, "PyExc_RuntimeWarning"))
  pyExcSyntaxWarning = cast[PPPyObject](symAddr(lib, "PyExc_SyntaxWarning"))
  pyExcUserWarning = cast[PPPyObject](symAddr(lib, "PyExc_UserWarning"))
  pyExcOverflowWarning = cast[PPPyObject](symAddr(lib, "PyExc_OverflowWarning"))
  pyExcReferenceError = cast[PPPyObject](symAddr(lib, "PyExc_ReferenceError"))
  pyExcStopIteration = cast[PPPyObject](symAddr(lib, "PyExc_StopIteration"))
  pyExcFutureWarning = cast[PPPyObject](symAddr(lib, "PyExc_FutureWarning"))
  pyExcPendingDeprecationWarning = cast[PPPyObject](symAddr(lib, 
      "PyExc_PendingDeprecationWarning"))
  pyExcUnicodeDecodeError = cast[PPPyObject](symAddr(lib, "PyExc_UnicodeDecodeError"))
  pyExcUnicodeEncodeError = cast[PPPyObject](symAddr(lib, "PyExc_UnicodeEncodeError"))
  pyExcUnicodeTranslateError = cast[PPPyObject](symAddr(lib, "PyExc_UnicodeTranslateError"))
  pyTypeType = cast[PPyTypeObject](symAddr(lib, "PyType_Type"))
  pyCFunctionType = cast[PPyTypeObject](symAddr(lib, "PyCFunction_Type"))
  pyCObjectType = cast[PPyTypeObject](symAddr(lib, "PyCObject_Type"))
  pyClassType = cast[PPyTypeObject](symAddr(lib, "PyClass_Type"))
  pyCodeType = cast[PPyTypeObject](symAddr(lib, "PyCode_Type"))
  pyComplexType = cast[PPyTypeObject](symAddr(lib, "PyComplex_Type"))
  pyDictType = cast[PPyTypeObject](symAddr(lib, "PyDict_Type"))
  pyFileType = cast[PPyTypeObject](symAddr(lib, "PyFile_Type"))
  pyFloatType = cast[PPyTypeObject](symAddr(lib, "PyFloat_Type"))
  pyFrameType = cast[PPyTypeObject](symAddr(lib, "PyFrame_Type"))
  pyFunctionType = cast[PPyTypeObject](symAddr(lib, "PyFunction_Type"))
  pyInstanceType = cast[PPyTypeObject](symAddr(lib, "PyInstance_Type"))
  pyIntType = cast[PPyTypeObject](symAddr(lib, "PyInt_Type"))
  pyListType = cast[PPyTypeObject](symAddr(lib, "PyList_Type"))
  pyLongType = cast[PPyTypeObject](symAddr(lib, "PyLong_Type"))
  pyMethodType = cast[PPyTypeObject](symAddr(lib, "PyMethod_Type"))
  pyModuleType = cast[PPyTypeObject](symAddr(lib, "PyModule_Type"))
  pyObjectType = cast[PPyTypeObject](symAddr(lib, "PyObject_Type"))
  pyRangeType = cast[PPyTypeObject](symAddr(lib, "PyRange_Type"))
  pySliceType = cast[PPyTypeObject](symAddr(lib, "PySlice_Type"))
  pyStringType = cast[PPyTypeObject](symAddr(lib, "PyString_Type"))
  pyTupleType = cast[PPyTypeObject](symAddr(lib, "PyTuple_Type"))
  pyUnicodeType = cast[PPyTypeObject](symAddr(lib, "PyUnicode_Type"))
  pyBaseObjectType = cast[PPyTypeObject](symAddr(lib, "PyBaseObject_Type"))
  pyBufferType = cast[PPyTypeObject](symAddr(lib, "PyBuffer_Type"))
  pyCallIterType = cast[PPyTypeObject](symAddr(lib, "PyCallIter_Type"))
  pyCellType = cast[PPyTypeObject](symAddr(lib, "PyCell_Type"))
  pyClassMethodType = cast[PPyTypeObject](symAddr(lib, "PyClassMethod_Type"))
  pyPropertyType = cast[PPyTypeObject](symAddr(lib, "PyProperty_Type"))
  pySeqIterType = cast[PPyTypeObject](symAddr(lib, "PySeqIter_Type"))
  pyStaticMethodType = cast[PPyTypeObject](symAddr(lib, "PyStaticMethod_Type"))
  pySuperType = cast[PPyTypeObject](symAddr(lib, "PySuper_Type"))
  pySymtableEntryType = cast[PPyTypeObject](symAddr(lib, "PySymtableEntry_Type"))
  pyTraceBackType = cast[PPyTypeObject](symAddr(lib, "PyTraceBack_Type"))
  pyWrapperDescrType = cast[PPyTypeObject](symAddr(lib, "PyWrapperDescr_Type"))
  pyBaseStringType = cast[PPyTypeObject](symAddr(lib, "PyBaseString_Type"))
  pyBoolType = cast[PPyTypeObject](symAddr(lib, "PyBool_Type"))
  pyEnumType = cast[PPyTypeObject](symAddr(lib, "PyEnum_Type"))

# Unfortunately we have to duplicate the loading mechanism here, because Nimrod
# used to not support variables from dynamic libraries. Well designed API's
# don't require this anyway. Python is an exception.

var
  lib: TLibHandle

when defined(windows):
  const
    LibNames = ["python27.dll", "python26.dll", "python25.dll",
      "python24.dll", "python23.dll", "python22.dll", "python21.dll",
      "python20.dll", "python16.dll", "python15.dll"]
elif defined(macosx):
  const
    LibNames = ["libpython2.7.dylib", "libpython2.6.dylib",
      "libpython2.5.dylib", "libpython2.4.dylib", "libpython2.3.dylib", 
      "libpython2.2.dylib", "libpython2.1.dylib", "libpython2.0.dylib",
      "libpython1.6.dylib", "libpython1.5.dylib"]
else:
  const
    LibNames = [
      "libpython2.7.so" & dllver,
      "libpython2.6.so" & dllver, 
      "libpython2.5.so" & dllver, 
      "libpython2.4.so" & dllver, 
      "libpython2.3.so" & dllver, 
      "libpython2.2.so" & dllver, 
      "libpython2.1.so" & dllver, 
      "libpython2.0.so" & dllver,
      "libpython1.6.so" & dllver, 
      "libpython1.5.so" & dllver]
  
for libName in items(LibNames): 
  lib = loadLib(libName)
  if lib != nil: break

if lib == nil: quit("could not load python library")
init(lib)

