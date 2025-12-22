/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DEFINITIONS_H
#define DEFINITIONS_H

#define SCREEN_BPP 8

#define	LNG_ENG	1
#define LNG_GER 2
#define LNG_FRE	3


#define MAPMAGIC 3358395
#define SAVEMAGIC 5342535

#define M_PI 3.1415926535897932384626433832795
#define DIAGONALSPEEDCONST 0.70710678118654752440084436210485
#define DIAGONALCOST 1.4142135623730950488016887242097


#define GAMESPEED_MAX 25
#define GAMESPEED_MIN 5
#define VOLUME_MAX 100
#define VOLUME_MIN 0

#define MESSAGE_BUFFER_SIZE 5
#define MAX_PLAYERS 6

#define MAX_LINE 256
#define MAX_MSGLENGTH 30
#define MAX_NAMELENGTH 20
#define MAX_XSIZE 256
#define MAX_YSIZE 256

#define ROCKFILLER 1		//how many times random generator will try to remove sand "holes" for rock from the map
#define SPICEFILLER 1		//for spice
#define ROCKFIELDS 10		//how many fields it will randomly generate
#define SPICEFIELDS 10

#define BUILDRANGE 2
#define RANDOMSPICEMIN 150	//how much spice on each spice tile
#define RANDOMSPICEMAX 250
#define RANDOMTHICKSPICEMIN 250
#define RANDOMTHICKSPICEMAX 400
#define conv2char 2.0 * M_PI / 256
#define BLOCKSIZE 16		//size of tile pieces 16x16
#define GAMEBARWIDTH 144
#define NONE ((Uint32) -1)			// unsigned -1
#define INVALID_POS	(-1)
#define INVALID (-1)

#define DEVIATIONTIME 500
#define HARVESTERMAXSPICE 700
#define HARVESTSPEED 0.2
#define HARVESTEREXTRACTSPEED 0.5
#define RANDOMHARVESTMOVE 300
#define HEAVILYDAMAGEDRATIO 0.3	//if health/getMaxHealth() < this, when damaged will become heavily damage- smoke and shit
#define HEAVILYDAMAGEDSPEEDMULTIPLIER 0.75	// 0.666666666666
#define RANDOMTURNTIMER 2000	//less of this makes units randomly turn more
#define NUMSELECTEDLISTS 9
#define NUM_INFANTRY_PER_CELL 5		//how many infantry can fit in a cell
#define LASTSANDFRAME 2	//is number spice output frames - 1

#define UNIT_REPAIRCOST 0.1
#define DEFAULT_GUARDRANGE 10			//0 - 10, how far unit will search for enemy when guarding
#define DEFAULT_STARTINGCREDITS 3000

#define PALACE_DEATHHAND_WEAPONDAMAGE       100

#define INFANTRY_FRAMETIME			500

#define NUM_ANGLES 8
#define MAXANGLE 7
#define RIGHT 0
#define RIGHTUP 1
#define UP 2
#define LEFTUP 3
#define LEFT 4
#define LEFTDOWN 5
#define DOWN 6
#define RIGHTDOWN 7

#define COLOUR_CLEAR 0
#define COLOUR_BLACK 12
#define COLOUR_DARKGREY 13
#define COLOUR_BLUE 11
#define COLOUR_LIGHTBLUE 9
#define COLOUR_LIGHTGREY 14
#define COLOUR_BROWN 95
#define COLOUR_YELLOW 123
#define COLOUR_GREEN 3
#define COLOUR_LIGHTGREEN 4
#define COLOUR_RED 231
#define COLOUR_WHITE 255
#define COLOUR_ORANGE 83

#define COLOUR_DESERTSAND 105
#define COLOUR_SPICE 111
#define COLOUR_THICKSPICE 116
#define COLOUR_MOUNTAIN 47

#define COLOUR_ATREIDES 160
#define COLOUR_ORDOS 176
#define COLOUR_HARKONNEN 144
#define COLOUR_SARDAUKAR 208
#define COLOUR_FREMEN 192
#define COLOUR_MERCENARY 128

#endif //DEFINITIONS_H
