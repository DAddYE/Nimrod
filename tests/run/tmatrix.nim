discard """
  file: "tmatrix.nim"
  output: "111"
"""
# Test overloading of [] with multiple indices

type
  TMatrix* = object
    data: Seq[Float]
    fWidth, fHeight: Int

template `|`(x, y: Int): Expr = y * m.fWidth + x

proc createMatrix*(width, height: Int): TMatrix = 
  result.fWidth = width
  result.fHeight = height
  newSeq(result.data, width*height)

proc width*(m: TMatrix): Int {.inline.} = return m.fWidth
proc height*(m: TMatrix): Int {.inline.} = return m.fHeight

proc `[]`*(m: TMatrix, x, y: Int): Float {.inline.} =
  result = m.data[x|y]

proc `[]=`*(m: var TMatrix, x, y: Int, val: Float) {.inline.} =
  m.data[x|y] = val
  
proc `-|`*(m: TMatrix): TMatrix =
  ## transposes a matrix
  result = createMatrix(m.height, m.width)
  for x in 0..m.width-1:
    for y in 0..m.height-1: result[y,x] = m[x,y]

#m.row(0, 2) # select row
#m.col(0, 89) # select column

const
  w = 3
  h = 20

var m = createMatrix(w, h)
for i in 0..w-1:
  m[i, i] = 1.0

for i in 0..w-1:
  stdout.write(m[i,i]) #OUT 111


