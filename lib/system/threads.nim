#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## Thread support for Nimrod. **Note**: This is part of the system module.
## Do not import it directly. To activate thread support you need to compile
## with the ``--threads:on`` command line switch.
##
## Nimrod's memory model for threads is quite different from other common 
## programming languages (C, Pascal): Each thread has its own
## (garbage collected) heap and sharing of memory is restricted. This helps
## to prevent race conditions and improves efficiency. See `the manual for
## details of this memory model <manual.html#threads>`_.
##
## Example:
##
## .. code-block:: nimrod
##
##  import locks
##
##  var
##    thr: array [0..4, TThread[tuple[a,b: int]]]
##    L: TLock
##  
##  proc threadFunc(interval: tuple[a,b: int]) {.thread.} =
##    for i in interval.a..interval.b:
##      Acquire(L) # lock stdout
##      echo i
##      Release(L)
##
##  InitLock(L)
##
##  for i in 0..high(thr):
##    createThread(thr[i], threadFunc, (i*10, i*10+5))
##  joinThreads(thr)
  
const
  maxRegisters = 256 # don't think there is an arch with more registers
  useStackMaskHack = false ## use the stack mask hack for better performance
  StackGuardSize = 4096
  ThreadStackMask = 1024*256*sizeof(int)-1
  ThreadStackSize = ThreadStackMask+1 - StackGuardSize

when defined(windows):
  type
    TSysThread = THandle
    TWinThreadProc = proc (x: pointer): int32 {.stdcall.}

  proc CreateThread(lpThreadAttributes: Pointer, dwStackSize: int32,
                     lpStartAddress: TWinThreadProc, 
                     lpParameter: Pointer,
                     dwCreationFlags: int32, 
                     lpThreadId: var int32): TSysThread {.
    stdcall, dynlib: "kernel32", importc: "CreateThread".}

  proc winSuspendThread(hThread: TSysThread): int32 {.
    stdcall, dynlib: "kernel32", importc: "SuspendThread".}
      
  proc winResumeThread(hThread: TSysThread): int32 {.
    stdcall, dynlib: "kernel32", importc: "ResumeThread".}

  proc WaitForMultipleObjects(nCount: int32,
                              lpHandles: ptr TSysThread,
                              bWaitAll: int32,
                              dwMilliseconds: int32): int32 {.
    stdcall, dynlib: "kernel32", importc: "WaitForMultipleObjects".}

  proc TerminateThread(hThread: TSysThread, dwExitCode: int32): int32 {.
    stdcall, dynlib: "kernel32", importc: "TerminateThread".}
    
  type
    TThreadVarSlot = distinct int32

  proc ThreadVarAlloc(): TThreadVarSlot {.
    importc: "TlsAlloc", stdcall, dynlib: "kernel32".}
  proc ThreadVarSetValue(dwTlsIndex: TThreadVarSlot, lpTlsValue: pointer) {.
    importc: "TlsSetValue", stdcall, dynlib: "kernel32".}
  proc ThreadVarGetValue(dwTlsIndex: TThreadVarSlot): pointer {.
    importc: "TlsGetValue", stdcall, dynlib: "kernel32".}
  
else:
  {.passL: "-pthread".}
  {.passC: "-pthread".}

  type
    TSysThread {.importc: "pthread_t", header: "<sys/types.h>",
                 final, pure.} = object
    TpthreadAttr {.importc: "pthread_attr_t",
                     header: "<sys/types.h>", final, pure.} = object
                 
    Ttimespec {.importc: "struct timespec",
                header: "<time.h>", final, pure.} = object
      tv_sec: Int
      tv_nsec: Int

  proc pthread_attr_init(a1: var TpthreadAttr) {.
    importc, header: "<pthread.h>".}
  proc pthread_attr_setstacksize(a1: var TpthreadAttr, a2: Int) {.
    importc, header: "<pthread.h>".}

  proc pthreadCreate(a1: var TSysThread, a2: var TpthreadAttr,
            a3: proc (x: Pointer) {.noconv.}, 
            a4: Pointer): Cint {.importc: "pthread_create", 
            header: "<pthread.h>".}
  proc pthread_join(a1: TSysThread, a2: ptr Pointer): Cint {.
    importc, header: "<pthread.h>".}

  proc pthreadCancel(a1: TSysThread): Cint {.
    importc: "pthread_cancel", header: "<pthread.h>".}

  proc acquireSysTimeoutAux(L: var TSysLock, timeout: var Ttimespec): Cint {.
    importc: "pthread_mutex_timedlock", header: "<time.h>".}

  proc acquireSysTimeout(L: var TSysLock, msTimeout: Int) {.inline.} =
    var a: Ttimespec
    a.tv_sec = msTimeout div 1000
    a.tv_nsec = (msTimeout mod 1000) * 1000
    var res = acquireSysTimeoutAux(L, a)
    if res != 0'i32: raise newException(EResourceExhausted, $strerror(res))

  type
    TThreadVarSlot {.importc: "pthread_key_t", pure, final,
                   header: "<sys/types.h>".} = object

  proc pthreadGetspecific(a1: TThreadVarSlot): Pointer {.
    importc: "pthread_getspecific", header: "<pthread.h>".}
  proc pthreadKeyCreate(a1: ptr TThreadVarSlot, 
                          destruct: proc (x: Pointer) {.noconv.}): Int32 {.
    importc: "pthread_key_create", header: "<pthread.h>".}
  proc pthreadKeyDelete(a1: TThreadVarSlot): Int32 {.
    importc: "pthread_key_delete", header: "<pthread.h>".}

  proc pthreadSetspecific(a1: TThreadVarSlot, a2: Pointer): Int32 {.
    importc: "pthread_setspecific", header: "<pthread.h>".}
  
  proc threadVarAlloc(): TThreadVarSlot {.inline.} =
    discard pthreadKeyCreate(addr(result), nil)
  proc threadVarSetValue(s: TThreadVarSlot, value: Pointer) {.inline.} =
    discard pthreadSetspecific(s, value)
  proc threadVarGetValue(s: TThreadVarSlot): Pointer {.inline.} =
    result = pthreadGetspecific(s)

  when useStackMaskHack:
    proc pthread_attr_setstack(attr: var TPthread_attr, stackaddr: pointer,
                               size: int): cint {.
      importc: "pthread_attr_setstack", header: "<pthread.h>".}

