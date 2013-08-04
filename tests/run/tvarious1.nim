discard """
  file: "tlenopenarray.nim"
  output: '''1
0'''
"""

echo len([1_000_000]) #OUT 1

type 
  TArray = Array[0..3, Int]
  TVector = distinct Array[0..3, Int]
proc `[]`(v: TVector; idx: Int): Int = TArray(v)[idx]
var v: TVector
echo v[2]
