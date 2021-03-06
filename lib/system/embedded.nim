#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#


# Bare-bones implementation of some things for embedded targets.

proc chckIndx(i, a, b: Int): Int {.inline, compilerproc.}
proc chckRange(i, a, b: Int): Int {.inline, compilerproc.}
proc chckRangeF(x, a, b: Float): Float {.inline, compilerproc.}
proc chckNil(p: Pointer) {.inline, compilerproc.}

proc pushFrame(s: PFrame) {.compilerRtl, inl, exportc: "nimFrame".} = nil
proc popFrame {.compilerRtl, inl.} = nil

proc setFrame(s: PFrame) {.compilerRtl, inl.} = nil
proc pushSafePoint(s: PSafePoint) {.compilerRtl, inl.} = nil
proc popSafePoint {.compilerRtl, inl.} = nil
proc pushCurrentException(e: ref E_Base) {.compilerRtl, inl.} = nil
proc popCurrentException {.compilerRtl, inl.} = nil

# some platforms have native support for stack traces:
const
  nativeStackTraceSupported = false
  hasSomeStackTrace = false

proc quitOrDebug() {.inline.} =
  quit(1)

proc raiseException(e: ref E_Base, ename: Cstring) {.compilerRtl.} =
  sysFatal(ENoExceptionToReraise, "exception handling is not available")

proc reraiseException() {.compilerRtl.} =
  sysFatal(ENoExceptionToReraise, "no exception to reraise")

proc writeStackTrace() = nil

proc setControlCHook(hook: proc () {.noconv.}) = nil
