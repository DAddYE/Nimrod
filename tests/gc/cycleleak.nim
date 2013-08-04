discard """
  outputsub: "no leak: "
"""

type
  Module = object
    nodes*: Seq[PNode]
    id: Int

  PModule = ref Module

  Node = object
    owner*: PModule
    data*: Array[0..200, Char] # some fat to drain memory faster
    id: Int

  PNode = ref Node

var
  gid: Int

when false:
  proc finalizeNode(x: PNode) =
    echo "node id: ", x.id
  proc finalizeModule(x: PModule) =
    echo "module id: ", x.id

proc newNode(owner: PModule): PNode =
  new(result)
  result.owner = owner
  inc gid
  result.id = gid

proc compileModule: PModule =
  new(result)
  result.nodes = @[]
  for i in 0..100:
    result.nodes.add newNode(result)
  inc gid
  result.id = gid

var gModuleCache: PModule

proc loop =
  for i in 0..1000:
    gModuleCache = compileModule()
    gModuleCache = nil
    gCFullCollect()

    if getOccupiedMem() > 9_000_000:
      echo "still a leak! ", getOccupiedMem()
      quit(1)
  echo "no leak: ", getOccupiedMem()

loop()

