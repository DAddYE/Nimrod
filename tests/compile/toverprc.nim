# Test overloading of procs when used as function pointers

import strutils

proc parseInt(x: Float): Int {.noSideEffect.} = nil
proc parseInt(x: Bool): Int {.noSideEffect.} = nil
proc parseInt(x: Float32): Int {.noSideEffect.} = nil
proc parseInt(x: Int8): Int {.noSideEffect.} = nil
proc parseInt(x: TFile): Int {.noSideEffect.} = nil
proc parseInt(x: Char): Int {.noSideEffect.} = nil
proc parseInt(x: Int16): Int {.noSideEffect.} = nil

proc parseInt[T](x: T): Int = echo x; 34

type
  TParseInt = proc (x: String): Int {.noSideEffect.}

var
  q = TParseInt(parseInt)
  p: TParseInt = parseInt

proc takeParseInt(x: proc (y: String): Int {.noSideEffect.}): Int = 
  result = x("123")
  
echo "Give a list of numbers (separated by spaces): "
var x = stdin.readLine.split.map(parseInt).max
echo x, " is the maximum!"
echo "another number: ", takeParseInt(parseInt)


type
  TFoo[A,B] = object
    lorem: a
    ipsum: b

proc bar[A,B](f: TFoo[a,b], x: a) = echo(x, " ", f.lorem, f.ipsum)
proc bar[A,B](f: TFoo[a,b], x: b) = echo(x, " ", f.lorem, f.ipsum)

discard parseInt[string]("yay")
