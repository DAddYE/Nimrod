template foo(a: Int, b: String) = nil
foo(1, "test")

proc bar(a: Int, b: String) = nil
bar(1, "test")

template foo(a: Int, b: String) = bar(a, b)
foo(1, "test")

block:
  proc bar(a: Int, b: String) = nil
  template foo(a: Int, b: String) = nil
  foo(1, "test")
  bar(1, "test")
  
proc baz =
  proc foo(a: Int, b: String) = nil
  proc foo(b: String) =
    template bar(a: Int, b: String) = nil
    bar(1, "test")
    
  foo("test")

  block:
    proc foo(b: String) = nil
    foo("test")
    foo(1, "test")

baz()
