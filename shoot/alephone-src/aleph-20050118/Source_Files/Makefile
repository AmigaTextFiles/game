#SUBDIRS = CSeries Expat Files GameWorld Input Lua Misc ModelView Network \
#  Pfhortran RenderMain RenderOther Sound TCPMess XML

PROGRAM = alephone

SRC = shell.cpp shell_misc.cpp

# this is a mess...try to fix it
LIBS = \
  CSeries/libcseries.a Expat/libexpat.a Files/libfiles.a \
  GameWorld/libgameworld.a Input/libinput.a Lua/liba1lua.a Misc/libmisc.a \
  ModelView/libmodelview.a Network/libnetwork.a Pfhortran/libpfhortran.a \
  RenderMain/librendermain.a RenderOther/librenderother.a Sound/libsound.a \
  TCPMess/libtcpmess.a XML/libxml.a \
  CSeries/libcseries.a Expat/libexpat.a Files/libfiles.a \
  GameWorld/libgameworld.a Input/libinput.a Lua/liba1lua.a Misc/libmisc.a \
  ModelView/libmodelview.a Network/libnetwork.a Pfhortran/libpfhortran.a \
  RenderMain/librendermain.a RenderOther/librenderother.a Sound/libsound.a \
  TCPMess/libtcpmess.a XML/libxml.a

blab =  Files/libfiles.a GameWorld/libgameworld.a Input/libinput.a Lua/liba1lua.a \
  ModelView/libmodelview.a Network/libnetwork.a Pfhortran/libpfhortran.a \
  RenderOther/librenderother.a Sound/libsound.a \
  XML/libxml.a Expat/libexpat.a CSeries/libcseries.a Misc/libmisc.a RenderMain/librendermain.a \
  \
  CSeries/libcseries.a Expat/libexpat.a Files/libfiles.a \
  GameWorld/libgameworld.a Input/libinput.a Lua/liba1lua.a Misc/libmisc.a \
  ModelView/libmodelview.a Network/libnetwork.a Pfhortran/libpfhortran.a \
  RenderMain/librendermain.a RenderOther/librenderother.a Sound/libsound.a \
  TCPMess/libtcpmess.a XML/libxml.a 

top_srcdir = ..

INCLUDES = -I$(top_srcdir)/Source_Files/CSeries -I$(top_srcdir)/Source_Files/Files \
  -I$(top_srcdir)/Source_Files/GameWorld -I$(top_srcdir)/Source_Files/Input \
  -I$(top_srcdir)/Source_Files/Lua -I$(top_srcdir)/Source_Files/Misc \
  -I$(top_srcdir)/Source_Files/ModelView -I$(top_srcdir)/Source_Files/Network \
  -I$(top_srcdir)/Source_Files/Pfhortran -I$(top_srcdir)/Source_Files/RenderMain \
  -I$(top_srcdir)/Source_Files/RenderOther -I$(top_srcdir)/Source_Files/Sound \
  -I$(top_srcdir)/Source_Files/XML -I$(top_srcdir)/Source_Files/Expat \
  -I$(top_srcdir)/Source_Files/TCPMess \
  -Isdk:local/newlib/include/SDL -I.

OBJ = $(SRC:.cpp=.o)

DEFINES = -DSDL -DHAVE_LUA -DHAVE_SDL_IMAGE_H -DWORDS_BIGENDIAN -DHAVE_SDL_NET -DHAVE_UNISTD_H \
	-DHAVE_SNPRINTF -DHAVE_VSNPRINTF -DHAVE_SDL_SOUND_H -DHAVE_SDL_SOUND -DHAVE_SDL_NET_H \
    -DPKGDATADIR="/PROGDIR"

CFLAGS = -O2 -newlib -g -Wall $(DEFINES) $(INCLUDES) -c

AOS4LIBS = -llua -llualib -lSDL_Image -lpng -ljpeg -lz -lSDL_Net -lSDL_Sound -lvorbisfile \
	-lvorbis -logg -lSDL -lauto -lpthread -lunix

all: do_libs $(PROGRAM)

$(PROGRAM): $(OBJ) $(LIBS)
	g++ -newlib -o $(PROGRAM) $(OBJ) $(LIBS) $(AOS4LIBS)

do_libs:
	make -C CSeries
	make -C Expat
	make -C Files
	make -C GameWorld
	make -C Input
	make -C Lua
	make -C Misc
	make -C ModelView
	make -C Network
	make -C Pfhortran
	make -C RenderMain
	make -C RenderOther
	make -C Sound
	make -C TCPMess
	make -C XML

%.o:%.cpp
	g++ $(CFLAGS) $<

clean:
	make -C CSeries clean
	make -C Expat clean
	make -C Files clean
	make -C GameWorld clean
	make -C Input clean
	make -C Lua clean
	make -C Misc clean
	make -C ModelView clean
	make -C Network clean
	make -C Pfhortran clean
	make -C RenderMain clean
	make -C RenderOther clean
	make -C Sound clean
	make -C TCPMess clean
	make -C XML clean
	delete #?.o
	delete $(PROGRAM)

# Data directories
#confpaths.h: Makefile
#	 echo "#define PKGDATADIR \"$(pkgdatadir)\"" > $@

shell.o: confpaths.h
