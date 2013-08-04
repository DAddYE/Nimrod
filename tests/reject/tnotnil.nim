discard """
  line: 22
  errormsg: "type mismatch"
"""

type
  PObj = ref TObj not nil
  TObj = object
    x: Int
  
  MyString = String not nil

#var x: PObj = nil

proc p(x: String not nil): Int =
  result = 45

proc q(x: MyString) = nil
proc q2(x: String) = nil

q2(nil)
q(nil)

