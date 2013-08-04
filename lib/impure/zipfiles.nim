#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements a zip archive creator/reader/modifier.

import 
  streams, libzip, times, os

type
  TZipArchive* = object of TObject ## represents a zip archive
    mode: TFileMode
    w: Pzip


proc zipError(z: var TZipArchive) = 
  var e: ref Eio
  new(e)
  e.msg = $zipStrerror(z.w)
  raise e
  
proc open*(z: var TZipArchive, filename: String, mode: TFileMode = fmRead): Bool =
  ## Opens a zip file for reading, writing or appending. All file modes are 
  ## supported. Returns true iff successful, false otherwise.
  var err, flags: Int32
  case mode
  of fmRead, fmReadWriteExisting, fmAppend: flags = 0
  of fmWrite:                               
    if existsFile(filename): removeFile(filename)
    flags = ZIP_CREATE or ZIP_EXCL
  of fmReadWrite: flags = ZIP_CREATE
  z.w = zipOpen(filename, flags, addr(err))
  z.mode = mode
  result = z.w != nil

proc close*(z: var TZipArchive) =
  ## Closes a zip file.
  zipClose(z.w)
 
proc createDir*(z: var TZipArchive, dir: String) = 
  ## Creates a directory within the `z` archive. This does not fail if the
  ## directory already exists. Note that for adding a file like 
  ## ``"path1/path2/filename"`` it is not necessary
  ## to create the ``"path/path2"`` subdirectories - it will be done 
  ## automatically by ``addFile``. 
  assert(z.mode != fmRead) 
  discard zipAddDir(z.w, dir)
  zipErrorClear(z.w)

proc addFile*(z: var TZipArchive, dest, src: String) = 
  ## Adds the file `src` to the archive `z` with the name `dest`. `dest`
  ## may contain a path that will be created. 
  assert(z.mode != fmRead) 
  var zipsrc = zipSourceFile(z.w, src, 0, -1)
  if zipsrc == nil:
    #echo("Dest: " & dest)
    #echo("Src: " & src)
    zipError(z)
  if zipAdd(z.w, dest, zipsrc) < 0'i32:
    zipSourceFree(zipsrc)
    zipError(z)

proc addFile*(z: var TZipArchive, file: String) = 
  ## A shortcut for ``addFile(z, file, file)``, i.e. the name of the source is
  ## the name of the destination.
  addFile(z, file, file)
  
proc mySourceCallback(state, data: Pointer, len: Int, 
                      cmd: TzipSourceCmd): Int {.cdecl.} = 
  var src = cast[PStream](state)
  case cmd
  of ZIP_SOURCE_OPEN: 
    if src.setPositionImpl != nil: setPosition(src, 0) # reset
  of ZIP_SOURCE_READ:
    result = readData(src, data, len)
  of ZIP_SOURCE_CLOSE: close(src)
  of ZIP_SOURCE_STAT: 
    var stat = cast[PzipStat](data)
    zipStatInit(stat)
    stat.size = high(int32)-1 # we don't know the size
    stat.mtime = getTime()
    result = sizeof(TzipStat)
  of ZIP_SOURCE_ERROR:
    var err = cast[ptr Array[0..1, Cint]](data)
    err[0] = ZIP_ER_INTERNAL
    err[1] = 0
    result = 2*sizeof(cint)
  of constZIP_SOURCE_FREE: gCUnref(src)
  else: assert(false)
  
proc addFile*(z: var TZipArchive, dest: String, src: PStream) = 
  ## Adds a file named with `dest` to the archive `z`. `dest`
  ## may contain a path. The file's content is read from the `src` stream.
  assert(z.mode != fmRead)
  gCRef(src)
  var zipsrc = zipSourceFunction(z.w, mySourceCallback, cast[Pointer](src))
  if zipsrc == nil: zipError(z)
  if zipAdd(z.w, dest, zipsrc) < 0'i32:
    zipSourceFree(zipsrc)
    zipError(z)
  
# -------------- zip file stream ---------------------------------------------

type
  TZipFileStream = object of TStream
    f: PzipFile

  PZipFileStream* = 
    ref TZipFileStream ## a reader stream of a file within a zip archive 

proc fsClose(s: PStream) = zipFclose(PZipFileStream(s).f)
proc fsReadData(s: PStream, buffer: Pointer, bufLen: Int): Int = 
  result = zipFread(PZipFileStream(s).f, buffer, bufLen)

proc newZipFileStream(f: PzipFile): PZipFileStream = 
  new(result)
  result.f = f
  result.closeImpl = fsClose
  result.readDataImpl = fsReadData
  # other methods are nil!

# ----------------------------------------------------------------------------
  
proc getStream*(z: var TZipArchive, filename: String): PZipFileStream = 
  ## returns a stream that can be used to read the file named `filename`
  ## from the archive `z`. Returns nil in case of an error.
  ## The returned stream does not support the `setPosition`, `getPosition`, 
  ## `writeData` or `atEnd` methods.
  var x = zipFopen(z.w, filename, 0'i32)
  if x != nil: result = newZipFileStream(x)
  
iterator walkFiles*(z: var TZipArchive): String = 
  ## walks over all files in the archive `z` and returns the filename 
  ## (including the path).
  var i = 0'i32
  var num = zipGetNumFiles(z.w)
  while i < num:
    yield $zipGetName(z.w, i, 0'i32)
    inc(i)


proc extractFile*(z: var TZipArchive, srcFile: String, dest: PStream) =
  ## extracts a file from the zip archive `z` to the destination stream.
  var strm = getStream(z, srcFile)
  while true:
    if not strm.atEnd:
        dest.write(strm.readStr(1))
    else: break
  dest.flush()
  strm.close()

proc extractFile*(z: var TZipArchive, srcFile: String, dest: String) =
  ## extracts a file from the zip archive `z` to the destination filename.
  var file = newFileStream(dest, fmReadWrite)
  extractFile(z, srcFile, file)
  file.close()

proc extractAll*(z: var TZipArchive, dest: String) =
  ## extracts all files from archive `z` to the destination directory.
  for file in walkFiles(z):
    extractFile(z, file, dest / extractFilename(file))

