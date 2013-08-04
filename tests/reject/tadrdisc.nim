discard """
  file: "tadrdisc.nim"
  line: 20
  errormsg: "for a \'var\' type a variable needs to be passed"
"""
# Test that the address of a dicriminants cannot be taken

type
  TKind = enum ka, kb, kc
  TA = object
    case k: TKind
    of ka: x, y: Int
    of kb: a, b: String
    of kc: c, d: Float
    
proc setKind(k: var TKind) = 
  k = kc
  
var a: TA
setKind(a.k) #ERROR_MSG for a 'var' type a variable needs to be passed



