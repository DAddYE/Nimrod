#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Dominik Picheta
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module provides an easy to use sockets-style 
## nimrod interface to the OpenSSL library.

{.deprecated.}

import openssl, strutils, os

type
  TSecureSocket* {.final.} = object
    ssl: Pssl
    bio: Pbio

proc connect*(sock: var TSecureSocket, address: String, 
    port: Int): Int =
  ## Connects to the specified `address` on the specified `port`.
  ## Returns the result of the certificate validation.
  SslLoadErrorStrings()
  ERR_load_BIO_strings()
  
  if SSL_library_init() != 1:
    oSError()
  
  var ctx = SSL_CTX_new(SSLv23_client_method())
  if ctx == nil:
    ERR_print_errors_fp(stderr)
    oSError()
    
  #if SSL_CTX_load_verify_locations(ctx, 
  #   "/tmp/openssl-0.9.8e/certs/vsign1.pem", NIL) == 0:
  #  echo("Failed load verify locations")
  #  ERR_print_errors_fp(stderr)
  
  sock.bio = BIO_new_ssl_connect(ctx)
  if bIOGetSsl(sock.bio, addr(sock.ssl)) == 0:
    oSError()

  if bIOSetConnHostname(sock.bio, address & ":" & $port) != 1:
    oSError()
  
  if bIODoConnect(sock.bio) <= 0:
    ERR_print_errors_fp(stderr)
    oSError()
  
  result = SSL_get_verify_result(sock.ssl)

proc recvLine*(sock: TSecureSocket, line: var TaintedString): Bool =
  ## Acts in a similar fashion to the `recvLine` in the sockets module.
  ## Returns false when no data is available to be read.
  ## `Line` must be initialized and not nil!
  setLen(line.String, 0)
  while true:
    var c: Array[0..0, Char]
    var n = BIO_read(sock.bio, c, c.len.Cint)
    if n <= 0: return false
    if c[0] == '\r':
      n = BIO_read(sock.bio, c, c.len.Cint)
      if n > 0 and c[0] == '\L':
        return true
      elif n <= 0:
        return false
    elif c[0] == '\L': return true
    add(line.String, c)


proc send*(sock: TSecureSocket, data: String) =
  ## Writes `data` to the socket.
  if BIO_write(sock.bio, data, data.len.Cint) <= 0:
    oSError()

proc close*(sock: TSecureSocket) =
  ## Closes the socket
  if BIO_free(sock.bio) <= 0:
    ERR_print_errors_fp(stderr)
    oSError()

when isMainModule:
  var s: TSecureSocket
  echo connect(s, "smtp.gmail.com", 465)
  
  #var buffer: array[0..255, char]
  #echo BIO_read(bio, buffer, buffer.len)
  var buffer: String = ""
  
  echo s.recvLine(buffer)
  echo buffer 
  echo buffer.len
  
