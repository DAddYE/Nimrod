
template `:=`(name, val: Expr): Stmt {.immediate.} =
  var name = val

ha := 1 * 4
hu := "ta-da" == "ta-da"
echo ha, hu

