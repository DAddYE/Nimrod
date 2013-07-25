discard """
  cmd: "nimrod js --hints:on $# $#"
"""

# This file tests the JavaScript generator

import
  dom, strutils

# We need to declare the used elements here. This is annoying but
# prevents any kind of typo:
var
  inputElement {.importc: "document.form1.input1", nodecl.}: ref TElement

proc onButtonClick() {.exportc.} =
  let v = $inputElement.value
  if v.allCharsInSet(whiteSpace):
    echo "only whitespace, hu?"
  else:
    var x = parseInt(v)
    echo x*x

proc onLoad() {.exportc.} =
  echo "Welcome! Please take your time to fill in this formular!"
