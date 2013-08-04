discard """
  outputsub: "true"
"""

from strutils import join

type
  TFoo * = object
    id: Int
    func: proc(){.closure.}
var fooCounter = 0
var aliveFoos = newseq[int](0)

proc free*(some: ref TFoo) =
  #echo "Tfoo #", some.id, " freed"
  aliveFoos.del aliveFoos.find(some.id)
proc newFoo*(): ref TFoo =
  new result, free
  
  result.id = fooCounter
  aliveFoos.add result.id
  inc fooCounter

for i in 0 .. <10:
 discard newFoo()

for i in 0 .. <10:
  let f = newFoo()
  f.func = proc = 
    echo f.id

gCFullCollect()
echo aliveFoos.len <= 3
