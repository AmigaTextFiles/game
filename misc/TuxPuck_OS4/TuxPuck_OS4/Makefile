# Makefile for TuxPuck , Copyright Jacob Kroon 2001-2002
NAME		= tuxpuck
VERSION		= 0.8.2
CC		= gcc
CFLAGS		+= -newlib -Isdk:local/newlib/include/SDL -D_VERSION=\"$(VERSION)\" -g -Wall
CSOURCES	= tuxpuck.c video.c audio.c menu.c sprite.c font.c timer.c \
		  board.c entity.c glass.c scoreboard.c player.c zoom.c png.c \
		  jpg.c intro.c tux.c arcana.c 
INCLUDES	= tuxpuck.h video.h audio.h font.h
	   	  

#############################################################

OBJS=$(CSOURCES:.c=.o)
ifdef COMSPEC
  OBJS += w32icon.o
endif

%.o	: %.c
	$(CC) $(CFLAGS)  -c -o $@ $<

$(NAME) : $(OBJS)
	$(MAKE) -C data
	$(CC) $(CFLAGS) $(OBJS) -newlib /data/libdata.a -lm -lpng \
	-newlib -lSDL_image -lpng -ljpeg -lSDL_mixer -lvorbisfile -lvorbis -logg -lfreetype -lSDL -lz -lm -lauto -lpthread -o $(NAME)

clean :
	cd utils; $(MAKE) clean;
	cd data; $(MAKE) clean;
	rm -f *~ $(OBJS) $(NAME)

indent :
	cd utils; $(MAKE) indent;
	indent -br -brs -sob -ce -c50 -npsl -npcs $(CSOURCES) $(INCLUDES)
	rm -f *~

dist :
	$(MAKE) clean
	mkdir $(NAME)-$(VERSION)
	cp $(CSOURCES) $(INCLUDES) readme.txt todo.txt bugs.txt thanks.txt \
	  COPYING Makefile $(NAME)-$(VERSION)
	cp -R man utils data $(NAME)-$(VERSION)
	tar -cf $(NAME)-$(VERSION).tar $(NAME)-$(VERSION)
	tar -f $(NAME)-$(VERSION).tar --delete \
	  `tar -tf $(NAME)-*.tar | grep -w -e ".svn/"`
	gzip -9 $(NAME)-$(VERSION).tar
	rm -Rf $(NAME)-$(VERSION)

install : $(NAME)
	install -d $(DESTDIR)/usr/bin
	install -d $(DESTDIR)/usr/man/man6
	install -m755 $(NAME) $(DESTDIR)/usr/bin
	install -m644 man/$(NAME).6.gz $(DESTDIR)/usr/man/man6
