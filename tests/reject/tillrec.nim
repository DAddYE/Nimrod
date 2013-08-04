discard """
  file: "tillrec.nim"
  line: 13
  errormsg: "illegal recursion in type \'TIllegal\'"
"""
# test illegal recursive types

type
  TLegal {.final.} = object
    x: Int
    kids: Seq[TLegal]

  TIllegal {.final.} = object  #ERROR_MSG illegal recursion in type 'TIllegal'
    y: Int
    x: Array[0..3, TIllegal]


