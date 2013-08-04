#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

{.deadCodeElim: on.}
when defined(windows): 
  const 
    Lib = "sqlite3.dll"
elif defined(macosx): 
  const 
    Lib = "(libsqlite3(|.0).dylib|sqlite-3.6.13.dylib)"
else: 
  const 
    Lib = "libsqlite3.so(|.0)"
    
const 
  SqliteInteger* = 1
  SqliteFloat* = 2
  SqliteBlob* = 4
  SqliteNull* = 5
  SqliteText* = 3
  SqliteUtf8* = 1
  SqliteUtf16le* = 2
  SqliteUtf16be* = 3         # Use native byte order  
  SqliteUtf16* = 4           # sqlite3_create_function only  
  SqliteAny* = 5             #sqlite_exec return values
  SqliteOk* = 0
  SqliteError* = 1           # SQL error or missing database  
  SqliteInternal* = 2        # An internal logic error in SQLite  
  SqlitePerm* = 3            # Access permission denied  
  SqliteAbort* = 4           # Callback routine requested an abort  
  SqliteBusy* = 5            # The database file is locked  
  SqliteLocked* = 6          # A table in the database is locked  
  SqliteNomem* = 7           # A malloc() failed  
  SqliteReadonly* = 8        # Attempt to write a readonly database  
  SqliteInterrupt* = 9       # Operation terminated by sqlite3_interrupt() 
  SqliteIoerr* = 10          # Some kind of disk I/O error occurred  
  SqliteCorrupt* = 11        # The database disk image is malformed  
  SqliteNotfound* = 12       # (Internal Only) Table or record not found  
  SqliteFull* = 13           # Insertion failed because database is full  
  SqliteCantopen* = 14       # Unable to open the database file  
  SqliteProtocol* = 15       # Database lock protocol error  
  SqliteEmpty* = 16          # Database is empty  
  SqliteSchema* = 17         # The database schema changed  
  SqliteToobig* = 18         # Too much data for one row of a table  
  SqliteConstraint* = 19     # Abort due to contraint violation  
  SqliteMismatch* = 20       # Data type mismatch  
  SqliteMisuse* = 21         # Library used incorrectly  
  SqliteNolfs* = 22          # Uses OS features not supported on host  
  SqliteAuth* = 23           # Authorization denied  
  SqliteFormat* = 24         # Auxiliary database format error  
  SqliteRange* = 25          # 2nd parameter to sqlite3_bind out of range  
  SqliteNotadb* = 26         # File opened that is not a database file  
  SqliteRow* = 100           # sqlite3_step() has another row ready  
  SqliteDone* = 101          # sqlite3_step() has finished executing  
  SqliteCopy* = 0
  SqliteCreateIndex* = 1
  SqliteCreateTable* = 2
  SqliteCreateTempIndex* = 3
  SqliteCreateTempTable* = 4
  SqliteCreateTempTrigger* = 5
  SqliteCreateTempView* = 6
  SqliteCreateTrigger* = 7
  SqliteCreateView* = 8
  SqliteDelete* = 9
  SqliteDropIndex* = 10
  SqliteDropTable* = 11
  SqliteDropTempIndex* = 12
  SqliteDropTempTable* = 13
  SqliteDropTempTrigger* = 14
  SqliteDropTempView* = 15
  SqliteDropTrigger* = 16
  SqliteDropView* = 17
  SqliteInsert* = 18
  SqlitePragma* = 19
  SqliteRead* = 20
  SqliteSelect* = 21
  SqliteTransaction* = 22
  SqliteUpdate* = 23
  SqliteAttach* = 24
  SqliteDetach* = 25
  SqliteAlterTable* = 26
  SqliteReindex* = 27
  SqliteDeny* = 1
  SqliteIgnore* = 2          # Original from sqlite3.h: 
                              ##define SQLITE_STATIC      ((void(*)(void *))0)
                              ##define SQLITE_TRANSIENT   ((void(*)(void *))-1)

const 
  SqliteStatic* = nil
  SqliteTransient* = cast[pointer](- 1)

