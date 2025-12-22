# ONLY CHANGE THESE THREE OPTIONS IF YOU KNOW WHAT YOU ARE DOING
BIN_PREFIX = /usr/local/bin/
# if you don't have privileges to install systemwide, comment out both 
# lines below and the game will then play from the current directory
DATA_PREFIX = /usr/local/share/games/twind/
HIGH_SCORE_PREFIX = /var/lib/games/twind/
# uncomment out the EXTENSION if you don't have the png libs on your system
#EXTENSION = ".bmp"
AUDIOFLAG = AUDIO
CC = gcc
ifdef EXTENSION
CFLAGS = -Wall -g -DDATA_PREFIX=\"$(DATA_PREFIX)\" \
	-DEXTENSION=\"$(EXTENSION)\" -D$(AUDIOFLAG) -DLINUX \
	-DHIGH_SCORE_PREFIX=\"$(HIGH_SCORE_PREFIX)\"
else
CFLAGS = -Wall -g -DDATA_PREFIX=\"$(DATA_PREFIX)\" -D$(AUDIOFLAG) -DLINUX \
	-DHIGH_SCORE_PREFIX=\"$(HIGH_SCORE_PREFIX)\"
endif
LIBS = -lm
SDL_CFLAGS = `sdl-config --cflags`
SDL_LIBS = `sdl-config --libs` -lSDL_image
MIXER_LIB = -lSDL_mixer

all: twind

install:
	mkdir -p $(DATA_PREFIX)graphics
	mkdir -p $(DATA_PREFIX)music
	mkdir -p $(DATA_PREFIX)sound
	mkdir -p $(HIGH_SCORE_PREFIX)
ifdef EXTENSION
	cp -r graphics/*.bmp $(DATA_PREFIX)graphics
else
	cp -r graphics/*.png $(DATA_PREFIX)graphics
endif
	cp -r music/*.ogg $(DATA_PREFIX)music
	cp -r sound/*.wav $(DATA_PREFIX)sound
	cp twind $(BIN_PREFIX)
	chown root:games $(BIN_PREFIX)twind
	chmod g+s $(BIN_PREFIX)twind
	touch $(HIGH_SCORE_PREFIX)twind.hscr
	chown root:games $(HIGH_SCORE_PREFIX)twind.hscr
	chmod 664 $(HIGH_SCORE_PREFIX)twind.hscr
    
uninstall:
	rm -rf $(DATA_PREFIX)
	rm -f $(BIN_PREFIX)twind

noaudio:
	make twind MIXER_LIB= AUDIOFLAG=NOAUDIO
 	
twind: twind.o
	$(CC) twind.o $(LIBS) $(SDL_LIBS) $(MIXER_LIB) -o twind

twind.o: twind.c
	$(CC) $(CFLAGS) $(SDL_CFLAGS) -c twind.c

clean:
	rm -f twind *.o
