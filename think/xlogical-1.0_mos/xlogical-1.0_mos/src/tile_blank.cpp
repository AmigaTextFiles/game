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

Ctile_blank::Ctile_blank( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blank::constructor( )" << endl;
#endif
}

Ctile_blank::~Ctile_blank( )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blank::destructor( )" << endl;
#endif
}

void
Ctile_blank::draw_under( int ulX, int ulY )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " Ctile_blank::draw( ";
	cerr << ulX << ", " << ulY << " )" << endl;
#endif
	
}
// $Id: tile_blank.cpp,v 1.2 2001/02/16 21:00:05 tom Exp $
//
// $Log: tile_blank.cpp,v $
// Revision 1.2  2001/02/16 21:00:05  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:34  brown
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
// Revision 1.6  1999/12/25 08:18:39  tom
// Added "Id" and "Log" CVS keywords to source code.
//
