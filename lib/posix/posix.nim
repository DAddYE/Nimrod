#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# Until std_arg!!
# done: ipc, pwd, stat, semaphore, sys/types, sys/utsname, pthread, unistd,
# statvfs, mman, time, wait, signal, nl_types, sched, spawn, select, ucontext,
# net/if, sys/socket, sys/uio, netinet/in, netinet/tcp, netdb

## This is a raw POSIX interface module. It does not not provide any
## convenience: cstrings are used instead of proper Nimrod strings and
## return codes indicate errors. If you want exceptions 
## and a proper Nimrod-like interface, use the OS module or write a wrapper.

## Coding conventions:
## ALL types are named the same as in the POSIX standard except that they start
## with 'T' or 'P' (if they are pointers) and without the '_t' suffix to be
## consistent with Nimrod conventions. If an identifier is a Nimrod keyword
## the \`identifier\` notation is used.
##
## This library relies on the header files of your C compiler. The
## resulting C code will just ``#include <XYZ.h>`` and *not* define the
## symbols declared here.

from times import TTime

const
  hasSpawnH = true # should exist for every Posix system really nowadays
  hasAioH = defined(linux)

when false:
  const
    C_IRUSR = 0c000400 ## Read by owner.
    C_IWUSR = 0c000200 ## Write by owner.
    C_IXUSR = 0c000100 ## Execute by owner.
    C_IRGRP = 0c000040 ## Read by group.
    C_IWGRP = 0c000020 ## Write by group.
    C_IXGRP = 0c000010 ## Execute by group.
    C_IROTH = 0c000004 ## Read by others.
    C_IWOTH = 0c000002 ## Write by others.
    C_IXOTH = 0c000001 ## Execute by others.
    C_ISUID = 0c004000 ## Set user ID.
    C_ISGID = 0c002000 ## Set group ID.
    C_ISVTX = 0c001000 ## On directories, restricted deletion flag.
    C_ISDIR = 0c040000 ## Directory.
    C_ISFIFO = 0c010000 ##FIFO.
    C_ISREG = 0c100000 ## Regular file.
    C_ISBLK = 0c060000 ## Block special.
    C_ISCHR = 0c020000 ## Character special.
    C_ISCTG = 0c110000 ## Reserved.
    C_ISLNK = 0c120000 ## Symbolic link.</p>
    C_ISSOCK = 0c140000 ## Socket.

const
  MmNulllbl* = nil
  MmNullsev* = 0
  MmNullmc* = 0
  MmNulltxt* = nil
  MmNullact* = nil
  MmNulltag* = nil
  
  StderrFileno* = 2 ## File number of stderr;
  StdinFileno* = 0  ## File number of stdin;
  StdoutFileno* = 1 ## File number of stdout; 

when defined(endb):
  # to not break bootstrapping again ...
  type
    TDIR* {.importc: "DIR", header: "<dirent.h>", 
            final, pure, incompleteStruct.} = object
      ## A type representing a directory stream. 
else:
  type
    TDIR* {.importc: "DIR", header: "<dirent.h>", 
            final, pure.} = object
      ## A type representing a directory stream.   
  
type
  Tdirent* {.importc: "struct dirent", 
             header: "<dirent.h>", final, pure.} = object ## dirent_t struct
    d_ino*: Tino  ## File serial number.
    d_name*: Array [0..255, Char] ## Name of entry.

  Tflock* {.importc: "flock", final, pure,
            header: "<fcntl.h>".} = object ## flock type
    l_type*: Cshort   ## Type of lock; F_RDLCK, F_WRLCK, F_UNLCK. 
    l_whence*: Cshort ## Flag for starting offset. 
    l_start*: Toff    ## Relative offset in bytes. 
    l_len*: Toff      ## Size; if 0 then until EOF. 
    l_pid*: TPid      ## Process ID of the process holding the lock; 
                      ## returned with F_GETLK. 
  
  Tfenv* {.importc: "fenv_t", header: "<fenv.h>", final, pure.} = 
    object ## Represents the entire floating-point environment. The
           ## floating-point environment refers collectively to any
           ## floating-point status flags and control modes supported
           ## by the implementation.
  Tfexcept* {.importc: "fexcept_t", header: "<fenv.h>", final, pure.} = 
    object ## Represents the floating-point status flags collectively, 
           ## including any status the implementation associates with the 
           ## flags. A floating-point status flag is a system variable 
           ## whose value is set (but never cleared) when a floating-point
           ## exception is raised, which occurs as a side effect of
           ## exceptional floating-point arithmetic to provide auxiliary
           ## information. A floating-point control mode is a system variable
           ## whose value may be set by the user to affect the subsequent 
           ## behavior of floating-point arithmetic.

  TFTW* {.importc: "struct FTW", header: "<ftw.h>", final, pure.} = object
    base*: Cint
    level*: Cint
    
  TGlob* {.importc: "glob_t", header: "<glob.h>", 
           final, pure.} = object ## glob_t
    gl_pathc*: Int          ## Count of paths matched by pattern. 
    gl_pathv*: CstringArray ## Pointer to a list of matched pathnames. 
    gl_offs*: Int           ## Slots to reserve at the beginning of gl_pathv. 
  
  TGroup* {.importc: "struct group", header: "<grp.h>", 
            final, pure.} = object ## struct group
    gr_name*: Cstring     ## The name of the group. 
    gr_gid*: TGid         ## Numerical group ID. 
    gr_mem*: CstringArray ## Pointer to a null-terminated array of character 
                          ## pointers to member names. 

  Ticonv* {.importc: "iconv_t", header: "<iconv.h>", final, pure.} = 
    object ## Identifies the conversion from one codeset to another.

  Tlconv* {.importc: "struct lconv", header: "<locale.h>", final,
            pure.} = object
    currency_symbol*: Cstring
    decimal_point*: Cstring
    frac_digits*: Char
    grouping*: Cstring
    int_curr_symbol*: Cstring
    int_frac_digits*: Char
    int_n_cs_precedes*: Char
    int_n_sep_by_space*: Char
    int_n_sign_posn*: Char
    int_p_cs_precedes*: Char
    int_p_sep_by_space*: Char
    int_p_sign_posn*: Char
    mon_decimal_point*: Cstring
    mon_grouping*: Cstring
    mon_thousands_sep*: Cstring
    negative_sign*: Cstring
    n_cs_precedes*: Char
    n_sep_by_space*: Char
    n_sign_posn*: Char
    positive_sign*: Cstring
    p_cs_precedes*: Char
    p_sep_by_space*: Char
    p_sign_posn*: Char
    thousands_sep*: Cstring

  TMqd* {.importc: "mqd_t", header: "<mqueue.h>", final, pure.} = object
  TMqAttr* {.importc: "struct mq_attr", 
             header: "<mqueue.h>", 
             final, pure.} = object ## message queue attribute
    mq_flags*: Int   ## Message queue flags. 
    mq_maxmsg*: Int  ## Maximum number of messages. 
    mq_msgsize*: Int ## Maximum message size. 
    mq_curmsgs*: Int ## Number of messages currently queued. 

  TPasswd* {.importc: "struct passwd", header: "<pwd.h>", 
             final, pure.} = object ## struct passwd
    pw_name*: Cstring   ## User's login name. 
    pw_uid*: Tuid       ## Numerical user ID. 
    pw_gid*: TGid       ## Numerical group ID. 
    pw_dir*: Cstring    ## Initial working directory. 
    pw_shell*: Cstring  ## Program to use as shell. 

  Tblkcnt* {.importc: "blkcnt_t", header: "<sys/types.h>".} = Int
    ## used for file block counts
  Tblksize* {.importc: "blksize_t", header: "<sys/types.h>".} = Int
    ## used for block sizes
  TClock* {.importc: "clock_t", header: "<sys/types.h>".} = Int
  TClockId* {.importc: "clockid_t", header: "<sys/types.h>".} = Int
  TDev* {.importc: "dev_t", header: "<sys/types.h>".} = Int
  Tfsblkcnt* {.importc: "fsblkcnt_t", header: "<sys/types.h>".} = Int
  Tfsfilcnt* {.importc: "fsfilcnt_t", header: "<sys/types.h>".} = Int
  TGid* {.importc: "gid_t", header: "<sys/types.h>".} = Int
  Tid* {.importc: "id_t", header: "<sys/types.h>".} = Int
  Tino* {.importc: "ino_t", header: "<sys/types.h>".} = Int
  TKey* {.importc: "key_t", header: "<sys/types.h>".} = Int
  TMode* {.importc: "mode_t", header: "<sys/types.h>".} = Cint
  TNlink* {.importc: "nlink_t", header: "<sys/types.h>".} = Int
  TOff* {.importc: "off_t", header: "<sys/types.h>".} = Int64
  TPid* {.importc: "pid_t", header: "<sys/types.h>".} = Int
  TpthreadAttr* {.importc: "pthread_attr_t", header: "<sys/types.h>".} = Int
  TpthreadBarrier* {.importc: "pthread_barrier_t", 
                      header: "<sys/types.h>".} = Int
  TpthreadBarrierattr* {.importc: "pthread_barrierattr_t", 
                          header: "<sys/types.h>".} = Int
  TpthreadCond* {.importc: "pthread_cond_t", header: "<sys/types.h>".} = Int
  TpthreadCondattr* {.importc: "pthread_condattr_t", 
                       header: "<sys/types.h>".} = Int
  TpthreadKey* {.importc: "pthread_key_t", header: "<sys/types.h>".} = Int
  TpthreadMutex* {.importc: "pthread_mutex_t", header: "<sys/types.h>".} = Int
  TpthreadMutexattr* {.importc: "pthread_mutexattr_t", 
                        header: "<sys/types.h>".} = Int
  TpthreadOnce* {.importc: "pthread_once_t", header: "<sys/types.h>".} = Int
  TpthreadRwlock* {.importc: "pthread_rwlock_t", 
                     header: "<sys/types.h>".} = Int
  TpthreadRwlockattr* {.importc: "pthread_rwlockattr_t", 
                         header: "<sys/types.h>".} = Int
  TpthreadSpinlock* {.importc: "pthread_spinlock_t", 
                       header: "<sys/types.h>".} = Int
  Tpthread* {.importc: "pthread_t", header: "<sys/types.h>".} = Int
  Tsuseconds* {.importc: "suseconds_t", header: "<sys/types.h>".} = Int
  #Ttime* {.importc: "time_t", header: "<sys/types.h>".} = int
  Ttimer* {.importc: "timer_t", header: "<sys/types.h>".} = Int
  TtraceAttr* {.importc: "trace_attr_t", header: "<sys/types.h>".} = Int
  TtraceEventId* {.importc: "trace_event_id_t", 
                     header: "<sys/types.h>".} = Int
  TtraceEventSet* {.importc: "trace_event_set_t", 
                      header: "<sys/types.h>".} = Int
  TtraceId* {.importc: "trace_id_t", header: "<sys/types.h>".} = Int
  Tuid* {.importc: "uid_t", header: "<sys/types.h>".} = Int
  Tuseconds* {.importc: "useconds_t", header: "<sys/types.h>".} = Int
  
  Tutsname* {.importc: "struct utsname", 
              header: "<sys/utsname.h>", 
              final, pure.} = object ## struct utsname
    sysname*,      ## Name of this implementation of the operating system. 
      nodename*,   ## Name of this node within the communications 
                   ## network to which this node is attached, if any. 
      release*,    ## Current release level of this implementation. 
      version*,    ## Current version level of this release. 
      machine*: Array [0..255, Char] ## Name of the hardware type on which the
                                     ## system is running. 

  TSem* {.importc: "sem_t", header: "<semaphore.h>", final, pure.} = object
  TipcPerm* {.importc: "struct ipc_perm", 
               header: "<sys/ipc.h>", final, pure.} = object ## struct ipc_perm
    uid*: Tuid    ## Owner's user ID. 
    gid*: tgid    ## Owner's group ID. 
    cuid*: Tuid   ## Creator's user ID. 
    cgid*: Tgid   ## Creator's group ID. 
    mode*: TMode  ## Read/write permission. 
  
  TStat* {.importc: "struct stat", 
           header: "<sys/stat.h>", final, pure.} = object ## struct stat
    st_dev*: TDev          ## Device ID of device containing file. 
    st_ino*: Tino          ## File serial number. 
    st_mode*: TMode        ## Mode of file (see below). 
    st_nlink*: tnlink      ## Number of hard links to the file. 
    st_uid*: Tuid          ## User ID of file. 
    st_gid*: Tgid          ## Group ID of file. 
    st_rdev*: TDev         ## Device ID (if file is character or block special). 
    st_size*: TOff         ## For regular files, the file size in bytes. 
                           ## For symbolic links, the length in bytes of the 
                           ## pathname contained in the symbolic link. 
                           ## For a shared memory object, the length in bytes. 
                           ## For a typed memory object, the length in bytes. 
                           ## For other file types, the use of this field is 
                           ## unspecified. 
    st_atime*: ttime       ## Time of last access. 
    st_mtime*: ttime       ## Time of last data modification. 
    st_ctime*: ttime       ## Time of last status change. 
    st_blksize*: Tblksize  ## A file system-specific preferred I/O block size  
                           ## for this object. In some file system types, this 
                           ## may vary from file to file. 
    st_blocks*: Tblkcnt    ## Number of blocks allocated for this object. 

  
  TStatvfs* {.importc: "struct statvfs", header: "<sys/statvfs.h>", 
              final, pure.} = object ## struct statvfs
    f_bsize*: Int        ## File system block size. 
    f_frsize*: Int       ## Fundamental file system block size. 
    f_blocks*: Tfsblkcnt ## Total number of blocks on file system
                         ## in units of f_frsize. 
    f_bfree*: Tfsblkcnt  ## Total number of free blocks. 
    f_bavail*: Tfsblkcnt ## Number of free blocks available to 
                         ## non-privileged process. 
    f_files*: Tfsfilcnt  ## Total number of file serial numbers. 
    f_ffree*: Tfsfilcnt  ## Total number of free file serial numbers. 
    f_favail*: Tfsfilcnt ## Number of file serial numbers available to 
                         ## non-privileged process. 
    f_fsid*: Int         ## File system ID. 
    f_flag*: Int         ## Bit mask of f_flag values. 
    f_namemax*: Int      ## Maximum filename length. 

  TposixTypedMemInfo* {.importc: "struct posix_typed_mem_info", 
                           header: "<sys/mman.h>", final, pure.} = object
    posix_tmi_length*: Int
  
  Ttm* {.importc: "struct tm", header: "<time.h>", 
         final, pure.} = object ## struct tm
    tm_sec*: Cint   ## Seconds [0,60]. 
    tm_min*: Cint   ## Minutes [0,59]. 
    tm_hour*: Cint  ## Hour [0,23]. 
    tm_mday*: Cint  ## Day of month [1,31]. 
    tm_mon*: Cint   ## Month of year [0,11]. 
    tm_year*: Cint  ## Years since 1900. 
    tm_wday*: Cint  ## Day of week [0,6] (Sunday =0). 
    tm_yday*: Cint  ## Day of year [0,365]. 
    tm_isdst*: Cint ## Daylight Savings flag. 
  Ttimespec* {.importc: "struct timespec", 
               header: "<time.h>", final, pure.} = object ## struct timespec
    tv_sec*: Ttime ## Seconds. 
    tv_nsec*: Int  ## Nanoseconds. 
  Titimerspec* {.importc: "struct itimerspec", header: "<time.h>", 
                 final, pure.} = object ## struct itimerspec
    it_interval*: Ttimespec ## Timer period. 
    it_value*: Ttimespec    ## Timer expiration. 
  
  TsigAtomic* {.importc: "sig_atomic_t", header: "<signal.h>".} = Cint
    ## Possibly volatile-qualified integer type of an object that can be 
    ## accessed as an atomic entity, even in the presence of asynchronous
    ## interrupts.
  Tsigset* {.importc: "sigset_t", header: "<signal.h>", final, pure.} = object
  
  TsigEvent* {.importc: "struct sigevent", 
               header: "<signal.h>", final, pure.} = object ## struct sigevent
    sigev_notify*: Cint           ## Notification type. 
    sigev_signo*: Cint            ## Signal number. 
    sigev_value*: TsigVal         ## Signal value. 
    sigev_notify_function*: proc (x: TsigVal) {.noconv.} ## Notification func. 
    sigev_notify_attributes*: ptr TpthreadAttr ## Notification attributes.

  TsigVal* {.importc: "union sigval", 
             header: "<signal.h>", final, pure.} = object ## struct sigval
    sival_ptr*: Pointer ## pointer signal value; 
                        ## integer signal value not defined!
  TSigaction* {.importc: "struct sigaction", 
                header: "<signal.h>", final, pure.} = object ## struct sigaction
    sa_handler*: proc (x: Cint) {.noconv.}  ## Pointer to a signal-catching
                                            ## function or one of the macros 
                                            ## SIG_IGN or SIG_DFL. 
    sa_mask*: Tsigset ## Set of signals to be blocked during execution of 
                      ## the signal handling function. 
    sa_flags*: Cint   ## Special flags. 
    sa_sigaction*: proc (x: Cint, y: var TsigInfo, z: Pointer) {.noconv.}

  TStack* {.importc: "stack_t",
            header: "<signal.h>", final, pure.} = object ## stack_t
    ss_sp*: Pointer  ## Stack base or pointer. 
    ss_size*: Int    ## Stack size. 
    ss_flags*: Cint  ## Flags. 

  TSigStack* {.importc: "struct sigstack", 
               header: "<signal.h>", final, pure.} = object ## struct sigstack
    ss_onstack*: Cint ## Non-zero when signal stack is in use. 
    ss_sp*: Pointer   ## Signal stack pointer. 

  TsigInfo* {.importc: "siginfo_t", 
              header: "<signal.h>", final, pure.} = object ## siginfo_t
    si_signo*: Cint    ## Signal number. 
    si_code*: Cint     ## Signal code. 
    si_errno*: Cint    ## If non-zero, an errno value associated with 
                       ## this signal, as defined in <errno.h>. 
    si_pid*: tpid      ## Sending process ID. 
    si_uid*: Tuid      ## Real user ID of sending process. 
    si_addr*: Pointer  ## Address of faulting instruction. 
    si_status*: Cint   ## Exit value or signal. 
    si_band*: Int      ## Band event for SIGPOLL. 
    si_value*: TsigVal ## Signal value. 
  
  TnlItem* {.importc: "nl_item", header: "<nl_types.h>".} = Cint
  TnlCatd* {.importc: "nl_catd", header: "<nl_types.h>".} = Cint

  TschedParam* {.importc: "struct sched_param", 
                  header: "<sched.h>", 
                  final, pure.} = object ## struct sched_param
    sched_priority*: Cint
    sched_ss_low_priority*: Cint     ## Low scheduling priority for 
                                     ## sporadic server. 
    sched_ss_repl_period*: Ttimespec ## Replenishment period for 
                                     ## sporadic server. 
    sched_ss_init_budget*: Ttimespec ## Initial budget for sporadic server. 
    sched_ss_max_repl*: Cint         ## Maximum pending replenishments for 
                                     ## sporadic server. 

  Ttimeval* {.importc: "struct timeval", header: "<sys/select.h>", 
              final, pure.} = object ## struct timeval
    tv_sec*: Int       ## Seconds. 
    tv_usec*: Int ## Microseconds. 
  TfdSet* {.importc: "fd_set", header: "<sys/select.h>", 
             final, pure.} = object
  Tmcontext* {.importc: "mcontext_t", header: "<ucontext.h>", 
               final, pure.} = object
  Tucontext* {.importc: "ucontext_t", header: "<ucontext.h>", 
               final, pure.} = object ## ucontext_t
    uc_link*: ptr Tucontext ## Pointer to the context that is resumed 
                            ## when this context returns. 
    uc_sigmask*: Tsigset    ## The set of signals that are blocked when this 
                            ## context is active. 
    uc_stack*: TStack       ## The stack used by this context. 
    uc_mcontext*: Tmcontext ## A machine-specific representation of the saved 
                            ## context. 

