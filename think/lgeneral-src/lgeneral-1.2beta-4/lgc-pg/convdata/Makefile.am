EXTRA_DIST = \
crosshair.bmp damage_bars.bmp fog.bmp grid.bmp road2.bmp select_frame.bmp \
strength.bmp air2.wav air.wav leg.wav sea.wav wheeled.wav tracked.wav \
battle.wav attack.bmp move.bmp select.wav mapnames reinf

install-data-local:
	$(mkinstalldirs) $(DESTDIR)$(inst_dir)/convdata
	@for file in *.bmp; do\
	  $(INSTALL_DATA) $$file $(DESTDIR)$(inst_dir)/convdata/$$file;\
	done
	@for file in *.wav; do\
	  $(INSTALL_DATA) $$file $(DESTDIR)$(inst_dir)/convdata/$$file;\
	done
	$(INSTALL_DATA) mapnames $(DESTDIR)$(inst_dir)/convdata/mapnames
	$(INSTALL_DATA) reinf $(DESTDIR)$(inst_dir)/convdata/reinf
