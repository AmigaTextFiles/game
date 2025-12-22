#
# Copyright 2008 The nPush Developers
#
# This file is part of nPush (http://npush.sourceforge.net).
#
# nPush is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# nPush is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with nPush in file COPYING; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

# directory where the games are installed (/usr, /usr/local, ... or something)
ifndef PREFIX
PREFIX=/usr
endif

PROGRAM = npush.fpu
OBJECTS = npush.o 
MY_CFLAGS = -g -Wall
CC = g++ -m68020 -m68881 -noixemul

%.o:	%.cpp
	$(CC) -c $(MY_CFLAGS) $< -o $@


all:	$(PROGRAM)


$(PROGRAM):	$(OBJECTS)
	$(CC) -g -Wall -o $(PROGRAM) $(OBJECTS) -lpdcurses_ns `sdl-config2 --libs`

clean:
	$(RM) *.o
	$(RM) $(PROGRAM)
	$(RM) $(PROGRAM).exe

