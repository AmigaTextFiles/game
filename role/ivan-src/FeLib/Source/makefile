SRC =  bitmap.cpp config.cpp error.cpp feio.cpp felist.cpp femain.cpp femath.cpp \
  festring.cpp fetime.cpp graphics.cpp hscore.cpp rawbit.cpp save.cpp             \
  whandler.cpp

OBJ = $(SRC:.cpp=.o)

DEFINES = -DUSE_SDL -DLOCAL_STATE_DIR=\"/PROGDIR\" -DGCC
CFLAGS = -O3 -newlib -I../include -Isdk:local/newlib/include/SDL -Wall -W $(DEFINES) -c

libfelib.a: $(OBJ)
	ar -ru $@ $(OBJ)
	ranlib $@

%.o : %.cpp
	g++ $(CFLAGS) $< -o $@

clean:
	delete #?.o
	delete libfelib.a


