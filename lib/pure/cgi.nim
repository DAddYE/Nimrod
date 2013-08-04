#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements helper procs for CGI applications. Example:
##
## .. code-block:: Nimrod
##
##    import strtabs, cgi
##
##    # Fill the values when debugging:
##    when debug:
##      setTestData("name", "Klaus", "password", "123456")
##    # read the data into `myData`
##    var myData = readData()
##    # check that the data's variable names are "name" or "password"
##    validateData(myData, "name", "password")
##    # start generating content:
##    writeContentType()
##    # generate content:
##    write(stdout, "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\">\n")
##    write(stdout, "<html><head><title>Test</title></head><body>\n")
##    writeln(stdout, "your name: " & myData["name"])
##    writeln(stdout, "your password: " & myData["password"])
##    writeln(stdout, "</body></html>")

import strutils, os, strtabs, cookies

proc uRLencode*(s: String): String =
  ## Encodes a value to be HTTP safe: This means that characters in the set
  ## ``{'A'..'Z', 'a'..'z', '0'..'9', '_'}`` are carried over to the result,
  ## a space is converted to ``'+'`` and every other character is encoded as
  ## ``'%xx'`` where ``xx`` denotes its hexadecimal value.
  result = newStringOfCap(s.len + s.len shr 2) # assume 12% non-alnum-chars
  for i in 0..s.len-1:
    case s[i]
    of 'a'..'z', 'A'..'Z', '0'..'9', '_': add(result, s[i])
    of ' ': add(result, '+')
    else:
      add(result, '%')
      add(result, toHex(ord(s[i]), 2))

proc handleHexChar(c: Char, x: var Int) {.inline.} =
  case c
  of '0'..'9': x = (x shl 4) or (ord(c) - ord('0'))
  of 'a'..'f': x = (x shl 4) or (ord(c) - ord('a') + 10)
  of 'A'..'F': x = (x shl 4) or (ord(c) - ord('A') + 10)
  else: assert(false)

proc uRLdecode*(s: String): String =
  ## Decodes a value from its HTTP representation: This means that a ``'+'``
  ## is converted to a space, ``'%xx'`` (where ``xx`` denotes a hexadecimal
  ## value) is converted to the character with ordinal number ``xx``, and
  ## and every other character is carried over.
  result = newString(s.len)
  var i = 0
  var j = 0
  while i < s.len:
    case s[i]
    of '%':
      var x = 0
      handleHexChar(s[i+1], x)
      handleHexChar(s[i+2], x)
      inc(i, 2)
      result[j] = chr(x)
    of '+': result[j] = ' '
    else: result[j] = s[i]
    inc(i)
    inc(j)
  setLen(result, j)

proc addXmlChar(dest: var String, c: Char) {.inline.} =
  case c
  of '&': add(dest, "&amp;")
  of '<': add(dest, "&lt;")
  of '>': add(dest, "&gt;")
  of '\"': add(dest, "&quot;")
  else: add(dest, c)

proc xMLencode*(s: String): String =
  ## Encodes a value to be XML safe:
  ## * ``"`` is replaced by ``&quot;``
  ## * ``<`` is replaced by ``&lt;``
  ## * ``>`` is replaced by ``&gt;``
  ## * ``&`` is replaced by ``&amp;``
  ## * every other character is carried over.
  result = newStringOfCap(s.len + s.len shr 2)
  for i in 0..len(s)-1: addXmlChar(result, s[i])

type
  ECgi* = object of Eio  ## the exception that is raised, if a CGI error occurs
  TRequestMethod* = enum ## the used request method
    methodNone,          ## no REQUEST_METHOD environment variable
    methodPost,          ## query uses the POST method
    methodGet            ## query uses the GET method

proc cgiError*(msg: String) {.noreturn.} =
  ## raises an ECgi exception with message `msg`.
  var e: ref ECgi
  new(e)
  e.msg = msg
  raise e

proc getEncodedData(allowedMethods: Set[TRequestMethod]): String =
  case getEnv("REQUEST_METHOD").String
  of "POST":
    if methodPost notin allowedMethods:
      cgiError("'REQUEST_METHOD' 'POST' is not supported")
    var L = parseInt(getEnv("CONTENT_LENGTH").String)
    result = newString(L)
    if readBuffer(stdin, addr(result[0]), L) != L:
      cgiError("cannot read from stdin")
  of "GET":
    if methodGet notin allowedMethods:
      cgiError("'REQUEST_METHOD' 'GET' is not supported")
    result = getEnv("QUERY_STRING").String
  else:
    if methodNone notin allowedMethods:
      cgiError("'REQUEST_METHOD' must be 'POST' or 'GET'")

