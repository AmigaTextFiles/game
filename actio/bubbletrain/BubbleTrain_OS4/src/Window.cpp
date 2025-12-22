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
 
#include "Window.h"

Window::Window(SDL_Surface* screen) : IWidget(Point(0,0))
{
	this->rootScreen	= screen;
	this->size.topLeft.set(0,0);
	this->size.bottomRight.set(0,0);
	Window::initialise();
}

Window::Window(SDL_Surface* screen, Rect size) : IWidget(size.topLeft)
{
	this->rootScreen	= screen;
	this->size 			= size;
	Window::initialise();
}

Window::~Window()
{
	if (this->windowScreen != NULL)
		SDL_FreeSurface(this->windowScreen);

	if (this->imageBackground != NULL)
		SDL_FreeSurface(this->imageBackground);

	// Clean up the child controls		
	this->controls.DeleteAndRemove();
}

void Window::addControl(IWidget* control)
{
	if (control == NULL)
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Control added to Window is null");
		
	this->controls.Append(control);
}

void Window::loadBackgroundImage(const char* image)
{
	// Clean up the image if already loaded
	if (this->imageBackground != NULL)
		SDL_FreeSurface(this->imageBackground);

	// Load the onto the button.
    this->imageBackground = IMG_Load(image);
    
    if (!this->imageBackground)
        Log::Instance()->die(1, SV_ERROR, "Trouble loading image %s", image);
		
}

void Window::loadTransparentBackgroundImage(const char* image)
{
	// Clean up the image if already loaded
	if (this->imageBackground != NULL)
		SDL_FreeSurface(this->imageBackground);

	// Load the onto the button.
    this->imageBackground = Theme::Instance()->loadTransparentBitmap(image);
    
    if (!this->imageBackground)
        Log::Instance()->die(1, SV_ERROR, "Trouble loading image %s", image);
		
}

void Window::setBackgroundColour(Uint32 background)
{
	this->colourBackground = background;
}

Uint32 Window::getBackgroundColour()
{
	return this->colourBackground;	
}

void Window::setEnabledBackground(bool background)
{
	this->displayBackground = background;
}

bool Window::getEnabledBackground()
{
	return this->displayBackground;
}

void Window::setBorderColour(Uint32 borderColour)
{
	this->borderColTopLeft = borderColour;
	this->borderColBottomRight = borderColour;
}

void Window::setBorder(bool border)
{
	this->displayBorder = border;
}

bool Window::getBorder()
{
	return this->displayBorder;
}

void Window::setBorderThickness(Uint8 thickness)
{
	this->borderThickness = thickness;
}

Uint8 Window::getBorderThickness()
{
	return this->borderThickness;
}

void Window::setInnerBevel(bool bevel)
{
	this->innerBevel = bevel;
	if (bevel)
	{
		this->displayBorder = true;
		// Calculate the border colours based on the back ground colour if not set
		// then use the border colour
		// Set the top and left border to a lighter shade and the bottom & right to a darker shade
		Uint8 r = 0, g = 0, b = 0;
		Uint8 adjustFactor = 0x30;
		SDL_GetRGB(this->colourBackground, this->windowScreen->format, &r, &g, &b);
		Uint8 rl = (r + adjustFactor > 255) ? 255 : r + adjustFactor;
		Uint8 gl = (g + adjustFactor > 255) ? 255 : g + adjustFactor;
		Uint8 bl = (b + adjustFactor > 255) ? 255 : b + adjustFactor;
		
		Uint8 rd = (r - adjustFactor < 0) ? 0 : r - adjustFactor;
		Uint8 gd = (g - adjustFactor < 0) ? 0 : g - adjustFactor;
		Uint8 bd = (b - adjustFactor < 0) ? 0 : b - adjustFactor;
		
		this->borderColTopLeft = SDL_MapRGB(SDL_GetVideoSurface()->format, rl, gl, bl);
		this->borderColBottomRight = SDL_MapRGB(SDL_GetVideoSurface()->format, rd, gd, bd);
	}
}

void Window::setTimedAction(Callback0Base& timeE, Uint32 delayTime, bool inputReset)
{
	this->timeEvent = timeE.clone();
	this->startTime = SDL_GetTicks();
	this->delayTime = delayTime;
	this->inputReset = inputReset;
}

void Window::setModal(bool modal)
{
	this->modal = modal;
}

bool Window::getModal()
{
	return this->modal;
}

void Window::setSize(Rect size)
{
	this->size = size;
	IWidget::point = size.topLeft;
	Window::createWindowScreen(this->rootScreen);
}

void Window::setAlpha(Uint8 al)
{
	this->alpha = al;
	SDL_SetAlpha(this->windowScreen,SDL_SRCALPHA,al);
}
	
Uint8 Window::getAlpha()
{
	return this->alpha;
}

void Window::animate()
{
      // Fire the action time if there is no response
      if (this->timeEvent != NULL && startTime != 0 && SDL_GetTicks() - startTime > delayTime)
        (*this->timeEvent)();
}

