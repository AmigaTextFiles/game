/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 
 /*
  * The font class is responsible for loading bitmap fonts and drawing to windows.
  * 
  * The font is always in the same order and characters are separated by a clear 
  * vertical line of pixels. So when loading if there are any character with a 
  * space then the following items will be out of sync.
  * Once loaded it builds up a character mapping to bounding rectangle on the bitmap
  * image.
  * 
  */
 
#ifndef FONT_H
#define FONT_H

// System includes
#include <stdarg.h>		// Allows variable list arguments
#include <string.h>		// Basic string functions
#include <SDL/SDL_Image.h>

// Game includes
#include "General.h"
#include "Log.h"

// Constansts - defines the order / number of characters used in the fonts	
const char CHARACTERLIST[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!\"£$%^&*()_+-=[]{};'#:@~\\/|?,.<>";
const int MAX_NUM_CHARACTERS = 94;

// Character mapping with ascii codes to index in the above character list.
const int CHARACTERMAPPING[] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,62,63,82,65,66,68,81,70,
71,69,73,90,74,91,87,52,53,54,
55,56,57,58,59,60,61,83,80,92,
75,93,89,84,0,1,2,3,4,5,
6,7,8,9,10,11,12,13,14,15,
16,17,18,19,20,21,22,23,24,25,
76,86,77,67,72,-1,26,27,28,29,
30,31,32,33,34,35,36,37,38,39,
40,41,42,43,44,45,46,47,48,49,
50,51,78,88,79,85,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,64,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,-1,-1,-1,-1};

// Enums	
// Defines the vertical alignment for the text within the bounding box
enum VerticalAlign
{
	Top,
	Middle,
	Bottom	
};

// Defines the hozitonal alignment for the text within the bounding box
enum HorizontalAlign
{
	Left,
	Centred,
	Justified,
	Right
};	

// Struct to hold the basic information about the character and it's
// location within the bitmap font.
struct CharStruct
{
	char 		character;
	Uint16		height;
	Uint16		width;
	Uint16		x;
	Uint16		y;
};

class Font 
{
private:
	CharStruct alphanum[MAX_NUM_CHARACTERS];	// This is an array of characters 0-9 a-z A-Z .,-!?
	SDL_Surface* fontSurface;					// The bitmap font
	Uint32 spaceWidth;							// The width of a space usually the same size as the letter i
	char* fontname;								// The name of the font loaded
	
    void loadFont();
	bool isColumnBlank(SDL_Surface *surface, int x, Uint32 colour);
	int getCharacterIndex(char character);
	void setCharacterRect(SDL_Rect& src, SDL_Rect& dst, int startX, int currentX, int charIndex);

public:
  	Font(const char* Filename);
	~Font();
	
	char* fontName();
	
	void drawText(SDL_Surface* surface, Rect boundingBox,  VerticalAlign vAlign, HorizontalAlign hAlign, char* text, ... );	
    Uint32 textWidth(const char* text, ...);
    Uint32 height();
};


#endif
