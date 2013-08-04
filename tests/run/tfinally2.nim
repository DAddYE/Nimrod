discard """
  file: "tfinally2.nim"
  output: '''A
B
C
D'''
"""
# Test break in try statement:

proc main: Int = 
  try:
    block ab:
      try:
        try:
          break AB
        finally:
          echo("A")
        echo("skipped")
      finally: 
        block b:
          echo("B")
      echo("skipped")
    echo("C")
  finally:
    echo("D")
    
discard main() #OUT ABCD



