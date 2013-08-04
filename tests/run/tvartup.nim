discard """
  file: "tvartup.nim"
  output: "2 3"
"""
# Test the new tuple unpacking

proc divmod(a, b: Int): tuple[di, mo: Int] =
  return (a div b, a mod b)
  
var (x, y) = divmod(15, 6)
stdout.write(x)
stdout.write(" ")
stdout.write(y)

#OUT 2 3


