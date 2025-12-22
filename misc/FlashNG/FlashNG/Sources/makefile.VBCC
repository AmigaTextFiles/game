#
# FlashNG makefile by Giles Burdett
# Configured for VBCC v0.7
#

CC=vc
CFLAGS=+m68k
LFLAGS=-lauto -lamiga -llucyplay -lgtlayout
EXE=FlashNG

OBJS=flash.o timer.o game.o load.o gui.o icon.o 

all:   $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LFLAGS) -o $(EXE)

flash.o:  flash.c timer.h game.h load.h gui.h icon.h version.h
	$(CC) $(CFLAGS) -c flash.c

timer.o:  timer.c timer.h
	$(CC) $(CFLAGS) -c timer.c

game.o:   game.c game.h
	$(CC) $(CFLAGS) -c game.c

load.o:   load.c load.h
	$(CC) $(CFLAGS) -c load.c

gui.o:    gui.c gui.h version.h
	$(CC) $(CFLAGS) -c gui.c

icon.o:   icon.c icon.h
	$(CC) $(CFLAGS) -c icon.c

