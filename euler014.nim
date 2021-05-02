import tables

type Number = Positive
type Length = Positive

var collatzLengths: Table[Number, Length]

func isEven(n: Number): bool =
  n mod 2 == 0

func nextCollatz(n: Number): Number =
  if n.isEven:
    n div 2
  else:
    3*n + 1

proc collatzLength(n: Number): Length =
  if n == 1:
    return 1
  if n notin collatzLengths:
    collatzLengths[n] = collatzLength(nextCollatz n) + 1
  collatzLengths[n]

proc startOfLongestChainBelow(n: Number): Number =
  var maxLength = 0
  result = 1
  for i in 1 ..< n:
    let newLength = collatzLength i
    if newLength > maxLength:
      maxLength = newLength
      result = i

when isMainModule:
  echo startOfLongestChainBelow 1000000
