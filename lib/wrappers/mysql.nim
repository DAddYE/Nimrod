#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2010 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

{.deadCodeElim: on.}
{.push, callconv: cdecl.}

when defined(Unix): 
  const 
    lib = "libmysqlclient.so.15"
when defined(Windows): 
  const 
    lib = "libmysql.dll"
type 
  MyBool* = Bool
  PmyBool* = ptr MyBool
  Pvio* = Pointer
  Pgptr* = ptr Gptr
  Gptr* = Cstring
  PmySocket* = ptr MySocket
  MySocket* = Cint
  PPByte* = Pointer
  Cuint* = Cint

#  ------------ Start of declaration in "mysql_com.h"   ---------------------  
#
#  ** Common definition between mysql server & client
#   
# Field/table name length

const 
  NameLen* = 64
  HostnameLength* = 60
  UsernameLength* = 16
  ServerVersionLength* = 60
  SqlstateLength* = 5
  LocalHost* = "localhost"
  LocalHostNamedpipe* = '.'

const 
  Namedpipe* = "MySQL"
  Servicename* = "MySQL"

type 
  TenumServerCommand* = enum 
    COM_SLEEP, COM_QUIT, COM_INIT_DB, COM_QUERY, COM_FIELD_LIST, COM_CREATE_DB, 
    COM_DROP_DB, COM_REFRESH, COM_SHUTDOWN, COM_STATISTICS, COM_PROCESS_INFO, 
    COM_CONNECT, COM_PROCESS_KILL, COM_DEBUG, COM_PING, COM_TIME, 
    COM_DELAYED_INSERT, COM_CHANGE_USER, COM_BINLOG_DUMP, COM_TABLE_DUMP, 
    COM_CONNECT_OUT, COM_REGISTER_SLAVE, COM_STMT_PREPARE, COM_STMT_EXECUTE, 
    COM_STMT_SEND_LONG_DATA, COM_STMT_CLOSE, COM_STMT_RESET, COM_SET_OPTION, 
    COM_STMT_FETCH, COM_END

const 
  ScrambleLength* = 20 # Length of random string sent by server on handshake; 
                        # this is also length of obfuscated password, 
                        # recieved from client
  ScrambleLength323* = 8    # length of password stored in the db: 
                              # new passwords are preceeded with '*'  
  ScrambledPasswordCharLength* = SCRAMBLE_LENGTH * 2 + 1
  ScrambledPasswordCharLength323* = SCRAMBLE_LENGTH_323 * 2
  NotNullFlag* = 1          #  Field can't be NULL
  PriKeyFlag* = 2           #  Field is part of a primary key
  UniqueKeyFlag* = 4        #  Field is part of a unique key
  MultipleKeyFlag* = 8      #  Field is part of a key
  BlobFlag* = 16             #  Field is a blob
  UnsignedFlag* = 32         #  Field is unsigned
  ZerofillFlag* = 64         #  Field is zerofill
  BinaryFlag* = 128          #  Field is binary
                              # The following are only sent to new clients  
  EnumFlag* = 256            # field is an enum
  AutoIncrementFlag* = 512  # field is a autoincrement field
  TimestampFlag* = 1024      # Field is a timestamp
  SetFlag* = 2048            # field is a set
  NoDefaultValueFlag* = 4096 # Field doesn't have default value
  NumFlag* = 32768           # Field is num (for clients)
  PartKeyFlag* = 16384      # Intern; Part of some key
  GroupFlag* = 32768         # Intern: Group field
  UniqueFlag* = 65536        # Intern: Used by sql_yacc
  BincmpFlag* = 131072       # Intern: Used by sql_yacc
  RefreshGrant* = 1          # Refresh grant tables
  RefreshLog* = 2            # Start on new log file
  RefreshTables* = 4         # close all tables
  RefreshHosts* = 8          # Flush host cache
  RefreshStatus* = 16        # Flush status variables
  RefreshThreads* = 32       # Flush thread cache
  RefreshSlave* = 64         # Reset master info and restart slave thread
  RefreshMaster* = 128 # Remove all bin logs in the index and truncate the index
                        # The following can't be set with mysql_refresh()  
  RefreshReadLock* = 16384  # Lock tables for read
  RefreshFast* = 32768       # Intern flag
  RefreshQueryCache* = 65536 # RESET (remove all queries) from query cache
  RefreshQueryCacheFree* = 0x00020000 # pack query cache
  RefreshDesKeyFile* = 0x00040000
  RefreshUserResources* = 0x00080000
  ClientLongPassword* = 1   # new more secure passwords
  ClientFoundRows* = 2      # Found instead of affected rows
  ClientLongFlag* = 4       # Get all column flags
  ClientConnectWithDb* = 8 # One can specify db on connect
  ClientNoSchema* = 16      # Don't allow database.table.column
  ClientCompress* = 32       # Can use compression protocol
  ClientOdbc* = 64           # Odbc client
  ClientLocalFiles* = 128   # Can use LOAD DATA LOCAL
  ClientIgnoreSpace* = 256  # Ignore spaces before '('
  ClientProtocol41* = 512   # New 4.1 protocol
  ClientInteractive* = 1024  # This is an interactive client
  ClientSsl* = 2048          # Switch to SSL after handshake
  ClientIgnoreSigpipe* = 4096 # IGNORE sigpipes
  ClientTransactions* = 8192 # Client knows about transactions
  ClientReserved* = 16384    # Old flag for 4.1 protocol
  ClientSecureConnection* = 32768 # New 4.1 authentication
  ClientMultiStatements* = 65536 # Enable/disable multi-stmt support
  ClientMultiResults* = 131072 # Enable/disable multi-results
  ClientRememberOptions*: Int = 1 shl 31
  ServerStatusInTrans* = 1 # Transaction has started
  ServerStatusAutocommit* = 2 # Server in auto_commit mode
  ServerStatusMoreResults* = 4 # More results on server
  ServerMoreResultsExists* = 8 # Multi query - next query exists
  ServerQueryNoGoodIndexUsed* = 16
  ServerQueryNoIndexUsed* = 32 # The server was able to fulfill the clients request and opened a
                                   #      read-only non-scrollable cursor for a query. This flag comes
                                   #      in reply to COM_STMT_EXECUTE and COM_STMT_FETCH commands. 
  ServerStatusCursorExists* = 64 # This flag is sent when a read-only cursor is exhausted, in reply to
                                    #      COM_STMT_FETCH command. 
  ServerStatusLastRowSent* = 128
  ServerStatusDbDropped* = 256 # A database was dropped
  ServerStatusNoBackslashEscapes* = 512
  ErrmsgSize* = 200
  NetReadTimeout* = 30      # Timeout on read
  NetWriteTimeout* = 60     # Timeout on write
  NetWaitTimeout* = 8 * 60 * 60 # Wait for new query
  OnlyKillQuery* = 1

const 
  MaxTinyintWidth* = 3      # Max width for a TINY w.o. sign
  MaxSmallintWidth* = 5     # Max width for a SHORT w.o. sign
  MaxMediumintWidth* = 8    # Max width for a INT24 w.o. sign
  MaxIntWidth* = 10         # Max width for a LONG w.o. sign
  MaxBigintWidth* = 20      # Max width for a LONGLONG
  MaxCharWidth* = 255       # Max length for a CHAR colum
  MaxBlobWidth* = 8192      # Default width for blob

