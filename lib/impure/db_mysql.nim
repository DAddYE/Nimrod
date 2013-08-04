#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## A higher level `mySQL`:idx: database wrapper. The same interface is 
## implemented for other databases too.

import strutils, mysql

type
  TDbConn* = PMySQL    ## encapsulates a database connection
  TRow* = Seq[String]  ## a row of a dataset. NULL database values will be
                       ## transformed always to the empty string.
  EDb* = object of Eio ## exception that is raised if a database error occurs

  TSqlQuery* = distinct String ## an SQL query string

  FDb* = object of Fio ## effect that denotes a database operation
  FReadDb* = object of FDb   ## effect that denotes a read operation
  FWriteDb* = object of FDb  ## effect that denotes a write operation

proc dbError(db: TDbConn) {.noreturn.} = 
  ## raises an EDb exception.
  var e: ref EDb
  new(e)
  e.msg = $mysql.error(db)
  raise e

proc dbError*(msg: String) {.noreturn.} = 
  ## raises an EDb exception with message `msg`.
  var e: ref EDb
  new(e)
  e.msg = msg
  raise e

when false:
  proc dbQueryOpt*(db: TDbConn, query: string, args: varargs[string, `$`]) =
    var stmt = mysql_stmt_init(db)
    if stmt == nil: dbError(db)
    if mysql_stmt_prepare(stmt, query, len(query)) != 0: 
      dbError(db)
    var 
      binding: seq[MYSQL_BIND]
    discard mysql_stmt_close(stmt)

proc dbQuote(s: String): String =
  result = "'"
  for c in items(s):
    if c == '\'': add(result, "''")
    else: add(result, c)
  add(result, '\'')

proc dbFormat(formatstr: TSqlQuery, args: Varargs[String]): String =
  result = ""
  var a = 0
  for c in items(String(formatstr)):
    if c == '?':
      add(result, dbQuote(args[a]))
      inc(a)
    else: 
      add(result, c)
  
proc tryExec*(db: TDbConn, query: TSqlQuery, args: Varargs[String, `$`]): Bool {.
  tags: [FReadDb, FWriteDb].} =
  ## tries to execute the query and returns true if successful, false otherwise.
  var q = dbFormat(query, args)
  return mysql.RealQuery(db, q, q.len) == 0'i32

proc rawExec(db: TDbConn, query: TSqlQuery, args: Varargs[String, `$`]) =
  var q = dbFormat(query, args)
  if mysql.RealQuery(db, q, q.len) != 0'i32: dbError(db)

proc exec*(db: TDbConn, query: TSqlQuery, args: Varargs[String, `$`]) {.
  tags: [FReadDb, FWriteDb].} =
  ## executes the query and raises EDB if not successful.
  var q = dbFormat(query, args)
  if mysql.RealQuery(db, q, q.len) != 0'i32: dbError(db)
    
proc newRow(L: Int): TRow = 
  newSeq(result, L)
  for i in 0..L-1: result[i] = ""
  
proc properFreeResult(sqlres: mysql.PRES, row: CstringArray) =  
  if row != nil:
    while mysql.FetchRow(sqlres) != nil: nil
  mysql.FreeResult(sqlres)
  
iterator fastRows*(db: TDbConn, query: TSqlQuery,
                   args: Varargs[String, `$`]): TRow {.tags: [FReadDb].} =
  ## executes the query and iterates over the result dataset. This is very 
  ## fast, but potenially dangerous: If the for-loop-body executes another
  ## query, the results can be undefined. For MySQL this is the case!.
  rawExec(db, query, args)
  var sqlres = mysql.UseResult(db)
  if sqlres != nil:
    var L = Int(mysql.NumFields(sqlres))
    var result = newRow(L)
    var row: CstringArray
    while true:
      row = mysql.FetchRow(sqlres)
      if row == nil: break
      for i in 0..L-1: 
        setLen(result[i], 0)
        add(result[i], row[i])
      yield result
    properFreeResult(sqlres, row)

proc getRow*(db: TDbConn, query: TSqlQuery,
             args: Varargs[String, `$`]): TRow {.tags: [FReadDb].} =
  ## retrieves a single row. If the query doesn't return any rows, this proc
  ## will return a TRow with empty strings for each column.
  rawExec(db, query, args)
  var sqlres = mysql.UseResult(db)
  if sqlres != nil:
    var L = Int(mysql.NumFields(sqlres))
    result = newRow(L)
    var row = mysql.FetchRow(sqlres)
    if row != nil: 
      for i in 0..L-1: 
        setLen(result[i], 0)
        add(result[i], row[i])
    properFreeResult(sqlres, row)

proc getAllRows*(db: TDbConn, query: TSqlQuery, 
                 args: Varargs[String, `$`]): Seq[TRow] {.tags: [FReadDb].} =
  ## executes the query and returns the whole result dataset.
  result = @[]
  rawExec(db, query, args)
  var sqlres = mysql.UseResult(db)
  if sqlres != nil:
    var L = Int(mysql.NumFields(sqlres))
    var row: CstringArray
    var j = 0
    while true:
      row = mysql.FetchRow(sqlres)
      if row == nil: break
      setLen(result, j+1)
      newSeq(result[j], L)
      for i in 0..L-1: result[j][i] = $row[i]
      inc(j)
    mysql.FreeResult(sqlres)

iterator rows*(db: TDbConn, query: TSqlQuery, 
               args: Varargs[String, `$`]): TRow {.tags: [FReadDb].} =
  ## same as `FastRows`, but slower and safe.
  for r in items(getAllRows(db, query, args)): yield r

proc getValue*(db: TDbConn, query: TSqlQuery, 
               args: Varargs[String, `$`]): String {.tags: [FReadDb].} = 
  ## executes the query and returns the first column of the first row of the
  ## result dataset. Returns "" if the dataset contains no rows or the database
  ## value is NULL.
  result = ""
  for row in fastRows(db, query, args): 
    result = row[0]
    break

proc tryInsertID*(db: TDbConn, query: TSqlQuery, 
                  args: Varargs[String, `$`]): Int64 {.tags: [FWriteDb].} =
  ## executes the query (typically "INSERT") and returns the 
  ## generated ID for the row or -1 in case of an error.
  var q = dbFormat(query, args)
  if mysql.RealQuery(db, q, q.len) != 0'i32: 
    result = -1'i64
  else:
    result = mysql.InsertId(db)
  
proc insertID*(db: TDbConn, query: TSqlQuery, 
               args: Varargs[String, `$`]): Int64 {.tags: [FWriteDb].} = 
  ## executes the query (typically "INSERT") and returns the 
  ## generated ID for the row.
  result = tryInsertID(db, query, args)
  if result < 0: dbError(db)

proc execAffectedRows*(db: TDbConn, query: TSqlQuery, 
                       args: Varargs[String, `$`]): Int64 {.
                       tags: [FReadDb, FWriteDb].} = 
  ## runs the query (typically "UPDATE") and returns the
  ## number of affected rows
  rawExec(db, query, args)
  result = mysql.AffectedRows(db)

proc close*(db: TDbConn) {.tags: [FDb].} = 
  ## closes the database connection.
  if db != nil: mysql.Close(db)

proc open*(connection, user, password, database: String): TDbConn {.
  tags: [FDb].} =
  ## opens a database connection. Raises `EDb` if the connection could not
  ## be established.
  result = mysql.Init(nil)
  if result == nil: dbError("could not open database connection") 
  if mysql.RealConnect(result, "", user, password, database, 
                       0'i32, nil, 0) == nil:
    var errmsg = $mysql.error(result)
    db_mysql.Close(result)
    dbError(errmsg)

