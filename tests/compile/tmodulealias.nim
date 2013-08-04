discard """
  disabled: true
"""

when defined(windows):
  import winlean
else:
  import posix

when defined(Windows):
  template orig: expr = 
    winlean
else:
  template orig: Expr = 
    posix

proc socket(domain, typ, protocol: Int): Int =
  result = orig.socket(ord(domain), ord(typ), ord(protocol)))

