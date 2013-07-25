# This module contains the definitions for structures and externs for
# functions used by frontend postgres applications. It is based on
# Postgresql's libpq-fe.h.
#
# It is for postgreSQL version 7.4 and higher with support for the v3.0
# connection-protocol.
#

{.deadCodeElim: on.}

when defined(windows):
  const
    dllName = "libpq.dll"
elif defined(macosx):
  const
    dllName = "libpq.dylib"
else:
  const
    dllName = "libpq.so(.5|)"
type
  POid* = ptr Oid
  Oid* = int32

const
  ERROR_MSG_LENGTH* = 4096
  CMDSTATUS_LEN* = 40

type
  TSockAddr* = array[1..112, int8]
  TPGresAttDesc*{.pure, final.} = object
    name*: cstring
    adtid*: Oid
    adtsize*: int

  PPGresAttDesc* = ptr TPGresAttDesc
  PPPGresAttDesc* = ptr PPGresAttDesc
  TPGresAttValue*{.pure, final.} = object
    length*: int32
    value*: cstring

  PPGresAttValue* = ptr TPGresAttValue
  PPPGresAttValue* = ptr PPGresAttValue
  PExecStatusType* = ptr TExecStatusType
  TExecStatusType* = enum
    PGRES_EMPTY_QUERY = 0, PGRES_COMMAND_OK, PGRES_TUPLES_OK, PGRES_COPY_OUT,
    PGRES_COPY_IN, PGRES_BAD_RESPONSE, PGRES_NONFATAL_ERROR, PGRES_FATAL_ERROR
  TPGlobjfuncs*{.pure, final.} = object
    fn_lo_open*: Oid
    fn_lo_close*: Oid
    fn_lo_creat*: Oid
    fn_lo_unlink*: Oid
    fn_lo_lseek*: Oid
    fn_lo_tell*: Oid
    fn_lo_read*: Oid
    fn_lo_write*: Oid

  PPGlobjfuncs* = ptr TPGlobjfuncs
  PConnStatusType* = ptr TConnStatusType
  TConnStatusType* = enum
    CONNECTION_OK, CONNECTION_BAD, CONNECTION_STARTED, CONNECTION_MADE,
    CONNECTION_AWAITING_RESPONSE, CONNECTION_AUTH_OK, CONNECTION_SETENV,
    CONNECTION_SSL_STARTUP, CONNECTION_NEEDED
  TPGconn*{.pure, final.} = object
    pghost*: cstring
    pgtty*: cstring
    pgport*: cstring
    pgoptions*: cstring
    dbName*: cstring
    status*: TConnStatusType
    errorMessage*: array[0..(ERROR_MSG_LENGTH) - 1, char]
    Pfin*: TFile
    Pfout*: TFile
    Pfdebug*: TFile
    sock*: int32
    laddr*: TSockAddr
    raddr*: TSockAddr
    salt*: array[0..(2) - 1, char]
    asyncNotifyWaiting*: int32
    notifyList*: pointer
    pguser*: cstring
    pgpass*: cstring
    lobjfuncs*: PPGlobjfuncs

  PPGconn* = ptr TPGconn
  TPGresult*{.pure, final.} = object
    ntups*: int32
    numAttributes*: int32
    attDescs*: PPGresAttDesc
    tuples*: PPPGresAttValue
    tupArrSize*: int32
    resultStatus*: TExecStatusType
    cmdStatus*: array[0..(CMDSTATUS_LEN) - 1, char]
    binary*: int32
    conn*: PPGconn

  PPGresult* = ptr TPGresult
  PPostgresPollingStatusType* = ptr PostgresPollingStatusType
  PostgresPollingStatusType* = enum
    PGRES_POLLING_FAILED = 0, PGRES_POLLING_READING, PGRES_POLLING_WRITING,
    PGRES_POLLING_OK, PGRES_POLLING_ACTIVE
  PPGTransactionStatusType* = ptr PGTransactionStatusType
  PGTransactionStatusType* = enum
    PQTRANS_IDLE, PQTRANS_ACTIVE, PQTRANS_INTRANS, PQTRANS_INERROR,
    PQTRANS_UNKNOWN
  PPGVerbosity* = ptr PGVerbosity
  PGVerbosity* = enum
    PQERRORS_TERSE, PQERRORS_DEFAULT, PQERRORS_VERBOSE
  PpgNotify* = ptr pgNotify
  pgNotify*{.pure, final.} = object
    relname*: cstring
    be_pid*: int32
    extra*: cstring

  PQnoticeReceiver* = proc (arg: pointer, res: PPGresult){.cdecl.}
  PQnoticeProcessor* = proc (arg: pointer, message: cstring){.cdecl.}
  Ppqbool* = ptr pqbool
  pqbool* = char
  P_PQprintOpt* = ptr PQprintOpt
  PQprintOpt*{.pure, final.} = object
    header*: pqbool
    align*: pqbool
    standard*: pqbool
    html3*: pqbool
    expanded*: pqbool
    pager*: pqbool
    fieldSep*: cstring
    tableOpt*: cstring
    caption*: cstring
    fieldName*: ptr cstring

  P_PQconninfoOption* = ptr PQconninfoOption
  PQconninfoOption*{.pure, final.} = object
    keyword*: cstring
    envvar*: cstring
    compiled*: cstring
    val*: cstring
    label*: cstring
    dispchar*: cstring
    dispsize*: int32

  PPQArgBlock* = ptr PQArgBlock
  PQArgBlock*{.pure, final.} = object
    length*: int32
    isint*: int32
    p*: pointer


