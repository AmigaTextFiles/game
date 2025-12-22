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
#include "text.h"
#include "menutext.h"

CMenuText::CMenuText( void ) :
	fText( "" )
{
#if DEBUG & 1
	cout << ">CMenuText::CMenuText()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuText::CMenuText()" << endl;
#endif
}

CMenuText::CMenuText( const string &aText ) :
	fText( aText )
{
#if DEBUG & 1
	cout << ">CMenuText::CMenuText()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuText::CMenuText()" << endl;
#endif
}

CMenuText::~CMenuText( void )
{
#if DEBUG & 1
	cout << ">CMenuText::~CMenuText()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuText::~CMenuText()" << endl;
#endif
}

void
CMenuText::Click( int aX, int aY, int aButton )
{
#if DEBUG & 1
	cout << ">CMenuText::Click()" << endl;
	cout << "aX=" << aX << " aY=" << aY << " aButton=" << aButton << endl;
#endif

	if (aButton == 1)
	{
		Selected();
	}

#if DEBUG & 1
	cout << "<CMenuText::Click()" << endl;
#endif
}

void
CMenuText::Draw( void )
{
#if DEBUG & 1
	cout << ">CMenuText::Draw()" << endl;
#endif

	CText *font = NULL;

	if ((fX >= 0) && (fX+fWidth < fMainWidth) &&
		(fY >= 0) && (fY+fHeight < fMainHeight))
	{
		if (fHilighted)
		{
			font = graphDriver->graph_hi_font();
			font->render_string((char *) fText.c_str( ), fX, fY );
		} else {
			font = graphDriver->graph_lo_font();
			font->render_string( (char *)fText.c_str( ), fX, fY );
		}
	}

#if DEBUG & 1
	cout << "<CMenuText::Draw()" << endl;
#endif
}

void
CMenuText::Realize( void )
{
#if DEBUG & 1
	cout << ">CMenuText::Realize()" << endl;
#endif

	fHeight = graphDriver->graph_hi_font( )->get_height( );
	fWidth = graphDriver->graph_hi_font( )->stringLen( const_cast<char *>(fText.c_str()) );

#if DEBUG & 1
	cout << "<CMenuText::Realize()" << endl;
#endif
}

void
CMenuText::Selected( void )
{
#if DEBUG & 1
	cout << ">CMenuText::Selected()" << endl;
#endif

	cout << "text=[" << fText.c_str() << "] selected!" << endl;

#if DEBUG & 1
	cout << "<CMenuText::Selected()" << endl;
#endif
}

void
CMenuText::SetText( const string &aText )
{
#if DEBUG & 1
	cout << ">CMenuText::SetText()" << endl;
#endif

	fText = aText;
	fWidth = graphDriver->graph_hi_font( )->stringLen( const_cast<char *>(fText.c_str()) );
	fX = (fMainWidth/2) - (Width()/2);

#if DEBUG & 1
	cout << "<CMenuText::SetText()" << endl;
#endif
}

// $Id: menutext.cpp,v 1.2 2001/02/16 21:00:01 tom Exp $
//
// $Log: menutext.cpp,v $
// Revision 1.2  2001/02/16 21:00:01  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:30  brown
// Working toward Windows integration
//
// Revision 1.4  2000/10/08 06:33:56  tom
// added video mode menu option
//
// Revision 1.3  2000/10/06 19:29:10  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.2  2000/10/01 17:11:34  tom
// fixed some of the menu redrawing bugs
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.4  2000/01/07 07:17:39  tom
// See if you like these kinds of menus... ;)
//
// Revision 1.3  1999/12/25 08:18:38  tom
// Added "Id" and "Log" CVS keywords to source code.
//
