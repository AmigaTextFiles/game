# Makefile for test program for game_libs - lunar lander
CFLAGS=-Wall `sdl-config --libs --cflags` 
CC=gcc

LIBS=SDL_image

C_FILES=moon_lander.c game_lib.c DT_drawtext.c
OBJ_FILES=moon_lander.o game_lib.o DT_drawtext.o 
OUT_FILE=moon-lander.bin

all: game_lib

game_lib: $(OBJ_FILES)
	$(CC) $(CFLAGS) -o $(OUT_FILE) $(OBJ_FILES) -l$(LIBS) -lSDL_mixer

moon_lander.o: moon_lander.c
	$(CC) $(CFLAGS) -c -o $@ $^

game_lib.o: game_lib.c
	$(CC) $(CFLAGS) -c -o $@ $^

DT_drawtext.o: DT_drawtext.c
	$(CC) $(CFLAGS) -c -o $@ $^

clean: 
	rm -f *.o core  

install: 
	./install.sh