type 
  PstNet* = ptr TstNet
  TstNet*{.final.} = object 
    vio*: Pvio
    buff*: Cstring
    buff_end*: Cstring
    write_pos*: Cstring
    read_pos*: Cstring
    fd*: MySocket            # For Perl DBI/dbd
    max_packet*: Int
    max_packet_size*: Int
    pkt_nr*: Cuint
    compress_pkt_nr*: Cuint
    write_timeout*: Cuint
    read_timeout*: Cuint
    retry_count*: Cuint
    fcntl*: Cint
    compress*: MyBool #   The following variable is set if we are doing several queries in one
                       #        command ( as in LOAD TABLE ... FROM MASTER ),
                       #        and do not want to confuse the client with OK at the wrong time 
    remain_in_buf*: Int
    len*: Int
    buf_length*: Int
    where_b*: Int
    return_status*: ptr Cint
    reading_or_writing*: Char
    save_char*: Cchar
    no_send_ok*: MyBool      # For SPs and other things that do multiple stmts
    no_send_eof*: MyBool     # For SPs' first version read-only cursors
    no_send_error*: MyBool # Set if OK packet is already sent, and
                            # we do not need to send error messages
                            #   Pointer to query object in query cache, do not equal NULL (0) for
                            #        queries in cache that have not stored its results yet 
                            # $endif
    last_error*: Array[0..(ERRMSG_SIZE) - 1, Char]
    sqlstate*: Array[0..(SQLSTATE_LENGTH + 1) - 1, Char]
    last_errno*: Cuint
    error*: Char
    query_cache_query*: Gptr
    report_error*: MyBool    # We should report error (we have unreported error)
    return_errno*: MyBool

  TNET* = TstNet
  Pnet* = ptr TNET

const 
  packetError* = - 1

type 
  TenumFieldTypes* = enum    # For backward compatibility  
    TYPE_DECIMAL, TYPE_TINY, TYPE_SHORT, TYPE_LONG, TYPE_FLOAT, TYPE_DOUBLE, 
    TYPE_NULL, TYPE_TIMESTAMP, TYPE_LONGLONG, TYPE_INT24, TYPE_DATE, TYPE_TIME, 
    TYPE_DATETIME, TYPE_YEAR, TYPE_NEWDATE, TYPE_VARCHAR, TYPE_BIT, 
    TYPE_NEWDECIMAL = 246, TYPE_ENUM = 247, TYPE_SET = 248, 
    TYPE_TINY_BLOB = 249, TYPE_MEDIUM_BLOB = 250, TYPE_LONG_BLOB = 251, 
    TYPE_BLOB = 252, TYPE_VAR_STRING = 253, TYPE_STRING = 254, 
    TYPE_GEOMETRY = 255

const 
  ClientMultiQueries* = CLIENT_MULTI_STATEMENTS
  FieldTypeDecimal* = TYPE_DECIMAL
  FieldTypeNewdecimal* = TYPE_NEWDECIMAL
  FieldTypeTiny* = TYPE_TINY
  FieldTypeShort* = TYPE_SHORT
  FieldTypeLong* = TYPE_LONG
  FieldTypeFloat* = TYPE_FLOAT
  FieldTypeDouble* = TYPE_DOUBLE
  FieldTypeNull* = TYPE_NULL
  FieldTypeTimestamp* = TYPE_TIMESTAMP
  FieldTypeLonglong* = TYPE_LONGLONG
  FieldTypeInt24* = TYPE_INT24
  FieldTypeDate* = TYPE_DATE
  FieldTypeTime* = TYPE_TIME
  FieldTypeDatetime* = TYPE_DATETIME
  FieldTypeYear* = TYPE_YEAR
  FieldTypeNewdate* = TYPE_NEWDATE
  FieldTypeEnum* = TYPE_ENUM
  FieldTypeSet* = TYPE_SET
  FieldTypeTinyBlob* = TYPE_TINY_BLOB
  FieldTypeMediumBlob* = TYPE_MEDIUM_BLOB
  FieldTypeLongBlob* = TYPE_LONG_BLOB
  FieldTypeBlob* = TYPE_BLOB
  FieldTypeVarString* = TYPE_VAR_STRING
  FieldTypeString* = TYPE_STRING
  FieldTypeChar* = TYPE_TINY
  FieldTypeInterval* = TYPE_ENUM
  FieldTypeGeometry* = TYPE_GEOMETRY
  FieldTypeBit* = TYPE_BIT  # Shutdown/kill enums and constants  
                              # Bits for THD::killable.  
  ShutdownKillableConnect* = chr(1 shl 0)
  ShutdownKillableTrans* = chr(1 shl 1)
  ShutdownKillableLockTable* = chr(1 shl 2)
  ShutdownKillableUpdate* = chr(1 shl 3)

type 
  TenumShutdownLevel* = enum 
    SHUTDOWN_DEFAULT = 0, SHUTDOWN_WAIT_CONNECTIONS = 1, 
    SHUTDOWN_WAIT_TRANSACTIONS = 2, SHUTDOWN_WAIT_UPDATES = 8, 
    SHUTDOWN_WAIT_ALL_BUFFERS = 16, SHUTDOWN_WAIT_CRITICAL_BUFFERS = 17, 
    KILL_QUERY = 254, KILL_CONNECTION = 255
  TenumCursorType* = enum    # options for mysql_set_option  
    CURSOR_TYPE_NO_CURSOR = 0, CURSOR_TYPE_READ_ONLY = 1, 
    CURSOR_TYPE_FOR_UPDATE = 2, CURSOR_TYPE_SCROLLABLE = 4
  TenumMysqlSetOption* = enum 
    OPTION_MULTI_STATEMENTS_ON, OPTION_MULTI_STATEMENTS_OFF

proc myNetInit*(net: Pnet, vio: Pvio): MyBool{.cdecl, dynlib: lib, 
    importc: "my_net_init".}
proc myNetLocalInit*(net: Pnet){.cdecl, dynlib: lib, 
                                    importc: "my_net_local_init".}
proc netEnd*(net: Pnet){.cdecl, dynlib: lib, importc: "net_end".}
proc netClear*(net: Pnet){.cdecl, dynlib: lib, importc: "net_clear".}
proc netRealloc*(net: Pnet, len: Int): MyBool{.cdecl, dynlib: lib, 
    importc: "net_realloc".}
proc netFlush*(net: Pnet): MyBool{.cdecl, dynlib: lib, importc: "net_flush".}
proc myNetWrite*(net: Pnet, packet: Cstring, length: Int): MyBool{.cdecl, 
    dynlib: lib, importc: "my_net_write".}
proc netWriteCommand*(net: Pnet, command: Char, header: Cstring, 
                        head_len: Int, packet: Cstring, length: Int): MyBool{.
    cdecl, dynlib: lib, importc: "net_write_command".}
proc netRealWrite*(net: Pnet, packet: Cstring, length: Int): Cint{.cdecl, 
    dynlib: lib, importc: "net_real_write".}
proc myNetRead*(net: Pnet): Int{.cdecl, dynlib: lib, importc: "my_net_read".}
  # The following function is not meant for normal usage
  #      Currently it's used internally by manager.c  
type 
  Psockaddr* = ptr Tsockaddr
  Tsockaddr*{.final.} = object  # undefined structure

proc myConnect*(s: MySocket, name: Psockaddr, namelen: Cuint, timeout: Cuint): Cint{.
    cdecl, dynlib: lib, importc: "my_connect".}
