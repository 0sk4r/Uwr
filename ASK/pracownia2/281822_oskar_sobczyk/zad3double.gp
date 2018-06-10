set title "Zadanie 3: Int"

# set terminal postscript eps enhanced
set terminal pngcairo size 640,480 enhanced font 'Arial,10'

set ylabel "Czas (s)"
set xlabel "n"
#set yrange [0:20]
set datafile separator ","

set style line 1 linecolor rgb '#0061ff' linetype 1
set style line 2 linecolor rgb '#ff0000' linetype 1
set style line 3 linecolor rgb '#009926' linetype 1
set style line 4 linecolor rgb '#001c99' linetype 1
set style line 5 linecolor rgb '#ef02c8' linetype 1
set style line 6 linecolor rgb '#efeb02' linetype 1
set style line 7 linecolor rgb '#ef9802' linetype 1


plot "zad3double.dat" using 1:2 with lines title "v0" linestyle 1 , \
    "zad3double.dat" using 1:3 with lines title "v1(8)" linestyle 2 , \
    "zad3double.dat" using 1:4 with lines title "v1(16)" linestyle 3 , \
    "zad3double.dat" using 1:5 with lines title "v1(32)" linestyle 4

# vim: ft=gnuplot
