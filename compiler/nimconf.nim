#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# This module handles the reading of the config file.

import 
  llstream, nversion, commands, os, strutils, msgs, platform, condsyms, lexer, 
  options, idents, wordrecg

# ---------------- configuration file parser -----------------------------
# we use Nimrod's scanner here to safe space and work

proc ppGetTok(L: var TLexer, tok: var TToken) = 
  # simple filter
  rawGetTok(L, tok)
  while tok.tokType in {tkComment}: rawGetTok(L, tok)
  
proc parseExpr(L: var TLexer, tok: var TToken): Bool
proc parseAtom(L: var TLexer, tok: var TToken): Bool = 
  if tok.tokType == tkParLe: 
    ppGetTok(L, tok)
    result = parseExpr(L, tok)
    if tok.tokType == tkParRi: ppGetTok(L, tok)
    else: lexMessage(L, errTokenExpected, "\')\'")
  elif tok.ident.id == ord(wNot): 
    ppGetTok(L, tok)
    result = not parseAtom(L, tok)
  else:
    result = isDefined(tok.ident)
    ppGetTok(L, tok)

proc parseAndExpr(L: var TLexer, tok: var TToken): Bool = 
  result = parseAtom(L, tok)
  while tok.ident.id == ord(wAnd): 
    ppGetTok(L, tok)          # skip "and"
    var b = parseAtom(L, tok)
    result = result and b

proc parseExpr(L: var TLexer, tok: var TToken): bool = 
  result = parseAndExpr(L, tok)
  while tok.ident.id == ord(wOr): 
    ppGetTok(L, tok)          # skip "or"
    var b = parseAndExpr(L, tok)
    result = result or b

proc evalppIf(L: var TLexer, tok: var TToken): Bool = 
  ppGetTok(L, tok)            # skip 'if' or 'elif'
  result = parseExpr(L, tok)
  if tok.tokType == tkColon: ppGetTok(L, tok)
  else: lexMessage(L, errTokenExpected, "\':\'")
  
var condStack: Seq[Bool] = @[]

proc doEnd(L: var TLexer, tok: var TToken) = 
  if high(condStack) < 0: lexMessage(L, errTokenExpected, "@if")
  ppGetTok(L, tok)            # skip 'end'
  setLen(condStack, high(condStack))

type 
  TJumpDest = enum 
    jdEndif, jdElseEndif

proc jumpToDirective(L: var TLexer, tok: var TToken, dest: TJumpDest)
proc doElse(L: var TLexer, tok: var TToken) = 
  if high(condStack) < 0: lexMessage(L, errTokenExpected, "@if")
  ppGetTok(L, tok)
  if tok.tokType == tkColon: ppGetTok(L, tok)
  if condStack[high(condStack)]: jumpToDirective(L, tok, jdEndif)
  
proc doElif(L: var TLexer, tok: var TToken) = 
  if high(condStack) < 0: lexMessage(L, errTokenExpected, "@if")
  var res = evalppIf(L, tok)
  if condStack[high(condStack)] or not res: jumpToDirective(L, tok, jdElseEndif)
  else: condStack[high(condStack)] = true
  
proc jumpToDirective(L: var TLexer, tok: var TToken, dest: TJumpDest) = 
  var nestedIfs = 0
  while true: 
    if (tok.ident != nil) and (tok.ident.s == "@"): 
      ppGetTok(L, tok)
      case whichKeyword(tok.ident)
      of wIf: 
        inc(nestedIfs)
      of wElse: 
        if (dest == jdElseEndif) and (nestedIfs == 0): 
          doElse(L, tok)
          break 
      of wElif: 
        if (dest == jdElseEndif) and (nestedIfs == 0): 
          doElif(L, tok)
          break 
      of wEnd: 
        if nestedIfs == 0: 
          doEnd(L, tok)
          break 
        if nestedIfs > 0: dec(nestedIfs)
      else: 
        nil
      ppGetTok(L, tok)
    elif tok.tokType == tkEof: 
      lexMessage(L, errTokenExpected, "@end")
    else: 
      ppGetTok(L, tok)
  
proc parseDirective(L: var TLexer, tok: var TToken) = 
  ppGetTok(L, tok)            # skip @
  case whichKeyword(tok.ident)
  of wIf:
    setLen(condStack, len(condStack) + 1)
    var res = evalppIf(L, tok)
    condStack[high(condStack)] = res
    if not res: jumpToDirective(L, tok, jdElseEndif)
  of wElif: doElif(L, tok)
  of wElse: doElse(L, tok)
  of wEnd: doEnd(L, tok)
  of wWrite: 
    ppGetTok(L, tok)
    msgs.MsgWriteln(tokToStr(tok))
    ppGetTok(L, tok)
  else:
    case tok.ident.s.normalize
    of "putenv": 
      ppGetTok(L, tok)
      var key = tokToStr(tok)
      ppGetTok(L, tok)
      os.putEnv(key, tokToStr(tok))
      ppGetTok(L, tok)
    of "prependenv": 
      ppGetTok(L, tok)
      var key = tokToStr(tok)
      ppGetTok(L, tok)
      os.putEnv(key, tokToStr(tok) & os.getenv(key))
      ppGetTok(L, tok)
    of "appendenv":
      ppGetTok(L, tok)
      var key = tokToStr(tok)
      ppGetTok(L, tok)
      os.putEnv(key, os.getenv(key) & tokToStr(tok))
      ppGetTok(L, tok)
    else: lexMessage(L, errInvalidDirectiveX, tokToStr(tok))
  
