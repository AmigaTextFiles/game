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
 
#include "TextExplodingBubble.h"

TextExplodingBubble::TextExplodingBubble() : ExplodingBubble()
{
	TextExplodingBubble::initialise();
}

TextExplodingBubble::TextExplodingBubble(Colour colour) : ExplodingBubble(colour)
{
	TextExplodingBubble::initialise();
}

TextExplodingBubble::TextExplodingBubble(SFX type) : ExplodingBubble(type)
{
	TextExplodingBubble::initialise();
}

TextExplodingBubble::TextExplodingBubble(Colour colour, Point position) : ExplodingBubble(colour, position)
{
	TextExplodingBubble::initialise();
}

TextExplodingBubble::~TextExplodingBubble()
{
	if (this->text != NULL)
		delete this->text;
}

void TextExplodingBubble::setText(const char* text)
{
	if (this->text != NULL)
		delete this->text;
	
	this->text = strdup(text);
	
	// Work out the text size
	Theme::Instance()->textSize(FONT_MENU, &this->textHalfWidth, &this->textHalfHeight, this->text);
	this->textHalfWidth /= 2;
	this->textHalfHeight /= 2;
}

const char* TextExplodingBubble::getText()
{
	return this->text;
}
	
void TextExplodingBubble::animate()
{
	ExplodingBubble::animate();
	
}

void TextExplodingBubble::draw(SDL_Surface* screen)
{
	ExplodingBubble::draw(screen);
	
	// draw the text to the screen
	if (this->text != NULL)
	{
		Rect rText(this->position.x - this->textHalfWidth, this->position.y - this->textHalfHeight, this->position.x + this->textHalfWidth, this->position.y + this->textHalfHeight);
		Theme::Instance()->drawText(FONT_MENU, rText, Middle, Centred, this->text);
	}
}

void TextExplodingBubble::initialise()
{
	this->text 			= NULL;
	this->textHalfWidth = 0;
	this->textHalfHeight= 0;
}

