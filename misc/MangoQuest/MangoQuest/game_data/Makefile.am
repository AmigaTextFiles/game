# Makefile for installing and uninstalling data files

SHELL=@SHELL@

install:
	$(SHELL) ./../mkinstalldirs $(DESTDIR)$(pkgdatadir)
	cp -r icone.bmp menus fonts hud sounds textures maps $(DESTDIR)$(pkgdatadir)
	chmod -R 755 $(DESTDIR)$(pkgdatadir)

# Directories in EXTRA_DIST doen't work?
dist-hook:
	cp -r -p fonts $(DESTDIR)$(distdir)
	cp -r -p menus $(DESTDIR)$(distdir)
	cp -r -p hud  $(DESTDIR)$(distdir)
	cp -r -p sounds  $(DESTDIR)$(distdir)
	cp -r -p textures  $(DESTDIR)$(distdir)
	cp -r -p maps  $(DESTDIR)$(distdir)
	cp -r -p icone.bmp $(DESTDIR)$(distdir)
	cp -r -p $(DESTDIR)$(distdir)

uninstall:
	@echo "Removing $(DESTDIR)$(pkgdatadir) ..."
	rm -rf $(DESTDIR)$(pkgdatadir)
