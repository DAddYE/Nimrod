import 
  libcurl

var hCurl = easyInit()
if hCurl != nil: 
  discard easySetopt(hCurl, OptVerbose, true)
  discard easySetopt(hCurl, OptUrl, "http://force7.de/nimrod")
  discard easyPerform(hCurl)
  easyCleanup(hCurl)

