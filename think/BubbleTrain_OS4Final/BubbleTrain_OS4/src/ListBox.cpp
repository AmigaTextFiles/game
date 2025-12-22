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
 
#include "ListBox.h"

ListBox::ListBox(Rect rect) : Control(rect.topLeft)
{
	ListBox::clearList();
	this->currentItem 		= listItems.GetIterator();
	this->currentItem.Start();
	this->width 			= (int)rect.width();
	this->height 			= (int)rect.height();
	this->highLightColour 	= 0x0;
	this->scrollBars 		= false;
	this->scrollStart 		= 0;
	this->scrollMoveAmount	= 5;
	ListBox::setFont(FONT_BUTTON);
}

ListBox::~ListBox()
{

}

void ListBox::addItem(const char* item, const char* value)
{
	listItem* newItem = new listItem();
	newItem->item = strdup(item);
	newItem->value = strdup(value);
	this->listItems.Append(newItem);
	
	if (listItems.Size() == 1)
		this->currentItem.Start();
		
	if (listItems.Size() * this->blockHeight > (Uint32)this->height)
	{
		this->scrollBars	= true;
		this->scrollStart	= 0;
		ListBox::calcScrollBarPos();
	}
}

void ListBox::clearList()
{
	this->listItems.DeleteAndRemove();
	this->scrollBars	= false;
	this->scrollStart	= 0;
}

bool ListBox::itemSelected()
{
	return this->currentItem.Valid();
}

const char* ListBox::getSelectedItem()
{
	if (ListBox::itemSelected())
		return this->currentItem.Item()->item;
	
	return NULL;
}

const char* ListBox::getSelectedValue()
{
	if (ListBox::itemSelected())
		return this->currentItem.Item()->value;
	
	return NULL;
}


int ListBox::getWidth()
{
	return this->width;	
}

void ListBox::setWidth(int width)
{
	this->width = width;
}

int ListBox::getHeight()
{
	return this->height;
}

void ListBox::setHeight(int height)
{
	this->height = height;
	this->itemsPerScreen = this->height / this->blockHeight;
	ListBox::calcScrollBarPos();
}

void ListBox::setHighLightColour(Uint32 col)
{
	this->highLightColour = col;
}

void ListBox::setFont(FontRes font)
{
	this->font = font;
	
	// Update the block height
	Theme::Instance()->textSize(this->font, NULL , &this->blockHeight, "1");
	this->itemsPerScreen = this->height / this->blockHeight;
	ListBox::calcScrollBarPos();
}

void ListBox::sort()
{
//for(int i=right; i>left; --i)
//		for(int j=left; j<i; ++j)
//		  if(Direction == Asc && hand[j].Card->GetCardSuit() > hand[j+1].Card->GetCardSuit())
//		  {
//				HandCard tempr = hand[j];
//				hand[j] = hand[j+1];
//				hand[j+1] = tempr;
//		  } 
//		  else if(Direction == Desc && hand[j].Card->GetCardSuit() < hand[j+1].Card->GetCardSuit())
//		  {
//				HandCard tempr = hand[j];
//				hand[j] = hand[j+1];
//				hand[j+1] = tempr;
//		  } 	
}

