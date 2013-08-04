discard """
  file: "tcontinuexc.nim"
  outputsub: "ECcaught"
  exitcode: "1"
"""
type
  ESomething = object of E_Base
  ESomeOtherErr = object of E_Base

proc genErrors(s: String) =
  if s == "error!":
    raise newException(ESomething, "Test")
  else:
    raise newException(ESomeOtherErr, "bla")

try:
  for i in 0..3:
    try:
      genErrors("error!")
    except ESomething:
      stdout.write("E")
    stdout.write("C")
    raise newException(ESomeOtherErr, "bla")
finally:  
  echo "caught"

#OUT ECcaught



