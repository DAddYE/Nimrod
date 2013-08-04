#
#    Binding for the IUP GUI toolkit
#       (c) 2012 Andreas Rumpf 
#    C header files translated by hand
#    Licence of IUP follows:


# ****************************************************************************
# Copyright (C) 1994-2009 Tecgraf, PUC-Rio.
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# ****************************************************************************

{.deadCodeElim: on.}

when defined(windows): 
  const dllname = "iup(30|27|26|25|24).dll"
elif defined(macosx):
  const dllname = "libiup(3.0|2.7|2.6|2.5|2.4).dylib"
else: 
  const dllname = "libiup(3.0|2.7|2.6|2.5|2.4).so.1"

const
  IupName* = "IUP - Portable User Interface"
  IupCopyright* = "Copyright (C) 1994-2009 Tecgraf, PUC-Rio."
  IupDescription* = "Portable toolkit for building graphical user interfaces."
  constIUPVERSION* = "3.0"
  constIUPVERSIONNUMBER* = 300000
  constIUPVERSIONDATE* = "2009/07/18"

type
  Ihandle {.pure.} = object
  PIhandle* = ptr Ihandle

  Icallback* = proc (arg: PIhandle): Cint {.cdecl.}

#                      pre-definided dialogs
proc fileDlg*: PIhandle {.importc: "IupFileDlg", dynlib: dllname, cdecl.}
proc messageDlg*: PIhandle {.importc: "IupMessageDlg", dynlib: dllname, cdecl.}
proc colorDlg*: PIhandle {.importc: "IupColorDlg", dynlib: dllname, cdecl.}
proc fontDlg*: PIhandle {.importc: "IupFontDlg", dynlib: dllname, cdecl.}

proc getFile*(arq: Cstring): Cint {.
  importc: "IupGetFile", dynlib: dllname, cdecl.}
proc message*(title, msg: Cstring) {.
  importc: "IupMessage", dynlib: dllname, cdecl.}
proc messagef*(title, format: Cstring) {.
  importc: "IupMessagef", dynlib: dllname, cdecl, varargs.}
proc alarm*(title, msg, b1, b2, b3: Cstring): Cint {.
  importc: "IupAlarm", dynlib: dllname, cdecl.}
proc scanf*(format: Cstring): Cint {.
  importc: "IupScanf", dynlib: dllname, cdecl, varargs.}
proc listDialog*(theType: Cint, title: Cstring, size: Cint, 
                 list: CstringArray, op, max_col, max_lin: Cint, 
                 marks: ptr Cint): Cint {.
                 importc: "IupListDialog", dynlib: dllname, cdecl.}
proc getText*(title, text: Cstring): Cint {.
  importc: "IupGetText", dynlib: dllname, cdecl.}
proc getColor*(x, y: Cint, r, g, b: var Byte): Cint {.
  importc: "IupGetColor", dynlib: dllname, cdecl.}

type
  Iparamcb* = proc (dialog: PIhandle, param_index: Cint, 
                    user_data: Pointer): Cint {.cdecl.}

proc getParam*(title: Cstring, action: Iparamcb, user_data: Pointer, 
               format: Cstring): Cint {.
               importc: "IupGetParam", cdecl, varargs, dynlib: dllname.}
proc getParamv*(title: Cstring, action: Iparamcb, user_data: Pointer, 
                format: Cstring, param_count, param_extra: Cint, 
                param_data: Pointer): Cint {.
                importc: "IupGetParamv", cdecl, dynlib: dllname.}


#                      Functions

proc open*(argc: ptr Cint, argv: ptr CstringArray): Cint {.
  importc: "IupOpen", cdecl, dynlib: dllname.}
proc close*() {.importc: "IupClose", cdecl, dynlib: dllname.}
proc imageLibOpen*() {.importc: "IupImageLibOpen", cdecl, dynlib: dllname.}

proc mainLoop*(): Cint {.importc: "IupMainLoop", cdecl, dynlib: dllname, 
                         discardable.}
proc loopStep*(): Cint {.importc: "IupLoopStep", cdecl, dynlib: dllname,
                         discardable.}
proc mainLoopLevel*(): Cint {.importc: "IupMainLoopLevel", cdecl, 
                              dynlib: dllname, discardable.}
proc flush*() {.importc: "IupFlush", cdecl, dynlib: dllname.}
proc exitLoop*() {.importc: "IupExitLoop", cdecl, dynlib: dllname.}

proc update*(ih: PIhandle) {.importc: "IupUpdate", cdecl, dynlib: dllname.}
proc updateChildren*(ih: PIhandle) {.importc: "IupUpdateChildren", cdecl, dynlib: dllname.}
proc redraw*(ih: PIhandle, children: Cint) {.importc: "IupRedraw", cdecl, dynlib: dllname.}
proc refresh*(ih: PIhandle) {.importc: "IupRefresh", cdecl, dynlib: dllname.}

proc mapFont*(iupfont: Cstring): Cstring {.importc: "IupMapFont", cdecl, dynlib: dllname.}
proc unMapFont*(driverfont: Cstring): Cstring {.importc: "IupUnMapFont", cdecl, dynlib: dllname.}
proc help*(url: Cstring): Cint {.importc: "IupHelp", cdecl, dynlib: dllname.}
proc load*(filename: Cstring): Cstring {.importc: "IupLoad", cdecl, dynlib: dllname.}

proc iupVersion*(): Cstring {.importc: "IupVersion", cdecl, dynlib: dllname.}
proc iupVersionDate*(): Cstring {.importc: "IupVersionDate", cdecl, dynlib: dllname.}
proc iupVersionNumber*(): Cint {.importc: "IupVersionNumber", cdecl, dynlib: dllname.}
proc setLanguage*(lng: Cstring) {.importc: "IupSetLanguage", cdecl, dynlib: dllname.}
proc getLanguage*(): Cstring {.importc: "IupGetLanguage", cdecl, dynlib: dllname.}

proc destroy*(ih: PIhandle) {.importc: "IupDestroy", cdecl, dynlib: dllname.}
proc detach*(child: PIhandle) {.importc: "IupDetach", cdecl, dynlib: dllname.}
proc append*(ih, child: PIhandle): PIhandle {.
  importc: "IupAppend", cdecl, dynlib: dllname, discardable.}
proc insert*(ih, ref_child, child: PIhandle): PIhandle {.
  importc: "IupInsert", cdecl, dynlib: dllname, discardable.}
proc getChild*(ih: PIhandle, pos: Cint): PIhandle {.
  importc: "IupGetChild", cdecl, dynlib: dllname.}
