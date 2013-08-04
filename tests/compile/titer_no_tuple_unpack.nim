
iterator xrange(fromm, to: Int, step = 1): tuple[x, y: Int] =
  var a = fromm
  while a <= to:
    yield (a, a+1)
    inc(a, step)

for a, b in xrange(3, 7):
  echo a, " ", b
  
for tup in xrange(3, 7):
  echo tup

