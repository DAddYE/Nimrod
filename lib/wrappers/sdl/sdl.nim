#******************************************************************************
#
#          JEDI-SDL : Pascal units for SDL - Simple DirectMedia Layer
#             Conversion of the Simple DirectMedia Layer Headers
#
# Portions created by Sam Lantinga <slouken@devolution.com> are
# Copyright (C) 1997-2004  Sam Lantinga
# 5635-34 Springhouse Dr.
# Pleasanton, CA 94588 (USA)
#
# All Rights Reserved.
#
# The original files are : SDL.h
#                          SDL_main.h
#                          SDL_types.h
#                          SDL_rwops.h
#                          SDL_timer.h
#                          SDL_audio.h
#                          SDL_cdrom.h
#                          SDL_joystick.h
#                          SDL_mouse.h
#                          SDL_keyboard.h
#                          SDL_events.h
#                          SDL_video.h
#                          SDL_byteorder.h
#                          SDL_version.h
#                          SDL_active.h
#                          SDL_thread.h
#                          SDL_mutex .h
#                          SDL_getenv.h
#                          SDL_loadso.h
#
# The initial developer of this Pascal code was :
# Dominique Louis <Dominique@SavageSoftware.com.au>
#
# Portions created by Dominique Louis are
# Copyright (C) 2000 - 2004 Dominique Louis.
#
#
# Contributor(s)
# --------------
# Tom Jones <tigertomjones@gmx.de>  His Project inspired this conversion
# Matthias Thoma <ma.thoma@gmx.de>
#
# Obtained through:
# Joint Endeavour of Delphi Innovators ( Project JEDI )
#
# You may retrieve the latest version of this file at the Project
# JEDI home page, located at http://delphi-jedi.org
#
# The contents of this file are used with permission, subject to
# the Mozilla Public License Version 1.1 (the "License"); you may
# not use this file except in compliance with the License. You may
# obtain a copy of the License at
# http://www.mozilla.org/MPL/MPL-1.1.html
#
# Software distributed under the License is distributed on an
# "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# Description
# -----------
#
#
#
#
#
#
#
# Requires
# --------
#   The SDL Runtime libraris on Win32  : SDL.dll on Linux : libSDL.so
#   They are available from...
#   http://www.libsdl.org .
#
# Programming Notes
# -----------------
#
#
#
#
# Revision History
# ----------------
#   May      08 2001 - DL : Added Keyboard  State Array ( See demos for how to
#                           use )
#                           PKeyStateArr = ^TKeyStateArr;
#                           TKeyStateArr = array[0..65000] of byte;
#                           As most games will need it.
#
#   April    02 2001 - DL : Added SDL_getenv.h definitions and tested version
#                           1.2.0 compatability.
#
#   March    13 2001 - MT : Added Linux compatibility.
#
#   March    10 2001 - MT : Added externalsyms for DEFINES
#                           Changed the license header
#
#   March    09 2001 - MT : Added Kylix Ifdefs/Deleted the uses mmsystem
#
#   March    01 2001 - DL : Update conversion of version 1.1.8
#
#   July     22 2001 - DL : Added TUInt8Array and PUIntArray after suggestions
#                           from Matthias Thoma and Eric Grange.
#
#   October  12 2001 - DL : Various changes as suggested by Matthias Thoma and
#                           David Acklam
#
#   October  24 2001 - DL : Added FreePascal support as per suggestions from
#                           Dean Ellis.
#
#   October  27 2001 - DL : Added SDL_BUTTON macro
#
#  November  08 2001 - DL : Bug fix as pointed out by Puthoon.
#
#  November  29 2001 - DL : Bug fix of SDL_SetGammaRamp as pointed out by Simon
#                           Rushton.
#
#  November  30 2001 - DL : SDL_NOFRAME added as pointed out by Simon Rushton.
#
#  December  11 2001 - DL : Added $WEAKPACKAGEUNIT ON to facilitate useage in
#                           Components
#
#  January   05 2002 - DL : Added SDL_Swap32 function as suggested by Matthias
#                           Thoma and also made sure the _getenv from
#                           MSVCRT.DLL uses the right calling convention
#
#  January   25 2002 - DL : Updated conversion of SDL_AddTimer &
#                           SDL_RemoveTimer as per suggestions from Matthias
#                           Thoma.
#
#  January   27 2002 - DL : Commented out exported function putenv and getenv
#                           So that developers get used to using SDL_putenv
#                           SDL_getenv, as they are more portable
#
#  March     05 2002 - DL : Added FreeAnNil procedure for Delphi 4 users.
#
#  October   23 2002 - DL : Added Delphi 3 Define of Win32.
#                           If you intend to you Delphi 3...
#                           ( which is officially unsupported ) make sure you
#                           remove references to $EXTERNALSYM in this and other
#                           SDL files.
#
# November  29 2002 - DL : Fixed bug in Declaration of SDL_GetRGBA that was
#                          pointed out by Todd Lang
#
#   April   03 2003 - DL : Added jedi-sdl.inc include file to support more
#                          Pascal compilers. Initial support is now included
#                          for GnuPascal, VirtualPascal, TMT and obviously
#                          continue support for Delphi Kylix and FreePascal.
#
#   April   08 2003 - MK : Aka Mr Kroket - Added Better FPC support
#
#   April   24 2003 - DL : under instruction from Alexey Barkovoy, I have added
#                          better TMT Pascal support and under instruction
#                          from Prof. Abimbola Olowofoyeku (The African Chief),
#                          I have added better Gnu Pascal support
#
#   April   30 2003 - DL : under instruction from David Mears AKA
#                          Jason Siletto, I have added FPC Linux support.
#                          This was compiled with fpc 1.1, so remember to set
#                          include file path. ie. -Fi/usr/share/fpcsrc/rtl/*
#
#
#
#  Revision 1.31  2007/05/29 21:30:48  savage
#  Changes as suggested by Almindor for 64bit compatibility.
#
#  Revision 1.30  2007/05/29 19:31:03  savage
#  Fix to TSDL_Overlay structure - thanks David Pethes (aka imcold)
#
#  Revision 1.29  2007/05/20 20:29:11  savage
#  Initial Changes to Handle 64 Bits
#
#  Revision 1.26  2007/02/11 13:38:04  savage
#  Added Nintendo DS support - Thanks Dean.
#
#  Revision 1.25  2006/12/02 00:12:52  savage
#  Updated to latest version
#
#  Revision 1.24  2006/05/18 21:10:04  savage
#  Added 1.2.10 Changes
#
#  Revision 1.23  2005/12/04 23:17:52  drellis
#  Added declaration of SInt8 and PSInt8
#
#  Revision 1.22  2005/05/24 21:59:03  savage
#  Re-arranged uses clause to work on Win32 and Linux, Thanks again Michalis.
#
#  Revision 1.21  2005/05/22 18:42:31  savage
#  Changes as suggested by Michalis Kamburelis. Thanks again.
#
#  Revision 1.20  2005/04/10 11:48:33  savage
#  Changes as suggested by Michalis, thanks.
#
#  Revision 1.19  2005/01/05 01:47:06  savage
#  Changed LibName to reflect what MacOS X should have. ie libSDL*-1.2.0.dylib respectively.
#
#  Revision 1.18  2005/01/04 23:14:41  savage
#  Changed LibName to reflect what most Linux distros will have. ie libSDL*-1.2.so.0 respectively.
#
#  Revision 1.17  2005/01/03 18:40:59  savage
#  Updated Version number to reflect latest one
#
#  Revision 1.16  2005/01/01 02:02:06  savage
#  Updated to v1.2.8
#
#  Revision 1.15  2004/12/24 18:57:11  savage
#  forgot to apply Michalis Kamburelis' patch to the implementation section. now fixed
#
#  Revision 1.14  2004/12/23 23:42:18  savage
#  Applied Patches supplied by Michalis Kamburelis ( THANKS! ), for greater FreePascal compatability.
#
#  Revision 1.13  2004/09/30 22:31:59  savage
#  Updated with slightly different header comments
#
#  Revision 1.12  2004/09/12 21:52:58  savage
#  Slight changes to fix some issues with the sdl classes.
#
#  Revision 1.11  2004/08/14 22:54:30  savage
#  Updated so that Library name defines are correctly defined for MacOS X.
#
#  Revision 1.10  2004/07/20 23:57:33  savage
#  Thanks to Paul Toth for spotting an error in the SDL Audio Convertion structures.
#  In TSDL_AudioCVT the filters variable should point to and array of pointers and not what I had there previously.
#
#  Revision 1.9  2004/07/03 22:07:22  savage
#  Added Bitwise Manipulation Functions for TSDL_VideoInfo struct.
#
#  Revision 1.8  2004/05/10 14:10:03  savage
#  Initial MacOS X support. Fixed defines for MACOS ( Classic ) and DARWIN ( MacOS X ).
#
#  Revision 1.7  2004/04/13 09:32:08  savage
#  Changed Shared object names back to just the .so extension to avoid conflicts on various Linux/Unix distros. Therefore developers will need to create Symbolic links to the actual Share Objects if necessary.
#
#  Revision 1.6  2004/04/01 20:53:23  savage
#  Changed Linux Shared Object names so they reflect the Symbolic Links that are created when installing the RPMs from the SDL site.
#
#  Revision 1.5  2004/02/22 15:32:10  savage
#  SDL_GetEnv Fix so it also works on FPC/Linux. Thanks to Rodrigo for pointing this out.
#
#  Revision 1.4  2004/02/21 23:24:29  savage
#  SDL_GetEnv Fix so that it is not define twice for FPC. Thanks to Rene Hugentobler for pointing out this bug,
#
#  Revision 1.3  2004/02/18 22:35:51  savage
#  Brought sdl.pas up to 1.2.7 compatability
#  Thus...
#  Added SDL_GL_STEREO,
#      SDL_GL_MULTISAMPLEBUFFERS,
#      SDL_GL_MULTISAMPLESAMPLES
#
#  Add DLL/Shared object functions
#  function SDL_LoadObject( const sofile : PChar ) : Pointer;
#
#  function SDL_LoadFunction( handle : Pointer; const name : PChar ) : Pointer;
#
#  procedure SDL_UnloadObject( handle : Pointer );
#
#  Added function to create RWops from const memory: SDL_RWFromConstMem()
#  function SDL_RWFromConstMem(const mem: Pointer; size: Integer) : PSDL_RWops;
#
#  Ported SDL_cpuinfo.h so Now you can test for Specific CPU types.
#
#  Revision 1.2  2004/02/17 21:37:12  savage
#  Tidying up of units
#
#  Revision 1.1  2004/02/05 00:08:20  savage
#  Module 1.0 release
#
#

{.deadCodeElim: on.}
import unsigned
when defined(windows): 
  const 
    LibName = "SDL.dll"
elif defined(macosx): 
  const 
    LibName = "libSDL-1.2.0.dylib"
else: 
  const 
    LibName = "libSDL.so(|.1|.0)"
const 
  MajorVersion* = 1
  MinorVersion* = 2
  Patchlevel* = 11         # SDL.h constants
  InitTimer* = 0x00000001
  InitAudio* = 0x00000010
  InitVideo* = 0x00000020
  InitCdrom* = 0x00000100
  InitJoystick* = 0x00000200
  InitNoparachute* = 0x00100000 # Don't catch fatal signals
  InitEventthread* = 0x01000000 # Not supported on all OS's
  InitEverything* = 0x0000FFFF # SDL_error.h constants
  ErrMaxStrlen* = 128
  ErrMaxArgs* = 5           # SDL_types.h constants
  Pressed* = 0x00000001
  Released* = 0x00000000      # SDL_timer.h constants
                              # This is the OS scheduler timeslice, in milliseconds
  Timeslice* = 10             # This is the maximum resolution of the SDL timer on all platforms
  TimerResolution* = 10      # Experimentally determined
                              # SDL_audio.h constants
  AudioU8* = 0x00000008      # Unsigned 8-bit samples
  AudioS8* = 0x00008008      # Signed 8-bit samples
  AudioU16lsb* = 0x00000010  # Unsigned 16-bit samples
  AudioS16lsb* = 0x00008010  # Signed 16-bit samples
  AudioU16msb* = 0x00001010  # As above, but big-endian byte order
  AudioS16msb* = 0x00009010  # As above, but big-endian byte order
  AudioU16* = AUDIO_U16LSB
  AudioS16* = AUDIO_S16LSB   # SDL_cdrom.h constants
                              # The maximum number of CD-ROM tracks on a disk
  MaxTracks* = 99            # The types of CD-ROM track possible
  AudioTrack* = 0x00000000
  DataTrack* = 0x00000004    # Conversion functions from frames to Minute/Second/Frames and vice versa
  CdFps* = 75                # SDL_byteorder.h constants
                              # The two types of endianness
  LilEndian* = 1234
  BigEndian* = 4321

when cpuEndian == littleEndian: 
  const 
    Byteorder* = LIL_ENDIAN   # Native audio byte ordering
    AudioU16sys* = AUDIO_U16LSB
    AudioS16sys* = AUDIO_S16LSB
else: 
  const 
    BYTEORDER* = BIG_ENDIAN   # Native audio byte ordering
    AUDIO_U16SYS* = AUDIO_U16MSB
    AUDIO_S16SYS* = AUDIO_S16MSB
const 
  MixMaxvolume* = 128        # SDL_joystick.h constants
  MaxJoysticks* = 2          # only 2 are supported in the multimedia API
  MaxAxes* = 6               # each joystick can have up to 6 axes
  MaxButtons* = 32           # and 32 buttons
  AxisMin* = - 32768         # minimum value for axis coordinate
  AxisMax* = 32767           # maximum value for axis coordinate
  JoyAxisThreshold* = (toFloat((AXIS_MAX) - (AXIS_MIN)) / 100.000) # 1% motion
  HatCentered* = 0x00000000
  HatUp* = 0x00000001
  HatRight* = 0x00000002
  HatDown* = 0x00000004
  HatLeft* = 0x00000008
  HatRightup* = HAT_RIGHT or HAT_UP
  HatRightdown* = HAT_RIGHT or HAT_DOWN
  HatLeftup* = HAT_LEFT or HAT_UP
  HatLeftdown* = HAT_LEFT or HAT_DOWN # SDL_events.h constants

type 
  TEventKind* = enum          # kind of an SDL event
    NOEVENT = 0,              # Unused (do not remove)
    ACTIVEEVENT = 1,          # Application loses/gains visibility
    KEYDOWN = 2,              # Keys pressed
    KEYUP = 3,                # Keys released
    MOUSEMOTION = 4,          # Mouse moved
    MOUSEBUTTONDOWN = 5,      # Mouse button pressed
    MOUSEBUTTONUP = 6,        # Mouse button released
    JOYAXISMOTION = 7,        # Joystick axis motion
    JOYBALLMOTION = 8,        # Joystick trackball motion
    JOYHATMOTION = 9,         # Joystick hat position change
    JOYBUTTONDOWN = 10,       # Joystick button pressed
    JOYBUTTONUP = 11,         # Joystick button released
    QUITEV = 12,              # User-requested quit ( Changed due to procedure conflict )
    SYSWMEVENT = 13,          # System specific event
    EVENT_RESERVEDA = 14,     # Reserved for future use..
    EVENT_RESERVED = 15,      # Reserved for future use..
    VIDEORESIZE = 16,         # User resized video mode
    VIDEOEXPOSE = 17,         # Screen needs to be redrawn
    EVENT_RESERVED2 = 18,     # Reserved for future use..
    EVENT_RESERVED3 = 19,     # Reserved for future use..
    EVENT_RESERVED4 = 20,     # Reserved for future use..
    EVENT_RESERVED5 = 21,     # Reserved for future use..
    EVENT_RESERVED6 = 22,     # Reserved for future use..
    EVENT_RESERVED7 = 23,     # Reserved for future use..
                              # Events SDL_USEREVENT through SDL_MAXEVENTS-1 are for your use
    USEREVENT = 24 # This last event is only for bounding internal arrays
                   # It is the number of bits in the event mask datatype -- int32

