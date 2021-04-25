from decimal import Decimal
from math import floor

def b(theta, n):
    if n < 1:
        raise ValueError('b_n, n >= 1')
    elif n == 1:
        return theta
    else:
        bn1 = b(theta, n - 1)
        fbn1 = floor(bn1)
        return fbn1 * (bn1 - fbn1 + 1)

def a(theta, n):
    return floor(b(theta, n))

def tau(theta, minlen=24):
    digits = ''
    n = 2
    while len(digits) < minlen:
        digits += str(a(theta, n))
        n += 1
    return Decimal('2.' + digits)

def fixedpoint(start=2):
    current = Decimal(start)
    while True:
        yield current
        t = tau(current)
        if str(t) == str(current):
            break
        current = t

if __name__ == '__main__':
    for i, t in enumerate(fixedpoint(), 1):
        print(i, t)
