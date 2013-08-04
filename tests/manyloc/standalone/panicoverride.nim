
proc printf(frmt: Cstring) {.varargs, importc, header: "<stdio.h>", cdecl.}
proc exit(code: Int) {.importc, header: "<stdlib.h>", cdecl.}

{.push stack_trace: off, profiler:off.}

proc rawoutput(s: String) =
  printf("%s\n", s)

proc panic(s: String) =
  rawoutput(s)
  exit(1)

# Alternatively we also could implement these 2 here:
#
# template sysFatal(exceptn: typeDesc, message: string)
# template sysFatal(exceptn: typeDesc, message, arg: string)

{.pop.}
