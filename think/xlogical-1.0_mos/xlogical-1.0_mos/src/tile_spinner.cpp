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
#include "defs.h"
#include "gamelogic.h"
#include "graph.h"
#include "sound_files.h"
#include "tiles.h"

#define FLASH_TIME 5

//#define DEBUG_FUNC

Ctile_spinner::Ctile_spinner( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::constructor( )" << endl;
#endif
	moving = 0;
	finishing = 0;
	finished = 0;
	finishing_hopper = -1;
	flashOn = 0;
	flashWait = rand( ) % 5;

	// Reset the hopper
	hopper[0] = NULL;
	hopper[1] = NULL;
	hopper[2] = NULL;
	hopper[3] = NULL;

	// Set up the spin animation
	anim_frames.set_frame_range( 0, 2 );

	// Set up the finish animation
	finish_frames.set_frame_range( 0, 2 );
}

Ctile_spinner::~Ctile_spinner( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::destructor( )" << endl;
#endif
}

void
Ctile_spinner::flash_light( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::flash_light( )" << endl;
#endif
	static ulong lastMenuTime = 0;

	// don't show time if we're paused
	if( lastMenuTime != gMenuEntryTime )
	{
		return;
	} else {
		lastMenuTime = gMenuEntryTime;
	}

	flashWait++;

	if( !(flashWait % FLASH_TIME) )
	{
		if( flashOn || finished )
		{
			flashOn = 0;
		} else {
			flashOn = 1;
		}
	}
}

void
Ctile_spinner::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::draw_over( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	int pm  = 0;
	int xoff0 = -0;
	int yoff0 = 5;
	int xoff1 = -5;
	int yoff1 = -2;
	int xoff2 = 0;
	int yoff2 = -8;
	int xoff3 = 5;
	int yoff3 = -1;

	if( finished )
	{
		graphDriver->graph_draw( BMP_SPINDARK, ulX, ulY );
	} else {
		// Update our flashing
		flash_light( );
		// Clear under the spinner
		graphDriver->graph_erase_pixmap( BMP_SPINDARK, ulX, ulY );
	}

	// Draw the spinner base
	if( flashOn )
	{
		graphDriver->graph_draw( 
			BMP_SPINRED_0 + anim_frames.get_current_frame( ), 
			ulX, 
			ulY );
	} else {

		graphDriver->graph_draw( 
			BMP_SPIN_0 + anim_frames.get_current_frame( ), 
			ulX, 
			ulY );
	}

	// DRAW THE BALLS

	// Are we animating?  Adjust the ball positions as the hoppers
	// rotate
	if( moving ) {
		switch( anim_frames.get_current_frame( ) )
		{
			case 1:
				xoff0 = -9;
				yoff0 = 8;
				xoff1 = -7;
				yoff1 = -10;
				xoff2 = 10;
				yoff2 = -10;
				xoff3 = 8;
				yoff3 = 9;
				break;
			case 2:
				xoff0 = -16;
				yoff0 = 13;
				xoff1 = -14;
				yoff1 = -17;
				xoff2 = 17;
				yoff2 = -17;
				xoff3 = 14;
				yoff3 = 14;
				break;
			default:
				break;
		}
	}

	if( !finishing )
	{
		// Loop through the ball hopper and draw those balls
		if( hopper[0] != NULL )
		{
			graphDriver->graph_draw(
				hopper[0]->get_pixmap_num( ), 
				ulX + CURMAP->tileSize / 2 - CURMAP->ballSize / 2 + xoff0, 
				ulY + yoff0 );
		}

		if( hopper[1] != NULL )
		{
			graphDriver->graph_draw(
				hopper[1]->get_pixmap_num( ), 
				ulX + CURMAP->tileSize - CURMAP->ballSize + xoff1,
				ulY + CURMAP->tileSize / 2 - CURMAP->ballSize / 2 + yoff1 );
		}

		if( hopper[2] != NULL )
		{
			graphDriver->graph_draw(
				hopper[2]->get_pixmap_num( ), 
				ulX + CURMAP->tileSize / 2 - CURMAP->ballSize / 2 + xoff2,
				ulY + CURMAP->tileSize - CURMAP->ballSize + yoff2 );
		}

		if( hopper[3] != NULL )
		{
			graphDriver->graph_draw(
				hopper[3]->get_pixmap_num( ), 
				ulX + xoff3,
				ulY + CURMAP->tileSize/ 2 - CURMAP->ballSize / 2 + yoff3 );
		}
	} else {

		// We're in finish-the-spinner mode.

		// As we empty a hopper, we'll draw an animation
		graphDriver->graph_draw( 
			BMP_FINISH_1 + finish_frames.get_current_frame( ), 
			ulX + xoff3,
			ulY + CURMAP->tileSize/ 2 - CURMAP->ballSize / 2 + yoff3 );
		graphDriver->graph_draw( 
			BMP_FINISH_1 + finish_frames.get_current_frame( ), 
			ulX + CURMAP->tileSize / 2 - CURMAP->ballSize / 2 + xoff2,
			ulY + CURMAP->tileSize - CURMAP->ballSize + yoff2 );
		graphDriver->graph_draw(
			BMP_FINISH_1 + finish_frames.get_current_frame( ), 
			ulX + CURMAP->tileSize - CURMAP->ballSize + xoff1,
			ulY + CURMAP->tileSize / 2 - CURMAP->ballSize / 2 + yoff1 );
		graphDriver->graph_draw( 
			BMP_FINISH_1 + finish_frames.get_current_frame( ), 
			ulX + CURMAP->tileSize / 2 - CURMAP->ballSize / 2 + xoff0, 
			ulY + yoff0 );
	}

	// Plug the ring gaps
	if( ! (exitFlags & EXIT_UP) )
	{
		graphDriver->graph_draw( BMP_SPINRING_U, ulX + 24, ulY + 0 );
	}

	if( ! (exitFlags & EXIT_DOWN) )
	{
		graphDriver->graph_draw( BMP_SPINRING_D, ulX + 24, ulY + 57 );
	}

	if( ! (exitFlags & EXIT_LEFT) )
	{
		graphDriver->graph_draw( BMP_SPINRING_L, ulX + 0, ulY + 23 );
	}

	if( ! (exitFlags & EXIT_RIGHT) )
	{
		graphDriver->graph_draw( BMP_SPINRING_R, ulX + 58, ulY + 22 );
	}

	// Now do the covers
	if( flashOn )
	{
		pm = BMP_SPINCOVERRED_0;
	} else {
		pm = BMP_SPINCOVER_0;
	}

	if( moving ) {
		pm += anim_frames.get_current_frame( );
	}

	switch( pm )
	{
		case BMP_SPINCOVERRED_0:
			graphDriver->graph_draw( pm, ulX + 10, ulY + 8 );
			break;
		case BMP_SPINCOVERRED_1:
			graphDriver->graph_draw( pm, ulX + 8, ulY + 7 );
			break;
		case BMP_SPINCOVERRED_2:
			graphDriver->graph_draw( pm, ulX + 8, ulY + 7 );
			break;
		case BMP_SPINCOVER_0:
			graphDriver->graph_draw( pm, ulX + 10, ulY + 8 );
			break;
		case BMP_SPINCOVER_1:
			graphDriver->graph_draw( pm, ulX + 8, ulY + 7 );
			break;
		case BMP_SPINCOVER_2:
			graphDriver->graph_draw( pm, ulX + 8, ulY + 7 );
			break;
	}

	// Draw the light
	if( flashOn )
	{
		graphDriver->graph_draw( BMP_SPINTOPON, ulX + 29, ulY + 26 );
	} else {
		graphDriver->graph_draw( BMP_SPINTOPOFF, ulX + 29, ulY + 26 );
	}
}

