DEFS = @DEFS@ @inst_flag@ @sound_flag@ @dis_flag@ @dl_flag@

bin_PROGRAMS = lgeneral

lgeneral_SOURCES = main.c \
config.c date.c \
file.c map.c nation.c \
player.c scenario.c sdl.c misc.c unit.c unit.h \
audio.c parser.c list.c unit_lib.c \
terrain.c image.c slot.c gui.c \
event.c windows.c action.c campaign.c \
strat_map.c ai.c engine.c ai_group.c ai_tools.c \
lgeneral.6

lgeneral_LDFLAGS = @export_flag@
lgeneral_LDADD   = @mixer_flag@ @dl_lib_flag@
man_MANS = lgeneral.6

EXTRA_DIST = lgeneral.h \
config.h date.h engine.h \
file.h map.h nation.h player.h \
player.h scenario.h sdl.h misc.h unit.h unit.h \
audio.h parser.h list.h unit_lib.h \
terrain.h image.h slot.h gui.h \
event.h windows.h action.h campaign.h \
strat_map.h ai.h ai_group.h ai_tools.h

SUBDIRS = gfx themes campaigns maps nations sounds music units \
scenarios ai_modules

install-data-local:
	$(mkinstalldirs) $(DESTDIR)$(inst_dir)

uninstall-local:
	rm -rf $(DESTDIR)$(inst_dir)