const 
  Numevents* = 32
  Allevents* = 0xFFFFFFFF
  Activeeventmask* = 1 shl ord(ACTIVEEVENT)
  Keydownmask* = 1 shl ord(KEYDOWN)
  Keyupmask* = 1 shl ord(KEYUP)
  Mousemotionmask* = 1 shl ord(MOUSEMOTION)
  Mousebuttondownmask* = 1 shl ord(MOUSEBUTTONDOWN)
  Mousebuttonupmask* = 1 shl ord(MOUSEBUTTONUP)
  Mouseeventmask* = 1 shl ord(MOUSEMOTION) or 1 shl ord(MOUSEBUTTONDOWN) or
      1 shl ord(MOUSEBUTTONUP)
  Joyaxismotionmask* = 1 shl ord(JOYAXISMOTION)
  Joyballmotionmask* = 1 shl ord(JOYBALLMOTION)
  Joyhatmotionmask* = 1 shl ord(JOYHATMOTION)
  Joybuttondownmask* = 1 shl ord(JOYBUTTONDOWN)
  Joybuttonupmask* = 1 shl ord(JOYBUTTONUP)
  Joyeventmask* = 1 shl ord(JOYAXISMOTION) or 1 shl ord(JOYBALLMOTION) or
      1 shl ord(JOYHATMOTION) or 1 shl ord(JOYBUTTONDOWN) or
      1 shl ord(JOYBUTTONUP)
  Videoresizemask* = 1 shl ord(VIDEORESIZE)
  Quitmask* = 1 shl ord(QUITEV)
  Syswmeventmask* = 1 shl ord(SYSWMEVENT)
  Query* = - 1
  Ignore* = 0
  Disable* = 0
  Enable* = 1                 #SDL_keyboard.h constants
                              # This is the mask which refers to all hotkey bindings
  AllHotkeys* = 0xFFFFFFFF # Enable/Disable keyboard repeat.  Keyboard repeat defaults to off.
                            #  'delay' is the initial delay in ms between the time when a key is
                            #  pressed, and keyboard repeat begins.
                            #  'interval' is the time in ms between keyboard repeat events.
  DefaultRepeatDelay* = 500
  DefaultRepeatInterval* = 30 # The keyboard syms have been cleverly chosen to map to ASCII
  KUnknown* = 0
  KFirst* = 0
  KBackspace* = 8
  KTab* = 9
  KClear* = 12
  KReturn* = 13
  KPause* = 19
  KEscape* = 27
  KSpace* = 32
  KExclaim* = 33
  KQuotedbl* = 34
  KHash* = 35
  KDollar* = 36
  KAmpersand* = 38
  KQuote* = 39
  KLeftparen* = 40
  KRightparen* = 41
  KAsterisk* = 42
  KPlus* = 43
  KComma* = 44
  KMinus* = 45
  KPeriod* = 46
  KSlash* = 47
  K0* = 48
  K1* = 49
  K2* = 50
  K3* = 51
  K4* = 52
  K5* = 53
  K6* = 54
  K7* = 55
  K8* = 56
  K9* = 57
  KColon* = 58
  KSemicolon* = 59
  KLess* = 60
  KEquals* = 61
  KGreater* = 62
  KQuestion* = 63
  KAt* = 64                  # Skip uppercase letters
  KLeftbracket* = 91
  KBackslash* = 92
  KRightbracket* = 93
  KCaret* = 94
  KUnderscore* = 95
  KBackquote* = 96
  KA* = 97
  KB* = 98
  KC* = 99
  KD* = 100
  KE* = 101
  KF* = 102
  KG* = 103
  KH* = 104
  KI* = 105
  KJ* = 106
  KK* = 107
  KL* = 108
  KM* = 109
  KN* = 110
  KO* = 111
  KP* = 112
  KQ* = 113
  KR* = 114
  KS* = 115
  KT* = 116
  KU* = 117
  KV* = 118
  KW* = 119
  KX* = 120
  KY* = 121
  KZ* = 122
  KDelete* = 127             # End of ASCII mapped keysyms
                              # International keyboard syms
  KWorld0* = 160            # 0xA0
  KWorld1* = 161
  KWorld2* = 162
  KWorld3* = 163
  KWorld4* = 164
  KWorld5* = 165
  KWorld6* = 166
  KWorld7* = 167
  KWorld8* = 168
  KWorld9* = 169
  KWorld10* = 170
  KWorld11* = 171
  KWorld12* = 172
  KWorld13* = 173
  KWorld14* = 174
  KWorld15* = 175
  KWorld16* = 176
  KWorld17* = 177
  KWorld18* = 178
  KWorld19* = 179
  KWorld20* = 180
  KWorld21* = 181
  KWorld22* = 182
  KWorld23* = 183
  KWorld24* = 184
  KWorld25* = 185
  KWorld26* = 186
  KWorld27* = 187
  KWorld28* = 188
  KWorld29* = 189
  KWorld30* = 190
  KWorld31* = 191
  KWorld32* = 192
  KWorld33* = 193
  KWorld34* = 194
  KWorld35* = 195
  KWorld36* = 196
  KWorld37* = 197
  KWorld38* = 198
  KWorld39* = 199
  KWorld40* = 200
  KWorld41* = 201
  KWorld42* = 202
  KWorld43* = 203
  KWorld44* = 204
  KWorld45* = 205
  KWorld46* = 206
  KWorld47* = 207
  KWorld48* = 208
  KWorld49* = 209
  KWorld50* = 210
  KWorld51* = 211
  KWorld52* = 212
  KWorld53* = 213
  KWorld54* = 214
  KWorld55* = 215
  KWorld56* = 216
  KWorld57* = 217
  KWorld58* = 218
  KWorld59* = 219
  KWorld60* = 220
  KWorld61* = 221
  KWorld62* = 222
  KWorld63* = 223
  KWorld64* = 224
  KWorld65* = 225
  KWorld66* = 226
  KWorld67* = 227
  KWorld68* = 228
  KWorld69* = 229
  KWorld70* = 230
  KWorld71* = 231
  KWorld72* = 232
  KWorld73* = 233
  KWorld74* = 234
  KWorld75* = 235
  KWorld76* = 236
  KWorld77* = 237
  KWorld78* = 238
  KWorld79* = 239
  KWorld80* = 240
  KWorld81* = 241
  KWorld82* = 242
  KWorld83* = 243
  KWorld84* = 244
  KWorld85* = 245
  KWorld86* = 246
  KWorld87* = 247
  KWorld88* = 248
  KWorld89* = 249
  KWorld90* = 250
  KWorld91* = 251
  KWorld92* = 252
  KWorld93* = 253
  KWorld94* = 254
  KWorld95* = 255           # 0xFF
                              # Numeric keypad
  KKp0* = 256
  KKp1* = 257
  KKp2* = 258
  KKp3* = 259
  KKp4* = 260
  KKp5* = 261
  KKp6* = 262
  KKp7* = 263
  KKp8* = 264
  KKp9* = 265
  KKpPeriod* = 266
  KKpDivide* = 267
  KKpMultiply* = 268
  KKpMinus* = 269
  KKpPlus* = 270
  KKpEnter* = 271
  KKpEquals* = 272          # Arrows + Home/End pad
  KUp* = 273
  KDown* = 274
  KRight* = 275
  KLeft* = 276
  KInsert* = 277
  KHome* = 278
  KEnd* = 279
  KPageup* = 280
  KPagedown* = 281           # Function keys
  KF1* = 282
  KF2* = 283
  KF3* = 284
  KF4* = 285
  KF5* = 286
  KF6* = 287
  KF7* = 288
  KF8* = 289
  KF9* = 290
  KF10* = 291
  KF11* = 292
  KF12* = 293
  KF13* = 294
  KF14* = 295
  KF15* = 296                # Key state modifier keys
  KNumlock* = 300
  KCapslock* = 301
  KScrollock* = 302
  KRshift* = 303
  KLshift* = 304
  KRctrl* = 305
  KLctrl* = 306
  KRalt* = 307
  KLalt* = 308
  KRmeta* = 309
  KLmeta* = 310
  KLsuper* = 311             # Left "Windows" key
  KRsuper* = 312             # Right "Windows" key
  KMode* = 313               # "Alt Gr" key
  KCompose* = 314            # Multi-key compose key
                              # Miscellaneous function keys
  KHelp* = 315
  KPrint* = 316
  KSysreq* = 317
  KBreak* = 318
  KMenu* = 319
  KPower* = 320              # Power Macintosh power key
  KEuro* = 321               # Some european keyboards
  KGp2xUp* = 0
  KGp2xUpleft* = 1
  KGp2xLeft* = 2
  KGp2xDownleft* = 3
  KGp2xDown* = 4
  KGp2xDownright* = 5
  KGp2xRight* = 6
  KGp2xUpright* = 7
  KGp2xStart* = 8
  KGp2xSelect* = 9
  KGp2xL* = 10
  KGp2xR* = 11
  KGp2xA* = 12
  KGp2xB* = 13
  KGp2xY* = 14
  KGp2xX* = 15
  KGp2xVolup* = 16
  KGp2xVoldown* = 17
  KGp2xClick* = 18

const                         # Enumeration of valid key mods (possibly OR'd together)
  KmodNone* = 0x00000000
  KmodLshift* = 0x00000001
  KmodRshift* = 0x00000002
  KmodLctrl* = 0x00000040
  KmodRctrl* = 0x00000080
  KmodLalt* = 0x00000100
  KmodRalt* = 0x00000200
  KmodLmeta* = 0x00000400
  KmodRmeta* = 0x00000800
  KmodNum* = 0x00001000
  KmodCaps* = 0x00002000
  KmodMode* = 44000
  KmodReserved* = 0x00008000
  KmodCtrl* = (KMOD_LCTRL or KMOD_RCTRL)
  KmodShift* = (KMOD_LSHIFT or KMOD_RSHIFT)
  KmodAlt* = (KMOD_LALT or KMOD_RALT)
  KmodMeta* = (KMOD_LMETA or KMOD_RMETA) #SDL_video.h constants
                                          # Transparency definitions: These define alpha as the opacity of a surface */
  AlphaOpaque* = 255
  AlphaTransparent* = 0 # These are the currently supported flags for the SDL_surface
                         # Available for SDL_CreateRGBSurface() or SDL_SetVideoMode()
  Swsurface* = 0x00000000     # Surface is in system memory
  Hwsurface* = 0x00000001     # Surface is in video memory
  Asyncblit* = 0x00000004     # Use asynchronous blits if possible
                              # Available for SDL_SetVideoMode()
  Anyformat* = 0x10000000     # Allow any video depth/pixel-format
  Hwpalette* = 0x20000000     # Surface has exclusive palette
  Doublebuf* = 0x40000000     # Set up double-buffered video mode
  Fullscreen* = 0x80000000    # Surface is a full screen display
  Opengl* = 0x00000002        # Create an OpenGL rendering context
  Openglblit* = 0x00000002    # Create an OpenGL rendering context
  Resizable* = 0x00000010     # This video mode may be resized
  Noframe* = 0x00000020       # No window caption or edge frame
                              # Used internally (read-only)
  Hwaccel* = 0x00000100       # Blit uses hardware acceleration
  Srccolorkey* = 0x00001000   # Blit uses a source color key
  Rleaccelok* = 0x00002000    # Private flag
  Rleaccel* = 0x00004000      # Colorkey blit is RLE accelerated
  Srcalpha* = 0x00010000      # Blit uses source alpha blending
  Srcclipping* = 0x00100000   # Blit uses source clipping
  Prealloc* = 0x01000000 # Surface uses preallocated memory
                         # The most common video overlay formats.
                         #    For an explanation of these pixel formats, see:
                         #    http://www.webartz.com/fourcc/indexyuv.htm
                         #
                         #   For information on the relationship between color spaces, see:
                         #
                         #   
                         #   http://www.neuro.sfc.keio.ac.jp/~aly/polygon/info/color-space-faq.html
  Yv12Overlay* = 0x32315659  # Planar mode: Y + V + U  (3 planes)
  IyuvOverlay* = 0x56555949  # Planar mode: Y + U + V  (3 planes)
  Yuy2Overlay* = 0x32595559  # Packed mode: Y0+U0+Y1+V0 (1 plane)
  UyvyOverlay* = 0x59565955  # Packed mode: U0+Y0+V0+Y1 (1 plane)
  YvyuOverlay* = 0x55595659  # Packed mode: Y0+V0+Y1+U0 (1 plane)
                              # flags for SDL_SetPalette()
  Logpal* = 0x00000001
  Physpal* = 0x00000002 #SDL_mouse.h constants
                        # Used as a mask when testing buttons in buttonstate
                        #    Button 1:	Left mouse button
                        #    Button 2:	Middle mouse button
                        #    Button 3:	Right mouse button
                        #    Button 4:	Mouse Wheel Up
                        #    Button 5:	Mouse Wheel Down
                        #
  ButtonLeft* = 1
  ButtonMiddle* = 2
  ButtonRight* = 3
  ButtonWheelup* = 4
  ButtonWheeldown* = 5
  ButtonLmask* = PRESSED shl (BUTTON_LEFT - 1)
  ButtonMmask* = PRESSED shl (BUTTON_MIDDLE - 1)
  BUTTONRMask* = PRESSED shl (BUTTON_RIGHT - 1) # SDL_active.h constants
                                                 # The available application states
  Appmousefocus* = 0x00000001 # The app has mouse coverage
  Appinputfocus* = 0x00000002 # The app has input focus
  Appactive* = 0x00000004 # The application is active
                          # SDL_mutex.h constants
                          # Synchronization functions which can time out return this value
                          #  they time out.
  MutexTimedout* = 1         # This is the timeout value which corresponds to never time out
  MutexMaxwait* = not int(0)
  GrabQuery* = - 1
  GrabOff* = 0
  GrabOn* = 1                #SDL_GRAB_FULLSCREEN // Used internally

