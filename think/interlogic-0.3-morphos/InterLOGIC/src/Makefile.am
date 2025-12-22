bin_PROGRAMS = interlogic


# set the include path found by configure
AM_CPPFLAGS = $(all_includes) $(LIBSDL_CFLAGS)

# the library search path.
interlogic_LDFLAGS = $(all_libraries) $(LIBSDL_RPATH)
interlogic_LDADD = $(LIBSDL_LIBS) -lSDL_image
interlogic_SOURCES = interlogic.c credits.c levels.c mainmenu.c password.c \
	splash.c

noinst_HEADERS = interlogic.h credits.h levels.h mainmenu.h password.h splash.h \
		levelinfo.h gfx_clock.xpm gfx_credits.xpm gfx_fontnum.xpm gfx_gameend.xpm \
	gfx_level.xpm gfx_lvlcomp.xpm gfx_mainmenu.xpm gfx_menuglow.xpm gfx_passback.xpm \
	gfx_passfont.xpm gfx_player.xpm gfx_splash.xpm gfx_tiles.xpm gfx_timesup.xpm
