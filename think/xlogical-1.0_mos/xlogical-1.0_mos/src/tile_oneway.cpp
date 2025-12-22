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

#include <cmath>



// Application Includes
#include "audio.h"
#include "properties.h"
#include "tiles.h"
#include "graph.h"
#include "gamelogic.h"
#include "sound_files.h"

//#define DEBUG_FUNC

Ctile_oneway::Ctile_oneway( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_oneway::constructor( )" << endl;
#endif
	exitFlags = 0l;
	oneWayDir = UP;
}

Ctile_oneway::Ctile_oneway( unsigned long flags, dir_t oneWay )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_oneway::constructor( long )" << endl;
#endif
	exitFlags = flags;
	oneWayDir = oneWay;
}

Ctile_oneway::~Ctile_oneway( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_oneway::destructor( )" << endl;
#endif
}

void
Ctile_oneway::move_balls( void )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_oneway::move_balls( )" << endl;
#endif

	float	xcoord		= 0;
	float	ycoord		= 0;
	float	overShoot	= 0;
	dir_t	dir			= UP;
	int		halfTile	= CURMAP->tileSize / 2;
	int 	overHalf	= 0;
	list< Cball * >::iterator it;

	// Bail if there are no balls here
	if( balls.empty( ) )
	{
		return;
	}

	it = balls.begin( );

	while( it != balls.end( ) )
	{
		// Clear the no move flag if it's set
		if( (*it)->check_no_move( ) )
		{
			(*it)->clear_no_move( );
			it++;
		} else {

			// Get the direction the ball is moving in
			dir = (*it)->get_direction( );

			// Get the ball's coordinates
			(*it)->get_coordinates( &xcoord, &ycoord);

			// Reset our flag
			overHalf = 0;

			// Find out if the ball is going to cross the mid point of
			// the tile.
			switch( dir )
			{
			case UP:
				if( (ycoord <= halfTile ) && (*it)->doMidPoint)
				{
					overShoot = fabs( ycoord - CURMAP->ballSpd - halfTile );
					overHalf = 1;
				}
				break;
			case DOWN:
				if( (ycoord >= halfTile ) && (*it)->doMidPoint)
				{
					overShoot = fabs( ycoord + CURMAP->ballSpd - halfTile );
					overHalf = 1;
				}
				break;
			case LEFT:
				if( (xcoord <= halfTile ) && (*it)->doMidPoint)
				{
					overShoot = fabs( ycoord - CURMAP->ballSpd - halfTile );
					overHalf = 1;
				}
				break;
			case RIGHT:
				if( (xcoord >= halfTile ) && (*it)->doMidPoint)
				{
					overShoot = fabs( xcoord + CURMAP->ballSpd - halfTile );
					overHalf = 1;
				}
				break;
			default:
				break;
			}

			// Will we go over the halfway point after this move?
			if( overHalf )
			{
				// Move the ball manually since we know what to do
				switch( oneWayDir )
				{
				case UP:
					//exitFlags = EXIT_UP;
					xcoord = halfTile;
					ycoord = halfTile - overShoot;
					break;
				case DOWN:
					//exitFlags = EXIT_DOWN;
					xcoord = halfTile;
					ycoord = halfTile + overShoot;
					break;
				case LEFT:
					//exitFlags = EXIT_LEFT;
					xcoord = halfTile - overShoot;
					ycoord = halfTile;
					break;
				case RIGHT:
					//exitFlags = EXIT_RIGHT;
					xcoord = halfTile + overShoot;
					ycoord = halfTile;
					break;
				default:
					break;
				}
				audioDriver->play_sound( soundFiles[SOUND_ONE_WAY] );
				(*it)->set_coordinates( xcoord, ycoord );
				(*it)->set_direction( oneWayDir );
				(*it)->doMidPoint = false;
				it++;

			} else {

				// Move the ball with the base class functions
				if( move_a_ball( **it ) == 1 )
				{
					// It left the tile, remove it
					delete *it;
					it = balls.erase( it );
				} else {
					// Move on
					it++;
				}
			}
		}
	}
}

void
Ctile_oneway::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_oneway::draw_over( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	int pm = -1;
	
	// Draw the base for the oneway
	graphDriver->graph_draw( BMP_NEXT_BASE, ulX, ulY );

	// Now draw the oneway
	switch( oneWayDir )
	{
	case UP:
		pm = BMP_ARROW_U;
		break;
	case DOWN:
		pm = BMP_ARROW_D;
		break;
	case LEFT:
		pm = BMP_ARROW_L;
		break;
	case RIGHT:
		pm = BMP_ARROW_R;
		break;
	default:
		break;
	}

	graphDriver->graph_draw( pm, ulX + 23, ulY + 23 );
}
// $Id: tile_oneway.cpp,v 1.4 2001/03/15 09:54:50 tom Exp $
//
// $Log: tile_oneway.cpp,v $
// Revision 1.4  2001/03/15 09:54:50  tom
// Changed code to set/check the doMidPoint flag on balls as they cross
// the tiles.  Trying to calculate when the mid point check should be done
// resulted in some occasional slip ups where sometimes a tile would not do
// the appropriate mid point action (e.g. painter would miss a ball, blocker
// would let the wrong colored ball through, one-way wouldn't redirect a ball
// in a different direction, teleporter would miss a ball, etc.).
//
// Revision 1.3  2001/02/19 03:03:57  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.2  2001/02/16 21:00:07  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:35  brown
// Working toward Windows integration
//
// Revision 1.9  2000/11/19 03:23:48  brown
// Fixed lost ball bug - found teleporter bug but it's not fixed yet
//
// Revision 1.8  2000/11/18 23:33:00  tom
// put back default switch cases and removed a debug statement
//
// Revision 1.7  2000/11/18 22:38:58  tom
// fixed some memory leaks and changed some stuff to try to track down the
// disappearing ball phenomenon.
//
// Revision 1.6  2000/10/25 16:45:24  brown
// Updated to build on vanilla RedHat 7.0
//
// Revision 1.5  2000/10/08 02:53:49  brown
// Fixed the level editor and some graphics
//
// Revision 1.4  2000/10/07 18:16:34  brown
// Ball movement fixes
//
// Revision 1.3  2000/10/06 19:29:12  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.2  2000/10/01 05:00:26  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.4  2000/03/28 07:31:10  tom
// Added calls to play more sound effects.
//
// Revision 1.3  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
