import math

iterator sievePrimes(upperBound: Natural): Natural =
  ## Sieve of Erathostenes
  var notPrime = newSeq[bool](upperBound + 1)
  let maxFactorToCheck = sqrt(upperBound.float).Natural

  for candidate in 2..maxFactorToCheck:
    if notPrime[candidate]:
      continue
    yield candidate
    for multiple in countup(candidate, upperBound, candidate):
      notPrime[multiple] = true

  for candidate in maxFactorToCheck+1..upperBound:
    if notPrime[candidate]:
      continue
    yield candidate

func sumOfPrimesBelow(n: Positive): Natural =
  for prime in sievePrimes(n - 1):
    result += prime

when isMainModule:
  echo sumOfPrimesBelow 2000000
