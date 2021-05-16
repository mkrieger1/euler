import algorithm, strutils

type Name = string

func toNames(s: string): seq[Name] =
  for word in s.strip.split(','):
    result.add word.strip(chars={'"'})

const names = staticRead"p022_names.txt".toNames

func value(name: Name): Positive =
  for letter in name:
    result.inc ord(letter) - ord('A') + 1

when isMainModule:
  var scores = 0
  for position, name in sorted(names):
    scores.inc (position + 1) * name.value
  echo scores
