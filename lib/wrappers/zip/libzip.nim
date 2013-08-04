#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2013 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## Interface to the `libzip <http://www.nih.at/libzip/index.html>`_ library by
## Dieter Baron and Thomas Klausner. This version links
## against ``libzip2.so.2`` unless you define the symbol ``useLibzipSrc``; then
## it is compiled against some old ``libizp_all.c`` file.

#
#  zip.h -- exported declarations.
#  Copyright (C) 1999-2008 Dieter Baron and Thomas Klausner
#
#  This file is part of libzip, a library to manipulate ZIP archives.
#  The authors can be contacted at <libzip@nih.at>
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in
#     the documentation and/or other materials provided with the
#     distribution.
#  3. The names of the authors may not be used to endorse or promote
#     products derived from this software without specific prior
#     written permission.
# 
#  THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY EXPRESS
#  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
#  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
#  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
#  IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
#  IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

import times

when defined(unix) and not defined(useLibzipSrc):
  when defined(macosx):
    {.pragma: mydll, dynlib: "libzip2.dylib".}
  else:
    {.pragma: mydll, dynlib: "libzip(|2).so(|.2|.1|.0)".}
else:
  when defined(unix):
    {.passl: "-lz".}
  {.compile: "libzip_all.c".}
  {.pragma: mydll.}

type 
  TzipSourceCmd* = Int32

  TzipSourceCallback* = proc (state: Pointer, data: Pointer, length: Int, 
                                cmd: TzipSourceCmd): Int {.cdecl.}
  PzipStat* = ptr TzipStat
  TzipStat* = object ## the 'zip_stat' struct
    name*: Cstring            ## name of the file  
    index*: Int32             ## index within archive  
    crc*: Int32               ## crc of file data  
    mtime*: TTime             ## modification time  
    size*: Int                ## size of file (uncompressed)  
    comp_size*: Int           ## size of file (compressed)  
    comp_method*: Int16       ## compression method used  
    encryption_method*: Int16 ## encryption method used  
  
  Tzip = object
  TzipSource = object 
  TzipFile = object

  Pzip* = ptr Tzip ## represents a zip archive
  PzipFile* = ptr TzipFile ## represents a file within an archive
  PzipSource* = ptr TzipSource ## represents a source for an archive


# flags for zip_name_locate, zip_fopen, zip_stat, ...  
const 
  ZipCreate* = 1'i32
  ZipExcl* = 2'i32
  ZipCheckcons* = 4'i32 
  ZipFlNocase* = 1'i32        ## ignore case on name lookup  
  ZipFlNodir* = 2'i32         ## ignore directory component  
  ZipFlCompressed* = 4'i32    ## read compressed data  
  ZipFlUnchanged* = 8'i32     ## use original data, ignoring changes  
  ZipFlRecompress* = 16'i32   ## force recompression of data  

const  # archive global flags flags  
  ZipAflTorrent* = 1'i32      ##  torrent zipped  

const # libzip error codes  
  ZipErOk* = 0'i32            ## N No error  
  ZipErMultidisk* = 1'i32     ## N Multi-disk zip archives not supported  
  ZipErRename* = 2'i32        ## S Renaming temporary file failed  
  ZipErClose* = 3'i32         ## S Closing zip archive failed  
  ZipErSeek* = 4'i32          ## S Seek error  
  ZipErRead* = 5'i32          ## S Read error  
  ZipErWrite* = 6'i32         ## S Write error  
  ZipErCrc* = 7'i32           ## N CRC error  
  ZipErZipclosed* = 8'i32     ## N Containing zip archive was closed  
  ZipErNoent* = 9'i32         ## N No such file  
  ZipErExists* = 10'i32       ## N File already exists  
  ZipErOpen* = 11'i32         ## S Can't open file  
  ZipErTmpopen* = 12'i32      ## S Failure to create temporary file  
  ZipErZlib* = 13'i32         ## Z Zlib error  
  ZipErMemory* = 14'i32       ## N Malloc failure  
  ZipErChanged* = 15'i32      ## N Entry has been changed  
  ZipErCompnotsupp* = 16'i32  ## N Compression method not supported  
  ZipErEof* = 17'i32          ## N Premature EOF  
  ZipErInval* = 18'i32        ## N Invalid argument  
  ZipErNozip* = 19'i32        ## N Not a zip archive  
  ZipErInternal* = 20'i32     ## N Internal error  
  ZipErIncons* = 21'i32       ## N Zip archive inconsistent  
  ZipErRemove* = 22'i32       ## S Can't remove file  
  ZipErDeleted* = 23'i32      ## N Entry has been deleted  
   
