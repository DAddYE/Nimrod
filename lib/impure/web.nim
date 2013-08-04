#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module contains simple high-level procedures for dealing with the
## web. Use cases: 
##
## * requesting URLs
## * sending and retrieving emails
## * sending and retrieving files from an FTP server
##
## Currently only requesting URLs is implemented. The implementation depends
## on the libcurl library!
##
## **Deprecated since version 0.8.8:** Use the
## `httpclient <httpclient.html>`_ module instead. 
## 

{.deprecated.}

import libcurl, streams

proc curlwrapperWrite(p: Pointer, size, nmemb: Int, 
                      data: Pointer): Int {.cdecl.} = 
  var stream = cast[PStream](data)
  stream.writeData(p, size*nmemb)
  return size*nmemb

proc uRLretrieveStream*(url: String): PStream = 
  ## retrieves the given `url` and returns a stream which one can read from to
  ## obtain the contents. Returns nil if an error occurs.
  result = newStringStream()
  var hCurl = easyInit() 
  if hCurl == nil: return nil
  if easySetopt(hCurl, OptUrl, url) != EOk: return nil
  if easySetopt(hCurl, OptWritefunction, 
                      curlwrapperWrite) != EOk: return nil
  if easySetopt(hCurl, OptWritedata, result) != EOk: return nil
  if easyPerform(hCurl) != EOk: return nil
  easyCleanup(hCurl)
  
proc uRLretrieveString*(url: String): TaintedString = 
  ## retrieves the given `url` and returns the contents. Returns nil if an
  ## error occurs.
  var stream = newStringStream()
  var hCurl = easyInit()
  if hCurl == nil: return
  if easySetopt(hCurl, OptUrl, url) != EOk: return
  if easySetopt(hCurl, OptWritefunction, 
                      curlwrapperWrite) != EOk: return
  if easySetopt(hCurl, OptWritedata, stream) != EOk: return
  if easyPerform(hCurl) != EOk: return
  easyCleanup(hCurl)
  result = stream.data.TaintedString

when isMainModule:
  echo uRLretrieveString("http://nimrod-code.org/")

