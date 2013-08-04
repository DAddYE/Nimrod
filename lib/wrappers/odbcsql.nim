
{.deadCodeElim: on.}

when not defined(ODBCVER):
  const
    Odbcver = 0x0351 ## define ODBC version 3.51 by default

when defined(windows):
  {.push callconv: stdcall.}
  const odbclib = "odbc32.dll"
else:
  {.push callconv: cdecl.}
  const odbclib = "libodbc.so"

# DATA TYPES CORRESPONDENCE
#   BDE fields  ODBC types
#   ----------  ------------------
#   ftBlob      SQL_BINARY
#   ftBoolean   SQL_BIT
#   ftDate      SQL_TYPE_DATE
#   ftTime      SQL_TYPE_TIME
#   ftDateTime  SQL_TYPE_TIMESTAMP
#   ftInteger   SQL_INTEGER
#   ftSmallint  SQL_SMALLINT
#   ftFloat     SQL_DOUBLE
#   ftString    SQL_CHAR
#   ftMemo      SQL_BINARY // SQL_VARCHAR
#

type 
  TSqlChar* = Char
  TSqlSmallInt* = Int16
  TSqlUSmallInt* = Int16
  TSqlHandle* = Pointer
  TSqlHEnv* = TSqlHandle
  TSqlHDBC* = TSqlHandle
  TSqlHStmt* = TSqlHandle
  TSqlHDesc* = TSqlHandle
  TSqlInteger* = Int
  TSqlUInteger* = Int
  TSqlPointer* = Pointer
  TSqlReal* = Cfloat
  TSqlDouble* = Cdouble
  TSqlFloat* = Cdouble
  TSqlHWND* = Pointer
  Psqlchar* = Cstring
  Psqlinteger* = ptr TSqlInteger
  Psqluinteger* = ptr TSqlUInteger
  Psqlsmallint* = ptr TSqlSmallInt
  Psqlusmallint* = ptr TSqlUSmallInt
  Psqlreal* = ptr TSqlReal
  Psqldouble* = ptr TSqlDouble
  Psqlfloat* = ptr TSqlFloat
  Psqlhandle* = ptr TSqlHandle

const                         # SQL data type codes 
  SqlUnknownType* = 0
  SqlLongvarchar* = (- 1)
  SqlBinary* = (- 2)
  SqlVarbinary* = (- 3)
  SqlLongvarbinary* = (- 4)
  SqlBigint* = (- 5)
  SqlTinyint* = (- 6)
  SqlBit* = (- 7)
  SqlWchar* = (- 8)
  SqlWvarchar* = (- 9)
  SqlWlongvarchar* = (- 10)
  SqlChar* = 1
  SqlNumeric* = 2
  SqlDecimal* = 3
  SqlInteger* = 4
  SqlSmallint* = 5
  SqlFloat* = 6
  SqlReal* = 7
  SqlDouble* = 8
  SqlDatetime* = 9
  SqlVarchar* = 12
  SqlTypeDate* = 91
  SqlTypeTime* = 92
  SqlTypeTimestamp* = 93
  SqlDate* = 9
  SqlTime* = 10
  SqlTimestamp* = 11
  SqlInterval* = 10
  SqlGuid* = - 11            # interval codes

when ODBCVER >= 0x0300: 
  const 
    SqlCodeYear* = 1
    SqlCodeMonth* = 2
    SqlCodeDay* = 3
    SqlCodeHour* = 4
    SqlCodeMinute* = 5
    SqlCodeSecond* = 6
    SqlCodeYearToMonth* = 7
    SqlCodeDayToHour* = 8
    SqlCodeDayToMinute* = 9
    SqlCodeDayToSecond* = 10
    SqlCodeHourToMinute* = 11
    SqlCodeHourToSecond* = 12
    SqlCodeMinuteToSecond* = 13
    SqlIntervalYear* = 100 + SQL_CODE_YEAR
    SqlIntervalMonth* = 100 + SQL_CODE_MONTH
    SqlIntervalDay* = 100 + SQL_CODE_DAY
    SqlIntervalHour* = 100 + SQL_CODE_HOUR
    SqlIntervalMinute* = 100 + SQL_CODE_MINUTE
    SqlIntervalSecond* = 100 + SQL_CODE_SECOND
    SqlIntervalYearToMonth* = 100 + SQL_CODE_YEAR_TO_MONTH
    SqlIntervalDayToHour* = 100 + SQL_CODE_DAY_TO_HOUR
    SqlIntervalDayToMinute* = 100 + SQL_CODE_DAY_TO_MINUTE
    SqlIntervalDayToSecond* = 100 + SQL_CODE_DAY_TO_SECOND
    SqlIntervalHourToMinute* = 100 + SQL_CODE_HOUR_TO_MINUTE
    SqlIntervalHourToSecond* = 100 + SQL_CODE_HOUR_TO_SECOND
    SqlIntervalMinuteToSecond* = 100 + SQL_CODE_MINUTE_TO_SECOND
else: 
  const 
    SQL_INTERVAL_YEAR* = - 80
    SQL_INTERVAL_MONTH* = - 81
    SQL_INTERVAL_YEAR_TO_MONTH* = - 82
    SQL_INTERVAL_DAY* = - 83
    SQL_INTERVAL_HOUR* = - 84
    SQL_INTERVAL_MINUTE* = - 85
    SQL_INTERVAL_SECOND* = - 86
    SQL_INTERVAL_DAY_TO_HOUR* = - 87
    SQL_INTERVAL_DAY_TO_MINUTE* = - 88
    SQL_INTERVAL_DAY_TO_SECOND* = - 89
    SQL_INTERVAL_HOUR_TO_MINUTE* = - 90
    SQL_INTERVAL_HOUR_TO_SECOND* = - 91
    SQL_INTERVAL_MINUTE_TO_SECOND* = - 92


