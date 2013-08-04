discard """
  output: "an identifier"
"""

const
  SymChars: Set[Char] = {'a'..'z', 'A'..'Z', '\x80'..'\xFF'}

proc classify(s: String) =
  case s[0]
  of SymChars, '_': echo "an identifier"
  of {'0'..'9'}: echo "a number"
  else: echo "other"

classify("Hurra")

