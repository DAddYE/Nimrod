#
# $Xorg: XKB.h,v 1.3 2000/08/18 04:05:45 coskrey Exp $
#************************************************************
# $Xorg: XKBstr.h,v 1.3 2000/08/18 04:05:45 coskrey Exp $
#************************************************************
# $Xorg: XKBgeom.h,v 1.3 2000/08/18 04:05:45 coskrey Exp $
#************************************************************
#
#Copyright (c) 1993 by Silicon Graphics Computer Systems, Inc.
#
#Permission to use, copy, modify, and distribute this
#software and its documentation for any purpose and without
#fee is hereby granted, provided that the above copyright
#notice appear in all copies and that both that copyright
#notice and this permission notice appear in supporting
#documentation, and that the name of Silicon Graphics not be
#used in advertising or publicity pertaining to distribution
#of the software without specific prior written permission.
#Silicon Graphics makes no representation about the suitability
#of this software for any purpose. It is provided "as is"
#without any express or implied warranty.
#
#SILICON GRAPHICS DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS
#SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
#AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SILICON
#GRAPHICS BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL
#DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
#DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
#OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
#THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
#********************************************************
# $XFree86: xc/include/extensions/XKB.h,v 1.5 2002/11/20 04:49:01 dawes Exp $
# $XFree86: xc/include/extensions/XKBgeom.h,v 3.9 2002/09/18 17:11:40 tsi Exp $
#
# Pascal Convertion was made by Ido Kannner - kanerido@actcom.net.il
#
#Thanks:
#         I want to thanks to oliebol for putting up with all of the problems that was found
#         while translating this code. ;)
#
#         I want to thanks #fpc channel in freenode irc, for helping me, and to put up with my
#         wierd questions ;)
#
#         Thanks for mmc in #xlib on freenode irc And so for the channel itself for the helping me to
#         understanding some of the problems I had converting this headers and pointing me to resources
#         that helped translating this headers.
#
# Ido
#
#History:
#        2004/10/15           - Fixed a bug of accessing second based records by removing "paced record" and
#                               chnaged it to "reocrd" only.
#        2004/10/04 - 06      - Convertion from the c header of XKBgeom.h.
#        2004/10/03           - Removed the XKBstr_UNIT compiler decleration. Afther the joined files,
#                                                                                     There is no need for it anymore.
#                                                                             - There is a need to define (for now) XKBgeom (compiler define) in order
#                                                                               to use the code of it. At this moment, I did not yet converted it to Pascal.
#
#        2004/09/17 - 10/04   - Convertion from the c header of XKBstr.
#
#        2004/10/03           - Joined xkbstr.pas into xkb.pas because of the circular calls problems.
#                             - Added the history of xkbstr.pas above this addition.
#
#        2004/09/17           - Fixed a wrong convertion number of XkbPerKeyBitArraySize, insted
#                               of float, it's now converted into integer (as it should have been).
#
#        2004/09/15 - 16      - Convertion from the c header of XKB.h.
#

import 
  X, Xlib

include "x11pragma.nim"

proc xkbCharToInt*(v: Int8): Int16
proc xkbIntTo2Chars*(i: Int16, h, L: var Int8)
proc xkb2CharsToInt*(h, L: Int8): Int16
  #
  #          Common data structures and access macros
  #        
type
  PWord* = ptr Array[0..64_000, Int16]
  PByte* = ptr Byte
  PXkbStatePtr* = ptr TXkbStateRec
  TXkbStateRec*{.final.} = object 
    group*: Int8
    lockedGroup*: Int8
    baseGroup*: Int16
    latchedGroup*: Int16
    mods*: Int8
    baseMods*: Int8
    latchedMods*: Int8
    lockedMods*: Int8
    compat_state*: Int8
    grabMods*: Int8
    compat_grab_mods*: Int8
    lookupMods*: Int8
    compat_lookup_mods*: Int8
    ptr_buttons*: Int16


proc xkbModLocks*(s: PXkbStatePtr): Int8
proc xkbStateMods*(s: PXkbStatePtr): Int16
proc xkbGroupLock*(s: PXkbStatePtr): Int8
proc xkbStateGroup*(s: PXkbStatePtr): Int16
proc xkbStateFieldFromRec*(s: PXkbStatePtr): Int
proc xkbGrabStateFromRec*(s: PXkbStatePtr): Int
type 
  PXkbModsPtr* = ptr TXkbModsRec
  TXkbModsRec*{.final.} = object 
    mask*: Int8               # effective mods
    real_mods*: Int8
    vmods*: Int16


type 
  PXkbKTMapEntryPtr* = ptr TXkbKTMapEntryRec
  TXkbKTMapEntryRec*{.final.} = object 
    active*: Bool
    level*: Int8
    mods*: TXkbModsRec


type 
  PXkbKeyTypePtr* = ptr TXkbKeyTypeRec
  TXkbKeyTypeRec*{.final.} = object 
    mods*: TXkbModsRec
    numLevels*: Int8
    map_count*: Int8
    map*: PXkbKTMapEntryPtr
    preserve*: PXkbModsPtr
    name*: TAtom
    level_names*: TAtom


proc xkbNumGroups*(g: Int16): Int16
proc xkbOutOfRangeGroupInfo*(g: Int16): Int16
proc xkbOutOfRangeGroupAction*(g: Int16): Int16
proc xkbOutOfRangeGroupNumber*(g: Int16): Int16
proc xkbSetGroupInfo*(g, w, n: Int16): Int16
proc xkbSetNumGroups*(g, n: Int16): Int16
  #
  #          Structures and access macros used primarily by the server
  #        
type 
  PXkbBehavior* = ptr TXkbBehavior
  TXkbBehavior*{.final.} = object 
    theType*: Int8
    data*: Int8


type 
  PXkbModAction* = ptr TXkbModAction
  TXkbModAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    mask*: Int8
    real_mods*: Int8
    vmods1*: Int8
    vmods2*: Int8


proc xkbModActionVMods*(a: PXkbModAction): Int16
proc xkbSetModActionVMods*(a: PXkbModAction, v: Int8)
type 
  PXkbGroupAction* = ptr TXkbGroupAction
  TXkbGroupAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    groupXXX*: Int8


proc xkbSAGroup*(a: PXkbGroupAction): Int8
proc xkbSASetGroupProc*(a: PXkbGroupAction, g: Int8)
type 
  PXkbISOAction* = ptr TXkbISOAction
  TXkbISOAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    mask*: Int8
    real_mods*: Int8
    group_XXX*: Int8
    affect*: Int8
    vmods1*: Int8
    vmods2*: Int8


type 
  PXkbPtrAction* = ptr TXkbPtrAction
  TXkbPtrAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    highXXX*: Int8
    lowXXX*: Int8
    highYYY*: Int8
    lowYYY*: Int8


proc xkbPtrActionX*(a: PXkbPtrAction): Int16
proc xkbPtrActionY*(a: PXkbPtrAction): Int16
proc xkbSetPtrActionX*(a: PXkbPtrAction, x: Int8)
proc xkbSetPtrActionY*(a: PXkbPtrAction, y: Int8)
type 
  PXkbPtrBtnAction* = ptr TXkbPtrBtnAction
  TXkbPtrBtnAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    count*: Int8
    button*: Int8


type 
  PXkbPtrDfltAction* = ptr TXkbPtrDfltAction
  TXkbPtrDfltAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    affect*: Int8
    valueXXX*: Int8


proc xkbSAPtrDfltValue*(a: PXkbPtrDfltAction): Int8
proc xkbSASetPtrDfltValue*(a: PXkbPtrDfltAction, c: Pointer)
type 
  PXkbSwitchScreenAction* = ptr TXkbSwitchScreenAction
  TXkbSwitchScreenAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    screenXXX*: Int8


proc xkbSAScreen*(a: PXkbSwitchScreenAction): Int8
proc xkbSASetScreen*(a: PXkbSwitchScreenAction, s: Pointer)
type 
  PXkbCtrlsAction* = ptr TXkbCtrlsAction
  TXkbCtrlsAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    ctrls3*: Int8
    ctrls2*: Int8
    ctrls1*: Int8
    ctrls0*: Int8


proc xkbActionSetCtrls*(a: PXkbCtrlsAction, c: Int8)
proc xkbActionCtrls*(a: PXkbCtrlsAction): Int16
type 
  PXkbMessageAction* = ptr TXkbMessageAction
  TXkbMessageAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    message*: Array[0..5, Char]


type 
  PXkbRedirectKeyAction* = ptr TXkbRedirectKeyAction
  TXkbRedirectKeyAction*{.final.} = object 
    theType*: Int8
    new_key*: Int8
    mods_mask*: Int8
    mods*: Int8
    vmodsMask0*: Int8
    vmodsMask1*: Int8
    vmods0*: Int8
    vmods1*: Int8


proc xkbSARedirectVMods*(a: PXkbRedirectKeyAction): Int16
proc xkbSARedirectSetVMods*(a: PXkbRedirectKeyAction, m: Int8)
proc xkbSARedirectVModsMask*(a: PXkbRedirectKeyAction): Int16
proc xkbSARedirectSetVModsMask*(a: PXkbRedirectKeyAction, m: Int8)
type 
  PXkbDeviceBtnAction* = ptr TXkbDeviceBtnAction
  TXkbDeviceBtnAction*{.final.} = object 
    theType*: Int8
    flags*: Int8
    count*: Int8
    button*: Int8
    device*: Int8


type 
  PXkbDeviceValuatorAction* = ptr TXkbDeviceValuatorAction
  TXkbDeviceValuatorAction*{.final.} = object  #
                                               #      Macros to classify key actions
                                               #                
    theType*: Int8
    device*: Int8
    v1_what*: Int8
    v1_ndx*: Int8
    v1_value*: Int8
    v2_what*: Int8
    v2_ndx*: Int8
    v2_value*: Int8


const 
  XkbAnyActionDataSize* = 7

type 
  PXkbAnyAction* = ptr TXkbAnyAction
  TXkbAnyAction*{.final.} = object 
    theType*: Int8
    data*: Array[0..XkbAnyActionDataSize - 1, Int8]


proc xkbIsModAction*(a: PXkbAnyAction): Bool
proc xkbIsGroupAction*(a: PXkbAnyAction): Bool
proc xkbIsPtrAction*(a: PXkbAnyAction): Bool
type 
  PXkbAction* = ptr TXkbAction
  TXkbAction*{.final.} = object  #
                                 #      XKB request codes, used in:
                                 #      -  xkbReqType field of all requests
                                 #      -  requestMinor field of some events
                                 #                
    any*: TXkbAnyAction
    mods*: TXkbModAction
    group*: TXkbGroupAction
    iso*: TXkbISOAction
    thePtr*: TXkbPtrAction
    btn*: TXkbPtrBtnAction
    dflt*: TXkbPtrDfltAction
    screen*: TXkbSwitchScreenAction
    ctrls*: TXkbCtrlsAction
    msg*: TXkbMessageAction
    redirect*: TXkbRedirectKeyAction
    devbtn*: TXkbDeviceBtnAction
    devval*: TXkbDeviceValuatorAction
    theType*: Int8


const 
  XKbUseExtension* = 0
  XKbSelectEvents* = 1
  XKbBell* = 3
  XKbGetState* = 4
  XKbLatchLockState* = 5
  XKbGetControls* = 6
  XKbSetControls* = 7
  XKbGetMap* = 8
  XKbSetMap* = 9
  XKbGetCompatMap* = 10
  XKbSetCompatMap* = 11
  XKbGetIndicatorState* = 12
  XKbGetIndicatorMap* = 13
  XKbSetIndicatorMap* = 14
  XKbGetNamedIndicator* = 15
  XKbSetNamedIndicator* = 16
  XKbGetNames* = 17
  XKbSetNames* = 18
  XKbGetGeometry* = 19
  XKbSetGeometry* = 20
  XKbPerClientFlags* = 21
  XKbListComponents* = 22
  XKbGetKbdByName* = 23
  XKbGetDeviceInfo* = 24
  XKbSetDeviceInfo* = 25
  XKbSetDebuggingFlags* = 101 #
                               #      In the X sense, XKB reports only one event.
                               #      The type field of all XKB events is XkbEventCode
                               #                

const 
  XkbEventCode* = 0
  XkbNumberEvents* = XkbEventCode + 1 #
                                      #      XKB has a minor event code so it can use one X event code for
                                      #      multiple purposes.
                                      #       - reported in the xkbType field of all XKB events.
                                      #       - XkbSelectEventDetails: Indicates the event for which event details
                                      #         are being changed
                                      #                

const 
  XkbNewKeyboardNotify* = 0
  XkbMapNotify* = 1
  XkbStateNotify* = 2
  XkbControlsNotify* = 3
  XkbIndicatorStateNotify* = 4
  XkbIndicatorMapNotify* = 5
  XkbNamesNotify* = 6
  XkbCompatMapNotify* = 7
  XkbBellNotify* = 8
  XkbActionMessage* = 9
  XkbAccessXNotify* = 10
  XkbExtensionDeviceNotify* = 11 #
                                 #      Event Mask:
                                 #       - XkbSelectEvents:  Specifies event interest.
                                 #    

const 
  XkbNewKeyboardNotifyMask* = int(1) shl 0
  XkbMapNotifyMask* = int(1) shl 1
  XkbStateNotifyMask* = int(1) shl 2
  XkbControlsNotifyMask* = int(1) shl 3
  XkbIndicatorStateNotifyMask* = int(1) shl 4
  XkbIndicatorMapNotifyMask* = int(1) shl 5
  XkbNamesNotifyMask* = int(1) shl 6
  XkbCompatMapNotifyMask* = int(1) shl 7
  XkbBellNotifyMask* = int(1) shl 8
  XkbActionMessageMask* = int(1) shl 9
  XkbAccessXNotifyMask* = int(1) shl 10
  XkbExtensionDeviceNotifyMask* = int(1) shl 11
  XkbAllEventsMask* = 0x00000FFF #
                                 #      NewKeyboardNotify event details:
                                 #    

const 
  XkbNKNKeycodesMask* = int(1) shl 0
  XkbNKNGeometryMask* = int(1) shl 1
  XkbNKNDeviceIDMask* = int(1) shl 2
  XkbAllNewKeyboardEventsMask* = 0x00000007 #
                                            #      AccessXNotify event types:
                                            #       - The 'what' field of AccessXNotify events reports the
                                            #         reason that the event was generated.
                                            #                

const 
  XkbAXNSKPress* = 0
  XkbAXNSKAccept* = 1
  XkbAXNSKReject* = 2
  XkbAXNSKRelease* = 3
  XkbAXNBKAccept* = 4
  XkbAXNBKReject* = 5
  XkbAXNAXKWarning* = 6 #
                         #      AccessXNotify details:
                         #      - Used as an event detail mask to limit the conditions under which
                         #        AccessXNotify events are reported
                         #                

const 
  XkbAXNSKPressMask* = int(1) shl 0
  XkbAXNSKAcceptMask* = int(1) shl 1
  XkbAXNSKRejectMask* = int(1) shl 2
  XkbAXNSKReleaseMask* = int(1) shl 3
  XkbAXNBKAcceptMask* = int(1) shl 4
  XkbAXNBKRejectMask* = int(1) shl 5
  XkbAXNAXKWarningMask* = int(1) shl 6
  XkbAllAccessXEventsMask* = 0x0000000F #
                                        #      State detail mask:
                                        #       - The 'changed' field of StateNotify events reports which of
                                        #         the keyboard state components have changed.
                                        #       - Used as an event detail mask to limit the conditions under
                                        #         which StateNotify events are reported.
                                        #                

