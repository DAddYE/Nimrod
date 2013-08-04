
type
    PNode = ref TNode
    TNode = tuple # comment
      self: PNode # comment
      a, b: Int # comment

var node: PNode
new(node)
node.self = node

