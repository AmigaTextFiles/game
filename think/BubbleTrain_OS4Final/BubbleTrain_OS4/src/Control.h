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
  * The basics for a control. This class doesn't do anything itself but provides
  * common functionality for the control which inherit this class
  */
 
#ifndef CONTROL_H
#define CONTROL_H

#include "IWidget.h"
#include "Theme.h"
#include "CallBack.h"

// Defines the type of bevel the outer edge of the control can have
enum BevelType 
{
	BEV_NONE,
	BEV_NORMAL,
	BEV_INNER,
	BEV_OUTER
};

class Control : public IWidget
{
	
protected:

	// Background colours
	Uint32 activeColour;
	Uint32 inActiveColour;
	
	// Border colours
	Uint32 borderColTopLeft;
	Uint32 borderColBottomRight;
	
	// Border type
	BevelType borderType;
	
	// Events
	Callback0Base* changeEvent;
	Callback0Base* clickEvent;
	Callback0Base* doubleClickEvent;
	
	void initialise();
	void updateBorderType();
	
public:
	
	Control();
	Control(Point pos);
	Control(int x, int y);
	virtual ~Control();
	
	// Properties for the active / inactive colours
	void setActiveColour(Uint32 colour);
	Uint32 getActiveColour();
	void setInActiveColour(Uint32 colour);
	Uint32 getInActiveColour();
	
	// Set the border types
	void setBorderColour(Uint32 col);
	void setBevelType(BevelType bevType);
	
	// Add / fire events for a control
	virtual void addChangeEvent(Callback0Base& changeEvent);
	virtual void addClickEvent(Callback0Base& clickEvent);
	virtual void addDoubleClickEvent(Callback0Base& doubleClickEvent);
	void fireChangeEvent();
	void fireClickEvent();
	void fireDoubleClickEvent();
	
	// IWidget methods
	virtual void draw(SDL_Surface* screenDest){};
	virtual bool mouseDown(int x, int y){return false;};
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character){return false;};
};

#endif // CONTROL_H
