## libuv is still fast moving target
## This file was last updated against a development HEAD revision of https://github.com/joyent/libuv/

## Use the following link to see changes (in uv.h) since then and don't forget to update the information here.
## https://github.com/joyent/libuv/compare/9f6024a6fa9d254527b4b59af724257df870288b...master

when defined(Windows):
  import winlean
else:
  import posix

type
  TPort* = distinct Int16  ## port type

  Cssize = Int
  Coff = Int
  Csize = Int

  AllocProc* = proc (handle: PHandle, suggested_size: Csize): TBuf {.cdecl.}
  ReadProc* = proc (stream: PStream, nread: Cssize, buf: TBuf) {.cdecl.}
  ReadProc2* = proc (stream: PPipe, nread: Cssize, buf: TBuf, pending: THandleType) {.cdecl.}
  WriteProc* = proc (req: PWrite, status: Cint) {.cdecl.}
  ConnectProc* = proc (req: PConnect, status: Cint) {.cdecl.}
  ShutdownProc* = proc (req: PShutdown, status: Cint) {.cdecl.}
  ConnectionProc* = proc (server: PStream, status: Cint) {.cdecl.}
  CloseProc* = proc (handle: PHandle) {.cdecl.}
  TimerProc* = proc (handle: PTimer, status: Cint) {.cdecl.}
  AsyncProc* = proc (handle: PAsync, status: Cint) {.cdecl.}
  PrepareProc* = proc (handle: PPrepare, status: Cint) {.cdecl.}
  CheckProc* = proc (handle: PCheck, status: Cint) {.cdecl.}
  IdleProc* = proc (handle: PIdle, status: Cint) {.cdecl.}

  PSockAddr* = ptr TSockAddr

  GetAddrInfoProc* = proc (handle: PGetAddrInfo, status: Cint, res: ptr Taddrinfo)

  ExitProc* = proc (a2: PProcess, exit_status: Cint, term_signal: Cint)
  FsProc* = proc (req: PFS)
  WorkProc* = proc (req: PWork)
  AfterWorkProc* = proc (req: PWork)

  FsEventProc* = proc (handle: PFsEvent, filename: Cstring, events: Cint, status: Cint)

  TErrorCode* {.size: sizeof(cint).} = enum
    UNKNOWN = - 1, OK = 0, EOF, EACCESS, EAGAIN, EADDRINUSE, EADDRNOTAVAIL,
    EAFNOSUPPORT, EALREADY, EBADF, EBUSY, ECONNABORTED, ECONNREFUSED,
    ECONNRESET, EDESTADDRREQ, EFAULT, EHOSTUNREACH, EINTR, EINVAL, EISCONN,
    EMFILE, EMSGSIZE, ENETDOWN, ENETUNREACH, ENFILE, ENOBUFS, ENOMEM, ENONET,
    ENOPROTOOPT, ENOTCONN, ENOTSOCK, ENOTSUP, ENOENT, EPIPE, EPROTO,
    EPROTONOSUPPORT, EPROTOTYPE, ETIMEDOUT, ECHARSET, EAIFAMNOSUPPORT,
    EAINONAME, EAISERVICE, EAISOCKTYPE, ESHUTDOWN, EEXIST

  THandleType* {.size: sizeof(cint).} = enum
    UNKNOWN_HANDLE = 0, TCP, UDP, NAMED_PIPE, TTY, FILE, TIMER, PREPARE, CHECK,
    IDLE, ASYNC, ARES_TASK, ARES_EVENT, PROCESS, FS_EVENT

  TReqType* {.size: sizeof(cint).} = enum
    rUNKNOWN_REQ = 0,
    rCONNECT,
    rACCEPT,
    rREAD,
    rWRITE,
    rSHUTDOWN,
    rWAKEUP,
    rUDP_SEND,
    rFS,
    rWORK,
    rGETADDRINFO,
    rREQ_TYPE_PRIVATE

  TErr* {.pure, final, importc: "uv_err_t", header: "uv.h".} = object
    code* {.importc: "code".}: TErrorCode
    sys_errno* {.importc: "sys_errno_".}: Cint

  TFsEventType* = enum
    evRENAME = 1,
    evCHANGE = 2

  TFsEvent* {.pure, final, importc: "uv_fs_event_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer
    filename {.importc: "filename".}: Cstring

  PFsEvent* = ptr TFsEvent

  TFsEvents* {.pure, final, importc: "uv_fs_event_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer
    filename* {.importc: "filename".}: Cstring

  TBuf* {.pure, final, importc: "uv_buf_t", header: "uv.h"} = object
    base* {.importc: "base".}: Cstring
    len* {.importc: "len".}: Csize

  TAnyHandle* {.pure, final, importc: "uv_any_handle", header: "uv.h".} = object
    tcp* {.importc: "tcp".}: TTcp
    pipe* {.importc: "pipe".}: TPipe
    prepare* {.importc: "prepare".}: TPrepare
    check* {.importc: "check".}: TCheck
    idle* {.importc: "idle".}: TIdle
    async* {.importc: "async".}: TAsync
    timer* {.importc: "timer".}: TTimer
    getaddrinfo* {.importc: "getaddrinfo".}: TGetaddrinfo
    fs_event* {.importc: "fs_event".}: TFsEvents

  TAnyReq* {.pure, final, importc: "uv_any_req", header: "uv.h".} = object
    req* {.importc: "req".}: TReq
    write* {.importc: "write".}: TWrite
    connect* {.importc: "connect".}: TConnect
    shutdown* {.importc: "shutdown".}: TShutdown
    fs_req* {.importc: "fs_req".}: TFS
    work_req* {.importc: "work_req".}: TWork

  ## better import this
  Uint64 = Int64

  TCounters* {.pure, final, importc: "uv_counters_t", header: "uv.h".} = object
    eio_init* {.importc: "eio_init".}: Uint64
    req_init* {.importc: "req_init".}: Uint64
    handle_init* {.importc: "handle_init".}: Uint64
    stream_init* {.importc: "stream_init".}: Uint64
    tcp_init* {.importc: "tcp_init".}: Uint64
    udp_init* {.importc: "udp_init".}: Uint64
    pipe_init* {.importc: "pipe_init".}: Uint64
    tty_init* {.importc: "tty_init".}: Uint64
    prepare_init* {.importc: "prepare_init".}: Uint64
    check_init* {.importc: "check_init".}: Uint64
    idle_init* {.importc: "idle_init".}: Uint64
    async_init* {.importc: "async_init".}: Uint64
    timer_init* {.importc: "timer_init".}: Uint64
    process_init* {.importc: "process_init".}: Uint64
    fs_event_init* {.importc: "fs_event_init".}: Uint64

  TLoop* {.pure, final, importc: "uv_loop_t", header: "uv.h".} = object
    # ares_handles_* {.importc: "uv_ares_handles_".}: pointer # XXX: This seems to be a private field? 
    eio_want_poll_notifier* {.importc: "uv_eio_want_poll_notifier".}: TAsync
    eio_done_poll_notifier* {.importc: "uv_eio_done_poll_notifier".}: TAsync
    eio_poller* {.importc: "uv_eio_poller".}: TIdle
    counters* {.importc: "counters".}: TCounters
    last_err* {.importc: "last_err".}: TErr
    data* {.importc: "data".}: Pointer

  PLoop* = ptr TLoop

  TShutdown* {.pure, final, importc: "uv_shutdown_t", header: "uv.h".} = object
    typ* {.importc: "type".}: TReqType
    data* {.importc: "data".}: Pointer
    handle* {.importc: "handle".}: PStream
    cb* {.importc: "cb".}: ShutdownProc

  PShutdown* = ptr TShutdown

  THandle* {.pure, final, importc: "uv_handle_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer

  PHandle* = ptr THandle

  TStream* {.pure, final, importc: "uv_stream_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    alloc_cb* {.importc: "alloc_cb".}: AllocProc
    read_cb* {.importc: "read_cb".}: ReadProc
    read2_cb* {.importc: "read2_cb".}: ReadProc2
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer
    write_queue_size* {.importc: "write_queue_size".}: Csize

  PStream* = ptr TStream

  TWrite* {.pure, final, importc: "uv_write_t", header: "uv.h".} = object
    typ* {.importc: "type".}: TReqType
    data* {.importc: "data".}: Pointer
    cb* {.importc: "cb".}: WriteProc
    send_handle* {.importc: "send_handle".}: PStream
    handle* {.importc: "handle".}: PStream

  PWrite* = ptr TWrite

  TTcp* {.pure, final, importc: "uv_tcp_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    alloc_cb* {.importc: "alloc_cb".}: AllocProc
    read_cb* {.importc: "read_cb".}: ReadProc
    read2_cb* {.importc: "read2_cb".}: ReadProc2
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer
    write_queue_size* {.importc: "write_queue_size".}: Csize

  PTcp* = ptr TTcp

  TConnect* {.pure, final, importc: "uv_connect_t", header: "uv.h".} = object
    typ* {.importc: "type".}: TReqType
    data* {.importc: "data".}: Pointer
    cb* {.importc: "cb".}: ConnectProc
    handle* {.importc: "handle".}: PStream

  PConnect* = ptr TConnect

  TUdpFlags* = enum
    UDP_IPV6ONLY = 1, UDP_PARTIAL = 2

  ## XXX: better import this
  Cunsigned = Int

  UdpSendProc* = proc (req: PUdpSend, status: Cint)
  UdpRecvProc* = proc (handle: PUdp, nread: Cssize, buf: TBuf, adr: ptr TSockAddr, flags: Cunsigned)

  TUdp* {.pure, final, importc: "uv_udp_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer

  PUdp* = ptr TUdp

  TUdpSend* {.pure, final, importc: "uv_udp_send_t", header: "uv.h".} = object
    typ* {.importc: "type".}: TReqType
    data* {.importc: "data".}: Pointer
    handle* {.importc: "handle".}: PUdp
    cb* {.importc: "cb".}: UdpSendProc

  PUdpSend* = ptr TUdpSend

  TTTy* {.pure, final, importc: "uv_tty_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    alloc_cb* {.importc: "alloc_cb".}: AllocProc
    read_cb* {.importc: "read_cb".}: ReadProc
    read2_cb* {.importc: "read2_cb".}: ReadProc2
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer
    write_queue_size* {.importc: "write_queue_size".}: Csize

  PTTy* = ptr TTTy

  TPipe* {.pure, final, importc: "uv_pipe_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    alloc_cb* {.importc: "alloc_cb".}: AllocProc
    read_cb* {.importc: "read_cb".}: ReadProc
    read2_cb* {.importc: "read2_cb".}: ReadProc2
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer
    write_queue_size* {.importc: "write_queue_size".}: Csize
    ipc {.importc: "ipc".}: Int

  PPipe* = ptr TPipe

  TPrepare* {.pure, final, importc: "uv_prepare_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer

  PPrepare* = ptr TPrepare

  TCheck* {.pure, final, importc: "uv_check_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer

  PCheck* = ptr TCheck

  TIdle* {.pure, final, importc: "uv_idle_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer

  PIdle* = ptr TIdle

  TAsync* {.pure, final, importc: "uv_async_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer

  PAsync* = ptr TAsync

  TTimer* {.pure, final, importc: "uv_timer_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer

  PTimer* = ptr TTimer

  TGetAddrInfo* {.pure, final, importc: "uv_getaddrinfo_t", header: "uv.h".} = object
    typ* {.importc: "type".}: TReqType
    data* {.importc: "data".}: Pointer
    loop* {.importc: "loop".}: PLoop

  PGetAddrInfo* = ptr TGetAddrInfo

  TProcessOptions* {.pure, final, importc: "uv_process_options_t", header: "uv.h".} = object
    exit_cb* {.importc: "exit_cb".}: ExitProc
    file* {.importc: "file".}: Cstring
    args* {.importc: "args".}: CstringArray
    env* {.importc: "env".}: CstringArray
    cwd* {.importc: "cwd".}: Cstring
    windows_verbatim_arguments* {.importc: "windows_verbatim_arguments".}: Cint
    stdin_stream* {.importc: "stdin_stream".}: PPipe
    stdout_stream* {.importc: "stdout_stream".}: PPipe
    stderr_stream* {.importc: "stderr_stream".}: PPipe

  PProcessOptions* = ptr TProcessOptions

  TProcess* {.pure, final, importc: "uv_process_t", header: "uv.h".} = object
    loop* {.importc: "loop".}: PLoop
    typ* {.importc: "type".}: THandleType
    close_cb* {.importc: "close_cb".}: CloseProc
    data* {.importc: "data".}: Pointer
    exit_cb* {.importc: "exit_cb".}: ExitProc
    pid* {.importc: "pid".}: Cint

  PProcess* = ptr TProcess

  TWork* {.pure, final, importc: "uv_work_t", header: "uv.h".} = object
    typ* {.importc: "type".}: TReqType
    data* {.importc: "data".}: Pointer
    loop* {.importc: "loop".}: PLoop
    work_cb* {.importc: "work_cb".}: WorkProc
    after_work_cb* {.importc: "after_work_cb".}: AfterWorkProc

  PWork* = ptr TWork

  TFsType* {.size: sizeof(cint).} = enum
    FS_UNKNOWN = - 1, FS_CUSTOM, FS_OPEN, FS_CLOSE, FS_READ, FS_WRITE,
    FS_SENDFILE, FS_STAT, FS_LSTAT, FS_FSTAT, FS_FTRUNCATE, FS_UTIME, FS_FUTIME,
    FS_CHMOD, FS_FCHMOD, FS_FSYNC, FS_FDATASYNC, FS_UNLINK, FS_RMDIR, FS_MKDIR,
    FS_RENAME, FS_READDIR, FS_LINK, FS_SYMLINK, FS_READLINK, FS_CHOWN, FS_FCHOWN

  TFS* {.pure, final, importc: "uv_fs_t", header: "uv.h".} = object
    typ* {.importc: "type".}: TReqType
    data* {.importc: "data".}: Pointer
    loop* {.importc: "loop".}: PLoop
    fs_type* {.importc: "fs_type".}: TFsType
    cb* {.importc: "cb".}: FsProc
    result* {.importc: "result".}: Cssize
    fsPtr* {.importc: "ptr".}: Pointer
    path* {.importc: "path".}: Cstring
    errorno* {.importc: "errorno".}: Cint

  PFS* = ptr TFS

  TReq* {.pure, final, importc: "uv_req_t", header: "uv.h".} = object
    typ* {.importc: "type".}: TReqType
    data* {.importc: "data".}: Pointer

  PReq* = ptr TReq

  TAresOptions* {.pure, final, importc: "ares_options", header: "uv.h".} = object
    flags* {.importc: "flags".}: Int
    timeout* {.importc: "timeout".}: Int
    tries* {.importc: "tries".}: Int
    ndots* {.importc: "ndots".}: Int
    udp_port* {.importc: "udp_port".}: TPort
    tcp_port* {.importc: "tcp_port".}: TPort
    socket_send_buffer_size* {.importc: "socket_send_buffer_size".}: Int
    socket_recv_buffer_size* {.importc: "socket_receive_buffer_size".}: Int
    servers* {.importc: "servers".}: ptr TInAddr
    nservers* {.importc: "nservers".}: Int
    domains* {.importc: "domains".}: ptr Cstring
    ndomains* {.importc: "ndomains".}: Int
    lookups* {.importc: "lookups".}: Cstring

  #XXX: not yet exported
  #ares_sock_state_cb sock_state_cb;
  #void *sock_state_cb_data;
  #struct apattern *sortlist;
  #int nsort;

  PAresOptions* = ptr TAresOptions
  PAresChannel* = Pointer

proc loopNew*(): PLoop{.
    importc: "uv_loop_new", header: "uv.h".}

proc loopDelete*(a2: PLoop){.
    importc: "uv_loop_delete", header: "uv.h".}

proc defaultLoop*(): PLoop{.
    importc: "uv_default_loop", header: "uv.h".}

proc run*(a2: PLoop): Cint{.
    importc: "uv_run", header: "uv.h".}

proc addref*(a2: PLoop){.
    importc: "uv_ref", header: "uv.h".}

proc unref*(a2: PLoop){.
    importc: "uv_unref", header: "uv.h".}

proc updateTime*(a2: PLoop){.
    importc: "uv_update_time", header: "uv.h".}

proc now*(a2: PLoop): Int64{.
    importc: "uv_now", header: "uv.h".}

proc lastError*(a2: PLoop): TErr{.
    importc: "uv_last_error", header: "uv.h".}

proc strerror*(err: TErr): Cstring{.
    importc: "uv_strerror", header: "uv.h".}

proc errName*(err: TErr): Cstring{.
    importc: "uv_err_name", header: "uv.h".}

proc shutdown*(req: PShutdown, handle: PStream, cb: ShutdownProc): Cint{.
    importc: "uv_shutdown", header: "uv.h".}

proc isActive*(handle: PHandle): Cint{.
    importc: "uv_is_active", header: "uv.h".}

proc close*(handle: PHandle, close_cb: CloseProc){.
    importc: "uv_close", header: "uv.h".}

proc bufInit*(base: Cstring, len: Csize): TBuf{.
    importc: "uv_buf_init", header: "uv.h".}

proc listen*(stream: PStream, backlog: Cint, cb: ConnectionProc): Cint{.
    importc: "uv_listen", header: "uv.h".}

proc accept*(server: PStream, client: PStream): Cint{.
    importc: "uv_accept", header: "uv.h".}

proc readStart*(a2: PStream, alloc_cb: AllocProc, read_cb: ReadProc): Cint{.
    importc: "uv_read_start", header: "uv.h".}

proc readStart*(a2: PStream, alloc_cb: AllocProc, read_cb: ReadProc2): Cint{.
    importc: "uv_read2_start", header: "uv.h".}

proc readStop*(a2: PStream): Cint{.
    importc: "uv_read_stop", header: "uv.h".}

proc write*(req: PWrite, handle: PStream, bufs: ptr TBuf, bufcnt: Cint, cb: WriteProc): Cint{.
    importc: "uv_write", header: "uv.h".}

proc write*(req: PWrite, handle: PStream, bufs: ptr TBuf, bufcnt: Cint, send_handle: PStream, cb: WriteProc): Cint{.
    importc: "uv_write2", header: "uv.h".}

proc tcpInit*(a2: PLoop, handle: PTcp): Cint{.
    importc: "uv_tcp_init", header: "uv.h".}

proc tcpBind*(handle: PTcp, a3: TsockaddrIn): Cint{.
    importc: "uv_tcp_bind", header: "uv.h".}

proc tcpBind6*(handle: PTcp, a3: TsockaddrIn6): Cint{.
    importc: "uv_tcp_bind6", header: "uv.h".}

proc tcpGetsockname*(handle: PTcp, name: ptr TSockAddr, namelen: var Cint): Cint{.
    importc: "uv_tcp_getsockname", header: "uv.h".}

proc tcpGetpeername*(handle: PTcp, name: ptr TSockAddr, namelen: var Cint): Cint{.
    importc: "uv_tcp_getpeername", header: "uv.h".}

proc tcpConnect*(req: PConnect, handle: PTcp, address: TsockaddrIn, cb: ConnectProc): Cint{.
    importc: "uv_tcp_connect", header: "uv.h".}

proc tcpConnect6*(req: PConnect, handle: PTcp, address: TsockaddrIn6, cb: ConnectProc): Cint{.
    importc: "uv_tcp_connect6", header: "uv.h".}

proc udpInit*(a2: PLoop, handle: PUdp): Cint{.
    importc: "uv_udp_init", header: "uv.h".}

proc udpBind*(handle: PUdp, adr: TsockaddrIn, flags: Cunsigned): Cint{.
    importc: "uv_udp_bind", header: "uv.h".}

proc udpBind6*(handle: PUdp, adr: TsockaddrIn6, flags: Cunsigned): Cint{.
    importc: "uv_udp_bind6", header: "uv.h".}

proc udpGetsockname*(handle: PUdp, name: ptr TSockAddr, namelen: var Cint): Cint{.
    importc: "uv_udp_getsockname", header: "uv.h".}

proc udpSend*(req: PUdpSend, handle: PUdp, bufs: ptr TBuf, bufcnt: Cint, adr: TsockaddrIn, send_cb: UdpSendProc): Cint{.
    importc: "uv_udp_send", header: "uv.h".}

proc udpSend6*(req: PUdpSend, handle: PUdp, bufs: ptr TBuf, bufcnt: Cint, adr: TsockaddrIn6, send_cb: UdpSendProc): Cint{.
    importc: "uv_udp_send6", header: "uv.h".}

proc udpRecvStart*(handle: PUdp, alloc_cb: AllocProc, recv_cb: UdpRecvProc): Cint{.
    importc: "uv_udp_recv_start", header: "uv.h".}

proc udpRecvStop*(handle: PUdp): Cint{.
    importc: "uv_udp_recv_stop", header: "uv.h".}

proc ttyInit*(a2: PLoop, a3: PTTy, fd: TFile): Cint{.
    importc: "uv_tty_init", header: "uv.h".}

proc ttySetMode*(a2: PTTy, mode: Cint): Cint{.
    importc: "uv_tty_set_mode", header: "uv.h".}

proc ttyGetWinsize*(a2: PTTy, width: var Cint, height: var Cint): Cint{.
    importc: "uv_tty_get_winsize", header: "uv.h".}

proc ttyResetMode*() {.
    importc: "uv_tty_reset_mode", header: "uv.h".}

proc guessHandle*(file: TFile): THandleType{.
    importc: "uv_guess_handle", header: "uv.h".}

proc pipeInit*(a2: PLoop, handle: PPipe, ipc: Int): Cint{.
    importc: "uv_pipe_init", header: "uv.h".}

proc pipeOpen*(a2: PPipe, file: TFile){.
    importc: "uv_pipe_open", header: "uv.h".}

proc pipeBind*(handle: PPipe, name: Cstring): Cint{.
    importc: "uv_pipe_bind", header: "uv.h".}

proc pipeConnect*(req: PConnect, handle: PPipe, name: Cstring, cb: ConnectProc): Cint{.
    importc: "uv_pipe_connect", header: "uv.h".}

proc prepareInit*(a2: PLoop, prepare: PPrepare): Cint{.
    importc: "uv_prepare_init", header: "uv.h".}

proc prepareStart*(prepare: PPrepare, cb: PrepareProc): Cint{.
    importc: "uv_prepare_start", header: "uv.h".}

proc prepareStop*(prepare: PPrepare): Cint{.
    importc: "uv_prepare_stop", header: "uv.h".}

proc checkInit*(a2: PLoop, check: PCheck): Cint{.
    importc: "uv_check_init", header: "uv.h".}

proc checkStart*(check: PCheck, cb: CheckProc): Cint{.
    importc: "uv_check_start", header: "uv.h".}

proc checkStop*(check: PCheck): Cint{.
    importc: "uv_check_stop", header: "uv.h".}

proc idleInit*(a2: PLoop, idle: PIdle): Cint{.
    importc: "uv_idle_init", header: "uv.h".}

proc idleStart*(idle: PIdle, cb: IdleProc): Cint{.
    importc: "uv_idle_start", header: "uv.h".}

proc idleStop*(idle: PIdle): Cint{.
    importc: "uv_idle_stop", header: "uv.h".}

proc asyncInit*(a2: PLoop, async: PAsync, async_cb: AsyncProc): Cint{.
    importc: "uv_async_init", header: "uv.h".}

proc asyncSend*(async: PAsync): Cint{.
    importc: "uv_async_send", header: "uv.h".}

proc timerInit*(a2: PLoop, timer: PTimer): Cint{.
    importc: "uv_timer_init", header: "uv.h".}

proc timerStart*(timer: PTimer, cb: TimerProc, timeout: Int64, repeat: Int64): Cint{.
    importc: "uv_timer_start", header: "uv.h".}

proc timerStop*(timer: PTimer): Cint{.
    importc: "uv_timer_stop", header: "uv.h".}

proc timerAgain*(timer: PTimer): Cint{.
    importc: "uv_timer_again", header: "uv.h".}

proc timerSetRepeat*(timer: PTimer, repeat: Int64){.
    importc: "uv_timer_set_repeat", header: "uv.h".}

proc timerGetRepeat*(timer: PTimer): Int64{.
    importc: "uv_timer_get_repeat", header: "uv.h".}

proc aresInitOptions*(a2: PLoop, channel: PAresChannel, options: PAresOptions, optmask: Cint): Cint{.
    importc: "uv_ares_init_options", header: "uv.h".}

proc aresDestroy*(a2: PLoop, channel: PAresChannel){.
    importc: "uv_ares_destroy", header: "uv.h".}

proc getaddrinfo*(a2: PLoop, handle: PGetAddrInfo,getaddrinfo_cb: GetAddrInfoProc, node: Cstring, service: Cstring, hints: ptr Taddrinfo): Cint{.
    importc: "uv_getaddrinfo", header: "uv.h".}

proc freeaddrinfo*(ai: ptr Taddrinfo){.
    importc: "uv_freeaddrinfo", header: "uv.h".}

proc spawn*(a2: PLoop, a3: PProcess, options: TProcessOptions): Cint{.
    importc: "uv_spawn", header: "uv.h".}

proc processKill*(a2: PProcess, signum: Cint): Cint{.
    importc: "uv_process_kill", header: "uv.h".}

proc queueWork*(loop: PLoop, req: PWork, work_cb: WorkProc, after_work_cb: AfterWorkProc): Cint{.
    importc: "uv_queue_work", header: "uv.h".}

proc reqCleanup*(req: PFS){.
    importc: "uv_fs_req_cleanup", header: "uv.h".}

proc close*(loop: PLoop, req: PFS, file: TFile, cb: FsProc): Cint{.
    importc: "uv_fs_close", header: "uv.h".}

proc open*(loop: PLoop, req: PFS, path: Cstring, flags: Cint, mode: Cint, cb: FsProc): Cint{.
    importc: "uv_fs_open", header: "uv.h".}

proc read*(loop: PLoop, req: PFS, file: TFile, buf: Pointer, length: Csize, offset: Coff, cb: FsProc): Cint{.
    importc: "uv_fs_read", header: "uv.h".}

proc unlink*(loop: PLoop, req: PFS, path: Cstring, cb: FsProc): Cint{.
    importc: "uv_fs_unlink", header: "uv.h".}

proc write*(loop: PLoop, req: PFS, file: TFile, buf: Pointer, length: Csize, offset: Coff, cb: FsProc): Cint{.
    importc: "uv_fs_write", header: "uv.h".}

proc mkdir*(loop: PLoop, req: PFS, path: Cstring, mode: Cint, cb: FsProc): Cint{.
    importc: "uv_fs_mkdir", header: "uv.h".}

proc rmdir*(loop: PLoop, req: PFS, path: Cstring, cb: FsProc): Cint{.
    importc: "uv_fs_rmdir", header: "uv.h".}

proc readdir*(loop: PLoop, req: PFS, path: Cstring, flags: Cint, cb: FsProc): Cint{.
    importc: "uv_fs_readdir", header: "uv.h".}

proc stat*(loop: PLoop, req: PFS, path: Cstring, cb: FsProc): Cint{.
    importc: "uv_fs_stat", header: "uv.h".}

proc fstat*(loop: PLoop, req: PFS, file: TFile, cb: FsProc): Cint{.
    importc: "uv_fs_fstat", header: "uv.h".}

proc rename*(loop: PLoop, req: PFS, path: Cstring, new_path: Cstring, cb: FsProc): Cint{.
    importc: "uv_fs_rename", header: "uv.h".}

proc fsync*(loop: PLoop, req: PFS, file: TFile, cb: FsProc): Cint{.
    importc: "uv_fs_fsync", header: "uv.h".}

proc fdatasync*(loop: PLoop, req: PFS, file: TFile, cb: FsProc): Cint{.
    importc: "uv_fs_fdatasync", header: "uv.h".}

proc ftruncate*(loop: PLoop, req: PFS, file: TFile, offset: Coff, cb: FsProc): Cint{.
    importc: "uv_fs_ftruncate", header: "uv.h".}

proc sendfile*(loop: PLoop, req: PFS, out_fd: TFile, in_fd: TFile, in_offset: Coff, length: Csize, cb: FsProc): Cint{.
    importc: "uv_fs_sendfile", header: "uv.h".}

proc chmod*(loop: PLoop, req: PFS, path: Cstring, mode: Cint, cb: FsProc): Cint{.
    importc: "uv_fs_chmod", header: "uv.h".}

proc utime*(loop: PLoop, req: PFS, path: Cstring, atime: Cdouble, mtime: Cdouble, cb: FsProc): Cint{.
    importc: "uv_fs_utime", header: "uv.h".}

proc futime*(loop: PLoop, req: PFS, file: TFile, atime: Cdouble, mtime: Cdouble, cb: FsProc): Cint{.
    importc: "uv_fs_futime", header: "uv.h".}

proc lstat*(loop: PLoop, req: PFS, path: Cstring, cb: FsProc): Cint{.
    importc: "uv_fs_lstat", header: "uv.h".}

proc link*(loop: PLoop, req: PFS, path: Cstring, new_path: Cstring, cb: FsProc): Cint{.
    importc: "uv_fs_link", header: "uv.h".}

proc symlink*(loop: PLoop, req: PFS, path: Cstring, new_path: Cstring, flags: Cint, cb: FsProc): Cint{.
    importc: "uv_fs_symlink", header: "uv.h".}

proc readlink*(loop: PLoop, req: PFS, path: Cstring, cb: FsProc): Cint{.
    importc: "uv_fs_readlink", header: "uv.h".}

proc fchmod*(loop: PLoop, req: PFS, file: TFile, mode: Cint, cb: FsProc): Cint{.
    importc: "uv_fs_fchmod", header: "uv.h".}

proc chown*(loop: PLoop, req: PFS, path: Cstring, uid: Cint, gid: Cint, cb: FsProc): Cint{.
    importc: "uv_fs_chown", header: "uv.h".}

proc fchown*(loop: PLoop, req: PFS, file: TFile, uid: Cint, gid: Cint, cb: FsProc): Cint{.
    importc: "uv_fs_fchown", header: "uv.h".}

proc eventInit*(loop: PLoop, handle: PFsEvent, filename: Cstring, cb: FsEventProc): Cint{.
    importc: "uv_fs_event_init", header: "uv.h".}

proc ip4Addr*(ip: Cstring, port: Cint): TsockaddrIn{.
    importc: "uv_ip4_addr", header: "uv.h".}

proc ip6Addr*(ip: Cstring, port: Cint): TsockaddrIn6{.
    importc: "uv_ip6_addr", header: "uv.h".}

proc ip4Name*(src: ptr TsockaddrIn, dst: Cstring, size: Csize): Cint{.
    importc: "uv_ip4_name", header: "uv.h".}

proc ip6Name*(src: ptr TsockaddrIn6, dst: Cstring, size: Csize): Cint{.
    importc: "uv_ip6_name", header: "uv.h".}

proc exepath*(buffer: Cstring, size: var Csize): Cint{.
    importc: "uv_exepath", header: "uv.h".}

proc hrtime*(): Uint64{.
    importc: "uv_hrtime", header: "uv.h".}

proc loadavg*(load: var Array[0..2, Cdouble]) {.
    importc: "uv_loadavg", header: "uv.h"}

proc getFreeMemory*(): Cdouble {.
    importc: "uv_get_free_memory", header: "uv.h".}

proc getTotalMemory*(): Cdouble {.
    importc: "uv_get_total_memory", header: "uv.h".}

