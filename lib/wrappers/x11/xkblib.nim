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


include "x11pragma.nim"


type 
  PXkbAnyEvent* = ptr TXkbAnyEvent
  TXkbAnyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds;
    xkb_type*: Int16          # XKB event minor code
    device*: Int16            # device ID
  

type 
  PXkbNewKeyboardNotifyEvent* = ptr TXkbNewKeyboardNotifyEvent
  TXkbNewKeyboardNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbNewKeyboardNotify
    device*: Int16            # device ID
    old_device*: Int16        # device ID of previous keyboard
    min_key_code*: Int16      # minimum key code
    max_key_code*: Int16      # maximum key code
    old_min_key_code*: Int16  # min key code of previous kbd
    old_max_key_code*: Int16  # max key code of previous kbd
    changed*: Int16           # changed aspects of the keyboard
    req_major*: Int8          # major and minor opcode of req
    req_minor*: Int8          # that caused change, if applicable
  

type 
  PXkbMapNotifyEvent* = ptr TXkbMapNotifyEvent
  TXkbMapNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbMapNotify
    device*: Int16            # device ID
    changed*: Int16           # fields which have been changed
    flags*: Int16             # reserved
    first_type*: Int16        # first changed key type
    num_types*: Int16         # number of changed key types
    min_key_code*: TKeyCode
    max_key_code*: TKeyCode
    first_key_sym*: TKeyCode
    first_key_act*: TKeyCode
    first_key_behavior*: TKeyCode
    first_key_explicit*: TKeyCode
    first_modmap_key*: TKeyCode
    first_vmodmap_key*: TKeyCode
    num_key_syms*: Int16
    num_key_acts*: Int16
    num_key_behaviors*: Int16
    num_key_explicit*: Int16
    num_modmap_keys*: Int16
    num_vmodmap_keys*: Int16
    vmods*: Int16             # mask of changed virtual mods
  

type 
  PXkbStateNotifyEvent* = ptr TXkbStateNotifyEvent
  TXkbStateNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbStateNotify
    device*: Int16            # device ID
    changed*: Int16           # mask of changed state components
    group*: Int16             # keyboard group
    base_group*: Int16        # base keyboard group
    latched_group*: Int16     # latched keyboard group
    locked_group*: Int16      # locked keyboard group
    mods*: Int16              # modifier state
    base_mods*: Int16         # base modifier state
    latched_mods*: Int16      # latched modifiers
    locked_mods*: Int16       # locked modifiers
    compat_state*: Int16      # compatibility state
    grab_mods*: Int8          # mods used for grabs
    compat_grab_mods*: Int8   # grab mods for non-XKB clients
    lookup_mods*: Int8        # mods sent to clients
    compat_lookup_mods*: Int8 # mods sent to non-XKB clients
    ptr_buttons*: Int16       # pointer button state
    keycode*: TKeyCode        # keycode that caused the change
    event_type*: Int8         # KeyPress or KeyRelease
    req_major*: Int8          # Major opcode of request
    req_minor*: Int8          # Minor opcode of request
  

type 
  PXkbControlsNotifyEvent* = ptr TXkbControlsNotifyEvent
  TXkbControlsNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbControlsNotify
    device*: Int16            # device ID
    changed_ctrls*: Int16     # controls with changed sub-values
    enabled_ctrls*: Int16     # controls currently enabled
    enabled_ctrl_changes*: Int16 # controls just {en,dis}abled
    num_groups*: Int16        # total groups on keyboard
    keycode*: TKeyCode        # key that caused change or 0
    event_type*: Int8         # type of event that caused change
    req_major*: Int8          # if keycode==0, major and minor
    req_minor*: Int8          # opcode of req that caused change
  

type 
  PXkbIndicatorNotifyEvent* = ptr TXkbIndicatorNotifyEvent
  TXkbIndicatorNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbIndicatorNotify
    device*: Int16            # device
    changed*: Int16           # indicators with new state or map
    state*: Int16             # current state of all indicators
  

type 
  PXkbNamesNotifyEvent* = ptr TXkbNamesNotifyEvent
  TXkbNamesNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbNamesNotify
    device*: Int16            # device ID
    changed*: Int32           # names that have changed
    first_type*: Int16        # first key type with new name
    num_types*: Int16         # number of key types with new names
    first_lvl*: Int16         # first key type new new level names
    num_lvls*: Int16          # # of key types w/new level names
    num_aliases*: Int16       # total number of key aliases
    num_radio_groups*: Int16  # total number of radio groups
    changed_vmods*: Int16     # virtual modifiers with new names
    changed_groups*: Int16    # groups with new names
    changed_indicators*: Int16 # indicators with new names
    first_key*: Int16         # first key with new name
    num_keys*: Int16          # number of keys with new names
  