when ODBCVER < 0x0300: 
  const 
    SQL_UNICODE* = - 95
    SQL_UNICODE_VARCHAR* = - 96
    SQL_UNICODE_LONGVARCHAR* = - 97
    SQL_UNICODE_CHAR* = SQL_UNICODE
else: 
  # The previous definitions for SQL_UNICODE_ are historical and obsolete 
  const 
    SqlUnicode* = SQL_WCHAR
    SqlUnicodeVarchar* = SQL_WVARCHAR
    SqlUnicodeLongvarchar* = SQL_WLONGVARCHAR
    SqlUnicodeChar* = SQL_WCHAR
const                         # C datatype to SQL datatype mapping 
  SqlCChar* = SQL_CHAR
  SqlCLong* = SQL_INTEGER
  SqlCShort* = SQL_SMALLINT
  SqlCFloat* = SQL_REAL
  SqlCDouble* = SQL_DOUBLE
  SqlCNumeric* = SQL_NUMERIC
  SqlCDefault* = 99
  SqlSignedOffset* = - 20
  SqlUnsignedOffset* = - 22
  SqlCDate* = SQL_DATE
  SqlCTime* = SQL_TIME
  SqlCTimestamp* = SQL_TIMESTAMP
  SqlCTypeDate* = SQL_TYPE_DATE
  SqlCTypeTime* = SQL_TYPE_TIME
  SqlCTypeTimestamp* = SQL_TYPE_TIMESTAMP
  SqlCIntervalYear* = SQL_INTERVAL_YEAR
  SqlCIntervalMonth* = SQL_INTERVAL_MONTH
  SqlCIntervalDay* = SQL_INTERVAL_DAY
  SqlCIntervalHour* = SQL_INTERVAL_HOUR
  SqlCIntervalMinute* = SQL_INTERVAL_MINUTE
  SqlCIntervalSecond* = SQL_INTERVAL_SECOND
  SqlCIntervalYearToMonth* = SQL_INTERVAL_YEAR_TO_MONTH
  SqlCIntervalDayToHour* = SQL_INTERVAL_DAY_TO_HOUR
  SqlCIntervalDayToMinute* = SQL_INTERVAL_DAY_TO_MINUTE
  SqlCIntervalDayToSecond* = SQL_INTERVAL_DAY_TO_SECOND
  SqlCIntervalHourToMinute* = SQL_INTERVAL_HOUR_TO_MINUTE
  SqlCIntervalHourToSecond* = SQL_INTERVAL_HOUR_TO_SECOND
  SqlCIntervalMinuteToSecond* = SQL_INTERVAL_MINUTE_TO_SECOND
  SqlCBinary* = SQL_BINARY
  SqlCBit* = SQL_BIT
  SqlCSbigint* = SQL_BIGINT + SQL_SIGNED_OFFSET # SIGNED BIGINT
  SqlCUbigint* = SQL_BIGINT + SQL_UNSIGNED_OFFSET # UNSIGNED BIGINT
  SqlCTinyint* = SQL_TINYINT
  SqlCSlong* = SQL_C_LONG + SQL_SIGNED_OFFSET # SIGNED INTEGER
  SqlCSshort* = SQL_C_SHORT + SQL_SIGNED_OFFSET # SIGNED SMALLINT
  SqlCStinyint* = SQL_TINYINT + SQL_SIGNED_OFFSET # SIGNED TINYINT
  SqlCUlong* = SQL_C_LONG + SQL_UNSIGNED_OFFSET # UNSIGNED INTEGER
  SqlCUshort* = SQL_C_SHORT + SQL_UNSIGNED_OFFSET # UNSIGNED SMALLINT
  SqlCUtinyint* = SQL_TINYINT + SQL_UNSIGNED_OFFSET # UNSIGNED TINYINT
  SqlCBookmark* = SQL_C_ULONG # BOOKMARK
  SqlCGuid* = SQL_GUID
  SqlTypeNull* = 0

when ODBCVER < 0x0300: 
  const 
    SQL_TYPE_MIN* = SQL_BIT
    SQL_TYPE_MAX* = SQL_VARCHAR

const 
  SqlCVarbookmark* = SQL_C_BINARY
  SqlApiSqldescribeparam* = 58
  SqlNoTotal* = - 4

type 
  SqlDateStruct* {.final, pure.} = object 
    Year*: TSqlSmallInt
    Month*: TSqlUSmallInt
    Day*: TSqlUSmallInt

  PsqlDateStruct* = ptr SqlDateStruct
  SqlTimeStruct* {.final, pure.} = object 
    Hour*: TSqlUSmallInt
    Minute*: TSqlUSmallInt
    Second*: TSqlUSmallInt

  PsqlTimeStruct* = ptr SqlTimeStruct
  SqlTimestampStruct* {.final, pure.} = object 
    Year*: TSqlUSmallInt
    Month*: TSqlUSmallInt
    Day*: TSqlUSmallInt
    Hour*: TSqlUSmallInt
    Minute*: TSqlUSmallInt
    Second*: TSqlUSmallInt
    Fraction*: TSqlUInteger

  PsqlTimestampStruct* = ptr SqlTimestampStruct