void ListBox::draw(SDL_Surface* screenDest)
{
	SDL_Rect screenRect;
	screenRect.x = (short int)this->point.x;
	screenRect.y = (short int)this->point.y;
	screenRect.w = this->width;
	screenRect.h = this->height;
	
	// Fill the background and add the beveled border
	SDL_FillRect (screenDest, &screenRect, this->activeColour);
	for (int i = 0; i < 1; i++)
	{
		// Draw the top & left
		Theme::Instance()->drawLine(screenDest, this->borderColTopLeft, (int)this->point.x + i, (int)this->point.y + i, (int)this->point.x + i , (int)this->point.y + this->height - 1 - i);
		Theme::Instance()->drawLine(screenDest, this->borderColTopLeft, (int)this->point.x + 1 + i, (int)this->point.y + i, (int)this->point.x + this->width- 1 - 2 * i, (int)this->point.y + i);
		// Draw the bottom & right
		Theme::Instance()->drawLine(screenDest, this->borderColBottomRight, (int)this->point.x + i, (int)this->point.y + this->height - 1 - i, (int)this->point.x + this->width - 1 - 2 * i, (int)this->point.y + this->height - 1 - i);
		Theme::Instance()->drawLine(screenDest, this->borderColBottomRight, (int)this->point.x + this->width - 1 - i, (int)this->point.y + 1 + i, (int)this->point.x + this->width - 1 - i, (int)this->point.y + this->height - 1 - 2 * i);
	}	

	Uint32 border = 2;
	
	DListIterator<listItem*> listIter = listItems.GetIterator();
	Rect size(screenRect.x + border, screenRect.y + border, screenRect.x + screenRect.w, screenRect.y + this->blockHeight + border);
	int count = 0;
	while (listIter.Valid())
	{
		// Keep looping through the items until we get to the start of the items
		// to draw for the start of the scroll window
		if (this->scrollBars && count++ < this->scrollStart)
		{
			listIter.Forth();
			continue;
		}
		
		if (this->currentItem.Valid() && this->currentItem.Item() == listIter.Item())
		{
			SDL_Rect highLightRect;
			highLightRect.x = (short int)size.topLeft.x;
			highLightRect.y = (short int)size.topLeft.y;
			highLightRect.w = (short int)size.width() - border;
			if (this->scrollBars)
				highLightRect.w -= SCROLLBAR_WIDTH +  border;
			highLightRect.h = (short int)size.height();

			SDL_FillRect(screenDest, &highLightRect	, this->highLightColour);
		}
		Theme::Instance()->drawText(screenDest, this->font, size, Middle, Left, listIter.Item()->item);
		
		size.topLeft.y += this->blockHeight + border;
		size.bottomRight.y += this->blockHeight + border;
		
		// stop displaying items then the start of the next item is drawn off screen
		if (size.bottomRight.y > screenRect.y + screenRect.h)
			break;	
		
		listIter.Forth();	
	}
	
	if (this->scrollBars)
	{
		// Draw the scroll bar now
		SDL_Rect scrollBarBaseRect;
		scrollBarBaseRect.x = (short int)(this->point.x + this->width - SCROLLBAR_WIDTH - border);
		scrollBarBaseRect.y = (short int)this->point.y + border;
		scrollBarBaseRect.w = SCROLLBAR_WIDTH;
		scrollBarBaseRect.h = this->height - 2 * border;
	
		SDL_FillRect(screenDest, &scrollBarBaseRect	, this->highLightColour);
		/*
		// draw the chunk part of the scroll bar
		// The height of the scroll bar is the ratio of shown items to size of complete list
		scrollBarRect.h = ((this->height * this->itemsPerScreen) / this->listItems.Size());
		
		// Calculate the y pos of the scroll bar.
		// Work out the ratio of the amount to move for each item by height to move / num of items not shown
		scrollBarRect.y = (short int)this->point.y + 2 * border + 
			(this->scrollStart * (this->height - scrollBarRect.h) / 
			(this->listItems.Size() - this->itemsPerScreen));
			
		if ((Uint32)scrollBarRect.y < this->point.y + 2 * border)
			scrollBarRect.y = (short int)(this->point.y + 2 * border);
		scrollBarRect.x += border;
		scrollBarRect.w -= 2 * border;
		scrollBarRect.h -= 6 * border;
		*/
		SDL_FillRect(screenDest, &this->scrollBarRect, this->activeColour);
	}
		
}

