discard """
  line: 19
  errormsg: "can raise an unlisted exception: ref EIO"
"""

type
  TObj = object {.pure, inheritable.}
  TObjB = object of TObj
    a, b, c: String
  
  Eio2 = ref object of Eio
  
proc forw: Int {.raises: [].}

proc lier(): Int {.raises: [Eio].} =
  writeln stdout, "arg"

proc forw: int =
  raise newException(Eio, "arg")

