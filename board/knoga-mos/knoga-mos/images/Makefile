# Makefile.in generated automatically by automake 1.5 from Makefile.am.

# Copyright 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001
# Free Software Foundation, Inc.
# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.



####### kdevelop will overwrite this part!!! (begin)##########

SHELL = /bin/sh

srcdir = .
top_srcdir = ../..

prefix = /usr/local
exec_prefix = ${prefix}

bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/sbin
libexecdir = ${exec_prefix}/libexec
datadir = ${prefix}/share
sysconfdir = ${prefix}/etc
sharedstatedir = ${prefix}/com
localstatedir = ${prefix}/var
libdir = ${exec_prefix}/lib
infodir = ${prefix}/info
mandir = ${prefix}/man
includedir = ${prefix}/include
oldincludedir = /usr/include
pkgdatadir = $(datadir)/knoga
pkglibdir = $(libdir)/knoga
pkgincludedir = $(includedir)/knoga
top_builddir = ../..

ACLOCAL = aclocal
AUTOCONF = autoconf
AUTOMAKE = automake
AUTOHEADER = autoheader

INSTALL = /bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_SCRIPT = ${INSTALL}
INSTALL_HEADER = $(INSTALL_DATA)
transform = s,x,x,
NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
AMTAR = tar
AWK = gawk
CC = gcc
CXX = g++
DEPDIR = .deps
EXEEXT = 
INSTALL_STRIP_PROGRAM = ${SHELL} $(install_sh) -c -s
OBJEXT = o
PACKAGE = knoga
SDL_CFLAGS = -noixemul -I/usr/include/SDL
SDL_CONFIG = /bin/sdl-config
SDL_LIBS = -L/usr/lib -noixemul -lSDL -lc -lm
VERSION = 0.2
am__include = include
am__quote = 
install_sh = /Ram Disk/knoga-0.2/install-sh

EXTRA_DIST = 1er.png \
             2er.png \
	     3er.png \
	     3pa.png \
	     4er.png \
	     4pa.png \
	     5er.png \
	     6er.png \
	     background.png \
	     ablage.png \
	     anibutton.png \
	     becher.png \
	     becher1.png \
	     black.png \
	     cha.png \
	     feld.png \
	     fha.png \
	     gabc.png \
	     gstr.png \
	     highscore.png \
	     int.png \
	     int1.png \
	     kabc.png \
	     kni.png \
	     kstr.png \
	     man1.png \
	     menu1.png \
	     menu2.png \
	     menu3.png \
	     menu4.png \
	     menu5.png \
	     menu6.png \
	     menu7.png \
	     menu8.png \
	     menueback.png \
	     pfeil.png \
	     w1.gif \
	     w1.png \
	     w2.gif \
	     w2.png \
	     w3.gif \
	     w3.png \
	     w4.png \
	     w5.png \
	     w6.png 

subdir = src/images
mkinstalldirs = $(SHELL) $(top_srcdir)/mkinstalldirs
CONFIG_CLEAN_FILES =
DIST_SOURCES =
DIST_COMMON = Makefile.am Makefile.in
all: all-am

.SUFFIXES:
$(srcdir)/Makefile.in:  Makefile.am  $(top_srcdir)/configure.in $(ACLOCAL_M4)
	cd $(top_srcdir) && \
	  $(AUTOMAKE) --gnu  src/images/Makefile
Makefile:  $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) && \
	  CONFIG_HEADERS= CONFIG_LINKS= \
	  CONFIG_FILES=$(subdir)/$@ $(SHELL) ./config.status
uninstall-info-am:
tags: TAGS
TAGS:


DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)

top_distdir = ../..
distdir = $(top_distdir)/$(PACKAGE)-$(VERSION)

distdir: $(DISTFILES)
	@for file in $(DISTFILES); do \
	  if test -f $$file; then d=.; else d=$(srcdir); fi; \
	  dir=`echo "$$file" | sed -e 's,/[^/]*$$,,'`; \
	  if test "$$dir" != "$$file" && test "$$dir" != "."; then \
	    $(mkinstalldirs) "$(distdir)/$$dir"; \
	  fi; \
	  if test -d $$d/$$file; then \
	    cp -pR $$d/$$file $(distdir) \
	    || exit 1; \
	  else \
	    test -f $(distdir)/$$file \
	    || cp -p $$d/$$file $(distdir)/$$file \
	    || exit 1; \
	  fi; \
	done
check-am: all-am
check: check-am
all-am: Makefile

