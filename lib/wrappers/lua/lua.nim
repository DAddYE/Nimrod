#*****************************************************************************
# *                                                                            *
# *  File:        lua.pas                                                      *
# *  Authors:     TeCGraf           (C headers + actual Lua libraries)         *
# *               Lavergne Thomas   (original translation to Pascal)           *
# *               Bram Kuijvenhoven (update to Lua 5.1.1 for FreePascal)       *
# *  Description: Basic Lua library                                            *
# *                                                                            *
# *****************************************************************************
#
#** $Id: lua.h,v 1.175 2003/03/18 12:31:39 roberto Exp $
#** Lua - An Extensible Extension Language
#** TeCGraf: Computer Graphics Technology Group, PUC-Rio, Brazil
#** http://www.lua.org   mailto:info@lua.org
#** See Copyright Notice at the end of this file
#
#
#** Updated to Lua 5.1.1 by Bram Kuijvenhoven (bram at kuijvenhoven dot net),
#**   Hexis BV (http://www.hexis.nl), the Netherlands
#** Notes:
#**    - Only tested with FPC (FreePascal Compiler)
#**    - Using LuaBinaries styled DLL/SO names, which include version names
#**    - LUA_YIELD was suffixed by '_' for avoiding name collision
#
#
#** Translated to pascal by Lavergne Thomas
#** Notes :
#**    - Pointers type was prefixed with 'P'
#**    - lua_upvalueindex constant was transformed to function
#**    - Some compatibility function was isolated because with it you must have
#**      lualib.
#**    - LUA_VERSION was suffixed by '_' for avoiding name collision.
#** Bug reports :
#**    - thomas.lavergne@laposte.net
#**   In french or in english
#

when defined(useLuajit):
  when defined(MACOSX):
    const
      NAME* = "libluajit.dylib"
      LIB_NAME* = "libluajit.dylib"
  elif defined(UNIX):
    const
      NAME* = "libluajit.so(|.0)"
      LIB_NAME* = "libluajit.so(|.0)"
  else:
    const
      NAME* = "luajit.dll"
      LIB_NAME* = "luajit.dll"
else:
  when defined(MACOSX):
    const
      Name* = "liblua(|5.1|5.0).dylib"
      LibName* = "liblua(|5.1|5.0).dylib"
  elif defined(UNIX):
    const
      NAME* = "liblua(|5.1|5.0).so(|.0)"
      LIB_NAME* = "liblua(|5.1|5.0).so(|.0)"
  else:
    const 
      NAME* = "lua(|5.1|5.0).dll"
      LIB_NAME* = "lua(|5.1|5.0).dll"

const 
  Version* = "Lua 5.1"
  Release* = "Lua 5.1.1"
  VersionNum* = 501
  Copyright* = "Copyright (C) 1994-2006 Lua.org, PUC-Rio"
  Authors* = "R. Ierusalimschy, L. H. de Figueiredo & W. Celes"
  # option for multiple returns in `lua_pcall' and `lua_call' 
  Multret* = - 1              #
                              #** pseudo-indices
                              #
  Registryindex* = - 10000
  Environindex* = - 10001
  Globalsindex* = - 10002

proc upvalueindex*(I: Cint): Cint
const                         # thread status; 0 is OK 
  constYIELD* = 1
  Errrun* = 2
  Errsyntax* = 3
  Errmem* = 4
  Errerr* = 5

type 
  PState* = Pointer
  CFunction* = proc (L: PState): Cint{.cdecl.}

#
#** functions that read/write blocks when loading/dumping Lua chunks
#

type 
  Reader* = proc (L: PState, ud: Pointer, sz: ptr Cint): Cstring{.cdecl.}
  Writer* = proc (L: PState, p: Pointer, sz: Cint, ud: Pointer): Cint{.cdecl.}
  Alloc* = proc (ud, theptr: Pointer, osize, nsize: Cint){.cdecl.}

