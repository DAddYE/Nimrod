discard """
  file: "tlowhigh.nim"
  output: "10"
"""
# Test the magic low() and high() procs

type
  MyEnum = enum e1, e2, e3, e4, e5

var
  a: Array [myEnum, Int]

for i in low(a) .. high(a):
  a[i] = 0

proc sum(a: Openarray[Int]): Int =
  result = 0
  for i in low(a)..high(a):
    inc(result, a[i])

write(stdout, sum([1, 2, 3, 4]))
#OUT 10