const 
  XkbModifierStateMask* = int(1) shl 0
  XkbModifierBaseMask* = int(1) shl 1
  XkbModifierLatchMask* = int(1) shl 2
  XkbModifierLockMask* = int(1) shl 3
  XkbGroupStateMask* = int(1) shl 4
  XkbGroupBaseMask* = int(1) shl 5
  XkbGroupLatchMask* = int(1) shl 6
  XkbGroupLockMask* = int(1) shl 7
  XkbCompatStateMask* = int(1) shl 8
  XkbGrabModsMask* = int(1) shl 9
  XkbCompatGrabModsMask* = int(1) shl 10
  XkbLookupModsMask* = int(1) shl 11
  XkbCompatLookupModsMask* = int(1) shl 12
  XkbPointerButtonMask* = int(1) shl 13
  XkbAllStateComponentsMask* = 0x00003FFF #
                                          #      Controls detail masks:
                                          #       The controls specified in XkbAllControlsMask:
                                          #       - The 'changed' field of ControlsNotify events reports which of
                                          #         the keyboard controls have changed.
                                          #       - The 'changeControls' field of the SetControls request specifies
                                          #         the controls for which values are to be changed.
                                          #       - Used as an event detail mask to limit the conditions under
                                          #         which ControlsNotify events are reported.
                                          #
                                          #       The controls specified in the XkbAllBooleanCtrlsMask:
                                          #       - The 'enabledControls' field of ControlsNotify events reports the
                                          #         current status of the boolean controls.
                                          #       - The 'enabledControlsChanges' field of ControlsNotify events reports
                                          #         any boolean controls that have been turned on or off.
                                          #       - The 'affectEnabledControls' and 'enabledControls' fields of the
                                          #         kbSetControls request change the set of enabled controls.
                                          #       - The 'accessXTimeoutMask' and 'accessXTimeoutValues' fields of
                                          #         an XkbControlsRec specify the controls to be changed if the keyboard
                                          #         times out and the values to which they should be changed.
                                          #       - The 'autoCtrls' and 'autoCtrlsValues' fields of the PerClientFlags
                                          #         request specifies the specify the controls to be reset when the
                                          #         client exits and the values to which they should be reset.
                                          #       - The 'ctrls' field of an indicator map specifies the controls
                                          #         that drive the indicator.
                                          #       - Specifies the boolean controls affected by the SetControls and
                                          #         LockControls key actions.
                                          #                

const 
  XkbRepeatKeysMask* = int(1) shl 0
  XkbSlowKeysMask* = int(1) shl 1
  XkbBounceKeysMask* = int(1) shl 2
  XkbStickyKeysMask* = int(1) shl 3
  XkbMouseKeysMask* = int(1) shl 4
  XkbMouseKeysAccelMask* = int(1) shl 5
  XkbAccessXKeysMask* = int(1) shl 6
  XkbAccessXTimeoutMask* = int(1) shl 7
  XkbAccessXFeedbackMask* = int(1) shl 8
  XkbAudibleBellMask* = int(1) shl 9
  XkbOverlay1Mask* = int(1) shl 10
  XkbOverlay2Mask* = int(1) shl 11
  XkbIgnoreGroupLockMask* = int(1) shl 12
  XkbGroupsWrapMask* = int(1) shl 27
  XkbInternalModsMask* = int(1) shl 28
  XkbIgnoreLockModsMask* = int(1) shl 29
  XkbPerKeyRepeatMask* = int(1) shl 30
  XkbControlsEnabledMask* = int(1) shl 31
  XkbAccessXOptionsMask* = XkbStickyKeysMask or XkbAccessXFeedbackMask
  XkbAllBooleanCtrlsMask* = 0x00001FFF
  XkbAllControlsMask* = 0xF8001FFF #
                                   #      Compatibility Map Compontents:
                                   #       - Specifies the components to be allocated in XkbAllocCompatMap.
                                   #                

const 
  XkbSymInterpMask* = 1 shl 0
  XkbGroupCompatMask* = 1 shl 1
  XkbAllCompatMask* = 0x00000003 #
                                 #      Assorted constants and limits.
                                 #                

const 
  XkbAllIndicatorsMask* = 0xFFFFFFFF #
                                     #      Map components masks:
                                     #      Those in AllMapComponentsMask:
                                     #       - Specifies the individual fields to be loaded or changed for the
                                     #         GetMap and SetMap requests.
                                     #      Those in ClientInfoMask:
                                     #       - Specifies the components to be allocated by XkbAllocClientMap.
                                     #      Those in ServerInfoMask:
                                     #       - Specifies the components to be allocated by XkbAllocServerMap.
                                     #                

const 
  XkbKeyTypesMask* = 1 shl 0
  XkbKeySymsMask* = 1 shl 1
  XkbModifierMapMask* = 1 shl 2
  XkbExplicitComponentsMask* = 1 shl 3
  XkbKeyActionsMask* = 1 shl 4
  XkbKeyBehaviorsMask* = 1 shl 5
  XkbVirtualModsMask* = 1 shl 6
  XkbVirtualModMapMask* = 1 shl 7
  XkbAllClientInfoMask* = XkbKeyTypesMask or XkbKeySymsMask or
      XkbModifierMapMask
  XkbAllServerInfoMask* = XkbExplicitComponentsMask or XkbKeyActionsMask or
      XkbKeyBehaviorsMask or XkbVirtualModsMask or XkbVirtualModMapMask
  XkbAllMapComponentsMask* = XkbAllClientInfoMask or XkbAllServerInfoMask #
                                                                          #      Names component mask:
                                                                          #       - Specifies the names to be loaded or changed for the GetNames and
                                                                          #         SetNames requests.
                                                                          #       - Specifies the names that have changed in a NamesNotify event.
                                                                          #       - Specifies the names components to be allocated by XkbAllocNames.
                                                                          #                

const 
  XkbKeycodesNameMask* = 1 shl 0
  XkbGeometryNameMask* = 1 shl 1
  XkbSymbolsNameMask* = 1 shl 2
  XkbPhysSymbolsNameMask* = 1 shl 3
  XkbTypesNameMask* = 1 shl 4
  XkbCompatNameMask* = 1 shl 5
  XkbKeyTypeNamesMask* = 1 shl 6
  XkbKTLevelNamesMask* = 1 shl 7
  XkbIndicatorNamesMask* = 1 shl 8
  XkbKeyNamesMask* = 1 shl 9
  XkbKeyAliasesMask* = 1 shl 10
  XkbVirtualModNamesMask* = 1 shl 11
  XkbGroupNamesMask* = 1 shl 12
  XkbRGNamesMask* = 1 shl 13
  XkbComponentNamesMask* = 0x0000003F
  XkbAllNamesMask* = 0x00003FFF #
                                #      Miscellaneous event details:
                                #      - event detail masks for assorted events that don't reall
                                #        have any details.
                                #                

const 
  XkbAllStateEventsMask* = XkbAllStateComponentsMask
  XkbAllMapEventsMask* = XkbAllMapComponentsMask
  XkbAllControlEventsMask* = XkbAllControlsMask
  XkbAllIndicatorEventsMask* = XkbAllIndicatorsMask
  XkbAllNameEventsMask* = XkbAllNamesMask
  XkbAllCompatMapEventsMask* = XkbAllCompatMask
  XkbAllBellEventsMask* = int(1) shl 0
  XkbAllActionMessagesMask* = int(1) shl 0 #
                                           #      XKB reports one error:  BadKeyboard
                                           #      A further reason for the error is encoded into to most significant
                                           #      byte of the resourceID for the error:
                                           #         XkbErr_BadDevice - the device in question was not found
                                           #         XkbErr_BadClass  - the device was found but it doesn't belong to
                                           #                            the appropriate class.
                                           #         XkbErr_BadId     - the device was found and belongs to the right
                                           #                            class, but not feedback with a matching id was
                                           #                            found.
                                           #      The low byte of the resourceID for this error contains the device
                                           #      id, class specifier or feedback id that failed.
                                           #                

const 
  XkbKeyboard* = 0
  XkbNumberErrors* = 1
  XkbErrBadDevice* = 0x000000FF
  XkbErrBadClass* = 0x000000FE
  XkbErrBadId* = 0x000000FD #
                             #      Keyboard Components Mask:
                             #      - Specifies the components that follow a GetKeyboardByNameReply
                             #                

const 
  XkbClientMapMask* = int(1) shl 0
  XkbServerMapMask* = int(1) shl 1
  XkbCompatMapMask* = int(1) shl 2
  XkbIndicatorMapMask* = int(1) shl 3
  XkbNamesMask* = int(1) shl 4
  XkbGeometryMask* = int(1) shl 5
  XkbControlsMask* = int(1) shl 6
  XkbAllComponentsMask* = 0x0000007F #
                                     #      AccessX Options Mask
                                     #       - The 'accessXOptions' field of an XkbControlsRec specifies the
                                     #         AccessX options that are currently in effect.
                                     #       - The 'accessXTimeoutOptionsMask' and 'accessXTimeoutOptionsValues'
                                     #         fields of an XkbControlsRec specify the Access X options to be
                                     #         changed if the keyboard times out and the values to which they
                                     #         should be changed.
                                     #                

const 
  XkbAXSKPressFBMask* = int(1) shl 0
  XkbAXSKAcceptFBMask* = int(1) shl 1
  XkbAXFeatureFBMask* = int(1) shl 2
  XkbAXSlowWarnFBMask* = int(1) shl 3
  XkbAXIndicatorFBMask* = int(1) shl 4
  XkbAXStickyKeysFBMask* = int(1) shl 5
  XkbAXTwoKeysMask* = int(1) shl 6
  XkbAXLatchToLockMask* = int(1) shl 7
  XkbAXSKReleaseFBMask* = int(1) shl 8
  XkbAXSKRejectFBMask* = int(1) shl 9
  XkbAXBKRejectFBMask* = int(1) shl 10
  XkbAXDumbBellFBMask* = int(1) shl 11
  XkbAXFBOptionsMask* = 0x00000F3F
  XkbAXSKOptionsMask* = 0x000000C0
  XkbAXAllOptionsMask* = 0x00000FFF #
                                     #      XkbUseCoreKbd is used to specify the core keyboard without having
                                     #                        to look up its X input extension identifier.
                                     #      XkbUseCorePtr is used to specify the core pointer without having
                                     #                        to look up its X input extension identifier.
                                     #      XkbDfltXIClass is used to specify "don't care" any place that the
                                     #                        XKB protocol is looking for an X Input Extension
                                     #                        device class.
                                     #      XkbDfltXIId is used to specify "don't care" any place that the
                                     #                        XKB protocol is looking for an X Input Extension
                                     #                        feedback identifier.
                                     #      XkbAllXIClasses is used to get information about all device indicators,
                                     #                        whether they're part of the indicator feedback class
                                     #                        or the keyboard feedback class.
                                     #      XkbAllXIIds is used to get information about all device indicator
                                     #                        feedbacks without having to list them.
                                     #      XkbXINone is used to indicate that no class or id has been specified.
                                     #      XkbLegalXILedClass(c)  True if 'c' specifies a legal class with LEDs
                                     #      XkbLegalXIBellClass(c) True if 'c' specifies a legal class with bells
                                     #      XkbExplicitXIDevice(d) True if 'd' explicitly specifies a device
                                     #      XkbExplicitXIClass(c)  True if 'c' explicitly specifies a device class
                                     #      XkbExplicitXIId(c)     True if 'i' explicitly specifies a device id
                                     #      XkbSingleXIClass(c)    True if 'c' specifies exactly one device class,
                                     #                             including the default.
                                     #      XkbSingleXIId(i)       True if 'i' specifies exactly one device
                                     #                              identifier, including the default.
                                     #                

const 
  XkbUseCoreKbd* = 0x00000100
  XkbUseCorePtr* = 0x00000200
  XkbDfltXIClass* = 0x00000300
  XkbDfltXIId* = 0x00000400
  XkbAllXIClasses* = 0x00000500
  XkbAllXIIds* = 0x00000600
  XkbXINone* = 0x0000FF00

proc xkbLegalXILedClass*(c: Int): Bool
proc xkbLegalXIBellClass*(c: Int): Bool
proc xkbExplicitXIDevice*(c: Int): Bool
proc xkbExplicitXIClass*(c: Int): Bool
proc xkbExplicitXIId*(c: Int): Bool
proc xkbSingleXIClass*(c: Int): Bool
proc xkbSingleXIId*(c: Int): Bool
const 
  XkbNoModifier* = 0x000000FF
  XkbNoShiftLevel* = 0x000000FF
  XkbNoShape* = 0x000000FF
  XkbNoIndicator* = 0x000000FF
  XkbNoModifierMask* = 0
  XkbAllModifiersMask* = 0x000000FF
  XkbAllVirtualModsMask* = 0x0000FFFF
  XkbNumKbdGroups* = 4
  XkbMaxKbdGroup* = XkbNumKbdGroups - 1
  XkbMaxMouseKeysBtn* = 4 #
                          #      Group Index and Mask:
                          #       - Indices into the kt_index array of a key type.
                          #       - Mask specifies types to be changed for XkbChangeTypesOfKey
                          #    

const 
  XkbGroup1Index* = 0
  XkbGroup2Index* = 1
  XkbGroup3Index* = 2
  XkbGroup4Index* = 3
  XkbAnyGroup* = 254
  XkbAllGroups* = 255
  XkbGroup1Mask* = 1 shl 0
  XkbGroup2Mask* = 1 shl 1
  XkbGroup3Mask* = 1 shl 2
  XkbGroup4Mask* = 1 shl 3
  XkbAnyGroupMask* = 1 shl 7
  XkbAllGroupsMask* = 0x0000000F #
                                 #      BuildCoreState: Given a keyboard group and a modifier state,
                                 #                      construct the value to be reported an event.
                                 #      GroupForCoreState:  Given the state reported in an event,
                                 #                      determine the keyboard group.
                                 #      IsLegalGroup:   Returns TRUE if 'g' is a valid group index.
                                 #                

proc xkbBuildCoreState*(m, g: Int): Int
proc xkbGroupForCoreState*(s: Int): Int
proc xkbIsLegalGroup*(g: Int): Bool
  #
  #      GroupsWrap values:
  #       - The 'groupsWrap' field of an XkbControlsRec specifies the
  #         treatment of out of range groups.
  #       - Bits 6 and 7 of the group info field of a key symbol map
  #         specify the interpretation of out of range groups for the
  #         corresponding key.
  #                