when hasAioH:
  type
    Taiocb* {.importc: "struct aiocb", header: "<aio.h>", 
              final, pure.} = object ## struct aiocb
      aio_fildes*: cint         ## File descriptor. 
      aio_offset*: TOff         ## File offset. 
      aio_buf*: pointer         ## Location of buffer. 
      aio_nbytes*: int          ## Length of transfer. 
      aio_reqprio*: cint        ## Request priority offset. 
      aio_sigevent*: TSigEvent  ## Signal number and value. 
      aio_lio_opcode: cint      ## Operation to be performed. 
 
when hasSpawnH:
  type
    TposixSpawnattr* {.importc: "posix_spawnattr_t", 
                        header: "<spawn.h>", final, pure.} = object
    TposixSpawnFileActions* {.importc: "posix_spawn_file_actions_t", 
                                 header: "<spawn.h>", final, pure.} = object

type
  TSocklen* {.importc: "socklen_t", header: "<sys/socket.h>".} = Cuint
  TSa_Family* {.importc: "sa_family_t", header: "<sys/socket.h>".} = Cint
  
  TSockAddr* {.importc: "struct sockaddr", header: "<sys/socket.h>", 
               pure, final.} = object ## struct sockaddr
    sa_family*: Tsa_family         ## Address family. 
    sa_data*: Array [0..255, Char] ## Socket address (variable-length data). 
  
  TsockaddrStorage* {.importc: "struct sockaddr_storage",
                       header: "<sys/socket.h>", 
                       pure, final.} = object ## struct sockaddr_storage
    ss_family*: Tsa_family ## Address family. 

  TifNameindex* {.importc: "struct if_nameindex", final, 
                   pure, header: "<net/if.h>".} = object ## struct if_nameindex
    if_index*: Cint   ## Numeric index of the interface. 
    if_name*: Cstring ## Null-terminated name of the interface. 


  TIOVec* {.importc: "struct iovec", pure, final,
            header: "<sys/uio.h>".} = object ## struct iovec
    iov_base*: Pointer ## Base address of a memory region for input or output. 
    iov_len*: Int    ## The size of the memory pointed to by iov_base. 
    
  Tmsghdr* {.importc: "struct msghdr", pure, final,
             header: "<sys/socket.h>".} = object  ## struct msghdr
    msg_name*: Pointer  ## Optional address. 
    msg_namelen*: TSockLen  ## Size of address. 
    msg_iov*: ptr TIOVec    ## Scatter/gather array. 
    msg_iovlen*: Cint   ## Members in msg_iov. 
    msg_control*: Pointer  ## Ancillary data; see below. 
    msg_controllen*: TSockLen ## Ancillary data buffer len. 
    msg_flags*: Cint ## Flags on received message. 


  Tcmsghdr* {.importc: "struct cmsghdr", pure, final, 
              header: "<sys/socket.h>".} = object ## struct cmsghdr
    cmsg_len*: TSockLen ## Data byte count, including the cmsghdr. 
    cmsg_level*: Cint   ## Originating protocol. 
    cmsg_type*: Cint    ## Protocol-specific type. 

  TLinger* {.importc: "struct linger", pure, final, 
             header: "<sys/socket.h>".} = object ## struct linger
    l_onoff*: Cint  ## Indicates whether linger option is enabled. 
    l_linger*: Cint ## Linger time, in seconds. 
  
  TInPort* = Int16 ## unsigned!
  TInAddrScalar* = Int32 ## unsigned!

  TInAddrT* {.importc: "in_addr_t", pure, final,
             header: "<netinet/in.h>".} = Int32 ## unsigned!

  TInAddr* {.importc: "struct in_addr", pure, final, 
             header: "<netinet/in.h>".} = object ## struct in_addr
    s_addr*: TInAddrScalar

  TsockaddrIn* {.importc: "struct sockaddr_in", pure, final, 
                  header: "<netinet/in.h>".} = object ## struct sockaddr_in
    sin_family*: TSa_family ## AF_INET. 
    sin_port*: TInPort      ## Port number. 
    sin_addr*: TInAddr      ## IP address. 

  TIn6Addr* {.importc: "struct in6_addr", pure, final,
              header: "<netinet/in.h>".} = object ## struct in6_addr
    s6_addr*: Array [0..15, Char]

  TsockaddrIn6* {.importc: "struct sockaddr_in6", pure, final,
                   header: "<netinet/in.h>".} = object ## struct sockaddr_in6
    sin6_family*: TSa_family ## AF_INET6. 
    sin6_port*: TInPort      ## Port number. 
    sin6_flowinfo*: Int32    ## IPv6 traffic class and flow information. 
    sin6_addr*: Tin6Addr     ## IPv6 address. 
    sin6_scope_id*: Int32    ## Set of interfaces for a scope. 
  
  Tipv6Mreq* {.importc: "struct ipv6_mreq", pure, final, 
                header: "<netinet/in.h>".} = object ## struct ipv6_mreq
    ipv6mr_multiaddr*: TIn6Addr ## IPv6 multicast address. 
    ipv6mr_interface*: Cint     ## Interface index. 

  Thostent* {.importc: "struct hostent", pure, final, 
              header: "<netdb.h>".} = object ## struct hostent
    h_name*: Cstring           ## Official name of the host. 
    h_aliases*: CstringArray   ## A pointer to an array of pointers to 
                               ## alternative host names, terminated by a 
                               ## null pointer. 
    h_addrtype*: Cint          ## Address type. 
    h_length*: Cint            ## The length, in bytes, of the address. 
    h_addr_list*: CstringArray ## A pointer to an array of pointers to network 
                               ## addresses (in network byte order) for the
                               ## host, terminated by a null pointer. 

  Tnetent* {.importc: "struct netent", pure, final, 
              header: "<netdb.h>".} = object ## struct netent
    n_name*: Cstring         ## Official, fully-qualified (including the 
                             ## domain) name of the host. 
    n_aliases*: CstringArray ## A pointer to an array of pointers to 
                             ## alternative network names, terminated by a 
                             ## null pointer. 
    n_addrtype*: Cint        ## The address type of the network. 
    n_net*: Int32            ## The network number, in host byte order. 

  TProtoent* {.importc: "struct protoent", pure, final, 
              header: "<netdb.h>".} = object ## struct protoent
    p_name*: Cstring         ## Official name of the protocol. 
    p_aliases*: CstringArray ## A pointer to an array of pointers to 
                             ## alternative protocol names, terminated by 
                             ## a null pointer. 
    p_proto*: Cint           ## The protocol number. 

  TServent* {.importc: "struct servent", pure, final, 
              header: "<netdb.h>".} = object ## struct servent
    s_name*: Cstring         ## Official name of the service. 
    s_aliases*: CstringArray ## A pointer to an array of pointers to 
                             ## alternative service names, terminated by 
                             ## a null pointer. 
    s_port*: Cint            ## The port number at which the service 
                             ## resides, in network byte order. 
    s_proto*: Cstring        ## The name of the protocol to use when 
                             ## contacting the service. 

  Taddrinfo* {.importc: "struct addrinfo", pure, final, 
              header: "<netdb.h>".} = object ## struct addrinfo
    ai_flags*: Cint         ## Input flags. 
    ai_family*: Cint        ## Address family of socket. 
    ai_socktype*: Cint      ## Socket type. 
    ai_protocol*: Cint      ## Protocol of socket. 
    ai_addrlen*: TSockLen   ## Length of socket address. 
    ai_addr*: ptr TSockAddr ## Socket address of socket. 
    ai_canonname*: Cstring  ## Canonical name of service location. 
    ai_next*: ptr Taddrinfo ## Pointer to next in list. 
  
  TPollfd* {.importc: "struct pollfd", pure, final, 
             header: "<poll.h>".} = object ## struct pollfd
    fd*: Cint        ## The following descriptor being polled. 
    events*: Cshort  ## The input event flags (see below). 
    revents*: Cshort ## The output event flags (see below).  
  
  Tnfds* {.importc: "nfds_t", header: "<poll.h>".} = Cint

var
  errno* {.importc, header: "<errno.h>".}: Cint ## error variable
  h_errno* {.importc, header: "<netdb.h>".}: Cint
  daylight* {.importc, header: "<time.h>".}: Cint
  timezone* {.importc, header: "<time.h>".}: Int
  
# Constants as variables:
when hasAioH:
  var
    AIO_ALLDONE* {.importc, header: "<aio.h>".}: cint
      ## A return value indicating that none of the requested operations 
      ## could be canceled since they are already complete.
    AIO_CANCELED* {.importc, header: "<aio.h>".}: cint
      ## A return value indicating that all requested operations have
      ## been canceled.
    AIO_NOTCANCELED* {.importc, header: "<aio.h>".}: cint
      ## A return value indicating that some of the requested operations could 
      ## not be canceled since they are in progress.
    LIO_NOP* {.importc, header: "<aio.h>".}: cint
      ## A lio_listio() element operation option indicating that no transfer is
      ## requested.
    LIO_NOWAIT* {.importc, header: "<aio.h>".}: cint
      ## A lio_listio() synchronization operation indicating that the calling 
      ## thread is to continue execution while the lio_listio() operation is 
      ## being performed, and no notification is given when the operation is
      ## complete.
    LIO_READ* {.importc, header: "<aio.h>".}: cint
      ## A lio_listio() element operation option requesting a read.
    LIO_WAIT* {.importc, header: "<aio.h>".}: cint
      ## A lio_listio() synchronization operation indicating that the calling 
      ## thread is to suspend until the lio_listio() operation is complete.
    LIO_WRITE* {.importc, header: "<aio.h>".}: cint
      ## A lio_listio() element operation option requesting a write.

