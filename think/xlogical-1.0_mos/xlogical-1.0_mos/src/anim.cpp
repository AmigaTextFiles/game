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


//Application Includes
#include "anim.h"
#include "graph.h"

anim::anim( void )
{
	frames.empty( );
	repeatStart = frames.end( );
	currentFrame = frames.end( );
	skipCounter = 0;
	skip = 0;
	xPos = 0;
	yPos = 0;
}

anim::~anim( void )
{
}

int
anim::advance_or_skip( void )
{
	if( skipCounter == skip )
	{
		return( advance( ) );
	} else {
		skipCounter += 1;
		return( 0 );
	}
}

void
anim::clear_frames( void )
{
	frames.empty( );
	repeatStart = frames.end( );
	currentFrame = frames.end( );
}

int
anim::is_done( void )
{
	return( animDone );
}

int
anim::advance( void )
{
	// Increment the frame counter
	currentFrame++;

	// Are we at the end?
	if( currentFrame == frames.end( ) )
	{
		// Repeat our repeatable frames
		currentFrame = repeatStart;

		// If there aren't any, we're done
		if( currentFrame == frames.end( ) )
		{
			// Flag that we're done the animation
			animDone = 1;

			// Return failure
			return( 0 );
		}
	}
	return( 1 );
}

void
anim::reset_anim( void )
{
	currentFrame = frames.begin( );
	skipCounter = 0;
	animDone = 0;
}

void
anim::set_repeat_start( int start )
{
	list< int >::iterator it;

	for( it = frames.begin( );it != frames.end( ); it ++ )
	{
		if( *it == start )
		{
			repeatStart = it;
		}
	}
}


void
anim::add_frame( int frame )
{
	// Tack the frame number onto the end of the list
	frames.push_back( frame );
}

void
anim::set_frame_range( int start, int end )
{
	int i;

	// First clear whatever we had
	clear_frames( );

	// Now loop and add the frame numbers
	for( i = start;i <= end; i++ )
	{
		frames.push_back( i );
	}

	// Set the position markers 
	currentFrame = frames.begin( );
	repeatStart = frames.end( );
}

int
anim::get_current_frame( )
{
	return( *currentFrame );
}

void
anim::set_pos( int x, int y )
{
	xPos = x;
	yPos = y;
}

void
anim::set_move_step( int x, int y )
{
	xStep = x;
	yStep = y;
}

int
anim::get_x_pos( void )
{
	return( xPos );
}

int
anim::get_y_pos( void )
{
	return( yPos );
}
// $Id: anim.cpp,v 1.2 2001/02/16 20:59:51 tom Exp $
//
// $Log: anim.cpp,v $
// Revision 1.2  2001/02/16 20:59:51  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:25  brown
// Working toward Windows integration
//
// Revision 1.2  2000/10/06 19:29:03  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.3  1999/12/25 08:18:32  tom
// Added "Id" and "Log" CVS keywords to source code.
//
