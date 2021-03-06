#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## Thread var support for crappy architectures that lack native support for 
## thread local storage. (**Thank you Mac OS X!**)

# included from cgen.nim

proc emulatedThreadVars(): Bool {.inline.} =
  result = {optThreads, optTlsEmulation} <= gGlobalOptions

proc accessThreadLocalVar(p: BProc, s: PSym) =
  if emulatedThreadVars() and not p.ThreadVarAccessed:
    p.ThreadVarAccessed = true
    p.module.usesThreadVars = true
    appf(p.procSec(cpsLocals), "\tNimThreadVars* NimTV;$n")
    app(p.procSec(cpsInit),
      ropecg(p.module, "\tNimTV = (NimThreadVars*) #GetThreadLocalVars();$n"))
    
var
  nimtv: PRope                 # nimrod thread vars; the struct body
  nimtvDeps: Seq[PType] = @[]  # type deps: every module needs whole struct
  nimtvDeclared = initIntSet() # so that every var/field exists only once
                               # in the struct

# 'nimtv' is incredibly hard to modularize! Best effort is to store all thread
# vars in a ROD section and with their type deps and load them
# unconditionally...

# nimtvDeps is VERY hard to cache because it's not a list of IDs nor can it be
# made to be one.

proc declareThreadVar(m: BModule, s: PSym, isExtern: Bool) =
  if emulatedThreadVars():
    # we gather all thread locals var into a struct; we need to allocate
    # storage for that somehow, can't use the thread local storage
    # allocator for it :-(
    if not containsOrIncl(nimtvDeclared, s.id):
      nimtvDeps.add(s.loc.t)
      appf(nimtv, "$1 $2;$n", [getTypeDesc(m, s.loc.t), s.loc.r])
  else:
    if isExtern: app(m.s[cfsVars], "extern ")
    if optThreads in gGlobalOptions: app(m.s[cfsVars], "NIM_THREADVAR ")
    app(m.s[cfsVars], getTypeDesc(m, s.loc.t))
    appf(m.s[cfsVars], " $1;$n", [s.loc.r])
  
proc generateThreadLocalStorage(m: BModule) =
  if nimtv != nil and (m.usesThreadVars or sfMainModule in m.module.flags):
    for t in items(nimtvDeps): discard getTypeDesc(m, t)
    appf(m.s[cfsSeqTypes], "typedef struct {$1} NimThreadVars;$n", [nimtv])

proc generateThreadVarsSize(m: BModule) =
  if nimtv != nil:
    app(m.s[cfsProcs], 
      "NI NimThreadVarsSize(){return (NI)sizeof(NimThreadVars);}" & tnl)

