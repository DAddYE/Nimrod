discard """
  line: 18
  errormsg: "type mismatch"
"""

type
  TObj = object {.pure, inheritable.}
  TObjB = object of TObj
    a, b, c: String
    fn: proc (): Int {.tags: [].}
  
  Eio2 = ref object of Eio
  
proc raiser(): Int {.tags: [TObj, FWriteIO].} =
  writeln stdout, "arg"

var o: TObjB
o.fn = raiser

