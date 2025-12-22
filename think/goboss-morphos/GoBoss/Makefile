all:
	gcc -O3 -Iusr:local/include -Iusr:/include/SDL -o goboss src/main.c src/communic.c src/gameparams.c src/spot.c src/display.c src/goutils.c -lSDL

all2:
	gcc -g -Wall `sdl-config --cflags --libs` -o goboss src/main.c src/communic.c src/gameparams.c src/spot.c src/display.c src/goutils.c
