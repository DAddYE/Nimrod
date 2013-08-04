#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#


## This module implements portable dialogs for Nimrod; the implementation
## builds on the GTK interface. On Windows, native dialogs are shown instead.

import
  glib2, gtk2

when defined(Windows):
  import windows, ShellAPI, os

proc info*(window: PWindow, msg: String) =
  ## Shows an information message to the user. The process waits until the
  ## user presses the OK button.
  when defined(Windows):
    discard MessageBoxA(0, msg, "Information", MB_OK or MB_ICONINFORMATION)
  else:
    var dialog = messageDialogNew(window,
                DIALOG_MODAL or DIALOG_DESTROY_WITH_PARENT,
                MessageInfo, ButtonsOk, "%s", Cstring(msg))
    setTitle(dialog, "Information")
    discard run(dialog)
    destroy(PWidget(dialog))

proc warning*(window: PWindow, msg: String) =
  ## Shows a warning message to the user. The process waits until the user
  ## presses the OK button.
  when defined(Windows):
    discard MessageBoxA(0, msg, "Warning", MB_OK or MB_ICONWARNING)
  else:
    var dialog = dialog(messageDialogNew(window,
                DIALOG_MODAL or DIALOG_DESTROY_WITH_PARENT,
                MessageWarning, ButtonsOk, "%s", Cstring(msg)))
    setTitle(dialog, "Warning")
    discard run(dialog)
    destroy(PWidget(dialog))

proc error*(window: PWindow, msg: String) =
  ## Shows an error message to the user. The process waits until the user
  ## presses the OK button.
  when defined(Windows):
    discard MessageBoxA(0, msg, "Error", MB_OK or MB_ICONERROR)
  else:
    var dialog = dialog(messageDialogNew(window,
                DIALOG_MODAL or DIALOG_DESTROY_WITH_PARENT,
                MessageError, ButtonsOk, "%s", Cstring(msg)))
    setTitle(dialog, "Error")
    discard run(dialog)
    destroy(PWidget(dialog))


proc chooseFileToOpen*(window: PWindow, root: String = ""): String =
  ## Opens a dialog that requests a filename from the user. Returns ""
  ## if the user closed the dialog without selecting a file. On Windows,
  ## the native dialog is used, else the GTK dialog is used.
  when defined(Windows):
    var
      opf: TOPENFILENAME
      buf: array [0..2047, char]
    opf.lStructSize = sizeof(opf).int32
    if root.len > 0:
      opf.lpstrInitialDir = root
    opf.lpstrFilter = "All Files\0*.*\0\0"
    opf.flags = OFN_FILEMUSTEXIST
    opf.lpstrFile = buf
    opf.nMaxFile = sizeof(buf).int32
    var res = GetOpenFileName(addr(opf))
    if res != 0:
      result = $buf
    else:
      result = ""
  else:
    var chooser = fileChooserDialogNew("Open File", window,
                FileChooserActionOpen, 
                StockCancel, RESPONSE_CANCEL,
                StockOpen, RESPONSE_OK, nil)
    if root.len > 0:
      discard setCurrentFolder(chooser, root)
    if run(chooser) == Cint(RESPONSE_OK):
      var x = getFilename(chooser)
      result = $x
      gFree(x)
    else:
      result = ""
    destroy(PWidget(chooser))

