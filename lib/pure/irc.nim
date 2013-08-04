#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Dominik Picheta
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements an asynchronous IRC client.
## 
## Currently this module requires at least some knowledge of the IRC protocol.
## It provides a function for sending raw messages to the IRC server, together
## with some basic functions like sending a message to a channel. 
## It automizes the process of keeping the connection alive, so you don't
## need to reply to PING messages. In fact, the server is also PING'ed to check 
## the amount of lag.
##
## .. code-block:: Nimrod
##
##   var client = irc("picheta.me", joinChans = @["#bots"])
##   client.connect()
##   while True:
##     var event: TIRCEvent
##     if client.poll(event):
##       case event.typ
##       of EvConnected: nil
##       of EvDisconnected:
##         client.reconnect()
##       of EvMsg:
##         # Write your message reading code here.
## 
## **Warning:** The API of this module is unstable, and therefore is subject
## to change.

import sockets, strutils, parseutils, times, asyncio, os

type
  TIRC* = object of TObject
    address: String
    port: TPort
    nick, user, realname, serverPass: String
    case isAsync: Bool
    of true:
      handleEvent: proc (irc: PAsyncIRC, ev: TIRCEvent) {.closure.}
      asyncSock: PAsyncSocket
      myDispatcher: PDispatcher
    of false:
      dummyA: Pointer
      dummyB: Pointer # workaround a Nimrod API issue
      dummyC: Pointer
      sock: TSocket
    status: TInfo
    lastPing: Float
    lastPong: Float
    lag: Float
    channelsToJoin: Seq[String]
    msgLimit: Bool
    messageBuffer: Seq[tuple[timeToSend: Float, m: String]]
    lastReconnect: Float

  Pirc* = ref TIRC

  PAsyncIRC* = ref TAsyncIRC
  TAsyncIRC* = object of TIRC

  TIRCMType* = enum
    MUnknown,
    MNumeric,
    MPrivMsg,
    MJoin,
    MPart,
    MMode,
    MTopic,
    MInvite,
    MKick,
    MQuit,
    MNick,
    MNotice,
    MPing,
    MPong,
    MError
  
  TIRCEventType* = enum
    EvMsg, EvConnected, EvDisconnected
  TIRCEvent* = object ## IRC Event
    case typ*: TIRCEventType
    of EvConnected:
      ## Connected to server.
      ## Only occurs with AsyncIRC.
      nil
    of EvDisconnected: 
      ## Disconnected from the server
      nil
    of EvMsg:              ## Message from the server
      cmd*: TIRCMType      ## Command (e.g. PRIVMSG)
      nick*, user*, host*, servername*: String
      numeric*: String     ## Only applies to ``MNumeric``
      params*: Seq[String] ## Parameters of the IRC message
      origin*: String      ## The channel/user that this msg originated from
      raw*: String         ## Raw IRC message
  
proc send*(irc: Pirc, message: String, sendImmediately = false) =
  ## Sends ``message`` as a raw command. It adds ``\c\L`` for you.
  var sendMsg = true
  if irc.msgLimit and not sendImmediately:
    var timeToSend = epochTime()
    if irc.messageBuffer.len() >= 3:
      timeToSend = (irc.messageBuffer[irc.messageBuffer.len()-1][0] + 2.0)

    irc.messageBuffer.add((timeToSend, message))
    sendMsg = false

  if sendMsg:
    try:
      if irc.isAsync:
        irc.asyncSock.send(message & "\c\L")
      else:
        irc.sock.send(message & "\c\L")
    except EOS:
      # Assuming disconnection of every EOS could be bad,
      # but I can't exactly check for EBrokenPipe.
      irc.status = SockClosed

proc privmsg*(irc: Pirc, target, message: String) =
  ## Sends ``message`` to ``target``. ``Target`` can be a channel, or a user.
  irc.send("PRIVMSG $1 :$2" % [target, message])

proc notice*(irc: Pirc, target, message: String) =
  ## Sends ``notice`` to ``target``. ``Target`` can be a channel, or a user. 
  irc.send("NOTICE $1 :$2" % [target, message])

