# Makefile for Mortar
#
# Ideally you should need just to set NAME, SOUND and LIB paths correctly
# for your system and then type 'make install'.  LIBDIR is always created
# but other directories you need to create yourself if they don't exist.
# Install is a bit untested btw...
#
# (w) 1998-1999 by Eero Tamminen

# TARGETS: fbmortar: Linux + framebuffers, wmortar: W, ggimortar: GGI,
# amortar: Amiga, pmortar: pilot, mortar.exe: DOS, mortar.ttp: Atari TOS

TARGETS = fbmortar wmortar xwmortar ggimortar amortar pmortar \
	mortar.exe mortar.ttp

# one of TARGETS
NAME	= amortar

# either 'gsi' (some unixen), 'tos' (TOS/MiNT+W), 'paula' (Amiga)
# or 'none' (default)
SOUND	= paula

# -DDEBUG enables a few extra sanity checks
CFLAGS	= -Wall -Wimplicit -O2 #-DDEBUG -g
LDFLAGS	= #-lefence

# extra, target specific libs
WLIBS	= -lW
XWLIBS  = -lW2X -L/usr/X11R6/lib -lX11
GGILIBS	= -lggi
ALIBS	= -lrtgm -lmieee

ifeq ($(NAME),mortar.exe)
 # DOS DJGPP / crosscompiler
 CC	= gcc-dos
 SCRIPT	= mort.bat
 BATDIR	= c:\dos
 # where you extracted Mortar and where BAT script will run it
 BASEDIR= c:\games\mortar
else
 ifeq ($(NAME),amortar)
  # AmigaOS 68k
  CC		= vc
  CFLAGS	= -O2 -DAMIGA -Dinline=
 else
  # generic unix
  UNIX		= 1
  CC		= gcc
  SCRIPT	= mort
  BINDIR	= /usr/local/bin
  MANDIR	= /usr/local/man/man6
  LIBDIR	= /usr/local/lib/mortar
  # LIBDIR	= /usr/local/share/games/mortar
 endif
endif

RM	= rm -f
PACK	= zip -r
TYPE	= zip

# -----------------

OBJS	= main.o intro.o game.o list.o user.o image.o range.o tank.o \
	  shot.o ammo.o shield.o util.o font.o scale.o screen.o \
	  color.o map.o pbm.o frame.o message.o config.o qtrig.o

# use snd-none.c for no sound
TOBJS	= win-tos.o snd-tos.o
DOBJS	= win-dos.o snd-none.o
POBJS	= win-pilot.o snd-none.o
GGIOBJS	= win-ggi.o snd-$(SOUND).o
FBOBJS  = win-lfb.o snd-$(SOUND).o
WOBJS	= win-w.o snd-$(SOUND).o
AOBJS	= win-rtgm.o snd-$(SOUND).o amiga.o

all: $(NAME)


wmortar: $(OBJS) $(WOBJS)
	$(CC) -o $@ $(OBJS) $(WOBJS) $(LDFLAGS) $(WLIBS)

xwmortar: $(OBJS) $(WOBJS)
	$(CC) -o $@ $(OBJS) $(WOBJS) $(LDFLAGS) $(XWLIBS)

pmortar: $(OBJS) $(POBJS)
	$(CC) -o $@ $(OBJS) $(POBJS) $(LDFLAGS)

fbmortar: $(OBJS) $(FBOBJS)
	$(CC) -o $@ $(OBJS) $(FBOBJS) $(LDFLAGS)

ggimortar: $(OBJS) $(GGIOBJS)
	$(CC) -o $@ $(OBJS) $(GGIOBJS) $(LDFLAGS) $(GGILIBS)

mortar.exe: $(OBJS) $(DOBJS)
	$(CC) -o $@ -s $(OBJS) $(DOBJS) $(LDFLAGS)

mortar.ttp: $(OBJS) $(TOBJS)
	$(CC) -o $@ $(OBJS) $(TOBJS) $(LDFLAGS)

amortar: $(OBJS) $(AOBJS)
	$(CC) -o $@ $(OBJS) $(AOBJS) $(LDFLAGS) $(ALIBS)


$(OBJS): mortar.h


# ---------------

ifdef UNIX

data: mortar.h
	$(MAKE) -C utils install

# it's not that obvious how to escape $* from both make and shell in 'mort'...
install: $(NAME)
	@echo checking that package got default files...
	[ -f data/config.def ] || { echo 'default config missing'; exit 1 }
	[ -f data/english ]    || { echo 'default language file missing'; exit 1 }
	[ -f data/ground.pic ] || { echo 'ground image(s) missing'; exit 1 }
	[ -f data/cannon.pic ] || { echo 'cannon image(s) missing'; exit 1 }
	[ -f data/font.pic ] || { echo 'font image(s) missing'; exit 1 }
	[ -f data/shot.pic ] || { echo 'shot image(s) missing'; exit 1 }
	[ -f data/sky.pic ] || { echo 'sky image(s) missing'; exit 1 }
	@echo removing olds and confirming dirs:
	rm -rf $(LIBDIR)
	[ -d $(BINDIR) ] || install -d -m 755 $(BINDIR)
	[ -d $(MANDIR) ] || install -d -m 755 $(MANDIR)
	[ -d $(LIBDIR) ] || install -d -m 755 $(LIBDIR)
	rm -f $(BINDIR)/$(NAME) $(BINDIR)/$(SCRIPT)
	rm -f $(MANDIR)/$(NAME).6 $(MANDIR)/$(SCRIPT).6
	@echo installing executables...
	install -s -m 755 $(NAME) $(BINDIR)/$(NAME)
	echo '#!/bin/sh' > $(BINDIR)/$(SCRIPT)
	echo $(NAME) -p $(LIBDIR) \$$\* >> $(BINDIR)/$(SCRIPT)
	chmod 755 $(BINDIR)/$(SCRIPT)
	@echo ...manuals...
	install -m 644 doc/mortar.6 $(MANDIR)/$(NAME).6
	ln -s $(MANDIR)/$(NAME).6 $(MANDIR)/$(SCRIPT).6
	@echo ...data files and configuration:
	for i in `find data/ -name CVS -prune -o -type f -print`; do install -m 644 $$i $(LIBDIR); done
	@echo
	@echo "You can now run MORTAR just by typing '$(SCRIPT) [players]'."

# simple code metrics ;-)
metrics:
	wc Makefile utils/Makefile utils/*.pov utils/*.[ch] *.[ch]

else

# DOS installation is untested
ifeq ($(NAME),mortar.exe)

install: $(NAME)
	@echo $(BASEDIR)\$(NAME) -p $(BASEDIR)\data > $(BATDIR)\$(SCRIPT)
	@echo "You can now run MORTAR just by typing '"$(SCRIPT)" [players]'."

endif

endif

# ---------

clean:
	$(MAKE) -C utils clean
	$(RM) *.o data/core

veryclean: clean
	$(RM) $(TARGETS) mortar.$(TYPE)

# removes also raytraced images
package: veryclean
	$(RM) data/{cannon,font,ground,shot,sky}.*
	cd ..
	$(PACK) mortar_s.$(TYPE) mortar/

# note that for sounds to work, you need to install mortar!
# that way sounds are copied to same directory as other files...
binpack:
	$(PACK) mortar.$(TYPE) $(NAME) *.bat data/ doc/
