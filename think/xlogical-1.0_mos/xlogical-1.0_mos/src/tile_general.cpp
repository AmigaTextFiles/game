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
#include <iostream>

#ifdef WIN32
using namespace std;
#endif

// Application Includes
#include "audio.h"
#include "properties.h"
#include "tiles.h"
#include "globals.h"
#include "graph.h"
#include "gamelogic.h"
#include "defs.h"
#include "sound_files.h"

//#define DEBUG_FUNC

Ctile::Ctile( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::Ctile( )" << endl;
#endif
	exitFlags = 0l;
	indexPos = 0;
	startPath = 0;
	balls.empty( );
}

Ctile::~Ctile( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::~Ctile( )" << endl;
#endif
	balls.empty( );
}

int
Ctile::add_ball( Cball *b, dir_t dir, int offset )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::add_ball( )" << endl;
	cerr << "adding to tile: " << indexPos << endl;
#endif

	int startOffset = 0;
	int checkDir = -1;
	float max = CURMAP->tileSize;
	float center = CURMAP->tileSize / 2;

	switch( this->get_type( ) )
	{
	case START:
		// This is a special case adding a new ball to the start tile
		// We want to see if this is a ball that has bounced from the
		// end of the startPath or if it's a new ball being added
		switch( dir )
		{
		case UP:
			if( exitFlags & EXIT_UP )
			{
				startOffset = (int)(max / 2);
			}
			break;
		case DOWN:
			if( exitFlags & EXIT_DOWN )
			{
				startOffset = (int)(max / 2);
			}
			break;
		case LEFT:
			if( exitFlags & EXIT_LEFT )
			{
				startOffset = (int)(max / 2);
			}
			break;
		case RIGHT:
			if( exitFlags & EXIT_RIGHT )
			{
				startOffset = (int)(max / 2);
			}
			break;
		default:
			break;
		}
		break;
	case TELEPORT:
		switch( dir )
		{
		case PENDING_UP:
			startOffset = (int)(max / 2);
			dir = UP;
			break;
		case PENDING_DOWN:
			startOffset = (int)(max / 2);
			dir = DOWN;
			break;
		case PENDING_LEFT:
			startOffset = (int)(max / 2);
			dir = LEFT;
			break;
		case PENDING_RIGHT:
			startOffset = (int)(max / 2);
			dir = RIGHT;
			break;
		default:
			break;
		}
		break;
	case SPINNER:
		// This is a special case adding a new ball to a spinner tile
		// The ball is just going to hit a hopper and that's it.
		// If it's moving then bounce!
		if( TILE_SPINNER( this )->is_moving( ) )
		{
			return( 0 );
		}

		switch( dir )
		{
		case UP:
			checkDir = 2;
			break;
		case DOWN:
			checkDir = 0;
			break;
		case LEFT:
			checkDir = 1;
			break;
		case RIGHT:
			checkDir = 3;
			break;
		default:
			break;
		}

		// Is the hopper empty?
		assert( checkDir >= 0 );
		if( TILE_SPINNER( this )->hopper[checkDir] != NULL )
		{
			// Nope, abort the add
			return( 0 );
		}
		
		// Hopper was fine.  Add the ball
		audioDriver->play_sound( soundFiles[SOUND_CATCH_BALL] );
		TILE_SPINNER( this )->hopper[checkDir] = b;
		dir = STOPPED;
		// Decrement our "balls moving" counter
		CURMAP->stop_ball( );

		break;
	default:
		break;
	}

	
	// Set the coordinates for the ball
	switch( dir )
	{
	case UP:
		b->set_coordinates( center, max - startOffset + offset );
		break;
	case DOWN:
		b->set_coordinates( center, 0 + startOffset + offset );
		break;
	case LEFT:
		b->set_coordinates( max - startOffset + offset, center );
		break;
	case RIGHT:
		b->set_coordinates( 0 + startOffset + offset, center );
		break;
	default:
		break;
	}

	// Set the direction if it hasn't already been set
	b->set_direction( dir );
	b->doMidPoint = true;

	balls.push_front( b );

	// Return success
	return( 1 );
}

