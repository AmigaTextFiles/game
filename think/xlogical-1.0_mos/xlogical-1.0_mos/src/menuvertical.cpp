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
#include "audio.h"
#include "exception.h"
#include "gamelogic.h"
#include "globals.h"
#include "menuvertical.h"
#include "properties.h"
#include "sound_files.h"

const int CMenuVertical::kTopOffset		= 32;
const int CMenuVertical::kBottomOffset	= 32;

CMenuVertical::CMenuVertical( const string &aString ) :
	CMenuText( aString )
{
#if DEBUG & 1
	cout << ">CMenuVertical::CMenuVertical()" << endl;
#endif

	fCurrChildIndex = -1;
	fManager = true;

#if DEBUG & 1
	cout << "<CMenuVertical::CMenuVertical()" << endl;
#endif
}

CMenuVertical::~CMenuVertical( void )
{
#if DEBUG & 1
	cout << ">CMenuVertical::~CMenuVertical()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuVertical::~CMenuVertical()" << endl;
#endif
}

void
CMenuVertical::Click( int aX, int aY, int aButton )
{
#if DEBUG & 1
	cout << ">CMenuVertical::Click()" << endl;
	cout << "aX=" << aX << " aY=" << aY << " aButton=" << aButton << endl;
#endif

	if (gTop == this)
	{
		if ((aButton == 1) &&
			!fChildren.empty())
		{
			for( int i=0; i < static_cast<int>(fChildren.size()); i++)
			{
				if ((aX >= fChildren[i]->X()) &&
					(aX <= fChildren[i]->X() + fChildren[i]->Width()) &&
					(aY >= fChildren[i]->Y()) &&
					(aY <= fChildren[i]->Y() + fChildren[i]->Height()) &&
					fChildren[i]->IsHilightable())
				{
					fChildren[fCurrChildIndex]->SetHilighted( false );
					fChildren[i]->SetHilighted( true );
					fCurrChildIndex = i;
					fChildren[i]->Click( aX, aY, aButton );

					RepositionChildren();
					break;
				}
			}
		}
	} else {
		CMenuText::Click( aX, aY, aButton );
	}

#if DEBUG & 1
	cout << "<CMenuVertical::Click()" << endl;
#endif
}

void
CMenuVertical::Draw( void )
{
#if DEBUG & 1
	cout << ">CMenuVertical::Draw()" << endl;
#endif

	if (gTop == this)
	{
		Children::iterator iter;

		for( iter=fChildren.begin(); iter != fChildren.end(); ++iter )
		{
			graphDriver->graph_clear_rect(
				(*iter)->X(), (*iter)->Y(),
				(*iter)->Width(), (*iter)->Height() );
			(*iter)->Draw();
		}
	} else {
		graphDriver->graph_clear_rect( X(), Y(), Width(), Height() );
		CMenuText::Draw();
	}

#if DEBUG & 1
	cout << "<CMenuVertical::Draw()" << endl;
#endif
}

void
CMenuVertical::Keypress( keysyms aKeyval )
{
#if DEBUG & 1
	cout << ">CMenuVertical::Keypress()" << endl;
#endif
	CMenuBase *mgr;

	switch( aKeyval )
	{
		case eEsc:
			if ((mgr = gTop->ParentManager()))
			{
				mgr->Start(
					graphDriver->graph_main_width(), 
					graphDriver->graph_main_height() );
			} else {
				if (fRestoreFunc)
				{
					(*fRestoreFunc)();
				}
			}
			break;
		case eEnter:
			Selected();
			break;
		case eUp:
			if (!fChildren.empty())
			{
				int i = fCurrChildIndex;

				audioDriver->play_sound( soundFiles[SOUND_MENU_CLICK] );
				fChildren[fCurrChildIndex]->SetHilighted( false );

				if (fCurrChildIndex > 0)
				{
					i--;
				} else {
					i = fChildren.size() - 1;
				}
				i = PrevHilightableChild( i );

				if (i != -1)
				{
					fCurrChildIndex = i;
				}
				fChildren[fCurrChildIndex]->SetHilighted( true );

				RepositionChildren();
			}
			break;
		case eDown:
			if (!fChildren.empty())
			{
				int i = fCurrChildIndex;

				audioDriver->play_sound( soundFiles[SOUND_MENU_CLICK] );
				fChildren[fCurrChildIndex]->SetHilighted( false );

				if (fCurrChildIndex < static_cast<int>(fChildren.size())-1)
				{
					i++;
				} else {
					i = 0;
				}
				i = NextHilightableChild( i );

				if (i != -1)
				{
					fCurrChildIndex = i;
				}
				fChildren[fCurrChildIndex]->SetHilighted( true );

				RepositionChildren();
			}
			break;
		default:
			fChildren[fCurrChildIndex]->Keypress( aKeyval );
			break;
	}

#if DEBUG & 1
	cout << "<CMenuVertical::Keypress()" << endl;
#endif
}

