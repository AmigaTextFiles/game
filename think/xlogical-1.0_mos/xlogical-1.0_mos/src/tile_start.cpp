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



// Language Includes
#include <cmath>

// Application Includes
#include "audio.h"
#include "properties.h"
#include "tiles.h"
#include "graph.h"
#include "gamelogic.h"
#include "sound_files.h"

//#define DEBUG_FUNC

Ctile_start::Ctile_start( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_start::constructor( )" << endl;
#endif
	startImage = -1;
}

Ctile_start::Ctile_start( unsigned long flags )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_start::constructor( unsigned long )" << endl;
#endif

	exitFlags = flags;

	switch( flags )
	{
	case ( EXIT_UP ):
		startImage = BMP_TRACK_U;
		break;
	case ( EXIT_DOWN ):
		startImage = BMP_TRACK_D;
		break;
	case ( EXIT_LEFT ):
		startImage = BMP_TRACK_L;
		break;
	case ( EXIT_RIGHT ):
		startImage = BMP_TRACK_R;
		break;
	default:
		break;
	}
}

Ctile_start::~Ctile_start( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_start::destructor( )" << endl;
#endif
}

void
Ctile_start::anim_loop( void )
{
}

void
Ctile_start::move_balls( void )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_start::move_balls( )" << endl;
#endif
	float	xcoord		= 0;
	float	ycoord		= 0;
	float	offset		= 0;
	dir_t	dir			= UP;
	int		timeToPass	= 0;
	int		halfTile	= CURMAP->tileSize / 2;
	int		overShoot	= 0;
	list< Cball * >::iterator it;

	it = balls.begin( );

	while( it != balls.end( ) )
	{
		timeToPass = 0;

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
			switch( dir )
			{
			case UP:
				// Will we cross the mid point?
				if( (ycoord <= halfTile ) && (*it)->doMidPoint)
				{
					// Yep, we crossed it
					audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
					overShoot = (int)
						fabs( ycoord - CURMAP->ballSpd - halfTile );
					(*it)->set_direction( DOWN );
					xcoord = halfTile;
					ycoord = halfTile + overShoot;
					(*it)->doMidPoint = false;
				} else {
					ycoord = ycoord - CURMAP->ballSpd;
					if (ycoord > CURMAP->tileSize) ycoord = CURMAP->tileSize-1;
					offset = ycoord;
				}
				break;
			case DOWN:
				if( (ycoord >= halfTile ) && (*it)->doMidPoint)
				{
					// Yep, we crossed it
					audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
					overShoot = (int)
						fabs( ycoord + CURMAP->ballSpd - halfTile );
					(*it)->set_direction( UP );
					xcoord = halfTile;
					ycoord = halfTile - overShoot;
					(*it)->doMidPoint = false;
				} else {
					ycoord = ycoord + CURMAP->ballSpd;
					if (ycoord < 0) ycoord = 0;
					offset = CURMAP->tileSize - ycoord;
				}
				break;
			case LEFT:
				if( (xcoord <= halfTile ) && (*it)->doMidPoint)
				{
					// Yep, we crossed it
					audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
					overShoot = (int)
						fabs( ycoord - CURMAP->ballSpd - halfTile );
					(*it)->set_direction( RIGHT );
					xcoord = halfTile + overShoot;
					ycoord = halfTile;
					(*it)->doMidPoint = false;
				} else {
					xcoord = xcoord - CURMAP->ballSpd;
					if (xcoord > CURMAP->tileSize) xcoord = CURMAP->tileSize-1;
					offset = xcoord;
				}
				break;
			case RIGHT:
				if( (xcoord >= halfTile ) && (*it)->doMidPoint)
				{
					// Yep, we crossed it
					audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
					overShoot = (int) 
						fabs( xcoord + CURMAP->ballSpd - halfTile );
					(*it)->set_direction( LEFT );
					xcoord = halfTile - overShoot;
					ycoord = halfTile;
					(*it)->doMidPoint = false;
				} else {
					xcoord = xcoord + CURMAP->ballSpd;
					if (xcoord < 0) xcoord = 0;
					offset = CURMAP->tileSize - xcoord;
				}
				break;
			default:
				break;
			}

			// See if we're out of bounds
			if(	( xcoord < 0 ) || ( xcoord > CURMAP->tileSize - 1 )
			||  ( ycoord < 0 ) || ( ycoord > CURMAP->tileSize - 1 ) )
			{ 
				if( pass_ball( *it, dir, (int)offset ) )
				{
					// Pass succeeded - remove ball from our list
					delete *it;
					it = balls.erase( it );
				} else {
					// Pass failed - bounce
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
						(*it)->set_coordinates( CURMAP->tileSize - offset, 
												ycoord);
						break;
					default:
						break;
					}
					it++;
				}
			} else {
				(*it)->set_coordinates( xcoord, ycoord);
				it++;
			}
		}
	}
}


