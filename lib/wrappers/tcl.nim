#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2010 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module is a wrapper for the TCL programming language.

#
#  tcl.h --
# 
#  This header file describes the externally-visible facilities of the Tcl
#  interpreter.
# 
#  Translated to Pascal Copyright (c) 2002 by Max Artemev
#  aka Bert Raccoon (bert@furry.ru, bert_raccoon@freemail.ru)
# 
# 
#  Copyright (c) 1998-2000 by Scriptics Corporation.
#  Copyright (c) 1994-1998 Sun Microsystems, Inc.
#  Copyright (c) 1993-1996 Lucent Technologies.
#  Copyright (c) 1987-1994 John Ousterhout, The Regents of the
#                          University of California, Berkeley.
# 
#  ***********************************************************************
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#  ***********************************************************************
# 

{.deadCodeElim: on.}

when defined(WIN32): 
  const 
    dllName = "tcl(85|84|83|82|81|80).dll"
elif defined(macosx): 
  const 
    dllName = "libtcl(8.5|8.4|8.3|8.2|8.1).dylib"
else: 
  const 
    dllName = "libtcl(8.5|8.4|8.3|8.2|8.1).so(|.1|.0)"
const 
  TclDestroyed* = 0xDEADDEAD
  TclOk* = 0
  TclError* = 1
  TclReturn* = 2
  TclBreak* = 3
  TclContinue* = 4
  ResultSize* = 200
  MaxArgv* = 0x00007FFF
  VersionMajor* = 0
  VersionMinor* = 0
  NoEval* = 0x00010000
  EvalGlobal* = 0x00020000 # Flag values passed to variable-related proc
  GlobalOnly* = 1
  NamespaceOnly* = 2
  AppendValue* = 4
  ListElement* = 8
  TraceReads* = 0x00000010
  TraceWrites* = 0x00000020
  TraceUnsets* = 0x00000040
  TraceDestroyed* = 0x00000080
  InterpDestroyed* = 0x00000100
  LeaveErrMsg* = 0x00000200
  ParsePart1* = 0x00000400 # Types for linked variables: *
  LinkInt* = 1
  LinkDouble* = 2
  LinkBoolean* = 3
  LinkString* = 4
  LinkReadOnly* = 0x00000080
  SmallHashTable* = 4   # Hash Table *
  StringKeys* = 0
  OneWordKeys* = 1      # Const/enums Tcl_QueuePosition *
                          
  QueueTail* = 0
  QueueHead* = 1
  QueueMark* = 2         # Tcl_QueuePosition;
                          # Event Flags
  DontWait* = 1 shl 1
  WindowEvents* = 1 shl 2
  FileEvents* = 1 shl 3
  TimerEvents* = 1 shl 4
  IdleEvents* = 1 shl 5  # WAS 0x10 ???? *
  AllEvents* = not DONT_WAIT
  Volatile* = 1
  TclStatic* = 0
  Dynamic* = 3            # Channel
  TclStdin* = 1 shl 1
  TclStdout* = 1 shl 2
  TclStderr* = 1 shl 3
  EnforceMode* = 1 shl 4
  Readable* = 1 shl 1
  Writable* = 1 shl 2
  Exception* = 1 shl 3    # POSIX *
  Eperm* = 1 # Operation not permitted; only the owner of the file (or other
             # resource) or processes with special privileges can perform the
             # operation.
             #
  Enoent* = 2 # No such file or directory.  This is a "file doesn't exist" error
              # for ordinary files that are referenced in contexts where they are
              # expected to already exist.
              #
  Esrch* = 3                  # No process matches the specified process ID. *
  Eintr* = 4 # Interrupted function call; an asynchronous signal occurred and
             # prevented completion of the call.  When this happens, you should
             # try the call again.
             #
  Eio* = 5                    # Input/output error; usually used for physical read or write errors. *
  Enxio* = 6 # No such device or address.  The system tried to use the device
             # represented by a file you specified, and it couldn't find the
             # device.  This can mean that the device file was installed
             # incorrectly, or that the physical device is missing or not
             # correctly attached to the computer.
             #
  E2big* = 7 # Argument list too long; used when the arguments passed to a new
             # program being executed with one of the `exec' functions (*note
             # Executing a File::.) occupy too much memory space.  This condition
             # never arises in the GNU system.
             #
  Enoexec* = 8 # Invalid executable file format.  This condition is detected by the
               # `exec' functions; see *Note Executing a File::.
               #
  Ebadf* = 9 # Bad file descriptor; for example, I/O on a descriptor that has been
             # closed or reading from a descriptor open only for writing (or vice
             # versa).
             #
  Echild* = 10 # There are no child processes.  This error happens on operations
               # that are supposed to manipulate child processes, when there aren't
               # any processes to manipulate.
               #
  Edeadlk* = 11 # Deadlock avoided; allocating a system resource would have resulted
                # in a deadlock situation.  The system does not guarantee that it
                # will notice all such situations.  This error means you got lucky
                # and the system noticed; it might just hang.  *Note File Locks::,
                # for an example.
                #
  Enomem* = 12 # No memory available.  The system cannot allocate more virtual
               # memory because its capacity is full.
               #
  Eacces* = 13 # Permission denied; the file permissions do not allow the attempted
               # operation.
               #
  Efault* = 14 # Bad address; an invalid pointer was detected.  In the GNU system,
               # this error never happens; you get a signal instead.
               #
  Enotblk* = 15 # A file that isn't a block special file was given in a situation
                # that requires one.  For example, trying to mount an ordinary file
                # as a file system in Unix gives this error.
                #
  Ebusy* = 16 # Resource busy; a system resource that can't be shared is already
              # in use.  For example, if you try to delete a file that is the root
              # of a currently mounted filesystem, you get this error.
              #
  Eexist* = 17 # File exists; an existing file was specified in a context where it
               # only makes sense to specify a new file.
               #
  Exdev* = 18 # An attempt to make an improper link across file systems was
              # detected.  This happens not only when you use `link' (*note Hard
              # Links::.) but also when you rename a file with `rename' (*note
              # Renaming Files::.).
              #
  Enodev* = 19 # The wrong type of device was given to a function that expects a
               # particular sort of device.
               #
  Enotdir* = 20 # A file that isn't a directory was specified when a directory is
                # required.
                #
  Eisdir* = 21 # File is a directory; you cannot open a directory for writing, or
               # create or remove hard links to it.
               #
  Einval* = 22 # Invalid argument.  This is used to indicate various kinds of
               # problems with passing the wrong argument to a library function.
               #
  Emfile* = 24 # The current process has too many files open and can't open any
               # more.  Duplicate descriptors do count toward this limit.
               #
               # In BSD and GNU, the number of open files is controlled by a
               # resource limit that can usually be increased.  If you get this
               # error, you might want to increase the `RLIMIT_NOFILE' limit or
               # make it unlimited; *note Limits on Resources::..
               #
  Enfile* = 23 # There are too many distinct file openings in the entire system.
               # Note that any number of linked channels count as just one file
               # opening; see *Note Linked Channels::.  This error never occurs in
               # the GNU system.
               #
  Enotty* = 25 # Inappropriate I/O control operation, such as trying to set terminal
               # modes on an ordinary file.
               #
  Etxtbsy* = 26 # An attempt to execute a file that is currently open for writing, or
                # write to a file that is currently being executed.  Often using a
                # debugger to run a program is considered having it open for writing
                # and will cause this error.  (The name stands for "text file
                # busy".)  This is not an error in the GNU system; the text is
                # copied as necessary.
                #
  Efbig* = 27 # File too big; the size of a file would be larger than allowed by
              # the system.
              #
  Enospc* = 28 # No space left on device; write operation on a file failed because
               # the disk is full.
               #
  Espipe* = 29                # Invalid seek operation (such as on a pipe).  *
  Erofs* = 30                 # An attempt was made to modify something on a read-only file system.  *
  Emlink* = 31 # Too many links; the link count of a single file would become too
               # large.  `rename' can cause this error if the file being renamed
               # already has as many links as it can take (*note Renaming Files::.).
               #
  Epipe* = 32 # Broken pipe; there is no process reading from the other end of a
              # pipe.  Every library function that returns this error code also
              # generates a `SIGPIPE' signal; this signal terminates the program
              # if not handled or blocked.  Thus, your program will never actually
              # see `EPIPE' unless it has handled or blocked `SIGPIPE'.
              #
  Edom* = 33 # Domain error; used by mathematical functions when an argument
             # value does not fall into the domain over which the function is
             # defined.
             #
  Erange* = 34 # Range error; used by mathematical functions when the result value
               # is not representable because of overflow or underflow.
               #
  Eagain* = 35 # Resource temporarily unavailable; the call might work if you try
               # again later.  The macro `EWOULDBLOCK' is another name for `EAGAIN';
               # they are always the same in the GNU C library.
               #
  Ewouldblock* = EAGAIN # In the GNU C library, this is another name for `EAGAIN' (above).
                        # The values are always the same, on every operating system.
                        # C libraries in many older Unix systems have `EWOULDBLOCK' as a
                        # separate error code.
                        #
  Einprogress* = 36 # An operation that cannot complete immediately was initiated on an
                    # object that has non-blocking mode selected.  Some functions that
                    # must always block (such as `connect'; *note Connecting::.) never
                    # return `EAGAIN'.  Instead, they return `EINPROGRESS' to indicate
                    # that the operation has begun and will take some time.  Attempts to
                    # manipulate the object before the call completes return `EALREADY'.
                    # You can use the `select' function to find out when the pending
                    # operation has completed; *note Waiting for I/O::..
                    #
  Ealready* = 37 # An operation is already in progress on an object that has
                 # non-blocking mode selected.
                 #
  Enotsock* = 38              # A file that isn't a socket was specified when a socket is required.  *
  Edestaddrreq* = 39 # No default destination address was set for the socket.  You get
                     # this error when you try to transmit data over a connectionless
                     # socket, without first specifying a destination for the data with
                     # `connect'.
                     #
  Emsgsize* = 40 # The size of a message sent on a socket was larger than the
                 # supported maximum size.
                 #
  Eprototype* = 41 # The socket type does not support the requested communications
                   # protocol.
                   #
  Enoprotoopt* = 42 # You specified a socket option that doesn't make sense for the
                    # particular protocol being used by the socket.  *Note Socket
                    # Options::.
                    #
  Eprotonosupport* = 43 # The socket domain does not support the requested communications
                        # protocol (perhaps because the requested protocol is completely
                        # invalid.) *Note Creating a Socket::.
                        #
  Esocktnosupport* = 44       # The socket type is not supported.  *
  Eopnotsupp* = 45 # The operation you requested is not supported.  Some socket
                   # functions don't make sense for all types of sockets, and others
                   # may not be implemented for all communications protocols.  In the
                   # GNU system, this error can happen for many calls when the object
                   # does not support the particular operation; it is a generic
                   # indication that the server knows nothing to do for that call.
                   #
  Epfnosupport* = 46 # The socket communications protocol family you requested is not
                     # supported.
                     #
  Eafnosupport* = 47 # The address family specified for a socket is not supported; it is
                     # inconsistent with the protocol being used on the socket.  *Note
                     # Sockets::.
                     #
  Eaddrinuse* = 48 # The requested socket address is already in use.  *Note Socket
                   # Addresses::.
                   #
  Eaddrnotavail* = 49 # The requested socket address is not available; for example, you
                      # tried to give a socket a name that doesn't match the local host
                      # name.  *Note Socket Addresses::.
                      #
  Enetdown* = 50              # A socket operation failed because the network was down.  *
  Enetunreach* = 51 # A socket operation failed because the subnet containing the remote
                    # host was unreachable.
                    #
  Enetreset* = 52             # A network connection was reset because the remote host crashed.  *
  Econnaborted* = 53          # A network connection was aborted locally. *
  Econnreset* = 54 # A network connection was closed for reasons outside the control of
                   # the local host, such as by the remote machine rebooting or an
                   # unrecoverable protocol violation.
                   #
  Enobufs* = 55 # The kernel's buffers for I/O operations are all in use.  In GNU,
                # this error is always synonymous with `ENOMEM'; you may get one or
                # the other from network operations.
                #
  Eisconn* = 56 # You tried to connect a socket that is already connected.  *Note
                # Connecting::.
                #
  Enotconn* = 57 # The socket is not connected to anything.  You get this error when
                 # you try to transmit data over a socket, without first specifying a
                 # destination for the data.  For a connectionless socket (for
                 # datagram protocols, such as UDP), you get `EDESTADDRREQ' instead.
                 #
  Eshutdown* = 58             # The socket has already been shut down.  *
  Etoomanyrefs* = 59          # ???  *
  Etimedout* = 60 # A socket operation with a specified timeout received no response
                  # during the timeout period.
                  #
  Econnrefused* = 61 # A remote host refused to allow the network connection (typically
                     # because it is not running the requested service).
                     #
  Eloop* = 62 # Too many levels of symbolic links were encountered in looking up a
              # file name.  This often indicates a cycle of symbolic links.
              #
  Enametoolong* = 63 # Filename too long (longer than `PATH_MAX'; *note Limits for
                     # Files::.) or host name too long (in `gethostname' or
                     # `sethostname'; *note Host Identification::.).
                     #
  Ehostdown* = 64             # The remote host for a requested network connection is down.  *
  Ehostunreach* = 65 # The remote host for a requested network connection is not
                     # reachable.
                     #
  Enotempty* = 66 # Directory not empty, where an empty directory was expected.
                  # Typically, this error occurs when you are trying to delete a
                  # directory.
                  #
  Eproclim* = 67 # This means that the per-user limit on new process would be
                 # exceeded by an attempted `fork'.  *Note Limits on Resources::, for
                 # details on the `RLIMIT_NPROC' limit.
                 #
  Eusers* = 68                # The file quota system is confused because there are too many users.  *
  Edquot* = 69                # The user's disk quota was exceeded.  *
  Estale* = 70 # Stale NFS file handle.  This indicates an internal confusion in
               # the NFS system which is due to file system rearrangements on the
               # server host.  Repairing this condition usually requires unmounting
               # and remounting the NFS file system on the local host.
               #
  Eremote* = 71 # An attempt was made to NFS-mount a remote file system with a file
                # name that already specifies an NFS-mounted file.  (This is an
                # error on some operating systems, but we expect it to work properly
                # on the GNU system, making this error code impossible.)
                #
  Ebadrpc* = 72               # ???  *
  Erpcmismatch* = 73          # ???  *
  Eprogunavail* = 74          # ???  *
  Eprogmismatch* = 75         # ???  *
  Eprocunavail* = 76          # ???  *
  Enolck* = 77 # No locks available.  This is used by the file locking facilities;
               # see *Note File Locks::.  This error is never generated by the GNU
               # system, but it can result from an operation to an NFS server
               # running another operating system.
               #
  Enosys* = 78 # Function not implemented.  Some functions have commands or options
               # defined that might not be supported in all implementations, and
               # this is the kind of error you get if you request them and they are
               # not supported.
               #
  Eftype* = 79 # Inappropriate file type or format.  The file was the wrong type
               # for the operation, or a data file had the wrong format.
               # On some systems `chmod' returns this error if you try to set the
               # sticky bit on a non-directory file; *note Setting Permissions::..
               #

