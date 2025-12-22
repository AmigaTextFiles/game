CC =		cc
LN =            ln
CFLAGS =	-mcd -wl -qq
LDFLAGS =	
LIBS =          -lm -lc

NEWOBJS = combat.o commands.o config.o display.o enemy.o init.o input.o main.o misc.o movement.o research.o taskforce.o update.o utils.o

conq :		$(NEWOBJS)
		$(LN) -o conq $(LDFLAGS) $(NEWOBJS) $(LIBS)

combat.o:	combat.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) combat.c

commands.o:	commands.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) commands.c

display.o:	display.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) display.c

enemy.o:	enemy.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) enemy.c

init.o:		init.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) init.c

input.o:	input.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) input.c

main.o:		main.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) main.c

misc.o:		misc.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) misc.c

movement.o:	movement.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) movement.c

research.o:	research.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) research.c

taskforce.o:	taskforce.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) taskforce.c

update.o:	update.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) update.c

utils.o:	utils.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) utils.c

config.o:	config.c vars.h structs.h defs.h protos.h
		$(CC) -c $(CFLAGS) config.c

clean:
	rm *.o conq *.dbg *.sym