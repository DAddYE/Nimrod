discard """
  file: "toverwr.nim"
  output: "hello"
"""
# Test the overloading resolution in connection with a qualifier

proc write(t: TFile, s: String) =
  nil # a nop

system.write(stdout, "hello")
#OUT hello


