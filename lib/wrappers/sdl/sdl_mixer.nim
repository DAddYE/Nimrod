#******************************************************************************
#
#  $Id: sdl_mixer.pas,v 1.18 2007/05/29 21:31:44 savage Exp $
#
#
#
#       Borland Delphi SDL_Mixer - Simple DirectMedia Layer Mixer Library
#       Conversion of the Simple DirectMedia Layer Headers
#
# Portions created by Sam Lantinga <slouken@devolution.com> are
# Copyright (C) 1997, 1998, 1999, 2000, 2001  Sam Lantinga
# 5635-34 Springhouse Dr.
# Pleasanton, CA 94588 (USA)
#
# All Rights Reserved.
#
# The original files are : SDL_mixer.h
#                          music_cmd.h
#                          wavestream.h
#                          timidity.h
#                          playmidi.h
#                          music_ogg.h
#                          mikmod.h
#
# The initial developer of this Pascal code was :
# Dominqiue Louis <Dominique@SavageSoftware.com.au>
#
# Portions created by Dominqiue Louis are
# Copyright (C) 2000 - 2001 Dominqiue Louis.
#
#
# Contributor(s)
# --------------
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
#   SDL.pas & SMPEG.pas somewhere within your search path.
#
# Programming Notes
# -----------------
#   See the Aliens Demo to see how this library is used
#
# Revision History
# ----------------
#   April    02 2001 - DL : Initial Translation
#
#  February  02 2002 - DL : Update to version 1.2.1
#
#   April   03 2003 - DL : Added jedi-sdl.inc include file to support more
#                          Pascal compilers. Initial support is now included
#                          for GnuPascal, VirtualPascal, TMT and obviously
#                          continue support for Delphi Kylix and FreePascal.
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
#  $Log: sdl_mixer.pas,v $
#  Revision 1.18  2007/05/29 21:31:44  savage
#  Changes as suggested by Almindor for 64bit compatibility.
#
#  Revision 1.17  2007/05/20 20:31:17  savage
#  Initial Changes to Handle 64 Bits
#
#  Revision 1.16  2006/12/02 00:16:17  savage
#  Updated to latest version
#
#  Revision 1.15  2005/04/10 11:48:33  savage
#  Changes as suggested by Michalis, thanks.
#
#  Revision 1.14  2005/02/24 20:20:07  savage
#  Changed definition of MusicType and added GetMusicType function
#
#  Revision 1.13  2005/01/05 01:47:09  savage
#  Changed LibName to reflect what MacOS X should have. ie libSDL*-1.2.0.dylib respectively.
#
#  Revision 1.12  2005/01/04 23:14:56  savage
#  Changed LibName to reflect what most Linux distros will have. ie libSDL*-1.2.so.0 respectively.
#
#  Revision 1.11  2005/01/01 02:05:19  savage
#  Updated to v1.2.6
#
#  Revision 1.10  2004/09/12 21:45:17  savage
#  Robert Reed spotted that Mix_SetMusicPosition was missing from the conversion, so this has now been added.
#
#  Revision 1.9  2004/08/27 21:48:24  savage
#  IFDEFed out Smpeg support on MacOS X
#
#  Revision 1.8  2004/08/14 22:54:30  savage
#  Updated so that Library name defines are correctly defined for MacOS X.
#
#  Revision 1.7  2004/05/10 14:10:04  savage
#  Initial MacOS X support. Fixed defines for MACOS ( Classic ) and DARWIN ( MacOS X ).
#
#  Revision 1.6  2004/04/13 09:32:08  savage
#  Changed Shared object names back to just the .so extension to avoid conflicts on various Linux/Unix distros. Therefore developers will need to create Symbolic links to the actual Share Objects if necessary.
#
#  Revision 1.5  2004/04/01 20:53:23  savage
#  Changed Linux Shared Object names so they reflect the Symbolic Links that are created when installing the RPMs from the SDL site.
#
#  Revision 1.4  2004/03/31 22:20:02  savage
#  Windows unit not used in this file, so it was removed to keep the code tidy.
#
#  Revision 1.3  2004/03/31 10:05:08  savage
#  Better defines for Endianess under FreePascal and Borland compilers.
#
#  Revision 1.2  2004/03/30 20:23:28  savage
#  Tidied up use of UNIX compiler directive.
#
#  Revision 1.1  2004/02/14 23:35:42  savage
#  version 1 of sdl_image, sdl_mixer and smpeg.
#
#
#
#******************************************************************************

