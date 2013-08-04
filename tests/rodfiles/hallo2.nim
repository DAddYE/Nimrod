discard """
  output: "Hello World"
"""

# Test incremental type information

type
  TNode = object {.pure.}
    le, ri: ref TNode
    data: String

proc newNode(data: String): ref TNode =
  new(result)
  result.data = data
  
echo newNode("Hello World").data

