discard """
  output: '''(k: kindA, a: (x: abc, z: [1, 1, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 2, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 3, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 4, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 5, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 6, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 7, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 8, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 9, 3]), empty: ())
(k: kindA, a: (x: abc, z: [1, 10, 3]), empty: ())'''
"""

type
  TArg = object
    x: String
    z: Seq[Int]
  TKind = enum kindXY, kindA
  TEmpty = object
  TDummy = ref object
    case k: TKind
    of kindXY: x, y: Int
    of kindA: 
      a: TArg
      empty: TEmpty

proc `$`[T](s: Seq[T]): String =
  # XXX why is that not in the stdlib?
  result = "["
  for i, x in s:
    if i > 0: result.add(", ")
    result.add($x)
  result.add("]")

proc main() =
  for i in 1..10:
    let d = TDummy(k: kindA, a: TArg(x: "abc", z: @[1,i,3]), empty: TEmpty())
    echo d[]

main()

