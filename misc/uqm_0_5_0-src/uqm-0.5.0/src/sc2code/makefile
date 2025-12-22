CC = gcc -mcrt=newlib
DEFINES = -DGFXMODULE_SDL=1 -DWORDS_BIGENDIAN=1
CFLAGS = -O2 -ggdb $(DEFINES) -Wall -Ilibs -I../ -I. -c
#LDFLAGS = #-newlib -o
#LDLIBS = #-lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL -lauto -lpthread

SRC = \
	battle.c border.c build.c cleanup.c clock.c collide.c comm.c commglue.c \
	confirm.c credits.c cyborg.c demo.c displist.c dummy.c encount.c fmv.c galaxy.c \
	gameev.c gameinp.c gameopt.c gendef.c getchar.c globdata.c gravity.c gravwell.c \
	grpinfo.c hyper.c init.c intel.c intro.c ipdisp.c load.c loadship.c master.c \
	melee.c menu.c misc.c mouse_err.c oscill.c outfit.c pickmele.c pickship.c \
	plandata.c process.c restart.c save.c settings.c setup.c setupmenu.c ship.c \
	shipstat.c shipyard.c sis.c sounds.c starbase.c starcon.c starmap.c state.c \
	status.c tactrans.c trans.c uqmdebug.c util.c velocity.c weapon.c

OBJ = $(SRC:.c=.o)

all: do libsc2code.a

libsc2code.a: $(OBJ)
	ar -ru libsc2code.a $(OBJ)
	ranlib libsc2code.a

do:
	$(MAKE) -C ships
	$(MAKE) -C planets
	$(MAKE) -C libs
	$(MAKE) -C comm

%.o : %.c
	$(CC) $(CFLAGS) $<

clean:
	$(MAKE) -C ships clean
	$(MAKE) -C planets clean
	$(MAKE) -C libs clean
	$(MAKE) -C comm clean
	delete #?.o
	delete libsc2code.a

