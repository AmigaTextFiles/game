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

#include <cassert>
#include <cmath>


// Application Includes
#include "audio.h"
#include "properties.h"
#include "tiles.h"
#include "graph.h"
#include "gamelogic.h"
#include "sound_files.h"

//#define DEBUG_FUNC

Ctile_teleport::Ctile_teleport( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_teleport::constructor( )" << endl;
#endif
	exitFlags = 0;
}

Ctile_teleport::Ctile_teleport( int dir )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_teleport::constructor( )" << endl;
#endif
	exitFlags = dir;
}

Ctile_teleport::~Ctile_teleport( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_teleport::destructor( )" << endl;
#endif
}

void
Ctile_teleport::draw_under( int ulX, int ulY )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_teleport::draw_under( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif

	// Call the generic background draw thingy
	draw_start_background( ulX, ulY );

	if( exitFlags & EXIT_UP )
	{
		graphDriver->graph_draw_perm( BMP_TRACK_U, 0, 0, ulX, ulY, 64, 64 );
	}
	if( exitFlags & EXIT_DOWN )
	{
		graphDriver->graph_draw_perm( BMP_TRACK_D, 0, 0, ulX, ulY, 64, 64 );
	}
	if( exitFlags & EXIT_LEFT )
	{
		graphDriver->graph_draw_perm( BMP_TRACK_L, 0, 0, ulX, ulY, 64, 64 );
	}
	if( exitFlags & EXIT_RIGHT )
	{
		graphDriver->graph_draw_perm( BMP_TRACK_R, 0, 0, ulX, ulY, 64, 64 );
	}
}

void
Ctile_teleport::draw_balls( int ulX, int ulY )
{
	simple_draw_balls( ulX, ulY );
}

void
Ctile_teleport::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_teleport::draw_under( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif

	// Draw the base
	graphDriver->graph_draw( BMP_TELEPORT_BASE, ulX, ulY );

	if( (exitFlags & EXIT_UP )
	|| ( exitFlags & EXIT_DOWN ) )
	{
		graphDriver->graph_draw( BMP_TELEPORT_UD, ulX, ulY );
	}

	if( (exitFlags & EXIT_LEFT )
	||( exitFlags & EXIT_RIGHT ) )
	{
		graphDriver->graph_draw( BMP_TELEPORT_LR, ulX, ulY );
	}
}

