# To test stack overflow message

proc over(a: Int): Int = 
  if a >= 10:
    assert false
    return
  result = over(a+1)+5
  
echo($over(0))

