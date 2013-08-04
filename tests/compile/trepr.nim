# test the new "repr" built-in proc

type
  TEnum = enum
    en1, en2, en3, en4, en5, en6

  TPoint {.final.} = object
    x, y, z: Int
    s: Array [0..1, String]
    e: TEnum

var
  p: TPoint
  q: ref TPoint
  s: Seq[ref TPoint]

p.x = 0
p.y = 13
p.z = 45
p.s[0] = "abc"
p.s[1] = "xyz"
p.e = en6

new(q)
q[] = p

s = @[q, q, q, q]

writeln(stdout, repr(p))
writeln(stdout, repr(q))
writeln(stdout, repr(s))
writeln(stdout, repr(en4))
