"""
Oskar Sobczyk

Pracownia 1

Program prosze uruchamiac poleceniem "python hilbert.py n s u d x y z fi psi" gdzie n...pis sa to kolejne argumenty zgodne
z trescia zadania. Parametr d powinien byc dosc duzy poniewaz im wieksze bedzie d tym wiekszy bedzie rysunek.

"""

from math import cos, sin, radians
import sys


def hilbert3d(n, s, u, d, x, y, z, fi, psi):
    # tworzymy liste ktora bedzie przetrzymywac wspolrzedne kolejnych wierzcholkow
    wspolrzedne = list()
    # inicjalizujemy wyliczanie wierzcholkow
    algorytm(n, 1.0, 0, 0, 0, [1, 0, 0], [0, 1, 0], [0, 0, -1], wspolrzedne)
    # funkcja powieksza krzywa
    skaluj(wspolrzedne, u)
    # funkcja przesuwa krzywa na ukladzie wspolrzednych
    przesun(wspolrzedne, x, y, z)
    # funkcja obraca krzywa o kat fi i psi
    punkty = wspto2d(fi, psi, wspolrzedne)
    # funkcja rzutuje krzywa na plaszczyzne
    wsp2d = rzutuj(punkty, d)
    # drukowanie kodu post script
    print('%!PS-Adobe-2.0 EPSF-2.0')
    print('%sBoundingBox: 200 200 %d %d' % ('%%', s, s))
    print('newpath')
    print('%d %d moveto' % (wsp2d[0][0], wsp2d[0][1]))
    for wsp in wsp2d:
        print('%f %f lineto' % (float(wsp[0]), float(wsp[1])))
    print(".4 setlinewidth")
    print("stroke")
    print("showpage")
    print("%%Trailer")
    print("%EOF")


"""
algorytm wyliczajacy krzywa gdzie n jest to poziom rekurencji, u dlugosc krawedzi, x,y,z wspolrzedne startowe,
przod, gora, prawo okresla gdzie jest przod, gora i prawo 'zolwia', jest to zapisane za pomoca wektorow
funkcja przechodzi przez 8 wierzcholkow szescianu, w kazdym wierzcholku nastepuje wywolanie rekurencyjne.
"""


def algorytm(n, u, x, y, z, przod, gora, prawo, wspolrzedne):
    if n == 0:
        # dodanie wspolrzednych do tablicy w postacji tablicy dwu-wymiarowej, ostatnia wartosc [1] jest po to aby mozna bylo pomnozyc przez macierz
        wspolrzedne.append([[x], [y], [z], [1]])
    else:
        u = float(u / 2)
        if przod[0] < 0 or przod[1] < 0 or przod[2] < 0:
            x -= u * przod[0]
            y -= u * przod[1]
            z -= u * przod[2]
        if gora[0] < 0 or gora[1] < 0 or gora[2] < 0:
            x -= u * gora[0]
            y -= u * gora[1]
            z -= u * gora[2]
        if prawo[0] < 0 or prawo[1] < 0 or prawo[2] < 0:
            x -= u * prawo[0]
            y -= u * prawo[1]
            z -= u * prawo[2]
        #wywolaia rekurencyjne parametry osx osy osz okreslaja w jaki sposob ma byc obrocona krzywa ktora powstaje w rekurencji
        algorytm(n - 1, u, x, y, z, gora, prawo, przod, wspolrzedne)
        algorytm(n - 1, u, x + u * przod[0], y + u * przod[1], z + u * przod[2], prawo, przod, gora, wspolrzedne)

        algorytm(n - 1, u, x + u * przod[0] + u * gora[0], y + u * przod[1] + u * gora[1],
                 z + u * przod[2] + u * gora[2], prawo, przod, gora, wspolrzedne)

        algorytm(n - 1, u, x + u * gora[0], y + u * gora[1], z + u * gora[2], przeciwna(przod),
                 przeciwna(gora), prawo, wspolrzedne)

        algorytm(n - 1, u, x + u * gora[0] + u * prawo[0], y + u * gora[1] + u * prawo[1],
                 z + u * gora[2] + u * prawo[2], przeciwna(przod), przeciwna(gora),
                 prawo, wspolrzedne)

        algorytm(n - 1, u, x + u * przod[0] + u * gora[0] + u * prawo[0],
                 y + u * przod[1] + u * gora[1] + u * prawo[1], z + u * przod[2] + u * gora[2] + u * prawo[2],
                 przeciwna(prawo), przod, przeciwna(gora), wspolrzedne)

        algorytm(n - 1, u, x + u * przod[0] + u * prawo[0], y + u * przod[1] + u * prawo[1],
                 z + u * przod[2] + u * prawo[2], przeciwna(prawo), przod,
                 przeciwna(gora), wspolrzedne)

        algorytm(n - 1, u, x + u * prawo[0], y + u * prawo[1], z + u * prawo[2], gora, przeciwna(prawo), przeciwna(przod),
                 wspolrzedne)


