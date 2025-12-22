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
  * A control for display / editing text.
  * 
  */
 
#ifndef TEXTBOX_H
#define TEXTBOX_H

#include "IWidget.h"
#include "Control.h"
#include "Theme.h"

#define MAX_TEXTBOX_CHARS 1023
#define CURSOR_FLASH_RATE 8

class TextBox : public Control
{

private:
	char text[MAX_TEXTBOX_CHARS+1];
	char cursorBuffer[MAX_TEXTBOX_CHARS+1];
	int cursor;
	int charCount;
	int width;
	int height;
	int charLimit;
	FontRes font;
	Uint32 cursorColour;
	int cursorScreenPos;
	int cursorFlashCount;
	
	void updateCursorScreenPos();
	
public:

	TextBox(Rect rect);
	virtual ~TextBox();
	
	// Text accessor methods
	const char* getText();
	void setText(const char* text);
	int getTextLimit();
	void setTextLimit(int limit);
	void setFont(FontRes font);
	
	// IWidget methods
	virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character );
};

#endif // TEXTBOX_H
