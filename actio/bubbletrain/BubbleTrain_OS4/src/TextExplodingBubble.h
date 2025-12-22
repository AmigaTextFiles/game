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
  * A flying/exploding bubble with text on. This should only be a single 
  * character
  */
 
#ifndef TEXTEXPLODINGBUBBLE_H
#define TEXTEXPLODINGBUBBLE_H

#include "ExplodingBubble.h"

class TextExplodingBubble : public ExplodingBubble
{
private:
	
	char* text;
	Uint32 textHalfWidth;
	Uint32 textHalfHeight;

	void initialise();

public:

	TextExplodingBubble();
	TextExplodingBubble(Colour colour);
	TextExplodingBubble(SFX type);
	TextExplodingBubble(Colour colour, Point position);
	virtual ~TextExplodingBubble();
	
	// Text accessor methods
	void setText(const char* text);
	const char* getText();
	
	// IWidget methods
	virtual void animate();
	virtual void draw(SDL_Surface* screen);
};

#endif // TEXTEXPLODINGBUBBLE_H
