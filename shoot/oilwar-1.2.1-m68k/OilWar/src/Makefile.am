EXTRA_DIST = install-sh missing mkinstalldirs config.sub config.guess\
background.png bitmaps.png\
singlegunshot.wav bulletricochet.wav explode.wav gasp.wav\
oilwar.scores

datafiledir = $(datadir)/games/oilwar
datafile_DATA = background.png bitmaps.png\
singlegunshot.wav bulletricochet.wav explode.wav gasp.wav

scorefiledir = /var/games
scorefile_DATA = oilwar.scores

AM_CPPFLAGS = $(sound_flag) -DDATA_DIR=\"$(datafiledir)/\" -DSCORE_DIR=\"$(scorefiledir)/\"

bin_PROGRAMS = oilwar
oilwar_SOURCES = Main.hpp Main.cpp cParticleSystem.hpp cParticleSystem.cpp Config.hpp

install-data-local:
	echo Setting access permissions of the highscore file
	chmod a+w $(DESTDIR)$(scorefiledir)/oilwar.scores
