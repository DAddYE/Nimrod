discard """
  line: 23
  errormsg: "type mismatch"
"""

type
  TObj = object {.pure, inheritable.}
  TObjB = object of TObj
    a, b, c: String
    fn: proc (): Int {.tags: [FReadIO].}
  
  Eio2 = ref object of Eio

proc q() {.tags: [Fio].} =
  nil
  
proc raiser(): Int =
  writeln stdout, "arg"
  if true:
    q()

var o: TObjB
o.fn = raiser