type 
  TArgv* = CstringArray
  TClientData* = Pointer
  TFreeProc* = proc (theBlock: Pointer){.cdecl.}
  PInterp* = ptr TInterp
  TInterp*{.final.} = object  #  Event Definitions
    result*: Cstring # Do not access this directly. Use
                     # Tcl_GetStringResult since result
                     # may be pointing to an object
    freeProc*: TFreeProc
    errorLine*: Int

  TEventSetupProc* = proc (clientData: TClientData, flags: Int){.cdecl.}
  TEventCheckProc* = TEventSetupProc
  PEvent* = ptr TEvent
  TEventProc* = proc (evPtr: PEvent, flags: Int): Int{.cdecl.}
  TEvent*{.final.} = object 
    prc*: TEventProc
    nextPtr*: PEvent
    ClientData*: TObject      # ClientData is just pointer.*
  
  PTime* = ptr TTime
  TTime*{.final.} = object 
    sec*: Int32               # Seconds. * 
    usec*: Int32              # Microseconds. * 
  
  TTimerToken* = Pointer
  PInteger* = ptr Int
  PHashTable* = ptr THashTable
  PHashEntry* = ptr THashEntry
  PPHashEntry* = ptr PHashEntry
  THashEntry*{.final.} = object 
    nextPtr*: PHashEntry
    tablePtr*: PHashTable
    bucketPtr*: PPHashEntry
    clientData*: TClientData
    key*: Cstring

  THashFindProc* = proc (tablePtr: PHashTable, key: Cstring): PHashEntry{.
      cdecl.}
  THashCreateProc* = proc (tablePtr: PHashTable, key: Cstring, 
                              newPtr: PInteger): PHashEntry{.cdecl.}
  THashTable*{.final.} = object 
    buckets*: PPHashEntry
    staticBuckets*: Array[0..SMALL_HASH_TABLE - 1, PHashEntry]
    numBuckets*: Int
    numEntries*: Int
    rebuildSize*: Int
    downShift*: Int
    mask*: Int
    keyType*: Int
    findProc*: THashFindProc
    createProc*: THashCreateProc

  PHashSearch* = ptr THashSearch
  THashSearch*{.final.} = object 
    tablePtr*: PHashTable
    nextIndex*: Int
    nextEntryPtr*: PHashEntry

  TAppInitProc* = proc (interp: PInterp): Int{.cdecl.}
  TPackageInitProc* = proc (interp: PInterp): Int{.cdecl.}
  TCmdProc* = proc (clientData: TClientData, interp: PInterp, argc: Int, 
                    argv: TArgv): Int{.cdecl.}
  TVarTraceProc* = proc (clientData: TClientData, interp: PInterp, 
                         varName: Cstring, elemName: Cstring, flags: Int): Cstring{.
      cdecl.}
  TInterpDeleteProc* = proc (clientData: TClientData, interp: PInterp){.cdecl.}
  TCmdDeleteProc* = proc (clientData: TClientData){.cdecl.}
  TNamespaceDeleteProc* = proc (clientData: TClientData){.cdecl.}

