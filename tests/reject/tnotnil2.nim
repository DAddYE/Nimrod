discard """
  errormsg: "cannot prove 'y' is not nil"
  line:20
"""

import strutils


type
  TObj = object
    x, y: Int

proc q(x: Pointer not nil) =
  nil

proc p() =
  var x: Pointer
  let y = x
  if not y.isNil or y != x:
    q(y)
  else:
    q(y)

p()