type 
  PXkbCompatMapNotifyEvent* = ptr TXkbCompatMapNotifyEvent
  TXkbCompatMapNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbCompatMapNotify
    device*: Int16            # device ID
    changed_groups*: Int16    # groups with new compat maps
    first_si*: Int16          # first new symbol interp
    num_si*: Int16            # number of new symbol interps
    num_total_si*: Int16      # total # of symbol interps
  

type 
  PXkbBellNotifyEvent* = ptr TXkbBellNotifyEvent
  TXkbBellNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbBellNotify
    device*: Int16            # device ID
    percent*: Int16           # requested volume as a % of maximum
    pitch*: Int16             # requested pitch in Hz
    duration*: Int16          # requested duration in useconds
    bell_class*: Int16        # (input extension) feedback class
    bell_id*: Int16           # (input extension) ID of feedback
    name*: TAtom              # "name" of requested bell
    window*: TWindow          # window associated with event
    event_only*: Bool         # "event only" requested
  

type 
  PXkbActionMessageEvent* = ptr TXkbActionMessageEvent
  TXkbActionMessageEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbActionMessage
    device*: Int16            # device ID
    keycode*: TKeyCode        # key that generated the event
    press*: Bool              # true if act caused by key press
    key_event_follows*: Bool  # true if key event also generated
    group*: Int16             # effective group
    mods*: Int16              # effective mods
    message*: Array[0..XkbActionMessageLength, Char] # message -- leave space for NUL
  

type 
  PXkbAccessXNotifyEvent* = ptr TXkbAccessXNotifyEvent
  TXkbAccessXNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbAccessXNotify
    device*: Int16            # device ID
    detail*: Int16            # XkbAXN_*
    keycode*: Int16           # key of event
    sk_delay*: Int16          # current slow keys delay
    debounce_delay*: Int16    # current debounce delay
  

type 
  PXkbExtensionDeviceNotifyEvent* = ptr TXkbExtensionDeviceNotifyEvent
  TXkbExtensionDeviceNotifyEvent*{.final.} = object 
    theType*: Int16           # XkbAnyEvent
    serial*: Int32            # of last req processed by server
    send_event*: Bool         # is this `from` a SendEvent request?
    display*: PDisplay        # Display the event was read `from`
    time*: TTime              # milliseconds
    xkb_type*: Int16          # XkbExtensionDeviceNotify
    device*: Int16            # device ID
    reason*: Int16            # reason for the event
    supported*: Int16         # mask of supported features
    unsupported*: Int16       # mask of unsupported features
                              # that some app tried to use
    first_btn*: Int16         # first button that changed
    num_btns*: Int16          # range of buttons changed
    leds_defined*: Int16      # indicators with names or maps
    led_state*: Int16         # current state of the indicators
    led_class*: Int16         # feedback class for led changes
    led_id*: Int16            # feedback id for led changes
  

type 
  PXkbEvent* = ptr TXkbEvent
  TXkbEvent*{.final.} = object 
    theType*: Int16
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
  XkbODSuccess* = 0
  XkbODBadLibraryVersion* = 1
  XkbODConnectionRefused* = 2
  XkbODNonXkbServer* = 3
  XkbODBadServerVersion* = 4 # Values for XlibFlags 

const 
  XkbLCForceLatin1Lookup* = 1 shl 0
  XkbLCConsumeLookupMods* = 1 shl 1
  XkbLCAlwaysConsumeShiftAndLock* = 1 shl 2
  XkbLCIgnoreNewKeyboards* = 1 shl 3
  XkbLCControlFallback* = 1 shl 4
  XkbLCConsumeKeysOnComposeFail* = 1 shl 29
  XkbLCComposeLED* = 1 shl 30
  XkbLCBeepOnComposeFail* = 1 shl 31
  XkbLCAllComposeControls* = 0xC0000000
  XkbLCAllControls* = 0xC000001F

proc xkbIgnoreExtension*(ignore: Bool): Bool{.libx11c, 
    importc: "XkbIgnoreExtension".}