const 
  DstringStaticSize* = 200

type 
  PDString* = ptr TDString
  TDString*{.final.} = object 
    str*: Cstring
    len*: Int
    spaceAvl*: Int
    staticSpace*: Array[0..DSTRING_STATIC_SIZE - 1, Char]

  PChannel* = ptr TChannel
  TChannel*{.final.} = object 
  TDriverBlockModeProc* = proc (instanceData: TClientData, mode: Int): Int{.
      cdecl.}
  TDriverCloseProc* = proc (instanceData: TClientData, interp: PInterp): Int{.
      cdecl.}
  TDriverInputProc* = proc (instanceData: TClientData, buf: Cstring, 
                            toRead: Int, errorCodePtr: PInteger): Int{.cdecl.}
  TDriverOutputProc* = proc (instanceData: TClientData, buf: Cstring, 
                             toWrite: Int, errorCodePtr: PInteger): Int{.cdecl.}
  TDriverSeekProc* = proc (instanceData: TClientData, offset: Int32, 
                           mode: Int, errorCodePtr: PInteger): Int{.cdecl.}
  TDriverSetOptionProc* = proc (instanceData: TClientData, interp: PInterp, 
                                optionName: Cstring, value: Cstring): Int{.cdecl.}
  TDriverGetOptionProc* = proc (instanceData: TClientData, interp: PInterp, 
                                optionName: Cstring, dsPtr: PDString): Int{.
      cdecl.}
  TDriverWatchProc* = proc (instanceData: TClientData, mask: Int){.cdecl.}
  TDriverGetHandleProc* = proc (instanceData: TClientData, direction: Int, 
                                handlePtr: var TClientData): Int{.cdecl.}
  PChannelType* = ptr TChannelType
  TChannelType*{.final.} = object 
    typeName*: Cstring
    blockModeProc*: TDriverBlockModeProc
    closeProc*: TDriverCloseProc
    inputProc*: TDriverInputProc
    ouputProc*: TDriverOutputProc
    seekProc*: TDriverSeekProc
    setOptionProc*: TDriverSetOptionProc
    getOptionProc*: TDriverGetOptionProc
    watchProc*: TDriverWatchProc
    getHandleProc*: TDriverGetHandleProc

  TChannelProc* = proc (clientData: TClientData, mask: Int){.cdecl.}
  PObj* = ptr TObj
  PPObj* = ptr PObj
  TObj*{.final.} = object 
    refCount*: Int            # ...
  
  TObjCmdProc* = proc (clientData: TClientData, interp: PInterp, objc: Int, 
                       PPObj: PPObj): Int{.cdecl.}
  PNamespace* = ptr TNamespace
  TNamespace*{.final.} = object 
    name*: Cstring
    fullName*: Cstring
    clientData*: TClientData
    deleteProc*: TNamespaceDeleteProc
    parentPtr*: PNamespace

  PCallFrame* = ptr TCallFrame
  TCallFrame*{.final.} = object 
    nsPtr*: PNamespace
    dummy1*: Int
    dummy2*: Int
    dummy3*: Cstring
    dummy4*: Cstring
    dummy5*: Cstring
    dummy6*: Int
    dummy7*: Cstring
    dummy8*: Cstring
    dummy9*: Int
    dummy10*: Cstring

  PCmdInfo* = ptr TCmdInfo
  TCmdInfo*{.final.} = object 
    isNativeObjectProc*: Int
    objProc*: TObjCmdProc
    objClientData*: TClientData
    prc*: TCmdProc
    clientData*: TClientData
    deleteProc*: TCmdDeleteProc
    deleteData*: TClientData
    namespacePtr*: PNamespace

  PCommand* = ptr TCommand
  TCommand*{.final.} = object     #       hPtr            : pTcl_HashEntry;
                                  #        nsPtr           : pTcl_Namespace;
                                  #        refCount        : integer;
                                  #        isCmdEpoch      : integer;
                                  #        compileProc     : pointer;
                                  #        objProc         : pointer;
                                  #        objClientData   : Tcl_ClientData;
                                  #        proc            : pointer;
                                  #        clientData      : Tcl_ClientData;
                                  #        deleteProc      : TTclCmdDeleteProc;
                                  #        deleteData      : Tcl_ClientData;
                                  #        deleted         : integer;
                                  #        importRefPtr    : pointer;
                                  #

