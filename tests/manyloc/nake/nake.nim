discard """
DO AS THOU WILST PUBLIC LICENSE

Whoever should stumble upon this document is henceforth and forever
entitled to DO AS THOU WILST with aforementioned document and the
contents thereof. 

As said in the Olde Country, `Keepe it Gangster'."""

import strutils, parseopt, tables, os

type
  PTask* = ref object
    desc*: String
    action*: TTaskFunction
  TTaskFunction* = proc() {.closure.}
var 
  tasks* = initTable[string, PTask](16)

proc newTask*(desc: String; action: TTaskFunction): PTask
proc runTask*(name: String) {.inline.}
proc shell*(cmd: Varargs[String, `$`]): Int {.discardable.}
proc cd*(dir: String) {.inline.}

template nakeImports*(): Stmt {.immediate.} =
  import tables, parseopt, strutils, os

template task*(name: String; description: String; body: Stmt): Stmt {.dirty, immediate.} =
  block:
    var t = newTask(description, proc() {.closure.} =
      body)
    tasks[name] = t

proc newTask*(desc: string; action: TTaskFunction): PTask =
  new(result)
  result.desc = desc
  result.action = action
proc runTask*(name: string) = tasks[name].action()

proc shell*(cmd: varargs[string, `$`]): int =
  result = execShellCmd(cmd.join(" "))
proc cd*(dir: string) = setCurrentDir(dir)
template withDir*(dir: String; body: Stmt): Stmt =
  ## temporary cd
  ## withDir "foo":
  ##   # inside foo
  ## #back to last dir
  var curDir = getCurrentDir()
  cd(dir)
  body
  cd(curDir)

when isMainModule:
  if not existsFile("nakefile.nim"):
    echo "No nakefile.nim found. Current working dir is ", getCurrentDir()
    quit 1
  var args = ""
  for i in 1..paramCount():
    args.add paramStr(i)
    args.add " "
  quit(shell("nimrod", "c", "-r", "nakefile.nim", args))
else:
  addQuitProc(proc() {.noconv.} =
    var 
      task: String
      printTaskList: Bool
    for kind, key, val in getopt():
      case kind
      of cmdLongOption, cmdShortOption:
        case key.toLower
        of "tasks", "t":
          printTaskList = true
        else: 
          echo "Unknown option: ", key, ": ", val
      of cmdArgument:
        task = key
      else: nil
    if printTaskList or task.isNil or not(tasks.hasKey(task)):
      echo "Available tasks:"
      for name, task in pairs(tasks):
        echo name, " - ", task.desc
      quit 0
    tasks[task].action())
