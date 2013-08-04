#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

when defined(nodejs):
  proc alert*(s: cstring) {.importc: "console.log", nodecl.}
else:
  proc alert*(s: Cstring) {.importc, nodecl.}

proc log*(s: Cstring) {.importc: "console.log", nodecl.}

type
  PSafePoint = ptr TSafePoint
  TSafePoint {.compilerproc, final.} = object
    prev: PSafePoint # points to next safe point
    exc: ref E_Base

  PCallFrame = ptr TCallFrame
  TCallFrame {.importc, nodecl, final.} = object
    prev: PCallFrame
    procname: Cstring
    line: Int # current line number
    filename: Cstring

var
  framePtr {.importc, nodecl, volatile.}: PCallFrame
  excHandler {.importc, nodecl, volatile.}: PSafePoint = nil
    # list of exception handlers
    # a global variable for the root of all try blocks

{.push stacktrace: off, profiler:off.}
proc nimBoolToStr(x: Bool): String {.compilerproc.} =
  if x: result = "true"
  else: result = "false"

proc nimCharToStr(x: Char): String {.compilerproc.} =
  result = newString(1)
  result[0] = x

proc getCurrentExceptionMsg*(): String =
  if excHandler != nil: return $excHandler.exc.msg
  return ""

proc auxWriteStackTrace(f: PCallFrame): String =
  type
    TTempFrame = tuple[procname: Cstring, line: Int]
  var
    it = f
    i = 0
    total = 0
    tempFrames: Array [0..63, TTempFrame]
  while it != nil and i <= high(tempFrames):
    tempFrames[i].procname = it.procname
    tempFrames[i].line = it.line
    inc(i)
    inc(total)
    it = it.prev
  while it != nil:
    inc(total)
    it = it.prev
  result = ""
  # if the buffer overflowed print '...':
  if total != i:
    add(result, "(")
    add(result, $(total-i))
    add(result, " calls omitted) ...\n")
  for j in countdown(i-1, 0):
    add(result, tempFrames[j].procname)
    if tempFrames[j].line > 0:
      add(result, ", line: ")
      add(result, $tempFrames[j].line)
    add(result, "\n")

proc rawWriteStackTrace(): String =
  if framePtr == nil:
    result = "No stack traceback available\n"
  else:
    result = "Traceback (most recent call last)\n"& auxWriteStackTrace(framePtr)
    framePtr = nil

proc raiseException(e: ref E_Base, ename: Cstring) {.
    compilerproc, noStackFrame.} =
  e.name = ename
  if excHandler != nil:
    excHandler.exc = e
  else:
    when nimrodStackTrace:
      var buf = rawWriteStackTrace()
    else:
      var buf = ""
    if e.msg != nil and e.msg[0] != '\0':
      add(buf, "Error: unhandled exception: ")
      add(buf, e.msg)
    else:
      add(buf, "Error: unhandled exception")
    add(buf, " [")
    add(buf, ename)
    add(buf, "]\n")
    alert(buf)
  asm """throw `e`;"""

proc reraiseException() {.compilerproc, noStackFrame.} =
  if excHandler == nil:
    raise newException(ENoExceptionToReraise, "no exception to reraise")
  else:
    asm """throw excHandler.exc;"""

proc raiseOverflow {.exportc: "raiseOverflow", noreturn.} =
  raise newException(EOverflow, "over- or underflow")

proc raiseDivByZero {.exportc: "raiseDivByZero", noreturn.} =
  raise newException(EDivByZero, "divison by zero")

proc raiseRangeError() {.compilerproc, noreturn.} =
  raise newException(EOutOfRange, "value out of range")

proc raiseIndexError() {.compilerproc, noreturn.} =
  raise newException(EInvalidIndex, "index out of bounds")

proc raiseFieldError(f: String) {.compilerproc, noreturn.} =
  raise newException(EInvalidField, f & " is not accessible")

proc SetConstr() {.varargs, noStackFrame, compilerproc.} =
  asm """
    var result = {};
    for (var i = 0; i < arguments.length; ++i) {
      var x = arguments[i];
      if (typeof(x) == "object") {
        for (var j = x[0]; j <= x[1]; ++j) {
          result[j] = true;
        }
      } else {
        result[x] = true;
      }
    }
    return result;
  """

proc cstrToNimstr(c: Cstring): String {.noStackFrame, compilerproc.} =
  asm """
    var result = [];
    for (var i = 0; i < `c`.length; ++i) {
      result[i] = `c`.charCodeAt(i);
    }
    result[result.length] = 0; // terminating zero
    return result;
  """

proc toJSStr(s: String): Cstring {.noStackFrame, compilerproc.} =
  asm """
    var len = `s`.length-1;
    var result = new Array(len);
    var fcc = String.fromCharCode;
    for (var i = 0; i < len; ++i) {
      result[i] = fcc(`s`[i]);
    }
    return result.join("");
  """

