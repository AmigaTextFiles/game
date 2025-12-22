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

Ctile_order::Ctile_order( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_order::constructor( )" << endl;
#endif
}

Ctile_order::~Ctile_order( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_order::destructor( )" << endl;
#endif
}

void
Ctile_order::draw_under( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_order::draw( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	
	graphDriver->graph_draw_perm( BMP_ORDER, 0, 0, ulX, ulY, 64, 64 );
}

void
Ctile_order::draw_over( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_order::draw( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	int i = 0;
	int done = 0;
	int pm = 0;
	int xOff = 23;
	int yOff = 0;

	// Erase 
	graphDriver->graph_erase_rect( ulX, ulY, 64, 64 );
	
	// Is there a ball order to display?
	if( CURMAP->order[0] != NO_COLOR )
	{
		// Loop through the ball order stuff
		while( !done )
		{
			// Set our Y offsets
			switch( i )
			{
			case 0:
				yOff = 4;
				break;
			case 1:
				yOff = 23;
				break;
			case 2:
				yOff = 42;
				break;
			default:
				done = 1;
				break;
			}

			// Set our pixmap
			switch( CURMAP->order[i] )
			{
			case C1:
				pm = BMP_GEM_C1;
				break;
			case C2:
				pm = BMP_GEM_C2;
				break;
			case C3:
				pm = BMP_GEM_C3;
				break;
			case C4:
				pm = BMP_GEM_C4;
				break;
			default:
				// No color assigned - skip it
				done = 1;
				break;
			}

			// Are we skipping this?
			if( !done )
			{
				graphDriver->graph_draw_pixmap( 
					pm, 
					0,
					0,
					ulX + xOff, 
					ulY + yOff,
					18,
					18,
					USE_MASK );
			}
			// Increment our loop var
			i++;
		}
	}
}

void
Ctile_order::anim_loop( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_order::anim_loop( )" << endl;
#endif

}
// $Id: tile_order.cpp,v 1.2 2001/02/16 21:00:07 tom Exp $
//
// $Log: tile_order.cpp,v $
// Revision 1.2  2001/02/16 21:00:07  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:35  brown
// Working toward Windows integration
//
// Revision 1.3  2000/10/06 19:29:12  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.2  2000/09/30 17:33:15  brown
// Fixed timer drawing and order/pattern refreshes
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.4  1999/12/25 08:18:40  tom
// Added "Id" and "Log" CVS keywords to source code.
//
