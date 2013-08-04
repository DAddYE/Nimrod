#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2008 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module is an interface to the zzip library. 

#   Author: 
#   Guido Draheim <guidod@gmx.de>
#   Tomi Ollila <Tomi.Ollila@iki.fi>
#   Copyright (c) 1999,2000,2001,2002,2003,2004 Guido Draheim
#          All rights reserved, 
#             usage allowed under the restrictions of the
#         Lesser GNU General Public License 
#             or alternatively the restrictions 
#             of the Mozilla Public License 1.1

when defined(windows):
  const
    dllname = "zzip.dll"
else:
  const 
    dllname = "libzzip.so"

type 
  TZZipError* = Int32
const
  ZzipError* = -4096'i32
  ZzipNoError* = 0'i32            # no error, may be used if user sets it.
  ZzipOutofmem* = ZZIP_ERROR - 20'i32  # out of memory  
  ZzipDirOpen* = ZZIP_ERROR - 21'i32  # failed to open zipfile, see errno for details 
  ZzipDirStat* = ZZIP_ERROR - 22'i32  # failed to fstat zipfile, see errno for details
  ZzipDirSeek* = ZZIP_ERROR - 23'i32  # failed to lseek zipfile, see errno for details
  ZzipDirRead* = ZZIP_ERROR - 24'i32  # failed to read zipfile, see errno for details  
  ZzipDirTooShort* = ZZIP_ERROR - 25'i32
  ZzipDirEdhMissing* = ZZIP_ERROR - 26'i32
  ZzipDirsize* = ZZIP_ERROR - 27'i32
  ZzipEnoent* = ZZIP_ERROR - 28'i32
  ZzipUnsuppCompr* = ZZIP_ERROR - 29'i32
  ZzipCorrupted* = ZZIP_ERROR - 31'i32
  ZzipUndef* = ZZIP_ERROR - 32'i32
  ZzipDirLargefile* = ZZIP_ERROR - 33'i32

  ZzipCaseless* = 1'i32 shl 12'i32
  ZzipNopaths* = 1'i32 shl 13'i32
  ZzipPreferzip* = 1'i32 shl 14'i32
  ZzipOnlyzip* = 1'i32 shl 16'i32
  ZzipFactory* = 1'i32 shl 17'i32
  ZzipAllowreal* = 1'i32 shl 18'i32
  ZzipThreaded* = 1'i32 shl 19'i32
  
type
  TZZipDir* {.final, pure.} = object
  TZZipFile* {.final, pure.} = object
  TZZipPluginIO* {.final, pure.} = object

  TZZipDirent* {.final, pure.} = object  
    d_compr*: Int32  ## compression method
    d_csize*: Int32  ## compressed size  
    st_size*: Int32  ## file size / decompressed size
    d_name*: Cstring ## file name / strdupped name

  TZZipStat* = TZZipDirent    

proc zzipStrerror*(errcode: Int32): Cstring  {.cdecl, dynlib: dllname, 
    importc: "zzip_strerror".}
proc zzipStrerrorOf*(dir: ptr TZZipDir): Cstring  {.cdecl, dynlib: dllname, 
    importc: "zzip_strerror_of".}
proc zzipErrno*(errcode: Int32): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_errno".}

proc zzipGeterror*(dir: ptr TZZipDir): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_error".}
proc zzipSeterror*(dir: ptr TZZipDir, errcode: Int32) {.cdecl, dynlib: dllname, 
    importc: "zzip_seterror".}
proc zzipComprStr*(compr: Int32): Cstring {.cdecl, dynlib: dllname, 
    importc: "zzip_compr_str".}
proc zzipDirhandle*(fp: ptr TZZipFile): ptr TZZipDir {.cdecl, dynlib: dllname, 
    importc: "zzip_dirhandle".}
proc zzipDirfd*(dir: ptr TZZipDir): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_dirfd".}
proc zzipDirReal*(dir: ptr TZZipDir): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_dir_real".}
proc zzipFileReal*(fp: ptr TZZipFile): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_file_real".}
proc zzipRealdir*(dir: ptr TZZipDir): Pointer {.cdecl, dynlib: dllname, 
    importc: "zzip_realdir".}
proc zzipRealfd*(fp: ptr TZZipFile): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_realfd".}

proc zzipDirAlloc*(fileext: CstringArray): ptr TZZipDir {.cdecl, 
    dynlib: dllname, importc: "zzip_dir_alloc".}
proc zzipDirFree*(para1: ptr TZZipDir): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_dir_free".}

proc zzipDirFdopen*(fd: Int32, errcode_p: ptr TZZipError): ptr TZZipDir {.cdecl, 
    dynlib: dllname, importc: "zzip_dir_fdopen".}
proc zzipDirOpen*(filename: Cstring, errcode_p: ptr TZZipError): ptr TZZipDir {.
    cdecl, dynlib: dllname, importc: "zzip_dir_open".}
