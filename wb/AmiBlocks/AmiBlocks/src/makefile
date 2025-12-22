CC  = vc
CFLAGS   = -+ -sc -DVBCC -DMUSIC -c
LDFLAGS  =
LDLIBS  = -lmedplayer -loctaplayer -loctamix

OBJS    = amiblocks.o med.o

AmiBlocks: $(OBJS)
		$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

amiblocks.o: amiblocks.c
		$(CC) $(CFLAGS) amiblocks.c

med.o: med.c
		$(CC) $(CFLAGS) med.c

clean:
		delete #?.o