var
  RTLD_LAZY* {.importc, header: "<dlfcn.h>".}: Cint
    ## Relocations are performed at an implementation-defined time.
  RTLD_NOW* {.importc, header: "<dlfcn.h>".}: Cint
    ## Relocations are performed when the object is loaded.
  RTLD_GLOBAL* {.importc, header: "<dlfcn.h>".}: Cint
    ## All symbols are available for relocation processing of other modules.
  RTLD_LOCAL* {.importc, header: "<dlfcn.h>".}: Cint
    ## All symbols are not made available for relocation processing by 
    ## other modules. 
    
  E2BIG* {.importc, header: "<errno.h>".}: Cint
      ## Argument list too long.
  EACCES* {.importc, header: "<errno.h>".}: Cint
      ## Permission denied.
  EADDRINUSE* {.importc, header: "<errno.h>".}: Cint
      ## Address in use.
  EADDRNOTAVAIL* {.importc, header: "<errno.h>".}: Cint
      ## Address not available.
  EAFNOSUPPORT* {.importc, header: "<errno.h>".}: Cint
      ## Address family not supported.
  EAGAIN* {.importc, header: "<errno.h>".}: Cint
      ## Resource unavailable, try again (may be the same value as EWOULDBLOCK).
  EALREADY* {.importc, header: "<errno.h>".}: Cint
      ## Connection already in progress.
  EBADF* {.importc, header: "<errno.h>".}: Cint
      ## Bad file descriptor.
  EBADMSG* {.importc, header: "<errno.h>".}: Cint
      ## Bad message.
  EBUSY* {.importc, header: "<errno.h>".}: Cint
      ## Device or resource busy.
  ECANCELED* {.importc, header: "<errno.h>".}: Cint
      ## Operation canceled.
  ECHILD* {.importc, header: "<errno.h>".}: Cint
      ## No child processes.
  ECONNABORTED* {.importc, header: "<errno.h>".}: Cint
      ## Connection aborted.
  ECONNREFUSED* {.importc, header: "<errno.h>".}: Cint
      ## Connection refused.
  ECONNRESET* {.importc, header: "<errno.h>".}: Cint
      ## Connection reset.
  EDEADLK* {.importc, header: "<errno.h>".}: Cint
      ## Resource deadlock would occur.
  EDESTADDRREQ* {.importc, header: "<errno.h>".}: Cint
      ## Destination address required.
  EDOM* {.importc, header: "<errno.h>".}: Cint
      ## Mathematics argument out of domain of function.
  EDQUOT* {.importc, header: "<errno.h>".}: Cint
      ## Reserved.
  EEXIST* {.importc, header: "<errno.h>".}: Cint
      ## File exists.
  EFAULT* {.importc, header: "<errno.h>".}: Cint
      ## Bad address.
  EFBIG* {.importc, header: "<errno.h>".}: Cint
      ## File too large.
  EHOSTUNREACH* {.importc, header: "<errno.h>".}: Cint
      ## Host is unreachable.
  EIDRM* {.importc, header: "<errno.h>".}: Cint
      ## Identifier removed.
  EILSEQ* {.importc, header: "<errno.h>".}: Cint
      ## Illegal byte sequence.
  EINPROGRESS* {.importc, header: "<errno.h>".}: Cint
      ## Operation in progress.
  EINTR* {.importc, header: "<errno.h>".}: Cint
      ## Interrupted function.
  EINVAL* {.importc, header: "<errno.h>".}: Cint
      ## Invalid argument.
  EIO* {.importc, header: "<errno.h>".}: Cint
      ## I/O error.
  EISCONN* {.importc, header: "<errno.h>".}: Cint
      ## Socket is connected.
  EISDIR* {.importc, header: "<errno.h>".}: Cint
      ## Is a directory.
  ELOOP* {.importc, header: "<errno.h>".}: Cint
      ## Too many levels of symbolic links.
  EMFILE* {.importc, header: "<errno.h>".}: Cint
      ## Too many open files.
  EMLINK* {.importc, header: "<errno.h>".}: Cint
      ## Too many links.
  EMSGSIZE* {.importc, header: "<errno.h>".}: Cint
      ## Message too large.
  EMULTIHOP* {.importc, header: "<errno.h>".}: Cint
      ## Reserved.
  ENAMETOOLONG* {.importc, header: "<errno.h>".}: Cint
      ## Filename too long.
  ENETDOWN* {.importc, header: "<errno.h>".}: Cint
      ## Network is down.
  ENETRESET* {.importc, header: "<errno.h>".}: Cint
      ## Connection aborted by network.
  ENETUNREACH* {.importc, header: "<errno.h>".}: Cint
      ## Network unreachable.
  ENFILE* {.importc, header: "<errno.h>".}: Cint
      ## Too many files open in system.
  ENOBUFS* {.importc, header: "<errno.h>".}: Cint
      ## No buffer space available.
  ENODATA* {.importc, header: "<errno.h>".}: Cint
      ## No message is available on the STREAM head read queue.
  ENODEV* {.importc, header: "<errno.h>".}: Cint
      ## No such device.
  ENOENT* {.importc, header: "<errno.h>".}: Cint
      ## No such file or directory.
  ENOEXEC* {.importc, header: "<errno.h>".}: Cint
      ## Executable file format error.
  ENOLCK* {.importc, header: "<errno.h>".}: Cint
      ## No locks available.
  ENOLINK* {.importc, header: "<errno.h>".}: Cint
      ## Reserved.
  ENOMEM* {.importc, header: "<errno.h>".}: Cint
      ## Not enough space.
  ENOMSG* {.importc, header: "<errno.h>".}: Cint
      ## No message of the desired type.
  ENOPROTOOPT* {.importc, header: "<errno.h>".}: Cint
      ## Protocol not available.
  ENOSPC* {.importc, header: "<errno.h>".}: Cint
      ## No space left on device.
  ENOSR* {.importc, header: "<errno.h>".}: Cint
      ## No STREAM resources.
  ENOSTR* {.importc, header: "<errno.h>".}: Cint
      ## Not a STREAM.
  ENOSYS* {.importc, header: "<errno.h>".}: Cint
      ## Function not supported.
  ENOTCONN* {.importc, header: "<errno.h>".}: Cint
      ## The socket is not connected.
  ENOTDIR* {.importc, header: "<errno.h>".}: Cint
      ## Not a directory.
  ENOTEMPTY* {.importc, header: "<errno.h>".}: Cint
      ## Directory not empty.
  ENOTSOCK* {.importc, header: "<errno.h>".}: Cint
      ## Not a socket.
  ENOTSUP* {.importc, header: "<errno.h>".}: Cint
      ## Not supported.
  ENOTTY* {.importc, header: "<errno.h>".}: Cint
      ## Inappropriate I/O control operation.
  ENXIO* {.importc, header: "<errno.h>".}: Cint
      ## No such device or address.
  EOPNOTSUPP* {.importc, header: "<errno.h>".}: Cint
      ## Operation not supported on socket.
  EOVERFLOW* {.importc, header: "<errno.h>".}: Cint
      ## Value too large to be stored in data type.
  EPERM* {.importc, header: "<errno.h>".}: Cint
      ## Operation not permitted.
  EPIPE* {.importc, header: "<errno.h>".}: Cint
      ## Broken pipe.
  EPROTO* {.importc, header: "<errno.h>".}: Cint
      ## Protocol error.
  EPROTONOSUPPORT* {.importc, header: "<errno.h>".}: Cint
      ## Protocol not supported.
  EPROTOTYPE* {.importc, header: "<errno.h>".}: Cint
      ## Protocol wrong type for socket.
  ERANGE* {.importc, header: "<errno.h>".}: Cint
      ## Result too large.
  EROFS* {.importc, header: "<errno.h>".}: Cint
      ## Read-only file system.
  ESPIPE* {.importc, header: "<errno.h>".}: Cint
      ## Invalid seek.
  ESRCH* {.importc, header: "<errno.h>".}: Cint
      ## No such process.
  ESTALE* {.importc, header: "<errno.h>".}: Cint
      ## Reserved.
  ETIME* {.importc, header: "<errno.h>".}: Cint
      ## Stream ioctl() timeout.
  ETIMEDOUT* {.importc, header: "<errno.h>".}: Cint
      ## Connection timed out.
  ETXTBSY* {.importc, header: "<errno.h>".}: Cint
      ## Text file busy.
  EWOULDBLOCK* {.importc, header: "<errno.h>".}: Cint
      ## Operation would block (may be the same value as [EAGAIN]).
  EXDEV* {.importc, header: "<errno.h>".}: Cint
      ## Cross-device link.   

  F_DUPFD* {.importc, header: "<fcntl.h>".}: Cint
    ## Duplicate file descriptor.
  F_GETFD* {.importc, header: "<fcntl.h>".}: Cint
    ## Get file descriptor flags.
  F_SETFD* {.importc, header: "<fcntl.h>".}: Cint
    ## Set file descriptor flags.
  F_GETFL* {.importc, header: "<fcntl.h>".}: Cint
    ## Get file status flags and file access modes.
  F_SETFL* {.importc, header: "<fcntl.h>".}: Cint
    ## Set file status flags.
  F_GETLK* {.importc, header: "<fcntl.h>".}: Cint
    ## Get record locking information.
  F_SETLK* {.importc, header: "<fcntl.h>".}: Cint
    ## Set record locking information.
  F_SETLKW* {.importc, header: "<fcntl.h>".}: Cint
    ## Set record locking information; wait if blocked.
  F_GETOWN* {.importc, header: "<fcntl.h>".}: Cint
    ## Get process or process group ID to receive SIGURG signals.
  F_SETOWN* {.importc, header: "<fcntl.h>".}: Cint
    ## Set process or process group ID to receive SIGURG signals. 
  FD_CLOEXEC* {.importc, header: "<fcntl.h>".}: Cint
    ## Close the file descriptor upon execution of an exec family function. 
  F_RDLCK* {.importc, header: "<fcntl.h>".}: Cint
    ## Shared or read lock.
  F_UNLCK* {.importc, header: "<fcntl.h>".}: Cint
    ## Unlock.
  F_WRLCK* {.importc, header: "<fcntl.h>".}: Cint
    ## Exclusive or write lock. 
  O_CREAT* {.importc, header: "<fcntl.h>".}: Cint
    ## Create file if it does not exist.
  O_EXCL* {.importc, header: "<fcntl.h>".}: Cint
    ## Exclusive use flag.
  O_NOCTTY* {.importc, header: "<fcntl.h>".}: Cint
    ## Do not assign controlling terminal.
  O_TRUNC* {.importc, header: "<fcntl.h>".}: Cint
    ## Truncate flag. 
  O_APPEND* {.importc, header: "<fcntl.h>".}: Cint
    ## Set append mode.
  O_DSYNC* {.importc, header: "<fcntl.h>".}: Cint
    ## Write according to synchronized I/O data integrity completion.
  O_NONBLOCK* {.importc, header: "<fcntl.h>".}: Cint
    ## Non-blocking mode.
  O_RSYNC* {.importc, header: "<fcntl.h>".}: Cint
    ## Synchronized read I/O operations.
  O_SYNC* {.importc, header: "<fcntl.h>".}: Cint
    ## Write according to synchronized I/O file integrity completion. 
  O_ACCMODE* {.importc, header: "<fcntl.h>".}: Cint
    ## Mask for file access modes.      
  O_RDONLY* {.importc, header: "<fcntl.h>".}: Cint
    ## Open for reading only.
  O_RDWR* {.importc, header: "<fcntl.h>".}: Cint
    ## Open for reading and writing.
  O_WRONLY* {.importc, header: "<fcntl.h>".}: Cint
    ## Open for writing only. 
  POSIX_FADV_NORMAL* {.importc, header: "<fcntl.h>".}: Cint
    ## The application has no advice to give on its behavior with
    ## respect to the specified data. It is the default characteristic
    ## if no advice is given for an open file.
  POSIX_FADV_SEQUENTIAL* {.importc, header: "<fcntl.h>".}: Cint
    ## The application expects to access the specified data 
    # sequentially from lower offsets to higher offsets.
  POSIX_FADV_RANDOM* {.importc, header: "<fcntl.h>".}: Cint
    ## The application expects to access the specified data in a random order.
  POSIX_FADV_WILLNEED* {.importc, header: "<fcntl.h>".}: Cint
    ## The application expects to access the specified data in the near future.
  POSIX_FADV_DONTNEED* {.importc, header: "<fcntl.h>".}: Cint
    ## The application expects that it will not access the specified data
    ## in the near future.
  POSIX_FADV_NOREUSE* {.importc, header: "<fcntl.h>".}: Cint
    ## The application expects to access the specified data once and 
    ## then not reuse it thereafter. 

  FE_DIVBYZERO* {.importc, header: "<fenv.h>".}: Cint
  FE_INEXACT* {.importc, header: "<fenv.h>".}: Cint
  FE_INVALID* {.importc, header: "<fenv.h>".}: Cint
  FE_OVERFLOW* {.importc, header: "<fenv.h>".}: Cint
  FE_UNDERFLOW* {.importc, header: "<fenv.h>".}: Cint
  FE_ALL_EXCEPT* {.importc, header: "<fenv.h>".}: Cint
  FE_DOWNWARD* {.importc, header: "<fenv.h>".}: Cint
  FE_TONEAREST* {.importc, header: "<fenv.h>".}: Cint
  FE_TOWARDZERO* {.importc, header: "<fenv.h>".}: Cint
  FE_UPWARD* {.importc, header: "<fenv.h>".}: Cint
  FE_DFL_ENV* {.importc, header: "<fenv.h>".}: Cint

  MM_HARD* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Source of the condition is hardware.
  MM_SOFT* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Source of the condition is software.
  MM_FIRM* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Source of the condition is firmware.
  MM_APPL* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Condition detected by application.
  MM_UTIL* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Condition detected by utility.
  MM_OPSYS* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Condition detected by operating system.
  MM_RECOVER* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Recoverable error.
  MM_NRECOV* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Non-recoverable error.
  MM_HALT* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Error causing application to halt.
  MM_ERROR* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Application has encountered a non-fatal fault.
  MM_WARNING* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Application has detected unusual non-error condition.
  MM_INFO* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Informative message.
  MM_NOSEV* {.importc, header: "<fmtmsg.h>".}: Cint
    ## No severity level provided for the message.
  MM_PRINT* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Display message on standard error.
  MM_CONSOLE* {.importc, header: "<fmtmsg.h>".}: Cint
    ## Display message on system console. 

  MM_OK* {.importc, header: "<fmtmsg.h>".}: Cint
    ## The function succeeded.
  MM_NOTOK* {.importc, header: "<fmtmsg.h>".}: Cint
    ## The function failed completely.
  MM_NOMSG* {.importc, header: "<fmtmsg.h>".}: Cint
    ## The function was unable to generate a message on standard error, 
    ## but otherwise succeeded.
  MM_NOCON* {.importc, header: "<fmtmsg.h>".}: Cint
    ## The function was unable to generate a console message, but 
    ## otherwise succeeded. 
    
  FNM_NOMATCH* {.importc, header: "<fnmatch.h>".}: Cint
    ## The string does not match the specified pattern.
  FNM_PATHNAME* {.importc, header: "<fnmatch.h>".}: Cint
    ## Slash in string only matches slash in pattern.
  FNM_PERIOD* {.importc, header: "<fnmatch.h>".}: Cint
    ## Leading period in string must be exactly matched by period in pattern.
  FNM_NOESCAPE* {.importc, header: "<fnmatch.h>".}: Cint
    ## Disable backslash escaping.
  FNM_NOSYS* {.importc, header: "<fnmatch.h>".}: Cint
    ## Reserved.

  FTW_F* {.importc, header: "<ftw.h>".}: Cint
    ## File.
  FTW_D* {.importc, header: "<ftw.h>".}: Cint
    ## Directory.
  FTW_DNR* {.importc, header: "<ftw.h>".}: Cint
    ## Directory without read permission.
  FTW_DP* {.importc, header: "<ftw.h>".}: Cint
    ## Directory with subdirectories visited.
  FTW_NS* {.importc, header: "<ftw.h>".}: Cint
    ## Unknown type; stat() failed.
  FTW_SL* {.importc, header: "<ftw.h>".}: Cint
    ## Symbolic link.
  FTW_SLN* {.importc, header: "<ftw.h>".}: Cint
    ## Symbolic link that names a nonexistent file.

  FTW_PHYS* {.importc, header: "<ftw.h>".}: Cint
    ## Physical walk, does not follow symbolic links. Otherwise, nftw() 
    ## follows links but does not walk down any path that crosses itself.
  FTW_MOUNT* {.importc, header: "<ftw.h>".}: Cint
    ## The walk does not cross a mount point.
  FTW_DEPTH* {.importc, header: "<ftw.h>".}: Cint
    ## All subdirectories are visited before the directory itself.
  FTW_CHDIR* {.importc, header: "<ftw.h>".}: Cint
    ## The walk changes to each directory before reading it. 

  GLOB_APPEND* {.importc, header: "<glob.h>".}: Cint
    ## Append generated pathnames to those previously obtained.
  GLOB_DOOFFS* {.importc, header: "<glob.h>".}: Cint
    ## Specify how many null pointers to add to the beginning of gl_pathv.
  GLOB_ERR* {.importc, header: "<glob.h>".}: Cint
    ## Cause glob() to return on error.
  GLOB_MARK* {.importc, header: "<glob.h>".}: Cint
    ## Each pathname that is a directory that matches pattern has a 
    ## slash appended.
  GLOB_NOCHECK* {.importc, header: "<glob.h>".}: Cint
    ## If pattern does not match any pathname, then return a list
    ## consisting of only pattern.
  GLOB_NOESCAPE* {.importc, header: "<glob.h>".}: Cint
    ## Disable backslash escaping.
  GLOB_NOSORT* {.importc, header: "<glob.h>".}: Cint
    ## Do not sort the pathnames returned.
  GLOB_ABORTED* {.importc, header: "<glob.h>".}: Cint
    ## The scan was stopped because GLOB_ERR was set or errfunc() 
    ## returned non-zero.
  GLOB_NOMATCH* {.importc, header: "<glob.h>".}: Cint
    ## The pattern does not match any existing pathname, and GLOB_NOCHECK 
    ## was not set in flags.
  GLOB_NOSPACE* {.importc, header: "<glob.h>".}: Cint
    ## An attempt to allocate memory failed.
  GLOB_NOSYS* {.importc, header: "<glob.h>".}: Cint
    ## Reserved

  CODESET* {.importc, header: "<langinfo.h>".}: Cint
    ## Codeset name.
  D_T_FMT* {.importc, header: "<langinfo.h>".}: Cint
    ## String for formatting date and time.
  D_FMT * {.importc, header: "<langinfo.h>".}: Cint
    ## Date format string.
  T_FMT* {.importc, header: "<langinfo.h>".}: Cint
    ## Time format string.
  T_FMT_AMPM* {.importc, header: "<langinfo.h>".}: Cint
    ## a.m. or p.m. time format string.
  AM_STR* {.importc, header: "<langinfo.h>".}: Cint
    ## Ante-meridiem affix.
  PM_STR* {.importc, header: "<langinfo.h>".}: Cint
    ## Post-meridiem affix.
  DAY_1* {.importc, header: "<langinfo.h>".}: Cint
    ## Name of the first day of the week (for example, Sunday).
  DAY_2* {.importc, header: "<langinfo.h>".}: Cint
    ## Name of the second day of the week (for example, Monday).
  DAY_3* {.importc, header: "<langinfo.h>".}: Cint
    ## Name of the third day of the week (for example, Tuesday).
  DAY_4* {.importc, header: "<langinfo.h>".}: Cint
    ## Name of the fourth day of the week (for example, Wednesday).
  DAY_5* {.importc, header: "<langinfo.h>".}: Cint
    ## Name of the fifth day of the week (for example, Thursday).
  DAY_6* {.importc, header: "<langinfo.h>".}: Cint
    ## Name of the sixth day of the week (for example, Friday).
  DAY_7* {.importc, header: "<langinfo.h>".}: Cint
    ## Name of the seventh day of the week (for example, Saturday).
  ABDAY_1* {.importc, header: "<langinfo.h>".}: Cint
    ## Abbreviated name of the first day of the week.
  ABDAY_2* {.importc, header: "<langinfo.h>".}: Cint
  ABDAY_3* {.importc, header: "<langinfo.h>".}: Cint
  ABDAY_4* {.importc, header: "<langinfo.h>".}: Cint
  ABDAY_5* {.importc, header: "<langinfo.h>".}: Cint
  ABDAY_6* {.importc, header: "<langinfo.h>".}: Cint
  ABDAY_7* {.importc, header: "<langinfo.h>".}: Cint
  MON_1* {.importc, header: "<langinfo.h>".}: Cint
    ## Name of the first month of the year.
  MON_2* {.importc, header: "<langinfo.h>".}: Cint
  MON_3* {.importc, header: "<langinfo.h>".}: Cint
  MON_4* {.importc, header: "<langinfo.h>".}: Cint
  MON_5* {.importc, header: "<langinfo.h>".}: Cint
  MON_6* {.importc, header: "<langinfo.h>".}: Cint
  MON_7* {.importc, header: "<langinfo.h>".}: Cint
  MON_8* {.importc, header: "<langinfo.h>".}: Cint
  MON_9* {.importc, header: "<langinfo.h>".}: Cint
  MON_10* {.importc, header: "<langinfo.h>".}: Cint
  MON_11* {.importc, header: "<langinfo.h>".}: Cint
  MON_12* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_1* {.importc, header: "<langinfo.h>".}: Cint
    ## Abbreviated name of the first month.
  ABMON_2* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_3* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_4* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_5* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_6* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_7* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_8* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_9* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_10* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_11* {.importc, header: "<langinfo.h>".}: Cint
  ABMON_12* {.importc, header: "<langinfo.h>".}: Cint
  ERA* {.importc, header: "<langinfo.h>".}: Cint
    ## Era description segments.
  ERA_D_FMT* {.importc, header: "<langinfo.h>".}: Cint
    ## Era date format string.
  ERA_D_T_FMT* {.importc, header: "<langinfo.h>".}: Cint
    ## Era date and time format string.
  ERA_T_FMT* {.importc, header: "<langinfo.h>".}: Cint
    ## Era time format string.
  ALT_DIGITS* {.importc, header: "<langinfo.h>".}: Cint
    ## Alternative symbols for digits.
  RADIXCHAR* {.importc, header: "<langinfo.h>".}: Cint
    ## Radix character.
  THOUSEP* {.importc, header: "<langinfo.h>".}: Cint
    ## Separator for thousands.
  YESEXPR* {.importc, header: "<langinfo.h>".}: Cint
    ## Affirmative response expression.
  NOEXPR* {.importc, header: "<langinfo.h>".}: Cint
    ## Negative response expression.
  CRNCYSTR* {.importc, header: "<langinfo.h>".}: Cint
    ## Local currency symbol, preceded by '-' if the symbol 
    ## should appear before the value, '+' if the symbol should appear 
    ## after the value, or '.' if the symbol should replace the radix
    ## character. If the local currency symbol is the empty string, 
    ## implementations may return the empty string ( "" ).

  LC_ALL* {.importc, header: "<locale.h>".}: Cint
  LC_COLLATE* {.importc, header: "<locale.h>".}: Cint
  LC_CTYPE* {.importc, header: "<locale.h>".}: Cint
  LC_MESSAGES* {.importc, header: "<locale.h>".}: Cint
  LC_MONETARY* {.importc, header: "<locale.h>".}: Cint
  LC_NUMERIC* {.importc, header: "<locale.h>".}: Cint
  LC_TIME* {.importc, header: "<locale.h>".}: Cint
  
  PTHREAD_BARRIER_SERIAL_THREAD* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_CANCEL_ASYNCHRONOUS* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_CANCEL_ENABLE* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_CANCEL_DEFERRED* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_CANCEL_DISABLE* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_CANCELED* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_COND_INITIALIZER* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_CREATE_DETACHED* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_CREATE_JOINABLE* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_EXPLICIT_SCHED* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_INHERIT_SCHED* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_MUTEX_DEFAULT* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_MUTEX_ERRORCHECK* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_MUTEX_INITIALIZER* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_MUTEX_NORMAL* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_MUTEX_RECURSIVE* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_ONCE_INIT* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_PRIO_INHERIT* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_PRIO_NONE* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_PRIO_PROTECT* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_PROCESS_SHARED* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_PROCESS_PRIVATE* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_SCOPE_PROCESS* {.importc, header: "<pthread.h>".}: Cint
  PTHREAD_SCOPE_SYSTEM* {.importc, header: "<pthread.h>".}: Cint

  posixAsyncIo* {.importc: "_POSIX_ASYNC_IO", header: "<unistd.h>".}: Cint
  posixPrioIo* {.importc: "_POSIX_PRIO_IO", header: "<unistd.h>".}: Cint
  posixSyncIo* {.importc: "_POSIX_SYNC_IO", header: "<unistd.h>".}: Cint
  fOk* {.importc: "F_OK", header: "<unistd.h>".}: Cint
  rOk* {.importc: "R_OK", header: "<unistd.h>".}: Cint
  wOk* {.importc: "W_OK", header: "<unistd.h>".}: Cint
  xOk* {.importc: "X_OK", header: "<unistd.h>".}: Cint

  csPath* {.importc: "_CS_PATH", header: "<unistd.h>".}: Cint
  csPosixV6Ilp32Off32Cflags* {.importc: "_CS_POSIX_V6_ILP32_OFF32_CFLAGS",
    header: "<unistd.h>".}: Cint
  csPosixV6Ilp32Off32Ldflags* {.
    importc: "_CS_POSIX_V6_ILP32_OFF32_LDFLAGS", header: "<unistd.h>".}: Cint
  csPosixV6Ilp32Off32Libs* {.importc: "_CS_POSIX_V6_ILP32_OFF32_LIBS",
    header: "<unistd.h>".}: Cint
  csPosixV6Ilp32OffbigCflags* {.
    importc: "_CS_POSIX_V6_ILP32_OFFBIG_CFLAGS", header: "<unistd.h>".}: Cint
  csPosixV6Ilp32OffbigLdflags* {.
    importc: "_CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS", header: "<unistd.h>".}: Cint
  csPosixV6Ilp32OffbigLibs* {.
    importc: "_CS_POSIX_V6_ILP32_OFFBIG_LIBS", header: "<unistd.h>".}: Cint
  csPosixV6Lp64Off64Cflags* {.
    importc: "_CS_POSIX_V6_LP64_OFF64_CFLAGS", header: "<unistd.h>".}: Cint
  csPosixV6Lp64Off64Ldflags* {.
    importc: "_CS_POSIX_V6_LP64_OFF64_LDFLAGS", header: "<unistd.h>".}: Cint
  csPosixV6Lp64Off64Libs* {.
    importc: "_CS_POSIX_V6_LP64_OFF64_LIBS", header: "<unistd.h>".}: Cint
  csPosixV6LpbigOffbigCflags* {.
    importc: "_CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS", header: "<unistd.h>".}: Cint
  csPosixV6LpbigOffbigLdflags* {.
    importc: "_CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS", header: "<unistd.h>".}: Cint
  csPosixV6LpbigOffbigLibs* {.
    importc: "_CS_POSIX_V6_LPBIG_OFFBIG_LIBS", header: "<unistd.h>".}: Cint
  csPosixV6WidthRestrictedEnvs* {.
    importc: "_CS_POSIX_V6_WIDTH_RESTRICTED_ENVS", header: "<unistd.h>".}: Cint
  fLock* {.importc: "F_LOCK", header: "<unistd.h>".}: Cint
  fTest* {.importc: "F_TEST", header: "<unistd.h>".}: Cint
  fTlock* {.importc: "F_TLOCK", header: "<unistd.h>".}: Cint
  fUlock* {.importc: "F_ULOCK", header: "<unistd.h>".}: Cint
  pc2Symlinks* {.importc: "_PC_2_SYMLINKS", header: "<unistd.h>".}: Cint
  pcAllocSizeMin* {.importc: "_PC_ALLOC_SIZE_MIN",
    header: "<unistd.h>".}: Cint
  pcAsyncIo* {.importc: "_PC_ASYNC_IO", header: "<unistd.h>".}: Cint
  pcChownRestricted* {.importc: "_PC_CHOWN_RESTRICTED", 
    header: "<unistd.h>".}: Cint
  pcFilesizebits* {.importc: "_PC_FILESIZEBITS", header: "<unistd.h>".}: Cint
  pcLinkMax* {.importc: "_PC_LINK_MAX", header: "<unistd.h>".}: Cint
  pcMaxCanon* {.importc: "_PC_MAX_CANON", header: "<unistd.h>".}: Cint

  pcMaxInput*{.importc: "_PC_MAX_INPUT", header: "<unistd.h>".}: Cint
  pcNameMax*{.importc: "_PC_NAME_MAX", header: "<unistd.h>".}: Cint
  pcNoTrunc*{.importc: "_PC_NO_TRUNC", header: "<unistd.h>".}: Cint
  pcPathMax*{.importc: "_PC_PATH_MAX", header: "<unistd.h>".}: Cint
  pcPipeBuf*{.importc: "_PC_PIPE_BUF", header: "<unistd.h>".}: Cint
  pcPrioIo*{.importc: "_PC_PRIO_IO", header: "<unistd.h>".}: Cint
  pcRecIncrXferSize*{.importc: "_PC_REC_INCR_XFER_SIZE", 
    header: "<unistd.h>".}: Cint
  pcRecMinXferSize*{.importc: "_PC_REC_MIN_XFER_SIZE", 
    header: "<unistd.h>".}: Cint
  pcRecXferAlign*{.importc: "_PC_REC_XFER_ALIGN", header: "<unistd.h>".}: Cint
  pcSymlinkMax*{.importc: "_PC_SYMLINK_MAX", header: "<unistd.h>".}: Cint
  pcSyncIo*{.importc: "_PC_SYNC_IO", header: "<unistd.h>".}: Cint
  pcVdisable*{.importc: "_PC_VDISABLE", header: "<unistd.h>".}: Cint
  sc2CBind*{.importc: "_SC_2_C_BIND", header: "<unistd.h>".}: Cint
  sc2CDev*{.importc: "_SC_2_C_DEV", header: "<unistd.h>".}: Cint
  sc2CharTerm*{.importc: "_SC_2_CHAR_TERM", header: "<unistd.h>".}: Cint
  sc2FortDev*{.importc: "_SC_2_FORT_DEV", header: "<unistd.h>".}: Cint
  sc2FortRun*{.importc: "_SC_2_FORT_RUN", header: "<unistd.h>".}: Cint
  sc2Localedef*{.importc: "_SC_2_LOCALEDEF", header: "<unistd.h>".}: Cint
  sc2Pbs*{.importc: "_SC_2_PBS", header: "<unistd.h>".}: Cint
  sc2PbsAccounting*{.importc: "_SC_2_PBS_ACCOUNTING", 
    header: "<unistd.h>".}: Cint
  sc2PbsCheckpoint*{.importc: "_SC_2_PBS_CHECKPOINT", 
    header: "<unistd.h>".}: Cint
  sc2PbsLocate*{.importc: "_SC_2_PBS_LOCATE", header: "<unistd.h>".}: Cint
  sc2PbsMessage*{.importc: "_SC_2_PBS_MESSAGE", header: "<unistd.h>".}: Cint
  sc2PbsTrack*{.importc: "_SC_2_PBS_TRACK", header: "<unistd.h>".}: Cint
  sc2SwDev*{.importc: "_SC_2_SW_DEV", header: "<unistd.h>".}: Cint
  sc2Upe*{.importc: "_SC_2_UPE", header: "<unistd.h>".}: Cint
  sc2Version*{.importc: "_SC_2_VERSION", header: "<unistd.h>".}: Cint
  scAdvisoryInfo*{.importc: "_SC_ADVISORY_INFO", header: "<unistd.h>".}: Cint
  scAioListioMax*{.importc: "_SC_AIO_LISTIO_MAX", header: "<unistd.h>".}: Cint
  scAioMax*{.importc: "_SC_AIO_MAX", header: "<unistd.h>".}: Cint
  scAioPrioDeltaMax*{.importc: "_SC_AIO_PRIO_DELTA_MAX", 
    header: "<unistd.h>".}: Cint
  scArgMax*{.importc: "_SC_ARG_MAX", header: "<unistd.h>".}: Cint
  scAsynchronousIo*{.importc: "_SC_ASYNCHRONOUS_IO", 
    header: "<unistd.h>".}: Cint
  scAtexitMax*{.importc: "_SC_ATEXIT_MAX", header: "<unistd.h>".}: Cint
  scBarriers*{.importc: "_SC_BARRIERS", header: "<unistd.h>".}: Cint
  scBcBaseMax*{.importc: "_SC_BC_BASE_MAX", header: "<unistd.h>".}: Cint
  scBcDimMax*{.importc: "_SC_BC_DIM_MAX", header: "<unistd.h>".}: Cint
  scBcScaleMax*{.importc: "_SC_BC_SCALE_MAX", header: "<unistd.h>".}: Cint
  scBcStringMax*{.importc: "_SC_BC_STRING_MAX", header: "<unistd.h>".}: Cint
  scChildMax*{.importc: "_SC_CHILD_MAX", header: "<unistd.h>".}: Cint
  scClkTck*{.importc: "_SC_CLK_TCK", header: "<unistd.h>".}: Cint
  scClockSelection*{.importc: "_SC_CLOCK_SELECTION", 
    header: "<unistd.h>".}: Cint
  scCollWeightsMax*{.importc: "_SC_COLL_WEIGHTS_MAX", 
    header: "<unistd.h>".}: Cint
  scCputime*{.importc: "_SC_CPUTIME", header: "<unistd.h>".}: Cint
  scDelaytimerMax*{.importc: "_SC_DELAYTIMER_MAX", header: "<unistd.h>".}: Cint
  scExprNestMax*{.importc: "_SC_EXPR_NEST_MAX", header: "<unistd.h>".}: Cint
  scFsync*{.importc: "_SC_FSYNC", header: "<unistd.h>".}: Cint
  scGetgrRSizeMax*{.importc: "_SC_GETGR_R_SIZE_MAX", 
    header: "<unistd.h>".}: Cint
  scGetpwRSizeMax*{.importc: "_SC_GETPW_R_SIZE_MAX", 
    header: "<unistd.h>".}: Cint
  scHostNameMax*{.importc: "_SC_HOST_NAME_MAX", header: "<unistd.h>".}: Cint
  scIovMax*{.importc: "_SC_IOV_MAX", header: "<unistd.h>".}: Cint
  scIpv6*{.importc: "_SC_IPV6", header: "<unistd.h>".}: Cint
  scJobControl*{.importc: "_SC_JOB_CONTROL", header: "<unistd.h>".}: Cint
  scLineMax*{.importc: "_SC_LINE_MAX", header: "<unistd.h>".}: Cint
  scLoginNameMax*{.importc: "_SC_LOGIN_NAME_MAX", header: "<unistd.h>".}: Cint
  scMappedFiles*{.importc: "_SC_MAPPED_FILES", header: "<unistd.h>".}: Cint
  scMemlock*{.importc: "_SC_MEMLOCK", header: "<unistd.h>".}: Cint
  scMemlockRange*{.importc: "_SC_MEMLOCK_RANGE", header: "<unistd.h>".}: Cint
  scMemoryProtection*{.importc: "_SC_MEMORY_PROTECTION", 
    header: "<unistd.h>".}: Cint
  scMessagePassing*{.importc: "_SC_MESSAGE_PASSING", 
    header: "<unistd.h>".}: Cint
  scMonotonicClock*{.importc: "_SC_MONOTONIC_CLOCK", 
    header: "<unistd.h>".}: Cint
  scMqOpenMax*{.importc: "_SC_MQ_OPEN_MAX", header: "<unistd.h>".}: Cint
  scMqPrioMax*{.importc: "_SC_MQ_PRIO_MAX", header: "<unistd.h>".}: Cint
  scNgroupsMax*{.importc: "_SC_NGROUPS_MAX", header: "<unistd.h>".}: Cint
  scOpenMax*{.importc: "_SC_OPEN_MAX", header: "<unistd.h>".}: Cint
  scPageSize*{.importc: "_SC_PAGE_SIZE", header: "<unistd.h>".}: Cint
  scPrioritizedIo*{.importc: "_SC_PRIORITIZED_IO", header: "<unistd.h>".}: Cint
  scPriorityScheduling*{.importc: "_SC_PRIORITY_SCHEDULING", 
    header: "<unistd.h>".}: Cint
  scRawSockets*{.importc: "_SC_RAW_SOCKETS", header: "<unistd.h>".}: Cint
  scReDupMax*{.importc: "_SC_RE_DUP_MAX", header: "<unistd.h>".}: Cint
  scReaderWriterLocks*{.importc: "_SC_READER_WRITER_LOCKS", 
    header: "<unistd.h>".}: Cint
  scRealtimeSignals*{.importc: "_SC_REALTIME_SIGNALS", 
    header: "<unistd.h>".}: Cint
  scRegexp*{.importc: "_SC_REGEXP", header: "<unistd.h>".}: Cint
  scRtsigMax*{.importc: "_SC_RTSIG_MAX", header: "<unistd.h>".}: Cint
  scSavedIds*{.importc: "_SC_SAVED_IDS", header: "<unistd.h>".}: Cint
  scSemNsemsMax*{.importc: "_SC_SEM_NSEMS_MAX", header: "<unistd.h>".}: Cint
  scSemValueMax*{.importc: "_SC_SEM_VALUE_MAX", header: "<unistd.h>".}: Cint
  scSemaphores*{.importc: "_SC_SEMAPHORES", header: "<unistd.h>".}: Cint
  scSharedMemoryObjects*{.importc: "_SC_SHARED_MEMORY_OBJECTS", 
    header: "<unistd.h>".}: Cint
  scShell*{.importc: "_SC_SHELL", header: "<unistd.h>".}: Cint
  scSigqueueMax*{.importc: "_SC_SIGQUEUE_MAX", header: "<unistd.h>".}: Cint
  scSpawn*{.importc: "_SC_SPAWN", header: "<unistd.h>".}: Cint
  scSpinLocks*{.importc: "_SC_SPIN_LOCKS", header: "<unistd.h>".}: Cint
  scSporadicServer*{.importc: "_SC_SPORADIC_SERVER", 
    header: "<unistd.h>".}: Cint
  scSsReplMax*{.importc: "_SC_SS_REPL_MAX", header: "<unistd.h>".}: Cint
  scStreamMax*{.importc: "_SC_STREAM_MAX", header: "<unistd.h>".}: Cint
  scSymloopMax*{.importc: "_SC_SYMLOOP_MAX", header: "<unistd.h>".}: Cint
  scSynchronizedIo*{.importc: "_SC_SYNCHRONIZED_IO", 
    header: "<unistd.h>".}: Cint
  scThreadAttrStackaddr*{.importc: "_SC_THREAD_ATTR_STACKADDR", 
    header: "<unistd.h>".}: Cint
  scThreadAttrStacksize*{.importc: "_SC_THREAD_ATTR_STACKSIZE", 
    header: "<unistd.h>".}: Cint
  scThreadCputime*{.importc: "_SC_THREAD_CPUTIME", header: "<unistd.h>".}: Cint
  scThreadDestructorIterations*{.importc: "_SC_THREAD_DESTRUCTOR_ITERATIONS",
    header: "<unistd.h>".}: Cint
  scThreadKeysMax*{.importc: "_SC_THREAD_KEYS_MAX", 
    header: "<unistd.h>".}: Cint
  scThreadPrioInherit*{.importc: "_SC_THREAD_PRIO_INHERIT", 
    header: "<unistd.h>".}: Cint
  scThreadPrioProtect*{.importc: "_SC_THREAD_PRIO_PROTECT", 
    header: "<unistd.h>".}: Cint
  scThreadPriorityScheduling*{.importc: "_SC_THREAD_PRIORITY_SCHEDULING",
    header: "<unistd.h>".}: Cint
  scThreadProcessShared*{.importc: "_SC_THREAD_PROCESS_SHARED", 
    header: "<unistd.h>".}: Cint
  scThreadSafeFunctions*{.importc: "_SC_THREAD_SAFE_FUNCTIONS", 
    header: "<unistd.h>".}: Cint
  scThreadSporadicServer*{.importc: "_SC_THREAD_SPORADIC_SERVER", 
    header: "<unistd.h>".}: Cint
  scThreadStackMin*{.importc: "_SC_THREAD_STACK_MIN", 
    header: "<unistd.h>".}: Cint
  scThreadThreadsMax*{.importc: "_SC_THREAD_THREADS_MAX", 
    header: "<unistd.h>".}: Cint
  scThreads*{.importc: "_SC_THREADS", header: "<unistd.h>".}: Cint
  scTimeouts*{.importc: "_SC_TIMEOUTS", header: "<unistd.h>".}: Cint
  scTimerMax*{.importc: "_SC_TIMER_MAX", header: "<unistd.h>".}: Cint
  scTimers*{.importc: "_SC_TIMERS", header: "<unistd.h>".}: Cint
  scTrace*{.importc: "_SC_TRACE", header: "<unistd.h>".}: Cint
  scTraceEventFilter*{.importc: "_SC_TRACE_EVENT_FILTER", header: "<unistd.h>".}: Cint
  scTraceEventNameMax*{.importc: "_SC_TRACE_EVENT_NAME_MAX", header: "<unistd.h>".}: Cint
  scTraceInherit*{.importc: "_SC_TRACE_INHERIT", header: "<unistd.h>".}: Cint
  scTraceLog*{.importc: "_SC_TRACE_LOG", header: "<unistd.h>".}: Cint
  scTraceNameMax*{.importc: "_SC_TRACE_NAME_MAX", header: "<unistd.h>".}: Cint
  scTraceSysMax*{.importc: "_SC_TRACE_SYS_MAX", header: "<unistd.h>".}: Cint
  scTraceUserEventMax*{.importc: "_SC_TRACE_USER_EVENT_MAX", header: "<unistd.h>".}: Cint
  scTtyNameMax*{.importc: "_SC_TTY_NAME_MAX", header: "<unistd.h>".}: Cint
  scTypedMemoryObjects*{.importc: "_SC_TYPED_MEMORY_OBJECTS", header: "<unistd.h>".}: Cint
  scTznameMax*{.importc: "_SC_TZNAME_MAX", header: "<unistd.h>".}: Cint
  scV6Ilp32Off32*{.importc: "_SC_V6_ILP32_OFF32", header: "<unistd.h>".}: Cint
  scV6Ilp32Offbig*{.importc: "_SC_V6_ILP32_OFFBIG", header: "<unistd.h>".}: Cint
  scV6Lp64Off64*{.importc: "_SC_V6_LP64_OFF64", header: "<unistd.h>".}: Cint
  scV6LpbigOffbig*{.importc: "_SC_V6_LPBIG_OFFBIG", header: "<unistd.h>".}: Cint
  scVersion*{.importc: "_SC_VERSION", header: "<unistd.h>".}: Cint
  scXbs5Ilp32Off32*{.importc: "_SC_XBS5_ILP32_OFF32", header: "<unistd.h>".}: Cint
  scXbs5Ilp32Offbig*{.importc: "_SC_XBS5_ILP32_OFFBIG", header: "<unistd.h>".}: Cint
  scXbs5Lp64Off64*{.importc: "_SC_XBS5_LP64_OFF64", header: "<unistd.h>".}: Cint
  scXbs5LpbigOffbig*{.importc: "_SC_XBS5_LPBIG_OFFBIG", 
                         header: "<unistd.h>".}: Cint
  scXopenCrypt*{.importc: "_SC_XOPEN_CRYPT", header: "<unistd.h>".}: Cint
  scXopenEnhI18n*{.importc: "_SC_XOPEN_ENH_I18N", header: "<unistd.h>".}: Cint
  scXopenLegacy*{.importc: "_SC_XOPEN_LEGACY", header: "<unistd.h>".}: Cint
  scXopenRealtime*{.importc: "_SC_XOPEN_REALTIME", header: "<unistd.h>".}: Cint
  scXopenRealtimeThreads*{.importc: "_SC_XOPEN_REALTIME_THREADS", 
                              header: "<unistd.h>".}: Cint
  scXopenShm*{.importc: "_SC_XOPEN_SHM", header: "<unistd.h>".}: Cint
  scXopenStreams*{.importc: "_SC_XOPEN_STREAMS", header: "<unistd.h>".}: Cint
  scXopenUnix*{.importc: "_SC_XOPEN_UNIX", header: "<unistd.h>".}: Cint
  scXopenVersion*{.importc: "_SC_XOPEN_VERSION", header: "<unistd.h>".}: Cint
  scNprocessorsOnln*{.importc: "_SC_NPROCESSORS_ONLN", 
                        header: "<unistd.h>".}: Cint
  
  SEM_FAILED* {.importc, header: "<semaphore.h>".}: Pointer
  IPC_CREAT* {.importc, header: "<sys/ipc.h>".}: Cint
    ## Create entry if key does not exist.
  IPC_EXCL* {.importc, header: "<sys/ipc.h>".}: Cint
    ## Fail if key exists.
  IPC_NOWAIT* {.importc, header: "<sys/ipc.h>".}: Cint
    ## Error if request must wait.

  IPC_PRIVATE* {.importc, header: "<sys/ipc.h>".}: Cint
    ## Private key.

  IPC_RMID* {.importc, header: "<sys/ipc.h>".}: Cint
    ## Remove identifier.
  IPC_SET* {.importc, header: "<sys/ipc.h>".}: Cint
    ## Set options.
  IPC_STAT* {.importc, header: "<sys/ipc.h>".}: Cint
    ## Get options. 

  S_IFMT* {.importc, header: "<sys/stat.h>".}: Cint
    ## Type of file.
  S_IFBLK* {.importc, header: "<sys/stat.h>".}: Cint
    ## Block special.
  S_IFCHR* {.importc, header: "<sys/stat.h>".}: Cint
    ## Character special.
  S_IFIFO* {.importc, header: "<sys/stat.h>".}: Cint
    ## FIFO special.
  S_IFREG* {.importc, header: "<sys/stat.h>".}: Cint
    ## Regular.
  S_IFDIR* {.importc, header: "<sys/stat.h>".}: Cint
    ## Directory.
  S_IFLNK* {.importc, header: "<sys/stat.h>".}: Cint
    ## Symbolic link.
  S_IFSOCK* {.importc, header: "<sys/stat.h>".}: Cint
    ## Socket.
  S_IRWXU* {.importc, header: "<sys/stat.h>".}: Cint
    ## Read, write, execute/search by owner.
  S_IRUSR* {.importc, header: "<sys/stat.h>".}: Cint
    ## Read permission, owner.
  S_IWUSR* {.importc, header: "<sys/stat.h>".}: Cint
    ## Write permission, owner.
  S_IXUSR* {.importc, header: "<sys/stat.h>".}: Cint
    ## Execute/search permission, owner.
  S_IRWXG* {.importc, header: "<sys/stat.h>".}: Cint
    ## Read, write, execute/search by group.
  S_IRGRP* {.importc, header: "<sys/stat.h>".}: Cint
    ## Read permission, group.
  S_IWGRP* {.importc, header: "<sys/stat.h>".}: Cint
    ## Write permission, group.
  S_IXGRP* {.importc, header: "<sys/stat.h>".}: Cint
    ## Execute/search permission, group.
  S_IRWXO* {.importc, header: "<sys/stat.h>".}: Cint
    ## Read, write, execute/search by others.
  S_IROTH* {.importc, header: "<sys/stat.h>".}: Cint
    ## Read permission, others.
  S_IWOTH* {.importc, header: "<sys/stat.h>".}: Cint
    ## Write permission, others.
  S_IXOTH* {.importc, header: "<sys/stat.h>".}: Cint
    ## Execute/search permission, others.
  S_ISUID* {.importc, header: "<sys/stat.h>".}: Cint
    ## Set-user-ID on execution.
  S_ISGID* {.importc, header: "<sys/stat.h>".}: Cint
    ## Set-group-ID on execution.
  S_ISVTX* {.importc, header: "<sys/stat.h>".}: Cint
    ## On directories, restricted deletion flag.
  
  ST_RDONLY* {.importc, header: "<sys/statvfs.h>".}: Cint
    ## Read-only file system.
  ST_NOSUID* {.importc, header: "<sys/statvfs.h>".}: Cint
    ## Does not support the semantics of the ST_ISUID and ST_ISGID file mode bits.
       
  PROT_READ* {.importc, header: "<sys/mman.h>".}: Cint
    ## Page can be read.
  PROT_WRITE* {.importc, header: "<sys/mman.h>".}: Cint
    ## Page can be written.
  PROT_EXEC* {.importc, header: "<sys/mman.h>".}: Cint
    ## Page can be executed.
  PROT_NONE* {.importc, header: "<sys/mman.h>".}: Cint
    ## Page cannot be accessed.
  MAP_SHARED* {.importc, header: "<sys/mman.h>".}: Cint
    ## Share changes.
  MAP_PRIVATE* {.importc, header: "<sys/mman.h>".}: Cint
    ## Changes are private.
  MAP_FIXED* {.importc, header: "<sys/mman.h>".}: Cint
    ## Interpret addr exactly.
  MS_ASYNC* {.importc, header: "<sys/mman.h>".}: Cint
    ## Perform asynchronous writes.
  MS_SYNC* {.importc, header: "<sys/mman.h>".}: Cint
    ## Perform synchronous writes.
  MS_INVALIDATE* {.importc, header: "<sys/mman.h>".}: Cint
    ## Invalidate mappings.
  MCL_CURRENT* {.importc, header: "<sys/mman.h>".}: Cint
    ## Lock currently mapped pages.
  MCL_FUTURE* {.importc, header: "<sys/mman.h>".}: Cint
    ## Lock pages that become mapped.
  MAP_FAILED* {.importc, header: "<sys/mman.h>".}: Cint
  POSIX_MADV_NORMAL* {.importc, header: "<sys/mman.h>".}: Cint
    ## The application has no advice to give on its behavior with 
    ## respect to the specified range. It is the default characteristic 
    ## if no advice is given for a range of memory.
  POSIX_MADV_SEQUENTIAL* {.importc, header: "<sys/mman.h>".}: Cint
    ## The application expects to access the specified range sequentially
    ## from lower addresses to higher addresses.
  POSIX_MADV_RANDOM* {.importc, header: "<sys/mman.h>".}: Cint
    ## The application expects to access the specified range in a random order.
  POSIX_MADV_WILLNEED* {.importc, header: "<sys/mman.h>".}: Cint
    ## The application expects to access the specified range in the near future.
  POSIX_MADV_DONTNEED* {.importc, header: "<sys/mman.h>".}: Cint
  POSIX_TYPED_MEM_ALLOCATE* {.importc, header: "<sys/mman.h>".}: Cint
  POSIX_TYPED_MEM_ALLOCATE_CONTIG* {.importc, header: "<sys/mman.h>".}: Cint
  POSIX_TYPED_MEM_MAP_ALLOCATABLE* {.importc, header: "<sys/mman.h>".}: Cint


  CLOCKS_PER_SEC* {.importc, header: "<time.h>".}: Int
    ## A number used to convert the value returned by the clock() function
    ## into seconds.
  CLOCK_PROCESS_CPUTIME_ID* {.importc, header: "<time.h>".}: Cint
    ## The identifier of the CPU-time clock associated with the process 
    ## making a clock() or timer*() function call.
  CLOCK_THREAD_CPUTIME_ID* {.importc, header: "<time.h>".}: Cint
  CLOCK_REALTIME* {.importc, header: "<time.h>".}: Cint
    ## The identifier of the system-wide realtime clock.
  TIMER_ABSTIME* {.importc, header: "<time.h>".}: Cint
    ## Flag indicating time is absolute. For functions taking timer 
    ## objects, this refers to the clock associated with the timer.
  CLOCK_MONOTONIC* {.importc, header: "<time.h>".}: Cint

  WNOHANG* {.importc, header: "<sys/wait.h>".}: Cint
    ## Do not hang if no status is available; return immediately.
  WUNTRACED* {.importc, header: "<sys/wait.h>".}: Cint
    ## Report status of stopped child process.
  WEXITSTATUS* {.importc, header: "<sys/wait.h>".}: Cint
    ## Return exit status.
  WIFCONTINUED* {.importc, header: "<sys/wait.h>".}: Cint
    ## True if child has been continued.
  WIFEXITED* {.importc, header: "<sys/wait.h>".}: Cint
    ## True if child exited normally.
  WIFSIGNALED* {.importc, header: "<sys/wait.h>".}: Cint
    ## True if child exited due to uncaught signal.
  WIFSTOPPED* {.importc, header: "<sys/wait.h>".}: Cint
    ## True if child is currently stopped.
  WSTOPSIG* {.importc, header: "<sys/wait.h>".}: Cint
    ## Return signal number that caused process to stop.
  WTERMSIG* {.importc, header: "<sys/wait.h>".}: Cint
    ## Return signal number that caused process to terminate.
  WEXITED* {.importc, header: "<sys/wait.h>".}: Cint
    ## Wait for processes that have exited.
  WSTOPPED* {.importc, header: "<sys/wait.h>".}: Cint
    ## Status is returned for any child that has stopped upon receipt 
    ## of a signal.
  WCONTINUED* {.importc, header: "<sys/wait.h>".}: Cint
    ## Status is returned for any child that was stopped and has been continued.
  WNOWAIT* {.importc, header: "<sys/wait.h>".}: Cint
    ## Keep the process whose status is returned in infop in a waitable state. 
  P_ALL* {.importc, header: "<sys/wait.h>".}: Cint 
  P_PID* {.importc, header: "<sys/wait.h>".}: Cint 
  P_PGID* {.importc, header: "<sys/wait.h>".}: Cint
       
  SIG_DFL* {.importc, header: "<signal.h>".}: proc (x: Cint) {.noconv.}
    ## Request for default signal handling.
  SIG_ERR* {.importc, header: "<signal.h>".}: proc (x: Cint) {.noconv.}
    ## Return value from signal() in case of error.
  cSIGHOLD* {.importc: "SIG_HOLD", 
    header: "<signal.h>".}: proc (x: Cint) {.noconv.}
    ## Request that signal be held.
  SIG_IGN* {.importc, header: "<signal.h>".}: proc (x: Cint) {.noconv.}
    ## Request that signal be ignored. 

  SIGEV_NONE* {.importc, header: "<signal.h>".}: Cint
  SIGEV_SIGNAL* {.importc, header: "<signal.h>".}: Cint
  SIGEV_THREAD* {.importc, header: "<signal.h>".}: Cint
  SIGABRT* {.importc, header: "<signal.h>".}: Cint
  SIGALRM* {.importc, header: "<signal.h>".}: Cint
  SIGBUS* {.importc, header: "<signal.h>".}: Cint
  SIGCHLD* {.importc, header: "<signal.h>".}: Cint
  SIGCONT* {.importc, header: "<signal.h>".}: Cint
  SIGFPE* {.importc, header: "<signal.h>".}: Cint
  SIGHUP* {.importc, header: "<signal.h>".}: Cint
  SIGILL* {.importc, header: "<signal.h>".}: Cint
  SIGINT* {.importc, header: "<signal.h>".}: Cint
  SIGKILL* {.importc, header: "<signal.h>".}: Cint
  SIGPIPE* {.importc, header: "<signal.h>".}: Cint
  SIGQUIT* {.importc, header: "<signal.h>".}: Cint
  SIGSEGV* {.importc, header: "<signal.h>".}: Cint
  SIGSTOP* {.importc, header: "<signal.h>".}: Cint
  SIGTERM* {.importc, header: "<signal.h>".}: Cint
  SIGTSTP* {.importc, header: "<signal.h>".}: Cint
  SIGTTIN* {.importc, header: "<signal.h>".}: Cint
  SIGTTOU* {.importc, header: "<signal.h>".}: Cint
  SIGUSR1* {.importc, header: "<signal.h>".}: Cint
  SIGUSR2* {.importc, header: "<signal.h>".}: Cint
  SIGPOLL* {.importc, header: "<signal.h>".}: Cint
  SIGPROF* {.importc, header: "<signal.h>".}: Cint
  SIGSYS* {.importc, header: "<signal.h>".}: Cint
  SIGTRAP* {.importc, header: "<signal.h>".}: Cint
  SIGURG* {.importc, header: "<signal.h>".}: Cint
  SIGVTALRM* {.importc, header: "<signal.h>".}: Cint
  SIGXCPU* {.importc, header: "<signal.h>".}: Cint
  SIGXFSZ* {.importc, header: "<signal.h>".}: Cint
  SA_NOCLDSTOP* {.importc, header: "<signal.h>".}: Cint
  SIG_BLOCK* {.importc, header: "<signal.h>".}: Cint
  SIG_UNBLOCK* {.importc, header: "<signal.h>".}: Cint
  SIG_SETMASK* {.importc, header: "<signal.h>".}: Cint
  SA_ONSTACK* {.importc, header: "<signal.h>".}: Cint
  SA_RESETHAND* {.importc, header: "<signal.h>".}: Cint
  SA_RESTART* {.importc, header: "<signal.h>".}: Cint
  SA_SIGINFO* {.importc, header: "<signal.h>".}: Cint
  SA_NOCLDWAIT* {.importc, header: "<signal.h>".}: Cint
  SA_NODEFER* {.importc, header: "<signal.h>".}: Cint
  SS_ONSTACK* {.importc, header: "<signal.h>".}: Cint
  SS_DISABLE* {.importc, header: "<signal.h>".}: Cint
  MINSIGSTKSZ* {.importc, header: "<signal.h>".}: Cint
  SIGSTKSZ* {.importc, header: "<signal.h>".}: Cint

  NL_SETD* {.importc, header: "<nl_types.h>".}: Cint
  NL_CAT_LOCALE* {.importc, header: "<nl_types.h>".}: Cint

  SCHED_FIFO* {.importc, header: "<sched.h>".}: Cint
  SCHED_RR* {.importc, header: "<sched.h>".}: Cint
  SCHED_SPORADIC* {.importc, header: "<sched.h>".}: Cint
  SCHED_OTHER* {.importc, header: "<sched.h>".}: Cint
  FD_SETSIZE* {.importc, header: "<sys/select.h>".}: Cint

  SEEK_SET* {.importc, header: "<unistd.h>".}: Cint
  SEEK_CUR* {.importc, header: "<unistd.h>".}: Cint
  SEEK_END* {.importc, header: "<unistd.h>".}: Cint

  SCM_RIGHTS* {.importc, header: "<sys/socket.h>".}: Cint
    ## Indicates that the data array contains the access rights 
    ## to be sent or received. 

  SOCK_DGRAM* {.importc, header: "<sys/socket.h>".}: Cint ## Datagram socket.
  SOCK_RAW* {.importc, header: "<sys/socket.h>".}: Cint
    ## Raw Protocol Interface.
  SOCK_SEQPACKET* {.importc, header: "<sys/socket.h>".}: Cint
    ## Sequenced-packet socket.
  SOCK_STREAM* {.importc, header: "<sys/socket.h>".}: Cint
    ## Byte-stream socket. 
    
  SOL_SOCKET* {.importc, header: "<sys/socket.h>".}: Cint
    ## Options to be accessed at socket level, not protocol level. 
    
  SO_ACCEPTCONN* {.importc, header: "<sys/socket.h>".}: Cint
    ## Socket is accepting connections.
  SO_BROADCAST* {.importc, header: "<sys/socket.h>".}: Cint
    ## Transmission of broadcast messages is supported.
  SO_DEBUG* {.importc, header: "<sys/socket.h>".}: Cint
    ## Debugging information is being recorded.
  SO_DONTROUTE* {.importc, header: "<sys/socket.h>".}: Cint
    ## Bypass normal routing.
  SO_ERROR* {.importc, header: "<sys/socket.h>".}: Cint
    ## Socket error status.
  SO_KEEPALIVE* {.importc, header: "<sys/socket.h>".}: Cint
    ## Connections are kept alive with periodic messages.
  SO_LINGER* {.importc, header: "<sys/socket.h>".}: Cint
    ## Socket lingers on close.
  SO_OOBINLINE* {.importc, header: "<sys/socket.h>".}: Cint
    ## Out-of-band data is transmitted in line.
  SO_RCVBUF* {.importc, header: "<sys/socket.h>".}: Cint
    ## Receive buffer size.
  SO_RCVLOWAT* {.importc, header: "<sys/socket.h>".}: Cint
    ## Receive *low water mark*.
  SO_RCVTIMEO* {.importc, header: "<sys/socket.h>".}: Cint
    ## Receive timeout.
  SO_REUSEADDR* {.importc, header: "<sys/socket.h>".}: Cint
    ## Reuse of local addresses is supported.
  SO_SNDBUF* {.importc, header: "<sys/socket.h>".}: Cint
    ## Send buffer size.
  SO_SNDLOWAT* {.importc, header: "<sys/socket.h>".}: Cint
    ## Send *low water mark*.
  SO_SNDTIMEO* {.importc, header: "<sys/socket.h>".}: Cint
    ## Send timeout.
  SO_TYPE* {.importc, header: "<sys/socket.h>".}: Cint
    ## Socket type. 
      
  SOMAXCONN* {.importc, header: "<sys/socket.h>".}: Cint
    ## The maximum backlog queue length. 
    
  MSG_CTRUNC* {.importc, header: "<sys/socket.h>".}: Cint
    ## Control data truncated.
  MSG_DONTROUTE* {.importc, header: "<sys/socket.h>".}: Cint
    ## Send without using routing tables.
  MSG_EOR* {.importc, header: "<sys/socket.h>".}: Cint
    ## Terminates a record (if supported by the protocol).
  MSG_OOB* {.importc, header: "<sys/socket.h>".}: Cint
    ## Out-of-band data.
  MSG_NOSIGNAL* {.importc, header: "<sys/socket.h>".}: Cint
    ## No SIGPIPE generated when an attempt to send is made on a stream-oriented socket that is no longer connected.
  MSG_PEEK* {.importc, header: "<sys/socket.h>".}: Cint
    ## Leave received data in queue.
  MSG_TRUNC* {.importc, header: "<sys/socket.h>".}: Cint
    ## Normal data truncated.
  MSG_WAITALL* {.importc, header: "<sys/socket.h>".}: Cint
    ## Attempt to fill the read buffer. 

  AF_INET* {.importc, header: "<sys/socket.h>".}: Cint
    ## Internet domain sockets for use with IPv4 addresses.
  AF_INET6* {.importc, header: "<sys/socket.h>".}: Cint
    ## Internet domain sockets for use with IPv6 addresses.
  AF_UNIX* {.importc, header: "<sys/socket.h>".}: Cint
    ## UNIX domain sockets.
  AF_UNSPEC* {.importc, header: "<sys/socket.h>".}: Cint
    ## Unspecified. 

  SHUT_RD* {.importc, header: "<sys/socket.h>".}: Cint
    ## Disables further receive operations.
  SHUT_RDWR* {.importc, header: "<sys/socket.h>".}: Cint
    ## Disables further send and receive operations.
  SHUT_WR* {.importc, header: "<sys/socket.h>".}: Cint
    ## Disables further send operations. 

  IF_NAMESIZE* {.importc, header: "<net/if.h>".}: Cint
    
  IPPROTO_IP* {.importc, header: "<netinet/in.h>".}: Cint
    ## Internet protocol.
  IPPROTO_IPV6* {.importc, header: "<netinet/in.h>".}: Cint
    ## Internet Protocol Version 6.
  IPPROTO_ICMP* {.importc, header: "<netinet/in.h>".}: Cint
    ## Control message protocol.
  IPPROTO_RAW* {.importc, header: "<netinet/in.h>".}: Cint
    ## Raw IP Packets Protocol. 
  IPPROTO_TCP* {.importc, header: "<netinet/in.h>".}: Cint
    ## Transmission control protocol.
  IPPROTO_UDP* {.importc, header: "<netinet/in.h>".}: Cint
    ## User datagram protocol.

  INADDR_ANY* {.importc, header: "<netinet/in.h>".}: TinAddrScalar
    ## IPv4 local host address.
  INADDR_BROADCAST* {.importc, header: "<netinet/in.h>".}: TinAddrScalar
    ## IPv4 broadcast address.

  INET_ADDRSTRLEN* {.importc, header: "<netinet/in.h>".}: Cint
    ## 16. Length of the string form for IP. 

  IPV6_JOIN_GROUP* {.importc, header: "<netinet/in.h>".}: Cint
    ## Join a multicast group.
  IPV6_LEAVE_GROUP* {.importc, header: "<netinet/in.h>".}: Cint
    ## Quit a multicast group.
  IPV6_MULTICAST_HOPS* {.importc, header: "<netinet/in.h>".}: Cint
    ## Multicast hop limit.
  IPV6_MULTICAST_IF* {.importc, header: "<netinet/in.h>".}: Cint
    ## Interface to use for outgoing multicast packets.
  IPV6_MULTICAST_LOOP* {.importc, header: "<netinet/in.h>".}: Cint
    ## Multicast packets are delivered back to the local application.
  IPV6_UNICAST_HOPS* {.importc, header: "<netinet/in.h>".}: Cint
    ## Unicast hop limit.
  IPV6_V6ONLY* {.importc, header: "<netinet/in.h>".}: Cint
    ## Restrict AF_INET6 socket to IPv6 communications only.

  TCP_NODELAY* {.importc, header: "<netinet/tcp.h>".}: Cint
    ## Avoid coalescing of small segments. 

  IPPORT_RESERVED* {.importc, header: "<netdb.h>".}: Cint 

  HOST_NOT_FOUND* {.importc, header: "<netdb.h>".}: Cint 
  NO_DATA* {.importc, header: "<netdb.h>".}: Cint 
  NO_RECOVERY* {.importc, header: "<netdb.h>".}: Cint 
  TRY_AGAIN* {.importc, header: "<netdb.h>".}: Cint 

  AI_PASSIVE* {.importc, header: "<netdb.h>".}: Cint 
    ## Socket address is intended for bind().
  AI_CANONNAME* {.importc, header: "<netdb.h>".}: Cint 
    ## Request for canonical name.
  AI_NUMERICHOST* {.importc, header: "<netdb.h>".}: Cint 
    ## Return numeric host address as name.
  AI_NUMERICSERV* {.importc, header: "<netdb.h>".}: Cint 
    ## Inhibit service name resolution.
  AI_V4MAPPED* {.importc, header: "<netdb.h>".}: Cint 
     ## If no IPv6 addresses are found, query for IPv4 addresses and
     ## return them to the caller as IPv4-mapped IPv6 addresses.
  AI_ALL* {.importc, header: "<netdb.h>".}: Cint 
    ## Query for both IPv4 and IPv6 addresses.
  AI_ADDRCONFIG* {.importc, header: "<netdb.h>".}: Cint 
    ## Query for IPv4 addresses only when an IPv4 address is configured; 
    ## query for IPv6 addresses only when an IPv6 address is configured.

  NI_NOFQDN* {.importc, header: "<netdb.h>".}: Cint 
    ## Only the nodename portion of the FQDN is returned for local hosts.
  NI_NUMERICHOST* {.importc, header: "<netdb.h>".}: Cint 
    ## The numeric form of the node's address is returned instead of its name.
  NI_NAMEREQD* {.importc, header: "<netdb.h>".}: Cint 
    ## Return an error if the node's name cannot be located in the database.
  NI_NUMERICSERV* {.importc, header: "<netdb.h>".}: Cint 
    ## The numeric form of the service address is returned instead of its name.
  NI_NUMERICSCOPE* {.importc, header: "<netdb.h>".}: Cint 
    ## For IPv6 addresses, the numeric form of the scope identifier is
    ## returned instead of its name.
  NI_DGRAM* {.importc, header: "<netdb.h>".}: Cint 
    ## Indicates that the service is a datagram service (SOCK_DGRAM). 

  EAI_AGAIN* {.importc, header: "<netdb.h>".}: Cint 
    ## The name could not be resolved at this time. Future attempts may succeed.
  EAI_BADFLAGS* {.importc, header: "<netdb.h>".}: Cint 
    ## The flags had an invalid value.
  EAI_FAIL* {.importc, header: "<netdb.h>".}: Cint 
    ## A non-recoverable error occurred.
  EAI_FAMILY* {.importc, header: "<netdb.h>".}: Cint 
    ## The address family was not recognized or the address length 
    ## was invalid for the specified family.
  EAI_MEMORY* {.importc, header: "<netdb.h>".}: Cint 
    ## There was a memory allocation failure.
  EAI_NONAME* {.importc, header: "<netdb.h>".}: Cint 
    ## The name does not resolve for the supplied parameters.
    ## NI_NAMEREQD is set and the host's name cannot be located, 
    ## or both nodename and servname were null.
  EAI_SERVICE* {.importc, header: "<netdb.h>".}: Cint 
    ## The service passed was not recognized for the specified socket type.
  EAI_SOCKTYPE* {.importc, header: "<netdb.h>".}: Cint 
    ## The intended socket type was not recognized.
  EAI_SYSTEM* {.importc, header: "<netdb.h>".}: Cint 
    ## A system error occurred. The error code can be found in errno.
  EAI_OVERFLOW* {.importc, header: "<netdb.h>".}: Cint 
    ## An argument buffer overflowed.

  POLLIN* {.importc, header: "<poll.h>".}: Cshort
    ## Data other than high-priority data may be read without blocking.
  POLLRDNORM* {.importc, header: "<poll.h>".}: Cshort
    ## Normal data may be read without blocking.
  POLLRDBAND* {.importc, header: "<poll.h>".}: Cshort
    ## Priority data may be read without blocking.
  POLLPRI* {.importc, header: "<poll.h>".}: Cshort
    ## High priority data may be read without blocking.
  POLLOUT* {.importc, header: "<poll.h>".}: Cshort
    ## Normal data may be written without blocking.
  POLLWRNORM* {.importc, header: "<poll.h>".}: Cshort
    ## Equivalent to POLLOUT.
  POLLWRBAND* {.importc, header: "<poll.h>".}: Cshort
    ## Priority data may be written.
  POLLERR* {.importc, header: "<poll.h>".}: Cshort
    ## An error has occurred (revents only).
  POLLHUP* {.importc, header: "<poll.h>".}: Cshort
    ## Device has been disconnected (revents only).
  POLLNVAL* {.importc, header: "<poll.h>".}: Cshort
    ## Invalid fd member (revents only). 


