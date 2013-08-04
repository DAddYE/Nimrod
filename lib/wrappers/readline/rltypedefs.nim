# rltypedefs.h -- Type declarations for readline functions. 
# Copyright (C) 2000-2009 Free Software Foundation, Inc.
#
#   This file is part of the GNU Readline Library (Readline), a library
#   for reading lines of text with interactive input and history editing.      
#
#   Readline is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Readline is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Readline.  If not, see <http://www.gnu.org/licenses/>.
#

type 
  TFunction* = proc (): Cint{.cdecl.}
  TVFunction* = proc (){.cdecl.}
  TCPFunction* = proc (): Cstring{.cdecl.}
  TCPPFunction* = proc (): CstringArray{.cdecl.}

# Bindable functions 

type 
  TcommandFunc* = proc (a2: Cint, a3: Cint): Cint{.cdecl.}

# Typedefs for the completion system 

type 
  TcompentryFunc* = proc (a2: Cstring, a3: Cint): Cstring{.cdecl.}
  TcompletionFunc* = proc (a2: Cstring, a3: Cint, a4: Cint): CstringArray{.
      cdecl.}
  TquoteFunc* = proc (a2: Cstring, a3: Cint, a4: Cstring): Cstring{.cdecl.}
  TdequoteFunc* = proc (a2: Cstring, a3: Cint): Cstring{.cdecl.}
  TcompignoreFunc* = proc (a2: CstringArray): Cint{.cdecl.}
  TcompdispFunc* = proc (a2: CstringArray, a3: Cint, a4: Cint){.cdecl.}

# Type for input and pre-read hook functions like rl_event_hook 

type 
  ThookFunc* = proc (): Cint{.cdecl.}

# Input function type 

type 
  TgetcFunc* = proc (a2: TFile): Cint{.cdecl.}

# Generic function that takes a character buffer (which could be the readline
#   line buffer) and an index into it (which could be rl_point) and returns
#   an int. 

type 
  TlinebufFunc* = proc (a2: Cstring, a3: Cint): Cint{.cdecl.}

# `Generic' function pointer typedefs 

type 
  Tintfunc* = proc (a2: Cint): Cint{.cdecl.}
  Tivoidfunc* = proc (): Cint{.cdecl.}
  Ticpfunc* = proc (a2: Cstring): Cint{.cdecl.}
  Ticppfunc* = proc (a2: CstringArray): Cint{.cdecl.}
  Tvoidfunc* = proc (){.cdecl.}
  Tvintfunc* = proc (a2: Cint){.cdecl.}
  Tvcpfunc* = proc (a2: Cstring){.cdecl.}
  Tvcppfunc* = proc (a2: CstringArray){.cdecl.}
  Tcpvfunc* = proc (): Cstring{.cdecl.}
  Tcpifunc* = proc (a2: Cint): Cstring{.cdecl.}
  Tcpcpfunc* = proc (a2: Cstring): Cstring{.cdecl.}
  Tcpcppfunc* = proc (a2: CstringArray): Cstring{.cdecl.}
