discard """
  output: "right proc called"
"""

type
  TMatrixNM*[M, N, T] = object 
    aij*: Array[M, Array[N, T]]
  TMatrix2x2*[T] = TMatrixNM[Range[0..1], Range[0..1], T]
  TMatrix3x3*[T] = TMatrixNM[Range[0..2], Range[0..2], T]

proc test*[T] (matrix: TMatrix2x2[T]) =
  echo "wrong proc called"

proc test*[T] (matrix: TMatrix3x3[T]) =
  echo "right proc called"  

var matrix: TMatrix3x3[Float]

matrix.test
