CC	      = gcc -m68020 -m68881
CFLAGS      = -O2 
#CFLAGS      = -O2  -g -Wall 
LDFLAGS      = -lm

LD	      = $(CC)

SDL_LDFLAGS 	= $(shell sdl-config2 --libs)
SDL_CFLAGS	= $(shell sdl-config2 --cflags)

MAKEFILE      = Makefile

OBJS	      = depth.o CEGex.o CSprite.o CList.o CInput.o CTime.o CEG2.o CBmps.o

PROGRAM       = depth

%.o:		%.c
		$(CC) $(SDL_CFLAGS) $(CFLAGS) -c $<
all:		$(PROGRAM)

$(PROGRAM):     $(OBJS) $(LIBS)
		@echo "Linking $(PROGRAM) ..."
		$(LD) -o $(PROGRAM) $(OBJS)  $(SDL_LDFLAGS) $(LDFLAGS)


