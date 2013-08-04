
type
  TFoo = object
    data: Array[0..100, Int]
  TSecond = distinct TFoo

proc `[]` (self: var TFoo, x: Int): var Int =
  return self.data[x]

proc `[]=` (self: var TFoo, x, y: Int) =
  # only `[]` returning a 'var T' seems to not work for now :-/
  self.data[x] = y

proc second(self: var TFoo): var TSecond =
  return TSecond(self)

proc `[]`(self: var TSecond, x: Int): var Int =  
  return TFoo(self).data[2*x]

var f: TFoo

for i in 0..f.data.high: f[i] = 2 * i

echo f.second[1]

#echo `second[]`(f,1)
# this is the only way I could use it, but not what I expected

