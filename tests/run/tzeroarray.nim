discard """
  output: done
"""

for i in 0 .. 1:
  var a: Array[0..4, Int]
  if a[0] != 0: quit "bug"
  a[0] = 6

proc main =
  for i in 0 .. 1:
    var a: Array[0..4, Int]
    if a[0] != 0: quit "bug"
    a[0] = 6

main()
echo "done"

