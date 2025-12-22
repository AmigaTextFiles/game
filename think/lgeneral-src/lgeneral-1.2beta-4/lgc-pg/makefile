NAME = lgc-pg

CFLAGS = -g -newlib -O2 -W -Wall -Isdk:local/newlib/include/SDL -DVERSION="1.2beta-4" -DSRC_DIR="/progdir" -c

SRC = main.c units.c shp.c nations.c terrain.c maps.c scenarios.c \
	list.c misc.c parser.c

OBJ = $(SRC:.c=.o)

$(NAME) : $(OBJ)
	gcc -newlib -o $@ $(OBJ) -lSDL -lpthread -lauto -lunix

%.o : %.c
	gcc $(CFLAGS) $<

clean:
	delete $(OBJ)
	delete $(NAME)

 