proc getChildPos*(ih, child: PIhandle): Cint {.
  importc: "IupGetChildPos", cdecl, dynlib: dllname.}
proc getChildCount*(ih: PIhandle): Cint {.
  importc: "IupGetChildCount", cdecl, dynlib: dllname.}
proc getNextChild*(ih, child: PIhandle): PIhandle {.
  importc: "IupGetNextChild", cdecl, dynlib: dllname.}
proc getBrother*(ih: PIhandle): PIhandle {.
  importc: "IupGetBrother", cdecl, dynlib: dllname.}
proc getParent*(ih: PIhandle): PIhandle {.
  importc: "IupGetParent", cdecl, dynlib: dllname.}
proc getDialog*(ih: PIhandle): PIhandle {.
  importc: "IupGetDialog", cdecl, dynlib: dllname.}
proc getDialogChild*(ih: PIhandle, name: Cstring): PIhandle {.
  importc: "IupGetDialogChild", cdecl, dynlib: dllname.}
proc reparent*(ih, new_parent: PIhandle): Cint {.
  importc: "IupReparent", cdecl, dynlib: dllname.}

proc popup*(ih: PIhandle, x, y: Cint): Cint {.
  importc: "IupPopup", cdecl, dynlib: dllname, discardable.}
proc show*(ih: PIhandle): Cint {.
  importc: "IupShow", cdecl, dynlib: dllname, discardable.}
proc showXY*(ih: PIhandle, x, y: Cint): Cint {.
  importc: "IupShowXY", cdecl, dynlib: dllname, discardable.}
proc hide*(ih: PIhandle): Cint {.
  importc: "IupHide", cdecl, dynlib: dllname, discardable.}
proc map*(ih: PIhandle): Cint {.
  importc: "IupMap", cdecl, dynlib: dllname, discardable.}
proc unmap*(ih: PIhandle) {.
  importc: "IupUnmap", cdecl, dynlib: dllname, discardable.}

proc setAttribute*(ih: PIhandle, name, value: Cstring) {.
  importc: "IupSetAttribute", cdecl, dynlib: dllname.}
proc storeAttribute*(ih: PIhandle, name, value: Cstring) {.
  importc: "IupStoreAttribute", cdecl, dynlib: dllname.}
proc setAttributes*(ih: PIhandle, str: Cstring): PIhandle {.
  importc: "IupSetAttributes", cdecl, dynlib: dllname.}
proc getAttribute*(ih: PIhandle, name: Cstring): Cstring {.
  importc: "IupGetAttribute", cdecl, dynlib: dllname.}
proc getAttributes*(ih: PIhandle): Cstring {.
  importc: "IupGetAttributes", cdecl, dynlib: dllname.}
proc getInt*(ih: PIhandle, name: Cstring): Cint {.
  importc: "IupGetInt", cdecl, dynlib: dllname.}
proc getInt2*(ih: PIhandle, name: Cstring): Cint {.
  importc: "IupGetInt2", cdecl, dynlib: dllname.}
proc getIntInt*(ih: PIhandle, name: Cstring, i1, i2: var Cint): Cint {.
  importc: "IupGetIntInt", cdecl, dynlib: dllname.}
proc getFloat*(ih: PIhandle, name: Cstring): Cfloat {.
  importc: "IupGetFloat", cdecl, dynlib: dllname.}
proc setfAttribute*(ih: PIhandle, name, format: Cstring) {.
  importc: "IupSetfAttribute", cdecl, dynlib: dllname, varargs.}
proc getAllAttributes*(ih: PIhandle, names: CstringArray, n: Cint): Cint {.
  importc: "IupGetAllAttributes", cdecl, dynlib: dllname.}
proc setAtt*(handle_name: Cstring, ih: PIhandle, name: Cstring): PIhandle {.
  importc: "IupSetAtt", cdecl, dynlib: dllname, varargs, discardable.}

proc setGlobal*(name, value: Cstring) {.
  importc: "IupSetGlobal", cdecl, dynlib: dllname.}
proc storeGlobal*(name, value: Cstring) {.
  importc: "IupStoreGlobal", cdecl, dynlib: dllname.}
proc getGlobal*(name: Cstring): Cstring {.
  importc: "IupGetGlobal", cdecl, dynlib: dllname.}

proc setFocus*(ih: PIhandle): PIhandle {.
  importc: "IupSetFocus", cdecl, dynlib: dllname.}
proc getFocus*(): PIhandle {.
  importc: "IupGetFocus", cdecl, dynlib: dllname.}
proc previousField*(ih: PIhandle): PIhandle {.
  importc: "IupPreviousField", cdecl, dynlib: dllname.}
proc nextField*(ih: PIhandle): PIhandle {.
  importc: "IupNextField", cdecl, dynlib: dllname.}

proc getCallback*(ih: PIhandle, name: Cstring): Icallback {.
  importc: "IupGetCallback", cdecl, dynlib: dllname.}
proc setCallback*(ih: PIhandle, name: Cstring, func: Icallback): Icallback {.
  importc: "IupSetCallback", cdecl, dynlib: dllname, discardable.}
  
proc setCallbacks*(ih: PIhandle, name: Cstring, func: Icallback): PIhandle {.
  importc: "IupSetCallbacks", cdecl, dynlib: dllname, varargs, discardable.}

proc getFunction*(name: Cstring): Icallback {.
  importc: "IupGetFunction", cdecl, dynlib: dllname.}
proc setFunction*(name: Cstring, func: Icallback): Icallback {.
  importc: "IupSetFunction", cdecl, dynlib: dllname, discardable.}
proc getActionName*(): Cstring {.
  importc: "IupGetActionName", cdecl, dynlib: dllname.}

proc getHandle*(name: Cstring): PIhandle {.
  importc: "IupGetHandle", cdecl, dynlib: dllname.}
proc setHandle*(name: Cstring, ih: PIhandle): PIhandle {.
  importc: "IupSetHandle", cdecl, dynlib: dllname.}
proc getAllNames*(names: CstringArray, n: Cint): Cint {.
  importc: "IupGetAllNames", cdecl, dynlib: dllname.}
proc getAllDialogs*(names: CstringArray, n: Cint): Cint {.
  importc: "IupGetAllDialogs", cdecl, dynlib: dllname.}
proc getName*(ih: PIhandle): Cstring {.
  importc: "IupGetName", cdecl, dynlib: dllname.}

