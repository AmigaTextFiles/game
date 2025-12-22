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
 * Screen for displaying the options - updates the options class
 */

#ifndef OPTIONSSCREEN_H
#define OPTIONSSCREEN_H

// System Includes
#include <SDL/SDL_mixer.h>

// Game Includes
#include "Options.h"
#include "Window.h"
#include "WindowManager.h"
#include "CallBack.h"
#include "MessageBox.h"

class OptionsScreen : public Window
{

private:

	// use a state for defining which key we are defining
	enum keystates
	{
		KS_None,
		KS_Fire,
		KS_Left,
		KS_Right
	};
	
	keystates state;

	// Sound options
	CheckBox* chkSoundEnabled;
	Slider* sldMusicVolume;
	Slider* sldEffectsVolume;
	
	// Game options
	TextBox* txtCredits;
	
	// Control options
	// Mouse
	CheckBox* chkMouseEnabled;
	Slider* sldMouseSensitivity;
	// Key
	Label* lblFireKey;
	Label* lblLeftKey;
	Label* lblRightKey;
	MessageBox* keyMsgBox;
	
	// Sound events
	void soundChanged();
	void musicVolumeChanged();
	void effectVolumeChagned();
	
	// Game events
	void creditsChanged();
	
	// Control events
	void mouseChanged();
	void mouseSensitivityChanged();
	void assignKeys();
	
	void ok();
	
public:

	OptionsScreen(SDL_Surface* screen);
	virtual ~OptionsScreen();
	
	virtual void draw(SDL_Surface* screenDest);
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character);
};

#endif // OPTIONSSCREEN_H
