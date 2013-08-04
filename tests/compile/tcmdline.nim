# Test the command line

import
  os, strutils

var
  i: Int
  params = paramCount()
i = 0
writeln(stdout, "This exe: " & getAppFilename())
writeln(stdout, "Number of parameters: " & $params)
while i <= params:
  writeln(stdout, paramStr(i))
  i = i + 1
