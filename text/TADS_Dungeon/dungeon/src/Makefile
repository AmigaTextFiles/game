# Makefile for Dungeon, the TADS port.
# Requires TADS compiler 2.1.0 or greater.  (developed with 2.1.2)

#
# Set TC and TR to point to your TADS compiler and run-time.
#
TC=		../../tads/tadsc
TR=		../../tads/tadsr

PROGNAME=	dungeon
#SWAPTIONS=	-tf /tmp/TADSSWAP.DAT
OOPTIONS=	-s -mp10000 -ml32768 -fv b
OPTIONS=	$(OOPTIONS) $(SWAPTIONS)
RUNOPTIONS=
VERBOSE=	-v1

FILES1=		adv.t adv-mods.t std.t verbs.t classes.t funcs.t \
		fight.t help.t \
		house.t thief.t puzzle.t bank.t alice.t carousel.t dam.t \
		river.t volcano.t temple.t mines.t \
		objects.t
FILES2=		maze.t gue.t \
		dome.t endgame.t
FILES3=		debug.t
FILES=		$(FILES1) $(FILES2) $(FILES3)

$(PROGNAME).gam: Makefile $(PROGNAME).t $(FILES)
	$(TC) $(OPTIONS) $(PROGNAME).t
debug: Makefile $(PROGNAME).t $(FILES)
	$(TC) -ds $(OPTIONS) $(PROGNAME).t

run: $(PROGNAME).gam
	$(TR) $(RUNOPTIONS) $(PROGNAME).gam

#$(PROGNAME).gam: Makefile precomp.to $(PROGNAME).t $(FILES)
#	$(TC) $(OPTIONS) -l precomp.to $(PROGNAME).t
full: Makefile $(PROGNAME).t $(FILES)
	$(TC) $(OPTIONS) $(VERBOSE) $(PROGNAME).t

# doesn't save us that much time, but...
precomp.to:	precomp.t Makefile $(FILES1)
	$(TC) $(OPTIONS) $(VERBOSE) -w precomp.to precomp.t
