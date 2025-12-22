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



#include <iostream>
#include "exception.h"
#include "menulabel.h"

CMenuLabel::CMenuLabel( void ) :
	CMenuText( "" )
{
#if DEBUG & 1
	cout << ">CMenuLabel::CMenuLabel()" << endl;
#endif

	fHilightable = false;

#if DEBUG & 1
	cout << "<CMenuLabel::CMenuLabel()" << endl;
#endif
}

CMenuLabel::CMenuLabel( const string &aText ) :
	CMenuText( aText )
{
#if DEBUG & 1
	cout << ">CMenuLabel::CMenuLabel()" << endl;
#endif

	fHilightable = false;

#if DEBUG & 1
	cout << "<CMenuLabel::CMenuLabel()" << endl;
#endif
}

CMenuLabel::~CMenuLabel( void )
{
#if DEBUG & 1
	cout << ">CMenuLabel::~CMenuLabel()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuLabel::~CMenuLabel()" << endl;
#endif
}

void
CMenuLabel::Selected( void )
{
#if DEBUG & 1
	cout << ">CMenuLabel::Selected()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuLabel::Selected()" << endl;
#endif
}

// $Id: menulabel.cpp,v 1.2 2001/02/16 21:00:00 tom Exp $
//
// $Log: menulabel.cpp,v $
// Revision 1.2  2001/02/16 21:00:00  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:30  brown
// Working toward Windows integration
//
// Revision 1.3  2000/10/06 19:29:09  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.2  2000/10/01 19:28:02  tom
// - removed all references to CFont
// - fixed password entry menu item
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.2  1999/12/25 08:18:38  tom
// Added "Id" and "Log" CVS keywords to source code.
//
