
TARGET=atakks

all: $(TARGET)

CC	= gcc
CFLAGS	= -O2 -ISDL: -D_REENTRANT -Wall -ansi -DUS
LDFLAGS = -LSDL: -lpthread 

$(TARGET): main.o
	$(CC) -o $(TARGET) main.o -lSDL $(LDFLAGS) $(CFLAGS)


main.o: main.c defs.h

clean:
	wipe o.* ~C~V 
