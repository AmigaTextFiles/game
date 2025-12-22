CC				=	gcc -m68020 -m68881 -noixemul
CXX			=	g++ -m68020 -m68881 -noixemul
CHMOD			=	chmod
RM				=	rm -f
STRIP			=	strip


CFLAGS		=	-g -O2 -Wall `sdl-config2 --cflags` -DNOTPSP -D__MORPHOS__
LDFLAGS		=	-lSDL_image -ljpeg -lpng -lz -lSDL_mixer_mad -lmad `sdl-config2 --libs` -lm

SRC			=	bootmain.c \
					debug.c \
					input.c \
					sound.c \
					grp_screen.c \
					grp_texture.c \
					grp_sprite.c \
					gamemain.c \
					puz_base.c \
					puz_disp.c \
					puz_trial.c
OBJ			=	$(SRC:.c=.o)
BIN			=	Tail-Tale


all: $(BIN)
	
$(BIN):	$(OBJ)
		$(CC) $(OBJ) -o $(BIN).db $(LDFLAGS)
		$(STRIP) --strip-unneeded --remove-section=.comment $(BIN).db -o $(BIN)
		$(CHMOD) u+x $(BIN)

%.o:	%.c
		$(CC) $(CFLAGS) -c $< -o $@

clean:
		$(RM) $(OBJ) $(BIN).db $(BIN)
