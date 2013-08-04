#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## A higher level `SQLite`:idx: database wrapper. This interface 
## is implemented for other databases too.

import strutils, sqlite3

type
  TDbConn* = PSqlite3  ## encapsulates a database connection
  TRow* = Seq[String]  ## a row of a dataset. NULL database values will be
                       ## transformed always to the empty string.
  EDb* = object of Eio ## exception that is raised if a database error occurs
  
  TSqlQuery* = distinct String ## an SQL query string
  
  FDb* = object of Fio ## effect that denotes a database operation
  FReadDb* = object of FDb   ## effect that denotes a read operation
  FWriteDb* = object of FDb  ## effect that denotes a write operation
  
proc sql*(query: String): TSqlQuery {.noSideEffect, inline.} =  
  ## constructs a TSqlQuery from the string `query`. This is supposed to be 
  ## used as a raw-string-literal modifier:
  ## ``sql"update user set counter = counter + 1"``
  ##
  ## If assertions are turned off, it does nothing. If assertions are turned 
  ## on, later versions will check the string for valid syntax.
  result = TSqlQuery(query)
 
proc dbError(db: TDbConn) {.noreturn.} = 
  ## raises an EDb exception.
  var e: ref EDb
  new(e)
  e.msg = $sqlite3.errmsg(db)
  raise e

proc dbError*(msg: String) {.noreturn.} = 
  ## raises an EDb exception with message `msg`.
  var e: ref EDb
  new(e)
  e.msg = msg
  raise e

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
  
proc tryExec*(db: TDbConn, query: TSqlQuery, 
              args: Varargs[String, `$`]): Bool {.tags: [FReadDb, FWriteDb].} =
  ## tries to execute the query and returns true if successful, false otherwise.
  var q = dbFormat(query, args)
  var stmt: sqlite3.PStmt
  if prepareV2(db, q, q.len.Cint, stmt, nil) == SQLITE_OK:
    if step(stmt) == SQLITE_DONE:
      result = finalize(stmt) == SQLITE_OK

proc exec*(db: TDbConn, query: TSqlQuery, args: Varargs[String, `$`])  {.
  tags: [FReadDb, FWriteDb].} =
  ## executes the query and raises EDB if not successful.
  if not tryExec(db, query, args): dbError(db)
  
proc newRow(L: Int): TRow =
  newSeq(result, L)
  for i in 0..L-1: result[i] = ""
  
proc setupQuery(db: TDbConn, query: TSqlQuery, 
                args: Varargs[String]): Pstmt = 
  var q = dbFormat(query, args)
  if prepareV2(db, q, q.len.Cint, result, nil) != SQLITE_OK: dbError(db)
  
proc setRow(stmt: Pstmt, r: var TRow, cols: Cint) =
  for col in 0..cols-1:
    setLen(r[col], columnBytes(stmt, col)) # set capacity
    setLen(r[col], 0)
    let x = columnText(stmt, col)
    if not isNil(x): add(r[col], x)
  
iterator fastRows*(db: TDbConn, query: TSqlQuery,
                   args: Varargs[String, `$`]): TRow  {.tags: [FReadDb].} =
  ## executes the query and iterates over the result dataset. This is very 
  ## fast, but potenially dangerous: If the for-loop-body executes another
  ## query, the results can be undefined. For Sqlite it is safe though.
  var stmt = setupQuery(db, query, args)
  var L = (columnCount(stmt))
  var result = newRow(L)
  while step(stmt) == SQLITE_ROW: 
    setRow(stmt, result, L)
    yield result
  if finalize(stmt) != SQLITE_OK: dbError(db)

proc getRow*(db: TDbConn, query: TSqlQuery,
             args: Varargs[String, `$`]): TRow {.tags: [FReadDb].} =
  ## retrieves a single row. If the query doesn't return any rows, this proc
  ## will return a TRow with empty strings for each column.
  var stmt = setupQuery(db, query, args)
  var L = (columnCount(stmt))
  result = newRow(L)
  if step(stmt) == SQLITE_ROW: 
    setRow(stmt, result, L)
  if finalize(stmt) != SQLITE_OK: dbError(db)

