var
  x: Array [0..2, Int]

x = [0, 1, 2]

type
  TStringDesc {.final.} = object
    len, space: Int # len and space without counting the terminating zero
    data: Array [0..0, Char] # for the '\0' character

var
  emptyString {.exportc: "emptyString".}: TStringDesc 