proc zzipDirClose*(dir: ptr TZZipDir) {.cdecl, dynlib: dllname, 
    importc: "zzip_dir_close".}
proc zzipDirRead*(dir: ptr TZZipDir, dirent: ptr TZZipDirent): Int32 {.cdecl, 
    dynlib: dllname, importc: "zzip_dir_read".}

proc zzipOpendir*(filename: Cstring): ptr TZZipDir {.cdecl, dynlib: dllname, 
    importc: "zzip_opendir".}
proc zzipClosedir*(dir: ptr TZZipDir) {.cdecl, dynlib: dllname, 
    importc: "zzip_closedir".}
proc zzipReaddir*(dir: ptr TZZipDir): ptr TZZipDirent {.cdecl, dynlib: dllname, 
    importc: "zzip_readdir".}
proc zzipRewinddir*(dir: ptr TZZipDir) {.cdecl, dynlib: dllname, 
                                      importc: "zzip_rewinddir".}
proc zzipTelldir*(dir: ptr TZZipDir): Int {.cdecl, dynlib: dllname, 
    importc: "zzip_telldir".}
proc zzipSeekdir*(dir: ptr TZZipDir, offset: Int) {.cdecl, dynlib: dllname, 
    importc: "zzip_seekdir".}

proc zzipFileOpen*(dir: ptr TZZipDir, name: Cstring, flags: Int32): ptr TZZipFile {.
    cdecl, dynlib: dllname, importc: "zzip_file_open".}
proc zzipFileClose*(fp: ptr TZZipFile) {.cdecl, dynlib: dllname, 
    importc: "zzip_file_close".}
proc zzipFileRead*(fp: ptr TZZipFile, buf: Pointer, length: Int): Int {.
    cdecl, dynlib: dllname, importc: "zzip_file_read".}
proc zzipOpen*(name: Cstring, flags: Int32): ptr TZZipFile {.cdecl, 
    dynlib: dllname, importc: "zzip_open".}
proc zzipClose*(fp: ptr TZZipFile) {.cdecl, dynlib: dllname, 
    importc: "zzip_close".}
proc zzipRead*(fp: ptr TZZipFile, buf: Pointer, length: Int): Int {.
    cdecl, dynlib: dllname, importc: "zzip_read".}

proc zzipFreopen*(name: Cstring, mode: Cstring, para3: ptr TZZipFile): ptr TZZipFile {.
    cdecl, dynlib: dllname, importc: "zzip_freopen".}
proc zzipFopen*(name: Cstring, mode: Cstring): ptr TZZipFile {.cdecl, 
    dynlib: dllname, importc: "zzip_fopen".}
proc zzipFread*(p: Pointer, size: Int, nmemb: Int, 
                 file: ptr TZZipFile): Int {.cdecl, dynlib: dllname, 
    importc: "zzip_fread".}
proc zzipFclose*(fp: ptr TZZipFile) {.cdecl, dynlib: dllname, 
    importc: "zzip_fclose".}

proc zzipRewind*(fp: ptr TZZipFile): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_rewind".}
proc zzipSeek*(fp: ptr TZZipFile, offset: Int, whence: Int32): Int {.
    cdecl, dynlib: dllname, importc: "zzip_seek".}
proc zzipTell*(fp: ptr TZZipFile): Int {.cdecl, dynlib: dllname, 
    importc: "zzip_tell".}

proc zzipDirStat*(dir: ptr TZZipDir, name: Cstring, zs: ptr TZZipStat, 
                    flags: Int32): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_dir_stat".}
proc zzipFileStat*(fp: ptr TZZipFile, zs: ptr TZZipStat): Int32 {.cdecl, 
    dynlib: dllname, importc: "zzip_file_stat".}
proc zzipFstat*(fp: ptr TZZipFile, zs: ptr TZZipStat): Int32 {.cdecl, dynlib: dllname, 
    importc: "zzip_fstat".}

proc zzipOpenSharedIo*(stream: ptr TZZipFile, name: Cstring, 
                          o_flags: Int32, o_modes: Int32, ext: CstringArray, 
                          io: ptr TZZipPluginIO): ptr TZZipFile {.cdecl, 
    dynlib: dllname, importc: "zzip_open_shared_io".}
proc zzipOpenExtIo*(name: Cstring, o_flags: Int32, o_modes: Int32, 
                       ext: CstringArray, io: ptr TZZipPluginIO): ptr TZZipFile {.
    cdecl, dynlib: dllname, importc: "zzip_open_ext_io".}
proc zzipOpendirExtIo*(name: Cstring, o_modes: Int32, 
                          ext: CstringArray, io: ptr TZZipPluginIO): ptr TZZipDir {.
    cdecl, dynlib: dllname, importc: "zzip_opendir_ext_io".}
proc zzipDirOpenExtIo*(filename: Cstring, errcode_p: ptr TZZipError, 
                           ext: CstringArray, io: ptr TZZipPluginIO): ptr TZZipDir {.
    cdecl, dynlib: dllname, importc: "zzip_dir_open_ext_io".}
