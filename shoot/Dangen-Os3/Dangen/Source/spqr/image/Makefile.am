# Makefile.am for dangen/spqr/image
# $Id: Makefile.am,v 1.14 2005/08/14 01:52:49 oohara Exp $
# process this file with automake --foreign to generate Makefile.in

EXTRA_DIST = font.png \
  font-medium.png \
  font-terminus.png

install-data-local:
	$(mkinstalldirs) $(DESTDIR)$(datadir)/games/dangen/image/
	$(INSTALL_DATA) $(top_srcdir)/spqr/image/font.png \
  $(DESTDIR)$(datadir)/games/dangen/image/

uninstall-local:
	-rm -f $(DESTDIR)$(datadir)/games/dangen/image/font.png
	-rmdir $(DESTDIR)$(datadir)/games/dangen/image/
	-rmdir $(DESTDIR)$(datadir)/games/dangen/
