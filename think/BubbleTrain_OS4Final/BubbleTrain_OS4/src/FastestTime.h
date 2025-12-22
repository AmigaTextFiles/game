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
 * Defines the fastest times acheived in bubble train.
 * The scores are stored in an xml file. Details include Name, game, level, time
 * 
 * The times board is calculated by the one with the highest level followed by the
 * lowest time. This doesn't separate out for the different types of games played
 * 
 * This class uses the singleton pattern so it can be called from anywhere and only
 * has to load the fastest times once
 * 
 * This also inherits from IWidget so that it can draw the list to screen for the 
 * fastest times list. This way nothing else needs to know how they are stored.
 */
 
#ifndef FastestTime_H
#define FastestTime_H

#include "General.h"
#include "ILoadSave.h"
#include "IWidget.h"
#include "List.h"
#include "Theme.h"

#define HS_FILENAME "bubbletrain.hsc"		// Filename used to store the details in
#define HS_MAX_NUM 10						// Maximum number of items in the list

// Simple structure to hold the required information about a fastest time entry
struct FastestTimeST
{
	char* name;
	char* game;
	int level;
	int score;	
	~FastestTimeST()
	{
		delete this->name;
		delete this->game;
	}
};

class FastestTime : public IWidget
{
private:
	static FastestTime* _instance;			// Singleton static variable		
	
	FastestTimeST* hScores[HS_MAX_NUM];		// The array containing the fastest times
	int count;								// Count for the number of items in the list
	
	int compare(int a, int b);				// Compare fastest times objects at the given index in the list
	int compareValues(int index, int level, int score);	// Compare the given values with the item at index in the list
	void sort();							// Sort the list so that things are always in the correct order
	
	void load();							// Load / save the list to the xml file
	void save();
		
public:
	static FastestTime* Instance();

	FastestTime();
	virtual ~FastestTime();
	
	// Check and add items to the fastest times list
	bool checkAddHS(const char* game, int level, int score);
	void addHS(const char* name, const char* game, const int level, int score);
	
	// IWidget methods
	virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress(SDLKey key, SDLMod mod, Uint16 character);
};

#endif // FastestTime_H
