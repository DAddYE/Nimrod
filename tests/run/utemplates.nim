import unittest

template t(a: Int): Expr = "int"
template t(a: String): Expr = "string"

test "templates can be overloaded":
  check t(10) == "int"
  check t("test") == "string"

test "previous definitions can be further overloaded or hidden in local scopes":
  template t(a: Bool): Expr = "bool"

  check t(true) == "bool"
  check t(10) == "int"
  
  template t(a: Int): Expr = "inner int"
  check t(10) == "inner int"
  check t("test") == "string"

test "templates can be redefined multiple times":
  template customAssert(cond: Bool, msg: String): Stmt =
    if not cond: fail(msg)

  template assertionFailed(body: Stmt) {.immediate.} =
    template fail(msg: String): Stmt = body

  assertion_failed: check msg == "first fail path"
  customAssert false, "first fail path"

  assertion_failed: check msg == "second fail path"  
  customAssert false, "second fail path"

