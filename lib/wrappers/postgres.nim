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
  Oid* = Int32

const 
  ErrorMsgLength* = 4096
  CmdstatusLen* = 40

type 
  TSockAddr* = Array[1..112, Int8]
  TPGresAttDesc*{.pure, final.} = object 
    name*: Cstring
    adtid*: Oid
    adtsize*: Int

  PPGresAttDesc* = ptr TPGresAttDesc
  PPPGresAttDesc* = ptr PPGresAttDesc
  TPGresAttValue*{.pure, final.} = object 
    length*: Int32
    value*: Cstring

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
    pghost*: Cstring
    pgtty*: Cstring
    pgport*: Cstring
    pgoptions*: Cstring
    dbName*: Cstring
    status*: TConnStatusType
    errorMessage*: Array[0..(ERROR_MSG_LENGTH) - 1, Char]
    Pfin*: TFile
    Pfout*: TFile
    Pfdebug*: TFile
    sock*: Int32
    laddr*: TSockAddr
    raddr*: TSockAddr
    salt*: Array[0..(2) - 1, Char]
    asyncNotifyWaiting*: Int32
    notifyList*: Pointer
    pguser*: Cstring
    pgpass*: Cstring
    lobjfuncs*: PPGlobjfuncs

  PPGconn* = ptr TPGconn
  TPGresult*{.pure, final.} = object 
    ntups*: Int32
    numAttributes*: Int32
    attDescs*: PPGresAttDesc
    tuples*: PPPGresAttValue
    tupArrSize*: Int32
    resultStatus*: TExecStatusType
    cmdStatus*: Array[0..(CMDSTATUS_LEN) - 1, Char]
    binary*: Int32
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
  PpgNotify* = ptr PgNotify
  PgNotify*{.pure, final.} = object 
    relname*: Cstring
    be_pid*: Int32
    extra*: Cstring

  PQnoticeReceiver* = proc (arg: Pointer, res: PPGresult){.cdecl.}
  PQnoticeProcessor* = proc (arg: Pointer, message: Cstring){.cdecl.}
  Ppqbool* = ptr Pqbool
  Pqbool* = Char
  PPQprintOpt* = ptr PQprintOpt
  PQprintOpt*{.pure, final.} = object 
    header*: Pqbool
    align*: Pqbool
    standard*: Pqbool
    html3*: Pqbool
    expanded*: Pqbool
    pager*: Pqbool
    fieldSep*: Cstring
    tableOpt*: Cstring
    caption*: Cstring
    fieldName*: ptr Cstring

  PPQconninfoOption* = ptr PQconninfoOption
  PQconninfoOption*{.pure, final.} = object 
    keyword*: Cstring
    envvar*: Cstring
    compiled*: Cstring
    val*: Cstring
    label*: Cstring
    dispchar*: Cstring
    dispsize*: Int32

  PPQArgBlock* = ptr PQArgBlock
  PQArgBlock*{.pure, final.} = object 
    length*: Int32
    isint*: Int32
    p*: Pointer


proc pQconnectStart*(conninfo: Cstring): PPGconn{.cdecl, dynlib: dllName, 
    importc: "PQconnectStart".}
proc pQconnectPoll*(conn: PPGconn): PostgresPollingStatusType{.cdecl, 
    dynlib: dllName, importc: "PQconnectPoll".}
proc pQconnectdb*(conninfo: Cstring): PPGconn{.cdecl, dynlib: dllName, 
    importc: "PQconnectdb".}
proc pQsetdbLogin*(pghost: Cstring, pgport: Cstring, pgoptions: Cstring, 
                   pgtty: Cstring, dbName: Cstring, login: Cstring, pwd: Cstring): PPGconn{.
    cdecl, dynlib: dllName, importc: "PQsetdbLogin".}
proc pQsetdb*(M_PGHOST, M_PGPORT, M_PGOPT, M_PGTTY, M_DBNAME: Cstring): PPGconn
proc pQfinish*(conn: PPGconn){.cdecl, dynlib: dllName, importc: "PQfinish".}
proc pQconndefaults*(): PPQconninfoOption{.cdecl, dynlib: dllName, 
    importc: "PQconndefaults".}
proc pQconninfoFree*(connOptions: PPQconninfoOption){.cdecl, dynlib: dllName, 
    importc: "PQconninfoFree".}
proc pQresetStart*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
    importc: "PQresetStart".}
proc pQresetPoll*(conn: PPGconn): PostgresPollingStatusType{.cdecl, 
    dynlib: dllName, importc: "PQresetPoll".}
proc pQreset*(conn: PPGconn){.cdecl, dynlib: dllName, importc: "PQreset".}
proc pQrequestCancel*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
    importc: "PQrequestCancel".}
