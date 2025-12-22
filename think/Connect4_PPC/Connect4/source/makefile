#
# Connect 4 makefile
#

CC=vc
CFLAGS=+m68k -+ 
LFLAGS=-lauto -lamiga -lmui
EXE=Connect4

C4_OBJS=main.o gameboardclass.o graphics_support.o computer_player.o

all:   $(C4_OBJS)
	$(CC) $(CFLAGS) $(C4_OBJS) $(LFLAGS) -o $(EXE)

main.o:    main.c window/#?.c graphics_support.h gameboardclass.h computer_player.h
	$(CC) $(CFLAGS) -c main.c

gameboardclass.o:    gameboardclass.c graphics_support.h gameboardclass.h computer_player.h
	$(CC) $(CFLAGS) -c gameboardclass.c

graphics_support.o:    graphics_support.c graphics_support.h
	$(CC) $(CFLAGS) -c graphics_support.c

computer_player.o:   computer_player.c computer_player.h gameboardclass.h
	$(CC) $(CFLAGS) -c computer_player.c
