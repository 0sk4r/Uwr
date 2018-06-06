set title "Zadanie 1: Int"

# set terminal postscript eps enhanced
set terminal pngcairo size 640,480 enhanced font 'Arial,10'

set ylabel "Czas (s)"
set xlabel "n"
#set yrange [0:20]

set style line 1 linecolor rgb '#0061ff' linetype 1
set style line 2 linecolor rgb '#ff0000' linetype 1
set style line 3 linecolor rgb '#009926' linetype 1
set style line 4 linecolor rgb '#001c99' linetype 1
set style line 5 linecolor rgb '#ef02c8' linetype 1
set style line 6 linecolor rgb '#efeb02' linetype 1
set style line 7 linecolor rgb '#ef9802' linetype 1

#plot "test.dat" using 1:2:3 with yerrorbars notitle linestyle 1, \
#     "zad1int.dat" using 1:2 with lines title "f(x)" linestyle 2

plot "zad1int.dat" using 1:2 with lines title "v0" linestyle 1 , \
    "zad1int.dat" using 1:3 with lines title "v1" linestyle 2 , \
    "zad1int.dat" using 1:4 with lines title "v2" linestyle 3 , \
    "zad1int.dat" using 1:5 with lines title "v3(8)" linestyle 4, \
    "zad1int.dat" using 1:6 with lines title "v3(16)" linestyle 5, \
    "zad1int.dat" using 1:7 with lines title "v3(32)" linestyle 6, \
    "zad1int.dat" using 1:8 with lines title "v3(64)" linestyle 7

# vim: ft=gnuplot
