#*****************************************************************************
# *                                                                            *
# *  File:        lauxlib.pas                                                  *
# *  Authors:     TeCGraf           (C headers + actual Lua libraries)         *
# *               Lavergne Thomas   (original translation to Pascal)           *
# *               Bram Kuijvenhoven (update to Lua 5.1.1 for FreePascal)       *
# *  Description: Lua auxiliary library                                        *
# *                                                                            *
# *****************************************************************************
#
#** $Id: lauxlib.h,v 1.59 2003/03/18 12:25:32 roberto Exp $
#** Auxiliary functions for building Lua libraries
#** See Copyright Notice in lua.h
#
#
#** Translated to pascal by Lavergne Thomas
#** Notes :
#**    - Pointers type was prefixed with 'P'
#** Bug reports :
#**    - thomas.lavergne@laposte.net
#**   In french or in english
#

import 
  lua

proc pushstring*(L: PState, s: String)
  # compatibilty macros
proc getn*(L: PState, n: Cint): Cint
  # calls lua_objlen
proc setn*(L: PState, t, n: Cint)
  # does nothing!
type 
  Treg*{.final.} = object 
    name*: Cstring
    func*: CFunction

  Preg* = ptr Treg


{.push callConv: cdecl, dynlib: lua.LIB_NAME.}
{.push importc: "luaL_$1".}

proc openlib*(L: PState, libname: Cstring, lr: Preg, nup: Cint)
proc register*(L: PState, libname: Cstring, lr: Preg)

proc getmetafield*(L: PState, obj: Cint, e: Cstring): Cint
proc callmeta*(L: PState, obj: Cint, e: Cstring): Cint
proc typerror*(L: PState, narg: Cint, tname: Cstring): Cint
proc argerror*(L: PState, numarg: Cint, extramsg: Cstring): Cint
proc checklstring*(L: PState, numArg: Cint, len: ptr Int): Cstring
proc optlstring*(L: PState, numArg: Cint, def: Cstring, len: ptr Cint): Cstring
proc checknumber*(L: PState, numArg: Cint): Number
proc optnumber*(L: PState, nArg: Cint, def: Number): Number
proc checkinteger*(L: PState, numArg: Cint): Integer
proc optinteger*(L: PState, nArg: Cint, def: Integer): Integer
proc checkstack*(L: PState, sz: Cint, msg: Cstring)
proc checktype*(L: PState, narg, t: Cint)

proc checkany*(L: PState, narg: Cint)
proc newmetatable*(L: PState, tname: Cstring): Cint

proc checkudata*(L: PState, ud: Cint, tname: Cstring): Pointer
proc where*(L: PState, lvl: Cint)
proc error*(L: PState, fmt: Cstring): Cint{.varargs.}
proc checkoption*(L: PState, narg: Cint, def: Cstring, lst: CstringArray): Cint

proc unref*(L: PState, t, theref: Cint)
proc loadfile*(L: PState, filename: Cstring): Cint
proc loadbuffer*(L: PState, buff: Cstring, size: Cint, name: Cstring): Cint
proc loadstring*(L: PState, s: Cstring): Cint
proc newstate*(): PState

{.pop.}
proc reference*(L: PState, t: Cint): Cint{.importc: "luaL_ref".}

{.pop.}

proc open*(): PState
  # compatibility; moved from unit lua to lauxlib because it needs luaL_newstate
  #
  #** ===============================================================
  #** some useful macros
  #** ===============================================================
  #
proc argcheck*(L: PState, cond: Bool, numarg: Cint, extramsg: Cstring)
proc checkstring*(L: PState, n: Cint): Cstring
proc optstring*(L: PState, n: Cint, d: Cstring): Cstring
proc checkint*(L: PState, n: Cint): Cint
proc checklong*(L: PState, n: Cint): Clong
proc optint*(L: PState, n: Cint, d: Float64): Cint
proc optlong*(L: PState, n: Cint, d: Float64): Clong
proc dofile*(L: PState, filename: Cstring): Cint
proc dostring*(L: PState, str: Cstring): Cint
proc getmetatable*(L: PState, tname: Cstring)
  # not translated:
  # #define luaL_opt(L,f,n,d)  (lua_isnoneornil(L,(n)) ? (d) : f(L,(n)))
  #
  #** =======================================================
  #** Generic Buffer manipulation
  #** =======================================================
  #
