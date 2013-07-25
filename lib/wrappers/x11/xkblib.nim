# $Xorg: XKBlib.h,v 1.6 2000/08/17 19:45:03 cpqbld Exp $
#************************************************************
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
#DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING `from` LOSS OF USE,
#DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
#OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
#THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
#********************************************************/
# $XFree86: xc/lib/X11/XKBlib.h,v 3.3 2001/08/01 00:44:38 tsi Exp $
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
#        2004/10/15        - Fixed a bug of accessing second based records by removing "paced record" and
#                            chnaged it to "reocrd" only.
#        2004/10/10        - Added to TXkbGetAtomNameFunc and TXkbInternAtomFunc the cdecl call.
#        2004/10/06 - 09   - Convertion `from` the c header of XKBlib.h
#
#

import
  X, Xlib, XKB

type
  PXkbAnyEvent* = ptr TXkbAnyEvent
  TXkbAnyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds;
    xkb_type*: int16          # XKB event minor code
    device*: int16            # device ID


type
  PXkbNewKeyboardNotifyEvent* = ptr TXkbNewKeyboardNotifyEvent
  TXkbNewKeyboardNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbNewKeyboardNotify
    device*: int16            # device ID
    old_device*: int16        # device ID of previous keyboard
    min_key_code*: int16      # minimum key code
    max_key_code*: int16      # maximum key code
    old_min_key_code*: int16  # min key code of previous kbd
    old_max_key_code*: int16  # max key code of previous kbd
    changed*: int16           # changed aspects of the keyboard
    req_major*: int8          # major and minor opcode of req
    req_minor*: int8          # that caused change, if applicable


type
  PXkbMapNotifyEvent* = ptr TXkbMapNotifyEvent
  TXkbMapNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbMapNotify
    device*: int16            # device ID
    changed*: int16           # fields which have been changed
    flags*: int16             # reserved
    first_type*: int16        # first changed key type
    num_types*: int16         # number of changed key types
    min_key_code*: TKeyCode
    max_key_code*: TKeyCode
    first_key_sym*: TKeyCode
    first_key_act*: TKeyCode
    first_key_behavior*: TKeyCode
    first_key_explicit*: TKeyCode
    first_modmap_key*: TKeyCode
    first_vmodmap_key*: TKeyCode
    num_key_syms*: int16
    num_key_acts*: int16
    num_key_behaviors*: int16
    num_key_explicit*: int16
    num_modmap_keys*: int16
    num_vmodmap_keys*: int16
    vmods*: int16             # mask of changed virtual mods


type
  PXkbStateNotifyEvent* = ptr TXkbStateNotifyEvent
  TXkbStateNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbStateNotify
    device*: int16            # device ID
    changed*: int16           # mask of changed state components
    group*: int16             # keyboard group
    base_group*: int16        # base keyboard group
    latched_group*: int16     # latched keyboard group
    locked_group*: int16      # locked keyboard group
    mods*: int16              # modifier state
    base_mods*: int16         # base modifier state
    latched_mods*: int16      # latched modifiers
    locked_mods*: int16       # locked modifiers
    compat_state*: int16      # compatibility state
    grab_mods*: int8          # mods used for grabs
    compat_grab_mods*: int8   # grab mods for non-XKB clients
    lookup_mods*: int8        # mods sent to clients
    compat_lookup_mods*: int8 # mods sent to non-XKB clients
    ptr_buttons*: int16       # pointer button state
    keycode*: TKeyCode        # keycode that caused the change
    event_type*: int8         # KeyPress or KeyRelease
    req_major*: int8          # Major opcode of request
    req_minor*: int8          # Minor opcode of request


type
  PXkbControlsNotifyEvent* = ptr TXkbControlsNotifyEvent
  TXkbControlsNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbControlsNotify
    device*: int16            # device ID
    changed_ctrls*: int16     # controls with changed sub-values
    enabled_ctrls*: int16     # controls currently enabled
    enabled_ctrl_changes*: int16 # controls just {en,dis}abled
    num_groups*: int16        # total groups on keyboard
    keycode*: TKeyCode        # key that caused change or 0
    event_type*: int8         # type of event that caused change
    req_major*: int8          # if keycode==0, major and minor
    req_minor*: int8          # opcode of req that caused change


type
  PXkbIndicatorNotifyEvent* = ptr TXkbIndicatorNotifyEvent
  TXkbIndicatorNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbIndicatorNotify
    device*: int16            # device
    changed*: int16           # indicators with new state or map
    state*: int16             # current state of all indicators