int
Ctile::check_available_spinner( int exitDir )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::check_available_spinner( )" << endl;
#endif
	Ctile *tempTile;

	int retVal = 0;
	dir_t checkDir = UP;
	dir_t checkDir2 = UP;

	// In this function, we're assuming some pre-checking has
	// been done on the map and that there will never be an
	// exitFlag set to have an exit leading off the map

	switch( exitDir )
	{
	case EXIT_UP:
		checkDir = UP;
		checkDir2 = DOWN;
		break;
	case EXIT_DOWN:
		checkDir = DOWN;
		checkDir2 = UP;
		break;
	case EXIT_LEFT:
		checkDir = LEFT;
		checkDir2 = RIGHT;
		break;
	case EXIT_RIGHT:
		checkDir = RIGHT;
		checkDir2 = LEFT;
		break;
	default:
		break;
	}
	// Do we have an exit there?
	// and is it a track tile WITHOUT 4 exits 
	if( (exitFlags & exitDir) &&
		(get_type() == TRACK) &&
		(exitFlags != (EXIT_UP|EXIT_DOWN|EXIT_LEFT|EXIT_RIGHT)))
	{
		// Get the tile that's on that side
		tempTile = get_tile( checkDir );
		// Is it a spinner?
		if( tempTile->get_type( ) == SPINNER )
		{
			// Make sure it's not spinning or finishing
			if( (! TILE_SPINNER( tempTile )->is_moving( ) )
			  && (! TILE_SPINNER( tempTile )->is_finishing( ) ) )
			{
				// Is the hopper empty on that side?
				if( ! TILE_SPINNER( tempTile )->check_hopper( checkDir2 ) )
				{
					// Woohoo!  Go for it!
					retVal = 1;
				}
			}
		} else {
			// If we're on the start track and the other track is not
			// and we're near max balls
			if( is_start_path( ) 
			&& (tempTile->get_type(  ) == TRACK ) 
			&& (! tempTile->is_start_path( ) )
			&& (CURMAP->get_moving_balls( ) < CURMAP->maxBallsInMotion - 1 ) )
			{
				// Woohoo!  Go for it!
				retVal = 1;
			}
		}
	}
	return( retVal );
}

int
Ctile::pass_ball( Cball *b, dir_t dir, int offset )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::pass_ball( )" << endl;
#endif

	Cball *	tempBall	= NULL;
	Ctile *	tempTile	= NULL;
	int		xoffset		= 0;
	int		yoffset		= 0;
	int		status		= 0;
	float	xpos		= 0;
	float	ypos		= 0;

	// Apply the offset to the appropriate coordinate
	if( (dir == UP) || (dir == DOWN) )
	{
		yoffset = offset;
	} else {
		xoffset = offset;
	}

	// Get the old ball coords
	b->get_last_coordinates( &xpos, &ypos );

	// Erase the old ball
	graphDriver->graph_erase_pixmap( 
		b->get_pixmap_num( ), 
		(int)xpos, (int)ypos );

	// Get the old ball parameters
	b->get_coordinates( &xpos, &ypos );

	// Get the adjacent tile
	tempTile = get_tile( dir );

	// Bail if this tile is bogus
	if( tempTile == NULL )
	{
		cout << "BOGUS TILE!!!" << endl;
		return( 0 );
	}
	if( !is_start_path( ) && (tempTile->is_start_path( ) ) )
	{
		return( 0 );
	}

	// Set up the new ball
	tempBall = new Cball;
	tempBall->set_coordinates( xpos + xoffset, ypos + yoffset );
	tempBall->set_direction( dir );
	tempBall->set_color( b->get_color( ) );
	tempBall->set_pixmap_num( b->get_pixmap_num( ) );

	// If we're passing down or right, skip the next update
	if( (dir == DOWN) || (dir == RIGHT) )
	{
		tempBall->set_no_move( );
	}

	status = tempTile->add_ball( tempBall, dir, offset );  

	if( status )
	{
		b->deactivate( );

		// See if this is a ball leaving the start path
		// Is the start path active?
		if( CURMAP->startPathActive )
		{
			// Is the current tile a track on the start path?
			if( is_start_path( ) == 1 )
			{
				switch( tempTile->get_type( ) )
				{
				case TRACK:
				case ONEWAY:
				case BLOCKER:
				case PAINTER:
				case TELEPORT:
				case COVERED:
					// Is the new track on the start path?
					if( ! tempTile->is_start_path( ) )
					{
						// Reset the start path flag
						CURMAP->startPathActive = 0;
					}
					break;
				case START:
					// Leave the startPath as is
					break;
				default:
					// Reset the startPathActive flag
					CURMAP->startPathActive = 0;
					break;
				}
			}
		}
	} else {
		delete tempBall;
	}

	return( status );
}

int
Ctile::get_row( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::get_row( )" << endl;
#endif

	return( indexPos / CURMAP->xSize );
}

int
Ctile::get_col( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::get_col( )" << endl;
#endif
	return( indexPos % (CURMAP)->xSize );
}