type 
  THandle* = Int              #SDL_types.h types
                              # Basic data types
  TBool* = enum 
    sdlFALSE, sdlTRUE
  PUInt8Array* = ptr TUInt8Array
  TUInt8Array* = Array[0..high(Int) shr 1, Byte]
  PUInt16* = ptr Uint16
  PUInt32* = ptr Uint32
  PUInt64* = ptr UInt64
  UInt64*{.final.} = object 
    hi*: Int32
    lo*: Int32

  PSInt64* = ptr SInt64
  SInt64*{.final.} = object 
    hi*: Int32
    lo*: Int32

  TGrabMode* = Int32         # SDL_error.h types
  Terrorcode* = enum 
    ENOMEM, EFREAD, EFWRITE, EFSEEK, LASTERROR
  Errorcode* = Terrorcode
  TArg*{.final.} = object 
    buf*: Array[0..ERR_MAX_STRLEN - 1, Int8]

  Perror* = ptr Terror
  Terror*{.final.} = object  # This is a numeric value corresponding to the current error
                             # SDL_rwops.h types
                             # This is the read/write operation structure -- very basic
                             # some helper types to handle the unions
                             # "packed" is only guessed
    error*: Int # This is a key used to index into a language hashtable containing
                #       internationalized versions of the SDL error messages.  If the key
                #       is not in the hashtable, or no hashtable is available, the key is
                #       used directly as an error message format string.
    key*: Array[0..ERR_MAX_STRLEN - 1, Int8] # These are the arguments for the error functions
    argc*: Int
    args*: Array[0..ERR_MAX_ARGS - 1, TArg]

  TStdio*{.final.} = object 
    autoclose*: Int           # FILE * is only defined in Kylix so we use a simple Pointer
    fp*: Pointer

  TMem*{.final.} = object 
    base*: ptr Byte
    here*: ptr Byte
    stop*: ptr Byte

  PRWops* = ptr TRWops        # now the pointer to function types
  TSeek* = proc (context: PRWops, offset: Int, whence: Int): Int{.cdecl.}
  TRead* = proc (context: PRWops, thePtr: Pointer, size: Int, maxnum: Int): Int{.
      cdecl.}
  TWrite* = proc (context: PRWops, thePtr: Pointer, size: Int, num: Int): Int{.
      cdecl.}
  TClose* = proc (context: PRWops): Int{.cdecl.} # the variant record itself
  TRWops*{.final.} = object 
    seek*: TSeek
    read*: TRead
    write*: TWrite
    closeFile*: TClose        # a keyword as name is not allowed
                              # be warned! structure alignment may arise at this point
    theType*: Cint
    mem*: TMem
  
  RWops* = TRWops             # SDL_timer.h types
                              # Function prototype for the timer callback function
  TTimerCallback* = proc (interval: Int32): Int32{.cdecl.}
  TNewTimerCallback* = proc (interval: Int32, param: Pointer): Int32{.cdecl.}

  PTimerID* = ptr TTimerID
  TTimerID*{.final.} = object 
    interval*: Int32
    callback*: TNewTimerCallback
    param*: Pointer
    last_alarm*: Int32
    next*: PTimerID

  TAudioSpecCallback* = proc (userdata: Pointer, stream: ptr Byte, length: Int){.
      cdecl.}                 # SDL_audio.h types
                              # The calculated values in this structure are calculated by SDL_OpenAudio()
  PAudioSpec* = ptr TAudioSpec
  TAudioSpec*{.final.} = object  # A structure to hold a set of audio conversion filters and buffers
    freq*: Int                # DSP frequency -- samples per second
    format*: Uint16           # Audio data format
    channels*: Byte          # Number of channels: 1 mono, 2 stereo
    silence*: Byte           # Audio buffer silence value (calculated)
    samples*: Uint16          # Audio buffer size in samples
    padding*: Uint16          # Necessary for some compile environments
    size*: Int32 # Audio buffer size in bytes (calculated)
                 # This function is called when the audio device needs more data.
                 # 'stream' is a pointer to the audio data buffer
                 # 'len' is the length of that buffer in bytes.
                 # Once the callback returns, the buffer will no longer be valid.
                 # Stereo samples are stored in a LRLRLR ordering.
    callback*: TAudioSpecCallback
    userdata*: Pointer

  PAudioCVT* = ptr TAudioCVT
  PAudioCVTFilter* = ptr TAudioCVTFilter
  TAudioCVTFilter*{.final.} = object 
    cvt*: PAudioCVT
    format*: Uint16

  PAudioCVTFilterArray* = ptr TAudioCVTFilterArray
  TAudioCVTFilterArray* = Array[0..9, PAudioCVTFilter]
  TAudioCVT*{.final.} = object 
    needed*: Int              # Set to 1 if conversion possible
    src_format*: Uint16       # Source audio format
    dst_format*: Uint16       # Target audio format
    rate_incr*: Float64       # Rate conversion increment
    buf*: ptr Byte              # Buffer to hold entire audio data
    length*: Int              # Length of original audio buffer
    len_cvt*: Int             # Length of converted audio buffer
    len_mult*: Int            # buffer must be len*len_mult big
    len_ratio*: Float64       # Given len, final size is len*len_ratio
    filters*: TAudioCVTFilterArray
    filter_index*: Int        # Current audio conversion function
  
  TAudiostatus* = enum        # SDL_cdrom.h types
    AUDIO_STOPPED, AUDIO_PLAYING, AUDIO_PAUSED
  TCDStatus* = enum 
    CD_ERROR, CD_TRAYEMPTY, CD_STOPPED, CD_PLAYING, CD_PAUSED
  PCDTrack* = ptr TCDTrack
  TCDTrack*{.final.} = object  # This structure is only current as of the last call to SDL_CDStatus()
    id*: Byte                # Track number
    theType*: Byte           # Data or audio track
    unused*: Uint16
    len*: Int32              # Length, in frames, of this track
    offset*: Int32           # Offset, in frames, from start of disk
  
  Pcd* = ptr TCD
  TCD*{.final.} = object      #SDL_joystick.h types
    id*: Int                  # Private drive identifier
    status*: TCDStatus        # Current drive status
                              # The rest of this structure is only valid if there's a CD in drive
    numtracks*: Int           # Number of tracks on disk
    cur_track*: Int           # Current track position
    cur_frame*: Int           # Current frame offset within current track
    track*: Array[0..MAX_TRACKS, TCDTrack]

  PTransAxis* = ptr TTransAxis
  TTransAxis*{.final.} = object  # The private structure used to keep track of a joystick
    offset*: Int
    scale*: Float32

  PJoystickHwdata* = ptr TJoystick_hwdata
  TJoystick_hwdata*{.final.} = object  # joystick ID
    id*: Int                  # values used to translate device-specific coordinates into  SDL-standard ranges
    transaxis*: Array[0..5, TTransAxis]

  PBallDelta* = ptr TBallDelta
  TBallDelta*{.final.} = object  # Current ball motion deltas
                                 # The SDL joystick structure
    dx*: Int
    dy*: Int

  PJoystick* = ptr TJoystick
  TJoystick*{.final.} = object  # SDL_verion.h types
    index*: Byte             # Device index
    name*: Cstring            # Joystick name - system dependent
    naxes*: Int               # Number of axis controls on the joystick
    axes*: PUInt16            # Current axis states
    nhats*: Int               # Number of hats on the joystick
    hats*: ptr Byte             # Current hat states
    nballs*: Int              # Number of trackballs on the joystick
    balls*: PBallDelta        # Current ball motion deltas
    nbuttons*: Int            # Number of buttons on the joystick
    buttons*: ptr Byte          # Current button states
    hwdata*: PJoystickHwdata # Driver dependent information
    ref_count*: Int           # Reference count for multiple opens
  
  Pversion* = ptr Tversion
  Tversion*{.final.} = object  # SDL_keyboard.h types
    major*: Byte
    minor*: Byte
    patch*: Byte

  TKey* = Int32
  TMod* = Int32
  PKeySym* = ptr TKeySym
  TKeySym*{.final.} = object  # SDL_events.h types
                              #Checks the event queue for messages and optionally returns them.
                              #   If 'action' is SDL_ADDEVENT, up to 'numevents' events will be added to
                              #   the back of the event queue.
                              #   If 'action' is SDL_PEEKEVENT, up to 'numevents' events at the front
                              #   of the event queue, matching 'mask', will be returned and will not
                              #   be removed from the queue.
                              #   If 'action' is SDL_GETEVENT, up to 'numevents' events at the front
                              #   of the event queue, matching 'mask', will be returned and will be
                              #   removed from the queue.
                              #   This function returns the number of events actually stored, or -1
                              #   if there was an error.  This function is thread-safe.
    scancode*: Byte           # hardware specific scancode
    sym*: TKey                # SDL virtual keysym
    modifier*: TMod           # current key modifiers
    unicode*: Uint16          # translated character
  
  TEventAction* = enum        # Application visibility event structure
    ADDEVENT, PEEKEVENT, GETEVENT

  PActiveEvent* = ptr TActiveEvent
  TActiveEvent*{.final.} = object  # SDL_ACTIVEEVENT
                                   # Keyboard event structure
    kind*: TEventKind
    gain*: Byte              # Whether given states were gained or lost (1/0)
    state*: Byte             # A mask of the focus states
  
  PKeyboardEvent* = ptr TKeyboardEvent
  TKeyboardEvent*{.final.} = object  # SDL_KEYDOWN or SDL_KEYUP
                                     # Mouse motion event structure
    kind*: TEventKind
    which*: Byte             # The keyboard device index
    state*: Byte             # SDL_PRESSED or SDL_RELEASED
    keysym*: TKeySym

  PMouseMotionEvent* = ptr TMouseMotionEvent
  TMouseMotionEvent*{.final.} = object  # SDL_MOUSEMOTION
                                        # Mouse button event structure
    kind*: TEventKind
    which*: Byte             # The mouse device index
    state*: Byte             # The current button state
    x*, y*: Uint16            # The X/Y coordinates of the mouse
    xrel*: Int16             # The relative motion in the X direction
    yrel*: Int16             # The relative motion in the Y direction
  
  PMouseButtonEvent* = ptr TMouseButtonEvent
  TMouseButtonEvent*{.final.} = object  # SDL_MOUSEBUTTONDOWN or SDL_MOUSEBUTTONUP
                                        # Joystick axis motion event structure
    kind*: TEventKind
    which*: Byte             # The mouse device index
    button*: Byte            # The mouse button index
    state*: Byte             # SDL_PRESSED or SDL_RELEASED
    x*: Uint16                # The X coordinates of the mouse at press time
    y*: Uint16                # The Y coordinates of the mouse at press time
  
  PJoyAxisEvent* = ptr TJoyAxisEvent
  TJoyAxisEvent*{.final.} = object  # SDL_JOYAXISMOTION
                                    # Joystick trackball motion event structure
    kind*: TEventKind
    which*: Byte             # The joystick device index
    axis*: Byte              # The joystick axis index
    value*: Int16            # The axis value (range: -32768 to 32767)
  
  PJoyBallEvent* = ptr TJoyBallEvent
  TJoyBallEvent*{.final.} = object  # SDL_JOYAVBALLMOTION
                                    # Joystick hat position change event structure
    kind*: TEventKind
    which*: Byte             # The joystick device index
    ball*: Byte              # The joystick trackball index
    xrel*: Int16             # The relative motion in the X direction
    yrel*: Int16             # The relative motion in the Y direction
  
  PJoyHatEvent* = ptr TJoyHatEvent
  TJoyHatEvent*{.final.} = object  # SDL_JOYHATMOTION */
                                   # Joystick button event structure
    kind*: TEventKind
    which*: Byte             # The joystick device index */
    hat*: Byte               # The joystick hat index */
    value*: Byte             # The hat position value:
                             # 8   1   2
                             # 7   0   3
                             # 6   5   4
                             # Note that zero means the POV is centered.
  
  PJoyButtonEvent* = ptr TJoyButtonEvent
  TJoyButtonEvent*{.final.} = object  # SDL_JOYBUTTONDOWN or SDL_JOYBUTTONUP
                                      # The "window resized" event
                                      # When you get this event, you are
                                      # responsible for setting a new video
                                      # mode with the new width and height.
    kind*: TEventKind
    which*: Byte             # The joystick device index
    button*: Byte            # The joystick button index
    state*: Byte             # SDL_PRESSED or SDL_RELEASED
  
  PResizeEvent* = ptr TResizeEvent
  TResizeEvent*{.final.} = object  # SDL_VIDEORESIZE
                                   # A user-defined event type
    kind*: TEventKind
    w*: Cint                   # New width
    h*: Cint                   # New height
  
  PUserEvent* = ptr TUserEvent
  TUserEvent*{.final.} = object  # SDL_USEREVENT through SDL_NUMEVENTS-1
    kind*: TEventKind
    code*: Cint                # User defined event code
    data1*: Pointer           # User defined data pointer
    data2*: Pointer           # User defined data pointer 
  

when defined(Unix): 
  type                        #These are the various supported subsystems under UNIX
    TSysWm* = enum 
      SYSWM_X11
when defined(WINDOWS): 
  type 
    PSysWMmsg* = ptr TSysWMmsg
    TSysWMmsg*{.final.} = object 
      version*: Tversion
      hwnd*: THandle          # The window for the message
      msg*: int               # The type of message
      w_Param*: int32         # WORD message parameter
      lParam*: int32          # LONG message parameter
    
elif defined(Unix): 
  type                        # The Linux custom event structure
    PSysWMmsg* = ptr TSysWMmsg
    TSysWMmsg*{.final.} = object 
      version*: Tversion
      subsystem*: TSysWm
      when false: 
          event*: TXEvent

    
else: 
  type                        # The generic custom event structure
    PSysWMmsg* = ptr TSysWMmsg
    TSysWMmsg*{.final.} = object 
      version*: Tversion
      data*: int

# The Windows custom window manager information structure

when defined(WINDOWS): 
  type 
    PSysWMinfo* = ptr TSysWMinfo
    TSysWMinfo*{.final.} = object 
      version*: Tversion
      window*: THandle        # The display window
    
elif defined(Unix): 
  type 
    TX11*{.final.} = object 
      when false: 
          display*: PDisplay  # The X11 display
          window*: TWindow    # The X11 display window
                              # These locking functions should be called around
                              # any X11 functions using the display variable.
                              # They lock the event thread, so should not be
                              # called around event functions or from event filters.
          lock_func*: Pointer
          unlock_func*: Pointer # Introduced in SDL 1.0.2
          fswindow*: TWindow  # The X11 fullscreen window
          wmwindow*: TWindow  # The X11 managed input window
        
    
  type 
    PSysWMinfo* = ptr TSysWMinfo
    TSysWMinfo*{.final.} = object 
      version*: Tversion
      subsystem*: TSysWm
      X11*: TX11

else: 
  type # The generic custom window manager information structure
    PSysWMinfo* = ptr TSysWMinfo
    TSysWMinfo*{.final.} = object 
      version*: Tversion
      data*: int

