discard """
  msg: "type mismatch: got (array[0..2, float], array[0..1, float])"
"""

proc `+`*[R, T] (v1, v2: Array[R, T]): Array[R, T] =
  for i in low(v1)..high(v1):
    result[i] = v1[i] + v2[i]

var 
  v1: Array[0..2, Float] = [3.0, 1.2, 3.0]
  v2: Array[0..1, Float] = [2.0, 1.0]
  v3 = v1 + v2