const 
  Tnone* = - 1
  Tnil* = 0
  Tboolean* = 1
  Tlightuserdata* = 2
  TNumber* = 3
  Tstring* = 4
  Ttable* = 5
  Tfunction* = 6
  Tuserdata* = 7
  Tthread* = 8                # minimum Lua stack available to a C function 
  Minstack* = 20

type                          # Type of Numbers in Lua 
  Number* = Float
  Integer* = Cint

{.pragma: ilua, importc: "lua_$1".}

{.push callConv: cdecl, dynlib: LibName.}
#{.push importc: "lua_$1".}

proc newstate*(f: Alloc, ud: Pointer): PState {.ilua.}

proc close*(L: PState){.ilua.}
proc newthread*(L: PState): PState{.ilua.}
proc atpanic*(L: PState, panicf: CFunction): CFunction{.ilua.}

proc gettop*(L: PState): Cint{.ilua.}
proc settop*(L: PState, idx: Cint){.ilua.}
proc pushvalue*(L: PState, Idx: Cint){.ilua.}
proc remove*(L: PState, idx: Cint){.ilua.}
proc insert*(L: PState, idx: Cint){.ilua.}
proc replace*(L: PState, idx: Cint){.ilua.}
proc checkstack*(L: PState, sz: Cint): Cint{.ilua.}
proc xmove*(`from`, `to`: PState, n: Cint){.ilua.}
proc isnumber*(L: PState, idx: Cint): Cint{.ilua.}
proc isstring*(L: PState, idx: Cint): Cint{.ilua.}
proc iscfunction*(L: PState, idx: Cint): Cint{.ilua.}
proc isuserdata*(L: PState, idx: Cint): Cint{.ilua.}
proc luatype*(L: PState, idx: Cint): Cint{.importc: "lua_type".}
proc typename*(L: PState, tp: Cint): Cstring{.ilua.}
proc equal*(L: PState, idx1, idx2: Cint): Cint{.ilua.}
proc rawequal*(L: PState, idx1, idx2: Cint): Cint{.ilua.}
proc lessthan*(L: PState, idx1, idx2: Cint): Cint{.ilua.}
proc tonumber*(L: PState, idx: Cint): Number{.ilua.}
proc tointeger*(L: PState, idx: Cint): Integer{.ilua.}
proc toboolean*(L: PState, idx: Cint): Cint{.ilua.}
proc tolstring*(L: PState, idx: Cint, length: ptr Cint): Cstring{.ilua.}
proc objlen*(L: PState, idx: Cint): Cint{.ilua.}
proc tocfunction*(L: PState, idx: Cint): CFunction{.ilua.}
proc touserdata*(L: PState, idx: Cint): Pointer{.ilua.}
proc tothread*(L: PState, idx: Cint): PState{.ilua.}
proc topointer*(L: PState, idx: Cint): Pointer{.ilua.}
proc pushnil*(L: PState){.ilua.}
proc pushnumber*(L: PState, n: Number){.ilua.}
proc pushinteger*(L: PState, n: Integer){.ilua.}
proc pushlstring*(L: PState, s: Cstring, len: Cint){.ilua.}
proc pushstring*(L: PState, s: Cstring){.ilua.}
proc pushvfstring*(L: PState, fmt: Cstring, argp: Pointer): Cstring{.ilua.}
proc pushfstring*(L: PState, fmt: Cstring): Cstring{.varargs,ilua.}
proc pushcclosure*(L: PState, fn: CFunction, n: Cint){.ilua.}
proc pushboolean*(L: PState, b: Cint){.ilua.}
proc pushlightuserdata*(L: PState, p: Pointer){.ilua.}
proc pushthread*(L: PState){.ilua.}
proc gettable*(L: PState, idx: Cint){.ilua.}
proc getfield*(L: PState, idx: Cint, k: Cstring){.ilua.}
proc rawget*(L: PState, idx: Cint){.ilua.}
proc rawgeti*(L: PState, idx, n: Cint){.ilua.}
proc createtable*(L: PState, narr, nrec: Cint){.ilua.}
proc newuserdata*(L: PState, sz: Cint): Pointer{.ilua.}
proc getmetatable*(L: PState, objindex: Cint): Cint{.ilua.}
proc getfenv*(L: PState, idx: Cint){.ilua.}
proc settable*(L: PState, idx: Cint){.ilua.}
proc setfield*(L: PState, idx: Cint, k: Cstring){.ilua.}
proc rawset*(L: PState, idx: Cint){.ilua.}
proc rawseti*(L: PState, idx, n: Cint){.ilua.}
proc setmetatable*(L: PState, objindex: Cint): Cint{.ilua.}
proc setfenv*(L: PState, idx: Cint): Cint{.ilua.}
proc call*(L: PState, nargs, nresults: Cint){.ilua.}
proc pcall*(L: PState, nargs, nresults, errf: Cint): Cint{.ilua.}
proc cpcall*(L: PState, func: CFunction, ud: Pointer): Cint{.ilua.}
proc load*(L: PState, reader: Reader, dt: Pointer, chunkname: Cstring): Cint{.ilua.}
proc dump*(L: PState, writer: Writer, data: Pointer): Cint{.ilua.}
proc luayield*(L: PState, nresults: Cint): Cint{.importc: "lua_yield".}
proc resume*(L: PState, narg: Cint): Cint{.ilua.}
proc status*(L: PState): Cint{.ilua.}
proc gc*(L: PState, what, data: Cint): Cint{.ilua.}
proc error*(L: PState): Cint{.ilua.}
proc next*(L: PState, idx: Cint): Cint{.ilua.}
proc concat*(L: PState, n: Cint){.ilua.}
proc getallocf*(L: PState, ud: ptr Pointer): Alloc{.ilua.}
proc setallocf*(L: PState, f: Alloc, ud: Pointer){.ilua.}
{.pop.}