import 
  sdl, smpeg

when defined(windows): 
  const 
    MixerLibName = "SDL_mixer.dll"
elif defined(macosx): 
  const 
    MixerLibName = "libSDL_mixer-1.2.0.dylib"
else: 
  const 
    MixerLibName = "libSDL_mixer.so"
const 
  MajorVersion* = 1
  MinorVersion* = 2
  Patchlevel* = 7    # Backwards compatibility
  
  Channels* = 8           # Good default values for a PC soundcard
  DefaultFrequency* = 22050

when defined(IA32): 
  const 
    DEFAULT_FORMAT* = AUDIO_S16LSB
else: 
  const 
    DefaultFormat* = AUDIO_S16MSB
const 
  DefaultChannels* = 2
  MaxVolume* = 128       # Volume of a chunk
  PathMax* = 255             # mikmod.h constants
                              #*
                              #  * Library version
                              #  *
  LibmikmodVersionMajor* = 3
  LibmikmodVersionMinor* = 1
  LibmikmodRevision* = 8
  LibmikmodVersion* = ((LIBMIKMOD_VERSION_MAJOR shl 16) or
      (LIBMIKMOD_VERSION_MINOR shl 8) or (LIBMIKMOD_REVISION))

type                          #music_cmd.h types
  PMusicCMD* = ptr TMusicCMD
  TMusicCMD*{.final.} = object  #wavestream.h types
    filename*: Array[0..PATH_MAX - 1, Char]
    cmd*: Array[0..PATH_MAX - 1, Char]
    pid*: TSYS_ThreadHandle

  PWAVStream* = ptr TWAVStream
  TWAVStream*{.final.} = object  #playmidi.h types
    wavefp*: Pointer
    start*: Int32
    stop*: Int32
    cvt*: TAudioCVT

  PMidiEvent* = ptr TMidiEvent
  TMidiEvent*{.final.} = object 
    time*: Int32
    channel*: Byte
    typ*: Byte
    a*: Byte
    b*: Byte

  PMidiSong* = ptr TMidiSong
  TMidiSong*{.final.} = object  #music_ogg.h types
    samples*: Int32
    events*: PMidiEvent

  POGGMusic* = ptr TOGG_Music
  TOGG_Music*{.final.} = object  # mikmod.h types
                                 #*
                                 #  * Error codes
                                 #  *
    playing*: Int32
    volume*: Int32              #vf: OggVorbis_File;
    section*: Int32
    cvt*: TAudioCVT
    len_available*: Int32
    snd_available*: Pointer

  TErrorEnum* = enum 
    MMERR_OPENING_FILE, MMERR_OUT_OF_MEMORY, MMERR_DYNAMIC_LINKING, 
    MMERR_SAMPLE_TOO_BIG, MMERR_OUT_OF_HANDLES, MMERR_UNKNOWN_WAVE_TYPE, 
    MMERR_LOADING_PATTERN, MMERR_LOADING_TRACK, MMERR_LOADING_HEADER, 
    MMERR_LOADING_SAMPLEINFO, MMERR_NOT_A_MODULE, MMERR_NOT_A_STREAM, 
    MMERR_MED_SYNTHSAMPLES, MMERR_ITPACK_INVALID_DATA, MMERR_DETECTING_DEVICE, 
    MMERR_INVALID_DEVICE, MMERR_INITIALIZING_MIXER, MMERR_OPENING_AUDIO, 
    MMERR_8BIT_ONLY, MMERR_16BIT_ONLY, MMERR_STEREO_ONLY, MMERR_ULAW, 
    MMERR_NON_BLOCK, MMERR_AF_AUDIO_PORT, MMERR_AIX_CONFIG_INIT, 
    MMERR_AIX_CONFIG_CONTROL, MMERR_AIX_CONFIG_START, MMERR_GUS_SETTINGS, 
    MMERR_GUS_RESET, MMERR_GUS_TIMER, MMERR_HP_SETSAMPLESIZE, MMERR_HP_SETSPEED, 
    MMERR_HP_CHANNELS, MMERR_HP_AUDIO_OUTPUT, MMERR_HP_AUDIO_DESC, 
    MMERR_HP_BUFFERSIZE, MMERR_OSS_SETFRAGMENT, MMERR_OSS_SETSAMPLESIZE, 
    MMERR_OSS_SETSTEREO, MMERR_OSS_SETSPEED, MMERR_SGI_SPEED, MMERR_SGI_16BIT, 
    MMERR_SGI_8BIT, MMERR_SGI_STEREO, MMERR_SGI_MONO, MMERR_SUN_INIT, 
    MMERR_OS2_MIXSETUP, MMERR_OS2_SEMAPHORE, MMERR_OS2_TIMER, MMERR_OS2_THREAD, 
    MMERR_DS_PRIORITY, MMERR_DS_BUFFER, MMERR_DS_FORMAT, MMERR_DS_NOTIFY, 
    MMERR_DS_EVENT, MMERR_DS_THREAD, MMERR_DS_UPDATE, MMERR_WINMM_HANDLE, 
    MMERR_WINMM_ALLOCATED, MMERR_WINMM_DEVICEID, MMERR_WINMM_FORMAT, 
    MMERR_WINMM_UNKNOWN, MMERR_MAC_SPEED, MMERR_MAC_START, MMERR_MAX
  Pmodule* = ptr TMODULE
  TMODULE*{.final.} = object 
  Punimod* = ptr TUNIMOD
  TUNIMOD* = TMODULE          #SDL_mixer.h types
                              # The internal format for an audio chunk
  PChunk* = ptr TChunk
  TChunk*{.final.} = object 
    allocated*: Cint
    abuf*: Pointer
    alen*: Uint32
    volume*: Byte            # Per-sample volume, 0-128
  
  TFading* = enum 
    MIX_NO_FADING, MIX_FADING_OUT, MIX_FADING_IN
  TMusicType* = enum 
    MUS_NONE, MUS_CMD, MUS_WAV, MUS_MOD, MUS_MID, MUS_OGG, MUS_MP3
  PMusic* = ptr TMusic
  TMusic*{.final.} = object  # The internal format for a music chunk interpreted via mikmod
    mixtype*: TMusicType      # other fields are not aviable
                              #    data : TMusicUnion;
                              #    fading : TMix_Fading;
                              #    fade_volume : integer;
                              #    fade_step : integer;
                              #    fade_steps : integer;
                              #    error : integer;
  
  TMixFunction* = proc (udata, stream: Pointer, length: Cint): Pointer{.
      cdecl.} # This macro can be used to fill a version structure with the compile-time
              #  version of the SDL_mixer library.

