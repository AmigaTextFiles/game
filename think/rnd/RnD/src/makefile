SRC = cartoons.c conf_gfx.c conf_mus.c conf_snd.c conf_hlp.c config.c editor.c \
	events.c files.c game.c init.c main.c netserv.c network.c screens.c tape.c \
	tools.c

OBJ = $(SRC:.c=.o)

CFLAGS = -newlib -Wall -O2 -Isdk:Local/newlib/include/SDL -DTARGET_SDL -c
LIBS = -newlib -Llibgame -lgame -lSDL_Image -lpng -ljpeg -lz \
	-lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL -lpthread -lauto -lunix #-lSDL_Net

all: lib exe

exe: $(OBJ) libgame/libgame.a
	gcc -o RnD $(OBJ) $(LIBS)

lib:
	make -C libgame

%.o:%.c
	gcc $(CFLAGS) $<

clean:
	make -C libgame clean
	delete #?.o
	delete RnD


