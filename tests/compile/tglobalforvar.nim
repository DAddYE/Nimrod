
var funcs: Seq[proc (): Int {.nimcall.}] = @[]
for i in 0..10:
  funcs.add((proc (): Int = return i * i))

echo(funcs[3]())

