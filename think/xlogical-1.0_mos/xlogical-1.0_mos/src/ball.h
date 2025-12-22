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



// vim:ts=4
#ifndef BALL_H
#define BALL_H

// Application Includes
#include "defs.h"

class Cball {

public:
		void get_last_coordinates( float *x, float *y ) 
									{ *x = oldXPos; *y = oldYPos; }
		void get_coordinates( float *x, float *y ) { *x = xpos; *y = ypos; }
		void set_last_coordinates( float x, float y ) 
										{ oldXPos = x; oldYPos = y; }
		void set_coordinates( float x, float y ) { xpos = x; ypos = y; }
		void move( float x, float y ) { xpos += x; ypos += y; }
		color_t get_color( void  ) { return( color ); }
		void set_color( color_t c ) { color = c; }
		void set_direction( dir_t d ) { moveDirection = d; }
		dir_t get_direction( void ) { return( moveDirection ); }
		int is_active( void ) { return( active ); }
		void deactivate( void ) { active = 0; }
		int get_pixmap_num( void ) { return( pixmap_num); }
		void set_pixmap_num( int pn ) { pixmap_num = pn; }
		void set_no_move( void ) { dontMove = 1; }
		void clear_no_move( void ) { dontMove = 0; }
		int check_no_move( void ) { return( dontMove ); }
		Cball( ) { active = 1;  dontMove = 0; doMidPoint = true; }
		~Cball( ) { }

		bool doMidPoint;
private:
		dir_t moveDirection;
		color_t color;
		float xpos;
		float ypos;
		float oldXPos;
		float oldYPos;
		int active;
		int dontMove;
		int pixmap_num;
};

#endif
// $Id: ball.h,v 1.4 2001/03/15 09:38:53 tom Exp $
//
// $Log: ball.h,v $
// Revision 1.4  2001/03/15 09:38:53  tom
// added midpoint flag
//
// Revision 1.3  2001/02/16 20:59:52  tom
// did some WIN32 porting work on the code... just a few more files to go.
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
// Revision 1.6  1999/12/25 08:18:32  tom
// Added "Id" and "Log" CVS keywords to source code.
//
