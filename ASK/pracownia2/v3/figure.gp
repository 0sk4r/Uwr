set title "A very important figure"

# set terminal postscript eps enhanced
set terminal pngcairo size 640,480 enhanced font 'Arial,10'

set xlabel "X-AXIS"
set ylabel "Y-AXIS"

set style line 1 linecolor rgb '#0060ad' linetype 1
set style line 2 linecolor rgb '#dd181f' linetype 1

#plot "test.dat" using 1:2:3 with yerrorbars notitle linestyle 1, \
#     "figure.dat" using 1:2 with lines title "f(x)" linestyle 2
plot "figure.dat" using 1:2 with lines title "v0" linestyle 2 , \
    "figure.dat" using 1:3 with lines title "v1" linestyle 2 , \
    "figure.dat" using 1:4 with lines title "v2" linestyle 2 , \
    "figure.dat" using 1:5 with lines title "v3" linestyle 2

# vim: ft=gnuplot