type 
  PrandStruct* = ptr TrandStruct
  TrandStruct*{.final.} = object # The following is for user defined functions  
    seed1*: Int
    seed2*: Int
    max_value*: Int
    max_value_dbl*: Cdouble

  TItem_result* = enum 
    STRING_RESULT, REAL_RESULT, INT_RESULT, ROW_RESULT, DECIMAL_RESULT
  PItemResult* = ptr TItem_result
  PstUdfArgs* = ptr TstUdfArgs
  TstUdfArgs*{.final.} = object 
    arg_count*: Cuint         # Number of arguments
    arg_type*: PItemResult   # Pointer to item_results
    args*: CstringArray       # Pointer to item_results
    lengths*: ptr Int         # Length of string arguments
    maybe_null*: Cstring      # Length of string arguments
    attributes*: CstringArray # Pointer to attribute name
    attribute_lengths*: ptr Int # Length of attribute arguments
  
  TUDF_ARGS* = TstUdfArgs
  PudfArgs* = ptr TUDF_ARGS   # This holds information about the result  
  PstUdfInit* = ptr TstUdfInit
  TstUdfInit*{.final.} = object 
    maybe_null*: MyBool      # 1 if function can return NULL
    decimals*: Cuint          # for real functions
    max_length*: Int          # For string functions
    theptr*: Cstring          # free pointer for function data
    const_item*: MyBool      # free pointer for function data
  
  TUDF_INIT* = TstUdfInit
  PudfInit* = ptr TUDF_INIT   # Constants when using compression  

const 
  NetHeaderSize* = 4        # standard header size
  CompHeaderSize* = 3 # compression header extra size
                        # Prototypes to password functions  
                        # These functions are used for authentication by client and server and
                        #      implemented in sql/password.c     

proc randominit*(para1: PrandStruct, seed1: Int, seed2: Int){.cdecl, 
    dynlib: lib, importc: "randominit".}
proc myRnd*(para1: PrandStruct): Cdouble{.cdecl, dynlib: lib, 
    importc: "my_rnd".}
proc createRandomString*(fto: Cstring, len: Cuint, rand_st: PrandStruct){.
    cdecl, dynlib: lib, importc: "create_random_string".}
proc hashPassword*(fto: Int, password: Cstring, password_len: Cuint){.cdecl, 
    dynlib: lib, importc: "hash_password".}
proc makeScrambledPassword323*(fto: Cstring, password: Cstring){.cdecl, 
    dynlib: lib, importc: "make_scrambled_password_323".}
proc scramble323*(fto: Cstring, message: Cstring, password: Cstring){.cdecl, 
    dynlib: lib, importc: "scramble_323".}
proc checkScramble323*(para1: Cstring, message: Cstring, salt: Int): MyBool{.
    cdecl, dynlib: lib, importc: "check_scramble_323".}
proc getSaltFromPassword323*(res: ptr int, password: Cstring){.cdecl, 
    dynlib: lib, importc: "get_salt_from_password_323".}
proc makePasswordFromSalt323*(fto: Cstring, salt: ptr int){.cdecl, 
    dynlib: lib, importc: "make_password_from_salt_323".}
proc octet2hex*(fto: Cstring, str: Cstring, length: Cuint): Cstring{.cdecl, 
    dynlib: lib, importc: "octet2hex".}
proc makeScrambledPassword*(fto: Cstring, password: Cstring){.cdecl, 
    dynlib: lib, importc: "make_scrambled_password".}
proc scramble*(fto: Cstring, message: Cstring, password: Cstring){.cdecl, 
    dynlib: lib, importc: "scramble".}
proc checkScramble*(reply: Cstring, message: Cstring, hash_stage2: Pointer): MyBool{.
    cdecl, dynlib: lib, importc: "check_scramble".}
proc getSaltFromPassword*(res: Pointer, password: Cstring){.cdecl, 
    dynlib: lib, importc: "get_salt_from_password".}
proc makePasswordFromSalt*(fto: Cstring, hash_stage2: Pointer){.cdecl, 
    dynlib: lib, importc: "make_password_from_salt".}
  # end of password.c  
proc getTtyPassword*(opt_message: Cstring): Cstring{.cdecl, dynlib: lib, 
    importc: "get_tty_password".}
proc errnoToSqlstate*(errno: Cuint): Cstring{.cdecl, dynlib: lib, 
    importc: "mysql_errno_to_sqlstate".}
  # Some other useful functions  
proc modifyDefaultsFile*(file_location: Cstring, option: Cstring, 
                           option_value: Cstring, section_name: Cstring, 
                           remove_option: Cint): Cint{.cdecl, dynlib: lib, 
    importc: "load_defaults".}
proc loadDefaults*(conf_file: Cstring, groups: CstringArray, argc: ptr Cint, 
                    argv: ptr CstringArray): Cint{.cdecl, dynlib: lib, 
    importc: "load_defaults".}
proc myInit*(): MyBool{.cdecl, dynlib: lib, importc: "my_init".}
proc myThreadInit*(): MyBool{.cdecl, dynlib: lib, importc: "my_thread_init".}
proc myThreadEnd*(){.cdecl, dynlib: lib, importc: "my_thread_end".}
const 
  NullLength*: Int = int(not (0)) # For net_store_length

const 
  StmtHeader* = 4
  LongDataHeader* = 6 #  ------------ Stop of declaration in "mysql_com.h"   -----------------------  
                        # $include "mysql_time.h"
                        # $include "mysql_version.h"
                        # $include "typelib.h"
                        # $include "my_list.h" /* for LISTs used in 'MYSQL' and 'MYSQL_STMT' */
                        #      var
                        #         mysql_port : cuint;cvar;external;
                        #         mysql_unix_port : Pchar;cvar;external;

const 
  ClientNetReadTimeout* = 365 * 24 * 3600 # Timeout on read
  ClientNetWriteTimeout* = 365 * 24 * 3600 # Timeout on write

type 
  PstMysqlField* = ptr TstMysqlField
  TstMysqlField*{.final.} = object 
    name*: Cstring            # Name of column
    org_name*: Cstring        # Original column name, if an alias
    table*: Cstring           # Table of column if column was a field
    org_table*: Cstring       # Org table name, if table was an alias
    db*: Cstring              # Database for table
    catalog*: Cstring         # Catalog for table
    def*: Cstring             # Default value (set by mysql_list_fields)
    len*: Int                 # Width of column (create length)
    max_length*: Int          # Max width for selected set
    name_length*: Cuint
    org_name_length*: Cuint
    table_length*: Cuint
    org_table_length*: Cuint
    db_length*: Cuint
    catalog_length*: Cuint
    def_length*: Cuint
    flags*: Cuint             # Div flags
    decimals*: Cuint          # Number of decimals in field
    charsetnr*: Cuint         # Character set
    ftype*: TenumFieldTypes  # Type of field. See mysql_com.h for types
  
  TFIELD* = TstMysqlField
  Pfield* = ptr TFIELD
  Prow* = ptr TROW             # return data as array of strings
  TROW* = CstringArray
  PfieldOffset* = ptr TFIELD_OFFSET # offset to current field
  TFIELD_OFFSET* = Cuint

proc isPriKey*(n: Int32): Bool
proc isNotNull*(n: Int32): Bool
proc isBlob*(n: Int32): Bool
proc isNum*(t: TenumFieldTypes): Bool
proc internalNumField*(f: PstMysqlField): Bool
proc isNumField*(f: PstMysqlField): Bool
type 
  MyUlonglong* = Int64
  PmyUlonglong* = ptr MyUlonglong

const 
  CountError* = not (my_ulonglong(0))

type 
  PstMysqlRows* = ptr TstMysqlRows
  TstMysqlRows*{.final.} = object 
    next*: PstMysqlRows     # list of rows
    data*: TROW
    len*: Int

  TROWS* = TstMysqlRows
  Prows* = ptr TROWS
  ProwOffset* = ptr TROW_OFFSET # offset to current row
  TROW_OFFSET* = TROWS 
  
