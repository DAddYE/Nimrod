discard """
  file: "tthreadanalysis3.nim"
  line: 35
  errormsg: "write to foreign heap"
  cmd: "nimrod cc --hints:on --threads:on $# $#"
"""

import os

var
  thr: Array [0..5, TThread[tuple[a, b: Int]]]

proc doNothing() = nil

type
  PNode = ref TNode
  TNode = object {.pure.}
    le, ri: PNode
    data: String

var
  root: PNode

proc buildTree(depth: Int): PNode =
  if depth == 3: return nil
  new(result)
  result.le = buildTree(depth-1)
  result.ri = buildTree(depth-1)
  result.data = $depth

proc echoLeTree(n: PNode) =
  var it = n
  while it != nil:
    echo it.data
    it = it.le

proc threadFunc(interval: tuple[a, b: Int]) {.thread.} = 
  doNothing()
  for i in interval.a..interval.b: 
    var r = buildTree(i)
    echoLeTree(r) # for local data
  echoLeTree(root) # and the same for foreign data :-)

proc main =
  root = buildTree(5)
  for i in 0..high(thr):
    createThread(thr[i], threadFunc, (i*100, i*100+50))
  joinThreads(thr)

main()

