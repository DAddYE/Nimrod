import os

proc getDllName: String = 
  result = "mylib.dll"
  if existsFile(result): return
  result = "mylib2.dll"
  if existsFile(result): return
  quit("could not load dynamic library")

proc myImport(s: Cstring) {.cdecl, importc, dynlib: getDllName().}
proc myImport2(s: Int) {.cdecl, importc, dynlib: getDllName().}

myImport("test2")
myImport2(12)


