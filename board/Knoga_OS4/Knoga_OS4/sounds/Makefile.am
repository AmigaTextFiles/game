####### kdevelop will overwrite this part!!! (begin)##########
EXTRA_DIST = bad.wav \
	 blocks.wav \
	 clap.wav \
	 gameover.wav \
	 track1.xm \
	 track2.mod \
	 tick.wav \
	 tick1.wav \
	 winner.wav \
	 wuerfel13.wav  
####### 

install-data-local:
	$(mkinstalldirs) /usr/local/games/knoga/
	$(mkinstalldirs) /usr/local/games/knoga/images/
	$(mkinstalldirs) /usr/local/games/knoga/sounds/
	$(INSTALL_DATA) bad.wav /usr/local/games/knoga/sounds/bad.wav
	$(INSTALL_DATA) blocks.wav /usr/local/games/knoga/sounds/blocks.wav
	$(INSTALL_DATA) gameover.wav /usr/local/games/knoga/sounds/gameover.wav
	$(INSTALL_DATA) tick.wav /usr/local/games/knoga/sounds/tick.wav
	$(INSTALL_DATA) tick1.wav /usr/local/games/knoga/sounds/tick1.wav
	$(INSTALL_DATA) winner.wav /usr/local/games/knoga/sounds/winner.wav
	$(INSTALL_DATA) wuerfel13.wav /usr/local/games/knoga/sounds/wuerfel13.wav
	$(INSTALL_DATA) track1.xm /usr/local/games/knoga/sounds/track1.xm
	$(INSTALL_DATA) track2.mod /usr/local/games/knoga/sounds/track2.mod
	

uninstall-local:
	-rm -f /usr/local/games/knoga/sounds/bad.wav
	-rm -f /usr/local/games/knoga/sounds/blocks.wav
	-rm -f /usr/local/games/knoga/sounds/gameover.wav
	-rm -f /usr/local/games/knoga/sounds/tick.wav
	-rm -f /usr/local/games/knoga/sounds/tick1.wav
	-rm -f /usr/local/games/knoga/sounds/winner.wav
	-rm -f /usr/local/games/knoga/sounds/wuerfel13.wav
	-rm -f /usr/local/games/knoga/sounds/track1.xm
	-rm -f /usr/local/games/knoga/sounds/track2.mod


