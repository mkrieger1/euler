import tables, hashes

type Position = object
  row, col: Natural

# from https://nim-lang.org/docs/tables.html#basic-usage-hashing
proc hash(p: Position): Hash =
  result = p.row.hash !& p.col.hash
  result = !$result

iterator nextPositions(p: Position): Position =
  let r = p.row
  let c = p.col
  if r > 0:
    yield Position(row: r - 1, col: c)
  if c > 0:
    yield Position(row: r, col: c - 1)

var paths: Table[Position, Natural]

proc numPaths(p: Position): Natural =
  if p.row == 0 or p.col == 0:
    return 1
  var num = 0
  if p notin paths:
    for n in p.nextPositions:
      num.inc numPaths(n)
    paths[p] = num
  paths[p]

when isMainModule:
  echo numPaths Position(row: 20, col: 20)
