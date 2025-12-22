LIB = libcseries.a
SRC = \
  byte_swapping.cpp csalerts_sdl.cpp cscluts_sdl.cpp csdialogs_sdl.cpp \
  csmisc_sdl.cpp csstrings_sdl.cpp mytm_sdl.cpp snprintf.cpp

EXTRA_libcseries_a_SOURCES = csfiles_beos.cpp

top_srcdir = ../..

INCLUDES = -I$(top_srcdir)/Source_Files/Files -I$(top_srcdir)/Source_Files/GameWorld \
  -I$(top_srcdir)/Source_Files/Input -I$(top_srcdir)/Source_Files/Misc \
  -I$(top_srcdir)/Source_Files/ModelView -I$(top_srcdir)/Source_Files/Network \
  -I$(top_srcdir)/Source_Files/Pfhortran -I$(top_srcdir)/Source_Files/RenderMain \
  -I$(top_srcdir)/Source_Files/RenderOther -I$(top_srcdir)/Source_Files/Sound \
  -I$(top_srcdir)/Source_Files/XML \
  -Isdk:local/newlib/include/SDL -I.

OBJ = $(SRC:.cpp=.o)

DEFINES = -DSDL -DHAVE_LUA -DHAVE_SDL_IMAGE_H -DWORDS_BIGENDIAN -DHAVE_SDL_NET -DHAVE_UNISTD_H -DHAVE_SNPRINTF -DHAVE_VSNPRINTF

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