const 
  SqlNameLen* = 128
  SqlOvOdbc3* = 3
  SqlOvOdbc2* = 2
  SqlAttrOdbcVersion* = 200 # Options for SQLDriverConnect 
  SqlDriverNoprompt* = 0
  SqlDriverComplete* = 1
  SqlDriverPrompt* = 2
  SqlDriverCompleteRequired* = 3 
  SqlIsPointer* = (- 4)  # whether an attribute is a pointer or not 
  SqlIsUinteger* = (- 5)
  SqlIsInteger* = (- 6)
  SqlIsUsmallint* = (- 7)
  SqlIsSmallint* = (- 8)    # SQLExtendedFetch "fFetchType" values 
  SqlFetchBookmark* = 8
  SqlScrollOptions* = 44    # SQL_USE_BOOKMARKS options 
  SqlUbOff* = 0
  SqlUbOn* = 1
  SqlUbDefault* = SQL_UB_OFF
  SqlUbFixed* = SQL_UB_ON
  SqlUbVariable* = 2        # SQL_SCROLL_OPTIONS masks 
  SqlSoForwardOnly* = 0x00000001
  SqlSoKeysetDriven* = 0x00000002
  SqlSoDynamic* = 0x00000004
  SqlSoMixed* = 0x00000008
  SqlSoStatic* = 0x00000010
  SqlBookmarkPersistence* = 82
  SqlStaticSensitivity* = 83 # SQL_BOOKMARK_PERSISTENCE values 
  SqlBpClose* = 0x00000001
  SqlBpDelete* = 0x00000002
  SqlBpDrop* = 0x00000004
  SqlBpTransaction* = 0x00000008
  SqlBpUpdate* = 0x00000010
  SqlBpOtherHstmt* = 0x00000020
  SqlBpScroll* = 0x00000040
  SqlDynamicCursorAttributes1* = 144
  SqlDynamicCursorAttributes2* = 145
  SqlForwardOnlyCursorAttributes1* = 146
  SqlForwardOnlyCursorAttributes2* = 147
  SqlIndexKeywords* = 148
  SqlInfoSchemaViews* = 149
  SqlKeysetCursorAttributes1* = 150
  SqlKeysetCursorAttributes2* = 151
  SqlStaticCursorAttributes1* = 167
  SqlStaticCursorAttributes2* = 168 # supported SQLFetchScroll FetchOrientation's 
  SqlCa1Next* = 1
  SqlCa1Absolute* = 2
  SqlCa1Relative* = 4
  SqlCa1Bookmark* = 8       # supported SQLSetPos LockType's 
  SqlCa1LockNoChange* = 0x00000040
  SqlCa1LockExclusive* = 0x00000080
  SqlCa1LockUnlock* = 0x00000100 # supported SQLSetPos Operations 
  SqlCa1PosPosition* = 0x00000200
  SqlCa1PosUpdate* = 0x00000400
  SqlCa1PosDelete* = 0x00000800
  SqlCa1PosRefresh* = 0x00001000 # positioned updates and deletes 
  SqlCa1PositionedUpdate* = 0x00002000
  SqlCa1PositionedDelete* = 0x00004000
  SqlCa1SelectForUpdate* = 0x00008000 # supported SQLBulkOperations operations 
  SqlCa1BulkAdd* = 0x00010000
  SqlCa1BulkUpdateByBookmark* = 0x00020000
  SqlCa1BulkDeleteByBookmark* = 0x00040000
  SqlCa1BulkFetchByBookmark* = 0x00080000 # supported values for SQL_ATTR_SCROLL_CONCURRENCY 
  SqlCa2ReadOnlyConcurrency* = 1
  SqlCa2LockConcurrency* = 2
  SqlCa2OptRowverConcurrency* = 4
  SqlCa2OptValuesConcurrency* = 8 # sensitivity of the cursor to its own inserts, deletes, and updates 
  SqlCa2SensitivityAdditions* = 0x00000010
  SqlCa2SensitivityDeletions* = 0x00000020
  SqlCa2SensitivityUpdates* = 0x00000040 #  semantics of SQL_ATTR_MAX_ROWS 
  SqlCa2MaxRowsSelect* = 0x00000080
  SqlCa2MaxRowsInsert* = 0x00000100
  SqlCa2MaxRowsDelete* = 0x00000200
  SqlCa2MaxRowsUpdate* = 0x00000400
  SqlCa2MaxRowsCatalog* = 0x00000800
  SqlCa2MaxRowsAffectsAll* = (SQL_CA2_MAX_ROWS_SELECT or
      SQL_CA2_MAX_ROWS_INSERT or SQL_CA2_MAX_ROWS_DELETE or
      SQL_CA2_MAX_ROWS_UPDATE or SQL_CA2_MAX_ROWS_CATALOG) # semantics of 
                                                           # SQL_DIAG_CURSOR_ROW_COUNT 
  SqlCa2CrcExact* = 0x00001000
  SqlCa2CrcApproximate* = 0x00002000 #  the kinds of positioned statements that can be simulated 
  SqlCa2SimulateNonUnique* = 0x00004000
  SqlCa2SimulateTryUnique* = 0x00008000
  SqlCa2SimulateUnique* = 0x00010000 #  Operations in SQLBulkOperations 
  SqlAdd* = 4
  SqlSetposMaxOptionValue* = SQL_ADD
  SqlUpdateByBookmark* = 5
  SqlDeleteByBookmark* = 6
  SqlFetchByBookmark* = 7  # Operations in SQLSetPos 
  SqlPosition* = 0
  SqlRefresh* = 1
  SqlUpdate* = 2
  SqlDelete* = 3             # Lock options in SQLSetPos 
  SqlLockNoChange* = 0
  SqlLockExclusive* = 1
  SqlLockUnlock* = 2        # SQLExtendedFetch "rgfRowStatus" element values 
  SqlRowSuccess* = 0
  SqlRowDeleted* = 1
  SqlRowUpdated* = 2
  SqlRowNorow* = 3
  SqlRowAdded* = 4
  SqlRowError* = 5
  SqlRowSuccessWithInfo* = 6
  SqlRowProceed* = 0
  SqlRowIgnore* = 1
  SqlMaxDsnLength* = 32    # maximum data source name size 
  SqlMaxOptionStringLength* = 256
  SqlOdbcCursors* = 110
  SqlAttrOdbcCursors* = SQL_ODBC_CURSORS # SQL_ODBC_CURSORS options 
  SqlCurUseIfNeeded* = 0
  SqlCurUseOdbc* = 1
  SqlCurUseDriver* = 2
  SqlCurDefault* = SQL_CUR_USE_DRIVER
  SqlParamTypeUnknown* = 0
  SqlParamInput* = 1
  SqlParamInputOutput* = 2
  SqlResultCol* = 3
  SqlParamOutput* = 4
  SqlReturnValue* = 5       # special length/indicator values 
  SqlNullData* = (- 1)
  SqlDataAtExec* = (- 2)
  SqlSuccess* = 0
  SqlSuccessWithInfo* = 1
  SqlNoData* = 100
  SqlError* = (- 1)
  SqlInvalidHandle* = (- 2)
  SqlStillExecuting* = 2
  SqlNeedData* = 99         # flags for null-terminated string 
  SqlNts* = (- 3)            # maximum message length 
  SqlMaxMessageLength* = 512 # date/time length constants 
  SqlDateLen* = 10
  SqlTimeLen* = 8           # add P+1 if precision is nonzero 
  SqlTimestampLen* = 19     # add P+1 if precision is nonzero 
                              # handle type identifiers 
  SqlHandleEnv* = 1
  SqlHandleDbc* = 2
  SqlHandleStmt* = 3
  SqlHandleDesc* = 4        # environment attribute 
  SqlAttrOutputNts* = 10001 # connection attributes 
  SqlAttrAutoIpd* = 10001
  SqlAttrMetadataId* = 10014 # statement attributes 
  SqlAttrAppRowDesc* = 10010
  SqlAttrAppParamDesc* = 10011
  SqlAttrImpRowDesc* = 10012
  SqlAttrImpParamDesc* = 10013
  SqlAttrCursorScrollable* = (- 1)
  SqlAttrCursorSensitivity* = (- 2)
  SqlQueryTimeout* = 0
  SqlMaxRows* = 1
  SqlNoscan* = 2
  SqlMaxLength* = 3
  SqlAsyncEnable* = 4       # same as SQL_ATTR_ASYNC_ENABLE */
  SqlBindType* = 5
  SqlCursorType* = 6
  SqlConcurrency* = 7
  SqlKeysetSize* = 8
  SqlRowsetSize* = 9
  SqlSimulateCursor* = 10
  SqlRetrieveData* = 11
  SqlUseBookmarks* = 12
  SqlGetBookmark* = 13      #      GetStmtOption Only */
  SqlRowNumber* = 14        #      GetStmtOption Only */
  SqlAttrCursorType* = SQL_CURSOR_TYPE
  SqlAttrConcurrency* = SQL_CONCURRENCY
  SqlAttrFetchBookmarkPtr* = 16
  SqlAttrRowStatusPtr* = 25
  SqlAttrRowsFetchedPtr* = 26
  SqlAutocommit* = 102
  SqlAttrAutocommit* = SQL_AUTOCOMMIT
  SqlAttrRowNumber* = SQL_ROW_NUMBER
  SqlTxnIsolation* = 108
  SqlAttrTxnIsolation* = SQL_TXN_ISOLATION
  SqlAttrMaxRows* = SQL_MAX_ROWS
  SqlAttrUseBookmarks* = SQL_USE_BOOKMARKS #* connection attributes */
  SqlAccessMode* = 101      #  SQL_AUTOCOMMIT              =102;
  SqlLoginTimeout* = 103
  SqlOptTrace* = 104
  SqlOptTracefile* = 105
  SqlTranslateDll* = 106
  SqlTranslateOption* = 107 #  SQL_TXN_ISOLATION           =108;
  SqlCurrentQualifier* = 109 #  SQL_ODBC_CURSORS            =110;
  SqlQuietMode* = 111
  SqlPacketSize* = 112      #* connection attributes with new names */
  SqlAttrAccessMode* = SQL_ACCESS_MODE #  SQL_ATTR_AUTOCOMMIT                       =SQL_AUTOCOMMIT;
  SqlAttrConnectionDead* = 1209 #* GetConnectAttr only */
  SqlAttrConnectionTimeout* = 113
  SqlAttrCurrentCatalog* = SQL_CURRENT_QUALIFIER
  SqlAttrDisconnectBehavior* = 114
  SqlAttrEnlistInDtc* = 1207
  SqlAttrEnlistInXa* = 1208
  SqlAttrLoginTimeout* = SQL_LOGIN_TIMEOUT #  SQL_ATTR_ODBC_CURSORS             =SQL_ODBC_CURSORS;
  SqlAttrPacketSize* = SQL_PACKET_SIZE
  SqlAttrQuietMode* = SQL_QUIET_MODE
  SqlAttrTrace* = SQL_OPT_TRACE
  SqlAttrTracefile* = SQL_OPT_TRACEFILE
  SqlAttrTranslateLib* = SQL_TRANSLATE_DLL
  SqlAttrTranslateOption* = SQL_TRANSLATE_OPTION #  SQL_ATTR_TXN_ISOLATION                  =SQL_TXN_ISOLATION;
                                                    #* SQL_ACCESS_MODE options */
  SqlModeReadWrite* = 0
  SqlModeReadOnly* = 1
  SqlModeDefault* = SQL_MODE_READ_WRITE #* SQL_AUTOCOMMIT options */
  SqlAutocommitOff* = 0
  SqlAutocommitOn* = 1
  SqlAutocommitDefault* = SQL_AUTOCOMMIT_ON # SQL_ATTR_CURSOR_SCROLLABLE values 
  SqlNonscrollable* = 0
  SqlScrollable* = 1         # SQL_CURSOR_TYPE options 
  SqlCursorForwardOnly* = 0
  SqlCursorKeysetDriven* = 1
  SqlCursorDynamic* = 2
  SqlCursorStatic* = 3
  SqlCursorTypeDefault* = SQL_CURSOR_FORWARD_ONLY # Default value 
                                                     # SQL_CONCURRENCY options 
  SqlConcurReadOnly* = 1
  SqlConcurLock* = 2
  SqlConcurRowver* = 3
  SqlConcurValues* = 4
  SqlConcurDefault* = SQL_CONCUR_READ_ONLY # Default value 
                                             # identifiers of fields in the SQL descriptor 
  SqlDescCount* = 1001
  SqlDescType* = 1002
  SqlDescLength* = 1003
  SqlDescOctetLengthPtr* = 1004
  SqlDescPrecision* = 1005
  SqlDescScale* = 1006
  SqlDescDatetimeIntervalCode* = 1007
  SqlDescNullable* = 1008
  SqlDescIndicatorPtr* = 1009
  SqlDescDataPtr* = 1010
  SqlDescName* = 1011
  SqlDescUnnamed* = 1012
  SqlDescOctetLength* = 1013
  SqlDescAllocType* = 1099 # identifiers of fields in the diagnostics area 
  SqlDiagReturncode* = 1
  SqlDiagNumber* = 2
  SqlDiagRowCount* = 3
  SqlDiagSqlstate* = 4
  SqlDiagNative* = 5
  SqlDiagMessageText* = 6
  SqlDiagDynamicFunction* = 7
  SqlDiagClassOrigin* = 8
  SqlDiagSubclassOrigin* = 9
  SqlDiagConnectionName* = 10
  SqlDiagServerName* = 11
  SqlDiagDynamicFunctionCode* = 12 # dynamic function codes 
  SqlDiagAlterTable* = 4
  SqlDiagCreateIndex* = (- 1)
  SqlDiagCreateTable* = 77
  SqlDiagCreateView* = 84
  SqlDiagDeleteWhere* = 19
  SqlDiagDropIndex* = (- 2)
  SqlDiagDropTable* = 32
  SqlDiagDropView* = 36
  SqlDiagDynamicDeleteCursor* = 38
  SqlDiagDynamicUpdateCursor* = 81
  SqlDiagGrant* = 48
  SqlDiagInsert* = 50
  SqlDiagRevoke* = 59
  SqlDiagSelectCursor* = 85
  SqlDiagUnknownStatement* = 0
  SqlDiagUpdateWhere* = 82 # Statement attribute values for cursor sensitivity 
  SqlUnspecified* = 0
  SqlInsensitive* = 1
  SqlSensitive* = 2          # GetTypeInfo() request for all data types 
  SqlAllTypes* = 0          # Default conversion code for SQLBindCol(), SQLBindParam() and SQLGetData() 
  SqlDefault* = 99 # SQLGetData() code indicating that the application row descriptor
                    #    specifies the data type 
  SqlArdType* = (- 99)      # SQL date/time type subcodes 
  SqlCodeDate* = 1
  SqlCodeTime* = 2
  SqlCodeTimestamp* = 3     # CLI option values 
  SqlFalse* = 0
  SqlTrue* = 1               # values of NULLABLE field in descriptor 
  SqlNoNulls* = 0
  SqlNullable* = 1 # Value returned by SQLGetTypeInfo() to denote that it is
                    # not known whether or not a data type supports null values. 
  SqlNullableUnknown* = 2 
  SqlClose* = 0
  SqlDrop* = 1
  SqlUnbind* = 2
  SqlResetParams* = 3 # Codes used for FetchOrientation in SQLFetchScroll(),
                        #   and in SQLDataSources() 
  SqlFetchNext* = 1
  SqlFetchFirst* = 2
  SqlFetchFirstUser* = 31
  SqlFetchFirstSystem* = 32 # Other codes used for FetchOrientation in SQLFetchScroll() 
  SqlFetchLast* = 3
  SqlFetchPrior* = 4
  SqlFetchAbsolute* = 5
  SqlFetchRelative* = 6   
  SqlNullHenv* = TSqlHEnv(nil)
  SqlNullHdbc* = TSqlHDBC(nil)
  SqlNullHstmt* = TSqlHStmt(nil)
  SqlNullHdesc* = TSqlHDesc(nil) #* null handle used in place of parent handle when allocating HENV */
  SqlNullHandle* = TSqlHandle(nil) #* Values that may appear in the result set of SQLSpecialColumns() */
  SqlScopeCurrow* = 0
  SqlScopeTransaction* = 1
  SqlScopeSession* = 2      #* Column types and scopes in SQLSpecialColumns.  */
  SqlBestRowid* = 1
  SqlRowver* = 2             
  SqlRowIdentifier* = 1     #* Reserved values for UNIQUE argument of SQLStatistics() */
  SqlIndexUnique* = 0
  SqlIndexAll* = 1          #* Reserved values for RESERVED argument of SQLStatistics() */
  SqlQuick* = 0
  SqlEnsure* = 1             #* Values that may appear in the result set of SQLStatistics() */
  SqlTableStat* = 0
  SqlIndexClustered* = 1
  SqlIndexHashed* = 2
  SqlIndexOther* = 3 
  SqlScrollConcurrency* = 43
  SqlTxnCapable* = 46
  SqlTransactionCapable* = SQL_TXN_CAPABLE
  SqlUserName* = 47
  SqlTxnIsolationOption* = 72
  SqlTransactionIsolationOption* = SQL_TXN_ISOLATION_OPTION 
  SqlOjCapabilities* = 115
  SqlOuterJoinCapabilities* = SQL_OJ_CAPABILITIES
  SqlXopenCliYear* = 10000
  SqlCursorSensitivity* = 10001
  SqlDescribeParameter* = 10002
  SqlCatalogName* = 10003
  SqlCollationSeq* = 10004
  SqlMaxIdentifierLen* = 10005
  SqlMaximumIdentifierLength* = SQL_MAX_IDENTIFIER_LEN
  SqlSccoReadOnly* = 1
  SqlSccoLock* = 2
  SqlSccoOptRowver* = 4
  SqlSccoOptValues* = 8    #* SQL_TXN_CAPABLE values */
  SqlTcNone* = 0
  SqlTcDml* = 1
  SqlTcAll* = 2
  SqlTcDdlCommit* = 3
  SqlTcDdlIgnore* = 4      #* SQL_TXN_ISOLATION_OPTION bitmasks */
  SqlTxnReadUncommitted* = 1
  SqlTransactionReadUncommitted* = SQL_TXN_READ_UNCOMMITTED
  SqlTxnReadCommitted* = 2
  SqlTransactionReadCommitted* = SQL_TXN_READ_COMMITTED
  SqlTxnRepeatableRead* = 4
  SqlTransactionRepeatableRead* = SQL_TXN_REPEATABLE_READ
  SqlTxnSerializable* = 8
  SqlTransactionSerializable* = SQL_TXN_SERIALIZABLE 
  SqlSsAdditions* = 1
  SqlSsDeletions* = 2
  SqlSsUpdates* = 4         # SQLColAttributes defines 
  SqlColumnCount* = 0
  SqlColumnName* = 1
  SqlColumnType* = 2
  SqlColumnLength* = 3
  SqlColumnPrecision* = 4
  SqlColumnScale* = 5
  SqlColumnDisplaySize* = 6
  SqlColumnNullable* = 7
  SqlColumnUnsigned* = 8
  SqlColumnMoney* = 9
  SqlColumnUpdatable* = 10
  SqlColumnAutoIncrement* = 11
  SqlColumnCaseSensitive* = 12
  SqlColumnSearchable* = 13
  SqlColumnTypeName* = 14
  SqlColumnTableName* = 15
  SqlColumnOwnerName* = 16
  SqlColumnQualifierName* = 17
  SqlColumnLabel* = 18
  SqlColattOptMax* = SQL_COLUMN_LABEL
  SqlColumnDriverStart* = 1000
  SqlDescArraySize* = 20
  SqlDescArrayStatusPtr* = 21
  SqlDescAutoUniqueValue* = SQL_COLUMN_AUTO_INCREMENT
  SqlDescBaseColumnName* = 22
  SqlDescBaseTableName* = 23
  SqlDescBindOffsetPtr* = 24
  SqlDescBindType* = 25
  SqlDescCaseSensitive* = SQL_COLUMN_CASE_SENSITIVE
  SqlDescCatalogName* = SQL_COLUMN_QUALIFIER_NAME
  SqlDescConciseType* = SQL_COLUMN_TYPE
  SqlDescDatetimeIntervalPrecision* = 26
  SqlDescDisplaySize* = SQL_COLUMN_DISPLAY_SIZE
  SqlDescFixedPrecScale* = SQL_COLUMN_MONEY
  SqlDescLabel* = SQL_COLUMN_LABEL
  SqlDescLiteralPrefix* = 27
  SqlDescLiteralSuffix* = 28
  SqlDescLocalTypeName* = 29
  SqlDescMaximumScale* = 30
  SqlDescMinimumScale* = 31
  SqlDescNumPrecRadix* = 32
  SqlDescParameterType* = 33
  SqlDescRowsProcessedPtr* = 34
  SqlDescSchemaName* = SQL_COLUMN_OWNER_NAME
  SqlDescSearchable* = SQL_COLUMN_SEARCHABLE
  SqlDescTypeName* = SQL_COLUMN_TYPE_NAME
  SqlDescTableName* = SQL_COLUMN_TABLE_NAME
  SqlDescUnsigned* = SQL_COLUMN_UNSIGNED
  SqlDescUpdatable* = SQL_COLUMN_UPDATABLE #* SQLEndTran() options */
  SqlCommit* = 0
  SqlRollback* = 1
  SqlAttrRowArraySize* = 27 #* SQLConfigDataSource() options */
  OdbcAddDsn* = 1
  OdbcConfigDsn* = 2
  OdbcRemoveDsn* = 3
  OdbcAddSysDsn* = 4
  OdbcConfigSysDsn* = 5
  OdbcRemoveSysDsn* = 6

