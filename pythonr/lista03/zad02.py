from functools import *


def pierwsze_funkcyjna(n):
    primes_set = reduce((lambda s, x: s - set(range(2 * x, n + 1, x)) if (x in s) else s),
                        range(2, n + 1), set(range(2, n + 1)))
    return sorted(list(primes_set))


print(pierwsze_funkcyjna(100))
