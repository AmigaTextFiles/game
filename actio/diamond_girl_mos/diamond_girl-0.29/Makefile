CC = gcc
LD = gcc

DEBUG_OFF = -O3
DEBUG_NORMAL = -O1 -ggdb
DEBUG_FULL = -O0 -ggdb
DFLAGS = $(DEBUG_NORMAL)

CFLAGS = $(DFLAGS) -Wextra -Wall $(shell sdl-config --cflags) -std=gnu99 -Werror -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wredundant-decls -Wnested-externs
LDFLAGS = $(DFLAGS) $(shell sdl-config --libs) -lSDL_gfx -lSDL_image -lSDL_mixer


OBJECTS = src/main.o src/gfx.o src/main_menu.o src/BFont.o src/map.o src/game.o src/highscore.o src/sfx.o src/editor.o src/draw_map.o


all: diamond_girl

up_revision:
	$(CC) src/revision.c -o revision
	./revision > src/version.h
	cvs commit -m "up_revision" src/version.h


clean:
	$(RM) $(OBJECTS) diamond_girl *~ src/*~ revision

diamond_girl: $(OBJECTS)
	$(LD) $(OBJECTS) $(LDFLAGS) -o $@


%.o : %.c src/diamond_girl.h src/version.h
	$(CC) $(CFLAGS) -c $< -o $@

