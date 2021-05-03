import strutils, tables, hashes

type
  Triangle = seq[seq[Natural]]

  Position = object
    row, i: Natural

func toTriangle(s: string): Triangle =
  for line in s.strip.split('\n'):
    var nums: seq[Natural]
    for num in line.strip.split():
      nums.add num.parseInt
    result.add nums

func `[]`(t: Triangle, p: Position): Natural =
  assert p.row < t.len
  assert p.i <= p.row
  t[p.row][p.i]

iterator nextPositions(p: Position): Position =
  assert p.i <= p.row
  yield Position(row: p.row + 1, i: p.i)
  yield Position(row: p.row + 1, i: p.i + 1)

proc hash(p: Position): Hash =
  result = p.row.hash !& p.i.hash
  result = !$result

var sums: Table[Position, Natural]

proc maxPathSum(t: Triangle, p: Position): Natural =
  if p.row == t.len - 1:
    return t[p]
  if p notin sums:
    var s = 0
    for n in p.nextPositions:
      s = max(s, t.maxPathSum(n))
    sums[p] = s + t[p]
  sums[p]

when isMainModule:
  let t = """
                       75
                     95 64
                    17 47 82
                  18 35 87 10
                 20 04 82 47 65
               19 01 23 75 03 34
              88 02 77 73 07 63 67
            99 65 04 28 06 16 70 92
           41 41 26 56 83 40 80 70 33
         41 48 72 33 47 32 37 16 94 29
        53 71 44 65 25 43 91 52 97 51 14
      70 11 33 28 77 73 17 78 39 68 17 57
     91 71 52 38 17 14 91 43 58 50 27 29 48
   63 66 04 68 89 53 67 30 73 16 69 87 40 31
  04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
  """.toTriangle

  echo t.maxPathSum(Position(row: 0, i: 0))
