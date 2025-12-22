CC = gcc -mcrt=newlib
DEFINES = -DGFXMODULE_SDL=1 -DWORDS_BIGENDIAN=1
CFLAGS = -O2 -ggdb $(DEFINES) -Wall -I../libs -I../../ -I../ -I. -c
#LDFLAGS = -newlib -o
#LDLIBS = -lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL -lauto -lpthread

SRC = \
	calc.c cargo.c devices.c genburv.c genchmmr.c gencol.c gendru.c genilw.c \
	genmel.c genmyc.c genorz.c genpet.c genpku.c genrain.c gensam.c genshof.c \
	gensly.c gensol.c genspa.c gensup.c gensyr.c genthrad.c gentopo.c genutw.c \
	genvault.c genvux.c genwreck.c genyeh.c genzoq.c lander.c orbits.c oval.c \
	pl_stuff.c planets.c plangen.c pstarmap.c report.c roster.c scan.c solarsys.c \
	surface.c


OBJ = $(SRC:.c=.o)

libplanets.a: $(OBJ)
	ar -ru $@ $(OBJ)
	ranlib $@

%.o : %.c
	$(CC) $(CFLAGS) $<

clean:
	delete #?.o
	delete libplanets.a