proc confTok(L: var TLexer, tok: var TToken) = 
  ppGetTok(L, tok)
  while tok.ident != nil and tok.ident.s == "@": 
    parseDirective(L, tok)    # else: give the token to the parser
  
proc checkSymbol(L: TLexer, tok: TToken) = 
  if tok.tokType notin {tkSymbol..pred(tkIntLit), tkStrLit..tkTripleStrLit}: 
    lexMessage(L, errIdentifierExpected, tokToStr(tok))
  
proc parseAssignment(L: var TLexer, tok: var TToken) = 
  if tok.ident.id == getIdent("-").id or tok.ident.id == getIdent("--").id:
    confTok(L, tok)           # skip unnecessary prefix
  var info = getLineInfo(L, tok) # safe for later in case of an error
  checkSymbol(L, tok)
  var s = tokToStr(tok)
  confTok(L, tok)             # skip symbol
  var val = ""
  while tok.tokType == tkDot: 
    add(s, '.')
    confTok(L, tok)
    checkSymbol(L, tok)
    add(s, tokToStr(tok))
    confTok(L, tok)
  if tok.tokType == tkBracketLe: 
    # BUGFIX: val, not s!
    # BUGFIX: do not copy '['!
    confTok(L, tok)
    checkSymbol(L, tok)
    add(val, tokToStr(tok))
    confTok(L, tok)
    if tok.tokType == tkBracketRi: confTok(L, tok)
    else: lexMessage(L, errTokenExpected, "']'")
    add(val, ']')
  if tok.tokType in {tkColon, tkEquals}: 
    if len(val) > 0: add(val, ':')
    confTok(L, tok)           # skip ':' or '='
    checkSymbol(L, tok)
    add(val, tokToStr(tok))
    confTok(L, tok)           # skip symbol
    while tok.ident != nil and tok.ident.id == getIdent("&").id:
      confTok(L, tok)
      checkSymbol(L, tok)
      add(val, tokToStr(tok))
      confTok(L, tok)
  processSwitch(s, val, passPP, info)

proc readConfigFile(filename: String) =
  var
    L: TLexer
    tok: TToken
    stream: PLLStream
  stream = lLStreamOpen(filename, fmRead)
  if stream != nil:
    initToken(tok)
    openLexer(L, filename, stream)
    tok.tokType = tkEof       # to avoid a pointless warning
    confTok(L, tok)           # read in the first token
    while tok.tokType != tkEof: parseAssignment(L, tok)
    if len(condStack) > 0: lexMessage(L, errTokenExpected, "@end")
    closeLexer(L)
    if gVerbosity >= 1: rawMessage(hintConf, filename)

proc getUserConfigPath(filename: String): String =
  result = joinPath(getConfigDir(), filename)

proc getSystemConfigPath(filename: String): String =
  # try standard configuration file (installation did not distribute files
  # the UNIX way)
  result = joinPath([getPrefixDir(), "config", filename])
  if not existsFile(result): result = "/etc/" & filename

proc loadConfigs*(cfg: String) =
  # set default value (can be overwritten):
  if libpath == "": 
    # choose default libpath:
    var prefix = getPrefixDir()
    if prefix == "/usr": libpath = "/usr/lib/nimrod"
    elif prefix == "/usr/local": libpath = "/usr/local/lib/nimrod"
    else: libpath = joinPath(prefix, "lib")

  if optSkipConfigFile notin gGlobalOptions:
    readConfigFile(getSystemConfigPath(cfg))

  if optSkipUserConfigFile notin gGlobalOptions:
    readConfigFile(getUserConfigPath(cfg))

  var pd = if gProjectPath.len > 0: gProjectPath else: getCurrentDir()
  if optSkipParentConfigFiles notin gGlobalOptions:
    for dir in parentDirs(pd, fromRoot=true, inclusive=false):
      readConfigFile(dir / cfg)
  
  if optSkipProjConfigFile notin gGlobalOptions:
    readConfigFile(pd / cfg)
    
    if gProjectName.len != 0:
      var conffile = changeFileExt(gProjectFull, "cfg")
      if conffile != pd / cfg and existsFile(conffile):
        readConfigFile(conffile)
        rawMessage(warnConfigDeprecated, conffile)
      
      # new project wide config file:
      readConfigFile(changeFileExt(gProjectFull, "nimrod.cfg"))
 
