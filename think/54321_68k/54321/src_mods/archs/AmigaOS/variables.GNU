############################################################
CXX := g++ -m68020 -m68881
STRIP := strip
############################################################
MKDIR_CMD = test -d $(@D) || mkdir -p $(@D)
############################################################

SDL := /usr/local
SDL_IMAGE := /usr/local

CPPFLAGS += `sdl-config2 --cflags`
LDFLAGS += \
	-lSDL_image -ljpeg -lpng -lz `sdl-config2 --libs` \
	-lpthread  

prog:	Release/54321-$(ARCH)

Release/54321-$(ARCH):
	-@$(MKDIR_CMD)
	echo '#!/bin/sh' > $@
	echo "cd ./bin/$(ARCH) && exec ./54321 \$$*" >> $@
	chmod 755 $@
