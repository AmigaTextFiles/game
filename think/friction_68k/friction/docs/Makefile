CC=gcc -m68020 -m68881
CXX=g++ -m68020 -m68881

CFLAGS =	`sdl-config2 --cflags`
CPPFLAGS =	$(CFLAGS)
LIBS =		`sdl-config2 --libs`

PROGS =		friction

all:		$(PROGS)

FRICTION =	friction.o Input.o GameLogic.o Graphics.o Level.o Ball.o \
		Goal.o MovingTrap.o FileManager.o ForceField.o

friction:	$(FRICTION)
		$(CXX) -o $@ $^ $(LIBS)

clean:
		rm -f *.o *~ $(PROGS)
