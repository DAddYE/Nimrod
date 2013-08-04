import 
  streams, md5, sockets, unsigned,
  sg_packets, zlib_helpers, idgen
type
  TClientType* = enum
    CServer = 0'i8, CPlayer, CUnknown
  PClient* = ref TClient
  TClient* = object of TObject
    id*: Int32
    addy*: TupAddress
    clientID*: Uint16
    auth*: Bool
    outputBuf*: PStringStream
    case kind*: TClientType
    of CPlayer:
      alias*: String
      session*: String
      lastPing*: Float
      failedPings*: Int
    of CServer:
      record*: ScZoneRecord
      cfg*: TChecksumFile
    of CUnknown: nil
  TChecksumFile* = object
    unpackedSize*: Int
    sum*: MD5Digest
    compressed*: String
  TupAddress* = tuple[host: String, port: Int16]
  PIDGen*[T: Ordinal] = ref TIDGen[T]
  TIDGen[T: Ordinal] = object
    max: T
    freeIDs: Seq[T]
var cliID = newIdGen[int32]()

proc sendMessage*(client: PClient; txt: String)
proc sendError*(client: PClient; txt: String)
proc `$`*(client: PClient): String

proc newIncomingBuffer*(size = 1024): PStringStream =
  result = newStringStream("")
  result.data.setLen size
  result.data.setLen 0
  result.flushImpl = proc(stream: PStream) =
    stream.setPosition(0)
    PStringStream(stream).data.setLen(0)


proc free*(c: PClient) =
  echo "Client freed: ", c
  cliID.del c.id
  c.outputBuf.flush()
  c.outputBuf = nil
proc newClient*(addy: TupAddress): PClient =
  new(result, free)
  result.addy = addy
  result.outputBuf = newStringStream("")
  result.outputBuf.flushImpl = proc(stream: PStream) = 
    stream.setPosition 0
    PStringStream(stream).data.setLen 0

proc loginPlayer*(client: PClient; login: CsLogin): Bool =
  if client.auth:
    client.sendError("You are already logged in.")
    return
  client.id = cliID.next()
  client.auth = true
  client.kind = CPlayer
  client.alias = login.alias
  client.session = getMD5(client.alias & $rand(10000))
  result = true

proc `$`*(client: PClient): string =
  if not client.auth: return $client.addy
  case client.kind
  of CPlayer: result = client.alias
  of CServer: result = client.record.name
  else: result = $client.addy
proc send*[T](client: PClient; pktType: Char; pkt: var T) =
  client.outputBuf.write(pktType)
  pkt.pack(client.outputBuf)

proc sendMessage*(client: PClient; txt: string) =
  var m = newScChat(CSystem, text = txt)
  client.send hChat, m
proc sendError*(client: PClient; txt: string) =
  var m = newScChat(CError, text = txt)
  client.send hChat, m

proc checksumFile*(filename: String): TChecksumFile =
  let fullText = readFile(filename)
  result.unpackedSize = fullText.len
  result.sum = toMD5(fullText)
  result.compressed = compress(fullText)
proc checksumStr*(str: String): TChecksumFile =
  result.unpackedSize = str.len
  result.sum = toMD5(str)
  result.compressed = compress(str)