type 
  PSysWMEvent* = ptr TSysWMEvent
  TSysWMEvent*{.final.} = object 
    kind*: TEventKind
    msg*: PSysWMmsg

  PExposeEvent* = ptr TExposeEvent
  TExposeEvent*{.final.} = object
    kind*: TEventKind

  PQuitEvent* = ptr TQuitEvent
  TQuitEvent*{.final.} = object
    kind*: TEventKind

  PEvent* = ptr TEvent
  TEvent*{.final.} = object  
    kind*: TEventKind
    pad: Array[0..19, Byte]
  
  TEventFilter* = proc (event: PEvent): Int{.cdecl.} # SDL_video.h types
                                                     # Useful data types
  PPSDLRect* = ptr PRect
  PRect* = ptr TRect
  TRect*{.final.} = object 
    x*, y*: Int16
    w*, h*: Uint16

  Rect* = TRect
  PColor* = ptr TColor
  TColor*{.final.} = object 
    r*: Byte
    g*: Byte
    b*: Byte
    unused*: Byte

  PColorArray* = ptr TColorArray
  TColorArray* = Array[0..65000, TColor]
  PPalette* = ptr TPalette
  TPalette*{.final.} = object  # Everything in the pixel format structure is read-only
    ncolors*: Int
    colors*: PColorArray

  PPixelFormat* = ptr TPixelFormat
  TPixelFormat*{.final.} = object  # The structure passed to the low level blit functions
    palette*: PPalette
    BitsPerPixel*: Byte
    BytesPerPixel*: Byte
    Rloss*: Byte
    Gloss*: Byte
    Bloss*: Byte
    Aloss*: Byte
    Rshift*: Byte
    Gshift*: Byte
    Bshift*: Byte
    Ashift*: Byte
    RMask*: Int32
    GMask*: Int32
    BMask*: Int32
    AMask*: Int32
    colorkey*: Int32         # RGB color key information
    alpha*: Byte             # Alpha value information (per-surface alpha)
  
  PBlitInfo* = ptr TBlitInfo
  TBlitInfo*{.final.} = object  # typedef for private surface blitting functions
    s_pixels*: ptr Byte
    s_width*: Int
    s_height*: Int
    s_skip*: Int
    d_pixels*: ptr Byte
    d_width*: Int
    d_height*: Int
    d_skip*: Int
    aux_data*: Pointer
    src*: PPixelFormat
    table*: ptr Byte
    dst*: PPixelFormat

  PSurface* = ptr TSurface
  TBlit* = proc (src: PSurface, srcrect: PRect, 
                 dst: PSurface, dstrect: PRect): Int{.cdecl.}
  TSurface*{.final.} = object  # Useful for determining the video hardware capabilities
    flags*: Int32            # Read-only
    format*: PPixelFormat     # Read-only
    w*, h*: Cint              # Read-only
    pitch*: Uint16            # Read-only
    pixels*: Pointer          # Read-write
    offset*: Cint             # Private
    hwdata*: Pointer          #TPrivate_hwdata;  Hardware-specific surface info
                              # clipping information:
    clip_rect*: TRect         # Read-only
    unused1*: Int32           # for binary compatibility
                              # Allow recursive locks
    locked*: Int32            # Private
                              # info for fast blit mapping to other surfaces
    Blitmap*: Pointer         # PSDL_BlitMap; //   Private
                              # format version, bumped at every change to invalidate blit maps
    format_version*: Cint      # Private
    refcount*: Cint

  PVideoInfo* = ptr TVideoInfo
  TVideoInfo*{.final.} = object  # The YUV hardware video overlay
    hw_available*: Byte 
    blit_hw*: Byte 
    UnusedBits3*: Byte       # Unused at this point
    video_mem*: Int32        # The total amount of video memory (in K)
    vfmt*: PPixelFormat       # Value: The format of the video surface
    current_w*: Int32        # Value: The current video mode width
    current_h*: Int32        # Value: The current video mode height
  
  POverlay* = ptr TOverlay
  TOverlay*{.final.} = object  # Public enumeration for setting the OpenGL window attributes.
    format*: Int32           # Overlay format
    w*, h*: Int               # Width and height of overlay
    planes*: Int              # Number of planes in the overlay. Usually either 1 or 3
    pitches*: PUInt16         # An array of pitches, one for each plane. Pitch is the length of a row in bytes.
    pixels*: ptr ptr Byte # An array of pointers to the data of each plane. The overlay should be locked before these pointers are used.
    hw_overlay*: Int32    # This will be set to 1 if the overlay is hardware accelerated.
  
  TGLAttr* = enum 
    GL_RED_SIZE, GL_GREEN_SIZE, GL_BLUE_SIZE, GL_ALPHA_SIZE, GL_BUFFER_SIZE, 
    GL_DOUBLEBUFFER, GL_DEPTH_SIZE, GL_STENCIL_SIZE, GL_ACCUM_RED_SIZE, 
    GL_ACCUM_GREEN_SIZE, GL_ACCUM_BLUE_SIZE, GL_ACCUM_ALPHA_SIZE, GL_STEREO, 
    GL_MULTISAMPLEBUFFERS, GL_MULTISAMPLESAMPLES, GL_ACCELERATED_VISUAL, 
    GL_SWAP_CONTROL
  PCursor* = ptr TCursor
  TCursor*{.final.} = object  # SDL_mutex.h types
    area*: TRect              # The area of the mouse cursor
    hot_x*, hot_y*: Int16    # The "tip" of the cursor
    data*: ptr Byte             # B/W cursor data
    mask*: ptr Byte             # B/W cursor mask
    save*: Array[1..2, ptr Byte] # Place to save cursor area
    wm_cursor*: Pointer       # Window-manager cursor
  

type 
  PMutex* = ptr TMutex
  TMutex*{.final.} = object 
  Psemaphore* = ptr Tsemaphore
  Tsemaphore*{.final.} = object 
  PSem* = ptr TSem
  TSem* = Tsemaphore
  PCond* = ptr TCond
  TCond*{.final.} = object    # SDL_thread.h types

when defined(WINDOWS): 
  type 
    TSYS_ThreadHandle* = THandle
when defined(Unix): 
  type 
    TSYS_ThreadHandle* = Pointer
type                          # This is the system-independent thread info structure
  PThread* = ptr TThread
  TThread*{.final.} = object  # Helper Types
                              # Keyboard  State Array ( See demos for how to use )
    threadid*: Int32
    handle*: TSYS_ThreadHandle
    status*: Int
    errbuf*: Terror
    data*: Pointer

  PKeyStateArr* = ptr TKeyStateArr
  TKeyStateArr* = Array[0..65000, Byte] # Types required so we don't need to use Windows.pas
  PInteger* = ptr Int
  PByte* = ptr Int8
  PWord* = ptr Int16
  PLongWord* = ptr Int32      # General arrays
  PByteArray* = ptr TByteArray
  TByteArray* = Array[0..32767, Int8]
  PWordArray* = ptr TWordArray
  TWordArray* = Array[0..16383, Int16] # Generic procedure pointer

type TEventSeq = Set[TEventKind]
template evconv(procName: Expr, ptrName: TypeDesc, assertions: TEventSeq): Stmt {.immediate.} =
  proc `procName`*(event: PEvent): ptrName =
    assert(contains(assertions, event.kind))
    result = cast[ptrName](event)

evconv(EvActive, PActiveEvent, {ACTIVEEVENT})
evconv(EvKeyboard, PKeyboardEvent, {KEYDOWN, KEYUP})
evconv(EvMouseMotion, PMouseMotionEvent, {MOUSEMOTION})
evconv(EvMouseButton, PMouseButtonEvent, {MOUSEBUTTONDOWN, MOUSEBUTTONUP})
evconv(EvJoyAxis, PJoyAxisEvent,{JOYAXISMOTION})
evconv(EvJoyBall, PJoyBallEvent, {JOYBALLMOTION})
evconv(EvJoyHat, PJoyHatEvent, {JOYHATMOTION})
evconv(EvJoyButton, PJoyButtonEvent, {JOYBUTTONDOWN, JOYBUTTONUP})
evconv(EvResize, PResizeEvent, {VIDEORESIZE})
evconv(EvExpose, PExposeEvent, {VIDEOEXPOSE})
evconv(EvQuit, PQuitEvent, {QUITEV})
evconv(EvUser, PUserEvent, {USEREVENT})
evconv(EvSysWM, PSysWMEvent, {SYSWMEVENT})

#------------------------------------------------------------------------------
# initialization
#------------------------------------------------------------------------------
# This function loads the SDL dynamically linked library and initializes
#  the subsystems specified by 'flags' (and those satisfying dependencies)
#  Unless the SDL_INIT_NOPARACHUTE flag is set, it will install cleanup
#  signal handlers for some commonly ignored fatal signals (like SIGSEGV)

proc init*(flags: Int32): Int{.cdecl, importc: "SDL_Init", dynlib: LibName.}
  # This function initializes specific SDL subsystems
proc initSubSystem*(flags: Int32): Int{.cdecl, importc: "SDL_InitSubSystem", 
    dynlib: LibName.}
  # This function cleans up specific SDL subsystems
proc quitSubSystem*(flags: Int32){.cdecl, importc: "SDL_QuitSubSystem", 
                                    dynlib: LibName.}
  # This function returns mask of the specified subsystems which have
  #  been initialized.
  #  If 'flags' is 0, it returns a mask of all initialized subsystems.
proc wasInit*(flags: Int32): Int32{.cdecl, importc: "SDL_WasInit", 
                                      dynlib: LibName.}
  # This function cleans up all initialized subsystems and unloads the
  #  dynamically linked library.  You should call it upon all exit conditions.
proc quit*(){.cdecl, importc: "SDL_Quit", dynlib: LibName.}
when defined(WINDOWS): 
  # This should be called from your WinMain() function, if any
  proc RegisterApp*(name: cstring, style: int32, h_Inst: Pointer): int{.cdecl, 
      importc: "SDL_RegisterApp", dynlib: LibName.}
proc tableSize*(table: Cstring): Int
  #------------------------------------------------------------------------------
  # error-handling
  #------------------------------------------------------------------------------
  # Public functions
proc getError*(): Cstring{.cdecl, importc: "SDL_GetError", dynlib: LibName.}
proc setError*(fmt: Cstring){.cdecl, importc: "SDL_SetError", dynlib: LibName.}
proc clearError*(){.cdecl, importc: "SDL_ClearError", dynlib: LibName.}
when not (defined(WINDOWS)): 
  proc error*(Code: Terrorcode){.cdecl, importc: "SDL_Error", dynlib: LibName.}
proc outOfMemory*()
  #------------------------------------------------------------------------------
  # io handling
  #------------------------------------------------------------------------------
  # Functions to create SDL_RWops structures from various data sources
proc rWFromFile*(filename, mode: Cstring): PRWops{.cdecl, 
    importc: "SDL_RWFromFile", dynlib: LibName.}
proc freeRW*(area: PRWops){.cdecl, importc: "SDL_FreeRW", dynlib: LibName.}
  #fp is FILE *fp ???
proc rWFromFP*(fp: Pointer, autoclose: Int): PRWops{.cdecl, 
    importc: "SDL_RWFromFP", dynlib: LibName.}
proc rWFromMem*(mem: Pointer, size: Int): PRWops{.cdecl, 
    importc: "SDL_RWFromMem", dynlib: LibName.}
proc rWFromConstMem*(mem: Pointer, size: Int): PRWops{.cdecl, 
    importc: "SDL_RWFromConstMem", dynlib: LibName.}
proc allocRW*(): PRWops{.cdecl, importc: "SDL_AllocRW", dynlib: LibName.}
proc rWSeek*(context: PRWops, offset: Int, whence: Int): Int
proc rWTell*(context: PRWops): Int
proc rWRead*(context: PRWops, theptr: Pointer, size: Int, n: Int): Int
proc rWWrite*(context: PRWops, theptr: Pointer, size: Int, n: Int): Int
proc rWClose*(context: PRWops): Int
  #------------------------------------------------------------------------------
  # time-handling
  #------------------------------------------------------------------------------
  # Get the number of milliseconds since the SDL library initialization.
  # Note that this value wraps if the program runs for more than ~49 days.
proc getTicks*(): Int32{.cdecl, importc: "SDL_GetTicks", dynlib: LibName.}
  # Wait a specified number of milliseconds before returning
proc delay*(msec: Int32){.cdecl, importc: "SDL_Delay", dynlib: LibName.}
  # Add a new timer to the pool of timers already running.
  # Returns a timer ID, or NULL when an error occurs.
proc addTimer*(interval: Int32, callback: TNewTimerCallback, param: Pointer): PTimerID{.
    cdecl, importc: "SDL_AddTimer", dynlib: LibName.}
  # Remove one of the multiple timers knowing its ID.
  # Returns a boolean value indicating success.
proc removeTimer*(t: PTimerID): TBool{.cdecl, importc: "SDL_RemoveTimer", 
                                       dynlib: LibName.}
proc setTimer*(interval: Int32, callback: TTimerCallback): Int{.cdecl, 
    importc: "SDL_SetTimer", dynlib: LibName.}
  #------------------------------------------------------------------------------
  # audio-routines
  #------------------------------------------------------------------------------
  # These functions are used internally, and should not be used unless you
  #  have a specific need to specify the audio driver you want to use.
  #  You should normally use SDL_Init() or SDL_InitSubSystem().
proc audioInit*(driver_name: Cstring): Int{.cdecl, importc: "SDL_AudioInit", 
    dynlib: LibName.}
proc audioQuit*(){.cdecl, importc: "SDL_AudioQuit", dynlib: LibName.}
  # This function fills the given character buffer with the name of the
  #  current audio driver, and returns a Pointer to it if the audio driver has
  #  been initialized.  It returns NULL if no driver has been initialized.
proc audioDriverName*(namebuf: Cstring, maxlen: Int): Cstring{.cdecl, 
    importc: "SDL_AudioDriverName", dynlib: LibName.}
  # This function opens the audio device with the desired parameters, and
  #  returns 0 if successful, placing the actual hardware parameters in the
  #  structure pointed to by 'obtained'.  If 'obtained' is NULL, the audio
  #  data passed to the callback function will be guaranteed to be in the
  #  requested format, and will be automatically converted to the hardware
  #  audio format if necessary.  This function returns -1 if it failed
  #  to open the audio device, or couldn't set up the audio thread.
  #
  #  When filling in the desired audio spec structure,
  #   'desired->freq' should be the desired audio frequency in samples-per-second.
  #   'desired->format' should be the desired audio format.
  #   'desired->samples' is the desired size of the audio buffer, in samples.
  #      This number should be a power of two, and may be adjusted by the audio
  #      driver to a value more suitable for the hardware.  Good values seem to
  #      range between 512 and 8096 inclusive, depending on the application and
  #      CPU speed.  Smaller values yield faster response time, but can lead
  #      to underflow if the application is doing heavy processing and cannot
  #      fill the audio buffer in time.  A stereo sample consists of both right
  #      and left channels in LR ordering.
  #      Note that the number of samples is directly related to time by the
  #      following formula:  ms = (samples*1000)/freq
  #   'desired->size' is the size in bytes of the audio buffer, and is
  #      calculated by SDL_OpenAudio().
  #   'desired->silence' is the value used to set the buffer to silence,
  #      and is calculated by SDL_OpenAudio().
  #   'desired->callback' should be set to a function that will be called
  #      when the audio device is ready for more data.  It is passed a pointer
  #      to the audio buffer, and the length in bytes of the audio buffer.
  #      This function usually runs in a separate thread, and so you should
  #      protect data structures that it accesses by calling SDL_LockAudio()
  #      and SDL_UnlockAudio() in your code.
  #   'desired->userdata' is passed as the first parameter to your callback
  #      function.
  #
  #  The audio device starts out playing silence when it's opened, and should
  #  be enabled for playing by calling SDL_PauseAudio(0) when you are ready
  #  for your audio callback function to be called.  Since the audio driver
  #  may modify the requested size of the audio buffer, you should allocate
  #  any local mixing buffers after you open the audio device.
proc openAudio*(desired, obtained: PAudioSpec): Int{.cdecl, 
    importc: "SDL_OpenAudio", dynlib: LibName.}
  # Get the current audio state:
proc getAudioStatus*(): TAudiostatus{.cdecl, importc: "SDL_GetAudioStatus", 
                                      dynlib: LibName.}
  # This function pauses and unpauses the audio callback processing.
  #  It should be called with a parameter of 0 after opening the audio
  #  device to start playing sound.  This is so you can safely initialize
  #  data for your callback function after opening the audio device.
  #  Silence will be written to the audio device during the pause.
proc pauseAudio*(pause_on: Int){.cdecl, importc: "SDL_PauseAudio", 
                                 dynlib: LibName.}
  # This function loads a WAVE from the data source, automatically freeing
  #  that source if 'freesrc' is non-zero.  For example, to load a WAVE file,
  #  you could do:
  #  SDL_LoadWAV_RW(SDL_RWFromFile("sample.wav", "rb"), 1, ...);
  #
  #  If this function succeeds, it returns the given SDL_AudioSpec,
  #  filled with the audio data format of the wave data, and sets
  #  'audio_buf' to a malloc()'d buffer containing the audio data,
  #  and sets 'audio_len' to the length of that audio buffer, in bytes.
  #  You need to free the audio buffer with SDL_FreeWAV() when you are
  #  done with it.
  #
  #  This function returns NULL and sets the SDL error message if the
  #  wave file cannot be opened, uses an unknown data format, or is
  #  corrupt.  Currently raw and MS-ADPCM WAVE files are supported.
