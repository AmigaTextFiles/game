
CC = gcc

objects = src/BlastTiles.o src/DrawTiles.o src/SDL_events.o src/SDL_utils.o src/engine.o src/game.o src/main.o src/require.o 

headers = src/BlastTiles.h src/Config.h src/DrawTiles.h src/SDL_events.h src/SDL_utils.h src/TileColors.h src/Version.h src/engine.h src/game.h src/libraries.h src/main.h src/mouse.h src/require.h 

ctm3d: $(objects)
	$(CC) -o ctm3d $(objects) `sdl-config --libs` $(CFLAGS)

clean:
	rm -f ctm3d $(objects)