proc mnewString(len: Int): String {.noStackFrame, compilerproc.} =
  asm """
    var result = new Array(`len`+1);
    result[0] = 0;
    result[`len`] = 0;
    return result;
  """

proc SetCard(a: Int): Int {.compilerproc, noStackFrame.} =
  # argument type is a fake
  asm """
    var result = 0;
    for (var elem in `a`) { ++result; }
    return result;
  """

proc SetEq(a, b: Int): Bool {.compilerproc, noStackFrame.} =
  asm """
    for (var elem in `a`) { if (!`b`[elem]) return false; }
    for (var elem in `b`) { if (!`a`[elem]) return false; }
    return true;
  """

proc SetLe(a, b: Int): Bool {.compilerproc, noStackFrame.} =
  asm """
    for (var elem in `a`) { if (!`b`[elem]) return false; }
    return true;
  """

proc SetLt(a, b: Int): Bool {.compilerproc.} =
  result = SetLe(a, b) and not SetEq(a, b)

proc SetMul(a, b: Int): Int {.compilerproc, noStackFrame.} =
  asm """
    var result = {};
    for (var elem in `a`) {
      if (`b`[elem]) { result[elem] = true; }
    }
    return result;
  """

proc SetPlus(a, b: Int): Int {.compilerproc, noStackFrame.} =
  asm """
    var result = {};
    for (var elem in `a`) { result[elem] = true; }
    for (var elem in `b`) { result[elem] = true; }
    return result;
  """

proc SetMinus(a, b: Int): Int {.compilerproc, noStackFrame.} =
  asm """
    var result = {};
    for (var elem in `a`) {
      if (!`b`[elem]) { result[elem] = true; }
    }
    return result;
  """

proc cmpStrings(a, b: String): Int {.noStackFrame, compilerProc.} =
  asm """
    if (`a` == `b`) return 0;
    if (!`a`) return -1;
    if (!`b`) return 1;
    for (var i = 0; i < `a`.length-1; ++i) {
      var result = `a`[i] - `b`[i];
      if (result != 0) return result;
    }
    return 0;
  """

proc cmp(x, y: String): Int = return cmpStrings(x, y)

proc eqStrings(a, b: String): Bool {.noStackFrame, compilerProc.} =
  asm """
    if (`a` == `b`) return true;
    if ((!`a`) || (!`b`)) return false;
    var alen = `a`.length;
    if (alen != `b`.length) return false;
    for (var i = 0; i < alen; ++i)
      if (`a`[i] != `b`[i]) return false;
    return true;
  """

type
  TDocument {.importc.} = object of TObject
    write: proc (text: Cstring) {.nimcall.}
    writeln: proc (text: Cstring) {.nimcall.}
    createAttribute: proc (identifier: Cstring): ref TNode {.nimcall.}
    createElement: proc (identifier: Cstring): ref TNode {.nimcall.}
    createTextNode: proc (identifier: Cstring): ref TNode {.nimcall.}
    getElementById: proc (id: Cstring): ref TNode {.nimcall.}
    getElementsByName: proc (name: Cstring): Seq[ref TNode] {.nimcall.}
    getElementsByTagName: proc (name: Cstring): Seq[ref TNode] {.nimcall.}

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
    insertBefore*: proc (newNode, before: ref TNode) {.nimcall.}
    insertData*: proc (position: Int, data: Cstring) {.nimcall.}
    removeAttribute*: proc (attr: Cstring) {.nimcall.}
    removeAttributeNode*: proc (attr: ref TNode) {.nimcall.}
    removeChild*: proc (child: ref TNode) {.nimcall.}
    replaceChild*: proc (newNode, oldNode: ref TNode) {.nimcall.}
    replaceData*: proc (start, len: Int, text: Cstring) {.nimcall.}
    setAttribute*: proc (name, value: Cstring) {.nimcall.}
    setAttributeNode*: proc (attr: ref TNode) {.nimcall.}

when defined(kwin):
  proc rawEcho {.compilerproc, nostackframe.} =
    asm """
      var buf = "";
      for (var i = 0; i < arguments.length; ++i) {
        buf += `toJSStr`(arguments[i]);
      }
      print(buf);
    """
    
elif defined(nodejs):
  proc ewriteln(x: cstring) = log(x)
  
  proc rawEcho {.compilerproc, nostackframe.} =
    asm """
      var buf = "";
      for (var i = 0; i < arguments.length; ++i) {
        buf += `toJSStr`(arguments[i]);
      }
      console.log(buf);
    """

