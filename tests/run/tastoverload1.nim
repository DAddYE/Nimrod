discard """
  output: '''string literal
no string literal
no string literal'''
"""

proc optLit(a: String{lit}) =
  echo "string literal"

proc optLit(a: String) =
  echo "no string literal"

const
  constant = "abc"

var
  variable = "xyz"

optLit("literal")
optLit(constant)
optLit(variable)
