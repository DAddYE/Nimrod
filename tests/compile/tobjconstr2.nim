type TFoo{.exportc.} = object
 x:Int

var s{.exportc.}: Seq[TFoo] = @[]

s.add TFoo(x: 42)

echo s[0].x
