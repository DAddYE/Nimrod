discard """
  file: "titer3.nim"
  output: "1231"
"""

iterator count13: Int =
  yield 1
  yield 2
  yield 3

for x in count13():
  write(stdout, $x)

# yield inside an iterator, but not in a loop:
iterator iter1(a: Openarray[Int]): Int =
  yield a[0]

var x = [[1, 2, 3], [4, 5, 6]]
for y in iter1(x[0]): write(stdout, $y)

#OUT 1231

