CC			=	gcc
CHMOD		=	chmod
RM			=	rm -f
STRIP		=	strip


CFLAGS	=	-g -O2 -Wall -mcrt=newlib `sdl-config --cflags` -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL 
LDFLAGS	=	-mcrt=newlib `sdl-config --libs` -lSDL_image -lpng -ljpeg -lz -lSDL_mixer -lvorbisfile -lvorbis -logg -lSDL_ttf -lfreetype -lsdlmain -lsdl -lauto -lpthread -lm -lunix


SRC		=	$(wildcard *.c)
OBJ		=	$(SRC:.c=.o)
BIN		=	PrimatePlunge


all: $(BIN)

$(BIN):	$(OBJ)
		$(CC) $(CFLAGS) $(OBJ) -o $(BIN).db $(LDFLAGS)
		$(STRIP) --strip-unneeded --remove-section=.comment $(BIN).db -o $(BIN)
		$(CHMOD) u+x $(BIN)

%.o:	%.c
		$(CC) $(CFLAGS) -c $< -o $@

clean:
		$(RM) $(OBJ) $(BIN).db $(BIN)