type 
  TSqlite3 {.pure, final.} = object 
  PSqlite3* = ptr TSqlite3
  PPSqlite3* = ptr PSqlite3
  TContext{.pure, final.} = object 
  Pcontext* = ptr TContext
  Tstmt{.pure, final.} = object 
  Pstmt* = ptr Tstmt
  Tvalue{.pure, final.} = object 
  Pvalue* = ptr Tvalue
  PPValue* = ptr Pvalue 
  
  Tcallback* = proc (para1: Pointer, para2: Int32, para3, 
                     para4: CstringArray): Int32{.cdecl.}
  TbindDestructorFunc* = proc (para1: Pointer){.cdecl.}
  TcreateFunctionStepFunc* = proc (para1: Pcontext, para2: Int32, 
                                      para3: PPValue){.cdecl.}
  TcreateFunctionFuncFunc* = proc (para1: Pcontext, para2: Int32, 
                                      para3: PPValue){.cdecl.}
  TcreateFunctionFinalFunc* = proc (para1: Pcontext){.cdecl.}
  TresultFunc* = proc (para1: Pointer){.cdecl.}
  TcreateCollationFunc* = proc (para1: Pointer, para2: Int32, para3: Pointer, 
                                  para4: Int32, para5: Pointer): Int32{.cdecl.}
  TcollationNeededFunc* = proc (para1: Pointer, para2: PSqlite3, eTextRep: Int32, 
                                  para4: Cstring){.cdecl.}

proc close*(para1: PSqlite3): Int32{.cdecl, dynlib: Lib, importc: "sqlite3_close".}
proc exec*(para1: PSqlite3, sql: Cstring, para3: Tcallback, para4: Pointer, 
           errmsg: var Cstring): Int32{.cdecl, dynlib: Lib, 
                                        importc: "sqlite3_exec".}
proc lastInsertRowid*(para1: PSqlite3): Int64{.cdecl, dynlib: Lib, 
    importc: "sqlite3_last_insert_rowid".}
proc changes*(para1: PSqlite3): Int32{.cdecl, dynlib: Lib, importc: "sqlite3_changes".}
proc totalChanges*(para1: PSqlite3): Int32{.cdecl, dynlib: Lib, 
                                      importc: "sqlite3_total_changes".}
proc interrupt*(para1: PSqlite3){.cdecl, dynlib: Lib, importc: "sqlite3_interrupt".}
proc complete*(sql: Cstring): Int32{.cdecl, dynlib: Lib, 
                                     importc: "sqlite3_complete".}
proc complete16*(sql: Pointer): Int32{.cdecl, dynlib: Lib, 
                                       importc: "sqlite3_complete16".}
proc busyHandler*(para1: PSqlite3, 
                   para2: proc (para1: Pointer, para2: Int32): Int32{.cdecl.}, 
                   para3: Pointer): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_busy_handler".}
proc busyTimeout*(para1: PSqlite3, ms: Int32): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_busy_timeout".}
proc getTable*(para1: PSqlite3, sql: Cstring, resultp: var CstringArray, 
                nrow, ncolumn: var Cint, errmsg: ptr Cstring): Int32{.cdecl, 
    dynlib: Lib, importc: "sqlite3_get_table".}
proc freeTable*(result: CstringArray){.cdecl, dynlib: Lib, 
                                        importc: "sqlite3_free_table".}
  # Todo: see how translate sqlite3_mprintf, sqlite3_vmprintf, sqlite3_snprintf
  # function sqlite3_mprintf(_para1:Pchar; args:array of const):Pchar;cdecl; external Sqlite3Lib name 'sqlite3_mprintf';
proc mprintf*(para1: Cstring): Cstring{.cdecl, varargs, dynlib: Lib, 
                                        importc: "sqlite3_mprintf".}
  #function sqlite3_vmprintf(_para1:Pchar; _para2:va_list):Pchar;cdecl; external Sqlite3Lib name 'sqlite3_vmprintf';
proc free*(z: Cstring){.cdecl, dynlib: Lib, importc: "sqlite3_free".}
  #function sqlite3_snprintf(_para1:longint; _para2:Pchar; _para3:Pchar; args:array of const):Pchar;cdecl; external Sqlite3Lib name 'sqlite3_snprintf';
proc snprintf*(para1: Int32, para2: Cstring, para3: Cstring): Cstring{.cdecl, 
    dynlib: Lib, varargs, importc: "sqlite3_snprintf".}
proc setAuthorizer*(para1: PSqlite3, xAuth: proc (para1: Pointer, para2: Int32, 
    para3: Cstring, para4: Cstring, para5: Cstring, para6: Cstring): Int32{.
    cdecl.}, pUserData: Pointer): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_set_authorizer".}
