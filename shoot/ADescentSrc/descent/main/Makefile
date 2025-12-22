# Kludgy makefile

LIBDIR=../lib
OBJDIR=../objects
BINDIR=..


LDFLAGS=-g -gstabs
GDBFLAG=#-pg
BASEREL=-fstrength-reduce -msmall-code -fbaserel32
LIBS=-L$(LIBDIR) -lgr -lkali -l3d -lbios -lcfile -lfix -lmisc  -liff -lmem -ltexmap -lvecmat -lami -lm -lgr # -lcf -lui -lgr -leditor -lui -lgr


BIN=$(BINDIR)/adescent
BIN_OBJS=  \
	$(OBJDIR)/inferno.o $(OBJDIR)/game.o $(OBJDIR)/gauges.o $(OBJDIR)/mglobal.o \
	$(OBJDIR)/scores.o $(OBJDIR)/object.o $(OBJDIR)/laser.o $(OBJDIR)/physics.o $(OBJDIR)/bm.o \
	$(OBJDIR)/menu.o $(OBJDIR)/gamesave.o $(OBJDIR)/switch.o $(OBJDIR)/effects.o $(OBJDIR)/texmerge.o $(OBJDIR)/polyobj.o \
	$(OBJDIR)/gamemine.o $(OBJDIR)/fireball.o $(OBJDIR)/ai.o $(OBJDIR)/aipath.o $(OBJDIR)/hostage.o \
	$(OBJDIR)/powerup.o $(OBJDIR)/fuelcen.o $(OBJDIR)/digi.o $(OBJDIR)/render.o $(OBJDIR)/hash.o $(OBJDIR)/piggy.o $(OBJDIR)/args.o \
	$(OBJDIR)/gameseg.o $(OBJDIR)/wall.o $(OBJDIR)/collide.o $(OBJDIR)/lighting.o \
	$(OBJDIR)/robot.o $(OBJDIR)/morph.o $(OBJDIR)/vclip.o $(OBJDIR)/weapon.o $(OBJDIR)/fvi.o $(OBJDIR)/newdemo.o $(OBJDIR)/titles.o \
	$(OBJDIR)/gameseq.o $(OBJDIR)/controls.o $(OBJDIR)/automap.o $(OBJDIR)/text.o \
	$(OBJDIR)/network.o $(OBJDIR)/newmenu.o $(OBJDIR)/netmisc.o $(OBJDIR)/victor.o\
	$(OBJDIR)/gamefont.o $(OBJDIR)/joydefs.o $(OBJDIR)/hud.o $(OBJDIR)/playsave.o \
	$(OBJDIR)/endlevel.o $(OBJDIR)/terrain.o $(OBJDIR)/kconfig.o $(OBJDIR)/modem.o  \
	$(OBJDIR)/multi.o $(OBJDIR)/cntrlcen.o $(OBJDIR)/credits.o $(OBJDIR)/config.o $(OBJDIR)/kmatrix.o      \
	$(OBJDIR)/paging.o $(OBJDIR)/mission.o $(OBJDIR)/songs.o $(OBJDIR)/bmread.o $(OBJDIR)/state.o \
	$(OBJDIR)/multibot.o $(OBJDIR)/nocomlib.o $(OBJDIR)/slew.o $(OBJDIR)/dumpmine.o

all: $(BIN)

$(BIN): $(BIN_OBJS)
	gcc $(GDBFLAG) $(LDFLAGS) -o $@ $(BIN_OBJS)  $(LIBS) $(BASEREL)

$(OBJDIR)/aipath.o : aipath.c
	gcc $(CFLAGS) -O3 -fexpensive-optimizations $(INCLUDES) -o $@ -c $<

$(OBJDIR)/ai.o : ai.c
	gcc $(CFLAGS) -O3 -fexpensive-optimizations $(INCLUDES) -o $@ -c $<

$(OBJDIR)/%.o : %.c
	gcc $(CFLAGS) $(INCLUDES) -o $@ -c $<

clean:
	rm -f $(BIN) $(BIN_OBJS)
