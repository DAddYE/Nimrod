discard """
  output: "XXXXX01234"
"""

iterator modPairs(a: var Array[0..4,String]): tuple[key: Int, val: var String] =
  for i in 0..a.high:
    yield (i, a[i])

iterator modItems*[T](a: var Array[0..4,T]): var T =
  for i in 0..a.high:
    yield a[i]

var
  arr = ["a", "b", "c", "d", "e"]

for a in modItems(arr):
  a = "X"

for a in items(arr):
  stdout.write(a)

for i, a in modPairs(arr):
  a = $i

for a in items(arr):
  stdout.write(a)

echo ""

