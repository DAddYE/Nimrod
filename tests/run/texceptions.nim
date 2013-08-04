discard """
  output: '''
BEFORE
FINALLY

BEFORE
EXCEPT
FINALLY
RECOVER

BEFORE
EXCEPT
FINALLY
'''
"""

echo ""

proc noExpcetion =
  try:
    echo "BEFORE"

  except:
    echo "EXCEPT"
    raise

  finally:
    echo "FINALLY"

try: noExpcetion()
except: echo "RECOVER"

echo ""

proc reraiseInExcept =
  try:
    echo "BEFORE"
    raise newException(Eio, "")

  except EIO:
    echo "EXCEPT"
    raise

  finally:
    echo "FINALLY"

try: reraiseInExcept()
except: echo "RECOVER"

echo ""

proc returnInExcept =
  try:
    echo "BEFORE"
    raise newException(Eio, "")

  except:
    echo "EXCEPT"
    return

  finally:
    echo "FINALLY"

try: returnInExcept()
except: echo "RECOVER"