void
Ctile_spinner::click_func( int xPos, int yPos, int button )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::click_func( )" << endl;
#endif

	// If we're already moving or if we're finishing then bail
	if( moving || finishing )
	{
		return;
	}

	// Was it a "spin" click?
	if( button == 3 )
	{
		// Ok, NOW we're moving
		moving = 1;

		audioDriver->play_sound( soundFiles[SOUND_SPINNER_CLICK] );
	} else
	// Was it an "eject ball" click?
	if( button == 1 )
	{
		if( xPos < yPos )
		{
			// We clicked either left or down
			if( xPos < -1 * yPos + CURMAP->tileSize )
			{
				// We clicked left
				try_eject( LEFT );
			} else {
				// We clicked down
				try_eject( DOWN );
			}
		} else {
			// We clicked either right or up
			if( xPos < -1 * yPos + CURMAP->tileSize )
			{
				// We clicked Up
				try_eject( UP );
			} else {
				// We clicked right
				try_eject( RIGHT );
			}
		}
	}
}

void
Ctile_spinner::anim_loop( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::anim_loop( )" << endl;
#endif
	Cball	*tempBall;

	if( moving )
	{
		if( ! anim_frames.advance( ) )
		{
			// Animation is done - reset.
			moving = 0;

			// Rotate the ball hopper
			tempBall = hopper[0];
			hopper[0] = hopper[1];
			hopper[1] = hopper[2];
			hopper[2] = hopper[3];
			hopper[3] = tempBall;

			anim_frames.reset_anim( );
		}
	} else if( finishing )
	{
		// We're finishing this spinner
		if( ! finish_frames.advance( ) )
		{
			finishing = 0;
			finished = 1;
			flashOn = 0;
			finish_frames.reset_anim( );
		}
	}
}