Ctile *
Ctile::get_tile( dir_t dir )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::get_tile( )" << endl;
#endif

	int row;
	int col;
	int xSize;
	int ySize;
	Ctile *tempTile = NULL;

	xSize = CURMAP->xSize;
	ySize = CURMAP->ySize;
	row = indexPos / xSize;
	col = indexPos % xSize;

	// Alter our row/col
	switch( dir )
	{
	case UP:
		row = row - 1;
		break;
	case DOWN:
		row = row + 1;
		break;
	case LEFT:
		col = col - 1;
		break;
	case RIGHT:
		col = col + 1;
		break;
	default:
		break;
	}

	// If we're still within the boundaries, get the tile
	if( (row >= 0) && (row < ySize )
		&& (col >= 0) && (col < xSize ) )
	{
		tempTile = CURMAP->tiles[ row * xSize + col];
	}
	return( tempTile );
}

void
Ctile::set_start_path( dir_t dir )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::set_start_path( )" << endl;
#endif
	Ctile *tempTile = NULL;
	
	if( startPath == 1 )
	{
		return;
	}

	startPath = 1;

	switch( dir )
	{
	case UP:
		if( exitFlags & EXIT_UP )
		{
			tempTile = get_tile( UP );
			if( (tempTile != NULL) && (tempTile->get_type( ) != SPINNER) )
			{
				tempTile->set_start_path( UP );
			}
		}
		break;
	case DOWN:
		if( exitFlags & EXIT_DOWN )
		{
			tempTile = get_tile( DOWN );
			if( (tempTile != NULL) && (tempTile->get_type( ) != SPINNER) )
			{
				tempTile->set_start_path( DOWN );
			}
		}
		break;
	case LEFT:
		if( exitFlags & EXIT_LEFT )
		{
			tempTile = get_tile( LEFT );
			if( (tempTile != NULL) && (tempTile->get_type( ) != SPINNER) )
			{
				tempTile->set_start_path( LEFT );
			}
		}
		break;
	case RIGHT:
		if( exitFlags & EXIT_RIGHT )
		{
			tempTile = get_tile( RIGHT );
			if( (tempTile != NULL) && (tempTile->get_type( ) != SPINNER) )
			{
				tempTile->set_start_path( RIGHT );
			}
		}
		break;
	default:
		break;
	}

	return;

	// NOT SURE IF WE SHOULD USE THIS OR NOT

	// If we're a teleporter, find the other end and carry on
	if( get_type( ) == TELEPORT )
	{
		if( exitFlags & EXIT_UP )
		{
			tempTile = CURMAP->find_teleport_with_dir( 
									TILE_TELEPORT( this ),  DOWN );
			tempTile->set_start_path( dir );
		}
		if( exitFlags & EXIT_DOWN )
		{
			tempTile = CURMAP->find_teleport_with_dir( 
									TILE_TELEPORT( this ), UP );
			tempTile->set_start_path( dir );
		}
		if( exitFlags & EXIT_LEFT )
		{
			tempTile = CURMAP->find_teleport_with_dir( 
									TILE_TELEPORT( this ), RIGHT );
			tempTile->set_start_path( dir );
		}
		if( exitFlags & EXIT_RIGHT )
		{
			tempTile = CURMAP->find_teleport_with_dir( 
									TILE_TELEPORT( this ), LEFT );
			tempTile->set_start_path( dir );
		}
	}
}

int
Ctile::is_start_path( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::is_start_path( )" << endl;
#endif
	return( startPath );
}

