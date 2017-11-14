import time


def perfect_listcomp(n):
    def divs(m):
        return [i for i in range(1, int(m / 2) + 1) if m % i == 0]
    return [i for i in range(2, n) if sum(divs(i)) == i]


def perfect_functional(n):
    def divs(m): return list(filter(lambda e: m %
                                    e == 0, range(1, int(m / 2) + 1)))
    return list(filter(lambda e: (e == sum(divs(e))), range(2, n)))


def main():
    start1 = time.time()
    perfect_functional(10000)
    end1 = time.time()
    t1 = end1 - start1
    print("Funkcyjnie: {}".format(t1))

    start2 = time.time()
    perfect_listcomp(10000)
    end2 = time.time()
    t2 = end2 - start2
    print("Lista skladana: {}".format(t2))


if __name__ == "__main__":
    main()
