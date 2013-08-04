#
#
#              Nimrod REPL
#        (c) Copyright 2012 Dominik Picheta
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

import glib2, gtk2, gdk2, os, osproc, dialogs, strutils

when defined(tinyc):
  const runCmd = "run"
else:
  const runCmd = "c -r"

var nimExe = findExe("nimrod")
if nimExe.len == 0: nimExe = "../bin" / addFileExt("nimrod", os.exeExt)

proc execCode(code: String): String =
  var f: TFile
  if open(f, "temp.nim", fmWrite):
    f.write(code)
    f.close()
    result = osproc.execProcess(
      "$# $# --verbosity:0 --hint[Conf]:off temp.nim" % [nimExe, runCmd],
      {poStdErrToStdOut})
  else:
    result = "cannot open file 'temp.nim'"

var shiftPressed = false
var w: gtk2.PWindow
var inputTextBuffer: PTextBuffer
var outputTextBuffer: PTextBuffer

proc destroy(widget: PWidget, data: Pgpointer){.cdecl.} = 
  mainQuit()

proc fileOpenClicked(menuitem: PMenuItem, userdata: Pgpointer) {.cdecl.} =
  var path = chooseFileToOpen(w)
  if path != "":
    var file = readFile(path)
    if file != nil:
      setText(inputTextBuffer, file, len(file).Gint)
    else:
      error(w, "Unable to read from file")

proc fileSaveClicked(menuitem: PMenuItem, userdata: Pgpointer) {.cdecl.} =
  var path = chooseFileToSave(w)
  
  if path == "": return
  var startIter: TTextIter
  var endIter: TTextIter
  getStartIter(inputTextBuffer, addr(startIter))
  getEndIter(inputTextBuffer, addr(endIter))
  var inputText = getText(inputTextBuffer, addr(startIter), 
                           addr(endIter), false)
  var f: TFile
  if open(f, path, fmWrite):
    f.write(inputText)
    f.close()
  else:
    error(w, "Unable to write to file")

proc inputKeyPressed(widget: PWidget, event: PEventKey, 
                     userdata: Pgpointer): Bool {.cdecl.} =
  if ($keyvalName(event.keyval)).toLower() == "shift_l":
    # SHIFT is pressed
    shiftPressed = true
  
proc setError(msg: String) = 
  outputTextBuffer.setText(msg, msg.len.Gint)
  
proc inputKeyReleased(widget: PWidget, event: PEventKey, 
                      userdata: Pgpointer): Bool {.cdecl.} =
  #echo(keyval_name(event.keyval))
  if ($keyvalName(event.keyval)).toLower() == "shift_l":
    # SHIFT is released
    shiftPressed = false
    
  if ($keyvalName(event.keyval)).toLower() == "return":
    #echo($keyval_name(event.keyval), "Shift_L")
    # Enter pressed
    if shiftPressed == false:
      var startIter: TTextIter
      var endIter: TTextIter
      getStartIter(inputTextBuffer, addr(startIter))
      getEndIter(inputTextBuffer, addr(endIter))
      var inputText = getText(inputTextBuffer, addr(startIter), 
                               addr(endIter), false)

      try:
        var r = execCode($inputText)
        setText(outputTextBuffer, r, len(r).Gint)
      except EIO:
        setError("Error: Could not open file temp.nim")


proc initControls() =
  w = windowNew(gtk2.WINDOW_TOPLEVEL)
  setDefaultSize(w, 500, 600)
  setTitle(w, "Nimrod REPL")
  discard signalConnect(w, "destroy", signalFunc(nimrepl.destroy), nil)
  
  # MainBox (vbox)
  var mainBox = vboxNew(false, 0)
  add(w, mainBox)
  
  # TopMenu (MenuBar)
  var topMenu = menuBarNew()
  show(topMenu)
  
  var fileMenu = menuNew()
  var openMenuItem = menuItemNew("Open")
  append(fileMenu, openMenuItem)
  show(openMenuItem)
  discard signalConnect(openMenuItem, "activate", 
                          signalFunc(fileOpenClicked), nil)
  var saveMenuItem = menuItemNew("Save...")
  append(fileMenu, saveMenuItem)
  show(saveMenuItem)
  discard signalConnect(saveMenuItem, "activate", 
                          signalFunc(fileSaveClicked), nil)
  var fileMenuItem = menuItemNew("File")

  
  setSubmenu(fileMenuItem, fileMenu)
  show(fileMenuItem)
  append(topMenu, fileMenuItem)
  
  packStart(mainBox, topMenu, false, false, 0)

  # VPaned - Seperates the InputTextView and the OutputTextView
  var paned = vpanedNew()
  setPosition(paned, 450)
  packStart(mainBox, paned, true, true, 0)
  show(paned)

  # Init the TextBuffers
  inputTextBuffer = textBufferNew(nil)
  outputTextBuffer = textBufferNew(nil)

  # InputTextView (TextView)
  var inputScrolledWindow = scrolledWindowNew(nil, nil)
  setPolicy(inputScrolledWindow, POLICY_AUTOMATIC, POLICY_AUTOMATIC)
  var inputTextView = textViewNew(inputTextBuffer)
  addWithViewport(inputScrolledWindow, inputTextView)
  add1(paned, inputScrolledWindow)
  show(inputScrolledWindow)
  show(inputTextView)
  
  discard signalConnect(inputTextView, "key-release-event", 
                          signalFunc(inputKeyReleased), nil)
  discard signalConnect(inputTextView, "key-press-event", 
                          signalFunc(inputKeyPressed), nil)
  
  # OutputTextView (TextView)
  var outputScrolledWindow = scrolledWindowNew(nil, nil)
  setPolicy(outputScrolledWindow, POLICY_AUTOMATIC, POLICY_AUTOMATIC)
  var outputTextView = textViewNew(outputTextBuffer)
  addWithViewport(outputScrolledWindow, outputTextView)
  add2(paned, outputScrolledWindow)
  show(outputScrolledWindow)
  show(outputTextView)
  
  show(w)
  show(mainBox)
  
nimrodInit()
initControls()
main()