const 
  AllocMaxBlockToDrop* = 4096
  AllocMaxBlockUsageBeforeDrop* = 10 # struct for once_alloc (block)  

type 
  PstUsedMem* = ptr TstUsedMem
  TstUsedMem*{.final.} = object 
    next*: PstUsedMem       # Next block in use
    left*: Cuint              # memory left in block
    size*: Cuint              # size of block
  
  TUSED_MEM* = TstUsedMem
  PusedMem* = ptr TUSED_MEM
  PstMemRoot* = ptr TstMemRoot
  TstMemRoot*{.final.} = object 
    free*: PusedMem          # blocks with free memory in it
    used*: PusedMem          # blocks almost without free memory
    pre_alloc*: PusedMem     # preallocated block
    min_malloc*: Cuint        # if block have less memory it will be put in 'used' list
    block_size*: Cuint        # initial block size
    block_num*: Cuint # allocated blocks counter
                      #    first free block in queue test counter (if it exceed
                      #       MAX_BLOCK_USAGE_BEFORE_DROP block will be dropped in 'used' list)     
    first_block_usage*: Cuint
    error_handler*: proc (){.cdecl.}

  TMEM_ROOT* = TstMemRoot
  PmemRoot* = ptr TMEM_ROOT   #  ------------ Stop of declaration in "my_alloc.h"    ----------------------  

type 
  PstMysqlData* = ptr TstMysqlData
  TstMysqlData*{.final.} = object 
    rows*: MyUlonglong
    fields*: Cuint
    data*: Prows
    alloc*: TMEM_ROOT
    prev_ptr*: ptr Prows

  TDATA* = TstMysqlData
  Pdata* = ptr TDATA
  Toption* = enum 
    OPT_CONNECT_TIMEOUT, OPT_COMPRESS, OPT_NAMED_PIPE, INIT_COMMAND, 
    READ_DEFAULT_FILE, READ_DEFAULT_GROUP, SET_CHARSET_DIR, SET_CHARSET_NAME, 
    OPT_LOCAL_INFILE, OPT_PROTOCOL, SHARED_MEMORY_BASE_NAME, OPT_READ_TIMEOUT, 
    OPT_WRITE_TIMEOUT, OPT_USE_RESULT, OPT_USE_REMOTE_CONNECTION, 
    OPT_USE_EMBEDDED_CONNECTION, OPT_GUESS_CONNECTION, SET_CLIENT_IP, 
    SECURE_AUTH, REPORT_DATA_TRUNCATION, OPT_RECONNECT

const 
  MaxMysqlManagerErr* = 256
  MaxMysqlManagerMsg* = 256
  ManagerOk* = 200
  ManagerInfo* = 250
  ManagerAccess* = 401
  ManagerClientErr* = 450
  ManagerInternalErr* = 500