proc pQconnectStart*(conninfo: cstring): PPGconn{.cdecl, dynlib: dllName,
    importc: "PQconnectStart".}
proc pQconnectPoll*(conn: PPGconn): PostgresPollingStatusType{.cdecl,
    dynlib: dllName, importc: "PQconnectPoll".}
proc pQconnectdb*(conninfo: cstring): PPGconn{.cdecl, dynlib: dllName,
    importc: "PQconnectdb".}
proc pQsetdbLogin*(pghost: cstring, pgport: cstring, pgoptions: cstring,
                   pgtty: cstring, dbName: cstring, login: cstring, pwd: cstring): PPGconn{.
    cdecl, dynlib: dllName, importc: "PQsetdbLogin".}
proc pQsetdb*(M_PGHOST, M_PGPORT, M_PGOPT, M_PGTTY, M_DBNAME: cstring): ppgconn
proc pQfinish*(conn: PPGconn){.cdecl, dynlib: dllName, importc: "PQfinish".}
proc pQconndefaults*(): PPQconninfoOption{.cdecl, dynlib: dllName,
    importc: "PQconndefaults".}
proc pQconninfoFree*(connOptions: PPQconninfoOption){.cdecl, dynlib: dllName,
    importc: "PQconninfoFree".}
proc pQresetStart*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
    importc: "PQresetStart".}
proc pQresetPoll*(conn: PPGconn): PostgresPollingStatusType{.cdecl,
    dynlib: dllName, importc: "PQresetPoll".}
proc pQreset*(conn: PPGconn){.cdecl, dynlib: dllName, importc: "PQreset".}
proc pQrequestCancel*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
    importc: "PQrequestCancel".}
proc pQdb*(conn: PPGconn): cstring{.cdecl, dynlib: dllName, importc: "PQdb".}
proc pQuser*(conn: PPGconn): cstring{.cdecl, dynlib: dllName, importc: "PQuser".}
proc pQpass*(conn: PPGconn): cstring{.cdecl, dynlib: dllName, importc: "PQpass".}
proc pQhost*(conn: PPGconn): cstring{.cdecl, dynlib: dllName, importc: "PQhost".}
proc pQport*(conn: PPGconn): cstring{.cdecl, dynlib: dllName, importc: "PQport".}
proc pQtty*(conn: PPGconn): cstring{.cdecl, dynlib: dllName, importc: "PQtty".}
proc pQoptions*(conn: PPGconn): cstring{.cdecl, dynlib: dllName,
    importc: "PQoptions".}
proc pQstatus*(conn: PPGconn): TConnStatusType{.cdecl, dynlib: dllName,
    importc: "PQstatus".}
proc pQtransactionStatus*(conn: PPGconn): PGTransactionStatusType{.cdecl,
    dynlib: dllName, importc: "PQtransactionStatus".}
