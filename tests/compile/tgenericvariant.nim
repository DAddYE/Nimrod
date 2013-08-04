type  
  TMaybe[T] = object
    case empty: Bool
    of False: value: T
    else: nil

proc just*[T](val: T): TMaybe[T] =
  result.empty = false
  result.value = val

proc nothing[T](): TMaybe[T] =
  result.empty = true

proc safeReadLine(): TMaybe[String] =
  var r = stdin.readLine()
  if r == "": return nothing[string]()
  else: return just(r)

when isMainModule:
  var test = just("Test")
  echo(test.value)
  var mSomething = safeReadLine()
  echo(mSomething.value)