proc loadWAVRW*(src: PRWops, freesrc: Int, spec: PAudioSpec, audio_buf: ptr Byte, 
                 audiolen: PUInt32): PAudioSpec{.cdecl, 
    importc: "SDL_LoadWAV_RW", dynlib: LibName.}
  # Compatibility convenience function -- loads a WAV from a file
proc loadWAV*(filename: Cstring, spec: PAudioSpec, audio_buf: ptr Byte, 
              audiolen: PUInt32): PAudioSpec
  # This function frees data previously allocated with SDL_LoadWAV_RW()
proc freeWAV*(audio_buf: ptr Byte){.cdecl, importc: "SDL_FreeWAV", dynlib: LibName.}
  # This function takes a source format and rate and a destination format
  #  and rate, and initializes the 'cvt' structure with information needed
  #  by SDL_ConvertAudio() to convert a buffer of audio data from one format
  #  to the other.
  #  This function returns 0, or -1 if there was an error.
proc buildAudioCVT*(cvt: PAudioCVT, src_format: Uint16, src_channels: Byte, 
                    src_rate: Int, dst_format: Uint16, dst_channels: Byte, 
                    dst_rate: Int): Int{.cdecl, importc: "SDL_BuildAudioCVT", 
    dynlib: LibName.}
  # Once you have initialized the 'cvt' structure using SDL_BuildAudioCVT(),
  #  created an audio buffer cvt->buf, and filled it with cvt->len bytes of
  #  audio data in the source format, this function will convert it in-place
  #  to the desired format.
  #  The data conversion may expand the size of the audio data, so the buffer
  #  cvt->buf should be allocated after the cvt structure is initialized by
  #  SDL_BuildAudioCVT(), and should be cvt->len*cvt->len_mult bytes long.
proc convertAudio*(cvt: PAudioCVT): Int{.cdecl, importc: "SDL_ConvertAudio", 
    dynlib: LibName.}
  # This takes two audio buffers of the playing audio format and mixes
  #  them, performing addition, volume adjustment, and overflow clipping.
  #  The volume ranges from 0 - 128, and should be set to SDL_MIX_MAXVOLUME
  #  for full audio volume.  Note this does not change hardware volume.
  #  This is provided for convenience -- you can mix your own audio data.
proc mixAudio*(dst, src: ptr Byte, length: Int32, volume: Int){.cdecl, 
    importc: "SDL_MixAudio", dynlib: LibName.}
  # The lock manipulated by these functions protects the callback function.
  #  During a LockAudio/UnlockAudio pair, you can be guaranteed that the
  #  callback function is not running.  Do not call these from the callback
  #  function or you will cause deadlock.
proc lockAudio*(){.cdecl, importc: "SDL_LockAudio", dynlib: LibName.}
proc unlockAudio*(){.cdecl, importc: "SDL_UnlockAudio", dynlib: LibName.}
  # This function shuts down audio processing and closes the audio device.
proc closeAudio*(){.cdecl, importc: "SDL_CloseAudio", dynlib: LibName.}
  #------------------------------------------------------------------------------
  # CD-routines
  #------------------------------------------------------------------------------
  # Returns the number of CD-ROM drives on the system, or -1 if
  #  SDL_Init() has not been called with the SDL_INIT_CDROM flag.
proc cDNumDrives*(): Int{.cdecl, importc: "SDL_CDNumDrives", dynlib: LibName.}
  # Returns a human-readable, system-dependent identifier for the CD-ROM.
  #   Example:
  #   "/dev/cdrom"
  #   "E:"
  #   "/dev/disk/ide/1/master"
proc cDName*(drive: Int): Cstring{.cdecl, importc: "SDL_CDName", dynlib: LibName.}
  # Opens a CD-ROM drive for access.  It returns a drive handle on success,
  #  or NULL if the drive was invalid or busy.  This newly opened CD-ROM
  #  becomes the default CD used when other CD functions are passed a NULL
  #  CD-ROM handle.
  #  Drives are numbered starting with 0.  Drive 0 is the system default CD-ROM.
proc cDOpen*(drive: Int): Pcd{.cdecl, importc: "SDL_CDOpen", dynlib: LibName.}
  # This function returns the current status of the given drive.
  #  If the drive has a CD in it, the table of contents of the CD and current
  #  play position of the CD will be stored in the SDL_CD structure.
proc cDStatus*(cdrom: Pcd): TCDStatus{.cdecl, importc: "SDL_CDStatus", 
                                       dynlib: LibName.}
  #  Play the given CD starting at 'start_track' and 'start_frame' for 'ntracks'
  #   tracks and 'nframes' frames.  If both 'ntrack' and 'nframe' are 0, play
  #   until the end of the CD.  This function will skip data tracks.
  #   This function should only be called after calling SDL_CDStatus() to
  #   get track information about the CD.
  #
  #   For example:
  #   // Play entire CD:
  #  if ( CD_INDRIVE(SDL_CDStatus(cdrom)) ) then
  #    SDL_CDPlayTracks(cdrom, 0, 0, 0, 0);
  #   // Play last track:
  #   if ( CD_INDRIVE(SDL_CDStatus(cdrom)) ) then
  #   begin
  #    SDL_CDPlayTracks(cdrom, cdrom->numtracks-1, 0, 0, 0);
  #   end;
  #
  #   // Play first and second track and 10 seconds of third track:
  #   if ( CD_INDRIVE(SDL_CDStatus(cdrom)) )
  #    SDL_CDPlayTracks(cdrom, 0, 0, 2, 10);
  #
  #   This function returns 0, or -1 if there was an error.
proc cDPlayTracks*(cdrom: Pcd, start_track: Int, start_frame: Int, ntracks: Int, 
                   nframes: Int): Int{.cdecl, importc: "SDL_CDPlayTracks", 
                                       dynlib: LibName.}
  #  Play the given CD starting at 'start' frame for 'length' frames.
  #   It returns 0, or -1 if there was an error.
proc cDPlay*(cdrom: Pcd, start: Int, len: Int): Int{.cdecl, 
    importc: "SDL_CDPlay", dynlib: LibName.}
  # Pause play -- returns 0, or -1 on error
proc cDPause*(cdrom: Pcd): Int{.cdecl, importc: "SDL_CDPause", dynlib: LibName.}
  # Resume play -- returns 0, or -1 on error
proc cDResume*(cdrom: Pcd): Int{.cdecl, importc: "SDL_CDResume", dynlib: LibName.}
  # Stop play -- returns 0, or -1 on error
proc cDStop*(cdrom: Pcd): Int{.cdecl, importc: "SDL_CDStop", dynlib: LibName.}
  # Eject CD-ROM -- returns 0, or -1 on error
proc cDEject*(cdrom: Pcd): Int{.cdecl, importc: "SDL_CDEject", dynlib: LibName.}
  # Closes the handle for the CD-ROM drive
proc cDClose*(cdrom: Pcd){.cdecl, importc: "SDL_CDClose", dynlib: LibName.}
  # Given a status, returns true if there's a disk in the drive
proc cDInDrive*(status: TCDStatus): Bool
  # Conversion functions from frames to Minute/Second/Frames and vice versa
proc framesToMsf*(frames: Int, M: var Int, S: var Int, F: var Int)
proc msfToFrames*(M: Int, S: Int, F: Int): Int
  #------------------------------------------------------------------------------
  # JoyStick-routines
  #------------------------------------------------------------------------------
  # Count the number of joysticks attached to the system
proc numJoysticks*(): Int{.cdecl, importc: "SDL_NumJoysticks", dynlib: LibName.}
  # Get the implementation dependent name of a joystick.
  #  This can be called before any joysticks are opened.
  #  If no name can be found, this function returns NULL.
proc joystickName*(index: Int): Cstring{.cdecl, importc: "SDL_JoystickName", 
    dynlib: LibName.}
  # Open a joystick for use - the index passed as an argument refers to
  #  the N'th joystick on the system.  This index is the value which will
  #  identify this joystick in future joystick events.
  #
  #  This function returns a joystick identifier, or NULL if an error occurred.
proc joystickOpen*(index: Int): PJoystick{.cdecl, importc: "SDL_JoystickOpen", 
    dynlib: LibName.}
  # Returns 1 if the joystick has been opened, or 0 if it has not.
proc joystickOpened*(index: Int): Int{.cdecl, importc: "SDL_JoystickOpened", 
                                       dynlib: LibName.}
  # Get the device index of an opened joystick.
proc joystickIndex*(joystick: PJoystick): Int{.cdecl, 
    importc: "SDL_JoystickIndex", dynlib: LibName.}
  # Get the number of general axis controls on a joystick
proc joystickNumAxes*(joystick: PJoystick): Int{.cdecl, 
    importc: "SDL_JoystickNumAxes", dynlib: LibName.}
  # Get the number of trackballs on a joystick
  #  Joystick trackballs have only relative motion events associated
  #  with them and their state cannot be polled.
proc joystickNumBalls*(joystick: PJoystick): Int{.cdecl, 
    importc: "SDL_JoystickNumBalls", dynlib: LibName.}
  # Get the number of POV hats on a joystick
proc joystickNumHats*(joystick: PJoystick): Int{.cdecl, 
    importc: "SDL_JoystickNumHats", dynlib: LibName.}
  # Get the number of buttons on a joystick
proc joystickNumButtons*(joystick: PJoystick): Int{.cdecl, 
    importc: "SDL_JoystickNumButtons", dynlib: LibName.}
  # Update the current state of the open joysticks.
  #  This is called automatically by the event loop if any joystick
  #  events are enabled.
proc joystickUpdate*(){.cdecl, importc: "SDL_JoystickUpdate", dynlib: LibName.}
  # Enable/disable joystick event polling.
  #  If joystick events are disabled, you must call SDL_JoystickUpdate()
  #  yourself and check the state of the joystick when you want joystick
  #  information.
  #  The state can be one of SDL_QUERY, SDL_ENABLE or SDL_IGNORE.
proc joystickEventState*(state: Int): Int{.cdecl, 
    importc: "SDL_JoystickEventState", dynlib: LibName.}
  # Get the current state of an axis control on a joystick
  #  The state is a value ranging from -32768 to 32767.
  #  The axis indices start at index 0.
proc joystickGetAxis*(joystick: PJoystick, axis: Int): Int16{.cdecl, 
    importc: "SDL_JoystickGetAxis", dynlib: LibName.}
  # The hat indices start at index 0.
proc joystickGetHat*(joystick: PJoystick, hat: Int): Byte{.cdecl, 
    importc: "SDL_JoystickGetHat", dynlib: LibName.}
  # Get the ball axis change since the last poll
  #  This returns 0, or -1 if you passed it invalid parameters.
  #  The ball indices start at index 0.
proc joystickGetBall*(joystick: PJoystick, ball: Int, dx: var Int, dy: var Int): Int{.
    cdecl, importc: "SDL_JoystickGetBall", dynlib: LibName.}
  # Get the current state of a button on a joystick
  #  The button indices start at index 0.
proc joystickGetButton*(joystick: PJoystick, Button: Int): Byte{.cdecl, 
    importc: "SDL_JoystickGetButton", dynlib: LibName.}
  # Close a joystick previously opened with SDL_JoystickOpen()
proc joystickClose*(joystick: PJoystick){.cdecl, importc: "SDL_JoystickClose", 
    dynlib: LibName.}
  #------------------------------------------------------------------------------
  # event-handling
  #------------------------------------------------------------------------------
  # Pumps the event loop, gathering events from the input devices.
  #  This function updates the event queue and internal input device state.
  #  This should only be run in the thread that sets the video mode.
proc pumpEvents*(){.cdecl, importc: "SDL_PumpEvents", dynlib: LibName.}
  # Checks the event queue for messages and optionally returns them.
  #  If 'action' is SDL_ADDEVENT, up to 'numevents' events will be added to
  #  the back of the event queue.
  #  If 'action' is SDL_PEEKEVENT, up to 'numevents' events at the front
  #  of the event queue, matching 'mask', will be returned and will not
  #  be removed from the queue.
  #  If 'action' is SDL_GETEVENT, up to 'numevents' events at the front
  #  of the event queue, matching 'mask', will be returned and will be
  #  removed from the queue.
  #  This function returns the number of events actually stored, or -1
  #  if there was an error.  This function is thread-safe.
proc peepEvents*(events: PEvent, numevents: Int, action: Teventaction, 
                 mask: Int32): Int{.cdecl, importc: "SDL_PeepEvents", 
                                     dynlib: LibName.}
  # Polls for currently pending events, and returns 1 if there are any pending
  #   events, or 0 if there are none available.  If 'event' is not NULL, the next
  #   event is removed from the queue and stored in that area.
proc pollEvent*(event: PEvent): Int{.cdecl, importc: "SDL_PollEvent", 
                                     dynlib: LibName.}
  #  Waits indefinitely for the next available event, returning 1, or 0 if there
  #   was an error while waiting for events.  If 'event' is not NULL, the next
  #   event is removed from the queue and stored in that area.
proc waitEvent*(event: PEvent): Int{.cdecl, importc: "SDL_WaitEvent", 
                                     dynlib: LibName.}
proc pushEvent*(event: PEvent): Int{.cdecl, importc: "SDL_PushEvent", 
                                     dynlib: LibName.}
  # If the filter returns 1, then the event will be added to the internal queue.
  #  If it returns 0, then the event will be dropped from the queue, but the
  #  internal state will still be updated.  This allows selective filtering of
  #  dynamically arriving events.
  #
  #  WARNING:  Be very careful of what you do in the event filter function, as
  #            it may run in a different thread!
  #
  #  There is one caveat when dealing with the SDL_QUITEVENT event type.  The
  #  event filter is only called when the window manager desires to close the
  #  application window.  If the event filter returns 1, then the window will
  #  be closed, otherwise the window will remain open if possible.
  #  If the quit event is generated by an interrupt signal, it will bypass the
  #  internal queue and be delivered to the application at the next event poll.
proc setEventFilter*(filter: TEventFilter){.cdecl, 
    importc: "SDL_SetEventFilter", dynlib: LibName.}
  # Return the current event filter - can be used to "chain" filters.
  #  If there is no event filter set, this function returns NULL.
proc getEventFilter*(): TEventFilter{.cdecl, importc: "SDL_GetEventFilter", 
                                      dynlib: LibName.}
  # This function allows you to set the state of processing certain events.
  #  If 'state' is set to SDL_IGNORE, that event will be automatically dropped
  #  from the event queue and will not event be filtered.
  #  If 'state' is set to SDL_ENABLE, that event will be processed normally.
  #  If 'state' is set to SDL_QUERY, SDL_EventState() will return the
  #  current processing state of the specified event.
proc eventState*(theType: Byte, state: Int): Byte{.cdecl, 
    importc: "SDL_EventState", dynlib: LibName.}
  #------------------------------------------------------------------------------
  # Version Routines
  #------------------------------------------------------------------------------
  # This macro can be used to fill a version structure with the compile-time
  #  version of the SDL library.
proc version*(X: var Tversion)
  # This macro turns the version numbers into a numeric value:
  #   (1,2,3) -> (1203)
  #   This assumes that there will never be more than 100 patchlevels
proc versionnum*(X, Y, Z: Int): Int
  # This is the version number macro for the current SDL version
proc compiledversion*(): Int
  # This macro will evaluate to true if compiled with SDL at least X.Y.Z
