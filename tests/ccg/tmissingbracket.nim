discard """
  output: '''Subobject test called
5'''
"""

type
  TClassOfTCustomObject {.pure, inheritable.} = object
    base* : ptr TClassOfTCustomObject
    className* : String
  TClassOfTobj = object of TClassOfTCustomObject
    nil
  TCustomObject = ref object {.inheritable.}
    class* : ptr TClassOfTCustomObject
  TObj = ref object of TCustomObject
    data: Int

var classOfTObj: TClassOfTObj

proc initClassOfTObj() =
  classOfTObj.base = nil
  classOfTObj.className = "TObj"

initClassOfTObj()

proc initialize*(self: TObj) =
  self.class = addr classOfTObj
  # this generates wrong C code: && instead of &

proc newInstance(T: TypeDesc): T =
  mixin initialize
  new(result)
  initialize(result)

var o = TObj.newInstance()

type
    TestObj* = object of TObject
        t:Int
    SubObject* = object of TestObj

method test*(t:var TestObj) =
    echo "test called"

method test*(t:var SubObject) =
    echo "Subobject test called"
    t.t= 5

var a: SubObject

a.test()
echo a.t

