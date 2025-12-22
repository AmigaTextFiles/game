CPP = g++
INCDIR =  #-I/home/grad/03/farrer/SDL/include/
LINKDIR = #-L/home/grad/03/farrer/SDL/lib/
CFLAGS = -mcrt=newlib $(INCDIR) -Wall -g -c
EFLAGS = $(INCDIR) -Wall $(LINKDIR) -mcrt=newlib -lSDL_gfx -lSDL_net -lSDL_image -ltiff -lpng -ljpeg -lz -lSDL_mixer -lsmpeg -lm -lvorbisfile -lvorbis -logg -lstdc++ -lSDL_ttf -lfreetype -lz -lsdlmain -lsdl -lauto -lpthread -lm -lunix
OBJECTS = avaibleMove.o board.o game.o menu.o minimax.o tp1.o


all: lothello

lothello: $(OBJECTS)
	$(CPP) $(OBJECTS) $(EFLAGS) -o lothello

avaibleMove.o: avaibleMove.cpp avaibleMove.h
	$(CPP) $(CFLAGS) avaibleMove.cpp -o avaibleMove.o

board.o: board.cpp board.h
	$(CPP) $(CFLAGS) board.cpp -o board.o

game.o: game.cpp game.h defs.h
	$(CPP) $(CFLAGS) game.cpp -o game.o

menu.o: menu.cpp menu.h defs.h
	$(CPP) $(CFLAGS) menu.cpp -o menu.o

minimax.o: minimax.cpp minimax.h avaibleMove.h board.h
	$(CPP) $(CFLAGS) minimax.cpp -o minimax.o

tp1.o: tp1.cpp game.h defs.h menu.h
	$(CPP) $(CFLAGS) tp1.cpp -o tp1.o

clean:
	rm -rf *.o lothello
