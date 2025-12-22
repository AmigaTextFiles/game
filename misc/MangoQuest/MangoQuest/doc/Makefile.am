# Makefile for installing and uninstalling data files

SHELL=@SHELL@

install:
	$(SHELL) ./../mkinstalldirs $(DESTDIR)$(pkgdatadir)/
	$(SHELL) ./../mkinstalldirs $(DESTDIR)$(pkgdatadir)/doc
	cp -r manuals $(DESTDIR)$(pkgdatadir)/doc/
	chmod -R 755 $(DESTDIR)$(pkgdatadir)

# Directories in EXTRA_DIST doesn't work?
dist-hook:
	cp -r -p manuals $(DESTDIR)$(distdir)

uninstall:
	@echo "Removing $(DESTDIR)$(pkgdatadir) ..."
	rm -rf $(DESTDIR)$(pkgdatadir)
