#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## A higher level `PostgreSQL`:idx: database wrapper. This interface 
## is implemented for other databases too.

import strutils, postgres

type
  TDbConn* = PPGconn   ## encapsulates a database connection
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
  e.msg = $pQerrorMessage(db)
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
  var res = pQexec(db, q)
  result = pQresultStatus(res) == PgresCommandOk
  pQclear(res)

proc exec*(db: TDbConn, query: TSqlQuery, args: Varargs[String, `$`]) {.
  tags: [FReadDb, FWriteDb].} =
  ## executes the query and raises EDB if not successful.
  var q = dbFormat(query, args)
  var res = pQexec(db, q)
  if pQresultStatus(res) != PgresCommandOk: dbError(db)
  pQclear(res)
  
proc newRow(L: Int): TRow =
  newSeq(result, L)
  for i in 0..L-1: result[i] = ""
  
proc setupQuery(db: TDbConn, query: TSqlQuery, 
                args: Varargs[String]): PPGresult = 
  var q = dbFormat(query, args)
  result = pQexec(db, q)
  if pQresultStatus(result) != PgresTuplesOk: dbError(db)
  
proc setRow(res: PPGresult, r: var TRow, line, cols: Int32) =
  for col in 0..cols-1:
    setLen(r[col], 0)
    var x = pQgetvalue(res, line, col)
    add(r[col], x)
  
iterator fastRows*(db: TDbConn, query: TSqlQuery,
                   args: Varargs[String, `$`]): TRow {.tags: [FReadDb].} =
  ## executes the query and iterates over the result dataset. This is very 
  ## fast, but potenially dangerous: If the for-loop-body executes another
  ## query, the results can be undefined. For Postgres it is safe though.
  var res = setupQuery(db, query, args)
  var L = pQnfields(res)
  var result = newRow(L)
  for i in 0..pQntuples(res)-1:
    setRow(res, result, i, L)
    yield result
  pQclear(res)

proc getRow*(db: TDbConn, query: TSqlQuery,
             args: Varargs[String, `$`]): TRow {.tags: [FReadDb].} =
  ## retrieves a single row. If the query doesn't return any rows, this proc
  ## will return a TRow with empty strings for each column.
  var res = setupQuery(db, query, args)
  var L = pQnfields(res)
  result = newRow(L)
  setRow(res, result, 0, L)
  pQclear(res)

proc getAllRows*(db: TDbConn, query: TSqlQuery, 
                 args: Varargs[String, `$`]): Seq[TRow] {.tags: [FReadDb].} =
  ## executes the query and returns the whole result dataset.
  result = @[]
  for r in fastRows(db, query, args):
    result.add(r)

iterator rows*(db: TDbConn, query: TSqlQuery, 
               args: Varargs[String, `$`]): TRow {.tags: [FReadDb].} =
  ## same as `FastRows`, but slower and safe.
  for r in items(getAllRows(db, query, args)): yield r

proc getValue*(db: TDbConn, query: TSqlQuery, 
               args: Varargs[String, `$`]): String {.tags: [FReadDb].} = 
  ## executes the query and returns the first column of the first row of the
  ## result dataset. Returns "" if the dataset contains no rows or the database
  ## value is NULL.
  var x = pQgetvalue(setupQuery(db, query, args), 0, 0)
  result = if isNil(x): "" else: $x
  
proc tryInsertID*(db: TDbConn, query: TSqlQuery, 
                  args: Varargs[String, `$`]): Int64  {.tags: [FWriteDb].}=
  ## executes the query (typically "INSERT") and returns the 
  ## generated ID for the row or -1 in case of an error. For Postgre this adds
  ## ``RETURNING id`` to the query, so it only works if your primary key is
  ## named ``id``. 
  var x = pQgetvalue(setupQuery(db, TSqlQuery(String(query) & " RETURNING id"), 
    args), 0, 0)
  if not isNil(x):
    result = parseBiggestInt($x)
  else:
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
                       args: Varargs[String, `$`]): Int64 {.tags: [
                       FReadDb, FWriteDb].} = 
  ## executes the query (typically "UPDATE") and returns the
  ## number of affected rows.
  var q = dbFormat(query, args)
  var res = pQexec(db, q)
  if pQresultStatus(res) != PgresCommandOk: dbError(db)
  result = parseBiggestInt($pQcmdTuples(res))
  pQclear(res)

proc close*(db: TDbConn) {.tags: [FDb].} = 
  ## closes the database connection.
  if db != nil: pQfinish(db)

proc open*(connection, user, password, database: String): TDbConn {.
  tags: [FDb].} =
  ## opens a database connection. Raises `EDb` if the connection could not
  ## be established.
  result = pQsetdbLogin(nil, nil, nil, nil, database, user, password)
  if pQstatus(result) != ConnectionOk: dbError(result) # result = nil


