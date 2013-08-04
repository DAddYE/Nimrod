discard """
  file: "tarray.nim"
  output: "10012"
"""
# simple check for one dimensional arrays

type
  TMyArray = Array[0..2, Int]
  TMyRecord = tuple[x, y: Int]

proc sum(a: TMyarray): Int =
  result = 0
  var i = 0
  while i < len(a):
    inc(result, a[i])
    inc(i)

proc sum(a: Openarray[Int]): Int =
  result = 0
  var i = 0
  while i < len(a):
    inc(result, a[i])
    inc(i)

proc getPos(r: TMyRecord): Int =
  result = r.x + r.y

write(stdout, sum([1, 2, 3, 4]))
write(stdout, sum([]))
write(stdout, getPos( (x: 5, y: 7) ))
#OUT 10012