proc setAttributeHandle*(ih: PIhandle, name: Cstring, ih_named: PIhandle) {.
  importc: "IupSetAttributeHandle", cdecl, dynlib: dllname.}
proc getAttributeHandle*(ih: PIhandle, name: Cstring): PIhandle {.
  importc: "IupGetAttributeHandle", cdecl, dynlib: dllname.}

proc getClassName*(ih: PIhandle): Cstring {.
  importc: "IupGetClassName", cdecl, dynlib: dllname.}
proc getClassType*(ih: PIhandle): Cstring {.
  importc: "IupGetClassType", cdecl, dynlib: dllname.}
proc getClassAttributes*(classname: Cstring, names: CstringArray, 
                         n: Cint): Cint {.
  importc: "IupGetClassAttributes", cdecl, dynlib: dllname.}
proc saveClassAttributes*(ih: PIhandle) {.
  importc: "IupSaveClassAttributes", cdecl, dynlib: dllname.}
proc setClassDefaultAttribute*(classname, name, value: Cstring) {.
  importc: "IupSetClassDefaultAttribute", cdecl, dynlib: dllname.}

proc create*(classname: Cstring): PIhandle {.
  importc: "IupCreate", cdecl, dynlib: dllname.}
proc createv*(classname: Cstring, params: Pointer): PIhandle {.
  importc: "IupCreatev", cdecl, dynlib: dllname.}
proc createp*(classname: Cstring, first: Pointer): PIhandle {.
  importc: "IupCreatep", cdecl, dynlib: dllname, varargs.}

proc fill*(): PIhandle {.importc: "IupFill", cdecl, dynlib: dllname.}
proc radio*(child: PIhandle): PIhandle {.
  importc: "IupRadio", cdecl, dynlib: dllname.}
proc vbox*(child: PIhandle): PIhandle {.
  importc: "IupVbox", cdecl, dynlib: dllname, varargs.}
proc vboxv*(children: ptr PIhandle): PIhandle {.
  importc: "IupVboxv", cdecl, dynlib: dllname.}
proc zbox*(child: PIhandle): PIhandle {.
  importc: "IupZbox", cdecl, dynlib: dllname, varargs.}
proc zboxv*(children: ptr PIhandle): PIhandle {.
  importc: "IupZboxv", cdecl, dynlib: dllname.}
proc hbox*(child: PIhandle): PIhandle {.
  importc: "IupHbox", cdecl, dynlib: dllname, varargs.}
proc hboxv*(children: ptr PIhandle): PIhandle {.
  importc: "IupHboxv", cdecl, dynlib: dllname.}

proc normalizer*(ih_first: PIhandle): PIhandle {.
  importc: "IupNormalizer", cdecl, dynlib: dllname, varargs.}
proc normalizerv*(ih_list: ptr PIhandle): PIhandle {.
  importc: "IupNormalizerv", cdecl, dynlib: dllname.}

proc cbox*(child: PIhandle): PIhandle {.
  importc: "IupCbox", cdecl, dynlib: dllname, varargs.}
proc cboxv*(children: ptr PIhandle): PIhandle {.
  importc: "IupCboxv", cdecl, dynlib: dllname.}
proc sbox*(child: PIhandle): PIhandle {.
  importc: "IupSbox", cdecl, dynlib: dllname.}

proc frame*(child: PIhandle): PIhandle {.
  importc: "IupFrame", cdecl, dynlib: dllname.}

proc image*(width, height: Cint, pixmap: Pointer): PIhandle {.
  importc: "IupImage", cdecl, dynlib: dllname.}
proc imageRGB*(width, height: Cint, pixmap: Pointer): PIhandle {.
  importc: "IupImageRGB", cdecl, dynlib: dllname.}
proc imageRGBA*(width, height: Cint, pixmap: Pointer): PIhandle {.
  importc: "IupImageRGBA", cdecl, dynlib: dllname.}

proc item*(title, action: Cstring): PIhandle {.
  importc: "IupItem", cdecl, dynlib: dllname.}
proc submenu*(title: Cstring, child: PIhandle): PIhandle {.
  importc: "IupSubmenu", cdecl, dynlib: dllname.}
proc separator*(): PIhandle {.
  importc: "IupSeparator", cdecl, dynlib: dllname.}
proc menu*(child: PIhandle): PIhandle {.
  importc: "IupMenu", cdecl, dynlib: dllname, varargs.}
proc menuv*(children: ptr PIhandle): PIhandle {.
  importc: "IupMenuv", cdecl, dynlib: dllname.}

proc button*(title, action: Cstring): PIhandle {.
  importc: "IupButton", cdecl, dynlib: dllname.}
proc canvas*(action: Cstring): PIhandle {.
  importc: "IupCanvas", cdecl, dynlib: dllname.}
proc dialog*(child: PIhandle): PIhandle {.
  importc: "IupDialog", cdecl, dynlib: dllname.}
proc user*(): PIhandle {.
  importc: "IupUser", cdecl, dynlib: dllname.}
proc label*(title: Cstring): PIhandle {.
  importc: "IupLabel", cdecl, dynlib: dllname.}
proc list*(action: Cstring): PIhandle {.
  importc: "IupList", cdecl, dynlib: dllname.}
proc text*(action: Cstring): PIhandle {.
  importc: "IupText", cdecl, dynlib: dllname.}
proc multiLine*(action: Cstring): PIhandle {.
  importc: "IupMultiLine", cdecl, dynlib: dllname.}
proc toggle*(title, action: Cstring): PIhandle {.
  importc: "IupToggle", cdecl, dynlib: dllname.}
proc timer*(): PIhandle {.
  importc: "IupTimer", cdecl, dynlib: dllname.}
proc progressBar*(): PIhandle {.
  importc: "IupProgressBar", cdecl, dynlib: dllname.}
proc val*(theType: Cstring): PIhandle {.
  importc: "IupVal", cdecl, dynlib: dllname.}
proc tabs*(child: PIhandle): PIhandle {.
  importc: "IupTabs", cdecl, dynlib: dllname, varargs.}
proc tabsv*(children: ptr PIhandle): PIhandle {.
  importc: "IupTabsv", cdecl, dynlib: dllname.}
proc tree*(): PIhandle {.importc: "IupTree", cdecl, dynlib: dllname.}

proc spin*(): PIhandle {.importc: "IupSpin", cdecl, dynlib: dllname.}
proc spinbox*(child: PIhandle): PIhandle {.
  importc: "IupSpinbox", cdecl, dynlib: dllname.}