when hasSpawnh:
  var
    POSIX_SPAWN_RESETIDS* {.importc, header: "<spawn.h>".}: Cint
    POSIX_SPAWN_SETPGROUP* {.importc, header: "<spawn.h>".}: Cint
    POSIX_SPAWN_SETSCHEDPARAM* {.importc, header: "<spawn.h>".}: Cint
    POSIX_SPAWN_SETSCHEDULER* {.importc, header: "<spawn.h>".}: Cint
    POSIX_SPAWN_SETSIGDEF* {.importc, header: "<spawn.h>".}: Cint
    POSIX_SPAWN_SETSIGMASK* {.importc, header: "<spawn.h>".}: Cint

  when defined(linux):
    # better be safe than sorry; Linux has this flag, macosx doesn't, don't
    # know about the other OSes
    var POSIX_SPAWN_USEVFORK* {.importc, header: "<spawn.h>".}: cint
  else:
    # macosx lacks this, so we define the constant to be 0 to not affect
    # OR'ing of flags:
    const PosixSpawnUsevfork* = cint(0)
    
when hasAioH:
  proc aio_cancel*(a1: cint, a2: ptr Taiocb): cint {.importc, header: "<aio.h>".}
  proc aio_error*(a1: ptr Taiocb): cint {.importc, header: "<aio.h>".}
  proc aio_fsync*(a1: cint, a2: ptr Taiocb): cint {.importc, header: "<aio.h>".}
  proc aio_read*(a1: ptr Taiocb): cint {.importc, header: "<aio.h>".}
  proc aio_return*(a1: ptr Taiocb): int {.importc, header: "<aio.h>".}
  proc aio_suspend*(a1: ptr ptr Taiocb, a2: cint, a3: ptr ttimespec): cint {.
                   importc, header: "<aio.h>".}
  proc aio_write*(a1: ptr Taiocb): cint {.importc, header: "<aio.h>".}
  proc lio_listio*(a1: cint, a2: ptr ptr Taiocb, a3: cint,
               a4: ptr Tsigevent): cint {.importc, header: "<aio.h>".}

