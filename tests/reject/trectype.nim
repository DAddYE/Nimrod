discard """
  errormsg: "internal error: cannot generate C type for: PA"
"""
# Test recursive type descriptions
# (mainly for the C code generator)

type
  Pa = ref TA
  TA = Array [0..2, Pa]

  PRec = ref TRec
  TRec {.final.} = object
    a, b: TA

  P1 = ref T1
  Pb = ref TB
  TB = Array [0..3, P1]
  T1 = Array [0..6, Pb]

var
  x: Pa
new(x)
#ERROR_MSG internal error: cannot generate C type for: PA