def transormacja(obrotx, obroty):
    # tworzymy macierz obrotu
    # Zamieniamy kat na radiany
    radx = radians(obrotx)
    rady = radians(obroty)
    # macierze obrotu
    mobrotux = [[1, 0, 0, 0], [0, cos(radx), -sin(radx), 0], [0, sin(radx), cos(radx), 0], [0, 0, 0, 1]]
    mobrotuy = [[cos(rady), 0, sin(rady), 0], [0, 1, 0, 0], [-sin(rady), 0, cos(rady), 0], [0, 0, 0, 1]]
    return matrixmult(mobrotux, mobrotuy)

# funkcja mozaca macierze
def matrixmult(a, b):
    wiersz_a = len(a)
    kol_a = len(a[0])
    kol_b = len(b[0])

    # tworzymy macierz wynikowa
    c = [[0 for row in range(kol_b)] for col in range(wiersz_a)]

    for i in range(wiersz_a):
        for j in range(kol_b):
            for k in range(kol_a):
                c[i][j] += a[i][k] * b[k][j]
    return c

# funkcja skalujaca krzywa z wymiaru 1x1x1 na d x d x d
def skaluj(wspolrzedne, d):
    for x in range(len(wspolrzedne)):
        wspolrzedne[x][0][0] = wspolrzedne[x][0][0] * d
        wspolrzedne[x][1][0] = wspolrzedne[x][1][0] * d
        wspolrzedne[x][2][0] = wspolrzedne[x][2][0] * d

# funkcja przesuwajaca
def przesun(wspolrzedne, x, y, z):
    for i in range(len(wspolrzedne)):
        #do wspolrzednych kazdego punktu dodajemy x y z
        wspolrzedne[i][0][0] = wspolrzedne[i][0][0] + x
        wspolrzedne[i][1][0] = wspolrzedne[i][1][0] + y
        wspolrzedne[i][2][0] = wspolrzedne[i][2][0] + z

"""
funkcja rzutuje punkt na plasczyzne za pomoca wzorow wywodzacych sie z podobienstwa trojkatow
obserwator------d-------|plasczyzna-----z-----rzutowany punkt
"""
def rzutuj(wspolrzedne, d):
    wsp2d = list()
    for i in range(len(wspolrzedne)):
        x2d = (wspolrzedne[i][0] / (wspolrzedne[i][2] + d)) * d
        y2d = (wspolrzedne[i][1] / (wspolrzedne[i][2] + d)) * d
        wsp2d.append([x2d, y2d])
    return wsp2d

# funkcja zamienia elementy listy na przeciwne
def przeciwna(lista):
    listaminus = [-x for x in lista]
    return listaminus

# funkcja ktora obraca punkty o kat fi i psi
def wspto2d(fi, psi, wspolrzedne):
    wynik = list()
    macierz = transormacja(fi, psi)
    for wspolrzedna in wspolrzedne:
        trzywym = matrixmult(macierz, wspolrzedna)
        wynik.append([trzywym[0][0], trzywym[1][0], trzywym[2][0]])
    return wynik


# hilbert3d(n,s, u,  d,x,y,z,fi,psi)
# odczytanie argumentow z wiersza polecen
n, s, u, d, x, y, z, fi, psi = sys.argv[1:]
hilbert3d(int(n), int(s), int(u), int(d), int(x), int(y), int(z), int(fi), int(psi))