#
#** Garbage-collection functions and options
#

const 
  Gcstop* = 0
  Gcrestart* = 1
  Gccollect* = 2
  Gccount* = 3
  Gccountb* = 4
  Gcstep* = 5
  Gcsetpause* = 6
  Gcsetstepmul* = 7

#
#** ===============================================================
#** some useful macros
#** ===============================================================
#

proc pop*(L: PState, n: Cint)
proc newtable*(L: PState)
proc register*(L: PState, n: Cstring, f: CFunction)
proc pushcfunction*(L: PState, f: CFunction)
proc strlen*(L: PState, i: Cint): Cint
proc isfunction*(L: PState, n: Cint): Bool
proc istable*(L: PState, n: Cint): Bool
proc islightuserdata*(L: PState, n: Cint): Bool
proc isnil*(L: PState, n: Cint): Bool
proc isboolean*(L: PState, n: Cint): Bool
proc isthread*(L: PState, n: Cint): Bool
proc isnone*(L: PState, n: Cint): Bool
proc isnoneornil*(L: PState, n: Cint): Bool
proc pushliteral*(L: PState, s: Cstring)
proc setglobal*(L: PState, s: Cstring)
proc getglobal*(L: PState, s: Cstring)
proc tostring*(L: PState, i: Cint): Cstring
#
#** compatibility macros and functions
#

proc getregistry*(L: PState)
proc getgccount*(L: PState): Cint
type 
  Chunkreader* = Reader
  Chunkwriter* = Writer

#
#** ======================================================================
#** Debug API
#** ======================================================================
#

const 
  Hookcall* = 0
  Hookret* = 1
  Hookline* = 2
  Hookcount* = 3
  Hooktailret* = 4

const 
  Maskcall* = 1 shl Ord(HOOKCALL)
  Maskret* = 1 shl Ord(HOOKRET)
  Maskline* = 1 shl Ord(HOOKLINE)
  Maskcount* = 1 shl Ord(HOOKCOUNT)

