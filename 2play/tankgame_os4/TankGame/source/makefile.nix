CC = g++
CFLAGS = -O2 -Wall
LDFLAGS = `allegro-config --libs`
OBJ = Arena.o GameState.o logfile.o myMath.o Particles.o Player.o Scoreboard.o Shot.o Tank.o main.o
MAINBIN = ../tankgame

tankgame: $(OBJ)
	$(CC) -o $(MAINBIN) $(OBJ) $(LDFLAGS)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJ) 
	rm -f ../tankgame
