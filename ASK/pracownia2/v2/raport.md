# Raport do zadań z pracowni #2

 - Autor: Oskar Sobczyk
 - Numer indeksu: 281822

Konfiguracja
---

Informacje o systemie:
 - Dystrybucja: Ubuntu 18.04 LTS
 - Jądro systemu: GNU/Linux 4.15.0
 - Kompilator: GCC 7.3.0
 - Procesor: Intel® Core™ i5-4590 CPU @ 3.30GHz
 - Liczba rdzeni: 4

Pamięć podręczna:
 * L1d: 32 KiB, 8-drożny (per rdzeń), rozmiar linii 64B
 * L2: 256 KiB, 8-drożny (per rdzeń), rozmiar linii 64B
 * L3: 6MiB, 12-drożny (współdzielony), rozmiar linii 64B

Pamięć TLB:
 * L1d: 4KiB strony, 4-drożny, 64 wpisy
 * L2: 4KiB strony, 6-drożny, 1536 wpisów

 Informacje uzyskane na podstawie programu `x86info`.

# Zadanie 1

int:
---
|n      | v0    | v1    | v2    | v3    |
|:---:  |:---:  |:---:  |:---:  |:---:  |
|512    | 0.195 | 0.083 | 0.673 | null  |
|1024   | 2.871 | 0.656 | 14.624| null  |
|2048   | 63.025| 5.342 | 140.456| null |

double:
--- 
|n      | v0    | v1    | v2    | v3    |
|:---:  |:---:  |:---:  |:---:  |:---:  |
|512    |0.190  |0.078  | 1.012 | null  |
|1024   |6.721  | 0.823 | 15.016| null  |
|2048   |75.610 |7.232  | 180.319|null|


# Zadnie 3

Rozwiązanie w wersji `v0` cechuje się niską lokalnością danych. Macierz ułożona jest w pamięci wiersz za wierszem. Dostęp do dowolnego elementu macierzy wymaga wczytania całego wiersza. Korzystając z funkcji `transpose1` aby stransponować jeden wiersz macirzy `src` potrzeba wczytania `n` wierszy macierzy `dst`. W zależności od rozmiaru pamięci cache ilość chybień może się zwiększać.

Roziązaniem jest transpozycja macierzy podzielonej na bloki w sposób przedstawiony na rysunką poniżej. Została ona zaimplementowana w funkcji `transpose2`. Wykorzystanie takiej moetody zwiększa lokalność danych. Program wiele razy odwołuje się do danych już wczytanych w pamięci cache.

![Transpozycja macierzy blokowo](img/transpose_block.png)


int:
---

|n                  | v0        | v1 (8)    |v1 (16)    | v1 (32)   |
|:---:              |:---:      |:---:      |:---:      | :---:     |
|1024 (8 MiB)       | 0.00651   | 0.002537  |0.0035     |   0.0047  | 
|2048 (16 MiB)      | 0.03771   | 0.008665  |0.0137     |   0.0147  |
|4096 (64 MiB)      | 0.16307   | 0.036294  |0.0578     |   0.0701  |
|8192 (256 MiB)     | 0.82793   | 0.168385  |0.3052     |   0.2966  |
|16384 (1024 MiB)   | 3.639903  | 0.746810  |1.3051     |   1.2468  |

![Wykres zależności czasu od rozmiaru macierzy (int)](img/zad3_int.png)

double:
---

|n                  | v0        | v1 (8)    |v1 (16)    | v1 (32)   |
|:---:              |:---:      |:---:      |:---:      | :---:     |
|1024 (8 MiB)       |0.0089     |0.0026     |0.0036     |0.0042     |
|2048 (32 MiB)      |0.0432     |0.0116     |0.0169     |0.0217     |
|4096 (128 MiB)     |0.2062     |0.0508     |0.0755     |0.0809     |
|8192 (512 MiB)     |0.9004     |0.2137     |0.3279     |0.3355     |
|16384 (2048 MiB)   |4.4905     |1.0510     |1.7912     |1.8474     |

![Wykres zależności czasu od rozmiaru macierzy (double)](img/zad3_double.png)

# Zadanie 4

Funkcja `randomwalk1` 75 instrukcji

Funkcja `randomwalk1` 78 instrukcji

