CXX=g++ -noixemul
#DEBUGFLAGS= -Wall
DEBUGFLAGS=
CXXFLAGS= -O3 -mstring -mmultiple -g `sdl-config --cflags` $(DEBUGFLAGS)
LIBS= `sdl-config --libs` -lSDL_image -lSDL_net -lSDL_mixer
OBJ=src/main.o src/window.o src/graphics.o src/clientconf.o src/variable.o \
src/mouse.o src/keyboard.o src/trixmenu.o src/font.o \
src/sound.o src/net.o src/stringblock.o src/servlist.o src/button.o \
src/client.o src/block.o src/tetrablock.o src/splayer.o src/chat.o \
src/servconf.o src/scrollbar.o src/followclient.o src/media.o

P_NAME=Blobtrix

all: main

main: $(OBJ)
	$(CXX) $(OBJ) $(LIBS) $(CXXFLAGS) -o $(P_NAME) -O3 -g
	strip --remove-section=.comment $(P_NAME)

clean:
	rm src/*.o
	rm $(P_NAME)
	rm *.da
