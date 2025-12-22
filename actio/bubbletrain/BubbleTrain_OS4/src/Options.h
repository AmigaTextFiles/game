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
  * Maintain general options for the game, like sound, credit type options.
  * Implemented as a singleton class so only have to load once for general use
  */
  
#ifndef OPTIONS_H
#define OPTIONS_H

// System Includes
#include <SDL/SDL_mixer.h>

// Game Includes
#include "General.h"

// Constants
#define OPTIONS_FILENAME "configuration.xml" // Define the name of the options file.

class Options
{
private:

	const char* optionsFilename;

	static Options* _instance;
	
	// Sound
	bool soundEnabled;
	Uint8 musicVolume;
	Uint8 effectVolume;
	
	// Credits
	int credits;
	
	// Controls
	bool mouseEnabled;
	int mouseSensitivity;
	int fireKey;
	int cannonLeftKey;
	int cannonRightKey;

	void loadOptions();
	void saveOptions();
	
public:

	static Options* Instance();

	Options();
	virtual ~Options();
	
	// Sound
	void setSoundEnabled(bool enabled);
	bool getSoundEnabled();
	void setMusicVolume(Uint8 vol);
	Uint8 getMusicVolume();
	void setEffectVolume(Uint8 vol);
	Uint8 getEffectVolume();
	
	// credits
	void setCredits(int credits);
	int getCredits();
	
	// Controls
	// Mouse
	void setMouseEnabled(bool enabled);
	bool getMouseEnabled();
	void setMouseSensitivity(int sensitivity);
	int getMouseSensitivity();
	// Keys
	void setFireKey(int fire);
	int getFireKey();
	void setCannonLeftKey(int left);
	int getCannonLeftKey();
	void setCannonRightKey(int right);
	int getCannonRightKey();
	
};

#endif // OPTIONS_H
