type BaseTen = seq[Natural]

proc timesTwo(n: var BaseTen) =
  for i in 0 ..< n.len:
    n[i] *= 2
  for i in 0 ..< n.len:
    if n[i] < 10:
      continue
    n[i] -= 10
    if i == n.len - 1:
      n.add 1
    else:
      n[i + 1] += 1

func sumDigits(n: BaseTen): Natural =
  for d in n:
    result += d

when isMainModule:
  var n: BaseTen = @[1.Natural]

  for _ in 1..1000:
    n.timesTwo

  echo n.sumDigits
