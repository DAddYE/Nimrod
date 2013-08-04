import  macros

from uri import `/`

macro test*(a: Stmt): Stmt {.immediate.} =
  var nodes: tuple[a, b: Int]  
  nodes.a = 4
  nodes[1] = 45
  
  type
    TTypeEx = object
      x, y: Int
      case b: Bool
      of false: nil
      of true: z: Float
      
  var t: TTypeEx
  t.b = true
  t.z = 4.5

test:
  "hi"

