bin_PROGRAMS = aklabeth
aklabeth_SOURCES = attack.c british.c ddraw.c dead.c draw.c draw2.c draw3.c dungeon.c globals.c hdr.c monst.c move.c player.c struct.h town.c world.c sdw.cpp main.c aklabeth.cpp hardware.cpp aklabeth.h aklabeth.hpp sdw.hxx

# set the include path found by configure
INCLUDES= $(all_includes)

# the library search path.
aklabeth_LDFLAGS = $(all_libraries) $(LIBSDL_RPATH)
aklabeth_CXXFLAGS = $(LIBSDL_CFLAGS)
aklabeth_LDADD = $(LIBSDL_LIBS)

