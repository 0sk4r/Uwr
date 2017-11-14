from functools import *
import time


def prime_functional(n):
    primes_set = reduce((lambda s, x: s - set(range(2 * x, n + 1, x)) if (x in s) else s),
                        range(2, n + 1),
                        set(range(2, n + 1)))
    return sorted(list(primes_set))


def prime_listcomp(n):
    return [x for x in range(2, n) if all(x % y != 0 for y in range(2, x))]


def main():
    start1 = time.time()
    prime_functional(10000)
    end1 = time.time()
    t1 = end1 - start1
    print("Funkcyjnie: {}".format(t1))

    start2 = time.time()
    prime_listcomp(10000)
    end2 = time.time()
    t2 = end2 - start2
    print("Lista skladana: {}".format(t2))


if __name__ == "__main__":
    main()