proc join*(irc: Pirc, channel: String, key = "") =
  ## Joins ``channel``.
  ## 
  ## If key is not ``""``, then channel is assumed to be key protected and this
  ## function will join the channel using ``key``.
  if key == "":
    irc.send("JOIN " & channel)
  else:
    irc.send("JOIN " & channel & " " & key)

proc part*(irc: Pirc, channel, message: String) =
  ## Leaves ``channel`` with ``message``.
  irc.send("PART " & channel & " :" & message)

proc close*(irc: Pirc) =
  ## Closes connection to an IRC server.
  ##
  ## **Warning:** This procedure does not send a ``QUIT`` message to the server.
  irc.status = SockClosed
  if irc.isAsync:
    irc.asyncSock.close()
  else:
    irc.sock.close()

proc isNumber(s: String): Bool =
  ## Checks if `s` contains only numbers.
  var i = 0
  while s[i] in {'0'..'9'}: inc(i)
  result = i == s.len and s.len > 0

proc parseMessage(msg: String): TIRCEvent =
  result.typ = EvMsg
  result.cmd = MUnknown
  result.raw = msg
  var i = 0
  # Process the prefix
  if msg[i] == ':':
    inc(i) # Skip `:`
    var nick = ""
    i.inc msg.parseUntil(nick, {'!', ' '}, i)
    result.nick = ""
    result.serverName = ""
    if msg[i] == '!':
      result.nick = nick
      inc(i) # Skip `!`
      i.inc msg.parseUntil(result.user, {'@'}, i)
      inc(i) # Skip `@`
      i.inc msg.parseUntil(result.host, {' '}, i)
      inc(i) # Skip ` `
    else:
      result.serverName = nick
      inc(i) # Skip ` `
  
  # Process command
  var cmd = ""
  i.inc msg.parseUntil(cmd, {' '}, i)

  if cmd.isNumber:
    result.cmd = MNumeric
    result.numeric = cmd
  else:
    case cmd
    of "PRIVMSG": result.cmd = MPrivMsg
    of "JOIN": result.cmd = MJoin
    of "PART": result.cmd = MPart
    of "PONG": result.cmd = MPong
    of "PING": result.cmd = MPing
    of "MODE": result.cmd = MMode
    of "TOPIC": result.cmd = MTopic
    of "INVITE": result.cmd = MInvite
    of "KICK": result.cmd = MKick
    of "QUIT": result.cmd = MQuit
    of "NICK": result.cmd = MNick
    of "NOTICE": result.cmd = MNotice
    of "ERROR": result.cmd = MError
    else: result.cmd = MUnknown
  
  # Don't skip space here. It is skipped in the following While loop.
  
  # Params
  result.params = @[]
  var param = ""
  while msg[i] != '\0' and msg[i] != ':':
    inc(i) # Skip ` `.
    i.inc msg.parseUntil(param, {' ', ':', '\0'}, i)
    if param != "":
      result.params.add(param)
      param.setLen(0)
  
  if msg[i] == ':':
    inc(i) # Skip `:`.
    result.params.add(msg[i..msg.len-1])

proc connect*(irc: Pirc) =
  ## Connects to an IRC server as specified by ``irc``.
  assert(irc.address != "")
  assert(irc.port != TPort(0))
  
  irc.sock.connect(irc.address, irc.port)
 
  irc.status = SockConnected
  
  # Greet the server :)
  if irc.serverPass != "": irc.send("PASS " & irc.serverPass, true)
  irc.send("NICK " & irc.nick, true)
  irc.send("USER $1 * 0 :$2" % [irc.user, irc.realname], true)

proc reconnect*(irc: Pirc, timeout = 5000) =
  ## Reconnects to an IRC server.
  ##
  ## ``Timeout`` specifies the time to wait in miliseconds between multiple
  ## consecutive reconnections.
  ##
  ## This should be used when an ``EvDisconnected`` event occurs.
  let secSinceReconnect = Int(epochTime() - irc.lastReconnect)
  if secSinceReconnect < timeout:
    sleep(timeout - secSinceReconnect)
  irc.sock = socket()
  irc.connect()
  irc.lastReconnect = epochTime()

