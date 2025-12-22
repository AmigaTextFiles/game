CC	      = gcc -m68020 -m68881 -noixemul
CFLAGS      = -O2 
#CFLAGS      = -O2  -g -Wall 
LDFLAGS      =  

LD	      = gcc

SDL_LDFLAGS 	= $(shell sdl-config2 --libs)
SDL_CFLAGS	= $(shell sdl-config2 --cflags)

MAKEFILE      = Makefile

OBJS	      = baloon.o CEGex.o CSprite.o CList.o CInput.o CTime.o CEG2.o CBmps.o 

PROGRAM       = baloon

%.o:		%.c
		$(CC) $(SDL_CFLAGS) $(CFLAGS) -c $<
all:		$(PROGRAM)

$(PROGRAM):     $(OBJS) $(LIBS)
		@echo "Linking $(PROGRAM) ..."
		$(LD) -o $(PROGRAM) $(OBJS)  $(LDFLAGS) $(SDL_LDFLAGS)


