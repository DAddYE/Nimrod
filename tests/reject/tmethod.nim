discard """
  file: "tmethod.nim"
  line: 7
  errormsg: "\'method\' needs a parameter that has an object type"
"""

method m(i: Int): Int =
  return 5