bool ListBox::mouseDown(int x, int y)
{
	// Check if in my area
	if (x < this->point.x || this->point.x + this->width < x
	|| y < this->point.y || this->point.y + this->height < y)
	{
		active = false;
		return false;
	}
	
	// Check if clicked the scroll bar first
	// i.e. in the right section of the scroll bar
	if (this->scrollBars && x > (this->point.x + this->width - SCROLLBAR_WIDTH))
	{
		// Compare the y component against the rect used to draw the scroll bar for the movement
		if (this->scrollBarRect.y > y)
			ListBox::moveScrollBar(-this->scrollMoveAmount);
		
		if (this->scrollBarRect.y + this->scrollBarRect.h < y)
			ListBox::moveScrollBar(this->scrollMoveAmount);
			
		this->active = true;
		return true;	
	}
	
	Uint32 border = 2;
	
	DListIterator<listItem*> listIter = listItems.GetIterator();
	Rect size(this->point.x + border, this->point.y + border, this->point.x + this->width, this->point.y + this->blockHeight + border);
	int itemCount = 0;
	while (listIter.Valid())
	{
		// If we have scroll bars then the list doesn't start at the beginning
		// of the screen so move to the first item visible.
		if (itemCount++ < this->scrollStart)
		{
			listIter.Forth();
			continue;	
		}
		if (size.topLeft.x < x && x < size.bottomRight.x &&
			size.topLeft.y < y && y < size.bottomRight.y)
		{
			if (this->currentItem.Item() == listIter.Item() && abs(SDL_GetTicks() - this->clickTime) < 250)
				this->fireDoubleClickEvent();
			this->currentItem = listIter;
			break;	
		}
		
		size.topLeft.y += this->blockHeight + border;
		size.bottomRight.y += this->blockHeight + border;
		listIter.Forth();	
	}
	
	this->clickTime = SDL_GetTicks();
	this->active = true;
	this->fireClickEvent();
	return true;
}

bool ListBox::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	// Only move the current selection is active
	if (!active)
		return false;
		
	switch (key)
	{
		case SDLK_UP:
			this->currentItem.Back();
			ListBox::moveScrollBar(-1);
			if (!this->currentItem.Valid())
				this->currentItem.Start();
			return true;
		case SDLK_DOWN:
			this->currentItem.Forth();
			ListBox::moveScrollBar(1);
			if (!this->currentItem.Valid())
				this->currentItem.End();
			return true;
		case SDLK_HOME:
			this->currentItem.Start();
			ListBox::setScrollStart(0);
			return true;
		case SDLK_END:
			ListBox::setScrollStart(this->listItems.Size());
			this->currentItem.End();
			return true;
		default:
			break;
	}
	return false;
}


void ListBox::calcScrollBarPos()
{
	if (!this->scrollBars || this->listItems.Size() == 0)
		return;
		
	int border = 2;

	// draw the chunk part of the scroll bar
	// The height of the scroll bar is the ratio of shown items to size of complete list
	scrollBarRect.h = ((this->height * this->itemsPerScreen) / this->listItems.Size());

	// Calculate the y pos of the scroll bar.
	// Work out the ratio of the amount to move for each item by height to move / num of items not shown
	scrollBarRect.y = (short int)this->point.y + 2 * border + 
		(this->scrollStart * (this->height - scrollBarRect.h) / 
		(this->listItems.Size() - this->itemsPerScreen));
	
	//if ((Uint32)scrollBarRect.y < this->point.y + 2 * border)
	//	scrollBarRect.y = (short int)(this->point.y + 2 * border);
		
	scrollBarRect.x = (short int)(this->point.x + this->width - SCROLLBAR_WIDTH);
	scrollBarRect.w = SCROLLBAR_WIDTH - 2 * border;
	scrollBarRect.h -= 6 * border;

}

void ListBox::setScrollStart(int start)
{
	if (!this->scrollBars)
		return;
		
	this->scrollStart = start;
	
	//lower bounds
	if (this->scrollStart < 0)
		this->scrollStart = 0;
		
	// Upper bounds - make sure there is at least one screen worth of data
	if (this->scrollStart > this->listItems.Size() - (int)this->itemsPerScreen + 1)
		this->scrollStart = this->listItems.Size() - (int)this->itemsPerScreen + 1;
	
	ListBox::calcScrollBarPos();	
}

void ListBox::moveScrollBar(int amount)
{
	ListBox::setScrollStart(this->scrollStart + amount);
}

