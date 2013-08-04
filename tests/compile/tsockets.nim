import sockets
var s: TSocket
s = socket()

s.connect("www.google.com", TPort(80))

var data: String = ""
s.readLine(data)
echo(data)


