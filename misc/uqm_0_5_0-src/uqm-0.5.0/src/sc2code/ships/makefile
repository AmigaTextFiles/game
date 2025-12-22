CC = gcc -mcrt=newlib
DEFINES = -DGFXMODULE_SDL=1 -DWORDS_BIGENDIAN=1
CFLAGS = -O2 -ggdb $(DEFINES) -Wall -I../libs -I../../ -I../ -I. -c
#LDFLAGS = -newlib -o
#LDLIBS = -lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL -lauto -lpthread

SRC = \
	androsyn/androsyn.c arilou/arilou.c blackurq/blackurq.c \
	chenjesu/chenjesu.c chmmr/chmmr.c druuge/druuge.c human/human.c \
	ilwrath/ilwrath.c lastbat/lastbat.c melnorme/melnorme.c mmrnmhrm/mmrnmhrm.c \
	mycon/mycon.c orz/orz.c pkunk/pkunk.c probe/probe.c shofixti/shofixti.c \
	sis_ship/sis_ship.c slylandr/slylandr.c spathi/spathi.c supox/supox.c \
	syreen/syreen.c thradd/thradd.c umgah/umgah.c urquan/urquan.c utwig/utwig.c \
	vux/vux.c yehat/yehat.c zoqfot/zoqfot.c

OBJ = $(SRC:.c=.o)

libships.a: $(OBJ)
	ar -ru $@ $(OBJ)
	ranlib $@

%.o : %.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	delete #?/#?.o
	delete libships.a


