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

Ctile_track::Ctile_track( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_track::constructor( )" << endl;
#endif
}

Ctile_track::Ctile_track( unsigned long flags )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_track::constructor( long )" << endl;
#endif

	exitFlags |= flags;
}

Ctile_track::~Ctile_track( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_track::destructor( )" << endl;
#endif
}

void
Ctile_track::move_balls( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_track::move_balls( )" << endl;
#endif
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
			if( move_a_ball( **it ) == 1 )
			{
				// We got an erase return value
				delete *it;
				it = balls.erase( it );
			} else {
				// Move on
				it++;
			}
		}
	}
}

int
Ctile_track::move_a_ball( Cball &b )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_track::move_a_ball( )" << endl;
#endif
	float	xcoord		= 0;
	float	ycoord		= 0;
	float	offset		= 0;
	int		passed		= 0;
	dir_t	dir			= UP;
	int		halfTile	= CURMAP->tileSize / 2;

	// Get the direction the ball is moving in
	dir = b.get_direction( );

	// Get the ball's coordinates
	b.get_coordinates( &xcoord, &ycoord);

	// Find out if the ball is going to cross the mid point of
	// the tile.
	switch( dir )
	{
	case UP:
		if( (ycoord <= halfTile) && b.doMidPoint)
		{
			b.doMidPoint = false;
			offset = check_move_up( b, xcoord, ycoord );
		} else {
			// Keep going UP 
			ycoord = ycoord - CURMAP->ballSpd;
			if (ycoord > CURMAP->tileSize) ycoord = CURMAP->tileSize - 1;
			offset = ycoord;
		}
		break;
	case DOWN:
		if( (ycoord >= halfTile) && b.doMidPoint)
		{
			b.doMidPoint = false;
			offset = check_move_down( b, xcoord, ycoord );
		} else {
			// Keep going DOWN 
			ycoord = ycoord + CURMAP->ballSpd;
			if (ycoord < 0) ycoord = 0;
			offset = ycoord - CURMAP->tileSize;
		}
		break;
	case LEFT:
		if( (xcoord <= halfTile) && b.doMidPoint)
		{
			b.doMidPoint = false;
			offset = check_move_left( b, xcoord, ycoord );
		} else {
			// Keep going left
			xcoord = xcoord - CURMAP->ballSpd;
			if (xcoord > CURMAP->tileSize) xcoord = CURMAP->tileSize - 1;
			offset = xcoord;
		}
		break;
	case RIGHT:
		if( (xcoord >= halfTile) && b.doMidPoint)
		{
			b.doMidPoint = false;
			offset = check_move_right( b, xcoord, ycoord );
		} else {
			// Keep going right 
			xcoord = xcoord + CURMAP->ballSpd;
			if (xcoord < 0) xcoord = 0;
			offset = xcoord - CURMAP->tileSize;
		}
		break;
	default:
		break;
	}

	// See if we're out of bounds
	if(	( xcoord < 0 ) || ( xcoord > CURMAP->tileSize - 1 )
	||  ( ycoord < 0 ) || ( ycoord > CURMAP->tileSize - 1 ) )
	{ 
		// Time to pass the ball to the next tile
		passed = pass_ball( &b, dir, (int)offset );

		// Uh oh - it bounced back
		if( ! passed )
		{
			audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
			switch( dir )
			{
			case UP:
				b.doMidPoint = true;
				b.set_direction( DOWN );
				b.set_coordinates( xcoord, offset);
				break;
			case DOWN:
				b.doMidPoint = true;
				b.set_direction( UP );
				b.set_coordinates( xcoord, 
						CURMAP->tileSize - offset);
				break;
			case LEFT:
				b.doMidPoint = true;
				b.set_direction( RIGHT );
				b.set_coordinates( offset, ycoord);
				break;
			case RIGHT:
				b.doMidPoint = true;
				b.set_direction( LEFT );
				b.set_coordinates( 
					CURMAP->tileSize - offset, ycoord);
				break;
			default:
				break;
			}

		}
	} else {
		// Keep moving as we were
		b.set_coordinates( xcoord, ycoord);
	}

	// Do some more range checking now
	if( ycoord < 0 )
	{
		b.set_coordinates( xcoord, 0);
	}
	if( xcoord < 0 )
	{
		b.set_coordinates( 0, ycoord);
	}
	if( ycoord > CURMAP->tileSize )
	{
		b.set_coordinates( xcoord, CURMAP->tileSize);
	}
	if( xcoord > CURMAP->tileSize )
	{
		b.set_coordinates( CURMAP->tileSize, ycoord);
	}

	return( passed );
}


