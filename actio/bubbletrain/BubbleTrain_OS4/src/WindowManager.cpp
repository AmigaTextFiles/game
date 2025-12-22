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
 
#include "WindowManager.h"

WindowManager* WindowManager::_instance = (WindowManager*)NULL; /// initialize static instance pointer

WindowManager* WindowManager::Instance()
{
	if (_instance == NULL)
	{
		_instance = new WindowManager();	
	}
	return _instance;	
}

WindowManager::WindowManager()
{
	this->widIter = this->widgets.GetIterator();
	
	// Clear the list
	this->listToBeCleared = false;

	// Delete a single item from the list
	this->itemsToBeDeleted = false;

}

WindowManager::~WindowManager()
{
	this->widgets.DeleteAndRemove();
}

void WindowManager::push(IWidget* wid)
{
	// If the list has been marked to be cleared then add them onto the waiting list
	if (this->listToBeCleared)
		this->widgetsAfterClear.Append(wid);
	else
		this->widgets.Append(wid);

	// Reset the iterator - but only if we are not clearing the window
//	this->widIter.Start();
}

void WindowManager::remove(IWidget* wid)
{
	this->itemsToBeDeleted = true;
	this->widgetDelete.Append(wid);
}

void WindowManager::clear()
{
	// Flag that the list has to be cleared
	this->listToBeCleared = true;
}

void WindowManager::processFrame(SDL_Surface* screen)
{
	// Do any neccessary clean up before we process the list
	if (this->listToBeCleared)
		WindowManager::clearList();
	else if (this->itemsToBeDeleted)
		WindowManager::deleteItems();
	
	// Move through each widget and process
	this->widIter.Start();
	while (this->widIter.Valid())
	{
		this->widIter.Item()->pollKeyStates();
		this->widIter.Item()->animate();
		this->widIter.Item()->draw(screen);
		this->widIter.Forth();	
	}
}

void WindowManager::setActive(bool active)
{
	this->widIter.Start();
	while (this->widIter.Valid())
	{
		this->widIter.Item()->setActive(active);
		this->widIter.Forth();	
	}
}

void WindowManager::animate()
{
	this->widIter.Start();
	while (this->widIter.Valid())
	{
		this->widIter.Item()->animate();
		this->widIter.Forth();	
	}
}

bool WindowManager::pollKeyStates()
{
	this->widIter.Start();
	while (this->widIter.Valid())
	{
		this->widIter.Item()->pollKeyStates();
		this->widIter.Forth();	
	}
	return false;
}

void WindowManager::draw(SDL_Surface* screenDest)
{
	this->widIter.Start();
	while (this->widIter.Valid())
	{
		if (widIter.Item()->getVisible())
			this->widIter.Item()->draw(screenDest);
		this->widIter.Forth();	
	}
}

bool WindowManager::mouseDown(int x, int y)
{
	// run in reverse order because the top most window is at the rear
	// and we want to process the widget with the hightest z-order
	this->widIter.End();
	while (this->widIter.Valid())
	{
		// If an event if handled then don't pass it down the windows only 
		// allow the top most to process it
		if (this->widIter.Item()->mouseDown(x, y))
			return true;
		this->widIter.Back();	
	}
	return false;
}

bool WindowManager::keyPress(SDLKey key, SDLMod mod, Uint16 character)
{
	// run in reverse order because the top most window is at the rear
	// and we want to process the widget with the hightest z-order
	this->widIter.End();
	while (this->widIter.Valid())
	{
			// If an event if handled then don't pass it down the windows only 
		// allow the top most to process it
		if (this->widIter.Item()->keyPress(key, mod, character))
			return true;
	
		this->widIter.Back();
	}

	return false;
}


void WindowManager::clearList()
{
	// Remove all items from the current list
	this->widgets.DeleteAndRemove();
	
	// Now add all of the items which were added after the list was flagged to be 
	// cleared.
	
	DListIterator<IWidget*> clearItemIter = this->widgetsAfterClear.GetIterator();
	clearItemIter.Start();
	while (clearItemIter.Valid())
	{
		this->widgets.Append(clearItemIter.Item());
		clearItemIter.Forth();
	}
	// Remove all items from the clear list but don't delete
	this->widgetsAfterClear.RemoveAll();
	
	// Reset the clear flag
	this->listToBeCleared = false;
}

void WindowManager::deleteItems()
{
	// Delete all items from the widgets list which appear in the widgetdelete list
	DListIterator<IWidget*> deleteItemIter = this->widgetDelete.GetIterator();
	deleteItemIter.Start();
	while (deleteItemIter.Valid())
	{
		this->widIter.End();
		while (this->widIter.Valid())
		{
			// Loop through each widget until we find the one we want and 
			// remove it from the list
			if (this->widIter.Item() == deleteItemIter.Item())
			{
				delete this->widIter.Item();
				this->widgets.Remove(this->widIter);
				break;
			}
			this->widIter.Back();	
		}
		deleteItemIter.Forth();
	}
	
	// Remove all items from the delete list because none of them exist any more
	this->widgetDelete.RemoveAll();
	
	// Reset the delete flag
	this->itemsToBeDeleted = false;
}