# IupText utilities
proc textConvertLinColToPos*(ih: PIhandle, lin, col: Cint, pos: var Cint) {.
  importc: "IupTextConvertLinColToPos", cdecl, dynlib: dllname.}
proc textConvertPosToLinCol*(ih: PIhandle, pos: Cint, lin, col: var Cint) {.
  importc: "IupTextConvertPosToLinCol", cdecl, dynlib: dllname.}

proc convertXYToPos*(ih: PIhandle, x, y: Cint): Cint {.
  importc: "IupConvertXYToPos", cdecl, dynlib: dllname.}

# IupTree utilities
proc treeSetUserId*(ih: PIhandle, id: Cint, userid: Pointer): Cint {.
  importc: "IupTreeSetUserId", cdecl, dynlib: dllname, discardable.}
proc treeGetUserId*(ih: PIhandle, id: Cint): Pointer {.
  importc: "IupTreeGetUserId", cdecl, dynlib: dllname.}
proc treeGetId*(ih: PIhandle, userid: Pointer): Cint {.
  importc: "IupTreeGetId", cdecl, dynlib: dllname.}

proc treeSetAttribute*(ih: PIhandle, name: Cstring, id: Cint, value: Cstring) {.
  importc: "IupTreeSetAttribute", cdecl, dynlib: dllname.}
proc treeStoreAttribute*(ih: PIhandle, name: Cstring, id: Cint, value: Cstring) {.
  importc: "IupTreeStoreAttribute", cdecl, dynlib: dllname.}
proc treeGetAttribute*(ih: PIhandle, name: Cstring, id: Cint): Cstring {.
  importc: "IupTreeGetAttribute", cdecl, dynlib: dllname.}
proc treeGetInt*(ih: PIhandle, name: Cstring, id: Cint): Cint {.
  importc: "IupTreeGetInt", cdecl, dynlib: dllname.}
proc treeGetFloat*(ih: PIhandle, name: Cstring, id: Cint): Cfloat {.
  importc: "IupTreeGetFloat", cdecl, dynlib: dllname.}
proc treeSetfAttribute*(ih: PIhandle, name: Cstring, id: Cint, format: Cstring) {.
  importc: "IupTreeSetfAttribute", cdecl, dynlib: dllname, varargs.}


#                   Common Return Values
const
  IupError* = cint(1)
  IupNoerror* = cint(0)
  IupOpened* = cint(-1)
  IupInvalid* = cint(-1)

  # Callback Return Values
  IupIgnore* = cint(-1)
  IupDefault* = cint(-2)
  IupClose* = cint(-3)
  IupContinue* = cint(-4)

  # IupPopup and IupShowXY Parameter Values
  IupCenter* = cint(0xFFFF) 
  IupLeft* = cint(0xFFFE) 
  IupRight* = cint(0xFFFD) 
  IupMousepos* = cint(0xFFFC) 
  IupCurrent* = cint(0xFFFB) 
  IupCenterparent* = cint(0xFFFA) 
  IupTop* = IUP_LEFT
  IupBottom* = IUP_RIGHT

  # SHOW_CB Callback Values
  IupShow* = cint(0)
  IupRestore* = cint(1)
  IupMinimize* = cint(2)
  IupMaximize* = cint(3)
  IupHide* = cint(4)

  # SCROLL_CB Callback Values
  IupSbup* = cint(0)
  IupSbdn* = cint(1)
  IupSbpgup* = cint(2)   
  IupSbpgdn* = cint(3)
  IupSbposv* = cint(4)
  IupSbdragv* = cint(5) 
  IupSbleft* = cint(6)
  IupSbright* = cint(7)
  IupSbpgleft* = cint(8)
  IupSbpgright* = cint(9)
  IupSbposh* = cint(10)
  IupSbdragh* = cint(11)

  # Mouse Button Values and Macros
  IupButton1* = cint(ord('1'))
  IupButton2* = cint(ord('2'))
  IupButton3* = cint(ord('3'))
  IupButton4* = cint(ord('4'))
  IupButton5* = cint(ord('5'))

proc isShift*(s: Cstring): Bool = return s[0] == 'S'
proc isControl*(s: Cstring): Bool = return s[1] == 'C'
proc isButton1*(s: Cstring): Bool = return s[2] == '1'
proc isButton2*(s: Cstring): Bool = return s[3] == '2'
proc isbutton3*(s: Cstring): Bool = return s[4] == '3'
proc isDouble*(s: Cstring): Bool = return s[5] == 'D'
proc isAlt*(s: Cstring): Bool = return s[6] == 'A'
proc isSys*(s: Cstring): Bool = return s[7] == 'Y'
proc isButton4*(s: Cstring): Bool = return s[8] == '4'
proc isButton5*(s: Cstring): Bool = return s[9] == '5'

# Pre-Defined Masks
const
  IupMaskFloat* = "[+/-]?(/d+/.?/d*|/./d+)"
  IupMaskUfloat* = "(/d+/.?/d*|/./d+)"
  IupMaskEfloat* = "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
  IupMaskInt* = "[+/-]?/d+"
  IupMaskUint* = "/d+"
  
