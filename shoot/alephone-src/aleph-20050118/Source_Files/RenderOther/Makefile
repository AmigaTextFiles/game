LIB = librenderother.a

SRC = \
  ChaseCam.cpp computer_interface.cpp fades.cpp FontHandler.cpp game_window.cpp \
  game_window_sdl.cpp HUDRenderer.cpp HUDRenderer_OGL.cpp HUDRenderer_SW.cpp \
  images.cpp motion_sensor.cpp overhead_map.cpp OverheadMap_OGL.cpp \
  OverheadMapRenderer.cpp OverheadMap_SDL.cpp screen_drawing.cpp screen_sdl.cpp \
  sdl_fonts.cpp TextLayoutHelper.cpp TextStrings.cpp ViewControl.cpp

top_srcdir = ../..

INCLUDES = -I$(top_srcdir)/Source_Files/CSeries -I$(top_srcdir)/Source_Files/Files \
  -I$(top_srcdir)/Source_Files/GameWorld -I$(top_srcdir)/Source_Files/Input \
  -I$(top_srcdir)/Source_Files/Lua -I$(top_srcdir)/Source_Files/Misc \
  -I$(top_srcdir)/Source_Files/ModelView -I$(top_srcdir)/Source_Files/Network \
  -I$(top_srcdir)/Source_Files/Pfhortran -I$(top_srcdir)/Source_Files/RenderMain \
  -I$(top_srcdir)/Source_Files/Sound -I$(top_srcdir)/Source_Files/XML \
  -I$(top_srcdir)/Source_Files \
  -Isdk:local/newlib/include/SDL -I.

OBJ = $(SRC:.cpp=.o)

DEFINES = -DSDL -DHAVE_LUA -DHAVE_SDL_IMAGE_H -DHAVE_SDL_IMAGE -DWORDS_BIGENDIAN -DHAVE_SDL_NET

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
