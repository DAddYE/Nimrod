#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Dominik Picheta
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements the SMTP client protocol as specified by RFC 5321, 
## this can be used to send mail to any SMTP Server.
## 
## This module also implements the protocol used to format messages, 
## as specified by RFC 2822.
## 
## Example gmail use:
## 
## 
## .. code-block:: Nimrod
##   var msg = createMessage("Hello from Nimrod's SMTP", 
##                           "Hello!.\n Is this awesome or what?", 
##                           @["foo@gmail.com"])
##   var smtp = connect("smtp.gmail.com", 465, True, True)
##   smtp.auth("username", "password")
##   smtp.sendmail("username@gmail.com", @["foo@gmail.com"], $msg)
##   
## 
## For SSL support this module relies on OpenSSL. If you want to 
## enable SSL, compile with ``-d:ssl``.

import sockets, strutils, strtabs, base64, os

type
  TSMTP* {.final.} = object
    sock: TSocket
    debug: Bool
  
  TMessage* {.final.} = object
    msgTo: Seq[String]
    msgCc: Seq[String]
    msgSubject: String
    msgOtherHeaders: PStringTable
    msgBody: String
  
  EInvalidReply* = object of Eio
  
proc debugSend(smtp: TSMTP, cmd: String) =
  if smtp.debug:
    echo("C:" & cmd)
  smtp.sock.send(cmd)

proc debugRecv(smtp: var TSMTP): TaintedString =
  var line = TaintedString""
  smtp.sock.readLine(line)

  if smtp.debug:
    echo("S:" & line.String)
  return line

proc quitExcpt(smtp: TSMTP, msg: String) =
  smtp.debugSend("QUIT")
  raise newException(EInvalidReply, msg)

proc checkReply(smtp: var TSMTP, reply: String) =
  var line = smtp.debugRecv()
  if not line.String.startsWith(reply):
    quitExcpt(smtp, "Expected " & reply & " reply, got: " & line.String)

proc connect*(address: String, port = 25, 
              ssl = false, debug = false): TSMTP =
  ## Establishes a connection with a SMTP server.
  ## May fail with EInvalidReply or with a socket error.
  result.sock = socket()
  if ssl:
    when defined(ssl):
      let ctx = newContext(verifyMode = CVerifyNone)
      ctx.wrapSocket(result.sock)
    else:
      raise newException(ESystem, 
                         "SMTP module compiled without SSL support")
  result.sock.connect(address, TPort(port))
  result.debug = debug
  
  result.checkReply("220")
  result.debugSend("HELO " & address & "\c\L")
  result.checkReply("250")

proc auth*(smtp: var TSMTP, username, password: String) =
  ## Sends an AUTH command to the server to login as the `username` 
  ## using `password`.
  ## May fail with EInvalidReply.

  smtp.debugSend("AUTH LOGIN\c\L")
  smtp.checkReply("334") # TODO: Check whether it's asking for the "Username:"
                         # i.e "334 VXNlcm5hbWU6"
  smtp.debugSend(encode(username) & "\c\L")
  smtp.checkReply("334") # TODO: Same as above, only "Password:" (I think?)
  
  smtp.debugSend(encode(password) & "\c\L")
  smtp.checkReply("235") # Check whether the authentification was successful.

proc sendmail*(smtp: var TSMTP, fromaddr: String,
               toaddrs: Seq[String], msg: String) =
  ## Sends `msg` from `fromaddr` to `toaddr`. 
  ## Messages may be formed using ``createMessage`` by converting the
  ## TMessage into a string.

  smtp.debugSend("MAIL FROM:<" & fromaddr & ">\c\L")
  smtp.checkReply("250")
  for address in items(toaddrs):
    smtp.debugSend("RCPT TO:<" & address & ">\c\L")
    smtp.checkReply("250")
  
  # Send the message
  smtp.debugSend("DATA " & "\c\L")
  smtp.checkReply("354")
  smtp.debugSend(msg & "\c\L")
  smtp.debugSend(".\c\L")
  smtp.checkReply("250")

proc close*(smtp: TSMTP) =
  ## Disconnects from the SMTP server and closes the socket.
  smtp.debugSend("QUIT\c\L")
  smtp.sock.close()

proc createMessage*(mSubject, mBody: String, mTo, mCc: Seq[String],
                otherHeaders: Openarray[tuple[name, value: String]]): TMessage =
  ## Creates a new MIME compliant message.
  result.msgTo = mTo
  result.msgCc = mCc
  result.msgSubject = mSubject
  result.msgBody = mBody
  result.msgOtherHeaders = newStringTable()
  for n, v in items(otherHeaders):
    result.msgOtherHeaders[n] = v

proc createMessage*(mSubject, mBody: String, mTo,
                    mCc: Seq[String] = @[]): TMessage =
  ## Alternate version of the above.
  result.msgTo = mTo
  result.msgCc = mCc
  result.msgSubject = mSubject
  result.msgBody = mBody
  result.msgOtherHeaders = newStringTable()

proc `$`*(msg: TMessage): String =
  ## stringify for ``TMessage``.
  result = ""
  if msg.msgTo.len() > 0:
    result = "TO: " & msg.msgTo.join(", ") & "\c\L"
  if msg.msgCc.len() > 0:
    result.add("CC: " & msg.msgCc.join(", ") & "\c\L")
  # TODO: Folding? i.e when a line is too long, shorten it...
  result.add("Subject: " & msg.msgSubject & "\c\L")
  for key, value in pairs(msg.msgOtherHeaders):
    result.add(key & ": " & value & "\c\L")

  result.add("\c\L")
  result.add(msg.msgBody)
  

when isMainModule:
  #var msg = createMessage("Test subject!", 
  #     "Hello, my name is dom96.\n What\'s yours?", @["dominik@localhost"])
  #echo(msg)

  #var smtp = connect("localhost", 25, False, True)
  #smtp.sendmail("root@localhost", @["dominik@localhost"], $msg)
  
  #echo(decode("a17sm3701420wbe.12"))
  var msg = createMessage("Hello from Nimrod's SMTP!", 
                          "Hello!!!!.\n Is this awesome or what?", 
                          @["someone@yahoo.com", "someone@gmail.com"])
  echo(msg)

  var smtp = connect("smtp.gmail.com", 465, true, true)
  smtp.auth("someone", "password")
  smtp.sendmail("someone@gmail.com", 
                @["someone@yahoo.com", "someone@gmail.com"], $msg)
  smtp.close()
  