proc irc*(address: String, port: TPort = 6667.TPort,
         nick = "NimrodBot",
         user = "NimrodBot",
         realname = "NimrodBot", serverPass = "",
         joinChans: Seq[String] = @[],
         msgLimit: Bool = true): Pirc =
  ## Creates a ``TIRC`` object.
  new(result)
  result.address = address
  result.port = port
  result.nick = nick
  result.user = user
  result.realname = realname
  result.serverPass = serverPass
  result.lastPing = epochTime()
  result.lastPong = -1.0
  result.lag = -1.0
  result.channelsToJoin = joinChans
  result.msgLimit = msgLimit
  result.messageBuffer = @[]
  result.status = SockIdle
  result.sock = socket()

proc processLine(irc: Pirc, line: String): TIRCEvent =
  if line.len == 0:
    irc.close()
    result.typ = EvDisconnected
  else:
    result = parseMessage(line)
    # Get the origin
    result.origin = result.params[0]
    if result.origin == irc.nick and
       result.nick != "": result.origin = result.nick

    if result.cmd == MError:
      irc.close()
      result.typ = EvDisconnected
      return

    if result.cmd == MPing:
      irc.send("PONG " & result.params[0])
    if result.cmd == MPong:
      irc.lag = epochTime() - parseFloat(result.params[result.params.high])
      irc.lastPong = epochTime()
    if result.cmd == MNumeric:
      if result.numeric == "001":
        # Check the nickname.
        if irc.nick != result.params[0]:
          assert ' ' notin result.params[0]
          irc.nick = result.params[0]
        for chan in items(irc.channelsToJoin):
          irc.join(chan)
    if result.cmd == MNick:
      if result.nick == irc.nick:
        irc.nick = result.params[0]
    
proc processOther(irc: Pirc, ev: var TIRCEvent): Bool =
  result = false
  if epochTime() - irc.lastPing >= 20.0:
    irc.lastPing = epochTime()
    irc.send("PING :" & formatFloat(irc.lastPing), true)

  if epochTime() - irc.lastPong >= 120.0 and irc.lastPong != -1.0:
    irc.close()
    ev.typ = EvDisconnected # TODO: EvTimeout?
    return true
  
  for i in 0..irc.messageBuffer.len-1:
    if epochTime() >= irc.messageBuffer[0][0]:
      irc.send(irc.messageBuffer[0].m, true)
      irc.messageBuffer.delete(0)
    else:
      break # messageBuffer is guaranteed to be from the quickest to the
            # later-est.

proc poll*(irc: Pirc, ev: var TIRCEvent,
           timeout: Int = 500): Bool =
  ## This function parses a single message from the IRC server and returns 
  ## a TIRCEvent.
  ##
  ## This function should be called often as it also handles pinging
  ## the server.
  ##
  ## This function provides a somewhat asynchronous IRC implementation, although
  ## it should only be used for simple things for example an IRC bot which does
  ## not need to be running many time critical tasks in the background. If you
  ## require this, use the asyncio implementation.
  
  if not (irc.status == SockConnected):
    # Do not close the socket here, it is already closed!
    ev.typ = EvDisconnected
  var line = TaintedString""
  var socks = @[irc.sock]
  var ret = socks.select(timeout)
  if socks.len() == 0 and ret != 0:
    irc.sock.readLine(line)
    ev = irc.processLine(line.String)
    result = true

  if processOther(irc, ev): result = true

proc getLag*(irc: Pirc): Float =
  ## Returns the latency between this client and the IRC server in seconds.
  ## 
  ## If latency is unknown, returns -1.0.
  return irc.lag

proc isConnected*(irc: Pirc): Bool =
  ## Returns whether this IRC client is connected to an IRC server.
  return irc.status == SockConnected

proc getNick*(irc: Pirc): String =
  ## Returns the current nickname of the client.
  return irc.nick

# -- Asyncio dispatcher

proc handleConnect(s: PAsyncSocket, irc: PAsyncIRC) =  
  # Greet the server :)
  if irc.serverPass != "": irc.send("PASS " & irc.serverPass, true)
  irc.send("NICK " & irc.nick, true)
  irc.send("USER $1 * 0 :$2" % [irc.user, irc.realname], true)
  irc.status = SockConnected
  
  var ev: TIRCEvent
  ev.typ = EvConnected
  irc.handleEvent(irc, ev)

