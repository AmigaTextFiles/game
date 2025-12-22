PROG := syobon

GAMEDATA ?= .

CXX ?= g++
CXXFLAGS ?= -O2 -pipe

SRCS := DxLib.cpp loadg.cpp main.cpp
OBJS := $(SRCS:%.cpp=%.o)

CXXFLAGS += $(shell sdl-config --cflags)
LIBS := -lSDL_mixer -lvorbisfile -lvorbis -logg -lmikmod -lSDL_ttf -lfreetype2 -lSDL_image -lpng -lz -ljpeg -lSDL_gfx $(shell sdl-config --libs)

all: $(PROG)

$(PROG): $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.cpp
	$(CXX) -o $@ $(CXXFLAGS) -DGAMEDATA=\"$(GAMEDATA)\" -c $<

clean:
	rm -f $(OBJS)

distclean: clean
	rm -f $(PROG) $(OBJS)
