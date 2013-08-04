discard """
  file: "tnestprc.nim"
  output: "10"
"""
# Test nested procs without closures

proc add3(x: Int): Int = 
  proc add(x, y: Int): Int {.noconv.} = 
    result = x + y
    
  result = add(x, 3)
  
echo add3(7) #OUT 10



