CC = gcc -mcrt=newlib
CFLAGS = -O2 -ggdb -Wall -Isc2code -Isc2code/libs -I. -Iregex -ISDK:Local/common/include/SDL -c
LDFLAGS = -Lsc2code -Lsc2code/libs -Lsc2code/ships -Lsc2code/planets -Lsc2code/comm -o
LDLIBS = -lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL_Image -lpng -ljpeg -lz -lSDL -lauto -lpthread -lunix

SRC = options.c port.c starcon2.c 
OBJ = $(SRC:%.c=%.o)

R_SRC = regex/regex.c
R_OBJ =$(R_SRC:%.c=%.o)

G_SRC = getopt/getopt.c getopt/getopt1.c
G_OBJ = $(G_SRC:%.c=%.o)

# TODO: rethink linkin again. Now there is stupid 2-pass for sc2code & planets :(
sc2: $(OBJ) $(R_OBJ) $(G_OBJ) do sc2code/libsc2code.a
	$(CC) $(LDFLAGS) $@ $(OBJ) -lsc2code -lplanets -lsc2code -lplanets -lships -lcomm -llibs $(R_OBJ) $(G_OBJ) $(LDLIBS)

do:
	$(MAKE) -C sc2code

%.o : %.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	$(MAKE) -C sc2code clean
	delete #?.o
	delete regex/#?.o
	delete getopt/#?.o
	delete sc2
