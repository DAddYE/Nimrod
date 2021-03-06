import strutils, os, osproc, strtabs, streams, sockets

const
  wwwNL* = "\r\L"
  ServerSig = "Server: httpserver.nim/1.0.0" & wwwNL

type
  TRequestMethod = enum reqGet, reqPost
  TServer* = object       ## contains the current server state
    socket: TSocket
    job: Seq[TJob]
  TJob* = object
    client: TSocket
    process: PProcess

# --------------- output messages --------------------------------------------

proc sendTextContentType(client: TSocket) =
  send(client, "Content-type: text/html" & wwwNL)
  send(client, wwwNL)

proc badRequest(client: TSocket) =
  # Inform the client that a request it has made has a problem.
  send(client, "HTTP/1.0 400 BAD REQUEST" & wwwNL)
  sendTextContentType(client)
  send(client, "<p>Your browser sent a bad request, " &
               "such as a POST without a Content-Length.</p>" & wwwNL)


proc cannotExec(client: TSocket) =
  send(client, "HTTP/1.0 500 Internal Server Error" & wwwNL)
  sendTextContentType(client)
  send(client, "<P>Error prohibited CGI execution.</p>" & wwwNL)


proc headers(client: TSocket, filename: String) =
  # XXX could use filename to determine file type
  send(client, "HTTP/1.0 200 OK" & wwwNL)
  send(client, ServerSig)
  sendTextContentType(client)

proc notFound(client: TSocket, path: String) =
  send(client, "HTTP/1.0 404 NOT FOUND" & wwwNL)
  send(client, ServerSig)
  sendTextContentType(client)
  send(client, "<html><title>Not Found</title>" & wwwNL)
  send(client, "<body><p>The server could not fulfill" & wwwNL)
  send(client, "your request because the resource <b>" & path & "</b>" & wwwNL)
  send(client, "is unavailable or nonexistent.</p>" & wwwNL)
  send(client, "</body></html>" & wwwNL)


proc unimplemented(client: TSocket) =
  send(client, "HTTP/1.0 501 Method Not Implemented" & wwwNL)
  send(client, ServerSig)
  sendTextContentType(client)
  send(client, "<html><head><title>Method Not Implemented" &
               "</title></head>" &
               "<body><p>HTTP request method not supported.</p>" &
               "</body></HTML>" & wwwNL)


# ----------------- file serving ---------------------------------------------

proc discardHeaders(client: TSocket) = skip(client)

proc serveFile(client: TSocket, filename: String) =
  discardHeaders(client)

  var f: TFile
  if open(f, filename):
    headers(client, filename)
    const bufSize = 8000 # != 8K might be good for memory manager
    var buf = alloc(bufsize)
    while true:
      var bytesread = readBuffer(f, buf, bufsize)
      if bytesread > 0:
        var byteswritten = send(client, buf, bytesread)
        if bytesread != byteswritten:
          dealloc(buf)
          close(f)
          oSError()
      if bytesread != bufSize: break
    dealloc(buf)
    close(f)
    client.close()
  else:
    notFound(client, filename)

# ------------------ CGI execution -------------------------------------------

proc executeCgi(server: var TServer, client: TSocket, path, query: String, 
                meth: TRequestMethod) =
  var env = newStringTable(modeCaseInsensitive)
  var contentLength = -1
  case meth
  of reqGet:
    discardHeaders(client)

    env["REQUEST_METHOD"] = "GET"
    env["QUERY_STRING"] = query
  of reqPost:
    var buf = ""
    var dataAvail = true
    while dataAvail:
      dataAvail = recvLine(client, buf)
      if buf.len == 0:
        break
      var L = toLower(buf)
      if L.startsWith("content-length:"):
        var i = len("content-length:")
        while L[i] in Whitespace: inc(i)
        contentLength = parseInt(substr(L, i))

    if contentLength < 0:
      badRequest(client)
      return

    env["REQUEST_METHOD"] = "POST"
    env["CONTENT_LENGTH"] = $contentLength

  send(client, "HTTP/1.0 200 OK" & wwwNL)

  var process = startProcess(command=path, env=env)
 
  var job: TJob
  job.process = process
  job.client = client
  server.job.add(job)
 
  if meth == reqPost:
    # get from client and post to CGI program:
    var buf = alloc(contentLength)
    if recv(client, buf, contentLength) != contentLength: 
      dealloc(buf)
      oSError()
    var inp = process.inputStream
    inp.writeData(buf, contentLength)
    dealloc(buf)

proc animate(server: var TServer) =
  # checks list of jobs, removes finished ones (pretty sloppy by seq copying)
  var activeJobs: Seq[TJob] = @[]
  for i in 0..server.job.len-1:
    var job = server.job[i]
    if running(job.process):
      activeJobs.add(job)
    else:
      # read process output stream and send it to client
      var outp = job.process.outputStream
      while true:
        var line = outp.readStr(1024)
        if line.len == 0:
          break
        else:
          try:
            send(job.client, line)
          except:
            echo("send failed, client diconnected")
      close(job.client)

  server.job = activeJobs

# --------------- Server Setup -----------------------------------------------

proc acceptRequest(server: var TServer, client: TSocket) =
  var cgi = false
  var query = ""
  var buf = ""
  discard recvLine(client, buf)
  var path = ""
  var data = buf.split()
  var meth = reqGet
  var q = find(data[1], '?')

  # extract path
  if q >= 0:
    # strip "?..." from path, this may be found in both POST and GET
    path = data[1].substr(0, q-1)
  else:
    path = data[1]
  # path starts with "/", by adding "." in front of it we serve files from cwd
  path = "." & path

  echo("accept: " & path)

  if cmpIgnoreCase(data[0], "GET") == 0:
    if q >= 0:
      cgi = true
      query = data[1].substr(q+1)
  elif cmpIgnoreCase(data[0], "POST") == 0:
    cgi = true
    meth = reqPost
  else:
    unimplemented(client)

  if path[path.len-1] == '/' or existsDir(path):
    path = path / "index.html"

  if not existsFile(path):
    discardHeaders(client)
    notFound(client, path)
    client.close()
  else:
    when defined(Windows):
      var ext = splitFile(path).ext.toLower
      if ext == ".exe" or ext == ".cgi":
        # XXX: extract interpreter information here?
        cgi = true
    else:
      if {fpUserExec, fpGroupExec, fpOthersExec} * path.getFilePermissions != {}:
        cgi = true
    if not cgi:
      serveFile(client, path)
    else:
      executeCgi(server, client, path, query, meth)



when isMainModule:
  var port = 80

  var server: TServer
  server.job = @[]
  server.socket = socket(AfInet)
  if server.socket == invalidSocket: oSError()
  server.socket.bindAddr(port=TPort(port))
  listen(server.socket)
  echo("server up on port " & $port)

  while true:
    # check for new new connection & handle it
    var list: Seq[TSocket] = @[server.socket]
    if select(list, 10) > 0:
      var client: TSocket
      new(client)
      accept(server.socket, client)
      try:
        acceptRequest(server, client)
      except:
        echo("failed to accept client request")

    # pooling events
    animate(server)
    # some slack for CPU
    sleep(10)
  server.socket.close()
