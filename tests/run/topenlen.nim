discard """
  file: "topenlen.nim"
  output: "7"
"""
# Tests a special bug

proc choose(b: Openarray[String]): String = return b[0]

proc p(a, b: Openarray[String]): Int =
  result = a.len + b.len - 1
  for j in 0 .. a.len: inc(result)
  discard choose(a)
  discard choose(b)

discard choose(["sh", "-c", $p([""], ["a"])])
echo($p(["", "ha", "abc"], ["xyz"])) #OUT 7


