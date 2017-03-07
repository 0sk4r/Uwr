class zespolona():
    def __init__(self, re, im):
        self.re = re
        self.im = im


def dodaj1(a, b):
    c = zespolona(0, 0)
    c.re = a.re + b.re
    c.im = a.im + b.im
    return c.re, c.im


def dodaj2(a, b):
    a.re = a.re + b.re
    a.im = a.im + b.im


def odejmij1(a, b):
    c = zespolona(0, 0)
    c.re = a.re - b.re
    c.im = a.im - b.im
    return c.re, c.im


def odejmij2(a, b):
    a.re = a.re - b.re
    a.im = a.im - b.im


def mnozenie1(a, b):
    c = zespolona(0, 0)
    c.re = a.re * b.re - a.im * b.im
    c.im = a.im * b.re + a.re * b.im
    return c.re, c.im


def mnozenie2(a, b):
    pom = zespolona(a.re, a.im)

    pom.re = a.re * b.re - a.im * b.im
    pom.im = a.im * b.re + a.re * b.im
    a.re = pom.re
    a.im = pom.im


def dzielenie1(a, b):
    c = zespolona(0, 0)
    c.re = a.re * b.re + a.im * b.im / b.re ** 2 + b.im ** 2
    c.im = a.im * b.re - a.re * b.im / b.re ** 2 + b.im ** 2
    return c.re, c.im


def dzielenie2(a, b):
    pom = zespolona(a.re, a.im)
    pom.re = a.re * b.re + a.im * b.im / b.re ** 2 + b.im ** 2
    pom.im = a.im * b.re - a.re * b.im / b.re ** 2 + b.im ** 2
    a.re = pom.re
    a.im = pom.im
