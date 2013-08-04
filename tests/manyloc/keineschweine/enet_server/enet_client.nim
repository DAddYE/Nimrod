import enet, strutils,
  sfml, sfml_colors, sg_gui, input_helpers,
  math_helpers, sg_packets, estreams, tables,
  json, sg_assets, client_helpers
if enetInit() != 0:
  quit "Could not initialize ENet"
type
  TClientSettings = object
    resolution*: TVideoMode
    offlineFile: String
    dirserver: tuple[host: String, port: Int16]
    website*: String
var
  clientSettings: TClientSettings
  event: enet.TEvent
  bConnected = false
  runServer = true
  gui = newGuiContainer()
  zonelist = newGuiContainer()
  kc = newKeyClient(setActive = true)
  clock = newClock()
  chatBox: PMessageArea
  chatInput: PTextEntry
  loginBtn, playBtn: PButton
  fpsText = newText("", guiFont, 18)
  connectionButtons: Seq[PButton]
  connectButton: PButton
  uAlias, uPasswd: PTextEntry
  dirServer: PServer
  zone: PServer
  showZoneList = false
  myCreds = newScLogin(0, "", "") ##my session token

proc handleChat(server: PServer; buf: PBuffer) =
  let msg = readScChat(buf)
  chatBox.add msg
proc handlePlayerLogin(server: PServer; buf: PBuffer) =
  let login = readScLogin(buf)
  myCreds = login
  echo("I am ", $myCreds)


kc.registerHandler MouseLeft, down, proc() =
  gui.click(input_helpers.getMousePos())

block:
  var pos = vec2f(15, 550)
  chatBox = gui.newMessageArea(pos)
  pos.y += 20
  chatInput = gui.newTextEntry("...", pos, proc() =
    sendPubChat dirServer, chatInput.getText()
    chatInput.clearText())

gui.setActive(chatInput)

proc dispMessage(args: Varargs[String, `$`]) =
  var s = ""
  for it in items(args):
    s.add it
  chatBox.add(s)
proc dispMessage(text: String) {.inline.} =
  chatBox.add(text)
proc dispError(text: String) {.inline.} =
  chatBox.add(newScChat(kind = CError, text = text))

proc updateButtons() =
  let conn = dirServer.connected
  for b in connectionButtons: setEnabled(b, conn)
  if conn:
    connectButton.setString "Disconnect"
  else:
    connectButton.setString "Connect"

proc poll(serv: PServer; timeout: Cuint = 30) =
  if serv.isNil or serv.host.isNil: return
  if serv.connected:
    while serv.host.hostService(event, timeout) > 0:
      case event.kind
      of EvtReceive:
        var buf = newBuffer(event.packet)
        
        serv.handlePackets(buf)
        
        event.packet.destroy()
      of EvtDisconnect:        
        dispMessage "Disconnected"
        serv.connected = false
        event.peer.data = nil
        updateButtons()
      of EvtNone: discard
      else:
        echo repr(event)
  else:
    if serv.host.hostService(event, timeout) > 0 and event.kind == EvtConnect:
      dispMessage "Connected"
      serv.connected = true
      if serv.peer != event.peer:
        serv.peer = event.peer
      event.peer.data = serv
      updateButtons()

proc tryLogin*(b: PButton) =
  var login = newCsLogin(
    alias = u_alias.getText(),
    passwd = u_passwd.getText())
  dirServer.send hLogin, login
proc tryTransition*(b: PButton) =
  #zone.writePkt HZoneJoinReq, myCreds
proc tryConnect*(b: PButton) =
  if not dirServer.connected:
    var error: String
    if not dirServer.connect(
            clientSettings.dirServer.host, 
            clientSettings.dirServer.port, 
            error):
      dispError(error)
  else:
    dirServer.peer.disconnect(1)

proc playOffline*(b: PButton) =
  var errors: Seq[String] = @[]
  if loadSettingsFromFile(clientSettings.offlineFile, errors):
    transition()
  else:
    dispMessage "Errors reading the file (", clientSettings.offlineFile, "):"
    for e in errors: dispError(e)

