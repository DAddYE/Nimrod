# Tries to test the full ownership path generated by idetools.

proc lev1(t1: String) =
  var temp = t1
  for i in 0..len(temp)-1:
    temp[i] = chr(Int(temp[i]) + 1)

  proc lev2(t2: String) =
    var temp = t2
    for i in 0..len(temp)-1:
      temp[i] = chr(Int(temp[i]) + 1)

    proc lev3(t3: String) =
      var temp = t3
      for i in 0..len(temp)-1:
        temp[i] = chr(Int(temp[i]) + 1)

      proc lev4(t4: String) =
        var temp = t4
        for i in 0..len(temp)-1:
          temp[i] = chr(Int(temp[i]) + 1)

        echo temp & "(lev4)"
      lev4(temp & "(lev3)")
    lev3(temp & "(lev2)")
  lev2(temp & "(lev1)")

when isMainModule:
  lev1("abcd")