type 
  TPanicProc* = proc (fmt, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8: Cstring){.
      cdecl.}                 # 1/15/97 orig. Tcl style
  TClientDataProc* = proc (clientData: TClientData){.cdecl.}
  TIdleProc* = proc (clientData: TClientData){.cdecl.}
  TTimerProc* = TIdleProc
  TCreateCloseHandler* = proc (channel: PChannel, prc: TClientDataProc, 
                               clientData: TClientData){.cdecl.}
  TDeleteCloseHandler* = TCreateCloseHandler
  TEventDeleteProc* = proc (evPtr: PEvent, clientData: TClientData): Int{.
      cdecl.}

proc alloc*(size: Int): Cstring{.cdecl, dynlib: dllName, 
                                     importc: "Tcl_Alloc".}
proc createInterp*(): PInterp{.cdecl, dynlib: dllName, 
                                   importc: "Tcl_CreateInterp".}
proc deleteInterp*(interp: PInterp){.cdecl, dynlib: dllName, 
    importc: "Tcl_DeleteInterp".}
proc resetResult*(interp: PInterp){.cdecl, dynlib: dllName, 
                                        importc: "Tcl_ResetResult".}
proc eval*(interp: PInterp, script: Cstring): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_Eval".}
proc evalFile*(interp: PInterp, filename: Cstring): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_EvalFile".}
proc addErrorInfo*(interp: PInterp, message: Cstring){.cdecl, 
    dynlib: dllName, importc: "Tcl_AddErrorInfo".}
