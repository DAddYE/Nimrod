discard """
  output: '''true'''
"""

import lists

const
  data = [1, 2, 3, 4, 5, 6]

block singlyLinkedListTest1:
  var L: TSinglyLinkedList[Int]
  for d in items(data): L.prepend(d)
  assert($L == "[6, 5, 4, 3, 2, 1]")
  
  assert(4 in L)

block singlyLinkedListTest2:
  var L: TSinglyLinkedList[String]
  for d in items(data): L.prepend($d)
  assert($L == "[6, 5, 4, 3, 2, 1]")
  
  assert("4" in L)


block doublyLinkedListTest1:
  var L: TDoublyLinkedList[Int]
  for d in items(data): L.prepend(d)
  for d in items(data): L.append(d)
  L.remove(L.find(1))
  assert($L == "[6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 6]")
  
  assert(4 in L)

block singlyLinkedRingTest1:
  var L: TSinglyLinkedRing[Int]
  L.prepend(4)
  assert($L == "[4]")
  L.prepend(4)

  assert($L == "[4, 4]")
  assert(4 in L)
  

block doublyLinkedRingTest1:
  var L: TDoublyLinkedRing[Int]
  L.prepend(4)
  assert($L == "[4]")
  L.prepend(4)

  assert($L == "[4, 4]")
  assert(4 in L)
  
  L.append(3)
  L.append(5)
  assert($L == "[4, 4, 3, 5]")

  L.remove(L.find(3))
  L.remove(L.find(5))
  L.remove(L.find(4))
  L.remove(L.find(4))
  assert($L == "[]")
  assert(4 notin L)
  

echo "true"

