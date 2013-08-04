
proc printf(frmt: Cstring) {.varargs, header: "<stdio.h>", cdecl.}

var x = 0
inc x
printf("hi %ld\n", x+4777)
