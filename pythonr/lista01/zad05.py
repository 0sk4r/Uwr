def tabliczka(x1, x2, y1, y2):
    x = list(range(x1, x2 + 1))
    y = list(range(y1, y2 + 1))

    row_format = "{:>3} " * (len(x) + 1)

    print(row_format.format("", *x))

    result = []
    for a in y:
        result.append(map(lambda x: x * a, x))

    for val1, val2 in zip(y, result):
        print(row_format.format(val1, *val2))


def main():
    tabliczka(3, 5, 2, 4)


if __name__ == '__main__':
    main()