# from 32 to 126, all character sets are equal,
# the key code i the same as the character code.
const
  KSp* = cint(ord(' '))
  KExclam* = cint(ord('!'))   
  KQuotedbl* = cint(ord('\"'))
  KNumbersign* = cint(ord('#'))
  KDollar* = cint(ord('$'))
  KPercent* = cint(ord('%'))
  KAmpersand* = cint(ord('&'))
  KApostrophe* = cint(ord('\''))
  KParentleft* = cint(ord('('))
  KParentright* = cint(ord(')'))
  KAsterisk* = cint(ord('*'))
  KPlus* = cint(ord('+'))
  KComma* = cint(ord(','))
  KMinus* = cint(ord('-'))
  KPeriod* = cint(ord('.'))
  KSlash* = cint(ord('/'))
  K0* = cint(ord('0'))
  K1* = cint(ord('1'))
  K2* = cint(ord('2'))
  K3* = cint(ord('3'))
  K4* = cint(ord('4'))
  K5* = cint(ord('5'))
  K6* = cint(ord('6'))
  K7* = cint(ord('7'))
  K8* = cint(ord('8'))
  K9* = cint(ord('9'))
  KColon* = cint(ord(':'))
  KSemicolon* = cint(ord(';'))
  KLess* = cint(ord('<'))
  KEqual* = cint(ord('='))
  KGreater* = cint(ord('>'))   
  KQuestion* = cint(ord('?'))   
  KAt* = cint(ord('@'))   
  KUpperA* = cint(ord('A'))   
  KUpperB* = cint(ord('B'))   
  KUpperC* = cint(ord('C'))   
  KUpperD* = cint(ord('D'))   
  KUpperE* = cint(ord('E'))   
  KUpperF* = cint(ord('F'))   
  KUpperG* = cint(ord('G'))   
  KUpperH* = cint(ord('H'))   
  KUpperI* = cint(ord('I'))   
  KUpperJ* = cint(ord('J'))   
  KUpperK* = cint(ord('K'))   
  KUpperL* = cint(ord('L'))   
  KUpperM* = cint(ord('M'))   
  KUpperN* = cint(ord('N'))   
  KUpperO* = cint(ord('O'))   
  KUpperP* = cint(ord('P'))   
  KUpperQ* = cint(ord('Q'))  
  KUpperR* = cint(ord('R'))  
  KUpperS* = cint(ord('S'))  
  KUpperT* = cint(ord('T'))  
  KUpperU* = cint(ord('U'))  
  KUpperV* = cint(ord('V')) 
  KUpperW* = cint(ord('W')) 
  KUpperX* = cint(ord('X'))  
  KUpperY* = cint(ord('Y'))  
  KUpperZ* = cint(ord('Z'))  
  KBracketleft* = cint(ord('[')) 
  KBackslash* = cint(ord('\\'))  
  KBracketright* = cint(ord(']'))  
  KCircum* = cint(ord('^'))   
  KUnderscore* = cint(ord('_'))   
  KGrave* = cint(ord('`'))   
  KLowera* = cint(ord('a'))  
  KLowerb* = cint(ord('b'))   
  KLowerc* = cint(ord('c')) 
  KLowerd* = cint(ord('d'))   
  KLowere* = cint(ord('e'))   
  KLowerf* = cint(ord('f'))  
  KLowerg* = cint(ord('g'))
  KLowerh* = cint(ord('h')) 
  KLoweri* = cint(ord('i')) 
  KLowerj* = cint(ord('j')) 
  KLowerk* = cint(ord('k'))
  KLowerl* = cint(ord('l'))
  KLowerm* = cint(ord('m'))
  KLowern* = cint(ord('n'))
  KLowero* = cint(ord('o'))
  KLowerp* = cint(ord('p'))
  KLowerq* = cint(ord('q'))
  KLowerr* = cint(ord('r'))
  KLowers* = cint(ord('s'))
  KLowert* = cint(ord('t'))
  KLoweru* = cint(ord('u'))
  KLowerv* = cint(ord('v'))
  KLowerw* = cint(ord('w'))
  KLowerx* = cint(ord('x'))
  KLowery* = cint(ord('y'))
  KLowerz* = cint(ord('z'))
  KBraceleft* = cint(ord('{'))
  KBar* = cint(ord('|'))
  KBraceright* = cint(ord('}'))
  KTilde* = cint(ord('~'))

proc isPrint*(c: Cint): Bool = return c > 31 and c < 127

# also define the escape sequences that have keys associated
const
  KBs* = cint(ord('\b'))
  KTab* = cint(ord('\t'))
  KLf* = cint(10)
  KCr* = cint(13)

# IUP Extended Key Codes, range start at 128
# Modifiers use 256 interval
# These key code definitions are specific to IUP

proc isXkey*(c: Cint): Bool = return c > 128
proc isShiftXkey*(c: Cint): Bool = return c > 256 and c < 512
proc isCtrlXkey*(c: Cint): Bool = return c > 512 and c < 768
proc isAltXkey*(c: Cint): Bool = return c > 768 and c < 1024
proc isSysXkey*(c: Cint): Bool = return c > 1024 and c < 1280

proc iUPxCODE*(c: Cint): Cint = return c + Cint(128) # Normal (must be above 128)
proc iUPsxCODE*(c: Cint): Cint = 
  return c + Cint(256)
  # Shift (must have range to include the standard keys and the normal 
  # extended keys, so must be above 256

proc iUPcxCODE*(c: Cint): Cint = return c + Cint(512) # Ctrl
proc iUPmxCODE*(c: Cint): Cint = return c + Cint(768) # Alt
proc iUPyxCODE*(c: Cint): Cint = return c + Cint(1024) # Sys (Win or Apple) 