proc backgroundError*(interp: PInterp){.cdecl, dynlib: dllName, 
    importc: "Tcl_BackgroundError".}
proc createCommand*(interp: PInterp, name: Cstring, cmdProc: TCmdProc, 
                        clientData: TClientData, deleteProc: TCmdDeleteProc): PCommand{.
    cdecl, dynlib: dllName, importc: "Tcl_CreateCommand".}
proc deleteCommand*(interp: PInterp, name: Cstring): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_DeleteCommand".}
proc callWhenDeleted*(interp: PInterp, prc: TInterpDeleteProc, 
                          clientData: TClientData){.cdecl, dynlib: dllName, 
    importc: "Tcl_CallWhenDeleted".}
proc dontCallWhenDeleted*(interp: PInterp, prc: TInterpDeleteProc, 
                              clientData: TClientData){.cdecl, 
    dynlib: dllName, importc: "Tcl_DontCallWhenDeleted".}
proc commandComplete*(cmd: Cstring): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_CommandComplete".}
proc linkVar*(interp: PInterp, varName: Cstring, varAddr: Pointer, typ: Int): Int{.
    cdecl, dynlib: dllName, importc: "Tcl_LinkVar".}
proc unlinkVar*(interp: PInterp, varName: Cstring){.cdecl, dynlib: dllName, 
    importc: "Tcl_UnlinkVar".}
proc traceVar*(interp: PInterp, varName: Cstring, flags: Int, 
                   prc: TVarTraceProc, clientData: TClientData): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_TraceVar".}
proc traceVar2*(interp: PInterp, varName: Cstring, elemName: Cstring, 
                    flags: Int, prc: TVarTraceProc, clientData: TClientData): Int{.
    cdecl, dynlib: dllName, importc: "Tcl_TraceVar2".}
proc untraceVar*(interp: PInterp, varName: Cstring, flags: Int, 
                     prc: TVarTraceProc, clientData: TClientData){.cdecl, 
    dynlib: dllName, importc: "Tcl_UntraceVar".}
proc untraceVar2*(interp: PInterp, varName: Cstring, elemName: Cstring, 
                      flags: Int, prc: TVarTraceProc, clientData: TClientData){.
    cdecl, dynlib: dllName, importc: "Tcl_UntraceVar2".}
proc getVar*(interp: PInterp, varName: Cstring, flags: Int): Cstring{.cdecl, 
    dynlib: dllName, importc: "Tcl_GetVar".}
proc getVar2*(interp: PInterp, varName: Cstring, elemName: Cstring, 
                  flags: Int): Cstring{.cdecl, dynlib: dllName, 
                                        importc: "Tcl_GetVar2".}
proc setVar*(interp: PInterp, varName: Cstring, newValue: Cstring, 
                 flags: Int): Cstring{.cdecl, dynlib: dllName, 
                                       importc: "Tcl_SetVar".}
proc setVar2*(interp: PInterp, varName: Cstring, elemName: Cstring, 
                  newValue: Cstring, flags: Int): Cstring{.cdecl, 
    dynlib: dllName, importc: "Tcl_SetVar2".}
