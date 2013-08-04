#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2006 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#
#       NetBIOS 3.0 interface unit 

# This module contains the definitions for portable NetBIOS 3.0 support. 

{.deadCodeElim: on.}

import                        # Data structure templates 
  Windows

const 
  Ncbnamsz* = 16              # absolute length of a net name
  MaxLana* = 254             # lana's in range 0 to MAX_LANA inclusive

type                          # Network Control Block
  Pncb* = ptr TNCB
  TNCBPostProc* = proc (P: Pncb) {.stdcall.}
  TNCB* {.final.} = object # Structure returned to the NCB command NCBASTAT is ADAPTER_STATUS followed
                           # by an array of NAME_BUFFER structures.
    ncb_command*: Char        # command code
    ncb_retcode*: Char        # return code
    ncb_lsn*: Char            # local session number
    ncb_num*: Char            # number of our network name
    ncb_buffer*: Cstring      # address of message buffer
    ncb_length*: Int16        # size of message buffer
    ncb_callname*: Array[0..NCBNAMSZ - 1, Char] # blank-padded name of remote
    ncb_name*: Array[0..NCBNAMSZ - 1, Char] # our blank-padded netname
    ncb_rto*: Char            # rcv timeout/retry count
    ncb_sto*: Char            # send timeout/sys timeout
    ncb_post*: TNCBPostProc   # POST routine address
    ncb_lana_num*: Char       # lana (adapter) number
    ncb_cmd_cplt*: Char       # 0xff => commmand pending
    ncb_reserve*: Array[0..9, Char] # reserved, used by BIOS
    ncb_event*: THandle       # HANDLE to Win32 event which
                              # will be set to the signalled
                              # state when an ASYNCH command
                              # completes
  
  PAdapterStatus* = ptr TAdapterStatus
  TAdapterStatus* {.final.} = object 
    adapter_address*: Array[0..5, Char]
    rev_major*: Char
    reserved0*: Char
    adapter_type*: Char
    rev_minor*: Char
    duration*: Int16
    frmr_recv*: Int16
    frmr_xmit*: Int16
    iframe_recv_err*: Int16
    xmit_aborts*: Int16
    xmit_success*: Dword
    recv_success*: Dword
    iframe_xmit_err*: Int16
    recv_buff_unavail*: Int16
    t1_timeouts*: Int16
    ti_timeouts*: Int16
    reserved1*: Dword
    free_ncbs*: Int16
    max_cfg_ncbs*: Int16
    max_ncbs*: Int16
    xmit_buf_unavail*: Int16
    max_dgram_size*: Int16
    pending_sess*: Int16
    max_cfg_sess*: Int16
    max_sess*: Int16
    max_sess_pkt_size*: Int16
    name_count*: Int16

  PNameBuffer* = ptr TNameBuffer
  TNameBuffer* {.final.} = object 
    name*: Array[0..NCBNAMSZ - 1, Char]
    name_num*: Char
    name_flags*: Char


const                         # values for name_flags bits.
  NameFlagsMask* = 0x00000087
  GroupName* = 0x00000080
  UniqueName* = 0x00000000
  Registering* = 0x00000000
  Registered* = 0x00000004
  Deregistered* = 0x00000005
  Duplicate* = 0x00000006
  DuplicateDereg* = 0x00000007

type # Structure returned to the NCB command NCBSSTAT is SESSION_HEADER followed
     # by an array of SESSION_BUFFER structures. If the NCB_NAME starts with an
     # asterisk then an array of these structures is returned containing the
     # status for all names.
  PSessionHeader* = ptr TSessionHeader
  TSessionHeader* {.final.} = object 
    sess_name*: Char
    num_sess*: Char
    rcv_dg_outstanding*: Char
    rcv_any_outstanding*: Char

  PSessionBuffer* = ptr TSessionBuffer
  TSessionBuffer* {.final.} = object 
    lsn*: Char
    state*: Char
    local_name*: Array[0..NCBNAMSZ - 1, Char]
    remote_name*: Array[0..NCBNAMSZ - 1, Char]
    rcvs_outstanding*: Char
    sends_outstanding*: Char


const                         # Values for state
  ListenOutstanding* = 0x00000001
  CallPending* = 0x00000002
  SessionEstablished* = 0x00000003
  HangupPending* = 0x00000004
  HangupComplete* = 0x00000005
  SessionAborted* = 0x00000006

type # Structure returned to the NCB command NCBENUM.
     # On a system containing lana's 0, 2 and 3, a structure with
     # length =3, lana[0]=0, lana[1]=2 and lana[2]=3 will be returned.
  PLanaEnum* = ptr TLanaEnum
  TLanaEnum* {.final.} = object # Structure returned to the NCB command NCBFINDNAME is FIND_NAME_HEADER followed
                                # by an array of FIND_NAME_BUFFER structures.
    len*: Char                #  Number of valid entries in lana[]
    lana*: Array[0..MAX_LANA, Char]

  PFindNameHeader* = ptr TFindNameHeader
  TFindNameHeader* {.final.} = object 
    node_count*: Int16
    reserved*: Char
    unique_group*: Char

  PFindNameBuffer* = ptr TFindNameBuffer
  TFindNameBuffer* {.final.} = object # Structure provided with NCBACTION. The purpose of NCBACTION is to provide
                                      # transport specific extensions to netbios.
    len*: Char
    access_control*: Char
    frame_control*: Char
    destination_addr*: Array[0..5, Char]
    source_addr*: Array[0..5, Char]
    routing_info*: Array[0..17, Char]

  PActionHeader* = ptr TActionHeader
  TActionHeader* {.final.} = object 
    transport_id*: Int32
    action_code*: Int16
    reserved*: Int16


