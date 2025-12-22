#INC=-I/usr/include/SDL -I. -I.. -I../../C-Nd_array
INC = -I/usr/include/SDL -I. -I$(HOME)/projects/include
LIB=-lSDL -lSDL_image -L$(HOME)/projects/lib
CC=gcc -Wall -g

OBJS=drawmap.o  genmap.o  ortho-interp.o cosmap.o

all: Makefile.dep  $(OBJS) main.o
	$(CC) $(LIB) -o drmain main.o $(OBJS) -ldXrng -lCgrid

testdraw: $(OBJS) testdraw.o
	$(CC) $(LIB) -o testdraw testdraw.o $(OBJS) -lCgrid

testcos:  cosmap.o testcos.o
	$(CC) $(LIB) -o testcos cosmap.o testcos.o

perlinify:  $(OBJS) perlinify.o
	$(CC) $(LIB) -o perlinify perlinify.o $(OBJS) -lCgrid



Makefile.dep depend: *.c
	for i in *.c; do $(CC) $(INC) -MM $$i;done >Makefile.dep

include Makefile.dep

.c.o:
	$(CC) $(INC) -c $<
