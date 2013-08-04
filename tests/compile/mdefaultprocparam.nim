

proc p*(f = (proc(): String = "hi")) =
  echo f()

