discard """
  file: "tconstr1.nim"
  line: 25
  errormsg: "type mismatch"
"""
# Test array, record constructors

type
  TComplexRecord = tuple[
    s: String,
    x, y: Int,
    z: Float,
    chars: Set[Char]]

proc testSem =
  var
    things: Array [0..1, TComplexRecord] = [
      (s: "hi", x: 69, y: 45, z: 0.0, chars: {'a', 'b', 'c'}),
      (s: "hi", x: 69, y: 45, z: 1.0, chars: {'a', 'b', 'c'})]
  write(stdout, things[0].x)

const
  things: Array [0..1, TComplexRecord] = [
    (s: "hi", x: 69, y: 45, z: 0.0, chars: {'a', 'b', 'c'}),
    (s: "hi", x: 69, y: 45, z: 1.0)] #ERROR
  otherThings = [  # the same
    (s: "hi", x: 69, y: 45, z: 0.0, chars: {'a', 'b', 'c'}),
    (s: "hi", x: 69, y: 45, z: 1.0, chars: {'a'})]


