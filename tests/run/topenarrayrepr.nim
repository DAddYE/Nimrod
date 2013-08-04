discard """
  file: "topenarrayrepr.nim"
  output: "5 - [1]"
"""
type
  TProc = proc (n: Int, m: Openarray[Int64]) {.nimcall.}

proc foo(x: Int, P: TProc) =
  p(x, [ 1'i64 ])

proc bar(n: Int, m: Openarray[Int64]) =
  echo($n & " - " & repr(m))

foo(5, bar) #OUT 5 - [1]



