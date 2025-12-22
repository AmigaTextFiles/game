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
 
#include "TextBox.h"

TextBox::TextBox(Rect rect) : Control((int)rect.topLeft.x, (int)rect.topLeft.y)
{
	this->width = (int)rect.width();
	this->height = (int)rect.height();
	this->text[0] = 0;
	this->active = false;
	this->cursor = 0;
	this->cursorScreenPos = (int)this->point.x;
	this->charCount = 0;
	this->charLimit = MAX_TEXTBOX_CHARS;
	this->font = FONT_SCORE;
	this->setBevelType(BEV_INNER);
	this->cursorColour = SDL_MapRGB(SDL_GetVideoSurface()->format, 0xff, 0,0);
	this->cursorFlashCount = 0;
}

TextBox::~TextBox()
{

}

const char* TextBox::getText()
{
	return (const char*) this->text;
}

void TextBox::setText(const char* text)
{
	if (text == NULL)
		return;
	
	if (strlen(this->text) > MAX_TEXTBOX_CHARS)
	{
		strncpy(this->text, text, MAX_TEXTBOX_CHARS);
		this->text[MAX_TEXTBOX_CHARS+1]=0;	
	}
	else
		strcpy(this->text, text);
		
	this->charCount = strlen(this->text);
	this->cursor = this->charCount;
	TextBox::updateCursorScreenPos();
}

int TextBox::getTextLimit()
{
	return this->charLimit;	
}

void TextBox::setTextLimit(int limit)
{
	this->charLimit = limit;
}

void TextBox::setFont(FontRes font)
{
	this->font = font;
}

void TextBox::draw(SDL_Surface* screenDest)
{
	SDL_Rect screenRect;
	screenRect.x = (short int)this->point.x;
	screenRect.y = (short int)this->point.y;
	screenRect.w = this->width;
	screenRect.h = this->height;
	
	// Draw the background text box
	Uint32 colour;
	if (this->active)
		colour = this->activeColour; 
	else
		colour = this->inActiveColour;
	SDL_FillRect (screenDest, &screenRect, colour);
	
	// Draw a border around the textbox
	// Top and left in a dark colour
	// Bottom and right in a light colour
	Point bottomRight (this->point.x + this->width, this->point.y + this->height);
	// top
	Theme::Instance()->drawLine(screenDest, this->borderColTopLeft, this->point , Point(this->point.x + this->width, this->point.y));
	// bottom
	Theme::Instance()->drawLine(screenDest, this->borderColBottomRight, Point(this->point.x, this->point.y + this->height), bottomRight);
	// left
	Theme::Instance()->drawLine(screenDest, this->borderColTopLeft, this->point , Point(this->point.x, this->point.y + this->height));
	// right
	Theme::Instance()->drawLine(screenDest, this->borderColBottomRight, Point(this->point.x + this->width, this->point.y), bottomRight);
	
	// Draw the text with a border around it
	int thickness = 2;
	Rect size(this->point.x + thickness, this->point.y + thickness, this->point.x + this->width - thickness*2, this->point.y + this->height - thickness*2);
	Theme::Instance()->drawText(screenDest, this->font, size, Top, Left, "%s", this->text);
	
	// Draw in a cursor so we know where we are looking
	if (this->active)
	{
		// Get the cursor to flash on an off
		if (this->cursorFlashCount <= CURSOR_FLASH_RATE)
			Theme::Instance()->drawLine(screenDest, this->cursorColour, this->cursorScreenPos + thickness, (int)this->point.y + thickness, this->cursorScreenPos + thickness, (int)this->point.y + this->height - thickness*2);
			
		// Reset the counter after twice the max so it blinks on and off
		this->cursorFlashCount++;
		if (this->cursorFlashCount > CURSOR_FLASH_RATE * 2)
			this->cursorFlashCount = 0;
		
	}
	
}

bool TextBox::mouseDown(int x, int y)
{
	// Check if in my area
	if (x < this->point.x || this->point.x + this->width < x
	|| y < this->point.y || this->point.y + this->height < y)
	{
		this->active = false;
		return false;
	}

	this->active = true;
	this->fireClickEvent();
	return true;
}

