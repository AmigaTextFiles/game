# Noiz2sa makefile for AmigaOs 4
# Varthall/Up Rough 16.09.05

NAME   = noiz2sa
O      = o
RM     = delete
CC     = gcc
CXX    = g++

PROG        = $(NAME)

DEFAULT_CFLAGS = -I/sdk/local/clib2/include/SDL -I/sdk/local/common/include/SDL
MORE_CFLAGS = -O3
LDFLAGS = -lsdl_image -lSDL_mixer -lvorbisfile -lvorbis -logg -lsdlmain -lsdl -lauto -lpthread -L. -L./bulletml -lm -lbulletml -lstdc++

CFLAGS  = $(DEFAULT_CFLAGS) $(MORE_CFLAGS) 
CPPFLAGS  = $(DEFAULT_CFLAGS) $(MORE_CFLAGS) -I./bulletml/

OBJS =	$(NAME).$(O) ship.$(O) shot.$(O) frag.$(O) bonus.$(O) \
	foe.$(O) foecommand.$(O) barragemanager.$(O) attractmanager.$(O) \
	background.$(O) letterrender.$(O) \
	screen.$(O) clrtbl.$(O) vector.$(O) degutil.$(O) rand.$(O) soundmanager.$(O)

all: $(OBJS)
	$(MAKE) -C bulletml
	$(CC) $(CFLAGS) -o $(PROG) $(OBJS) $(LDFLAGS)
	strip $(NAME)

clean:
	$(RM) $(PROG) #?.$(O)
	$(MAKE) -C bulletml clean