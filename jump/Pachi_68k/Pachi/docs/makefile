CC			=	gcc -m68020 -m68881 -noixemul
CHMOD		=	chmod
RM			=	rm -f
STRIP		=	strip


CFLAGS	=	-g -O2 -Wall `sdl-config2 --cflags` -D__MORPHOS__
LDFLAGS	=	-lSDL_mixer_1 `sdl-config2 --libs` -lm


OBJ		= faes.o
BIN		= Pachi


all: $(BIN)

$(BIN): $(OBJ)
		$(CC) $(OBJ) -o $(BIN).db $(LDFLAGS)
		$(STRIP) --strip-unneeded --remove-section=.comment $(BIN).db -o $(BIN)
		$(CHMOD) u+x $(BIN)

%.o:	%.cpp
		$(CC) $(CFLAGS) -c $<

clean:
		$(RM) $(OBJ) $(BIN).db $(BIN)