bool TextBox::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	// Only append any text if the box is active
	if (!this->active)
		return false;
	
	// For now remove the cursor so they can only type at the end of the box. Should be ok to be this 
	// simple because it is only used for the FastestTime.
	switch (key)
	{
		case SDLK_BACKSPACE:
		case SDLK_DELETE:
		{
			if (this->charCount == 0)
				return false;
				
			if (this->cursor == this->charCount && key == SDLK_BACKSPACE)
			{
				this->text[--this->cursor] = 0;
			}
			else if (this->cursor == 0 && key == SDLK_BACKSPACE)
			{
				return false;
			}
			else
			{
				// If using the backspace then simple move the
				// position down one and do a normal delete.
				// Move the cursor down aswell so it maintains the same location
				int pos = this->cursor;
				if (key == SDLK_BACKSPACE)
				{
					if (this->cursor > 0)
						this->cursor--;
					pos--;
				}
					
				// move all of the characters after the cursor down
				for (int i=pos; i < this->charCount; i++)
					this->text[i] = this->text[i+1];
					
			}
			this->charCount--;
			this->fireChangeEvent();
			TextBox::updateCursorScreenPos();
			return true;
		}
		
		// Allow the cursor position to be moved around the text box.
		case SDLK_LEFT:
			this->cursor--;
			if (this->cursor < 0)
				this->cursor = 0;
			TextBox::updateCursorScreenPos();
			return true;
		case SDLK_RIGHT:
			this->cursor++;
			if (this->cursor > this->charCount)
				this->cursor = this->charCount;
			TextBox::updateCursorScreenPos();
			return true;
		case SDLK_END:
			this->cursor = this->charCount;
			TextBox::updateCursorScreenPos();
			return true;
		case SDLK_HOME:
			this->cursor = 0;
			TextBox::updateCursorScreenPos();
			return true;
		default:
			break;
	}
	
	// Make sure that we don't exced the limit
	if (this->charCount >= MAX_TEXTBOX_CHARS ||
		this->charCount >= this->charLimit)
		return false;
	
	
	// Characters supported by the font engine
	// ABCDEFGHIJKLMNOPQRSTUVWXYZ
	// abcdefghijklmnopqrstuvwxyz
	// 0123456789
	// !\"£$%^&*()_+-=[]{};'#:@~\\/|?,.<>
	
	// We are at the end of the text box
	if (character == 0)
	{
		// Map the keys to characters [a-zA-Z]
		if (SDLK_a <= key && key <= SDLK_z)
		{
			// if upper case then starts at 65
			// lower case starts at 97
			// SDLK_a is 97
			
			// Upper case
			if (mod & KMOD_SHIFT)
				character = key - 32;
			else
				character = key;
		}
		else if (key == SDLK_SPACE)
			character = ' ';
		/*
		SDLK_EXCLAIM	= 33,
		SDLK_QUOTEDBL	= 34,
		SDLK_HASH		= 35,
		SDLK_DOLLAR		= 36,
		SDLK_AMPERSAND	= 38,
		SDLK_QUOTE		= 39,
		SDLK_LEFTPAREN	= 40,
		SDLK_RIGHTPAREN	= 41,
		SDLK_ASTERISK	= 42,
		SDLK_PLUS		= 43,
		SDLK_COMMA		= 44,
		SDLK_MINUS		= 45,
		SDLK_PERIOD		= 46,
		SDLK_SLASH		= 47,
		SDLK_0			= 48,
		SDLK_1			= 49,
		SDLK_2			= 50,
		SDLK_3			= 51,
		SDLK_4			= 52,
		SDLK_5			= 53,
		SDLK_6			= 54,
		SDLK_7			= 55,
		SDLK_8			= 56,
		SDLK_9			= 57,
		SDLK_COLON		= 58,
		SDLK_SEMICOLON	= 59,
		SDLK_LESS		= 60,
		SDLK_EQUALS		= 61,
		SDLK_GREATER	= 62,
		SDLK_QUESTION	= 63,
		SDLK_AT			= 64,
		*/
		else if (SDLK_EXCLAIM <= key && key <= SDLK_AT)
			character = key;
		/*
		SDLK_LEFTBRACKET	= 91,
		SDLK_BACKSLASH		= 92,
		SDLK_RIGHTBRACKET	= 93,
		SDLK_CARET			= 94,
		SDLK_UNDERSCORE		= 95,
		*/
		else if (SDLK_LEFTBRACKET <= key && key <= SDLK_UNDERSCORE)
			character = key;

		/*		
		SDLK_KP0		= 256,
		SDLK_KP1		= 257,
		SDLK_KP2		= 258,
		SDLK_KP3		= 259,
		SDLK_KP4		= 260,
		SDLK_KP5		= 261,
		SDLK_KP6		= 262,
		SDLK_KP7		= 263,
		SDLK_KP8		= 264,
		SDLK_KP9		= 265,
		map to 
		SDLK_0			= 48,
		SDLK_1			= 49,
		SDLK_2			= 50,
		SDLK_3			= 51,
		SDLK_4			= 52,
		SDLK_5			= 53,
		SDLK_6			= 54,
		SDLK_7			= 55,
		SDLK_8			= 56,
		SDLK_9			= 57,
		*/
		else if (SDLK_KP0 <= key && key <= SDLK_KP9)
			character = key - 208;
			
		/* SDLK_KP_PERIOD 
		 * SDLK_PERIOD		= 46,
		 */
		else if (SDLK_KP_PERIOD == key)
			character = 46;
	}
	
	// Check to make sure we have a character to enter
	if (character == 0)
		return false;
	
	// Insert the character into the end of the textbox
	if (this->cursor == this->charCount)
	{
		this->text[this->cursor++] = character;
		this->text[this->cursor] = 0;
	}
	else
	{
		// Insert the character at the cursor and move everything after the cursor
		// on
		for (int i=this->charCount; i >= this->cursor; i--)
				this->text[i+1] = this->text[i];
				
		this->text[this->cursor++] = character;
	}
	this->charCount++;
	this->fireChangeEvent();
	TextBox::updateCursorScreenPos();
	return true;
	
}


void TextBox::updateCursorScreenPos()
{
	Uint32 cursorWidth = 0;
	Uint32 cursorHeight = 0;
	if (this->cursor != 0)
	{
		strncpy(this->cursorBuffer, text, this->cursor);
		this->cursorBuffer[this->cursor] = 0;
		Theme::Instance()->textSize(this->font, &cursorWidth, &cursorHeight, this->cursorBuffer);
	}
	
	this->cursorScreenPos = (int)this->point.x + cursorWidth;
}
