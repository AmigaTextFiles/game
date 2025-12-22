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
 
#include "Font.h"

///////////////////////////////////////////////////////////////////
// Public Methods
///////////////////////////////////////////////////////////////////

Font::Font(const char* fontFilename)
{
	if (fontFilename == NULL || !strcmp(fontFilename, ""))
		Log::Instance()->die(1, SV_FATALERROR, "Font::load unable to load blank filename");
	
	this->fontname = strdup(fontFilename);
	this->fontSurface = IMG_Load(fontFilename);
	if (this->fontSurface == NULL)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Font::load fontfile %s", fontFilename);
		Log::Instance()->die(1, SV_FATALERROR, "Font::load unable to load file %s", fontFilename);
	}
	Font::loadFont();
}

Font::~Font()
{
	delete[] fontname;
	SDL_FreeSurface(fontSurface);
}

char* Font::fontName()
{
	return this->fontname;	
}

Uint32 Font::height()
{
	return this->fontSurface->h;	
}

void Font::drawText(SDL_Surface* surface, Rect boundingBox,  VerticalAlign vAlign, HorizontalAlign hAlign, char* text, ... )
{
	
	char string[1024];          // Temporary string
	
	va_list ap;               	// Pointer To List Of Arguments
	va_start(ap, text);         // Parses The String For Variables
	vsprintf(string, text, ap); // Converts Symbols To Actual Numbers
	va_end(ap);               	// Results Are Stored In Text
	
	int len=strlen(string);		// Get the number of chars in the string
	int xx			= 0; 		// This will hold the place where to draw the next char
	int charIndex 	= 0;
	int leftEdge 	= 0;		// Use this to help with the horizontal alignment
	int topEdge		= 0;		// Use this to help with the vertical aligment
	int stringWidth = 0;
	
	// Figure out where to start the left edge based on the halignment
	switch (hAlign)
	{
		case Justified:
		case Left:
			leftEdge = (int)boundingBox.topLeft.x;
			break;
		case Centred:
			// Find the middle of the bounding box and the width of the text and use that
			stringWidth = Font::textWidth(string);
			leftEdge = (int)boundingBox.topLeft.x + (int)(boundingBox.width() / 2 ) - stringWidth / 2;
			break;
		case Right:
			stringWidth = Font::textWidth(string);
			leftEdge = (int)boundingBox.bottomRight.x - stringWidth;
			break;			
	}
	
	// Figure out where the top of the text should appear based on the vertical alignment
	switch (vAlign)
	{
		case Top:
			topEdge = (int)boundingBox.topLeft.y;
			break;
		case Middle:
			topEdge = (int)(boundingBox.topLeft.y + (boundingBox.height() / 2)) - (fontSurface->h / 2);
			break;
		case Bottom:
			topEdge = (int)boundingBox.bottomRight.y - fontSurface->h;
			break;	
	}
	
    SDL_Rect scr, dst;
    scr.h = fontSurface->h;
    scr.y = 0;
    scr.x = 0;
    dst.h = scr.h;
    
	for (int character = 0; character < len; character++)
	{
		// Space found
		if (string[character] == ' ')
		{
			xx += spaceWidth;
			continue;
		} 
		// Lookup the index of the character
		charIndex = Font::getCharacterIndex(string[character]);

		// If we don't support the character then skip it
		if (charIndex < 0)
			continue;	

		//Log::Instance()->log(SV_INFORMATION, "Character %c found char index %d", string[character], charIndex);
		scr.w = alphanum[charIndex].width;
		scr.x = alphanum[charIndex].x;
		scr.y = alphanum[charIndex].y;
		dst.w = scr.w;
		dst.x = leftEdge + xx;
		dst.y = topEdge;
		xx += scr.w + 1;
		
		// make sure we don't write any text outside of the bounding box
		if (dst.x < boundingBox.topLeft.x || dst.x + dst.w > boundingBox.bottomRight.x)
			break;
		
		SDL_BlitSurface (fontSurface, &scr, surface, &dst);
		
	}
}

Uint32 Font::textWidth(const char* text, ...)
{

  char string[1024];          // Temporary string
	
  va_list ap;                 // Pointer To List Of Arguments
  va_start(ap, text);         // Parses The String For Variables
  vsprintf(string, text, ap); // Converts Symbols To Actual Numbers
  va_end(ap);                 // Results Are Stored In Text
  
  int len=strlen(string);  // Get the number of chars in the string
  int width=0; // This will hold the place where to draw the next char
  int charIndex = -1;
  
  for (int character = 0; character < len; character++)
  {
		if (string[character] == ' ') {
			width += spaceWidth;
			continue;
		} 
		charIndex = Font::getCharacterIndex(string[character]);
		if (charIndex >= 0)
			width += alphanum[charIndex].width + 1;
			// Add an extra one for the space between characters
  }

  return width;
}


///////////////////////////////////////////////////////////////////
// Private Methods
///////////////////////////////////////////////////////////////////

