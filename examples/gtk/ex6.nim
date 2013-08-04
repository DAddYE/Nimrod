
import 
  glib2, gtk2

type 
  TButtonSignalState = object 
    obj: gtk2.PObject
    signalID: Int32
    disable: Bool

  PButtonSignalState = ptr TButtonSignalState

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

proc widgetDestroy(w: PWidget) {.cdecl.} = destroy(w)

proc disablesignal(widget: PWidget, data: Pgpointer){.cdecl.} = 
  var s = cast[PButtonSignalState](data)
  if s.Disable: 
    signalHandlerBlock(s.Obj, s.SignalID)
  else: 
    signalHandlerUnblock(s.Obj, s.SignalID)
  s.disable = not s.disable

var 
  quitState: TButtonSignalState

nimrodInit()
var window = windowNew(WINDOW_TOPLEVEL)
var quitbutton = buttonNew("Quit program")
var disablebutton = buttonNew("Disable button")
var windowbox = vboxNew(true, 10)
packStart(windowbox, disablebutton, true, false, 0)
packStart(windowbox, quitbutton, true, false, 0)
setBorderWidth(window, 10)
add(window, windowbox)
discard signalConnect(window, "destroy", signalFunc(ex6.destroy), nil)
quitState.Obj = quitbutton
quitState.SignalID = signalConnectObject(quitState.Obj, "clicked", 
                       signalFunc(widgetDestroy), window).Int32
quitState.Disable = true
discard signalConnect(disablebutton, "clicked", 
                   signalFunc(disablesignal), addr(quitState))
show(quitbutton)
show(disablebutton)
show(windowbox)
show(window)
main()

