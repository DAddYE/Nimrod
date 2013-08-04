
iterator fibonacci(): Int = 
  var a = 0
  var b = 1
  while true: 
    yield a
    var c = b
    b = a
    a = a + c


