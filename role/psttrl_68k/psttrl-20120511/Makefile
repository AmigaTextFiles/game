# makefile for psttrl

CC = gcc -m68020 -m68881
CC_WARNINGS = -Wall -Wdeclaration-after-statement -Wshadow \
  -Wbad-function-cast -Wcast-qual -Wcast-align -Wwrite-strings \
  -Wsign-compare -Wstrict-prototypes -Wmissing-prototypes
CFLAGS = -g -O2
CPPFLAGS =
LDFLAGS =
LIBS = -lpdcurses_ns $(shell sdl-config2 --libs) -lm

USE_GCC_MMD = yes

program = psttrl
objects = action.o array.o build.o cave.o \
  combat.o \
  corridor.o creature-detail.o creature-effect.o creature.o \
  digital-fov.o dungeon-add-remove.o dungeon.o \
  grid-detail.o int-loader.o item.o jkiss32.o judge.o \
  list-int.o loop-action.o loop-draw.o loop-input.o loop.o \
  main.o \
  monster.o name.o player-cache.o post-move.o r-and-c.o \
  save.o turn-order.o util-corridor.o util.o weapon-detail.o \
  weapon-effect.o world.o
headers = action.h array.h build.h cave.h \
  color-pair.h \
  combat.h \
  config.h \
  corridor.h creature-detail.h creature-effect.h creature.h \
  digital-fov.h dungeon-add-remove.h dungeon.h \
  grid-detail.h int-loader.h item.h jkiss32.h judge.h \
  layer-detail.h \
  list-int.h loop-action.h loop-draw.h loop-input.h loop.h \
  monster.h name.h player-cache.h post-move.h r-and-c.h \
  save.h turn-order.h util-corridor.h util.h weapon-detail.h \
  weapon-effect.h world.h

all: $(program)

$(program): $(objects)
	$(CC) $(CFLAGS) $(CC_WARNINGS) $(LDFLAGS) -o $@ $^ $(LIBS)

ifeq ($(USE_GCC_MMD),yes)
-include $(subst .o,.d,$(objects))
gcc_mmd = -MMD
else
$(objects): %.o: $(headers)
gcc_mmd =
endif

$(objects): %.o: %.c
	$(CC) $(CFLAGS) $(CC_WARNINGS) $(CPPFLAGS) $(gcc_mmd) -c -o $@ $<

.PHONY: all mostlyclean clean

mostlyclean:
	-rm -f *.o *.d

clean: mostlyclean
	-rm -f $(program)
