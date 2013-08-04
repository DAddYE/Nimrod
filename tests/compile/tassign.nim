# Test the assignment operator for complex types which need RTTI

type
  TRec = object
    x, y: Int
    s: String
    seq: Seq[String]
    arr: Seq[Seq[Array[0..3, String]]]
  TRecSeq = Seq[TRec]

proc test() =
  var
    a, b: TRec
  a.x = 1
  a.y = 2
  a.s = "Hallo!"
  a.seq = @["abc", "def", "ghi", "jkl"]
  a.arr = @[]
  setLen(a.arr, 4)
  a.arr[0] = @[]
  a.arr[1] = @[]

  b = a # perform a deep copy here!
  b.seq = @["xyz", "huch", "was", "soll"]
  writeln(stdout, len(a.seq))
  writeln(stdout, a.seq[3])
  writeln(stdout, len(b.seq))
  writeln(stdout, b.seq[3])
  writeln(stdout, b.y)

test()
