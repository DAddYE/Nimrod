#
# $Xorg: XI.h,v 1.4 2001/02/09 02:03:23 xorgcvs Exp $
#
#************************************************************
#
#Copyright 1989, 1998  The Open Group
#
#Permission to use, copy, modify, distribute, and sell this software and its
#documentation for any purpose is hereby granted without fee, provided that
#the above copyright notice appear in all copies and that both that
#copyright notice and this permission notice appear in supporting
#documentation.
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
#OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
#AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#Except as contained in this notice, the name of The Open Group shall not be
#used in advertising or otherwise to promote the sale, use or other dealings
#in this Software without prior written authorization from The Open Group.
#
#Copyright 1989 by Hewlett-Packard Company, Palo Alto, California.
#
#                        All Rights Reserved
#
#Permission to use, copy, modify, and distribute this software and its
#documentation for any purpose and without fee is hereby granted,
#provided that the above copyright notice appear in all copies and that
#both that copyright notice and this permission notice appear in
#supporting documentation, and that the name of Hewlett-Packard not be
#used in advertising or publicity pertaining to distribution of the
#software without specific, written prior permission.
#
#HEWLETT-PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
#ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
#HEWLETT-PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
#ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
#WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
#ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
#SOFTWARE.
#
#********************************************************/
# $XFree86: xc/include/extensions/XI.h,v 1.5 2001/12/14 19:53:28 dawes Exp $
#
# Definitions used by the server, library and client
#
#        Pascal Convertion was made by Ido Kannner - kanerido@actcom.net.il
#
#Histroy:
#        2004/10/15 - Fixed a bug of accessing second based records by removing "paced record" and chnaged it to
#                     "reocrd" only.
#        2004/10/07 - Removed the "uses X;" line. The unit does not need it.
#        2004/10/03 - Conversion from C header to Pascal unit.
#

const 
  szXGetExtensionVersionReq* = 8
  szXGetExtensionVersionReply* = 32
  szXListInputDevicesReq* = 4
  szXListInputDevicesReply* = 32
  szXOpenDeviceReq* = 8
  szXOpenDeviceReply* = 32
  szXCloseDeviceReq* = 8
  szXSetDeviceModeReq* = 8
  szXSetDeviceModeReply* = 32
  szXSelectExtensionEventReq* = 12
  szXGetSelectedExtensionEventsReq* = 8
  szXGetSelectedExtensionEventsReply* = 32
  szXChangeDeviceDontPropagateListReq* = 12
  szXGetDeviceDontPropagateListReq* = 8
  szXGetDeviceDontPropagateListReply* = 32
  szXGetDeviceMotionEventsReq* = 16
  szXGetDeviceMotionEventsReply* = 32
  szXChangeKeyboardDeviceReq* = 8
  szXChangeKeyboardDeviceReply* = 32
  szXChangePointerDeviceReq* = 8
  szXChangePointerDeviceReply* = 32
  szXGrabDeviceReq* = 20
  szXGrabDeviceReply* = 32
  szXUngrabDeviceReq* = 12
  szXGrabDeviceKeyReq* = 20
  szXGrabDeviceKeyReply* = 32
  szXUngrabDeviceKeyReq* = 16
  szXGrabDeviceButtonReq* = 20
  szXGrabDeviceButtonReply* = 32
  szXUngrabDeviceButtonReq* = 16
  szXAllowDeviceEventsReq* = 12
  szXGetDeviceFocusReq* = 8
  szXGetDeviceFocusReply* = 32
  szXSetDeviceFocusReq* = 16
  szXGetFeedbackControlReq* = 8
  szXGetFeedbackControlReply* = 32
  szXChangeFeedbackControlReq* = 12
  szXGetDeviceKeyMappingReq* = 8
  szXGetDeviceKeyMappingReply* = 32
  szXChangeDeviceKeyMappingReq* = 8
  szXGetDeviceModifierMappingReq* = 8
  szXSetDeviceModifierMappingReq* = 8
  szXSetDeviceModifierMappingReply* = 32
  szXGetDeviceButtonMappingReq* = 8
  szXGetDeviceButtonMappingReply* = 32
  szXSetDeviceButtonMappingReq* = 8
  szXSetDeviceButtonMappingReply* = 32
  szXQueryDeviceStateReq* = 8
  szXQueryDeviceStateReply* = 32
  szXSendExtensionEventReq* = 16
  szXDeviceBellReq* = 8
  szXSetDeviceValuatorsReq* = 8
  szXSetDeviceValuatorsReply* = 32
  szXGetDeviceControlReq* = 8
  szXGetDeviceControlReply* = 32
  szXChangeDeviceControlReq* = 8
  szXChangeDeviceControlReply* = 32

const 
  Iname* = "XInputExtension"