iterator decodeData*(data: String): tuple[key, value: TaintedString] =
  ## Reads and decodes CGI data and yields the (name, value) pairs the
  ## data consists of.
  var i = 0
  var name = ""
  var value = ""
  # decode everything in one pass:
  while data[i] != '\0':
    setLen(name, 0) # reuse memory
    while true:
      case data[i]
      of '\0': break
      of '%':
        var x = 0
        handleHexChar(data[i+1], x)
        handleHexChar(data[i+2], x)
        inc(i, 2)
        add(name, chr(x))
      of '+': add(name, ' ')
      of '=', '&': break
      else: add(name, data[i])
      inc(i)
    if data[i] != '=': cgiError("'=' expected")
    inc(i) # skip '='
    setLen(value, 0) # reuse memory
    while true:
      case data[i]
      of '%':
        var x = 0
        handleHexChar(data[i+1], x)
        handleHexChar(data[i+2], x)
        inc(i, 2)
        add(value, chr(x))
      of '+': add(value, ' ')
      of '&', '\0': break
      else: add(value, data[i])
      inc(i)
    yield (name.TaintedString, value.TaintedString)
    if data[i] == '&': inc(i)
    elif data[i] == '\0': break
    else: cgiError("'&' expected")

iterator decodeData*(allowedMethods: Set[TRequestMethod] =
       {methodNone, methodPost, methodGet}): tuple[key, value: TaintedString] =
  ## Reads and decodes CGI data and yields the (name, value) pairs the
  ## data consists of. If the client does not use a method listed in the
  ## `allowedMethods` set, an `ECgi` exception is raised.
  var data = getEncodedData(allowedMethods)
  if not isNil(data):
    for key, value in decodeData(data):
      yield (key, value)

proc readData*(allowedMethods: Set[TRequestMethod] =
               {methodNone, methodPost, methodGet}): PStringTable =
  ## Read CGI data. If the client does not use a method listed in the
  ## `allowedMethods` set, an `ECgi` exception is raised.
  result = newStringTable()
  for name, value in decodeData(allowedMethods):
    result[name.String] = value.String

proc validateData*(data: PStringTable, validKeys: Varargs[String]) =
  ## validates data; raises `ECgi` if this fails. This checks that each variable
  ## name of the CGI `data` occurs in the `validKeys` array.
  for key, val in pairs(data):
    if find(validKeys, key) < 0:
      cgiError("unknown variable name: " & key)

proc getContentLength*(): String =
  ## returns contents of the ``CONTENT_LENGTH`` environment variable
  return getEnv("CONTENT_LENGTH").String

proc getContentType*(): String =
  ## returns contents of the ``CONTENT_TYPE`` environment variable
  return getEnv("CONTENT_Type").String

proc getDocumentRoot*(): String =
  ## returns contents of the ``DOCUMENT_ROOT`` environment variable
  return getEnv("DOCUMENT_ROOT").String

proc getGatewayInterface*(): String =
  ## returns contents of the ``GATEWAY_INTERFACE`` environment variable
  return getEnv("GATEWAY_INTERFACE").String

proc getHttpAccept*(): String =
  ## returns contents of the ``HTTP_ACCEPT`` environment variable
  return getEnv("HTTP_ACCEPT").String

proc getHttpAcceptCharset*(): String =
  ## returns contents of the ``HTTP_ACCEPT_CHARSET`` environment variable
  return getEnv("HTTP_ACCEPT_CHARSET").String

proc getHttpAcceptEncoding*(): String =
  ## returns contents of the ``HTTP_ACCEPT_ENCODING`` environment variable
  return getEnv("HTTP_ACCEPT_ENCODING").String

proc getHttpAcceptLanguage*(): String =
  ## returns contents of the ``HTTP_ACCEPT_LANGUAGE`` environment variable
  return getEnv("HTTP_ACCEPT_LANGUAGE").String

proc getHttpConnection*(): String =
  ## returns contents of the ``HTTP_CONNECTION`` environment variable
  return getEnv("HTTP_CONNECTION").String

proc getHttpCookie*(): String =
  ## returns contents of the ``HTTP_COOKIE`` environment variable
  return getEnv("HTTP_COOKIE").String

proc getHttpHost*(): String =
  ## returns contents of the ``HTTP_HOST`` environment variable
  return getEnv("HTTP_HOST").String

proc getHttpReferer*(): String =
  ## returns contents of the ``HTTP_REFERER`` environment variable
  return getEnv("HTTP_REFERER").String

proc getHttpUserAgent*(): String =
  ## returns contents of the ``HTTP_USER_AGENT`` environment variable
  return getEnv("HTTP_USER_AGENT").String

proc getPathInfo*(): String =
  ## returns contents of the ``PATH_INFO`` environment variable
  return getEnv("PATH_INFO").String

proc getPathTranslated*(): String =
  ## returns contents of the ``PATH_TRANSLATED`` environment variable
  return getEnv("PATH_TRANSLATED").String

