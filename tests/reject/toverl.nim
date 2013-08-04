discard """
  file: "toverl.nim"
  line: 11
  errormsg: "redefinition of \'TNone\'"
"""
# Test for overloading

type
  TNone {.exportc: "_NONE", final.} = object

proc tNone(a, b: Int) = nil #ERROR_MSG attempt to redefine 'TNone'


