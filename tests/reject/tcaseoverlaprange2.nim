discard """
  line: 13
  errormsg: "duplicate case label"
"""




proc checkDuplicates(myval: Int32): Bool = 
  case myval
  of 0x7B:
    echo "this should not compile"
  of 0x78 .. 0x7D:
    result = true
  else:
    nil

echo checkDuplicates(0x7B)