proc unsetVar*(interp: PInterp, varName: Cstring, flags: Int): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_UnsetVar".}
proc unsetVar2*(interp: PInterp, varName: Cstring, elemName: Cstring, 
                    flags: Int): Int{.cdecl, dynlib: dllName, 
                                      importc: "Tcl_UnsetVar2".}
proc setResult*(interp: PInterp, newValue: Cstring, freeProc: TFreeProc){.
    cdecl, dynlib: dllName, importc: "Tcl_SetResult".}
proc firstHashEntry*(hashTbl: PHashTable, searchInfo: var THashSearch): PHashEntry{.
    cdecl, dynlib: dllName, importc: "Tcl_FirstHashEntry".}
proc nextHashEntry*(searchInfo: var THashSearch): PHashEntry{.cdecl, 
    dynlib: dllName, importc: "Tcl_NextHashEntry".}
proc initHashTable*(hashTbl: PHashTable, keyType: Int){.cdecl, 
    dynlib: dllName, importc: "Tcl_InitHashTable".}
proc stringMatch*(str: Cstring, pattern: Cstring): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_StringMatch".}
proc getErrno*(): Int{.cdecl, dynlib: dllName, importc: "Tcl_GetErrno".}
proc setErrno*(val: Int){.cdecl, dynlib: dllName, importc: "Tcl_SetErrno".}
proc setPanicProc*(prc: TPanicProc){.cdecl, dynlib: dllName, 
    importc: "Tcl_SetPanicProc".}
proc pkgProvide*(interp: PInterp, name: Cstring, version: Cstring): Int{.
    cdecl, dynlib: dllName, importc: "Tcl_PkgProvide".}
proc staticPackage*(interp: PInterp, pkgName: Cstring, 
                        initProc: TPackageInitProc, 
                        safeInitProc: TPackageInitProc){.cdecl, dynlib: dllName, 
    importc: "Tcl_StaticPackage".}
proc createEventSource*(setupProc: TEventSetupProc, 
                            checkProc: TEventCheckProc, 
                            clientData: TClientData){.cdecl, dynlib: dllName, 
    importc: "Tcl_CreateEventSource".}
proc deleteEventSource*(setupProc: TEventSetupProc, 
                            checkProc: TEventCheckProc, 
                            clientData: TClientData){.cdecl, dynlib: dllName, 
    importc: "Tcl_DeleteEventSource".}
proc queueEvent*(evPtr: PEvent, pos: Int){.cdecl, dynlib: dllName, 
    importc: "Tcl_QueueEvent".}
proc setMaxBlockTime*(timePtr: PTime){.cdecl, dynlib: dllName, 
    importc: "Tcl_SetMaxBlockTime".}
proc deleteEvents*(prc: TEventDeleteProc, clientData: TClientData){.
    cdecl, dynlib: dllName, importc: "Tcl_DeleteEvents".}
proc doOneEvent*(flags: Int): Int{.cdecl, dynlib: dllName, 
                                       importc: "Tcl_DoOneEvent".}
proc doWhenIdle*(prc: TIdleProc, clientData: TClientData){.cdecl, 
    dynlib: dllName, importc: "Tcl_DoWhenIdle".}
proc cancelIdleCall*(prc: TIdleProc, clientData: TClientData){.cdecl, 
    dynlib: dllName, importc: "Tcl_CancelIdleCall".}
proc createTimerHandler*(milliseconds: Int, prc: TTimerProc, 
                             clientData: TClientData): TTimerToken{.cdecl, 
    dynlib: dllName, importc: "Tcl_CreateTimerHandler".}
proc deleteTimerHandler*(token: TTimerToken){.cdecl, dynlib: dllName, 
    importc: "Tcl_DeleteTimerHandler".}
  #    procedure Tcl_CreateModalTimeout(milliseconds: integer; prc: TTclTimerProc; clientData: Tcl_ClientData); cdecl; external dllName;
  #    procedure Tcl_DeleteModalTimeout(prc: TTclTimerProc; clientData: Tcl_ClientData); cdecl; external dllName;
proc splitList*(interp: PInterp, list: Cstring, argcPtr: var Int, 
                    argvPtr: var TArgv): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_SplitList".}
proc merge*(argc: Int, argv: TArgv): Cstring{.cdecl, dynlib: dllName, 
    importc: "Tcl_Merge".}
proc free*(p: Cstring){.cdecl, dynlib: dllName, importc: "Tcl_Free".}
proc init*(interp: PInterp): Int{.cdecl, dynlib: dllName, 
                                      importc: "Tcl_Init".}
  #    procedure Tcl_InterpDeleteProc(clientData: Tcl_ClientData; interp: pTcl_Interp); cdecl; external dllName;
proc getAssocData*(interp: PInterp, key: Cstring, prc: var TInterpDeleteProc): TClientData{.
    cdecl, dynlib: dllName, importc: "Tcl_GetAssocData".}
proc deleteAssocData*(interp: PInterp, key: Cstring){.cdecl, 
    dynlib: dllName, importc: "Tcl_DeleteAssocData".}
proc setAssocData*(interp: PInterp, key: Cstring, prc: TInterpDeleteProc, 
                       clientData: TClientData){.cdecl, dynlib: dllName, 
    importc: "Tcl_SetAssocData".}
proc isSafe*(interp: PInterp): Int{.cdecl, dynlib: dllName, 
                                        importc: "Tcl_IsSafe".}
proc makeSafe*(interp: PInterp): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_MakeSafe".}
proc createSlave*(interp: PInterp, slaveName: Cstring, isSafe: Int): PInterp{.
    cdecl, dynlib: dllName, importc: "Tcl_CreateSlave".}
