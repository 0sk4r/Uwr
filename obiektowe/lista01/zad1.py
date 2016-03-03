class kolekcja():
    def __init__(self,typ):
        self.zbiór = typ
        self.tablica = list()

def wstaw(kolekcja, element):
    if kolekcja.zbiór==False:
        kolekcja.tablica.append(element)
    else:
        if (element in kolekcja.tablica) == False:
            kolekcja.tablica.append(element)

def rozmiar(kolekcja):
    return len(kolekcja.tablica)

def szukaj(kolekcja, element):
    if kolekcja.zbiór:
        if element in kolekcja.tablica:
            return 1
    else:
        licznik = 0
        for i in range(rozmiar(kolekcja)):
            if element == kolekcja.tablica[i]:
                licznik+=1
        return licznik
    return 0


x = kolekcja(False)
x.tablica=[2,3,4,5,6,7,5,1,3,5]

print(szukaj(x,5))