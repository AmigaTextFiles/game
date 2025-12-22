# Makefile for Infocom Debugging Tool 
# (works with Aztec 5.2a)

CFLAGS = -DAMIGA -ms -so -wlc

OBJS = 	alphabet.o check.o decode.o extern.o header.o macros.o main.o \
	object.o recog.o stuffing.o tree.o vars.o vocab.o

all: DebugTool

DebugTool:	$(OBJS)
	ln -o DebugTool $(OBJS) -lc


$(OBJS):	frobnitz.h Makefile

# (c) 1992 by Paul David Doherty
