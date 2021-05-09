iterator primeDecomposition*(n: Positive): Positive =
  ## Generate all prime factors of `n`, in ascending order.
  ##
  ## Each factor can be generated multiple times.
  runnableExamples:
    var primes: seq[int]
    for p in primeDecomposition(126):
      primes.add p
    assert primes == [2, 3, 3, 7]

  var rest = n
  var factor = 2
  while rest > 1:
    while rest mod factor != 0:
      inc factor
    yield factor
    rest = rest div factor
