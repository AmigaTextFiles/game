levelsdir = $(pkgdatadir)/levels
levels_DATA = Anthill.lev \
ArmsRace.lev \
BeachRaid.lev \
Foxhole.lev \
GreatBattle.lev \
IslandHoppers.lev \
LankhValley.lev \
LostFactories.lev \
MountainDefense.lev \
Revelation.lev \
Uprising.lev

EXTRA_DIST = $(levels_DATA:.lev=.src)
CLEANFILES = $(levels_DATA)

def_tiles = $(top_builddir)/tools/default.tiles
def_units = $(top_builddir)/tools/default.units

SUFFIXES = .lev .src
.src.lev:	$(top_builddir)/editor/cfed
		$(top_builddir)/editor/cfed "$<" --tiles $(def_tiles) --units $(def_units)

