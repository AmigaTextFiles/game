#
# Change TARGET to "gp2x" or "pc"
#
TARGET="pc"

#
# Default variables
#
CC?=gcc

CC_GP2X?=gp2x-gcc
CC_PC?=gcc
OBJECTS = sdlame.o output.o input.o game.o player.o computer.o
LIBS_GP2X = -lSDL -lSDL_gfx --start-group -lSDL_ttf -lfreetype -lSDL --end-group -lSDL_image -ljpeg -lpng -lz --start-group -lSDL_mixer -lvorbisidec -lmikmod -lsmpeg -lSDL --end-group -lpthread -lm -ldl
LIBS_PC = -lSDL_mixer -lSDL_image -lSDL_ttf -lSDL -lpthread -lm -ldl -lpng -lz -lfreetype -lvorbis
PARAMETER_GP2X = -static -DGP2X_MODE -I/usr/local/gp2xdev/include/SDL -L/usr/local/gp2xdev/lib
PARAMETER_PC = -I/usr/include/SDL -L/usr/lib
CFLAGS?=-Wall -O2
NAME_GP2X=sdlame.gpe
NAME_PC=sdlame.pc

ifdef gp2x
TARGET = gp2x
CC = $(CC_GP2X)
PARAMETER = $(PARAMETER_GP2X)
NAME = $(NAME_GP2X)
LIBS  =$(LIBS_GP2X)
else
TARGET = pc
CC = $(CC_PC)
PARAMETER = $(PARAMETER_PC)
NAME = $(NAME_PC)
LIBS = $(LIBS_PC)
endif

%.o: %.c
	$(CC) -c $(CFLAGS) $(PARAMETER) $<

$(TARGET): $(OBJECTS)
	$(CC) -o $(NAME) $(OBJECTS) $(PARAMETER) $(LIBS)
	-mv $(NAME) ..

clean:
	-rm *.o
   