Cball *
Ctile_spinner::check_hopper( dir_t dir )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::check_hopper()" << endl;
#endif
	switch( dir )
	{
	case UP:
		return( hopper[0] );
		break;
	case DOWN:
		return( hopper[2] );
		break;
	case LEFT:
		return( hopper[3] );
		break;
	case RIGHT:
		return( hopper[1] );
		break;
	default:
		break;
	}
	return( NULL );
}

int
Ctile_spinner::check_complete( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::check_complete( )" << endl;
#endif
	int		retVal			= FILL_NONE;
	color_t checkColor		= NO_COLOR;
	int		matchingOrder	= 0;
	int 	i				= 0;

	// Make sure all hoppers are full
	for( i = 0; i < 4; i++ )
	{
		if( hopper[i] == NULL )
		{
			return( FILL_NONE );
		}
	}

	// Do we have to match a pattern?
	if( CURMAP->pattern[0] != NO_COLOR )
	{
		if( (hopper[0]->get_color( ) == CURMAP->pattern[0] )
		 && (hopper[1]->get_color( ) == CURMAP->pattern[1] )
		 && (hopper[2]->get_color( ) == CURMAP->pattern[2] )
		 && (hopper[3]->get_color( ) == CURMAP->pattern[3] ) )
		{
			// We matched our pattern!!
			CURMAP->pattern[0] = NO_COLOR;
			CURMAP->pattern[1] = NO_COLOR;
			CURMAP->pattern[2] = NO_COLOR;
			CURMAP->pattern[3] = NO_COLOR;

			// calculate time for next pattern
			CURMAP->nextPatternTime =
				graphDriver->graph_get_time() + CURMAP->patternWaitTime;
		} else {
			// We didn't match the pattern
			return( FILL_NONE );
		}

		retVal = FILL_PATTERN;
	} else {

		// We don't have to match a pattern - solid fill
		// Do we have an order to match?
		if( CURMAP->order[0] == NO_COLOR )
		{
			// Get the color from the first hopper
			checkColor = hopper[0]->get_color( );
		} else {
			// Get the color from the order list
			checkColor = CURMAP->order[0];
			matchingOrder = 1;
		}

		// Check the hoppers for a match
		if( (hopper[0]->get_color( ) == checkColor)
		&& (hopper[1]->get_color( ) == checkColor)
		&& (hopper[2]->get_color( ) == checkColor)
		&& (hopper[3]->get_color( ) == checkColor) )
		{
			// We have a full spinner and no color to match
			retVal = FILL_SOLID;
			if( matchingOrder )
			{
				retVal = FILL_ORDER;
				CURMAP->order[0] = CURMAP->order[1];
				CURMAP->order[1] = CURMAP->order[2];
				if( CURMAP->randOrder == 1 )
				{
					// Randomize a new color
					CURMAP->order[2] = (color_t)(rand( )%4 + 1);
				} else {
					// Set the next one to null
					CURMAP->order[2] = NO_COLOR;
				}
			}
		} else {
			// We didn't match all the proper colors
			return( FILL_NONE );
		}
	}
	
	// Everything still a go?
	if( retVal != FILL_NONE )
	{
		finishing = 1;

		// Remove the balls
		for( i = 0; i < 4; i++ )
		{
			balls.remove( hopper[i] );
			delete hopper[i];
			hopper[i] = NULL;

		}

		// Only increment the counter if we're not finished
		if( ! finished )
		{
			// Turn off the light
			flashOn = 0;

			// Increment the finished counter
			CURMAP->spinnersFinished++;
			audioDriver->play_sound( soundFiles[SOUND_FINISH_SPINNER] );
		} else {
			// Return a completed status if we've already
			// finished this spinner
			retVal = FILL_COMPLETED;
		}
	}
	return( retVal );
}

