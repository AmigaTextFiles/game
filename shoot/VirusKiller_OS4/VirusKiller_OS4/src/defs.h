/*
Copyright (C) 2004 Parallel Realities

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

/* ############# system defaults ##### */

#define SCREENWIDTH		800
#define SCREENHEIGHT		600
#define SCREENDEPTH		16

/* ########### maximums ############ */

#define MAX_SOUNDS 	25

/* ########### game sections ######## */

#define SECTION_TITLE 		0
#define SECTION_GAME 		1
#define SECTION_HIGHSCORE 	2

/* ########### widgets ############ */

const char widgetName[][25] = {

	"BUTTON",
	"RADIO",
	"SMOOTH_SLIDER",
	"SLIDER",
	"LABEL",
	"INPUT",
	"-1"

};

#define WG_BUTTON				0
#define WG_RADIO				1
#define WG_SMOOTH_SLIDER 	2
#define WG_SLIDER				3
#define WG_LABEL 				4
#define WG_INPUT				5

#define SMOOTH_SLIDER_WIDTH	200.00

/* ############## text ############## */

#define TXT_LEFT 0
#define TXT_CENTERED 1
#define TXT_RIGHT 2

/* ############## sounds ############ */

enum {

	SND_VIRUSLAUGH1,
	SND_VIRUSLAUGH2,
	SND_VIRUSLAUGH3,
	SND_VIRUSLAUGH4,
	SND_VIRUSLAUGH5,
	SND_VIRUSLAUGH6,
	SND_VIRUSDESTROYDIR,
	SND_VIRUSEATFILE,
	SND_DIRDESTROYED1,
	SND_DIRDESTROYED2,
	SND_DIRDESTROYED3,
	SND_DIRDESTROYED4,
	SND_DIRDESTROYED5,
	SND_DIRDESTROYED6,
	SND_FILEDESTROYED1,
	SND_FILEDESTROYED2,
	SND_FILEDESTROYED3,
	SND_VIRUSKILLED1,
	SND_VIRUSKILLED2,
	SND_VIRUSKILLED3,
	SND_KERNALBEAM,
	SND_POWERUP,
	SND_CLOCK,
	SND_EXPLOSION,
	SND_GAMEOVER

};

/* ############ virus types ########## */

#define VIRUS_THIEF			0
#define VIRUS_EAT				1
#define VIRUS_DESTROY		2

/* ############ item types ########## */

#define ITEM_MINWAIT			3
#define ITEM_MAXWAIT			10

#define ITEM_POWER			0
#define ITEM_BOMB				1
#define ITEM_CLOCK			2
#define ITEM_TEXT				3

/* ############ mode ################# */

#define MODE_EASY				0
#define MODE_NORMAL			1
#define MODE_HARD				2
#define MODE_NIGHTMARE		3
#define MODE_ULTIMATE		4

const char gameModes[][20] = {

	"Easy",
	"Normal",
	"Hard",
	"Nightmare",
	"Ultimate Nightmare"

};

/* ########### pak file stuff ######## */

#define PAK_MAX_FILENAME 60

#ifndef USEPAK
	#define USEPAK 1
#endif
#ifndef PAKLOCATION
	#define PAKLOCATION ""
#endif
#ifndef PAKFULLPATH
	#define PAKFULLPATH PAKLOCATION PAKNAME
#endif
#ifndef PATH_MAX
	#define PATH_MAX	4096
#endif
#ifndef GAMEPLAYMANUAL
	#define GAMEPLAYMANUAL "manual.html"
#endif
#ifndef SAFEDIR
	#define SAFEDIR "/tmp/"
#endif

enum {

	PAK_IMG,
	PAK_SOUND,
	PAK_MUSIC,
	PAK_DATA,
	PAK_FONT
};

/* ############# debug ################## */

#ifndef DEBUG
	#define debug(x)
#else
	#define debug(x) {printf("*** DEBUG: "); printf x;}
#endif

/*############## port stuff ############# 

You can put your own details in here for when you do
ports :)

*/

#ifndef PLATFORMNAME
	#define PLATFORMNAME 	"Linux"
	#define PORTERSNAME		"Stephen Sweeney"
	#define PORTERSEMAIL	"stephen.sweeney@parallelrealities.co.uk"
#endif