type 
  TstDynamicArray*{.final.} = object 
    buffer*: Cstring
    elements*: Cuint
    max_element*: Cuint
    alloc_increment*: Cuint
    size_of_element*: Cuint

  TDYNAMIC_ARRAY* = TstDynamicArray
  PstDynamicArray* = ptr TstDynamicArray
  PstMysqlOptions* = ptr TstMysqlOptions
  TstMysqlOptions*{.final.} = object 
    connect_timeout*: Cuint
    read_timeout*: Cuint
    write_timeout*: Cuint
    port*: Cuint
    protocol*: Cuint
    client_flag*: Int
    host*: Cstring
    user*: Cstring
    password*: Cstring
    unix_socket*: Cstring
    db*: Cstring
    init_commands*: PstDynamicArray
    my_cnf_file*: Cstring
    my_cnf_group*: Cstring
    charset_dir*: Cstring
    charset_name*: Cstring
    ssl_key*: Cstring         # PEM key file
    ssl_cert*: Cstring        # PEM cert file
    ssl_ca*: Cstring          # PEM CA file
    ssl_capath*: Cstring      # PEM directory of CA-s?
    ssl_cipher*: Cstring      # cipher to use
    shared_memory_base_name*: Cstring
    max_allowed_packet*: Int
    use_ssl*: MyBool         # if to use SSL or not
    compress*: MyBool
    named_pipe*: MyBool #  On connect, find out the replication role of the server, and
                         #       establish connections to all the peers  
    rpl_probe*: MyBool #  Each call to mysql_real_query() will parse it to tell if it is a read
                        #       or a write, and direct it to the slave or the master      
    rpl_parse*: MyBool #  If set, never read from a master, only from slave, when doing
                        #       a read that is replication-aware    
    no_master_reads*: MyBool
    separate_thread*: MyBool
    methods_to_use*: Toption
    client_ip*: Cstring
    secure_auth*: MyBool     # Refuse client connecting to server if it uses old (pre-4.1.1) protocol
    report_data_truncation*: MyBool # 0 - never report, 1 - always report (default)
                                     # function pointers for local infile support  
    local_infile_init*: proc (para1: var Pointer, para2: Cstring, para3: Pointer): Cint{.
        cdecl.}
    local_infile_read*: proc (para1: Pointer, para2: Cstring, para3: Cuint): Cint
    local_infile_end*: proc (para1: Pointer)
    local_infile_error*: proc (para1: Pointer, para2: Cstring, para3: Cuint): Cint
    local_infile_userdata*: Pointer

  Tstatus* = enum 
    STATUS_READY, STATUS_GET_RESULT, STATUS_USE_RESULT
  TprotocolType* = enum  # There are three types of queries - the ones that have to go to
                          # the master, the ones that go to a slave, and the adminstrative
                          # type which must happen on the pivot connectioin 
    PROTOCOL_DEFAULT, PROTOCOL_TCP, PROTOCOL_SOCKET, PROTOCOL_PIPE, 
    PROTOCOL_MEMORY
  TrplType* = enum 
    RPL_MASTER, RPL_SLAVE, RPL_ADMIN
  TcharsetInfoSt*{.final.} = object 
    number*: Cuint
    primary_number*: Cuint
    binary_number*: Cuint
    state*: Cuint
    csname*: Cstring
    name*: Cstring
    comment*: Cstring
    tailoring*: Cstring
    ftype*: Cstring
    to_lower*: Cstring
    to_upper*: Cstring
    sort_order*: Cstring
    contractions*: ptr Int16
    sort_order_big*: ptr ptr Int16
    tab_to_uni*: ptr Int16
    tab_from_uni*: Pointer    # was ^MY_UNI_IDX
    state_map*: Cstring
    ident_map*: Cstring
    strxfrm_multiply*: Cuint
    mbminlen*: Cuint
    mbmaxlen*: Cuint
    min_sort_char*: Int16
    max_sort_char*: Int16
    escape_with_backslash_is_dangerous*: MyBool
    cset*: Pointer            # was ^MY_CHARSET_HANDLER
    coll*: Pointer            # was ^MY_COLLATION_HANDLER;
  
  TCHARSET_INFO* = TcharsetInfoSt
  PcharsetInfoSt* = ptr TcharsetInfoSt
  PcharacterSet* = ptr TcharacterSet
  TcharacterSet*{.final.} = object 
    number*: Cuint
    state*: Cuint
    csname*: Cstring
    name*: Cstring
    comment*: Cstring
    dir*: Cstring
    mbminlen*: Cuint
    mbmaxlen*: Cuint

  TMY_CHARSET_INFO* = TcharacterSet
  PmyCharsetInfo* = ptr TMY_CHARSET_INFO
  PstMysqlMethods* = ptr TstMysqlMethods
  PstMysql* = ptr TstMysql
  TstMysql*{.final.} = object 
    net*: TNET                 # Communication parameters
    connector_fd*: Gptr       # ConnectorFd for SSL
    host*: Cstring
    user*: Cstring
    passwd*: Cstring
    unix_socket*: Cstring
    server_version*: Cstring
    host_info*: Cstring
    info*: Cstring
    db*: Cstring
    charset*: PcharsetInfoSt
    fields*: Pfield
    field_alloc*: TMEM_ROOT
    affected_rows*: MyUlonglong
    insert_id*: MyUlonglong  # id if insert on table with NEXTNR
    extra_info*: MyUlonglong # Used by mysqlshow, not used by mysql 5.0 and up
    thread_id*: Int           # Id for connection in server
    packet_length*: Int
    port*: Cuint
    client_flag*: Int
    server_capabilities*: Int
    protocol_version*: Cuint
    field_count*: Cuint
    server_status*: Cuint
    server_language*: Cuint
    warning_count*: Cuint
    options*: TstMysqlOptions
    status*: Tstatus
    free_me*: MyBool         # If free in mysql_close
    reconnect*: MyBool       # set to 1 if automatic reconnect
    scramble*: Array[0..(SCRAMBLE_LENGTH + 1) - 1, Char] # session-wide random string
                                                         #  Set if this is the original connection, not a master or a slave we have
                                                         #       added though mysql_rpl_probe() or mysql_set_master()/ mysql_add_slave()      
    rpl_pivot*: MyBool #   Pointers to the master, and the next slave connections, points to
                        #        itself if lone connection.       
    master*: PstMysql
    next_slave*: PstMysql
    last_used_slave*: PstMysql # needed for round-robin slave pick
    last_used_con*: PstMysql # needed for send/read/store/use result to work correctly with replication
    stmts*: Pointer           # was PList, list of all statements
    methods*: PstMysqlMethods
    thd*: Pointer #   Points to boolean flag in MYSQL_RES  or MYSQL_STMT. We set this flag
                  #        from mysql_stmt_close if close had to cancel result set of this object.       
    unbuffered_fetch_owner*: PmyBool

  TMySQL* = TstMysql
  PMySQL* = ptr TMySQL
  PstMysqlRes* = ptr TstMysqlRes
  TstMysqlRes*{.final.} = object 
    row_count*: MyUlonglong
    fields*: Pfield
    data*: Pdata
    data_cursor*: Prows
    lengths*: ptr Int         # column lengths of current row
    handle*: PMySQL                # for unbuffered reads
    field_alloc*: TMEM_ROOT
    field_count*: Cuint
    current_field*: Cuint
    row*: TROW                 # If unbuffered read
    current_row*: TROW         # buffer to current row
    eof*: MyBool             # Used by mysql_fetch_row
    unbuffered_fetch_cancelled*: MyBool # mysql_stmt_close() had to cancel this result
    methods*: PstMysqlMethods

  TRES* = TstMysqlRes
  Pres* = ptr TRES
  PstMysqlStmt* = ptr TstMysqlStmt
  Pstmt* = ptr TSTMT
  TstMysqlMethods*{.final.} = object 
    read_query_result*: proc (MySQL:  PMySQL): MyBool{.cdecl.}
    advanced_command*: proc (MySQL: PMySQL, command: TenumServerCommand, header: Cstring, 
                             header_length: Int, arg: Cstring, arg_length: Int, 
                             skip_check: MyBool): MyBool
    read_rows*: proc (MySQL: PMySQL, fields: Pfield, fields_count: Cuint): Pdata
    use_result*: proc (MySQL: PMySQL): Pres
    fetch_lengths*: proc (fto: ptr Int, column: TROW, field_count: Cuint)
    flush_use_result*: proc (MySQL: PMySQL)
    list_fields*: proc (MySQL: PMySQL): Pfield
    read_prepare_result*: proc (MySQL: PMySQL, stmt: Pstmt): MyBool
    stmt_execute*: proc (stmt: Pstmt): Cint
    read_binary_rows*: proc (stmt: Pstmt): Cint
    unbuffered_fetch*: proc (MySQL: PMySQL, row: CstringArray): Cint
    free_embedded_thd*: proc (MySQL: PMySQL)
    read_statistics*: proc (MySQL: PMySQL): Cstring
    next_result*: proc (MySQL: PMySQL): MyBool
    read_change_user_result*: proc (MySQL: PMySQL, buff: Cstring, passwd: Cstring): Cint
    read_rowsfrom_cursor*: proc (stmt: Pstmt): Cint

  TMETHODS* = TstMysqlMethods
  Pmethods* = ptr TMETHODS
  PstMysqlManager* = ptr TstMysqlManager
  TstMysqlManager*{.final.} = object 
    net*: TNET
    host*: Cstring
    user*: Cstring
    passwd*: Cstring
    port*: Cuint
    free_me*: MyBool
    eof*: MyBool
    cmd_status*: Cint
    last_errno*: Cint
    net_buf*: Cstring
    net_buf_pos*: Cstring
    net_data_end*: Cstring
    net_buf_size*: Cint
    last_error*: Array[0..(MAX_MYSQL_MANAGER_ERR) - 1, Char]

  TMANAGER* = TstMysqlManager
  Pmanager* = ptr TMANAGER
  PstMysqlParameters* = ptr TstMysqlParameters
  TstMysqlParameters*{.final.} = object 
    p_max_allowed_packet*: ptr Int
    p_net_buffer_length*: ptr Int

  TPARAMETERS* = TstMysqlParameters
  Pparameters* = ptr TPARAMETERS
  TenumMysqlStmtState* = enum 
    STMT_INIT_DONE = 1, STMT_PREPARE_DONE, STMT_EXECUTE_DONE, STMT_FETCH_DONE
  PstMysqlBind* = ptr TstMysqlBind
  TstMysqlBind*{.final.} = object 
    len*: Int                 # output length pointer
    is_null*: PmyBool        # Pointer to null indicator
    buffer*: Pointer          # buffer to get/put data
    error*: PmyBool          # set this if you want to track data truncations happened during fetch
    buffer_type*: TenumFieldTypes # buffer type
    buffer_length*: Int       # buffer length, must be set for str/binary
                              # Following are for internal use. Set by mysql_stmt_bind_param  
    row_ptr*: ptr Byte        # for the current data position
    offset*: Int              # offset position for char/binary fetch
    length_value*: Int        #  Used if length is 0
    param_number*: Cuint      # For null count and error messages
    pack_length*: Cuint       # Internal length for packed data
    error_value*: MyBool     # used if error is 0
    is_unsigned*: MyBool     # set if integer type is unsigned
    long_data_used*: MyBool  # If used with mysql_send_long_data
    is_null_value*: MyBool   # Used if is_null is 0
    store_param_func*: proc (net: Pnet, param: PstMysqlBind){.cdecl.}
    fetch_result*: proc (para1: PstMysqlBind, para2: Pfield, row: PPByte)
    skip_result*: proc (para1: PstMysqlBind, para2: Pfield, row: PPByte)

  TBIND* = TstMysqlBind
  Pbind* = ptr TBIND           # statement handler  
  TstMysqlStmt*{.final.} = object 
    mem_root*: TMEM_ROOT       # root allocations
    mysql*: PMySQL                      # connection handle
    params*: Pbind            # input parameters
    `bind`*: Pbind            # input parameters
    fields*: Pfield           # result set metadata
    result*: TDATA             # cached result set
    data_cursor*: Prows       # current row in cached result
    affected_rows*: MyUlonglong # copy of mysql->affected_rows after statement execution
    insert_id*: MyUlonglong
    read_row_func*: proc (stmt: PstMysqlStmt, row: PPByte): Cint{.cdecl.}
    stmt_id*: Int             # Id for prepared statement
    flags*: Int               # i.e. type of cursor to open
    prefetch_rows*: Int       # number of rows per one COM_FETCH
    server_status*: Cuint # Copied from mysql->server_status after execute/fetch to know
                          # server-side cursor status for this statement.
    last_errno*: Cuint        # error code
    param_count*: Cuint       # input parameter count
    field_count*: Cuint       # number of columns in result set
    state*: TenumMysqlStmtState # statement state
    last_error*: Array[0..(ERRMSG_SIZE) - 1, Char] # error message
    sqlstate*: Array[0..(SQLSTATE_LENGTH + 1) - 1, Char]
    send_types_to_server*: MyBool # Types of input parameters should be sent to server
    bind_param_done*: MyBool # input buffers were supplied
    bind_result_done*: Char   # output buffers were supplied
    unbuffered_fetch_cancelled*: MyBool
    update_max_length*: MyBool

  TSTMT* = TstMysqlStmt 
         
  TenumStmtAttrType* = enum 
    STMT_ATTR_UPDATE_MAX_LENGTH, STMT_ATTR_CURSOR_TYPE, STMT_ATTR_PREFETCH_ROWS

