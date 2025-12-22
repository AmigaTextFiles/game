EXTRA_DIST = font_credit.bmp title.bmp

SUBDIRS = flags terrain units

install-data-local:
	$(mkinstalldirs) $(DESTDIR)$(inst_dir)/gfx
	$(mkinstalldirs) $(DESTDIR)$(inst_dir)/gfx/terrain
	$(mkinstalldirs) $(DESTDIR)$(inst_dir)/gfx/units
	$(mkinstalldirs) $(DESTDIR)$(inst_dir)/gfx/flags
	@for file in *.bmp; do\
	  $(INSTALL_DATA) $$file $(DESTDIR)$(inst_dir)/gfx/$$file;\
	done
