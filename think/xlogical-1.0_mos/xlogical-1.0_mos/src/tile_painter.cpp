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
#include "audio.h"
#include "properties.h"
#include "tiles.h"
#include "graph.h"
#include "gamelogic.h"
#include "sound_files.h"

//#define DEBUG_FUNC

Ctile_painter::Ctile_painter( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_painter::constructor( )" << endl;
#endif
	exitFlags = 0;
	newColor = NO_COLOR;
}

Ctile_painter::Ctile_painter( color_t c, int exits )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_painter::constructor( )" << endl;
#endif
	// Set the exitFlags for this tile
	exitFlags = exits;

	// Set the paint color
	newColor = c;
}

Ctile_painter::~Ctile_painter( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_painter::destructor( )" << endl;
#endif
}

void
Ctile_painter::draw_under( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_painter::draw_under( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif

	// Draw the start path
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
Ctile_painter::draw_balls( int ulX, int ulY )
{
	simple_draw_balls( ulX, ulY );
}

void
Ctile_painter::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_painter::draw_over( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	
	// Draw the base for the painter
	graphDriver->graph_draw( BMP_PAINT_BASE, ulX, ulY );

	// Now draw the paint swirl
	switch( newColor )
	{
	case C1:
		graphDriver->graph_draw( BMP_GEM_C1, ulX+24, ulY+24 );
		break;
	case C2:
		graphDriver->graph_draw( BMP_GEM_C2, ulX+24, ulY+24 );
		break;
	case C3:
		graphDriver->graph_draw( BMP_GEM_C3, ulX+24, ulY+24 );
		break;
	case C4:
		graphDriver->graph_draw( BMP_GEM_C4, ulX+24, ulY+24 );
		break;
	default:
		break;
	}
}

void
Ctile_painter::move_balls( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_painter::move_balls" << endl;
#endif
	float	xcoord		= 0;
	float	ycoord		= 0;
	float	offset		= 0;
	int		status		= 0;
	dir_t	dir			= UP;
	int		halfTile	= CURMAP->tileSize / 2;
	list< Cball * >::iterator it;
	int 	pm			= 0;


	// Bail if there are no balls here
	if( balls.empty( ) )
	{
		return;
	}
	
	// Set up the new pixmap
	switch( newColor )
	{
	case C1:
		pm = BMP_BALL_C1;
		break;
	case C2:
		pm = BMP_BALL_C2;
		break;
	case C3:
		pm = BMP_BALL_C3;
		break;
	case C4:
		pm = BMP_BALL_C4;
		break;
	default:
		break;
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
				if( (ycoord <= halfTile ) && (*it)->doMidPoint)
				{
					// Set the new color
					(*it)->set_color( newColor );
					(*it)->set_pixmap_num( pm );
					audioDriver->play_sound( soundFiles[SOUND_PAINT_BALL] );
					(*it)->doMidPoint = false;
				}

				// Keep going UP 
				ycoord = ycoord - CURMAP->ballSpd;
				if (ycoord > CURMAP->tileSize) ycoord = CURMAP->tileSize-1;
				offset = ycoord;
				break;
			case DOWN:
				if( (ycoord >= halfTile ) && (*it)->doMidPoint)
				{
					// Set the new color
					(*it)->set_color( newColor );
					(*it)->set_pixmap_num( pm );
					audioDriver->play_sound( soundFiles[SOUND_PAINT_BALL] );
					(*it)->doMidPoint = false;
				}

				// Keep going DOWN 
				ycoord = ycoord + CURMAP->ballSpd;
				if (ycoord < 0) ycoord = 0;
				offset = ycoord - CURMAP->tileSize;
				break;
			case LEFT:
				if( (xcoord <= halfTile ) && (*it)->doMidPoint)
				{
					// Set the new color
					(*it)->set_color( newColor );
					(*it)->set_pixmap_num( pm );
					audioDriver->play_sound( soundFiles[SOUND_PAINT_BALL] );
					(*it)->doMidPoint = false;
				}
				// Keep going LEFT
				xcoord = xcoord - CURMAP->ballSpd;
				if (xcoord > CURMAP->tileSize) xcoord = CURMAP->tileSize-1;
				offset = xcoord;
				break;
			case RIGHT:
				if( (xcoord >= halfTile ) && (*it)->doMidPoint)
				{
					// Set the new color
					(*it)->set_color( newColor );
					(*it)->set_pixmap_num( pm );
					audioDriver->play_sound( soundFiles[SOUND_PAINT_BALL] );
					(*it)->doMidPoint = false;
				}

				// Keep going RIGHT 
				xcoord = xcoord + CURMAP->ballSpd;
				if (xcoord < 0) xcoord = 0;
				offset = xcoord - (CURMAP->tileSize - 1);
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
// $Id: tile_painter.cpp,v 1.5 2001/03/31 09:23:33 tom Exp $
//
// $Log: tile_painter.cpp,v $
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
// Revision 1.3  2001/02/19 03:03:57  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.2  2001/02/16 21:00:09  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:35  brown
// Working toward Windows integration
//
// Revision 1.6  2000/11/18 22:38:58  tom
// fixed some memory leaks and changed some stuff to try to track down the
// disappearing ball phenomenon.
//
// Revision 1.5  2000/10/08 21:14:03  brown
// Fixed blocker problem
// Fixed painter tile so the right bitmaps is drawn
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
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.8  2000/02/23 05:52:04  tom
// Added some sound effects that were missing.
//
// Revision 1.7  2000/02/21 23:06:37  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.6  2000/01/10 02:53:49  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.5  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