proc pQdb*(conn: PPGconn): Cstring{.cdecl, dynlib: dllName, importc: "PQdb".}
proc pQuser*(conn: PPGconn): Cstring{.cdecl, dynlib: dllName, importc: "PQuser".}
proc pQpass*(conn: PPGconn): Cstring{.cdecl, dynlib: dllName, importc: "PQpass".}
proc pQhost*(conn: PPGconn): Cstring{.cdecl, dynlib: dllName, importc: "PQhost".}
proc pQport*(conn: PPGconn): Cstring{.cdecl, dynlib: dllName, importc: "PQport".}
proc pQtty*(conn: PPGconn): Cstring{.cdecl, dynlib: dllName, importc: "PQtty".}
proc pQoptions*(conn: PPGconn): Cstring{.cdecl, dynlib: dllName, 
    importc: "PQoptions".}
proc pQstatus*(conn: PPGconn): TConnStatusType{.cdecl, dynlib: dllName, 
    importc: "PQstatus".}
proc pQtransactionStatus*(conn: PPGconn): PGTransactionStatusType{.cdecl, 
    dynlib: dllName, importc: "PQtransactionStatus".}
proc pQparameterStatus*(conn: PPGconn, paramName: Cstring): Cstring{.cdecl, 
    dynlib: dllName, importc: "PQparameterStatus".}
proc pQprotocolVersion*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
    importc: "PQprotocolVersion".}
proc pQerrorMessage*(conn: PPGconn): Cstring{.cdecl, dynlib: dllName, 
    importc: "PQerrorMessage".}
proc pQsocket*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
                                      importc: "PQsocket".}
proc pQbackendPID*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
    importc: "PQbackendPID".}
proc pQclientEncoding*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
    importc: "PQclientEncoding".}
proc pQsetClientEncoding*(conn: PPGconn, encoding: Cstring): Int32{.cdecl, 
    dynlib: dllName, importc: "PQsetClientEncoding".}
when defined(USE_SSL): 
  # Get the SSL structure associated with a connection  
  proc PQgetssl*(conn: PPGconn): PSSL{.cdecl, dynlib: dllName, 
                                       importc: "PQgetssl".}
proc pQsetErrorVerbosity*(conn: PPGconn, verbosity: PGVerbosity): PGVerbosity{.
    cdecl, dynlib: dllName, importc: "PQsetErrorVerbosity".}
proc pQtrace*(conn: PPGconn, debug_port: TFile){.cdecl, dynlib: dllName, 
    importc: "PQtrace".}
proc pQuntrace*(conn: PPGconn){.cdecl, dynlib: dllName, importc: "PQuntrace".}
proc pQsetNoticeReceiver*(conn: PPGconn, theProc: PQnoticeReceiver, arg: Pointer): PQnoticeReceiver{.
    cdecl, dynlib: dllName, importc: "PQsetNoticeReceiver".}
proc pQsetNoticeProcessor*(conn: PPGconn, theProc: PQnoticeProcessor, 
                           arg: Pointer): PQnoticeProcessor{.cdecl, 
    dynlib: dllName, importc: "PQsetNoticeProcessor".}
proc pQexec*(conn: PPGconn, query: Cstring): PPGresult{.cdecl, dynlib: dllName, 
    importc: "PQexec".}
proc pQexecParams*(conn: PPGconn, command: Cstring, nParams: Int32, 
                   paramTypes: POid, paramValues: CstringArray, 
                   paramLengths, paramFormats: ptr Int32, resultFormat: Int32): PPGresult{.
    cdecl, dynlib: dllName, importc: "PQexecParams".}
proc pQexecPrepared*(conn: PPGconn, stmtName: Cstring, nParams: Int32, 
                     paramValues: CstringArray, 
                     paramLengths, paramFormats: ptr Int32, resultFormat: Int32): PPGresult{.
    cdecl, dynlib: dllName, importc: "PQexecPrepared".}
proc pQsendQuery*(conn: PPGconn, query: Cstring): Int32{.cdecl, dynlib: dllName, 
    importc: "PQsendQuery".}
proc pQsendQueryParams*(conn: PPGconn, command: Cstring, nParams: Int32, 
                        paramTypes: POid, paramValues: CstringArray, 
                        paramLengths, paramFormats: ptr Int32, 
                        resultFormat: Int32): Int32{.cdecl, dynlib: dllName, 
    importc: "PQsendQueryParams".}
proc pQsendQueryPrepared*(conn: PPGconn, stmtName: Cstring, nParams: Int32, 
                          paramValues: CstringArray, 
                          paramLengths, paramFormats: ptr Int32, 
                          resultFormat: Int32): Int32{.cdecl, dynlib: dllName, 
    importc: "PQsendQueryPrepared".}