void
Ctile_start::draw_under( int ulX, int ulY )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_start::draw_under( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif

	draw_start_background( ulX, ulY );

	draw_exit_tracks( ulX, ulY );
}


void
Ctile_start::draw_balls( int ulX, int ulY )
{
	// This is done in the draw_over function
	// To accomodate the timer erase clearing the balls
}

void
Ctile_start::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_start::draw_over( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif

	ulong timeNow = graphDriver->graph_get_time();
	ulong timeLeft = 0;
	int frame		= 0;

	if (gMenuEntryTime != 0)
	{
		timeLeft = CURMAP->ballStartTime + CURMAP->ballTimeLimit - timeNow + (timeNow - gMenuEntryTime);
	} else {
		if (CURMAP->ballStartTime > 0)
		{
			timeLeft = CURMAP->ballStartTime + CURMAP->ballTimeLimit - timeNow;
		} else {
			timeLeft = CURMAP->ballTimeLimit;
		}
	}
	frame = static_cast<int>(
		((float)timeLeft / (float)CURMAP->ballTimeLimit) * 20.0);

	if( frame < 0)
	{
		frame = 0;
	}

	if( frame > 19)
	{
		frame = 19;
	}

	frame = BMP_STARTTIMER_19 - frame;

	// Erase the image
	graphDriver->graph_erase_pixmap( BMP_STARTTIMER_00, ulX + 7, ulY + 8 );

	// A hack.  Pure and simple.
	simple_draw_balls( ulX, ulY );

	switch( frame )
	{
		case BMP_STARTTIMER_00:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_01:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_02:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_03:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_04:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_05:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_06:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_07:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_08:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_09:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_10:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_11:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_12:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_13:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_14:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_15:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_16:
			graphDriver->graph_draw( frame, ulX + 7, ulY + 8 );
			break;
		case BMP_STARTTIMER_17:
			graphDriver->graph_draw( frame, ulX + 9, ulY + 8 );
			break;
		case BMP_STARTTIMER_18:
			graphDriver->graph_draw( frame, ulX + 14, ulY + 8 );
			break;
		case BMP_STARTTIMER_19:
			graphDriver->graph_draw( frame, ulX + 20, ulY + 8 );
			break;
	}
}
// $Id: tile_start.cpp,v 1.6 2001/07/31 20:54:56 tom Exp $
//
// $Log: tile_start.cpp,v $
// Revision 1.6  2001/07/31 20:54:56  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
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
// Revision 1.17  2000/03/28 07:31:10  tom
// Added calls to play more sound effects.
//
// Revision 1.16  2000/02/21 23:06:37  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.15  2000/02/13 06:27:19  tom
// Fixed new ball timer bug and high score update bug.
//
// Revision 1.14  2000/02/13 03:44:53  brown
// Start tile changes, as well as some font scroll changes
//
// Revision 1.13  2000/01/10 02:53:50  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.12  2000/01/01 21:51:22  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.11  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
