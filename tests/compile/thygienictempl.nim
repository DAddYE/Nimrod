    
var
  e = "abc"
    
raise newException(Eio, e & "ha!")

template t() = echo(foo)

var foo = 12
t()


template testIn(a, b, c: Expr): Bool {.immediate, dirty.} =
  var result {.gensym.}: bool = false
  false

when isMainModule:
  assert test_in(ret2, "test", str_val)
