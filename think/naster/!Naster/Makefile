
TARGET=naster

all: $(TARGET)

CC	= gcc
CFLAGS	= -O2 -ISDL: -D_REENTRANT
LDFLAGS = -LSDL: -lSDL_mixer -lSDL_image -lz -ljpeg -lpng -ltiff

$(TARGET): naster.o SFont.o
	$(CC) -o $(TARGET) naster.o SFont.o -lSDL $(LDFLAGS)


naster.o: naster.c

SFont.o: SFont.c Sfont.h
clean:
	wipe o.* ~C~V 
