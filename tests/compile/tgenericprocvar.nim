proc foo[T](thing: T) =
    discard thing

var a: proc (thing: Int) {.nimcall.} = foo[int]

