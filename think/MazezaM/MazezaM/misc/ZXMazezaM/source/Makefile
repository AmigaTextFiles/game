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
PYTHON   = python
CPP      = cpp

MZMFILES = mazezams/original.mzm

#############
#  TESTING  # - you probably won't need to change these!
#############

# CPPMACROS = -D BLACK_AND_WHITE -D DEBUG_KEYS
# CPPMACROS = -D DEBUG_KEYS -D FINAL_BUILD
# CPPMACROS = -D DEBUG_KEYS
CPPMACROS = -D FINAL_BUILD
#CPPMACROS =

#############
#   RULES   # - you probably won't need to change these!
#############

all: MazezaM.tap

############
#  LOADER  #
############

MazezaM0.tap: src/loader.bas
	$(CPP) -P src/loader.bas $(CPPMACROS) loader.post.bas
	$(ZMAKEBAS) -l -a @START -s 0 -n MazezaM -o MazezaM0.tap loader.post.bas

#############
#   UDGS    #
#############

MazezaM2.tap: udgs/MazezaM2.tap
	cp udgs/MazezaM2.tap .

#############
# MAIN CODE #
#############

levels.bas: $(MZMFILES)
	$(PYTHON) mzmtools/mzm2zxbas.py $(MZMFILES) > levels.bas

MazezaM3.tap: levels.bas src/main.bas src/constants.bas
	$(CPP) -I. -P src/main.bas $(CPPMACROS) main.post.bas
	$(ZMAKEBAS) -l -a @START -s 0 -i 2 -n "MazezaM 3" -o MazezaM3.tap main.post.bas

##############
# FINAL TAPE #
##############

MazezaM.tap: MazezaM0.tap MazezaM2.tap MazezaM3.tap
	cat MazezaM0.tap MazezaM2.tap MazezaM3.tap > MazezaM.tap

##############
#   CLEAN    #
##############

clean:
	rm -f levels.bas MazezaM.pyc loader.post.bas main.post.bas
	rm -f MazezaM0.tap MazezaM2.tap MazezaM3.tap MazezaM.tap
