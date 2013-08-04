discard """
  file: "tarraycons.nim"
  output: "6"
"""

type
  TEnum = enum
    eA, eB, eC, eD, eE, eF
    
const
  myMapping: Array[TEnum, Array[0..1, Int]] = [
    eA: [1, 2],
    eB: [3, 4],
    [5, 6],
    eD: [0: 8, 1: 9],
    eE: [0: 8, 9],
    eF: [2, 1: 9]
  ]

echo myMapping[eC][1]



