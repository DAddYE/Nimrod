import strutils

# Verifies if the --suggestion switch differentiates types for dot notation.

type
  TDollar = distinct Int
  TEuro = distinct Int

proc echoRemainingDollars(amount: TDollar) =
  echo "You have $1 dollars" % [$Int(amount)]

proc echoRemainingEuros(amount: TEuro) =
  echo "You have $1 euros" % [$Int(amount)]

proc echoRemainingBugs() =
  echo "You still have bugs"

proc main =
  var
    d: TDollar
    e: TEuro
  d = TDollar(23)
  e = TEuro(32)
  d.echoRemainingDollars()
  e.echoRemai