proc trace*(para1: PSqlite3, xTrace: proc (para1: Pointer, para2: Cstring){.cdecl.}, 
            para3: Pointer): Pointer{.cdecl, dynlib: Lib, 
                                      importc: "sqlite3_trace".}
proc progressHandler*(para1: PSqlite3, para2: Int32, 
                       para3: proc (para1: Pointer): Int32{.cdecl.}, 
                       para4: Pointer){.cdecl, dynlib: Lib, 
                                        importc: "sqlite3_progress_handler".}
proc commitHook*(para1: PSqlite3, para2: proc (para1: Pointer): Int32{.cdecl.}, 
                  para3: Pointer): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_commit_hook".}
proc open*(filename: Cstring, ppDb: var PSqlite3): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_open".}
proc open16*(filename: Pointer, ppDb: var PSqlite3): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_open16".}
proc errcode*(db: PSqlite3): Int32{.cdecl, dynlib: Lib, importc: "sqlite3_errcode".}
proc errmsg*(para1: PSqlite3): Cstring{.cdecl, dynlib: Lib, importc: "sqlite3_errmsg".}
proc errmsg16*(para1: PSqlite3): Pointer{.cdecl, dynlib: Lib, 
                                   importc: "sqlite3_errmsg16".}
proc prepare*(db: PSqlite3, zSql: Cstring, nBytes: Int32, ppStmt: var Pstmt, 
              pzTail: ptr Cstring): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_prepare".}
    
proc prepareV2*(db: PSqlite3, zSql: Cstring, nByte: Cint, ppStmt: var Pstmt,
                pzTail: ptr Cstring): Cint {.
                importc: "sqlite3_prepare_v2", cdecl, dynlib: Lib.}
    
proc prepare16*(db: PSqlite3, zSql: Pointer, nBytes: Int32, ppStmt: var Pstmt, 
                pzTail: var Pointer): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_prepare16".}
proc bindBlob*(para1: Pstmt, para2: Int32, para3: Pointer, n: Int32, 
                para5: TbindDestructorFunc): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_bind_blob".}
proc bindDouble*(para1: Pstmt, para2: Int32, para3: Float64): Int32{.cdecl, 
    dynlib: Lib, importc: "sqlite3_bind_double".}
proc bindInt*(para1: Pstmt, para2: Int32, para3: Int32): Int32{.cdecl, 
    dynlib: Lib, importc: "sqlite3_bind_int".}
proc bindInt64*(para1: Pstmt, para2: Int32, para3: Int64): Int32{.cdecl, 
    dynlib: Lib, importc: "sqlite3_bind_int64".}
proc bindNull*(para1: Pstmt, para2: Int32): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_bind_null".}
proc bindText*(para1: Pstmt, para2: Int32, para3: Cstring, n: Int32, 
                para5: TbindDestructorFunc): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_bind_text".}
proc bindText16*(para1: Pstmt, para2: Int32, para3: Pointer, para4: Int32, 
                  para5: TbindDestructorFunc): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_bind_text16".}
  #function sqlite3_bind_value(_para1:Psqlite3_stmt; _para2:longint; _para3:Psqlite3_value):longint;cdecl; external Sqlite3Lib name 'sqlite3_bind_value';
  #These overloaded functions were introduced to allow the use of SQLITE_STATIC and SQLITE_TRANSIENT
  #It's the c world man ;-)
proc bindBlob*(para1: Pstmt, para2: Int32, para3: Pointer, n: Int32, 
                para5: Int32): Int32{.cdecl, dynlib: Lib, 
                                      importc: "sqlite3_bind_blob".}
proc bindText*(para1: Pstmt, para2: Int32, para3: Cstring, n: Int32, 
                para5: Int32): Int32{.cdecl, dynlib: Lib, 
                                      importc: "sqlite3_bind_text".}
proc bindText16*(para1: Pstmt, para2: Int32, para3: Pointer, para4: Int32, 
                  para5: Int32): Int32{.cdecl, dynlib: Lib, 
                                        importc: "sqlite3_bind_text16".}
proc bindParameterCount*(para1: Pstmt): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_bind_parameter_count".}
proc bindParameterName*(para1: Pstmt, para2: Int32): Cstring{.cdecl, 
    dynlib: Lib, importc: "sqlite3_bind_parameter_name".}
