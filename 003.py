"""
Project Euler Problem 3
=======================

The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143?
"""

from itertools import count, dropwhile

def factors(n):
    a = dropwhile(lambda x: n % x, count(2)).next()
    # equivalent to:
    # a = 2
    # while n % a:
    #     a += 1
    return [a] + ([] if a == n else factors(n/a))

print max(factors(600851475143))
