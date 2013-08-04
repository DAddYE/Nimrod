const romanNumbers = [
    ("M", 1000), ("D", 500), ("C", 100),
    ("L", 50), ("X", 10), ("V", 5), ("I", 1) ]

var c = 0
for key, val in items(romanNumbers):
  inc(c)
  stdout.write(key & "=" & $val)
  if c < romanNumbers.len: stdout.write(", ") else: echo""
#echo""

proc printBiTuple(t: tuple[k: String, v: Int]): Int =
  stdout.write(t.k & "=" & $t.v & ", ")
  return 0
  

