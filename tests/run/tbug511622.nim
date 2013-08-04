discard """
  file: "tbug511622.nim"
  output: "3"
"""
import StrUtils, Math

proc fibonacciA(n: Int): Int64 =
  var fn = Float64(n)
  var p: Float64 = (1.0 + sqrt(5.0)) / 2.0
  var q: Float64 = 1.0 / p
  return Int64((pow(p, fn) + pow(q, fn)) / sqrt(5.0))

echo fibonacciA(4) #OUT 3