proc xkbOpenDisplay*(name: Cstring, ev_rtrn, err_rtrn, major_rtrn, minor_rtrn, 
                                    reason: ptr Int16): PDisplay{.libx11c, importc: "XkbOpenDisplay".}
proc xkbQueryExtension*(dpy: PDisplay, opcodeReturn, eventBaseReturn, 
                                       errorBaseReturn, majorRtrn, minorRtrn: ptr Int16): Bool{.
    libx11c, importc: "XkbQueryExtension".}
proc xkbUseExtension*(dpy: PDisplay, major_rtrn, minor_rtrn: ptr Int16): Bool{.
    libx11c, importc: "XkbUseExtension".}
proc xkbLibraryVersion*(libMajorRtrn, libMinorRtrn: ptr Int16): Bool{.libx11c, importc: "XkbLibraryVersion".}
proc xkbSetXlibControls*(dpy: PDisplay, affect, values: Int16): Int16{.libx11c, importc: "XkbSetXlibControls".}
proc xkbGetXlibControls*(dpy: PDisplay): Int16{.libx11c, 
    importc: "XkbGetXlibControls".}
type 
  TXkbInternAtomFunc* = proc (dpy: PDisplay, name: Cstring, only_if_exists: Bool): TAtom{.
      cdecl.}

type 
  TXkbGetAtomNameFunc* = proc (dpy: PDisplay, atom: TAtom): Cstring{.cdecl.}

proc xkbSetAtomFuncs*(getAtom: TXkbInternAtomFunc, getName: TXkbGetAtomNameFunc){.
    libx11c, importc: "XkbSetAtomFuncs".}
proc xkbKeycodeToKeysym*(dpy: PDisplay, kc: TKeyCode, group, level: Int16): TKeySym{.
    libx11c, importc: "XkbKeycodeToKeysym".}
proc xkbKeysymToModifiers*(dpy: PDisplay, ks: TKeySym): Int16{.libx11c, importc: "XkbKeysymToModifiers".}
proc xkbLookupKeySym*(dpy: PDisplay, keycode: TKeyCode, 
                      modifiers, modifiers_return: Int16, keysym_return: PKeySym): Bool{.
    libx11c, importc: "XkbLookupKeySym".}
proc xkbLookupKeyBinding*(dpy: PDisplay, sym_rtrn: TKeySym, mods: Int16, 
                          buffer: Cstring, nbytes: Int16, extra_rtrn: ptr Int16): Int16{.
    libx11c, importc: "XkbLookupKeyBinding".}
proc xkbTranslateKeyCode*(xkb: PXkbDescPtr, keycode: TKeyCode, 
                          modifiers, modifiers_return: Int16, 
                          keysym_return: PKeySym): Bool{.libx11c, 
    importc: "XkbTranslateKeyCode".}
proc xkbTranslateKeySym*(dpy: PDisplay, sym_return: TKeySym, modifiers: Int16, 
                         buffer: Cstring, nbytes: Int16, extra_rtrn: ptr Int16): Int16{.
    libx11c, importc: "XkbTranslateKeySym".}
proc xkbSetAutoRepeatRate*(dpy: PDisplay, deviceSpec, delay, interval: Int16): Bool{.
    libx11c, importc: "XkbSetAutoRepeatRate".}
proc xkbGetAutoRepeatRate*(dpy: PDisplay, deviceSpec: Int16, 
                           delayRtrn, intervalRtrn: PWord): Bool{.libx11c, importc: "XkbGetAutoRepeatRate".}
proc xkbChangeEnabledControls*(dpy: PDisplay, deviceSpec, affect, values: Int16): Bool{.
    libx11c, importc: "XkbChangeEnabledControls".}
proc xkbDeviceBell*(dpy: PDisplay, win: TWindow, 
                    deviceSpec, bellClass, bellID, percent: Int16, name: TAtom): Bool{.
    libx11c, importc: "XkbDeviceBell".}
proc xkbForceDeviceBell*(dpy: PDisplay, 
                         deviceSpec, bellClass, bellID, percent: Int16): Bool{.
    libx11c, importc: "XkbForceDeviceBell".}
proc xkbDeviceBellEvent*(dpy: PDisplay, win: TWindow, 
                         deviceSpec, bellClass, bellID, percent: Int16, 
                         name: TAtom): Bool{.libx11c, 
    importc: "XkbDeviceBellEvent".}
