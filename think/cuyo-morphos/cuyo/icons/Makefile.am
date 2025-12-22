desktopdir = $(datadir)/applications
desktop_DATA = cuyo.desktop


# The following would automatically put cuyo with the full
# path into the desktop file. But do we really want that?
# Maybe things are easier without full path.
# (Then the user can move the binary around without having to
# worry about the desktop file.)   -Immi

#cuyo.desktop: cuyo.desktop.in
#	cp cuyo.desktop.in cuyo.desktop
#	echo "Exec=$(bindir)/cuyo" >> cuyo.desktop




# icons32dir = $(datadir)/icons/hicolor/32x32/apps
# icons48dir = $(datadir)/icons/hicolor/48x48/apps
# icons64dir = $(datadir)/icons/hicolor/64x64/apps
# icons32_DATA = cuyo-32x32.png
# icons48_DATA = cuyo-48x48.png
# icons64_DATA = cuyo-64x64.png

# Das vorige war falsch: die png sollen alle cuyo.png heissen
# und nicht cuyo-xxxx.png. Deshalb nachfolgend neue Version:

iconsdir = $(datadir)/icons/hicolor
icons_DATA = cuyo-32x32.png cuyo-64x64.png

install-iconsDATA:
	$(mkinstalldirs) $(DESTDIR)$(iconsdir)/32x32/apps
	$(INSTALL_DATA) $(srcdir)/cuyo-32x32.png $(DESTDIR)$(iconsdir)/32x32/apps/cuyo.png
	$(mkinstalldirs) $(DESTDIR)$(iconsdir)/64x64/apps
	$(INSTALL_DATA) $(srcdir)/cuyo-64x64.png $(DESTDIR)$(iconsdir)/64x64/apps/cuyo.png


uninstall-iconsDATA:
	-rm -f $(DESTDIR)$(iconsdir)/32x32/apps/cuyo.png
	-rm -f $(DESTDIR)$(iconsdir)/64x64/apps/cuyo.png





EXTRA_DIST = $(icons_DATA) cuyo.desktop
