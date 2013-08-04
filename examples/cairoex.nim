import cairo

var surface = imageSurfaceCreate(FormatArgb32, 240, 80)
var cr = create(surface)

selectFontFace(cr, "serif", FontSlantNormal, 
                              FontWeightBold)
setFontSize(cr, 32.0)
setSourceRgb(cr, 0.0, 0.0, 1.0)
moveTo(cr, 10.0, 50.0)
showText(cr, "Hello, world")
destroy(cr)
discard writeToPng(surface, "hello.png")
destroy(surface)

