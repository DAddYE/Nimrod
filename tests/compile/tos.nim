# test some things of the os module

import os

proc walkDirTree(root: String) = 
  for k, f in walkDir(root):
    case k 
    of pcFile, pcLinkToFile: echo(f)
    of pcDir: walkDirTree(f)
    of pcLinkToDir: nil

walkDirTree(".")