proc chooseFilesToOpen*(window: PWindow, root: String = ""): Seq[String] =
  ## Opens a dialog that requests filenames from the user. Returns ``@[]``
  ## if the user closed the dialog without selecting a file. On Windows,
  ## the native dialog is used, else the GTK dialog is used.
  when defined(Windows):
    var
      opf: TOPENFILENAME
      buf: array [0..2047*4, char]
    opf.lStructSize = sizeof(opf).int32
    if root.len > 0:
      opf.lpstrInitialDir = root
    opf.lpstrFilter = "All Files\0*.*\0\0"
    opf.flags = OFN_FILEMUSTEXIST or OFN_ALLOWMULTISELECT or OFN_EXPLORER
    opf.lpstrFile = buf
    opf.nMaxFile = sizeof(buf).int32
    var res = GetOpenFileName(addr(opf))
    result = @[]
    if res != 0:
      # parsing the result is horrible:
      var
        i = 0
        s: string
        path = ""
      while buf[i] != '\0':
        add(path, buf[i])
        inc(i)
      inc(i)
      if buf[i] != '\0':
        while true:
          s = ""
          while buf[i] != '\0':
            add(s, buf[i])
            inc(i)
          add(result, s)
          inc(i)
          if buf[i] == '\0': break
        for i in 0..result.len-1: result[i] = os.joinPath(path, result[i])
      else:
        # only one file selected --> gosh, what an ungly thing 
        # the windows API is
        add(result, path) 
  else:
    var chooser = fileChooserDialogNew("Open Files", window,
                FileChooserActionOpen,
                StockCancel, RESPONSE_CANCEL,
                StockOpen, RESPONSE_OK, nil)
    if root.len > 0:
      discard setCurrentFolder(chooser, root)
    setSelectMultiple(chooser, true)
    result = @[]
    if run(chooser) == Cint(RESPONSE_OK):
      var L = getFilenames(chooser)
      var it = L
      while it != nil:
        add(result, $cast[Cstring](it.data))
        gFree(it.data)
        it = it.next
      free(L)
    destroy(PWidget(chooser))


proc chooseFileToSave*(window: PWindow, root: String = ""): String =
  ## Opens a dialog that requests a filename to save to from the user.
  ## Returns "" if the user closed the dialog without selecting a file.
  ## On Windows, the native dialog is used, else the GTK dialog is used.
  when defined(Windows):
    var
      opf: TOPENFILENAME
      buf: array [0..2047, char]
    opf.lStructSize = sizeof(opf).int32
    if root.len > 0:
      opf.lpstrInitialDir = root
    opf.lpstrFilter = "All Files\0*.*\0\0"
    opf.flags = OFN_OVERWRITEPROMPT
    opf.lpstrFile = buf
    opf.nMaxFile = sizeof(buf).int32
    var res = GetSaveFileName(addr(opf))
    if res != 0:
      result = $buf
    else:
      result = ""
  else:
    var chooser = fileChooserDialogNew("Save File", window,
                FileChooserActionSave,
                StockCancel, RESPONSE_CANCEL,
                StockSave, RESPONSE_OK, nil)
    if root.len > 0:
      discard setCurrentFolder(chooser, root)
    setDoOverwriteConfirmation(chooser, true)
    if run(chooser) == Cint(RESPONSE_OK):
      var x = getFilename(chooser)
      result = $x
      gFree(x)
    else:
      result = ""
    destroy(PWidget(chooser))


proc chooseDir*(window: PWindow, root: String = ""): String =
  ## Opens a dialog that requests a directory from the user.
  ## Returns "" if the user closed the dialog without selecting a directory.
  ## On Windows, the native dialog is used, else the GTK dialog is used.
  when defined(Windows):
    var
      lpItemID: PItemIDList
      BrowseInfo: TBrowseInfo
      DisplayName: array [0..MAX_PATH, char]
      TempPath: array [0..MAX_PATH, char]
    Result = ""
    #BrowseInfo.hwndOwner = Application.Handle
    BrowseInfo.pszDisplayName = DisplayName
    BrowseInfo.ulFlags = 1 #BIF_RETURNONLYFSDIRS
    lpItemID = SHBrowseForFolder(cast[LPBrowseInfo](addr(BrowseInfo)))
    if lpItemId != nil:
      discard SHGetPathFromIDList(lpItemID, TempPath)
      Result = $TempPath
      discard GlobalFreePtr(lpItemID)
  else:
    var chooser = fileChooserDialogNew("Select Directory", window,
                FileChooserActionSelectFolder,
                StockCancel, RESPONSE_CANCEL,
                StockOpen, RESPONSE_OK, nil)
    if root.len > 0:
      discard setCurrentFolder(chooser, root)
    if run(chooser) == Cint(RESPONSE_OK):
      var x = getFilename(chooser)
      result = $x
      gFree(x)
    else:
      result = ""
    destroy(PWidget(chooser))