void
CMenuVertical::Manage( void )
{
#if DEBUG & 1
	cout << ">CMenuVertical::Manage()" << endl;
#endif

	if (gTop == this)
	{
		if ((!fChildren.empty()) && (fCurrChildIndex == -1))
		{
			fCurrChildIndex = NextHilightableChild( 0 );
			if (fCurrChildIndex != -1)
			{
				fChildren[fCurrChildIndex]->SetHilighted( true );
			}
		}

		int x, y;

		if (Height() < (fMainHeight - kTopOffset - kBottomOffset))
		{
			x = (fMainWidth/2) - (Width()/2);
			y = (fMainHeight/2) - (Height()/2);

			SetPos( x, y );

			for( int i=0, y=0; i<static_cast<int>(fChildren.size()); i++ )
			{
				fChildren[i]->SetPos(
					fX + (fWidth / 2) - (fChildren[i]->Width() / 2),
					fY + y );
				fChildren[i]->Manage();
				y += fChildren[i]->Height();
			}
		} else {
			RepositionChildren();
		}

	} else {
		CMenuText::Manage();
	}

#if DEBUG & 1
	cout << "<CMenuVertical::Manage()" << endl;
#endif
}

int
CMenuVertical::NextHilightableChild( int aChildIndex )
{
	for( int i=aChildIndex; i<static_cast<int>(fChildren.size()); i+=1 )
	{
		if (fChildren[i]->IsHilightable())
		{
			return( i );
		}
	}
	return( -1 );
}

int
CMenuVertical::PrevHilightableChild( int aChildIndex )
{
	for( int i=aChildIndex; i>=0; i-=1 )
	{
		if (fChildren[i]->IsHilightable())
		{
			return( i );
		}
	}
	return( -1 );
}

void
CMenuVertical::Realize( void )
{
#if DEBUG & 1
	cout << ">CMenuVertical::Realize()" << endl;
#endif

	if (gTop == this)
	{
		Children::iterator iter;

		fHeight = 0;
		fWidth = 0;
		for(iter=CMenuBase::fChildren.begin();
			iter != CMenuBase::fChildren.end();
			++iter )
		{
			(*iter)->Realize();
			if ((*iter)->Width() > fWidth)
			{
				fWidth = (*iter)->Width();
			}
			fHeight += (*iter)->Height();
		}
	} else {
		CMenuText::Realize();
	}

#if DEBUG & 1
	cout << "<CMenuVertical::Realize()" << endl;
#endif
}

void
CMenuVertical::RepositionChildren( void )
{
#if DEBUG & 1
	cout << ">CMenuVertical::RepositionChildren()" << endl;
#endif
	if ((Height() > (fMainHeight - kTopOffset - kBottomOffset)) &&
		!fChildren.empty())
	{
		int i, y;

		y = fMainHeight/2 - fChildren[fCurrChildIndex]->Height()/2;
		fChildren[fCurrChildIndex]->SetPos(
			fMainWidth/2 - fChildren[fCurrChildIndex]->Width()/2,
			y );
		for(i=fCurrChildIndex-1; i>=0; i-- )
		{
			y -= fChildren[i]->Height();
			fChildren[i]->SetPos(
				fMainWidth/2 - fChildren[i]->Width()/2,
				y );
		}
		for(i=fCurrChildIndex+1,
				y=fMainHeight/2 + fChildren[fCurrChildIndex]->Height()/2;
			i<static_cast<int>(fChildren.size());
			i++ )
		{
			fChildren[i]->SetPos(
				fMainWidth/2 - fChildren[i]->Width()/2,
				y );
			y += fChildren[i]->Height();
		}
	}

#if DEBUG & 1
	cout << "<CMenuVertical::RepositionChildren()" << endl;
#endif
}

void
CMenuVertical::Selected( void )
{
#if DEBUG & 1
	cout << ">CMenuVertical::Selected()" << endl;
#endif

	if (gTop == this)
	{
		if (fCurrChildIndex >= 0)
		{
			fChildren[fCurrChildIndex]->Selected();
		}
	} else {
		Start( 
			graphDriver->graph_main_width(), 
			graphDriver->graph_main_height(),
			ParentManager()->DrawFunc(),
			ParentManager()->RestoreFunc() );
	}

#if DEBUG & 1
	cout << "<CMenuVertical::Selected()" << endl;
#endif
}

// $Id: menuvertical.cpp,v 1.3 2001/02/19 03:03:55 tom Exp $
//
// $Log: menuvertical.cpp,v $
// Revision 1.3  2001/02/19 03:03:55  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.2  2001/02/16 21:00:01  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:31  brown
// Working toward Windows integration
//
// Revision 1.5  2000/10/06 19:29:10  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.4  2000/10/02 06:10:05  tom
// fixed one last (hopefully!) refresh bug in the intermission menu
//
// Revision 1.3  2000/10/01 18:11:18  tom
// fixed menu background drawing
//
// Revision 1.2  2000/10/01 05:00:25  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.8  2000/01/23 06:11:39  tom
// - changed menu stuff to take 1 call back that is called to restore the
//   graphDriver state and do whatever else is necessary to switch states.
// - created centralized state switching routines to make it easier to hook in
//   mod changing, etc.
// - xlogical now supports intro.mod, pregame.mod, ingame.mod, & user mods
//   (still need to hook in highscore.mod and endgame.mod)
//
// Revision 1.7  1999/12/28 22:53:39  tom
// Fixed level warp and menu refresh bug.
//
// Revision 1.6  1999/12/25 08:18:38  tom
// Added "Id" and "Log" CVS keywords to source code.
//
