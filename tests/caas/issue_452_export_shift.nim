const
  VersionStr1* = "0.5.0" ## Idetools shifts this one column.
  VersionStr2 = "0.5.0" ## This one is ok.
  VersionStr3* = "0.5.0" ## Bad.
  VersionStr4 = "0.5.0" ## Ok.

proc forward1*(): String = result = ""
proc forward2(): String = result = ""
