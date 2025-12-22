SRC = scummer.cpp graphicengine.cpp image.cpp blocks.cpp iostuff.cpp graphics.cpp viewer.cpp

OBJECTS = $(SRC:.cpp=.o)

CFLAGS= -g -Wall -I./includes
CFLAGS += `sdl-config --cflags`

all: $(OBJECTS)
	c++ -o  scummer  `sdl-config --libs` $(OBJECTS) 
clean:
	rm -f $(OBJECTS)

.cpp.o:
	c++ $(CFLAGS) -c $< -o $(<:.cpp=.o)