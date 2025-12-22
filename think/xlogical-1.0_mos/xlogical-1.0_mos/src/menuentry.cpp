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



#include <cstdio>
#include <iostream>
#include "graph.h"
#include "exception.h"
#include "text.h"
#include "gamelogic.h"
#include "graph_keysyms.h"
#include "globals.h"
#include "menuentry.h"

const int CMenuEntry::kBlinkCountStart = 3;

CMenuEntry::CMenuEntry(
	const int aMaxLength ) :
	fOnOff( true ),
	fBlinkCount( kBlinkCountStart ),
	fMaxLength( aMaxLength ),
	fCursorPos( 0 ),
	fText( "" )
{
#if DEBUG & 1
	cout << ">CMenuEntry::CMenuEntry()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuEntry::CMenuEntry()" << endl;
#endif
}

CMenuEntry::~CMenuEntry( void )
{
#if DEBUG & 1
	cout << ">CMenuEntry::~CMenuEntry()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuEntry::~CMenuEntry()" << endl;
#endif
}

void
CMenuEntry::Click( int aX, int aY, int aButton )
{
#if DEBUG & 1
	cout << ">CMenuEntry::Click()" << endl;
	cout << "aX=" << aX << " aY=" << aY << " aButton=" << aButton << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuEntry::Click()" << endl;
#endif
}

void
CMenuEntry::Draw( void )
{
#if DEBUG & 1
	cout << ">CMenuEntry::Draw()" << endl;
#endif
	CText *font = NULL;

	if (fHilighted)
	{
		font = graphDriver->graph_hi_font();
	} else {
		font = graphDriver->graph_lo_font();
	}
	if ((fX >= 0) && (fX+fWidth < fMainWidth) &&
		(fY >= 0) && (fY+fHeight < fMainHeight))
	{
		font->render_string((char *) fText.c_str( ), fX, fY );
	}
	if (fBlinkCount <= 0)
	{
		fBlinkCount = kBlinkCountStart;
		fOnOff = !fOnOff;
	} else {
		fBlinkCount -= 1;
	}
	if (fOnOff)
	{
		font->render_string(
			"*",
			fX + graphDriver->graph_hi_font( )->stringLen( const_cast<char *>(fText.c_str() ) ),
			fY );
	} else {
		graphDriver->graph_clear_rect(
			fX + graphDriver->graph_hi_font()->stringLen( const_cast<char *>(fText.c_str() ) ),
			fY,
			graphDriver->graph_hi_font()->stringLen( "*" ),
			graphDriver->graph_hi_font()->get_height() );
	}

#if DEBUG & 1
	cout << "<CMenuEntry::Draw()" << endl;
#endif
}

void
CMenuEntry::Keypress( keysyms aKeyval )
{
#if DEBUG & 1
	cout << ">CMenuEntry::Keypress()" << endl;
#endif

	// erase the cursor
	graphDriver->graph_clear_rect(
		fX + graphDriver->graph_hi_font()->stringLen( const_cast<char *>(fText.c_str() ) ),
		fY,
		graphDriver->graph_hi_font()->stringLen( "*" ),
		graphDriver->graph_hi_font()->get_height() );

	switch( aKeyval )
	{
		case eEnter:
			Selected();
			break;
		case eLeft:
			if (fCursorPos > 0)
			{
				fCursorPos -= 1;
			}
			break;
		case eRight:
			if ((fCursorPos < fMaxLength) &&
				(fCursorPos < static_cast<int>(fText.length())))
			{
				fCursorPos += 1;
			}
			break;
		case eDelete:
			fText.erase(fCursorPos, 1);
			break;
		case eBackSpace:
			if (fCursorPos > 0)
			{
				fText.erase(fCursorPos-1, 1);
				fCursorPos -= 1;
			}
			break;
		default:
			if (fCursorPos < fMaxLength)
			{
				char str[2];
				str[0] = keysym_to_char( aKeyval );
				str[1] = '\0';
				fText.replace(fCursorPos, 1, str);
				fCursorPos += 1;
			}
			break;
	}

#if DEBUG & 1
	cout << "<CMenuEntry::Keypress()" << endl;
#endif
}

void
CMenuEntry::Manage( void )
{
#if DEBUG & 1
	cout << ">CMenuEntry::Manage()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuEntry::Manage()" << endl;
#endif
}

void
CMenuEntry::Realize( void )
{
#if DEBUG & 1
	cout << ">CMenuEntry::Realize()" << endl;
#endif

	// calculate size of text part
	fHeight = graphDriver->graph_hi_font( )->get_height( );
	char *buf = new char[fMaxLength+1];
	sprintf( buf, "%*s", fMaxLength, "" );
	fWidth = graphDriver->graph_hi_font( )->stringLen( buf );
	delete [] buf;

#if DEBUG & 1
	cout << "<CMenuEntry::Realize()" << endl;
#endif
}

void
CMenuEntry::Reset( void )
{
#if DEBUG & 1
	cout << ">CMenuEntry::Reset()" << endl;
#endif

	fText.erase();
	fCursorPos = 0;
	fOnOff = true;
	fBlinkCount = kBlinkCountStart;

#if DEBUG & 1
	cout << "<CMenuEntry::Reset()" << endl;
#endif
}

void
CMenuEntry::Selected( void )
{
#if DEBUG & 1
	cout << ">CMenuEntry::Selected()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuEntry::Selected()" << endl;
#endif
}

void
CMenuEntry::SetHilighted( bool aHilighted )
{
#if DEBUG & 1
	cout << ">CMenuEntry::SetHiglighted()" << endl;
#endif

	CMenuBase::SetHilighted( aHilighted );

#if DEBUG & 1
	cout << "<CMenuEntry::SetHiglighted()" << endl;
#endif
}

// $Id: menuentry.cpp,v 1.2 2001/02/16 21:00:00 tom Exp $
//
// $Log: menuentry.cpp,v $
// Revision 1.2  2001/02/16 21:00:00  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:29  brown
// Working toward Windows integration
//
// Revision 1.5  2000/10/06 19:29:09  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.4  2000/10/01 19:28:01  tom
// - removed all references to CFont
// - fixed password entry menu item
//
// Revision 1.3  2000/10/01 18:11:18  tom
// fixed menu background drawing
//
// Revision 1.2  2000/10/01 17:11:34  tom
// fixed some of the menu redrawing bugs
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.2  1999/12/25 08:18:38  tom
// Added "Id" and "Log" CVS keywords to source code.
//
