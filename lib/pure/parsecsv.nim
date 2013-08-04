#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2009 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements a simple high performance `CSV`:idx:
## (`comma separated value`:idx:) parser. 
##
## Example: How to use the parser
## ==============================
##
## .. code-block:: nimrod
##   import os, parsecsv, streams
##   var s = newFileStream(ParamStr(1), fmRead)
##   if s == nil: quit("cannot open the file" & ParamStr(1))
##   var x: TCsvParser
##   open(x, s, ParamStr(1))
##   while readRow(x):
##     Echo "new row: "
##     for val in items(x.row):
##       Echo "##", val, "##"
##   close(x)
##

import
  lexbase, streams

type
  TCsvRow* = Seq[String] ## a row in a CSV file
  TCsvParser* = object of TBaseLexer ## the parser object.
    row*: TCsvRow                    ## the current row
    filename: String
    sep, quote, esc: Char
    skipWhite: Bool
    currRow: Int

  EInvalidCsv* = object of Eio ## exception that is raised if
                               ## a parsing error occurs

proc raiseEInvalidCsv(filename: String, line, col: Int, 
                      msg: String) {.noreturn.} =
  var e: ref EInvalidCsv
  new(e)
  e.msg = filename & "(" & $line & ", " & $col & ") Error: " & msg
  raise e

proc error(my: TCsvParser, pos: Int, msg: String) = 
  raiseEInvalidCsv(my.filename, my.LineNumber, getColNumber(my, pos), msg)

proc open*(my: var TCsvParser, input: PStream, filename: String,
           separator = ',', quote = '"', escape = '\0',
           skipInitialSpace = false) =
  ## initializes the parser with an input stream. `Filename` is only used
  ## for nice error messages. The parser's behaviour can be controlled by
  ## the diverse optional parameters:
  ## - `separator`: character used to separate fields
  ## - `quote`: Used to quote fields containing special characters like 
  ##   `separator`, `quote` or new-line characters. '\0' disables the parsing
  ##   of quotes.
  ## - `escape`: removes any special meaning from the following character; 
  ##   '\0' disables escaping; if escaping is disabled and `quote` is not '\0',
  ##   two `quote` characters are parsed one literal `quote` character.
  ## - `skipInitialSpace`: If true, whitespace immediately following the 
  ##   `separator` is ignored.
  lexbase.open(my, input)
  my.filename = filename
  my.sep = separator
  my.quote = quote
  my.esc = escape
  my.skipWhite = skipInitialSpace
  my.row = @[]
  my.currRow = 0

proc parseField(my: var TCsvParser, a: var String) = 
  var pos = my.bufpos
  var buf = my.buf
  if my.skipWhite:
    while buf[pos] in {' ', '\t'}: inc(pos)
  setLen(a, 0) # reuse memory
  if buf[pos] == my.quote and my.quote != '\0': 
    inc(pos)
    while true: 
      var c = buf[pos]
      if c == '\0':
        my.bufpos = pos # can continue after exception?
        error(my, pos, my.quote & " expected")
        break
      elif c == my.quote: 
        if my.esc == '\0' and buf[pos+1] == my.quote:
          add(a, my.quote)
          inc(pos, 2)
        else:
          inc(pos)
          break
      elif c == my.esc:
        add(a, buf[pos+1])
        inc(pos, 2)
      else:
        case c
        of '\c': 
          pos = handleCR(my, pos)
          buf = my.buf
          add(a, "\n")
        of '\l': 
          pos = handleLF(my, pos)
          buf = my.buf
          add(a, "\n")
        else:
          add(a, c)
          inc(pos)
  else:
    while true:
      var c = buf[pos]
      if c == my.sep: break
      if c in {'\c', '\l', '\0'}: break
      add(a, c)
      inc(pos)
  my.bufpos = pos

proc processedRows*(my: var TCsvParser): Int = 
  ## returns number of the processed rows
  return my.currRow

proc readRow*(my: var TCsvParser, columns = 0): Bool = 
  ## reads the next row; if `columns` > 0, it expects the row to have
  ## exactly this many columns. Returns false if the end of the file
  ## has been encountered else true.
  var col = 0 # current column
  var oldpos = my.bufpos
  while my.buf[my.bufpos] != '\0':
    var oldlen = my.row.len
    if oldlen < col+1:
      setLen(my.row, col+1)
      my.row[col] = ""
    parseField(my, my.row[col])
    inc(col)
    if my.buf[my.bufpos] == my.sep: 
      inc(my.bufpos)
    else:
      case my.buf[my.bufpos]
      of '\c', '\l': 
        # skip empty lines:
        while true: 
          case my.buf[my.bufpos]
          of '\c': my.bufpos = handleCR(my, my.bufpos)
          of '\l': my.bufpos = handleLF(my, my.bufpos)
          else: break
      of '\0': nil
      else: error(my, my.bufpos, my.sep & " expected")
      break
  
  setLen(my.row, col)
  result = col > 0
  if result and col != columns and columns > 0: 
    error(my, oldpos+1, $columns & " columns expected, but found " & 
          $col & " columns")
  inc(my.currRow)
  
proc close*(my: var TCsvParser) {.inline.} = 
  ## closes the parser `my` and its associated input stream.
  lexbase.close(my)

when isMainModule:
  import os
  var s = newFileStream(paramStr(1), fmRead)
  if s == nil: quit("cannot open the file" & paramStr(1))
  var x: TCsvParser
  open(x, s, paramStr(1))
  while readRow(x):
    echo "new row: "
    for val in items(x.row):
      echo "##", val, "##"
  close(x)

