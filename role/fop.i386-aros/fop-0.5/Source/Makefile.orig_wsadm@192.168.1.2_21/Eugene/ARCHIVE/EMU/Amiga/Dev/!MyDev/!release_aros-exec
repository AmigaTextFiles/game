# Makefile for FOP: Fight or Perish
#
# Bill Kendrick <bill@newbreedsoftware.com>
# http://www.newbreedsoftware.com/fop
#
# February 25, 2009 - March 15, 2009

VERSION=0.5
CC=gcc
SDL_CFLAGS=$(shell sdl-config --cflags)
SDL_LIBS=$(shell sdl-config --libs) -lSDL_image
CFLAGS=-Wall -O2 $(SDL_CFLAGS) -DVERSION="\"${VERSION}\""

all:	fop

clean:
	-rm fop
	-rm *.o

fop:	fop.o
	$(CC) -o fop fop.o $(SDL_LIBS) -lm

fop.o:	src/fop.c
	$(CC) -o fop.o src/fop.c -c $(CFLAGS)
