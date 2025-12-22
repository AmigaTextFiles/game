CC	= gcc
CFLAGS = -newlib -O2 -ISDK:Local/clib2/include/SDL -IUSR:local/include
LIBS = -newlib -lSDL_mixer -LSDK:Local/clib2/lib -lSDL_image -lSDLmain -LUSR:local/lib -lpng -ljpeg -lz -lSDL -lvorbisfile -lvorbis -logg -lauto -lm

#CFLAGS	= -O2 -I/usr/local/include/SDL -D_REENTRANT
EXE	= lopan
OBJS	= $(EXE).o gfx.o font.o

$(EXE):	$(OBJS)
	gcc -o $(EXE) $(OBJS) $(CFLAGS) $(LIBS)

$(EXE).o: $(EXE).c gfx.h font.h

gfx.o:	gfx.c gfx.h

font.o:	font.c font.h

clean:
	rm *.o $(EXE)
