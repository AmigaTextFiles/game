CC = gcc -mcrt=newlib
DEFINES = -DGFXMODULE_SDL=1 -DWORDS_BIGENDIAN=1
CFLAGS = -O2 -ggdb $(DEFINES) -Wall -I../libs -I../../ -I../ -I. -c
#LDFLAGS = -newlib -o
#LDLIBS = -lSDL_Mixer -lvorbisfile -lvorbis -logg -lSDL -lauto -lpthread

SRC = \
	arilou/arilouc.c blackur/blackurc.c chmmr/chmmrc.c comandr/comandr.c \
	druuge/druugec.c ilwrath/ilwrathc.c melnorm/melnorm.c mycon/myconc.c \
	orz/orzc.c pkunk/pkunkc.c rebel/rebel.c shofixt/shofixt.c slyhome/slyhome.c \
	slyland/slyland.c spahome/spahome.c spathi/spathic.c starbas/starbas.c \
	supox/supoxc.c syreen/syreenc.c talkpet/talkpet.c thradd/thraddc.c \
	umgah/umgahc.c urquan/urquanc.c utwig/utwigc.c vux/vuxc.c yehat/yehatc.c \
	zoqfot/zoqfotc.c

OBJ = $(SRC:.c=.o)

libcomm.a: $(OBJ)
	ar -ru $@ $(OBJ)
	ranlib $@

%.o : %.c
	$(CC) $(CFLAGS) $< -o$@

clean:
	delete #?/#?.o
	delete libcomm.a

