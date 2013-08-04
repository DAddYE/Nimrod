import xlib, xutil, x, keysym

const
  WindowWidth = 400
  WindowHeight = 300
  
var
  width, height: Cuint
  display: PDisplay
  screen: Cint
  depth: Int
  win: TWindow
  sizeHints: TXSizeHints

proc createWindow = 
  width = WINDOW_WIDTH
  height = WINDOW_HEIGHT

  display = XOpenDisplay(nil)
  if display == nil:
    echo("Verbindung zum X-Server fehlgeschlagen")
    quit(1)

  screen = XDefaultScreen(display)
  depth = XDefaultDepth(display, screen)
  var rootwin = XRootWindow(display, screen)
  win = XCreateSimpleWindow(display, rootwin, 100, 10,
                            width, height, 5,
                            XBlackPixel(display, screen),
                            XWhitePixel(display, screen))
  sizeHints.flags = PSize or PMinSize or PMaxSize
  sizeHints.min_width =  width.Cint
  sizeHints.max_width =  width.Cint
  sizeHints.min_height = height.Cint
  sizeHints.max_height = height.Cint
  discard XSetStandardProperties(display, win, "Simple Window", "window",
                         0, nil, 0, addr(sizeHints))
  discard XSelectInput(display, win, ButtonPressMask or KeyPressMask or 
                                     PointerMotionMask)
  discard XMapWindow(display, win)

proc closeWindow =
  discard XDestroyWindow(display, win)
  discard XCloseDisplay(display)
    
var
  xev: TXEvent

proc processEvent =
  var key: TKeySym
  case Int(xev.theType)
  of KeyPress:
    key = XLookupKeysym(cast[ptr TXKeyEvent](addr(xev)), 0)
    if key.Int != 0:
      echo("keyboard event")
  of ButtonPressMask, PointerMotionMask:
    echo("Mouse event")
  else: nil

proc eventloop =
  discard XFlush(display)
  var numEvents = Int(XPending(display))
  while numEvents != 0:
    dec(numEvents)
    discard XNextEvent(display, addr(xev))
    processEvent()

createWindow()
while true:
  eventloop()
closeWindow()
