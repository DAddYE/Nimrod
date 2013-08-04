#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Dominik Picheta
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# Get the platform-dependent flags.  
# Structure describing an inotify event.  
type 
  TinotifyEvent*{.pure, final, importc: "struct inotify_event", 
                   header: "<sys/inotify.h>".} = object 
    wd*{.importc: "wd".}: Cint # Watch descriptor.  
    mask*{.importc: "mask".}: Uint32 # Watch mask.  
    cookie*{.importc: "cookie".}: Uint32 # Cookie to synchronize two events.  
    len*{.importc: "len".}: Uint32 # Length (including NULs) of name.  
    name*{.importc: "name".}: Char # Name.  
    
# Supported events suitable for MASK parameter of INOTIFY_ADD_WATCH.  
const 
  InAccess* = 0x00000001   # File was accessed.  
  InModify* = 0x00000002   # File was modified.  
  InAttrib* = 0x00000004   # Metadata changed.  
  InCloseWrite* = 0x00000008 # Writtable file was closed.  
  InCloseNowrite* = 0x00000010 # Unwrittable file closed.  
  InClose* = (IN_CLOSE_WRITE or IN_CLOSE_NOWRITE) # Close.  
  InOpen* = 0x00000020     # File was opened.  
  InMovedFrom* = 0x00000040 # File was moved from X.  
  InMovedTo* = 0x00000080 # File was moved to Y.  
  InMove* = (IN_MOVED_FROM or IN_MOVED_TO) # Moves.  
  InCreate* = 0x00000100   # Subfile was created.  
  InDelete* = 0x00000200   # Subfile was deleted.  
  InDeleteSelf* = 0x00000400 # Self was deleted.  
  InMoveSelf* = 0x00000800 # Self was moved.  
# Events sent by the kernel.  
const 
  InUnmount* = 0x00002000  # Backing fs was unmounted.  
  InQOverflow* = 0x00004000 # Event queued overflowed.  
  InIgnored* = 0x00008000  # File was ignored.   
# Special flags.  
const 
  InOnlydir* = 0x01000000  # Only watch the path if it is a
                            #        directory.  
  InDontFollow* = 0x02000000 # Do not follow a sym link.  
  InExclUnlink* = 0x04000000 # Exclude events on unlinked
                               #        objects.  
  InMaskAdd* = 0x20000000 # Add to the mask of an already
                            #        existing watch.  
  InIsdir* = 0x40000000    # Event occurred against dir.  
  InOneshot* = 0x80000000  # Only send event once.  
# All events which a program can wait on.  
const 
  InAllEvents* = (IN_ACCESS or IN_MODIFY or IN_ATTRIB or IN_CLOSE_WRITE or
      IN_CLOSE_NOWRITE or IN_OPEN or IN_MOVED_FROM or IN_MOVED_TO or
      IN_CREATE or IN_DELETE or IN_DELETE_SELF or IN_MOVE_SELF)
# Create and initialize inotify instance.
proc inotifyInit*(): Cint{.cdecl, importc: "inotify_init", 
                            header: "<sys/inotify.h>".}
# Create and initialize inotify instance.  
proc inotifyInit1*(flags: Cint): Cint{.cdecl, importc: "inotify_init1", 
    header: "<sys/inotify.h>".}
# Add watch of object NAME to inotify instance FD.  Notify about
#   events specified by MASK.  
proc inotifyAddWatch*(fd: Cint; name: Cstring; mask: Uint32): Cint{.
    cdecl, importc: "inotify_add_watch", header: "<sys/inotify.h>".}
# Remove the watch specified by WD from the inotify instance FD.  
proc inotifyRmWatch*(fd: Cint; wd: Cint): Cint{.cdecl, 
    importc: "inotify_rm_watch", header: "<sys/inotify.h>".}
