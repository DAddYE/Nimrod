discard """
  outputsub: "no leak: "
"""

type
  Cyclic = object
    sibling: PCyclic
    data: Array[0..200, Char]

  PCyclic = ref Cyclic

proc makePair: PCyclic =
  new(result)
  new(result.sibling)
  result.sibling.sibling = result

proc loop =
  for i in 0..10000:
    var x = makePair()
    gCFullCollect()
    x = nil
    gCFullCollect()

  if getOccupiedMem() > 300_000:
    echo "still a leak! ", getOccupiedMem()
    quit(1)
  else:
    echo "no leak: ", getOccupiedMem()

loop()

