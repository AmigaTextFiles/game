all: naster

naster: naster.o
	gcc `sdl-config --libs` -lSDL_image naster.o SFont.o -o naster
naster.o: naster.c
	gcc -c `sdl-config --cflags` -Wall SFont.c
	gcc -c `sdl-config --cflags` -Wall naster.c
clean:
	rm -f *.o
	rm -f naster
install:
	install -D naster /usr/local/games/naster
	install -D 14P_Copperplate_Blue.png /usr/local/share/games/naster/14P_Copperplate_Blue.png
	install -D board.png /usr/local/share/games/naster/board.png
