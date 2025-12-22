#
# Makefile for Daimonin
#
#
#   Copyright (C) 2002 Michael Toennies
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   The author can be reached via e-mail to michael.toennies@nord-com.net


srcdir = .

SRCS = \
	book.c\
	client.c\
	commands.c\
	event.c\
	group.c\
	interface.c\
	inventory.c\
	item.c\
	main.c\
	map.c\
	menu.c\
	misc.c\
	player.c\
	socket.c\
	sound.c\
	sprite.c\
	textwin.c\
	wrapper.c\
	dialog.c\
	adler32.c \
	crc32.c \
	inflate.c\
	inffast.c\
	inftrees.c\
	uncompr.c\
	zutil.c\
	filewrap.c

ALLFILES = $(SRCS) Makefile.in

DEPEND = 

SED = @SED@

OBJS = $(SRCS:.c=.o)
EXTRA_LIBS = -LSDK:Local/newlib/lib
SDL_CFLAGS = -DAMIGA
SDL_CONFIG = 
SDL_LIBS = -lSDL_image -lSDL_mixer -lvorbisenc -lvorbisfile -lvorbis -logg -lpng -ljpeg -lsmpeg -lSDLmain -lSDL -lpthread -lm -lstdc++ -lauto
##SDL_LIBS =  -lSDL_image -lSDL_mixer
## nach -lm kommt -lstdc++, vor lpthread kommt lnet
CFLAGS = -newlib -O2 -funsigned-char $(EXTRA_CFLAGS) $(SDL_CFLAGS)
EXTRA_INCLUDES = -Isdk:newlib/include
INCLUDES= $(EXTRA_INCLUDES) -I$(srcdir)/include

LDFLAGS = -newlib

LIBS =  $(EXTRA_LIBS) $(SDL_LIBS)

SHELL = /bin/sh

prefix = ../../../client-BETA3-0.966
exec_prefix = ${prefix}
bindir = ${exec_prefix}/bin

INSTALL = /usr/bin/install -c

MKDIR = /usr/bin/mkdir
CC = gcc
RM = delete

daimonin: $(OBJS) $(LOCAL_LIBRARIES)
	$(RM) -f $@
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LOCAL_LIBRARIES) $(LIBS)

depend:
	$(DEPEND) $(DEPENDFLAGS) -- $(CFLAGS) $(INCLUDES) -- $(SRCS)

clean::
	$(RM) -f daimonin $(OBJS) Makefile.bak

distclean:: clean
	$(RM) -f Makefile ./include/define.h

.c.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $*.c

all: daimonin
