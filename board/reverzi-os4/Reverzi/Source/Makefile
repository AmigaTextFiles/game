PREFIX=/PROGDIR/
PREFIXDATA=$(PREFIX)data/
PREFIXBINARY=$(PREFIX)/bin
CFLAGS=-mcrt=newlib `sdl-config --cflags` -DUNIX -O3 -DNDEBUG -DPREFIX=$(PREFIX) -DPREFIXDATA=$(PREFIXDATA)
LIBS=-mcrt=newlib -lSDL_gfx -lSDL_net -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL_ttf -lfreetype -lz -lsdlmain -lsdl -lauto -lpthread -lm -lunix
CC=g++ -mcrt=newlib


all: reverzi

reverzi: reverzi.o player.o position.o SFont.o SDL_additives.o
	$(CC) -o reverzi $^ $(LIBS)

.cpp.o:
	$(CC) $(CFLAGS) -c $^

clean:
	rm reverzi *.o || true

install: reverzi
	install -D -s reverzi $(PREFIXBINARY)/reverzi
	install -d img $(PREFIXDATA)/img
	install -m 0644 img/*.png $(PREFIXDATA)/img

uninstall:
	rm $(PREFIXBINARY)/reverzi
	rm -r $(PREFIXDATA)

build: clean all

