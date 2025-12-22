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
#include "graph.h"
#include "exception.h"
#include "gamelogic.h"
#include "globals.h"
#include "menuslider.h"
#include "properties.h"
#include "sound_files.h"
#include "text.h"

const float CMenuSlider::kSliderIncrement	= 0.05;
const int	CMenuSlider::kSliderWidth		= 128;
const int	CMenuSlider::kSliderHeight		= 32;
const int	CMenuSlider::kThumbWidth		= 8;
const int	CMenuSlider::kThumbHeight		= 16;

CMenuSlider::CMenuSlider(
	float aVal,
	const string &aString,
	const float aMax ) :
	fMax( aMax ),
	fValue( aVal )
{
#if DEBUG & 1
	cout << ">CMenuSlider::CMenuSlider()" << endl;
#endif

	fMenuText.SetText( aString );

#if DEBUG & 1
	cout << "<CMenuSlider::CMenuSlider()" << endl;
#endif
}

CMenuSlider::~CMenuSlider( void )
{
#if DEBUG & 1
	cout << ">CMenuSlider::~CMenuSlider()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuSlider::~CMenuSlider()" << endl;
#endif
}

void
CMenuSlider::Click( int aX, int aY, int aButton )
{
#if DEBUG & 1
	cout << ">CMenuSlider::Click()" << endl;
	cout << "aX=" << aX << " aY=" << aY << " aButton=" << aButton << endl;
#endif
	float minX, maxX;

	// erase the old thumb
	graphDriver->graph_clear_rect(
		(int)(fX + fMenuText.Width() 
		+ graphDriver->graph_hi_font()->get_width() +
			((fValue)/fMax * kSliderWidth) - kThumbWidth/2),
		fY + (Height() - kThumbHeight)/2,
		kThumbWidth,
		kThumbHeight );

	minX = fX + fMenuText.Width() + graphDriver->graph_hi_font()->get_width();
	maxX = minX + kSliderWidth;
	if ((aX >= minX) &&
		(aX <= maxX))
	{
		fValue = (aX - minX)/(maxX - minX) * fMax;
		Selected();
		audioDriver->play_sound( soundFiles[SOUND_MENU_CLICK] );
	}

#if DEBUG & 1
	cout << "<CMenuSlider::Click()" << endl;
#endif
}

void
CMenuSlider::Draw( void )
{
#if DEBUG & 1
	cout << ">CMenuSlider::Draw()" << endl;
#endif
	int sliderXPM;
	int thumbXPM;

	// draw the text part
	fMenuText.Draw();

	if (fHilighted)
	{
		sliderXPM = BMP_SLIDER;
		thumbXPM = BMP_SLIDER_THUMB;
	} else {
		sliderXPM = BMP_SLIDER;
		thumbXPM = BMP_SLIDER_THUMB;
	}

	// draw the slider and thumb parts
	graphDriver->graph_draw_pixmap(
		sliderXPM,
		0,				// srcX
		0,				// srcY
		fX + fMenuText.Width() + graphDriver->graph_hi_font()->get_width(),
		fY,
		kSliderWidth,
		kSliderHeight,
		USE_MASK );
	graphDriver->graph_draw_pixmap(
		thumbXPM,
		0,				// srcX
		0,				// srcY
		(int)(fX + fMenuText.Width() + 
			  graphDriver->graph_hi_font()->get_width() +
			((fValue)/fMax * kSliderWidth) - kThumbWidth/2),
		fY + (Height() - kThumbHeight)/2,
		kThumbWidth,
		kThumbHeight,
		USE_MASK );

#if DEBUG & 1
	cout << "<CMenuSlider::Draw()" << endl;
#endif
}

float
CMenuSlider::GetValue( void )
{
	return( fValue );
}

void
CMenuSlider::Keypress( keysyms aKeyval )
{
#if DEBUG & 1
	cout << ">CMenuSlider::Keypress()" << endl;
#endif

	// erase the old thumb
	graphDriver->graph_clear_rect(
		(int)(fX + fMenuText.Width()
			+ graphDriver->graph_hi_font()->get_width()
			+ ((fValue)/fMax * kSliderWidth) - kThumbWidth/2),
		fY + (Height() - kThumbHeight)/2,
		kThumbWidth,
		kThumbHeight );

	switch( aKeyval )
	{
		case eLeft:
			fValue -= kSliderIncrement * fMax;
			if (fValue < 0)
			{
				fValue = 0;
			}
			Selected();
			audioDriver->play_sound( soundFiles[SOUND_MENU_CLICK] );
			break;
		case eRight:
			fValue += kSliderIncrement * fMax;
			if (fValue > fMax)
			{
				fValue = fMax;
			}
			Selected();
			audioDriver->play_sound( soundFiles[SOUND_MENU_CLICK] );
			break;
		default:
			break;
	}

#if DEBUG & 1
	cout << "<CMenuSlider::Keypress()" << endl;
#endif
}

void
CMenuSlider::Manage( void )
{
#if DEBUG & 1
	cout << ">CMenuSlider::Manage()" << endl;
#endif

	fMenuText.SetPos( fX, fY );

#if DEBUG & 1
	cout << "<CMenuSlider::Manage()" << endl;
#endif
}

void
CMenuSlider::Realize( void )
{
#if DEBUG & 1
	cout << ">CMenuSlider::Realize()" << endl;
#endif

	// calculate dimensions of text part
	fMenuText.Realize();

	// calculate size of slider and text part
	fHeight = fMenuText.Height();
	fWidth = fMenuText.Width() + graphDriver->graph_hi_font()->get_width() + kSliderWidth;

#if DEBUG & 1
	cout << "<CMenuSlider::Realize()" << endl;
#endif
}

void
CMenuSlider::Selected( void )
{
#if DEBUG & 1
	cout << ">CMenuSlider::Selected()" << endl;
#endif

#if DEBUG & 1
	cout << "<CMenuSlider::Selected()" << endl;
#endif
}

void
CMenuSlider::SetHilighted( bool aHilighted )
{
#if DEBUG & 1
	cout << ">CMenuSlider::SetHiglighted()" << endl;
#endif

	fMenuText.SetHilighted( aHilighted );
	CMenuBase::SetHilighted( aHilighted );

#if DEBUG & 1
	cout << "<CMenuSlider::SetHiglighted()" << endl;
#endif
}

// $Id: menuslider.cpp,v 1.3 2001/02/19 03:03:55 tom Exp $
//
// $Log: menuslider.cpp,v $
// Revision 1.3  2001/02/19 03:03:55  tom
// hard coded names and paths of builtin music and sound files to be
// consistent with how image files are compiled into the executable and
// to make the properties/ini file simpler to port between Unix and WIN32
//
// Revision 1.2  2001/02/16 21:00:01  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:30  brown
// Working toward Windows integration
//
// Revision 1.7  2000/11/12 22:01:11  brown
// More typecast fixes
//
// Revision 1.6  2000/10/06 19:29:10  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.5  2000/10/01 19:28:02  tom
// - removed all references to CFont
// - fixed password entry menu item
//
// Revision 1.4  2000/10/01 18:11:18  tom
// fixed menu background drawing
//
// Revision 1.3  2000/10/01 17:10:19  tom
// fixed slider redraw when changing the thumb position
//
// Revision 1.2  2000/10/01 05:00:25  tom
// put in infrastructure for abstract audio drivers and started to code
// SDL_mixer support.
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.4  1999/12/25 08:18:38  tom
// Added "Id" and "Log" CVS keywords to source code.
//