proc pQgetResult*(conn: PPGconn): PPGresult{.cdecl, dynlib: dllName, 
    importc: "PQgetResult".}
proc pQisBusy*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
                                      importc: "PQisBusy".}
proc pQconsumeInput*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
    importc: "PQconsumeInput".}
proc pQnotifies*(conn: PPGconn): PpgNotify{.cdecl, dynlib: dllName, 
    importc: "PQnotifies".}
proc pQputCopyData*(conn: PPGconn, buffer: Cstring, nbytes: Int32): Int32{.
    cdecl, dynlib: dllName, importc: "PQputCopyData".}
proc pQputCopyEnd*(conn: PPGconn, errormsg: Cstring): Int32{.cdecl, 
    dynlib: dllName, importc: "PQputCopyEnd".}
proc pQgetCopyData*(conn: PPGconn, buffer: CstringArray, async: Int32): Int32{.
    cdecl, dynlib: dllName, importc: "PQgetCopyData".}
proc pQgetline*(conn: PPGconn, str: Cstring, len: Int32): Int32{.cdecl, 
    dynlib: dllName, importc: "PQgetline".}
proc pQputline*(conn: PPGconn, str: Cstring): Int32{.cdecl, dynlib: dllName, 
    importc: "PQputline".}
proc pQgetlineAsync*(conn: PPGconn, buffer: Cstring, bufsize: Int32): Int32{.
    cdecl, dynlib: dllName, importc: "PQgetlineAsync".}
proc pQputnbytes*(conn: PPGconn, buffer: Cstring, nbytes: Int32): Int32{.cdecl, 
    dynlib: dllName, importc: "PQputnbytes".}
proc pQendcopy*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
                                       importc: "PQendcopy".}
proc pQsetnonblocking*(conn: PPGconn, arg: Int32): Int32{.cdecl, 
    dynlib: dllName, importc: "PQsetnonblocking".}
proc pQisnonblocking*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, 
    importc: "PQisnonblocking".}
proc pQflush*(conn: PPGconn): Int32{.cdecl, dynlib: dllName, importc: "PQflush".}
proc pQfn*(conn: PPGconn, fnid: Int32, result_buf, result_len: ptr Int32, 
           result_is_int: Int32, args: PPQArgBlock, nargs: Int32): PPGresult{.
    cdecl, dynlib: dllName, importc: "PQfn".}
proc pQresultStatus*(res: PPGresult): TExecStatusType{.cdecl, dynlib: dllName, 
    importc: "PQresultStatus".}
proc pQresStatus*(status: TExecStatusType): Cstring{.cdecl, dynlib: dllName, 
    importc: "PQresStatus".}
proc pQresultErrorMessage*(res: PPGresult): Cstring{.cdecl, dynlib: dllName, 
    importc: "PQresultErrorMessage".}
proc pQresultErrorField*(res: PPGresult, fieldcode: Int32): Cstring{.cdecl, 
    dynlib: dllName, importc: "PQresultErrorField".}
proc pQntuples*(res: PPGresult): Int32{.cdecl, dynlib: dllName, 
                                        importc: "PQntuples".}
proc pQnfields*(res: PPGresult): Int32{.cdecl, dynlib: dllName, 
                                        importc: "PQnfields".}
proc pQbinaryTuples*(res: PPGresult): Int32{.cdecl, dynlib: dllName, 
    importc: "PQbinaryTuples".}
proc pQfname*(res: PPGresult, field_num: Int32): Cstring{.cdecl, 
    dynlib: dllName, importc: "PQfname".}
proc pQfnumber*(res: PPGresult, field_name: Cstring): Int32{.cdecl, 
    dynlib: dllName, importc: "PQfnumber".}
proc pQftable*(res: PPGresult, field_num: Int32): Oid{.cdecl, dynlib: dllName, 
    importc: "PQftable".}
proc pQftablecol*(res: PPGresult, field_num: Int32): Int32{.cdecl, 
    dynlib: dllName, importc: "PQftablecol".}
proc pQfformat*(res: PPGresult, field_num: Int32): Int32{.cdecl, 
    dynlib: dllName, importc: "PQfformat".}
proc pQftype*(res: PPGresult, field_num: Int32): Oid{.cdecl, dynlib: dllName, 
    importc: "PQftype".}
proc pQfsize*(res: PPGresult, field_num: Int32): Int32{.cdecl, dynlib: dllName, 
    importc: "PQfsize".}
proc pQfmod*(res: PPGresult, field_num: Int32): Int32{.cdecl, dynlib: dllName, 
    importc: "PQfmod".}
proc pQcmdStatus*(res: PPGresult): Cstring{.cdecl, dynlib: dllName, 
    importc: "PQcmdStatus".}
