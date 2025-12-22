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
#include "tiles.h"
#include "graph.h"
#include "gamelogic.h"

//#define DEBUG_FUNC

Ctile_moving::Ctile_moving( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_moving::constructor( )" << endl;
#endif
}

Ctile_moving::~Ctile_moving( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_moving::destructor( )" << endl;
#endif
}

void Ctile_moving::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_moving::draw_under( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	int pm;

	switch( CURMAP->maxBallsInMotion )
	{
	case 3:
		pm = BMP_BALLMOVE3_0;
		break;
	case 4:
		pm = BMP_BALLMOVE4_0;
		break;
	default:
		pm = BMP_BALLMOVE5_0;
		break;
	}

	pm += CURMAP->get_moving_balls( );
	
	// Erase the old one
	graphDriver->graph_erase_pixmap( pm, ulX + 12, ulY + 5 );

	// Draw the base
	graphDriver->graph_draw( pm, ulX + 12, ulY + 5 );
}

void
Ctile_moving::anim_loop( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_moving::anim_loop( )" << endl;
#endif
}
// $Id: tile_moving.cpp,v 1.2 2001/02/16 21:00:06 tom Exp $
//
// $Log: tile_moving.cpp,v $
// Revision 1.2  2001/02/16 21:00:06  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:35  brown
// Working toward Windows integration
//
// Revision 1.2  2000/10/06 19:29:12  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.6  2000/02/22 04:03:33  brown
// Still more bitmap changes - new graphics and the like
//
// Revision 1.5  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
