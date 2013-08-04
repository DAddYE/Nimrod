
import 
  glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

var 
  window: PWidget
  button: PWidget

nimrodInit()
window = windowNew(WINDOW_TOPLEVEL)
button = buttonNew("Click me")
setBorderWidth(PContainer(window), 5)
add(PContainer(window), button)
discard signalConnect(window, "destroy", 
                           signalFunc(ex2.destroy), nil)
show(button)
show(window)
main()

