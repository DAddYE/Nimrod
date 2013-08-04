discard """
  output: '''48
hel'''
"""

template optZero{x+x}(x: Int): Int = x*3
template andthen{`*`(x,3)}(x: Int): Int = x*4
template optSubstr1{x = substr(x, a, b)}(x: String, a, b: Int) = setLen(x, b+1)

var y = 12
echo y+y

var s: Array[0..2, String]
s[0] = "hello"
s[0] = substr(s[0], 0, 2)

echo s[0]