proc versionAtleast*(X: Int, Y: Int, Z: Int): Bool
  # This function gets the version of the dynamically linked SDL library.
  #  it should NOT be used to fill a version structure, instead you should
  #  use the SDL_Version() macro.
proc linkedVersion*(): Pversion{.cdecl, importc: "SDL_Linked_Version", 
                                  dynlib: LibName.}
  #------------------------------------------------------------------------------
  # video
  #------------------------------------------------------------------------------
  # These functions are used internally, and should not be used unless you
  #  have a specific need to specify the video driver you want to use.
  #  You should normally use SDL_Init() or SDL_InitSubSystem().
  #
  #  SDL_VideoInit() initializes the video subsystem -- sets up a connection
  #  to the window manager, etc, and determines the current video mode and
  #  pixel format, but does not initialize a window or graphics mode.
  #  Note that event handling is activated by this routine.
  #
  #  If you use both sound and video in your application, you need to call
  #  SDL_Init() before opening the sound device, otherwise under Win32 DirectX,
  #  you won't be able to set full-screen display modes.
proc videoInit*(driver_name: Cstring, flags: Int32): Int{.cdecl, 
    importc: "SDL_VideoInit", dynlib: LibName.}
proc videoQuit*(){.cdecl, importc: "SDL_VideoQuit", dynlib: LibName.}
  # This function fills the given character buffer with the name of the
  #  video driver, and returns a pointer to it if the video driver has
  #  been initialized.  It returns NULL if no driver has been initialized.
proc videoDriverName*(namebuf: Cstring, maxlen: Int): Cstring{.cdecl, 
    importc: "SDL_VideoDriverName", dynlib: LibName.}
  # This function returns a pointer to the current display surface.
  #  If SDL is doing format conversion on the display surface, this
  #  function returns the publicly visible surface, not the real video
  #  surface.
proc getVideoSurface*(): PSurface{.cdecl, importc: "SDL_GetVideoSurface", 
                                   dynlib: LibName.}
  # This function returns a read-only pointer to information about the
  #  video hardware.  If this is called before SDL_SetVideoMode(), the 'vfmt'
  #  member of the returned structure will contain the pixel format of the
  #  "best" video mode.
proc getVideoInfo*(): PVideoInfo{.cdecl, importc: "SDL_GetVideoInfo", 
                                  dynlib: LibName.}
  # Check to see if a particular video mode is supported.
  #  It returns 0 if the requested mode is not supported under any bit depth,
  #  or returns the bits-per-pixel of the closest available mode with the
  #  given width and height.  If this bits-per-pixel is different from the
  #  one used when setting the video mode, SDL_SetVideoMode() will succeed,
  #  but will emulate the requested bits-per-pixel with a shadow surface.
  #
  #  The arguments to SDL_VideoModeOK() are the same ones you would pass to
  #  SDL_SetVideoMode()
proc videoModeOK*(width, height, bpp: Int, flags: Int32): Int{.cdecl, 
    importc: "SDL_VideoModeOK", importc: "SDL_VideoModeOK", dynlib: LibName.}
  # Return a pointer to an array of available screen dimensions for the
  #  given format and video flags, sorted largest to smallest.  Returns
  #  NULL if there are no dimensions available for a particular format,
  #  or (SDL_Rect **)-1 if any dimension is okay for the given format.
  #
  #  if 'format' is NULL, the mode list will be for the format given
  #  by SDL_GetVideoInfo( ) - > vfmt
proc listModes*(format: PPixelFormat, flags: Int32): PPSDLRect{.cdecl, 
    importc: "SDL_ListModes", dynlib: LibName.}
  # Set up a video mode with the specified width, height and bits-per-pixel.
  #
  #  If 'bpp' is 0, it is treated as the current display bits per pixel.
  #
  #  If SDL_ANYFORMAT is set in 'flags', the SDL library will try to set the
  #  requested bits-per-pixel, but will return whatever video pixel format is
  #  available.  The default is to emulate the requested pixel format if it
  #  is not natively available.
  #
  #  If SDL_HWSURFACE is set in 'flags', the video surface will be placed in
  #  video memory, if possible, and you may have to call SDL_LockSurface()
  #  in order to access the raw framebuffer.  Otherwise, the video surface
  #  will be created in system memory.
  #
  #  If SDL_ASYNCBLIT is set in 'flags', SDL will try to perform rectangle
  #  updates asynchronously, but you must always lock before accessing pixels.
  #  SDL will wait for updates to complete before returning from the lock.
  #
  #  If SDL_HWPALETTE is set in 'flags', the SDL library will guarantee
  #  that the colors set by SDL_SetColors() will be the colors you get.
  #  Otherwise, in 8-bit mode, SDL_SetColors() may not be able to set all
  #  of the colors exactly the way they are requested, and you should look
  #  at the video surface structure to determine the actual palette.
  #  If SDL cannot guarantee that the colors you request can be set,
  #  i.e. if the colormap is shared, then the video surface may be created
  #  under emulation in system memory, overriding the SDL_HWSURFACE flag.
  #
  #  If SDL_FULLSCREEN is set in 'flags', the SDL library will try to set
  #  a fullscreen video mode.  The default is to create a windowed mode
  #  if the current graphics system has a window manager.
  #  If the SDL library is able to set a fullscreen video mode, this flag
  #  will be set in the surface that is returned.
  #
  #  If SDL_DOUBLEBUF is set in 'flags', the SDL library will try to set up
  #  two surfaces in video memory and swap between them when you call
  #  SDL_Flip().  This is usually slower than the normal single-buffering
  #  scheme, but prevents "tearing" artifacts caused by modifying video
  #  memory while the monitor is refreshing.  It should only be used by
  #  applications that redraw the entire screen on every update.
  #
  #  This function returns the video framebuffer surface, or NULL if it fails.
proc setVideoMode*(width, height, bpp: Int, flags: Uint32): PSurface{.cdecl, 
    importc: "SDL_SetVideoMode", dynlib: LibName.}
  # Makes sure the given list of rectangles is updated on the given screen.
  #  If 'x', 'y', 'w' and 'h' are all 0, SDL_UpdateRect will update the entire
  #  screen.
  #  These functions should not be called while 'screen' is locked.
proc updateRects*(screen: PSurface, numrects: Int, rects: PRect){.cdecl, 
    importc: "SDL_UpdateRects", dynlib: LibName.}
proc updateRect*(screen: PSurface, x, y: Int32, w, h: Int32){.cdecl, 
    importc: "SDL_UpdateRect", dynlib: LibName.}
  # On hardware that supports double-buffering, this function sets up a flip
  #  and returns.  The hardware will wait for vertical retrace, and then swap
  #  video buffers before the next video surface blit or lock will return.
  #  On hardware that doesn not support double-buffering, this is equivalent
  #  to calling SDL_UpdateRect(screen, 0, 0, 0, 0);
  #  The SDL_DOUBLEBUF flag must have been passed to SDL_SetVideoMode() when
  #  setting the video mode for this function to perform hardware flipping.
  #  This function returns 0 if successful, or -1 if there was an error.
proc flip*(screen: PSurface): Int{.cdecl, importc: "SDL_Flip", dynlib: LibName.}
  # Set the gamma correction for each of the color channels.
  #  The gamma values range (approximately) between 0.1 and 10.0
  #
  #  If this function isn't supported directly by the hardware, it will
  #  be emulated using gamma ramps, if available.  If successful, this
  #  function returns 0, otherwise it returns -1.
proc setGamma*(redgamma: Float32, greengamma: Float32, bluegamma: Float32): Int{.
    cdecl, importc: "SDL_SetGamma", dynlib: LibName.}
  # Set the gamma translation table for the red, green, and blue channels
  #  of the video hardware.  Each table is an array of 256 16-bit quantities,
  #  representing a mapping between the input and output for that channel.
  #  The input is the index into the array, and the output is the 16-bit
  #  gamma value at that index, scaled to the output color precision.
  #
  #  You may pass NULL for any of the channels to leave it unchanged.
  #  If the call succeeds, it will return 0.  If the display driver or
  #  hardware does not support gamma translation, or otherwise fails,
  #  this function will return -1.
proc setGammaRamp*(redtable: PUInt16, greentable: PUInt16, bluetable: PUInt16): Int{.
    cdecl, importc: "SDL_SetGammaRamp", dynlib: LibName.}
  # Retrieve the current values of the gamma translation tables.
  #
  #  You must pass in valid pointers to arrays of 256 16-bit quantities.
  #  Any of the pointers may be NULL to ignore that channel.
  #  If the call succeeds, it will return 0.  If the display driver or
  #  hardware does not support gamma translation, or otherwise fails,
  #  this function will return -1.
proc getGammaRamp*(redtable: PUInt16, greentable: PUInt16, bluetable: PUInt16): Int{.
    cdecl, importc: "SDL_GetGammaRamp", dynlib: LibName.}
  # Sets a portion of the colormap for the given 8-bit surface.  If 'surface'
  #  is not a palettized surface, this function does nothing, returning 0.
  #  If all of the colors were set as passed to SDL_SetColors(), it will
  #  return 1.  If not all the color entries were set exactly as given,
  #  it will return 0, and you should look at the surface palette to
  #  determine the actual color palette.
  #
  #  When 'surface' is the surface associated with the current display, the
  #  display colormap will be updated with the requested colors.  If
  #  SDL_HWPALETTE was set in SDL_SetVideoMode() flags, SDL_SetColors()
  #  will always return 1, and the palette is guaranteed to be set the way
  #  you desire, even if the window colormap has to be warped or run under
  #  emulation.
proc setColors*(surface: PSurface, colors: PColor, firstcolor: Int, ncolors: Int): Int{.
    cdecl, importc: "SDL_SetColors", dynlib: LibName.}
  # Sets a portion of the colormap for a given 8-bit surface.
  #  'flags' is one or both of:
  #  SDL_LOGPAL  -- set logical palette, which controls how blits are mapped
  #                 to/from the surface,
  #  SDL_PHYSPAL -- set physical palette, which controls how pixels look on
  #                 the screen
  #  Only screens have physical palettes. Separate change of physical/logical
  #  palettes is only possible if the screen has SDL_HWPALETTE set.
  #
  #  The return value is 1 if all colours could be set as requested, and 0
  #  otherwise.
  #
  #  SDL_SetColors() is equivalent to calling this function with
  #  flags = (SDL_LOGPAL or SDL_PHYSPAL).
proc setPalette*(surface: PSurface, flags: Int, colors: PColor, firstcolor: Int, 
                 ncolors: Int): Int{.cdecl, importc: "SDL_SetPalette", 
                                     dynlib: LibName.}
  # Maps an RGB triple to an opaque pixel value for a given pixel format
proc mapRGB*(format: PPixelFormat, r: Byte, g: Byte, b: Byte): Int32{.cdecl, 
    importc: "SDL_MapRGB", dynlib: LibName.}
  # Maps an RGBA quadruple to a pixel value for a given pixel format
proc mapRGBA*(format: PPixelFormat, r: Byte, g: Byte, b: Byte, a: Byte): Int32{.
    cdecl, importc: "SDL_MapRGBA", dynlib: LibName.}
  # Maps a pixel value into the RGB components for a given pixel format
proc getRGB*(pixel: Int32, fmt: PPixelFormat, r: ptr Byte, g: ptr Byte, b: ptr Byte){.
    cdecl, importc: "SDL_GetRGB", dynlib: LibName.}
  # Maps a pixel value into the RGBA components for a given pixel format
proc getRGBA*(pixel: Int32, fmt: PPixelFormat, r: ptr Byte, g: ptr Byte, b: ptr Byte, 
              a: ptr Byte){.cdecl, importc: "SDL_GetRGBA", dynlib: LibName.}
  # Allocate and free an RGB surface (must be called after SDL_SetVideoMode)
  #  If the depth is 4 or 8 bits, an empty palette is allocated for the surface.
  #  If the depth is greater than 8 bits, the pixel format is set using the
  #  flags '[RGB]mask'.
  #  If the function runs out of memory, it will return NULL.
  #
  #  The 'flags' tell what kind of surface to create.
  #  SDL_SWSURFACE means that the surface should be created in system memory.
  #  SDL_HWSURFACE means that the surface should be created in video memory,
  #  with the same format as the display surface.  This is useful for surfaces
  #  that will not change much, to take advantage of hardware acceleration
  #  when being blitted to the display surface.
  #  SDL_ASYNCBLIT means that SDL will try to perform asynchronous blits with
  #  this surface, but you must always lock it before accessing the pixels.
  #  SDL will wait for current blits to finish before returning from the lock.
  #  SDL_SRCCOLORKEY indicates that the surface will be used for colorkey blits.
  #  If the hardware supports acceleration of colorkey blits between
  #  two surfaces in video memory, SDL will try to place the surface in
  #  video memory. If this isn't possible or if there is no hardware
  #  acceleration available, the surface will be placed in system memory.
  #  SDL_SRCALPHA means that the surface will be used for alpha blits and
  #  if the hardware supports hardware acceleration of alpha blits between
  #  two surfaces in video memory, to place the surface in video memory
  #  if possible, otherwise it will be placed in system memory.
  #  If the surface is created in video memory, blits will be _much_ faster,
  #  but the surface format must be identical to the video surface format,
  #  and the only way to access the pixels member of the surface is to use
  #  the SDL_LockSurface() and SDL_UnlockSurface() calls.
  #  If the requested surface actually resides in video memory, SDL_HWSURFACE
  #  will be set in the flags member of the returned surface.  If for some
  #  reason the surface could not be placed in video memory, it will not have
  #  the SDL_HWSURFACE flag set, and will be created in system memory instead.
proc allocSurface*(flags: Int32, width, height, depth: Int, 
                   RMask, GMask, BMask, AMask: Int32): PSurface
proc createRGBSurface*(flags: Int32, width, height, depth: Int, 
                       RMask, GMask, BMask, AMask: Int32): PSurface{.cdecl, 
    importc: "SDL_CreateRGBSurface", dynlib: LibName.}
proc createRGBSurfaceFrom*(pixels: Pointer, width, height, depth, pitch: Int, 
                           RMask, GMask, BMask, AMask: Int32): PSurface{.cdecl, 
    importc: "SDL_CreateRGBSurfaceFrom", dynlib: LibName.}
proc freeSurface*(surface: PSurface){.cdecl, importc: "SDL_FreeSurface", 
                                      dynlib: LibName.}
proc mustLock*(Surface: PSurface): Bool
  # SDL_LockSurface() sets up a surface for directly accessing the pixels.
  #  Between calls to SDL_LockSurface()/SDL_UnlockSurface(), you can write
  #  to and read from 'surface->pixels', using the pixel format stored in
  #  'surface->format'.  Once you are done accessing the surface, you should
  #  use SDL_UnlockSurface() to release it.
  #
  #  Not all surfaces require locking.  If SDL_MUSTLOCK(surface) evaluates
  #  to 0, then you can read and write to the surface at any time, and the
  #  pixel format of the surface will not change.  In particular, if the
  #  SDL_HWSURFACE flag is not given when calling SDL_SetVideoMode(), you
  #  will not need to lock the display surface before accessing it.
  #
  #  No operating system or library calls should be made between lock/unlock
  #  pairs, as critical system locks may be held during this time.
  #
  #  SDL_LockSurface() returns 0, or -1 if the surface couldn't be locked.
proc lockSurface*(surface: PSurface): Int{.cdecl, importc: "SDL_LockSurface", 
    dynlib: LibName.}
