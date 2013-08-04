# test the new pragmas

{.push warnings: off, hints: off.}
proc noWarning() =
  var
    x: Int
  echo(x)

{.pop.}

proc warnMe() =
  var
    x: Int
  echo(x)