proc serverInit*(argc: Cint, argv: CstringArray, groups: CstringArray): Cint{.
    cdecl, dynlib: lib, importc: "mysql_server_init".}
proc serverEnd*(){.cdecl, dynlib: lib, importc: "mysql_server_end".}
  # mysql_server_init/end need to be called when using libmysqld or
  #      libmysqlclient (exactly, mysql_server_init() is called by mysql_init() so
  #      you don't need to call it explicitely; but you need to call
  #      mysql_server_end() to free memory). The names are a bit misleading
  #      (mysql_SERVER* to be used when using libmysqlCLIENT). So we add more general
  #      names which suit well whether you're using libmysqld or libmysqlclient. We
  #      intend to promote these aliases over the mysql_server* ones.     
proc libraryInit*(argc: Cint, argv: CstringArray, groups: CstringArray): Cint{.
    cdecl, dynlib: lib, importc: "mysql_server_init".}
proc libraryEnd*(){.cdecl, dynlib: lib, importc: "mysql_server_end".}
proc getParameters*(): Pparameters{.stdcall, dynlib: lib, 
                                     importc: "mysql_get_parameters".}
  # Set up and bring down a thread; these function should be called
  #      for each thread in an application which opens at least one MySQL
  #      connection.  All uses of the connection(s) should be between these
  #      function calls.     
proc threadInit*(): MyBool{.stdcall, dynlib: lib, importc: "mysql_thread_init".}
proc threadEnd*(){.stdcall, dynlib: lib, importc: "mysql_thread_end".}
  # Functions to get information from the MYSQL and MYSQL_RES structures
  #      Should definitely be used if one uses shared libraries.     
proc numRows*(res: Pres): MyUlonglong{.stdcall, dynlib: lib, 
    importc: "mysql_num_rows".}
proc numFields*(res: Pres): Cuint{.stdcall, dynlib: lib, 
                                    importc: "mysql_num_fields".}
proc eof*(res: Pres): MyBool{.stdcall, dynlib: lib, importc: "mysql_eof".}
proc fetchFieldDirect*(res: Pres, fieldnr: Cuint): Pfield{.stdcall, 
    dynlib: lib, importc: "mysql_fetch_field_direct".}
proc fetchFields*(res: Pres): Pfield{.stdcall, dynlib: lib, 
                                       importc: "mysql_fetch_fields".}
proc rowTell*(res: Pres): TROW_OFFSET{.stdcall, dynlib: lib, 
                                       importc: "mysql_row_tell".}
proc fieldTell*(res: Pres): TFIELD_OFFSET{.stdcall, dynlib: lib, 
    importc: "mysql_field_tell".}
proc fieldCount*(MySQL: PMySQL): Cuint{.stdcall, dynlib: lib, 
                               importc: "mysql_field_count".}
proc affectedRows*(MySQL: PMySQL): MyUlonglong{.stdcall, dynlib: lib, 
                                        importc: "mysql_affected_rows".}
proc insertId*(MySQL: PMySQL): MyUlonglong{.stdcall, dynlib: lib, 
                                    importc: "mysql_insert_id".}
proc errno*(MySQL: PMySQL): Cuint{.stdcall, dynlib: lib, importc: "mysql_errno".}
proc error*(MySQL: PMySQL): Cstring{.stdcall, dynlib: lib, importc: "mysql_error".}
proc sqlstate*(MySQL: PMySQL): Cstring{.stdcall, dynlib: lib, importc: "mysql_sqlstate".}
proc warningCount*(MySQL: PMySQL): Cuint{.stdcall, dynlib: lib, 
                                 importc: "mysql_warning_count".}
proc info*(MySQL: PMySQL): Cstring{.stdcall, dynlib: lib, importc: "mysql_info".}
proc threadId*(MySQL: PMySQL): Int{.stdcall, dynlib: lib, importc: "mysql_thread_id".}
proc characterSetName*(MySQL: PMySQL): Cstring{.stdcall, dynlib: lib, 
                                        importc: "mysql_character_set_name".}
proc setCharacterSet*(MySQL: PMySQL, csname: Cstring): Int32{.stdcall, dynlib: lib, 
    importc: "mysql_set_character_set".}
proc init*(MySQL: PMySQL): PMySQL{.stdcall, dynlib: lib, importc: "mysql_init".}
proc sslSet*(MySQL: PMySQL, key: Cstring, cert: Cstring, ca: Cstring, capath: Cstring, 
              cipher: Cstring): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_ssl_set".}
proc changeUser*(MySQL: PMySQL, user: Cstring, passwd: Cstring, db: Cstring): MyBool{.
    stdcall, dynlib: lib, importc: "mysql_change_user".}
proc realConnect*(MySQL: PMySQL, host: Cstring, user: Cstring, passwd: Cstring, 
                   db: Cstring, port: Cuint, unix_socket: Cstring, 
                   clientflag: Int): PMySQL{.stdcall, dynlib: lib, 
                                        importc: "mysql_real_connect".}
proc selectDb*(MySQL: PMySQL, db: Cstring): Cint{.stdcall, dynlib: lib, 
    importc: "mysql_select_db".}
proc query*(MySQL: PMySQL, q: Cstring): Cint{.stdcall, dynlib: lib, importc: "mysql_query".}
proc sendQuery*(MySQL: PMySQL, q: Cstring, len: Int): Cint{.stdcall, dynlib: lib, 
    importc: "mysql_send_query".}
proc realQuery*(MySQL: PMySQL, q: Cstring, len: Int): Cint{.stdcall, dynlib: lib, 
    importc: "mysql_real_query".}
proc storeResult*(MySQL: PMySQL): Pres{.stdcall, dynlib: lib, 
                               importc: "mysql_store_result".}
proc useResult*(MySQL: PMySQL): Pres{.stdcall, dynlib: lib, importc: "mysql_use_result".}
  # perform query on master  
proc masterQuery*(MySQL: PMySQL, q: Cstring, len: Int): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_master_query".}
proc masterSendQuery*(MySQL: PMySQL, q: Cstring, len: Int): MyBool{.stdcall, 
    dynlib: lib, importc: "mysql_master_send_query".}
  # perform query on slave  