proc bindParameterIndex*(para1: Pstmt, zName: Cstring): Int32{.cdecl, 
    dynlib: Lib, importc: "sqlite3_bind_parameter_index".}
  #function sqlite3_clear_bindings(_para1:Psqlite3_stmt):longint;cdecl; external Sqlite3Lib name 'sqlite3_clear_bindings';
proc columnCount*(pStmt: Pstmt): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_count".}
proc columnName*(para1: Pstmt, para2: Int32): Cstring{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_name".}
proc columnName16*(para1: Pstmt, para2: Int32): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_name16".}
proc columnDecltype*(para1: Pstmt, i: Int32): Cstring{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_decltype".}
proc columnDecltype16*(para1: Pstmt, para2: Int32): Pointer{.cdecl, 
    dynlib: Lib, importc: "sqlite3_column_decltype16".}
proc step*(para1: Pstmt): Int32{.cdecl, dynlib: Lib, importc: "sqlite3_step".}
proc dataCount*(pStmt: Pstmt): Int32{.cdecl, dynlib: Lib, 
                                       importc: "sqlite3_data_count".}
proc columnBlob*(para1: Pstmt, iCol: Int32): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_blob".}
proc columnBytes*(para1: Pstmt, iCol: Int32): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_bytes".}
proc columnBytes16*(para1: Pstmt, iCol: Int32): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_bytes16".}
proc columnDouble*(para1: Pstmt, iCol: Int32): Float64{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_double".}
proc columnInt*(para1: Pstmt, iCol: Int32): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_int".}
proc columnInt64*(para1: Pstmt, iCol: Int32): Int64{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_int64".}
proc columnText*(para1: Pstmt, iCol: Int32): Cstring{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_text".}
proc columnText16*(para1: Pstmt, iCol: Int32): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_text16".}
proc columnType*(para1: Pstmt, iCol: Int32): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_column_type".}
proc finalize*(pStmt: Pstmt): Int32{.cdecl, dynlib: Lib, 
                                     importc: "sqlite3_finalize".}
proc reset*(pStmt: Pstmt): Int32{.cdecl, dynlib: Lib, importc: "sqlite3_reset".}
proc createFunction*(para1: PSqlite3, zFunctionName: Cstring, nArg: Int32, 
                      eTextRep: Int32, para5: Pointer, 
                      xFunc: TcreateFunctionFuncFunc, 
                      xStep: TcreateFunctionStepFunc, 
                      xFinal: TcreateFunctionFinalFunc): Int32{.cdecl, 
    dynlib: Lib, importc: "sqlite3_create_function".}
proc createFunction16*(para1: PSqlite3, zFunctionName: Pointer, nArg: Int32, 
                        eTextRep: Int32, para5: Pointer, 
                        xFunc: TcreateFunctionFuncFunc, 
                        xStep: TcreateFunctionStepFunc, 
                        xFinal: TcreateFunctionFinalFunc): Int32{.cdecl, 
    dynlib: Lib, importc: "sqlite3_create_function16".}
proc aggregateCount*(para1: Pcontext): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_aggregate_count".}
proc valueBlob*(para1: Pvalue): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_blob".}
proc valueBytes*(para1: Pvalue): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_bytes".}
proc valueBytes16*(para1: Pvalue): Int32{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_bytes16".}
proc valueDouble*(para1: Pvalue): Float64{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_double".}
proc valueInt*(para1: Pvalue): Int32{.cdecl, dynlib: Lib, 
                                       importc: "sqlite3_value_int".}
proc valueInt64*(para1: Pvalue): Int64{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_int64".}
proc valueText*(para1: Pvalue): Cstring{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_text".}
proc valueText16*(para1: Pvalue): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_text16".}
proc valueText16le*(para1: Pvalue): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_text16le".}
proc valueText16be*(para1: Pvalue): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_value_text16be".}
proc valueType*(para1: Pvalue): Int32{.cdecl, dynlib: Lib, 
                                        importc: "sqlite3_value_type".}
proc aggregateContext*(para1: Pcontext, nBytes: Int32): Pointer{.cdecl, 
    dynlib: Lib, importc: "sqlite3_aggregate_context".}
proc userData*(para1: Pcontext): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_user_data".}
proc getAuxdata*(para1: Pcontext, para2: Int32): Pointer{.cdecl, dynlib: Lib, 
    importc: "sqlite3_get_auxdata".}
proc setAuxdata*(para1: Pcontext, para2: Int32, para3: Pointer, 
                  para4: proc (para1: Pointer){.cdecl.}){.cdecl, dynlib: Lib, 
    importc: "sqlite3_set_auxdata".}
proc resultBlob*(para1: Pcontext, para2: Pointer, para3: Int32, 
                  para4: TresultFunc){.cdecl, dynlib: Lib, 
                                        importc: "sqlite3_result_blob".}
proc resultDouble*(para1: Pcontext, para2: Float64){.cdecl, dynlib: Lib, 
    importc: "sqlite3_result_double".}
proc resultError*(para1: Pcontext, para2: Cstring, para3: Int32){.cdecl, 
    dynlib: Lib, importc: "sqlite3_result_error".}
proc resultError16*(para1: Pcontext, para2: Pointer, para3: Int32){.cdecl, 
    dynlib: Lib, importc: "sqlite3_result_error16".}
proc resultInt*(para1: Pcontext, para2: Int32){.cdecl, dynlib: Lib, 
    importc: "sqlite3_result_int".}
proc resultInt64*(para1: Pcontext, para2: Int64){.cdecl, dynlib: Lib, 
    importc: "sqlite3_result_int64".}
proc resultNull*(para1: Pcontext){.cdecl, dynlib: Lib, 
                                    importc: "sqlite3_result_null".}
proc resultText*(para1: Pcontext, para2: Cstring, para3: Int32, 
                  para4: TresultFunc){.cdecl, dynlib: Lib, 
                                        importc: "sqlite3_result_text".}
proc resultText16*(para1: Pcontext, para2: Pointer, para3: Int32, 
                    para4: TresultFunc){.cdecl, dynlib: Lib, 
    importc: "sqlite3_result_text16".}
proc resultText16le*(para1: Pcontext, para2: Pointer, para3: Int32, 
                      para4: TresultFunc){.cdecl, dynlib: Lib, 
    importc: "sqlite3_result_text16le".}
proc resultText16be*(para1: Pcontext, para2: Pointer, para3: Int32, 
                      para4: TresultFunc){.cdecl, dynlib: Lib, 
    importc: "sqlite3_result_text16be".}
proc resultValue*(para1: Pcontext, para2: Pvalue){.cdecl, dynlib: Lib, 
    importc: "sqlite3_result_value".}
proc createCollation*(para1: PSqlite3, zName: Cstring, eTextRep: Int32, 
                       para4: Pointer, xCompare: TcreateCollationFunc): Int32{.
    cdecl, dynlib: Lib, importc: "sqlite3_create_collation".}
proc createCollation16*(para1: PSqlite3, zName: Cstring, eTextRep: Int32, 
                         para4: Pointer, xCompare: TcreateCollationFunc): Int32{.
    cdecl, dynlib: Lib, importc: "sqlite3_create_collation16".}
proc collationNeeded*(para1: PSqlite3, para2: Pointer, para3: TcollationNeededFunc): Int32{.
    cdecl, dynlib: Lib, importc: "sqlite3_collation_needed".}
proc collationNeeded16*(para1: PSqlite3, para2: Pointer, para3: TcollationNeededFunc): Int32{.
    cdecl, dynlib: Lib, importc: "sqlite3_collation_needed16".}
proc libversion*(): Cstring{.cdecl, dynlib: Lib, importc: "sqlite3_libversion".}
  #Alias for allowing better code portability (win32 is not working with external variables) 
proc version*(): Cstring{.cdecl, dynlib: Lib, importc: "sqlite3_libversion".}
  # Not published functions
proc libversionNumber*(): Int32{.cdecl, dynlib: Lib, 
                                  importc: "sqlite3_libversion_number".}
  #function sqlite3_key(db:Psqlite3; pKey:pointer; nKey:longint):longint;cdecl; external Sqlite3Lib name 'sqlite3_key';
  #function sqlite3_rekey(db:Psqlite3; pKey:pointer; nKey:longint):longint;cdecl; external Sqlite3Lib name 'sqlite3_rekey';
  #function sqlite3_sleep(_para1:longint):longint;cdecl; external Sqlite3Lib name 'sqlite3_sleep';
  #function sqlite3_expired(_para1:Psqlite3_stmt):longint;cdecl; external Sqlite3Lib name 'sqlite3_expired';
  #function sqlite3_global_recover:longint;cdecl; external Sqlite3Lib name 'sqlite3_global_recover';
# implementation
