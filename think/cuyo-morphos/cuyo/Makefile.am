# Die Daten sollen jetzt nicht mehr nach /usr/share/cuyo, sondern
# nach /usr/share/games/cuyo
# Erst mal noch auskommentiert, weil man das in jede einzelne Makefile.am
# schreiben müsste, was irgendwie doof ist.
# pkgdatadir = $(datadir)/games/@PACKAGE@

SUBDIRS = src data docs icons

# Damit die GNU-Dateien nicht notwendig sind:
# AUTOMAKE_OPTIONS = foreign 


EXTRA_DIST = autogen.sh sdl.m4

# aclocal soll mit -I . aufgerufen werden. Auch, wenn es automatisch von
# make aufgerufen wird. Automake macht das aber ohne "-I ."; deshalb manuell
# setzen. (Dadurch, dass hier ACLOCAL gesetzt wird, lässt automake die sonst
# automatisch generierte Zeile "ACLOCAL = @ACLOCAL@" weg.

ACLOCAL_AMFLAGS = -I .

CLEANFILES = config.h.in~
DISTCLEANFILES = stamp-h stamp-h1
MAINTAINERCLEANFILES =  Makefile.in configure install-sh stamp-h.in aclocal.m4 config.h.in mkinstalldirs config.guess config.sub missing depcomp



dist-hook:
	mkdir $(distdir)/datasrc
	($(DATASRC_MAINTAINER_MODE) && $(MAKE) -C datasrc distfiles) || true
	for file in `cat datasrc/distfiles`; do cp datasrc/$$file $(distdir)/datasrc/; done
	mkdir $(distdir)/datasrc/pics
	($(DATASRC_MAINTAINER_MODE) && $(MAKE) -C datasrc/pics distfiles) || true
	for file in `cat datasrc/pics/distfiles`; do cp datasrc/pics/$$file $(distdir)/datasrc/pics/; done

