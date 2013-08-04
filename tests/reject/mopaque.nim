type
  TLexer* {.final.} = object
    line*: Int
    filename*: String
    buffer: Cstring

proc noProcVar*(): Int = 18
