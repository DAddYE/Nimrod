import 
  cairo, glib2, gtk2

proc destroy(widget: PWidget, data: Pgpointer) {.cdecl.} =
  mainQuit()

var
  window: PWidget
nimrodInit()
window = windowNew(WINDOW_TOPLEVEL)
discard signalConnect(window, "destroy",
                       signalFunc(ex1.destroy), nil)
show(window)
main()
