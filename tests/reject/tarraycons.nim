discard """
  file: "tarraycons.nim"
  line: 14
  errormsg: "invalid order in array constructor"
"""

type
  TEnum = enum
    eA, eB, eC, eD, eE, eF
    
const
  myMapping: Array[TEnum, Array[0..1, Int]] = [
    eA: [1, 2],
    eC: [3, 4],
    eB: [5, 6],
    eD: [0: 8, 1: 9],
    eE: [0: 8, 9],
    eF: [2, 1: 9]
  ]

echo myMapping[eC][1]



