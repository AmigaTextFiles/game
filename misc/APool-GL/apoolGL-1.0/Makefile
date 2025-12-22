# SDL has to be installed properly. sdl-config MUST be in your PATH-Environment
SDLCFLAGS=`sdl-config --cflags`
CFLAGS=-O3 -Wall -ansi -pedantic -ffast-math -fomit-frame-pointer -funroll-loops -finline-functions -I/usr/local/X11R6/include $(SDLCFLAGS)
# you may uncomment the following line when using gcc-3.X
# CFLAGS:=$(CFLAGS) -march=athlon-xp -mfpmath=sse
# be more verbose...
CFLAG:=$(CFLAGS) -DDEBUG

SDLLIBS=`sdl-config --libs`

# Libraries for OpenGL
GLLIBS=-lGL -lGLU
# uncomment the following line when using Windows
# GLLIBS=-lopengl32 -lglu32

O_FILES=graphics.o apool.o computer.o physics.o gl.o
LIBS=-L/usr/local/X11R6/lib -L/usr/X11R6/lib $(SDLLIBS) $(GLLIBS)

apool:	$(O_FILES)
	$(CC) $(O_FILES) $(LIBS) -lm -o apool

%.o:    %.c apool.h Makefile
	$(CC) $(CFLAGS) -c $*.c -o $*.o

clean:
	rm -f *.o core
	strip apool

mrproper:
	rm -f *.o apool core *~

distclean:	
	make mrproper

install:
	install -d /usr/local/share/apool
	cp -af * /usr/local/share/apool/
	ln -sf /usr/local/share/apool/apool /usr/local/bin/apool
