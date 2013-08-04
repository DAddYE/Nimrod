
type
  TMyObj = TYourObj
  TYourObj = object of TObject
    x, y: Int
  
proc init: TYourObj =
  result.x = 0
  result.y = -1
  
proc f(x: var TYourObj) =
  nil
  
var m: TMyObj = init()
f(m)
