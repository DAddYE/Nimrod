discard """
  file: "tvarres1.nim"
  line: 12
  errormsg: "address of 'bla' may not escape its stack frame"
"""

var
  g = 5

proc p(): var Int = 
  var bla: Int
  result = bla
  
p() = 45

echo g

