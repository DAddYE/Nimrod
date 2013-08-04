
import 
  glib2, gtk2

proc newbutton(ALabel: Cstring): PWidget = 
  Result = buttonNew(aLabel)
  show(result)

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

nimrodInit()
var window = windowNew(WINDOW_TOPLEVEL)
var maintable = tableNew(6, 6, true)

proc addToTable(Widget: PWidget, Left, Right, Top, Bottom: Guint) = 
  attachDefaults(maintable, widget, left, right, top, bottom)

show(maintable)
addToTable(newbutton("1,1 At 1,1"), 1, 2, 1, 2)
addToTable(newbutton("2,2 At 3,1"), 3, 5, 1, 3)
addToTable(newbutton("4,1 At 4,1"), 1, 5, 4, 5) # Put all in window
setBorderWidth(window, 5)
add(window, maintable)
discard signalConnect(window, "destroy", 
                       signalFunc(ex4.destroy), nil)
show(window)
main()