const
  IupNummaxcodes* = 1280 ## 5*256=1280  Normal+Shift+Ctrl+Alt+Sys

  KHome* = IUPxCODE(1)                
  KUp* = IUPxCODE(2)
  KPgup* = IUPxCODE(3)
  KLeft* = IUPxCODE(4)
  KMiddle* = IUPxCODE(5)
  KRight* = IUPxCODE(6)
  KEnd* = IUPxCODE(7)
  KDown* = IUPxCODE(8)
  KPgdn* = IUPxCODE(9)
  KIns* = IUPxCODE(10)    
  KDel* = IUPxCODE(11)    
  KPause* = IUPxCODE(12)
  KEsc* = IUPxCODE(13)
  KCcedilla* = IUPxCODE(14)
  KF1* = IUPxCODE(15)
  KF2* = IUPxCODE(16)
  KF3* = IUPxCODE(17)
  KF4* = IUPxCODE(18)
  KF5* = IUPxCODE(19)
  KF6* = IUPxCODE(20)
  KF7* = IUPxCODE(21)
  KF8* = IUPxCODE(22)
  KF9* = IUPxCODE(23)
  KF10* = IUPxCODE(24)
  KF11* = IUPxCODE(25)
  KF12* = IUPxCODE(26)
  KPrint* = IUPxCODE(27)
  KMenu* = IUPxCODE(28)

  KAcute* = IUPxCODE(29) # no Shift/Ctrl/Alt

  KSHOME* = IUPsxCODE(K_HOME)
  KSUP* = IUPsxCODE(K_UP)
  KSPGUP* = IUPsxCODE(K_PGUP)
  KSLEFT* = IUPsxCODE(K_LEFT)
  KSMIDDLE* = IUPsxCODE(K_MIDDLE)
  KSRIGHT* = IUPsxCODE(K_RIGHT)
  KSEND* = IUPsxCODE(K_END)
  KSDOWN* = IUPsxCODE(K_DOWN)
  KSPGDN* = IUPsxCODE(K_PGDN)
  KSINS* = IUPsxCODE(K_INS)
  KSDEL* = IUPsxCODE(K_DEL)
  KSSP* = IUPsxCODE(K_SP)
  KSTAB* = IUPsxCODE(K_TAB)
  KSCR* = IUPsxCODE(K_CR)
  KSBS* = IUPsxCODE(K_BS)
  KSPAUSE* = IUPsxCODE(K_PAUSE)
  KSESC* = IUPsxCODE(K_ESC)
  KSCcedilla* = IUPsxCODE(K_ccedilla)
  KSF1* = IUPsxCODE(K_F1)
  KSF2* = IUPsxCODE(K_F2)
  KSF3* = IUPsxCODE(K_F3)
  KSF4* = IUPsxCODE(K_F4)
  KSF5* = IUPsxCODE(K_F5)
  KSF6* = IUPsxCODE(K_F6)
  KSF7* = IUPsxCODE(K_F7)
  KSF8* = IUPsxCODE(K_F8)
  KSF9* = IUPsxCODE(K_F9)
  KSF10* = IUPsxCODE(K_F10)
  KSF11* = IUPsxCODE(K_F11)
  KSF12* = IUPsxCODE(K_F12)
  KSPrint* = IUPsxCODE(K_Print)
  KSMenu* = IUPsxCODE(K_Menu)

  KCHOME* = IUPcxCODE(K_HOME)
  KCUP* = IUPcxCODE(K_UP)
  KCPGUP* = IUPcxCODE(K_PGUP)
  KCLEFT* = IUPcxCODE(K_LEFT)
  KCMIDDLE* = IUPcxCODE(K_MIDDLE)
  KCRIGHT* = IUPcxCODE(K_RIGHT)
  KCEND* = IUPcxCODE(K_END)
  KCDOWN* = IUPcxCODE(K_DOWN)
  KCPGDN* = IUPcxCODE(K_PGDN)
  KCINS* = IUPcxCODE(K_INS)
  KCDEL* = IUPcxCODE(K_DEL)
  KCSP* = IUPcxCODE(K_SP)
  KCTAB* = IUPcxCODE(K_TAB)
  KCCR* = IUPcxCODE(K_CR)
  KCBS* = IUPcxCODE(K_BS)
  KCPAUSE* = IUPcxCODE(K_PAUSE)
  KCESC* = IUPcxCODE(K_ESC)
  KCCcedilla* = IUPcxCODE(K_ccedilla)
  KCF1* = IUPcxCODE(K_F1)
  KCF2* = IUPcxCODE(K_F2)
  KCF3* = IUPcxCODE(K_F3)
  KCF4* = IUPcxCODE(K_F4)
  KCF5* = IUPcxCODE(K_F5)
  KCF6* = IUPcxCODE(K_F6)
  KCF7* = IUPcxCODE(K_F7)
  KCF8* = IUPcxCODE(K_F8)
  KCF9* = IUPcxCODE(K_F9)
  KCF10* = IUPcxCODE(K_F10)
  KCF11* = IUPcxCODE(K_F11)
  KCF12* = IUPcxCODE(K_F12)
  KCPrint* = IUPcxCODE(K_Print)
  KCMenu* = IUPcxCODE(K_Menu)

  KMHOME* = IUPmxCODE(K_HOME)
  KMUP* = IUPmxCODE(K_UP)
  KMPGUP* = IUPmxCODE(K_PGUP)
  KMLEFT* = IUPmxCODE(K_LEFT)
  KMMIDDLE* = IUPmxCODE(K_MIDDLE)
  KMRIGHT* = IUPmxCODE(K_RIGHT)
  KMEND* = IUPmxCODE(K_END)
  KMDOWN* = IUPmxCODE(K_DOWN)
  KMPGDN* = IUPmxCODE(K_PGDN)
  KMINS* = IUPmxCODE(K_INS)
  KMDEL* = IUPmxCODE(K_DEL)
  KMSP* = IUPmxCODE(K_SP)
  KMTAB* = IUPmxCODE(K_TAB)
  KMCR* = IUPmxCODE(K_CR)
  KMBS* = IUPmxCODE(K_BS)
  KMPAUSE* = IUPmxCODE(K_PAUSE)
  KMESC* = IUPmxCODE(K_ESC)
  KMCcedilla* = IUPmxCODE(K_ccedilla)
  KMF1* = IUPmxCODE(K_F1)
  KMF2* = IUPmxCODE(K_F2)
  KMF3* = IUPmxCODE(K_F3)
  KMF4* = IUPmxCODE(K_F4)
  KMF5* = IUPmxCODE(K_F5)
  KMF6* = IUPmxCODE(K_F6)
  KMF7* = IUPmxCODE(K_F7)
  KMF8* = IUPmxCODE(K_F8)
  KMF9* = IUPmxCODE(K_F9)
  KMF10* = IUPmxCODE(K_F10)
  KMF11* = IUPmxCODE(K_F11)
  KMF12* = IUPmxCODE(K_F12)
  KMPrint* = IUPmxCODE(K_Print)
  KMMenu* = IUPmxCODE(K_Menu)

  KYHOME* = IUPyxCODE(K_HOME)
  KYUP* = IUPyxCODE(K_UP)
  KYPGUP* = IUPyxCODE(K_PGUP)
  KYLEFT* = IUPyxCODE(K_LEFT)
  KYMIDDLE* = IUPyxCODE(K_MIDDLE)
  KYRIGHT* = IUPyxCODE(K_RIGHT)
  KYEND* = IUPyxCODE(K_END)
  KYDOWN* = IUPyxCODE(K_DOWN)
  KYPGDN* = IUPyxCODE(K_PGDN)
  KYINS* = IUPyxCODE(K_INS)
  KYDEL* = IUPyxCODE(K_DEL)
  KYSP* = IUPyxCODE(K_SP)
  KYTAB* = IUPyxCODE(K_TAB)
  KYCR* = IUPyxCODE(K_CR)
  KYBS* = IUPyxCODE(K_BS)
  KYPAUSE* = IUPyxCODE(K_PAUSE)
  KYESC* = IUPyxCODE(K_ESC)
  KYCcedilla* = IUPyxCODE(K_ccedilla)
  KYF1* = IUPyxCODE(K_F1)
  KYF2* = IUPyxCODE(K_F2)
  KYF3* = IUPyxCODE(K_F3)
  KYF4* = IUPyxCODE(K_F4)
  KYF5* = IUPyxCODE(K_F5)
  KYF6* = IUPyxCODE(K_F6)
  KYF7* = IUPyxCODE(K_F7)
  KYF8* = IUPyxCODE(K_F8)
  KYF9* = IUPyxCODE(K_F9)
  KYF10* = IUPyxCODE(K_F10)
  KYF11* = IUPyxCODE(K_F11)
  KYF12* = IUPyxCODE(K_F12)
  KYPrint* = IUPyxCODE(K_Print)
  KYMenu* = IUPyxCODE(K_Menu)

  KSPlus* = IUPsxCODE(K_plus)   
  KSComma* = IUPsxCODE(K_comma)   
  KSMinus* = IUPsxCODE(K_minus)   
  KSPeriod* = IUPsxCODE(K_period)   
  KSSlash* = IUPsxCODE(K_slash)   
  KSAsterisk* = IUPsxCODE(K_asterisk)
                        
  KCupperA* = IUPcxCODE(K_upperA)
  KCupperB* = IUPcxCODE(K_upperB)
  KCupperC* = IUPcxCODE(K_upperC)
  KCupperD* = IUPcxCODE(K_upperD)
  KCupperE* = IUPcxCODE(K_upperE)
  KCupperF* = IUPcxCODE(K_upperF)
  KCupperG* = IUPcxCODE(K_upperG)
  KCupperH* = IUPcxCODE(K_upperH)
  KCupperI* = IUPcxCODE(K_upperI)
  KCupperJ* = IUPcxCODE(K_upperJ)
  KCupperK* = IUPcxCODE(K_upperK)
  KCupperL* = IUPcxCODE(K_upperL)
  KCupperM* = IUPcxCODE(K_upperM)
  KCupperN* = IUPcxCODE(K_upperN)
  KCupperO* = IUPcxCODE(K_upperO)
  KCupperP* = IUPcxCODE(K_upperP)
  KCupperQ* = IUPcxCODE(K_upperQ)
  KCupperR* = IUPcxCODE(K_upperR)
  KCupperS* = IUPcxCODE(K_upperS)
  KCupperT* = IUPcxCODE(K_upperT)
  KCupperU* = IUPcxCODE(K_upperU)
  KCupperV* = IUPcxCODE(K_upperV)
  KCupperW* = IUPcxCODE(K_upperW)
  KCupperX* = IUPcxCODE(K_upperX)
  KCupperY* = IUPcxCODE(K_upperY)
  KCupperZ* = IUPcxCODE(K_upperZ)
  KC1* = IUPcxCODE(K_1)
  KC2* = IUPcxCODE(K_2)
  KC3* = IUPcxCODE(K_3)
  KC4* = IUPcxCODE(K_4)
  KC5* = IUPcxCODE(K_5)
  KC6* = IUPcxCODE(K_6)
  KC7* = IUPcxCODE(K_7)        
  KC8* = IUPcxCODE(K_8)         
  KC9* = IUPcxCODE(K_9)
  KC0* = IUPcxCODE(K_0)
  KCPlus* = IUPcxCODE(K_plus)   
  KCComma* = IUPcxCODE(K_comma)   
  KCMinus* = IUPcxCODE(K_minus)   
  KCPeriod* = IUPcxCODE(K_period)   
  KCSlash* = IUPcxCODE(K_slash)   
  KCSemicolon* = IUPcxCODE(K_semicolon) 
  KCEqual* = IUPcxCODE(K_equal)
  KCBracketleft* = IUPcxCODE(K_bracketleft)
  KCBracketright* = IUPcxCODE(K_bracketright)
  KCBackslash* = IUPcxCODE(K_backslash)
  KCAsterisk* = IUPcxCODE(K_asterisk)

  KMupperA* = IUPmxCODE(K_upperA)
  KMupperB* = IUPmxCODE(K_upperB)
  KMupperC* = IUPmxCODE(K_upperC)
  KMupperD* = IUPmxCODE(K_upperD)
  KMupperE* = IUPmxCODE(K_upperE)
  KMupperF* = IUPmxCODE(K_upperF)
  KMupperG* = IUPmxCODE(K_upperG)
  KMupperH* = IUPmxCODE(K_upperH)
  KMupperI* = IUPmxCODE(K_upperI)
  KMupperJ* = IUPmxCODE(K_upperJ)
  KMupperK* = IUPmxCODE(K_upperK)
  KMupperL* = IUPmxCODE(K_upperL)
  KMupperM* = IUPmxCODE(K_upperM)
  KMupperN* = IUPmxCODE(K_upperN)
  KMupperO* = IUPmxCODE(K_upperO)
  KMupperP* = IUPmxCODE(K_upperP)
  KMupperQ* = IUPmxCODE(K_upperQ)
  KMupperR* = IUPmxCODE(K_upperR)
  KMupperS* = IUPmxCODE(K_upperS)
  KMupperT* = IUPmxCODE(K_upperT)
  KMupperU* = IUPmxCODE(K_upperU)
  KMupperV* = IUPmxCODE(K_upperV)
  KMupperW* = IUPmxCODE(K_upperW)
  KMupperX* = IUPmxCODE(K_upperX)
  KMupperY* = IUPmxCODE(K_upperY)
  KMupperZ* = IUPmxCODE(K_upperZ)
  KM1* = IUPmxCODE(K_1)
  KM2* = IUPmxCODE(K_2)
  KM3* = IUPmxCODE(K_3)
  KM4* = IUPmxCODE(K_4)
  KM5* = IUPmxCODE(K_5)
  KM6* = IUPmxCODE(K_6)
  KM7* = IUPmxCODE(K_7)        
  KM8* = IUPmxCODE(K_8)         
  KM9* = IUPmxCODE(K_9)
  KM0* = IUPmxCODE(K_0)
  KMPlus* = IUPmxCODE(K_plus)   
  KMComma* = IUPmxCODE(K_comma)   
  KMMinus* = IUPmxCODE(K_minus)   
  KMPeriod* = IUPmxCODE(K_period)   
  KMSlash* = IUPmxCODE(K_slash)   
  KMSemicolon* = IUPmxCODE(K_semicolon) 
  KMEqual* = IUPmxCODE(K_equal)
  KMBracketleft* = IUPmxCODE(K_bracketleft)
  KMBracketright* = IUPmxCODE(K_bracketright)
  KMBackslash* = IUPmxCODE(K_backslash)
  KMAsterisk* = IUPmxCODE(K_asterisk)

  KYA* = IUPyxCODE(K_upperA)
  KYB* = IUPyxCODE(K_upperB)
  KYC* = IUPyxCODE(K_upperC)
  KYD* = IUPyxCODE(K_upperD)
  KYE* = IUPyxCODE(K_upperE)
  KYF* = IUPyxCODE(K_upperF)
  KYG* = IUPyxCODE(K_upperG)
  KYH* = IUPyxCODE(K_upperH)
  KYI* = IUPyxCODE(K_upperI)
  KYJ* = IUPyxCODE(K_upperJ)
  KYK* = IUPyxCODE(K_upperK)
  KYL* = IUPyxCODE(K_upperL)
  KYM* = IUPyxCODE(K_upperM)
  KYN* = IUPyxCODE(K_upperN)
  KYO* = IUPyxCODE(K_upperO)
  KYP* = IUPyxCODE(K_upperP)
  KYQ* = IUPyxCODE(K_upperQ)
  KYR* = IUPyxCODE(K_upperR)
  KYS* = IUPyxCODE(K_upperS)
  KYT* = IUPyxCODE(K_upperT)
  KYU* = IUPyxCODE(K_upperU)
  KYV* = IUPyxCODE(K_upperV)
  KYW* = IUPyxCODE(K_upperW)
  KYX* = IUPyxCODE(K_upperX)
  KYY* = IUPyxCODE(K_upperY)
  KYZ* = IUPyxCODE(K_upperZ)
  KY1* = IUPyxCODE(K_1)
  KY2* = IUPyxCODE(K_2)
  KY3* = IUPyxCODE(K_3)
  KY4* = IUPyxCODE(K_4)
  KY5* = IUPyxCODE(K_5)
  KY6* = IUPyxCODE(K_6)
  KY7* = IUPyxCODE(K_7)        
  KY8* = IUPyxCODE(K_8)         
  KY9* = IUPyxCODE(K_9)
  KY0* = IUPyxCODE(K_0)
  KYPlus* = IUPyxCODE(K_plus)
  KYComma* = IUPyxCODE(K_comma)
  KYMinus* = IUPyxCODE(K_minus)   
  KYPeriod* = IUPyxCODE(K_period)   
  KYSlash* = IUPyxCODE(K_slash)   
  KYSemicolon* = IUPyxCODE(K_semicolon) 
  KYEqual* = IUPyxCODE(K_equal)
  KYBracketleft* = IUPyxCODE(K_bracketleft)
  KYBracketright* = IUPyxCODE(K_bracketright)
  KYBackslash* = IUPyxCODE(K_backslash)
  KYAsterisk* = IUPyxCODE(K_asterisk)

