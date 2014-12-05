"""
Project Euler Problem 4
=======================

A palindromic number reads the same both ways. The largest palindrome made
from the product of two 2-digit numbers is 9009 = 91 * 99.

Find the largest palindrome made from the product of two 3-digit numbers.
"""

def is_palindrome(n):
    digits = str(n)
    return all(x == y for x, y in zip(digits, reversed(digits)))

def descending_products(a, b):
    return reversed(sorted(set(i*j for i in range(a+1) for j in range(b+1))))

for x in descending_products(999, 999):
    if is_palindrome(x):
        print x
        break
