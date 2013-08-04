#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## Declaration of the Document Object Model for the JavaScript backend.

when not defined(js) and not defined(Nimdoc):
  {.error: "This module only works on the JavaScript platform".}

type
  TEventHandlers* {.importc.} = object of TObject
    onabort*: proc (event: ref TEvent) {.nimcall.}
    onblur*: proc (event: ref TEvent) {.nimcall.}
    onchange*: proc (event: ref TEvent) {.nimcall.}
    onclick*: proc (event: ref TEvent) {.nimcall.}
    ondblclick*: proc (event: ref TEvent) {.nimcall.}
    onerror*: proc (event: ref TEvent) {.nimcall.}
    onfocus*: proc (event: ref TEvent) {.nimcall.}
    onkeydown*: proc (event: ref TEvent) {.nimcall.}
    onkeypress*: proc (event: ref TEvent) {.nimcall.}
    onkeyup*: proc (event: ref TEvent) {.nimcall.}
    onload*: proc (event: ref TEvent) {.nimcall.}
    onmousedown*: proc (event: ref TEvent) {.nimcall.}
    onmousemove*: proc (event: ref TEvent) {.nimcall.}
    onmouseout*: proc (event: ref TEvent) {.nimcall.}
    onmouseover*: proc (event: ref TEvent) {.nimcall.}
    onmouseup*: proc (event: ref TEvent) {.nimcall.}
    onreset*: proc (event: ref TEvent) {.nimcall.}
    onselect*: proc (event: ref TEvent) {.nimcall.}
    onsubmit*: proc (event: ref TEvent) {.nimcall.}
    onunload*: proc (event: ref TEvent) {.nimcall.}

  TWindow* {.importc.} = object of TEventHandlers
    document*: ref TDocument
    event*: ref TEvent
    history*: ref THistory
    location*: ref TLocation
    closed*: Bool
    defaultStatus*: Cstring
    innerHeight*, innerWidth*: Int
    locationbar*: ref TLocationBar
    menubar*: ref TMenuBar
    name*: Cstring
    outerHeight*, outerWidth*: Int
    pageXOffset*, pageYOffset*: Int
    personalbar*: ref TPersonalBar
    scrollbars*: ref TScrollBars
    statusbar*: ref TStatusBar
    status*: Cstring
    toolbar*: ref TToolBar

    alert*: proc (msg: Cstring) {.nimcall.}
    back*: proc () {.nimcall.}
    blur*: proc () {.nimcall.}
    captureEvents*: proc (eventMask: Int) {.nimcall.}
    clearInterval*: proc (interval: ref TInterval) {.nimcall.}
    clearTimeout*: proc (timeout: ref TTimeOut) {.nimcall.}
    close*: proc () {.nimcall.}
    confirm*: proc (msg: Cstring): Bool {.nimcall.}
    disableExternalCapture*: proc () {.nimcall.}
    enableExternalCapture*: proc () {.nimcall.}
    find*: proc (text: Cstring, caseSensitive = false, 
                 backwards = false) {.nimcall.}
    focus*: proc () {.nimcall.}
    forward*: proc () {.nimcall.}
    handleEvent*: proc (e: ref TEvent) {.nimcall.}
    home*: proc () {.nimcall.}
    moveBy*: proc (x, y: Int) {.nimcall.}
    moveTo*: proc (x, y: Int) {.nimcall.}
    open*: proc (uri, windowname: Cstring,
                 properties: Cstring = nil): ref TWindow {.nimcall.}
    print*: proc () {.nimcall.}
    prompt*: proc (text, default: Cstring): Cstring {.nimcall.}
    releaseEvents*: proc (eventMask: Int) {.nimcall.}
    resizeBy*: proc (x, y: Int) {.nimcall.}
    resizeTo*: proc (x, y: Int) {.nimcall.}
    routeEvent*: proc (event: ref TEvent) {.nimcall.}
    scrollBy*: proc (x, y: Int) {.nimcall.}
    scrollTo*: proc (x, y: Int) {.nimcall.}
    setInterval*: proc (code: Cstring, pause: Int): ref TInterval {.nimcall.}
    setTimeout*: proc (code: Cstring, pause: Int): ref TTimeOut {.nimcall.}
    stop*: proc () {.nimcall.}
    frames*: Seq[TFrame]

  TFrame* {.importc.} = object of TWindow

  TDocument* {.importc.} = object of TEventHandlers
    alinkColor*: Cstring
    bgColor*: Cstring
    charset*: Cstring
    cookie*: Cstring
    defaultCharset*: Cstring
    fgColor*: Cstring
    lastModified*: Cstring
    linkColor*: Cstring
    referrer*: Cstring
    title*: Cstring
    URL*: Cstring
    vlinkColor*: Cstring
    captureEvents*: proc (eventMask: Int) {.nimcall.}
    createAttribute*: proc (identifier: Cstring): ref TNode {.nimcall.}
    createElement*: proc (identifier: Cstring): ref TNode {.nimcall.}
    createTextNode*: proc (identifier: Cstring): ref TNode {.nimcall.}
    getElementById*: proc (id: Cstring): ref TNode {.nimcall.}
    getElementsByName*: proc (name: Cstring): Seq[ref TNode] {.nimcall.}
    getElementsByTagName*: proc (name: Cstring): Seq[ref TNode] {.nimcall.}
    getSelection*: proc (): Cstring {.nimcall.}
    handleEvent*: proc (event: ref TEvent) {.nimcall.}
    open*: proc () {.nimcall.}
    releaseEvents*: proc (eventMask: Int) {.nimcall.}
    routeEvent*: proc (event: ref TEvent) {.nimcall.}
    write*: proc (text: Cstring) {.nimcall.}
    writeln*: proc (text: Cstring) {.nimcall.}
    anchors*: Seq[ref TAnchor]
    forms*: Seq[ref TForm]
    images*: Seq[ref TImage]
    applets*: Seq[ref TApplet]
    embeds*: Seq[ref TEmbed]
    links*: Seq[ref TLink]

  TLink* {.importc.} = object of TObject
    name*: Cstring
    target*: Cstring
    text*: Cstring
    x*: Int
    y*: Int

  TEmbed* {.importc.} = object of TObject
    height*: Int
    hspace*: Int
    name*: Cstring
    src*: Cstring
    width*: Int
    `type`*: Cstring
    vspace*: Int
    play*: proc () {.nimcall.}
    stop*: proc () {.nimcall.}

  TAnchor* {.importc.} = object of TObject
    name*: Cstring
    text*: Cstring
    x*, y*: Int

  TApplet* {.importc.} = object of TObject

  TElement* {.importc.} = object of TEventHandlers
    checked*: Bool
    defaultChecked*: Bool
    defaultValue*: Cstring
    disabled*: Bool
    form*: ref TForm
    name*: Cstring
    readOnly*: Bool
    `type`*: Cstring
    value*: Cstring
    blur*: proc () {.nimcall.}
    click*: proc () {.nimcall.}
    focus*: proc () {.nimcall.}
    handleEvent*: proc (event: ref TEvent) {.nimcall.}
    select*: proc () {.nimcall.}
    options*: Seq[ref TOption]

  TOption* {.importc.} = object of TObject
    defaultSelected*: Bool
    selected*: Bool
    selectedIndex*: Int
    text*: Cstring
    value*: Cstring

  TForm* {.importc.} = object of TEventHandlers
    action*: Cstring
    encoding*: Cstring
    `method`*: Cstring
    name*: Cstring
    target*: Cstring
    handleEvent*: proc (event: ref TEvent) {.nimcall.}
    reset*: proc () {.nimcall.}
    submit*: proc () {.nimcall.}
    elements*: Seq[ref TElement]

  TImage* {.importc.} = object of TEventHandlers
    border*: Int
    complete*: Bool
    height*: Int
    hspace*: Int
    lowsrc*: Cstring
    name*: Cstring
    src*: Cstring
    vspace*: Int
    width*: Int
    handleEvent*: proc (event: ref TEvent) {.nimcall.}

  TNodeType* = enum
    ElementNode = 1,
    AttributeNode,
    TextNode,
    CDATANode,
    EntityRefNode,
    EntityNode,
    ProcessingInstructionNode,
    CommentNode,
    DocumentNode,
    DocumentTypeNode,
    DocumentFragmentNode,
    NotationNode
  TNode* {.importc.} = object of TObject
    attributes*: Seq[ref TNode]
    childNodes*: Seq[ref TNode]
    data*: Cstring
    firstChild*: ref TNode
    lastChild*: ref TNode
    nextSibling*: ref TNode
    nodeName*: Cstring
    nodeType*: TNodeType
    nodeValue*: Cstring
    parentNode*: ref TNode
    previousSibling*: ref TNode
    appendChild*: proc (child: ref TNode) {.nimcall.}
    appendData*: proc (data: Cstring) {.nimcall.}
    cloneNode*: proc (copyContent: Bool) {.nimcall.}
    deleteData*: proc (start, len: Int) {.nimcall.}
    getAttribute*: proc (attr: Cstring): Cstring {.nimcall.}
    getAttributeNode*: proc (attr: Cstring): ref TNode {.nimcall.}
    getElementsByTagName*: proc (): Seq[ref TNode] {.nimcall.}
    hasChildNodes*: proc (): Bool {.nimcall.}
    innerHTML*: Cstring
    insertBefore*: proc (newNode, before: ref TNode) {.nimcall.}
    insertData*: proc (position: Int, data: Cstring) {.nimcall.}
    removeAttribute*: proc (attr: Cstring) {.nimcall.}
    removeAttributeNode*: proc (attr: ref TNode) {.nimcall.}
    removeChild*: proc (child: ref TNode) {.nimcall.}
    replaceChild*: proc (newNode, oldNode: ref TNode) {.nimcall.}
    replaceData*: proc (start, len: Int, text: Cstring) {.nimcall.}
    setAttribute*: proc (name, value: Cstring) {.nimcall.}
    setAttributeNode*: proc (attr: ref TNode) {.nimcall.}
    style*: ref TStyle

  TStyle* {.importc.} = object of TObject
    background*: Cstring
    backgroundAttachment*: Cstring
    backgroundColor*: Cstring
    backgroundImage*: Cstring
    backgroundPosition*: Cstring
    backgroundRepeat*: Cstring
    border*: Cstring
    borderBottom*: Cstring
    borderBottomColor*: Cstring
    borderBottomStyle*: Cstring
    borderBottomWidth*: Cstring
    borderColor*: Cstring
    borderLeft*: Cstring
    borderLeftColor*: Cstring
    borderLeftStyle*: Cstring
    borderLeftWidth*: Cstring
    borderRight*: Cstring
    borderRightColor*: Cstring
    borderRightStyle*: Cstring
    borderRightWidth*: Cstring
    borderStyle*: Cstring
    borderTop*: Cstring
    borderTopColor*: Cstring
    borderTopStyle*: Cstring
    borderTopWidth*: Cstring
    borderWidth*: Cstring
    bottom*: Cstring
    captionSide*: Cstring
    clear*: Cstring
    clip*: Cstring
    color*: Cstring
    cursor*: Cstring
    direction*: Cstring
    display*: Cstring
    emptyCells*: Cstring
    cssFloat*: Cstring
    font*: Cstring
    fontFamily*: Cstring
    fontSize*: Cstring
    fontStretch*: Cstring
    fontStyle*: Cstring
    fontVariant*: Cstring
    fontWeight*: Cstring
    height*: Cstring
    left*: Cstring
    letterSpacing*: Cstring
    lineHeight*: Cstring
    listStyle*: Cstring
    listStyleImage*: Cstring
    listStylePosition*: Cstring
    listStyleType*: Cstring
    margin*: Cstring
    marginBottom*: Cstring
    marginLeft*: Cstring
    marginRight*: Cstring
    marginTop*: Cstring
    maxHeight*: Cstring
    maxWidth*: Cstring
    minHeight*: Cstring
    minWidth*: Cstring
    overflow*: Cstring
    padding*: Cstring
    paddingBottom*: Cstring
    paddingLeft*: Cstring
    paddingRight*: Cstring
    paddingTop*: Cstring
    pageBreakAfter*: Cstring
    pageBreakBefore*: Cstring
    position*: Cstring
    right*: Cstring
    scrollbar3dLightColor*: Cstring
    scrollbarArrowColor*: Cstring
    scrollbarBaseColor*: Cstring
    scrollbarDarkshadowColor*: Cstring
    scrollbarFaceColor*: Cstring
    scrollbarHighlightColor*: Cstring
    scrollbarShadowColor*: Cstring
    scrollbarTrackColor*: Cstring
    tableLayout*: Cstring
    textAlign*: Cstring
    textDecoration*: Cstring
    textIndent*: Cstring
    textTransform*: Cstring
    top*: Cstring
    verticalAlign*: Cstring
    visibility*: Cstring
    width*: Cstring
    wordSpacing*: Cstring
    zIndex*: Int
    getAttribute*: proc (attr: Cstring, caseSensitive=false): Cstring {.nimcall.}
    removeAttribute*: proc (attr: Cstring, caseSensitive=false) {.nimcall.}
    setAttribute*: proc (attr, value: Cstring, caseSensitive=false) {.nimcall.}

  TEvent* {.importc.} = object of TObject
    altKey*, ctrlKey*, shiftKey*: Bool
    button*: Int
    clientX*, clientY*: Int
    keyCode*: Int
    layerX*, layerY*: Int
    modifiers*: Int
    ALT_MASK*, CONTROL_MASK*, SHIFT_MASK*, META_MASK*: Int
    offsetX*, offsetY*: Int
    pageX*, pageY*: Int
    screenX*, screenY*: Int
    which*: Int
    `type`*: Cstring
    x*, y*: Int
    ABORT*: Int
    BLUR*: Int
    CHANGE*: Int
    CLICK*: Int
    DBLCLICK*: Int
    DRAGDROP*: Int
    ERROR*: Int
    FOCUS*: Int
    KEYDOWN*: Int
    KEYPRESS*: Int
    KEYUP*: Int
    LOAD*: Int
    MOUSEDOWN*: Int
    MOUSEMOVE*: Int
    MOUSEOUT*: Int
    MOUSEOVER*: Int
    MOUSEUP*: Int
    MOVE*: Int
    RESET*: Int
    RESIZE*: Int
    SELECT*: Int
    SUBMIT*: Int
    UNLOAD*: Int

  TLocation* {.importc.} = object of TObject
    hash*: Cstring
    host*: Cstring
    hostname*: Cstring
    href*: Cstring
    pathname*: Cstring
    port*: Cstring
    protocol*: Cstring
    search*: Cstring
    reload*: proc () {.nimcall.}
    replace*: proc (s: Cstring) {.nimcall.}

  THistory* {.importc.} = object of TObject
    length*: Int
    back*: proc () {.nimcall.}
    forward*: proc () {.nimcall.}
    go*: proc (pagesToJump: Int) {.nimcall.}

  TNavigator* {.importc.} = object of TObject
    appCodeName*: Cstring
    appName*: Cstring
    appVersion*: Cstring
    cookieEnabled*: Bool
    language*: Cstring
    platform*: Cstring
    userAgent*: Cstring
    javaEnabled*: proc (): Bool {.nimcall.}
    mimeTypes*: Seq[ref TMimeType]

  TPlugin* {.importc.} = object of TObject
    description*: Cstring
    filename*: Cstring
    name*: Cstring

  TMimeType* {.importc.} = object of TObject
    description*: Cstring
    enabledPlugin*: ref TPlugin
    suffixes*: Seq[Cstring]
    `type`*: Cstring

  TLocationBar* {.importc.} = object of TObject
    visible*: Bool
  TMenuBar* = TLocationBar
  TPersonalBar* = TLocationBar
  TScrollBars* = TLocationBar
  TToolBar* = TLocationBar
  TStatusBar* = TLocationBar

  TScreen* {.importc.} = object of TObject
    availHeight*: Int
    availWidth*: Int
    colorDepth*: Int
    height*: Int
    pixelDepth*: Int
    width*: Int

  TTimeOut* {.importc.} = object of TObject
  TInterval* {.importc.} = object of TObject

var
  window* {.importc, nodecl.}: ref TWindow
  document* {.importc, nodecl.}: ref TDocument
  navigator* {.importc, nodecl.}: ref TNavigator
  screen* {.importc, nodecl.}: ref TScreen

proc decodeURI*(uri: Cstring): Cstring {.importc, nodecl.}
proc encodeURI*(uri: Cstring): Cstring {.importc, nodecl.}

proc escape*(uri: Cstring): Cstring {.importc, nodecl.}
proc unescape*(uri: Cstring): Cstring {.importc, nodecl.}

proc decodeURIComponent*(uri: Cstring): Cstring {.importc, nodecl.}
proc encodeURIComponent*(uri: Cstring): Cstring {.importc, nodecl.}
proc isFinite*(x: BiggestFloat): Bool {.importc, nodecl.}
proc isNaN*(x: BiggestFloat): Bool {.importc, nodecl.}
proc parseFloat*(s: Cstring): BiggestFloat {.importc, nodecl.}
proc parseInt*(s: Cstring): Int {.importc, nodecl.}