const 
  Idsize* = 60

type 
  TDebug*{.final.} = object    # activation record 
    event*: Cint
    name*: Cstring            # (n) 
    namewhat*: Cstring        # (n) `global', `local', `field', `method' 
    what*: Cstring            # (S) `Lua', `C', `main', `tail'
    source*: Cstring          # (S) 
    currentline*: Cint         # (l) 
    nups*: Cint                # (u) number of upvalues 
    linedefined*: Cint         # (S) 
    lastlinedefined*: Cint     # (S) 
    short_src*: Array[0.. <IDSIZE, Char] # (S) \ 
                               # private part 
    i_ci*: Cint                # active function 
  
  PDebug* = ptr TDebug
  Hook* = proc (L: PState, ar: PDebug){.cdecl.}

#
#** ======================================================================
#** Debug API
#** ======================================================================
#

{.push callConv: cdecl, dynlib: lua.LIB_NAME.}

proc getstack*(L: PState, level: Cint, ar: PDebug): Cint{.ilua.}
proc getinfo*(L: PState, what: Cstring, ar: PDebug): Cint{.ilua.}
proc getlocal*(L: PState, ar: PDebug, n: Cint): Cstring{.ilua.}
proc setlocal*(L: PState, ar: PDebug, n: Cint): Cstring{.ilua.}
proc getupvalue*(L: PState, funcindex: Cint, n: Cint): Cstring{.ilua.}
proc setupvalue*(L: PState, funcindex: Cint, n: Cint): Cstring{.ilua.}
proc sethook*(L: PState, func: Hook, mask: Cint, count: Cint): Cint{.ilua.}
proc gethook*(L: PState): Hook{.ilua.}
proc gethookmask*(L: PState): Cint{.ilua.}
proc gethookcount*(L: PState): Cint{.ilua.}

{.pop.}

# implementation

proc upvalueindex(I: cint): cint = 
  Result = GLOBALSINDEX - i

proc pop(L: PState, n: cint) = 
  settop(L, - n - 1)

proc newtable(L: PState) = 
  createtable(L, 0, 0)

proc register(L: PState, n: cstring, f: CFunction) = 
  pushcfunction(L, f)
  setglobal(L, n)

proc pushcfunction(L: PState, f: CFunction) = 
  pushcclosure(L, f, 0)

proc strlen(L: PState, i: cint): cint = 
  Result = objlen(L, i)

proc isfunction(L: PState, n: cint): bool = 
  Result = luatype(L, n) == TFUNCTION

proc istable(L: PState, n: cint): bool = 
  Result = luatype(L, n) == TTABLE

proc islightuserdata(L: PState, n: cint): bool = 
  Result = luatype(L, n) == TLIGHTUSERDATA

proc isnil(L: PState, n: cint): bool = 
  Result = luatype(L, n) == TNIL

proc isboolean(L: PState, n: cint): bool = 
  Result = luatype(L, n) == TBOOLEAN

proc isthread(L: PState, n: cint): bool = 
  Result = luatype(L, n) == TTHREAD

proc isnone(L: PState, n: cint): bool = 
  Result = luatype(L, n) == TNONE

proc isnoneornil(L: PState, n: cint): bool = 
  Result = luatype(L, n) <= 0

proc pushliteral(L: PState, s: cstring) = 
  pushlstring(L, s, s.len.Cint)

proc setglobal(L: PState, s: cstring) = 
  setfield(L, GLOBALSINDEX, s)

proc getglobal(L: PState, s: cstring) = 
  getfield(L, GLOBALSINDEX, s)

proc tostring(L: PState, i: cint): cstring = 
  Result = tolstring(L, i, nil)

proc getregistry(L: PState) = 
  pushvalue(L, REGISTRYINDEX)

proc getgccount(L: PState): cint = 
  Result = gc(L, GCCOUNT, 0)
