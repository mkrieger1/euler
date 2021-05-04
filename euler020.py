def fac(n):
    result = 1
    for i in range(1, n + 1):
        result *= i
    return result

def sum_digits(n):
    return sum(int(d) for d in str(n))

print(sum_digits(fac(100)))