installdirs:

install: install-am
install-exec: install-exec-am
install-data: install-data-am
uninstall: uninstall-am

install-am: all-am
	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am

installcheck: installcheck-am
install-strip:
	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
	  `test -z '$(STRIP)' || \
	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
mostlyclean-generic:

clean-generic:

distclean-generic:
	-rm -f Makefile $(CONFIG_CLEAN_FILES) stamp-h stamp-h[0-9]*

maintainer-clean-generic:
	@echo "This command is intended for maintainers to use"
	@echo "it deletes files that may require special tools to rebuild."
clean: clean-am

clean-am: clean-generic mostlyclean-am

distclean: distclean-am

distclean-am: clean-am distclean-generic

dvi: dvi-am

dvi-am:

info: info-am

info-am:

install-data-am: install-data-local

install-exec-am:

install-info: install-info-am

install-man:

installcheck-am:

maintainer-clean: maintainer-clean-am

maintainer-clean-am: distclean-am maintainer-clean-generic

mostlyclean: mostlyclean-am

mostlyclean-am: mostlyclean-generic

uninstall-am: uninstall-info-am uninstall-local

.PHONY: all all-am check check-am clean clean-generic distclean \
	distclean-generic distdir dvi dvi-am info info-am install \
	install-am install-data install-data-am install-data-local \
	install-exec install-exec-am install-info install-info-am \
	install-man install-strip installcheck installcheck-am \
	installdirs maintainer-clean maintainer-clean-generic \
	mostlyclean mostlyclean-generic uninstall uninstall-am \
	uninstall-info-am uninstall-local

####### 

install-data-local:
	$(mkinstalldirs) /usr/local/games/knoga/
	$(mkinstalldirs) /usr/local/games/knoga/images/
	$(mkinstalldirs) /usr/local/games/knoga/sounds/
	$(INSTALL_DATA)	1er.png /usr/local/games/knoga/images/1er.png
	$(INSTALL_DATA)	2er.png /usr/local/games/knoga/images/2er.png
	$(INSTALL_DATA)	3er.png /usr/local/games/knoga/images/3er.png
	$(INSTALL_DATA)	4er.png /usr/local/games/knoga/images/4er.png
	$(INSTALL_DATA)	3pa.png /usr/local/games/knoga/images/3pa.png
	$(INSTALL_DATA)	4pa.png /usr/local/games/knoga/images/4pa.png
	$(INSTALL_DATA)	5er.png /usr/local/games/knoga/images/5er.png
	$(INSTALL_DATA)	6er.png /usr/local/games/knoga/images/6er.png
	$(INSTALL_DATA)	ablage.png /usr/local/games/knoga/images/ablage.png
	$(INSTALL_DATA)	anibutton.png /usr/local/games/knoga/images/anibutton.png
	$(INSTALL_DATA)	background.png /usr/local/games/knoga/images/background.png
	$(INSTALL_DATA)	becher.png /usr/local/games/knoga/images/becher.png
	$(INSTALL_DATA)	becher1.png /usr/local/games/knoga/images/becher1.png
	$(INSTALL_DATA)	black.png /usr/local/games/knoga/images/black.png
	$(INSTALL_DATA)	cha.png /usr/local/games/knoga/images/cha.png
	$(INSTALL_DATA)	feld.png /usr/local/games/knoga/images/feld.png
	$(INSTALL_DATA)	fha.png /usr/local/games/knoga/images/fha.png
	$(INSTALL_DATA)	gabc.png /usr/local/games/knoga/images/gabc.png
	$(INSTALL_DATA)	gstr.png /usr/local/games/knoga/images/gstr.png
	$(INSTALL_DATA)	highscore.png /usr/local/games/knoga/images/highscore.png
	$(INSTALL_DATA)	int.png /usr/local/games/knoga/images/int.png
	$(INSTALL_DATA)	int1.png /usr/local/games/knoga/images/int1.png
	$(INSTALL_DATA)	kabc.png /usr/local/games/knoga/images/kabc.png
	$(INSTALL_DATA)	kni.png /usr/local/games/knoga/images/kni.png
	$(INSTALL_DATA)	kstr.png /usr/local/games/knoga/images/kstr.png
	$(INSTALL_DATA)	man1.png /usr/local/games/knoga/images/man1.png
	$(INSTALL_DATA)	menu1.png /usr/local/games/knoga/images/menu1.png
	$(INSTALL_DATA)	menu2.png /usr/local/games/knoga/images/menu2.png
	$(INSTALL_DATA)	menu3.png /usr/local/games/knoga/images/menu3.png
	$(INSTALL_DATA)	menu4.png /usr/local/games/knoga/images/menu4.png
	$(INSTALL_DATA)	menu5.png /usr/local/games/knoga/images/menu5.png
	$(INSTALL_DATA)	menu6.png /usr/local/games/knoga/images/menu6.png
	$(INSTALL_DATA)	menu7.png /usr/local/games/knoga/images/menu7.png
	$(INSTALL_DATA)	menu8.png /usr/local/games/knoga/images/menu8.png
	$(INSTALL_DATA)	menueback.png /usr/local/games/knoga/images/menueback.png
	$(INSTALL_DATA)	pfeil.png /usr/local/games/knoga/images/pfeil.png
	$(INSTALL_DATA)	w1.gif /usr/local/games/knoga/images/w1.gif
	$(INSTALL_DATA)	w1.png /usr/local/games/knoga/images/w1.png
	$(INSTALL_DATA)	w2.gif /usr/local/games/knoga/images/w2.gif
	$(INSTALL_DATA)	w2.png /usr/local/games/knoga/images/w2.png
	$(INSTALL_DATA)	w3.gif /usr/local/games/knoga/images/w3.gif
	$(INSTALL_DATA)	w3.png /usr/local/games/knoga/images/w3.png
	$(INSTALL_DATA)	w4.png /usr/local/games/knoga/images/w4.png
	$(INSTALL_DATA)	w5.png /usr/local/games/knoga/images/w5.png
	$(INSTALL_DATA)	w6.png /usr/local/games/knoga/images/w6.png

uninstall-local:
	-rm -f /usr/local/games/knoga/images/1er.png
	-rm -f /usr/local/games/knoga/images/2er.png
	-rm -f /usr/local/games/knoga/images/3er.png
	-rm -f /usr/local/games/knoga/images/4er.png
	-rm -f /usr/local/games/knoga/images/5er.png
	-rm -f /usr/local/games/knoga/images/6er.png
	-rm -f /usr/local/games/knoga/images/ablage.png
	-rm -f /usr/local/games/knoga/images/anibutton.png
	-rm -f /usr/local/games/knoga/images/background.png
	-rm -f /usr/local/games/knoga/images/becher.png
	-rm -f /usr/local/games/knoga/images/becher1.png
	-rm -f /usr/local/games/knoga/images/black.png
	-rm -f /usr/local/games/knoga/images/cha.png
	-rm -f /usr/local/games/knoga/images/feld.png
	-rm -f /usr/local/games/knoga/images/fha.png
	-rm -f /usr/local/games/knoga/images/gabc.png
	-rm -f /usr/local/games/knoga/images/gstr.png
	-rm -f /usr/local/games/knoga/images/highscore.png
	-rm -f /usr/local/games/knoga/images/int.png
	-rm -f /usr/local/games/knoga/images/int1.png
	-rm -f /usr/local/games/knoga/images/kabc.png
	-rm -f /usr/local/games/knoga/images/kni.png
	-rm -f /usr/local/games/knoga/images/kstr.png
	-rm -f /usr/local/games/knoga/images/man1.png
	-rm -f /usr/local/games/knoga/images/menu1.png
	-rm -f /usr/local/games/knoga/images/menu2.png
	-rm -f /usr/local/games/knoga/images/menu3.png
	-rm -f /usr/local/games/knoga/images/menu4.png
	-rm -f /usr/local/games/knoga/images/menu5.png
	-rm -f /usr/local/games/knoga/images/menu6.png
	-rm -f /usr/local/games/knoga/images/menu7.png
	-rm -f /usr/local/games/knoga/images/menu8.png
	-rm -f /usr/local/games/knoga/images/menueback.png
	-rm -f /usr/local/games/knoga/images/pfeil.png
	-rm -f /usr/local/games/knoga/images/w1.gif
	-rm -f /usr/local/games/knoga/images/w1.png
	-rm -f /usr/local/games/knoga/images/w2.gif
	-rm -f /usr/local/games/knoga/images/w2.png
	-rm -f /usr/local/games/knoga/images/w3.gif
	-rm -f /usr/local/games/knoga/images/w3.png
	-rm -f /usr/local/games/knoga/images/w4.png
	-rm -f /usr/local/games/knoga/images/w5.png
	-rm -f /usr/local/games/knoga/images/w6.png
# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
