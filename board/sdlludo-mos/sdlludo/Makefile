CC=g++
CFLAGS=`sdl-config --cflags --libs`
LIBS= -lSDL_image
OBJECTS=main.o img.o cplayer.o cbrick.o
OUTPUT=ludo

learntodrive: $(OBJECTS)
	$(CC) $(OBJECTS) -o $(OUTPUT) $(CFLAGS) $(LIBS)

main.o: main.cpp
	$(CC) -c main.cpp

img.o: img.cpp img.h
	$(CC) -c img.cpp

cplayer.o: cplayer.cpp cplayer.h
	$(CC) -c cplayer.cpp

cbrick.o: cbrick.cpp cbrick.h
	$(CC) -c cbrick.cpp

clean:
	rm -f $(OBJECTS) $(OUTPUT)
