discard """
  file: "tpos.nim"
  output: "6"
"""
# test this particular function

proc mypos(sub, s: String, start: Int = 0): Int =
  var
    i, j, m, n: Int
  m = sub.len
  n = s.len
  i = start
  j = 0
  if i >= n:
    result = -1
  else:
    while true:
      if s[i] == sub[j]:
        inc(i)
        inc(j)
      else:
        i = i - j + 1
        j = 0
      if (j >= m) or (i >= n): break
    if j >= m:
      result = i - m
    else:
      result = -1

var sub = "hello"
var s = "world hello"
write(stdout, mypos(sub, s))
#OUT 6


