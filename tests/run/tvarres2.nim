discard """
  output: "45 hallo"
"""

type
  TKachel = tuple[i: Int, s: String]
  TSpielwiese = object
    k: Seq[TKachel]

var
  spielwiese: TSpielwiese
newSeq(spielwiese.k, 64)

proc at*(s: var TSpielwiese, x, y: Int): var TKachel =
  result = s.k[y * 8 + x]

spielwiese.at(3, 4) = (45, "hallo")

echo spielwiese.at(3,4)[0], " ", spielwiese.at(3,4)[1]

