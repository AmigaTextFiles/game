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



// Application Includes
#include "tiles.h"
#include "graph.h"
#include "gamelogic.h"

//#define DEBUG_FUNC

Ctile_timer::Ctile_timer( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_timer::constructor( )" << endl;
#endif
}

Ctile_timer::~Ctile_timer( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_timer::destructor( )" << endl;
#endif
}

void
Ctile_timer::draw_under( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_timer::draw_under( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	
	graphDriver->graph_draw_perm( BMP_TIMER, 0, 0, ulX, ulY, 64, 64 );
}

void
Ctile_timer::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_timer::draw_over( )" << endl;
#endif
	ulong timeNow = graphDriver->graph_get_time();
	ulong timeLeft = 0;
	int minutes = 0;
	int seconds = 0;
	int milis = 0;
	int tMinutes = 0;
	int oMinutes = 0;
	int tSeconds = 0;
	int oSeconds = 0;
	static ulong lastMenuTime = 0;

	// don't show time if we're paused
	if( lastMenuTime != gMenuEntryTime )
	{
		return;
	} else {
		lastMenuTime = gMenuEntryTime;
	}

	if (gMenuEntryTime != 0)
	{
		timeLeft = CURMAP->startTime + CURMAP->mapTimeLimit - timeNow + (timeNow - gMenuEntryTime);
	} else {
		timeLeft = CURMAP->startTime + CURMAP->mapTimeLimit - timeNow;
	}

	minutes = (timeLeft / kTicksInSecond) / 60;
	tMinutes = minutes / 10;
	oMinutes = minutes % 10;
	seconds = (timeLeft / kTicksInSecond) % 60;
	tSeconds = seconds / 10;
	oSeconds = seconds % 10;

	milis = (timeLeft % kTicksInSecond) / 100;

	// Draw the Minutes-Tens place
	graphDriver->graph_erase_rect( ulX, ulY, 64, 32 );

	// Draw the Minutes-Tens place
	graphDriver->graph_draw_pixmap( 
		BMP_NUMBERS, 
		9 * tMinutes,
		0,
		ulX+6, 
		ulY+8,
		9,
		12,
		USE_MASK );

	// Draw the Minutes-Ones place
	graphDriver->graph_draw_pixmap( 
		BMP_NUMBERS, 
		9 * oMinutes,
		0,
		ulX+15, 
		ulY+8,
		9,
		12,
		USE_MASK );

	// Draw the Seconds-Tens place
	graphDriver->graph_draw_pixmap( 
		BMP_NUMBERS, 
		9 * tSeconds,
		0,
		ulX+27, 
		ulY+8,
		9,
		12,
		USE_MASK );

	// Draw the Seconds-Ones place
	graphDriver->graph_draw_pixmap( 
		BMP_NUMBERS, 
		9 * oSeconds,
		0,
		ulX+36, 
		ulY+8,
		9,
		12,
		USE_MASK );

	// Draw the tenths-of-a-second
	graphDriver->graph_draw_pixmap( 
		BMP_NUMBERS, 
		9 * milis,
		0,
		ulX+48, 
		ulY+8,
		9,
		12,
		USE_MASK );
}
// $Id: tile_timer.cpp,v 1.3 2001/07/31 20:54:57 tom Exp $
//
// $Log: tile_timer.cpp,v $
// Revision 1.3  2001/07/31 20:54:57  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
//
// Revision 1.2  2001/02/16 21:00:11  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:37  brown
// Working toward Windows integration
//
// Revision 1.4  2000/10/06 19:29:13  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.3  2000/10/01 03:43:33  brown
// Added FPS counter
//
// Revision 1.2  2000/09/30 17:33:15  brown
// Fixed timer drawing and order/pattern refreshes
//
// Revision 1.1.1.1  2000/09/28 02:17:53  tom
// imported sources
//
// Revision 1.11  2000/07/23 17:47:18  brown
// Fixed the problem with matching a color order where hopper 0 could be any color
//
// Revision 1.9  2000/01/09 02:26:18  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.8  2000/01/06 02:41:58  brown
// Some font stuff.  Fixed some other intermission goodies
//
// Revision 1.7  2000/01/05 03:47:34  brown
// Fixed some endgame stuff, scrollers, and hi-score menu entry goodies
//
// Revision 1.6  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