const 
  XkbWrapIntoRange* = 0x00000000
  XkbClampIntoRange* = 0x00000040
  XkbRedirectIntoRange* = 0x00000080 #
                                     #      Action flags:  Reported in the 'flags' field of most key actions.
                                     #      Interpretation depends on the type of the action; not all actions
                                     #      accept all flags.
                                     #
                                     #      Option                    Used for Actions
                                     #      ------                    ----------------
                                     #      ClearLocks                SetMods, LatchMods, SetGroup, LatchGroup
                                     #      LatchToLock               SetMods, LatchMods, SetGroup, LatchGroup
                                     #      LockNoLock                LockMods, ISOLock, LockPtrBtn, LockDeviceBtn
                                     #      LockNoUnlock              LockMods, ISOLock, LockPtrBtn, LockDeviceBtn
                                     #      UseModMapMods             SetMods, LatchMods, LockMods, ISOLock
                                     #      GroupAbsolute             SetGroup, LatchGroup, LockGroup, ISOLock
                                     #      UseDfltButton             PtrBtn, LockPtrBtn
                                     #      NoAcceleration            MovePtr
                                     #      MoveAbsoluteX             MovePtr
                                     #      MoveAbsoluteY             MovePtr
                                     #      ISODfltIsGroup            ISOLock
                                     #      ISONoAffectMods           ISOLock
                                     #      ISONoAffectGroup          ISOLock
                                     #      ISONoAffectPtr            ISOLock
                                     #      ISONoAffectCtrls          ISOLock
                                     #      MessageOnPress            ActionMessage
                                     #      MessageOnRelease          ActionMessage
                                     #      MessageGenKeyEvent        ActionMessage
                                     #      AffectDfltBtn             SetPtrDflt
                                     #      DfltBtnAbsolute           SetPtrDflt
                                     #      SwitchApplication SwitchScreen
                                     #      SwitchAbsolute            SwitchScreen
                                     #                

const 
  XkbSAClearLocks* = int(1) shl 0
  XkbSALatchToLock* = int(1) shl 1
  XkbSALockNoLock* = int(1) shl 0
  XkbSALockNoUnlock* = int(1) shl 1
  XkbSAUseModMapMods* = int(1) shl 2
  XkbSAGroupAbsolute* = int(1) shl 2
  XkbSAUseDfltButton* = 0
  XkbSANoAcceleration* = int(1) shl 0
  XkbSAMoveAbsoluteX* = int(1) shl 1
  XkbSAMoveAbsoluteY* = int(1) shl 2
  XkbSAISODfltIsGroup* = int(1) shl 7
  XkbSAISONoAffectMods* = int(1) shl 6
  XkbSAISONoAffectGroup* = int(1) shl 5
  XkbSAISONoAffectPtr* = int(1) shl 4
  XkbSAISONoAffectCtrls* = int(1) shl 3
  XkbSAISOAffectMask* = 0x00000078
  XkbSAMessageOnPress* = int(1) shl 0
  XkbSAMessageOnRelease* = int(1) shl 1
  XkbSAMessageGenKeyEvent* = int(1) shl 2
  XkbSAAffectDfltBtn* = 1
  XkbSADfltBtnAbsolute* = int(1) shl 2
  XkbSASwitchApplication* = int(1) shl 0
  XkbSASwitchAbsolute* = int(1) shl 2 #
                                       #      The following values apply to the SA_DeviceValuator
                                       #      action only.  Valuator operations specify the action
                                       #      to be taken.   Values specified in the action are
                                       #      multiplied by 2^scale before they are applied.
                                       #                

const 
  XkbSAIgnoreVal* = 0x00000000
  XkbSASetValMin* = 0x00000010
  XkbSASetValCenter* = 0x00000020
  XkbSASetValMax* = 0x00000030
  XkbSASetValRelative* = 0x00000040
  XkbSASetValAbsolute* = 0x00000050
  XkbSAValOpMask* = 0x00000070
  XkbSAValScaleMask* = 0x00000007

proc xkbSAValOp*(a: Int): Int
proc xkbSAValScale*(a: Int): Int
  #
  #      Action types: specifies the type of a key action.  Reported in the
  #      type field of all key actions.
  #                
const 
  XkbSANoAction* = 0x00000000
  XkbSASetMods* = 0x00000001
  XkbSALatchMods* = 0x00000002
  XkbSALockMods* = 0x00000003
  XkbSASetGroup* = 0x00000004
  XkbSALatchGroup* = 0x00000005
  XkbSALockGroup* = 0x00000006
  XkbSAMovePtr* = 0x00000007
  XkbSAPtrBtn* = 0x00000008
  XkbSALockPtrBtn* = 0x00000009
  XkbSASetPtrDflt* = 0x0000000A
  XkbSAISOLock* = 0x0000000B
  XkbSATerminate* = 0x0000000C
  XkbSASwitchScreen* = 0x0000000D
  XkbSASetControls* = 0x0000000E
  XkbSALockControls* = 0x0000000F
  XkbSAActionMessage* = 0x00000010
  XkbSARedirectKey* = 0x00000011
  XkbSADeviceBtn* = 0x00000012
  XkbSALockDeviceBtn* = 0x00000013
  XkbSADeviceValuator* = 0x00000014
  XkbSALastAction* = XkbSA_DeviceValuator
  XkbSANumActions* = XkbSA_LastAction + 1

const 
  XkbSAXFree86Private* = 0x00000086
#
#      Specifies the key actions that clear latched groups or modifiers.
#                

const  ##define        XkbSA_BreakLatch \
       #        ((1<<XkbSA_NoAction)|(1<<XkbSA_PtrBtn)|(1<<XkbSA_LockPtrBtn)|\
       #        (1<<XkbSA_Terminate)|(1<<XkbSA_SwitchScreen)|(1<<XkbSA_SetControls)|\
       #        (1<<XkbSA_LockControls)|(1<<XkbSA_ActionMessage)|\
       #        (1<<XkbSA_RedirectKey)|(1<<XkbSA_DeviceBtn)|(1<<XkbSA_LockDeviceBtn))
       #
  XkbSABreakLatch* = (1 shl XkbSA_PtrBtn) or (1 shl XkbSA_LockPtrBtn) or
      (1 shl XkbSA_Terminate) or (1 shl XkbSA_SwitchScreen) or
      (1 shl XkbSA_SetControls) or (1 shl XkbSA_LockControls) or
      (1 shl XkbSA_ActionMessage) or (1 shl XkbSA_RedirectKey) or
      (1 shl XkbSA_DeviceBtn) or (1 shl XkbSA_LockDeviceBtn) #
                                                             #      Key Behavior Qualifier:
                                                             #         KB_Permanent indicates that the behavior describes an unalterable
                                                             #         characteristic of the keyboard, not an XKB software-simulation of
                                                             #         the listed behavior.
                                                             #      Key Behavior Types:
                                                             #         Specifies the behavior of the underlying key.
                                                             #                

const 
  XkbKBPermanent* = 0x00000080
  XkbKBOpMask* = 0x0000007F
  XkbKBDefault* = 0x00000000
  XkbKBLock* = 0x00000001
  XkbKBRadioGroup* = 0x00000002
  XkbKBOverlay1* = 0x00000003
  XkbKBOverlay2* = 0x00000004
  XkbKBRGAllowNone* = 0x00000080 #
                                  #      Various macros which describe the range of legal keycodes.
                                  #                

const 
  XkbMinLegalKeyCode* = 8
  XkbMaxLegalKeyCode* = 255
  XkbMaxKeyCount* = XkbMaxLegalKeyCode - XkbMinLegalKeyCode + 1
  XkbPerKeyBitArraySize* = (XkbMaxLegalKeyCode + 1) div 8

proc xkbIsLegalKeycode*(k: Int): Bool
type 
  PXkbControlsPtr* = ptr TXkbControlsRec
  TXkbControlsRec*{.final.} = object 
    mk_dflt_btn*: Int8
    num_groups*: Int8
    groups_wrap*: Int8
    internal*: TXkbModsRec
    ignore_lock*: TXkbModsRec
    enabledCtrls*: Int16
    repeat_delay*: Int16
    repeat_interval*: Int16
    slow_keys_delay*: Int16
    debounce_delay*: Int16
    mk_delay*: Int16
    mk_interval*: Int16
    mk_time_to_max*: Int16
    mk_max_speed*: Int16
    mk_curve*: Int16
    axOptions*: Int16
    ax_timeout*: Int16
    axt_opts_mask*: Int16
    axt_opts_values*: Int16
    axt_ctrls_mask*: Int16
    axt_ctrls_values*: Int16
    per_key_repeat*: Array[0..XkbPerKeyBitArraySize - 1, Int8]


proc xkbAXAnyFeedback*(c: PXkbControlsPtr): Int16
proc xkbAXNeedOption*(c: PXkbControlsPtr, w: Int16): Int16
proc xkbAXNeedFeedback*(c: PXkbControlsPtr, w: Int16): Bool
  #
  #      Assorted constants and limits.
  #                
const 
  XkbNumModifiers* = 8
  XkbNumVirtualMods* = 16
  XkbNumIndicators* = 32
  XkbMaxRadioGroups* = 32
  XkbAllRadioGroupsMask* = 0xFFFFFFFF
  XkbMaxShiftLevel* = 63
  XkbMaxSymsPerKey* = XkbMaxShiftLevel * XkbNumKbdGroups
  XkbRGMaxMembers* = 12
  XkbActionMessageLength* = 6
  XkbKeyNameLength* = 4
  XkbMaxRedirectCount* = 8
  XkbGeomPtsPerMM* = 10
  XkbGeomMaxColors* = 32
  XkbGeomMaxLabelColors* = 3
  XkbGeomMaxPriority* = 255

type 
  PXkbServerMapPtr* = ptr TXkbServerMapRec
  TXkbServerMapRec*{.final.} = object 
    num_acts*: Int16
    size_acts*: Int16
    acts*: ptr Array[0..0xfff, TXkbAction]
    behaviors*: PXkbBehavior
    keyActs*: PWord
    explicit*: PByte
    vmods*: Array[0..XkbNumVirtualMods - 1, Int8]
    vmodmap*: PWord


proc xkbSMKeyActionsPtr*(m: PXkbServerMapPtr, k: Int16): PXkbAction
  #
  #          Structures and access macros used primarily by clients
  #        
type 
  PXkbSymMapPtr* = ptr TXkbSymMapRec
  TXkbSymMapRec*{.final.} = object 
    ktIndex*: Array[0..XkbNumKbdGroups - 1, Int8]
    groupInfo*: Int8
    width*: Int8
    offset*: Int8


type 
  PXkbClientMapPtr* = ptr TXkbClientMapRec
  TXkbClientMapRec*{.final.} = object 
    size_types*: Int8
    num_types*: Int8
    types*: ptr Array[0..0xffff, TXkbKeyTypeRec]
    size_syms*: Int16
    num_syms*: Int16
    syms*: ptr Array[0..0xffff, TKeySym]
    keySymMap*: ptr Array[0..0xffff, TXkbSymMapRec]
    modmap*: PByte


proc xkbCMKeyGroupInfo*(m: PXkbClientMapPtr, k: Int16): Int8
proc xkbCMKeyNumGroups*(m: PXkbClientMapPtr, k: Int16): Int8
proc xkbCMKeyGroupWidth*(m: PXkbClientMapPtr, k: Int16, g: Int8): Int8
proc xkbCMKeyGroupsWidth*(m: PXkbClientMapPtr, k: Int16): Int8
proc xkbCMKeyTypeIndex*(m: PXkbClientMapPtr, k: Int16, g: Int8): Int8
proc xkbCMKeyType*(m: PXkbClientMapPtr, k: Int16, g: Int8): PXkbKeyTypePtr
proc xkbCMKeyNumSyms*(m: PXkbClientMapPtr, k: Int16): Int16
proc xkbCMKeySymsOffset*(m: PXkbClientMapPtr, k: Int16): Int8
  #
  #          Compatibility structures and access macros
  #        
type 
  PXkbSymInterpretPtr* = ptr TXkbSymInterpretRec
  TXkbSymInterpretRec*{.final.} = object 
    sym*: TKeySym
    flags*: Int8
    match*: Int8
    mods*: Int8
    virtual_mod*: Int8
    act*: TXkbAnyAction


type 
  PXkbCompatMapPtr* = ptr TXkbCompatMapRec
  TXkbCompatMapRec*{.final.} = object 
    sym_interpret*: PXkbSymInterpretPtr
    groups*: Array[0..XkbNumKbdGroups - 1, TXkbModsRec]
    num_si*: Int16
    size_si*: Int16


type 
  PXkbIndicatorMapPtr* = ptr TXkbIndicatorMapRec
  TXkbIndicatorMapRec*{.final.} = object 
    flags*: Int8
    whichGroups*: Int8
    groups*: Int8
    whichMods*: Int8
    mods*: TXkbModsRec
    ctrls*: Int16


proc xkbIMIsAuto*(i: PXkbIndicatorMapPtr): Bool
proc xkbIMInUse*(i: PXkbIndicatorMapPtr): Bool
type 
  PXkbIndicatorPtr* = ptr TXkbIndicatorRec
  TXkbIndicatorRec*{.final.} = object 
    phys_indicators*: Int32
    maps*: Array[0..XkbNumIndicators - 1, TXkbIndicatorMapRec]


type 
  PXkbKeyNamePtr* = ptr TXkbKeyNameRec
  TXkbKeyNameRec*{.final.} = object 
    name*: Array[0..XkbKeyNameLength - 1, Char]


type 
  PXkbKeyAliasPtr* = ptr TXkbKeyAliasRec
  TXkbKeyAliasRec*{.final.} = object  #
                                      #          Names for everything
                                      #        
    float*: Array[0..XkbKeyNameLength - 1, Char]
    alias*: Array[0..XkbKeyNameLength - 1, Char]


type 
  PXkbNamesPtr* = ptr TXkbNamesRec
  TXkbNamesRec*{.final.} = object  #
                                   #      Key Type index and mask for the four standard key types.
                                   #                
    keycodes*: TAtom
    geometry*: TAtom
    symbols*: TAtom
    types*: TAtom
    compat*: TAtom
    vmods*: Array[0..XkbNumVirtualMods - 1, TAtom]
    indicators*: Array[0..XkbNumIndicators - 1, TAtom]
    groups*: Array[0..XkbNumKbdGroups - 1, TAtom]
    keys*: PXkbKeyNamePtr
    key_aliases*: PXkbKeyAliasPtr
    radio_groups*: PAtom
    phys_symbols*: TAtom
    num_keys*: Int8
    num_key_aliases*: Int8
    num_rg*: Int16


const 
  XkbOneLevelIndex* = 0
  XkbTwoLevelIndex* = 1
  XkbAlphabeticIndex* = 2
  XkbKeypadIndex* = 3
  XkbLastRequiredType* = XkbKeypadIndex
  XkbNumRequiredTypes* = XkbLastRequiredType + 1
  XkbMaxKeyTypes* = 255
  XkbOneLevelMask* = 1 shl 0
  XkbTwoLevelMask* = 1 shl 1
  XkbAlphabeticMask* = 1 shl 2
  XkbKeypadMask* = 1 shl 3
  XkbAllRequiredTypes* = 0x0000000F

proc xkbShiftLevel*(n: Int8): Int8
proc xkbShiftLevelMask*(n: Int8): Int8
  #
  #      Extension name and version information
  #                
const 
  XkbName* = "XKEYBOARD"
  XkbMajorVersion* = 1
  XkbMinorVersion* = 0 #
                       #      Explicit map components:
                       #       - Used in the 'explicit' field of an XkbServerMap.  Specifies
                       #         the keyboard components that should _not_ be updated automatically
                       #         in response to core protocol keyboard mapping requests.
                       #                

