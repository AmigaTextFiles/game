LIB = libgameworld.a

SRC = \
  devices.cpp dynamic_limits.cpp effects.cpp flood_map.cpp items.cpp \
  lightsource.cpp map_constructors.cpp map.cpp marathon2.cpp media.cpp \
  monsters.cpp pathfinding.cpp physics.cpp placement.cpp platforms.cpp \
  player.cpp projectiles.cpp scenery.cpp weapons.cpp world.cpp

top_srcdir = ../..

INCLUDES = -I$(top_srcdir)/Source_Files/CSeries -I$(top_srcdir)/Source_Files/Files \
  -I$(top_srcdir)/Source_Files/Input -I$(top_srcdir)/Source_Files/Lua \
  -I$(top_srcdir)/Source_Files/Misc -I$(top_srcdir)/Source_Files/ModelView \
  -I$(top_srcdir)/Source_Files/Network -I$(top_srcdir)/Source_Files/Pfhortran \
  -I$(top_srcdir)/Source_Files/RenderMain -I$(top_srcdir)/Source_Files/RenderOther \
  -I$(top_srcdir)/Source_Files/Sound -I$(top_srcdir)/Source_Files/XML \
  -I$(top_srcdir)/Source_Files \
  -Isdk:local/newlib/include/SDL -I.

OBJ = $(SRC:.cpp=.o)

DEFINES = -DSDL -DHAVE_LUA -DHAVE_SDL_IMAGE_H -DWORDS_BIGENDIAN -DHAVE_SDL_NET

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
