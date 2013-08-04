#
#
#            Nimrod Benchmark tool
#        (c) Copyright 2012 Dominik Picheta
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This program runs benchmarks
import osproc, os, times, json

type
  TBenchResult = tuple[file: String, success: Bool, time: Float]

proc compileBench(file: String) =
  ## Compiles ``file``.
  doAssert(execCmdEx("nimrod c -d:release " & file).exitCode == QuitSuccess)

proc runBench(file: String): TBenchResult =
  ## Runs ``file`` and returns info on how long it took to run.
  var start = epochTime()
  if execCmdEx(file.addFileExt(ExeExt)).exitCode == QuitSuccess:
    var t = epochTime() - start
    result = (file, true, t)
  else: result = (file, false, -1.0)

proc genOutput(benches: Seq[TBenchResult]): PJsonNode =
  result = newJObject()
  for i in benches:
    if i.success:
      result[i.file.extractFilename] = newJFloat(i.time)
    else:
      result[i.file.extractFilename] = newJNull()

proc doBench(): Seq[TBenchResult] =
  result = @[]
  for i in walkFiles("tests/benchmarks/*.nim"):
    echo(i.extractFilename)
    compileBench(i)
    result.add(runBench(i))

when isMainModule:
  var b = doBench()
  var output = genOutput(b)
  writeFile("benchmarkResults.json", pretty(output))
  
