#Put the C compiler (eg gcc) you used after =
CC=gcc

#put the options (eg -Wall) after =
# CFLAGS=-Wall -ansi -pedantic -g
CFLAGS=-noixemul -Wall -ansi -pedantic

#put .c program files (eg main.c, trunk.c) after=
SRC=dem_parse.c dem_send.c ini.c init.c main.c qwz.c tools.c

#put the equivalent files ending in .o (eg main.o, trunk.o) after =
OBJS=dem_parse.o dem_send.o ini.o init.o main.o qwz.o tools.o

#put the name of your program (eg solitaire) after =
PROGRAM=qwdtools

#this is not necessary because make includes this as an implicit rule
%.o: %.c
	$(CC) -c $(CFLAGS) $<

#NB You have to press the tabulator before $(CC), not the spacebar!
$(PROGRAM): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(PROGRAM) -lm

#NB You have to press the tabulator before rm, not the spacebar!
clean:
	rm -f $(OBJS) $(PROGRAM)
