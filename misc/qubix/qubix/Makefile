# NIXIECLOCK
# erco@3dsite.com 1.00

# AMIGAOS4 MAKEFILE

CCFLAGS = -mcpu=604e -O3
LIBS = -lfltk -lm -lauto -lnet -lunix

all: qubix

bin: all
	cp qubix bin.linux

qubix: qubix.cxx
	g++ $(CCFLAGS) -c qubix.cxx 
	g++ qubix.o $(LIBS) -o $@
	strip -R.comment qubix

clean:
	delete $(ALL) qubix *.o core