proc controlsOpen*(): Cint {.cdecl, importc: "IupControlsOpen", dynlib: dllname.}
proc controlsClose*() {.cdecl, importc: "IupControlsClose", dynlib: dllname.}

proc oldValOpen*() {.cdecl, importc: "IupOldValOpen", dynlib: dllname.}
proc oldTabsOpen*() {.cdecl, importc: "IupOldTabsOpen", dynlib: dllname.}

proc colorbar*(): PIhandle {.cdecl, importc: "IupColorbar", dynlib: dllname.}
proc cells*(): PIhandle {.cdecl, importc: "IupCells", dynlib: dllname.}
proc colorBrowser*(): PIhandle {.cdecl, importc: "IupColorBrowser", dynlib: dllname.}
proc gauge*(): PIhandle {.cdecl, importc: "IupGauge", dynlib: dllname.}
proc dial*(theType: Cstring): PIhandle {.cdecl, importc: "IupDial", dynlib: dllname.}
proc matrix*(action: Cstring): PIhandle {.cdecl, importc: "IupMatrix", dynlib: dllname.}

# IupMatrix utilities
proc matSetAttribute*(ih: PIhandle, name: Cstring, lin, col: Cint, 
                      value: Cstring) {.
                      cdecl, importc: "IupMatSetAttribute", dynlib: dllname.}