proc SQLAllocHandle*(HandleType: TSqlSmallInt, InputHandle: TSqlHandle, 
                     OutputHandlePtr: var TSqlHandle): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLSetEnvAttr*(EnvironmentHandle: TSqlHEnv, Attribute: TSqlInteger, 
                    Value: TSqlPointer, StringLength: TSqlInteger): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLGetEnvAttr*(EnvironmentHandle: TSqlHEnv, Attribute: TSqlInteger, 
                    Value: TSqlPointer, BufferLength: TSqlInteger, 
                    StringLength: Psqlinteger): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLFreeHandle*(HandleType: TSqlSmallInt, Handle: TSqlHandle): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLGetDiagRec*(HandleType: TSqlSmallInt, Handle: TSqlHandle, 
                    RecNumber: TSqlSmallInt, Sqlstate: Psqlchar, 
                    NativeError: var TSqlInteger, MessageText: Psqlchar, 
                    BufferLength: TSqlSmallInt, TextLength: var TSqlSmallInt): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLGetDiagField*(HandleType: TSqlSmallInt, Handle: TSqlHandle, 
                      RecNumber: TSqlSmallInt, DiagIdentifier: TSqlSmallInt, 
                      DiagInfoPtr: TSqlPointer, BufferLength: TSqlSmallInt, 
                      StringLengthPtr: var TSqlSmallInt): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLConnect*(ConnectionHandle: TSqlHDBC, ServerName: Psqlchar, 
                 NameLength1: TSqlSmallInt, UserName: Psqlchar, 
                 NameLength2: TSqlSmallInt, Authentication: Psqlchar, 
                 NameLength3: TSqlSmallInt): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLDisconnect*(ConnectionHandle: TSqlHDBC): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLDriverConnect*(hdbc: TSqlHDBC, hwnd: TSqlHWND, szCsin: Cstring, 
                       szCLen: TSqlSmallInt, szCsout: Cstring, 
                       cbCSMax: TSqlSmallInt, cbCsOut: var TSqlSmallInt, 
                       f: TSqlUSmallInt): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLBrowseConnect*(hdbc: TSqlHDBC, szConnStrIn: Psqlchar, 
                       cbConnStrIn: TSqlSmallInt, szConnStrOut: Psqlchar, 
                       cbConnStrOutMax: TSqlSmallInt, 
                       cbConnStrOut: var TSqlSmallInt): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLExecDirect*(StatementHandle: TSqlHStmt, StatementText: Psqlchar, 
                    TextLength: TSqlInteger): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLPrepare*(StatementHandle: TSqlHStmt, StatementText: Psqlchar, 
                 TextLength: TSqlInteger): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLCloseCursor*(StatementHandle: TSqlHStmt): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLExecute*(StatementHandle: TSqlHStmt): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLFetch*(StatementHandle: TSqlHStmt): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLNumResultCols*(StatementHandle: TSqlHStmt, ColumnCount: var TSqlSmallInt): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLDescribeCol*(StatementHandle: TSqlHStmt, ColumnNumber: TSqlUSmallInt, 
                     ColumnName: Psqlchar, BufferLength: TSqlSmallInt, 
                     NameLength: var TSqlSmallInt, DataType: var TSqlSmallInt, 
                     ColumnSize: var TSqlUInteger, 
                     DecimalDigits: var TSqlSmallInt, Nullable: var TSqlSmallInt): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLFetchScroll*(StatementHandle: TSqlHStmt, FetchOrientation: TSqlSmallInt, 
                     FetchOffset: TSqlInteger): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLExtendedFetch*(hstmt: TSqlHStmt, fFetchType: TSqlUSmallInt, 
                       irow: TSqlInteger, pcrow: Psqluinteger, 
                       rgfRowStatus: Psqlusmallint): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLGetData*(StatementHandle: TSqlHStmt, ColumnNumber: TSqlUSmallInt, 
                 TargetType: TSqlSmallInt, TargetValue: TSqlPointer, 
                 BufferLength: TSqlInteger, StrLen_or_Ind: Psqlinteger): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLSetStmtAttr*(StatementHandle: TSqlHStmt, Attribute: TSqlInteger, 
                     Value: TSqlPointer, StringLength: TSqlInteger): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLGetStmtAttr*(StatementHandle: TSqlHStmt, Attribute: TSqlInteger, 
                     Value: TSqlPointer, BufferLength: TSqlInteger, 
                     StringLength: Psqlinteger): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLGetInfo*(ConnectionHandle: TSqlHDBC, InfoType: TSqlUSmallInt, 
                 InfoValue: TSqlPointer, BufferLength: TSqlSmallInt, 
                 StringLength: Psqlsmallint): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLBulkOperations*(StatementHandle: TSqlHStmt, Operation: TSqlSmallInt): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLPutData*(StatementHandle: TSqlHStmt, Data: TSqlPointer, 
                 StrLen_or_Ind: TSqlInteger): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLBindCol*(StatementHandle: TSqlHStmt, ColumnNumber: TSqlUSmallInt, 
                 TargetType: TSqlSmallInt, TargetValue: TSqlPointer, 
                 BufferLength: TSqlInteger, StrLen_or_Ind: Psqlinteger): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLSetPos*(hstmt: TSqlHStmt, irow: TSqlUSmallInt, fOption: TSqlUSmallInt, 
                fLock: TSqlUSmallInt): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLDataSources*(EnvironmentHandle: TSqlHEnv, Direction: TSqlUSmallInt, 
                     ServerName: Psqlchar, BufferLength1: TSqlSmallInt, 
                     NameLength1: Psqlsmallint, Description: Psqlchar, 
                     BufferLength2: TSqlSmallInt, NameLength2: Psqlsmallint): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLDrivers*(EnvironmentHandle: TSqlHEnv, Direction: TSqlUSmallInt, 
                 DriverDescription: Psqlchar, BufferLength1: TSqlSmallInt, 
                 DescriptionLength1: Psqlsmallint, DriverAttributes: Psqlchar, 
                 BufferLength2: TSqlSmallInt, AttributesLength2: Psqlsmallint): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLSetConnectAttr*(ConnectionHandle: TSqlHDBC, Attribute: TSqlInteger, 
                        Value: TSqlPointer, StringLength: TSqlInteger): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLGetCursorName*(StatementHandle: TSqlHStmt, CursorName: Psqlchar, 
                       BufferLength: TSqlSmallInt, NameLength: Psqlsmallint): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLSetCursorName*(StatementHandle: TSqlHStmt, CursorName: Psqlchar, 
                       NameLength: TSqlSmallInt): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLRowCount*(StatementHandle: TSqlHStmt, RowCount: var TSqlInteger): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLBindParameter*(hstmt: TSqlHStmt, ipar: TSqlUSmallInt, 
                       fParamType: TSqlSmallInt, fCType: TSqlSmallInt, 
                       fSqlType: TSqlSmallInt, cbColDef: TSqlUInteger, 
                       ibScale: TSqlSmallInt, rgbValue: TSqlPointer, 
                       cbValueMax: TSqlInteger, pcbValue: Psqlinteger): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLFreeStmt*(StatementHandle: TSqlHStmt, Option: TSqlUSmallInt): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLColAttribute*(StatementHandle: TSqlHStmt, ColumnNumber: TSqlUSmallInt, 
                      FieldIdentifier: TSqlUSmallInt, 
                      CharacterAttribute: Psqlchar, BufferLength: TSqlSmallInt, 
                      StringLength: Psqlsmallint, 
                      NumericAttribute: TSqlPointer): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLEndTran*(HandleType: TSqlSmallInt, Handle: TSqlHandle, 
                 CompletionType: TSqlSmallInt): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLTables*(hstmt: TSqlHStmt, szTableQualifier: Psqlchar, 
                cbTableQualifier: TSqlSmallInt, szTableOwner: Psqlchar, 
                cbTableOwner: TSqlSmallInt, szTableName: Psqlchar, 
                cbTableName: TSqlSmallInt, szTableType: Psqlchar, 
                cbTableType: TSqlSmallInt): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLColumns*(hstmt: TSqlHStmt, szTableQualifier: Psqlchar, 
                 cbTableQualifier: TSqlSmallInt, szTableOwner: Psqlchar, 
                 cbTableOwner: TSqlSmallInt, szTableName: Psqlchar, 
                 cbTableName: TSqlSmallInt, szColumnName: Psqlchar, 
                 cbColumnName: TSqlSmallInt): TSqlSmallInt{.dynlib: odbclib, importc.}