proc version*(X: var sdl.TVersion)
  # This function gets the version of the dynamically linked SDL_mixer library.
  #     It should NOT be used to fill a version structure, instead you should use the
  #     SDL_MIXER_VERSION() macro.
proc linkedVersion*(): sdl.Pversion{.cdecl, importc: "Mix_Linked_Version", 
                                      dynlib: MixerLibName.}
  # Open the mixer with a certain audio format
proc openAudio*(frequency: Cint, format: Uint16, channels: Cint, 
                    chunksize: Cint): Cint{.cdecl, importc: "Mix_OpenAudio", 
    dynlib: MixerLibName.}
  # Dynamically change the number of channels managed by the mixer.
  #   If decreasing the number of channels, the upper channels are
  #   stopped.
  #   This function returns the new number of allocated channels.
  #
proc allocateChannels*(numchannels: Cint): Cint{.cdecl, 
    importc: "Mix_AllocateChannels", dynlib: MixerLibName.}
  # Find out what the actual audio device parameters are.
  #   This function returns 1 if the audio has been opened, 0 otherwise.
  #
proc querySpec*(frequency: var Cint, format: var Uint16, channels: var Cint): Cint{.
    cdecl, importc: "Mix_QuerySpec", dynlib: MixerLibName.}
  # Load a wave file or a music (.mod .s3m .it .xm) file
