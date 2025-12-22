# tric-tac-toe makefile for use with gcc

CC = gcc
CFLAGS = `sdl-config --cflags`
LIBS = `sdl-config --libs` -lm -lSDL_image -lSDL_ttf

TARGET = tric-tac-toe
CONF_FILE = intro-number.txt
SOURCES = src/main.c \
          src/computer.c \
	  src/draw.c
HEADERS = src/main.h \
          src/computer.h \
	  src/draw.h \
	  src/types.h
OBJS = src/main.o \
       src/computer.o \
       src/draw.o

$(TARGET):  $(OBJS)
	$(CC) -o $(TARGET) $(OBJS) $(LIBS)

$(OBJS):  $(SOURCES) $(HEADERS)

src/%.o:  %.c
	$(CC) -c -o $@ $(CFLAGS) $<

clean:
	rm -f $(TARGET) $(CONF_FILE) $(OBJS) config.txt