void
Ctile_teleport::move_balls( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_teleport::move_balls( )" << endl;
#endif
	float	xcoord		= 0;
	float	ycoord		= 0;
	float	offset		= 0;
	int		status		= 0;
	dir_t	dir			= UP;
	float	overShoot	= 0;
	int		halfTile	= CURMAP->tileSize / 2;
	list< Cball * >::iterator it;
	int 	telePort	= 0;
	Ctile * tempTele = NULL;


	// Bail if there are no balls here
	if( balls.empty( ) )
	{
		return;
	}

	it = balls.begin( );

	while( it != balls.end( ) )
	{
		// Reset our vars
		telePort = 0;
		offset = 0;
		overShoot = 0;

		// Get the direction the ball is moving in
		dir = (*it)->get_direction( );

		// Get the ball's coordinates
		(*it)->get_coordinates( &xcoord, &ycoord);

		// Clear the no move flag if it's set
		if( (*it)->check_no_move( ) )
		{
			(*it)->clear_no_move( );
			it++;
		} else {
			// Find out if the ball is going to cross the mid point of
			// the tile.
			switch( dir )
			{
			case UP:
				// Will we cross the mid point? here?
				if( (ycoord <= halfTile) && (*it)->doMidPoint)
				{
					// Ball will cross the midpoint this iteration
					overShoot = fabs( ycoord - CURMAP->ballSpd - halfTile );
					telePort = 1;

					(*it)->doMidPoint = false;
					break;
				}
				// Keep going UP 
				ycoord = ycoord - CURMAP->ballSpd;
				if (ycoord > CURMAP->tileSize) ycoord = CURMAP->tileSize - 1;
				offset = ycoord;
				break;
			case DOWN:
				if( (ycoord >= halfTile) && (*it)->doMidPoint)
				{
					// Ball will cross the midpoint this iteration
					overShoot = fabs( ycoord + CURMAP->ballSpd - halfTile );
					telePort = 1;

					(*it)->doMidPoint = false;
					break;
				}

				// Keep going DOWN 
				ycoord = ycoord + CURMAP->ballSpd;
				if (ycoord < 0) ycoord = 0;
				offset = ycoord - CURMAP->tileSize;
				break;
			case LEFT:
				if( (xcoord <= halfTile) && (*it)->doMidPoint)
				{
					// Ball will cross the midpoint this iteration
					overShoot = fabs( ycoord - CURMAP->ballSpd - halfTile );
					telePort = 1;

					(*it)->doMidPoint = false;
					break;
				}
				// Keep going left
				xcoord = xcoord - CURMAP->ballSpd;
				if (xcoord > CURMAP->tileSize) xcoord = CURMAP->tileSize - 1;
				offset = xcoord;
				break;
			case RIGHT:
				if( (xcoord >= halfTile) && (*it)->doMidPoint)
				{
					// Ball will cross the midpoint this iteration
					overShoot = fabs( xcoord + CURMAP->ballSpd - halfTile );
					telePort = 1;

					(*it)->doMidPoint = false;
					break;
				}

				// Keep going right 
				xcoord = xcoord + CURMAP->ballSpd;
				if (xcoord < 0) xcoord = 0;
				offset = xcoord - CURMAP->tileSize;
				break;
			default:
				break;
			}

			// Did we teleport?
			if( telePort )
			{
				// play teleport sound effect
				audioDriver->play_sound( soundFiles[SOUND_TELEPORT] );

				// Get the other teleporter for this direction
				// ( since we'd have to be going in this direction
				// to have teleported )
				tempTele = CURMAP->find_teleport_with_dir( this, dir );

				// Add the ball to it
				status = tempTele->add_ball( *it, (dir_t)(dir + PENDING_UP), 0 );
				assert( status > 0 );
				(*it)->doMidPoint = false;

				// Erase the ball from this teleporter
				it = balls.erase( it );
				continue;
			}
			// See if we're out of bounds
			if(	( xcoord < 0 ) || ( xcoord > CURMAP->tileSize - 1 )
			||  ( ycoord < 0 ) || ( ycoord > CURMAP->tileSize - 1 ) )
			{ 
				// Time to pass the ball to the next tile
				status = pass_ball( *it, dir, (int)offset );

				// Uh oh - it bounced back
				if( ! status )
				{
					audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
					switch( dir )
					{
					case UP:
						(*it)->set_direction( DOWN );
						(*it)->set_coordinates( xcoord, offset);
						break;
					case DOWN:
						(*it)->set_direction( UP );
						(*it)->set_coordinates( xcoord, 
								CURMAP->tileSize - offset);
						break;
					case LEFT:
						(*it)->set_direction( RIGHT );
						(*it)->set_coordinates( offset, ycoord);
						break;
					case RIGHT:
						(*it)->set_direction( LEFT );
						(*it)->set_coordinates( 
							CURMAP->tileSize - offset, ycoord);
						break;
					default:
						break;
					}
					// when a ball bounces on a teleporter tile, we need to
					// redo the midpoint check
					(*it)->doMidPoint = true;
					it++;
				} else {
					delete *it;
					it = balls.erase( it );
				}
			} else {
				// Nope - move along - nothing to see here.
				(*it)->set_coordinates( xcoord, ycoord);
				it++;
			}
		}
	}
}
// $Id: tile_teleport.cpp,v 1.6 2001/08/01 00:57:56 tom Exp $
//
// $Log: tile_teleport.cpp,v $
// Revision 1.6  2001/08/01 00:57:56  tom
// added include of cassert header file
//
// Revision 1.5  2001/03/31 09:23:34  tom
// fixed ball disappearing bug as a result of fluctuating frame rates
//
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
// Revision 1.2  2001/02/16 21:00:10  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:36  brown
// Working toward Windows integration
//
// Revision 1.9  2000/11/19 03:54:31  brown
// Ach-Ha!  Fixed the last of the bugs ( har! )
//
// Revision 1.8  2000/11/19 03:44:07  brown
// Hmm.
//
// Revision 1.7  2000/11/19 03:41:57  brown
// More changes -fixed teleporter
//
// Revision 1.6  2000/11/18 22:38:58  tom
// fixed some memory leaks and changed some stuff to try to track down the
// disappearing ball phenomenon.
//
// Revision 1.5  2000/10/25 16:45:25  brown
// Updated to build on vanilla RedHat 7.0
//
// Revision 1.4  2000/10/07 18:16:35  brown
// Ball movement fixes
//
// Revision 1.3  2000/10/06 19:29:13  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.2  2000/10/01 05:00:27  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.1.1.1  2000/09/28 02:17:53  tom
// imported sources
//
// Revision 1.10  2000/03/27 05:18:22  tom
// Added teleport sound effect.
//
// Revision 1.9  2000/02/21 23:06:37  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.8  2000/01/10 02:53:50  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.7  1999/12/27 03:38:03  brown
// Fixed teleporters I hope - updated graphics etc
//
// Revision 1.6  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