const 
  XkbExplicitKeyTypesMask* = 0x0000000F
  XkbExplicitKeyType1Mask* = 1 shl 0
  XkbExplicitKeyType2Mask* = 1 shl 1
  XkbExplicitKeyType3Mask* = 1 shl 2
  XkbExplicitKeyType4Mask* = 1 shl 3
  XkbExplicitInterpretMask* = 1 shl 4
  XkbExplicitAutoRepeatMask* = 1 shl 5
  XkbExplicitBehaviorMask* = 1 shl 6
  XkbExplicitVModMapMask* = 1 shl 7
  XkbAllExplicitMask* = 0x000000FF #
                                   #      Symbol interpretations flags:
                                   #       - Used in the flags field of a symbol interpretation
                                   #                

const 
  XkbSIAutoRepeat* = 1 shl 0
  XkbSILockingKey* = 1 shl 1 #
                              #      Symbol interpretations match specification:
                              #       - Used in the match field of a symbol interpretation to specify
                              #         the conditions under which an interpretation is used.
                              #                

const 
  XkbSILevelOneOnly* = 0x00000080
  XkbSIOpMask* = 0x0000007F
  XkbSINoneOf* = 0
  XkbSIAnyOfOrNone* = 1
  XkbSIAnyOf* = 2
  XkbSIAllOf* = 3
  XkbSIExactly* = 4 #
                     #      Indicator map flags:
                     #       - Used in the flags field of an indicator map to indicate the
                     #         conditions under which and indicator can be changed and the
                     #         effects of changing the indicator.
                     #                

const 
  XkbIMNoExplicit* = int(1) shl 7
  XkbIMNoAutomatic* = int(1) shl 6
  XkbIMLEDDrivesKB* = int(1) shl 5 #
                                    #      Indicator map component specifications:
                                    #       - Used by the 'which_groups' and 'which_mods' fields of an indicator
                                    #         map to specify which keyboard components should be used to drive
                                    #         the indicator.
                                    #                

const 
  XkbIMUseBase* = int(1) shl 0
  XkbIMUseLatched* = int(1) shl 1
  XkbIMUseLocked* = int(1) shl 2
  XkbIMUseEffective* = int(1) shl 3
  XkbIMUseCompat* = int(1) shl 4
  XkbIMUseNone* = 0
  XkbIMUseAnyGroup* = XkbIM_UseBase or XkbIM_UseLatched or XkbIM_UseLocked or
      XkbIM_UseEffective
  XkbIMUseAnyMods* = XkbIM_UseAnyGroup or XkbIM_UseCompat #
                                                           #      GetByName components:
                                                           #       - Specifies desired or necessary components to GetKbdByName request.
                                                           #       - Reports the components that were found in a GetKbdByNameReply
                                                           #                

const 
  XkbGBNTypesMask* = int(1) shl 0
  XkbGBNCompatMapMask* = int(1) shl 1
  XkbGBNClientSymbolsMask* = int(1) shl 2
  XkbGBNServerSymbolsMask* = int(1) shl 3
  XkbGBNSymbolsMask* = XkbGBN_ClientSymbolsMask or XkbGBN_ServerSymbolsMask
  XkbGBNIndicatorMapMask* = int(1) shl 4
  XkbGBNKeyNamesMask* = int(1) shl 5
  XkbGBNGeometryMask* = int(1) shl 6
  XkbGBNOtherNamesMask* = int(1) shl 7
  XkbGBNAllComponentsMask* = 0x000000FF #
                                         #       ListComponents flags
                                         #                        

const 
  XkbLCHidden* = int(1) shl 0
  XkbLCDefault* = int(1) shl 1
  XkbLCPartial* = int(1) shl 2
  XkbLCAlphanumericKeys* = int(1) shl 8
  XkbLCModifierKeys* = int(1) shl 9
  XkbLCKeypadKeys* = int(1) shl 10
  XkbLCFunctionKeys* = int(1) shl 11
  XkbLCAlternateGroup* = int(1) shl 12 #
                                        #      X Input Extension Interactions
                                        #      - Specifies the possible interactions between XKB and the X input
                                        #        extension
                                        #      - Used to request (XkbGetDeviceInfo) or change (XKbSetDeviceInfo)
                                        #        XKB information about an extension device.
                                        #      - Reports the list of supported optional features in the reply to
                                        #        XkbGetDeviceInfo or in an XkbExtensionDeviceNotify event.
                                        #      XkbXI_UnsupportedFeature is reported in XkbExtensionDeviceNotify
                                        #      events to indicate an attempt to use an unsupported feature.
                                        #                

const 
  XkbXIKeyboardsMask* = int(1) shl 0
  XkbXIButtonActionsMask* = int(1) shl 1
  XkbXIIndicatorNamesMask* = int(1) shl 2
  XkbXIIndicatorMapsMask* = int(1) shl 3
  XkbXIIndicatorStateMask* = int(1) shl 4
  XkbXIUnsupportedFeatureMask* = int(1) shl 15
  XkbXIAllFeaturesMask* = 0x0000001F
  XkbXIAllDeviceFeaturesMask* = 0x0000001E
  XkbXIIndicatorsMask* = 0x0000001C
  XkbAllExtensionDeviceEventsMask* = 0x0000801F #
                                                #      Per-Client Flags:
                                                #       - Specifies flags to be changed by the PerClientFlags request.
                                                #                

const 
  XkbPCFDetectableAutoRepeatMask* = int(1) shl 0
  XkbPCFGrabsUseXKBStateMask* = int(1) shl 1
  XkbPCFAutoResetControlsMask* = int(1) shl 2
  XkbPCFLookupStateWhenGrabbed* = int(1) shl 3
  XkbPCFSendEventUsesXKBState* = int(1) shl 4
  XkbPCFAllFlagsMask* = 0x0000001F #
                                    #      Debugging flags and controls
                                    #                

const 
  XkbDFDisableLocks* = 1 shl 0

type 
  PXkbPropertyPtr* = ptr TXkbPropertyRec
  TXkbPropertyRec*{.final.} = object 
    name*: Cstring
    value*: Cstring


type 
  PXkbColorPtr* = ptr TXkbColorRec
  TXkbColorRec*{.final.} = object 
    pixel*: Int16
    spec*: Cstring


type 
  PXkbPointPtr* = ptr TXkbPointRec
  TXkbPointRec*{.final.} = object 
    x*: Int16
    y*: Int16


type 
  PXkbBoundsPtr* = ptr TXkbBoundsRec
  TXkbBoundsRec*{.final.} = object 
    x1*: Int16
    y1*: Int16
    x2*: Int16
    y2*: Int16


proc xkbBoundsWidth*(b: PXkbBoundsPtr): Int16
proc xkbBoundsHeight*(b: PXkbBoundsPtr): Int16
type 
  PXkbOutlinePtr* = ptr TXkbOutlineRec
  TXkbOutlineRec*{.final.} = object 
    num_points*: Int16
    sz_points*: Int16
    corner_radius*: Int16
    points*: PXkbPointPtr


type 
  PXkbShapePtr* = ptr TXkbShapeRec
  TXkbShapeRec*{.final.} = object 
    name*: TAtom
    num_outlines*: Int16
    sz_outlines*: Int16
    outlines*: ptr Array [0..0xffff, TXkbOutlineRec]
    approx*: ptr Array[0..0xffff, TXkbOutlineRec]
    primary*: ptr Array[0..0xffff, TXkbOutlineRec]
    bounds*: TXkbBoundsRec


proc xkbOutlineIndex*(s: PXkbShapePtr, o: PXkbOutlinePtr): Int32
type 
  PXkbShapeDoodadPtr* = ptr TXkbShapeDoodadRec
  TXkbShapeDoodadRec*{.final.} = object 
    name*: TAtom
    theType*: Int8
    priority*: Int8
    top*: Int16
    left*: Int16
    angle*: Int16
    colorNdx*: Int16
    shapeNdx*: Int16


type 
  PXkbTextDoodadPtr* = ptr TXkbTextDoodadRec
  TXkbTextDoodadRec*{.final.} = object 
    name*: TAtom
    theType*: Int8
    priority*: Int8
    top*: Int16
    left*: Int16
    angle*: Int16
    width*: Int16
    height*: Int16
    colorNdx*: Int16
    text*: Cstring
    font*: Cstring


type 
  PXkbIndicatorDoodadPtr* = ptr TXkbIndicatorDoodadRec
  TXkbIndicatorDoodadRec*{.final.} = object 
    name*: TAtom
    theType*: Int8
    priority*: Int8
    top*: Int16
    left*: Int16
    angle*: Int16
    shapeNdx*: Int16
    onColorNdx*: Int16
    offColorNdx*: Int16


type 
  PXkbLogoDoodadPtr* = ptr TXkbLogoDoodadRec
  TXkbLogoDoodadRec*{.final.} = object 
    name*: TAtom
    theType*: Int8
    priority*: Int8
    top*: Int16
    left*: Int16
    angle*: Int16
    colorNdx*: Int16
    shapeNdx*: Int16
    logo_name*: Cstring


type 
  PXkbAnyDoodadPtr* = ptr TXkbAnyDoodadRec
  TXkbAnyDoodadRec*{.final.} = object 
    name*: TAtom
    theType*: Int8
    priority*: Int8
    top*: Int16
    left*: Int16
    angle*: Int16


type 
  PXkbDoodadPtr* = ptr TXkbDoodadRec
  TXkbDoodadRec*{.final.} = object 
    any*: TXkbAnyDoodadRec
    shape*: TXkbShapeDoodadRec
    text*: TXkbTextDoodadRec
    indicator*: TXkbIndicatorDoodadRec
    logo*: TXkbLogoDoodadRec


const 
  XkbUnknownDoodad* = 0
  XkbOutlineDoodad* = 1
  XkbSolidDoodad* = 2
  XkbTextDoodad* = 3
  XkbIndicatorDoodad* = 4
  XkbLogoDoodad* = 5

type 
  PXkbKeyPtr* = ptr TXkbKeyRec
  TXkbKeyRec*{.final.} = object 
    name*: TXkbKeyNameRec
    gap*: Int16
    shapeNdx*: Int8
    colorNdx*: Int8


type 
  PXkbRowPtr* = ptr TXkbRowRec
  TXkbRowRec*{.final.} = object 
    top*: Int16
    left*: Int16
    num_keys*: Int16
    sz_keys*: Int16
    vertical*: Int16
    Keys*: PXkbKeyPtr
    bounds*: TXkbBoundsRec


type 
  PXkbOverlayPtr* = ptr TXkbOverlayRec #forward for TXkbSectionRec use.
                                       #Do not add more "type"
  PXkbSectionPtr* = ptr TXkbSectionRec
  TXkbSectionRec*{.final.} = object  #Do not add more "type"
    name*: TAtom
    priority*: Int8
    top*: Int16
    left*: Int16
    width*: Int16
    height*: Int16
    angle*: Int16
    num_rows*: Int16
    num_doodads*: Int16
    num_overlays*: Int16
    rows*: PXkbRowPtr
    doodads*: PXkbDoodadPtr
    bounds*: TXkbBoundsRec
    overlays*: PXkbOverlayPtr

  PXkbOverlayKeyPtr* = ptr TXkbOverlayKeyRec
  TXkbOverlayKeyRec*{.final.} = object  #Do not add more "type"
    over*: TXkbKeyNameRec
    under*: TXkbKeyNameRec

  PXkbOverlayRowPtr* = ptr TXkbOverlayRowRec
  TXkbOverlayRowRec*{.final.} = object  #Do not add more "type"
    row_under*: Int16
    num_keys*: Int16
    sz_keys*: Int16
    keys*: PXkbOverlayKeyPtr

  TXkbOverlayRec*{.final.} = object 
    name*: TAtom
    section_under*: PXkbSectionPtr
    num_rows*: Int16
    sz_rows*: Int16
    rows*: PXkbOverlayRowPtr
    bounds*: PXkbBoundsPtr


type 
  PXkbGeometryRec* = ptr TXkbGeometryRec
  PXkbGeometryPtr* = PXkbGeometryRec
  TXkbGeometryRec*{.final.} = object 
    name*: TAtom
    width_mm*: Int16
    height_mm*: Int16
    label_font*: Cstring
    label_color*: PXkbColorPtr
    base_color*: PXkbColorPtr
    sz_properties*: Int16
    sz_colors*: Int16
    sz_shapes*: Int16
    sz_sections*: Int16
    sz_doodads*: Int16
    sz_key_aliases*: Int16
    num_properties*: Int16
    num_colors*: Int16
    num_shapes*: Int16
    num_sections*: Int16
    num_doodads*: Int16
    num_key_aliases*: Int16
    properties*: ptr Array[0..0xffff, TXkbPropertyRec]
    colors*: ptr Array[0..0xffff, TXkbColorRec]
    shapes*: ptr Array[0..0xffff, TXkbShapeRec]
    sections*: ptr Array[0..0xffff, TXkbSectionRec]
    key_aliases*: ptr Array[0..0xffff, TXkbKeyAliasRec]


const 
  XkbGeomPropertiesMask* = 1 shl 0
  XkbGeomColorsMask* = 1 shl 1
  XkbGeomShapesMask* = 1 shl 2
  XkbGeomSectionsMask* = 1 shl 3
  XkbGeomDoodadsMask* = 1 shl 4
  XkbGeomKeyAliasesMask* = 1 shl 5
  XkbGeomAllMask* = 0x0000003F

type 
  PXkbGeometrySizesPtr* = ptr TXkbGeometrySizesRec
  TXkbGeometrySizesRec*{.final.} = object  #
                                           #          Tie it all together into one big keyboard description
                                           #        
    which*: Int16
    num_properties*: Int16
    num_colors*: Int16
    num_shapes*: Int16
    num_sections*: Int16
    num_doodads*: Int16
    num_key_aliases*: Int16


type 
  PXkbDescPtr* = ptr TXkbDescRec
  TXkbDescRec*{.final.} = object 
    dpy*: PDisplay
    flags*: Int16
    device_spec*: Int16
    minKeyCode*: TKeyCode
    maxKeyCode*: TKeyCode
    ctrls*: PXkbControlsPtr
    server*: PXkbServerMapPtr
    map*: PXkbClientMapPtr
    indicators*: PXkbIndicatorPtr
    names*: PXkbNamesPtr
    compat*: PXkbCompatMapPtr
    geom*: PXkbGeometryPtr


proc xkbKeyKeyTypeIndex*(d: PXkbDescPtr, k: Int16, g: Int8): Int8
proc xkbKeyKeyType*(d: PXkbDescPtr, k: Int16, g: Int8): PXkbKeyTypePtr
proc xkbKeyGroupWidth*(d: PXkbDescPtr, k: Int16, g: Int8): Int8
proc xkbKeyGroupsWidth*(d: PXkbDescPtr, k: Int16): Int8
proc xkbKeyGroupInfo*(d: PXkbDescPtr, k: Int16): Int8
proc xkbKeyNumGroups*(d: PXkbDescPtr, k: Int16): Int8
proc xkbKeyNumSyms*(d: PXkbDescPtr, k: Int16): Int16
proc xkbKeySym*(d: PXkbDescPtr, k: Int16, n: Int16): TKeySym
proc xkbKeySymEntry*(d: PXkbDescPtr, k: Int16, sl: Int16, g: Int8): TKeySym
proc xkbKeyAction*(d: PXkbDescPtr, k: Int16, n: Int16): PXkbAction
proc xkbKeyActionEntry*(d: PXkbDescPtr, k: Int16, sl: Int16, g: Int8): Int8
proc xkbKeyHasActions*(d: PXkbDescPtr, k: Int16): Bool
proc xkbKeyNumActions*(d: PXkbDescPtr, k: Int16): Int16
proc xkbKeyActionsPtr*(d: PXkbDescPtr, k: Int16): PXkbAction
proc xkbKeycodeInRange*(d: PXkbDescPtr, k: Int16): Bool
proc xkbNumKeys*(d: PXkbDescPtr): Int8
  #
  #          The following structures can be used to track changes
  #          to a keyboard device
  #        
