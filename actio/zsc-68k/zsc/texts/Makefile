# Generated automatically from Makefile.in by configure.
# Makefile.in generated automatically by automake 1.4 from Makefile.am

# Copyright (C) 1994, 1995-8, 1999 Free Software Foundation, Inc.
# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# xsc: Copyright (c) 1993-2001 by Mark B. Hanson (mbh@panix.com).

# @(#)$Id: Makefile.am,v 3.4 2001/04/29 00:39:36 mark Exp $


SHELL = /bin/sh

srcdir = .
top_srcdir = .
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

DESTDIR =

pkgdatadir = $(datadir)/xsc
pkglibdir = $(libdir)/xsc
pkgincludedir = $(includedir)/xsc

top_builddir = .

ACLOCAL = aclocal
AUTOCONF = autoconf
AUTOMAKE = automake
AUTOHEADER = autoheader

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL} $(AM_INSTALL_PROGRAM_FLAGS)
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_SCRIPT = ${INSTALL_PROGRAM}
transform = s,x,x,

NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
CXX = g++ -m68020 -m68881
MAKEINFO = makeinfo

PACKAGE = xsc
VERSION = 1.4

#AUTOMAKE_OPTIONS = no-dependencies

# for development
#CXXFLAGS = -g -Wall -W -Wshadow -Wcast-qual -Wcast-align \
#	-Wconversion -Winline

bin_PROGRAMS = xsc
xsc_SOURCES =  	args.C 	buzzer.C 	castle.C 	cyrilc.C 	ething.C 	fireball.C 	gothgbt.C 	king.C 	laser.C 	minefield.C 	ring.C 	romans.C 	romant.C 	ship.C 	stamp.C 	starfield.C 	stats.C 	text.C 	thing.C 	trig.C 	tthing.C 	util.C 	xsc.C 	xything.C


EXTRA_DIST =  	args.h 	buzzer.h 	castle.h 	config.h 	ething.h 	fireball.h 	font.h 	global.h 	icon.xbm 	king.h 	laser.h 	minefield.h 	random.h 	ring.h 	ship.h 	stamp.h 	starfield.h 	stats.h 	text.h 	thing.h 	timing.h 	trig.h 	tthing.h 	util.h 	xsc.h 	xything.h 
ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
mkinstalldirs = $(SHELL) $(top_srcdir)/mkinstalldirs
CONFIG_HEADER = config.h
CONFIG_CLEAN_FILES = 
PROGRAMS =  $(bin_PROGRAMS)