void
Ctile::simple_draw_balls( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile::simple_draw_balls( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	float xcoord, ycoord;
	list< Cball * >::iterator it;

	it = balls.begin( );

	for( ; it != balls.end( ); it++ )
	{
		(*it)->get_last_coordinates( &xcoord, &ycoord);
		graphDriver->graph_erase_pixmap( 
			(*it)->get_pixmap_num( ), (int)xcoord, (int)ycoord );

		// Draw the new one
		(*it)->get_coordinates( &xcoord, &ycoord);
		graphDriver->graph_draw( 
			(*it)->get_pixmap_num( ), 
			ulX + (int)xcoord - CURMAP->ballSize / 2, 
			ulY + (int)ycoord - CURMAP->ballSize / 2 );

		// Set the last coords to be real coords not
		// relative to the tile
		(*it)->set_last_coordinates( 
			ulX + (int)xcoord - CURMAP->ballSize / 2, 
			ulY + (int)ycoord - CURMAP->ballSize / 2 );
	}
}

void
Ctile::draw_start_background( int ulX, int ulY )
{
	// Draw Start Path stuff
	if( startPath == 1 )
	{
		// Always draw the center piece
		graphDriver->graph_draw_perm( BMP_START_C, 0, 0, ulX, ulY, 64, 64 );

		// Draw the rest
		if( exitFlags & EXIT_UP )
		{
			graphDriver->graph_draw_perm( BMP_START_U, 0, 0, ulX, ulY, 64, 64 );
		}
		if( exitFlags & EXIT_DOWN )
		{
			graphDriver->graph_draw_perm( BMP_START_D, 0, 0, ulX, ulY, 64, 64 );
		}
		if( exitFlags & EXIT_LEFT )
		{
			graphDriver->graph_draw_perm( BMP_START_L, 0, 0, ulX, ulY, 64, 64 );
		}
		if( exitFlags & EXIT_RIGHT )
		{
			graphDriver->graph_draw_perm( BMP_START_R, 0, 0, ulX, ulY, 64, 64 );
		}
	}
}

void
Ctile::draw_exit_tracks( int ulX, int ulY )
{
	int trackImage;

	switch( exitFlags )
	{
	case ( EXIT_UP | EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT ):
		trackImage = BMP_TRACK_UDLR;
		break;
	case ( EXIT_DOWN | EXIT_LEFT | EXIT_RIGHT ):
		trackImage = BMP_TRACK_DLR;
		break;
	case ( EXIT_UP | EXIT_LEFT | EXIT_RIGHT ):
		trackImage = BMP_TRACK_ULR;
		break;
	case ( EXIT_DOWN | EXIT_LEFT ):
		trackImage = BMP_TRACK_DL;
		break;
	case ( EXIT_DOWN | EXIT_RIGHT ):
		trackImage = BMP_TRACK_DR;
		break;
	case ( EXIT_UP | EXIT_DOWN | EXIT_LEFT ):
		trackImage = BMP_TRACK_UDL;
		break;
	case ( EXIT_UP | EXIT_DOWN | EXIT_RIGHT ):
		trackImage = BMP_TRACK_UDR;
		break;
	case ( EXIT_UP | EXIT_LEFT ):
		trackImage = BMP_TRACK_UL;
		break;
	case ( EXIT_UP | EXIT_RIGHT ):
		trackImage = BMP_TRACK_UR;
		break;
	case ( EXIT_LEFT | EXIT_RIGHT ):
		trackImage = BMP_TRACK_LR;
		break;
	case ( EXIT_UP | EXIT_DOWN ):
		trackImage = BMP_TRACK_UD;
		break;
	case ( EXIT_UP ):
		trackImage = BMP_TRACK_U;
		break;
	case ( EXIT_DOWN ):
		trackImage = BMP_TRACK_D;
		break;
	case ( EXIT_LEFT ):
		trackImage = BMP_TRACK_L;
		break;
	case ( EXIT_RIGHT ):	// fall through
	default:
		trackImage = BMP_TRACK_R;
		break;
	}

	// Now draw the proper exit
	graphDriver->graph_draw_perm( trackImage, 0, 0, ulX, ulY, 64, 64 );
}

// $Id: tile_general.cpp,v 1.6 2001/08/01 00:57:55 tom Exp $
//
// $Log: tile_general.cpp,v $
// Revision 1.6  2001/08/01 00:57:55  tom
// added include of cassert header file
//
// Revision 1.5  2001/03/31 09:23:33  tom
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
// Revision 1.3  2001/02/19 03:03:56  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.2  2001/02/16 21:00:06  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:34  brown
// Working toward Windows integration
//
// Revision 1.8  2000/11/18 23:33:00  tom
// put back default switch cases and removed a debug statement
//
// Revision 1.7  2000/11/18 22:38:58  tom
// fixed some memory leaks and changed some stuff to try to track down the
// disappearing ball phenomenon.
//
// Revision 1.6  2000/11/12 22:01:11  brown
// More typecast fixes
//
// Revision 1.5  2000/11/09 22:06:34  tom
// cleaned up compiler warnings
//
// Revision 1.4  2000/10/06 19:29:12  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.3  2000/10/01 05:00:26  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.2  2000/09/30 15:52:13  brown
// Fixed score display, text scrolling, window height, ball redraws
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.27  2000/07/23 16:50:33  brown
// Fixed level timer changing while paused
// Added "finish spinner" animation
// Fixed level ending before last spinner finished ( sortof )
//
// Revision 1.26  2000/03/28 07:31:09  tom
// Added calls to play more sound effects.
//
// Revision 1.25  2000/03/28 06:26:15  tom
// Added hopper "catch ball" sound effect.
//
// Revision 1.24  2000/02/23 05:52:03  tom
// Added some sound effects that were missing.
//
// Revision 1.23  2000/01/10 02:53:49  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.22  2000/01/09 02:26:17  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.21  2000/01/01 21:51:22  brown
// Mucho changes - fixed level loading and game startup screens
//
// Revision 1.20  1999/12/28 20:07:46  tom
// Made 4 way track an exception to the "hopper jump" rule.
//
// Revision 1.19  1999/12/27 03:38:03  brown
// Fixed teleporters I hope - updated graphics etc
//
// Revision 1.18  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
