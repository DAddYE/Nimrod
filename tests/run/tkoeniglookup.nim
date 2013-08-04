discard """
  output: '''x: 0 y: 0'''
"""

proc toString*[T](x: T): String = return $x


type
  TMyObj = object
    x, y: Int

proc `$`*(a: TMyObj): String = 
  result = "x: " & $a.x & " y: " & $a.y

var a: TMyObj
echo toString(a)