proc slaveQuery*(MySQL: PMySQL, q: Cstring, len: Int): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_slave_query".}
proc slaveSendQuery*(MySQL: PMySQL, q: Cstring, len: Int): MyBool{.stdcall, 
    dynlib: lib, importc: "mysql_slave_send_query".}
proc getCharacterSetInfo*(MySQL: PMySQL, charset: PmyCharsetInfo){.stdcall, 
    dynlib: lib, importc: "mysql_get_character_set_info".}
  # local infile support  
const 
  LocalInfileErrorLen* = 512

# procedure mysql_set_local_infile_handler(mysql:PMYSQL; local_infile_init:function (para1:Ppointer; para2:Pchar; para3:pointer):longint; local_infile_read:function (para1:pointer; para2:Pchar; para3:dword):longint; local_infile_end:procedure (_pa
# para6:pointer);cdecl;external mysqllib name 'mysql_set_local_infile_handler';

proc setLocalInfileDefault*(MySQL: PMySQL){.cdecl, dynlib: lib, 
                                     importc: "mysql_set_local_infile_default".}
  # enable/disable parsing of all queries to decide if they go on master or
  #      slave     
proc enableRplParse*(MySQL: PMySQL){.stdcall, dynlib: lib, 
                             importc: "mysql_enable_rpl_parse".}
proc disableRplParse*(MySQL: PMySQL){.stdcall, dynlib: lib, 
                              importc: "mysql_disable_rpl_parse".}
  # get the value of the parse flag  
proc rplParseEnabled*(MySQL: PMySQL): Cint{.stdcall, dynlib: lib, 
                                    importc: "mysql_rpl_parse_enabled".}
  #  enable/disable reads from master  
proc enableReadsFromMaster*(MySQL: PMySQL){.stdcall, dynlib: lib, 
                                     importc: "mysql_enable_reads_from_master".}
proc disableReadsFromMaster*(MySQL: PMySQL){.stdcall, dynlib: lib, importc: "mysql_disable_reads_from_master".}
  # get the value of the master read flag  
proc readsFromMasterEnabled*(MySQL: PMySQL): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_reads_from_master_enabled".}
proc rplQueryType*(q: Cstring, length: Cint): TrplType{.stdcall, dynlib: lib, 
    importc: "mysql_rpl_query_type".}
  # discover the master and its slaves  
proc rplProbe*(MySQL: PMySQL): MyBool{.stdcall, dynlib: lib, importc: "mysql_rpl_probe".}
  # set the master, close/free the old one, if it is not a pivot  
proc setMaster*(MySQL: PMySQL, host: Cstring, port: Cuint, user: Cstring, passwd: Cstring): Cint{.
    stdcall, dynlib: lib, importc: "mysql_set_master".}
proc addSlave*(MySQL: PMySQL, host: Cstring, port: Cuint, user: Cstring, passwd: Cstring): Cint{.
    stdcall, dynlib: lib, importc: "mysql_add_slave".}
proc shutdown*(MySQL: PMySQL, shutdown_level: TenumShutdownLevel): Cint{.stdcall, 
    dynlib: lib, importc: "mysql_shutdown".}
proc dumpDebugInfo*(MySQL: PMySQL): Cint{.stdcall, dynlib: lib, 
                                  importc: "mysql_dump_debug_info".}
proc refresh*(MySQL: PMySQL, refresh_options: Cuint): Cint{.stdcall, dynlib: lib, 
    importc: "mysql_refresh".}
proc kill*(MySQL: PMySQL, pid: Int): Cint{.stdcall, dynlib: lib, importc: "mysql_kill".}
proc setServerOption*(MySQL: PMySQL, option: TenumMysqlSetOption): Cint{.stdcall, 
    dynlib: lib, importc: "mysql_set_server_option".}
proc ping*(MySQL: PMySQL): Cint{.stdcall, dynlib: lib, importc: "mysql_ping".}
proc stat*(MySQL: PMySQL): Cstring{.stdcall, dynlib: lib, importc: "mysql_stat".}
proc getServerInfo*(MySQL: PMySQL): Cstring{.stdcall, dynlib: lib, 
                                     importc: "mysql_get_server_info".}
proc getClientInfo*(): Cstring{.stdcall, dynlib: lib, 
                                  importc: "mysql_get_client_info".}
proc getClientVersion*(): Int{.stdcall, dynlib: lib, 
                                 importc: "mysql_get_client_version".}
proc getHostInfo*(MySQL: PMySQL): Cstring{.stdcall, dynlib: lib, 
                                   importc: "mysql_get_host_info".}
proc getServerVersion*(MySQL: PMySQL): Int{.stdcall, dynlib: lib, 
                                    importc: "mysql_get_server_version".}
proc getProtoInfo*(MySQL: PMySQL): Cuint{.stdcall, dynlib: lib, 
                                  importc: "mysql_get_proto_info".}
proc listDbs*(MySQL: PMySQL, wild: Cstring): Pres{.stdcall, dynlib: lib, 
    importc: "mysql_list_dbs".}
proc listTables*(MySQL: PMySQL, wild: Cstring): Pres{.stdcall, dynlib: lib, 
    importc: "mysql_list_tables".}
proc listProcesses*(MySQL: PMySQL): Pres{.stdcall, dynlib: lib, 
                                 importc: "mysql_list_processes".}
proc options*(MySQL: PMySQL, option: Toption, arg: Cstring): Cint{.stdcall, dynlib: lib, 
    importc: "mysql_options".}
proc freeResult*(result: Pres){.stdcall, dynlib: lib, 
                                 importc: "mysql_free_result".}
proc dataSeek*(result: Pres, offset: MyUlonglong){.stdcall, dynlib: lib, 
    importc: "mysql_data_seek".}
proc rowSeek*(result: Pres, offset: TROW_OFFSET): TROW_OFFSET{.stdcall, 
    dynlib: lib, importc: "mysql_row_seek".}
proc fieldSeek*(result: Pres, offset: TFIELD_OFFSET): TFIELD_OFFSET{.stdcall, 
    dynlib: lib, importc: "mysql_field_seek".}
proc fetchRow*(result: Pres): TROW{.stdcall, dynlib: lib, 
                                    importc: "mysql_fetch_row".}
proc fetchLengths*(result: Pres): ptr Int{.stdcall, dynlib: lib, 
    importc: "mysql_fetch_lengths".}
proc fetchField*(result: Pres): Pfield{.stdcall, dynlib: lib, 
    importc: "mysql_fetch_field".}
proc listFields*(MySQL: PMySQL, table: Cstring, wild: Cstring): Pres{.stdcall, 
    dynlib: lib, importc: "mysql_list_fields".}
proc escapeString*(fto: Cstring, `from`: Cstring, from_length: Int): Int{.
    stdcall, dynlib: lib, importc: "mysql_escape_string".}
proc hexString*(fto: Cstring, `from`: Cstring, from_length: Int): Int{.stdcall, 
    dynlib: lib, importc: "mysql_hex_string".}
proc realEscapeString*(MySQL: PMySQL, fto: Cstring, `from`: Cstring, len: Int): Int{.
    stdcall, dynlib: lib, importc: "mysql_real_escape_string".}
proc debug*(debug: Cstring){.stdcall, dynlib: lib, importc: "mysql_debug".}
  #    function mysql_odbc_escape_string(mysql:PMYSQL; fto:Pchar; to_length:dword; from:Pchar; from_length:dword;
  #               param:pointer; extend_buffer:function (para1:pointer; to:Pchar; length:Pdword):Pchar):Pchar;stdcall;external mysqllib name 'mysql_odbc_escape_string';
