CC=gcc

CFLAGS=-Wall -O2 -newlib -ISDK:Local/newlib/include/SDL
SDL_LIBS= -newlib -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL -lauto -lpthread -lz

all:    ttt

clean:
	-rm ttt
	-rm ttt.o

ttt: ttt.o
	$(CC) $(CFLAGS) ttt.o -o ttt $(SDL_LIBS)

ttt.o:       ttt.c
