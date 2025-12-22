# Standard defines:

CC	=	g++
LD	=	g++
CCOMP	=	gcc
oDir	=	
Bin	=	
libDirs	=	-L/SDK/Local/clib2/lib/
incDirs	=	-I. -I.. -I/SDK/Include/include_h -I/SDK/local/common/include/SDL -I/SDK/Local/clib2/include/SDL
LD_FLAGS	=	
LIBS	=	-lSDL_net -lSDLmain -lSDL_image -lSDL_mixer -lsmpeg -lvorbisfile -lvorbis -logg -lSDL -lpthread -lm -lauto -lnet
C_FLAGS	=	-O2
SRCS	=	filter.c fireworks.c main.c menu.c sdl/gfx.c sdl/input.c sdl/interrpt.c sdl/sound.c 
EXOBJS	=	$(oDir)filter.o $(oDir)fireworks.o $(oDir)main.o $(oDir)menu.o $(oDir)sdl/gfx.o $(oDir)sdl/input.o $(oDir)sdl/interrpt.o $(oDir)sdl/sound.o
ALLOBJS	=	$(EXOBJS)
ALLBIN	=	$(Bin)jumpnbump
ALLTGT	=	$(Bin)jumpnbump

#@# Targets follow ---------------------------------
all:	$(ALLTGT)
objs:	$(ALLOBJS)
cleanobjs:
	delete all $(ALLOBJS)
cleanbin:
	delete all $(ALLBIN)
clean:	cleanobjs cleanbin
cleanall:	cleanobjs cleanbin

#@# Dependency rules follow -----------------------------
$(Bin)jumpnbump: $(EXOBJS)
	$(LD) -o $(Bin)jumpnbump $(EXOBJS) $(incDirs) $(libDirs) $(LD_FLAGS) $(LIBS)

$(oDir)filter.o: filter.c filter.h globals.h
	$(CC) $(C_FLAGS) $(incDirs) -c -o $@ $<

$(oDir)fireworks.o: fireworks.c globals.h
	$(CC) $(C_FLAGS) $(incDirs) -c -o $@ $<

$(oDir)main.o: main.c globals.h
	$(CC) $(C_FLAGS) $(incDirs) -c -o $@ $<

$(oDir)menu.o: menu.c globals.h
	$(CC) $(C_FLAGS) $(incDirs) -c -o $@ $<

$(oDir)sdl/gfx.o: sdl/gfx.c
	$(CC) $(C_FLAGS) $(incDirs) -c -o $@ $<

$(oDir)sdl/input.o: sdl/input.c
	$(CC) $(C_FLAGS) $(incDirs) -c -o $@ $<

$(oDir)sdl/interrpt.o: sdl/interrpt.c
	$(CC) $(C_FLAGS) $(incDirs) -c -o $@ $<

$(oDir)sdl/sound.o: sdl/sound.c
	$(CC) $(C_FLAGS) $(incDirs) -c -o $@ $<