proc xkbBell*(dpy: PDisplay, win: TWindow, percent: Int16, name: TAtom): Bool{.
    libx11c, importc: "XkbBell".}
proc xkbForceBell*(dpy: PDisplay, percent: Int16): Bool{.libx11c, 
    importc: "XkbForceBell".}
proc xkbBellEvent*(dpy: PDisplay, win: TWindow, percent: Int16, name: TAtom): Bool{.
    libx11c, importc: "XkbBellEvent".}
proc xkbSelectEvents*(dpy: PDisplay, deviceID, affect, values: Int16): Bool{.
    libx11c, importc: "XkbSelectEvents".}
proc xkbSelectEventDetails*(dpy: PDisplay, deviceID, eventType: Int16, 
                            affect, details: Int32): Bool{.libx11c, importc: "XkbSelectEventDetails".}
proc xkbNoteMapChanges*(old: PXkbMapChangesPtr, new: PXkbMapNotifyEvent, 
                        wanted: Int16){.libx11c, 
                                        importc: "XkbNoteMapChanges".}
proc xkbNoteNameChanges*(old: PXkbNameChangesPtr, new: PXkbNamesNotifyEvent, 
                         wanted: Int16){.libx11c, 
    importc: "XkbNoteNameChanges".}
proc xkbGetIndicatorState*(dpy: PDisplay, deviceSpec: Int16, pStateRtrn: PWord): TStatus{.
    libx11c, importc: "XkbGetIndicatorState".}
proc xkbGetDeviceIndicatorState*(dpy: PDisplay, 
                                 deviceSpec, ledClass, ledID: Int16, 
                                 pStateRtrn: PWord): TStatus{.libx11c, importc: "XkbGetDeviceIndicatorState".}
