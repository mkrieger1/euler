func ones(n: Natural): string =
  assert 0 <= n and n <= 9
  ["zero", "one", "two", "three", "four",
   "five", "six", "seven", "eight", "nine"][n]

func teens(n: Positive): string =
  assert 10 <= n and n <= 19
  case n:
  of 10: "ten"
  of 11: "eleven"
  of 12: "twelve"
  of 13: "thirteen"
  of 15: "fifteen"
  of 18: "eighteen"
  else: ones(n - 10) & "teen"

func tens(n: Positive): string =
  assert 2 <= n and n <= 9
  case n:
  of 2: "twenty"
  of 3: "thirty"
  of 4: "forty"
  of 5: "fifty"
  of 8: "eighty"
  else: ones(n) & "ty"

func toWords(n: Positive): seq[string] =
  assert n <= 1000

  if n == 1000:
    return @["one", "thousand"]

  let h = n div 100
  let t = n mod 100
  let o = t mod 10

  if h > 0:
    result.add ones(h)
    result.add "hundred"
    if t == 0:
      return
    result.add "and"

  if t < 10:
    result.add ones(t)
  elif t < 20:
    result.add teens(t)
  else:
    result.add tens(t div 10)
    if o == 0:
      return
    result.add ones(o)

when isMainModule:
  var sum = 0
  for n in 1..1000:
    for word in n.toWords:
      sum.inc word.len
  echo sum
