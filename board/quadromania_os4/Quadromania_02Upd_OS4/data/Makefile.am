EXTRA_DIST = coypright.png dots.png font.png frame.png texture.png titel.png

install-data-local:
	@for file in *.png; do\
	  $(INSTALL_DATA) $$file $(DESTDIR)$(inst_dir)/$$file;\
	done
