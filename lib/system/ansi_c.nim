#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2013 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# This include file contains headers of Ansi C procs
# and definitions of Ansi C types in Nimrod syntax
# All symbols are prefixed with 'c_' to avoid ambiguities

{.push hints:off}

proc cStrcmp(a, b: Cstring): Cint {.header: "<string.h>", 
  noSideEffect, importc: "strcmp".}
proc cMemcmp(a, b: Cstring, size: Int): Cint {.header: "<string.h>", 
  noSideEffect, importc: "memcmp".}
proc cMemcpy(a, b: Cstring, size: Int) {.header: "<string.h>", importc: "memcpy".}
proc cStrlen(a: Cstring): Int {.header: "<string.h>", 
  noSideEffect, importc: "strlen".}
proc cMemset(p: Pointer, value: Cint, size: Int) {.
  header: "<string.h>", importc: "memset".}

type
  CTextFile {.importc: "FILE", header: "<stdio.h>", 
               final, incompleteStruct.} = object
  CBinaryFile {.importc: "FILE", header: "<stdio.h>", 
                 final, incompleteStruct.} = object
  CTextFileStar = ptr CTextFile
  CBinaryFileStar = ptr CBinaryFile

  CJmpBuf {.importc: "jmp_buf", header: "<setjmp.h>".} = object

var
  cStdin {.importc: "stdin", nodecl.}: CTextFileStar
  cStdout {.importc: "stdout", nodecl.}: CTextFileStar
  cStderr {.importc: "stderr", nodecl.}: CTextFileStar

# constants faked as variables:
when not defined(SIGINT):
  var 
    sigint {.importc: "SIGINT", nodecl.}: Cint
    sigsegv {.importc: "SIGSEGV", nodecl.}: Cint
    sigabrt {.importc: "SIGABRT", nodecl.}: Cint
    sigfpe {.importc: "SIGFPE", nodecl.}: Cint
    sigill {.importc: "SIGILL", nodecl.}: Cint

when defined(macosx):
  var
    sigbus {.importc: "SIGBUS", nodecl.}: Cint
      # hopefully this does not lead to new bugs
else:
  var
    SIGBUS {.importc: "SIGSEGV", nodecl.}: cint
      # only Mac OS X has this shit

proc cLongjmp(jmpb: CJmpBuf, retval: Cint) {.
  header: "<setjmp.h>", importc: "longjmp".}
proc cSetjmp(jmpb: var CJmpBuf): Cint {.
  header: "<setjmp.h>", importc: "setjmp".}

proc cSignal(sig: Cint, handler: proc (a: Cint) {.noconv.}) {.
  importc: "signal", header: "<signal.h>".}
proc cRaise(sig: Cint) {.importc: "raise", header: "<signal.h>".}

proc cFputs(c: Cstring, f: CTextFileStar) {.importc: "fputs", 
  header: "<stdio.h>".}
proc cFgets(c: Cstring, n: Int, f: CTextFileStar): Cstring  {.
  importc: "fgets", header: "<stdio.h>".}
proc cFgetc(stream: CTextFileStar): Int {.importc: "fgetc", 
  header: "<stdio.h>".}
proc cUngetc(c: Int, f: CTextFileStar) {.importc: "ungetc", 
  header: "<stdio.h>".}
proc cPutc(c: Char, stream: CTextFileStar) {.importc: "putc", 
  header: "<stdio.h>".}
proc cFprintf(f: CTextFileStar, frmt: Cstring) {.
  importc: "fprintf", header: "<stdio.h>", varargs.}
proc cPrintf(frmt: Cstring) {.
  importc: "printf", header: "<stdio.h>", varargs.}

proc cFopen(filename, mode: Cstring): CTextFileStar {.
  importc: "fopen", header: "<stdio.h>".}
proc cFclose(f: CTextFileStar) {.importc: "fclose", header: "<stdio.h>".}

proc cSprintf(buf, frmt: Cstring) {.header: "<stdio.h>", 
  importc: "sprintf", varargs, noSideEffect.}
  # we use it only in a way that cannot lead to security issues

proc cFread(buf: Pointer, size, n: Int, f: CBinaryFileStar): Int {.
  importc: "fread", header: "<stdio.h>".}
proc cFseek(f: CBinaryFileStar, offset: Clong, whence: Int): Int {.
  importc: "fseek", header: "<stdio.h>".}

proc cFwrite(buf: Pointer, size, n: Int, f: CBinaryFileStar): Int {.
  importc: "fwrite", header: "<stdio.h>".}

proc cExit(errorcode: Cint) {.importc: "exit", header: "<stdlib.h>".}
proc cFerror(stream: CTextFileStar): Bool {.
  importc: "ferror", header: "<stdio.h>".}
proc cFflush(stream: CTextFileStar) {.importc: "fflush", header: "<stdio.h>".}
proc cAbort() {.importc: "abort", header: "<stdlib.h>".}
proc cFeof(stream: CTextFileStar): Bool {.
  importc: "feof", header: "<stdio.h>".}

proc cMalloc(size: Int): Pointer {.importc: "malloc", header: "<stdlib.h>".}
proc cFree(p: Pointer) {.importc: "free", header: "<stdlib.h>".}
proc cRealloc(p: Pointer, newsize: Int): Pointer {.
  importc: "realloc", header: "<stdlib.h>".}

when hostOS != "standalone":
  when not defined(errno):
    var errno {.importc, header: "<errno.h>".}: Cint ## error variable
proc strerror(errnum: Cint): Cstring {.importc, header: "<string.h>".}

proc cRemove(filename: Cstring): Cint {.
  importc: "remove", header: "<stdio.h>".}
proc cRename(oldname, newname: Cstring): Cint {.
  importc: "rename", header: "<stdio.h>".}

proc cSystem(cmd: Cstring): Cint {.importc: "system", header: "<stdlib.h>".}
proc cGetenv(env: Cstring): Cstring {.importc: "getenv", header: "<stdlib.h>".}
proc cPutenv(env: Cstring): Cint {.importc: "putenv", header: "<stdlib.h>".}

{.pop}
