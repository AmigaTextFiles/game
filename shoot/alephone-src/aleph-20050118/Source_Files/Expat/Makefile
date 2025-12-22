LIB = libexpat.a
SRC = hashtable.c xmlparse.c xmlrole.c xmltok.c

PROGRAM = gennmtab

OBJ = $(SRC:.c=.o)

DEFINES = -DSDL -DHAVE_LUA -DHAVE_SDL_IMAGE_H -DWORDS_BIGENDIAN -DHAVE_SDL_NET -DHAVE_UNISTD_H

CFLAGS = -O2 -newlib -g -Wall $(DEFINES) $(INCLUDES) -c

all: $(LIB) #$(PROGRAM)

$(LIB): $(OBJ)
	ar -ru $(LIB) $(OBJ)
	ranlib $(LIB)

#$(PROGRAM): gennmtab.o xmltok_impl.o xmltok_ns.o
#	 g++ -newlib -o $(PROGRAM) $(OBJ)

%.o:%.c
	gcc $(CFLAGS) $<

#nametab.h: gennmtab
#	 gennmtab >$@

xmltok.o: nametab.h

clean:
	delete #?.o
	delete $(LIB)
    #delete nametab.h
