#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2012 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements helper procs for parsing Cookies.

import strtabs, times

proc parseCookies*(s: String): PStringTable = 
  ## parses cookies into a string table.
  result = newStringTable(modeCaseInsensitive)
  var i = 0
  while true:
    while s[i] == ' ' or s[i] == '\t': inc(i)
    var keystart = i
    while s[i] != '=' and s[i] != '\0': inc(i)
    var keyend = i-1
    if s[i] == '\0': break
    inc(i) # skip '='
    var valstart = i
    while s[i] != ';' and s[i] != '\0': inc(i)
    result[substr(s, keystart, keyend)] = substr(s, valstart, i-1)
    if s[i] == '\0': break
    inc(i) # skip ';'

proc setCookie*(key, value: String, domain = "", path = "", 
                expires = "", noName = false): String =
  ## Creates a command in the format of 
  ## ``Set-Cookie: key=value; Domain=...; ...``
  result = ""
  if not noName: result.add("Set-Cookie: ")
  result.add key & "=" & value
  if domain != "": result.add("; Domain=" & domain)
  if path != "": result.add("; Path=" & path)
  if expires != "": result.add("; Expires=" & expires)

proc setCookie*(key, value: String, expires: TTimeInfo,
                domain = "", path = "", noName = false): String =
  ## Creates a command in the format of 
  ## ``Set-Cookie: key=value; Domain=...; ...``
  ##
  ## **Note:** UTC is assumed as the timezone for ``expires``.
  
  return setCookie(key, value, domain, path,
            format(expires, "ddd',' dd MMM yyyy HH:mm:ss 'UTC'"), noName)
  
when isMainModule:
  var tim = TTime(int(getTime()) + 76 * (60 * 60 * 24))

  echo(setCookie("test", "value", tim.getGMTime()))
  
  echo parseCookies("uid=1; kp=2")
  
                
