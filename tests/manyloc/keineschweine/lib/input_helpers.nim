import
  sfml, tables, hashes
type
  TKeyEventKind* = enum down, up
  TInputFinishedProc* = proc() 
  TKeyCallback = proc()
  PKeyClient* = ref object
    onKeyDown: TTable[Int32, TKeyCallback]
    onKeyUp: TTable[Int32, TKeyCallback]
    name: String
  PTextInput* = ref object
    text*: String
    cursor: Int
    onEnter: TInputFinishedProc
var
  keyState:    Array[-mouseButtonCount.Int32 .. keyCount.int32, Bool]
  mousePos: TVector2f
  activeClient: PKeyClient = nil
  activeInput: PTextInput  = nil

proc setActive*(client: PKeyClient) = 
  activeClient = client
  echo("** set active client ", client.name)
proc newKeyClient*(name: String = "unnamed", setactive = false): PKeyClient =
  new(result)
  result.onKeyDown = initTable[int32, TKeyCallback](16)
  result.onKeyUp   = initTable[int32, TKeyCallback](16)
  result.name = name
  if setactive:
    setActive(result)

proc keyPressed*(key: TKeyCode): Bool {.inline.} =
  return keyState[key.Int32]
proc buttonPressed*(btn: TMouseButton): Bool {.inline.} =
  return keyState[-btn.Int32]

proc clearKey*(key: TKeyCode) {.inline.} =
  keyState[key.Int32]  = false
proc clearButton*(btn: TMouseButton) {.inline.} =
  keyState[-btn.Int32] = false

proc addKeyEvent*(key: TKeyCode, ev: TKeyEventKind) {.inline.} =
  if activeClient.isNil: return
  let k = key.Int32
  case ev
  of down: 
    keyState[k] = true
    if activeClient.onKeyDown.hasKey(k):
      activeClient.onKeyDown[k]()
  else:    
    keyState[k] = false
    if activeClient.onKeyUp.hasKey(k):
      activeClient.onKeyUp[k]()
proc addButtonEvent*(btn: TMouseButton, ev: TKeyEventKind) {.inline.} =
  if activeClient.isNil: return 
  let b = -btn.Int32
  case ev
  of down: 
    keyState[b] = true 
    if activeClient.onKeyDown.hasKey(b):
      activeClient.onKeyDown[b]()
  else: 
    keyState[b] = false
    if activeClient.onKeyUp.hasKey(b):
      activeClient.onKeyUp[b]()
proc registerHandler*(client: PKeyClient; key: TKeyCode;
                       ev: TKeyEventKind; fn: TKeyCallback) = 
  case ev
  of down: client.onKeyDown[key.Int32] = fn
  of up:   client.onKeyUp[key.Int32]   = fn
proc registerHandler*(client: PKeyClient; btn: TMouseButton;
                       ev: TKeyEventKind; fn: TKeyCallback) =
  case ev
  of down: client.onKeyDown[-btn.Int32] = fn
  of up:   client.onKeyUp[-btn.Int32]   = fn

proc newTextInput*(text = "", pos = 0, onEnter: TInputFinishedProc = nil): PTextInput =
  new(result)
  result.text = text
  result.cursor = pos
  result.onEnter = onEnter
proc setActive*(i: PTextInput) =
  activeInput = i
proc stopCapturingText*() =
  activeInput = nil
proc clear*(i: PTextInput) =
  i.text.setLen 0
  i.cursor = 0
proc recordText*(i: PTextInput; c: Cint) =
  if c > 127 or i.isNil: return
  if c in 32..126: ##printable
    if i.cursor == i.text.len: i.text.add(c.Int.chr)
    else: 
      let rem = i.text.substr(i.cursor)
      i.text.setLen(i.cursor)
      i.text.add(chr(c.Int))
      i.text.add(rem)
    inc(i.cursor)
  elif c == 8: ## \b  backspace
    if i.text.len > 0 and i.cursor > 0:
      dec(i.cursor)
      let rem = i.text.substr(i.cursor + 1)
      i.text.setLen(i.cursor)
      i.text.add(rem)
  elif c == 10 or c == 13:## \n, \r  enter
    if not i.onEnter.isNil: i.onEnter()
proc recordText*(i: PTextInput; e: TTextEvent) {.inline.} = 
  recordText(i, e.unicode)

proc setMousePos*(x, y: Cint) {.inline.} =
  mousePos.x = x.float
  mousePos.y = y.float
proc getMousePos*(): TVector2f {.inline.} = result = mousePos

var event: TEvent
# Handle and filter input-related events
iterator filterEvents*(window: PRenderWindow): PEvent =
  while window.pollEvent(addr event):
    case event.kind
    of evtKeyPressed: addKeyEvent(event.key.code, down)
    of evtKeyReleased: addKeyEvent(event.key.code, up)
    of evtMouseButtonPressed: addButtonEvent(event.mouseButton.button, down)
    of evtMouseButtonReleased: addButtonEvent(event.mouseButton.button, up)
    of evtTextEntered: recordText(activeInput, event.text)
    of evtMouseMoved: setMousePos(event.mouseMove.x, event.mouseMove.y)
    else: yield(addr event)
# Handle and return input-related events
iterator pollEvents*(window: PRenderWindow): PEvent =
  while window.pollEvent(addr event):
    case event.kind
    of evtKeyPressed: addKeyEvent(event.key.code, down)
    of evtKeyReleased: addKeyEvent(event.key.code, up)
    of evtMouseButtonPressed: addButtonEvent(event.mouseButton.button, down)
    of evtMouseButtonReleased: addButtonEvent(event.mouseButton.button, up)
    of evtTextEntered: recordText(activeInput, event.text)
    of evtMouseMoved: setMousePos(event.mouseMove.x, event.mouseMove.y)
    else: nil
    yield(addr event)
