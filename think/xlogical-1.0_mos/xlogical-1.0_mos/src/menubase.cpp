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



// Language Includes
#include <cerrno>
#include <iostream>

// Application Includes
#include "audio.h"
#include "exception.h"
#include "gamelogic.h"
#include "globals.h"
#include "graph.h"
#include "menubase.h"
#include "properties.h"
#include "sound_files.h"

class CMenuBase *CMenuBase::gTop = NULL;
int CMenuBase::fMainHeight = 0;
int CMenuBase::fMainWidth = 0;

CMenuBase::CMenuBase( void ) :
	fHilightable( true ),
	fHilighted( false ),
	fManager( false ),
	fParent( NULL ),
	fHeight( 0 ),
	fWidth( 0 ),
	fX( 0 ),
	fY( 0 ),
	fDrawFunc( NULL ),
	fRestoreFunc( NULL )
{
#if DEBUG & 1
	cout << ">CMenuBase::CMenuBase()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuBase::CMenuBase()" << endl;
#endif
}

CMenuBase::~CMenuBase( void )
{
#if DEBUG & 1
	cout << ">CMenuBase::~CMenuBase()" << endl;
#endif
	Children::iterator iter;

	// free all the children
	for( iter=fChildren.begin(); iter != fChildren.end(); ++iter )
	{
		delete (*iter);
	}
	fChildren.clear();

	// check if we are destroying the root
	if (gTop == this)
	{
		gTop = NULL;
	}

#if DEBUG & 1
	cout << "<CMenuBase::~CMenuBase()" << endl;
#endif
}

void
CMenuBase::AddChild( CMenuBase *aChild )
{
#if DEBUG & 1
	cout << ">CMenuBase::AddChild()" << endl;
#endif

	if (aChild == this)
	{
cout << "xxxmenubaseErrorxxx" << endl;
		ThrowEx( "cannot be a parent of oneself" );
	}
	if (aChild->fParent != NULL)
	{
cout << "xxxmenubaseErrorxxx" << endl;
		ThrowEx( "child already has a parent" );
	}

	aChild->fParent = this;
	fChildren.push_back( aChild );

#if DEBUG & 1
	cout << "<CMenuBase::AddChild()" << endl;
#endif
}

CMenuBase *
CMenuBase::ChildManager( void )
{
#if DEBUG & 1
	cout << ">CMenuBase::ChildManager()" << endl;
#endif

	Children::iterator iter;

	for( iter=fChildren.begin(); iter!=fChildren.end(); ++iter)
	{
		if ((*iter)->IsManager())
		{
			return( *iter );
		}
	}

#if DEBUG & 1
	cout << "<CMenuBase::ChildManager()" << endl;
#endif
	return( NULL );
}

void
CMenuBase::Click( int aX, int aY, int aButton )
{
#if DEBUG & 1
	cout << ">CMenuBase::Click()" << endl;
	cout << "aX=" << aX << " aY=" << aY << " aButton=" << aButton << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuBase::Click()" << endl;
#endif
}

void_func
CMenuBase::DrawFunc( void )
{
	return( fDrawFunc );
}

void_func
CMenuBase::RestoreFunc( void )
{
	return( fRestoreFunc );
}

void
CMenuBase::HandleClick( int aX, int aY, int aButton )
{
#if DEBUG & 1
	cout << ">CMenuBase::HandleClick()" << endl;
	cout << "aX=" << aX << " aY=" << aY << " aButton=" << aButton << endl;
#endif

	if (gTop == NULL)
	{
cout << "xxxmenubaseErrorxxx" << endl;
		ThrowEx( "CMenuBase::gTop not set" );
	}

	gTop->Click( aX, aY, aButton );

#if DEBUG & 1
	cout << "<CMenuBase::HandleClick()" << endl;
#endif
}

void
CMenuBase::HandleLoop( void )
{
#if DEBUG & 1
	cout << ">CMenuBase::HandleLoop()" << endl;
#endif
	if (gTop == NULL)
	{
cout << "xxxmenubaseErrorxxx" << endl;
		ThrowEx( "CMenuBase::gTop not set" );
	}

	graphDriver->graph_clear_rect( 0, 0, fMainWidth, fMainHeight );
	gTop->Draw();

#if DEBUG & 1
	cout << "<CMenuBase::HandleLoop()" << endl;
#endif
}

void
CMenuBase::HandleKeyPress( keysyms aKeyval )
{
#if DEBUG & 1
	cout << ">CMenuBase::HandleKeyPress()" << endl;
	cout << "aKeyVal=" << static_cast<int>( aKeyval ) << endl;
#endif

	if (gTop == NULL)
	{
cout << "xxxmenubaseErrorxxx" << endl;
		ThrowEx( "CMenuBase::gTop not set" );
	}

	gTop->Keypress( aKeyval );

#if DEBUG & 1
	cout << "<CMenuBase::HandleKeyPress()" << endl;
#endif
}