proc loadWAVRW*(src: PRWops, freesrc: Cint): PChunk{.cdecl, 
    importc: "Mix_LoadWAV_RW", dynlib: MixerLibName.}
proc loadWAV*(filename: Cstring): PChunk
proc loadMUS*(filename: Cstring): PMusic{.cdecl, importc: "Mix_LoadMUS", 
    dynlib: MixerLibName.}
  # Load a wave file of the mixer format from a memory buffer
proc quickLoadWAV*(mem: Pointer): PChunk{.cdecl, 
    importc: "Mix_QuickLoad_WAV", dynlib: MixerLibName.}
  # Free an audio chunk previously loaded
proc freeChunk*(chunk: PChunk){.cdecl, importc: "Mix_FreeChunk", 
                                        dynlib: MixerLibName.}
proc freeMusic*(music: PMusic){.cdecl, importc: "Mix_FreeMusic", 
                                        dynlib: MixerLibName.}
  # Find out the music format of a mixer music, or the currently playing
  #   music, if 'music' is NULL.
proc getMusicType*(music: PMusic): TMusicType{.cdecl, 
    importc: "Mix_GetMusicType", dynlib: MixerLibName.}
  # Set a function that is called after all mixing is performed.
  #   This can be used to provide real-time visual display of the audio stream
  #   or add a custom mixer filter for the stream data.
  #
proc setPostMix*(mix_func: TMixFunction, arg: Pointer){.cdecl, 
    importc: "Mix_SetPostMix", dynlib: MixerLibName.}
  # Add your own music player or additional mixer function.
  #   If 'mix_func' is NULL, the default music player is re-enabled.
  #
proc hookMusic*(mix_func: TMixFunction, arg: Pointer){.cdecl, 
    importc: "Mix_HookMusic", dynlib: MixerLibName.}
  # Add your own callback when the music has finished playing.
  #
proc hookMusicFinished*(music_finished: Pointer){.cdecl, 
    importc: "Mix_HookMusicFinished", dynlib: MixerLibName.}
  # Get a pointer to the user data for the current music hook
proc getMusicHookData*(): Pointer{.cdecl, importc: "Mix_GetMusicHookData", 
                                       dynlib: MixerLibName.}
  #* Add your own callback when a channel has finished playing. NULL
  # * to disable callback.*
type 
  TChannel_finished* = proc (channel: Cint){.cdecl.}

proc channelFinished*(channel_finished: TChannel_finished){.cdecl, 
    importc: "Mix_ChannelFinished", dynlib: MixerLibName.}
const 
  ChannelPost* = - 2     

type 
  TEffectFunc* = proc (chan: Cint, stream: Pointer, length: Cint, 
                       udata: Pointer): Pointer{.cdecl.}     
  TEffectDone* = proc (chan: Cint, udata: Pointer): Pointer{.cdecl.} 
proc registerEffect*(chan: Cint, f: TEffectFunc, d: TEffectDone, 
                         arg: Pointer): Cint{.cdecl, 
    importc: "Mix_RegisterEffect", dynlib: MixerLibName.}

proc unregisterEffect*(channel: Cint, f: TEffectFunc): Cint{.cdecl, 
    importc: "Mix_UnregisterEffect", dynlib: MixerLibName.}