proc pQoidStatus*(res: PPGresult): Cstring{.cdecl, dynlib: dllName, 
    importc: "PQoidStatus".}
proc pQoidValue*(res: PPGresult): Oid{.cdecl, dynlib: dllName, 
                                       importc: "PQoidValue".}
proc pQcmdTuples*(res: PPGresult): Cstring{.cdecl, dynlib: dllName, 
    importc: "PQcmdTuples".}
proc pQgetvalue*(res: PPGresult, tup_num: Int32, field_num: Int32): Cstring{.
    cdecl, dynlib: dllName, importc: "PQgetvalue".}
proc pQgetlength*(res: PPGresult, tup_num: Int32, field_num: Int32): Int32{.
    cdecl, dynlib: dllName, importc: "PQgetlength".}
proc pQgetisnull*(res: PPGresult, tup_num: Int32, field_num: Int32): Int32{.
    cdecl, dynlib: dllName, importc: "PQgetisnull".}
proc pQclear*(res: PPGresult){.cdecl, dynlib: dllName, importc: "PQclear".}
proc pQfreemem*(p: Pointer){.cdecl, dynlib: dllName, importc: "PQfreemem".}
proc pQmakeEmptyPGresult*(conn: PPGconn, status: TExecStatusType): PPGresult{.
    cdecl, dynlib: dllName, importc: "PQmakeEmptyPGresult".}
proc pQescapeString*(till, `from`: Cstring, len: Int): Int{.cdecl, 
    dynlib: dllName, importc: "PQescapeString".}
proc pQescapeBytea*(bintext: Cstring, binlen: Int, bytealen: var Int): Cstring{.
    cdecl, dynlib: dllName, importc: "PQescapeBytea".}
proc pQunescapeBytea*(strtext: Cstring, retbuflen: var Int): Cstring{.cdecl, 
    dynlib: dllName, importc: "PQunescapeBytea".}
proc pQprint*(fout: TFile, res: PPGresult, ps: PPQprintOpt){.cdecl, 
    dynlib: dllName, importc: "PQprint".}
proc pQdisplayTuples*(res: PPGresult, fp: TFile, fillAlign: Int32, 
                      fieldSep: Cstring, printHeader: Int32, quiet: Int32){.
    cdecl, dynlib: dllName, importc: "PQdisplayTuples".}
proc pQprintTuples*(res: PPGresult, fout: TFile, printAttName: Int32, 
                    terseOutput: Int32, width: Int32){.cdecl, dynlib: dllName, 
    importc: "PQprintTuples".}
proc loOpen*(conn: PPGconn, lobjId: Oid, mode: Int32): Int32{.cdecl, 
    dynlib: dllName, importc: "lo_open".}
proc loClose*(conn: PPGconn, fd: Int32): Int32{.cdecl, dynlib: dllName, 
    importc: "lo_close".}
proc loRead*(conn: PPGconn, fd: Int32, buf: Cstring, length: Int): Int32{.
    cdecl, dynlib: dllName, importc: "lo_read".}
proc loWrite*(conn: PPGconn, fd: Int32, buf: Cstring, length: Int): Int32{.
    cdecl, dynlib: dllName, importc: "lo_write".}
proc loLseek*(conn: PPGconn, fd: Int32, offset: Int32, whence: Int32): Int32{.
    cdecl, dynlib: dllName, importc: "lo_lseek".}
proc loCreat*(conn: PPGconn, mode: Int32): Oid{.cdecl, dynlib: dllName, 
    importc: "lo_creat".}
proc loTell*(conn: PPGconn, fd: Int32): Int32{.cdecl, dynlib: dllName, 
    importc: "lo_tell".}
proc loUnlink*(conn: PPGconn, lobjId: Oid): Int32{.cdecl, dynlib: dllName, 
    importc: "lo_unlink".}
proc loImport*(conn: PPGconn, filename: Cstring): Oid{.cdecl, dynlib: dllName, 
    importc: "lo_import".}
proc loExport*(conn: PPGconn, lobjId: Oid, filename: Cstring): Int32{.cdecl, 
    dynlib: dllName, importc: "lo_export".}
proc pQmblen*(s: Cstring, encoding: Int32): Int32{.cdecl, dynlib: dllName, 
    importc: "PQmblen".}
proc pQenv2encoding*(): Int32{.cdecl, dynlib: dllName, importc: "PQenv2encoding".}
proc pQsetdb(M_PGHOST, M_PGPORT, M_PGOPT, M_PGTTY, M_DBNAME: cstring): ppgconn = 
  result = pQsetdbLogin(mPghost, mPgport, mPgopt, mPgtty, mDbname, "", "")
