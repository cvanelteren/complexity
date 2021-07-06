import algorithm, tables, math, sequtils, sugar, strformat
import nimpy

proc naive_estimator(x: openArray[float]) : Table[float, float] =
  result = initTable[float, float]()
  var z : int = x.len()
  for xi in x:
    if result.hasKeyOrPut(xi, 1/z):
        result[xi] += 1/z

proc entropy*(p: openArray[float]): float =
  result = 0
  for pi in p:
    if pi != 0:
        result -= pi * log(pi, base = 2)


proc argsort *[T](t: seq[T], order = SortOrder.Ascending): seq[int] =

  proc idx_comp(x, y: (T, int)): int =
    result = system.cmp(x[0], y[0])

  var mt = t
  let n = t.len()
  var val_and_idx = zip(toOpenArray(mt, 0, n-1), toSeq(0..<n)).toOrderedTable()
  val_and_idx.sort(cmp = idx_comp, order = order)
  result =  val_and_idx.values.toSeq()



proc permutation_entropy*[T](x: openArray[T], t: int, tau: int = 1, normalize : bool = false): float =
  # 1. Cut the the time-series in t overlapping segments
  # 2. Construct the ordering permutation of the segements
  # 3. Compute the relative frequency
  # 4. Compute the Shannon Entropy
  # copy the time series
  if t > x.len():
    echo "Windw is larger than array"
    return 0.0
  var buffer: seq[T]
  newSeq(buffer, t)

  var sorted : seq[int]

  var dist = initTable[seq[int], float]()
  echo "Computing permutation entropy with"
  echo fmt"Window {t=}"
  echo fmt"Time-shift {tau=}"

  var jdx : int
  # segment the data in overlapping segments
  for start in countup(0, x.len() - t, tau):
    # fill the buffer
    for idx in 0..<t:
      jdx = int((idx + start) %% x.len())
      buffer[idx] = x[jdx]
    # compute permutation vector
    sorted = buffer.argsort()
    # fill the distribution
    if dist.hasKeyOrPut(sorted, 1):
      dist[sorted] += 1

  # normalize
  var z = sum(dist.values.toSeq())
  var tmp = dist.values.toSeq()
  tmp.applyIt(it / z)
  result = entropy(tmp)
  if normalize:
    result /= log(float(fac(t)), base = 2)