proc getSlave*(interp: PInterp, slaveName: Cstring): PInterp{.cdecl, 
    dynlib: dllName, importc: "Tcl_GetSlave".}
proc getMaster*(interp: PInterp): PInterp{.cdecl, dynlib: dllName, 
    importc: "Tcl_GetMaster".}
proc getInterpPath*(askingInterp: PInterp, slaveInterp: PInterp): Int{.
    cdecl, dynlib: dllName, importc: "Tcl_GetInterpPath".}
proc createAlias*(slaveInterp: PInterp, srcCmd: Cstring, 
                      targetInterp: PInterp, targetCmd: Cstring, argc: Int, 
                      argv: TArgv): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_CreateAlias".}
proc getAlias*(interp: PInterp, srcCmd: Cstring, targetInterp: var PInterp, 
                   targetCmd: var Cstring, argc: var Int, argv: var TArgv): Int{.
    cdecl, dynlib: dllName, importc: "Tcl_GetAlias".}
proc exposeCommand*(interp: PInterp, hiddenCmdName: Cstring, 
                        cmdName: Cstring): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_ExposeCommand".}
proc hideCommand*(interp: PInterp, cmdName: Cstring, hiddenCmdName: Cstring): Int{.
    cdecl, dynlib: dllName, importc: "Tcl_HideCommand".}
proc eventuallyFree*(clientData: TClientData, freeProc: TFreeProc){.
    cdecl, dynlib: dllName, importc: "Tcl_EventuallyFree".}
proc preserve*(clientData: TClientData){.cdecl, dynlib: dllName, 
    importc: "Tcl_Preserve".}
proc release*(clientData: TClientData){.cdecl, dynlib: dllName, 
    importc: "Tcl_Release".}
proc interpDeleted*(interp: PInterp): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_InterpDeleted".}
proc getCommandInfo*(interp: PInterp, cmdName: Cstring, 
                         info: var TCmdInfo): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_GetCommandInfo".}
proc setCommandInfo*(interp: PInterp, cmdName: Cstring, 
                         info: var TCmdInfo): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_SetCommandInfo".}
proc findExecutable*(path: Cstring){.cdecl, dynlib: dllName, 
    importc: "Tcl_FindExecutable".}
proc getStringResult*(interp: PInterp): Cstring{.cdecl, dynlib: dllName, 
    importc: "Tcl_GetStringResult".}
  #v1.0
proc findCommand*(interp: PInterp, cmdName: Cstring, 
                      contextNsPtr: PNamespace, flags: Int): TCommand{.cdecl, 
    dynlib: dllName, importc: "Tcl_FindCommand".}
  #v1.0
proc deleteCommandFromToken*(interp: PInterp, cmd: PCommand): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_DeleteCommandFromToken".}
proc createNamespace*(interp: PInterp, name: Cstring, 
                          clientData: TClientData, 
                          deleteProc: TNamespaceDeleteProc): PNamespace{.cdecl, 
    dynlib: dllName, importc: "Tcl_CreateNamespace".}
  #v1.0
proc deleteNamespace*(namespacePtr: PNamespace){.cdecl, dynlib: dllName, 
    importc: "Tcl_DeleteNamespace".}
proc findNamespace*(interp: PInterp, name: Cstring, 
                        contextNsPtr: PNamespace, flags: Int): PNamespace{.
    cdecl, dynlib: dllName, importc: "Tcl_FindNamespace".}
proc tclExport*(interp: PInterp, namespacePtr: PNamespace, pattern: Cstring, 
                 resetListFirst: Int): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_Export".}
proc tclImport*(interp: PInterp, namespacePtr: PNamespace, pattern: Cstring, 
                 allowOverwrite: Int): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_Import".}
proc getCurrentNamespace*(interp: PInterp): PNamespace{.cdecl, 
    dynlib: dllName, importc: "Tcl_GetCurrentNamespace".}
proc getGlobalNamespace*(interp: PInterp): PNamespace{.cdecl, 
    dynlib: dllName, importc: "Tcl_GetGlobalNamespace".}
proc pushCallFrame*(interp: PInterp, callFramePtr: var TCallFrame, 
                        namespacePtr: PNamespace, isProcCallFrame: Int): Int{.
    cdecl, dynlib: dllName, importc: "Tcl_PushCallFrame".}
proc popCallFrame*(interp: PInterp){.cdecl, dynlib: dllName, 
    importc: "Tcl_PopCallFrame".}
proc varEval*(interp: PInterp): Int{.cdecl, varargs, dynlib: dllName, 
    importc: "Tcl_VarEval".}
  # For TkConsole.c *
proc recordAndEval*(interp: PInterp, cmd: Cstring, flags: Int): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_RecordAndEval".}
proc globalEval*(interp: PInterp, command: Cstring): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_GlobalEval".}
proc dStringFree*(dsPtr: PDString){.cdecl, dynlib: dllName, 
                                        importc: "Tcl_DStringFree".}
proc dStringAppend*(dsPtr: PDString, str: Cstring, length: Int): Cstring{.
    cdecl, dynlib: dllName, importc: "Tcl_DStringAppend".}
proc dStringAppendElement*(dsPtr: PDString, str: Cstring): Cstring{.cdecl, 
    dynlib: dllName, importc: "Tcl_DStringAppendElement".}
proc dStringInit*(dsPtr: PDString){.cdecl, dynlib: dllName, 
                                        importc: "Tcl_DStringInit".}