proc xkbGetIndicatorMap*(dpy: PDisplay, which: Int32, desc: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetIndicatorMap".}
proc xkbSetIndicatorMap*(dpy: PDisplay, which: Int32, desc: PXkbDescPtr): Bool{.
    libx11c, importc: "XkbSetIndicatorMap".}
proc xkbNoteIndicatorMapChanges*(o, n: PXkbIndicatorChangesPtr, w: Int16)
proc xkbNoteIndicatorStateChanges*(o, n: PXkbIndicatorChangesPtr, w: Int16)
proc xkbGetIndicatorMapChanges*(d: PDisplay, x: PXkbDescPtr, 
                                c: PXkbIndicatorChangesPtr): TStatus
proc xkbChangeIndicatorMaps*(d: PDisplay, x: PXkbDescPtr, 
                             c: PXkbIndicatorChangesPtr): Bool
proc xkbGetNamedIndicator*(dpy: PDisplay, name: TAtom, pNdxRtrn: ptr Int16, 
                           pStateRtrn: ptr Bool, pMapRtrn: PXkbIndicatorMapPtr, 
                           pRealRtrn: ptr Bool): Bool{.libx11c, 
    importc: "XkbGetNamedIndicator".}
proc xkbGetNamedDeviceIndicator*(dpy: PDisplay, 
                                 deviceSpec, ledClass, ledID: Int16, 
                                 name: TAtom, pNdxRtrn: ptr Int16, 
                                 pStateRtrn: ptr Bool, 
                                 pMapRtrn: PXkbIndicatorMapPtr, 
                                 pRealRtrn: ptr Bool): Bool{.libx11c, importc: "XkbGetNamedDeviceIndicator".}
proc xkbSetNamedIndicator*(dpy: PDisplay, name: TAtom, 
                           changeState, state, createNewMap: Bool, 
                           pMap: PXkbIndicatorMapPtr): Bool{.libx11c, importc: "XkbSetNamedIndicator".}
proc xkbSetNamedDeviceIndicator*(dpy: PDisplay, 
                                 deviceSpec, ledClass, ledID: Int16, 
                                 name: TAtom, 
                                 changeState, state, createNewMap: Bool, 
                                 pMap: PXkbIndicatorMapPtr): Bool{.libx11c, importc: "XkbSetNamedDeviceIndicator".}
proc xkbLockModifiers*(dpy: PDisplay, deviceSpec, affect, values: Int16): Bool{.
    libx11c, importc: "XkbLockModifiers".}
proc xkbLatchModifiers*(dpy: PDisplay, deviceSpec, affect, values: Int16): Bool{.
    libx11c, importc: "XkbLatchModifiers".}
proc xkbLockGroup*(dpy: PDisplay, deviceSpec, group: Int16): Bool{.libx11c, importc: "XkbLockGroup".}
proc xkbLatchGroup*(dpy: PDisplay, deviceSpec, group: Int16): Bool{.libx11c, importc: "XkbLatchGroup".}
proc xkbSetServerInternalMods*(dpy: PDisplay, deviceSpec, affectReal, 
    realValues, affectVirtual, virtualValues: Int16): Bool{.libx11c, importc: "XkbSetServerInternalMods".}
proc xkbSetIgnoreLockMods*(dpy: PDisplay, deviceSpec, affectReal, realValues, 
    affectVirtual, virtualValues: Int16): Bool{.libx11c, 
    importc: "XkbSetIgnoreLockMods".}
proc xkbVirtualModsToReal*(dpy: PDisplay, virtual_mask: Int16, mask_rtrn: PWord): Bool{.
    libx11c, importc: "XkbVirtualModsToReal".}
proc xkbComputeEffectiveMap*(xkb: PXkbDescPtr, theType: PXkbKeyTypePtr, 
                             map_rtrn: PByte): Bool{.libx11c, 
    importc: "XkbComputeEffectiveMap".}
proc xkbInitCanonicalKeyTypes*(xkb: PXkbDescPtr, which: Int16, keypadVMod: Int16): TStatus{.
    libx11c, importc: "XkbInitCanonicalKeyTypes".}
proc xkbAllocKeyboard*(): PXkbDescPtr{.libx11c, 
                                       importc: "XkbAllocKeyboard".}
proc xkbFreeKeyboard*(xkb: PXkbDescPtr, which: Int16, freeDesc: Bool){.libx11c, importc: "XkbFreeKeyboard".}
proc xkbAllocClientMap*(xkb: PXkbDescPtr, which, nTypes: Int16): TStatus{.libx11c, importc: "XkbAllocClientMap".}
proc xkbAllocServerMap*(xkb: PXkbDescPtr, which, nActions: Int16): TStatus{.
    libx11c, importc: "XkbAllocServerMap".}
proc xkbFreeClientMap*(xkb: PXkbDescPtr, what: Int16, freeMap: Bool){.libx11c, importc: "XkbFreeClientMap".}
proc xkbFreeServerMap*(xkb: PXkbDescPtr, what: Int16, freeMap: Bool){.libx11c, importc: "XkbFreeServerMap".}
proc xkbAddKeyType*(xkb: PXkbDescPtr, name: TAtom, map_count: Int16, 
                    want_preserve: Bool, num_lvls: Int16): PXkbKeyTypePtr{.
    libx11c, importc: "XkbAddKeyType".}
proc xkbAllocIndicatorMaps*(xkb: PXkbDescPtr): TStatus{.libx11c, 
    importc: "XkbAllocIndicatorMaps".}
proc xkbFreeIndicatorMaps*(xkb: PXkbDescPtr){.libx11c, 
    importc: "XkbFreeIndicatorMaps".}
proc xkbGetMap*(dpy: PDisplay, which, deviceSpec: Int16): PXkbDescPtr{.libx11c, importc: "XkbGetMap".}
proc xkbGetUpdatedMap*(dpy: PDisplay, which: Int16, desc: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetUpdatedMap".}
proc xkbGetMapChanges*(dpy: PDisplay, xkb: PXkbDescPtr, 
                       changes: PXkbMapChangesPtr): TStatus{.libx11c, importc: "XkbGetMapChanges".}
proc xkbRefreshKeyboardMapping*(event: PXkbMapNotifyEvent): TStatus{.libx11c, importc: "XkbRefreshKeyboardMapping".}
proc xkbGetKeyTypes*(dpy: PDisplay, first, num: Int16, xkb: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetKeyTypes".}
proc xkbGetKeySyms*(dpy: PDisplay, first, num: Int16, xkb: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetKeySyms".}
proc xkbGetKeyActions*(dpy: PDisplay, first, num: Int16, xkb: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetKeyActions".}
proc xkbGetKeyBehaviors*(dpy: PDisplay, firstKey, nKeys: Int16, 
                         desc: PXkbDescPtr): TStatus{.libx11c, 
    importc: "XkbGetKeyBehaviors".}
proc xkbGetVirtualMods*(dpy: PDisplay, which: Int16, desc: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetVirtualMods".}
proc xkbGetKeyExplicitComponents*(dpy: PDisplay, firstKey, nKeys: Int16, 
                                  desc: PXkbDescPtr): TStatus{.libx11c, importc: "XkbGetKeyExplicitComponents".}
proc xkbGetKeyModifierMap*(dpy: PDisplay, firstKey, nKeys: Int16, 
                           desc: PXkbDescPtr): TStatus{.libx11c, 
    importc: "XkbGetKeyModifierMap".}
proc xkbAllocControls*(xkb: PXkbDescPtr, which: Int16): TStatus{.libx11c, importc: "XkbAllocControls".}
proc xkbFreeControls*(xkb: PXkbDescPtr, which: Int16, freeMap: Bool){.libx11c, importc: "XkbFreeControls".}
proc xkbGetControls*(dpy: PDisplay, which: Int32, desc: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetControls".}
proc xkbSetControls*(dpy: PDisplay, which: Int32, desc: PXkbDescPtr): Bool{.
    libx11c, importc: "XkbSetControls".}
proc xkbNoteControlsChanges*(old: PXkbControlsChangesPtr, 
                             new: PXkbControlsNotifyEvent, wanted: Int16){.
    libx11c, importc: "XkbNoteControlsChanges".}
proc xkbGetControlsChanges*(d: PDisplay, x: PXkbDescPtr, 
                            c: PXkbControlsChangesPtr): TStatus
proc xkbChangeControls*(d: PDisplay, x: PXkbDescPtr, c: PXkbControlsChangesPtr): Bool
proc xkbAllocCompatMap*(xkb: PXkbDescPtr, which, nInterpret: Int16): TStatus{.
    libx11c, importc: "XkbAllocCompatMap".}
proc xkbFreeCompatMap*(xkib: PXkbDescPtr, which: Int16, freeMap: Bool){.libx11c, importc: "XkbFreeCompatMap".}
proc xkbGetCompatMap*(dpy: PDisplay, which: Int16, xkb: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetCompatMap".}
proc xkbSetCompatMap*(dpy: PDisplay, which: Int16, xkb: PXkbDescPtr, 
                      updateActions: Bool): Bool{.libx11c, 
    importc: "XkbSetCompatMap".}
proc xkbAddSymInterpret*(xkb: PXkbDescPtr, si: PXkbSymInterpretPtr, 
                         updateMap: Bool, changes: PXkbChangesPtr): PXkbSymInterpretPtr{.
    libx11c, importc: "XkbAddSymInterpret".}
proc xkbAllocNames*(xkb: PXkbDescPtr, which: Int16, 
                    nTotalRG, nTotalAliases: Int16): TStatus{.libx11c, importc: "XkbAllocNames".}
proc xkbGetNames*(dpy: PDisplay, which: Int16, desc: PXkbDescPtr): TStatus{.
    libx11c, importc: "XkbGetNames".}
proc xkbSetNames*(dpy: PDisplay, which, firstType, nTypes: Int16, 
                  desc: PXkbDescPtr): Bool{.libx11c, 
    importc: "XkbSetNames".}
proc xkbChangeNames*(dpy: PDisplay, xkb: PXkbDescPtr, 
                     changes: PXkbNameChangesPtr): Bool{.libx11c, 
    importc: "XkbChangeNames".}
proc xkbFreeNames*(xkb: PXkbDescPtr, which: Int16, freeMap: Bool){.libx11c, importc: "XkbFreeNames".}
proc xkbGetState*(dpy: PDisplay, deviceSpec: Int16, rtrnState: PXkbStatePtr): TStatus{.
    libx11c, importc: "XkbGetState".}
proc xkbSetMap*(dpy: PDisplay, which: Int16, desc: PXkbDescPtr): Bool{.libx11c, importc: "XkbSetMap".}
proc xkbChangeMap*(dpy: PDisplay, desc: PXkbDescPtr, changes: PXkbMapChangesPtr): Bool{.
    libx11c, importc: "XkbChangeMap".}
proc xkbSetDetectableAutoRepeat*(dpy: PDisplay, detectable: Bool, 
                                 supported: ptr Bool): Bool{.libx11c, importc: "XkbSetDetectableAutoRepeat".}
proc xkbGetDetectableAutoRepeat*(dpy: PDisplay, supported: ptr Bool): Bool{.
    libx11c, importc: "XkbGetDetectableAutoRepeat".}
proc xkbSetAutoResetControls*(dpy: PDisplay, changes: Int16, 
                              auto_ctrls, auto_values: PWord): Bool{.libx11c, importc: "XkbSetAutoResetControls".}
proc xkbGetAutoResetControls*(dpy: PDisplay, auto_ctrls, auto_ctrl_values: PWord): Bool{.
    libx11c, importc: "XkbGetAutoResetControls".}
proc xkbSetPerClientControls*(dpy: PDisplay, change: Int16, values: PWord): Bool{.
    libx11c, importc: "XkbSetPerClientControls".}
proc xkbGetPerClientControls*(dpy: PDisplay, ctrls: PWord): Bool{.libx11c, importc: "XkbGetPerClientControls".}
proc xkbCopyKeyType*(`from`, into: PXkbKeyTypePtr): TStatus{.libx11c, importc: "XkbCopyKeyType".}
proc xkbCopyKeyTypes*(`from`, into: PXkbKeyTypePtr, num_types: Int16): TStatus{.
    libx11c, importc: "XkbCopyKeyTypes".}
proc xkbResizeKeyType*(xkb: PXkbDescPtr, type_ndx, map_count: Int16, 
                       want_preserve: Bool, new_num_lvls: Int16): TStatus{.
    libx11c, importc: "XkbResizeKeyType".}
proc xkbResizeKeySyms*(desc: PXkbDescPtr, forKey, symsNeeded: Int16): PKeySym{.
    libx11c, importc: "XkbResizeKeySyms".}
proc xkbResizeKeyActions*(desc: PXkbDescPtr, forKey, actsNeeded: Int16): PXkbAction{.
    libx11c, importc: "XkbResizeKeyActions".}
proc xkbChangeTypesOfKey*(xkb: PXkbDescPtr, key, num_groups: Int16, 
                          groups: Int16, newTypes: ptr Int16, 
                          pChanges: PXkbMapChangesPtr): TStatus{.libx11c, importc: "XkbChangeTypesOfKey".}
    
proc xkbListComponents*(dpy: PDisplay, deviceSpec: Int16, 
                        ptrns: PXkbComponentNamesPtr, max_inout: ptr Int16): PXkbComponentListPtr{.
    libx11c, importc: "XkbListComponents".}
proc xkbFreeComponentList*(list: PXkbComponentListPtr){.libx11c, 
    importc: "XkbFreeComponentList".}
proc xkbGetKeyboard*(dpy: PDisplay, which, deviceSpec: Int16): PXkbDescPtr{.
    libx11c, importc: "XkbGetKeyboard".}
proc xkbGetKeyboardByName*(dpy: PDisplay, deviceSpec: Int16, 
                           names: PXkbComponentNamesPtr, want, need: Int16, 
                           load: Bool): PXkbDescPtr{.libx11c, 
    importc: "XkbGetKeyboardByName".}
    
proc xkbKeyTypesForCoreSymbols*(xkb: PXkbDescPtr, 
                                map_width: Int16,  # keyboard device
                                core_syms: PKeySym,  # always mapWidth symbols
                                protected: Int16,  # explicit key types
                                types_inout: ptr Int16,  # always four type indices
                                xkb_syms_rtrn: PKeySym): Int16{.libx11c, importc: "XkbKeyTypesForCoreSymbols".}
  # must have enough space
proc xkbApplyCompatMapToKey*(xkb: PXkbDescPtr,  
                             key: TKeyCode,  # key to be updated
                             changes: PXkbChangesPtr): Bool{.libx11c, importc: "XkbApplyCompatMapToKey".}
  # resulting changes to map
proc xkbUpdateMapFromCore*(xkb: PXkbDescPtr,  
                           first_key: TKeyCode,  # first changed key
                           num_keys,
                           map_width: Int16, 
                           core_keysyms: PKeySym,  # symbols `from` core keymap
                           changes: PXkbChangesPtr): Bool{.libx11c, importc: "XkbUpdateMapFromCore".}

proc xkbAddDeviceLedInfo*(devi: PXkbDeviceInfoPtr, ledClass, ledId: Int16): PXkbDeviceLedInfoPtr{.
    libx11c, importc: "XkbAddDeviceLedInfo".}
proc xkbResizeDeviceButtonActions*(devi: PXkbDeviceInfoPtr, newTotal: Int16): TStatus{.
    libx11c, importc: "XkbResizeDeviceButtonActions".}
proc xkbAllocDeviceInfo*(deviceSpec, nButtons, szLeds: Int16): PXkbDeviceInfoPtr{.
    libx11c, importc: "XkbAllocDeviceInfo".}
proc xkbFreeDeviceInfo*(devi: PXkbDeviceInfoPtr, which: Int16, freeDevI: Bool){.
    libx11c, importc: "XkbFreeDeviceInfo".}
proc xkbNoteDeviceChanges*(old: PXkbDeviceChangesPtr, 
                           new: PXkbExtensionDeviceNotifyEvent, wanted: Int16){.
    libx11c, importc: "XkbNoteDeviceChanges".}
proc xkbGetDeviceInfo*(dpy: PDisplay, which, deviceSpec, ledClass, ledID: Int16): PXkbDeviceInfoPtr{.
    libx11c, importc: "XkbGetDeviceInfo".}
proc xkbGetDeviceInfoChanges*(dpy: PDisplay, devi: PXkbDeviceInfoPtr, 
                              changes: PXkbDeviceChangesPtr): TStatus{.libx11c, importc: "XkbGetDeviceInfoChanges".}
proc xkbGetDeviceButtonActions*(dpy: PDisplay, devi: PXkbDeviceInfoPtr, 
                                all: Bool, first, nBtns: Int16): TStatus{.libx11c, importc: "XkbGetDeviceButtonActions".}
proc xkbGetDeviceLedInfo*(dpy: PDisplay, devi: PXkbDeviceInfoPtr, 
                          ledClass, ledId, which: Int16): TStatus{.libx11c, importc: "XkbGetDeviceLedInfo".}
proc xkbSetDeviceInfo*(dpy: PDisplay, which: Int16, devi: PXkbDeviceInfoPtr): Bool{.
    libx11c, importc: "XkbSetDeviceInfo".}
proc xkbChangeDeviceInfo*(dpy: PDisplay, desc: PXkbDeviceInfoPtr, 
                          changes: PXkbDeviceChangesPtr): Bool{.libx11c, importc: "XkbChangeDeviceInfo".}
proc xkbSetDeviceLedInfo*(dpy: PDisplay, devi: PXkbDeviceInfoPtr, 
                          ledClass, ledID, which: Int16): Bool{.libx11c, importc: "XkbSetDeviceLedInfo".}
proc xkbSetDeviceButtonActions*(dpy: PDisplay, devi: PXkbDeviceInfoPtr, 
                                first, nBtns: Int16): Bool{.libx11c, importc: "XkbSetDeviceButtonActions".}

proc xkbToControl*(c: Int8): Int8{.libx11c, 
                                   importc: "XkbToControl".}

proc xkbSetDebuggingFlags*(dpy: PDisplay, mask, flags: Int16, msg: Cstring, 
                           ctrls_mask, ctrls, rtrn_flags, rtrn_ctrls: Int16): Bool{.
    libx11c, importc: "XkbSetDebuggingFlags".}
proc xkbApplyVirtualModChanges*(xkb: PXkbDescPtr, changed: Int16, 
                                changes: PXkbChangesPtr): Bool{.libx11c, importc: "XkbApplyVirtualModChanges".}

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
  Result = xkbGetIndicatorMap(d, c.map_changes, x)

proc xkbChangeIndicatorMaps(d: PDisplay, x: PXkbDescPtr, 
                            c: PXkbIndicatorChangesPtr): bool = 
  ##define XkbChangeIndicatorMaps(d,x,c) (XkbSetIndicatorMap((d),(c)->map_changes,x))
  Result = xkbSetIndicatorMap(d, c.map_changes, x)

proc xkbGetControlsChanges(d: PDisplay, x: PXkbDescPtr, 
                           c: PXkbControlsChangesPtr): TStatus = 
  ##define XkbGetControlsChanges(d,x,c) XkbGetControls(d,(c)->changed_ctrls,x)
  Result = xkbGetControls(d, c.changed_ctrls, x)

proc xkbChangeControls(d: PDisplay, x: PXkbDescPtr, c: PXkbControlsChangesPtr): bool = 
  ##define XkbChangeControls(d,x,c) XkbSetControls(d,(c)->changed_ctrls,x)
  Result = xkbSetControls(d, c.changed_ctrls, x)
