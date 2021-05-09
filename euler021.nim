import tables
import lib/numbers

func properDivisors(x: Positive): seq[Positive] =
  ## All numbers less than x which divide evenly into x.
  result.add 1
  var newDivisors: seq[Positive]
  var previousFactor = 1

  for factor in primeDecomposition(x):
    if factor != previousFactor:
      newDivisors = result
    previousFactor = factor

    for i, d in newDivisors:
      let n = d * factor
      newDivisors[i] = n
      result.add n

  let last = result.pop
  assert last == x

var sums: Table[Positive, Positive]

proc sumOfProperDivisors(x: Positive): Positive =
  if x in sums:
    return sums[x]
  for d in properDivisors(x):
    inc result, d
  sums[x] = result

proc sumOfAmicableNumbersBelow(n: Positive): Positive =
  for x in 2 ..< n:
    let s = sumOfProperDivisors(x)
    if s == x:
      continue
    if sumOfProperDivisors(s) == x:
      inc result, x

when isMainModule:
  echo sumOfAmicableNumbersBelow 10000