void
Ctile_spinner::try_eject( dir_t dir )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_spinner::try_eject( )" << endl;
#endif
	Ctile *tempTile = NULL;

	// Can we move the ball?
	if( ! CURMAP->can_move_ball( ) )
	{
		return;
	}

	// Do stuff based on the direction
	switch( dir )
	{
	case UP:
		// Do we have an exit?
		if( exitFlags & EXIT_UP )
		{
			if( hopper[0] != NULL )
			{
				// Check to make sure we're not ejecting onto
				// the start path
				tempTile = get_tile( UP );
				if( tempTile->is_start_path( ) == 1 )
				{
					return;
				}

				// Set the ball direction and pass
				if( pass_ball( hopper[0], UP, 0 ) )
				{
					audioDriver->play_sound( soundFiles[SOUND_EJECT_BALL] );
					balls.remove( hopper[0] );
					delete hopper[0];
					hopper[0] = NULL;
					CURMAP->move_ball( );
				}
			}
		}
		break;
	case DOWN:
		if( exitFlags & EXIT_DOWN )
		{
			if( hopper[2] != NULL )
			{
				// Check to make sure we're not ejecting onto
				// the start path
				tempTile = get_tile( DOWN );
				if( tempTile->is_start_path( ) == 1 )
				{
					return;
				}
				// Set the ball direction and pass
				if( pass_ball( hopper[2], DOWN, 0 ) )
				{
					audioDriver->play_sound( soundFiles[SOUND_EJECT_BALL] );
					balls.remove( hopper[2] );
					delete hopper[2];
					hopper[2] = NULL;
					CURMAP->move_ball( );
				}
			}
		}
		break;
	case LEFT:
		if( exitFlags & EXIT_LEFT )
		{
			if( hopper[3] != NULL )
			{
				// Check to make sure we're not ejecting onto
				// the start path
				tempTile = get_tile( LEFT );
				if( tempTile->is_start_path( ) == 1 )
				{
					return;
				}
				// Set the ball direction and pass
				if( pass_ball( hopper[3], LEFT, 0 ) )
				{
					audioDriver->play_sound( soundFiles[SOUND_EJECT_BALL] );
					balls.remove( hopper[3] );
					delete hopper[3];
					hopper[3] = NULL;
					CURMAP->move_ball( );
				}
			}
		}
		break;
	case RIGHT:
		if( exitFlags & EXIT_RIGHT )
		{
			if( hopper[1] != NULL )
			{
				// Check to make sure we're not ejecting onto
				// the start path
				tempTile = get_tile( RIGHT );
				if( tempTile->is_start_path( ) == 1 )
				{
					return;
				}
				// Set the ball direction and pass
				if( pass_ball( hopper[1], RIGHT, 0 ) )
				{
					audioDriver->play_sound( soundFiles[SOUND_EJECT_BALL] );
					balls.remove( hopper[1] );
					delete hopper[1];
					hopper[1] = NULL;
					CURMAP->move_ball( );
				}
			}
		}
		break;
	default:
		break;
	}
}
// $Id: tile_spinner.cpp,v 1.5 2001/07/31 20:54:56 tom Exp $
//
// $Log: tile_spinner.cpp,v $
// Revision 1.5  2001/07/31 20:54:56  tom
// Changed system time functions to use time function provided by Cgraph
// class instead of using OS system calls.  This should make it easier
// to port to other operating systems, e.g. BSD.
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
// Revision 1.1  2001/01/20 17:32:36  brown
// Working toward Windows integration
//
// Revision 1.6  2000/11/19 03:54:31  brown
// Ach-Ha!  Fixed the last of the bugs ( har! )
//
// Revision 1.5  2000/10/06 19:29:13  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.4  2000/10/02 02:23:47  brown
// Random fixes
//
// Revision 1.3  2000/10/01 05:00:27  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.2  2000/09/30 15:52:13  brown
// Fixed score display, text scrolling, window height, ball redraws
//
// Revision 1.1.1.1  2000/09/28 02:17:53  tom
// imported sources
//
// Revision 1.29  2000/07/23 18:29:52  brown
// Fixed problem where quitting the current level didn't reset levels to the
// beginning
//
// Revision 1.28  2000/07/23 17:47:18  brown
// Fixed the problem with matching a color order where hopper 0 could be any color
//
// Revision 1.27  2000/07/23 16:50:33  brown
// Fixed level timer changing while paused
// Added "finish spinner" animation
// Fixed level ending before last spinner finished ( sortof )
//
// Revision 1.26  2000/03/27 04:05:11  tom
// Fixed the damn spinner finish stuttering bug.  I was on glue when I added
// the code to play the sample...
//
// Revision 1.25  2000/02/23 05:52:04  tom
// Added some sound effects that were missing.
//
// Revision 1.24  2000/02/22 04:22:51  brown
// Graphics changes
//
// Revision 1.23  2000/02/21 23:06:37  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.22  2000/02/13 03:44:52  brown
// Start tile changes, as well as some font scroll changes
//
// Revision 1.21  2000/02/12 21:07:11  brown
//
// Bunch of new backgrounds
//
// Revision 1.19  2000/01/10 02:53:49  brown
// Bunch of changes - fixed start track, fixed order and pattern, fixed some
// backgrounds.
//
// Revision 1.18  2000/01/09 02:26:17  brown
// Quite a few fixes - speedup for the level loading, passwords work etc
//
// Revision 1.17  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