proc getQueryString*(): String =
  ## returns contents of the ``QUERY_STRING`` environment variable
  return getEnv("QUERY_STRING").String

proc getRemoteAddr*(): String =
  ## returns contents of the ``REMOTE_ADDR`` environment variable
  return getEnv("REMOTE_ADDR").String

proc getRemoteHost*(): String =
  ## returns contents of the ``REMOTE_HOST`` environment variable
  return getEnv("REMOTE_HOST").String

proc getRemoteIdent*(): String =
  ## returns contents of the ``REMOTE_IDENT`` environment variable
  return getEnv("REMOTE_IDENT").String

proc getRemotePort*(): String =
  ## returns contents of the ``REMOTE_PORT`` environment variable
  return getEnv("REMOTE_PORT").String

proc getRemoteUser*(): String =
  ## returns contents of the ``REMOTE_USER`` environment variable
  return getEnv("REMOTE_USER").String

proc getRequestMethod*(): String =
  ## returns contents of the ``REQUEST_METHOD`` environment variable
  return getEnv("REQUEST_METHOD").String

proc getRequestURI*(): String =
  ## returns contents of the ``REQUEST_URI`` environment variable
  return getEnv("REQUEST_URI").String

proc getScriptFilename*(): String =
  ## returns contents of the ``SCRIPT_FILENAME`` environment variable
  return getEnv("SCRIPT_FILENAME").String

proc getScriptName*(): String =
  ## returns contents of the ``SCRIPT_NAME`` environment variable
  return getEnv("SCRIPT_NAME").String

proc getServerAddr*(): String =
  ## returns contents of the ``SERVER_ADDR`` environment variable
  return getEnv("SERVER_ADDR").String

proc getServerAdmin*(): String =
  ## returns contents of the ``SERVER_ADMIN`` environment variable
  return getEnv("SERVER_ADMIN").String

proc getServerName*(): String =
  ## returns contents of the ``SERVER_NAME`` environment variable
  return getEnv("SERVER_NAME").String

proc getServerPort*(): String =
  ## returns contents of the ``SERVER_PORT`` environment variable
  return getEnv("SERVER_PORT").String

proc getServerProtocol*(): String =
  ## returns contents of the ``SERVER_PROTOCOL`` environment variable
  return getEnv("SERVER_PROTOCOL").String

proc getServerSignature*(): String =
  ## returns contents of the ``SERVER_SIGNATURE`` environment variable
  return getEnv("SERVER_SIGNATURE").String

proc getServerSoftware*(): String =
  ## returns contents of the ``SERVER_SOFTWARE`` environment variable
  return getEnv("SERVER_SOFTWARE").String

proc setTestData*(keysvalues: Varargs[String]) =
  ## fills the appropriate environment variables to test your CGI application.
  ## This can only simulate the 'GET' request method. `keysvalues` should
  ## provide embedded (name, value)-pairs. Example:
  ##
  ## .. code-block:: Nimrod
  ##    setTestData("name", "Hanz", "password", "12345")
  putEnv("REQUEST_METHOD", "GET")
  var i = 0
  var query = ""
  while i < keysvalues.len:
    add(query, uRLencode(keysvalues[i]))
    add(query, '=')
    add(query, uRLencode(keysvalues[i+1]))
    add(query, '&')
    inc(i, 2)
  putEnv("QUERY_STRING", query)

proc writeContentType*() =
  ## call this before starting to send your HTML data to `stdout`. This
  ## implements this part of the CGI protocol:
  ##
  ## .. code-block:: Nimrod
  ##     write(stdout, "Content-type: text/html\n\n")
  ##
  ## It also modifies the debug stack traces so that they contain
  ## ``<br />`` and are easily readable in a browser.
  write(stdout, "Content-type: text/html\n\n")
  system.stackTraceNewLine = "<br />\n"

proc setStackTraceNewLine*() =
  ## Modifies the debug stack traces so that they contain
  ## ``<br />`` and are easily readable in a browser.
  system.stackTraceNewLine = "<br />\n"

proc setCookie*(name, value: String) =
  ## Sets a cookie.
  write(stdout, "Set-Cookie: ", name, "=", value, "\n")

var
  gcookies: PStringTable = nil

proc getCookie*(name: String): TaintedString =
  ## Gets a cookie. If no cookie of `name` exists, "" is returned.
  if gcookies == nil: gcookies = parseCookies(getHttpCookie())
  result = TaintedString(gcookies[name])

proc existsCookie*(name: String): Bool =
  ## Checks if a cookie of `name` exists.
  if gcookies == nil: gcookies = parseCookies(getHttpCookie())
  result = hasKey(gcookies, name)

when isMainModule:
  const test1 = "abc\L+def xyz"
  assert UrlEncode(test1) == "abc%0A%2Bdef+xyz"
  assert UrlDecode(UrlEncode(test1)) == test1

