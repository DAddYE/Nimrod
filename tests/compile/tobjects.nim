type
  TBase = object of TObject
    x, y: Int

  TSubclassKind = enum ka, kb, kc, kd, ke, kf
  TSubclass = object of TBase
    case c: TSubclassKind
    of ka, kb, kc, kd:
      a, b: Int
    of ke:
      d, e, f: Char
    else: nil
    n: Bool

type
  TMyObject = object of TObject
    case disp: Range[0..4]:
      of 0: arg: Char
      of 1: s: String
      else: wtf: Bool
      
var
  x: TMyObject

var
  global: Int

var
  s: String
  r: Float = 0.0
  i: Int = 500 + 400

case i
of 500..999: write(stdout, "ha!\n")
of 1000..3000, 12: write(stdout, "ganz schön groß\n")
of 1, 2, 3: write(stdout, "1 2 oder 3\n")
else: write(stdout, "sollte nicht passieren\n")

case readLine(stdin)
of "Rumpf": write(stdout, "Hallo Meister!\n")
of "Andreas": write(stdout, "Hallo Meister!\n")
else: write(stdout, "Nicht mein Meister!\n")

global = global + 1
write(stdout, "Hallo wie heißt du? \n")
s = readLine(stdin)
i = 0
while i < len(s):
  if s[i] == 'c': write(stdout, "'c' in deinem Namen gefunden\n")
  i = i + 1

write(stdout, "Du heißt " & s)
