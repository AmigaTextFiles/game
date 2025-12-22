# Makefile - builds a .tap file of the MazezaM game for the ZX Spectrum
#
# Copyright (C) 2002 Malcolm Tyrrell
# tyrrelmr@cs.tcd.ie
#
# You may use and distribute this file under the terms of the GNU General
# Public Licence.

#############
# VARIABLES # - you may need to change these!
#############

ZMAKEBAS = ~/bin/zmakebas

#############
#   RULES   # - you probably won't need to change these!
#############

all: udgmaker.tap

#############
#   UDGS    #
#############

udgmaker.tap: udgmaker.bas
	$(ZMAKEBAS) -l -n udgmaker -o udgmaker.tap udgmaker.bas

clean:
	rm -f udgmaker.tap
#	rm -f udgmaker.tap MazezaM2.tap
