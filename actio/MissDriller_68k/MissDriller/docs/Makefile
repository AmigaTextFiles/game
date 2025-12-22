CC	      = gcc -m68020 -m68881
CFLAGS      = -O2 -g
LDFLAGS      = -lSDL_mixer 

DEST	      = .

LD	      = $(CC)

SDL_LDFLAGS 	= $(shell sdl-config2 --libs)
SDL_CFLAGS	= $(shell sdl-config2 --cflags)

MAKEFILE      = Makefile

OBJS	      = drill.o CBmps.o Cffont.o CTime.o CWavs.o CInput.o

PRINT	      = pr

PROGRAM       = drill

SHELL	      = /bin/sh

%.o:		%.c
		$(CC) $(SDL_CFLAGS) $(CFLAGS) -c $<
all:		$(PROGRAM)

$(PROGRAM):     $(OBJS) $(LIBS)
		@echo "Linking $(PROGRAM) ..."
		$(LD) -o $(PROGRAM) $(OBJS)  $(LDFLAGS) $(SDL_LDFLAGS)

