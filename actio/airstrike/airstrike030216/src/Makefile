CFLAGS:= -g -O2 -Wall -Wno-unused $(OPTIONS)

CFLAGS += $(shell sdl-config --cflags) -Isprite -I. -Isupport -DINLINE=inline -DUSE_SOUND
#CFLAGS +=
#-DLINUX
CFILES:= $(shell find . -name '*.c')
OBJECTS:= $(CFILES:.c=.o)

airstrike: $(OBJECTS)
	$(CC) -noixemul -o $@ $(CFLAGS) $(OBJECTS) `sdl-config --libs` -lSDL_mixer -lSDL_image -ljpeg -lpng -lz

airstrike-sound: $(OBJECTS)
	$(CC) -noixemul -DUSE_SOUND -o $@ $(CFLAGS) $(OBJECTS) `sdl-config --libs` -lSDL_image -lSDL_mixer -ljpeg -lpng -lz

# Use the rule below when coding new sprite types
#sprites_autogen.h: sprite_types/*.c
#	../utils/genspritelist.sh $^

clean:
	rm -f `find . -name '*.[od]' -or -name '*~' -or -name '*.bb' -or -name '*.bbg'`

dryclean: 
	rm -f `find . -name '*.[^ch]' -type f` 

#Automatic dependency handling. This is not needed for a simple compile.

#include $(CFILES:.c=.d)
#
#%.d: %.c
#	$(CC) -MM $(CFLAGS) $< > $@.$$$$; \
#	sed 's,$(*F)\.o[ :]*,$(@:.d=.o) $@ : ,g' < $@.$$$$ > $@; \
#	rm -f $@.$$$$
