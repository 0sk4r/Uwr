traceroute: traceroute.cpp
	g++ -std=c++11 -W -Wall -c traceroute.cpp print.cpp send.cpp receive.cpp 
	g++ -std=c++11 -W -Wall -o traceroute traceroute.o print.o send.o receive.o 

clean:
	rm -rf *.o

distclean:
	rm -rf *.o traceroute
