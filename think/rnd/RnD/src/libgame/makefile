SRC = \
	gadgets.c hash.c image.c joystick.c misc.c msdos.c pcx.c random.c sdl.c \
  	setup.c sound.c system.c text.c toons.c x11.c

OBJ = $(SRC:.c=.o)

CFLAGS = -newlib -Wall -O2 -Isdk:Local/newlib/include/SDL -DTARGET_SDL -c

libgame.a: $(OBJ)
	ar -ru $@ $(OBJ)
	ranlib $@

%.o:%.c
	gcc $(CFLAGS) $<

clean:
	delete #?.o
	delete libgame.a
