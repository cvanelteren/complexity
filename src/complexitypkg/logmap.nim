proc logmap(x: float, r: float): float =
  result = r * x * (1 - x)

proc simulate(x: float, t: int, r: float): seq[float] =
  newSeq[float](result, t)
  for idx in 0..<t:
    result[idx] = logmap(x, r)