const
  emulatedThreadVars = compileOption("tlsEmulation")

when emulatedThreadVars:
  # the compiler generates this proc for us, so that we can get the size of
  # the thread local var block; we use this only for sanity checking though
  proc nimThreadVarsSize(): Int {.noconv, importc: "NimThreadVarsSize".}

# we preallocate a fixed size for thread local storage, so that no heap
# allocations are needed. Currently less than 7K are used on a 64bit machine.
# We use ``float`` for proper alignment:
type
  TThreadLocalStorage = Array [0..1_000, Float]

  PGcThread = ptr TGcThread
  TGcThread {.pure, inheritable.} = object
    sys: TSysThread
    when emulatedThreadVars and not useStackMaskHack:
      tls: TThreadLocalStorage
    else:
      nil
    when hasSharedHeap:
      next, prev: PGcThread
      stackBottom, stackTop: pointer
      stackSize: int
    else:
      nil

# XXX it'd be more efficient to not use a global variable for the 
# thread storage slot, but to rely on the implementation to assign slot X
# for us... ;-)
var globalsSlot = threadVarAlloc()
#const globalsSlot = TThreadVarSlot(0)
#sysAssert checkSlot.int == globalsSlot.int

when emulatedThreadVars:
  proc GetThreadLocalVars(): Pointer {.compilerRtl, inl.} =
    result = addr(cast[PGcThread](threadVarGetValue(globalsSlot)).tls)

when useStackMaskHack:
  proc MaskStackPointer(offset: int): pointer {.compilerRtl, inl.} =
    var x {.volatile.}: pointer
    x = addr(x)
    result = cast[pointer]((cast[int](x) and not ThreadStackMask) +% 
      (0) +% offset)

# create for the main thread. Note: do not insert this data into the list
# of all threads; it's not to be stopped etc.
when not defined(useNimRtl):
  
  when not useStackMaskHack:
    var mainThread: TGcThread
    threadVarSetValue(globalsSlot, addr(mainThread))
    when not defined(createNimRtl): initStackBottom()
    initGC()
    
  when emulatedThreadVars:
    if nimThreadVarsSize() > sizeof(TThreadLocalStorage):
      echo "too large thread local storage size requested"
      quit 1
  
  when hasSharedHeap and not defined(boehmgc) and not defined(nogc):
    var
      threadList: PGcThread
      
    proc registerThread(t: PGcThread) = 
      # we need to use the GC global lock here!
      AcquireSys(HeapLock)
      t.prev = nil
      t.next = threadList
      if threadList != nil: 
        sysAssert(threadList.prev == nil, "threadList.prev == nil")
        threadList.prev = t
      threadList = t
      ReleaseSys(HeapLock)
    
    proc unregisterThread(t: PGcThread) =
      # we need to use the GC global lock here!
      AcquireSys(HeapLock)
      if t == threadList: threadList = t.next
      if t.next != nil: t.next.prev = t.prev
      if t.prev != nil: t.prev.next = t.next
      # so that a thread can be unregistered twice which might happen if the
      # code executes `destroyThread`:
      t.next = nil
      t.prev = nil
      ReleaseSys(HeapLock)
      
    # on UNIX, the GC uses ``SIGFREEZE`` to tell every thread to stop so that
    # the GC can examine the stacks?
    proc stopTheWord() = nil
    
# We jump through some hops here to ensure that Nimrod thread procs can have
# the Nimrod calling convention. This is needed because thread procs are 
# ``stdcall`` on Windows and ``noconv`` on UNIX. Alternative would be to just
# use ``stdcall`` since it is mapped to ``noconv`` on UNIX anyway.

type
  TThread* {.pure, final.}[TArg] =
      object of TGcThread ## Nimrod thread. A thread is a heavy object (~14K)
                          ## that **must not** be part of a message! Use
                          ## a ``TThreadId`` for that.
    when TArg is void:
      dataFn: proc () {.nimcall.}
    else:
      dataFn: proc (m: TArg) {.nimcall.}
      data: TArg
  TThreadId*[TArg] = ptr TThread[TArg] ## the current implementation uses
                                       ## a pointer as a thread ID.

