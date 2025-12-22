EXTRA_DIST = \
click.wav edit.wav \
bkgnd.bmp brief_frame.bmp confirm_buttons.bmp ctrl_buttons.bmp cursors.bmp \
deploy_buttons.bmp folder.bmp font_brief.bmp font_error.bmp font_status.bmp \
font_std.bmp font_turn_info.bmp fr_hori.bmp fr_llc.bmp fr_luc.bmp fr_rlc.bmp \
fr_ruc.bmp fr_vert.bmp menu0_buttons.bmp menu1_buttons.bmp \
menu2_buttons.bmp menu3_buttons.bmp menu4_buttons.bmp module_buttons.bmp \
scen_dlg_buttons.bmp scroll_buttons.bmp unit_buttons.bmp wallpaper.bmp \
setup_confirm_buttons.bmp

install-data-local:
	$(mkinstalldirs) $(DESTDIR)$(inst_dir)/themes/default
	@for file in *.wav; do\
	  $(INSTALL_DATA) $$file $(DESTDIR)$(inst_dir)/themes/default/$$file;\
	done
	@for file in *.bmp; do\
	  $(INSTALL_DATA) $$file $(DESTDIR)$(inst_dir)/themes/default/$$file;\
	done
