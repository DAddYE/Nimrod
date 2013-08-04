
import 
  glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

proc widgetDestroy(w: PWidget) {.cdecl.} = 
  destroy(w)

nimrodInit()
var window = windowNew(WINDOW_TOPLEVEL)
var button = buttonNew("Click me")
setBorderWidth(window, 5)
add(window, button)
discard signalConnect(window, "destroy", 
                       signalFunc(ex5.destroy), nil)
discard signalConnectObject(button, "clicked", 
                              signalFunc(widgetDestroy), 
                              window)
show(button)
show(window)
main()

