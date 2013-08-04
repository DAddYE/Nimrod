discard """
  file: "treraise.nim"
  outputsub: "Error: unhandled exception: bla [ESomeOtherErr]"
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
  genErrors("errssor!")
except ESomething:
  echo("Error happened")
except:
  raise