type 
  PXkbMapChangesPtr* = ptr TXkbMapChangesRec
  TXkbMapChangesRec*{.final.} = object 
    changed*: Int16
    min_key_code*: TKeyCode
    max_key_code*: TKeyCode
    first_type*: Int8
    num_types*: Int8
    first_key_sym*: TKeyCode
    num_key_syms*: Int8
    first_key_act*: TKeyCode
    num_key_acts*: Int8
    first_key_behavior*: TKeyCode
    num_key_behaviors*: Int8
    first_key_explicit*: TKeyCode
    num_key_explicit*: Int8
    first_modmap_key*: TKeyCode
    num_modmap_keys*: Int8
    first_vmodmap_key*: TKeyCode
    num_vmodmap_keys*: Int8
    pad*: Int8
    vmods*: Int16


type 
  PXkbControlsChangesPtr* = ptr TXkbControlsChangesRec
  TXkbControlsChangesRec*{.final.} = object 
    changedCtrls*: Int16
    enabled_ctrls_changes*: Int16
    num_groups_changed*: Bool


type 
  PXkbIndicatorChangesPtr* = ptr TXkbIndicatorChangesRec
  TXkbIndicatorChangesRec*{.final.} = object 
    stateChanges*: Int16
    mapChanges*: Int16


type 
  PXkbNameChangesPtr* = ptr TXkbNameChangesRec
  TXkbNameChangesRec*{.final.} = object 
    changed*: Int16
    first_type*: Int8
    num_types*: Int8
    first_lvl*: Int8
    num_lvls*: Int8
    num_aliases*: Int8
    num_rg*: Int8
    first_key*: Int8
    num_keys*: Int8
    changed_vmods*: Int16
    changed_indicators*: Int32
    changed_groups*: Int8


type 
  PXkbCompatChangesPtr* = ptr TXkbCompatChangesRec
  TXkbCompatChangesRec*{.final.} = object 
    changed_groups*: Int8
    first_si*: Int16
    num_si*: Int16


type 
  PXkbChangesPtr* = ptr TXkbChangesRec
  TXkbChangesRec*{.final.} = object  #
                                     #          These data structures are used to construct a keymap from
                                     #          a set of components or to list components in the server
                                     #          database.
                                     #        
    device_spec*: Int16
    state_changes*: Int16
    map*: TXkbMapChangesRec
    ctrls*: TXkbControlsChangesRec
    indicators*: TXkbIndicatorChangesRec
    names*: TXkbNameChangesRec
    compat*: TXkbCompatChangesRec


type 
  PXkbComponentNamesPtr* = ptr TXkbComponentNamesRec
  TXkbComponentNamesRec*{.final.} = object 
    keymap*: ptr Int16
    keycodes*: ptr Int16
    types*: ptr Int16
    compat*: ptr Int16
    symbols*: ptr Int16
    geometry*: ptr Int16


type 
  PXkbComponentNamePtr* = ptr TXkbComponentNameRec
  TXkbComponentNameRec*{.final.} = object 
    flags*: Int16
    name*: Cstring


type 
  PXkbComponentListPtr* = ptr TXkbComponentListRec
  TXkbComponentListRec*{.final.} = object  #
                                           #          The following data structures describe and track changes to a
                                           #          non-keyboard extension device
                                           #        
    num_keymaps*: Int16
    num_keycodes*: Int16
    num_types*: Int16
    num_compat*: Int16
    num_symbols*: Int16
    num_geometry*: Int16
    keymaps*: PXkbComponentNamePtr
    keycodes*: PXkbComponentNamePtr
    types*: PXkbComponentNamePtr
    compat*: PXkbComponentNamePtr
    symbols*: PXkbComponentNamePtr
    geometry*: PXkbComponentNamePtr


type 
  PXkbDeviceLedInfoPtr* = ptr TXkbDeviceLedInfoRec
  TXkbDeviceLedInfoRec*{.final.} = object 
    led_class*: Int16
    led_id*: Int16
    phys_indicators*: Int16
    maps_present*: Int16
    names_present*: Int16
    state*: Int16
    names*: Array[0..XkbNumIndicators - 1, TAtom]
    maps*: Array[0..XkbNumIndicators - 1, TXkbIndicatorMapRec]


type 
  PXkbDeviceInfoPtr* = ptr TXkbDeviceInfoRec
  TXkbDeviceInfoRec*{.final.} = object 
    name*: Cstring
    theType*: TAtom
    device_spec*: Int16
    has_own_state*: Bool
    supported*: Int16
    unsupported*: Int16
    numBtns*: Int16
    btnActs*: PXkbAction
    sz_leds*: Int16
    numLeds*: Int16
    dflt_kbd_fb*: Int16
    dflt_led_fb*: Int16
    leds*: PXkbDeviceLedInfoPtr


proc xkbXIDevHasBtnActs*(d: PXkbDeviceInfoPtr): Bool
proc xkbXILegalDevBtn*(d: PXkbDeviceInfoPtr, b: Int16): Bool
proc xkbXIDevHasLeds*(d: PXkbDeviceInfoPtr): Bool
type 
  PXkbDeviceLedChangesPtr* = ptr TXkbDeviceLedChangesRec
  TXkbDeviceLedChangesRec*{.final.} = object 
    led_class*: Int16
    led_id*: Int16
    defined*: Int16           #names or maps changed
    next*: PXkbDeviceLedChangesPtr


type 
  PXkbDeviceChangesPtr* = ptr TXkbDeviceChangesRec
  TXkbDeviceChangesRec*{.final.} = object 
    changed*: Int16
    first_btn*: Int16
    num_btns*: Int16
    leds*: TXkbDeviceLedChangesRec


proc xkbShapeDoodadColor*(g: PXkbGeometryPtr, d: PXkbShapeDoodadPtr): PXkbColorPtr
proc xkbShapeDoodadShape*(g: PXkbGeometryPtr, d: PXkbShapeDoodadPtr): PXkbShapePtr
proc xkbSetShapeDoodadColor*(g: PXkbGeometryPtr, d: PXkbShapeDoodadPtr, 
                             c: PXkbColorPtr)
proc xkbSetShapeDoodadShape*(g: PXkbGeometryPtr, d: PXkbShapeDoodadPtr, 
                             s: PXkbShapePtr)
proc xkbTextDoodadColor*(g: PXkbGeometryPtr, d: PXkbTextDoodadPtr): PXkbColorPtr
proc xkbSetTextDoodadColor*(g: PXkbGeometryPtr, d: PXkbTextDoodadPtr, 
                            c: PXkbColorPtr)
proc xkbIndicatorDoodadShape*(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr): PXkbShapeDoodadPtr
proc xkbIndicatorDoodadOnColor*(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr): PXkbColorPtr
proc xkbIndicatorDoodadOffColor*(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr): PXkbColorPtr
proc xkbSetIndicatorDoodadOnColor*(g: PXkbGeometryPtr, 
                                   d: PXkbIndicatorDoodadPtr, c: PXkbColorPtr)
proc xkbSetIndicatorDoodadOffColor*(g: PXkbGeometryPtr, 
                                    d: PXkbIndicatorDoodadPtr, c: PXkbColorPtr)
proc xkbSetIndicatorDoodadShape*(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr, 
                                 s: PXkbShapeDoodadPtr)
proc xkbLogoDoodadColor*(g: PXkbGeometryPtr, d: PXkbLogoDoodadPtr): PXkbColorPtr
proc xkbLogoDoodadShape*(g: PXkbGeometryPtr, d: PXkbLogoDoodadPtr): PXkbShapeDoodadPtr
proc xkbSetLogoDoodadColor*(g: PXkbGeometryPtr, d: PXkbLogoDoodadPtr, 
                            c: PXkbColorPtr)
proc xkbSetLogoDoodadShape*(g: PXkbGeometryPtr, d: PXkbLogoDoodadPtr, 
                            s: PXkbShapeDoodadPtr)
proc xkbKeyShape*(g: PXkbGeometryPtr, k: PXkbKeyPtr): PXkbShapeDoodadPtr
proc xkbKeyColor*(g: PXkbGeometryPtr, k: PXkbKeyPtr): PXkbColorPtr
proc xkbSetKeyShape*(g: PXkbGeometryPtr, k: PXkbKeyPtr, s: PXkbShapeDoodadPtr)
proc xkbSetKeyColor*(g: PXkbGeometryPtr, k: PXkbKeyPtr, c: PXkbColorPtr)
proc xkbGeomColorIndex*(g: PXkbGeometryPtr, c: PXkbColorPtr): Int32
proc xkbAddGeomProperty*(geom: PXkbGeometryPtr, name: Cstring, value: Cstring): PXkbPropertyPtr{.
    libx11c, importc: "XkbAddGeomProperty".}
proc xkbAddGeomKeyAlias*(geom: PXkbGeometryPtr, alias: Cstring, float: Cstring): PXkbKeyAliasPtr{.
    libx11c, importc: "XkbAddGeomKeyAlias".}
proc xkbAddGeomColor*(geom: PXkbGeometryPtr, spec: Cstring, pixel: Int16): PXkbColorPtr{.
    libx11c, importc: "XkbAddGeomColor".}
proc xkbAddGeomOutline*(shape: PXkbShapePtr, sz_points: Int16): PXkbOutlinePtr{.
    libx11c, importc: "XkbAddGeomOutline".}
proc xkbAddGeomShape*(geom: PXkbGeometryPtr, name: TAtom, sz_outlines: Int16): PXkbShapePtr{.
    libx11c, importc: "XkbAddGeomShape".}
proc xkbAddGeomKey*(row: PXkbRowPtr): PXkbKeyPtr{.libx11c, 
    importc: "XkbAddGeomKey".}
proc xkbAddGeomRow*(section: PXkbSectionPtr, sz_keys: Int16): PXkbRowPtr{.libx11c, importc: "XkbAddGeomRow".}
proc xkbAddGeomSection*(geom: PXkbGeometryPtr, name: TAtom, sz_rows: Int16, 
                        sz_doodads: Int16, sz_overlays: Int16): PXkbSectionPtr{.
    libx11c, importc: "XkbAddGeomSection".}
proc xkbAddGeomOverlay*(section: PXkbSectionPtr, name: TAtom, sz_rows: Int16): PXkbOverlayPtr{.
    libx11c, importc: "XkbAddGeomOverlay".}
proc xkbAddGeomOverlayRow*(overlay: PXkbOverlayPtr, row_under: Int16, 
                           sz_keys: Int16): PXkbOverlayRowPtr{.libx11c, importc: "XkbAddGeomOverlayRow".}
proc xkbAddGeomOverlayKey*(overlay: PXkbOverlayPtr, row: PXkbOverlayRowPtr, 
                           over: Cstring, under: Cstring): PXkbOverlayKeyPtr{.
    libx11c, importc: "XkbAddGeomOverlayKey".}
proc xkbAddGeomDoodad*(geom: PXkbGeometryPtr, section: PXkbSectionPtr, 
                       name: TAtom): PXkbDoodadPtr{.libx11c, 
    importc: "XkbAddGeomDoodad".}
proc xkbFreeGeomKeyAliases*(geom: PXkbGeometryPtr, first: Int16, count: Int16, 
                            freeAll: Bool){.libx11c, 
    importc: "XkbFreeGeomKeyAliases".}
proc xkbFreeGeomColors*(geom: PXkbGeometryPtr, first: Int16, count: Int16, 
                        freeAll: Bool){.libx11c, 
                                        importc: "XkbFreeGeomColors".}
proc xkbFreeGeomDoodads*(doodads: PXkbDoodadPtr, nDoodads: Int16, freeAll: Bool){.
    libx11c, importc: "XkbFreeGeomDoodads".}
proc xkbFreeGeomProperties*(geom: PXkbGeometryPtr, first: Int16, count: Int16, 
                            freeAll: Bool){.libx11c, 
    importc: "XkbFreeGeomProperties".}
proc xkbFreeGeomOverlayKeys*(row: PXkbOverlayRowPtr, first: Int16, count: Int16, 
                             freeAll: Bool){.libx11c, 
    importc: "XkbFreeGeomOverlayKeys".}
proc xkbFreeGeomOverlayRows*(overlay: PXkbOverlayPtr, first: Int16, 
                             count: Int16, freeAll: Bool){.libx11c, importc: "XkbFreeGeomOverlayRows".}
proc xkbFreeGeomOverlays*(section: PXkbSectionPtr, first: Int16, count: Int16, 
                          freeAll: Bool){.libx11c, 
    importc: "XkbFreeGeomOverlays".}
proc xkbFreeGeomKeys*(row: PXkbRowPtr, first: Int16, count: Int16, freeAll: Bool){.
    libx11c, importc: "XkbFreeGeomKeys".}
proc xkbFreeGeomRows*(section: PXkbSectionPtr, first: Int16, count: Int16, 
                      freeAll: Bool){.libx11c, 
                                      importc: "XkbFreeGeomRows".}
proc xkbFreeGeomSections*(geom: PXkbGeometryPtr, first: Int16, count: Int16, 
                          freeAll: Bool){.libx11c, 
    importc: "XkbFreeGeomSections".}
proc xkbFreeGeomPoints*(outline: PXkbOutlinePtr, first: Int16, count: Int16, 
                        freeAll: Bool){.libx11c, 
                                        importc: "XkbFreeGeomPoints".}
proc xkbFreeGeomOutlines*(shape: PXkbShapePtr, first: Int16, count: Int16, 
                          freeAll: Bool){.libx11c, 
    importc: "XkbFreeGeomOutlines".}
proc xkbFreeGeomShapes*(geom: PXkbGeometryPtr, first: Int16, count: Int16, 
                        freeAll: Bool){.libx11c, 
                                        importc: "XkbFreeGeomShapes".}
proc xkbFreeGeometry*(geom: PXkbGeometryPtr, which: Int16, freeMap: Bool){.
    libx11c, importc: "XkbFreeGeometry".}
proc xkbAllocGeomProps*(geom: PXkbGeometryPtr, nProps: Int16): TStatus{.libx11c, importc: "XkbAllocGeomProps".}
proc xkbAllocGeomKeyAliases*(geom: PXkbGeometryPtr, nAliases: Int16): TStatus{.
    libx11c, importc: "XkbAllocGeomKeyAliases".}
proc xkbAllocGeomColors*(geom: PXkbGeometryPtr, nColors: Int16): TStatus{.libx11c, importc: "XkbAllocGeomColors".}
proc xkbAllocGeomShapes*(geom: PXkbGeometryPtr, nShapes: Int16): TStatus{.libx11c, importc: "XkbAllocGeomShapes".}
proc xkbAllocGeomSections*(geom: PXkbGeometryPtr, nSections: Int16): TStatus{.
    libx11c, importc: "XkbAllocGeomSections".}