proc handleRead(s: PAsyncSocket, irc: PAsyncIRC) =
  var line = "".TaintedString
  var ret = s.readLine(line)
  if ret:
    if line == "":
      var ev: TIRCEvent
      irc.close()
      ev.typ = EvDisconnected
      irc.handleEvent(irc, ev)
    else:
      var ev = irc.processLine(line.String)
      irc.handleEvent(irc, ev)
  
proc handleTask(s: PAsyncSocket, irc: PAsyncIRC) =
  var ev: TIRCEvent
  if irc.processOther(ev):
    irc.handleEvent(irc, ev)

proc register*(d: PDispatcher, irc: PAsyncIRC) =
  ## Registers ``irc`` with dispatcher ``d``.
  irc.asyncSock.handleConnect =
    proc (s: PAsyncSocket) =
      handleConnect(s, irc)
  irc.asyncSock.handleRead =
    proc (s: PAsyncSocket) =
      handleRead(s, irc)
  irc.asyncSock.handleTask =
    proc (s: PAsyncSocket) =
      handleTask(s, irc)
  d.register(irc.asyncSock)
  irc.myDispatcher = d

proc connect*(irc: PAsyncIRC) =
  ## Equivalent of connect for ``TIRC`` but specifically created for asyncio.
  assert(irc.address != "")
  assert(irc.port != TPort(0))
  
  irc.asyncSock.connect(irc.address, irc.port)

proc reconnect*(irc: PAsyncIRC, timeout = 5000) =
  ## Reconnects to an IRC server.
  ##
  ## ``Timeout`` specifies the time to wait in miliseconds between multiple
  ## consecutive reconnections.
  ##
  ## This should be used when an ``EvDisconnected`` event occurs.
  ##
  ## When successfully reconnected an ``EvConnected`` event will occur.
  let secSinceReconnect = Int(epochTime() - irc.lastReconnect)
  if secSinceReconnect < timeout:
    sleep(timeout - secSinceReconnect)
  irc.asyncSock = asyncSocket()
  irc.myDispatcher.register(irc)
  irc.connect()
  irc.lastReconnect = epochTime()

proc asyncIRC*(address: String, port: TPort = 6667.TPort,
              nick = "NimrodBot",
              user = "NimrodBot",
              realname = "NimrodBot", serverPass = "",
              joinChans: Seq[String] = @[],
              msgLimit: Bool = true,
              ircEvent: proc (irc: PAsyncIRC, ev: TIRCEvent) {.closure.}
              ): PAsyncIRC =
  ## Use this function if you want to use asyncio's dispatcher.
  ## 
  ## **Note:** Do **NOT** use this if you're writing a simple IRC bot which only
  ## requires one task to be run, i.e. this should not be used if you want a
  ## synchronous IRC client implementation, use ``irc`` for that.
  
  new(result)
  result.isAsync = true
  result.address = address
  result.port = port
  result.nick = nick
  result.user = user
  result.realname = realname
  result.serverPass = serverPass
  result.lastPing = epochTime()
  result.lastPong = -1.0
  result.lag = -1.0
  result.channelsToJoin = joinChans
  result.msgLimit = msgLimit
  result.messageBuffer = @[]
  result.handleEvent = ircEvent
  result.asyncSock = asyncSocket()
  
when isMainModule:
  #var m = parseMessage("ERROR :Closing Link: dom96.co.cc (Ping timeout: 252 seconds)")
  #echo(repr(m))


  
  var client = irc("amber.tenthbit.net", nick="TestBot1234",
                   joinChans = @["#flood"])
  client.connect()
  while True:
    var event: TIRCEvent
    if client.poll(event):
      case event.typ
      of EvConnected:
        nil
      of EvDisconnected:
        break
      of EvMsg:
        if event.cmd == MPrivMsg:
          var msg = event.params[event.params.high]
          if msg == "|test": client.privmsg(event.origin, "hello")
          if msg == "|excessFlood":
            for i in 0..10:
              client.privmsg(event.origin, "TEST" & $i)

        #echo( repr(event) )
      #echo("Lag: ", formatFloat(client.getLag()))
  
    