type
  PXkbNamesNotifyEvent* = ptr TXkbNamesNotifyEvent
  TXkbNamesNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbNamesNotify
    device*: int16            # device ID
    changed*: int32           # names that have changed
    first_type*: int16        # first key type with new name
    num_types*: int16         # number of key types with new names
    first_lvl*: int16         # first key type new new level names
    num_lvls*: int16          # # of key types w/new level names
    num_aliases*: int16       # total number of key aliases
    num_radio_groups*: int16  # total number of radio groups
    changed_vmods*: int16     # virtual modifiers with new names
    changed_groups*: int16    # groups with new names
    changed_indicators*: int16 # indicators with new names
    first_key*: int16         # first key with new name
    num_keys*: int16          # number of keys with new names


type
  PXkbCompatMapNotifyEvent* = ptr TXkbCompatMapNotifyEvent
  TXkbCompatMapNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbCompatMapNotify
    device*: int16            # device ID
    changed_groups*: int16    # groups with new compat maps
    first_si*: int16          # first new symbol interp
    num_si*: int16            # number of new symbol interps
    num_total_si*: int16      # total # of symbol interps


type
  PXkbBellNotifyEvent* = ptr TXkbBellNotifyEvent
  TXkbBellNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbBellNotify
    device*: int16            # device ID
    percent*: int16           # requested volume as a % of maximum
    pitch*: int16             # requested pitch in Hz
    duration*: int16          # requested duration in useconds
    bell_class*: int16        # (input extension) feedback class
    bell_id*: int16           # (input extension) ID of feedback
    name*: TAtom              # "name" of requested bell
    window*: TWindow          # window associated with event
    event_only*: bool         # "event only" requested


type
  PXkbActionMessageEvent* = ptr TXkbActionMessageEvent
  TXkbActionMessageEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbActionMessage
    device*: int16            # device ID
    keycode*: TKeyCode        # key that generated the event
    press*: bool              # true if act caused by key press
    key_event_follows*: bool  # true if key event also generated
    group*: int16             # effective group
    mods*: int16              # effective mods
    message*: array[0..XkbActionMessageLength, char] # message -- leave space for NUL


type
  PXkbAccessXNotifyEvent* = ptr TXkbAccessXNotifyEvent
  TXkbAccessXNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbAccessXNotify
    device*: int16            # device ID
    detail*: int16            # XkbAXN_*
    keycode*: int16           # key of event
    sk_delay*: int16          # current slow keys delay
    debounce_delay*: int16    # current debounce delay


type
  PXkbExtensionDeviceNotifyEvent* = ptr TXkbExtensionDeviceNotifyEvent
  TXkbExtensionDeviceNotifyEvent*{.final.} = object
    theType*: int16           # XkbAnyEvent
    serial*: int32            # of last req processed by server
    send_event*: bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: int16          # XkbExtensionDeviceNotify
    device*: int16            # device ID
    reason*: int16            # reason for the event
    supported*: int16         # mask of supported features
    unsupported*: int16       # mask of unsupported features
                              # that some app tried to use
    first_btn*: int16         # first button that changed
    num_btns*: int16          # range of buttons changed
    leds_defined*: int16      # indicators with names or maps
    led_state*: int16         # current state of the indicators
    led_class*: int16         # feedback class for led changes
    led_id*: int16            # feedback id for led changes


type
  PXkbEvent* = ptr TXkbEvent
  TXkbEvent*{.final.} = object
    theType*: int16
    any*: TXkbAnyEvent
    new_kbd*: TXkbNewKeyboardNotifyEvent
    map*: TXkbMapNotifyEvent
    state*: TXkbStateNotifyEvent
    ctrls*: TXkbControlsNotifyEvent
    indicators*: TXkbIndicatorNotifyEvent
    names*: TXkbNamesNotifyEvent
    compat*: TXkbCompatMapNotifyEvent
    bell*: TXkbBellNotifyEvent
    message*: TXkbActionMessageEvent
    accessx*: TXkbAccessXNotifyEvent
    device*: TXkbExtensionDeviceNotifyEvent
    core*: TXEvent


type
  PXkbKbdDpyStatePtr* = ptr TXkbKbdDpyStateRec
  TXkbKbdDpyStateRec*{.final.} = object  # XkbOpenDisplay error codes

const
  XkbOD_Success* = 0
  XkbOD_BadLibraryVersion* = 1
  XkbOD_ConnectionRefused* = 2
  XkbOD_NonXkbServer* = 3
  XkbOD_BadServerVersion* = 4 # Values for XlibFlags

