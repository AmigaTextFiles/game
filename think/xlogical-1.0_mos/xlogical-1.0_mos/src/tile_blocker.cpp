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
#include "gamelogic.h"
#include "graph.h"
#include "properties.h"
#include "sound_files.h"
#include "tiles.h"

//#define DEBUG_FUNC

Ctile_blocker::Ctile_blocker( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blocker::constructor( )" << endl;
#endif
}

Ctile_blocker::Ctile_blocker( color_t c, int exits )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blocker::constructor( )" << endl;
#endif
	// Set the exitFlags for this tile
	exitFlags = exits;

	// Set our pass color
	passColor = c;
}

Ctile_blocker::~Ctile_blocker( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blocker::destructor( )" << endl;
#endif
}

void
Ctile_blocker::draw_under( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blocker::draw_under( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	
	// Draw the start path stuff
	draw_start_background( ulX, ulY );

	// Draw the proper track
	switch( exitFlags )
	{
	case EXIT_UP | EXIT_DOWN:
		graphDriver->graph_draw_perm( BMP_TRACK_UD, 0, 0, ulX, ulY, 64, 64 );
		break;
	case EXIT_LEFT | EXIT_RIGHT:
		graphDriver->graph_draw_perm( BMP_TRACK_LR, 0, 0, ulX, ulY, 64, 64 );
		break;
	case EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT:
		graphDriver->graph_draw_perm( BMP_TRACK_UDLR, 0, 0, ulX, ulY, 64, 64 );
		break;
	default:
		break;
	}
}

void
Ctile_blocker::draw_balls( int ulX, int ulY )
{
	simple_draw_balls( ulX, ulY );
}

void
Ctile_blocker::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blocker::draw_over( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif

	// Draw the base for the painter
	graphDriver->graph_draw( BMP_BLOCK_BASE, ulX, ulY );
	// Now draw the paint swirl
	switch( passColor )
	{
	case C1:
		graphDriver->graph_draw( BMP_GEM_C1, ulX + 24, ulY + 24 );
		break;
	case C2:
		graphDriver->graph_draw( BMP_GEM_C2, ulX + 24, ulY + 24 );
		break;
	case C3:
		graphDriver->graph_draw( BMP_GEM_C3, ulX + 24, ulY + 24 );
		break;
	case C4:
		graphDriver->graph_draw( BMP_GEM_C4, ulX + 24, ulY + 24 );
		break;
	default:
		break;
	}
}

void
Ctile_blocker::move_balls( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blocker::move_balls" << endl;
#endif

	float	xcoord		= 0;
	float	ycoord		= 0;
	float	offset		= 0;
	int		status		= 0;
	dir_t	dir			= UP;
	float	overShoot	= 0;
	int		halfTile	= CURMAP->tileSize / 2;
	list< Cball * >::iterator it;

	// Bail if there are no balls here
	if( balls.empty( ) )
	{
		return;
	}

	it = balls.begin( );

	while( it != balls.end( ) )
	{
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
					(*it)->doMidPoint = false;

					// Ball will cross the midpoint this iteration
					overShoot = fabs( ycoord - CURMAP->ballSpd - halfTile );

					// Does the ball match our pass color?
					if( (*it)->get_color( ) != passColor )
					{
						// Nope, no match - bounce
						audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
						(*it)->set_direction( DOWN );
						xcoord = halfTile;
						ycoord = halfTile + overShoot;
						break;
					}
				}
				// Keep going UP 
				ycoord = ycoord - CURMAP->ballSpd;
				if (ycoord > CURMAP->tileSize) ycoord = CURMAP->tileSize-1;
				offset = ycoord;
				break;
			case DOWN:
				if( (ycoord >= halfTile ) && (*it)->doMidPoint)
				{
					(*it)->doMidPoint = false;

					// Ball will cross the midpoint this iteration
					overShoot = fabs( ycoord + CURMAP->ballSpd - halfTile );

					// Does the ball match our pass color?
					if( (*it)->get_color( ) != passColor )
					{
						// Nope, no match - bounce
						audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
						(*it)->set_direction( UP );
						xcoord = halfTile;
						ycoord = halfTile - overShoot;
						break;
					}
				}


				// Keep going DOWN 
				ycoord = ycoord + CURMAP->ballSpd;
				if (ycoord < 0) ycoord = 0;
				offset = ycoord - CURMAP->tileSize;
				break;
			case LEFT:
				if( (xcoord <= halfTile ) && (*it)->doMidPoint)
				{
					(*it)->doMidPoint = false;

					// Ball will cross the midpoint this iteration
					overShoot = fabs( ycoord - CURMAP->ballSpd - halfTile );

					// Does the ball match our pass color?
					if( (*it)->get_color( ) != passColor )
					{
						// Nope, no match - bounce
						audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
						(*it)->set_direction( RIGHT );
						xcoord = halfTile + overShoot;
						ycoord = halfTile;
						break;
					}
				}
				// Keep going left
				xcoord = xcoord - CURMAP->ballSpd;
				if (xcoord > CURMAP->tileSize) xcoord = CURMAP->tileSize-1;
				offset = xcoord;
				break;
			case RIGHT:
				if( (xcoord >= halfTile ) && (*it)->doMidPoint)
				{
					(*it)->doMidPoint = false;

					// Ball will cross the midpoint this iteration
					overShoot = fabs( xcoord + CURMAP->ballSpd - halfTile );

					// Does the ball match our pass color?
					if( (*it)->get_color( ) != passColor )
					{
						// Nope, no match - bounce
						audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
						(*it)->set_direction( LEFT );
						xcoord = halfTile - overShoot;
						ycoord = halfTile;
						break;
					}
				}

				// Keep going right 
				xcoord = xcoord + CURMAP->ballSpd;
				if (xcoord < 0) xcoord = 0;
				offset = xcoord - CURMAP->tileSize;
				break;
			default:
				break;
			}

			// See if we're out of bounds
			if(	( xcoord < 0 ) || ( xcoord > CURMAP->tileSize-1 )
			||  ( ycoord < 0 ) || ( ycoord > CURMAP->tileSize-1 ) )
			{ 
				// Time to pass the ball to the next tile
				status = pass_ball( *it, dir, (int)offset );

				// Uh oh - it bounced back
				if( ! status )
				{
					audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
					// A hack to make sure fluxuating ball speeds
					// don't interfere with our bouncing
					offset = offset / 2;
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
					(*it)->doMidPoint = true;
					it++;
				} else {
					delete *it;
					it = balls.erase( it );
				}
			} else {
				// Keep moving as we were
				(*it)->set_coordinates( xcoord, ycoord);
				it++;
			}
		}
	}
}
// $Id: tile_blocker.cpp,v 1.5 2001/03/31 09:23:33 tom Exp $
//
// $Log: tile_blocker.cpp,v $
// Revision 1.5  2001/03/31 09:23:33  tom
// fixed ball disappearing bug as a result of fluctuating frame rates
//
// Revision 1.4  2001/03/15 09:54:49  tom
// Changed code to set/check the doMidPoint flag on balls as they cross
// the tiles.  Trying to calculate when the mid point check should be done
// resulted in some occasional slip ups where sometimes a tile would not do
// the appropriate mid point action (e.g. painter would miss a ball, blocker
// would let the wrong colored ball through, one-way wouldn't redirect a ball
// in a different direction, teleporter would miss a ball, etc.).
//
// Revision 1.3  2001/02/19 03:03:55  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.2  2001/02/16 21:00:05  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:34  brown
// Working toward Windows integration
//
// Revision 1.7  2000/11/18 22:38:58  tom
// fixed some memory leaks and changed some stuff to try to track down the
// disappearing ball phenomenon.
//
// Revision 1.6  2000/10/25 16:45:24  brown
// Updated to build on vanilla RedHat 7.0
//
// Revision 1.5  2000/10/08 21:14:03  brown
// Fixed blocker problem
// Fixed painter tile so the right bitmaps is drawn
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
// Revision 1.8  2000/03/28 07:31:09  tom
// Added calls to play more sound effects.
//
// Revision 1.7  2000/02/21 23:06:36  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.6  2000/01/10 02:53:49  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.5  1999/12/25 08:18:39  tom
// Added "Id" and "Log" CVS keywords to source code.
//
