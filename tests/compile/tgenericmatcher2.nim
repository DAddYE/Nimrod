
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
      matcher: ref TMatcher[T]
      min, max: Int

var 
  m: ref TMatcher[Int]