int
CMenuBase::Height( void )
{
#if DEBUG & 1
	cout << ">CMenuBase::Height()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuBase::Height()" << endl;
#endif
	return( fHeight );
}

bool
CMenuBase::IsHilightable( void )
{
	return( fHilightable );
}

bool
CMenuBase::IsManager( void )
{
	return( fManager );
}

void
CMenuBase::Keypress( keysyms aKeyval )
{
#if DEBUG & 1
	cout << ">CMenuBase::Keypress()" << endl;
	cout << "aKeyVal=" << static_cast<int>( aKeyval ) << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuBase::Keypress()" << endl;
#endif
}

void
CMenuBase::Manage( void )
{
#if DEBUG & 1
	cout << ">CMenuBase::Manage()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuBase::Manage()" << endl;
#endif
}

CMenuBase *
CMenuBase::Parent( void )
{
	return( fParent );
}

CMenuBase *
CMenuBase::ParentManager( void )
{
#if DEBUG & 1
	cout << ">CMenuBase::ParentManager()" << endl;
#endif

	CMenuBase *tmp = fParent;

	while( tmp && !tmp->IsManager() )
	{
		tmp = tmp->Parent();
	}

#if DEBUG & 1
	cout << "<CMenuBase::ParentManager()" << endl;
#endif
	return( tmp );
}

void
CMenuBase::SetHilighted( bool aHilighted )
{
#if DEBUG & 1
	cout << ">CMenuBase::SetHilighted()" << endl;
#endif

	if (fHilightable)
	{
		fHilighted = aHilighted;
	}

#if DEBUG & 1
	cout << "<CMenuBase::SetHilighted()" << endl;
#endif
}

void
CMenuBase::SetPos( int aX, int aY )
{
#if DEBUG & 1
	cout << ">CMenuBase::SetPos()" << endl;
	cout << "aX=" << aX << " aY=" << aY << endl;
#endif

	fX = aX;
	fY = aY;

#if DEBUG & 1
	cout << "<CMenuBase::SetPos()" << endl;
#endif
}

void
CMenuBase::Start(
	int aWidth,
	int aHeight,
	void_func aDrawFunc,
	void_func aRestoreFunc )
{
#if DEBUG & 1
	cout << ">CMenuBase::Start()" << endl;
#endif

	gTop = this;
	audioDriver->play_sound( soundFiles[SOUND_MENU_CLICK] );

	// calculate size of menu item(s)
	Realize();

	// calculate initial starting position
	fMainWidth = aWidth;
	fMainHeight = aHeight;

	if (aDrawFunc)
	{
		fDrawFunc = aDrawFunc;
	}
	if (aRestoreFunc)
	{
		fRestoreFunc = aRestoreFunc;
	}

	// set graphics callbacks for menu
	graphDriver->graph_set_click_func( HandleClick );
	graphDriver->graph_set_key_press_func( HandleKeyPress );
	graphDriver->graph_set_loop_func( HandleLoop );

	// calculate position of children
	Manage();

	if (fDrawFunc)
	{
		fDrawFunc();

		graphDriver->graph_clear_rect( 0, 0, fMainWidth, fMainHeight );
		Draw();
	}

#if DEBUG & 1
	cout << "<CMenuBase::Start()" << endl;
#endif
}

int
CMenuBase::Width( void )
{
#if DEBUG & 1
	cout << ">CMenuBase::Width()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuBase::Width()" << endl;
#endif

	return( fWidth );
}

// $Id: menubase.cpp,v 1.3 2001/02/19 03:03:54 tom Exp $
//
// $Log: menubase.cpp,v $
// Revision 1.3  2001/02/19 03:03:54  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.2  2001/02/16 20:59:59  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:29  brown
// Working toward Windows integration
//
// Revision 1.6  2000/10/06 19:29:09  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.5  2000/10/03 01:50:28  tom
// removed unused code
//
// Revision 1.4  2000/10/01 18:11:18  tom
// fixed menu background drawing
//
// Revision 1.3  2000/10/01 17:11:33  tom
// fixed some of the menu redrawing bugs
//
// Revision 1.2  2000/10/01 05:00:25  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.10  2000/01/23 06:11:39  tom
// - changed menu stuff to take 1 call back that is called to restore the
//   graphDriver state and do whatever else is necessary to switch states.
// - created centralized state switching routines to make it easier to hook in
//   mod changing, etc.
// - xlogical now supports intro.mod, pregame.mod, ingame.mod, & user mods
//   (still need to hook in highscore.mod and endgame.mod)
//
// Revision 1.9  1999/12/28 07:36:23  tom
// Fixed menu refresh problems.
//
// Revision 1.8  1999/12/25 08:18:37  tom
// Added "Id" and "Log" CVS keywords to source code.
//
