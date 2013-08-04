discard """
  output: "true true false yes"
"""

proc isVoid[T](): String = 
  when T is Void:
    result = "yes"
  else:
    result = "no"

const x = int is int
echo x, " ", float is float, " ", float is string, " ", isVoid[void]()

