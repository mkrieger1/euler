"""
Project Euler Problem 7
=======================

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
that the 6th prime is 13.

What is the 10001st prime number?
"""

# TODO this is not efficient

from itertools import count, dropwhile

cache = {}

# TODO move to common file
def factors(n):
    if n < 2:
        return []
    if n in cache:
        return cache[n]
    a = dropwhile(lambda x: n % x, count(2)).next()
    result = [a] + factors(n/a)
    cache[n] = result
    return result


def solve(N):
    allprimes = set()
    n = 2
    while len(allprimes) < N:
        allprimes.update(factors(n))
        n += 1
    return sorted(allprimes)[-1]

if __name__=='__main__':
    print solve(10001)
