# test the new pragmas

{.push warnings: off, hints: off.}
proc noWarning() =
  var
    x: int
  echo(x)

{.pop.}

proc warnMe() =
  var
    x: int
  echo(x)

