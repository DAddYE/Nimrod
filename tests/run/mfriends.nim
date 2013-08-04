
type
  TMyObj = object 
    x: Int
    
proc gen*[T](): T = 
  var d: TMyObj
  # access private field here
  d.x = 3
  result = d.x

