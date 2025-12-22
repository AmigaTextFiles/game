bin_PROGRAMS = bitefusion

AM_CFLAGS = -g -Wall -O2 @ARCHFLAGS@

LINUX = @LINUX@
WIN32 = @WIN32@
DARWIN = @DARWIN@

bitefusion_SOURCES = main.c error.c error.h image.c images.h

if LINUX
bitefusion_LDADD = -lSDL -lz
endif
if WIN32
bitefusion_LDADD = /usr/i586-mingw32msvc/lib/libSDL.a -lgdi32 -lwsock32 -ldxguid -lwinmm -lz
endif
if DARWIN
bitefusion_LDFLAGS = -framework Carbon -framework CoreServices -framework AudioUnit -framework QuickTime -framework Cocoa -framework IOKit -framework OpenGL
bitefusion_LDADD = /usr/local/lib/libSDL.a /usr/local/lib/libSDLmain.a -lstdc++ -lz
endif
