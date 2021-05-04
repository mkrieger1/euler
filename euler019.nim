type
  Weekday = enum Mon, Tue, Wed, Thu, Fri, Sat, Sun
  Month = enum Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
  Year = int

  FirstOfMonth = object
    year: Year
    month: Month
    weekday: Weekday

const numWeekdays = ord(Weekday.high) - ord(Weekday.low) + 1
static:
  assert numWeekdays == 7

func divisibleBy(n, d: int): bool =
  n mod d == 0

func isLeapYear(y: Year): bool =
  if y.divisibleBy 400:
    true
  elif y.divisibleBy 100:
    false
  else:
    y.divisibleBy 4

func daysInMonth(m: Month, y: Year): int =
  case m:
  of Jan, Mar, May, Jul, Aug, Oct, Dec: 31
  of Apr, Jun, Sep, Nov: 30
  of Feb:
    if y.isLeapYear: 29
    else: 28

proc inc(f: var FirstOfMonth) =
  f.weekday =
    ((ord(f.weekday) + daysInMonth(f.month, f.year)) mod numWeekdays).Weekday
  if f.month == Dec:
    f.month = Jan
    inc f.year
  else:
    inc f.month

when isMainModule:
  var now = FirstOfMonth(year: 1900, month: Jan, weekday: Mon)
  var firstSundays = 0
  while now.year <= 2000:
    if now.year > 1900 and now.weekday == Sun:
      inc firstSundays
    inc now
  echo firstSundays