proc pQparameterStatus*(conn: PPGconn, paramName: cstring): cstring{.cdecl,
    dynlib: dllName, importc: "PQparameterStatus".}
proc pQprotocolVersion*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
    importc: "PQprotocolVersion".}
proc pQerrorMessage*(conn: PPGconn): cstring{.cdecl, dynlib: dllName,
    importc: "PQerrorMessage".}
proc pQsocket*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
                                      importc: "PQsocket".}
proc pQbackendPID*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
    importc: "PQbackendPID".}
proc pQclientEncoding*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
    importc: "PQclientEncoding".}
proc pQsetClientEncoding*(conn: PPGconn, encoding: cstring): int32{.cdecl,
    dynlib: dllName, importc: "PQsetClientEncoding".}
when defined(USE_SSL):
  # Get the SSL structure associated with a connection
  proc pQgetssl*(conn: PPGconn): PSSL{.cdecl, dynlib: dllName,
                                       importc: "PQgetssl".}
proc pQsetErrorVerbosity*(conn: PPGconn, verbosity: PGVerbosity): PGVerbosity{.
    cdecl, dynlib: dllName, importc: "PQsetErrorVerbosity".}
proc pQtrace*(conn: PPGconn, debug_port: TFile){.cdecl, dynlib: dllName,
    importc: "PQtrace".}
proc pQuntrace*(conn: PPGconn){.cdecl, dynlib: dllName, importc: "PQuntrace".}
proc pQsetNoticeReceiver*(conn: PPGconn, theProc: PQnoticeReceiver, arg: pointer): PQnoticeReceiver{.
    cdecl, dynlib: dllName, importc: "PQsetNoticeReceiver".}
proc pQsetNoticeProcessor*(conn: PPGconn, theProc: PQnoticeProcessor,
                           arg: pointer): PQnoticeProcessor{.cdecl,
    dynlib: dllName, importc: "PQsetNoticeProcessor".}
proc pQexec*(conn: PPGconn, query: cstring): PPGresult{.cdecl, dynlib: dllName,
    importc: "PQexec".}
proc pQexecParams*(conn: PPGconn, command: cstring, nParams: int32,
                   paramTypes: POid, paramValues: cstringArray,
                   paramLengths, paramFormats: ptr int32, resultFormat: int32): PPGresult{.
    cdecl, dynlib: dllName, importc: "PQexecParams".}
proc pQexecPrepared*(conn: PPGconn, stmtName: cstring, nParams: int32,
                     paramValues: cstringArray,
                     paramLengths, paramFormats: ptr int32, resultFormat: int32): PPGresult{.
    cdecl, dynlib: dllName, importc: "PQexecPrepared".}
proc pQsendQuery*(conn: PPGconn, query: cstring): int32{.cdecl, dynlib: dllName,
    importc: "PQsendQuery".}
proc pQsendQueryParams*(conn: PPGconn, command: cstring, nParams: int32,
                        paramTypes: POid, paramValues: cstringArray,
                        paramLengths, paramFormats: ptr int32,
                        resultFormat: int32): int32{.cdecl, dynlib: dllName,
    importc: "PQsendQueryParams".}
proc pQsendQueryPrepared*(conn: PPGconn, stmtName: cstring, nParams: int32,
                          paramValues: cstringArray,
                          paramLengths, paramFormats: ptr int32,
                          resultFormat: int32): int32{.cdecl, dynlib: dllName,
    importc: "PQsendQueryPrepared".}
proc pQgetResult*(conn: PPGconn): PPGresult{.cdecl, dynlib: dllName,
    importc: "PQgetResult".}
proc pQisBusy*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
                                      importc: "PQisBusy".}
proc pQconsumeInput*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
    importc: "PQconsumeInput".}
proc pQnotifies*(conn: PPGconn): PPGnotify{.cdecl, dynlib: dllName,
    importc: "PQnotifies".}
proc pQputCopyData*(conn: PPGconn, buffer: cstring, nbytes: int32): int32{.
    cdecl, dynlib: dllName, importc: "PQputCopyData".}
proc pQputCopyEnd*(conn: PPGconn, errormsg: cstring): int32{.cdecl,
    dynlib: dllName, importc: "PQputCopyEnd".}
