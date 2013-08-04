#
#
#           The Nimrod Compiler
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# this unit handles Nimrod sets; it implements bit sets
# the code here should be reused in the Nimrod standard library

type 
  TBitSet* = Seq[Int8]        # we use byte here to avoid issues with
                              # cross-compiling; uint would be more efficient
                              # however

const 
  ElemSize* = sizeof(int8) * 8

proc bitSetInit*(b: var TBitSet, length: Int)
proc bitSetUnion*(x: var TBitSet, y: TBitSet)
proc bitSetDiff*(x: var TBitSet, y: TBitSet)
proc bitSetSymDiff*(x: var TBitSet, y: TBitSet)
proc bitSetIntersect*(x: var TBitSet, y: TBitSet)
proc bitSetIncl*(x: var TBitSet, elem: BiggestInt)
proc bitSetExcl*(x: var TBitSet, elem: BiggestInt)
proc bitSetIn*(x: TBitSet, e: BiggestInt): Bool
proc bitSetEquals*(x, y: TBitSet): Bool
proc bitSetContains*(x, y: TBitSet): Bool
# implementation

proc bitSetIn(x: TBitSet, e: BiggestInt): bool = 
  result = (x[Int(e div ElemSize)] and toU8(Int(1 shl (e mod ElemSize)))) !=
      toU8(0)

proc bitSetIncl(x: var TBitSet, elem: BiggestInt) = 
  assert(elem >= 0)
  x[Int(elem div ElemSize)] = x[Int(elem div ElemSize)] or
      toU8(Int(1 shl (elem mod ElemSize)))

proc bitSetExcl(x: var TBitSet, elem: BiggestInt) = 
  x[Int(elem div ElemSize)] = x[Int(elem div ElemSize)] and
      not toU8(Int(1 shl (elem mod ElemSize)))

proc bitSetInit(b: var TBitSet, length: int) = 
  newSeq(b, length)

proc bitSetUnion(x: var TBitSet, y: TBitSet) = 
  for i in countup(0, high(x)): x[i] = x[i] or y[i]
  
proc bitSetDiff(x: var TBitSet, y: TBitSet) = 
  for i in countup(0, high(x)): x[i] = x[i] and not y[i]
  
proc bitSetSymDiff(x: var TBitSet, y: TBitSet) = 
  for i in countup(0, high(x)): x[i] = x[i] xor y[i]
  
proc bitSetIntersect(x: var TBitSet, y: TBitSet) = 
  for i in countup(0, high(x)): x[i] = x[i] and y[i]
  
proc bitSetEquals(x, y: TBitSet): bool = 
  for i in countup(0, high(x)): 
    if x[i] != y[i]: 
      return false
  result = true

proc bitSetContains(x, y: TBitSet): bool = 
  for i in countup(0, high(x)): 
    if (x[i] and not y[i]) != Int8(0): 
      return false
  result = true
