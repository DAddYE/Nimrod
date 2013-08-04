import unicode, sequtils

proc test() =
  let input = readFile("weird.nim")
  for letter in runes(String(input)):
    echo Int(letter)

when 1 > 0:
  proc failtest() =
    let
      input = readFile("weird.nim")
      letters = toSeq(runes(String(input)))
    for letter in letters:
      echo Int(letter)

when isMainModule:
  test()