const 
  XiKeyboard* = "KEYBOARD"
  XiMouse* = "MOUSE"
  XiTablet* = "TABLET"
  XiTouchscreen* = "TOUCHSCREEN"
  XiTouchpad* = "TOUCHPAD"
  XiBarcode* = "BARCODE"
  XiButtonbox* = "BUTTONBOX"
  XiKnobBox* = "KNOB_BOX"
  XiOneKnob* = "ONE_KNOB"
  XiNineKnob* = "NINE_KNOB"
  XiTrackball* = "TRACKBALL"
  XiQuadrature* = "QUADRATURE"
  XiIdModule* = "ID_MODULE"
  XiSpaceball* = "SPACEBALL"
  XiDataglove* = "DATAGLOVE"
  XiEyetracker* = "EYETRACKER"
  XiCursorkeys* = "CURSORKEYS"
  XiFootmouse* = "FOOTMOUSE"

const 
  DontCheck* = 0
  XInputInitialRelease* = 1
  XInputAddXDeviceBell* = 2
  XInputAddXSetDeviceValuators* = 3
  XInputAddXChangeDeviceControl* = 4

const 
  XIAbsent* = 0
  XIPresent* = 1

const 
  XIInitialReleaseMajor* = 1
  XIInitialReleaseMinor* = 0

const 
  XIAddXDeviceBellMajor* = 1
  XIAddXDeviceBellMinor* = 1

const 
  XIAddXSetDeviceValuatorsMajor* = 1
  XIAddXSetDeviceValuatorsMinor* = 2

const 
  XIAddXChangeDeviceControlMajor* = 1
  XIAddXChangeDeviceControlMinor* = 3

const 
  DeviceResolution* = 1

const 
  NoSuchExtension* = 1

const 
  Count* = 0
  Create* = 1

const 
  NewPointer* = 0
  NewKeyboard* = 1

const 
  Xpointer* = 0
  Xkeyboard* = 1

const 
  UseXKeyboard* = 0x000000FF

const 
  IsXPointer* = 0
  IsXKeyboard* = 1
  IsXExtensionDevice* = 2

const 
  AsyncThisDevice* = 0
  SyncThisDevice* = 1
  ReplayThisDevice* = 2
  AsyncOtherDevices* = 3
  AsyncAll* = 4
  SyncAll* = 5

const 
  FollowKeyboard* = 3
  RevertToFollowKeyboard* = 3

const 
  DvAccelNum* = int(1) shl 0
  DvAccelDenom* = int(1) shl 1
  DvThreshold* = int(1) shl 2

const 
  DvKeyClickPercent* = int(1) shl 0
  DvPercent* = int(1) shl 1
  DvPitch* = int(1) shl 2
  DvDuration* = int(1) shl 3
  DvLed* = int(1) shl 4
  DvLedMode* = int(1) shl 5
  DvKey* = int(1) shl 6
  DvAutoRepeatMode* = 1 shl 7

const 
  DvString* = int(1) shl 0

const 
  DvInteger* = int(1) shl 0

const 
  DeviceMode* = int(1) shl 0
  Relative* = 0
  Absolute* = 1               # Merged from Metrolink tree for XINPUT stuff 
  TSRaw* = 57
  TSScaled* = 58
  SendCoreEvents* = 59
  DontSendCoreEvents* = 60    # End of merged section 

const 
  ProximityState* = int(1) shl 1
  InProximity* = int(0) shl 1
  OutOfProximity* = int(1) shl 1

const 
  AddToList* = 0
  DeleteFromList* = 1

const 
  KeyClass* = 0
  ButtonClass* = 1
  ValuatorClass* = 2
  FeedbackClass* = 3
  ProximityClass* = 4
  FocusClass* = 5
  OtherClass* = 6

const 
  KbdFeedbackClass* = 0
  PtrFeedbackClass* = 1
  StringFeedbackClass* = 2
  IntegerFeedbackClass* = 3
  LedFeedbackClass* = 4
  BellFeedbackClass* = 5

const 
  devicePointerMotionHint* = 0
  deviceButton1Motion* = 1
  deviceButton2Motion* = 2
  deviceButton3Motion* = 3
  deviceButton4Motion* = 4
  deviceButton5Motion* = 5
  deviceButtonMotion* = 6
  deviceButtonGrab* = 7
  deviceOwnerGrabButton* = 8
  noExtensionEvent* = 9

const 
  XIBadDevice* = 0
  XIBadEvent* = 1
  XIBadMode* = 2
  XIDeviceBusy* = 3
  XIBadClass* = 4 # Make XEventClass be a CARD32 for 64 bit servers.  Don't affect client
                   #  definition of XEventClass since that would be a library interface change.
                   #  See the top of X.h for more _XSERVER64 magic.
                   #

when defined(XSERVER64): 
  type 
    XEventClass* = CARD32
else: 
  type 
    XEventClass* = Int32
#******************************************************************
# *
# * Extension version structure.
# *
# 

type 
  PXExtensionVersion* = ptr TXExtensionVersion
  TXExtensionVersion*{.final.} = object 
    present*: Int16
    major_version*: Int16
    minor_version*: Int16


# implementation
