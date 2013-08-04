discard """
  cmd: "nimrod c --threads:on $# $#"
  errormsg: "illegal recursion in type 'TIRC'"
  line: 16
"""

import events
import sockets
import strutils
import os

type
    TMessageReceivedEventArgs = object of TEventArgs
        Nick*: String
        Message*: String
    TIRC = object
        eventEmitter: TEventEmitter
        messageReceivedHandler*: TEventHandler
        socket: TSocket
        thread: TThread[TIRC]
        
proc initIRC*(): TIRC =
    result.Socket = socket()
    result.EventEmitter = initEventEmitter()
    result.MessageReceivedHandler = initEventHandler("MessageReceived")

proc isConnected*(irc: var TIRC): Bool =
    return running(irc.Thread)
  
   
proc sendRaw*(irc: var TIRC, message: String) =
    irc.Socket.send(message & "\r\L")
proc handleData(irc: TIRC) {.thread.} =
    var connected = false
    while connected:
        var tup = @[irc.Socket]
        var o = select(tup, 200)
        echo($o)
        echo($len(tup))
        if len(tup) == 1:
            #Connected
            connected = true
            
            #Parse data here
            
        else:
            #Disconnected
            connected = false
            return
   
proc connect*(irc: var TIRC, nick: String, host: String, port: Int = 6667) =
    connect(irc.Socket ,host ,TPort(port),TDomain.AF_INET)
    send(irc.Socket,"USER " & nick & " " & nick & " " & nick & " " & nick &"\r\L")
    send(irc.Socket,"NICK " & nick & "\r\L")
    var thread: TThread[TIRC]
    createThread(thread, handleData, irc)
    irc.Thread = thread


        
        
when isMainModule:
    var irc = initIRC()
    irc.connect("AmryBot[Nim]","irc.freenode.net",6667)
    irc.sendRaw("JOIN #nimrod")
    os.Sleep(4000)