const
  XkbLC_ForceLatin1Lookup* = 1 shl 0
  XkbLC_ConsumeLookupMods* = 1 shl 1
  XkbLC_AlwaysConsumeShiftAndLock* = 1 shl 2
  XkbLC_IgnoreNewKeyboards* = 1 shl 3
  XkbLC_ControlFallback* = 1 shl 4
  XkbLC_ConsumeKeysOnComposeFail* = 1 shl 29
  XkbLC_ComposeLED* = 1 shl 30
  XkbLC_BeepOnComposeFail* = 1 shl 31
  XkbLC_AllComposeControls* = 0xC0000000
  XkbLC_AllControls* = 0xC000001F

proc xkbIgnoreExtension*(ignore: bool): bool{.cdecl, dynlib: libX11,
    importc: "XkbIgnoreExtension".}
proc xkbOpenDisplay*(name: cstring, ev_rtrn, err_rtrn, major_rtrn, minor_rtrn,
                                    reason: ptr int16): PDisplay{.cdecl,
    dynlib: libX11, importc: "XkbOpenDisplay".}
proc xkbQueryExtension*(dpy: PDisplay, opcodeReturn, eventBaseReturn,
                                       errorBaseReturn, majorRtrn, minorRtrn: ptr int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbQueryExtension".}
proc xkbUseExtension*(dpy: PDisplay, major_rtrn, minor_rtrn: ptr int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbUseExtension".}
proc xkbLibraryVersion*(libMajorRtrn, libMinorRtrn: ptr int16): bool{.cdecl,
    dynlib: libX11, importc: "XkbLibraryVersion".}
proc xkbSetXlibControls*(dpy: PDisplay, affect, values: int16): int16{.cdecl,
    dynlib: libX11, importc: "XkbSetXlibControls".}
proc xkbGetXlibControls*(dpy: PDisplay): int16{.cdecl, dynlib: libX11,
    importc: "XkbGetXlibControls".}
type
  TXkbInternAtomFunc* = proc (dpy: PDisplay, name: cstring, only_if_exists: bool): TAtom{.
      cdecl.}

type
  TXkbGetAtomNameFunc* = proc (dpy: PDisplay, atom: TAtom): cstring{.cdecl.}

proc xkbSetAtomFuncs*(getAtom: TXkbInternAtomFunc, getName: TXkbGetAtomNameFunc){.
    cdecl, dynlib: libX11, importc: "XkbSetAtomFuncs".}
proc xkbKeycodeToKeysym*(dpy: PDisplay, kc: TKeyCode, group, level: int16): TKeySym{.
    cdecl, dynlib: libX11, importc: "XkbKeycodeToKeysym".}
proc xkbKeysymToModifiers*(dpy: PDisplay, ks: TKeySym): int16{.cdecl,
    dynlib: libX11, importc: "XkbKeysymToModifiers".}
proc xkbLookupKeySym*(dpy: PDisplay, keycode: TKeyCode,
                      modifiers, modifiers_return: int16, keysym_return: PKeySym): bool{.
    cdecl, dynlib: libX11, importc: "XkbLookupKeySym".}
proc xkbLookupKeyBinding*(dpy: PDisplay, sym_rtrn: TKeySym, mods: int16,
                          buffer: cstring, nbytes: int16, extra_rtrn: ptr int16): int16{.
    cdecl, dynlib: libX11, importc: "XkbLookupKeyBinding".}
proc xkbTranslateKeyCode*(xkb: PXkbDescPtr, keycode: TKeyCode,
                          modifiers, modifiers_return: int16,
                          keysym_return: PKeySym): bool{.cdecl, dynlib: libX11,
    importc: "XkbTranslateKeyCode".}
proc xkbTranslateKeySym*(dpy: PDisplay, sym_return: TKeySym, modifiers: int16,
                         buffer: cstring, nbytes: int16, extra_rtrn: ptr int16): int16{.
    cdecl, dynlib: libX11, importc: "XkbTranslateKeySym".}
proc xkbSetAutoRepeatRate*(dpy: PDisplay, deviceSpec, delay, interval: int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbSetAutoRepeatRate".}
proc xkbGetAutoRepeatRate*(dpy: PDisplay, deviceSpec: int16,
                           delayRtrn, intervalRtrn: PWord): bool{.cdecl,
    dynlib: libX11, importc: "XkbGetAutoRepeatRate".}
proc xkbChangeEnabledControls*(dpy: PDisplay, deviceSpec, affect, values: int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbChangeEnabledControls".}
proc xkbDeviceBell*(dpy: PDisplay, win: TWindow,
                    deviceSpec, bellClass, bellID, percent: int16, name: TAtom): bool{.
    cdecl, dynlib: libX11, importc: "XkbDeviceBell".}
proc xkbForceDeviceBell*(dpy: PDisplay,
                         deviceSpec, bellClass, bellID, percent: int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbForceDeviceBell".}
proc xkbDeviceBellEvent*(dpy: PDisplay, win: TWindow,
                         deviceSpec, bellClass, bellID, percent: int16,
                         name: TAtom): bool{.cdecl, dynlib: libX11,
    importc: "XkbDeviceBellEvent".}
proc xkbBell*(dpy: PDisplay, win: TWindow, percent: int16, name: TAtom): bool{.
    cdecl, dynlib: libX11, importc: "XkbBell".}
proc xkbForceBell*(dpy: PDisplay, percent: int16): bool{.cdecl, dynlib: libX11,
    importc: "XkbForceBell".}
proc xkbBellEvent*(dpy: PDisplay, win: TWindow, percent: int16, name: TAtom): bool{.
    cdecl, dynlib: libX11, importc: "XkbBellEvent".}
proc xkbSelectEvents*(dpy: PDisplay, deviceID, affect, values: int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbSelectEvents".}
proc xkbSelectEventDetails*(dpy: PDisplay, deviceID, eventType: int16,
                            affect, details: int32): bool{.cdecl,
    dynlib: libX11, importc: "XkbSelectEventDetails".}
proc xkbNoteMapChanges*(old: PXkbMapChangesPtr, new: PXkbMapNotifyEvent,
                        wanted: int16){.cdecl, dynlib: libX11,
                                        importc: "XkbNoteMapChanges".}
proc xkbNoteNameChanges*(old: PXkbNameChangesPtr, new: PXkbNamesNotifyEvent,
                         wanted: int16){.cdecl, dynlib: libX11,
    importc: "XkbNoteNameChanges".}
proc xkbGetIndicatorState*(dpy: PDisplay, deviceSpec: int16, pStateRtrn: PWord): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetIndicatorState".}
proc xkbGetDeviceIndicatorState*(dpy: PDisplay,
                                 deviceSpec, ledClass, ledID: int16,
                                 pStateRtrn: PWord): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbGetDeviceIndicatorState".}
proc xkbGetIndicatorMap*(dpy: PDisplay, which: int32, desc: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetIndicatorMap".}
proc xkbSetIndicatorMap*(dpy: PDisplay, which: int32, desc: PXkbDescPtr): bool{.
    cdecl, dynlib: libX11, importc: "XkbSetIndicatorMap".}
proc xkbNoteIndicatorMapChanges*(o, n: PXkbIndicatorChangesPtr, w: int16)
proc xkbNoteIndicatorStateChanges*(o, n: PXkbIndicatorChangesPtr, w: int16)
proc xkbGetIndicatorMapChanges*(d: PDisplay, x: PXkbDescPtr,
                                c: PXkbIndicatorChangesPtr): TStatus
proc xkbChangeIndicatorMaps*(d: PDisplay, x: PXkbDescPtr,
                             c: PXkbIndicatorChangesPtr): bool
proc xkbGetNamedIndicator*(dpy: PDisplay, name: TAtom, pNdxRtrn: ptr int16,
                           pStateRtrn: ptr bool, pMapRtrn: PXkbIndicatorMapPtr,
                           pRealRtrn: ptr bool): bool{.cdecl, dynlib: libX11,
    importc: "XkbGetNamedIndicator".}
proc xkbGetNamedDeviceIndicator*(dpy: PDisplay,
                                 deviceSpec, ledClass, ledID: int16,
                                 name: TAtom, pNdxRtrn: ptr int16,
                                 pStateRtrn: ptr bool,
                                 pMapRtrn: PXkbIndicatorMapPtr,
                                 pRealRtrn: ptr bool): bool{.cdecl,
    dynlib: libX11, importc: "XkbGetNamedDeviceIndicator".}
proc xkbSetNamedIndicator*(dpy: PDisplay, name: TAtom,
                           changeState, state, createNewMap: bool,
                           pMap: PXkbIndicatorMapPtr): bool{.cdecl,
    dynlib: libX11, importc: "XkbSetNamedIndicator".}
proc xkbSetNamedDeviceIndicator*(dpy: PDisplay,
                                 deviceSpec, ledClass, ledID: int16,
                                 name: TAtom,
                                 changeState, state, createNewMap: bool,
                                 pMap: PXkbIndicatorMapPtr): bool{.cdecl,
    dynlib: libX11, importc: "XkbSetNamedDeviceIndicator".}
proc xkbLockModifiers*(dpy: PDisplay, deviceSpec, affect, values: int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbLockModifiers".}
proc xkbLatchModifiers*(dpy: PDisplay, deviceSpec, affect, values: int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbLatchModifiers".}
proc xkbLockGroup*(dpy: PDisplay, deviceSpec, group: int16): bool{.cdecl,
    dynlib: libX11, importc: "XkbLockGroup".}
proc xkbLatchGroup*(dpy: PDisplay, deviceSpec, group: int16): bool{.cdecl,
    dynlib: libX11, importc: "XkbLatchGroup".}
proc xkbSetServerInternalMods*(dpy: PDisplay, deviceSpec, affectReal,
    realValues, affectVirtual, virtualValues: int16): bool{.cdecl,
    dynlib: libX11, importc: "XkbSetServerInternalMods".}
proc xkbSetIgnoreLockMods*(dpy: PDisplay, deviceSpec, affectReal, realValues,
    affectVirtual, virtualValues: int16): bool{.cdecl, dynlib: libX11,
    importc: "XkbSetIgnoreLockMods".}
proc xkbVirtualModsToReal*(dpy: PDisplay, virtual_mask: int16, mask_rtrn: PWord): bool{.
    cdecl, dynlib: libX11, importc: "XkbVirtualModsToReal".}
proc xkbComputeEffectiveMap*(xkb: PXkbDescPtr, theType: PXkbKeyTypePtr,
                             map_rtrn: PByte): bool{.cdecl, dynlib: libX11,
    importc: "XkbComputeEffectiveMap".}
proc xkbInitCanonicalKeyTypes*(xkb: PXkbDescPtr, which: int16, keypadVMod: int16): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbInitCanonicalKeyTypes".}
proc xkballocKeyboard*(): PXkbDescPtr{.cdecl, dynlib: libX11,
                                       importc: "XkballocKeyboard".}
proc xkbFreeKeyboard*(xkb: PXkbDescPtr, which: int16, freeDesc: bool){.cdecl,
    dynlib: libX11, importc: "XkbFreeKeyboard".}
proc xkballocClientMap*(xkb: PXkbDescPtr, which, nTypes: int16): TStatus{.cdecl,
    dynlib: libX11, importc: "XkballocClientMap".}
proc xkballocServerMap*(xkb: PXkbDescPtr, which, nActions: int16): TStatus{.
    cdecl, dynlib: libX11, importc: "XkballocServerMap".}
proc xkbFreeClientMap*(xkb: PXkbDescPtr, what: int16, freeMap: bool){.cdecl,
    dynlib: libX11, importc: "XkbFreeClientMap".}
proc xkbFreeServerMap*(xkb: PXkbDescPtr, what: int16, freeMap: bool){.cdecl,
    dynlib: libX11, importc: "XkbFreeServerMap".}
proc xkbAddKeyType*(xkb: PXkbDescPtr, name: TAtom, map_count: int16,
                    want_preserve: bool, num_lvls: int16): PXkbKeyTypePtr{.
    cdecl, dynlib: libX11, importc: "XkbAddKeyType".}
proc xkballocIndicatorMaps*(xkb: PXkbDescPtr): TStatus{.cdecl, dynlib: libX11,
    importc: "XkballocIndicatorMaps".}
proc xkbFreeIndicatorMaps*(xkb: PXkbDescPtr){.cdecl, dynlib: libX11,
    importc: "XkbFreeIndicatorMaps".}
proc xkbGetMap*(dpy: PDisplay, which, deviceSpec: int16): PXkbDescPtr{.cdecl,
    dynlib: libX11, importc: "XkbGetMap".}
proc xkbGetUpdatedMap*(dpy: PDisplay, which: int16, desc: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetUpdatedMap".}
proc xkbGetMapChanges*(dpy: PDisplay, xkb: PXkbDescPtr,
                       changes: PXkbMapChangesPtr): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbGetMapChanges".}
proc xkbRefreshKeyboardMapping*(event: PXkbMapNotifyEvent): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbRefreshKeyboardMapping".}
proc xkbGetKeyTypes*(dpy: PDisplay, first, num: int16, xkb: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetKeyTypes".}
proc xkbGetKeySyms*(dpy: PDisplay, first, num: int16, xkb: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetKeySyms".}
proc xkbGetKeyActions*(dpy: PDisplay, first, num: int16, xkb: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetKeyActions".}
proc xkbGetKeyBehaviors*(dpy: PDisplay, firstKey, nKeys: int16,
                         desc: PXkbDescPtr): TStatus{.cdecl, dynlib: libX11,
    importc: "XkbGetKeyBehaviors".}
proc xkbGetVirtualMods*(dpy: PDisplay, which: int16, desc: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetVirtualMods".}
proc xkbGetKeyExplicitComponents*(dpy: PDisplay, firstKey, nKeys: int16,
                                  desc: PXkbDescPtr): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbGetKeyExplicitComponents".}
proc xkbGetKeyModifierMap*(dpy: PDisplay, firstKey, nKeys: int16,
                           desc: PXkbDescPtr): TStatus{.cdecl, dynlib: libX11,
    importc: "XkbGetKeyModifierMap".}
proc xkballocControls*(xkb: PXkbDescPtr, which: int16): TStatus{.cdecl,
    dynlib: libX11, importc: "XkballocControls".}
proc xkbFreeControls*(xkb: PXkbDescPtr, which: int16, freeMap: bool){.cdecl,
    dynlib: libX11, importc: "XkbFreeControls".}
proc xkbGetControls*(dpy: PDisplay, which: int32, desc: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetControls".}
proc xkbSetControls*(dpy: PDisplay, which: int32, desc: PXkbDescPtr): bool{.
    cdecl, dynlib: libX11, importc: "XkbSetControls".}
proc xkbNoteControlsChanges*(old: PXkbControlsChangesPtr,
                             new: PXkbControlsNotifyEvent, wanted: int16){.
    cdecl, dynlib: libX11, importc: "XkbNoteControlsChanges".}
proc xkbGetControlsChanges*(d: PDisplay, x: PXkbDescPtr,
                            c: PXkbControlsChangesPtr): TStatus
proc xkbChangeControls*(d: PDisplay, x: PXkbDescPtr, c: PXkbControlsChangesPtr): bool
proc xkballocCompatMap*(xkb: PXkbDescPtr, which, nInterpret: int16): TStatus{.
    cdecl, dynlib: libX11, importc: "XkballocCompatMap".}
proc xkbFreeCompatMap*(xkib: PXkbDescPtr, which: int16, freeMap: bool){.cdecl,
    dynlib: libX11, importc: "XkbFreeCompatMap".}
proc xkbGetCompatMap*(dpy: PDisplay, which: int16, xkb: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetCompatMap".}
proc xkbSetCompatMap*(dpy: PDisplay, which: int16, xkb: PXkbDescPtr,
                      updateActions: bool): bool{.cdecl, dynlib: libX11,
    importc: "XkbSetCompatMap".}
proc xkbAddSymInterpret*(xkb: PXkbDescPtr, si: PXkbSymInterpretPtr,
                         updateMap: bool, changes: PXkbChangesPtr): PXkbSymInterpretPtr{.
    cdecl, dynlib: libX11, importc: "XkbAddSymInterpret".}
proc xkballocNames*(xkb: PXkbDescPtr, which: int16,
                    nTotalRG, nTotalAliases: int16): TStatus{.cdecl,
    dynlib: libX11, importc: "XkballocNames".}
proc xkbGetNames*(dpy: PDisplay, which: int16, desc: PXkbDescPtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetNames".}
proc xkbSetNames*(dpy: PDisplay, which, firstType, nTypes: int16,
                  desc: PXkbDescPtr): bool{.cdecl, dynlib: libX11,
    importc: "XkbSetNames".}
proc xkbChangeNames*(dpy: PDisplay, xkb: PXkbDescPtr,
                     changes: PXkbNameChangesPtr): bool{.cdecl, dynlib: libX11,
    importc: "XkbChangeNames".}
proc xkbFreeNames*(xkb: PXkbDescPtr, which: int16, freeMap: bool){.cdecl,
    dynlib: libX11, importc: "XkbFreeNames".}
proc xkbGetState*(dpy: PDisplay, deviceSpec: int16, rtrnState: PXkbStatePtr): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbGetState".}
proc xkbSetMap*(dpy: PDisplay, which: int16, desc: PXkbDescPtr): bool{.cdecl,
    dynlib: libX11, importc: "XkbSetMap".}
proc xkbChangeMap*(dpy: PDisplay, desc: PXkbDescPtr, changes: PXkbMapChangesPtr): bool{.
    cdecl, dynlib: libX11, importc: "XkbChangeMap".}
proc xkbSetDetectableAutoRepeat*(dpy: PDisplay, detectable: bool,
                                 supported: ptr bool): bool{.cdecl,
    dynlib: libX11, importc: "XkbSetDetectableAutoRepeat".}
proc xkbGetDetectableAutoRepeat*(dpy: PDisplay, supported: ptr bool): bool{.
    cdecl, dynlib: libX11, importc: "XkbGetDetectableAutoRepeat".}
proc xkbSetAutoResetControls*(dpy: PDisplay, changes: int16,
                              auto_ctrls, auto_values: PWord): bool{.cdecl,
    dynlib: libX11, importc: "XkbSetAutoResetControls".}
proc xkbGetAutoResetControls*(dpy: PDisplay, auto_ctrls, auto_ctrl_values: PWord): bool{.
    cdecl, dynlib: libX11, importc: "XkbGetAutoResetControls".}
proc xkbSetPerClientControls*(dpy: PDisplay, change: int16, values: PWord): bool{.
    cdecl, dynlib: libX11, importc: "XkbSetPerClientControls".}
proc xkbGetPerClientControls*(dpy: PDisplay, ctrls: PWord): bool{.cdecl,
    dynlib: libX11, importc: "XkbGetPerClientControls".}
proc xkbCopyKeyType*(`from`, into: PXkbKeyTypePtr): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbCopyKeyType".}
proc xkbCopyKeyTypes*(`from`, into: PXkbKeyTypePtr, num_types: int16): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbCopyKeyTypes".}
proc xkbResizeKeyType*(xkb: PXkbDescPtr, type_ndx, map_count: int16,
                       want_preserve: bool, new_num_lvls: int16): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbResizeKeyType".}
proc xkbResizeKeySyms*(desc: PXkbDescPtr, forKey, symsNeeded: int16): PKeySym{.
    cdecl, dynlib: libX11, importc: "XkbResizeKeySyms".}
proc xkbResizeKeyActions*(desc: PXkbDescPtr, forKey, actsNeeded: int16): PXkbAction{.
    cdecl, dynlib: libX11, importc: "XkbResizeKeyActions".}
proc xkbChangeTypesOfKey*(xkb: PXkbDescPtr, key, num_groups: int16,
                          groups: int16, newTypes: ptr int16,
                          pChanges: PXkbMapChangesPtr): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbChangeTypesOfKey".}

proc xkbListComponents*(dpy: PDisplay, deviceSpec: int16,
                        ptrns: PXkbComponentNamesPtr, max_inout: ptr int16): PXkbComponentListPtr{.
    cdecl, dynlib: libX11, importc: "XkbListComponents".}
proc xkbFreeComponentList*(list: PXkbComponentListPtr){.cdecl, dynlib: libX11,
    importc: "XkbFreeComponentList".}
proc xkbGetKeyboard*(dpy: PDisplay, which, deviceSpec: int16): PXkbDescPtr{.
    cdecl, dynlib: libX11, importc: "XkbGetKeyboard".}
proc xkbGetKeyboardByName*(dpy: PDisplay, deviceSpec: int16,
                           names: PXkbComponentNamesPtr, want, need: int16,
                           load: bool): PXkbDescPtr{.cdecl, dynlib: libX11,
    importc: "XkbGetKeyboardByName".}

proc xkbKeyTypesForCoreSymbols*(xkb: PXkbDescPtr,
                                map_width: int16,  # keyboard device
                                core_syms: PKeySym,  # always mapWidth symbols
                                protected: int16,  # explicit key types
                                types_inout: ptr int16,  # always four type indices
                                xkb_syms_rtrn: PKeySym): int16{.cdecl,
    dynlib: libX11, importc: "XkbKeyTypesForCoreSymbols".}
  # must have enough space
proc xkbApplyCompatMapToKey*(xkb: PXkbDescPtr,
                             key: TKeyCode,  # key to be updated
                             changes: PXkbChangesPtr): bool{.cdecl,
    dynlib: libX11, importc: "XkbApplyCompatMapToKey".}
  # resulting changes to map
proc xkbUpdateMapFromCore*(xkb: PXkbDescPtr,
                           first_key: TKeyCode,  # first changed key
                           num_keys,
                           map_width: int16,
                           core_keysyms: PKeySym,  # symbols `from` core keymap
                           changes: PXkbChangesPtr): bool{.cdecl,
    dynlib: libX11, importc: "XkbUpdateMapFromCore".}

proc xkbAddDeviceLedInfo*(devi: PXkbDeviceInfoPtr, ledClass, ledId: int16): PXkbDeviceLedInfoPtr{.
    cdecl, dynlib: libX11, importc: "XkbAddDeviceLedInfo".}
proc xkbResizeDeviceButtonActions*(devi: PXkbDeviceInfoPtr, newTotal: int16): TStatus{.
    cdecl, dynlib: libX11, importc: "XkbResizeDeviceButtonActions".}
proc xkballocDeviceInfo*(deviceSpec, nButtons, szLeds: int16): PXkbDeviceInfoPtr{.
    cdecl, dynlib: libX11, importc: "XkballocDeviceInfo".}
proc xkbFreeDeviceInfo*(devi: PXkbDeviceInfoPtr, which: int16, freeDevI: bool){.
    cdecl, dynlib: libX11, importc: "XkbFreeDeviceInfo".}
proc xkbNoteDeviceChanges*(old: PXkbDeviceChangesPtr,
                           new: PXkbExtensionDeviceNotifyEvent, wanted: int16){.
    cdecl, dynlib: libX11, importc: "XkbNoteDeviceChanges".}
proc xkbGetDeviceInfo*(dpy: PDisplay, which, deviceSpec, ledClass, ledID: int16): PXkbDeviceInfoPtr{.
    cdecl, dynlib: libX11, importc: "XkbGetDeviceInfo".}
proc xkbGetDeviceInfoChanges*(dpy: PDisplay, devi: PXkbDeviceInfoPtr,
                              changes: PXkbDeviceChangesPtr): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbGetDeviceInfoChanges".}
proc xkbGetDeviceButtonActions*(dpy: PDisplay, devi: PXkbDeviceInfoPtr,
                                all: bool, first, nBtns: int16): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbGetDeviceButtonActions".}
proc xkbGetDeviceLedInfo*(dpy: PDisplay, devi: PXkbDeviceInfoPtr,
                          ledClass, ledId, which: int16): TStatus{.cdecl,
    dynlib: libX11, importc: "XkbGetDeviceLedInfo".}
proc xkbSetDeviceInfo*(dpy: PDisplay, which: int16, devi: PXkbDeviceInfoPtr): bool{.
    cdecl, dynlib: libX11, importc: "XkbSetDeviceInfo".}
proc xkbChangeDeviceInfo*(dpy: PDisplay, desc: PXkbDeviceInfoPtr,
                          changes: PXkbDeviceChangesPtr): bool{.cdecl,
    dynlib: libX11, importc: "XkbChangeDeviceInfo".}
proc xkbSetDeviceLedInfo*(dpy: PDisplay, devi: PXkbDeviceInfoPtr,
                          ledClass, ledID, which: int16): bool{.cdecl,
    dynlib: libX11, importc: "XkbSetDeviceLedInfo".}
proc xkbSetDeviceButtonActions*(dpy: PDisplay, devi: PXkbDeviceInfoPtr,
                                first, nBtns: int16): bool{.cdecl,
    dynlib: libX11, importc: "XkbSetDeviceButtonActions".}

proc xkbToControl*(c: int8): int8{.cdecl, dynlib: libX11,
                                   importc: "XkbToControl".}

proc xkbSetDebuggingFlags*(dpy: PDisplay, mask, flags: int16, msg: cstring,
                           ctrls_mask, ctrls, rtrn_flags, rtrn_ctrls: int16): bool{.
    cdecl, dynlib: libX11, importc: "XkbSetDebuggingFlags".}
proc xkbApplyVirtualModChanges*(xkb: PXkbDescPtr, changed: int16,
                                changes: PXkbChangesPtr): bool{.cdecl,
    dynlib: libX11, importc: "XkbApplyVirtualModChanges".}

# implementation

proc xkbNoteIndicatorMapChanges(o, n: PXkbIndicatorChangesPtr, w: int16) =
  ##define XkbNoteIndicatorMapChanges(o,n,w) ((o)->map_changes|=((n)->map_changes&(w)))
  o.map_changes = o.map_changes or (n.map_changes and w)

proc xkbNoteIndicatorStateChanges(o, n: PXkbIndicatorChangesPtr, w: int16) =
  ##define XkbNoteIndicatorStateChanges(o,n,w) ((o)->state_changes|=((n)->state_changes&(w)))
  o.state_changes = o.state_changes or (n.state_changes and (w))

proc xkbGetIndicatorMapChanges(d: PDisplay, x: PXkbDescPtr,
                               c: PXkbIndicatorChangesPtr): TStatus =
  ##define XkbGetIndicatorMapChanges(d,x,c) (XkbGetIndicatorMap((d),(c)->map_changes,x)
  Result = XkbGetIndicatorMap(d, c.map_changes, x)

proc xkbChangeIndicatorMaps(d: PDisplay, x: PXkbDescPtr,
                            c: PXkbIndicatorChangesPtr): bool =
  ##define XkbChangeIndicatorMaps(d,x,c) (XkbSetIndicatorMap((d),(c)->map_changes,x))
  Result = XkbSetIndicatorMap(d, c.map_changes, x)

proc xkbGetControlsChanges(d: PDisplay, x: PXkbDescPtr,
                           c: PXkbControlsChangesPtr): TStatus =
  ##define XkbGetControlsChanges(d,x,c) XkbGetControls(d,(c)->changed_ctrls,x)
  Result = XkbGetControls(d, c.changed_ctrls, x)

proc xkbChangeControls(d: PDisplay, x: PXkbDescPtr, c: PXkbControlsChangesPtr): bool =
  ##define XkbChangeControls(d,x,c) XkbSetControls(d,(c)->changed_ctrls,x)
  Result = XkbSetControls(d, c.changed_ctrls, x)
