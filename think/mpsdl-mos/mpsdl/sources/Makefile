 all: mxsdl

sfont.o: SFont.c
	g++ -g -c `sdl-config --cflags` SFont.c

main.o: main.cpp
	g++ -g -c `sdl-config --cflags` main.cpp

mxsdl: main.o sfont.o
	g++ -g `sdl-config --libs` main.o SFont.o -o mpsdl -lSDL_image

clean:
	rm -rf *.o mpsdl
