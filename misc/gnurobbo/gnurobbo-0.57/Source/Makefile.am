bin_PROGRAMS = gnurobbo

gnurobbo_SOURCES = game.c game.h board.c data_init.c
EXTRA_DIST = levels.dat icons/icons.bmp robbo.ttf icons/ciphers.bmp icons/background.bmp

install-data-local:
	@$(NORMAL_INSTALL)
	if test -d $(srcdir)/pixmaps; then \
	  $(mkinstalldirs) $(DESTDIR)$(pkgdatadir)/pixmaps; \
	    for pixmap in $(srcdir)/pixmaps/*; do \
	      if test -f $$pixmap; then \
	       $(INSTALL_DATA) $$pixmap $(DESTDIR)$(pkgdatadir)/pixmaps; \
	      fi \
	    done \
	fi
	$(INSTALL_DATA) robbo.ttf $(DESTDIR)$(pkgdatadir)
	$(INSTALL_DATA) levels.dat $(DESTDIR)$(pkgdatadir)

dist-hook:
	if test -d pixmaps; then \
	  mkdir $(distdir)/pixmaps; \
	  for pixmap in pixmaps/*; do \
	    if test -f $$pixmap; then \
	     cp -p $$pixmap $(distdir)/pixmaps; \
	    fi \
	  done \
	fi
	cp -p robbo.ttf $(destdir)
	cp -p levels.dat $(destdir)
