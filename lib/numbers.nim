iterator primeDecomposition*(n: Positive): Positive =
  var rest = n
  var factor = 2
  while rest > 1:
    while rest mod factor != 0:
      inc factor
    yield factor
    rest = rest div factor