proc pQgetCopyData*(conn: PPGconn, buffer: cstringArray, async: int32): int32{.
    cdecl, dynlib: dllName, importc: "PQgetCopyData".}
proc pQgetline*(conn: PPGconn, str: cstring, len: int32): int32{.cdecl,
    dynlib: dllName, importc: "PQgetline".}
proc pQputline*(conn: PPGconn, str: cstring): int32{.cdecl, dynlib: dllName,
    importc: "PQputline".}
proc pQgetlineAsync*(conn: PPGconn, buffer: cstring, bufsize: int32): int32{.
    cdecl, dynlib: dllName, importc: "PQgetlineAsync".}
proc pQputnbytes*(conn: PPGconn, buffer: cstring, nbytes: int32): int32{.cdecl,
    dynlib: dllName, importc: "PQputnbytes".}
proc pQendcopy*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
                                       importc: "PQendcopy".}
proc pQsetnonblocking*(conn: PPGconn, arg: int32): int32{.cdecl,
    dynlib: dllName, importc: "PQsetnonblocking".}
proc pQisnonblocking*(conn: PPGconn): int32{.cdecl, dynlib: dllName,
    importc: "PQisnonblocking".}
proc pQflush*(conn: PPGconn): int32{.cdecl, dynlib: dllName, importc: "PQflush".}
proc pQfn*(conn: PPGconn, fnid: int32, result_buf, result_len: ptr int32,
           result_is_int: int32, args: PPQArgBlock, nargs: int32): PPGresult{.
    cdecl, dynlib: dllName, importc: "PQfn".}
proc pQresultStatus*(res: PPGresult): TExecStatusType{.cdecl, dynlib: dllName,
    importc: "PQresultStatus".}
proc pQresStatus*(status: TExecStatusType): cstring{.cdecl, dynlib: dllName,
    importc: "PQresStatus".}
proc pQresultErrorMessage*(res: PPGresult): cstring{.cdecl, dynlib: dllName,
    importc: "PQresultErrorMessage".}
proc pQresultErrorField*(res: PPGresult, fieldcode: int32): cstring{.cdecl,
    dynlib: dllName, importc: "PQresultErrorField".}
proc pQntuples*(res: PPGresult): int32{.cdecl, dynlib: dllName,
                                        importc: "PQntuples".}
proc pQnfields*(res: PPGresult): int32{.cdecl, dynlib: dllName,
                                        importc: "PQnfields".}
proc pQbinaryTuples*(res: PPGresult): int32{.cdecl, dynlib: dllName,
    importc: "PQbinaryTuples".}
proc pQfname*(res: PPGresult, field_num: int32): cstring{.cdecl,
    dynlib: dllName, importc: "PQfname".}
proc pQfnumber*(res: PPGresult, field_name: cstring): int32{.cdecl,
    dynlib: dllName, importc: "PQfnumber".}
proc pQftable*(res: PPGresult, field_num: int32): Oid{.cdecl, dynlib: dllName,
    importc: "PQftable".}
proc pQftablecol*(res: PPGresult, field_num: int32): int32{.cdecl,
    dynlib: dllName, importc: "PQftablecol".}
proc pQfformat*(res: PPGresult, field_num: int32): int32{.cdecl,
    dynlib: dllName, importc: "PQfformat".}
proc pQftype*(res: PPGresult, field_num: int32): Oid{.cdecl, dynlib: dllName,
    importc: "PQftype".}
proc pQfsize*(res: PPGresult, field_num: int32): int32{.cdecl, dynlib: dllName,
    importc: "PQfsize".}
proc pQfmod*(res: PPGresult, field_num: int32): int32{.cdecl, dynlib: dllName,
    importc: "PQfmod".}
proc pQcmdStatus*(res: PPGresult): cstring{.cdecl, dynlib: dllName,
    importc: "PQcmdStatus".}
proc pQoidStatus*(res: PPGresult): cstring{.cdecl, dynlib: dllName,
    importc: "PQoidStatus".}
proc pQoidValue*(res: PPGresult): Oid{.cdecl, dynlib: dllName,
                                       importc: "PQoidValue".}
