CC = ppc-morphos-gcc
LD = /opt/gg/bin/ppc-morphos-gcc
INSTALL = install
TAR = tar
TARFLAGS = zcf

CPPFLAGS = -Wall -ansi -pedantic

ifdef SIZE
	CPPFLAGS := $(CPPFLAGS) -D_SIZE_=$(SIZE)
endif

PROGNAME = tictactoe
VERSION = 1.2.1

OBJFILES = line_o_s.o messages.o moves.o scores.o t3types.o t3visual.o tictactoe.o
DISTFILES = *.c *.h Makefile README Copying Changelog

INSTALLDIR = /usr/local/games
DISTNAME = $(PROGNAME)-$(VERSION)

.c.o:
	$(CC) -c $(CPPFLAGS) $<

$(PROGNAME): $(OBJFILES)
	$(LD) -o $@ $^

install: $(PROGNAME)
	$(INSTALL) $(PROGNAME) $(INSTALLDIR)

uninstall: 
	rm -f $(INSTALLDIR)/$(PROGNAME)

clean:
	rm -f $(OBJFILES)
	rm -f core

distclean: clean
	rm -f $(PROGNAME)

tar: $(DISTNAME).tar.gz

$(DISTNAME).tar.gz: $(DISTFILES)
	[ -d $(DISTNAME) ] && rm -rf $(DISTNAME); \
	mkdir $(DISTNAME); \
	cp $(DISTFILES) $(DISTNAME)/; \
	$(TAR) $(TARFLAGS) $@ $(DISTNAME)/; \
	rm -rf $(DISTNAME)

line_o_s.o: line_o_s.c t3types.h messages.h line_o_s.h

messages.o: messages.c messages.h

moves.o: moves.c messages.h t3types.h t3visual.h line_o_s.h scores.h

scores.o: scores.c messages.h scores.h t3types.h line_o_s.h moves.h

t3types.o: t3types.c t3types.h

t3visual.o: t3visual.c t3types.h messages.h

tictactoe.o: tictactoe.c messages.h t3types.h t3visual.h moves.h

PHONY: clean distclean install uninstall tar