proc myodbcRemoveEscape*(MySQL: PMySQL, name: Cstring){.stdcall, dynlib: lib, 
    importc: "myodbc_remove_escape".}
proc threadSafe*(): Cuint{.stdcall, dynlib: lib, importc: "mysql_thread_safe".}
proc embedded*(): MyBool{.stdcall, dynlib: lib, importc: "mysql_embedded".}
proc managerInit*(con: Pmanager): Pmanager{.stdcall, dynlib: lib, 
    importc: "mysql_manager_init".}
proc managerConnect*(con: Pmanager, host: Cstring, user: Cstring, 
                      passwd: Cstring, port: Cuint): Pmanager{.stdcall, 
    dynlib: lib, importc: "mysql_manager_connect".}
proc managerClose*(con: Pmanager){.stdcall, dynlib: lib, 
                                    importc: "mysql_manager_close".}
proc managerCommand*(con: Pmanager, cmd: Cstring, cmd_len: Cint): Cint{.
    stdcall, dynlib: lib, importc: "mysql_manager_command".}
proc managerFetchLine*(con: Pmanager, res_buf: Cstring, res_buf_size: Cint): Cint{.
    stdcall, dynlib: lib, importc: "mysql_manager_fetch_line".}
proc readQueryResult*(MySQL: PMySQL): MyBool{.stdcall, dynlib: lib, 
                                       importc: "mysql_read_query_result".}
proc stmtInit*(MySQL: PMySQL): Pstmt{.stdcall, dynlib: lib, importc: "mysql_stmt_init".}
proc stmtPrepare*(stmt: Pstmt, query: Cstring, len: Int): Cint{.stdcall, 
    dynlib: lib, importc: "mysql_stmt_prepare".}
proc stmtExecute*(stmt: Pstmt): Cint{.stdcall, dynlib: lib, 
                                       importc: "mysql_stmt_execute".}
proc stmtFetch*(stmt: Pstmt): Cint{.stdcall, dynlib: lib, 
                                     importc: "mysql_stmt_fetch".}
proc stmtFetchColumn*(stmt: Pstmt, `bind`: Pbind, column: Cuint, offset: Int): Cint{.
    stdcall, dynlib: lib, importc: "mysql_stmt_fetch_column".}
proc stmtStoreResult*(stmt: Pstmt): Cint{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_store_result".}
proc stmtParamCount*(stmt: Pstmt): Int{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_param_count".}
proc stmtAttrSet*(stmt: Pstmt, attr_type: TenumStmtAttrType, attr: Pointer): MyBool{.
    stdcall, dynlib: lib, importc: "mysql_stmt_attr_set".}
proc stmtAttrGet*(stmt: Pstmt, attr_type: TenumStmtAttrType, attr: Pointer): MyBool{.
    stdcall, dynlib: lib, importc: "mysql_stmt_attr_get".}
proc stmtBindParam*(stmt: Pstmt, bnd: Pbind): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_bind_param".}
proc stmtBindResult*(stmt: Pstmt, bnd: Pbind): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_bind_result".}
proc stmtClose*(stmt: Pstmt): MyBool{.stdcall, dynlib: lib, 
                                        importc: "mysql_stmt_close".}
proc stmtReset*(stmt: Pstmt): MyBool{.stdcall, dynlib: lib, 
                                        importc: "mysql_stmt_reset".}
proc stmtFreeResult*(stmt: Pstmt): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_free_result".}
proc stmtSendLongData*(stmt: Pstmt, param_number: Cuint, data: Cstring, 
                          len: Int): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_send_long_data".}
proc stmtResultMetadata*(stmt: Pstmt): Pres{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_result_metadata".}
proc stmtParamMetadata*(stmt: Pstmt): Pres{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_param_metadata".}
proc stmtErrno*(stmt: Pstmt): Cuint{.stdcall, dynlib: lib, 
                                      importc: "mysql_stmt_errno".}
proc stmtError*(stmt: Pstmt): Cstring{.stdcall, dynlib: lib, 
                                        importc: "mysql_stmt_error".}
proc stmtSqlstate*(stmt: Pstmt): Cstring{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_sqlstate".}
proc stmtRowSeek*(stmt: Pstmt, offset: TROW_OFFSET): TROW_OFFSET{.stdcall, 
    dynlib: lib, importc: "mysql_stmt_row_seek".}
proc stmtRowTell*(stmt: Pstmt): TROW_OFFSET{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_row_tell".}
proc stmtDataSeek*(stmt: Pstmt, offset: MyUlonglong){.stdcall, dynlib: lib, 
    importc: "mysql_stmt_data_seek".}
proc stmtNumRows*(stmt: Pstmt): MyUlonglong{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_num_rows".}
proc stmtAffectedRows*(stmt: Pstmt): MyUlonglong{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_affected_rows".}
proc stmtInsertId*(stmt: Pstmt): MyUlonglong{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_insert_id".}
proc stmtFieldCount*(stmt: Pstmt): Cuint{.stdcall, dynlib: lib, 
    importc: "mysql_stmt_field_count".}
proc commit*(MySQL: PMySQL): MyBool{.stdcall, dynlib: lib, importc: "mysql_commit".}
proc rollback*(MySQL: PMySQL): MyBool{.stdcall, dynlib: lib, importc: "mysql_rollback".}
proc autocommit*(MySQL: PMySQL, auto_mode: MyBool): MyBool{.stdcall, dynlib: lib, 
    importc: "mysql_autocommit".}
proc moreResults*(MySQL: PMySQL): MyBool{.stdcall, dynlib: lib, 
                                  importc: "mysql_more_results".}
proc nextResult*(MySQL: PMySQL): Cint{.stdcall, dynlib: lib, importc: "mysql_next_result".}
proc close*(sock: PMySQL){.stdcall, dynlib: lib, importc: "mysql_close".}
  # status return codes  
const 
  NoData* = 100
  DataTruncated* = 101

proc reload*(MySQL: PMySQL): Cint
when defined(USE_OLD_FUNCTIONS): 
  proc connect*(MySQL: PMySQL, host: cstring, user: cstring, passwd: cstring): PMySQL{.stdcall, 
      dynlib: lib, importc: "mysql_connect".}
  proc create_db*(MySQL: PMySQL, DB: cstring): cint{.stdcall, dynlib: lib, 
      importc: "mysql_create_db".}
  proc drop_db*(MySQL: PMySQL, DB: cstring): cint{.stdcall, dynlib: lib, 
      importc: "mysql_drop_db".}
proc netSafeRead*(MySQL: PMySQL): Cuint{.cdecl, dynlib: lib, importc: "net_safe_read".}

proc isPriKey(n: int32): bool = 
  result = (n and PRI_KEY_FLAG) != 0

proc isNotNull(n: int32): bool = 
  result = (n and NOT_NULL_FLAG) != 0

proc isBlob(n: int32): bool = 
  result = (n and BLOB_FLAG) != 0

proc isNumField(f: pst_mysql_field): bool = 
  result = (f.flags and NUM_FLAG) != 0

proc isNum(t: Tenum_field_types): bool = 
  result = (t <= FieldTypeInt24) or (t == FieldTypeYear) or
      (t == FieldTypeNewdecimal)

proc internalNumField(f: Pst_mysql_field): bool = 
  result = (f.ftype <= FieldTypeInt24) and
      ((f.ftype != FieldTypeTimestamp) or (f.len == 14) or (f.len == 8)) or
      (f.ftype == FieldTypeYear)

proc reload(mysql: PMySQL): cint = 
  result = refresh(mySQL, REFRESH_GRANT)

{.pop.}
