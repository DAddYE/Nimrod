discard """
  line: 24
  errormsg: "usage of 'disallowIf' is a user-defined error"
"""

template optZero{x+x}(x: Int): Int = x*3
template andthen{`*`(x,3)}(x: Int): Int = x*4
template optSubstr1{x = substr(x, 0, b)}(x: String, b: Int) = setLen(x, b+1)

template disallowIf{
  if cond: action
  else: action2
}(cond: Bool, action, action2: Stmt) {.error.} = action

var y = 12
echo y+y

var s: Array[0..2, String]
s[0] = "hello"
s[0] = substr(s[0], 0, 2)

echo s[0]

if s[0] != "hi":
  echo "do it"
  echo "more branches"
else:
  nil
