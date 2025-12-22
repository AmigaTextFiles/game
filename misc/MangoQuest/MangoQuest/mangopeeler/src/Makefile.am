PACKAGE = @PACKAGE@
VERSION = @VERSION@

DATA_PREFIX=$(pkgdatadir)/../mangoquest/
ED_DATA_PREFIX=$(pkgdatadir)/
DEFS =  -DVERSION=\"@VERSION@\"

CXXFLAGS  = @CXXFLAGS@ -Wall \
 -DSHXMAN_DATA=\"$(DATA_PREFIX)\" \
 -DSHXEDIT_DATA=\"$(ED_DATA_PREFIX)\"
LIBS    = @LIBS@

CXX = g++

bin_PROGRAMS = mangopeeler
mangopeeler_SOURCES = main.cpp share.cpp editeur.cpp carte.cpp \
	clique.cpp polices.cpp ch_tout.cpp SDLStretch.cpp \
	volet.cpp volet_bonus.cpp volet_textures.cpp volet_special.cpp \
	sge_draw.cpp labyr.cpp geom.cpp portals.cpp secteur.cpp bonus.cpp \
	file_utils.cpp config_file.cpp

mangopeeler_CFLAGS  = CXXFLAGS
mangopeeler_LIBS    = LIBS