float
Ctile_track::check_move_up( Cball &b, float &xcoord, float &ycoord )
{
	float	overShoot	= 0;
	float	offset		= 0;
	int		halfTile	= CURMAP->tileSize / 2;

	// Ball will cross the midpoint this iteration
	overShoot = fabs( ycoord - CURMAP->ballSpd - halfTile );

	// Is there an exit LEFT that's not a blocked spinner?
	if( check_available_spinner( EXIT_LEFT ) )
	{
		// Yep, let's go left
		b.set_direction( LEFT );
		xcoord = halfTile - overShoot;
		ycoord = halfTile;
		return( 0 );
	}

	// Is there an exit RIGHT that's not a blocked spinner?
	if( check_available_spinner( EXIT_RIGHT ) )
	{
		b.set_direction( RIGHT );
		xcoord = halfTile + overShoot;
		ycoord = halfTile;
		return( 0 );
	}

	// Can we still go up??
	if( exitFlags & EXIT_UP )
	{	
		// Yep - keep moving up
		b.set_direction( UP );
		ycoord = ycoord - CURMAP->ballSpd;
		offset = ycoord;
		return( offset );
	}

	// No way to go up, left, or right - better turn around
	audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
	b.set_direction( DOWN );
	b.doMidPoint = true;
	xcoord = halfTile;
	ycoord = halfTile + overShoot;
	return( 0 );
}

float
Ctile_track::check_move_down( Cball &b, float &xcoord, float &ycoord )
{
	float	overShoot	= 0;
	float	offset		= 0;
	int		halfTile	= CURMAP->tileSize / 2;

	// Ball will cross the midpoint this iteration
	overShoot = fabs( ycoord + CURMAP->ballSpd - halfTile );

	// Is there an exit RIGHT that's not a blocked spinner?
	if( check_available_spinner( EXIT_RIGHT ) )
	{
		b.set_direction( RIGHT );
		xcoord = halfTile + overShoot;
		ycoord = halfTile;
		return( 0 );
	}

	// Is there an exit LEFT that's not a blocked spinner?
	if( check_available_spinner( EXIT_LEFT ) )
	{
		// Yep, let's go left
		b.set_direction( LEFT );
		xcoord = halfTile - overShoot;
		ycoord = halfTile;
		return( 0 );
	}

	// Is there an exit down?
	if( exitFlags & EXIT_DOWN )
	{	
		// Yep - keep moving down
		b.set_direction( DOWN );
		ycoord = ycoord + CURMAP->ballSpd;
		offset = ycoord;
		return( offset );
	}

	// No way to go up, left, or right - better turn around
	audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
	b.set_direction( UP );
	b.doMidPoint = true;
	xcoord = halfTile;
	ycoord = halfTile - overShoot;
	return( 0 );
}


float
Ctile_track::check_move_left( Cball &b, float &xcoord, float &ycoord )
{
	float	overShoot	= 0;
	float	offset		= 0;
	int		halfTile	= CURMAP->tileSize / 2;

	// Ball will cross the midpoint this iteration
	overShoot = fabs( ycoord - CURMAP->ballSpd - halfTile );

	// Is there an exit DOWN that's not a blocked spinner?
	if( check_available_spinner( EXIT_DOWN ) )
	{
		// Yep, let's go left
		b.set_direction( DOWN );
		xcoord = halfTile;
		ycoord = halfTile + overShoot;
		return( 0 );
	}

	// Is there an exit UP that's not a blocked spinner?
	if( check_available_spinner( EXIT_UP ) )
	{
		b.set_direction( UP );
		xcoord = halfTile;
		ycoord = halfTile - overShoot;
		return( 0 );
	}

	// Is there an exit LEFT 
	if( exitFlags & EXIT_LEFT )
	{	
		// Yep - keep moving Left
		b.set_direction( LEFT );
		xcoord = xcoord - CURMAP->ballSpd;
		offset = xcoord;
		return( offset );
	}

	// No way to go down left, or down - better turn around
	audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
	b.set_direction( RIGHT );
	b.doMidPoint = true;
	xcoord = halfTile + overShoot;
	ycoord = halfTile;
	return( 0 );
}

