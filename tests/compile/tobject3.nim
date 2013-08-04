type
  TFoo = ref object of TObject
    Data: Int  
  TBar = ref object of TFoo
    nil
  TBar2 = ref object of TBar
    d2: Int

template super(self: TBar): TFoo = self

template super(self: TBar2): TBar = self

proc foo(self: TFoo) =
  echo "TFoo"

#proc Foo(self: TBar) =
#  echo "TBar"
#  Foo(super(self))
# works when this code is uncommented

proc foo(self: TBar2) =
  echo "TBar2"
  foo(super(self))

var b: TBar2
new(b)

foo(b)
