
import 
  glib2, gtk2

proc newbutton(ALabel: Cstring): PWidget = 
  Result = buttonNew(aLabel)
  show(result)

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

nimrodInit()
var window = windowNew(WINDOW_TOPLEVEL) # Box to divide window in 2 halves:
var totalbox = vboxNew(true, 10)
show(totalbox)   # A box for each half of the screen:
var hbox = hboxNew(false, 5)
show(hbox)
var vbox = vboxNew(true, 5)
show(vbox)       # Put boxes in their halves
packStart(totalbox, hbox, true, true, 0)
packStart(totalbox, vbox, true, true, 0) # Now fill boxes with buttons.

packStart(hbox, newbutton("Button 1"), false, false, 0)
packStart(hbox, newbutton("Button 2"), false, false, 0)
packStart(hbox, newbutton("Button 3"), false, false, 0) # Vertical box
packStart(vbox, newbutton("Button A"), true, true, 0)
packStart(vbox, newbutton("Button B"), true, true, 0)
packStart(vbox, newbutton("Button C"), true, true, 0) # Put totalbox in window
setBorderWidth(PContainer(window), 5)
add(PContainer(window), totalbox)
discard signalConnect(window, "destroy", signalFunc(ex3.destroy), nil)
show(window)
main()

