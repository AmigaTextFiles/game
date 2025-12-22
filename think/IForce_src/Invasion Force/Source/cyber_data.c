/*
AI Code for Invasion Force - an Explore/Conquer Strategic Wargame
Copyright (C) 1996  Brannen Hough

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

/*
	cyber_data.c -- artificial intelligence module for Empire II

*/

/* This file contains all the static data used to simplify the AI
	routines.  Why calculate anything when a lookup table is here?
*/

#include "global.h"


/***************************
****  Global Data  *****
***************************/

int     AIDataFlag = 0;

struct  GovHist H;

struct  rtHandlerInfo *AIhandle = NULL;


char    outbuf[256];

// This is the location where the global movement routine
//		does it's computations.
int		*MoveMap = NULL;

// And now, to make the Governors a list like everything else
struct 	MinList  GovList;


int 	NewGov = 12;

int     NewUnit = 1000;

struct  GovReqs  LastReq;	// Just make this global - easier


struct  MinList  OpenList;
struct  MinList  DoneList;      // Two lists for our new A* path finder
int              *PathMap = NULL;  // And a place to record Directions
int               PathMapX = 0;
int               PathMapY = 0;
int               Path[MAX_PATH];
int               PathDiv;
int               PathLength;


/***************************
****  Data Arrays   ****
***************************/

// This data array is the most likely direction for the path searching
// Has been modified - this comment needs updating
// destx-orgx > 0 and desty-orgy > 0
// destx-orgx > 0 and desty-orgy < 0
// destx-orgx > 0 and desty-orgy = 0
// destx-orgx < 0 and desty-orgy > 0
// destx-orgx < 0 and desty-orgy < 0
// destx-orgx < 0 and desty-orgy = 0
// destx-orgx = 0 and desty-orgy > 0
// destx-orgx = 0 and desty-orgy < 0
const  enum  Direction   DirArray[8][6] = {
    { SOUTHEAST, EAST, SOUTHWEST, NORTHEAST, WEST, NORTHWEST },
    { NORTHEAST, EAST, NORTHWEST, SOUTHEAST, WEST, SOUTHWEST },
    { EAST, SOUTHEAST, NORTHEAST, NORTHWEST, SOUTHWEST, WEST },
    { SOUTHWEST, WEST, SOUTHEAST, NORTHWEST, EAST, NORTHEAST },
    { NORTHWEST, WEST, NORTHEAST, SOUTHWEST, EAST, SOUTHEAST },
    { WEST, SOUTHWEST, NORTHWEST, NORTHEAST, SOUTHEAST, EAST },
    { SOUTHEAST, SOUTHWEST, WEST, EAST, NORTHWEST, NORTHEAST },
    { NORTHWEST, NORTHEAST, EAST, WEST, SOUTHEAST, SOUTHWEST }
};


// And this array turns the direction into a corresponding string
const  char DirString[6][10] = {
        "EAST",
        "SOUTHEAST",
        "SOUTHWEST",
        "WEST",
        "NORTHWEST",
        "NORTHEAST"
};


// This array returns the mode in a corresponding string
const  char ModeString[9][15] = {
        "NO CITY",
        "EXPLORE",
        "SEARCH",
        "CONQUER",
        "SUPPORT",
        "ATTACK",
        "DEFEND",
        "OUTNUMBERED",
        "TAKEN"
};


// This array returns the unit type in a corresponding string
const  char UnitString[13][15] = {
        "RIFLE",
        "ARMOR",
        "AIRCAV",
        "BOMBER",
        "FIGHTER",
        "TRANSPORT",
        "SUB",
        "DESTROYER",
        "CRUISER",
        "BATTLESHIP",
        "CARRIER",
        "MILITIA",
        "CITY"
};


