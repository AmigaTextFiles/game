include ../make.conf

CC=g++ -m68020 -m68881

.SUFFIXES:
.SUFFIXES: .m .cpp .o

SOURCES = common_funcs.cpp pieces.cpp layers.cpp namedv.cpp sporktris.cpp menu.cpp prefs_file.cpp highscores.cpp keys.cpp main.cpp 
OBJ = common_funcs.o pieces.o layers.o namedv.o sporktris.o menu.o prefs_file.o highscores.o keys.o main.o 

EDITORSOURCES = pieceeditor.cpp pieces.cpp
EDITOROBJ = pieceeditor.o pieces.o

all: $(OBJ)
	$(CC) -o sporktris $(OBJ) -lSDL_ttf -lfreetype -lSDL_image -ljpeg -lpng -lz `sdl-config --libs` -lm 

editor: $(EDITOROBJ)
	$(CC) -o pieceeditor $(EDITOROBJ) -lSDL_image -ljpeg -lpng -lz `sdl-config --libs` -lm 

%.o : %.cpp
	$(CC) -c -g $(CXXFLAGS) -DDATA_DIR=\"PROGDIR:data\" -DINSTALL_DIR=\"PROGDIR:data\" -DINSTALL_PREFIX=\".sporktris_\" `sdl-config --cflags` $<

%.o : %.m
	$(CC) -c -g $(CXXFLAGS) `sdl-config --cflags` $<

clean:
	rm *.o sporktris pieceeditor
