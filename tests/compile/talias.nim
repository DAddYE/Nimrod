# Test the alias analysis

type
  TAnalysisResult* = enum
    arNo, arMaybe, arYes

proc isPartOf*[S, T](a: S, b: T): TAnalysisResult {.
  magic: "IsPartOf", noSideEffect.}
  ## not yet exported properly. 

template compileTimeAssert(cond: expr) =
  when not cond:
    {.compile: "is false: " & astToStr(cond).}

template `<|` (a, b: expr) =
  compileTimeAssert isPartOf(a, b) == arYes

template `!<|` (a, b: expr) =
  compileTimeAssert isPartOf(a, b) == arNo

template `?<|` (a, b: expr) =
  compileTimeAssert isPartOf(a, b) == arMaybe

type
  TA = object
  TC = object of TA
    arr: array[0..3, int]
    le, ri: ref TC
    f: string
    c: char
    se: seq[TA]

proc p(param1, param2: TC): TC =
  var
    local: TC
    plocal: ptr TC
    plocal2: ptr TA
    
  local.arr <| local
  local.arr[0] <| local
  local.arr[2] !<| local.arr[1]
  
  plocal2[] ?<| local

  param1 ?<| param2
  
  local.arr[0] !<| param1
  local.arr !<| param1
  local.le[] ?<| param1
  
  param1 !<| local.arr[0]
  param1 !<| local.arr
  param1 ?<| local.le[]
  
  result !<| local
  result <| result

var
  a, b: int
  x: TC
  
a <| a
a !<| b

discard p(x, x)

