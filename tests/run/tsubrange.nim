discard """
  file: "tsubrange.nim"
  outputsub: "value out of range: 50 [EOutOfRange]"
  exitcode: "1"
"""

type
  TRange = range[0..40]

proc p(r: TRange) =
  nil

var
  r: TRange
  y = 50
r = y

#p y

