main : main.o madmatrix.o libs.o alloctab.o
	gcc -o main main.o madmatrix.o libs.o alloctab.o

main.o : main.c libs.h madmatrix.h
	gcc -c -Wall main.c

libs.o : libs.c libs.h
	gcc -c -Wall libs.c

madmatrix.o : madmatrix.c madmatrix.h
	gcc -c -Wall madmatrix.c

alloctab.o : alloctab.c alloctab.h
	gcc -c alloctab.c
