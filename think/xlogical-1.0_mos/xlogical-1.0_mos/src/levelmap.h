//////////////////////////////////////////////////////////////////////
// XLogical - A puzzle game
//
// Copyright (C) 2000 Neil Brown, Tom Warkentin
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
// or at the website: http://www.gnu.org
//
////////////////////////////////////////////////////////////////////////



// vim:ts=4
#ifndef MAP_H
#define MAP_H

// Language Includes
#include <ctime>
#include <vector>

#ifdef WIN32
using namespace std;
#endif

// Application Includes
#include "defs.h"
#include "tiles.h"

class Clevel_map
{
public:
	char	*mapName;			// Name of this map
	int		xSize; 				// Number of tiles on the x axis
	int		ySize;				// Number of tiles on the y axis
	int		tileSize;			// For scaling down the tiles on large maps
	int		ballSize;			// For scaling down the ball on large maps
	int		maxBallsInMotion;	// Number of balls that can be moving
	int		startPathActive;	// Number of balls that can be moving
	color_t	nextColor;			// Next color to pop up
	ulong	startTime;			// Snapshot of start time for this level
	ulong	ballStartTime;		// Snapshot of start time for current ball
	ulong	ballTimeLimit;		// Time limit per ball
	ulong	mapTimeLimit;		// Time limit for the map
	vector< Ctile * > tiles;	// The map laid out row-major
	int		ballSpdPct;			// percent of max ball speed
	float	ballSpd;			// Current ball speed
	ulong	nextPatternTime;	// time when random pattern should be calculated
	ulong	patternWaitTime;	// number of seconds for next pattern
	int		bgPixmap;			// Background image
	int		spinnersOnMap;		// Number of spinners in this map.
	int		spinnersFinished;	// Number of spinners we've finished on this map
	int		startTile;			// Index of the tile we start balls from
	int		haveBallTimer;		// If we have a ball timer tile
	int		haveMapTimer;		// If we have a map timer tile

	// Pattern you must fill the spinners with
	color_t spinnerPattern[4];	// saved from map level
	color_t pattern[4];			// working area (gets cleared and reset)

	// Do we want to change the pattern every time 
	// the current pattern is matched?
	int randPattern;

	// Order of the colors you must fill the spinners with
	color_t order[4];

	// Do we want to keep updating the order and adding
	// more colors so that the player has no choice?
	int randOrder;

	char * load_level(		char * );

	// Reset the level
	void reset(				void );

	// Move a ball if we can.  Returns 1 if we're at max
	void move_ball(			void ) { numBallsInMotion++; }

	// Stop a ball
	void stop_ball(			void ) { numBallsInMotion--; }

	// How many moving balls?
	int get_moving_balls(	void ) { return( numBallsInMotion ); }

	// Can we move another ball?
	int can_move_ball( 		void ) { return( numBallsInMotion < 5 ); }

	// restores/calculates spinner pattern
	void new_pattern(		void );

	// returns the map name
	char * get_map_name(	void ) { return( mapName ); }

	// Finds the matching teleport tile
	Ctile_teleport * find_teleport_with_dir( Ctile_teleport *, dir_t );

	// Constructors
	Clevel_map(				void );
	Clevel_map(				char * );

	// Destructors
	~Clevel_map( );

private:
	int numBallsInMotion;	// Number of balls currently moving
	void base_init(			void );
	char * parse_map(		char * ); 
	void read_color_block(	char **, color_t [], int );
	void read_ball_colors(	char ** );
	void post_process_map(	void ); 
	void read_map(			char ** );

};

#endif
// $Id: levelmap.h,v 1.7 2001/08/01 00:57:15 tom Exp $
//
// $Log: levelmap.h,v $
// Revision 1.7  2001/08/01 00:57:15  tom
// changed time variables to be unsigned
//
// Revision 1.6  2001/07/31 20:54:55  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
//
// Revision 1.5  2001/02/16 20:59:56  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.4  2001/01/20 17:32:28  brown
// Working toward Windows integration
//
// Revision 1.3  2000/10/07 18:16:34  brown
// Ball movement fixes
//
// Revision 1.2  2000/10/06 19:29:06  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.19  2000/01/09 02:26:17  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.18  2000/01/01 21:51:19  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.17  1999/12/27 03:38:01  brown
// Fixed teleporters I hope - updated graphics etc
//
// Revision 1.16  1999/12/25 08:18:34  tom
// Added "Id" and "Log" CVS keywords to source code.
//
