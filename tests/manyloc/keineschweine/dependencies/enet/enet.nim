discard """Copyright (c) 2002-2012 Lee Salzman

Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER 
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""
when defined(Linux):
  const Lib = "libenet.so.1(|.0.3)"
else:
  {.error: "Your platform has not been accounted for."}
{.deadCodeElim: ON.}
const 
  EnetVersionMajor* = 1
  EnetVersionMinor* = 3
  EnetVersionPatch* = 3
template enetVersionCreate(major, minor, patch: Expr): Expr = 
  (((major) shl 16) or ((minor) shl 8) or (patch))

const 
  EnetVersion* = ENET_VERSION_CREATE(ENET_VERSION_MAJOR, ENET_VERSION_MINOR, 
                                      ENET_VERSION_PATCH)
type 
  TVersion* = Cuint
  TSocketType*{.size: sizeof(cint).} = enum 
    ENET_SOCKET_TYPE_STREAM = 1, ENET_SOCKET_TYPE_DATAGRAM = 2
  TSocketWait*{.size: sizeof(cint).} = enum 
    ENET_SOCKET_WAIT_NONE = 0, ENET_SOCKET_WAIT_SEND = (1 shl 0), 
    ENET_SOCKET_WAIT_RECEIVE = (1 shl 1)
  TSocketOption*{.size: sizeof(cint).} = enum 
    ENET_SOCKOPT_NONBLOCK = 1, ENET_SOCKOPT_BROADCAST = 2, 
    ENET_SOCKOPT_RCVBUF = 3, ENET_SOCKOPT_SNDBUF = 4, 
    ENET_SOCKOPT_REUSEADDR = 5
const 
  EnetHostAny* = 0
  EnetHostBroadcast* = 0xFFFFFFFF
  EnetPortAny* = 0
  
  EnetProtocolMinimumMtu* = 576
  EnetProtocolMaximumMtu* = 4096
  EnetProtocolMaximumPacketCommands* = 32
  EnetProtocolMinimumWindowSize* = 4096
  EnetProtocolMaximumWindowSize* = 32768
  EnetProtocolMinimumChannelCount* = 1
  EnetProtocolMaximumChannelCount* = 255
  EnetProtocolMaximumPeerId* = 0x00000FFF
type
  PAddress* = ptr TAddress
  TAddress*{.pure, final.} = object 
    host*: Cuint
    port*: Cushort
  
  TPacketFlag*{.size: sizeof(cint).} = enum 
    FlagReliable = (1 shl 0), 
    FlagUnsequenced = (1 shl 1), 
    NoAllocate = (1 shl 2), 
    UnreliableFragment = (1 shl 3)
  
  TENetListNode*{.pure, final.} = object 
      next*: ptr T_ENetListNode
      previous*: ptr T_ENetListNode

  PENetListIterator* = ptr TENetListNode
  TENetList*{.pure, final.} = object 
    sentinel*: TENetListNode
  
  TENetPacket*{.pure, final.} = object 
  TPacketFreeCallback* = proc (a2: ptr TENetPacket){.cdecl.}
  
  PPacket* = ptr TPacket
  TPacket*{.pure, final.} = object 
    referenceCount: Csize
    flags*: Cint
    data*: Cstring#ptr cuchar
    dataLength*: Csize
    freeCallback*: TPacketFreeCallback

  PAcknowledgement* = ptr TAcknowledgement
  TAcknowledgement*{.pure, final.} = object 
    acknowledgementList*: TEnetListNode
    sentTime*: Cuint
    command*: TEnetProtocol

  POutgoingCommand* = ptr TOutgoingCommand
  TOutgoingCommand*{.pure, final.} = object 
    outgoingCommandList*: TEnetListNode
    reliableSequenceNumber*: Cushort
    unreliableSequenceNumber*: Cushort
    sentTime*: Cuint
    roundTripTimeout*: Cuint
    roundTripTimeoutLimit*: Cuint
    fragmentOffset*: Cuint
    fragmentLength*: Cushort
    sendAttempts*: Cushort
    command*: TEnetProtocol
    packet*: PPacket

  PIncomingCommand* = ptr TIncomingCommand
  TIncomingCommand*{.pure, final.} = object 
    incomingCommandList*: TEnetListNode
    reliableSequenceNumber*: Cushort
    unreliableSequenceNumber*: Cushort
    command*: TEnetProtocol
    fragmentCount*: Cuint
    fragmentsRemaining*: Cuint
    fragments*: ptr Cuint
    packet*: ptr TPacket

  TPeerState*{.size: sizeof(cint).} = enum 
    ENET_PEER_STATE_DISCONNECTED = 0, ENET_PEER_STATE_CONNECTING = 1, 
    ENET_PEER_STATE_ACKNOWLEDGING_CONNECT = 2, 
    ENET_PEER_STATE_CONNECTION_PENDING = 3, 
    ENET_PEER_STATE_CONNECTION_SUCCEEDED = 4, ENET_PEER_STATE_CONNECTED = 5, 
    ENET_PEER_STATE_DISCONNECT_LATER = 6, ENET_PEER_STATE_DISCONNECTING = 7, 
    ENET_PEER_STATE_ACKNOWLEDGING_DISCONNECT = 8, ENET_PEER_STATE_ZOMBIE = 9
  
  TENetProtocolCommand*{.size: sizeof(cint).} = enum 
    ENET_PROTOCOL_COMMAND_NONE = 0, ENET_PROTOCOL_COMMAND_ACKNOWLEDGE = 1, 
    ENET_PROTOCOL_COMMAND_CONNECT = 2, 
    ENET_PROTOCOL_COMMAND_VERIFY_CONNECT = 3, 
    ENET_PROTOCOL_COMMAND_DISCONNECT = 4, ENET_PROTOCOL_COMMAND_PING = 5, 
    ENET_PROTOCOL_COMMAND_SEND_RELIABLE = 6, 
    ENET_PROTOCOL_COMMAND_SEND_UNRELIABLE = 7, 
    ENET_PROTOCOL_COMMAND_SEND_FRAGMENT = 8, 
    ENET_PROTOCOL_COMMAND_SEND_UNSEQUENCED = 9, 
    ENET_PROTOCOL_COMMAND_BANDWIDTH_LIMIT = 10, 
    ENET_PROTOCOL_COMMAND_THROTTLE_CONFIGURE = 11, 
    ENET_PROTOCOL_COMMAND_SEND_UNRELIABLE_FRAGMENT = 12, 
    ENET_PROTOCOL_COMMAND_COUNT = 13, ENET_PROTOCOL_COMMAND_MASK = 0x0000000F
  TENetProtocolFlag*{.size: sizeof(cint).} = enum 
    ENET_PROTOCOL_HEADER_SESSION_SHIFT = 12,
    ENET_PROTOCOL_COMMAND_FLAG_UNSEQUENCED = (1 shl 6), 
    ENET_PROTOCOL_COMMAND_FLAG_ACKNOWLEDGE = (1 shl 7), 
    ENET_PROTOCOL_HEADER_SESSION_MASK = (3 shl 12), 
    ENET_PROTOCOL_HEADER_FLAG_COMPRESSED = (1 shl 14), 
    ENET_PROTOCOL_HEADER_FLAG_SENT_TIME = (1 shl 15),
    ENET_PROTOCOL_HEADER_FLAG_MASK = EnetProtocolHeaderFlagCompressed.Cint or
        EnetProtocolHeaderFlagSentTime.Cint
  
  TENetProtocolHeader*{.pure, final.} = object 
    peerID*: Cushort
    sentTime*: Cushort

  TENetProtocolCommandHeader*{.pure, final.} = object 
    command*: Cuchar
    channelID*: Cuchar
    reliableSequenceNumber*: Cushort

  TENetProtocolAcknowledge*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    receivedReliableSequenceNumber*: Cushort
    receivedSentTime*: Cushort

  TENetProtocolConnect*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    outgoingPeerID*: Cushort
    incomingSessionID*: Cuchar
    outgoingSessionID*: Cuchar
    mtu*: Cuint
    windowSize*: Cuint
    channelCount*: Cuint
    incomingBandwidth*: Cuint
    outgoingBandwidth*: Cuint
    packetThrottleInterval*: Cuint
    packetThrottleAcceleration*: Cuint
    packetThrottleDeceleration*: Cuint
    connectID*: Cuint
    data*: Cuint

  TENetProtocolVerifyConnect*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    outgoingPeerID*: Cushort
    incomingSessionID*: Cuchar
    outgoingSessionID*: Cuchar
    mtu*: Cuint
    windowSize*: Cuint
    channelCount*: Cuint
    incomingBandwidth*: Cuint
    outgoingBandwidth*: Cuint
    packetThrottleInterval*: Cuint
    packetThrottleAcceleration*: Cuint
    packetThrottleDeceleration*: Cuint
    connectID*: Cuint

  TENetProtocolBandwidthLimit*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    incomingBandwidth*: Cuint
    outgoingBandwidth*: Cuint

  TENetProtocolThrottleConfigure*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    packetThrottleInterval*: Cuint
    packetThrottleAcceleration*: Cuint
    packetThrottleDeceleration*: Cuint

  TENetProtocolDisconnect*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    data*: Cuint

  TENetProtocolPing*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader

  TENetProtocolSendReliable*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    dataLength*: Cushort

  TENetProtocolSendUnreliable*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    unreliableSequenceNumber*: Cushort
    dataLength*: Cushort

  TENetProtocolSendUnsequenced*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    unsequencedGroup*: Cushort
    dataLength*: Cushort

  TENetProtocolSendFragment*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
    startSequenceNumber*: Cushort
    dataLength*: Cushort
    fragmentCount*: Cuint
    fragmentNumber*: Cuint
    totalLength*: Cuint
    fragmentOffset*: Cuint
  
  ## this is incomplete; need helper templates or something
  ## ENetProtocol
  TENetProtocol*{.pure, final.} = object 
    header*: TENetProtocolCommandHeader
const 
  EnetBufferMaximum* = (1 + 2 * ENET_PROTOCOL_MAXIMUM_PACKET_COMMANDS)
  EnetHostReceiveBufferSize          = 256 * 1024
  EnetHostSendBufferSize             = 256 * 1024
  EnetHostBandwidthThrottleInterval  = 1000
  EnetHostDefaultMtu                  = 1400

  EnetPeerDefaultRoundTripTime      = 500
  EnetPeerDefaultPacketThrottle      = 32
  EnetPeerPacketThrottleScale        = 32
  EnetPeerPacketThrottleCounter      = 7
  EnetPeerPacketThrottleAcceleration = 2
  EnetPeerPacketThrottleDeceleration = 2
  EnetPeerPacketThrottleInterval     = 5000
  EnetPeerPacketLossScale            = (1 shl 16)
  EnetPeerPacketLossInterval         = 10000
  EnetPeerWindowSizeScale            = 64 * 1024
  EnetPeerTimeoutLimit                = 32
  EnetPeerTimeoutMinimum              = 5000
  EnetPeerTimeoutMaximum              = 30000
  EnetPeerPingInterval                = 500
  EnetPeerUnsequencedWindows          = 64
  EnetPeerUnsequencedWindowSize      = 1024
  EnetPeerFreeUnsequencedWindows     = 32
  EnetPeerReliableWindows             = 16
  EnetPeerReliableWindowSize         = 0x1000
  EnetPeerFreeReliableWindows        = 8

when defined(Linux):
  import posix
  const
    ENET_SOCKET_NULL*: cint = -1
  type 
    TENetSocket* = cint
    PEnetBuffer* = ptr object
    TENetBuffer*{.pure, final.} = object 
      data*: pointer
      dataLength*: csize
    TENetSocketSet* = Tfd_set
  ## see if these are different on win32, if not then get rid of these
  template ENET_HOST_TO_NET_16*(value: expr): expr = 
    (htons(value))
  template ENET_HOST_TO_NET_32*(value: expr): expr = 
    (htonl(value))
  template ENET_NET_TO_HOST_16*(value: expr): expr = 
    (ntohs(value))
  template ENET_NET_TO_HOST_32*(value: expr): expr = 
    (ntohl(value))

  template ENET_SOCKETSET_EMPTY*(sockset: expr): expr = 
    FD_ZERO(addr((sockset)))
  template ENET_SOCKETSET_ADD*(sockset, socket: expr): expr = 
    FD_SET(socket, addr((sockset)))
  template ENET_SOCKETSET_REMOVE*(sockset, socket: expr): expr = 
    FD_CLEAR(socket, addr((sockset)))
  template ENET_SOCKETSET_CHECK*(sockset, socket: expr): expr = 
    FD_ISSET(socket, addr((sockset)))

when defined(Windows):
  ## put the content of win32.h in here


type 
  PChannel* = ptr TChannel
  TChannel*{.pure, final.} = object 
    outgoingReliableSequenceNumber*: Cushort
    outgoingUnreliableSequenceNumber*: Cushort
    usedReliableWindows*: Cushort
    reliableWindows*: Array[0..ENET_PEER_RELIABLE_WINDOWS - 1, Cushort]
    incomingReliableSequenceNumber*: Cushort
    incomingUnreliableSequenceNumber*: Cushort
    incomingReliableCommands*: TENetList
    incomingUnreliableCommands*: TENetList

  PPeer* = ptr TPeer
  TPeer*{.pure, final.} = object 
    dispatchList*: TEnetListNode
    host*: ptr THost
    outgoingPeerID*: Cushort
    incomingPeerID*: Cushort
    connectID*: Cuint
    outgoingSessionID*: Cuchar
    incomingSessionID*: Cuchar
    address*: TAddress
    data*: Pointer
    state*: TPeerState
    channels*: PChannel
    channelCount*: Csize
    incomingBandwidth*: Cuint
    outgoingBandwidth*: Cuint
    incomingBandwidthThrottleEpoch*: Cuint
    outgoingBandwidthThrottleEpoch*: Cuint
    incomingDataTotal*: Cuint
    outgoingDataTotal*: Cuint
    lastSendTime*: Cuint
    lastReceiveTime*: Cuint
    nextTimeout*: Cuint
    earliestTimeout*: Cuint
    packetLossEpoch*: Cuint
    packetsSent*: Cuint
    packetsLost*: Cuint
    packetLoss*: Cuint
    packetLossVariance*: Cuint
    packetThrottle*: Cuint
    packetThrottleLimit*: Cuint
    packetThrottleCounter*: Cuint
    packetThrottleEpoch*: Cuint
    packetThrottleAcceleration*: Cuint
    packetThrottleDeceleration*: Cuint
    packetThrottleInterval*: Cuint
    lastRoundTripTime*: Cuint
    lowestRoundTripTime*: Cuint
    lastRoundTripTimeVariance*: Cuint
    highestRoundTripTimeVariance*: Cuint
    roundTripTime*: Cuint
    roundTripTimeVariance*: Cuint
    mtu*: Cuint
    windowSize*: Cuint
    reliableDataInTransit*: Cuint
    outgoingReliableSequenceNumber*: Cushort
    acknowledgements*: TENetList
    sentReliableCommands*: TENetList
    sentUnreliableCommands*: TENetList
    outgoingReliableCommands*: TENetList
    outgoingUnreliableCommands*: TENetList
    dispatchedCommands*: TENetList
    needsDispatch*: Cint
    incomingUnsequencedGroup*: Cushort
    outgoingUnsequencedGroup*: Cushort
    unsequencedWindow*: Array[0..ENET_PEER_UNSEQUENCED_WINDOW_SIZE div 32 - 1, 
                              Cuint]
    eventData*: Cuint

  PCompressor* = ptr TCompressor
  TCompressor*{.pure, final.} = object 
    context*: Pointer
    compress*: proc (context: Pointer; inBuffers: ptr TEnetBuffer; 
                     inBufferCount: Csize; inLimit: Csize; 
                     outData: ptr Cuchar; outLimit: Csize): Csize{.cdecl.}
    decompress*: proc (context: Pointer; inData: ptr Cuchar; inLimit: Csize; 
                       outData: ptr Cuchar; outLimit: Csize): Csize{.cdecl.}
    destroy*: proc (context: Pointer){.cdecl.}

  TChecksumCallback* = proc (buffers: ptr TEnetBuffer; bufferCount: Csize): Cuint{.
      cdecl.}
  
  PHost* = ptr THost
  THost*{.pure, final.} = object 
    socket*: TEnetSocket
    address*: TAddress
    incomingBandwidth*: Cuint
    outgoingBandwidth*: Cuint
    bandwidthThrottleEpoch*: Cuint
    mtu*: Cuint
    randomSeed*: Cuint
    recalculateBandwidthLimits*: Cint
    peers*: ptr TPeer
    peerCount*: Csize
    channelLimit*: Csize
    serviceTime*: Cuint
    dispatchQueue*: TEnetList
    continueSending*: Cint
    packetSize*: Csize
    headerFlags*: Cushort
    commands*: Array[0..ENET_PROTOCOL_MAXIMUM_PACKET_COMMANDS - 1, 
                     TEnetProtocol]
    commandCount*: Csize
    buffers*: Array[0..ENET_BUFFER_MAXIMUM - 1, TEnetBuffer]
    bufferCount*: Csize
    checksum*: TChecksumCallback
    compressor*: TCompressor
    packetData*: Array[0..ENET_PROTOCOL_MAXIMUM_MTU - 1, 
                       Array[0..2 - 1, Cuchar]]
    receivedAddress*: TAddress
    receivedData*: ptr Cuchar
    receivedDataLength*: Csize
    totalSentData*: Cuint
    totalSentPackets*: Cuint
    totalReceivedData*: Cuint
    totalReceivedPackets*: Cuint
  
  TEventType*{.size: sizeof(cint).} = enum 
    EvtNone = 0, EvtConnect = 1, 
    EvtDisconnect = 2, EvtReceive = 3
  PEvent* = ptr TEvent
  TEvent*{.pure, final.} = object 
    kind*: TEventType
    peer*: ptr TPeer
    channelID*: Cuchar
    data*: Cuint
    packet*: ptr TPacket

  TENetCallbacks*{.pure, final.} = object 
    malloc*: proc (size: Csize): Pointer{.cdecl.}
    free*: proc (memory: Pointer){.cdecl.}
    no_memory*: proc (){.cdecl.}

{.push callConv:cdecl.}
proc enetMalloc*(a2: Csize): Pointer{.
  importc: "enet_malloc", dynlib: Lib.}
proc enetFree*(a2: Pointer){.
  importc: "enet_free", dynlib: Lib.}

proc enetInit*(): Cint{.
  importc: "enet_initialize", dynlib: Lib.}
proc enetInit*(version: TVersion; inits: ptr TENetCallbacks): Cint{.
  importc: "enet_initialize_with_callbacks", dynlib: Lib.}
proc enetDeinit*(){.
  importc: "enet_deinitialize", dynlib: Lib.}
proc enetTimeGet*(): Cuint{.
  importc: "enet_time_get", dynlib: Lib.}
proc enetTimeSet*(a2: Cuint){.
  importc: "enet_time_set", dynlib: Lib.}

#enet docs are pretty lacking, i'm not sure what the names of these arguments should be
proc createSocket*(kind: TSocketType): TEnetSocket{.
  importc: "enet_socket_create", dynlib: Lib.}
proc bindTo*(socket: TEnetSocket; address: var TAddress): Cint{.
  importc: "enet_socket_bind", dynlib: Lib.}
proc bindTo*(socket: TEnetSocket; address: ptr TAddress): Cint{.
  importc: "enet_socket_bind", dynlib: Lib.}
proc listen*(socket: TEnetSocket; a3: Cint): Cint{.
  importc: "enet_socket_listen", dynlib: Lib.}
proc accept*(socket: TEnetSocket; address: var TAddress): TEnetSocket{.
  importc: "enet_socket_accept", dynlib: Lib.}
proc accept*(socket: TEnetSocket; address: ptr TAddress): TEnetSocket{.
  importc: "enet_socket_accept", dynlib: Lib.}
proc connect*(socket: TEnetSocket; address: var TAddress): Cint{.
  importc: "enet_socket_connect", dynlib: Lib.}
proc connect*(socket: TEnetSocket; address: ptr TAddress): Cint{.
  importc: "enet_socket_connect", dynlib: Lib.}
proc send*(socket: TEnetSocket; address: var TAddress; buffer: ptr TEnetBuffer; size: Csize): Cint{.
  importc: "enet_socket_send", dynlib: Lib.}
proc send*(socket: TEnetSocket; address: ptr TAddress; buffer: ptr TEnetBuffer; size: Csize): Cint{.
  importc: "enet_socket_send", dynlib: Lib.}
proc receive*(socket: TEnetSocket; address: var TAddress; 
               buffer: ptr TEnetBuffer; size: Csize): Cint{.
  importc: "enet_socket_receive", dynlib: Lib.}
proc receive*(socket: TEnetSocket; address: ptr TAddress; 
               buffer: ptr TEnetBuffer; size: Csize): Cint{.
  importc: "enet_socket_receive", dynlib: Lib.}
proc wait*(socket: TEnetSocket; a3: ptr Cuint; a4: Cuint): Cint{.
  importc: "enet_socket_wait", dynlib: Lib.}
proc setOption*(socket: TEnetSocket; a3: TSocketOption; a4: Cint): Cint{.
  importc: "enet_socket_set_option", dynlib: Lib.}
proc destroy*(socket: TEnetSocket){.
  importc: "enet_socket_destroy", dynlib: Lib.}
proc select*(socket: TEnetSocket; a3: ptr TENetSocketSet; 
              a4: ptr TENetSocketSet; a5: Cuint): Cint{.
  importc: "enet_socketset_select", dynlib: Lib.}

proc setHost*(address: PAddress; hostName: Cstring): Cint{.
  importc: "enet_address_set_host", dynlib: Lib.}
proc setHost*(address: var TAddress; hostName: Cstring): Cint{.
  importc: "enet_address_set_host", dynlib: Lib.}
proc getHostIP*(address: var TAddress; hostName: Cstring; nameLength: Csize): Cint{.
  importc: "enet_address_get_host_ip", dynlib: Lib.}
proc getHost*(address: var TAddress; hostName: Cstring; nameLength: Csize): Cint{.
  importc: "enet_address_get_host", dynlib: Lib.}

## Call the above two funcs but trim the result string
proc getHostIP*(address: var TAddress; hostName: var String; nameLength: Csize): Cint{.inline.} =
  hostName.setLen nameLength
  result = getHostIP(address, Cstring(hostName), nameLength)
  if result == 0:
    hostName.setLen(len(Cstring(hostName)))
proc getHost*(address: var TAddress; hostName: var String; nameLength: Csize): Cint{.inline.} =
  hostName.setLen nameLength
  result = getHost(address, Cstring(hostName), nameLength)
  if result == 0:
    hostName.setLen(len(Cstring(hostName)))

proc createPacket*(data: Pointer; len: Csize; flag: TPacketFlag): PPacket{.
  importc: "enet_packet_create", dynlib: Lib.}
proc destroy*(packet: PPacket){.
  importc: "enet_packet_destroy", dynlib: Lib.}
proc resize*(packet: PPacket; dataLength: Csize): Cint{.
  importc: "enet_packet_resize", dynlib: Lib.}

proc crc32*(buffers: ptr TEnetBuffer; bufferCount: Csize): Cuint{.
  importc: "enet_crc32", dynlib: Lib.}

proc createHost*(address: ptr TAddress; maxConnections, maxChannels: Csize; downSpeed, upSpeed: Cuint): PHost{.
  importc: "enet_host_create", dynlib: Lib.}
proc createHost*(address: var TAddress; maxConnections, maxChannels: Csize; downSpeed, upSpeed: Cuint): PHost{.
  importc: "enet_host_create", dynlib: Lib.}
proc destroy*(host: PHost){.
  importc: "enet_host_destroy", dynlib: Lib.}
proc connect*(host: PHost; address: ptr TAddress; channelCount: Csize; data: Cuint): PPeer{.
  importc: "enet_host_connect", dynlib: Lib.}
proc connect*(host: PHost; address: var TAddress; channelCount: Csize; data: Cuint): PPeer{.
  importc: "enet_host_connect", dynlib: Lib.}

proc checkEvents*(host: PHost; event: var TEvent): Cint{.
  importc: "enet_host_check_events", dynlib: Lib.}
proc checkEvents*(host: PHost; event: ptr TEvent): Cint{.
  importc: "enet_host_check_events", dynlib: Lib.}
proc hostService*(host: PHost; event: var TEvent; timeout: Cuint): Cint{.
  importc: "enet_host_service", dynlib: Lib.}
proc hostService*(host: PHost; event: ptr TEvent; timeout: Cuint): Cint{.
  importc: "enet_host_service", dynlib: Lib.}
proc flush*(host: PHost){.
  importc: "enet_host_flush", dynlib: Lib.}
proc broadcast*(host: PHost; channelID: Cuchar; packet: PPacket){.
  importc: "enet_host_broadcast", dynlib: Lib.}
proc compress*(host: PHost; compressor: PCompressor){.
  importc: "enet_host_compress", dynlib: Lib.}
proc compressWithRangeCoder*(host: PHost): Cint{.
  importc: "enet_host_compress_with_range_coder", dynlib: Lib.}
proc channelLimit*(host: PHost; channelLimit: Csize){.
  importc: "enet_host_channel_limit", dynlib: Lib.}
proc bandwidthLimit*(host: PHost; incoming, outgoing: Cuint){.
  importc: "enet_host_bandwidth_limit", dynlib: Lib.}
proc bandwidthThrottle*(host: PHost){.
  importc: "enet_host_bandwidth_throttle", dynlib: Lib.}


proc send*(peer: PPeer; channel: Cuchar; packet: PPacket): Cint{.
  importc: "enet_peer_send", dynlib: Lib.}
proc receive*(peer: PPeer; channelID: ptr Cuchar): PPacket{.
  importc: "enet_peer_receive", dynlib: Lib.}
proc ping*(peer: PPeer){.
  importc: "enet_peer_ping", dynlib: Lib.}
proc reset*(peer: PPeer){.
  importc: "enet_peer_reset", dynlib: Lib.}
proc disconnect*(peer: PPeer; a3: Cuint){.
  importc: "enet_peer_disconnect", dynlib: Lib.}
proc disconnectNow*(peer: PPeer; a3: Cuint){.
  importc: "enet_peer_disconnect_now", dynlib: Lib.}
proc disconnectLater*(peer: PPeer; a3: Cuint){.
  importc: "enet_peer_disconnect_later", dynlib: Lib.}
proc throttleConfigure*(peer: PPeer; interval, acceleration, deceleration: Cuint){.
  importc: "enet_peer_throttle_configure", dynlib: Lib.}
proc throttle*(peer: PPeer; rtt: Cuint): Cint{.
  importc: "enet_peer_throttle", dynlib: Lib.}
proc resetQueues*(peer: PPeer){.
  importc: "enet_peer_reset_queues", dynlib: Lib.}
proc setupOutgoingCommand*(peer: PPeer; outgoingCommand: POutgoingCommand){.
  importc: "enet_peer_setup_outgoing_command", dynlib: Lib.}

proc queueOutgoingCommand*(peer: PPeer; command: ptr TEnetProtocol; 
          packet: PPacket; offset: Cuint; length: Cushort): POutgoingCommand{.
  importc: "enet_peer_queue_outgoing_command", dynlib: Lib.}
proc queueIncomingCommand*(peer: PPeer; command: ptr TEnetProtocol; 
                    packet: PPacket; fragmentCount: Cuint): PIncomingCommand{.
  importc: "enet_peer_queue_incoming_command", dynlib: Lib.}
proc queueAcknowledgement*(peer: PPeer; command: ptr TEnetProtocol; 
                            sentTime: Cushort): PAcknowledgement{.
  importc: "enet_peer_queue_acknowledgement", dynlib: Lib.}
proc dispatchIncomingUnreliableCommands*(peer: PPeer; channel: PChannel){.
  importc: "enet_peer_dispatch_incoming_unreliable_commands", dynlib: Lib.}
proc dispatchIncomingReliableCommands*(peer: PPeer; channel: PChannel){.
  importc: "enet_peer_dispatch_incoming_reliable_commands", dynlib: Lib.}

proc createRangeCoder*(): Pointer{.
  importc: "enet_range_coder_create", dynlib: Lib.}
proc rangeCoderDestroy*(context: Pointer){.
  importc: "enet_range_coder_destroy", dynlib: Lib.}
proc rangeCoderCompress*(context: Pointer; inBuffers: PEnetBuffer; inLimit, 
               bufferCount: Csize; outData: Cstring; outLimit: Csize): Csize{.
  importc: "enet_range_coder_compress", dynlib: Lib.}
proc rangeCoderDecompress*(context: Pointer; inData: Cstring; inLimit: Csize; 
                            outData: Cstring; outLimit: Csize): Csize{.
  importc: "enet_range_coder_decompress", dynlib: Lib.}
proc protocolCommandSize*(commandNumber: Cuchar): Csize{.
  importc: "enet_protocol_command_size", dynlib: Lib.}

{.pop.}

from hashes import `!$`, `!&`, THash, hash
proc hash*(x: TAddress): THash {.nimcall, noSideEffect.} =
  result = !$(hash(x.host.Int32) !& hash(x.port.Int16))

