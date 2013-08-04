#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Dominik Picheta
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module allows you to monitor files or directories for changes using
## asyncio.
##
## Windows support is not yet implemented.
##
## **Note:** This module uses ``inotify`` on Linux (Other Unixes are not yet
## supported). ``inotify`` was merged into the 2.6.13 Linux kernel, this
## module will therefore not work with any Linux kernel prior to that, unless
## it has been patched to support inotify.

when defined(linux) or defined(nimdoc):
  from posix import read
else:
  {.error: "Your platform is not supported.".}

import inotify, os, asyncio, tables

type
  PFSMonitor* = ref TFSMonitor
  TFSMonitor = object of TObject
    fd: Cint
    handleEvent: proc (m: PFSMonitor, ev: TMonitorEvent) {.closure.}
    targets: TTable[Cint, String]
  
  TMonitorEventType* = enum ## Monitor event type
    MonitorAccess,       ## File was accessed.
    MonitorAttrib,       ## Metadata changed.
    MonitorCloseWrite,   ## Writtable file was closed.
    MonitorCloseNoWrite, ## Unwrittable file closed.
    MonitorCreate,       ## Subfile was created.
    MonitorDelete,       ## Subfile was deleted.
    MonitorDeleteSelf,   ## Watched file/directory was itself deleted.
    MonitorModify,       ## File was modified.
    MonitorMoveSelf,     ## Self was moved.
    MonitorMoved,        ## File was moved.
    MonitorOpen,         ## File was opened.
    MonitorAll           ## Filter for all event types.
  
  TMonitorEvent* = object
    case kind*: TMonitorEventType  ## Type of the event.
    of MonitorMoveSelf, MonitorMoved:
      oldPath*: String          ## Old absolute location
      newPath*: String          ## New absolute location
    else:
      fullname*: String         ## Absolute filename of the file/directory affected.
    name*: String             ## Non absolute filepath of the file/directory
                              ## affected relative to the directory watched.
                              ## "" if this event refers to the file/directory
                              ## watched.
    wd*: Cint                 ## Watch descriptor.

const
  MaxEvents = 100

proc newMonitor*(): PFSMonitor =
  ## Creates a new file system monitor.
  new(result)
  result.fd = inotifyInit()
  result.targets = initTable[cint, string]()
  if result.fd < 0:
    oSError()

proc add*(monitor: PFSMonitor, target: String,
               filters = {MonitorAll}): Cint {.discardable.} =
  ## Adds ``target`` which may be a directory or a file to the list of
  ## watched paths of ``monitor``.
  ## You can specify the events to report using the ``filters`` parameter.
  
  var iNFilter = -1
  for f in filters:
    case f
    of MonitorAccess: iNFilter = iNFilter and IN_ACCESS
    of MonitorAttrib: iNFilter = iNFilter and IN_ATTRIB
    of MonitorCloseWrite: iNFilter = iNFilter and IN_CLOSE_WRITE
    of MonitorCloseNoWrite: iNFilter = iNFilter and IN_CLOSE_NO_WRITE
    of MonitorCreate: iNFilter = iNFilter and IN_CREATE
    of MonitorDelete: iNFilter = iNFilter and IN_DELETE
    of MonitorDeleteSelf: iNFilter = iNFilter and IN_DELETE_SELF
    of MonitorModify: iNFilter = iNFilter and IN_MODIFY
    of MonitorMoveSelf: iNFilter = iNFilter and IN_MOVE_SELF
    of MonitorMoved: iNFilter = iNFilter and IN_MOVED_FROM and IN_MOVED_TO
    of MonitorOpen: iNFilter = iNFilter and IN_OPEN
    of MonitorAll: iNFilter = iNFilter and IN_ALL_EVENTS
  
  result = inotifyAddWatch(monitor.fd, target, iNFilter.Uint32)
  if result < 0:
    oSError()
  monitor.targets.add(result, target)

proc del*(monitor: PFSMonitor, wd: Cint) =
  ## Removes watched directory or file as specified by ``wd`` from ``monitor``.
  ##
  ## If ``wd`` is not a part of ``monitor`` an EOS error is raised.
  if inotifyRmWatch(monitor.fd, wd) < 0:
    oSError()