proc unlockSurface*(surface: PSurface){.cdecl, importc: "SDL_UnlockSurface", 
                                        dynlib: LibName.}
  # Load a surface from a seekable SDL data source (memory or file.)
  #  If 'freesrc' is non-zero, the source will be closed after being read.
  #  Returns the new surface, or NULL if there was an error.
  #  The new surface should be freed with SDL_FreeSurface().
proc loadBMPRW*(src: PRWops, freesrc: Int): PSurface{.cdecl, 
    importc: "SDL_LoadBMP_RW", dynlib: LibName.}
  # Convenience macro -- load a surface from a file
proc loadBMP*(filename: Cstring): PSurface
  # Save a surface to a seekable SDL data source (memory or file.)
  #  If 'freedst' is non-zero, the source will be closed after being written.
  #  Returns 0 if successful or -1 if there was an error.
proc saveBMPRW*(surface: PSurface, dst: PRWops, freedst: Int): Int{.cdecl, 
    importc: "SDL_SaveBMP_RW", dynlib: LibName.}
  # Convenience macro -- save a surface to a file
proc saveBMP*(surface: PSurface, filename: Cstring): Int
  # Sets the color key (transparent pixel) in a blittable surface.
  #  If 'flag' is SDL_SRCCOLORKEY (optionally OR'd with SDL_RLEACCEL),
  #  'key' will be the transparent pixel in the source image of a blit.
  #  SDL_RLEACCEL requests RLE acceleration for the surface if present,
  #  and removes RLE acceleration if absent.
  #  If 'flag' is 0, this function clears any current color key.
  #  This function returns 0, or -1 if there was an error.
proc setColorKey*(surface: PSurface, flag, key: Int32): Int{.cdecl, 
    importc: "SDL_SetColorKey", dynlib: LibName.}
  # This function sets the alpha value for the entire surface, as opposed to
  #  using the alpha component of each pixel. This value measures the range
  #  of transparency of the surface, 0 being completely transparent to 255
  #  being completely opaque. An 'alpha' value of 255 causes blits to be
  #  opaque, the source pixels copied to the destination (the default). Note
  #  that per-surface alpha can be combined with colorkey transparency.
  #
  #  If 'flag' is 0, alpha blending is disabled for the surface.
  #  If 'flag' is SDL_SRCALPHA, alpha blending is enabled for the surface.
  #  OR:ing the flag with SDL_RLEACCEL requests RLE acceleration for the
  #  surface; if SDL_RLEACCEL is not specified, the RLE accel will be removed.
proc setAlpha*(surface: PSurface, flag: Int32, alpha: Byte): Int{.cdecl, 
    importc: "SDL_SetAlpha", dynlib: LibName.}
  # Sets the clipping rectangle for the destination surface in a blit.
  #
  #  If the clip rectangle is NULL, clipping will be disabled.
  #  If the clip rectangle doesn't intersect the surface, the function will
  #  return SDL_FALSE and blits will be completely clipped.  Otherwise the
  #  function returns SDL_TRUE and blits to the surface will be clipped to
  #  the intersection of the surface area and the clipping rectangle.
  #
  #  Note that blits are automatically clipped to the edges of the source
  #  and destination surfaces.
proc setClipRect*(surface: PSurface, rect: PRect){.cdecl, 
    importc: "SDL_SetClipRect", dynlib: LibName.}
  # Gets the clipping rectangle for the destination surface in a blit.
  #  'rect' must be a pointer to a valid rectangle which will be filled
  #  with the correct values.
proc getClipRect*(surface: PSurface, rect: PRect){.cdecl, 
    importc: "SDL_GetClipRect", dynlib: LibName.}
  # Creates a new surface of the specified format, and then copies and maps
  #  the given surface to it so the blit of the converted surface will be as
  #  fast as possible.  If this function fails, it returns NULL.
  #
  #  The 'flags' parameter is passed to SDL_CreateRGBSurface() and has those
  #  semantics.  You can also pass SDL_RLEACCEL in the flags parameter and
  #  SDL will try to RLE accelerate colorkey and alpha blits in the resulting
  #  surface.
  #
  #  This function is used internally by SDL_DisplayFormat().
proc convertSurface*(src: PSurface, fmt: PPixelFormat, flags: Int32): PSurface{.
    cdecl, importc: "SDL_ConvertSurface", dynlib: LibName.}
  #
  #  This performs a fast blit from the source surface to the destination
  #  surface.  It assumes that the source and destination rectangles are
  #  the same size.  If either 'srcrect' or 'dstrect' are NULL, the entire
  #  surface (src or dst) is copied.  The final blit rectangles are saved
  #  in 'srcrect' and 'dstrect' after all clipping is performed.
  #  If the blit is successful, it returns 0, otherwise it returns -1.
  #
  #  The blit function should not be called on a locked surface.
  #
  #  The blit semantics for surfaces with and without alpha and colorkey
  #  are defined as follows:
  #
  #  RGBA->RGB:
  #      SDL_SRCALPHA set:
  #   alpha-blend (using alpha-channel).
  #   SDL_SRCCOLORKEY ignored.
  #      SDL_SRCALPHA not set:
  #   copy RGB.
  #   if SDL_SRCCOLORKEY set, only copy the pixels matching the
  #   RGB values of the source colour key, ignoring alpha in the
  #   comparison.
  #
  #  RGB->RGBA:
  #      SDL_SRCALPHA set:
  #   alpha-blend (using the source per-surface alpha value);
  #   set destination alpha to opaque.
  #      SDL_SRCALPHA not set:
  #   copy RGB, set destination alpha to opaque.
  #      both:
  #   if SDL_SRCCOLORKEY set, only copy the pixels matching the
  #   source colour key.
  #
  #  RGBA->RGBA:
  #      SDL_SRCALPHA set:
  #   alpha-blend (using the source alpha channel) the RGB values;
  #   leave destination alpha untouched. [Note: is this correct?]
  #   SDL_SRCCOLORKEY ignored.
  #      SDL_SRCALPHA not set:
  #   copy all of RGBA to the destination.
  #   if SDL_SRCCOLORKEY set, only copy the pixels matching the
  #   RGB values of the source colour key, ignoring alpha in the
  #   comparison.
  #
  #  RGB->RGB:
  #      SDL_SRCALPHA set:
  #   alpha-blend (using the source per-surface alpha value).
  #      SDL_SRCALPHA not set:
  #   copy RGB.
  #      both:
  #   if SDL_SRCCOLORKEY set, only copy the pixels matching the
  #   source colour key.
  #
  #  If either of the surfaces were in video memory, and the blit returns -2,
  #  the video memory was lost, so it should be reloaded with artwork and
  #  re-blitted:
  #  while ( SDL_BlitSurface(image, imgrect, screen, dstrect) = -2 ) do
  #  begin
  #  while ( SDL_LockSurface(image) < 0 ) do
  #   Sleep(10);
  #  -- Write image pixels to image->pixels --
  #  SDL_UnlockSurface(image);
  # end;
  #
  #  This happens under DirectX 5.0 when the system switches away from your
  #  fullscreen application.  The lock will also fail until you have access
  #  to the video memory again.
  # You should call SDL_BlitSurface() unless you know exactly how SDL
  #   blitting works internally and how to use the other blit functions.
proc blitSurface*(src: PSurface, srcrect: PRect, dst: PSurface, dstrect: PRect): Int
  #  This is the public blit function, SDL_BlitSurface(), and it performs
  #   rectangle validation and clipping before passing it to SDL_LowerBlit()
proc upperBlit*(src: PSurface, srcrect: PRect, dst: PSurface, dstrect: PRect): Int{.
    cdecl, importc: "SDL_UpperBlit", dynlib: LibName.}
  # This is a semi-private blit function and it performs low-level surface
  #  blitting only.
proc lowerBlit*(src: PSurface, srcrect: PRect, dst: PSurface, dstrect: PRect): Int{.
    cdecl, importc: "SDL_LowerBlit", dynlib: LibName.}
  # This function performs a fast fill of the given rectangle with 'color'
  #  The given rectangle is clipped to the destination surface clip area
  #  and the final fill rectangle is saved in the passed in pointer.
  #  If 'dstrect' is NULL, the whole surface will be filled with 'color'
  #  The color should be a pixel of the format used by the surface, and
  #  can be generated by the SDL_MapRGB() function.
  #  This function returns 0 on success, or -1 on error.
proc fillRect*(dst: PSurface, dstrect: PRect, color: Int32): Int{.cdecl, 
    importc: "SDL_FillRect", dynlib: LibName.}
  # This function takes a surface and copies it to a new surface of the
  #  pixel format and colors of the video framebuffer, suitable for fast
  #  blitting onto the display surface.  It calls SDL_ConvertSurface()
  #
  #  If you want to take advantage of hardware colorkey or alpha blit
  #  acceleration, you should set the colorkey and alpha value before
  #  calling this function.
  #
  #  If the conversion fails or runs out of memory, it returns NULL
proc displayFormat*(surface: PSurface): PSurface{.cdecl, 
    importc: "SDL_DisplayFormat", dynlib: LibName.}
  # This function takes a surface and copies it to a new surface of the
  #  pixel format and colors of the video framebuffer (if possible),
  #  suitable for fast alpha blitting onto the display surface.
  #  The new surface will always have an alpha channel.
  #
  #  If you want to take advantage of hardware colorkey or alpha blit
  #  acceleration, you should set the colorkey and alpha value before
  #  calling this function.
  #
  #  If the conversion fails or runs out of memory, it returns NULL
proc displayFormatAlpha*(surface: PSurface): PSurface{.cdecl, 
    importc: "SDL_DisplayFormatAlpha", dynlib: LibName.}
  #* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  #* YUV video surface overlay functions                                       */
  #* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
  # This function creates a video output overlay
  #  Calling the returned surface an overlay is something of a misnomer because
  #  the contents of the display surface underneath the area where the overlay
  #  is shown is undefined - it may be overwritten with the converted YUV data.
proc createYUVOverlay*(width: Int, height: Int, format: Int32, 
                       display: PSurface): POverlay{.cdecl, 
    importc: "SDL_CreateYUVOverlay", dynlib: LibName.}
  # Lock an overlay for direct access, and unlock it when you are done
proc lockYUVOverlay*(Overlay: POverlay): Int{.cdecl, 
    importc: "SDL_LockYUVOverlay", dynlib: LibName.}
proc unlockYUVOverlay*(Overlay: POverlay){.cdecl, 
    importc: "SDL_UnlockYUVOverlay", dynlib: LibName.}
  # Blit a video overlay to the display surface.
  #  The contents of the video surface underneath the blit destination are
  #  not defined.
  #  The width and height of the destination rectangle may be different from
  #  that of the overlay, but currently only 2x scaling is supported.
proc displayYUVOverlay*(Overlay: POverlay, dstrect: PRect): Int{.cdecl, 
    importc: "SDL_DisplayYUVOverlay", dynlib: LibName.}
  # Free a video overlay
proc freeYUVOverlay*(Overlay: POverlay){.cdecl, importc: "SDL_FreeYUVOverlay", 
    dynlib: LibName.}
  #------------------------------------------------------------------------------
  # OpenGL Routines
  #------------------------------------------------------------------------------
  # Dynamically load a GL driver, if SDL is built with dynamic GL.
  #
  #  SDL links normally with the OpenGL library on your system by default,
  #  but you can compile it to dynamically load the GL driver at runtime.
  #  If you do this, you need to retrieve all of the GL functions used in
  #  your program from the dynamic library using SDL_GL_GetProcAddress().
  #
  #  This is disabled in default builds of SDL.
proc gLLoadLibrary*(filename: Cstring): Int{.cdecl, 
    importc: "SDL_GL_LoadLibrary", dynlib: LibName.}
  # Get the address of a GL function (for extension functions)
proc gLGetProcAddress*(procname: Cstring): Pointer{.cdecl, 
    importc: "SDL_GL_GetProcAddress", dynlib: LibName.}
  # Set an attribute of the OpenGL subsystem before intialization.
proc gLSetAttribute*(attr: TGLAttr, value: Int): Int{.cdecl, 
    importc: "SDL_GL_SetAttribute", dynlib: LibName.}
  # Get an attribute of the OpenGL subsystem from the windowing
  #  interface, such as glX. This is of course different from getting
  #  the values from SDL's internal OpenGL subsystem, which only
  #  stores the values you request before initialization.
  #
  #  Developers should track the values they pass into SDL_GL_SetAttribute
  #  themselves if they want to retrieve these values.
proc gLGetAttribute*(attr: TGLAttr, value: var Int): Int{.cdecl, 
    importc: "SDL_GL_GetAttribute", dynlib: LibName.}
  # Swap the OpenGL buffers, if double-buffering is supported.
proc gLSwapBuffers*(){.cdecl, importc: "SDL_GL_SwapBuffers", dynlib: LibName.}
  # Internal functions that should not be called unless you have read
  #  and understood the source code for these functions.
proc gLUpdateRects*(numrects: Int, rects: PRect){.cdecl, 
    importc: "SDL_GL_UpdateRects", dynlib: LibName.}
proc gLLock*(){.cdecl, importc: "SDL_GL_Lock", dynlib: LibName.}
proc gLUnlock*(){.cdecl, importc: "SDL_GL_Unlock", dynlib: LibName.}
  #* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  #* These functions allow interaction with the window manager, if any.        *
  #* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  # Sets/Gets the title and icon text of the display window
proc wMGetCaption*(title: var Cstring, icon: var Cstring){.cdecl, 
    importc: "SDL_WM_GetCaption", dynlib: LibName.}
proc wMSetCaption*(title: Cstring, icon: Cstring){.cdecl, 
    importc: "SDL_WM_SetCaption", dynlib: LibName.}
  # Sets the icon for the display window.
  #  This function must be called before the first call to SDL_SetVideoMode().
  #  It takes an icon surface, and a mask in MSB format.
  #  If 'mask' is NULL, the entire icon surface will be used as the icon.
proc wMSetIcon*(icon: PSurface, mask: Byte){.cdecl, importc: "SDL_WM_SetIcon", 
    dynlib: LibName.}
  # This function iconifies the window, and returns 1 if it succeeded.
  #  If the function succeeds, it generates an SDL_APPACTIVE loss event.
  #  This function is a noop and returns 0 in non-windowed environments.
proc wMIconifyWindow*(): Int{.cdecl, importc: "SDL_WM_IconifyWindow", 
                               dynlib: LibName.}
  # Toggle fullscreen mode without changing the contents of the screen.
  #  If the display surface does not require locking before accessing
  #  the pixel information, then the memory pointers will not change.
  #
  #  If this function was able to toggle fullscreen mode (change from
  #  running in a window to fullscreen, or vice-versa), it will return 1.
  #  If it is not implemented, or fails, it returns 0.
  #
  #  The next call to SDL_SetVideoMode() will set the mode fullscreen
  #  attribute based on the flags parameter - if SDL_FULLSCREEN is not
  #  set, then the display will be windowed by default where supported.
  #
  #  This is currently only implemented in the X11 video driver.
proc wMToggleFullScreen*(surface: PSurface): Int{.cdecl, 
    importc: "SDL_WM_ToggleFullScreen", dynlib: LibName.}
  # Grabbing means that the mouse is confined to the application window,
  #  and nearly all keyboard input is passed directly to the application,
  #  and not interpreted by a window manager, if any.
proc wMGrabInput*(mode: TGrabMode): TGrabMode{.cdecl, 
    importc: "SDL_WM_GrabInput", dynlib: LibName.}
  #------------------------------------------------------------------------------
  # mouse-routines
  #------------------------------------------------------------------------------
  # Retrieve the current state of the mouse.
  #  The current button state is returned as a button bitmask, which can
  #  be tested using the SDL_BUTTON(X) macros, and x and y are set to the
  #  current mouse cursor position.  You can pass NULL for either x or y.
