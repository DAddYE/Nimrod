
import 
  glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

nimrodInit()
var window = windowNew(WINDOW_TOPLEVEL)
var stackbox = vboxNew(true, 10)
var label1 = labelNew("Red label text")
var labelstyle = copy(getStyle(label1))
labelstyle.fg[STATE_NORMAL].pixel = 0
labelstyle.fg[STATE_NORMAL].red = -1'i16
labelstyle.fg[STATE_NORMAL].blue = 0'i16
labelstyle.fg[STATE_NORMAL].green = 0'i16
setStyle(label1, labelstyle) 
# Uncomment this to see the effect of setting the default style.
# set_default_style(labelstyle)
var label2 = labelNew("Black label text")
packStart(stackbox, label1, true, true, 0)
packStart(stackbox, label2, true, true, 0)
setBorderWidth(window, 5)
add(window, stackbox)
discard signalConnect(window, "destroy", 
                   signalFunc(ex8.destroy), nil)
showAll(window)
main()

