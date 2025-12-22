# ONLY CHANGE THESE THREE OPTIONS IF YOU KNOW WHAT YOU ARE DOING
BIN_PREFIX = /PROGDIR/
# if you don't have privileges to install systemwide, comment out both 
# lines below and the game will then play from the current directory
DATA_PREFIX = /PROGDIR/
HIGH_SCORE_PREFIX = /PROGDIR/
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
SDL_CFLAGS = -newlib -Isdk:local/newlib/include/SDL
SDL_LIBS = -newlib -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL_image -lpng -ljpeg -lSDL -lz -lunix -lauto -lpthread
MIXER_LIB = 

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
