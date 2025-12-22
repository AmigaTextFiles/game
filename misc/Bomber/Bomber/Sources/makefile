#
# Bomber
#

# CSDB = -s0n -bs
CSDB =
# LSDB = -g
LSDB =
# DEBUG = -d DEBUG
DEBUG =

CFLAGS = -ff -hi Bomber.hdr $(DEBUG) $(CSDB)
LIBS = -lmf -lc
OBJS = main.o display.o sound.o game.o highscore.o

bomber: bomber.hdr $(OBJS)
	ln $(OBJS) $(LIBS) -o Bomber $(LSDB)

bomber.hdr: bomber.h
	cc -a -ff -ho bomber.hdr bomber.h
