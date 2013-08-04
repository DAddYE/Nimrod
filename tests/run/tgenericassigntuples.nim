discard """
  output: '''abc232'''
"""

var t, s: tuple[x: String, c: Int]

proc ugh: Seq[tuple[x: String, c: Int]] = 
  result = @[("abc", 232)]

t = ugh()[0]
s = t
s = ugh()[0]

echo s[0], t[1]


