import strutils, math

proc degrees*(rad: Float): Float =
  return rad * 180.0 / PI
proc radians*(deg: Float): Float =
  return deg * PI / 180.0

## V not math, sue me
proc ff*(f: Float, precision = 2): String {.inline.} = 
  return formatFloat(f, ffDecimal, precision)