proc unregisterAllEffects*(channel: Cint): Cint{.cdecl, 
    importc: "Mix_UnregisterAllEffects", dynlib: MixerLibName.}
const 
  Effectsmaxspeed* = "MIX_EFFECTSMAXSPEED"
  
proc setPanning*(channel: Cint, left: Byte, right: Byte): Cint{.cdecl, 
    importc: "Mix_SetPanning", dynlib: MixerLibName.}

proc setPosition*(channel: Cint, angle: Int16, distance: Byte): Cint{.cdecl, 
    importc: "Mix_SetPosition", dynlib: MixerLibName.}

proc setDistance*(channel: Cint, distance: Byte): Cint{.cdecl, 
    importc: "Mix_SetDistance", dynlib: MixerLibName.}

proc setReverseStereo*(channel: Cint, flip: Cint): Cint{.cdecl, 
    importc: "Mix_SetReverseStereo", dynlib: MixerLibName.}

proc reserveChannels*(num: Cint): Cint{.cdecl, importc: "Mix_ReserveChannels", 
    dynlib: MixerLibName.}

proc groupChannel*(which: Cint, tag: Cint): Cint{.cdecl, 
    importc: "Mix_GroupChannel", dynlib: MixerLibName.}
proc groupChannels*(`from`: Cint, `to`: Cint, tag: Cint): Cint{.cdecl, 
    importc: "Mix_GroupChannels", dynlib: MixerLibName.}
proc groupAvailable*(tag: Cint): Cint{.cdecl, importc: "Mix_GroupAvailable", 
    dynlib: MixerLibName.}
proc groupCount*(tag: Cint): Cint{.cdecl, importc: "Mix_GroupCount", 
                                     dynlib: MixerLibName.}
proc groupOldest*(tag: Cint): Cint{.cdecl, importc: "Mix_GroupOldest", 
                                      dynlib: MixerLibName.}
proc groupNewer*(tag: Cint): Cint{.cdecl, importc: "Mix_GroupNewer", 
                                     dynlib: MixerLibName.}
proc playChannelTimed*(channel: Cint, chunk: PChunk, loops: Cint, 
                           ticks: Cint): Cint{.cdecl, 
    importc: "Mix_PlayChannelTimed", dynlib: MixerLibName.}
proc playChannel*(channel: Cint, chunk: PChunk, loops: Cint): Cint
proc playMusic*(music: PMusic, loops: Cint): Cint{.cdecl, 
    importc: "Mix_PlayMusic", dynlib: MixerLibName.}
proc fadeInMusic*(music: PMusic, loops: Cint, ms: Cint): Cint{.cdecl, 
    importc: "Mix_FadeInMusic", dynlib: MixerLibName.}
proc fadeInChannelTimed*(channel: Cint, chunk: PChunk, loops: Cint, 
                             ms: Cint, ticks: Cint): Cint{.cdecl, 
    importc: "Mix_FadeInChannelTimed", dynlib: MixerLibName.}
proc fadeInChannel*(channel: Cint, chunk: PChunk, loops: Cint, ms: Cint): Cint

proc volume*(channel: Cint, volume: Cint): Cint{.cdecl, importc: "Mix_Volume", 
    dynlib: MixerLibName.}
proc volumeChunk*(chunk: PChunk, volume: Cint): Cint{.cdecl, 
    importc: "Mix_VolumeChunk", dynlib: MixerLibName.}
proc volumeMusic*(volume: Cint): Cint{.cdecl, importc: "Mix_VolumeMusic", 
    dynlib: MixerLibName.}

proc haltChannel*(channel: Cint): Cint{.cdecl, importc: "Mix_HaltChannel", 
    dynlib: MixerLibName.}
proc haltGroup*(tag: Cint): Cint{.cdecl, importc: "Mix_HaltGroup", 
                                    dynlib: MixerLibName.}
