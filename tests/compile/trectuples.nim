
type Node = tuple[left: ref Node]

proc traverse(root: ref Node) =
  if root.left != nil: traverse(root.left)
  
type A = tuple[b: ptr A]
proc c(D: ptr A) = c(d.B)


