# Eugene aGGreSSor Sobolev greets you!

#INCLUDES= `sdl-config --cflags`#LIBS= `sdl-config --libs`#CFLAGS= $(INCLUDES) $(LIBS)
CFLAGS = -O2 -w
LIBS = -lSDL_mixer -lSDL_image -lSDL -lpng -ljpeg -lz -lSDL -lvorbisfile -lvorbis -logg -lm

OBJS= jetpac.o game.o menu.o graphics.o levels.o
CPP= i386-aros-g++STRIP= i386-aros-strip


jetpac: $(OBJS)
	@echo 'Linking jetpac'
	$(CPP) -o jetpac $(OBJS) $(CFLAGS) $(LIBS)

%.o: %.cpp
	@echo 'Compiling $<'
	@$(CPP) $(CFLAGS) -c -o $@ $< -Wall	$(STRIP) --strip-unneeded --remove-section .comment $<

clean:
	@echo 'Removing old object modules'
	rm -f *.o jetpac
