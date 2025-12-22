WTF: main.o handler.o
	BLink FROM LIB:cback.o main.o handler.o TO Intoxicated LIB LIB:lc.lib

main.o: main.c
	lc -v main

handler.o: handler.s
	GenIm2 handler
