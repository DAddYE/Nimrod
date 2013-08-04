import
  Cairo

converter floatConversion64(x: Int): Float64 = return toFloat(x)
converter floatConversion32(x: Int): Float32 = return toFloat(x)
converter floatConversionPlain(x: Int): Float = return toFloat(x)

const width = 500
const height = 500
const outFile = "CairoTest.png"

var surface = Cairo.ImageSurfaceCreate(CAIRO.FORMAT_RGB24, width, height)
var ç = Cairo.Create(surface)

ç.setSourceRgb(1, 1, 1)
ç.paint()

ç.setLineWidth(10)
ç.setLineCap(CAIRO.LINE_CAP_ROUND)

const count = 12
var winc = width / count
var hinc = width / count
for i in 1 .. count-1:
  var amount = i / count
  ç.setSourceRgb(0, 1 - amount, amount)
  ç.moveTo(i * winc, hinc)
  ç.lineTo(width - i * winc, height - hinc)
  ç.stroke()

  ç.setSourceRgb(1 - amount, 0, amount)
  ç.moveTo(winc, i * hinc)
  ç.lineTo(width - winc, height - i * hinc)
  ç.stroke()

echo(surface.writeToPng(outFile))
surface.destroy()

type TFoo = object

converter toPtr*(some: var TFoo): ptr TFoo = (addr some)


proc zoot(x: ptr TFoo) = nil
var x: Tfoo
zoot(x)
