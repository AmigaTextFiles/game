SRC = actset.cpp areaset.cpp charset.cpp charsset.cpp command.cpp coreset.cpp \
dataset.cpp dungeon.cpp game.cpp godset.cpp iconf.cpp id.cpp igraph.cpp        \
itemset.cpp levelset.cpp main.cpp materset.cpp message.cpp object.cpp           \
roomset.cpp script.cpp slotset.cpp trapset.cpp wmapset.cpp wskill.cpp

OBJ = $(SRC:.cpp=.o)

DEFINES = -DUSE_SDL -DLOCAL_STATE_DIR=\"/PROGDIR\" -DGCC
CFLAGS = -O3 -newlib -I../include -I../../felib/include -Isdk:local/newlib/include/SDL -Wall -W $(DEFINES) -c

../../ivan: $(OBJ) ../../felib/source/libfelib.a
	g++ -o $@ $(OBJ) ../../felib/source/libfelib.a -newlib -lSDL -lpthread -lauto -lunix
	strip $@ -R.comment -o $@_stripped

%.o : %.cpp
	g++ $(CFLAGS) $< -o $@

clean:
	delete #?.o




