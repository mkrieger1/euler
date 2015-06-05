"""
Project Euler Problem 23
========================

A perfect number is a number for which the sum of its proper divisors is
exactly equal to the number. For example, the sum of the proper divisors
of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
number.

A number whose proper divisors are less than the number is called
deficient and a number whose proper divisors exceed the number is called
abundant.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the
smallest number that can be written as the sum of two abundant numbers is
24. By mathematical analysis, it can be shown that all integers greater
than 28123 can be written as the sum of two abundant numbers. However,
this upper limit cannot be reduced any further by analysis even though it
is known that the greatest number that cannot be expressed as the sum of
two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the
sum of two abundant numbers.
"""

from collections import defaultdict
from bisect import bisect
from itertools import islice


# credits to Gareth Rees (http://codereview.stackexchange.com/a/92079/67888)
def all_sum_divisors(limit):
    """Return a list of the sums of divisors for the numbers below `limit`.

    >>> all_sum_divisors(10) # https://oeis.org/A000203
    [1, 1, 3, 4, 7, 6, 12, 8, 15, 13]
    """
    result = [1] * limit
    for p in range(2, limit):
        if result[p] > 1: # p is not prime
            continue
        p_power = p # p, p^2, p^3, ...
        last_m = 1 # 1, (1 + p), (1 + p + p^2), ...
        while p_power < limit:
            m = last_m + p_power # (1 + p), (1 + p + p^2), ...
            # loop over all multiples of p_power below limit
            for i in range(p_power, limit, p_power):
                result[i] //= last_m
                result[i] *= m
            last_m = m
            p_power *= p
    # now, when
    #     i = 2^a * 3^b * 5^c * ...
    # then
    #     result[i] = (1 + 2 + ... + 2^a) * (1 + 3 + ... + 3^b) * ...
    return result

def _abundant_numbers2(limit):
    sum_divisors = all_sum_divisors(limit)

    def is_abundant(number):
        return sum_divisors[number] > 2 * number

    return filter(is_abundant, range(2, limit))


def _abundant_numbers1(limit):
    # mapping from a number to the set of its proper divisors (i.e.,
    # excluding the number itself)
    divisors = defaultdict(set)
    for divisor in range(1, limit // 2 + 1):
        for number in range(2 * divisor, limit, divisor):
            divisors[number].add(divisor)

    def is_abundant(number):
        return sum(divisors[number]) > number

    return sorted(filter(is_abundant, divisors))


def abundant_numbers(limit):
    """Return a list of all abundant numbers below `limit`.

    >>> abundant_numbers(13)
    [12]
    """
    #return _abundant_numbers1(limit)
    return _abundant_numbers2(limit)


def sum_of_not_abundant_sums(limit=28124):
    """Return the sum of all positive integers below `limit` which cannot be
    written as the sum of two abundant numbers.

    All numbers below 24 cannot be written as the sum of two abundant numbers:
    >>> sum_of_not_abundant_sums(24) == sum(range(24))
    True

    24 can be written as the sum of two abundant numbers:
    >>> sum_of_not_abundant_sums(25) == sum(range(24))
    True
    """

    abundants = abundant_numbers(limit)

    # make a set so that membership can be tested efficiently
    abundants_set = set(abundants)

    def impossible_sum_of_two_abundant_numbers():
        for number in range(1, limit):
            for abundant in islice(abundants, bisect(abundants, number // 2)):
                if number - abundant in abundants_set:
                    break # is the sum of two abundant numbers
            else:
                yield number

    return sum(impossible_sum_of_two_abundant_numbers())


if __name__=='__main__':
    print sum_of_not_abundant_sums()