const                         # note: this is just arbitrary, as it related to the BUFSIZ defined in stdio.h ...
  Buffersize* = 4096

type 
  Buffer*{.final.} = object 
    p*: Cstring               # current position in buffer 
    lvl*: Cint                 # number of strings in the stack (level) 
    L*: PState
    buffer*: Array[0..BUFFERSIZE - 1, Char] # warning: see note above about LUAL_BUFFERSIZE
  
  PBuffer* = ptr Buffer

proc addchar*(B: PBuffer, c: Char)
  # warning: see note above about LUAL_BUFFERSIZE
  # compatibility only (alias for luaL_addchar) 
proc putchar*(B: PBuffer, c: Char)
  # warning: see note above about LUAL_BUFFERSIZE
proc addsize*(B: PBuffer, n: Cint)

{.push callConv: cdecl, dynlib: lua.LIB_NAME, importc: "luaL_$1".}
proc buffinit*(L: PState, B: PBuffer)
proc prepbuffer*(B: PBuffer): Cstring
proc addlstring*(B: PBuffer, s: Cstring, L: Cint)
proc addstring*(B: PBuffer, s: Cstring)
proc addvalue*(B: PBuffer)
proc pushresult*(B: PBuffer)
proc gsub*(L: PState, s, p, r: Cstring): Cstring
proc findtable*(L: PState, idx: Cint, fname: Cstring, szhint: Cint): Cstring
  # compatibility with ref system 
  # pre-defined references 
{.pop.}

const 
  Noref* = - 2
  Refnil* = - 1

proc unref*(L: PState, theref: Cint)
proc getref*(L: PState, theref: Cint)
  #
  #** Compatibility macros and functions
  #
# implementation

proc pushstring(L: PState, s: string) = 
  pushlstring(L, Cstring(s), s.len.Cint)

proc getn(L: PState, n: cint): cint = 
  Result = objlen(L, n)

proc setn(L: PState, t, n: cint) = 
  # does nothing as this operation is deprecated
  nil

proc open(): PState = 
  Result = newstate()

proc dofile(L: PState, filename: cstring): cint = 
  Result = loadfile(L, filename)
  if Result == 0: Result = pcall(L, 0, MULTRET, 0)
  
proc dostring(L: PState, str: cstring): cint = 
  Result = loadstring(L, str)
  if Result == 0: Result = pcall(L, 0, MULTRET, 0)
  
proc getmetatable(L: PState, tname: cstring) = 
  getfield(L, REGISTRYINDEX, tname)

proc argcheck(L: PState, cond: bool, numarg: cint, extramsg: cstring) = 
  if not cond: 
    discard argerror(L, numarg, extramsg)

proc checkstring(L: PState, n: cint): cstring = 
  Result = checklstring(L, n, nil)

proc optstring(L: PState, n: cint, d: cstring): cstring = 
  Result = optlstring(L, n, d, nil)

proc checkint(L: PState, n: cint): cint = 
  Result = Cint(checknumber(L, n))

proc checklong(L: PState, n: cint): clong = 
  Result = Int32(toInt(checknumber(L, n)))

proc optint(L: PState, n: cint, d: float64): cint = 
  Result = optnumber(L, n, d).Cint

proc optlong(L: PState, n: cint, d: float64): clong = 
  Result = Int32(toInt(optnumber(L, n, d)))

proc addchar(B: PBuffer, c: Char) = 
  if cast[Int](addr((b.p))) < (cast[Int](addr((b.buffer[0]))) + BUFFERSIZE): 
    discard prepbuffer(b)
  b.p[1] = c
  b.p = cast[Cstring](cast[Int](b.p) + 1)

proc putchar(B: PBuffer, c: Char) = 
  addchar(b, c)

proc addsize(B: PBuffer, n: cint) = 
  b.p = cast[Cstring](cast[Int](b.p) + n)

proc unref(L: PState, theref: cint) = 
  unref(L, REGISTRYINDEX, theref)

proc getref(L: PState, theref: cint) = 
  rawgeti(L, REGISTRYINDEX, theref)