# arpa/inet.h
proc htonl*(a1: Int32): Int32 {.importc, header: "<arpa/inet.h>".}
proc htons*(a1: Int16): Int16 {.importc, header: "<arpa/inet.h>".}
proc ntohl*(a1: Int32): Int32 {.importc, header: "<arpa/inet.h>".}
proc ntohs*(a1: Int16): Int16 {.importc, header: "<arpa/inet.h>".}

proc inet_addr*(a1: Cstring): TInAddrT {.importc, header: "<arpa/inet.h>".}
proc inet_ntoa*(a1: TInAddr): Cstring {.importc, header: "<arpa/inet.h>".}
proc inet_ntop*(a1: Cint, a2: Pointer, a3: Cstring, a4: Int32): Cstring {.
  importc, header: "<arpa/inet.h>".}
proc inet_pton*(a1: Cint, a2: Cstring, a3: Pointer): Cint {.
  importc, header: "<arpa/inet.h>".}

var
  in6addr_any* {.importc, header: "<netinet/in.h>".}: TIn6Addr
  in6addr_loopback* {.importc, header: "<netinet/in.h>".}: TIn6Addr

proc IN6ADDR_ANY_INIT* (): TIn6Addr {.importc, header: "<netinet/in.h>".}
proc IN6ADDR_LOOPBACK_INIT* (): TIn6Addr {.importc, header: "<netinet/in.h>".}

