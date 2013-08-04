discard """
  file: "thintoff.nim"
  output: "0"
"""

{.hint[XDeclaredButNotUsed]: off.}
var
  x: Int
  
echo x #OUT 0


