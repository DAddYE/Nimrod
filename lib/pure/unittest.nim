#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Nimrod Contributors
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## :Author: Zahary Karadjov
##
## This module implements the standard unit testing facilities such as
## suites, fixtures and test cases as well as facilities for combinatorial 
## and randomzied test case generation (not yet available) 
## and object mocking (not yet available)
##
## It is loosely based on C++'s boost.test and Haskell's QuickTest

import
  macros

when defined(stdout):
  import os

when not defined(ECMAScript):
  import terminal

type
  TTestStatus* = enum OK, FAILED
  TOutputLevel* = enum PRINT_ALL, PRINT_FAILURES, PRINT_NONE

var 
  # XXX: These better be thread-local
  abortOnError*: Bool
  outputLevel*: TOutputLevel
  colorOutput*: Bool
  
  checkpoints: Seq[String] = @[]

template testSetupIMPL*: Stmt {.immediate, dirty.} = nil
template testTeardownIMPL*: Stmt {.immediate, dirty.} = nil

proc shouldRun(testName: String): Bool =
  result = true

template suite*(name: Expr, body: Stmt): Stmt {.immediate, dirty.} =
  block:
    template setup*(setupBody: Stmt): Stmt {.immediate, dirty.} =
      template TestSetupIMPL: stmt {.immediate, dirty.} = setupBody

    template teardown*(teardownBody: Stmt): Stmt {.immediate, dirty.} =
      template TestTeardownIMPL: stmt {.immediate, dirty.} = teardownBody

    body

proc testDone(name: String, s: TTestStatus) =
  if s == Failed:
    programResult += 1

  if outputLevel != PrintNone and (outputLevel == PrintAll or s == Failed):
    template rawPrint() = echo("[", $s, "] ", name, "\n")
    when not defined(ECMAScript):
      if colorOutput and not defined(ECMAScript):
        var color = (if s == Ok: fgGreen else: fgRed)
        styledEcho styleBright, color, "[", $s, "] ", fgWhite, name, "\n"
      else:
        rawPrint()
    else:
      rawPrint()
  
template test*(name: Expr, body: Stmt): Stmt {.immediate, dirty.} =
  bind shouldRun, checkpoints, testDone

  if shouldRun(name):
    checkpoints = @[]
    var testStatusIMPL {.inject.} = Ok
    
    try:
      TestSetupIMPL()
      body

    except:
      checkpoint("Unhandled exception: " & getCurrentExceptionMsg())
      fail()

    finally:
      TestTeardownIMPL()
      testDone name, testStatusIMPL

proc checkpoint*(msg: String) =
  checkpoints.add(msg)
  # TODO: add support for something like SCOPED_TRACE from Google Test

template fail* =
  bind checkpoints
  for msg in items(checkpoints):
    echo msg

  when not defined(ECMAScript):
    if abortOnError: quit(1)
  
  testStatusIMPL = Failed
  checkpoints = @[]

macro check*(conditions: Stmt): Stmt {.immediate.} =
  let checked = callsite()[1]
  
  var
    argsAsgns = newNimNode(nnkStmtList)
    argsPrintOuts = newNimNode(nnkStmtList)
    counter = 0

  template asgn(a, value: Expr): Stmt =
    let a = value
  
  template print(name, value: Expr): Stmt =
    when compiles(string($value)):
      checkpoint(name & " was " & $value)

  proc inspectArgs(exp: PNimrodNode) =
    for i in 1 .. <exp.len:
      if exp[i].kind notin nnkLiterals:
        inc counter
        var arg = newIdentNode(":p" & ($counter))
        var argStr = exp[i].toStrLit
        if exp[i].kind in nnkCallKinds: inspectArgs(exp[i])
        argsAsgns.add getAst(asgn(arg, exp[i]))
        argsPrintOuts.add getAst(print(argStr, arg))
        exp[i] = arg

  case checked.kind
  of nnkCallKinds:
    template rewrite(call, lineInfoLit: Expr, callLit: String,
                     argAssgs, argPrintOuts: Stmt): Stmt =
      block:
        argAssgs
        if not call:
          checkpoint(lineInfoLit & ": Check failed: " & callLit)
          argPrintOuts
          fail()
      
    var checkedStr = checked.toStrLit
    inspectArgs(checked)
    result = getAst(rewrite(checked, checked.lineinfo, checkedStr, argsAsgns, argsPrintOuts))

  of nnkStmtList:
    result = newNimNode(nnkStmtList)
    for i in countup(0, checked.len - 1):
      result.add(newCall(!"check", checked[i]))

  else:
    template rewrite(Exp, lineInfoLit: Expr, expLit: String): Stmt =
      if not exp:
        checkpoint(lineInfoLit & ": Check failed: " & expLit)
        fail()

    result = getAst(rewrite(checked, checked.lineinfo, checked.toStrLit))

template require*(conditions: Stmt): Stmt {.immediate, dirty.} =
  block:
    const AbortOnError {.inject.} = true
    check conditions

macro expect*(exceptions: Varargs[Expr], body: Stmt): Stmt {.immediate.} =
  let exp = callsite()
  template expectBody(errorTypes, lineInfoLit: Expr,
                      body: Stmt): PNimrodNode {.dirty.} =
    try:
      body
      checkpoint(lineInfoLit & ": Expect Failed, no exception was thrown.")
      fail()
    except errorTypes:
      nil

  var body = exp[exp.len - 1]

  var errorTypes = newNimNode(nnkBracket)
  for i in countup(1, exp.len - 2):
    errorTypes.add(exp[i])

  result = getAst(expectBody(errorTypes, exp.lineinfo, body))


when defined(stdout):
  ## Reading settings
  var envOutLvl = os.getEnv("NIMTEST_OUTPUT_LVL").String

  abortOnError = existsEnv("NIMTEST_ABORT_ON_ERROR")
  colorOutput  = not existsEnv("NIMTEST_NO_COLOR")

else:
  var envOutLvl = "" # TODO
  ColorOutput  = false

if envOutLvl.len > 0:
  for opt in countup(low(TOutputLevel), high(TOutputLevel)):
    if $opt == envOutLvl:
      outputLevel = opt
      break
