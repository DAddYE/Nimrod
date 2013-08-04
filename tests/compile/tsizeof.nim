# Test the sizeof proc

type
  TMyRecord {.final.} = object
    x, y: Int
    b: Bool
    r: Float
    s: String

write(stdout, sizeof(TMyRecord))
