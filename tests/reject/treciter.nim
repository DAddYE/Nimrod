discard """
  file: "treciter.nim"
  line: 9
  errormsg: "recursive dependency: \'myrec\'"
"""
# Test that an error message occurs for a recursive iterator

iterator myrec(n: Int): Int =
  for x in myrec(n-1): #ERROR_MSG recursive dependency: 'myrec'
    yield x

for x in myrec(10): echo x


