"""
Project Euler Problem 5
=======================

2520 is the smallest number that can be divided by each of the numbers
from 1 to 10 without any remainder.

What is the smallest number that is evenly divisible by all of the numbers
from 1 to 20?
"""

from itertools import count, dropwhile

# TODO move to common file
def factors(n):
    if n < 2:
        return []
    a = dropwhile(lambda x: n % x, count(2)).next()
    # equivalent to:
    # a = 2
    # while n % a:
    #     a += 1
    return [a] + ([] if a == n else factors(n/a))

def allfactors(n):
    result = {}
    for i in range(n+1):
        f = factors(i)
        for x in set(f):
            a = f.count(x)
            c = result.get(x, 0)
            if a > c:
                result[x] = a
    return result

def smallestdivisible(n):
    f = allfactors(n).iteritems()
    return reduce(lambda total, (factor, mult): total * factor**mult, f, 1)

print smallestdivisible(20)
