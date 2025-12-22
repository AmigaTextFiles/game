SRC = physfs_byteorder.c physfs.c \
	archivers/mix.c archivers/qpak.c archivers/zip.c archivers/mvl.c \
	archivers/hog.c archivers/wad.c archivers/grp.c archivers/dir.c \
  	platform/amiga_posix.c platform/amiga_unix.c

OBJ = $(SRC:.c=.o)

CFLAGS = -O3 -newlib -wall -g -Iarchivers -I. -D__PHYSFS_NO_SYMLINKS__ -c

LIB = libphysfs.a

all: $(LIB)

$(LIB) : $(OBJ)
	ar -ru $(LIB) $(OBJ)
	ranlib $(LIB)

%.o : %.c
	gcc $(CFLAGS) $< -o $@

clean:
	delete $(LIB)
	delete #?.o
	delete #?/#?.o