const # type of system error value  
  ZipEtNone* = 0'i32          ## sys_err unused  
  ZipEtSys* = 1'i32           ## sys_err is errno  
  ZipEtZlib* = 2'i32          ## sys_err is zlib error code  

const # compression methods  
  ZipCmDefault* = -1'i32      ## better of deflate or store  
  ZipCmStore* = 0'i32         ## stored (uncompressed)  
  ZipCmShrink* = 1'i32        ## shrunk  
  ZipCmReduce1* = 2'i32      ## reduced with factor 1  
  ZipCmReduce2* = 3'i32      ## reduced with factor 2  
  ZipCmReduce3* = 4'i32      ## reduced with factor 3  
  ZipCmReduce4* = 5'i32      ## reduced with factor 4  
  ZipCmImplode* = 6'i32       ## imploded  
                                ## 7 - Reserved for Tokenizing compression algorithm  
  ZipCmDeflate* = 8'i32       ## deflated  
  ZipCmDeflate64* = 9'i32     ## deflate64  
  ZipCmPkwareImplode* = 10'i32 ## PKWARE imploding  
                                  ## 11 - Reserved by PKWARE  
  ZipCmBzip2* = 12'i32        ## compressed using BZIP2 algorithm  
                                ## 13 - Reserved by PKWARE  
  ZipCmLzma* = 14'i32         ## LZMA (EFS)  
                                ## 15-17 - Reserved by PKWARE  
  ZipCmTerse* = 18'i32        ## compressed using IBM TERSE (new)  
  ZipCmLz77* = 19'i32         ## IBM LZ77 z Architecture (PFS)  
  ZipCmWavpack* = 97'i32      ## WavPack compressed data  
  ZipCmPpmd* = 98'i32         ## PPMd version I, Rev 1  

const  # encryption methods                              
  ZipEmNone* = 0'i32            ## not encrypted  
  ZipEmTradPkware* = 1'i32     ## traditional PKWARE encryption 

const 
  ZipEmUnknown* = 0x0000FFFF'i32 ## unknown algorithm  

const 
  ZipSourceOpen* = 0'i32        ## prepare for reading  
  ZipSourceRead* = 1'i32        ## read data  
  ZipSourceClose* = 2'i32       ## reading is done  
  ZipSourceStat* = 3'i32        ## get meta information  
  ZipSourceError* = 4'i32       ## get error information  
  constZIPSOURCEFREE* = 5'i32   ## cleanup and free resources  

proc zipAdd*(para1: Pzip, para2: Cstring, para3: PzipSource): Int32 {.cdecl, 
    importc: "zip_add", mydll.}
proc zipAddDir*(para1: Pzip, para2: Cstring): Int32 {.cdecl,  
    importc: "zip_add_dir", mydll.}
proc zipClose*(para1: Pzip) {.cdecl, importc: "zip_close", mydll.}
proc zipDelete*(para1: Pzip, para2: Int32): Int32 {.cdecl, mydll,
    importc: "zip_delete".}
proc zipErrorClear*(para1: Pzip) {.cdecl, importc: "zip_error_clear", mydll.}
proc zipErrorGet*(para1: Pzip, para2: ptr Int32, para3: ptr Int32) {.cdecl, 
    importc: "zip_error_get", mydll.}
proc zipErrorGetSysType*(para1: Int32): Int32 {.cdecl, mydll,
    importc: "zip_error_get_sys_type".}
proc zipErrorToStr*(para1: Cstring, para2: Int, para3: Int32, 
                       para4: Int32): Int32 {.cdecl, mydll,
    importc: "zip_error_to_str".}
proc zipFclose*(para1: PzipFile) {.cdecl, mydll,
    importc: "zip_fclose".}
proc zipFileErrorClear*(para1: PzipFile) {.cdecl, mydll,
    importc: "zip_file_error_clear".}
proc zipFileErrorGet*(para1: PzipFile, para2: ptr Int32, para3: ptr Int32) {.
    cdecl, mydll, importc: "zip_file_error_get".}
proc zipFileStrerror*(para1: PzipFile): Cstring {.cdecl, mydll,
    importc: "zip_file_strerror".}
proc zipFopen*(para1: Pzip, para2: Cstring, para3: Int32): PzipFile {.cdecl, 
    mydll, importc: "zip_fopen".}
