discard """
  disabled: true
"""

# We start with a comment
# This is the same comment

# This is a new one!

import
  lexbase, os, strutils

type
  TMyRec {.final.} = object
    x, y: Int     # coordinates
    c: Char       # a character
    a: Int32      # an integer

  PMyRec = ref TMyRec # a reference to `TMyRec`

proc splitText(txt: String): Seq[String] # splits a text into several lines
                                         # the comment continues here
                                         # this is not easy to parse!

proc anotherSplit(txt: String): Seq[String] =
  # the comment should belong to `anotherSplit`!
  # another problem: comments are statements!

const
  x = 0B0_10001110100_0000101001000111101011101111111011000101001101001001'f64 # x ~~ 1.72826e35
  myNan = 0B01111111100000101100000000001000'f32 # NAN
  y = """
    a rather long text.
    Over many
    lines.
  """
  s = "\xff"
  a = {0..234}
  b = {0..high(int)}
  v = 0'i32
  z = 6767566'f32

# small test program for lexbase

proc main*(infile: String, a, b: Int, someverylongnamewithtype = 0,
           anotherlongthingie = 3) =
  var
    myInt: Int = 0
    s: Seq[String]
  # this should be an error!
  if initBaseLexer(L, infile, 30): nil
  else:
    writeln(stdout, "could not open: " & infile)
  writeln(stdout, "Success!")
  call(3, # we use 3
       12, # we use 12
       43) # we use 43
       

main(paramStr(1), 9, 0)
