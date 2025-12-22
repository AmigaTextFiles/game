LIB = librendermain.a

SRC = \
  AnimatedTextures.cpp Crosshairs_SDL.cpp ImageLoader_SDL.cpp  render.cpp \
  RenderPlaceObjs.cpp RenderRasterize.cpp \
  RenderSortPoly.cpp RenderVisTree.cpp scottish_textures.cpp shapes.cpp \
  textures.cpp OGL_Faders.cpp \
  OGL_Model_Def.cpp OGL_Render.cpp OGL_Setup.cpp OGL_Subst_Texture_Def.cpp \
  OGL_Textures.cpp $(EXTRA_GL)

top_srcdir = ../..

INCLUDES = -I$(top_srcdir)/Source_Files/CSeries -I$(top_srcdir)/Source_Files/Files \
  -I$(top_srcdir)/Source_Files/GameWorld -I$(top_srcdir)/Source_Files/Input \
  -I$(top_srcdir)/Source_Files/Misc -I$(top_srcdir)/Source_Files/ModelView \
  -I$(top_srcdir)/Source_Files/Network -I$(top_srcdir)/Source_Files/Pfhortran \
  -I$(top_srcdir)/Source_Files/RenderOther -I$(top_srcdir)/Source_Files/Sound \
  -I$(top_srcdir)/Source_Files/XML -I$(top_srcdir)/Source_Files \
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