DEFS = -DHAVE_CONFIG_H -I. -I$(srcdir) -I.
CPPFLAGS = 
LDFLAGS =    -L/usr/X11R6/lib
LIBS = -lX11 -lm 
X_CFLAGS =  -I/usr/X11R6/include
X_LIBS =  -L/usr/X11R6/lib
X_EXTRA_LIBS = 
X_PRE_LIBS =  -lSM -lICE
xsc_OBJECTS =  args.o buzzer.o castle.o cyrilc.o ething.o fireball.o \
gothgbt.o king.o laser.o minefield.o ring.o romans.o romant.o ship.o \
stamp.o starfield.o stats.o text.o thing.o trig.o tthing.o util.o xsc.o \
xything.o
xsc_LDADD = $(LDADD)
xsc_DEPENDENCIES = 
xsc_LDFLAGS = 
CXXFLAGS = -g -O2
CXXCOMPILE = $(CXX) $(DEFS) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CXXFLAGS) $(CXXFLAGS)
CXXLD = $(CXX)
CXXLINK = $(CXXLD) $(AM_CXXFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@
DIST_COMMON =  README ./stamp-h.in AUTHORS COPYING ChangeLog INSTALL \
Makefile.am Makefile.in NEWS aclocal.m4 config.h.in configure \
configure.in install-sh missing mkinstalldirs


DISTFILES = $(DIST_COMMON) $(SOURCES) $(HEADERS) $(TEXINFOS) $(EXTRA_DIST)

TAR = gtar
GZIP_ENV = --best
SOURCES = $(xsc_SOURCES)
OBJECTS = $(xsc_OBJECTS)


all: all-redirect
.SUFFIXES:
.SUFFIXES: .C .S .c .o .s
$(srcdir)/Makefile.in: Makefile.am $(top_srcdir)/configure.in $(ACLOCAL_M4) 
	cd $(top_srcdir) && $(AUTOMAKE) --gnu --include-deps Makefile

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status
	cd $(top_builddir) \
	  && CONFIG_FILES=$@ CONFIG_HEADERS= $(SHELL) ./config.status

$(ACLOCAL_M4):  configure.in 
	cd $(srcdir) && $(ACLOCAL)



sdl:
	make xsc \
		LDFLAGS="-lSDL_mixer `sdl-config --libs`" \
		LIBS="" \
		X_CFLAGS="" \
		X_LIBS="" \
		X_EXTRA_LIBS="" \
		X_PRE_LIBS="" \
		CPPFLAGS="`sdl-config --cflags` -DUSE_SDL" \
		xsc_OBJECTS="$(xsc_OBJECTS) XSDL.o playsound.o"

emtest:
	make xsc \
		LDFLAGS="`sdl-config --libs` -lSDL_mixer" \
		LIBS="" \
		X_CFLAGS="" \
		X_LIBS="" \
		X_EXTRA_LIBS="" \
		X_PRE_LIBS="" \
		CPPFLAGS="`sdl-config --cflags` -DUSE_SDL -DEMBEDDED" \
		xsc_OBJECTS="$(xsc_OBJECTS) XSDL.o playsound.o"

embedded:
	make xsc \
		LIBS="/usr/local/arm/lib/libSDL_mixer.a /usr/local/arm/lib/libSDL.a -L/usr/local/arm/lib/ -lpthread -L/opt/Qtopia/sharp/lib -lqpe -lqte" \
		LDFLAGS="" \
		X_CFLAGS="" \
		X_LIBS="" \
		X_EXTRA_LIBS="" \
		X_PRE_LIBS="" \
		CPPFLAGS="`sdl-config --cflags` -DUSE_SDL -DEMBEDDED -DQTOPIA" \
		xsc_OBJECTS="$(xsc_OBJECTS) XSDL.o playsound.o" \
		CXX="/opt/Embedix/tools/bin/arm-linux-g++ -DQT_QWS_EBX -DQT_QWS_CUSTOM -DQWS -fno-exceptions -fno-rtti" \
		LD=/opt/Embedix/tools/bin/arm-linux-g++
	/opt/Embedix/tools/bin/arm-linux-strip xsc





config.status: $(srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
	$(SHELL) ./config.status --recheck
$(srcdir)/configure: $(srcdir)/configure.in $(ACLOCAL_M4) $(CONFIGURE_DEPENDENCIES)
	cd $(srcdir) && $(AUTOCONF)

config.h: stamp-h
	@if test ! -f $@; then \
		rm -f stamp-h; \
		$(MAKE) stamp-h; \
	else :; fi
stamp-h: $(srcdir)/config.h.in $(top_builddir)/config.status
	cd $(top_builddir) \
	  && CONFIG_FILES= CONFIG_HEADERS=config.h \
	     $(SHELL) ./config.status
	@echo timestamp > stamp-h 2> /dev/null
$(srcdir)/config.h.in: $(srcdir)/stamp-h.in
	@if test ! -f $@; then \
		rm -f $(srcdir)/stamp-h.in; \
		$(MAKE) $(srcdir)/stamp-h.in; \
	else :; fi
$(srcdir)/stamp-h.in: $(top_srcdir)/configure.in $(ACLOCAL_M4) 
	cd $(top_srcdir) && $(AUTOHEADER)
	@echo timestamp > $(srcdir)/stamp-h.in 2> /dev/null

mostlyclean-hdr:

clean-hdr:

distclean-hdr:
	-rm -f config.h

maintainer-clean-hdr:

mostlyclean-binPROGRAMS:

clean-binPROGRAMS:
	-test -z "$(bin_PROGRAMS)" || rm -f $(bin_PROGRAMS)

distclean-binPROGRAMS:

maintainer-clean-binPROGRAMS:

install-binPROGRAMS: $(bin_PROGRAMS)
	@$(NORMAL_INSTALL)
	$(mkinstalldirs) $(DESTDIR)$(bindir)
	@list='$(bin_PROGRAMS)'; for p in $$list; do \
	  if test -f $$p; then \
	    echo "  $(INSTALL_PROGRAM) $$p $(DESTDIR)$(bindir)/`echo $$p|sed 's/$(EXEEXT)$$//'|sed '$(transform)'|sed 's/$$/$(EXEEXT)/'`"; \
	     $(INSTALL_PROGRAM) $$p $(DESTDIR)$(bindir)/`echo $$p|sed 's/$(EXEEXT)$$//'|sed '$(transform)'|sed 's/$$/$(EXEEXT)/'`; \
	  else :; fi; \
	done

uninstall-binPROGRAMS:
	@$(NORMAL_UNINSTALL)
	list='$(bin_PROGRAMS)'; for p in $$list; do \
	  rm -f $(DESTDIR)$(bindir)/`echo $$p|sed 's/$(EXEEXT)$$//'|sed '$(transform)'|sed 's/$$/$(EXEEXT)/'`; \
	done

.c.o:
	$(COMPILE) -c $<

.s.o:
	$(COMPILE) -c $<

.S.o:
	$(COMPILE) -c $<

mostlyclean-compile:
	-rm -f *.o core *.core

clean-compile:

distclean-compile:
	-rm -f *.tab.c

maintainer-clean-compile:

xsc: $(xsc_OBJECTS) $(xsc_DEPENDENCIES)
	@rm -f xsc
	$(CXXLINK) $(xsc_OBJECTS) $(xsc_LDFLAGS) $(xsc_LDADD) $(LIBS)
.C.o:
	$(CXXCOMPILE) -c $<

tags: TAGS

ID: $(HEADERS) $(SOURCES) $(LISP)
	list='$(SOURCES) $(HEADERS)'; \
	unique=`for i in $$list; do echo $$i; done | \
	  awk '    { files[$$0] = 1; } \
	       END { for (i in files) print i; }'`; \
	here=`pwd` && cd $(srcdir) \
	  && mkid -f$$here/ID $$unique $(LISP)

TAGS:  $(HEADERS) $(SOURCES) config.h.in $(TAGS_DEPENDENCIES) $(LISP)
	tags=; \
	here=`pwd`; \
	list='$(SOURCES) $(HEADERS)'; \
	unique=`for i in $$list; do echo $$i; done | \
	  awk '    { files[$$0] = 1; } \
	       END { for (i in files) print i; }'`; \
	test -z "$(ETAGS_ARGS)config.h.in$$unique$(LISP)$$tags" \
	  || (cd $(srcdir) && etags $(ETAGS_ARGS) $$tags config.h.in $$unique $(LISP) -o $$here/TAGS)

mostlyclean-tags:

clean-tags:

distclean-tags:
	-rm -f TAGS ID

maintainer-clean-tags:

distdir = $(PACKAGE)-$(VERSION)
top_distdir = $(distdir)

# This target untars the dist file and tries a VPATH configuration.  Then
# it guarantees that the distribution is self-contained by making another
# tarfile.
distcheck: dist
	-rm -rf $(distdir)
	GZIP=$(GZIP_ENV) $(TAR) zxf $(distdir).tar.gz
	mkdir $(distdir)/=build
	mkdir $(distdir)/=inst
	dc_install_base=`cd $(distdir)/=inst && pwd`; \
	cd $(distdir)/=build \
	  && ../configure --srcdir=.. --prefix=$$dc_install_base \
	  && $(MAKE) $(AM_MAKEFLAGS) \
	  && $(MAKE) $(AM_MAKEFLAGS) dvi \
	  && $(MAKE) $(AM_MAKEFLAGS) check \
	  && $(MAKE) $(AM_MAKEFLAGS) install \
	  && $(MAKE) $(AM_MAKEFLAGS) installcheck \
	  && $(MAKE) $(AM_MAKEFLAGS) dist
	-rm -rf $(distdir)
	@banner="$(distdir).tar.gz is ready for distribution"; \
	dashes=`echo "$$banner" | sed s/./=/g`; \
	echo "$$dashes"; \
	echo "$$banner"; \
	echo "$$dashes"
dist: distdir
	-chmod -R a+r $(distdir)
	GZIP=$(GZIP_ENV) $(TAR) chozf $(distdir).tar.gz $(distdir)
	-rm -rf $(distdir)
dist-all: distdir
	-chmod -R a+r $(distdir)
	GZIP=$(GZIP_ENV) $(TAR) chozf $(distdir).tar.gz $(distdir)
	-rm -rf $(distdir)
distdir: $(DISTFILES)
	-rm -rf $(distdir)
	mkdir $(distdir)
	-chmod 777 $(distdir)
	@for file in $(DISTFILES); do \
	  d=$(srcdir); \
	  if test -d $$d/$$file; then \
	    cp -pr $$d/$$file $(distdir)/$$file; \
	  else \
	    test -f $(distdir)/$$file \
	    || ln $$d/$$file $(distdir)/$$file 2> /dev/null \
	    || cp -p $$d/$$file $(distdir)/$$file || :; \
	  fi; \
	done
args.o: args.C global.h config.h xsc.h args.h timing.h stamp.h
buzzer.o: buzzer.C global.h config.h random.h trig.h util.h xsc.h args.h \
	timing.h stamp.h buzzer.h castle.h laser.h king.h fireball.h \
	ship.h ething.h tthing.h thing.h xything.h minefield.h stats.h \
	text.h ring.h
castle.o: castle.C global.h config.h timing.h stamp.h util.h xsc.h \
	args.h castle.h laser.h king.h fireball.h ship.h ething.h \
	tthing.h thing.h xything.h trig.h minefield.h buzzer.h stats.h \
	text.h ring.h
cyrilc.o: cyrilc.C global.h config.h font.h
ething.o: ething.C global.h config.h ething.h tthing.h thing.h xything.h \
	trig.h xsc.h args.h timing.h stamp.h
fireball.o: fireball.C global.h config.h random.h trig.h util.h xsc.h \
	args.h timing.h stamp.h fireball.h king.h castle.h laser.h \
	minefield.h buzzer.h ship.h ething.h tthing.h thing.h xything.h \
	stats.h text.h ring.h
gothgbt.o: gothgbt.C global.h config.h font.h
king.o: king.C global.h config.h trig.h util.h xsc.h args.h timing.h \
	stamp.h king.h castle.h laser.h minefield.h buzzer.h ship.h \
	ething.h tthing.h thing.h xything.h stats.h text.h ring.h \
	fireball.h
laser.o: laser.C global.h config.h trig.h util.h xsc.h args.h timing.h \
	stamp.h laser.h castle.h minefield.h buzzer.h king.h fireball.h \
	ship.h ething.h tthing.h thing.h xything.h stats.h text.h \
	ring.h
minefield.o: minefield.C global.h config.h random.h util.h xsc.h args.h \
	timing.h stamp.h minefield.h buzzer.h castle.h laser.h king.h \
	fireball.h ship.h ething.h tthing.h thing.h xything.h trig.h \
	stats.h text.h ring.h
ring.o: ring.C global.h config.h trig.h util.h xsc.h args.h timing.h \
	stamp.h ring.h laser.h castle.h minefield.h buzzer.h king.h \
	fireball.h ship.h ething.h tthing.h thing.h xything.h stats.h \
	text.h
romans.o: romans.C global.h config.h font.h
romant.o: romant.C global.h config.h font.h
ship.o: ship.C global.h config.h random.h timing.h stamp.h trig.h util.h \
	xsc.h args.h ship.h castle.h laser.h king.h fireball.h stats.h \
	tthing.h thing.h text.h xything.h minefield.h buzzer.h ring.h \
	ething.h
stamp.o: stamp.C global.h config.h stamp.h
starfield.o: starfield.C global.h config.h random.h util.h xsc.h args.h \
	timing.h stamp.h starfield.h ething.h tthing.h thing.h \
	xything.h trig.h
stats.o: stats.C global.h config.h util.h xsc.h args.h timing.h stamp.h \
	ship.h castle.h laser.h king.h fireball.h stats.h tthing.h \
	thing.h text.h xything.h trig.h minefield.h buzzer.h ring.h \
	ething.h
text.o: text.C global.h config.h font.h util.h xsc.h args.h timing.h \
	stamp.h text.h thing.h
thing.o: thing.C global.h config.h util.h xsc.h args.h timing.h stamp.h \
	thing.h
trig.o: trig.C global.h config.h util.h xsc.h args.h timing.h stamp.h \
	trig.h
tthing.o: tthing.C global.h config.h trig.h util.h tthing.h thing.h
util.o: util.C global.h config.h util.h xsc.h args.h timing.h stamp.h
xsc.o: xsc.C global.h config.h random.h args.h timing.h stamp.h trig.h \
	util.h xsc.h castle.h laser.h king.h fireball.h ship.h ething.h \
	tthing.h thing.h xything.h minefield.h buzzer.h stats.h text.h \
	ring.h starfield.h icon.xbm
xything.o: xything.C global.h config.h trig.h xsc.h args.h timing.h \
	stamp.h xything.h thing.h

info-am:
info: info-am
dvi-am:
dvi: dvi-am
check-am: all-am
check: check-am
installcheck-am:
installcheck: installcheck-am
all-recursive-am: config.h
	$(MAKE) $(AM_MAKEFLAGS) all-recursive

install-exec-am: install-binPROGRAMS
install-exec: install-exec-am

install-data-am:
install-data: install-data-am

install-am: all-am
	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am
install: install-am
uninstall-am: uninstall-binPROGRAMS
uninstall: uninstall-am
all-am: Makefile $(PROGRAMS) config.h
all-redirect: all-am
install-strip:
	$(MAKE) $(AM_MAKEFLAGS) AM_INSTALL_PROGRAM_FLAGS=-s install
installdirs:
	$(mkinstalldirs)  $(DESTDIR)$(bindir)


mostlyclean-generic:

clean-generic:

distclean-generic:
	-rm -f Makefile $(CONFIG_CLEAN_FILES)
	-rm -f config.cache config.log stamp-h stamp-h[0-9]*

maintainer-clean-generic:
mostlyclean-am:  mostlyclean-hdr mostlyclean-binPROGRAMS \
		mostlyclean-compile mostlyclean-tags \
		mostlyclean-generic

mostlyclean: mostlyclean-am

clean-am:  clean-hdr clean-binPROGRAMS clean-compile clean-tags \
		clean-generic mostlyclean-am

clean: clean-am

distclean-am:  distclean-hdr distclean-binPROGRAMS distclean-compile \
		distclean-tags distclean-generic clean-am

distclean: distclean-am
	-rm -f config.status

maintainer-clean-am:  maintainer-clean-hdr maintainer-clean-binPROGRAMS \
		maintainer-clean-compile maintainer-clean-tags \
		maintainer-clean-generic distclean-am
	@echo "This command is intended for maintainers to use;"
	@echo "it deletes files that may require special tools to rebuild."

maintainer-clean: maintainer-clean-am
	-rm -f config.status

.PHONY: mostlyclean-hdr distclean-hdr clean-hdr maintainer-clean-hdr \
mostlyclean-binPROGRAMS distclean-binPROGRAMS clean-binPROGRAMS \
maintainer-clean-binPROGRAMS uninstall-binPROGRAMS install-binPROGRAMS \
mostlyclean-compile distclean-compile clean-compile \
maintainer-clean-compile tags mostlyclean-tags distclean-tags \
clean-tags maintainer-clean-tags distdir info-am info dvi-am dvi check \
check-am installcheck-am installcheck all-recursive-am install-exec-am \
install-exec install-data-am install-data install-am install \
uninstall-am uninstall all-redirect all-am all installdirs \
mostlyclean-generic distclean-generic clean-generic \
maintainer-clean-generic clean mostlyclean distclean maintainer-clean


# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