// The following are the preference lists for unit types.  The
//  Governors use these lists to select which unit type to 
//  request.
//  NOTE:  The first type in the list MUST be a type that is
//  always enabled - i.e. no Bombers, Aircav, Armor, Mines.
//  The selection routine defaults to the first in the list
//  if a decision can't be made.  We don't want to build units
//  that aren't allowed in the current game.
// Multiple instances of a unit type in a single prefs list may
//	be used to prevent the 'same unit type' bonus from being
//	lost by small chance units at the end of a list.
// I've used repeats of unit types, with 100 chances for each, at
//      the ends of the prefs.  The utility of this is that any
//      unit types that aren't allowed will be skipped over.  So,
//      we may not reach '100' at the last unit type (if trying
//      to have all the choices add up to exactly 100).  There 
//      are more than one as they too might be types that are
//      not allowed.

const  struct GovPrefs AI5_CITY_DEF_AIR = {
  {RIFLE, FIGHTER, BOMBER, -1, -1, -1, -1, -1, -1, -1},
  {0, 100, 100, 0, 0, 0, 0, 0, 0 ,0 }
};

const  struct GovPrefs AI5_CITY_DEF_SEA = {
  {TRANSPORT, DESTROYER, CRUISER, BATTLESHIP, DESTROYER, CRUISER, 
   BATTLESHIP, -1, -1, -1},
  {0, 60, 35, 5, 100, 100, 100, 0, 0, 0}
};

const  struct GovPrefs AI5_CITY_SEARCH_FIRST = {
  {RIFLE, FIGHTER, BOMBER, FIGHTER, BOMBER, -1, -1, -1, -1, -1},
  {0, 75, 25, 100, 100, 0, 0, 0, 0, 0}
};

const  struct GovPrefs AI5_CITY_SUPPORT_SEA = {
  {TRANSPORT, DESTROYER, SUB, CRUISER, BATTLESHIP, CARRIER, -1, -1, -1, -1},
  {15, 25, 25, 15, 10, 10, 0, 0, 0, 0}
};

const  struct GovPrefs AI5_CITY_SUPPORT_LAND = {
  {RIFLE, ARMOR, FIGHTER, BOMBER, AIRCAV, -1, -1, -1, -1, -1},
  {20, 20, 20, 20, 20, 0, 0, 0, 0, 0}
};


const  struct GovPrefs AI5_ISLE_DEF_OWN = {
  {TRANSPORT, FIGHTER, BOMBER, AIRCAV, FIGHTER, BOMBER, AIRCAV, -1, -1, -1},
  {0, 60, 30, 10, 100, 100, 100, 0, 0, 0}
};

const  struct GovPrefs AI5_ISLE_DEF_AIR = {
  {RIFLE, FIGHTER, BOMBER, AIRCAV, FIGHTER, BOMBER, AIRCAV, -1, -1, -1},
  {0, 60, 30, 10, 100, 100, 100, 0, 0, 0}
};

const  struct GovPrefs AI5_ISLE_DEF_SEA = {
  {TRANSPORT, DESTROYER, SUB, CRUISER, BATTLESHIP, CARRIER, DESTROYER, SUB,
   CRUISER, BATTLESHIP},
  {0, 40, 40, 10, 5, 5, 100, 100, 100, 100}
};

const  struct GovPrefs AI5_ISLE_SEARCH_FIRST = {
  {TRANSPORT, FIGHTER, BOMBER, AIRCAV, -1, -1, -1, -1, -1, -1},
  {0, 100, 100, 100, 0, 0, 0, 0, 0, 0}
};

const  struct GovPrefs AI5_ISLE_SEARCH_OWN = {
  {TRANSPORT, AIRCAV, -1, -1, -1, -1, -1, -1, -1, -1},
  {0, 100, 0, 0, 0, 0, 0, 0, 0, 0}
};

const  struct GovPrefs AI5_ISLE_SEARCH_AIR = {
  {RIFLE, FIGHTER, BOMBER, -1, -1, -1, -1, -1, -1, -1},
  {0, 100, 100, 0, 0, 0, 0, 0, 0, 0}
};

