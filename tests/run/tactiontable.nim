discard """
  output: "action 3 arg"
"""

import tables

proc action1(arg: String) = 
  echo "action 1 ", arg

proc action2(arg: String) = 
  echo "action 2 ", arg

proc action3(arg: String) = 
  echo "action 3 ", arg

proc action4(arg: String) = 
  echo "action 4 ", arg

var
  actionTable = {
    "A": action1, 
    "B": action2, 
    "C": action3, 
    "D": action4}.toTable

actionTable["C"]("arg")

