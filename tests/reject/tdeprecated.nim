discard """
  line: 9
  errormsg: "'a' is deprecated [Deprecated]"
"""

var
  a {.deprecated.}: Array[0..11, Int]
  
a[8] = 1


