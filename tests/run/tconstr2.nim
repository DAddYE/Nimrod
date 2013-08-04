discard """
  file: "tconstr2.nim"
  output: "69"
"""
# Test array, record constructors

type
  TComplexRecord = tuple[
    s: String,
    x, y: Int,
    z: Float,
    chars: Set[Char]]

const
  things: Array [0..1, TComplexRecord] = [
    (s: "hi", x: 69, y: 45, z: 0.0, chars: {'a', 'b', 'c'}),
    (s: "hi", x: 69, y: 45, z: 1.0, chars: {})] 
  otherThings = [  # the same
    (s: "hi", x: 69, y: 45, z: 0.0, chars: {'a', 'b', 'c'}),
    (s: "hi", x: 69, y: 45, z: 1.0, chars: {'a'})]

write(stdout, things[0].x)
#OUT 69



