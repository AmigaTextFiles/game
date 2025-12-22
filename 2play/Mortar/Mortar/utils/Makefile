# Makefile for compiling MORTAR image utilities and creating images
# Use 'install16' for 16-color mortar images, 'install' otherwise.
#
# (w) 1998-1999 by Eero Tamminen

CC	= gcc
CFLAGS	= -Wall -O2 -fomit-frame-pointer
LDFLAGS	= -s

# uncomment if you want to save time and diskspace
#SMALL	= 1

# smallest memory print you get by having BGW and BGH
# set exactly to the screen size you use when playing.
ifdef SMALL
BGW	= 320
BGH	= 200
CW	= 32
CH	= 24
FRAMES	= 17
SW	= 8
SH	= 8
else
BGW	= 640
BGH	= 480
CW	= 48
CH	= 36
FRAMES	= 17
SW	= 12
SH	= 12
endif

# Game will need 2*BGC + 2*GRAYS amount of colors in addition to font colors.

# number of colors background pictures are quantized to
BGC	= 64

# number of grayscales / colors used by player and shot images
GRAYS	= 24

# character table image values (first char, columns, rows)
FIRST	= 32
XFONT	= 16
YFONT	= 14

# suitable skip values for >20 pixel font saved from xfd
XSKIP	= 7
YSKIP	= 4

# ------------------

DATA	= ../data
CONFIG	= config.def

OBJS	= ../pbm.o msg.o
UTILS	= insert merge order ppm24to8 ppm8to24 remap setcol squeeze
IMAGES	= shot.pic cannon.pic sky.pic ground.pic font.pic


all: $(UTILS) $(IMAGES)

$(UTILS): $(OBJS)

sky.pic: sky.pov insert ppm24to8
	povray +i$< +w$(BGW) +h$(BGH) +a +O- | cjpeg -quality 95 | djpeg -colors $(BGC) | ./ppm24to8 > $@
	./insert $@

ground.pic: ground.pov insert ppm24to8
	povray +i$< +w$(BGW) +h$(BGH) +a +O- | cjpeg -quality 95 | djpeg -colors $(BGC) | ./ppm24to8 > $@
	./insert $@

shot.pic: shot.pov order ppm24to8
	povray +i$< +w$(SW) +h$(SH) +a +fp +O- | ppmtopgm | ppmquant -fs $(GRAYS) | ./ppm24to8 | ./order > $@

cannon.pic: cannon.ini cannon.pov merge order ppm24to8 ppm8to24
	povray +w$(CW) +h$(CH) +kfi1 +kff$(FRAMES) $<
	rm -f cannon*.ppm
	./merge *.pgm | ./ppm8to24 | ppmquant -fs $(GRAYS) | ./ppm24to8 | ./order > $@
	rm -f cannon*.pgm

# font gif is a (possible manipulated) grab of the 'xfd' character table
# (characters 32-255).
font.pic: font.gif squeeze ppm24to8
	giftopnm $< | ./ppm24to8 | ./squeeze $(XFONT) $(YFONT) $(XSKIP) $(YSKIP) | ./order > $@


config: $(CONFIG)
	cp $(CONFIG) $(DATA)
#	@echo -n "energy = "		>> $(DATA)/$(CONFIG)
#	@echo "($(BGW)*1.4)/100*100"|bc	>> $(DATA)/$(CONFIG)
	@echo				>> $(DATA)/$(CONFIG)
	@echo "# -- game images --"	>> $(DATA)/$(CONFIG)
	@echo "width  =" $(BGW)		>> $(DATA)/$(CONFIG)
	@echo "height =" $(BGH)		>> $(DATA)/$(CONFIG)
	@echo				>> $(DATA)/$(CONFIG)
	@echo "sky    =" sky.pic	>> $(DATA)/$(CONFIG)
	@echo "ground =" ground.pic	>> $(DATA)/$(CONFIG)
	@echo				>> $(DATA)/$(CONFIG)
	@echo "font    =" font.pic	>> $(DATA)/$(CONFIG)
	@echo "first   =" $(FIRST)	>> $(DATA)/$(CONFIG)
	@echo "columns =" $(XFONT)	>> $(DATA)/$(CONFIG)
	@echo "rows    =" $(YFONT)	>> $(DATA)/$(CONFIG)
	@echo				>> $(DATA)/$(CONFIG)
	@echo "player =" cannon.pic	>> $(DATA)/$(CONFIG)
	@echo "frames =" $(FRAMES)	>> $(DATA)/$(CONFIG)
	@echo				>> $(DATA)/$(CONFIG)
	@echo "shot =" shot.pic		>> $(DATA)/$(CONFIG)
	cat $(DATA)/snd/map >> $(DATA)/$(CONFIG)


install: $(IMAGES) config
	mv $(IMAGES) $(DATA)


# -----------------

# The 'install16' target for 16-color resolutions has single color /
# single pixel (they are scaled at loading) sky and ground images,
# and will create one color font image and six color player/shot
# images (plus one extra palette entry for transparency).

# number of colors
FONT16	= 2
GRAY16	= 6

IMG16	= shot.16 cannon.16 font.16

shot.16: shot.pov order ppm24to8
	povray +i$< +w$(SW) +h$(SH) +a +fp +O- | ppmtopgm | ppmquant -fs $(GRAY16) | ./ppm24to8 | ./order > $@

cannon.16: cannon.ini cannon.pov merge order
	povray +w$(CW) +h$(CH) +kfi1 +kff$(FRAMES) $<
	rm -f cannon*.ppm
	./merge *.pgm | ./ppm8to24 | ppmquant -fs $(GRAY16) | ./ppm24to8 | ./order > $@
	rm -f cannon*.pgm

# convert to monochrome, back to color, squeeze and change color
font.16: font.gif order setcol squeeze ppm24to8
	giftopnm $< | ppmquant $(FONT16) | ./ppm24to8 | ./squeeze $(XFONT) $(YFONT) $(XSKIP) $(YSKIP) | ./order | ./setcol 1 0x00ffee > $@


CONFIG16 = $(DATA)/config.16

config.16: $(CONFIG)
	cp $(CONFIG) $(CONFIG16)
#	@echo -n "energy = "		>> $(CONFIG16)
#	@echo "($(BGW)*1.4)/100*100"|bc	>> $(CONFIG16)
	@echo				>> $(CONFIG16)
	@echo "# -- game images --"	>> $(CONFIG16)
	@echo "width  =" $(BGW)		>> $(CONFIG16)
	@echo "height =" $(BGH)		>> $(CONFIG16)
	@echo				>> $(CONFIG16)
	@echo "sky    =" sky.16		>> $(CONFIG16)
	@echo "ground =" ground.16	>> $(CONFIG16)
	@echo				>> $(CONFIG16)
	@echo "font    =" font.16	>> $(CONFIG16)
	@echo "first   =" $(FIRST)	>> $(CONFIG16)
	@echo "columns =" $(XFONT)	>> $(CONFIG16)
	@echo "rows    =" $(YFONT)	>> $(CONFIG16)
	@echo				>> $(CONFIG16)
	@echo "player =" cannon.16	>> $(CONFIG16)
	@echo "frames =" $(FRAMES)	>> $(CONFIG16)
	@echo				>> $(CONFIG16)
	@echo "shot =" shot.16		>> $(CONFIG16)
	cat $(DATA)/snd/map >> $(CONFIG16)


install16: $(IMG16) sky.16 ground.16 config.16
	cp sky.16 ground.16 $(DATA)
	mv $(IMG16) $(DATA)

# --------------------------------

clean:
	rm -f $(UTILS) $(IMAGES) $(IMG16) *.o core
