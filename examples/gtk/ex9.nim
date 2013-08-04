
import 
  gdk2, glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

const 
  Inside: Cstring = "Mouse is over label"
  OutSide: Cstring = "Mouse is not over label"

var 
  overButton: Bool

nimrodInit()
var window = windowNew(gtk2.WINDOW_TOPLEVEL)
var stackbox = vboxNew(true, 10)
var button1 = buttonNew("Move mouse over button")
var buttonstyle = copy(getStyle(button1))
buttonstyle.bg[STATE_PRELIGHT].pixel = 0
buttonstyle.bg[STATE_PRELIGHT].red = -1'i16
buttonstyle.bg[STATE_PRELIGHT].blue = 0'i16
buttonstyle.bg[STATE_PRELIGHT].green = 0'i16
setStyle(button1, buttonstyle)
var button2 = buttonNew()
var aLabel = labelNew(OutSide)


proc changeLabel(P: PWidget, Event: gdk2.PEventCrossing, 
                 Data: var Bool){.cdecl.} = 
  if not data: setText(aLabel, Inside)
  else: setText(aLabel, OutSide)
  data = not data


add(button2, aLabel)
packStart(stackbox, button1, true, true, 0)
packStart(stackbox, button2, true, true, 0)
setBorderWidth(window, 5)
add(window, stackbox)
discard signalConnect(window, "destroy", 
                   signalFunc(ex9.destroy), nil)
overButton = false
discard signalConnect(button1, "enter_notify_event", 
                   signalFunc(changeLabel), addr(overButton))
discard signalConnect(button1, "leave_notify_event", 
                   signalFunc(changeLabel), addr(overButton))
showAll(window)
main()
