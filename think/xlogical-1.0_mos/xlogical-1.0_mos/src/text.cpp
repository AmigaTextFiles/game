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
#include <iostream>
#include <cstring>
#include <cctype>

// Application Includes
#include "text.h"
#include "graph.h"
#include "defs.h"

//#define DEBUG_FUNC
//#define DEBUG1

CText::CText( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : CText::constructor( )" << endl;
#endif
	str		= NULL;
	loop	= 0;
	// Default font info
	pm		= BMP_FONT_4;
	cWidth	= 5;
	cHeight = 9;
	speed	= 1;
	spacing = 3;
	widthList = NULL;
	startChar = ' ';
	endChar = '`';
}

CText::~CText( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : CText::destructor( )" << endl;
#endif
	delete [] str;
}

void
CText::set_string( char *s )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : set_string( )" << endl;
#endif
	// Delete the old
	delete [] str;

	// Make room for the new
	str = new char [ strlen( s ) + 1 ];

	// Copy in the new
	strcpy( str, s );

	// Reset the scroll status stuff
	pixSkip = 0;
	currentChar = 0;
	leadPix = endX - startX;
}

void
CText::set_bounds( int x, int xPrime, int y )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : set_bounds( )" << endl;
#endif
	startX = x;
	endX = xPrime;
	ulY = y;
	pixSkip = 0;
	currentChar = 0;
	leadPix = endX - startX;
}

char
CText::fix_case( char c )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : fix_case( )" << endl;
#endif
	if( endChar >= 'z' )
	{
		return( c );
	}
	return( toupper( c ) );
}

void
CText::set_font_info( int fontPm, int width, int height, int spc,
												char start, char end )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : set_font_info( )" << endl;
#endif
	pm = fontPm;
	cWidth = width;
	spacing = spc;
	cHeight = height;
	widthList = NULL;
	startChar = start;
	endChar = end;
	numCharacters = end - start;
}

void
CText::set_font_info( int fontPm, int widths[], int height, int spc,
												char start, char end )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : set_font_info( )" << endl;
#endif
	int i 			= 0;
	int offsetTotal = 0;
	int maxWidth = 0;

	pm = fontPm;
	cHeight = height;
	spacing = spc;

	// Set the start and end
	startChar = start;
	endChar = end;
	numCharacters = end - start;

	// Make space for our width list
	widthList = new int[ numCharacters ];
	offsets = new int[ numCharacters ];

	// Generate the offsets and widths
	for( i = 0; i < numCharacters; i++ )
	{
		widthList[i] = widths[i];
		// Set the offset from the left
		offsets[i] = offsetTotal;
		offsetTotal += widths[i] + 1;
		if( widths[i] > maxWidth )	
		{
			maxWidth = widths[i];
		}
	}
	// Set a max
	cWidth = maxWidth;
}

void
CText::draw( void )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : draw( )" << endl;
#endif
	char c 			= 0;
	int stringIndex = 0;
	int charsDrawn	= 0;
	int xPos		= 0;
	int currWidth	= 0;

	// Ok, where do we start?
	xPos = startX + leadPix;

	// Step this back to 0
	leadPix = leadPix - speed;
	if( leadPix < 0 )
	{
		leadPix = 0;
	}

	// Only do this if we're drawing at the beginning of the clip area
	if( xPos == startX )
	{
		// Draw the first character ( partial )
		stringIndex = currentChar;
		c = fix_case( str[stringIndex] );

		currWidth = get_char_width( c );

		if( currWidth - pixSkip > 0 )
		{
			render_char(
				c,
				pixSkip,
				0,
				startX,
				ulY,
				currWidth - pixSkip,
				cHeight );
		}

		// Skip to where the next character starts
		xPos = startX + ( currWidth - pixSkip ) + spacing;

		// Step along the character
		pixSkip += speed;

		// Are we on to the next character?
		if( pixSkip > currWidth + spacing )
		{
			pixSkip = pixSkip % ( currWidth + spacing );
			currentChar++;

			// Have we stepped past the last character?
			if( currentChar > (int) strlen( str ) )
			{
				// Yep - reset
				currentChar = 0;
				pixSkip = 0;
				leadPix = endX - startX;
				return;
			}
		}
		stringIndex++;
	} else {
		stringIndex = currentChar;
	}

	c = fix_case( str[stringIndex] );
	// Now draw until we have no more space or we're out of text
	while( (stringIndex < (int)strlen( str )) 
		&& (xPos + get_char_width( c ) < endX) )
	{
		c = fix_case( str[stringIndex] );

		currWidth = get_char_width( c );
		render_char(
			c,
			0,
			0,
			xPos,
			ulY,
			currWidth,
			cHeight );
		xPos = xPos + currWidth + spacing;
		stringIndex++;
		charsDrawn++;
	}

	//cerr << "HERE3" << endl;
	//cerr << endX << " " << xPos << " " << endX - xPos  << " " <<
	//get_char_width( c )<< endl;
	//getchar( );

	// If our spacing kicked us over the limit, bail
	if( xPos > endX )
	{
		return;
	}

	c = fix_case( str[stringIndex] );

	// Do we need to draw a partial end character?
	if( (xPos + get_char_width( c ) >= endX) && (endX - xPos > 0 ) )
	{
		// We're out of room.  Draw the last character (partial)
		render_char(
			c,
			0,
			0,
			xPos,
			ulY,
			endX - xPos,
			cHeight );

		return;
	}

	// Ok, we're out of text.  NOW what?

	return;  // I guess
}

