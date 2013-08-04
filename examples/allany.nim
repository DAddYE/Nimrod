# All and any

template all(container, cond: Expr): Expr {.immediate.} =
  block:
    var result = true
    for it in items(container):
      if not cond(it):
        result = false
        break
    result

template any(container, cond: Expr): Expr {.immediate.} =
  block:
    var result = false
    for it in items(container):
      if cond(it):
        result = true
        break
    result

if all("mystring", {'a'..'z'}.contains) and any("myohmy", 'y'.`==`): 
  echo "works"
else: 
  echo "does not work"


