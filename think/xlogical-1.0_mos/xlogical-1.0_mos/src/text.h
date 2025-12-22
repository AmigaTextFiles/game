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



#ifndef TEXT_H
#define TEXT_H

class CText
{
public:
	void set_bounds(		int, int, int );
	void set_font_info(		int, int, int, int, char, char );
	void set_font_info(		int, int [], int, int, char, char );
	void set_string(		char * );
	int  stringLen(			char * );
	void render_string(		char *, int, int );
	void render_string_center(	char *, int, int, int );
	void render_string_rjust(	char *, int, int );
	void render_char(		char, int, int, int, int, int, int );
	void draw( 				void );
	void set_speed( 		int s ) { speed = s; }
	CText(					void );
	virtual ~CText(			void );
	int get_height( 		void ) { return( cHeight ); }
	int get_width( 			void ) { return( cWidth ); }
private:
	char fix_case(			char );
	char *str;				// String to scroll
	char startChar;			// ASCII number this font starts with
	char endChar;			// ASCII number this font starts with
	int	numCharacters;		// Number of characters in the font list
	int	loop;				// Are we looping? 
	int startX;				// X position of start of scroll area
	int endX;				// X position of end of scroll area
	int ulY;				// Upper left Y coordinate of scroll area
	int pm;					// Bitmap number
	int speed;				// Speed of scrolling
	int cWidth;				// Width of each character
	int cHeight;			// Height of each character
	int spacing;			// Space between characters
	int *widthList;			// List of character widths
	int *offsets;			// X offset from the left for each char
	int areaWidth;			// Width of the 
	int pixSkip;			// Number of pixels to skip from the first char
	int currentChar;		// Index into str where we're starting
	int leadPix;			// Number of pixels leading the text
	int get_char_width( 	char );
	int get_char_offset( 	char );
};

#endif
// $Id: text.h,v 1.3 2001/02/16 21:00:05 tom Exp $
//
// $Log: text.h,v $
// Revision 1.3  2001/02/16 21:00:05  tom
// did some WIN32 porting work on the code... just a few more files to go.
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
// Revision 1.4  2000/02/21 23:06:36  brown
// Updated a CRAPLOAD of graphics, fixed fonts and scrolling
//
// Revision 1.3  2000/02/13 03:44:52  brown
// Start tile changes, as well as some font scroll changes
//
// Revision 1.2  1999/12/25 08:18:39  tom
// Added "Id" and "Log" CVS keywords to source code.
//