float
Ctile_track::check_move_right( Cball &b, float &xcoord, float &ycoord )
{
	float	overShoot	= 0;
	float	offset		= 0;
	int		halfTile	= CURMAP->tileSize / 2;

	// Ball will cross the midpoint this iteration
	overShoot = fabs( xcoord + CURMAP->ballSpd - halfTile );

	// Is there an exit UP that's not a blocked spinner?
	if( check_available_spinner( EXIT_UP ) )
	{
		b.set_direction( UP );
		xcoord = halfTile;
		ycoord = halfTile - overShoot;
		return( 0 );
	}

	// Is there an exit DOWN that's not a blocked spinner?
	if( check_available_spinner( EXIT_DOWN ) )
	{
		// Yep, let's go left
		b.set_direction( DOWN );
		xcoord = halfTile;
		ycoord = halfTile + overShoot;
		return( 0 );
	}

	// Can we go right at all?
	if( exitFlags & EXIT_RIGHT )
	{	
		// Yep - keep moving Right
		xcoord = xcoord + CURMAP->ballSpd;
		offset = xcoord;
		return( offset );
	}


	// No way to go down right, or up - better turn around
	audioDriver->play_sound( soundFiles[SOUND_BLOCK_BALL] );
	b.set_direction( LEFT );
	b.doMidPoint = true;
	xcoord = halfTile - overShoot;
	ycoord = halfTile;
	return( 0 );
}

void
Ctile_track::draw_under( int ulX, int ulY )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_track::draw_under( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif

	// Draw the start track stuff 
	draw_start_background( ulX, ulY );
	
	draw_exit_tracks( ulX, ulY );
}

void
Ctile_track::draw_balls( int ulX, int ulY )
{
	simple_draw_balls( ulX, ulY );
}

void
Ctile_track::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC1
	cerr << __FILE__ << " Ctile_track::draw_over( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
}
// $Id: tile_track.cpp,v 1.6 2001/03/31 09:23:34 tom Exp $
//
// $Log: tile_track.cpp,v $
// Revision 1.6  2001/03/31 09:23:34  tom
// fixed ball disappearing bug as a result of fluctuating frame rates
//
// Revision 1.5  2001/03/17 00:43:31  tom
// removed stray cout statement
//
// Revision 1.4  2001/03/15 09:54:51  tom
// Changed code to set/check the doMidPoint flag on balls as they cross
// the tiles.  Trying to calculate when the mid point check should be done
// resulted in some occasional slip ups where sometimes a tile would not do
// the appropriate mid point action (e.g. painter would miss a ball, blocker
// would let the wrong colored ball through, one-way wouldn't redirect a ball
// in a different direction, teleporter would miss a ball, etc.).
//
// Revision 1.3  2001/02/19 03:03:58  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.2  2001/02/16 21:00:11  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:37  brown
// Working toward Windows integration
//
// Revision 1.9  2000/11/19 03:41:57  brown
// More changes -fixed teleporter
//
// Revision 1.7  2000/11/18 23:33:00  tom
// put back default switch cases and removed a debug statement
//
// Revision 1.6  2000/11/18 22:38:59  tom
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
// Revision 1.19  2000/03/28 07:31:10  tom
// Added calls to play more sound effects.
//
// Revision 1.18  2000/02/21 23:06:37  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.17  2000/01/10 02:53:51  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.16  2000/01/01 21:51:22  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.15  1999/12/25 08:18:41  tom
// Added "Id" and "Log" CVS keywords to source code.
//