const  struct GovPrefs AI5_ISLE_SUPPORT = {
  {TRANSPORT, FIGHTER, BOMBER, AIRCAV, DESTROYER, SUB, CRUISER, BATTLESHIP,
   CARRIER, BOMBER},
  {0, 20, 20, 10, 20, 15, 5, 5, 5, 100}
};

const  struct GovPrefs AI5_TRANS_ATTACK = {
  {RIFLE, ARMOR, DESTROYER, SUB, CRUISER, ARMOR, DESTROYER, SUB, CRUISER, -1},
  {50, 30, 10, 5, 5, 100, 100, 100, 100, 0}
};

const  struct GovPrefs AI5_TRANS_DEFEND = {
  {TRANSPORT, DESTROYER, SUB, CRUISER, DESTROYER, SUB, CRUISER, -1, -1, -1},
  {0, 40, 40, 20, 100, 100, 100, 0, 0, 0}
};

const  struct GovPrefs AI5_CARR_ATT_SEA = {
  {TRANSPORT, FIGHTER, AIRCAV, DESTROYER, SUB, CRUISER, FIGHTER, DESTROYER, 
   SUB, CRUISER},
  {0, 40, 10, 30, 15, 5, 100, 100, 100, 100}
};

const  struct GovPrefs AI5_CARR_ATT_AIR = {
  {RIFLE, FIGHTER, AIRCAV, FIGHTER, AIRCAV, -1, -1, -1, -1, -1},
  {0, 75, 25, 100, 100, 0, 0, 0, 0, 0}
};

const  struct GovPrefs AI5_BATT_ATTACK = {
  {TRANSPORT, DESTROYER, SUB, CRUISER, DESTROYER, SUB, CRUISER, -1, -1, -1},
  {0, 50, 25, 25, 100, 100, 100, 0, 0, 0}
};



// These are old - pre version 11.  Left in as guides only.
const  struct GovPrefs EXPLORE_PREFS = {
        {FIGHTER, BOMBER, FIGHTER, -1, -1, -1, -1, -1, -1, -1},
        {20, 30, 50, 0, 0, 0, 0, 0, 0, 0}
};

const  struct GovPrefs DEFEND_LAND_PREFS = {
        {RIFLE, ARMOR, FIGHTER, BOMBER, AIRCAV, -1, -1, -1, -1, -1},
        {30, 30, 15, 15, 10, 0, 0, 0, 0, 0}
};

const  struct GovPrefs DEFEND_PORT_PREFS = {
        {RIFLE, ARMOR, FIGHTER, BOMBER, DESTROYER, SUB, CRUISER, -1, -1, -1},
        {10, 15, 25, 20, 15, 10, 5, 0, 0, 0}
};

const  struct GovPrefs SEARCH_PORT_PREFS = {
		{RIFLE, AIRCAV, ARMOR, FIGHTER, TRANSPORT, DESTROYER, RIFLE, -1, -1, -1},
		{0, 20, 10, 10, 10, 40, 10, 0, 0, 0}
};

const  struct GovPrefs SEARCH_PREFS = {
		{RIFLE, ARMOR, AIRCAV, BOMBER, FIGHTER, RIFLE, -1, -1, -1, -1},
		{10, 20, 20, 10, 10, 30, 0, 0, 0, 0}
};


// This is a cute one - build Armor if you can, if not, build Infantry. Simple.
const  struct GovPrefs CONQUER_LAND_PREFS = {
        {RIFLE, ARMOR, -1, -1, -1, -1, -1, -1, -1, -1},
        {0, 100, 0, 0, 0, 0, 0, 0, 0, 0}
};

// FIGHTER is here so I will build something, even if AIRCAV are
//	not available
const  struct GovPrefs CONQUER_AIR_PREFS = {
        {FIGHTER, AIRCAV, -1, -1, -1, -1, -1, -1, -1, -1},
        {0, 100, 0, 0, 0, 0, 0, 0, 0, 0}
};

