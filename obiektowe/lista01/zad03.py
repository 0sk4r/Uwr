class zespolona():
    def __init__(self, re, im):
        self.re = re
        self.im = im


def dodaj1(a, b):
    c = zespolona(0, 0)
    c.re = a.re + b.re
    c.im = a.im + b.im
    return c


def dodaj2(a, b):
    a.re = a.re + b.re
    a.im = a.im + b.im


def odejmij1(a, b):
    c = zespolona(0, 0)
    c.re = a.re - b.re
    c.im = a.im - b.im
    return c


def odejmij2(a, b):
    a.re = a.re - b.re
    a.im = a.im - b.im


def mnozenie1(a, b):
    c = zespolona(0, 0)
    c.re = a.re * b.re - a.im * b.im
    c.im = a.im * b.re + a.re * b.im
    return c


def mnozenie2(a, b):
    a.re = a.re * b.re - a.im * b.im
    a.im = a.im * b.re + a.re * b.im


def dzielenie1(a, b):
    c = zespolona(0, 0)
    c.re = a.re * b.re + a.im * b.im / b.re ** 2 + b.im ** 2
    c.im = a.im * b.re - a.re * b.im / b.re ** 2 + b.im ** 2
    return c


def dzielenie2(a, b):
    a.re = a.re * b.re + a.im * b.im / b.re ** 2 + b.im ** 2
    a.im = a.im * b.re - a.re * b.im / b.re ** 2 + b.im ** 2


#x = zespolona(2, 3)
#y = zespolona(3, 2)

#z = dodaj1(x, y)
#print(z.re, z.im)
