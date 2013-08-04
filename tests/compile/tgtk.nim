
import
  gtk2, glib2, atk, gdk2, gdk2pixbuf, libglade2, pango,
  pangoutils

proc hello(widget: PWidget, data: Pointer) {.cdecl.} =
  write(stdout, "Hello World\n")

proc deleteEvent(widget: PWidget, event: PEvent,
                  data: Pointer): Bool {.cdecl.} =
  # If you return FALSE in the "delete_event" signal handler,
  # GTK will emit the "destroy" signal. Returning TRUE means
  # you don't want the window to be destroyed.
  # This is useful for popping up 'are you sure you want to quit?'
  # type dialogs.
  write(stdout, "delete event occurred\n")
  # Change TRUE to FALSE and the main window will be destroyed with
  # a "delete_event".
  return false

# Another callback
proc mydestroy(widget: PWidget, data: Pointer) {.cdecl.} =
  gtk2.main_quit()

proc mymain() =
  # GtkWidget is the storage type for widgets
  gtk2.nimrod_init()
  var window = windowNew(gtk2.WINDOW_TOPLEVEL)
  discard gSignalConnect(window, "delete_event", 
                           gCallback(deleteEvent), nil)
  discard gSignalConnect(window, "destroy", gCallback(mydestroy), nil)
  # Sets the border width of the window.
  setBorderWidth(window, 10)

  # Creates a new button with the label "Hello World".
  var button = buttonNew("Hello World")

  discard gSignalConnect(button, "clicked", gCallback(hello), nil)

  # This packs the button into the window (a gtk container).
  add(window, button)

  # The final step is to display this newly created widget.
  show(button)

  # and the window
  show(window)

  gtk2.main()

mymain()
