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




#ifndef DEFS_H
#define DEFS_H

#define Number(array) ((sizeof(array)/sizeof(array[0])))
#define CURMAP (*(currentGame->currentMap))

typedef enum 
{
	UP = 0,
	DOWN,
	LEFT,
	RIGHT,
	STOPPED,
	PENDING_UP,
	PENDING_DOWN,
	PENDING_LEFT,
	PENDING_RIGHT
} dir_t;


typedef enum {
	FILL_NONE = 0,
	FILL_COMPLETED,
	FILL_SOLID,
	FILL_ORDER,
	FILL_PATTERN
} fill_t;


typedef enum 
{
	NO_COLOR = 0,
	C1,
	C2,
	C3,
	C4,
	C5,
	MAX_COLORS
} color_t;

typedef enum
{
	BLANK_TILE = 0,
	PATTERN_DISP,
	ORDER_DISP,
	NEXT_DISP,
	TIME_DISP,
	MOVE_COUNTER,
	START,
	TRACK,
	SPINNER,
	PAINTER,
	BLOCKER,
	TELEPORT,
	BALL_TIMER,
	ONEWAY,
	COVERED,
	NUM_TILE_TYPES
} tile_t;

// Tile flags
#define EXIT_UP		( 1<<0 )
#define EXIT_DOWN	( 1<<1 )
#define EXIT_LEFT	( 1<<2 )
#define EXIT_RIGHT	( 1<<3 )

#define REVERSE_DIR(d) (d==LEFT?RIGHT:(d==RIGHT?LEFT:(d==UP?DOWN:UP)))

// Drawing flags
#define USE_MASK	( 1<<0 )

typedef void( *void_func)(void);

#define NUMCOLS_MAX 10
#define NUMROWS_MAX 7

// SCORING
#define SOLID_POINTS	200
#define ORDER_POINTS	300
#define PATTERN_POINTS	400

#define PLAYWIDTH 640
#define PLAYHEIGHT 497

#define BALL_SPEED_MAX 15.0

typedef unsigned long ulong;

const ulong kTicksInSecond	= 1000;

#if defined(WIN32)
#include <cstring>
inline
int strcasecmp( const char *string1, const char *string2 )
{
	return( _stricmp( string1, string2 ) );
}

#define PATHSEP "\\"

#else
// !WIN32
#define PATHSEP "/"
#endif

#endif

// $Id: defs.h,v 1.8 2001/07/31 20:54:51 tom Exp $
//
// $Log: defs.h,v $
// Revision 1.8  2001/07/31 20:54:51  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
//
// Revision 1.7  2001/02/17 07:18:21  tom
// got xlogical working in windows finally - with the following limitations:
// - music is broken (disabled in this checkin)
// - no user specified mod directories for in game music
// - high scores will be saved as user "nobody"
//
// Revision 1.6  2001/02/16 20:59:52  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.5  2000/10/08 02:53:47  brown
// Fixed the level editor and some graphics
//
// Revision 1.4  2000/10/07 19:26:20  brown
// Added BALL_SPEED_PCT to the parser
// Fixed debug info output
//
// Revision 1.3  2000/10/07 19:12:18  brown
// Speed-throttling code completed
//
// Revision 1.2  2000/10/06 19:29:04  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.12  2000/01/09 02:26:16  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.11  2000/01/05 03:47:32  brown
// Fixed some endgame stuff, scrollers, and hi-score menu entry goodies
//
// Revision 1.10  2000/01/01 21:51:18  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.9  1999/12/27 03:38:00  brown
// Fixed teleporters I hope - updated graphics etc
//
// Revision 1.8  1999/12/25 08:18:33  tom
// Added "Id" and "Log" CVS keywords to source code.
//