proc zipFopenIndex*(para1: Pzip, para2: Int32, para3: Int32): PzipFile {.
    cdecl, mydll, importc: "zip_fopen_index".}
proc zipFread*(para1: PzipFile, para2: Pointer, para3: Int): Int {.
    cdecl, mydll, importc: "zip_fread".}
proc zipGetArchiveComment*(para1: Pzip, para2: ptr Int32, para3: Int32): Cstring {.
    cdecl, mydll, importc: "zip_get_archive_comment".}
proc zipGetArchiveFlag*(para1: Pzip, para2: Int32, para3: Int32): Int32 {.
    cdecl, mydll, importc: "zip_get_archive_flag".}
proc zipGetFileComment*(para1: Pzip, para2: Int32, para3: ptr Int32, 
                           para4: Int32): Cstring {.cdecl, mydll,
    importc: "zip_get_file_comment".}
proc zipGetName*(para1: Pzip, para2: Int32, para3: Int32): Cstring {.cdecl, 
    mydll, importc: "zip_get_name".}
proc zipGetNumFiles*(para1: Pzip): Int32 {.cdecl,
    mydll, importc: "zip_get_num_files".}
proc zipNameLocate*(para1: Pzip, para2: Cstring, para3: Int32): Int32 {.cdecl, 
    mydll, importc: "zip_name_locate".}
proc zipOpen*(para1: Cstring, para2: Int32, para3: ptr Int32): Pzip {.cdecl, 
    mydll, importc: "zip_open".}
proc zipRename*(para1: Pzip, para2: Int32, para3: Cstring): Int32 {.cdecl, 
    mydll, importc: "zip_rename".}
proc zipReplace*(para1: Pzip, para2: Int32, para3: PzipSource): Int32 {.cdecl, 
    mydll, importc: "zip_replace".}
proc zipSetArchiveComment*(para1: Pzip, para2: Cstring, para3: Int32): Int32 {.
    cdecl, mydll, importc: "zip_set_archive_comment".}
proc zipSetArchiveFlag*(para1: Pzip, para2: Int32, para3: Int32): Int32 {.
    cdecl, mydll, importc: "zip_set_archive_flag".}
proc zipSetFileComment*(para1: Pzip, para2: Int32, para3: Cstring, 
                           para4: Int32): Int32 {.cdecl, mydll,
    importc: "zip_set_file_comment".}
proc zipSourceBuffer*(para1: Pzip, para2: Pointer, para3: Int, para4: Int32): PzipSource {.
    cdecl, mydll, importc: "zip_source_buffer".}
proc zipSourceFile*(para1: Pzip, para2: Cstring, para3: Int, para4: Int): PzipSource {.
    cdecl, mydll, importc: "zip_source_file".}
proc zipSourceFilep*(para1: Pzip, para2: TFile, para3: Int, para4: Int): PzipSource {.
    cdecl, mydll, importc: "zip_source_filep".}
proc zipSourceFree*(para1: PzipSource) {.cdecl, mydll,
    importc: "zip_source_free".}
proc zipSourceFunction*(para1: Pzip, para2: TzipSourceCallback, 
                          para3: Pointer): PzipSource {.cdecl, mydll,
    importc: "zip_source_function".}
proc zipSourceZip*(para1: Pzip, para2: Pzip, para3: Int32, para4: Int32, 
                     para5: Int, para6: Int): PzipSource {.cdecl, mydll,
    importc: "zip_source_zip".}
proc zipStat*(para1: Pzip, para2: Cstring, para3: Int32, para4: PzipStat): Int32 {.
    cdecl, mydll, importc: "zip_stat".}
proc zipStatIndex*(para1: Pzip, para2: Int32, para3: Int32, para4: PzipStat): Int32 {.
    cdecl, mydll, importc: "zip_stat_index".}
proc zipStatInit*(para1: PzipStat) {.cdecl, mydll, importc: "zip_stat_init".}
proc zipStrerror*(para1: Pzip): Cstring {.cdecl, mydll, importc: "zip_strerror".}
proc zipUnchange*(para1: Pzip, para2: Int32): Int32 {.cdecl, mydll,
    importc: "zip_unchange".}
proc zipUnchangeAll*(para1: Pzip): Int32 {.cdecl, mydll,
    importc: "zip_unchange_all".}
proc zipUnchangeArchive*(para1: Pzip): Int32 {.cdecl, mydll,
    importc: "zip_unchange_archive".}