const  struct GovPrefs CONQUER_SEA_PREFS = {
		{TRANSPORT, AIRCAV, -1, -1, -1, -1, -1, -1, -1, -1},
		{0, 100, -1, -1, -1, -1, -1, -1, -1, -1}
};

const  struct GovPrefs CONQUER_AIR2_PREFS = {
        {FIGHTER, BOMBER, -1, -1, -1, -1, -1, -1, -1, -1},
        {60, 40, 0, 0, 0, 0, 0, 0, 0, 0}
};

const  struct GovPrefs CONQUER_SEA2_PREFS = {
		{TRANSPORT, DESTROYER, SUB, CRUISER, TRANSPORT, -1, -1, -1, -1, -1},
		{0, 35, 25, 10, 30, -1, -1, -1, -1, -1}
};

const  struct GovPrefs OUTNUMBERED_SEA_PREFS = {
		{FIGHTER, BOMBER, SUB, -1, -1, -1, -1, -1, -1, -1},
		{40, 30, 30, -1, -1, -1, -1, -1, -1, -1}
};

const  struct GovPrefs OUTNUMBERED_LAND_PREFS = {
		{RIFLE, ARMOR, FIGHTER, BOMBER, RIFLE, -1, -1, -1, -1, -1},
		{40, 20, 10, 10, 20, -1, -1, -1, -1, -1}
};

const  struct GovPrefs SUPPORT_SEA_PREFS = {
		{FIGHTER, BOMBER, SUB, DESTROYER, CRUISER, TRANSPORT,
			BATTLESHIP, CARRIER, -1, -1},
		{10, 15, 20, 20, 10, 15, 5, 5, -1, -1}
};

const  struct GovPrefs SUPPORT_LAND_PREFS = {
		{RIFLE, ARMOR, FIGHTER, BOMBER, RIFLE, AIRCAV, -1, -1, -1, -1},
		{0, 25, 20, 20, 25, 10, -1, -1, -1, -1}
};

const  struct GovPrefs ATTACK_LAND_PREFS = {
        {RIFLE, ARMOR, -1, -1, -1, -1, -1, -1, -1, -1},
        {0, 100, 0, 0, 0, 0, 0, 0, 0, 0}
};

// No aircav?  Build fighters
const  struct GovPrefs ATTACK_AIR_PREFS = {
        {FIGHTER, AIRCAV, -1, -1, -1, -1, -1, -1, -1, -1},
        {0, 100, 0, 0, 0, 0, 0, 0, 0, 0}
};

const  struct GovPrefs ATTACK_SEA_PREFS = {
		{TRANSPORT, AIRCAV, -1, -1, -1, -1, -1, -1, -1, -1},
		{0, 100, -1, -1, -1, -1, -1, -1, -1, -1}
};

const  struct GovPrefs ATTACK_AIR2_PREFS = {
        {FIGHTER, BOMBER, -1, -1, -1, -1, -1, -1, -1, -1},
        {55, 45, 0, 0, 0, 0, 0, 0, 0, 0}
};

const  struct GovPrefs ATTACK_SEA2_PREFS = {
		{TRANSPORT, DESTROYER, SUB, CRUISER, TRANSPORT, -1, -1, -1, -1, -1},
		{0, 30, 30, 30, 10, -1, -1, -1, -1, -1}
};


//  This next batch of data arrays helps make sure we don't change 
//      production too fast - it sets a lower limit, or bounds, on
//      the number of turns remaining of each type to prevent us from
//      changing production during that time due to a change in the
//      owning governor's mode.  Prevents us from throwing away a 
//      battleship with two turns remaining on it, for example.
//      Suggested by Lorne, end of Feb, 96

const   int GENERAL_MIN_TURNS[13] = {
    1, 2, 3, 3, 3, 5, 5, 5, 5, 10, 10, 1, 1};