proc getAllRows*(db: TDbConn, query: TSqlQuery, 
                 args: Varargs[String, `$`]): Seq[TRow] {.tags: [FReadDb].} =
  ## executes the query and returns the whole result dataset.
  result = @[]
  for r in fastRows(db, query, args):
    result.add(r)

iterator rows*(db: TDbConn, query: TSqlQuery, 
               args: Varargs[String, `$`]): TRow {.tags: [FReadDb].} =
  ## same as `FastRows`, but slower and safe.
  for r in fastRows(db, query, args): yield r

proc getValue*(db: TDbConn, query: TSqlQuery, 
               args: Varargs[String, `$`]): String {.tags: [FReadDb].} = 
  ## executes the query and returns the first column of the first row of the
  ## result dataset. Returns "" if the dataset contains no rows or the database
  ## value is NULL.
  var stmt = setupQuery(db, query, args)
  if step(stmt) == SQLITE_ROW:
    let cb = columnBytes(stmt, 0)
    if cb == 0: 
      result = ""
    else:
      result = newStringOfCap(cb)
      add(result, columnText(stmt, 0))
    if finalize(stmt) != SQLITE_OK: dbError(db)
  else:
    result = ""
  
proc tryInsertID*(db: TDbConn, query: TSqlQuery, 
                  args: Varargs[String, `$`]): Int64 {.tags: [FWriteDb].} =
  ## executes the query (typically "INSERT") and returns the 
  ## generated ID for the row or -1 in case of an error. 
  var q = dbFormat(query, args)
  var stmt: sqlite3.PStmt
  if prepareV2(db, q, q.len.Cint, stmt, nil) == SQLITE_OK:
    if step(stmt) == SQLITE_DONE:
      if finalize(stmt) == SQLITE_OK:
        return lastInsertRowid(db)
  result = -1

proc insertID*(db: TDbConn, query: TSqlQuery, 
               args: Varargs[String, `$`]): Int64 {.tags: [FWriteDb].} = 
  ## executes the query (typically "INSERT") and returns the 
  ## generated ID for the row. For Postgre this adds
  ## ``RETURNING id`` to the query, so it only works if your primary key is
  ## named ``id``. 
  result = tryInsertID(db, query, args)
  if result < 0: dbError(db)
  
proc execAffectedRows*(db: TDbConn, query: TSqlQuery, 
                       args: Varargs[String, `$`]): Int64 {.
                       tags: [FReadDb, FWriteDb].} = 
  ## executes the query (typically "UPDATE") and returns the
  ## number of affected rows.
  exec(db, query, args)
  result = changes(db)

proc close*(db: TDbConn) {.tags: [FDb].} = 
  ## closes the database connection.
  if sqlite3.close(db) != SQLITE_OK: dbError(db)
    
proc open*(connection, user, password, database: String): TDbConn {.
  tags: [FDb].} =
  ## opens a database connection. Raises `EDb` if the connection could not
  ## be established. Only the ``connection`` parameter is used for ``sqlite``.
  var db: TDbConn
  if sqlite3.open(connection, db) == SQLITE_OK:
    result = db
  else:
    dbError(db)
   
when isMainModule:
  var db = open("db.sql", "", "", "")
  Exec(db, sql"create table tbl1(one varchar(10), two smallint)", [])
  exec(db, sql"insert into tbl1 values('hello!',10)", [])
  exec(db, sql"insert into tbl1 values('goodbye', 20)", [])
  #db.query("create table tbl1(one varchar(10), two smallint)")
  #db.query("insert into tbl1 values('hello!',10)")
  #db.query("insert into tbl1 values('goodbye', 20)")
  for r in db.rows(sql"select * from tbl1", []):
    echo(r[0], r[1])
  
  db_sqlite.close(db)
