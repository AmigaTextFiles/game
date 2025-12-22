# BINIAX-2 1.3 MAKEFILE FOR UNIX/LINUX/MACOS SYSTEMS
# (C) 2005-2009, JORDAN TUZSUZOV
# To build the game you need the development libraries of SDL 1.2, SDL_mixer and SDL_image.
# To execute the game you need the runtimes of SDL, SDL_mixer and SDL_image.

FLAGS=-W -WALL
CC=gcc -m68020 -m68881
FILES=biniax.c hof.c desktop/cfg.c desktop/gfx.c desktop/snd.c desktop/inp.c desktop/sys.c
INCLUDES=-I . -I desktop
LINKTO= -lSDL_image -ljpeg -lpng -lz -lSDL_mixer `sdl-config --libs` -lm
AUTO=`sdl-config --libs --cflags`
TARGET=biniax2

biniax:
	$(CC) $(AUTO) $(FILES) $(INCLUDES) -o $(TARGET) $(LINKTO)