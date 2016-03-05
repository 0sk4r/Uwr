from zad1 import *

print('zbior')

zbior = kolekcja(True)

for x in range(10):
    wstaw(zbior,x)

wstaw(zbior,4)
print (zbior.tablica)

print('rozmiar ',rozmiar(zbior))

print('ile jest 5? ',szukaj(zbior,5))

print('torba')
torba = kolekcja(False)

for x in range(10):
    wstaw(torba,x)


for x in range(10):
    wstaw(torba,x)

print (torba.tablica)

print('rozmiar ',rozmiar(torba))

print('ile jest 5? ',szukaj(torba,5))

