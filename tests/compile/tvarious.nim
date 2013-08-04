# Test various aspects

var x = (x: 42, y: (a: 8, z: 10))
echo x.y

import
  mvarious

type
  Pa = ref TA
  Pb = ref TB

  TB = object
    a: Pa

  TA = object
    b: TB
    x: Int

proc getPA(): Pa =
  var
    b: Bool
  b = not false
  return nil

# bug #501
proc f(): Int = result

var
  global: Int

var
  s: String
  i: Int
  r: TA

r.b.a.x = 0
global = global + 1
exportme()
write(stdout, "Hallo wie heißt du? ")
write(stdout, getPA().x)
s = readLine(stdin)
i = 0
while i < s.len:
  if s[i] == 'c': write(stdout, "'c' in deinem Namen gefunden\n")
  i = i + 1

write(stdout, "Du heißt " & s)

# bug #544

type Bar [T; I:range] = Array[I, T]
proc foo*[T; I:range](a, b: Bar[T, I]): Bar[T, I] =
  when len(a) != 3: 
    # Error: constant expression expected
    {.fatal:"Dimensions have to be 3".}
  #...
block:
  var a, b: Bar[Int, 0..2]
  discard foo(a, b)
