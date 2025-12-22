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
  * A window is a container for widgets / controls, which are grouped
  * together. Also provides a consistant approach with backgrounds, colours
  * borders etc.
  */
 
#ifndef WINDOW_H
#define WINDOW_H

// Game includes
#include "General.h"
#include "List.h"
#include "IWidget.h"
#include "Theme.h"
#include "TextBox.h"
#include "Button.h"
#include "CheckBox.h"
#include "Label.h"
#include "Listbox.h"
#include "Slider.h"
#include "CallBack.h"

class Window: public IWidget
{

protected:

	SDL_Surface* rootScreen;
	SDL_Surface* windowScreen;
	Rect size;
	
private:

	// Draw / visual parameters
	Uint32 colourBackground;
	bool displayBackground;
	Uint32 borderColTopLeft;
	Uint32 borderColBottomRight;
	bool displayBorder;
	Uint8 borderThickness;
	bool innerBevel;
	SDL_Surface* imageBackground;
    Uint8 alpha;
	bool modal;	// Means that nothing else below it should be processed
		
	// Controls displayed on the window
	List<IWidget*> controls;
	
    // Use this to fire an action if there is no click or keyPress for a certain time
    Callback0Base* timeEvent;
    Uint32 startTime;
    Uint32 delayTime;
    bool inputReset;	// Defines if the timer for the background action is reset when an input is received

	void initialise();
	void createWindowScreen(SDL_Surface* screen);
	
public:
	Window(SDL_Surface* screen);
	Window(SDL_Surface* screen, Rect size);
	virtual ~Window();
	
	// Accessor methods
	void addControl(IWidget* control);
    void loadBackgroundImage(const char* image);
    void loadTransparentBackgroundImage(const char* image);
    void setBackgroundColour(Uint32 background);
    Uint32 getBackgroundColour();
	void setEnabledBackground(bool background);
    bool getEnabledBackground();
   	void setBorderColour(Uint32 borderColour);
   	void setBorder(bool border);
   	bool getBorder();
   	void setBorderThickness(Uint8 thickness);
   	Uint8 getBorderThickness();
   	void setInnerBevel(bool bevel);
    void setTimedAction(Callback0Base& timeE, Uint32 delayTime, bool inputReset);
	void setModal(bool modal);
	bool getModal();
	void setSize(Rect size);
	void setAlpha(Uint8 al);
	Uint8 getAlpha();

	// IWigdet
	virtual void animate();
    virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character );
};

#endif // WINDOW_H