void Window::draw(SDL_Surface* screenDest)
{
	// Only draw current window and controls is visible
	if (!this->visible)
		return;
	
	if (this->displayBackground)
	{
		// Draw the background of the Window then draw each of the controls above it.
		if (this->imageBackground != NULL)
			SDL_BlitSurface(this->imageBackground, NULL, this->windowScreen, NULL);
		else
			SDL_FillRect(this->windowScreen, NULL, this->colourBackground);
	}
	
	// Draw out the border with the bevelled edges if the colours are different
	if (this->displayBorder)
	{
		for (int i = 0; i < this->borderThickness; i++)
		{
			// Draw the top & left
			Theme::Instance()->drawLine(this->windowScreen, this->borderColTopLeft, i, i, i , (int)this->size.height() - 1 - i);
			Theme::Instance()->drawLine(this->windowScreen, this->borderColTopLeft, 1 + i, i, (int)this->size.width()- 1 - 2 * i, i);
			// Draw the bottom & right
			Theme::Instance()->drawLine(this->windowScreen, this->borderColBottomRight, i, (int)this->size.height() - 1 - i, (int)this->size.width() - 1 - 2 * i, (int)this->size.height() - 1 - i);
			Theme::Instance()->drawLine(this->windowScreen, this->borderColBottomRight, (int)this->size.width() - 1 - i, 1 + i, (int)this->size.width() - 1 - i, (int)this->size.height() - 1 - 2 * i);
		}	
	}
	
	// Draw the contents of each control onto the Window
	DListIterator<IWidget*> ctrlIter = this->controls.GetIterator();
	ctrlIter.Start();
	while (ctrlIter.Valid())
	{
		if (ctrlIter.Item()->getVisible())
			ctrlIter.Item()->draw(this->windowScreen);
		ctrlIter.Forth();	
	}
	
	// Blit the Window onto the main screen
	SDL_Rect dst = {(short int)this->point.x, (short int)this->point.y, this->windowScreen->w, this->windowScreen->h};
	SDL_BlitSurface(this->windowScreen, NULL, screenDest, &dst);	
}

bool Window::mouseDown(int x, int y)
{	
	// Do a primary check that the mouse was clicked on the Window first before going 
	// through all of the controls
	if 	((x < this->point.x || this->point.x + this->size.width() < x) ||
	 	(y < this->point.y || this->point.y + this->size.height() < y))
	{
		// The click was out of bounds for this window
		// so if this window is the currently active one then 
		// make sure none of my controls are active.
		if (this->active)
		{
			// De activate each control
			DListIterator<IWidget*> ctrlIterActive = this->controls.GetIterator();
			ctrlIterActive.Start();
			while (ctrlIterActive.Valid())
			{
				ctrlIterActive.Item()->setActive(false);
				ctrlIterActive.Forth();
			}
			this->active = false;
		}	

		return this->modal;
	}
	
	// If the window is hiden then don't bother to process the click event
	if (!this->visible)
		return false;

	// The control x,y are relative to the Window so the mouse click x,y should 
	// be re-aligned to match the Window.
	x -= (int)this->point.x;
	y -= (int)this->point.y; 

	// Draw the contents of each control onto the Window
	DListIterator<IWidget*> ctrlIter = this->controls.GetIterator();
	ctrlIter.Start();
	bool handled=false;
	while (ctrlIter.Valid())
	{
		handled |= ctrlIter.Item()->mouseDown(x, y);
		ctrlIter.Forth();
	}
	
	// Set the window as the current active one
	this->active = true;

	return (handled | this->modal);
}

bool Window::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	// Reset the timer for the timed event.
	if (this->timeEvent != NULL && this->inputReset)
    	this->startTime = SDL_GetTicks();
	
	// Check keypress for each child control
    DListIterator<IWidget*> ctrlIter = this->controls.GetIterator();
	ctrlIter.Start();
	bool handled=false;
	while (ctrlIter.Valid())
	{
		handled |= ctrlIter.Item()->keyPress(key, mod, character);
		ctrlIter.Forth();	
	}
	
	return (handled | this->modal);
}

void Window::initialise()
{
	this->imageBackground 	= NULL;
    this->colourBackground 	= 0;
    this->displayBackground = true;
	this->borderColTopLeft 	= 0;
	this->borderColBottomRight = 0;
	this->displayBorder 	= false;
	this->borderThickness 	= 1;
	this->innerBevel 		= false;
    this->timeEvent 		= NULL;
    this->startTime 		= 0;
    this->delayTime 		= 0;
    this->alpha 			= 255;
    this->inputReset 		= false;
    this->active 			= true;
	this->modal				= true;  
	this->windowScreen		= NULL; 

	Window::createWindowScreen(this->rootScreen);
}

void Window::createWindowScreen(SDL_Surface* screen)
{
	if (this->windowScreen)
		SDL_FreeSurface(this->windowScreen);

    this->windowScreen = SDL_CreateRGBSurface(SDL_SWSURFACE, (int)size.width(), (int)size.height(), 32,
                                   screen->format->Rmask, screen->format->Gmask, screen->format->Bmask, screen->format->Amask);

    if(this->windowScreen == NULL)
		Log::Instance()->die(3, SV_FATALERROR, "Create Window; CreateRGBSurface failed %s\n", SDL_GetError());

   // Get the colour at (0,0) and use this as the blank colour.
    Uint32 blankColour = 0; //getPixel(this->windowScreen, 0, 0);

    // Set the transparency colour to the blank colour above.
    if (SDL_SetColorKey (this->windowScreen, SDL_SRCCOLORKEY, blankColour))
    	Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Window::createWindowScreen - Unable to set transparency on file");

}