proc haltMusic*(): Cint{.cdecl, importc: "Mix_HaltMusic", 
                            dynlib: MixerLibName.}
  # Change the expiration delay for a particular channel.
  #   The sample will stop playing after the 'ticks' milliseconds have elapsed,
  #   or remove the expiration if 'ticks' is -1
  #
proc expireChannel*(channel: Cint, ticks: Cint): Cint{.cdecl, 
    importc: "Mix_ExpireChannel", dynlib: MixerLibName.}
  # Halt a channel, fading it out progressively till it's silent
  #   The ms parameter indicates the number of milliseconds the fading
  #   will take.
  #
proc fadeOutChannel*(which: Cint, ms: Cint): Cint{.cdecl, 
    importc: "Mix_FadeOutChannel", dynlib: MixerLibName.}
proc fadeOutGroup*(tag: Cint, ms: Cint): Cint{.cdecl, 
    importc: "Mix_FadeOutGroup", dynlib: MixerLibName.}
proc fadeOutMusic*(ms: Cint): Cint{.cdecl, importc: "Mix_FadeOutMusic", 
                                      dynlib: MixerLibName.}
  # Query the fading status of a channel
proc fadingMusic*(): TFading{.cdecl, importc: "Mix_FadingMusic", 
                                      dynlib: MixerLibName.}
proc fadingChannel*(which: Cint): TFading{.cdecl, 
    importc: "Mix_FadingChannel", dynlib: MixerLibName.}

proc pause*(channel: Cint){.cdecl, importc: "Mix_Pause", dynlib: MixerLibName.}
proc resume*(channel: Cint){.cdecl, importc: "Mix_Resume", 
                                dynlib: MixerLibName.}
proc paused*(channel: Cint): Cint{.cdecl, importc: "Mix_Paused", 
                                     dynlib: MixerLibName.}

proc pauseMusic*(){.cdecl, importc: "Mix_PauseMusic", dynlib: MixerLibName.}
proc resumeMusic*(){.cdecl, importc: "Mix_ResumeMusic", dynlib: MixerLibName.}
proc rewindMusic*(){.cdecl, importc: "Mix_RewindMusic", dynlib: MixerLibName.}
proc pausedMusic*(): Cint{.cdecl, importc: "Mix_PausedMusic", 
                              dynlib: MixerLibName.}

proc setMusicPosition*(position: Float64): Cint{.cdecl, 
    importc: "Mix_SetMusicPosition", dynlib: MixerLibName.}

proc playing*(channel: Cint): Cint{.cdecl, importc: "Mix_Playing", 
                                      dynlib: MixerLibName.}
proc playingMusic*(): Cint{.cdecl, importc: "Mix_PlayingMusic", 
                               dynlib: MixerLibName.}

proc setMusicCMD*(command: Cstring): Cint{.cdecl, importc: "Mix_SetMusicCMD", 
    dynlib: MixerLibName.}

proc setSynchroValue*(value: Cint): Cint{.cdecl, 
    importc: "Mix_SetSynchroValue", dynlib: MixerLibName.}
proc getSynchroValue*(): Cint{.cdecl, importc: "Mix_GetSynchroValue", 
                                  dynlib: MixerLibName.}

proc getChunk*(channel: Cint): PChunk{.cdecl, importc: "Mix_GetChunk", 
    dynlib: MixerLibName.}

proc closeAudio*(){.cdecl, importc: "Mix_CloseAudio", dynlib: MixerLibName.}

proc version(X: var sdl.Tversion) = 
  x.major = MAJOR_VERSION
  x.minor = MINOR_VERSION
  x.patch = PATCHLEVEL

proc loadWAV(filename: cstring): PChunk = 
  result = loadWAVRW(rWFromFile(filename, "rb"), 1)

proc playChannel(channel: cint, chunk: PChunk, loops: cint): cint = 
  result = playChannelTimed(channel, chunk, loops, - 1)

proc fadeInChannel(channel: cint, chunk: PChunk, loops: cint, ms: cint): cint = 
  result = fadeInChannelTimed(channel, chunk, loops, ms, - 1)