proc pQcmdTuples*(res: PPGresult): cstring{.cdecl, dynlib: dllName,
    importc: "PQcmdTuples".}
proc pQgetvalue*(res: PPGresult, tup_num: int32, field_num: int32): cstring{.
    cdecl, dynlib: dllName, importc: "PQgetvalue".}
proc pQgetlength*(res: PPGresult, tup_num: int32, field_num: int32): int32{.
    cdecl, dynlib: dllName, importc: "PQgetlength".}
proc pQgetisnull*(res: PPGresult, tup_num: int32, field_num: int32): int32{.
    cdecl, dynlib: dllName, importc: "PQgetisnull".}
proc pQclear*(res: PPGresult){.cdecl, dynlib: dllName, importc: "PQclear".}
proc pQfreemem*(p: pointer){.cdecl, dynlib: dllName, importc: "PQfreemem".}
proc pQmakeEmptyPGresult*(conn: PPGconn, status: TExecStatusType): PPGresult{.
    cdecl, dynlib: dllName, importc: "PQmakeEmptyPGresult".}
proc pQescapeString*(till, `from`: cstring, len: int): int{.cdecl,
    dynlib: dllName, importc: "PQescapeString".}
proc pQescapeBytea*(bintext: cstring, binlen: int, bytealen: var int): cstring{.
    cdecl, dynlib: dllName, importc: "PQescapeBytea".}
proc pQunescapeBytea*(strtext: cstring, retbuflen: var int): cstring{.cdecl,
    dynlib: dllName, importc: "PQunescapeBytea".}
proc pQprint*(fout: TFile, res: PPGresult, ps: PPQprintOpt){.cdecl,
    dynlib: dllName, importc: "PQprint".}
proc pQdisplayTuples*(res: PPGresult, fp: TFile, fillAlign: int32,
                      fieldSep: cstring, printHeader: int32, quiet: int32){.
    cdecl, dynlib: dllName, importc: "PQdisplayTuples".}
proc pQprintTuples*(res: PPGresult, fout: TFile, printAttName: int32,
                    terseOutput: int32, width: int32){.cdecl, dynlib: dllName,
    importc: "PQprintTuples".}
proc lo_open*(conn: PPGconn, lobjId: Oid, mode: int32): int32{.cdecl,
    dynlib: dllName, importc: "lo_open".}
proc lo_close*(conn: PPGconn, fd: int32): int32{.cdecl, dynlib: dllName,
    importc: "lo_close".}
proc lo_read*(conn: PPGconn, fd: int32, buf: cstring, length: int): int32{.
    cdecl, dynlib: dllName, importc: "lo_read".}
proc lo_write*(conn: PPGconn, fd: int32, buf: cstring, length: int): int32{.
    cdecl, dynlib: dllName, importc: "lo_write".}
proc lo_lseek*(conn: PPGconn, fd: int32, offset: int32, whence: int32): int32{.
    cdecl, dynlib: dllName, importc: "lo_lseek".}
proc lo_creat*(conn: PPGconn, mode: int32): Oid{.cdecl, dynlib: dllName,
    importc: "lo_creat".}
proc lo_tell*(conn: PPGconn, fd: int32): int32{.cdecl, dynlib: dllName,
    importc: "lo_tell".}
proc lo_unlink*(conn: PPGconn, lobjId: Oid): int32{.cdecl, dynlib: dllName,
    importc: "lo_unlink".}
proc lo_import*(conn: PPGconn, filename: cstring): Oid{.cdecl, dynlib: dllName,
    importc: "lo_import".}
proc lo_export*(conn: PPGconn, lobjId: Oid, filename: cstring): int32{.cdecl,
    dynlib: dllName, importc: "lo_export".}
proc pQmblen*(s: cstring, encoding: int32): int32{.cdecl, dynlib: dllName,
    importc: "PQmblen".}
proc pQenv2encoding*(): int32{.cdecl, dynlib: dllName, importc: "PQenv2encoding".}
proc pQsetdb(M_PGHOST, M_PGPORT, M_PGOPT, M_PGTTY, M_DBNAME: cstring): ppgconn =
  result = PQsetdbLogin(M_PGHOST, M_PGPORT, M_PGOPT, M_PGTTY, M_DBNAME, "", "")
