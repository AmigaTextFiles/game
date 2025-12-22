CC  = g++
CFLAGS   = -newlib -O3 -c
LDFLAGS  =
LDLIBS	= -newlib -lsdl -lauto

OBJS    = game.o board.o highscores.o parameters.o

D-Fragmenta: $(OBJS)
		$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

game.o: game.cpp
		$(CC) $(CFLAGS) game.cpp

board.o: board.cpp
		$(CC) $(CFLAGS) board.cpp

highscores.o: highscores.cpp
		$(CC) $(CFLAGS) highscores.cpp

parameters.o: parameters.cpp
		$(CC) $(CFLAGS) parameters.cpp

clean:
	rm *.o
