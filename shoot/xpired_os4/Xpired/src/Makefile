PREFIX=/usr/local
SHARE_PREFIX=$(PREFIX)/share/xpired
CFLAGS= -newlib -Isdk:local/newlib/include/SDL
;-DUNIX -DPREFIX=\"$(PREFIX)\" -DSHARE_PREFIX=\"$(SHARE_PREFIX)\"
LDFLAGS= -newlib -lSDL -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL_image -lpng -ljpeg -lSDL_gfx -lSDL -lauto -lpthread -lz -lunix
CC=gcc

BINARIES = xpired xpiredit

all: $(BINARIES)

xpired: xpired.o
	$(CC) -o xpired xpired.o $(LDFLAGS)

xpiredit: xpiredit.o xpired_unix.h
	$(CC) -o xpiredit xpiredit.o $(LDFLAGS)

.PHONY: clean

clean:
	rm $(BINARIES) xp*.o

install: xpired xpiredit xpired.lvl xpired.cfg bgimages.txt
	if [ ! -d $(PREFIX)/bin ]; then mkdir -p $(PREFIX)/bin; fi
	if [ ! -d $(SHARE_PREFIX) ]; then mkdir -p $(SHARE_PREFIX); fi
	cp xpired xpiredit $(PREFIX)/bin
	cp xpired.lvl xpired.cfg bgimages.txt $(SHARE_PREFIX)
	cp -r img/ $(SHARE_PREFIX)
	cp -r snd/ $(SHARE_PREFIX)
	if [ -f readme.txt ]; then cp readme.txt $(SHARE_PREFIX); fi
	if [ -f xpired.dmo ]; then cp xpired.dmo $(SHARE_PREFIX); fi
