# Test the alias analysis

type
  TAnalysisResult* = enum
    arNo, arMaybe, arYes

proc isPartOf*[S, T](a: S, b: T): TAnalysisResult {.
  magic: "IsPartOf", noSideEffect.}
  ## not yet exported properly. 

template compileTimeAssert(cond: Expr) =
  when not cond:
    {.compile: "is false: " & astToStr(cond).}

template `<|` (a, b: Expr) =
  compileTimeAssert isPartOf(a, b) == arYes

template `!<|` (a, b: Expr) =
  compileTimeAssert isPartOf(a, b) == arNo

template `?<|` (a, b: Expr) =
  compileTimeAssert isPartOf(a, b) == arMaybe

type
  TA {.inheritable.} = object
  TC = object of TA
    arr: Array[0..3, Int]
    le, ri: ref TC
    f: String
    c: Char
    se: Seq[TA]

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
  a, b: Int
  x: TC
  
a <| a
a !<| b

discard p(x, x)

