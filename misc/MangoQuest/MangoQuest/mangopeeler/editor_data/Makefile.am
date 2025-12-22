# Makefile for installing and uninstalling data files

SHELL=@SHELL@

install:
	$(SHELL) ./../mkinstalldirs $(DESTDIR)$(pkgdatadir)
	cp -r bonus fonts interface autres icone.bmp splash.png  $(DESTDIR)$(pkgdatadir)/
	chmod -R 755 $(DESTDIR)$(pkgdatadir)

# Directories in EXTRA_DIST doen't work?
dist-hook:
	cp -r -p bonus $(DESTDIR)$(distdir)
	cp -r -p fonts  $(DESTDIR)$(distdir)
	cp -r -p interface  $(DESTDIR)$(distdir)
	cp -r -p icone.bmp  $(DESTDIR)$(distdir)
	cp -r -p splash.png  $(DESTDIR)$(distdir)
	cp -r -p autres  $(DESTDIR)$(distdir)

uninstall:
	@echo "Removing $(DESTDIR)$(pkgdatadir) ..."
	rm -rf $(DESTDIR)$(pkgdatadir)
