# test the new unsigned operations:

import
  strutils

var
  x, y: Int

x = 1
y = high(Int)

writeln(stdout, $ ( x +% y ) )
