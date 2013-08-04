
var 
  gx = 88
  gy = 44
  
template templ*(): Int =
  bind gx, gy
  gx + gy
  

