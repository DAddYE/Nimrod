discard """
  line: 11
  file: "tbindtypedesc.nim"
  errormsg: "type mismatch: got (typedesc[float], string)"
"""

proc foo(T: TypeDesc; some: T) =
  echo($some)

foo Int, 4
foo float, "bad"

