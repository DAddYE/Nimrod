# Module A
var 
  lastId = 0

template genId*: Expr =
  inc(lastId)
  lastId