proc SQLSpecialColumns*(StatementHandle: TSqlHStmt, IdentifierType: TSqlUSmallInt, 
                        CatalogName: Psqlchar, NameLength1: TSqlSmallInt, 
                        SchemaName: Psqlchar, NameLength2: TSqlSmallInt, 
                        TableName: Psqlchar, NameLength3: TSqlSmallInt, 
                        Scope: TSqlUSmallInt, 
                        Nullable: TSqlUSmallInt): TSqlSmallInt{.
    dynlib: odbclib, importc.}
proc SQLProcedures*(hstmt: TSqlHStmt, szTableQualifier: Psqlchar, 
                    cbTableQualifier: TSqlSmallInt, szTableOwner: Psqlchar, 
                    cbTableOwner: TSqlSmallInt, szTableName: Psqlchar, 
                    cbTableName: TSqlSmallInt): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLPrimaryKeys*(hstmt: TSqlHStmt, CatalogName: Psqlchar, 
                     NameLength1: TSqlSmallInt, SchemaName: Psqlchar, 
                     NameLength2: TSqlSmallInt, TableName: Psqlchar, 
                     NameLength3: TSqlSmallInt): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLProcedureColumns*(hstmt: TSqlHStmt, CatalogName: Psqlchar, 
                          NameLength1: TSqlSmallInt, SchemaName: Psqlchar, 
                          NameLength2: TSqlSmallInt, ProcName: Psqlchar, 
                          NameLength3: TSqlSmallInt, ColumnName: Psqlchar, 
                          NameLength4: TSqlSmallInt): TSqlSmallInt{.dynlib: odbclib, 
    importc.}
proc SQLStatistics*(hstmt: TSqlHStmt, CatalogName: Psqlchar, 
                    NameLength1: TSqlSmallInt, SchemaName: Psqlchar, 
                    NameLength2: TSqlSmallInt, TableName: Psqlchar, 
                    NameLength3: TSqlSmallInt, Unique: TSqlUSmallInt, 
                    Reserved: TSqlUSmallInt): TSqlSmallInt {.
                    dynlib: odbclib, importc.}

{.pop.}