proc matStoreAttribute*(ih: PIhandle, name: Cstring, lin, col: Cint, 
                        value: Cstring) {.cdecl, 
                        importc: "IupMatStoreAttribute", dynlib: dllname.}
proc matGetAttribute*(ih: PIhandle, name: Cstring, lin, col: Cint): Cstring {.
  cdecl, importc: "IupMatGetAttribute", dynlib: dllname.}
proc matGetInt*(ih: PIhandle, name: Cstring, lin, col: Cint): Cint {.
  cdecl, importc: "IupMatGetInt", dynlib: dllname.}
proc matGetFloat*(ih: PIhandle, name: Cstring, lin, col: Cint): Cfloat {.
  cdecl, importc: "IupMatGetFloat", dynlib: dllname.}
proc matSetfAttribute*(ih: PIhandle, name: Cstring, lin, col: Cint, 
                       format: Cstring) {.cdecl, 
                       importc: "IupMatSetfAttribute", 
                       dynlib: dllname, varargs.}

# Used by IupColorbar
const
  IupPrimary* = -1
  IupSecondary* = -2

# Initialize PPlot widget class
proc pPlotOpen*() {.cdecl, importc: "IupPPlotOpen", dynlib: dllname.}

# Create an PPlot widget instance
proc pPlot*: PIhandle {.cdecl, importc: "IupPPlot", dynlib: dllname.}

# Add dataset to plot
proc pPlotBegin*(ih: PIhandle, strXdata: Cint) {.
  cdecl, importc: "IupPPlotBegin", dynlib: dllname.}
proc pPlotAdd*(ih: PIhandle, x, y: Cfloat) {.
  cdecl, importc: "IupPPlotAdd", dynlib: dllname.}
proc pPlotAddStr*(ih: PIhandle, x: Cstring, y: Cfloat) {.
  cdecl, importc: "IupPPlotAddStr", dynlib: dllname.}
proc pPlotEnd*(ih: PIhandle): Cint {.
  cdecl, importc: "IupPPlotEnd", dynlib: dllname.}

proc pPlotInsertStr*(ih: PIhandle, index, sample_index: Cint, x: Cstring, 
                     y: Cfloat) {.cdecl, importc: "IupPPlotInsertStr", 
                     dynlib: dllname.}
proc pPlotInsert*(ih: PIhandle, index, sample_index: Cint, 
                  x, y: Cfloat) {.
                  cdecl, importc: "IupPPlotInsert", dynlib: dllname.}

# convert from plot coordinates to pixels
proc pPlotTransform*(ih: PIhandle, x, y: Cfloat, ix, iy: var Cint) {.
  cdecl, importc: "IupPPlotTransform", dynlib: dllname.}

# Plot on the given device. Uses a "cdCanvas*".
proc pPlotPaintTo*(ih: PIhandle, cnv: Pointer) {.
  cdecl, importc: "IupPPlotPaintTo", dynlib: dllname.}


