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



#ifndef ANIM_H
#define ANIM_H
// Language Includes
#include <list>

#ifdef WIN32
using namespace std;
#endif

// Application Includes
#include "graph.h"

class anim
{
public:
	void set_pos(			int, int );	// Set the start position
	void set_move_step(		int, int );	// Set the x and y stepping
	void set_frame_range(	int, int ); // Set the range for animation
	void set_repeat_start(	int );		// Set the frame where repeats start
	void add_frame(			int );		// Set the range for animation
	void clear_frames(		void );		// Set the range for animation
	void reset_anim(		void ); 	// Advance to the next frame
	int advance_or_skip(	void ); 	// Advance to the next frame
	int advance(			void ); 	// Advance to the next frame
	int get_current_frame(	void );		// Get current anim frame
	int get_x_pos(			void );		// Get current x location
	int get_y_pos(			void );		// Get current y location
	int is_done(			void );		// Set the range for animation

	anim( void );
	~anim( void );
private:
	list< int >frames;
	list< int >::iterator repeatStart;
	list< int >::iterator currentFrame;
	int skip;		// # cycles to skip between frames
	int skipCounter;// # cycles to skip between frames
	int xPos;		// Upper-left X pos
	int yPos;		// Upper-left Y pos
	int xStep;		// Move per frame in x dir
	int yStep;		// Move per frame in y dir
	int animDone;	// Animation complete status
};

#endif
// $Id: anim.h,v 1.4 2001/02/16 20:59:52 tom Exp $
//
// $Log: anim.h,v $
// Revision 1.4  2001/02/16 20:59:52  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.3  2001/01/20 17:32:25  brown
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