else:
  var
    document {.importc, nodecl.}: ref TDocument

  proc ewriteln(x: Cstring) = 
    var node = document.getElementsByTagName("body")[0]
    if node != nil: 
      node.appendChild(document.createTextNode(x))
      node.appendChild(document.createElement("br"))
    else: 
      raise newException(EInvalidValue, "<body> element does not exist yet!")

  proc rawEcho {.compilerproc.} =
    var node = document.getElementsByTagName("body")[0]
    if node == nil: raise newException(Eio, "<body> element does not exist yet!")
    asm """
      for (var i = 0; i < arguments.length; ++i) {
        var x = `toJSStr`(arguments[i]);
        `node`.appendChild(document.createTextNode(x))
      }
    """
    node.appendChild(document.createElement("br"))

# Arithmetic:
proc addInt(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    var result = `a` + `b`;
    if (result > 2147483647 || result < -2147483648) `raiseOverflow`();
    return result;
  """

proc subInt(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    var result = `a` - `b`;
    if (result > 2147483647 || result < -2147483648) `raiseOverflow`();
    return result;
  """

proc mulInt(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    var result = `a` * `b`;
    if (result > 2147483647 || result < -2147483648) `raiseOverflow`();
    return result;
  """

proc divInt(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    if (`b` == 0) `raiseDivByZero`();
    if (`b` == -1 && `a` == 2147483647) `raiseOverflow`();
    return Math.floor(`a` / `b`);
  """

proc modInt(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    if (`b` == 0) `raiseDivByZero`();
    if (`b` == -1 && `a` == 2147483647) `raiseOverflow`();
    return Math.floor(`a` % `b`);
  """

proc addInt64(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    var result = `a` + `b`;
    if (result > 9223372036854775807
    || result < -9223372036854775808) `raiseOverflow`();
    return result;
  """

proc subInt64(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    var result = `a` - `b`;
    if (result > 9223372036854775807
    || result < -9223372036854775808) `raiseOverflow`();
    return result;
  """

proc mulInt64(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    var result = `a` * `b`;
    if (result > 9223372036854775807
    || result < -9223372036854775808) `raiseOverflow`();
    return result;
  """

proc divInt64(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    if (`b` == 0) `raiseDivByZero`();
    if (`b` == -1 && `a` == 9223372036854775807) `raiseOverflow`();
    return Math.floor(`a` / `b`);
  """

proc modInt64(a, b: Int): Int {.noStackFrame, compilerproc.} =
  asm """
    if (`b` == 0) `raiseDivByZero`();
    if (`b` == -1 && `a` == 9223372036854775807) `raiseOverflow`();
    return Math.floor(`a` % `b`);
  """

proc NegInt(a: Int): Int {.compilerproc.} =
  result = a*(-1)

proc NegInt64(a: Int64): Int64 {.compilerproc.} =
  result = a*(-1)

proc AbsInt(a: Int): Int {.compilerproc.} =
  result = if a < 0: a*(-1) else: a

proc AbsInt64(a: Int64): Int64 {.compilerproc.} =
  result = if a < 0: a*(-1) else: a

proc LeU(a, b: Int): Bool {.compilerproc.} =
  result = abs(a) <= abs(b)

proc LtU(a, b: Int): Bool {.compilerproc.} =
  result = abs(a) < abs(b)

proc LeU64(a, b: Int64): Bool {.compilerproc.} =
  result = abs(a) <= abs(b)

proc LtU64(a, b: Int64): Bool {.compilerproc.} =
  result = abs(a) < abs(b)

proc AddU(a, b: Int): Int {.compilerproc.} =
  result = abs(a) + abs(b)
proc AddU64(a, b: Int64): Int64 {.compilerproc.} =
  result = abs(a) + abs(b)

proc SubU(a, b: Int): Int {.compilerproc.} =
  result = abs(a) - abs(b)
proc SubU64(a, b: Int64): Int64 {.compilerproc.} =
  result = abs(a) - abs(b)

proc MulU(a, b: Int): Int {.compilerproc.} =
  result = abs(a) * abs(b)
proc MulU64(a, b: Int64): Int64 {.compilerproc.} =
  result = abs(a) * abs(b)

proc DivU(a, b: Int): Int {.compilerproc.} =
  result = abs(a) div abs(b)
proc DivU64(a, b: Int64): Int64 {.compilerproc.} =
  result = abs(a) div abs(b)

proc ModU(a, b: Int): Int {.compilerproc.} =
  result = abs(a) mod abs(b)
proc ModU64(a, b: Int64): Int64 {.compilerproc.} =
  result = abs(a) mod abs(b)

proc Ze(a: Int): Int {.compilerproc.} =
  result = a
proc Ze64(a: Int64): Int64 {.compilerproc.} =
  result = a

proc toU8(a: Int): Int8 {.noStackFrame, compilerproc.} =
  asm """
    return `a`;
  """

proc toU16(a: Int): Int16 {.noStackFrame, compilerproc.} =
  asm """
    return `a`;
  """

proc toU32(a: Int): Int32 {.noStackFrame, compilerproc.} =
  asm """
    return `a`;
  """


proc nimMin(a, b: Int): Int {.compilerproc.} = return if a <= b: a else: b
proc nimMax(a, b: Int): Int {.compilerproc.} = return if a >= b: a else: b

type NimString = String # hack for hti.nim
include "system/hti"

proc isFatPointer(ti: PNimType): Bool =
  # This has to be consistent with the code generator!
  return ti.base.kind notin {tyObject,
    tyArray, tyArrayConstr, tyTuple,
    tyOpenArray, tySet, tyVar, tyRef, tyPtr}

proc NimCopy(x: Pointer, ti: PNimType): Pointer {.compilerproc.}

proc NimCopyAux(dest, src: Pointer, n: ptr TNimNode) {.compilerproc.} =
  case n.kind
  of nkNone: sysAssert(false, "NimCopyAux")
  of nkSlot:
    asm "`dest`[`n`.offset] = NimCopy(`src`[`n`.offset], `n`.typ);"
  of nkList:
    for i in 0..n.len-1:
      NimCopyAux(dest, src, n.sons[i])
  of nkCase:
    asm """
      `dest`[`n`.offset] = NimCopy(`src`[`n`.offset], `n`.typ);
      for (var i = 0; i < `n`.sons.length; ++i) {
        NimCopyAux(`dest`, `src`, `n`.sons[i][1]);
      }
    """

proc NimCopy(x: pointer, ti: PNimType): pointer =
  case ti.kind
  of tyPtr, tyRef, tyVar, tyNil:
    if not isFatPointer(ti):
      result = x
    else:
      asm """
        `result` = [null, 0];
        `result`[0] = `x`[0];
        `result`[1] = `x`[1];
      """
  of tySet:
    asm """
      `result` = {};
      for (var key in `x`) { `result`[key] = `x`[key]; }
    """
  of tyTuple, tyObject:
    if ti.base != nil: result = NimCopy(x, ti.base)
    elif ti.kind == tyObject:
      asm "`result` = {m_type: `ti`};"
    else:
      asm "`result` = {};"
    NimCopyAux(result, x, ti.node)
  of tySequence, tyArrayConstr, tyOpenArray, tyArray:
    asm """
      `result` = new Array(`x`.length);
      for (var i = 0; i < `x`.length; ++i) {
        `result`[i] = NimCopy(`x`[i], `ti`.base);
      }
    """
  of tyString:
    asm "`result` = `x`.slice(0);"
  else:
    result = x

proc genericReset(x: Pointer, ti: PNimType): Pointer {.compilerproc.} =
  case ti.kind
  of tyPtr, tyRef, tyVar, tyNil:
    if not isFatPointer(ti):
      result = nil
    else:
      asm """
        `result` = [null, 0];
      """
  of tySet:
    asm """
      `result` = {};
    """
  of tyTuple, tyObject:
    if ti.kind == tyObject:
      asm "`result` = {m_type: `ti`};"
    else:
      asm "`result` = {};"
  of tySequence, tyOpenArray:
    asm """
      `result` = [];
    """
  of tyArrayConstr, tyArray:
    asm """
      `result` = new Array(`x`.length);
      for (var i = 0; i < `x`.length; ++i) {
        `result`[i] = genericReset(`x`[i], `ti`.base);
      }
    """
  else:
    result = nil

proc ArrayConstr(len: Int, value: Pointer, typ: PNimType): Pointer {.
                 noStackFrame, compilerproc.} =
  # types are fake
  asm """
    var result = new Array(`len`);
    for (var i = 0; i < `len`; ++i) result[i] = NimCopy(`value`, `typ`);
    return result;
  """

proc chckIndx(i, a, b: Int): Int {.compilerproc.} =
  if i >= a and i <= b: return i
  else: raiseIndexError()

proc chckRange(i, a, b: Int): Int {.compilerproc.} =
  if i >= a and i <= b: return i
  else: raiseRangeError()

proc chckObj(obj, subclass: PNimType) {.compilerproc.} =
  # checks if obj is of type subclass:
  var x = obj
  if x == subclass: return # optimized fast path
  while x != subclass:
    if x == nil:
      raise newException(EInvalidObjectConversion, "invalid object conversion")
    x = x.base

proc isObj(obj, subclass: PNimType): Bool {.compilerproc.} =
  # checks if obj is of type subclass:
  var x = obj
  if x == subclass: return true # optimized fast path
  while x != subclass:
    if x == nil: return false
    x = x.base
  return true

proc addChar(x: String, c: Char) {.compilerproc, noStackFrame.} =
  asm """
    `x`[`x`.length-1] = `c`; `x`.push(0);
  """

{.pop.}
