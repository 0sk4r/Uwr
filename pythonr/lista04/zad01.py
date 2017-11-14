from functools import *
import time
from itertools import islice


def prime_functional(n):
    primes_set = reduce((lambda s, x: s - set(range(2 * x, n + 1, x)) if (x in s) else s),
                        range(2, n + 1),
                        set(range(2, n + 1)))
    return sorted(list(primes_set))


def prime_listcomp(n):
    return [x for x in range(2, n) if all(x % y != 0 for y in range(2, x))]


class PrimeIt:
    def __init__(self):
        self.current = 1

    def __next__(self):
        self.current += 1
        while 1:
            if self.current == 2:
                return self.current
            for i in range(2, self.current):
                if self.current % i == 0:
                    return None
            return self.current

    def __iter__(self):
        return self


def IteratorPrime(n):
    p = PrimeIt()
    res = []

    for prime in islice(p, n - 1):
        if prime:
            res.append(prime)
    return res


def main():

    print("10:")
    start1 = time.time()
    prime_functional(10)
    end1 = time.time()
    t1 = end1 - start1
    print("Funkcyjnie: {}".format(t1))

    start1 = time.time()
    prime_listcomp(10)
    end1 = time.time()
    t1 = end1 - start1
    print("Lista skladana: {}".format(t1))

    start1 = time.time()
    IteratorPrime(10)
    end1 = time.time()
    t1 = end1 - start1
    print("Iterator: {}".format(t1))

    print("100:")
    start1 = time.time()
    prime_functional(100)
    end1 = time.time()
    t1 = end1 - start1
    print("Funkcyjnie: {}".format(t1))

    start1 = time.time()
    prime_listcomp(100)
    end1 = time.time()
    t1 = end1 - start1
    print("Lista skladana: {}".format(t1))

    start1 = time.time()
    IteratorPrime(100)
    end1 = time.time()
    t1 = end1 - start1
    print("Iterator: {}".format(t1))

    print("10:")
    start1 = time.time()
    prime_functional(1000)
    end1 = time.time()
    t1 = end1 - start1
    print("Funkcyjnie: {}".format(t1))

    start1 = time.time()
    prime_listcomp(1000)
    end1 = time.time()
    t1 = end1 - start1
    print("Lista skladana: {}".format(t1))

    start1 = time.time()
    IteratorPrime(1000)
    end1 = time.time()
    t1 = end1 - start1
    print("Iterator: {}".format(t1))


if __name__ == "__main__":
    main()