proc getEvent(m: PFSMonitor, fd: Cint): Seq[TMonitorEvent] =
  result = @[]
  let size = (sizeof(TinotifyEvent)+2000)*MaxEvents
  var buffer = newString(size)

  let le = read(fd, addr(buffer[0]), size)

  var movedFrom: TTable[Cint, tuple[wd: Cint, old: String]] = 
            initTable[cint, tuple[wd: cint, old: string]]()

  var i = 0
  while i < le:
    var event = cast[ptr TinotifyEvent](addr(buffer[i]))
    var mev: TMonitorEvent
    mev.wd = event.wd
    if event.len.Int != 0:
      mev.name = newString(event.len.Int)
      copyMem(addr(mev.name[0]), addr event.name, event.len.Int-1)
    else:
      mev.name = ""
    
    if (event.mask.Int and IN_MOVED_FROM) != 0: 
      # Moved from event, add to m's collection
      movedFrom.add(event.cookie.Cint, (mev.wd, mev.name))
      inc(i, sizeof(TinotifyEvent) + event.len.Int)
      continue
    elif (event.mask.Int and IN_MOVED_TO) != 0: 
      mev.kind = MonitorMoved
      assert movedFrom.hasKey(event.cookie.cint)
      # Find the MovedFrom event.
      mev.oldPath = movedFrom[event.cookie.Cint].old
      mev.newPath = "" # Set later
      # Delete it from the TTable
      movedFrom.del(event.cookie.Cint)
    elif (event.mask.Int and IN_ACCESS) != 0: mev.kind = MonitorAccess
    elif (event.mask.Int and IN_ATTRIB) != 0: mev.kind = MonitorAttrib
    elif (event.mask.Int and IN_CLOSE_WRITE) != 0: 
      mev.kind = MonitorCloseWrite
    elif (event.mask.Int and IN_CLOSE_NOWRITE) != 0: 
      mev.kind = MonitorCloseNoWrite
    elif (event.mask.Int and IN_CREATE) != 0: mev.kind = MonitorCreate
    elif (event.mask.Int and IN_DELETE) != 0: 
      mev.kind = MonitorDelete
    elif (event.mask.Int and IN_DELETE_SELF) != 0: 
      mev.kind = MonitorDeleteSelf
    elif (event.mask.Int and IN_MODIFY) != 0: mev.kind = MonitorModify
    elif (event.mask.Int and IN_MOVE_SELF) != 0: 
      mev.kind = MonitorMoveSelf
    elif (event.mask.Int and IN_OPEN) != 0: mev.kind = MonitorOpen
    
    if mev.kind != MonitorMoved:
      mev.fullname = ""
    
    result.add(mev)
    inc(i, sizeof(TinotifyEvent) + event.len.Int)

  # If movedFrom events have not been matched with a moveTo. File has
  # been moved to an unwatched location, emit a MonitorDelete.
  for cookie, t in pairs(movedFrom):
    var mev: TMonitorEvent
    mev.kind = MonitorDelete
    mev.wd = t.wd
    mev.name = t.old
    result.add(mev)

proc fSMonitorRead(h: PObject) =
  var events = PFSMonitor(h).getEvent(PFSMonitor(h).fd)
  #var newEv: TMonitorEvent
  for ev in events:
    var target = PFSMonitor(h).targets[ev.wd]
    var newEv = ev
    if newEv.kind == MonitorMoved:
      newEv.oldPath = target / newEv.oldPath
      newEv.newPath = target / newEv.name
    else:
      newEv.fullName = target / newEv.name
    PFSMonitor(h).handleEvent(PFSMonitor(h), newEv)

proc toDelegate(m: PFSMonitor): PDelegate =
  result = newDelegate()
  result.deleVal = m
  result.fd = m.fd
  result.mode = fmRead
  result.handleRead = fSMonitorRead
  result.open = true

proc register*(d: PDispatcher, monitor: PFSMonitor,
               handleEvent: proc (m: PFSMonitor, ev: TMonitorEvent) {.closure.}) =
  ## Registers ``monitor`` with dispatcher ``d``.
  monitor.handleEvent = handleEvent
  var deleg = toDelegate(monitor)
  d.register(deleg)

when isMainModule:
  var disp = newDispatcher()
  var monitor = newMonitor()
  echo monitor.add("/home/dom/inotifytests/")
  disp.register(monitor,
    proc (m: PFSMonitor, ev: TMonitorEvent) =
      echo("Got event: ", ev.kind)
      if ev.kind == MonitorMoved:
        echo("From ", ev.oldPath, " to ", ev.newPath)
        echo("Name is ", ev.name)
      else:
        echo("Name ", ev.name, " fullname ", ev.fullName))
      
  while true:
    if not disp.poll(): break
  
