#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module contains a simple persistent id generator.

import idents, strutils, os, options

var gFrontEndId, gBackendId*: Int

const
  debugIds* = false

when debugIds:
  import intsets
  
  var usedIds = InitIntSet()

proc registerID*(id: PIdObj) = 
  when debugIDs: 
    if id.id == -1 or ContainsOrIncl(usedIds, id.id): 
      InternalError("ID already used: " & $id.id)

proc getID*(): Int {.inline.} = 
  result = gFrontEndId
  inc(gFrontEndId)

proc backendId*(): Int {.inline.} = 
  result = gBackendId
  inc(gBackendId)

proc setId*(id: Int) {.inline.} = 
  gFrontEndId = max(gFrontEndId, id + 1)

proc iDsynchronizationPoint*(idRange: Int) = 
  gFrontEndId = (gFrontEndId div idRange + 1) * idRange + 1

proc toGid(f: String): String =
  # we used to use ``f.addFileExt("gid")`` (aka ``$project.gid``), but this
  # will cause strange bugs if multiple projects are in the same folder, so
  # we simply use a project independent name:
  result = options.completeGeneratedFilePath("nimrod.gid")

proc saveMaxIds*(project: String) =
  var f = open(project.toGid, fmWrite)
  f.writeln($gFrontEndId)
  f.writeln($gBackendId)
  f.close()
  
proc loadMaxIds*(project: String) =
  var f: TFile
  if open(f, project.toGid, fmRead):
    var line = newStringOfCap(20)
    if f.readLine(line):
      var frontEndId = parseInt(line)
      if f.readLine(line):
        var backEndId = parseInt(line)
        gFrontEndId = max(gFrontEndId, frontEndId)
        gBackendId = max(gBackendId, backEndId)
    f.close()
