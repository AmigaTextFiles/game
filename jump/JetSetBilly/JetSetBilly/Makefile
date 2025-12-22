#
# Makefile for Amiga SAS/C 6.2
#

#
CC = sc
#CFLAGS =
#DBG=F
#
# rplib is only for LZW
#
LIBS = LIB:sc.lib LIB:amiga.lib rp.lib
#
SRC = main.c animtools.c compress.c files.c muzak.c
#
OBJ = main.o animtools.o compress.o files.o muzak.o \
MODPlayer/modplayer.o MODPlayer/loadmod.o
#
LIBOBJ = lib/amiga.o lib/ilbmraw.o lib/rnd.o
#
#.c.o:
#	$(CC) $(CFLAGS) GST=include.gst $*.c 

all: game bobconv

game:	include.gst $(OBJ) $(LIBOBJ)
	$(CC) LINK SCODE $(LIBOBJ) LIBS=$(LIBS) $(OBJ) TO game

mapconv: mapconv.o files.o compress.o $(LIBOBJ)
	$(CC) LINK $(LIBOBJ) LIBS=$(LIBS) mapconv.o files.o compress.o TO mapconv

bobconv: bobconv.o files.o compress.o $(LIBOBJ)
	$(CC) LINK $(LIBOBJ) LIBS=$(LIBS) bobconv.o files.o compress.o TO bobconv

maprefresh: maprefresh.o files.o compress.o
	$(CC) LINK $(LIBOBJ) LIBS=$(LIBS) maprefresh.o files.o compress.o TO maprefresh

unbobconv: unbobconv.o files.o compress.o $(LIBOBJ)
	$(CC) LINK $(LIBOBJ) LIBS=$(LIBS) unbobconv.o files.o compress.o TO unbobconv

include.gst: include.c
#	gst unload include.gst	<-- DOES NOT WORK! avail flush does.
	avail flush
	$(CC) MGST=include.gst include.c

animtools.o: animtools.c animtools.h
bobconv.o: bobconv.c
unbobconv.o: unbobconv.c
compress.o: compress.c
files.o: files.c
main.o: main.c types.h animtools.h game.h
mapconv.o: mapconv.c game.h
muzak.o: muzak.c