when not defined(boehmgc) and not hasSharedHeap:
  proc deallocOsPages()

template threadProcWrapperBody(closure: Expr) {.immediate.} =
  when defined(globalsSlot): threadVarSetValue(globalsSlot, closure)
  var t = cast[ptr TThread[TArg]](closure)
  when useStackMaskHack:
    var tls: TThreadLocalStorage
  when not defined(boehmgc) and not defined(nogc) and not hasSharedHeap:
    # init the GC for this thread:
    setStackBottom(addr(t))
    initGC()
  when defined(registerThread):
    t.stackBottom = addr(t)
    registerThread(t)
  when TArg is Void: t.dataFn()
  else: t.dataFn(t.data)
  when defined(registerThread): unregisterThread(t)
  when defined(deallocOsPages): deallocOsPages()
  # Since an unhandled exception terminates the whole process (!), there is
  # no need for a ``try finally`` here, nor would it be correct: The current
  # exception is tried to be re-raised by the code-gen after the ``finally``!
  # However this is doomed to fail, because we already unmapped every heap
  # page!
  
  # mark as not running anymore:
  t.dataFn = nil
  
{.push stack_trace:off.}
when defined(windows):
  proc threadProcWrapper[TArg](closure: pointer): int32 {.stdcall.} = 
    ThreadProcWrapperBody(closure)
    # implicitely return 0
else:
  proc threadProcWrapper[TArg](closure: Pointer) {.noconv.} = 
    ThreadProcWrapperBody(closure)
{.pop.}

proc running*[TArg](t: TThread[TArg]): Bool {.inline.} = 
  ## returns true if `t` is running.
  result = t.dataFn != nil

proc joinThread*[TArg](t: TThread[TArg]) {.inline.} = 
  ## waits for the thread `t` to finish.
  when hostOS == "windows":
    discard WaitForSingleObject(t.sys, -1'i32)
  else:
    discard pthread_join(t.sys, nil)

proc joinThreads*[TArg](t: Varargs[TThread[TArg]]) = 
  ## waits for every thread in `t` to finish.
  when hostOS == "windows":
    var a: Array[0..255, TSysThread]
    sysAssert a.len >= t.len, "a.len >= t.len"
    for i in 0..t.high: a[i] = t[i].sys
    discard WaitForMultipleObjects(t.len.int32, 
                                   cast[ptr TSysThread](addr(a)), 1, -1)
  else:
    for i in 0..t.high: joinThread(t[i])

when false:
  # XXX a thread should really release its heap here somehow:
  proc destroyThread*[TArg](t: var TThread[TArg]) =
    ## forces the thread `t` to terminate. This is potentially dangerous if
    ## you don't have full control over `t` and its acquired resources.
    when hostOS == "windows":
      discard TerminateThread(t.sys, 1'i32)
    else:
      discard pthread_cancel(t.sys)
    when defined(registerThread): unregisterThread(addr(t))
    t.dataFn = nil

proc createThread*[TArg](t: var TThread[TArg], 
                         tp: proc (arg: TArg) {.thread.}, 
                         param: TArg) =
  ## creates a new thread `t` and starts its execution. Entry point is the
  ## proc `tp`. `param` is passed to `tp`. `TArg` can be ``void`` if you
  ## don't need to pass any data to the thread.
  when TArg isnot Void: t.data = param
  t.dataFn = tp
  when hasSharedHeap: t.stackSize = ThreadStackSize
  when hostOS == "windows":
    var dummyThreadId: Int32
    t.sys = createThread(nil, ThreadStackSize, threadProcWrapper[TArg],
                         addr(t), 0'i32, dummyThreadId)
    if t.sys <= 0:
      raise newException(EResourceExhausted, "cannot create thread")
  else:
    var a {.noinit.}: TpthreadAttr
    pthread_attr_init(a)
    pthread_attr_setstacksize(a, ThreadStackSize)
    if pthreadCreate(t.sys, a, threadProcWrapper[TArg], addr(t)) != 0:
      raise newException(EResourceExhausted, "cannot create thread")

proc threadId*[TArg](t: var TThread[TArg]): TThreadId[TArg] {.inline.} =
  ## returns the thread ID of `t`.
  result = addr(t)

proc myThreadId*[TArg](): TThreadId[TArg] =
  ## returns the thread ID of the thread that calls this proc. This is unsafe
  ## because the type ``TArg`` is not checked for consistency!
  result = cast[TThreadId[TArg]](threadVarGetValue(globalsSlot))

when false:
  proc mainThreadId*[TArg](): TThreadId[TArg] =
    ## returns the thread ID of the main thread.
    result = cast[TThreadId[TArg]](addr(mainThread))

when useStackMaskHack:
  proc runMain(tp: proc () {.thread.}) {.compilerproc.} =
    var mainThread: TThread[pointer]
    createThread(mainThread, tp)
    joinThread(mainThread)

