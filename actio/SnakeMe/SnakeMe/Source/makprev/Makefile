.SUFFIXES: .cpp.o

CC=gcc 
LINK=$(CC)
LFLAGS= -L../SGU/lib -lSGU -lSDL -lX11
CFLAGS= -O2 -I/usr/include/SDL -I../SGU/include 

OBJ_FILES=makprev.o

makprev: $(OBJ_FILES)
	 $(LINK) $(LFLAGS) -o ../snakeme/$@ $(OBJ_FILES)

clean:
	rm *.o

.cpp.o:
	$(CC) $(CFLAGS) -c $< 
