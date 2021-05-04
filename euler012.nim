import tables
import lib/numbers

func numFactors(n: Positive): Positive =
  var counts: CountTable[Positive]
  for factor in primeDecomposition(n):
    counts.inc(factor)
  result = 1
  for multiplicity in counts.values:
    result *= multiplicity + 1

iterator triangleNumbers: Positive =
  var i = 1
  var n = 1
  while true:
    yield n
    inc i
    inc n, i

when isMainModule:
  for n in triangleNumbers():
    if numFactors(n) > 500:
      echo n
      break
