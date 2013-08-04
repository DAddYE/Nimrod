# Module A
var 
  lastId = 0

template genId*: Expr =
  bind lastId
  inc(lastId)
  lastId


