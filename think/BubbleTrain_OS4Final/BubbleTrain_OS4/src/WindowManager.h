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
  * Window manager groups together widgets / windows together and allows
  * each item to be processed, or skipped depending on the result of the previous
  * item.
  * 
  * Implemented as a singleton class so everything can get access to it.
  */
 
#ifndef WINDOWMANAGER_H
#define WINDOWMANAGER_H

// Game includes
#include "IWidget.h"
#include "List.h"

class WindowManager
{
	
private:
	// Singleton
	static WindowManager* _instance;

	// List of widgets
	List<IWidget*> widgets;
	DListIterator<IWidget*> widIter;

	// To delete items mark them for delete and then the next process frame
	// go through and delete the neccessary items
	// This means that items can't delete themselves before they have finished processing

	// Clear a list
	// Include a new list of widgets to load after we have cleared the list
	bool listToBeCleared;
	List<IWidget*> widgetsAfterClear;

	// Delete a single item from the list
	bool itemsToBeDeleted;
	List<IWidget*> widgetDelete;
	
	void clearList();
	void deleteItems();
	
public:
	static WindowManager* Instance();

	WindowManager();
	virtual ~WindowManager();
	
	// Control the widgets
	void push(IWidget* wid);
	void remove(IWidget* wid);
	void clear();
	
	// This bulks some of the frame animation / key events etc together
	void processFrame(SDL_Surface* screen);
	
	// IWigdet - use this to pass through to each widget
	virtual void setActive(bool active);
	virtual void animate();
	virtual bool pollKeyStates();
	virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress(SDLKey key, SDLMod mod, Uint16 character);
	
};

#endif // WINDOWMANAGER_H