proc getClientSettings*(): TClientSettings =
  result = clientSettings


proc lobbyInit*() =
  var s = json.parseFile("./client_settings.json")
  clientSettings.offlineFile = "data/"
  clientSettings.offlineFile.add s["default-file"].str
  let dirserv = s["directory-server"]
  clientSettings.dirserver.host = dirserv["host"].str
  clientSettings.dirserver.port = dirserv["port"].num.Int16
  clientSettings.resolution.width = s["resolution"][0].num.Cint
  clientSettings.resolution.height= s["resolution"][1].num.Cint
  clientSettings.resolution.bitsPerPixel = s["resolution"][2].num.Cint
  clientSettings.website = s["website"].str
  zonelist.setPosition(vec2f(200.0, 100.0))
  connectionButtons = @[]
  
  var pos = vec2f(10, 10)
  uAlias = gui.newTextEntry(
    if s.hasKey("alias"): s["alias"].str else: "alias", 
    pos)
  pos.y += 20
  uPasswd = gui.newTextEntry("buzz", pos)
  pos.y += 20
  connectionButtons.add(gui.newButton(
    text = "Login", 
    position = pos,
    onClick = tryLogin,
    startEnabled = false))
  pos.y += 20
  fpsText.setPosition pos
  pos.y += 20
  connectButton = gui.newButton(
    text = "Connect",
    position = pos,
    onClick = tryConnect)
  pos.y += 20
  gui.newButton("Test Files", position = pos, onClick = proc(b: PButton) =
    var req = newCsZoneJoinReq(myCreds)
    dirServer.send hZoneJoinReq, req)
  pos.y += 20
  connectionButtons.add(gui.newButton(
    text = "Test Chat",
    position = pos,
    onClick = (proc(b: PButton) = 
      var pkt = newCsChat(text = "ohai")
      dirServer.send hChat, pkt),
    startEnabled = false))
  pos.y += 20
  downloadProgress.setPosition(pos) 
  downloadProgress.bg.setFillColor(color(34, 139, 34))
  downloadProgress.bg.setSize(vec2f(0, 0))
  gui.add(downloadProgress)
  
  playBtn = gui.newButton(
    text = "Play",
    position = vec2f(680.0, 8.0),
    onClick = tryTransition,
    startEnabled = false)
  gui.newButton(
    text = "Play Offline",
    position = vec2f(680.0, 28.0),
    onClick = playOffline)
  discard """gui.newButton(text = "Scrollback + 1", position = vec2f(185, 10), onClick = proc(b: PButton) =
    messageArea.scrollBack += 1
    update(messageArea))
  gui.newButton(text = "Scrollback - 1", position = vec2f(185+160, 10), onClick = proc(b: PButton) = 
    messageArea.scrollBack -= 1
    update(messageArea))
  gui.newButton(text = "Flood msg area", position = vec2f(185, 30), onClick = proc(b: PButton) =
    for i in 0.. <30: 
      dispMessage($i))"""
  dirServer = newServer() 
  dirServer.addHandler hChat, handleChat
  dirServer.addHandler hLogin, handlePlayerLogin
  dirServer.addHandler hFileTransfer, client_helpers.handleFilePartRecv
  dirServer.addHandler hChallengeResult, client_helpers.handleFileChallengeResult
  dirServer.addHandler hFileChallenge, client_helpers.handleFileChallenge

proc lobbyReady*() = 
  kc.setActive()
  gui.setActive(uAlias)

var i = 0
proc lobbyUpdate*(dt: Float) =
  dirServer.poll()
  #let res = disp.poll()
  gui.update(dt)
  i = (i + 1) mod 60
  if i == 0:
    fpsText.setString("FPS: "& ff(1.0/dt))

proc lobbyDraw*(window: PRenderWindow) =
  window.clear(black)
  window.draw chatBox
  window.draw gui
  window.draw fpsText
  if showZoneList: window.draw zonelist
  window.display()

