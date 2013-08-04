when defined(doublePrecision):
  type
    TR* = float64
else:
  type
    TR* = Float32
