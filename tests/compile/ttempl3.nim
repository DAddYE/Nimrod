
template withOpenFile(f: Expr, filename: String, mode: TFileMode,
                      actions: Stmt): Stmt {.immediate.} =
  block:
    # test that 'f' is implicitely 'injecting':
    var f: TFile
    if open(f, filename, mode):
      try:
        actions
      finally:
        close(f)
    else:
      quit("cannot open for writing: " & filename)
    
withOpenFile(txt, "ttempl3.txt", fmWrite):
  writeln(txt, "line 1")
  txt.writeln("line 2")
  
var
  myVar: Array[0..1, Int]

# Test zero argument template: 
template ha: Expr = myVar[0]
  
ha = 1  
echo(ha)


# Test identifier generation:
template prefix(name: Expr): Expr {.immediate.} = `"hu" name`

var `hu "XYZ"` = "yay"

echo prefix(XYZ)

template typedef(name: Expr, typ: TypeDesc) {.immediate, dirty.} =
  type
    `T name`* = typ
    `P name`* = ref `T name`
    
typedef(myint, Int)
var x: Pmyint


# Test UFCS

type
  Foo = object
    arg: Int

proc initFoo(arg: Int): Foo =
  result.arg = arg

template create(typ: TypeDesc, arg: Expr): Expr = `init typ`(arg)

var ff = Foo.create(12)

echo ff.arg
