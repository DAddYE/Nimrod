discard """
  output: "5.0000000000000000e+00"
"""

type
  TMatrixNM*[M, N, T] = object 
    aij*: T
  TVectorN*[N, T] = TMatrixNM[Range[0..0], N, T]
  TVector3*[T] = TVectorN[Range[0..2], T]

proc coeffRef*[M, N, T] (matrix: var TMatrixNM[M, N, T], a: M, b: N): var T =
  return matrix.aij

proc coeffRef*[N, T] (vector: var TVectorN[N, T], i: N): var T = vector.aij

var 
  testVar: TVector3[Float]

testVar.aij = 2.0
testVar.coeffRef(1) = 5.0

echo testVar.aij