proc xkbAllocGeomOverlays*(section: PXkbSectionPtr, num_needed: Int16): TStatus{.
    libx11c, importc: "XkbAllocGeomOverlays".}
proc xkbAllocGeomOverlayRows*(overlay: PXkbOverlayPtr, num_needed: Int16): TStatus{.
    libx11c, importc: "XkbAllocGeomOverlayRows".}
proc xkbAllocGeomOverlayKeys*(row: PXkbOverlayRowPtr, num_needed: Int16): TStatus{.
    libx11c, importc: "XkbAllocGeomOverlayKeys".}
proc xkbAllocGeomDoodads*(geom: PXkbGeometryPtr, nDoodads: Int16): TStatus{.
    libx11c, importc: "XkbAllocGeomDoodads".}
proc xkbAllocGeomSectionDoodads*(section: PXkbSectionPtr, nDoodads: Int16): TStatus{.
    libx11c, importc: "XkbAllocGeomSectionDoodads".}
proc xkbAllocGeomOutlines*(shape: PXkbShapePtr, nOL: Int16): TStatus{.libx11c, importc: "XkbAllocGeomOutlines".}
proc xkbAllocGeomRows*(section: PXkbSectionPtr, nRows: Int16): TStatus{.libx11c, importc: "XkbAllocGeomRows".}
proc xkbAllocGeomPoints*(ol: PXkbOutlinePtr, nPts: Int16): TStatus{.libx11c, importc: "XkbAllocGeomPoints".}
proc xkbAllocGeomKeys*(row: PXkbRowPtr, nKeys: Int16): TStatus{.libx11c, importc: "XkbAllocGeomKeys".}
proc xkbAllocGeometry*(xkb: PXkbDescPtr, sizes: PXkbGeometrySizesPtr): TStatus{.
    libx11c, importc: "XkbAllocGeometry".}
proc xkbSetGeometryProc*(dpy: PDisplay, deviceSpec: Int16, geom: PXkbGeometryPtr): TStatus{.
    libx11c, importc: "XkbSetGeometry".}
proc xkbComputeShapeTop*(shape: PXkbShapePtr, bounds: PXkbBoundsPtr): Bool{.
    libx11c, importc: "XkbComputeShapeTop".}
proc xkbComputeShapeBounds*(shape: PXkbShapePtr): Bool{.libx11c, 
    importc: "XkbComputeShapeBounds".}
proc xkbComputeRowBounds*(geom: PXkbGeometryPtr, section: PXkbSectionPtr, 
                          row: PXkbRowPtr): Bool{.libx11c, 
    importc: "XkbComputeRowBounds".}
proc xkbComputeSectionBounds*(geom: PXkbGeometryPtr, section: PXkbSectionPtr): Bool{.
    libx11c, importc: "XkbComputeSectionBounds".}
proc xkbFindOverlayForKey*(geom: PXkbGeometryPtr, wanted: PXkbSectionPtr, 
                           under: Cstring): Cstring{.libx11c, 
    importc: "XkbFindOverlayForKey".}
proc xkbGetGeometryProc*(dpy: PDisplay, xkb: PXkbDescPtr): TStatus{.libx11c, importc: "XkbGetGeometry".}
proc xkbGetNamedGeometry*(dpy: PDisplay, xkb: PXkbDescPtr, name: TAtom): TStatus{.
    libx11c, importc: "XkbGetNamedGeometry".}
