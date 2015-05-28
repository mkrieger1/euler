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

SMALLEST_ABUNDANT = 12

# largest number for which we have to test if it can be expressed as the
# sum of two abundant numbers
MAX_TEST_SUM_OF_TWO_ABUNDANT = 28123

# largest number for which we have to know if it is abundant
MAX_TEST_ABUNDANT = MAX_TEST_SUM_OF_TWO_ABUNDANT - SMALLEST_ABUNDANT

# largest possible divisor that we have to consider
MAX_DIVISOR = MAX_TEST_ABUNDANT / 2

from collections import defaultdict

def solve_euler23():
    """Return the sum of all positive integers which cannot be written
    as the sum of two abundant numbers.
    """
    # mapping from a number to the set of its proper divisors (i.e.,
    # excluding the number itself)
    divisors = defaultdict(set)
    for divisor in range(1, MAX_DIVISOR+1):
        for number in range(2*divisor, MAX_TEST_ABUNDANT+1, divisor):
            divisors[number].add(divisor)

    def is_abundant(number):
        return sum(divisors[number]) > number

    abundant_numbers = sorted(filter(is_abundant, divisors))

    # make a set so that membership can be tested efficiently
    abundant_numbers_set = set(abundant_numbers)

    impossible_sum_of_two_abundant_numbers = []
    for number in range(1, MAX_TEST_SUM_OF_TWO_ABUNDANT+1):
        for abundant in abundant_numbers:
            if number - abundant in abundant_numbers_set:
                break # is the sum of two abundant numbers
        else:
            impossible_sum_of_two_abundant_numbers.append(number)

    return sum(impossible_sum_of_two_abundant_numbers)

if __name__=='__main__':
    print solve_euler23()
