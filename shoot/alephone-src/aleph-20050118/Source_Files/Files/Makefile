LIB = libfiles.a

SRC = \
  AStream.cpp crc.cpp FileHandler_SDL.cpp find_files_sdl.cpp game_wad.cpp \
  import_definitions.cpp Packing.cpp preprocess_map_sdl.cpp \
  preprocess_map_shared.cpp resource_manager.cpp wad.cpp wad.cpp \
  wad_prefs.cpp wad_sdl.cpp

top_srcdir = ../..

INCLUDES = -I$(top_srcdir)/Source_Files/CSeries -I$(top_srcdir)/Source_Files/GameWorld \
  -I$(top_srcdir)/Source_Files/Input -I$(top_srcdir)/Source_Files/Misc \
  -I$(top_srcdir)/Source_Files/ModelView -I$(top_srcdir)/Source_Files/Network \
  -I$(top_srcdir)/Source_Files/Pfhortran -I$(top_srcdir)/Source_Files/RenderMain \
  -I$(top_srcdir)/Source_Files/RenderOther -I$(top_srcdir)/Source_Files/Sound \
  -I$(top_srcdir)/Source_Files/XML -I$(top_srcdir)/Source_Files \
  -Isdk:local/newlib/include/SDL -I.

OBJ = $(SRC:.cpp=.o)

DEFINES = -DSDL -DHAVE_LUA -DHAVE_SDL_IMAGE_H -DWORDS_BIGENDIAN -DHAVE_SDL_NET -DHAVE_UNISTD_H

CFLAGS = -O2 -newlib -g -Wall $(DEFINES) $(INCLUDES) -c

all: $(LIB)

$(LIB): $(OBJ)
	ar -ru $(LIB) $(OBJ)
	ranlib $(LIB)

%.o:%.cpp
	g++ $(CFLAGS) $<

clean:
	delete #?.o
	delete $(LIB)