when defined(XKB_IN_SERVER): 
  proc SrvXkbAddGeomKeyAlias*(geom: PXkbGeometryPtr, alias: cstring, 
                              float: cstring): PXkbKeyAliasPtr{.libx11c, importc: "XkbAddGeomKeyAlias".}
  proc SrvXkbAddGeomColor*(geom: PXkbGeometryPtr, spec: cstring, pixel: int16): PXkbColorPtr{.
      libx11c, importc: "XkbAddGeomColor".}
  proc SrvXkbAddGeomDoodad*(geom: PXkbGeometryPtr, section: PXkbSectionPtr, 
                            name: TAtom): PXkbDoodadPtr{.libx11c, 
      importc: "XkbAddGeomDoodad".}
  proc SrvXkbAddGeomKey*(geom: PXkbGeometryPtr, alias: cstring, float: cstring): PXkbKeyAliasPtr{.
      libx11c, importc: "XkbAddGeomKeyAlias".}
  proc SrvXkbAddGeomOutline*(shape: PXkbShapePtr, sz_points: int16): PXkbOutlinePtr{.
      libx11c, importc: "XkbAddGeomOutline".}
  proc SrvXkbAddGeomOverlay*(overlay: PXkbOverlayPtr, row: PXkbOverlayRowPtr, 
                             over: cstring, under: cstring): PXkbOverlayKeyPtr{.
      libx11c, importc: "XkbAddGeomOverlayKey".}
  proc SrvXkbAddGeomOverlayRow*(overlay: PXkbOverlayPtr, row_under: int16, 
                                sz_keys: int16): PXkbOverlayRowPtr{.libx11c, importc: "XkbAddGeomOverlayRow".}
  proc SrvXkbAddGeomOverlayKey*(overlay: PXkbOverlayPtr, row: PXkbOverlayRowPtr, 
                                over: cstring, under: cstring): PXkbOverlayKeyPtr{.
      libx11c, importc: "XkbAddGeomOverlayKey".}
  proc SrvXkbAddGeomProperty*(geom: PXkbGeometryPtr, name: cstring, 
                              value: cstring): PXkbPropertyPtr{.libx11c, importc: "XkbAddGeomProperty".}
  proc SrvXkbAddGeomRow*(section: PXkbSectionPtr, sz_keys: int16): PXkbRowPtr{.
      libx11c, importc: "XkbAddGeomRow".}
  proc SrvXkbAddGeomSection*(geom: PXkbGeometryPtr, name: TAtom, sz_rows: int16, 
                             sz_doodads: int16, sz_overlays: int16): PXkbSectionPtr{.
      libx11c, importc: "XkbAddGeomSection".}
  proc SrvXkbAddGeomShape*(geom: PXkbGeometryPtr, name: TAtom, 
                           sz_outlines: int16): PXkbShapePtr{.libx11c, importc: "XkbAddGeomShape".}
  proc SrvXkbAllocGeomKeyAliases*(geom: PXkbGeometryPtr, nAliases: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomKeyAliases".}
  proc SrvXkbAllocGeomColors*(geom: PXkbGeometryPtr, nColors: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomColors".}
  proc SrvXkbAllocGeomDoodads*(geom: PXkbGeometryPtr, nDoodads: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomDoodads".}
  proc SrvXkbAllocGeomKeys*(row: PXkbRowPtr, nKeys: int16): TStatus{.libx11c, importc: "XkbAllocGeomKeys".}
  proc SrvXkbAllocGeomOutlines*(shape: PXkbShapePtr, nOL: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomOutlines".}
  proc SrvXkbAllocGeomPoints*(ol: PXkbOutlinePtr, nPts: int16): TStatus{.libx11c, importc: "XkbAllocGeomPoints".}
  proc SrvXkbAllocGeomProps*(geom: PXkbGeometryPtr, nProps: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomProps".}
  proc SrvXkbAllocGeomRows*(section: PXkbSectionPtr, nRows: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomRows".}
  proc SrvXkbAllocGeomSectionDoodads*(section: PXkbSectionPtr, nDoodads: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomSectionDoodads".}
  proc SrvXkbAllocGeomSections*(geom: PXkbGeometryPtr, nSections: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomSections".}
  proc SrvXkbAllocGeomOverlays*(section: PXkbSectionPtr, num_needed: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomOverlays".}
  proc SrvXkbAllocGeomOverlayRows*(overlay: PXkbOverlayPtr, num_needed: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomOverlayRows".}
  proc SrvXkbAllocGeomOverlayKeys*(row: PXkbOverlayRowPtr, num_needed: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomOverlayKeys".}
  proc SrvXkbAllocGeomShapes*(geom: PXkbGeometryPtr, nShapes: int16): TStatus{.
      libx11c, importc: "XkbAllocGeomShapes".}
  proc SrvXkbAllocGeometry*(xkb: PXkbDescPtr, sizes: PXkbGeometrySizesPtr): TStatus{.
      libx11c, importc: "XkbAllocGeometry".}
  proc SrvXkbFreeGeomKeyAliases*(geom: PXkbGeometryPtr, first: int16, 
                                 count: int16, freeAll: bool){.libx11c, importc: "XkbFreeGeomKeyAliases".}
  proc SrvXkbFreeGeomColors*(geom: PXkbGeometryPtr, first: int16, count: int16, 
                             freeAll: bool){.libx11c, 
      importc: "XkbFreeGeomColors".}
  proc SrvXkbFreeGeomDoodads*(doodads: PXkbDoodadPtr, nDoodads: int16, 
                              freeAll: bool){.libx11c, 
      importc: "XkbFreeGeomDoodads".}
  proc SrvXkbFreeGeomProperties*(geom: PXkbGeometryPtr, first: int16, 
                                 count: int16, freeAll: bool){.libx11c, importc: "XkbFreeGeomProperties".}
  proc SrvXkbFreeGeomOverlayKeys*(row: PXkbOverlayRowPtr, first: int16, 
                                  count: int16, freeAll: bool){.libx11c, importc: "XkbFreeGeomOverlayKeys".}
  proc SrvXkbFreeGeomOverlayRows*(overlay: PXkbOverlayPtr, first: int16, 
                                  count: int16, freeAll: bool){.libx11c, importc: "XkbFreeGeomOverlayRows".}
  proc SrvXkbFreeGeomOverlays*(section: PXkbSectionPtr, first: int16, 
                               count: int16, freeAll: bool){.libx11c, importc: "XkbFreeGeomOverlays".}
  proc SrvXkbFreeGeomKeys*(row: PXkbRowPtr, first: int16, count: int16, 
                           freeAll: bool){.libx11c, 
      importc: "XkbFreeGeomKeys".}
  proc SrvXkbFreeGeomRows*(section: PXkbSectionPtr, first: int16, count: int16, 
                           freeAll: bool){.libx11c, 
      importc: "XkbFreeGeomRows".}
  proc SrvXkbFreeGeomSections*(geom: PXkbGeometryPtr, first: int16, 
                               count: int16, freeAll: bool){.libx11c, importc: "XkbFreeGeomSections".}
  proc SrvXkbFreeGeomPoints*(outline: PXkbOutlinePtr, first: int16, 
                             count: int16, freeAll: bool){.libx11c, importc: "XkbFreeGeomPoints".}
  proc SrvXkbFreeGeomOutlines*(shape: PXkbShapePtr, first: int16, count: int16, 
                               freeAll: bool){.libx11c, 
      importc: "XkbFreeGeomOutlines".}
  proc SrvXkbFreeGeomShapes*(geom: PXkbGeometryPtr, first: int16, count: int16, 
                             freeAll: bool){.libx11c, 
      importc: "XkbFreeGeomShapes".}
  proc SrvXkbFreeGeometry*(geom: PXkbGeometryPtr, which: int16, freeMap: bool){.
      libx11c, importc: "XkbFreeGeometry".}
# implementation

import                        #************************************ xkb ************************************
  xi

proc xkbLegalXILedClass(c: int): bool = 
  ##define XkbLegalXILedClass(c) (((c)==KbdFeedbackClass)||((c)==LedFeedbackClass)||
  #                                ((c)==XkbDfltXIClass)||((c)==XkbAllXIClasses))
  Result = (c == KbdFeedbackClass) or (c == LedFeedbackClass) or
      (c == XkbDfltXIClass) or (c == XkbAllXIClasses)

proc xkbLegalXIBellClass(c: int): bool = 
  ##define XkbLegalXIBellClass(c) (((c)==KbdFeedbackClass)||((c)==BellFeedbackClass)||
  #                                 ((c)==XkbDfltXIClass)||((c)==XkbAllXIClasses))
  Result = (c == KbdFeedbackClass) or (c == BellFeedbackClass) or
      (c == XkbDfltXIClass) or (c == XkbAllXIClasses)

proc xkbExplicitXIDevice(c: int): bool = 
  ##define XkbExplicitXIDevice(c) (((c)&(~0xff))==0)
  Result = (c and (not 0x000000FF)) == 0

proc xkbExplicitXIClass(c: int): bool = 
  ##define XkbExplicitXIClass(c) (((c)&(~0xff))==0)
  Result = (c and (not 0x000000FF)) == 0

proc xkbExplicitXIId(c: int): bool = 
  ##define XkbExplicitXIId(c) (((c)&(~0xff))==0)
  Result = (c and (not 0x000000FF)) == 0

proc xkbSingleXIClass(c: int): bool = 
  ##define XkbSingleXIClass(c) ((((c)&(~0xff))==0)||((c)==XkbDfltXIClass))
  Result = ((c and (not 0x000000FF)) == 0) or (c == XkbDfltXIClass)

proc xkbSingleXIId(c: int): bool = 
  ##define XkbSingleXIId(c) ((((c)&(~0xff))==0)||((c)==XkbDfltXIId))
  Result = ((c and (not 0x000000FF)) == 0) or (c == XkbDfltXIId)

proc xkbBuildCoreState(m, g: int): int = 
  ##define XkbBuildCoreState(m,g) ((((g)&0x3)<<13)|((m)&0xff))
  Result = ((g and 0x00000003) shl 13) or (m and 0x000000FF)

proc xkbGroupForCoreState(s: int): int = 
  ##define XkbGroupForCoreState(s) (((s)>>13)&0x3)
  Result = (s shr 13) and 0x00000003

proc xkbIsLegalGroup(g: int): bool = 
  ##define XkbIsLegalGroup(g) (((g)>=0)&&((g)<XkbNumKbdGroups))
  Result = (g >= 0) and (g < XkbNumKbdGroups)

proc xkbSAValOp(a: int): int = 
  ##define XkbSA_ValOp(a) ((a)&XkbSA_ValOpMask)
  Result = a and XkbSA_ValOpMask

proc xkbSAValScale(a: int): int = 
  ##define XkbSA_ValScale(a) ((a)&XkbSA_ValScaleMask)
  Result = a and XkbSA_ValScaleMask

proc xkbIsModAction(a: PXkbAnyAction): bool = 
  ##define XkbIsModAction(a) (((a)->type>=Xkb_SASetMods)&&((a)->type<=XkbSA_LockMods))
  Result = (ze(a.theType) >= XkbSA_SetMods) and (ze(a.theType) <= XkbSA_LockMods)

proc xkbIsGroupAction(a: PXkbAnyAction): bool = 
  ##define XkbIsGroupAction(a) (((a)->type>=XkbSA_SetGroup)&&((a)->type<=XkbSA_LockGroup))
  Result = (ze(a.theType) >= XkbSA_SetGroup) or (ze(a.theType) <= XkbSA_LockGroup)

proc xkbIsPtrAction(a: PXkbAnyAction): bool = 
  ##define XkbIsPtrAction(a) (((a)->type>=XkbSA_MovePtr)&&((a)->type<=XkbSA_SetPtrDflt))
  Result = (ze(a.theType) >= XkbSA_MovePtr) and
      (ze(a.theType) <= XkbSA_SetPtrDflt)

proc xkbIsLegalKeycode(k: int): bool = 
  ##define        XkbIsLegalKeycode(k)    (((k)>=XkbMinLegalKeyCode)&&((k)<=XkbMaxLegalKeyCode))
  Result = (k >= XkbMinLegalKeyCode) and (k <= XkbMaxLegalKeyCode)

proc xkbShiftLevel(n: int8): int8 = 
  ##define XkbShiftLevel(n) ((n)-1)
  Result = n - 1'i8

proc xkbShiftLevelMask(n: int8): int8 = 
  ##define XkbShiftLevelMask(n) (1<<((n)-1))
  Result = 1'i8 shl (n - 1'i8)

proc xkbCharToInt(v: int8): int16 = 
  ##define XkbCharToInt(v) ((v)&0x80?(int)((v)|(~0xff)):(int)((v)&0x7f))
  if ((v and 0x80'i8) != 0'i8): Result = v or (not 0xFF'i16)
  else: Result = Int16(v and 0x7F'i8)
  
proc xkbIntTo2Chars(i: int16, h, L: var int8) = 
  ##define XkbIntTo2Chars(i,h,l) (((h)=((i>>8)&0xff)),((l)=((i)&0xff)))
  h = toU8((i shr 8'i16) and 0x00FF'i16)
  L = toU8(i and 0xFF'i16)

proc xkb2CharsToInt(h, L: int8): int16 = 
  when defined(cpu64): 
    ##define Xkb2CharsToInt(h,l) ((h)&0x80?(int)(((h)<<8)|(l)|(~0xffff)): (int)(((h)<<8)|(l)&0x7fff))
    if (h and 0x80'i8) != 0'i8: 
      Result = toU16((ze(h) shl 8) or ze(L) or not 0x0000FFFF)
    else: 
      Result = toU16((ze(h) shl 8) or ze(L) and 0x00007FFF)
  else: 
    ##define Xkb2CharsToInt(h,l) ((short)(((h)<<8)|(l)))
    Result = toU16(ze(h) shl 8 or ze(L))

proc xkbModLocks(s: PXkbStatePtr): int8 = 
  ##define XkbModLocks(s) ((s)->locked_mods)
  Result = s.locked_mods

proc xkbStateMods(s: PXkbStatePtr): int16 = 
  ##define XkbStateMods(s) ((s)->base_mods|(s)->latched_mods|XkbModLocks(s))
  Result = s.base_mods or s.latched_mods or xkbModLocks(s)

proc xkbGroupLock(s: PXkbStatePtr): int8 = 
  ##define XkbGroupLock(s) ((s)->locked_group)
  Result = s.locked_group

proc xkbStateGroup(s: PXkbStatePtr): int16 = 
  ##define XkbStateGroup(s) ((s)->base_group+(s)->latched_group+XkbGroupLock(s))
  Result = s.base_group + (s.latched_group) + xkbGroupLock(s)

proc xkbStateFieldFromRec(s: PXkbStatePtr): int = 
  ##define XkbStateFieldFromRec(s) XkbBuildCoreState((s)->lookup_mods,(s)->group)
  Result = xkbBuildCoreState(s.lookup_mods, s.group)

proc xkbGrabStateFromRec(s: PXkbStatePtr): int = 
  ##define XkbGrabStateFromRec(s) XkbBuildCoreState((s)->grab_mods,(s)->group)
  Result = xkbBuildCoreState(s.grab_mods, s.group)

proc xkbNumGroups(g: int16): int16 = 
  ##define XkbNumGroups(g) ((g)&0x0f)
  Result = g and 0x0000000F'i16

proc xkbOutOfRangeGroupInfo(g: int16): int16 = 
  ##define XkbOutOfRangeGroupInfo(g) ((g)&0xf0)
  Result = g and 0x000000F0'i16

proc xkbOutOfRangeGroupAction(g: int16): int16 = 
  ##define XkbOutOfRangeGroupAction(g) ((g)&0xc0)
  Result = g and 0x000000C0'i16

proc xkbOutOfRangeGroupNumber(g: int16): int16 = 
  ##define XkbOutOfRangeGroupNumber(g) (((g)&0x30)>>4)
  Result = (g and 0x00000030'i16) shr 4'i16

proc xkbSetGroupInfo(g, w, n: int16): int16 = 
  ##define XkbSetGroupInfo(g,w,n) (((w)&0xc0)|(((n)&3)<<4)|((g)&0x0f))
  Result = (w and 0x000000C0'i16) or 
    ((n and 3'i16) shl 4'i16) or (g and 0x0000000F'i16)

proc xkbSetNumGroups(g, n: int16): int16 = 
  ##define XkbSetNumGroups(g,n) (((g)&0xf0)|((n)&0x0f))
  Result = (g and 0x000000F0'i16) or (n and 0x0000000F'i16)

proc xkbModActionVMods(a: PXkbModAction): int16 = 
  ##define XkbModActionVMods(a) ((short)(((a)->vmods1<<8)|((a)->vmods2)))
  Result = toU16((ze(a.vmods1) shl 8) or ze(a.vmods2))

proc xkbSetModActionVMods(a: PXkbModAction, v: int8) = 
  ##define XkbSetModActionVMods(a,v) (((a)->vmods1=(((v)>>8)&0xff)),(a)->vmods2=((v)&0xff))
  a.vmods1 = toU8((ze(v) shr 8) and 0x000000FF)
  a.vmods2 = toU8(ze(v) and 0x000000FF)

proc xkbSAGroup(a: PXkbGroupAction): int8 = 
  ##define XkbSAGroup(a) (XkbCharToInt((a)->group_XXX))
  Result = Int8(xkbCharToInt(a.group_XXX))

proc xkbSASetGroupProc(a: PXkbGroupAction, g: int8) = 
  ##define XkbSASetGroup(a,g) ((a)->group_XXX=(g))
  a.group_XXX = g

proc xkbPtrActionX(a: PXkbPtrAction): int16 = 
  ##define XkbPtrActionX(a) (Xkb2CharsToInt((a)->high_XXX,(a)->low_XXX))
  Result = Int16(xkb2CharsToInt(a.high_XXX, a.low_XXX))

proc xkbPtrActionY(a: PXkbPtrAction): int16 = 
  ##define XkbPtrActionY(a) (Xkb2CharsToInt((a)->high_YYY,(a)->low_YYY))
  Result = Int16(xkb2CharsToInt(a.high_YYY, a.low_YYY))

proc xkbSetPtrActionX(a: PXkbPtrAction, x: int8) = 
  ##define XkbSetPtrActionX(a,x) (XkbIntTo2Chars(x,(a)->high_XXX,(a)->low_XXX))
  xkbIntTo2Chars(x, a.high_XXX, a.low_XXX)

proc xkbSetPtrActionY(a: PXkbPtrAction, y: int8) = 
  ##define XkbSetPtrActionY(a,y) (XkbIntTo2Chars(y,(a)->high_YYY,(a)->low_YYY))
  xkbIntTo2Chars(y, a.high_YYY, a.low_YYY)

proc xkbSAPtrDfltValue(a: PXkbPtrDfltAction): int8 = 
  ##define XkbSAPtrDfltValue(a) (XkbCharToInt((a)->valueXXX))
  Result = Int8(xkbCharToInt(a.valueXXX))

proc xkbSASetPtrDfltValue(a: PXkbPtrDfltAction, c: pointer) = 
  ##define XkbSASetPtrDfltValue(a,c) ((a)->valueXXX= ((c)&0xff))
  a.valueXXX = toU8(cast[Int](c))

proc xkbSAScreen(a: PXkbSwitchScreenAction): int8 = 
  ##define XkbSAScreen(a) (XkbCharToInt((a)->screenXXX))
  Result = toU8(xkbCharToInt(a.screenXXX))

proc xkbSASetScreen(a: PXkbSwitchScreenAction, s: pointer) = 
  ##define XkbSASetScreen(a,s) ((a)->screenXXX= ((s)&0xff))
  a.screenXXX = toU8(cast[Int](s))

proc xkbActionSetCtrls(a: PXkbCtrlsAction, c: int8) = 
  ##define XkbActionSetCtrls(a,c) (((a)->ctrls3=(((c)>>24)&0xff)),((a)->ctrls2=(((c)>>16)&0xff)),
  #                                 ((a)->ctrls1=(((c)>>8)&0xff)),((a)->ctrls0=((c)&0xff)))        
  a.ctrls3 = toU8((ze(c) shr 24) and 0x000000FF)
  a.ctrls2 = toU8((ze(c) shr 16) and 0x000000FF)
  a.ctrls1 = toU8((ze(c) shr 8) and 0x000000FF)
  a.ctrls0 = toU8(ze(c) and 0x000000FF)

proc xkbActionCtrls(a: PXkbCtrlsAction): int16 = 
  ##define XkbActionCtrls(a) ((((unsigned int)(a)->ctrls3)<<24)|(((unsigned int)(a)->ctrls2)<<16)|
  #                            (((unsigned int)(a)->ctrls1)<<8)|((unsigned int)((a)->ctrls0)))      
  Result = toU16((ze(a.ctrls3) shl 24) or (ze(a.ctrls2) shl 16) or 
     (ze(a.ctrls1) shl 8) or ze(a.ctrls0))

proc xkbSARedirectVMods(a: PXkbRedirectKeyAction): int16 = 
  ##define XkbSARedirectVMods(a) ((((unsigned int)(a)->vmods1)<<8)|((unsigned int)(a)->vmods0))
  Result = toU16((ze(a.vmods1) shl 8) or ze(a.vmods0))

proc xkbSARedirectSetVMods(a: PXkbRedirectKeyAction, m: int8) = 
  ##define XkbSARedirectSetVMods(a,m) (((a)->vmods_mask1=(((m)>>8)&0xff)),((a)->vmods_mask0=((m)&0xff)))
  a.vmods_mask1 = toU8((ze(m) shr 8) and 0x000000FF)
  a.vmods_mask0 = toU8(ze(m) or 0x000000FF)

proc xkbSARedirectVModsMask(a: PXkbRedirectKeyAction): int16 = 
  ##define XkbSARedirectVModsMask(a) ((((unsigned int)(a)->vmods_mask1)<<8)|
  #                                     ((unsigned int)(a)->vmods_mask0))
  Result = toU16((ze(a.vmods_mask1) shl 8) or ze(a.vmods_mask0))

proc xkbSARedirectSetVModsMask(a: PXkbRedirectKeyAction, m: int8) = 
  ##define XkbSARedirectSetVModsMask(a,m) (((a)->vmods_mask1=(((m)>>8)&0xff)),((a)->vmods_mask0=((m)&0xff)))
  a.vmods_mask1 = toU8(ze(m) shr 8 and 0x000000FF)
  a.vmods_mask0 = toU8(ze(m) and 0x000000FF)

proc xkbAXAnyFeedback(c: PXkbControlsPtr): int16 = 
  ##define XkbAX_AnyFeedback(c) ((c)->enabled_ctrls&XkbAccessXFeedbackMask)
  Result = toU16(ze(c.enabled_ctrls) and XkbAccessXFeedbackMask)

proc xkbAXNeedOption(c: PXkbControlsPtr, w: int16): int16 = 
  ##define XkbAX_NeedOption(c,w) ((c)->ax_options&(w))
  Result = toU16(ze(c.ax_options) and ze(w))

proc xkbAXNeedFeedback(c: PXkbControlsPtr, w: int16): bool = 
  ##define XkbAX_NeedFeedback(c,w) (XkbAX_AnyFeedback(c)&&XkbAX_NeedOption(c,w))
  Result = (xkbAXAnyFeedback(c) > 0'i16) and (xkbAXNeedOption(c, w) > 0'i16)

proc xkbSMKeyActionsPtr(m: PXkbServerMapPtr, k: int16): PXkbAction = 
  ##define XkbSMKeyActionsPtr(m,k) (&(m)->acts[(m)->key_acts[k]])
  Result = addr(m.acts[ze(m.key_acts[ze(k)])])

proc xkbCMKeyGroupInfo(m: PXkbClientMapPtr, k: int16): int8 = 
  ##define XkbCMKeyGroupInfo(m,k) ((m)->key_sym_map[k].group_info)
  Result = m.key_sym_map[ze(k)].group_info

proc xkbCMKeyNumGroups(m: PXkbClientMapPtr, k: int16): int8 = 
  ##define XkbCMKeyNumGroups(m,k) (XkbNumGroups((m)->key_sym_map[k].group_info))
  Result = toU8(xkbNumGroups(m.key_sym_map[ze(k)].group_info))

proc xkbCMKeyGroupWidth(m: PXkbClientMapPtr, k: int16, g: int8): int8 = 
  ##define XkbCMKeyGroupWidth(m,k,g) (XkbCMKeyType(m,k,g)->num_levels)
  Result = xkbCMKeyType(m, k, g).num_levels

proc xkbCMKeyGroupsWidth(m: PXkbClientMapPtr, K: int16): int8 = 
  ##define XkbCMKeyGroupsWidth(m,k) ((m)->key_sym_map[k].width)
  Result = m.key_sym_map[ze(k)].width

proc xkbCMKeyTypeIndex(m: PXkbClientMapPtr, k: int16, g: int8): int8 = 
  ##define XkbCMKeyTypeIndex(m,k,g) ((m)->key_sym_map[k].kt_index[g&0x3])
  Result = m.key_sym_map[ze(k)].kt_index[ze(g) and 0x00000003]

proc xkbCMKeyType(m: PXkbClientMapPtr, k: int16, g: int8): PXkbKeyTypePtr = 
  ##define XkbCMKeyType(m,k,g) (&(m)->types[XkbCMKeyTypeIndex(m,k,g)])
  Result = addr(m.types[ze(xkbCMKeyTypeIndex(m, k, g))])

proc xkbCMKeyNumSyms(m: PXkbClientMapPtr, k: int16): int16 = 
  ##define XkbCMKeyNumSyms(m,k) (XkbCMKeyGroupsWidth(m,k)*XkbCMKeyNumGroups(m,k))
  Result = toU16(ze(xkbCMKeyGroupsWidth(m, k)) or ze(xkbCMKeyNumGroups(m, k)))

proc xkbCMKeySymsOffset(m: PXkbClientMapPtr, k: int16): int8 = 
  ##define XkbCMKeySymsOffset(m,k) ((m)->key_sym_map[k].offset)
  Result = m.key_sym_map[ze(k)].offset

proc xkbCMKeySymsPtr*(m: PXkbClientMapPtr, k: Int16): PKeySym = 
  ##define XkbCMKeySymsPtr(m,k) (&(m)->syms[XkbCMKeySymsOffset(m,k)])
  Result = addr(m.syms[ze(xkbCMKeySymsOffset(m, k))])

proc xkbIMIsAuto(i: PXkbIndicatorMapPtr): bool = 
  ##define XkbIM_IsAuto(i) ((((i)->flags&XkbIM_NoAutomatic)==0)&&(((i)->which_groups&&(i)->groups)||
  #                           ((i)->which_mods&&(i)->mods.mask)||  ((i)->ctrls)))
  Result = ((ze(i.flags) and XkbIM_NoAutomatic) == 0) and
      (((i.which_groups > 0'i8) and (i.groups > 0'i8)) or
      ((i.which_mods > 0'i8) and (i.mods.mask > 0'i8)) or (i.ctrls > 0'i8))

proc xkbIMInUse(i: PXkbIndicatorMapPtr): bool = 
  ##define XkbIM_InUse(i) (((i)->flags)||((i)->which_groups)||((i)->which_mods)||((i)->ctrls)) 
  Result = (i.flags > 0'i8) or (i.which_groups > 0'i8) or (i.which_mods > 0'i8) or
      (i.ctrls > 0'i8)

proc xkbKeyKeyTypeIndex(d: PXkbDescPtr, k: int16, g: int8): int8 = 
  ##define XkbKeyKeyTypeIndex(d,k,g)      (XkbCMKeyTypeIndex((d)->map,k,g))
  Result = xkbCMKeyTypeIndex(d.map, k, g)

proc xkbKeyKeyType(d: PXkbDescPtr, k: int16, g: int8): PXkbKeyTypePtr = 
  ##define XkbKeyKeyType(d,k,g) (XkbCMKeyType((d)->map,k,g))
  Result = xkbCMKeyType(d.map, k, g)

proc xkbKeyGroupWidth(d: PXkbDescPtr, k: int16, g: int8): int8 = 
  ##define XkbKeyGroupWidth(d,k,g) (XkbCMKeyGroupWidth((d)->map,k,g))
  Result = xkbCMKeyGroupWidth(d.map, k, g)

proc xkbKeyGroupsWidth(d: PXkbDescPtr, k: int16): int8 = 
  ##define XkbKeyGroupsWidth(d,k) (XkbCMKeyGroupsWidth((d)->map,k))
  Result = xkbCMKeyGroupsWidth(d.map, k)

proc xkbKeyGroupInfo(d: PXkbDescPtr, k: int16): int8 = 
  ##define XkbKeyGroupInfo(d,k) (XkbCMKeyGroupInfo((d)->map,(k)))
  Result = xkbCMKeyGroupInfo(d.map, k)

proc xkbKeyNumGroups(d: PXkbDescPtr, k: int16): int8 = 
  ##define XkbKeyNumGroups(d,k) (XkbCMKeyNumGroups((d)->map,(k)))
  Result = xkbCMKeyNumGroups(d.map, k)

proc xkbKeyNumSyms(d: PXkbDescPtr, k: int16): int16 = 
  ##define XkbKeyNumSyms(d,k) (XkbCMKeyNumSyms((d)->map,(k)))
  Result = xkbCMKeyNumSyms(d.map, k)

proc xkbKeySymsPtr*(d: PXkbDescPtr, k: Int16): PKeySym = 
  ##define XkbKeySymsPtr(d,k) (XkbCMKeySymsPtr((d)->map,(k)))
  Result = xkbCMKeySymsPtr(d.map, k)

proc xkbKeySym(d: PXkbDescPtr, k: int16, n: int16): TKeySym = 
  ##define XkbKeySym(d,k,n) (XkbKeySymsPtr(d,k)[n])
  Result = cast[ptr Array[0..0xffff, TKeySym]](xkbKeySymsPtr(d, k))[ze(n)] # XXX: this seems strange!

proc xkbKeySymEntry(d: PXkbDescPtr, k: int16, sl: int16, g: int8): TKeySym = 
  ##define XkbKeySymEntry(d,k,sl,g) (XkbKeySym(d,k,((XkbKeyGroupsWidth(d,k)*(g))+(sl))))
  Result = xkbKeySym(d, k, toU16(ze(xkbKeyGroupsWidth(d, k)) * ze(g) + ze(sl)))

proc xkbKeyAction(d: PXkbDescPtr, k: int16, n: int16): PXkbAction = 
  ##define XkbKeyAction(d,k,n) (XkbKeyHasActions(d,k)?&XkbKeyActionsPtr(d,k)[n]:NULL)
  #if (XkbKeyHasActions(d, k)): 
  #  Result = XkbKeyActionsPtr(d, k)[ze(n)] #Buggy !!!
  assert(false)
  result = nil
  
proc xkbKeyActionEntry(d: PXkbDescPtr, k: int16, sl: int16, g: int8): int8 = 
  ##define XkbKeyActionEntry(d,k,sl,g) (XkbKeyHasActions(d,k) ?
  #                                      XkbKeyAction(d, k, ((XkbKeyGroupsWidth(d, k) * (g))+(sl))):NULL)
  if xkbKeyHasActions(d, k): 
    Result = xkbKeyGroupsWidth(d, k) *% g +% toU8(sl)
  else: 
    Result = 0'i8
  
proc xkbKeyHasActions(d: PXkbDescPtr, k: int16): bool = 
  ##define XkbKeyHasActions(d,k) ((d)->server->key_acts[k]!=0)
  Result = d.server.key_acts[ze(k)] != 0'i16

proc xkbKeyNumActions(d: PXkbDescPtr, k: int16): int16 = 
  ##define XkbKeyNumActions(d,k) (XkbKeyHasActions(d,k)?XkbKeyNumSyms(d,k):1)
  if (xkbKeyHasActions(d, k)): Result = xkbKeyNumSyms(d, k)
  else: Result = 1'i16
  
proc xkbKeyActionsPtr(d: PXkbDescPtr, k: int16): PXkbAction = 
  ##define XkbKeyActionsPtr(d,k) (XkbSMKeyActionsPtr((d)->server,k))
  Result = xkbSMKeyActionsPtr(d.server, k)

proc xkbKeycodeInRange(d: PXkbDescPtr, k: int16): bool = 
  ##define XkbKeycodeInRange(d,k) (((k)>=(d)->min_key_code)&& ((k)<=(d)->max_key_code))
  Result = (Char(toU8(k)) >= d.min_key_code) and (Char(toU8(k)) <= d.max_key_code)

proc xkbNumKeys(d: PXkbDescPtr): int8 = 
  ##define XkbNumKeys(d) ((d)->max_key_code-(d)->min_key_code+1)
  Result = toU8(ord(d.max_key_code) - ord(d.min_key_code) + 1)

proc xkbXIDevHasBtnActs(d: PXkbDeviceInfoPtr): bool = 
  ##define XkbXI_DevHasBtnActs(d) (((d)->num_btns>0)&&((d)->btn_acts!=NULL))
  Result = (d.num_btns > 0'i16) and (not (d.btn_acts == nil))

proc xkbXILegalDevBtn(d: PXkbDeviceInfoPtr, b: int16): bool = 
  ##define XkbXI_LegalDevBtn(d,b) (XkbXI_DevHasBtnActs(d)&&((b)<(d)->num_btns))
  Result = xkbXIDevHasBtnActs(d) and (b <% d.num_btns)

proc xkbXIDevHasLeds(d: PXkbDeviceInfoPtr): bool = 
  ##define XkbXI_DevHasLeds(d) (((d)->num_leds>0)&&((d)->leds!=NULL))
  Result = (d.num_leds > 0'i16) and (not (d.leds == nil))

proc xkbBoundsWidth(b: PXkbBoundsPtr): int16 = 
  ##define XkbBoundsWidth(b) (((b)->x2)-((b)->x1))
  Result = (b.x2) - b.x1

proc xkbBoundsHeight(b: PXkbBoundsPtr): int16 = 
  ##define XkbBoundsHeight(b) (((b)->y2)-((b)->y1))
  Result = (b.y2) - b.y1

proc xkbOutlineIndex(s: PXkbShapePtr, o: PXkbOutlinePtr): int32 = 
  ##define XkbOutlineIndex(s,o) ((int)((o)-&(s)->outlines[0]))
  Result = Int32((cast[TAddress](o) - cast[TAddress](addr(s.outlines[0]))) div sizeof(PXkbOutlinePtr))

proc xkbShapeDoodadColor(g: PXkbGeometryPtr, d: PXkbShapeDoodadPtr): PXkbColorPtr = 
  ##define XkbShapeDoodadColor(g,d) (&(g)->colors[(d)->color_ndx])
  Result = addr((g.colors[ze(d.color_ndx)]))

proc xkbShapeDoodadShape(g: PXkbGeometryPtr, d: PXkbShapeDoodadPtr): PXkbShapePtr = 
  ##define XkbShapeDoodadShape(g,d) (&(g)->shapes[(d)->shape_ndx])
  Result = addr(g.shapes[ze(d.shape_ndx)])

proc xkbSetShapeDoodadColor(g: PXkbGeometryPtr, d: PXkbShapeDoodadPtr, 
                            c: PXkbColorPtr) = 
  ##define XkbSetShapeDoodadColor(g,d,c) ((d)->color_ndx= (c)-&(g)->colors[0])
  d.color_ndx = toU16((cast[TAddress](c) - cast[TAddress](addr(g.colors[0]))) div sizeof(TXkbColorRec))

proc xkbSetShapeDoodadShape(g: PXkbGeometryPtr, d: PXkbShapeDoodadPtr, 
                            s: PXkbShapePtr) = 
  ##define XkbSetShapeDoodadShape(g,d,s) ((d)->shape_ndx= (s)-&(g)->shapes[0])
  d.shape_ndx = toU16((cast[TAddress](s) - cast[TAddress](addr(g.shapes[0]))) div sizeof(TXkbShapeRec))

proc xkbTextDoodadColor(g: PXkbGeometryPtr, d: PXkbTextDoodadPtr): PXkbColorPtr = 
  ##define XkbTextDoodadColor(g,d) (&(g)->colors[(d)->color_ndx])
  Result = addr(g.colors[ze(d.color_ndx)])

proc xkbSetTextDoodadColor(g: PXkbGeometryPtr, d: PXkbTextDoodadPtr, 
                           c: PXkbColorPtr) = 
  ##define XkbSetTextDoodadColor(g,d,c) ((d)->color_ndx= (c)-&(g)->colors[0])
  d.color_ndx = toU16((cast[TAddress](c) - cast[TAddress](addr(g.colors[0]))) div sizeof(TXkbColorRec))

proc xkbIndicatorDoodadShape(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr): PXkbShapeDoodadPtr = 
  ##define XkbIndicatorDoodadShape(g,d) (&(g)->shapes[(d)->shape_ndx])
  Result = cast[PXkbShapeDoodadPtr](addr(g.shapes[ze(d.shape_ndx)]))

proc xkbIndicatorDoodadOnColor(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr): PXkbColorPtr = 
  ##define XkbIndicatorDoodadOnColor(g,d) (&(g)->colors[(d)->on_color_ndx])
  Result = addr(g.colors[ze(d.on_color_ndx)])

proc xkbIndicatorDoodadOffColor(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr): PXkbColorPtr = 
  ##define XkbIndicatorDoodadOffColor(g,d) (&(g)->colors[(d)->off_color_ndx])
  Result = addr(g.colors[ze(d.off_color_ndx)])

proc xkbSetIndicatorDoodadOnColor(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr, 
                                  c: PXkbColorPtr) = 
  ##define XkbSetIndicatorDoodadOnColor(g,d,c) ((d)->on_color_ndx= (c)-&(g)->colors[0])
  d.on_color_ndx = toU16((cast[TAddress](c) - cast[TAddress](addr(g.colors[0]))) div sizeof(TXkbColorRec))

proc xkbSetIndicatorDoodadOffColor(g: PXkbGeometryPtr, 
                                   d: PXkbIndicatorDoodadPtr, c: PXkbColorPtr) = 
  ##define        XkbSetIndicatorDoodadOffColor(g,d,c) ((d)->off_color_ndx= (c)-&(g)->colors[0])
  d.off_color_ndx = toU16((cast[TAddress](c) - cast[TAddress](addr(g.colors[0]))) div sizeof(TxkbColorRec))

proc xkbSetIndicatorDoodadShape(g: PXkbGeometryPtr, d: PXkbIndicatorDoodadPtr, 
                                s: PXkbShapeDoodadPtr) = 
  ##define XkbSetIndicatorDoodadShape(g,d,s) ((d)->shape_ndx= (s)-&(g)->shapes[0])
  d.shape_ndx = toU16((cast[TAddress](s) - (cast[TAddress](addr(g.shapes[0])))) div sizeof(TXkbShapeRec))

proc xkbLogoDoodadColor(g: PXkbGeometryPtr, d: PXkbLogoDoodadPtr): PXkbColorPtr = 
  ##define XkbLogoDoodadColor(g,d) (&(g)->colors[(d)->color_ndx])
  Result = addr(g.colors[ze(d.color_ndx)])

proc xkbLogoDoodadShape(g: PXkbGeometryPtr, d: PXkbLogoDoodadPtr): PXkbShapeDoodadPtr = 
  ##define XkbLogoDoodadShape(g,d) (&(g)->shapes[(d)->shape_ndx])
  Result = cast[PXkbShapeDoodadPtr](addr(g.shapes[ze(d.shape_ndx)]))

proc xkbSetLogoDoodadColor(g: PXkbGeometryPtr, d: PXkbLogoDoodadPtr, 
                           c: PXkbColorPtr) = 
  ##define XkbSetLogoDoodadColor(g,d,c) ((d)->color_ndx= (c)-&(g)->colors[0])
  d.color_ndx = toU16((cast[TAddress](c) - cast[TAddress](addr(g.colors[0]))) div sizeof(TXkbColorRec))

proc xkbSetLogoDoodadShape(g: PXkbGeometryPtr, d: PXkbLogoDoodadPtr, 
                           s: PXkbShapeDoodadPtr) = 
  ##define XkbSetLogoDoodadShape(g,d,s) ((d)->shape_ndx= (s)-&(g)->shapes[0])
  d.shape_ndx = toU16((cast[TAddress](s) - cast[TAddress](addr(g.shapes[0]))) div sizeof(TXkbShapeRec))

proc xkbKeyShape(g: PXkbGeometryPtr, k: PXkbKeyPtr): PXkbShapeDoodadPtr = 
  ##define XkbKeyShape(g,k) (&(g)->shapes[(k)->shape_ndx])
  Result = cast[PXkbShapeDoodadPtr](addr(g.shapes[ze(k.shape_ndx)]))

proc xkbKeyColor(g: PXkbGeometryPtr, k: PXkbKeyPtr): PXkbColorPtr = 
  ##define XkbKeyColor(g,k) (&(g)->colors[(k)->color_ndx])
  Result = addr(g.colors[ze(k.color_ndx)])

proc xkbSetKeyShape(g: PXkbGeometryPtr, k: PXkbKeyPtr, s: PXkbShapeDoodadPtr) = 
  ##define XkbSetKeyShape(g,k,s) ((k)->shape_ndx= (s)-&(g)->shapes[0])
  k.shape_ndx = toU8((cast[TAddress](s) - cast[TAddress](addr(g.shapes[0]))) div sizeof(TXkbShapeRec))

proc xkbSetKeyColor(g: PXkbGeometryPtr, k: PXkbKeyPtr, c: PXkbColorPtr) = 
  ##define XkbSetKeyColor(g,k,c) ((k)->color_ndx= (c)-&(g)->colors[0])
  k.color_ndx = toU8((cast[TAddress](c) - cast[TAddress](addr(g.colors[0]))) div sizeof(TxkbColorRec))

proc xkbGeomColorIndex(g: PXkbGeometryPtr, c: PXkbColorPtr): int32 = 
  ##define XkbGeomColorIndex(g,c) ((int)((c)-&(g)->colors[0]))
  Result = toU16((cast[TAddress](c) - (cast[TAddress](addr(g.colors[0])))) div sizeof(TxkbColorRec))
