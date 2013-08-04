discard """
  outputsub: "101"
  cmd: "nimrod cc --hints:on --threads:on $# $#"
"""

import os, locks

const
  noDeadlocks = defined(preventDeadlocks)

var
  thr: Array [0..5, TThread[tuple[a, b: Int]]]
  L, m, n: TLock

proc doNothing() = nil

proc threadFunc(interval: tuple[a, b: Int]) {.thread.} = 
  doNothing()
  for i in interval.a..interval.b: 
    when nodeadlocks:
      case i mod 6
      of 0:
        Acquire(L) # lock stdout
        Acquire(M)
        Acquire(N)
      of 1:
        Acquire(L)
        Acquire(N) # lock stdout
        Acquire(M)
      of 2:
        Acquire(M)
        Acquire(L)
        Acquire(N)
      of 3:
        Acquire(M)
        Acquire(N)
        Acquire(L)
      of 4:
        Acquire(N)
        Acquire(M)
        Acquire(L)
      of 5:
        Acquire(N)
        Acquire(L)
        Acquire(M)
      else: assert false
    else:
      acquire(L) # lock stdout
      acquire(m)
      
    echo i
    os.sleep(10)
    when nodeadlocks:
      echo "deadlocks prevented: ", deadlocksPrevented
    when nodeadlocks:
      Release(N)
    release(m)
    release(L)

initLock(L)
initLock(m)
initLock(n)

proc main =
  for i in 0..high(thr):
    createThread(thr[i], threadFunc, (i*100, i*100+50))
  joinThreads(thr)

main()

