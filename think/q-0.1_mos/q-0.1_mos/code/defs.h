/*
Copyright (C) 2003 Parallel Realities

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

#define min(a, b) ((a) < (b) ? (a) : (b))
#define max(a, b) ((a) > (b) ? (a) : (b))

#define PI = 3.14159265359;

/* ############## errors ########### */

#define ERR_FILE 		"A required file (%s) could not be loaded"

/* ########### maximums ############ */

#define MAX_TILES		50
#define MAX_BALLS 	10

/* ########## map ################# */

#define MAPWIDTH		15
#define MAPHEIGHT		16

#define MAP_AIR		0
#define MAP_WALL		1
#define MAP_RED		2
#define MAP_YELLOW	3
#define MAP_GREEN		4
#define MAP_BLUE		5

const char ballTypes[][25] = {
	"RED",
	"YELLOW",
	"GREEN",
	"BLUE"
};

/* ########## balls ################ */

#define UNDEFINED_BALL	-1
#define RED_BALL			0
#define YELLOW_BALL		1
#define GREEN_BALL		2
#define BLUE_BALL			3

/* ########### game sections ######## */

#define SECTION_TITLE 0
#define SECTION_GAME 1

/* ########### widgets ############ */

const char widgetName[][25] = {

	"BUTTON",
	"RADIO",
	"SMOOTH_SLIDER",
	"SLIDER",
	"LABEL",
	"-1"

};

#define WG_BUTTON				0
#define WG_RADIO				1
#define WG_SMOOTH_SLIDER 	2
#define WG_SLIDER				3
#define WG_LABEL 				4

/* ############## text ############## */

#define TXT_LEFT 0
#define TXT_CENTERED 1
#define TXT_RIGHT 2

/* ########### pak file stuff ######## */

#ifndef USEPAK
	#define USEPAK 1
#endif
#ifndef DATALOCATION
	#define DATALOCATION ""
#endif
#ifndef PATH_MAX
	#define PATH_MAX	4096
#endif

/* ############# debug ################## */

#if USEPAK
	#define debug(x)
#else
	#define debug(x) {printf("*** DEBUG: "); printf x;}
#endif
