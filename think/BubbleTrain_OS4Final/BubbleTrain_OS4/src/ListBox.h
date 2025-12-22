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
  * A control to display lists of items. If there are more items than can be displayed
  * then use a scroll bar to reach the remainder of the list.
  * 
  * Each item consists of a display part and a value. It can also handle double clicks
  * and fires the approate command
  */
 
 
#ifndef LISTBOX_H
#define LISTBOX_H

// Game includes
#include "IWidget.h"
#include "Control.h"
#include "Theme.h"
#include "List.h"
#include "CallBack.h"

#define SCROLLBAR_WIDTH 15

class ListBox : public Control
{

private:

	// A single item in the list
	struct listItem
	{
		char* item;
		char* value;	
	};
	
	// List of items
	List<listItem*> listItems;
	DListIterator<listItem*> currentItem;
	
	int width;
	int height;
	
	// Scroll bar details
	Uint32 blockHeight;
	Uint32 itemsPerScreen;
	bool scrollBars;
	int scrollStart;
	int scrollMoveAmount;
	SDL_Rect scrollBarRect;
	
	Uint32 highLightColour;
	FontRes font;
	Uint32 clickTime;	// Use for double click. If within a certain time.
	
	void calcScrollBarPos();
	void setScrollStart(int start);
	void moveScrollBar(int amount);

public:

	ListBox(Rect rect);
	virtual ~ListBox();
	
	// Item handing methods
	void addItem(const char* item, const char* value);
	void clearList();
	bool itemSelected();
	const char* getSelectedItem();
	const char* getSelectedValue();
	void sort();
	
	// Display accessor methods
	int getWidth();
	void setWidth(int width);	
	int getHeight();
	void setHeight(int height);
	void setHighLightColour(Uint32 col);
	void setFont(FontRes font);
		
	// IWidget methods
	virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character );
};

#endif // LISTBOX_H
