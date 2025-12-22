# Makefile for Righteous

CC = cc
CFLAGS =-O2 -Wall
LIBS=-lSDL -lSDL_image -lSDL_mixer

righteous: righteous.o mathstuff.o gameloopsinglecpu.o gameloopsingleplayer.o
	$(CC) $(CFLAGS) $(LIBS) -o $@ $<

righteous.o: righteous.c
	$(CC) -c -o $@ $<

mathstuff.o: mathstuff.c
	$(CC) -c -o $@ $<

gameloopsinglecpu.o: gameloopsinglecpu.c
	$(CC) -c -o $@ $<

gameloopsingleplayer.o: gameloopsingleplayer.c
	$(CC) -c -o $@ $<

.PHONY: clean
clean:
	-rm -f *.o
