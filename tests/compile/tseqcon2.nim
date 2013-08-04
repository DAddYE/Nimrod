import os

proc recDir(dir: String): Seq[String] =
  result = @[]
  for kind, path in walkDir(dir):
    if kind == pcDir:
      add(result, recDir(path))
    else:
      add(result, path)
