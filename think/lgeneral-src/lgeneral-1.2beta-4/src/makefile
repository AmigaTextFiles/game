NAME = lgeneral

CFLAGS = -newlib -O2 -Wall -Isdk:local/newlib/include/SDL -DVERSION="1.2beta-4" -DDISABLE_INSTALL -DWITH_SOUND -DSRC_DIR="/progdir" -c

SRC = main.c \
	config.c date.c \
	file.c map.c nation.c \
	player.c scenario.c sdl.c misc.c unit.c \
	audio.c parser.c list.c unit_lib.c \
	terrain.c image.c slot.c gui.c \
	event.c windows.c action.c campaign.c \
	strat_map.c ai.c engine.c ai_group.c ai_tools.c

OBJ = $(SRC:.c=.o)

$(NAME): $(OBJ)
	gcc -newlib -o $@ $(OBJ) -lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL -lpthread -lauto -lunix

%.o : %.c
	gcc $(CFLAGS) $<

clean:
	delete $(OBJ)
	delete $(NAME)


