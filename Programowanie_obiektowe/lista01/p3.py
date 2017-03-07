from zad03 import *

x = zespolona(5, 2)
y = zespolona(2, 10)

print('działania z nową zmienną')
print('dodawanie', dodaj1(x, y))
print('odejmowanie', odejmij1(x, y))
print('mnożenie', mnozenie1(x, y))
print('dzielenie', dzielenie1(x, y))

print('dzialania ze zmiana elementu')

x = zespolona(5, 2)
y = zespolona(2, 10)
dodaj2(x, y)
print('dodawanie ', x.re, x.im)
x = zespolona(5, 2)
y = zespolona(2, 10)
odejmij2(x, y)
print('odejmowanie ', x.re, x.im)
x = zespolona(5, 2)
y = zespolona(2, 10)
mnozenie2(x, y)
print('mnozenie ', x.re, x.im)
x = zespolona(5, 2)
y = zespolona(2, 10)
dzielenie2(x, y)
print('dzielenie ', x.re, x.im)
