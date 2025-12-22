INCLUDES =  -Wall -DDATA_DIR=\"$(pkgdatadir)\"  $(FLY_CFLAGS)
    
bin_PROGRAMS = fly

fly_SOURCES = main.c flyer.c flyer.h scenario.c scenario.h camera.c camera.h\
             object3d.c object3d.h laser.c laser.h map.c map.h\
             timing.c timing.h\
	     list.c list.h\
	     text.c text.h\
	     wall.c wall.h\
	     level.c level.h\
	     explosion.c explosion.h\
	     texture.c texture.h\
             cache.c cache.h\
             hashtable.c hashtable.h\
             vector.c vector.h\
	     system.h getopt.c getopt1.c getopt.h

#  uncomment the following if fly requires the math library
fly_LDADD= @GLLIBS@ -lSDL_mixer -lglut

EXTRA_DIST=Makefile.mingw
