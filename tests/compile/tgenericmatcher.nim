discard """
  disabled: false
"""

type
  TMatcherKind = enum
    mkTerminal, mkSequence, mkAlternation, mkRepeat
  TMatcher[T] = object
    case kind: TMatcherKind
    of mkTerminal:
      value: T
    of mkSequence, mkAlternation:
      matchers: Seq[TMatcher[T]]
    of mkRepeat:
      matcher: PMatcher[T]
      min, max: Int
  PMatcher[T] = ref TMatcher[T]

var 
  m: PMatcher[Int]


