## Process this file with automake to produce Makefile.in
bin_PROGRAMS = lupengo

lupengo_SOURCES = \
	attract.c bdscoretab.c demo.c main.c joy.c lupengo.h \
	pics.c play.c sounds.c strconst.c topten.c

INCLUDES = -DDATADIR=\""$(pkgdatadir)"\" -DSCOREDIR=\""$(scoredir)"\"

SUBDIRS = picture sound

scoredir = $(localstatedir)/games
score_DATA = lupsco.dat