const                         # Values for transport_id
  AllTransports* = "M\0\0\0"
  MsNbf* = "MNBF"            # Special values and constants 

const                         # NCB Command codes
  Ncbcall* = 0x00000010       # NCB CALL
  Ncblisten* = 0x00000011     # NCB LISTEN
  Ncbhangup* = 0x00000012     # NCB HANG UP
  Ncbsend* = 0x00000014       # NCB SEND
  Ncbrecv* = 0x00000015       # NCB RECEIVE
  Ncbrecvany* = 0x00000016    # NCB RECEIVE ANY
  Ncbchainsend* = 0x00000017  # NCB CHAIN SEND
  Ncbdgsend* = 0x00000020     # NCB SEND DATAGRAM
  Ncbdgrecv* = 0x00000021     # NCB RECEIVE DATAGRAM
  Ncbdgsendbc* = 0x00000022   # NCB SEND BROADCAST DATAGRAM
  Ncbdgrecvbc* = 0x00000023   # NCB RECEIVE BROADCAST DATAGRAM
  Ncbaddname* = 0x00000030    # NCB ADD NAME
  Ncbdelname* = 0x00000031    # NCB DELETE NAME
  Ncbreset* = 0x00000032      # NCB RESET
  Ncbastat* = 0x00000033      # NCB ADAPTER STATUS
  Ncbsstat* = 0x00000034      # NCB SESSION STATUS
  Ncbcancel* = 0x00000035     # NCB CANCEL
  Ncbaddgrname* = 0x00000036  # NCB ADD GROUP NAME
  Ncbenum* = 0x00000037       # NCB ENUMERATE LANA NUMBERS
  Ncbunlink* = 0x00000070     # NCB UNLINK
  Ncbsendna* = 0x00000071     # NCB SEND NO ACK
  Ncbchainsendna* = 0x00000072 # NCB CHAIN SEND NO ACK
  Ncblanstalert* = 0x00000073 # NCB LAN STATUS ALERT
  Ncbaction* = 0x00000077     # NCB ACTION
  Ncbfindname* = 0x00000078   # NCB FIND NAME
  Ncbtrace* = 0x00000079      # NCB TRACE
  Asynch* = 0x00000080        # high bit set = asynchronous
                              # NCB Return codes
  NrcGoodret* = 0x00000000   # good return
                              # also returned when ASYNCH request accepted
  NrcBuflen* = 0x00000001    # illegal buffer length
  NrcIllcmd* = 0x00000003    # illegal command
  NrcCmdtmo* = 0x00000005    # command timed out
  NrcIncomp* = 0x00000006    # message incomplete, issue another command
  NrcBaddr* = 0x00000007     # illegal buffer address
  NrcSnumout* = 0x00000008   # session number out of range
  NrcNores* = 0x00000009     # no resource available
  NrcSclosed* = 0x0000000A   # session closed
  NrcCmdcan* = 0x0000000B    # command cancelled
  NrcDupname* = 0x0000000D   # duplicate name
  NrcNamtful* = 0x0000000E   # name table full
  NrcActses* = 0x0000000F    # no deletions, name has active sessions
  NrcLoctful* = 0x00000011   # local session table full
  NrcRemtful* = 0x00000012   # remote session table full
  NrcIllnn* = 0x00000013     # illegal name number
  NrcNocall* = 0x00000014    # no callname
  NrcNowild* = 0x00000015    # cannot put * in NCB_NAME
  NrcInuse* = 0x00000016     # name in use on remote adapter
  NrcNamerr* = 0x00000017    # name deleted
  NrcSabort* = 0x00000018    # session ended abnormally
  NrcNamconf* = 0x00000019   # name conflict detected
  NrcIfbusy* = 0x00000021    # interface busy, IRET before retrying
  NrcToomany* = 0x00000022   # too many commands outstanding, retry later
  NrcBridge* = 0x00000023    # NCB_lana_num field invalid
  NrcCanoccr* = 0x00000024   # command completed while cancel occurring
  NrcCancel* = 0x00000026    # command not valid to cancel
  NrcDupenv* = 0x00000030    # name defined by anther local process
  NrcEnvnotdef* = 0x00000034 # environment undefined. RESET required
  NrcOsresnotav* = 0x00000035 # required OS resources exhausted
  NrcMaxapps* = 0x00000036   # max number of applications exceeded
  NrcNosaps* = 0x00000037    # no saps available for netbios
  NrcNoresources* = 0x00000038 # requested resources are not available
  NrcInvaddress* = 0x00000039 # invalid ncb address or length > segment
  NrcInvddid* = 0x0000003B   # invalid NCB DDID
  NrcLockfail* = 0x0000003C  # lock of user area failed
  NrcOpenerr* = 0x0000003F   # NETBIOS not loaded
  NrcSystem* = 0x00000040    # system error
  NrcPending* = 0x000000FF   # asynchronous command is not yet finished
                              # main user entry point for NetBIOS 3.0
                              #   Usage: Result = Netbios( pncb ); 

proc netbios*(P: Pncb): Char{.stdcall, dynlib: "netapi32.dll", 
                              importc: "Netbios".}
# implementation
