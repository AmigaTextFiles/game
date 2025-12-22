# Makefile for installing and uninstalling data files

SHELL=@SHELL@


install:
	$(SHELL) ./../mkinstalldirs $(DESTDIR)$(pkgdatadir)
	chmod -R 755 $(DESTDIR)$(pkgdatadir)

# Directories in EXTRA_DIST doen't work?
dist-hook:

uninstall:
	@echo "Removing $(DESTDIR)$(pkgdatadir) ..."
	rm -rf $(DESTDIR)$(pkgdatadir)