# dirent.h
proc closedir*(a1: ptr TDIR): Cint  {.importc, header: "<dirent.h>".}
proc opendir*(a1: Cstring): ptr TDir {.importc, header: "<dirent.h>".}
proc readdir*(a1: ptr TDIR): ptr Tdirent  {.importc, header: "<dirent.h>".}
proc readdir_r*(a1: ptr TDIR, a2: ptr Tdirent, a3: ptr ptr Tdirent): Cint  {.
                importc, header: "<dirent.h>".}
proc rewinddir*(a1: ptr TDIR)  {.importc, header: "<dirent.h>".}
proc seekdir*(a1: ptr TDIR, a2: Int)  {.importc, header: "<dirent.h>".}
proc telldir*(a1: ptr TDIR): Int {.importc, header: "<dirent.h>".}

# dlfcn.h
proc dlclose*(a1: Pointer): Cint {.importc, header: "<dlfcn.h>".}
proc dlerror*(): Cstring {.importc, header: "<dlfcn.h>".}
proc dlopen*(a1: Cstring, a2: Cint): Pointer {.importc, header: "<dlfcn.h>".}
proc dlsym*(a1: Pointer, a2: Cstring): Pointer {.importc, header: "<dlfcn.h>".}

proc creat*(a1: Cstring, a2: Tmode): Cint {.importc, header: "<fcntl.h>".}
proc fcntl*(a1: Cint, a2: Cint): Cint {.varargs, importc, header: "<fcntl.h>".}
proc open*(a1: Cstring, a2: Cint): Cint {.varargs, importc, header: "<fcntl.h>".}
proc posix_fadvise*(a1: Cint, a2, a3: Toff, a4: Cint): Cint {.
  importc, header: "<fcntl.h>".}
proc posix_fallocate*(a1: Cint, a2, a3: Toff): Cint {.
  importc, header: "<fcntl.h>".}

proc feclearexcept*(a1: Cint): Cint {.importc, header: "<fenv.h>".}
proc fegetexceptflag*(a1: ptr Tfexcept, a2: Cint): Cint {.
  importc, header: "<fenv.h>".}
proc feraiseexcept*(a1: Cint): Cint {.importc, header: "<fenv.h>".}
proc fesetexceptflag*(a1: ptr Tfexcept, a2: Cint): Cint {.
  importc, header: "<fenv.h>".}
proc fetestexcept*(a1: Cint): Cint {.importc, header: "<fenv.h>".}
proc fegetround*(): Cint {.importc, header: "<fenv.h>".}
proc fesetround*(a1: Cint): Cint {.importc, header: "<fenv.h>".}
proc fegetenv*(a1: ptr Tfenv): Cint {.importc, header: "<fenv.h>".}
proc feholdexcept*(a1: ptr Tfenv): Cint {.importc, header: "<fenv.h>".}
proc fesetenv*(a1: ptr Tfenv): Cint {.importc, header: "<fenv.h>".}
proc feupdateenv*(a1: ptr Tfenv): Cint {.importc, header: "<fenv.h>".}

proc fmtmsg*(a1: Int, a2: Cstring, a3: Cint,
            a4, a5, a6: Cstring): Cint {.importc, header: "<fmtmsg.h>".}
            
proc fnmatch*(a1, a2: Cstring, a3: Cint): Cint {.importc, header: "<fnmatch.h>".}
proc ftw*(a1: Cstring, 
         a2: proc (x1: Cstring, x2: ptr TStat, x3: Cint): Cint {.noconv.},
         a3: Cint): Cint {.importc, header: "<ftw.h>".}
proc nftw*(a1: Cstring, 
          a2: proc (x1: Cstring, x2: ptr TStat, 
                    x3: Cint, x4: ptr TFTW): Cint {.noconv.},
          a3: Cint,
          a4: Cint): Cint {.importc, header: "<ftw.h>".}

proc glob*(a1: Cstring, a2: Cint,
          a3: proc (x1: Cstring, x2: Cint): Cint {.noconv.},
          a4: ptr Tglob): Cint {.importc, header: "<glob.h>".}
proc globfree*(a1: ptr TGlob) {.importc, header: "<glob.h>".}

proc getgrgid*(a1: TGid): ptr TGroup {.importc, header: "<grp.h>".}
proc getgrnam*(a1: Cstring): ptr TGroup {.importc, header: "<grp.h>".}
proc getgrgid_r*(a1: Tgid, a2: ptr TGroup, a3: Cstring, a4: Int,
                 a5: ptr ptr TGroup): Cint {.importc, header: "<grp.h>".}
proc getgrnam_r*(a1: Cstring, a2: ptr TGroup, a3: Cstring, 
                  a4: Int, a5: ptr ptr TGroup): Cint {.
                 importc, header: "<grp.h>".}
proc getgrent*(): ptr TGroup {.importc, header: "<grp.h>".}
proc endgrent*() {.importc, header: "<grp.h>".}
proc setgrent*() {.importc, header: "<grp.h>".}


proc iconv_open*(a1, a2: Cstring): Ticonv {.importc, header: "<iconv.h>".}
proc iconv*(a1: Ticonv, a2: var Cstring, a3: var Int, a4: var Cstring,
            a5: var Int): Int {.importc, header: "<iconv.h>".}
proc iconv_close*(a1: Ticonv): Cint {.importc, header: "<iconv.h>".}

proc nl_langinfo*(a1: TnlItem): Cstring {.importc, header: "<langinfo.h>".}

proc basename*(a1: Cstring): Cstring {.importc, header: "<libgen.h>".}
proc dirname*(a1: Cstring): Cstring {.importc, header: "<libgen.h>".}

proc localeconv*(): ptr Tlconv {.importc, header: "<locale.h>".}
proc setlocale*(a1: Cint, a2: Cstring): Cstring {.
                importc, header: "<locale.h>".}

proc strfmon*(a1: Cstring, a2: Int, a3: Cstring): Int {.varargs,
   importc, header: "<monetary.h>".}

proc mq_close*(a1: Tmqd): Cint {.importc, header: "<mqueue.h>".}
proc mq_getattr*(a1: Tmqd, a2: ptr Tmq_attr): Cint {.
  importc, header: "<mqueue.h>".}
proc mq_notify*(a1: Tmqd, a2: ptr TsigEvent): Cint {.
  importc, header: "<mqueue.h>".}
proc mq_open*(a1: Cstring, a2: Cint): TMqd {.
  varargs, importc, header: "<mqueue.h>".}
proc mq_receive*(a1: Tmqd, a2: Cstring, a3: Int, a4: var Int): Int {.
  importc, header: "<mqueue.h>".}
proc mq_send*(a1: Tmqd, a2: Cstring, a3: Int, a4: Int): Cint {.
  importc, header: "<mqueue.h>".}
proc mq_setattr*(a1: Tmqd, a2, a3: ptr Tmq_attr): Cint {.
  importc, header: "<mqueue.h>".}

proc mq_timedreceive*(a1: Tmqd, a2: Cstring, a3: Int, a4: Int, 
                      a5: ptr Ttimespec): Int {.importc, header: "<mqueue.h>".}
proc mq_timedsend*(a1: Tmqd, a2: Cstring, a3: Int, a4: Int, 
                   a5: ptr Ttimespec): Cint {.importc, header: "<mqueue.h>".}
proc mq_unlink*(a1: Cstring): Cint {.importc, header: "<mqueue.h>".}


proc getpwnam*(a1: Cstring): ptr TPasswd {.importc, header: "<pwd.h>".}
proc getpwuid*(a1: Tuid): ptr TPasswd {.importc, header: "<pwd.h>".}
proc getpwnam_r*(a1: Cstring, a2: ptr Tpasswd, a3: Cstring, a4: Int,
                 a5: ptr ptr Tpasswd): Cint {.importc, header: "<pwd.h>".}
proc getpwuid_r*(a1: Tuid, a2: ptr Tpasswd, a3: Cstring,
      a4: Int, a5: ptr ptr Tpasswd): Cint {.importc, header: "<pwd.h>".}
proc endpwent*() {.importc, header: "<pwd.h>".}
proc getpwent*(): ptr TPasswd {.importc, header: "<pwd.h>".}
proc setpwent*() {.importc, header: "<pwd.h>".}

proc uname*(a1: var Tutsname): Cint {.importc, header: "<sys/utsname.h>".}

