
import 
  gdk2, glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

const 
  Inside: Cstring = "Mouse is over label"
  OutSide: Cstring = "Mouse is not over label"

var 
  overLabel: Bool

nimrodInit()
var window = windowNew(gtk2.WINDOW_TOPLEVEL)
var stackbox = vboxNew(true, 10)
var box1 = eventBoxNew()
var label1 = labelNew("Move mouse over label")
add(box1, label1)
var box2 = eventBoxNew()
var label2 = labelNew(OutSide)
add(box2, label2)
packStart(stackbox, box1, true, true, 0)
packStart(stackbox, box2, true, true, 0)
setBorderWidth(window, 5)
add(window, stackbox)
discard signalConnect(window, "destroy", 
                   signalFunc(ex7.destroy), nil)
overLabel = false


proc changeLabel(P: PWidget, Event: gdk2.PEventCrossing, 
                Data: var Bool){.cdecl.} = 
  if not data: setText(label1, Inside)
  else: setText(label2, OutSide)
  data = not data


discard signalConnect(box1, "enter_notify_event", 
                   signalFunc(changeLabel), addr(overLabel))
discard signalConnect(box1, "leave_notify_event", 
                   signalFunc(changeLabel), addr(overLabel))
showAll(window)
main()

