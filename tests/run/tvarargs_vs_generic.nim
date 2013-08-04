discard """
  output: "direct\ngeneric\ngeneric"
"""

proc withDirectType(args: String) =
  echo "direct"

proc withDirectType[T](arg: T) =
  echo "generic"

proc withOpenArray(args: Openarray[String]) =
  echo "openarray"

proc withOpenArray[T](arg: T) =
  echo "generic"

proc withVarargs(args: Varargs[String]) =
  echo "varargs"

proc withVarargs[T](arg: T) =
  echo "generic"

withDirectType "string"
withOpenArray "string"
withVarargs "string"

