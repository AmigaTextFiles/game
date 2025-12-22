#
# Shotgun Debugger
# Copyright 2005 Game Creation Society
#
# Programmed by Matt Sarnoff
# http://www.contrib.andrew.cmu.edu/~msarnoff
# http://www.gamecreation.org
#
# Unix Makefile
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#

CPP  = g++
CC   = gcc
OBJ  = bitmapfont.o levelobjects.o level.o md2.o weapons.o objects.o enemies.o input.o player.o game.o interface.o main.o
LINKOBJ = $(OBJ)
LIBS =  `sdl-config --libs` -lSDL_image -lSDL_mixer -lGL -lGLU
BIN  = sdb
CXXFLAGS = $(CFLAGS)
CFLAGS = `sdl-config --cflags` -O2

.PHONY: all

all: sdb

clean:
	rm -f $(OBJ) $(BIN)

$(BIN): $(OBJ)
	$(CPP) $(LINKOBJ) -o $(BIN) $(LIBS)

main.o: main.cpp
	$(CPP) -c main.cpp -o main.o $(CXXFLAGS)

game.o: game.cpp
	$(CPP) -c game.cpp -o game.o $(CXXFLAGS)

levelobjects.o: levelobjects.cpp
	$(CPP) -c levelobjects.cpp -o levelobjects.o $(CXXFLAGS)

bitmapfont.o: bitmapfont.cpp
	$(CPP) -c bitmapfont.cpp -o bitmapfont.o $(CXXFLAGS)

level.o: level.cpp
	$(CPP) -c level.cpp -o level.o $(CXXFLAGS)

weapons.o: weapons.cpp
	$(CPP) -c weapons.cpp -o weapons.o $(CXXFLAGS)
  
md2.o: md2.cpp
	$(CPP) -c md2.cpp -o md2.o $(CXXFLAGS)
  
objects.o: objects.cpp
	$(CPP) -c objects.cpp -o objects.o $(CXXFLAGS)

enemies.o: enemies.cpp
	$(CPP) -c enemies.cpp -o enemies.o $(CXXFLAGS)
  
input.o: input.cpp
	$(CPP) -c input.cpp -o input.o $(CXXFLAGS)

player.o: player.cpp
	$(CPP) -c player.cpp -o player.o $(CXXFLAGS)

interface.o: interface.cpp
	$(CPP) -c interface.cpp -o interface.o $(CXXFLAGS)


