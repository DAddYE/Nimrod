import 
  math, strutils,
  sfml, input_helpers
when not defined(NoChipmunk):
  import chipmunk
  proc floor*(a: TVector): TVector2f {.inline.} =
    result.x = a.x.floor
    result.y = a.y.floor
  proc sfml2cp*(a: TVector2f): TVector {.inline.} =
    result.x = a.x
    result.y = a.y
  proc cp2sfml*(a: TVector): TVector2f {.inline.} =
    result.x = a.x
    result.y = a.y

proc vec2f*(a: TVector2i): TVector2f =
  result.x = a.x.cfloat
  result.y = a.y.cfloat
proc vec2i*(a: TVector2f): TVector2i =
  result.x = a.x.cint
  result.y = a.y.cint
proc vec3f*(x, y, z: Float): TVector3f =
  result.x = x.cfloat
  result.y = y.cfloat
  result.z = z.cfloat

proc `$`*(a: var TIntRect): String =
  result = "[TIntRect $1,$2 $3x$4]".format($a.left, $a.top, $a.width, $a.height)
proc `$`*(a: TKeyEvent): String =
  return "KeyEvent: code=$1 alt=$2 control=$3 shift=$4 system=$5".format(
    $a.code, $a.alt, $a.control, $a.shift, $a.system)

proc `wmod`*(x, y: Float): Float = return x - y * (x/y).floor
proc move*(a: var TIntRect, left, top: Cint): Bool =
  if a.left != left or a.top != top: result = true
  a.left = left
  a.top  = top
