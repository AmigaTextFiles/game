# makefile for kusemono

CC = gcc -m68020 -m68881 #-noixemul
CC_WARNINGS = -Wall -Wdeclaration-after-statement -Wshadow \
  -Wbad-function-cast -Wcast-qual -Wcast-align -Wwrite-strings \
  -Wsign-compare -Wstrict-prototypes -Wmissing-prototypes
CFLAGS = -g -O2
CPPFLAGS =
LDFLAGS =
LIBS = -lpdcurses_ns $(shell sdl-config2 --libs) -lm

program = kusemono
objects = action.o array.o build.o \
  creature-detail.o creature.o \
  digital-fov.o dungeon.o \
  enchantment-detail.o grid-detail.o int-loader.o \
  list-int.o loop.o magic-device.o \
  main.o \
  monster.o player-cache.o r-and-c.o \
  save.o turn-order.o util.o world.o
headers = action.h array.h build.h \
  config.h \
  creature-detail.h creature.h \
  digital-fov.h dungeon.h \
  enchantment-detail.h grid-detail.h int-loader.h \
  list-int.h loop.h magic-device.h \
  monster.h player-cache.h r-and-c.h \
  save.h turn-order.h util.h world.h

all: $(program)

$(program): $(objects)
	$(CC) $(CFLAGS) $(CC_WARNINGS) $(LDFLAGS) -o $@ $^ $(LIBS)

$(objects): %.o: %.c $(headers)
	$(CC) $(CFLAGS) $(CC_WARNINGS) $(CPPFLAGS) -c -o $@ $<

.PHONY: all mostlyclean clean

mostlyclean:
	-rm -f *.o

clean: mostlyclean
	-rm -f $(program)