proc appendResult*(interp: PInterp){.cdecl, varargs, dynlib: dllName, 
    importc: "Tcl_AppendResult".}
  # actually a "C" var array
proc setStdChannel*(channel: PChannel, typ: Int){.cdecl, dynlib: dllName, 
    importc: "Tcl_SetStdChannel".}
proc setChannelOption*(interp: PInterp, chan: PChannel, optionName: Cstring, 
                           newValue: Cstring): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_SetChannelOption".}
proc getChannelOption*(interp: PInterp, chan: PChannel, optionName: Cstring, 
                           dsPtr: PDString): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_GetChannelOption".}
proc createChannel*(typePtr: PChannelType, chanName: Cstring, 
                        instanceData: TClientData, mask: Int): PChannel{.
    cdecl, dynlib: dllName, importc: "Tcl_CreateChannel".}
proc registerChannel*(interp: PInterp, channel: PChannel){.cdecl, 
    dynlib: dllName, importc: "Tcl_RegisterChannel".}
proc unregisterChannel*(interp: PInterp, channel: PChannel): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_UnregisterChannel".}
proc createChannelHandler*(chan: PChannel, mask: Int, prc: TChannelProc, 
                               clientData: TClientData){.cdecl, 
    dynlib: dllName, importc: "Tcl_CreateChannelHandler".}
proc getChannel*(interp: PInterp, chanName: Cstring, modePtr: PInteger): PChannel{.
    cdecl, dynlib: dllName, importc: "Tcl_GetChannel".}
proc getStdChannel*(typ: Int): PChannel{.cdecl, dynlib: dllName, 
    importc: "Tcl_GetStdChannel".}
proc gets*(chan: PChannel, dsPtr: PDString): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_Gets".}
proc write*(chan: PChannel, s: Cstring, slen: Int): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_Write".}
proc flush*(chan: PChannel): Int{.cdecl, dynlib: dllName, 
                                      importc: "Tcl_Flush".}
  #    TclWinLoadLibrary      = function(name: PChar): HMODULE; cdecl; external dllName;
proc createExitHandler*(prc: TClientDataProc, clientData: TClientData){.
    cdecl, dynlib: dllName, importc: "Tcl_CreateExitHandler".}
proc deleteExitHandler*(prc: TClientDataProc, clientData: TClientData){.
    cdecl, dynlib: dllName, importc: "Tcl_DeleteExitHandler".}
proc getStringFromObj*(pObj: PObj, pLen: PInteger): Cstring{.cdecl, 
    dynlib: dllName, importc: "Tcl_GetStringFromObj".}
proc createObjCommand*(interp: PInterp, name: Cstring, cmdProc: TObjCmdProc, 
                           clientData: TClientData, 
                           deleteProc: TCmdDeleteProc): PCommand{.cdecl, 
    dynlib: dllName, importc: "Tcl_CreateObjCommand".}
proc newStringObj*(bytes: Cstring, length: Int): PObj{.cdecl, 
    dynlib: dllName, importc: "Tcl_NewStringObj".}
  #    procedure TclFreeObj(pObj: pTcl_Obj); cdecl; external dllName;
proc evalObj*(interp: PInterp, pObj: PObj): Int{.cdecl, dynlib: dllName, 
    importc: "Tcl_EvalObj".}
proc globalEvalObj*(interp: PInterp, pObj: PObj): Int{.cdecl, 
    dynlib: dllName, importc: "Tcl_GlobalEvalObj".}
proc regComp*(exp: Cstring): Pointer{.cdecl, dynlib: dllName, 
    importc: "TclRegComp".}

proc regExec*(prog: Pointer, str: Cstring, start: Cstring): Int{.cdecl, 
    dynlib: dllName, importc: "TclRegExec".}

proc regError*(msg: Cstring){.cdecl, dynlib: dllName, importc: "TclRegError".}

proc getRegError*(): Cstring{.cdecl, dynlib: dllName, 
                              importc: "TclGetRegError".}

proc regExpRange*(prog: Pointer, index: Int, head: var Cstring, 
                      tail: var Cstring){.cdecl, dynlib: dllName, 
    importc: "Tcl_RegExpRange".}
    
proc getCommandTable*(interp: PInterp): PHashTable = 
  if interp != nil: 
    result = cast[PHashTable](cast[Int](interp) + sizeof(interp) +
        sizeof(Pointer))

proc createHashEntry*(tablePtr: PHashTable, key: Cstring, 
                      newPtr: PInteger): PHashEntry = 
  result = cast[PHashTable](tablePtr).createProc(tablePtr, key, newPtr)

proc findHashEntry*(tablePtr: PHashTable, key: Cstring): PHashEntry = 
  result = cast[PHashTable](tablePtr).findProc(tablePtr, key)

proc setHashValue*(h: PHashEntry, clientData: TClientData) = 
  h.clientData = clientData

proc getHashValue*(h: PHashEntry): TClientData = 
  result = h.clientData

proc incrRefCount*(pObj: PObj) = 
  inc(pObj.refCount)

proc decrRefCount*(pObj: PObj) = 
  dec(pObj.refCount)
  if pObj.refCount <= 0: 
    dealloc(pObj)

proc isShared*(pObj: PObj): Bool = 
  return pObj.refCount > 1

proc getHashKey*(hashTbl: PHashTable, hashEntry: PHashEntry): Cstring = 
  if hashTbl == nil or hashEntry == nil: 
    result = nil
  else: 
    result = hashEntry.key