/**
* Takes the font surface and create the character mappings I.e. where the
* individual characters appear on the font surface
* 
* 
* NOTE: There can be a problem when reading in fine width fonts. In that " can be registered as two characters
* if there is a space between them leaving all of the following characters out of place. This happened with the arial
* font. The only work around with the method we use is to either leave out " or make sure you don't have a space between
* the quotes
* 
*/
void Font::loadFont()
{
	if (fontSurface == NULL)
    {
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Couldn't find font surface to load");
    	return;
    }
	// We are going to parse the font by looking for characters that fall between blank lines.
	// i.e. a b c .... where there are 6 blank pixels between each character.
	// This allows use to have variable width fonts and to make everything nice and easy
    
    // Get the colour at (0,0) and use this as the blank colour.
    Uint32 blankColour = getPixel(fontSurface, 0, 0);

    // Set the transparency colour to the blank colour above.
    SDL_SetColorKey (fontSurface, SDL_SRCCOLORKEY, blankColour);
    
    int startX = -1;
    bool foundChar = false;
    int x;
    int charIndex = 0;
    SDL_Rect src, dst;
    
    src.h = (Uint16) fontSurface->h;
    src.y = 0;
    dst.h = src.h;
    dst.x = 0;
    dst.y = 0;
    
	for (x=0; x<fontSurface->w && charIndex < MAX_NUM_CHARACTERS; x++)
	{
		
		// if the column is blank then it must be time to save the previous character
		if (Font::isColumnBlank(fontSurface, x, blankColour))
		{
			if (foundChar)
			{
				// Take the current range and store the character
				Font::setCharacterRect(src, dst, startX, x, charIndex);  
				// reset the found char flag
				charIndex++;
				foundChar = false;
			}
		} 
		else if (!foundChar)
		{ 
			startX = x;
			foundChar = true;
        }
	}
	
	if (foundChar)
		Font::setCharacterRect(src, dst, startX, x, charIndex);  
	
	// Width of a space is the size of an i
	spaceWidth = alphanum[9].width;
	
}

void Font::setCharacterRect(SDL_Rect& src, SDL_Rect& dst, int startX, int currentX, int charIndex)
{
	src.x = startX;
	src.w = currentX - startX;
	dst.w = src.w;
	alphanum[charIndex].height = src.h;
	alphanum[charIndex].width	= src.w;
	alphanum[charIndex].x		= src.x;
	alphanum[charIndex].y		= src.y;
	alphanum[charIndex].character = CHARACTERLIST[charIndex];
	//Log::Instance()->log(SV_INFORMATION, "charIndex %d char %c, scr size w=%i, h=%i, x=%i, y=%i", charIndex, alphanum[charIndex].character, src.w, src.h, src.x, src.y);
}					 

bool Font::isColumnBlank(SDL_Surface *surface, int x, Uint32 colour)
{
	for (int y=0; y<surface->h; y++)
	{
		if (getPixel(surface, x, y) != colour)
			return false;
	}
	return true;
}

int Font::getCharacterIndex(char character)
{
	// characters are ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefhijklmnopqrstuvwxyz0123456789!"£$%^&*()_+-=[]{};'#:@~\/|?,.<>
	// maps to ascii  65-90                     97-122                   48-57     
	// character !, ord 33, charIndex 62
	// character £, ord 163, charIndex 63
	// character $, ord 36, charIndex 64
	// character %, ord 37, charIndex 65
	// character ^, ord 94, charIndex 66
	// character &, ord 38, charIndex 67
	// character *, ord 42, charIndex 68
	// character (, ord 40, charIndex 69
	// character ), ord 41, charIndex 70
	// character _, ord 95, charIndex 71
	// character +, ord 43, charIndex 72
	// character -, ord 45, charIndex 73
	// character =, ord 61, charIndex 74
	// character [, ord 91, charIndex 75
	// character ], ord 93, charIndex 76
	// character {, ord 123, charIndex 77
	// character }, ord 125, charIndex 78
	// character ;, ord 59, charIndex 79
	// character ', ord 39, charIndex 80
	// character #, ord 35, charIndex 81
	// character :, ord 58, charIndex 82
	// character @, ord 64, charIndex 83
	// character ~, ord 126, charIndex 84
	// character \, ord 92, charIndex 85
	// character /, ord 47, charIndex 86
	// character |, ord 124, charIndex 87
	// character ?, ord 63, charIndex 88
	// character ,, ord 44, charIndex 89
	// character ., ord 46, charIndex 90
	// character <, ord 60, charIndex 91
	// character >, ord 62, charIndex 92
	
	//Log::Instance()->log(SV_INFORMATION, "Mapping Character %c", character);
/*
  if ('0' <= character and  character <= '9') {
          return character + 4;
  } else if ('a' <= character and character <= 'z') {
          return character - 71;
  } else if ('A' <= character and character <= 'Z') {
          return character - 65;
  }
  
  switch (character)
  {
	case '!': 
		return 62;
	case '"': 
		return 63;
	case '£': 
		return 64;
	case '$': 
		return 65;
	case '%': 
		return 66;
	case '^': 
		return 67;
	case '&': 
		return 68;
	case '*': 
		return 69;
	case '(': 
		return 70;
	case ')': 
		return 71;
	case '_': 
		return 72;
	case '+': 
		return 73;
	case '-': 
		return 74;
	case '=': 
		return 75;
	case '[': 
		return 76;
	case ']': 
		return 77;
	case '{': 
		return 78;
	case '}': 
		return 79;
	case ';': 
		return 80;
	case '\'': 
		return 81;
	case '#': 
		return 82;
	case ':': 
		return 83;
	case '@': 
		return 84;
	case '~': 
		return 85;
	case '\\': 
		return 86;
	case '/': 
		return 87;
	case '|': 
		return 88;
	case '?': 
		return 89;
	case ',': 
		return 90;
	case '.': 
		return 91;
	case '<': 
		return 92;
	case '>': 
		return 93;
  }

  return -1;*/
  
  return CHARACTERMAPPING[(int)character];
}



	
