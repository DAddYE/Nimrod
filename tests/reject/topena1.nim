discard """
  file: "topena1.nim"
  line: 9
  errormsg: "invalid type"
"""
# Tests a special bug

var
  x: ref Openarray[String] #ERROR_MSG invalid type