int
CText::get_char_width( char c )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : get_char_width( )" << endl;
#endif
	if( widthList == NULL )
	{
		return( cWidth );
	} else {
		return( widthList[ c-startChar ] );
	}
}

int
CText::get_char_offset( char c )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : get_char_offset( )" << endl;
#endif
	if( widthList == NULL )
	{
		return( (cWidth + 1 ) * (c - startChar) );
	} else {
		return( offsets[c - startChar] );
	}
}

void
CText::render_string( char *str, int x, int y )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : render_string( )" << endl;
#endif
	char *p			= NULL;
	int charWidth	= 0;
	int posCounter	= 0;
	int index		= 0;
	char c			= 0;

	p = str;
	while( *p != '\0' )
	{
		c = fix_case( *p );

		// Get the width for this char
		charWidth = get_char_width( c );

		render_char(
			c,
			0,
			0,
			x + posCounter + spacing * index, 
			y, 
			charWidth, 
			cHeight );

		posCounter += charWidth;
		p++;
		index++;
	}
}

int
CText::stringLen( char *str )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : stringLen( )" << endl;
#endif
	char *p	= NULL;
	char c	= 0;
	int len	= 0;

	// Find the length of the string
	p = str;
	while( *p != '\0' )
	{
		c = fix_case( *p );

		// Get the width for this char
		len += get_char_width( c );
		len += spacing;
		p++;
	}	
	return( len );
}

void
CText::render_string_rjust( char *str, int xMax, int y )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : render_string_rjust( )" << endl;
#endif
	char *p			= NULL;
	int charWidth	= 0;
	int posCounter	= 0;
	int index		= 0;
	int xMin		= 0;
	char c			= 0;

	// Get the starting point
	xMin = xMax - stringLen( str );

	p = str;
	while( *p != '\0' )
	{
		c = fix_case( *p );

		// Get the width for this char
		charWidth = get_char_width( c );
		render_char(
			c, 
			0,
			0,
			xMin + posCounter + spacing * index, 
			y, 
			charWidth, 
			cHeight );

		posCounter += charWidth;
		p++;
		index++;
	}
}

void
CText::render_string_center( char *str, int xMin, int xMax, int y )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : render_string_center( )" << endl;
#endif
	char *p			= NULL;
	int charWidth	= 0;
	int posCounter	= 0;
	int index		= 0;
	int startX		= 0;
	int len			= 0;
	char c			= 0;

	len = stringLen( str );

	startX = xMin + ( ( xMax - xMin ) - len ) / 2;

	p = str;
	while( *p != '\0' )
	{
		c = fix_case( *p );
		// Get the width for this char
		charWidth = get_char_width( c );
		render_char(
			c,
			0,
			0,
			startX + posCounter,
			y, 
			charWidth, 
			cHeight );

		posCounter += charWidth + spacing;
		p++;
		index++;
	}
}

void
CText::render_char( char c, int srcX, int srcY, int destX, int destY, 
									int width, int height )
{
#ifdef DEBUG_FUNC
	cerr << __FILE__ << " : render_char( )" << endl;
#endif
#ifdef DEBUG1
	cerr << "char:" << c << endl;
	cerr << "srcX:" << srcX << endl;
	cerr << "srcY:" << srcY << endl;
	cerr << "destX:" << destX << endl;
	cerr << "destY:" << destY << endl;
	cerr << "width:" << width << endl;
	cerr << "height:" << height << endl;
	cerr << "offset:" << get_char_offset( c ) << endl;
	cerr << "cWidth:" << cWidth << endl;
	cerr << "startchar:[" << startChar << "]" << endl;
	cerr << "[" << c << "] ";
	cerr << "(" << get_char_offset( c ) << ",";
	cerr << get_char_offset(c) + srcX << "," << srcY << ") ";
	cerr << "(" << destX << "," << destY << ")  ";
	cerr << "(" << width << "," << height << ")" << endl;
#endif

	if( (c >= startChar) && (c <= endChar) )
	{
		// Letters
		graphDriver->graph_draw_pixmap( 
			pm, 
			get_char_offset( c ) + srcX,
			srcY,
			destX, 
			destY,
			width,
			height,
			USE_MASK );
	}
}
// $Id: text.cpp,v 1.2 2001/02/16 21:00:05 tom Exp $
//
// $Log: text.cpp,v $
// Revision 1.2  2001/02/16 21:00:05  tom
// did some WIN32 porting work on the code... just a few more files to go.
//
// Revision 1.1  2001/01/20 17:32:34  brown
// Working toward Windows integration
//
// Revision 1.6  2000/10/25 16:45:24  brown
// Updated to build on vanilla RedHat 7.0
//
// Revision 1.5  2000/10/06 19:29:11  brown
// Added autoconf stuff
// Added GPL header to files
// Added WON scroller
// Added GPL to about screen
//
// Revision 1.4  2000/10/01 22:02:51  tom
// changed render_string() to do a toupper() on all characters in string
// to be rendered.
//
// Revision 1.3  2000/09/30 17:33:15  brown
// Fixed timer drawing and order/pattern refreshes
//
// Revision 1.2  2000/09/30 15:52:13  brown
// Fixed score display, text scrolling, window height, ball redraws
//
// Revision 1.1.1.1  2000/09/28 02:17:52  tom
// imported sources
//
// Revision 1.5  2000/02/21 23:06:36  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.4  2000/02/13 03:44:52  brown
// Start tile changes, as well as some font scroll changes
//
// Revision 1.3  1999/12/25 08:18:39  tom
// Added "Id" and "Log" CVS keywords to source code.
//
