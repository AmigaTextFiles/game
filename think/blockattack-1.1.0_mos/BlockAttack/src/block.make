Game/bloackattack: 	main.o highscore.o SFont.o ReadKeyboard.o joypad.o
	g++ -O -o Game/blockattack main.o highscore.o SFont.o ReadKeyboard.o joypad.o `sdl-config --cflags --libs` -lSDL_image -lSDL_mixer

main.o:	main.cpp
	g++ -c main.cpp `sdl-config --cflags`

highscore.o: highscore.h highscore.cpp
	g++ -c highscore.cpp

SFont.o: SFont.h SFont.c
	g++ -c SFont.c `sdl-config --cflags`

ReadKeyboard.o: ReadKeyboard.h ReadKeyboard.cpp
	g++ -c ReadKeyboard.cpp `sdl-config --cflags`

joypad.o: joypad.h joypad.cpp
	g++ -c joypad.cpp `sdl-config --cflags`