CC=gcc
CFLAGS+=-O2 -Wall -W -g
#CFLAGS+=-O2 -Wall -W -g -fprofile-arcs -ftest-coverage -pg
CFLAGS+=`sdl-config --cflags`
LFLAGS=`sdl-config --libs` -lSDL_image -L/usr/X11R6/lib -lX11
SRCS= \
	SFont.c \
	board.c \
	bonus.c \
	game.c \
	graphics.c \
	main.c \
	menu.c \
	myutils.c \
	score.c
OBJS=$(SRCS:.c=.o)

all: gemz

gemz:	$(OBJS)
	gcc $(CFLAGS) -o $@ $(LFLAGS) $(OBJS)

clean:
	rm -f $(OBJS)
	rm -f *.bb *.gcov *.bbg *.da
	rm -f *~ ./core
	rm gemz
