discard """
  errormsg: "'y' is provably nil"
  line:38
"""

import strutils


type
  TObj = object
    x, y: Int

type
  Superstring = String not nil


proc q(s: Superstring) =
  echo s

proc p2() =
  var  a: String = "I am not nil" 
  q(a) # but this should and does not

p2()

proc q(x: Pointer not nil) =
  nil

proc p() =
  var x: Pointer
  if not x.isNil:
    q(x)
  
  let y = x
  if not y.isNil:
    q(y)
  else:
    q(y)

p()
