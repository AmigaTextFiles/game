# Makefile for Righteous

CC = gcc
CFLAGS 	=`sdl-config --cflags` -mcrt=newlib -Wall -O2 -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL -g -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lsmpeg -lvorbisfile -lvorbisenc -lvorbis -logg -lSDL_mixer -lSDL_ttf -lfreetype -lsdlmain -lsdl -lauto -lpthread -lm
LIBS	=`sdl-config --libs` -g -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lsmpeg -lvorbisfile -lvorbisenc -lvorbis -logg -lSDL_ttf -lfreetype -lsdlmain -lsdl -lauto -lpthread -lm -mcrt=newlib

righteous: righteous.o mathstuff.o gameloopsingleplayer.o
	$(CC) $(CFLAGS) $(LIBS) -o $@ $<

righteous.o: righteous.c
	$(CC) -c -o $@ $<

mathstuff.o: mathstuff.c
	$(CC) -c -o $@ $<

gameloopsingleplayer.o: gameloopsingleplayer.c
	$(CC) -c -o $@ $<

.PHONY: clean
clean:
	-rm -f righteous *.o
