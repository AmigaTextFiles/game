SOURCES = pieces.cpp layers.cpp namedv.cpp tetris.cpp menu.cpp prefs_file.cpp main.cpp
OBJ = pieces.o layers.o namedv.o tetris.o menu.o prefs_file.o main.o

EDITORSOURCES = pieceeditor.cpp pieces.cpp
EDITOROBJ = pieceeditor.o pieces.o

all: $(OBJ)
	g++ -mcrt=newlib -Wall -O2 -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL -o tetris $(OBJ) `sdl-config --libs` -mcrt=newlib -lSDL_gfx -lSDL_net -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lsmpeg -lvorbisfile -lvorbis -logg -lstdc++ -lSDL_ttf -lfreetype -lz -lsdlmain -lsdl -lauto -lpthread -lm -lunix

editor: $(EDITOROBJ)
	g++ -mcrt=newlib -Wall -O2 -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL -o pieceeditor $(EDITOROBJ) `sdl-config --libs` -mcrt=newlib -lSDL_gfx -lSDL_net -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lsmpeg -lvorbisfile -lvorbis -logg -lstdc++ -lSDL_ttf -lfreetype -lz -lsdlmain -lsdl -lauto -lpthread -lm -lunix

%.o : %.cpp
	g++ -mcrt=newlib -Wall -O2 -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL -O3 -c -g $(CXXFLAGS) `sdl-config --cflags` $<

clean:
	rm *.o tetris pieceeditor