proc pthread_atfork*(a1, a2, a3: proc () {.noconv.}): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_destroy*(a1: ptr TpthreadAttr): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_getdetachstate*(a1: ptr TpthreadAttr, a2: Cint): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_getguardsize*(a1: ptr TpthreadAttr, a2: var Cint): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_getinheritsched*(a1: ptr TpthreadAttr,
          a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_attr_getschedparam*(a1: ptr TpthreadAttr,
          a2: ptr TschedParam): Cint {.importc, header: "<pthread.h>".}
proc pthread_attr_getschedpolicy*(a1: ptr TpthreadAttr,
          a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_attr_getscope*(a1: ptr TpthreadAttr,
          a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_attr_getstack*(a1: ptr TpthreadAttr,
         a2: var Pointer, a3: var Int): Cint {.importc, header: "<pthread.h>".}
proc pthread_attr_getstackaddr*(a1: ptr TpthreadAttr,
          a2: var Pointer): Cint {.importc, header: "<pthread.h>".}
proc pthread_attr_getstacksize*(a1: ptr TpthreadAttr,
          a2: var Int): Cint {.importc, header: "<pthread.h>".}
proc pthread_attr_init*(a1: ptr TpthreadAttr): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_setdetachstate*(a1: ptr TpthreadAttr, a2: Cint): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_setguardsize*(a1: ptr TpthreadAttr, a2: Int): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_setinheritsched*(a1: ptr TpthreadAttr, a2: Cint): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_setschedparam*(a1: ptr TpthreadAttr,
          a2: ptr TschedParam): Cint {.importc, header: "<pthread.h>".}
proc pthread_attr_setschedpolicy*(a1: ptr TpthreadAttr, a2: Cint): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_setscope*(a1: ptr TpthreadAttr, a2: Cint): Cint {.importc,
  header: "<pthread.h>".}
proc pthread_attr_setstack*(a1: ptr TpthreadAttr, a2: Pointer, a3: Int): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_setstackaddr*(a1: ptr TpthreadAttr, a2: Pointer): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_attr_setstacksize*(a1: ptr TpthreadAttr, a2: Int): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_barrier_destroy*(a1: ptr TpthreadBarrier): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_barrier_init*(a1: ptr TpthreadBarrier,
         a2: ptr TpthreadBarrierattr, a3: Cint): Cint {.
         importc, header: "<pthread.h>".}
proc pthread_barrier_wait*(a1: ptr TpthreadBarrier): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_barrierattr_destroy*(a1: ptr TpthreadBarrierattr): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_barrierattr_getpshared*(
          a1: ptr TpthreadBarrierattr, a2: var Cint): Cint {.
          importc, header: "<pthread.h>".}
proc pthread_barrierattr_init*(a1: ptr TpthreadBarrierattr): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_barrierattr_setpshared*(a1: ptr TpthreadBarrierattr, 
  a2: Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_cancel*(a1: Tpthread): Cint {.importc, header: "<pthread.h>".}
proc pthread_cleanup_push*(a1: proc (x: Pointer) {.noconv.}, a2: Pointer) {.
  importc, header: "<pthread.h>".}
proc pthread_cleanup_pop*(a1: Cint) {.importc, header: "<pthread.h>".}
proc pthread_cond_broadcast*(a1: ptr TpthreadCond): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_cond_destroy*(a1: ptr TpthreadCond): Cint {.importc, header: "<pthread.h>".}
proc pthread_cond_init*(a1: ptr TpthreadCond,
          a2: ptr TpthreadCondattr): Cint {.importc, header: "<pthread.h>".}
proc pthread_cond_signal*(a1: ptr TpthreadCond): Cint {.importc, header: "<pthread.h>".}
proc pthread_cond_timedwait*(a1: ptr TpthreadCond,
          a2: ptr TpthreadMutex, a3: ptr Ttimespec): Cint {.importc, header: "<pthread.h>".}

proc pthread_cond_wait*(a1: ptr TpthreadCond,
          a2: ptr TpthreadMutex): Cint {.importc, header: "<pthread.h>".}
proc pthread_condattr_destroy*(a1: ptr TpthreadCondattr): Cint {.importc, header: "<pthread.h>".}
proc pthread_condattr_getclock*(a1: ptr TpthreadCondattr,
          a2: var Tclockid): Cint {.importc, header: "<pthread.h>".}
proc pthread_condattr_getpshared*(a1: ptr TpthreadCondattr,
          a2: var Cint): Cint {.importc, header: "<pthread.h>".}
          
proc pthread_condattr_init*(a1: ptr TpthreadCondattr): Cint {.importc, header: "<pthread.h>".}
proc pthread_condattr_setclock*(a1: ptr TpthreadCondattr,a2: Tclockid): Cint {.importc, header: "<pthread.h>".}
proc pthread_condattr_setpshared*(a1: ptr TpthreadCondattr, a2: Cint): Cint {.importc, header: "<pthread.h>".}

proc pthread_create*(a1: ptr Tpthread, a2: ptr TpthreadAttr,
          a3: proc (x: Pointer): Pointer {.noconv.}, a4: Pointer): Cint {.importc, header: "<pthread.h>".}
proc pthread_detach*(a1: Tpthread): Cint {.importc, header: "<pthread.h>".}
proc pthread_equal*(a1, a2: Tpthread): Cint {.importc, header: "<pthread.h>".}
proc pthread_exit*(a1: Pointer) {.importc, header: "<pthread.h>".}
proc pthread_getconcurrency*(): Cint {.importc, header: "<pthread.h>".}
proc pthread_getcpuclockid*(a1: Tpthread, a2: var Tclockid): Cint {.importc, header: "<pthread.h>".}
proc pthread_getschedparam*(a1: Tpthread,  a2: var Cint,
          a3: ptr TschedParam): Cint {.importc, header: "<pthread.h>".}
proc pthread_getspecific*(a1: TpthreadKey): Pointer {.importc, header: "<pthread.h>".}
proc pthread_join*(a1: Tpthread, a2: ptr Pointer): Cint {.importc, header: "<pthread.h>".}
proc pthread_key_create*(a1: ptr TpthreadKey, a2: proc (x: Pointer) {.noconv.}): Cint {.importc, header: "<pthread.h>".}
proc pthread_key_delete*(a1: TpthreadKey): Cint {.importc, header: "<pthread.h>".}

proc pthread_mutex_destroy*(a1: ptr TpthreadMutex): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutex_getprioceiling*(a1: ptr TpthreadMutex,
         a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutex_init*(a1: ptr TpthreadMutex,
          a2: ptr TpthreadMutexattr): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutex_lock*(a1: ptr TpthreadMutex): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutex_setprioceiling*(a1: ptr TpthreadMutex,a2: Cint,
          a3: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutex_timedlock*(a1: ptr TpthreadMutex,
          a2: ptr Ttimespec): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutex_trylock*(a1: ptr TpthreadMutex): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutex_unlock*(a1: ptr TpthreadMutex): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutexattr_destroy*(a1: ptr TpthreadMutexattr): Cint {.importc, header: "<pthread.h>".}

proc pthread_mutexattr_getprioceiling*(
          a1: ptr TpthreadMutexattr, a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutexattr_getprotocol*(a1: ptr TpthreadMutexattr,
          a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutexattr_getpshared*(a1: ptr TpthreadMutexattr,
          a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutexattr_gettype*(a1: ptr TpthreadMutexattr,
          a2: var Cint): Cint {.importc, header: "<pthread.h>".}

proc pthread_mutexattr_init*(a1: ptr TpthreadMutexattr): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutexattr_setprioceiling*(a1: ptr TpthreadMutexattr, a2: Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutexattr_setprotocol*(a1: ptr TpthreadMutexattr, a2: Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutexattr_setpshared*(a1: ptr TpthreadMutexattr, a2: Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_mutexattr_settype*(a1: ptr TpthreadMutexattr, a2: Cint): Cint {.importc, header: "<pthread.h>".}

proc pthread_once*(a1: ptr TpthreadOnce, a2: proc () {.noconv.}): Cint {.importc, header: "<pthread.h>".}

proc pthread_rwlock_destroy*(a1: ptr TpthreadRwlock): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlock_init*(a1: ptr TpthreadRwlock,
          a2: ptr TpthreadRwlockattr): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlock_rdlock*(a1: ptr TpthreadRwlock): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlock_timedrdlock*(a1: ptr TpthreadRwlock,
          a2: ptr Ttimespec): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlock_timedwrlock*(a1: ptr TpthreadRwlock,
          a2: ptr Ttimespec): Cint {.importc, header: "<pthread.h>".}

proc pthread_rwlock_tryrdlock*(a1: ptr TpthreadRwlock): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlock_trywrlock*(a1: ptr TpthreadRwlock): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlock_unlock*(a1: ptr TpthreadRwlock): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlock_wrlock*(a1: ptr TpthreadRwlock): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlockattr_destroy*(a1: ptr TpthreadRwlockattr): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlockattr_getpshared*(
          a1: ptr TpthreadRwlockattr, a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlockattr_init*(a1: ptr TpthreadRwlockattr): Cint {.importc, header: "<pthread.h>".}
proc pthread_rwlockattr_setpshared*(a1: ptr TpthreadRwlockattr, a2: Cint): Cint {.importc, header: "<pthread.h>".}

proc pthread_self*(): Tpthread {.importc, header: "<pthread.h>".}
proc pthread_setcancelstate*(a1: Cint, a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_setcanceltype*(a1: Cint, a2: var Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_setconcurrency*(a1: Cint): Cint {.importc, header: "<pthread.h>".}
proc pthread_setschedparam*(a1: Tpthread, a2: Cint,
          a3: ptr TschedParam): Cint {.importc, header: "<pthread.h>".}

proc pthread_setschedprio*(a1: Tpthread, a2: Cint): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_setspecific*(a1: TpthreadKey, a2: Pointer): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_spin_destroy*(a1: ptr TpthreadSpinlock): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_spin_init*(a1: ptr TpthreadSpinlock, a2: Cint): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_spin_lock*(a1: ptr TpthreadSpinlock): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_spin_trylock*(a1: ptr TpthreadSpinlock): Cint{.
  importc, header: "<pthread.h>".}
proc pthread_spin_unlock*(a1: ptr TpthreadSpinlock): Cint {.
  importc, header: "<pthread.h>".}
proc pthread_testcancel*() {.importc, header: "<pthread.h>".}


proc access*(a1: Cstring, a2: Cint): Cint {.importc, header: "<unistd.h>".}
proc alarm*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc chdir*(a1: Cstring): Cint {.importc, header: "<unistd.h>".}
proc chown*(a1: Cstring, a2: Tuid, a3: Tgid): Cint {.importc, header: "<unistd.h>".}
proc close*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc confstr*(a1: Cint, a2: Cstring, a3: Int): Int {.importc, header: "<unistd.h>".}
proc crypt*(a1, a2: Cstring): Cstring {.importc, header: "<unistd.h>".}
proc ctermid*(a1: Cstring): Cstring {.importc, header: "<unistd.h>".}
proc dup*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc dup2*(a1, a2: Cint): Cint {.importc, header: "<unistd.h>".}
proc encrypt*(a1: Array[0..63, Char], a2: Cint) {.importc, header: "<unistd.h>".}

proc execl*(a1, a2: Cstring): Cint {.varargs, importc, header: "<unistd.h>".}
proc execle*(a1, a2: Cstring): Cint {.varargs, importc, header: "<unistd.h>".}
proc execlp*(a1, a2: Cstring): Cint {.varargs, importc, header: "<unistd.h>".}
proc execv*(a1: Cstring, a2: CstringArray): Cint {.importc, header: "<unistd.h>".}
proc execve*(a1: Cstring, a2, a3: CstringArray): Cint {.
  importc, header: "<unistd.h>".}
proc execvp*(a1: Cstring, a2: CstringArray): Cint {.importc, header: "<unistd.h>".}
proc fchown*(a1: Cint, a2: Tuid, a3: Tgid): Cint {.importc, header: "<unistd.h>".}
proc fchdir*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc fdatasync*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc fork*(): Tpid {.importc, header: "<unistd.h>".}
proc fpathconf*(a1, a2: Cint): Int {.importc, header: "<unistd.h>".}
proc fsync*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc ftruncate*(a1: Cint, a2: Toff): Cint {.importc, header: "<unistd.h>".}
proc getcwd*(a1: Cstring, a2: Int): Cstring {.importc, header: "<unistd.h>".}
proc getegid*(): TGid {.importc, header: "<unistd.h>".}
proc geteuid*(): Tuid {.importc, header: "<unistd.h>".}
proc getgid*(): TGid {.importc, header: "<unistd.h>".}

proc getgroups*(a1: Cint, a2: ptr Array[0..255, Tgid]): Cint {.
  importc, header: "<unistd.h>".}
proc gethostid*(): Int {.importc, header: "<unistd.h>".}
proc gethostname*(a1: Cstring, a2: Int): Cint {.importc, header: "<unistd.h>".}
proc getlogin*(): Cstring {.importc, header: "<unistd.h>".}
proc getlogin_r*(a1: Cstring, a2: Int): Cint {.importc, header: "<unistd.h>".}

proc getopt*(a1: Cint, a2: CstringArray, a3: Cstring): Cint {.
  importc, header: "<unistd.h>".}
proc getpgid*(a1: Tpid): Tpid {.importc, header: "<unistd.h>".}
proc getpgrp*(): Tpid {.importc, header: "<unistd.h>".}
proc getpid*(): Tpid {.importc, header: "<unistd.h>".}
proc getppid*(): Tpid {.importc, header: "<unistd.h>".}
proc getsid*(a1: Tpid): Tpid {.importc, header: "<unistd.h>".}
proc getuid*(): Tuid {.importc, header: "<unistd.h>".}
proc getwd*(a1: Cstring): Cstring {.importc, header: "<unistd.h>".}
proc isatty*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc lchown*(a1: Cstring, a2: Tuid, a3: Tgid): Cint {.importc, header: "<unistd.h>".}
proc link*(a1, a2: Cstring): Cint {.importc, header: "<unistd.h>".}

proc lockf*(a1, a2: Cint, a3: Toff): Cint {.importc, header: "<unistd.h>".}
proc lseek*(a1: Cint, a2: Toff, a3: Cint): Toff {.importc, header: "<unistd.h>".}
proc nice*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc pathconf*(a1: Cstring, a2: Cint): Int {.importc, header: "<unistd.h>".}

proc pause*(): Cint {.importc, header: "<unistd.h>".}
proc pipe*(a: Array[0..1, Cint]): Cint {.importc, header: "<unistd.h>".}
proc pread*(a1: Cint, a2: Pointer, a3: Int, a4: Toff): Int {.
  importc, header: "<unistd.h>".}
proc pwrite*(a1: Cint, a2: Pointer, a3: Int, a4: Toff): Int {.
  importc, header: "<unistd.h>".}
proc read*(a1: Cint, a2: Pointer, a3: Int): Int {.importc, header: "<unistd.h>".}
proc readlink*(a1, a2: Cstring, a3: Int): Int {.importc, header: "<unistd.h>".}

proc rmdir*(a1: Cstring): Cint {.importc, header: "<unistd.h>".}
proc setegid*(a1: Tgid): Cint {.importc, header: "<unistd.h>".}
proc seteuid*(a1: Tuid): Cint {.importc, header: "<unistd.h>".}
proc setgid*(a1: Tgid): Cint {.importc, header: "<unistd.h>".}

proc setpgid*(a1, a2: Tpid): Cint {.importc, header: "<unistd.h>".}
proc setpgrp*(): Tpid {.importc, header: "<unistd.h>".}
proc setregid*(a1, a2: Tgid): Cint {.importc, header: "<unistd.h>".}
proc setreuid*(a1, a2: Tuid): Cint {.importc, header: "<unistd.h>".}
proc setsid*(): Tpid {.importc, header: "<unistd.h>".}
proc setuid*(a1: Tuid): Cint {.importc, header: "<unistd.h>".}
proc sleep*(a1: Cint): Cint {.importc, header: "<unistd.h>".}
proc swab*(a1, a2: Pointer, a3: Int) {.importc, header: "<unistd.h>".}
proc symlink*(a1, a2: Cstring): Cint {.importc, header: "<unistd.h>".}
proc sync*() {.importc, header: "<unistd.h>".}
proc sysconf*(a1: Cint): Int {.importc, header: "<unistd.h>".}
proc tcgetpgrp*(a1: Cint): tpid {.importc, header: "<unistd.h>".}
proc tcsetpgrp*(a1: Cint, a2: Tpid): Cint {.importc, header: "<unistd.h>".}
proc truncate*(a1: Cstring, a2: Toff): Cint {.importc, header: "<unistd.h>".}
proc ttyname*(a1: Cint): Cstring {.importc, header: "<unistd.h>".}
proc ttyname_r*(a1: Cint, a2: Cstring, a3: Int): Cint {.
  importc, header: "<unistd.h>".}
proc ualarm*(a1, a2: Tuseconds): Tuseconds {.importc, header: "<unistd.h>".}
proc unlink*(a1: Cstring): Cint {.importc, header: "<unistd.h>".}
proc usleep*(a1: Tuseconds): Cint {.importc, header: "<unistd.h>".}
proc vfork*(): tpid {.importc, header: "<unistd.h>".}
proc write*(a1: Cint, a2: Pointer, a3: Int): Int {.importc, header: "<unistd.h>".}

proc sem_close*(a1: ptr Tsem): Cint {.importc, header: "<semaphore.h>".}
proc sem_destroy*(a1: ptr Tsem): Cint {.importc, header: "<semaphore.h>".}
proc sem_getvalue*(a1: ptr Tsem, a2: var Cint): Cint {.
  importc, header: "<semaphore.h>".}
proc sem_init*(a1: ptr Tsem, a2: Cint, a3: Cint): Cint {.
  importc, header: "<semaphore.h>".}
proc sem_open*(a1: Cstring, a2: Cint): ptr TSem {.
  varargs, importc, header: "<semaphore.h>".}
proc sem_post*(a1: ptr Tsem): Cint {.importc, header: "<semaphore.h>".}
proc sem_timedwait*(a1: ptr Tsem, a2: ptr Ttimespec): Cint {.
  importc, header: "<semaphore.h>".}
proc sem_trywait*(a1: ptr Tsem): Cint {.importc, header: "<semaphore.h>".}
proc sem_unlink*(a1: Cstring): Cint {.importc, header: "<semaphore.h>".}
proc sem_wait*(a1: ptr Tsem): Cint {.importc, header: "<semaphore.h>".}

proc ftok*(a1: Cstring, a2: Cint): Tkey {.importc, header: "<sys/ipc.h>".}

proc statvfs*(a1: Cstring, a2: var Tstatvfs): Cint {.
  importc, header: "<sys/statvfs.h>".}
proc fstatvfs*(a1: Cint, a2: var Tstatvfs): Cint {.
  importc, header: "<sys/statvfs.h>".}

proc chmod*(a1: Cstring, a2: TMode): Cint {.importc, header: "<sys/stat.h>".}
proc fchmod*(a1: Cint, a2: TMode): Cint {.importc, header: "<sys/stat.h>".}
proc fstat*(a1: Cint, a2: var Tstat): Cint {.importc, header: "<sys/stat.h>".}
proc lstat*(a1: Cstring, a2: var Tstat): Cint {.importc, header: "<sys/stat.h>".}
proc mkdir*(a1: Cstring, a2: TMode): Cint {.importc, header: "<sys/stat.h>".}
proc mkfifo*(a1: Cstring, a2: TMode): Cint {.importc, header: "<sys/stat.h>".}
proc mknod*(a1: Cstring, a2: TMode, a3: Tdev): Cint {.
  importc, header: "<sys/stat.h>".}
proc stat*(a1: Cstring, a2: var Tstat): Cint {.importc, header: "<sys/stat.h>".}
proc umask*(a1: Tmode): TMode {.importc, header: "<sys/stat.h>".}

proc S_ISBLK*(m: Tmode): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a block special file.
proc S_ISCHR*(m: Tmode): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a character special file.
proc S_ISDIR*(m: Tmode): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a directory.
proc S_ISFIFO*(m: Tmode): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a pipe or FIFO special file.
proc S_ISREG*(m: Tmode): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a regular file.
proc S_ISLNK*(m: Tmode): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a symbolic link.
proc S_ISSOCK*(m: Tmode): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a socket. 
    
proc S_TYPEISMQ*(buf: var TStat): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a message queue.
proc S_TYPEISSEM*(buf: var TStat): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a semaphore.
proc S_TYPEISSHM*(buf: var TStat): Bool {.importc, header: "<sys/stat.h>".}
  ## Test for a shared memory object. 
    
proc S_TYPEISTMO*(buf: var TStat): Bool {.importc, header: "<sys/stat.h>".}
  ## Test macro for a typed memory object. 
  
proc mlock*(a1: Pointer, a2: Int): Cint {.importc, header: "<sys/mman.h>".}
proc mlockall*(a1: Cint): Cint {.importc, header: "<sys/mman.h>".}
proc mmap*(a1: Pointer, a2: Int, a3, a4, a5: Cint, a6: Toff): Pointer {.
  importc, header: "<sys/mman.h>".}
proc mprotect*(a1: Pointer, a2: Int, a3: Cint): Cint {.
  importc, header: "<sys/mman.h>".}
proc msync*(a1: Pointer, a2: Int, a3: Cint): Cint {.importc, header: "<sys/mman.h>".}
proc munlock*(a1: Pointer, a2: Int): Cint {.importc, header: "<sys/mman.h>".}
proc munlockall*(): Cint {.importc, header: "<sys/mman.h>".}
proc munmap*(a1: Pointer, a2: Int): Cint {.importc, header: "<sys/mman.h>".}
proc posix_madvise*(a1: Pointer, a2: Int, a3: Cint): Cint {.
  importc, header: "<sys/mman.h>".}
proc posix_mem_offset*(a1: Pointer, a2: Int, a3: var Toff,
           a4: var Int, a5: var Cint): Cint {.importc, header: "<sys/mman.h>".}
proc posix_typed_mem_get_info*(a1: Cint, 
  a2: var TposixTypedMemInfo): Cint {.importc, header: "<sys/mman.h>".}
proc posix_typed_mem_open*(a1: Cstring, a2, a3: Cint): Cint {.
  importc, header: "<sys/mman.h>".}
proc shm_open*(a1: Cstring, a2: Cint, a3: Tmode): Cint {.
  importc, header: "<sys/mman.h>".}
proc shm_unlink*(a1: Cstring): Cint {.importc, header: "<sys/mman.h>".}

proc asctime*(a1: var Ttm): Cstring{.importc, header: "<time.h>".}

proc asctime_r*(a1: var Ttm, a2: Cstring): Cstring {.importc, header: "<time.h>".}
proc clock*(): Tclock {.importc, header: "<time.h>".}
proc clock_getcpuclockid*(a1: tpid, a2: var Tclockid): Cint {.
  importc, header: "<time.h>".}
proc clock_getres*(a1: Tclockid, a2: var Ttimespec): Cint {.
  importc, header: "<time.h>".}
proc clock_gettime*(a1: Tclockid, a2: var Ttimespec): Cint {.
  importc, header: "<time.h>".}
proc clock_nanosleep*(a1: Tclockid, a2: Cint, a3: var Ttimespec,
               a4: var Ttimespec): Cint {.importc, header: "<time.h>".}
proc clock_settime*(a1: Tclockid, a2: var Ttimespec): Cint {.
  importc, header: "<time.h>".}

proc ctime*(a1: var Ttime): Cstring {.importc, header: "<time.h>".}
proc ctime_r*(a1: var Ttime, a2: Cstring): Cstring {.importc, header: "<time.h>".}
proc difftime*(a1, a2: Ttime): Cdouble {.importc, header: "<time.h>".}
proc getdate*(a1: Cstring): ptr Ttm {.importc, header: "<time.h>".}

proc gmtime*(a1: var ttime): ptr Ttm {.importc, header: "<time.h>".}
proc gmtime_r*(a1: var ttime, a2: var Ttm): ptr Ttm {.importc, header: "<time.h>".}
proc localtime*(a1: var ttime): ptr Ttm {.importc, header: "<time.h>".}
proc localtime_r*(a1: var ttime, a2: var Ttm): ptr Ttm {.importc, header: "<time.h>".}
proc mktime*(a1: var Ttm): ttime  {.importc, header: "<time.h>".}
proc nanosleep*(a1, a2: var Ttimespec): Cint {.importc, header: "<time.h>".}
proc strftime*(a1: Cstring, a2: Int, a3: Cstring,
           a4: var Ttm): Int {.importc, header: "<time.h>".}
proc strptime*(a1, a2: Cstring, a3: var Ttm): Cstring {.importc, header: "<time.h>".}
proc time*(a1: var Ttime): ttime {.importc, header: "<time.h>".}
proc timer_create*(a1: var Tclockid, a2: var TsigEvent,
               a3: var Ttimer): Cint {.importc, header: "<time.h>".}
proc timer_delete*(a1: var Ttimer): Cint {.importc, header: "<time.h>".}
proc timer_gettime*(a1: Ttimer, a2: var Titimerspec): Cint {.
  importc, header: "<time.h>".}
proc timer_getoverrun*(a1: Ttimer): Cint {.importc, header: "<time.h>".}
proc timer_settime*(a1: Ttimer, a2: Cint, a3: var Titimerspec,
               a4: var Titimerspec): Cint {.importc, header: "<time.h>".}
proc tzset*() {.importc, header: "<time.h>".}


proc wait*(a1: var Cint): tpid {.importc, header: "<sys/wait.h>".}
proc waitid*(a1: Cint, a2: Tid, a3: var TsigInfo, a4: Cint): Cint {.
  importc, header: "<sys/wait.h>".}
proc waitpid*(a1: tpid, a2: var Cint, a3: Cint): tpid {.
  importc, header: "<sys/wait.h>".}

proc bsd_signal*(a1: Cint, a2: proc (x: Pointer) {.noconv.}) {.
  importc, header: "<signal.h>".}
proc kill*(a1: Tpid, a2: Cint): Cint {.importc, header: "<signal.h>".}
proc killpg*(a1: Tpid, a2: Cint): Cint {.importc, header: "<signal.h>".}
proc pthread_kill*(a1: Tpthread, a2: Cint): Cint {.importc, header: "<signal.h>".}
proc pthread_sigmask*(a1: Cint, a2, a3: var Tsigset): Cint {.
  importc, header: "<signal.h>".}
proc `raise`*(a1: Cint): Cint {.importc, header: "<signal.h>".}
proc sigaction*(a1: Cint, a2, a3: var Tsigaction): Cint {.
  importc, header: "<signal.h>".}
proc sigaddset*(a1: var Tsigset, a2: Cint): Cint {.importc, header: "<signal.h>".}
proc sigaltstack*(a1, a2: var Tstack): Cint {.importc, header: "<signal.h>".}
proc sigdelset*(a1: var Tsigset, a2: Cint): Cint {.importc, header: "<signal.h>".}
proc sigemptyset*(a1: var Tsigset): Cint {.importc, header: "<signal.h>".}
proc sigfillset*(a1: var Tsigset): Cint {.importc, header: "<signal.h>".}
proc sighold*(a1: Cint): Cint {.importc, header: "<signal.h>".}
proc sigignore*(a1: Cint): Cint {.importc, header: "<signal.h>".}
proc siginterrupt*(a1, a2: Cint): Cint {.importc, header: "<signal.h>".}
proc sigismember*(a1: var Tsigset, a2: Cint): Cint {.importc, header: "<signal.h>".}
proc signal*(a1: Cint, a2: proc (x: Cint) {.noconv.}) {.
  importc, header: "<signal.h>".}
proc sigpause*(a1: Cint): Cint {.importc, header: "<signal.h>".}
proc sigpending*(a1: var Tsigset): Cint {.importc, header: "<signal.h>".}
proc sigprocmask*(a1: Cint, a2, a3: var Tsigset): Cint {.
  importc, header: "<signal.h>".}
proc sigqueue*(a1: tpid, a2: Cint, a3: TsigVal): Cint {.
  importc, header: "<signal.h>".}
proc sigrelse*(a1: Cint): Cint {.importc, header: "<signal.h>".}
proc sigset*(a1: Int, a2: proc (x: Cint) {.noconv.}) {.
  importc, header: "<signal.h>".}
proc sigsuspend*(a1: var Tsigset): Cint {.importc, header: "<signal.h>".}
proc sigtimedwait*(a1: var Tsigset, a2: var TsigInfo, 
                   a3: var Ttimespec): Cint {.importc, header: "<signal.h>".}
proc sigwait*(a1: var Tsigset, a2: var Cint): Cint {.
  importc, header: "<signal.h>".}
proc sigwaitinfo*(a1: var Tsigset, a2: var TsigInfo): Cint {.
  importc, header: "<signal.h>".}


proc catclose*(a1: TnlCatd): Cint {.importc, header: "<nl_types.h>".}
proc catgets*(a1: TnlCatd, a2, a3: Cint, a4: Cstring): Cstring {.
  importc, header: "<nl_types.h>".}
proc catopen*(a1: Cstring, a2: Cint): TnlCatd {.
  importc, header: "<nl_types.h>".}

proc sched_get_priority_max*(a1: Cint): Cint {.importc, header: "<sched.h>".}
proc sched_get_priority_min*(a1: Cint): Cint {.importc, header: "<sched.h>".}
proc sched_getparam*(a1: tpid, a2: var TschedParam): Cint {.
  importc, header: "<sched.h>".}
proc sched_getscheduler*(a1: tpid): Cint {.importc, header: "<sched.h>".}
proc sched_rr_get_interval*(a1: tpid, a2: var Ttimespec): Cint {.
  importc, header: "<sched.h>".}
proc sched_setparam*(a1: tpid, a2: var TschedParam): Cint {.
  importc, header: "<sched.h>".}
proc sched_setscheduler*(a1: tpid, a2: Cint, a3: var TschedParam): Cint {.
  importc, header: "<sched.h>".}
proc sched_yield*(): Cint {.importc, header: "<sched.h>".}

proc strerror*(errnum: Cint): Cstring {.importc, header: "<string.h>".}
proc hstrerror*(herrnum: Cint): Cstring {.importc, header: "<netdb.h>".}

proc FD_CLR*(a1: Cint, a2: var TfdSet) {.importc, header: "<sys/select.h>".}
proc FD_ISSET*(a1: Cint, a2: var TfdSet): Cint {.
  importc, header: "<sys/select.h>".}
proc FD_SET*(a1: Cint, a2: var TfdSet) {.importc, header: "<sys/select.h>".}
proc FD_ZERO*(a1: var TfdSet) {.importc, header: "<sys/select.h>".}

proc pselect*(a1: Cint, a2, a3, a4: ptr TfdSet, a5: ptr Ttimespec,
         a6: var Tsigset): Cint  {.importc, header: "<sys/select.h>".}
proc select*(a1: Cint, a2, a3, a4: ptr TfdSet, a5: ptr Ttimeval): Cint {.
             importc, header: "<sys/select.h>".}

when hasSpawnH:
  proc posix_spawn*(a1: var tpid, a2: Cstring,
            a3: var TposixSpawnFileActions,
            a4: var TposixSpawnattr, 
            a5, a6: CstringArray): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawn_file_actions_addclose*(a1: var TposixSpawnFileActions,
            a2: Cint): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawn_file_actions_adddup2*(a1: var TposixSpawnFileActions,
            a2, a3: Cint): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawn_file_actions_addopen*(a1: var TposixSpawnFileActions,
            a2: Cint, a3: Cstring, a4: Cint, a5: tmode): Cint {.
            importc, header: "<spawn.h>".}
  proc posix_spawn_file_actions_destroy*(
    a1: var TposixSpawnFileActions): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawn_file_actions_init*(
    a1: var TposixSpawnFileActions): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnattr_destroy*(a1: var TposixSpawnattr): Cint {.
    importc, header: "<spawn.h>".}
  proc posix_spawnattr_getsigdefault*(a1: var TposixSpawnattr,
            a2: var Tsigset): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnattr_getflags*(a1: var TposixSpawnattr,
            a2: var Cshort): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnattr_getpgroup*(a1: var TposixSpawnattr,
            a2: var tpid): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnattr_getschedparam*(a1: var TposixSpawnattr,
            a2: var TschedParam): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnattr_getschedpolicy*(a1: var TposixSpawnattr,
            a2: var Cint): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnattr_getsigmask*(a1: var TposixSpawnattr,
            a2: var Tsigset): Cint {.importc, header: "<spawn.h>".}
  
  proc posix_spawnattr_init*(a1: var TposixSpawnattr): Cint {.
    importc, header: "<spawn.h>".}
  proc posix_spawnattr_setsigdefault*(a1: var TposixSpawnattr,
            a2: var Tsigset): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnattr_setflags*(a1: var TposixSpawnattr, a2: Cint): Cint {.
    importc, header: "<spawn.h>".}
  proc posix_spawnattr_setpgroup*(a1: var TposixSpawnattr, a2: tpid): Cint {.
    importc, header: "<spawn.h>".}
  
  proc posix_spawnattr_setschedparam*(a1: var TposixSpawnattr,
            a2: var TschedParam): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnattr_setschedpolicy*(a1: var TposixSpawnattr, 
                                       a2: Cint): Cint {.
                                       importc, header: "<spawn.h>".}
  proc posix_spawnattr_setsigmask*(a1: var TposixSpawnattr,
            a2: var Tsigset): Cint {.importc, header: "<spawn.h>".}
  proc posix_spawnp*(a1: var tpid, a2: Cstring,
            a3: var TposixSpawnFileActions,
            a4: var TposixSpawnattr,
            a5, a6: CstringArray): Cint {.importc, header: "<spawn.h>".}

proc getcontext*(a1: var Tucontext): Cint {.importc, header: "<ucontext.h>".}
proc makecontext*(a1: var Tucontext, a4: proc (){.noconv.}, a3: Cint) {.
  varargs, importc, header: "<ucontext.h>".}
proc setcontext*(a1: var Tucontext): Cint {.importc, header: "<ucontext.h>".}
proc swapcontext*(a1, a2: var Tucontext): Cint {.importc, header: "<ucontext.h>".}

proc readv*(a1: Cint, a2: ptr TIOVec, a3: Cint): Int {.
  importc, header: "<sys/uio.h>".}
proc writev*(a1: Cint, a2: ptr TIOVec, a3: Cint): Int {.
  importc, header: "<sys/uio.h>".}

proc CMSG_DATA*(cmsg: ptr Tcmsghdr): Cstring {.
  importc, header: "<sys/socket.h>".}

proc CMSG_NXTHDR*(mhdr: ptr Tmsghdr, cmsg: ptr Tcmsghdr): ptr Tcmsghdr {.
  importc, header: "<sys/socket.h>".}

proc CMSG_FIRSTHDR*(mhdr: ptr Tmsghdr): ptr Tcmsghdr {.
  importc, header: "<sys/socket.h>".}

proc accept*(a1: Cint, a2: ptr Tsockaddr, a3: ptr Tsocklen): Cint {.
  importc, header: "<sys/socket.h>".}

proc bindSocket*(a1: Cint, a2: ptr Tsockaddr, a3: Tsocklen): Cint {.
  importc: "bind", header: "<sys/socket.h>".}
  ## is Posix's ``bind``, because ``bind`` is a reserved word
  
proc connect*(a1: Cint, a2: ptr Tsockaddr, a3: Tsocklen): Cint {.
  importc, header: "<sys/socket.h>".}
proc getpeername*(a1: Cint, a2: ptr Tsockaddr, a3: ptr Tsocklen): Cint {.
  importc, header: "<sys/socket.h>".}
proc getsockname*(a1: Cint, a2: ptr Tsockaddr, a3: ptr Tsocklen): Cint {.
  importc, header: "<sys/socket.h>".}

proc getsockopt*(a1, a2, a3: Cint, a4: Pointer, a5: ptr Tsocklen): Cint {.
  importc, header: "<sys/socket.h>".}

proc listen*(a1, a2: Cint): Cint {.
  importc, header: "<sys/socket.h>".}
proc recv*(a1: Cint, a2: Pointer, a3: Int, a4: Cint): Int {.
  importc, header: "<sys/socket.h>".}
proc recvfrom*(a1: Cint, a2: Pointer, a3: Int, a4: Cint,
        a5: ptr Tsockaddr, a6: ptr Tsocklen): Int {.
  importc, header: "<sys/socket.h>".}
proc recvmsg*(a1: Cint, a2: ptr Tmsghdr, a3: Cint): Int {.
  importc, header: "<sys/socket.h>".}
proc send*(a1: Cint, a2: Pointer, a3: Int, a4: Cint): Int {.
  importc, header: "<sys/socket.h>".}
proc sendmsg*(a1: Cint, a2: ptr Tmsghdr, a3: Cint): Int {.
  importc, header: "<sys/socket.h>".}
proc sendto*(a1: Cint, a2: Pointer, a3: Int, a4: Cint, a5: ptr Tsockaddr,
             a6: Tsocklen): Int {.
  importc, header: "<sys/socket.h>".}
proc setsockopt*(a1, a2, a3: Cint, a4: Pointer, a5: Tsocklen): Cint {.
  importc, header: "<sys/socket.h>".}
proc shutdown*(a1, a2: Cint): Cint {.
  importc, header: "<sys/socket.h>".}
proc socket*(a1, a2, a3: Cint): Cint {.
  importc, header: "<sys/socket.h>".}
proc sockatmark*(a1: Cint): Cint {.
  importc, header: "<sys/socket.h>".}
proc socketpair*(a1, a2, a3: Cint, a4: var Array[0..1, Cint]): Cint {.
  importc, header: "<sys/socket.h>".}

proc if_nametoindex*(a1: Cstring): Cint {.importc, header: "<net/if.h>".}
proc if_indextoname*(a1: Cint, a2: Cstring): Cstring {.
  importc, header: "<net/if.h>".}
proc if_nameindex*(): ptr TifNameindex {.importc, header: "<net/if.h>".}
proc if_freenameindex*(a1: ptr TifNameindex) {.importc, header: "<net/if.h>".}

proc IN6_IS_ADDR_UNSPECIFIED* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Unspecified address.
proc IN6_IS_ADDR_LOOPBACK* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Loopback address.
proc IN6_IS_ADDR_MULTICAST* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Multicast address.
proc IN6_IS_ADDR_LINKLOCAL* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Unicast link-local address.
proc IN6_IS_ADDR_SITELOCAL* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Unicast site-local address.
proc IN6_IS_ADDR_V4MAPPED* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## IPv4 mapped address.
proc IN6_IS_ADDR_V4COMPAT* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## IPv4-compatible address.
proc IN6_IS_ADDR_MC_NODELOCAL* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Multicast node-local address.
proc IN6_IS_ADDR_MC_LINKLOCAL* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Multicast link-local address.
proc IN6_IS_ADDR_MC_SITELOCAL* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Multicast site-local address.
proc IN6_IS_ADDR_MC_ORGLOCAL* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Multicast organization-local address.
proc IN6_IS_ADDR_MC_GLOBAL* (a1: ptr TIn6Addr): Cint {.
  importc, header: "<netinet/in.h>".}
  ## Multicast global address.

proc endhostent*() {.importc, header: "<netdb.h>".}
proc endnetent*() {.importc, header: "<netdb.h>".}
proc endprotoent*() {.importc, header: "<netdb.h>".}
proc endservent*() {.importc, header: "<netdb.h>".}
proc freeaddrinfo*(a1: ptr Taddrinfo) {.importc, header: "<netdb.h>".}

proc gai_strerror*(a1: Cint): Cstring {.importc, header: "<netdb.h>".}

proc getaddrinfo*(a1, a2: Cstring, a3: ptr Taddrinfo, 
                  a4: var ptr Taddrinfo): Cint {.importc, header: "<netdb.h>".}
                  
proc gethostbyaddr*(a1: Pointer, a2: Tsocklen, a3: Cint): ptr Thostent {.
                    importc, header: "<netdb.h>".}
proc gethostbyname*(a1: Cstring): ptr Thostent {.importc, header: "<netdb.h>".}
proc gethostent*(): ptr Thostent {.importc, header: "<netdb.h>".}

proc getnameinfo*(a1: ptr Tsockaddr, a2: Tsocklen,
                  a3: Cstring, a4: Tsocklen, a5: Cstring,
                  a6: Tsocklen, a7: Cint): Cint {.importc, header: "<netdb.h>".}

proc getnetbyaddr*(a1: Int32, a2: Cint): ptr Tnetent {.importc, header: "<netdb.h>".}
proc getnetbyname*(a1: Cstring): ptr Tnetent {.importc, header: "<netdb.h>".}
proc getnetent*(): ptr Tnetent {.importc, header: "<netdb.h>".}

proc getprotobyname*(a1: Cstring): ptr TProtoent {.importc, header: "<netdb.h>".}
proc getprotobynumber*(a1: Cint): ptr TProtoent {.importc, header: "<netdb.h>".}
proc getprotoent*(): ptr TProtoent {.importc, header: "<netdb.h>".}

proc getservbyname*(a1, a2: Cstring): ptr TServent {.importc, header: "<netdb.h>".}
proc getservbyport*(a1: Cint, a2: Cstring): ptr TServent {.
  importc, header: "<netdb.h>".}
proc getservent*(): ptr TServent {.importc, header: "<netdb.h>".}

proc sethostent*(a1: Cint) {.importc, header: "<netdb.h>".}
proc setnetent*(a1: Cint) {.importc, header: "<netdb.h>".}
proc setprotoent*(a1: Cint) {.importc, header: "<netdb.h>".}
proc setservent*(a1: Cint) {.importc, header: "<netdb.h>".}

proc poll*(a1: ptr Tpollfd, a2: Tnfds, a3: Int): Cint {.
  importc, header: "<poll.h>".}

proc realpath*(name, resolved: Cstring): Cstring {.
  importc: "realpath", header: "<stdlib.h>".}