proc getMouseState*(x: var Int, y: var Int): Byte{.cdecl, 
    importc: "SDL_GetMouseState", dynlib: LibName.}
  # Retrieve the current state of the mouse.
  #  The current button state is returned as a button bitmask, which can
  #  be tested using the SDL_BUTTON(X) macros, and x and y are set to the
  #  mouse deltas since the last call to SDL_GetRelativeMouseState().
proc getRelativeMouseState*(x: var Int, y: var Int): Byte{.cdecl, 
    importc: "SDL_GetRelativeMouseState", dynlib: LibName.}
  # Set the position of the mouse cursor (generates a mouse motion event)
proc warpMouse*(x, y: Uint16){.cdecl, importc: "SDL_WarpMouse", dynlib: LibName.}
  # Create a cursor using the specified data and mask (in MSB format).
  #  The cursor width must be a multiple of 8 bits.
  #
  #  The cursor is created in black and white according to the following:
  #  data  mask    resulting pixel on screen
  #   0     1       White
  #   1     1       Black
  #   0     0       Transparent
  #   1     0       Inverted color if possible, black if not.
  #
  #  Cursors created with this function must be freed with SDL_FreeCursor().
proc createCursor*(data, mask: ptr Byte, w, h, hot_x, hot_y: Int): PCursor{.cdecl, 
    importc: "SDL_CreateCursor", dynlib: LibName.}
  # Set the currently active cursor to the specified one.
  #  If the cursor is currently visible, the change will be immediately
  #  represented on the display.
proc setCursor*(cursor: PCursor){.cdecl, importc: "SDL_SetCursor", 
                                  dynlib: LibName.}
  # Returns the currently active cursor.
proc getCursor*(): PCursor{.cdecl, importc: "SDL_GetCursor", dynlib: LibName.}
  # Deallocates a cursor created with SDL_CreateCursor().
proc freeCursor*(cursor: PCursor){.cdecl, importc: "SDL_FreeCursor", 
                                   dynlib: LibName.}
  # Toggle whether or not the cursor is shown on the screen.
  #  The cursor start off displayed, but can be turned off.
  #  SDL_ShowCursor() returns 1 if the cursor was being displayed
  #  before the call, or 0 if it was not.  You can query the current
  #  state by passing a 'toggle' value of -1.
proc showCursor*(toggle: Int): Int{.cdecl, importc: "SDL_ShowCursor", 
                                    dynlib: LibName.}
proc button*(Button: Int): Int
  #------------------------------------------------------------------------------
  # Keyboard-routines
  #------------------------------------------------------------------------------
  # Enable/Disable UNICODE translation of keyboard input.
  #  This translation has some overhead, so translation defaults off.
  #  If 'enable' is 1, translation is enabled.
  #  If 'enable' is 0, translation is disabled.
  #  If 'enable' is -1, the translation state is not changed.
  #  It returns the previous state of keyboard translation.
proc enableUNICODE*(enable: Int): Int{.cdecl, importc: "SDL_EnableUNICODE", 
                                       dynlib: LibName.}
  # If 'delay' is set to 0, keyboard repeat is disabled.
proc enableKeyRepeat*(delay: Int, interval: Int): Int{.cdecl, 
    importc: "SDL_EnableKeyRepeat", dynlib: LibName.}
proc getKeyRepeat*(delay: PInteger, interval: PInteger){.cdecl, 
    importc: "SDL_GetKeyRepeat", dynlib: LibName.}
  # Get a snapshot of the current state of the keyboard.
  #  Returns an array of keystates, indexed by the SDLK_* syms.
  #  Used:
  #
  #  byte *keystate = SDL_GetKeyState(NULL);
  #  if ( keystate[SDLK_RETURN] ) ... <RETURN> is pressed
proc getKeyState*(numkeys: Pointer): ptr Byte{.cdecl, importc: "SDL_GetKeyState", 
    dynlib: LibName.}
  # Get the current key modifier state
proc getModState*(): TMod{.cdecl, importc: "SDL_GetModState", dynlib: LibName.}
  # Set the current key modifier state
  #  This does not change the keyboard state, only the key modifier flags.
proc setModState*(modstate: TMod){.cdecl, importc: "SDL_SetModState", 
                                   dynlib: LibName.}
  # Get the name of an SDL virtual keysym
proc getKeyName*(key: TKey): Cstring{.cdecl, importc: "SDL_GetKeyName", 
                                      dynlib: LibName.}
  #------------------------------------------------------------------------------
  # Active Routines
  #------------------------------------------------------------------------------
  # This function returns the current state of the application, which is a
  #  bitwise combination of SDL_APPMOUSEFOCUS, SDL_APPINPUTFOCUS, and
  #  SDL_APPACTIVE.  If SDL_APPACTIVE is set, then the user is able to
  #  see your application, otherwise it has been iconified or disabled.
proc getAppState*(): Byte{.cdecl, importc: "SDL_GetAppState", dynlib: LibName.}
  # Mutex functions
  # Create a mutex, initialized unlocked
proc createMutex*(): PMutex{.cdecl, importc: "SDL_CreateMutex", dynlib: LibName.}
  # Lock the mutex  (Returns 0, or -1 on error)
proc mutexP*(mutex: PMutex): Int{.cdecl, importc: "SDL_mutexP", dynlib: LibName.}
proc lockMutex*(mutex: PMutex): Int
  # Unlock the mutex  (Returns 0, or -1 on error)
proc mutexV*(mutex: PMutex): Int{.cdecl, importc: "SDL_mutexV", dynlib: LibName.}
proc unlockMutex*(mutex: PMutex): Int
  # Destroy a mutex
proc destroyMutex*(mutex: PMutex){.cdecl, importc: "SDL_DestroyMutex", 
                                   dynlib: LibName.}
  # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  # Semaphore functions
  # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  # Create a semaphore, initialized with value, returns NULL on failure.
proc createSemaphore*(initial_value: Int32): PSem{.cdecl, 
    importc: "SDL_CreateSemaphore", dynlib: LibName.}
  # Destroy a semaphore
proc destroySemaphore*(sem: PSem){.cdecl, importc: "SDL_DestroySemaphore", 
                                   dynlib: LibName.}
  # This function suspends the calling thread until the semaphore pointed
  #  to by sem has a positive count. It then atomically decreases the semaphore
  #  count.
proc semWait*(sem: PSem): Int{.cdecl, importc: "SDL_SemWait", dynlib: LibName.}
  # Non-blocking variant of SDL_SemWait(), returns 0 if the wait succeeds,
  #   SDL_MUTEX_TIMEDOUT if the wait would block, and -1 on error.
proc semTryWait*(sem: PSem): Int{.cdecl, importc: "SDL_SemTryWait", 
                                  dynlib: LibName.}
  # Variant of SDL_SemWait() with a timeout in milliseconds, returns 0 if
  #   the wait succeeds, SDL_MUTEX_TIMEDOUT if the wait does not succeed in
  #   the allotted time, and -1 on error.
  #   On some platforms this function is implemented by looping with a delay
  #   of 1 ms, and so should be avoided if possible.
proc semWaitTimeout*(sem: PSem, ms: Int32): Int{.cdecl, 
    importc: "SDL_SemWaitTimeout", dynlib: LibName.}
  # Atomically increases the semaphore's count (not blocking), returns 0,
  #   or -1 on error.
proc semPost*(sem: PSem): Int{.cdecl, importc: "SDL_SemPost", dynlib: LibName.}
  # Returns the current count of the semaphore
proc semValue*(sem: PSem): Int32{.cdecl, importc: "SDL_SemValue", 
                                   dynlib: LibName.}
  # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  # Condition variable functions
  # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  # Create a condition variable
proc createCond*(): PCond{.cdecl, importc: "SDL_CreateCond", dynlib: LibName.}
  # Destroy a condition variable
proc destroyCond*(cond: PCond){.cdecl, importc: "SDL_DestroyCond", 
                                dynlib: LibName.}
  # Restart one of the threads that are waiting on the condition variable,
  #   returns 0 or -1 on error.
proc condSignal*(cond: PCond): Int{.cdecl, importc: "SDL_CondSignal", 
                                    dynlib: LibName.}
  # Restart all threads that are waiting on the condition variable,
  #  returns 0 or -1 on error.
proc condBroadcast*(cond: PCond): Int{.cdecl, importc: "SDL_CondBroadcast", 
                                       dynlib: LibName.}
  # Wait on the condition variable, unlocking the provided mutex.
  #  The mutex must be locked before entering this function!
  #  Returns 0 when it is signaled, or -1 on error.
proc condWait*(cond: PCond, mut: PMutex): Int{.cdecl, importc: "SDL_CondWait", 
    dynlib: LibName.}
  # Waits for at most 'ms' milliseconds, and returns 0 if the condition
  #  variable is signaled, SDL_MUTEX_TIMEDOUT if the condition is not
  #  signaled in the allotted time, and -1 on error.
  #  On some platforms this function is implemented by looping with a delay
  #  of 1 ms, and so should be avoided if possible.
proc condWaitTimeout*(cond: PCond, mut: PMutex, ms: Int32): Int{.cdecl, 
    importc: "SDL_CondWaitTimeout", dynlib: LibName.}
  # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  # Condition variable functions
  # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  # Create a thread
proc createThread*(fn, data: Pointer): PThread{.cdecl, 
    importc: "SDL_CreateThread", dynlib: LibName.}
  # Get the 32-bit thread identifier for the current thread
proc threadID*(): Int32{.cdecl, importc: "SDL_ThreadID", dynlib: LibName.}
  # Get the 32-bit thread identifier for the specified thread,
  #  equivalent to SDL_ThreadID() if the specified thread is NULL.
proc getThreadID*(thread: PThread): Int32{.cdecl, importc: "SDL_GetThreadID", 
    dynlib: LibName.}
  # Wait for a thread to finish.
  #  The return code for the thread function is placed in the area
  #  pointed to by 'status', if 'status' is not NULL.
proc waitThread*(thread: PThread, status: var Int){.cdecl, 
    importc: "SDL_WaitThread", dynlib: LibName.}
  # Forcefully kill a thread without worrying about its state
proc killThread*(thread: PThread){.cdecl, importc: "SDL_KillThread", 
                                   dynlib: LibName.}
  #------------------------------------------------------------------------------
  # Get Environment Routines
  #------------------------------------------------------------------------------
  #*
  # * This function gives you custom hooks into the window manager information.
  # * It fills the structure pointed to by 'info' with custom information and
  # * returns 1 if the function is implemented.  If it's not implemented, or
  # * the version member of the 'info' structure is invalid, it returns 0.
  # *
proc getWMInfo*(info: PSysWMinfo): Int{.cdecl, importc: "SDL_GetWMInfo", 
                                        dynlib: LibName.}
  #------------------------------------------------------------------------------
  #SDL_loadso.h
  #* This function dynamically loads a shared object and returns a pointer
  # * to the object handle (or NULL if there was an error).
  # * The 'sofile' parameter is a system dependent name of the object file.
  # *
proc loadObject*(sofile: Cstring): Pointer{.cdecl, importc: "SDL_LoadObject", 
    dynlib: LibName.}
  #* Given an object handle, this function looks up the address of the
  # * named function in the shared object and returns it.  This address
  # * is no longer valid after calling SDL_UnloadObject().
  # *
proc loadFunction*(handle: Pointer, name: Cstring): Pointer{.cdecl, 
    importc: "SDL_LoadFunction", dynlib: LibName.}
  #* Unload a shared object from memory *
proc unloadObject*(handle: Pointer){.cdecl, importc: "SDL_UnloadObject", 
                                     dynlib: LibName.}
  #------------------------------------------------------------------------------
proc swap32*(D: Int32): Int32
  # Bitwise Checking functions
proc isBitOn*(value: Int, bit: Int8): Bool
proc turnBitOn*(value: Int, bit: Int8): Int
proc turnBitOff*(value: Int, bit: Int8): Int
# implementation

proc tableSize(table: cstring): int = 
  Result = SizeOf(table) div SizeOf(table[0])

proc outOfMemory() = 
  when not (defined(WINDOWS)): error(Enomem)
  
proc rWSeek(context: PRWops, offset: int, whence: int): int = 
  Result = context.seek(context, offset, whence)

proc rWTell(context: PRWops): int = 
  Result = context.seek(context, 0, 1)

proc rWRead(context: PRWops, theptr: Pointer, size: int, n: int): int = 
  Result = context.read(context, theptr, size, n)

proc rWWrite(context: PRWops, theptr: Pointer, size: int, n: int): int = 
  Result = context.write(context, theptr, size, n)

proc rWClose(context: PRWops): int = 
  Result = context.closeFile(context)

proc loadWAV(filename: cstring, spec: PAudioSpec, audio_buf: ptr byte, 
             audiolen: PUInt32): PAudioSpec = 
  Result = loadWAVRW(rWFromFile(filename, "rb"), 1, spec, audioBuf, audiolen)

proc cDInDrive(status: TCDStatus): bool = 
  Result = ord(status) > ord(CD_ERROR)

proc framesToMsf(frames: int, M: var int, S: var int, F: var int) = 
  var value: Int
  value = frames
  f = value mod CD_FPS
  value = value div CD_FPS
  s = value mod 60
  value = value div 60
  m = value

proc msfToFrames(M: int, S: int, F: int): int = 
  Result = m * 60 * CD_FPS + s * CD_FPS + f

proc version(X: var TVersion) = 
  x.major = MAJOR_VERSION
  x.minor = MINOR_VERSION
  x.patch = PATCHLEVEL

proc versionnum(X, Y, Z: int): int = 
  Result = x * 1000 + y * 100 + z

proc compiledversion(): int = 
  Result = versionnum(MAJOR_VERSION, MINOR_VERSION, PATCHLEVEL)

proc versionAtleast(X, Y, Z: int): bool = 
  Result = (compiledversion() >= versionnum(x, y, z))

proc loadBMP(filename: cstring): PSurface = 
  Result = loadBMPRW(rWFromFile(filename, "rb"), 1)

proc saveBMP(surface: PSurface, filename: cstring): int = 
  Result = saveBMPRW(surface, rWFromFile(filename, "wb"), 1)

proc blitSurface(src: PSurface, srcrect: PRect, dst: PSurface, dstrect: PRect): int = 
  Result = upperBlit(src, srcrect, dst, dstrect)

proc allocSurface(flags: int32, width, height, depth: int, 
                  RMask, GMask, BMask, AMask: int32): PSurface = 
  Result = createRGBSurface(flags, width, height, depth, rMask, gMask, bMask, 
                            aMask)

proc mustLock(Surface: PSurface): bool = 
  Result = ((surface[].offset != 0) or
      ((surface[].flags and (HWSURFACE or ASYNCBLIT or RLEACCEL)) != 0))

proc lockMutex(mutex: Pmutex): int = 
  Result = mutexP(mutex)

proc unlockMutex(mutex: Pmutex): int = 
  Result = mutexV(mutex)

proc button(Button: int): int = 
  Result = PRESSED shl (button - 1)

proc swap32(D: int32): int32 = 
  Result = ((d shl 24) or ((d shl 8) and 0x00FF0000) or
      ((d shr 8) and 0x0000FF00) or (d shr 24))

proc isBitOn(value: int, bit: int8): bool = 
  result = ((value and (1 shl ze(bit))) != 0)

proc turnBitOn(value: int, bit: int8): int = 
  result = (value or (1 shl ze(bit)))

proc turnBitOff(value: int, bit: int8): int = 
  result = (value and not (1 shl ze(bit)))
